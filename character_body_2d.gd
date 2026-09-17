extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0


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


	move_and_slide()
	
func _input(event: InputEvent) -> void:
		if event.is_action_pressed("jump"):
			$AnimatedSprite2D.play("jump")
			await $AnimatedSprite2D.animation_finished
			$AnimatedSprite2D.play("idle")
		if event.is_action_pressed("right"): 
			$AnimatedSprite2D.flip_h = false;
			$AnimatedSprite2D.play("run")
		if event.is_action_released("right"):
			$AnimatedSprite2D.play("idle")
		if event.is_action_pressed("left"): 
			$AnimatedSprite2D.flip_h = true;
			$AnimatedSprite2D.play("run")
		if event.is_action_released("left"):
			$AnimatedSprite2D.play("idle")

		
