extends State
class_name JellyfishWanderingState


## the point the target_node is going to right now.
var target_point: Vector2 = Vector2.ZERO

## the velocity added from the push of the jellyfish to itself.
## the velocity is handeled speratley to get an accurate behaviour.
var added_velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	%WaitingTimer.timeout.connect(
		func() -> void:
			target_point = target_node.choose_target_pos()
	)

func _enter(_previous_state: State) -> void:
	target_point = target_node.choose_target_pos()


func _physics_update(_delta: float) -> void:
	if !%WaitingTimer.is_stopped():
		target_node.decelerate()
		return
	
	if target_node.is_player_in_vision_range() && !target_node.is_in_background():
		switch_to(&"ChasingPlayer")
		return
	
	if target_node.arrived_at_point(target_point):
		%WaitingTimer.start()
	
	
	
	target_node.rotation = lerp_angle(target_node.rotation, get_direction_to_target().angle() + deg_to_rad(90.0), 0.1)
	target_node.accelerate(get_direction_to_target() * get_speed())





## gets the speed of the wandering.
func get_speed() -> float:
	return (target_node as Jellyfish).partrol_speed


func get_direction_to_target() -> Vector2:
	return target_node.global_position.direction_to(target_point)
