extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var player: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		player.play("jump")
	elif direction: 
		player.play("run")
	else:
		player.play("idle")
	
	if direction > 0:
		player.flip_h = false
	if direction < 0: 
		player.flip_h = true
	


	move_and_slide()
	
	
	
#func _input(event: InputEvent) -> void:
		#if event.is_action_pressed("jump"):
			#player.play("jump")
			#await player.animation_finished
		#if event.is_action_pressed("right"): 
			#player.flip_h = false;
			#player.play("run")
		#if event.is_action_released("right"):
			#player.play("idle")
		#if event.is_action_pressed("left"): 
			#player.flip_h = true;
			#player.play("run")
		#if event.is_action_released("left"):
			#player.play("idle")
		#else:
			 #player.play("idle")
		#
