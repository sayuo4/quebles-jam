class_name PauseMenu
extends Control

var paused: bool: set = set_paused
var enabled: bool = false

@onready var continue_button: Button = %ContinueButton as Button
@onready var restart_button: Button = %RestartButton as Button
@onready var quit_buttion: Button = %QuitButton as Button
@onready var fullscreen_label: RichTextLabel = %FullScreenText as RichTextLabel

func _ready() -> void:
	paused = false
	
	if OS.get_name() == "Web":
		quit_buttion.hide()
		fullscreen_label.hide()
		
		continue_button.focus_neighbor_top = restart_button.get_path()
		restart_button.focus_neighbor_bottom = continue_button.get_path()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and can_pause():
		paused = not paused
		get_viewport().set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	visible = value
	get_tree().paused = value
	
	if value:
		continue_button.grab_focus()

func can_pause() -> bool:
	var start_menu: StartMenu = Global.get_start_menu()
	
	var started: bool = start_menu.started if start_menu else true
	
	return enabled and started

func _on_continue_button_pressed() -> void:
	paused = false

func _on_restart_button_pressed() -> void:
	var player: Player = Global.get_player()
	
	if player:
		player.kill()
		paused = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
