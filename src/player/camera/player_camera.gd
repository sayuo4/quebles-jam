class_name PlayerCamera
extends Camera2D

@export_group("Shake")
@export var shake_strength_multiplier: float = 1.0
@export var shake_fade_multiplier: float = 1.0
@export_range(0.0, 1.0) var jitter_amount: float

@export_group("Zoom")
@export var zoom_fade_multiplier: float = 1.0

var _shake_fade: float = 0.0
var _shake_strength: float = 0.0

var _zoom_fade: float = 0.0

var _default_zoom: Vector2

func _ready() -> void:
	_default_zoom = zoom

func _process(delta: float) -> void:
	var multiplied_shake_fade: float = _shake_fade * shake_fade_multiplier
	_shake_strength = lerpf(_shake_strength, 0.0, multiplied_shake_fade * delta)
	
	var multiplied_shake_strength: float = _shake_strength * shake_strength_multiplier
	offset = Vector2(
			multiplied_shake_strength * _get_random_jitter(jitter_amount),
			multiplied_shake_strength * _get_random_jitter(jitter_amount)
	)
	
	var multiplied_zoom_fade: float = _zoom_fade * zoom_fade_multiplier
	zoom = zoom.lerp(_default_zoom, multiplied_zoom_fade * delta)

func apply_shake(strength: float, fade: float) -> void:
	_shake_strength = strength
	_shake_fade = fade

func apply_zoom(value: Vector2, fade: float) -> void:
	zoom = value
	_zoom_fade = fade

func _get_random_jitter(amount: float) -> float:
	var dir: float = 1.0 if randi() % 2 == 0 else -1.0
	var jitter: float = 1.0 + randf_range(-amount, amount)
	
	return dir * jitter
