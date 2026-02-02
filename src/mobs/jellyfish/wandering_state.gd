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
		decelearte()
		return
	
	if target_node.arrived_at_point(target_point):
		%WaitingTimer.start()
	
	
	target_node.rotation = lerp_angle(target_node.rotation, get_direction_to_target().angle() + deg_to_rad(90.0), 0.1)
	accelerate(get_direction_to_target() * get_speed())


## accelerates towards [param towards]
func accelerate(towards: Vector2) -> void:
	target_node.velocity = target_node.velocity.move_toward(
		towards + added_velocity,
		get_acc()
	)
	added_velocity = added_velocity.lerp(Vector2.ZERO, 0.1)
	target_node.move_and_slide()

## accelerates towards [param towards]
func decelearte() -> void:
	target_node.velocity = target_node.velocity.move_toward(
		Vector2.ZERO,
		get_decel()
	)
	added_velocity = added_velocity.lerp(Vector2.ZERO, 0.1)
	target_node.move_and_slide()


## called by the animaiton player to give the jelly a push in the animation.
func push() -> void:
	added_velocity += target_node.velocity.normalized() * 100.0


## gets the speed of the wandering.
func get_speed() -> float:
	return (target_node as Jellyfish).partrol_speed

## gets the acceleration of the wandering.
func get_acc() -> float:
	return (target_node as Jellyfish).patrol_acc

## gets the deceleration of the wandering.
func get_decel() -> float:
	return (target_node as Jellyfish).patrol_decel

func get_direction_to_target() -> Vector2:
	return target_node.global_position.direction_to(target_point)
