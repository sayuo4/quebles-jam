extends Node

func get_main() -> Main:
	var main: Main = get_tree().current_scene as Main
	
	return main

func switch_scene(scene: PackedScene) -> void:
	var main: Main = get_main()
	
	if not main:
		return
	
	main.switch_scene(scene)
