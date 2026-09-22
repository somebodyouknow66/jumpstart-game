extends CharacterBody2D


const SPEED = 450.0
const JUMP_VELOCITY = -1000.0
@onready var player: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar
var timer := 1.0
var timer_reset := 0.5
var damage := 3
@onready var player_area: Area2D = $playerarea






func _physics_process(delta: float) -> void:
	
	timer -= delta 
	
	if health_bar.value <= 0:
		player.play("dead")
		return
		
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
		
	#attacking animation
	if Input.is_action_just_pressed("attack") and not Attacking.attacking:
		Attacking.attacking = true
		player.play("attack")
		
	if not Attacking.attacking:
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
		

	if player_area.has_overlapping_bodies():
		for body in player_area.get_overlapping_bodies():
			if body.name == "enemy" and timer <= 0:
				health_bar.value -= damage
				timer = timer_reset 
		

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
		


func _on_animated_sprite_2d_animation_finished() -> void:
	if player.animation == "attack": 
		Attacking.attacking = false
	if player.animation == "dead":
		get_tree().change_scene_to_file("res://splash_screen.tscn")
