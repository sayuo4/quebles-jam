class_name Main
extends Node2D

@export var default_scene: PackedScene
var current_scene: Node

@onready var sub_viewport: SubViewport = %SubViewport

func _ready() -> void:
	switch_scene(default_scene)

func switch_scene(scene: PackedScene) -> void:
	if not scene:
		return
	
	for child: Node in sub_viewport.get_children():
		child.queue_free()
	
	var scene_inst: Node = scene.instantiate()
	
	sub_viewport.add_child.call_deferred(scene_inst)
	scene_inst.set_deferred("owner", self)
	set_deferred("current_scene", scene_inst)
