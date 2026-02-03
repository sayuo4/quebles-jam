extends State
class_name JellyfishChasingPlayerState


var added_velocity: Vector2 = Vector2.ZERO


func _physics_update(_delta: float) -> void:
	if target_node.arrived_at_point(get_player_position(), target_node.chasing_arriving_distance):
		target_node.decelerate()
		return
	
	target_node.rotation = lerp_angle(target_node.rotation, get_direction_to_player().angle() + deg_to_rad(90.0), 0.1)
	
	
	target_node.accelerate(get_direction_to_player() * get_speed())
	

## returns the player position.
func get_player_position() -> Vector2:
	return get_tree().get_first_node_in_group(&"player").global_position

## returns the player position.
func get_direction_to_player() -> Vector2:
	return target_node.global_position.direction_to(get_player_position())


func get_speed() -> float: return target_node.chase_speed
func get_acc() -> float: return target_node.chase_acc
func get_decel() -> float: return target_node.chase_decel
