extends CharacterBody2D


var speed = 150
const JUMP_VELOCITY = -400.0
@onready var enemy: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Area2D = $"../Player/playerarea"
@onready var collision_shape: CollisionShape2D = $"../Player/CollisionShape2D"





func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	var distance_x := player.global_position.x - global_position.x
	velocity.x = clampf(distance_x / delta, -speed, speed)
	enemy.play("run")
	
	if distance_x > 0:
		enemy.flip_h = true
	elif distance_x < 0: 
		enemy.flip_h = false

	
		
		
	move_and_slide()
