extends CharacterBody2D
class_name Jellyfish


## the speed when the jelly is wandering around.
@export var partrol_speed: float = 100.0
## the speed when the jelly is chasing the player.s
@export var chasing_speed: float = 100.0

## the points the jelly fish will move along.
##@deprecated: forget this idea for now.
@export var patrol_positions: Array[Vector2] = []:
	set(value):
		patrol_positions = value
		queue_redraw()

## the acceleration of the jellyfish during patrol state.
@export var patrol_acc: float = 200.0 
## the acceleration of the jellyfish during patrol state.
@export var patrol_decel: float = 200.0 

## the radius the target position will be set to relative the position of the jelly fish.
@export var patrol_radius: float = 120.0
## the distance from the target position where the jelly is considered arrived at the point.
@export var arriving_distance: float = 5.0



## returns the random pos inside the [memebr patrol_radius].
func choose_target_pos() -> Vector2:
	var theta := deg_to_rad(randf_range(0.0, 360.0))
	var pos := Vector2(randf_range(0.0, patrol_radius), 0.0)
	return pos.rotated(theta)
	

## see [member arriving_distance]
## [param point] is a global coordinates.
func arrived_at_point(point: Vector2) -> bool:
	return global_position.distance_to(point) <= arriving_distance
