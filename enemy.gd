extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var player: CharacterBody2D = $"../Player"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var speed: float = 0.01 # put wanted speed here

	look_at(player.global_position)
	self.position = global_position.lerp(player.global_position, speed)

	move_and_slide()
