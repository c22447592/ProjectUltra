extends CharacterBody2D

var health = 100
const speed = 100
var current_dir = "none"
#var player_alive = true
#var attack_in_progress = false
#var enemy_inattack_range = false
#var enemy_attack_cooldown = true

func _ready():
	$AnimatedSprite2D.play("idle-front")

#movement function
func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	#function for player movement
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement):
	#function for player animation
	var dir = current_dir
	var anim = $AnimatedSprite2D
	#left and right directional movement
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-sideways")
		elif movement == 0:
			anim.play("idle-sideways")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk-sideways")
		elif movement == 0:
			anim.play("idle-sideways")
	#up and down directional movement
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-up")
		elif movement == 0:
			anim.play("idle-back")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-down")
		elif movement == 0:
			anim.play("idle-front")

#func player():
	#pass
#
#func _on_player_hitbox_body_entered(body):
	#if body.has_method("enemy"):
		#enemy_inattack_range = true
	#
#func _on_player_hitbox_body_exited(body):
	#if body.has_method("enemy"):
		#enemy_inattack_range = false
#
#func enemy_attack():
	#if enemy_inattack_range and enemy_attack_cooldown == true:
		#health = health - 10
		#enemy_attack_cooldown = false
		#$attackCooldown.start()
		#print("You have been hit, health is at ", health)
		#
#func _on_attack_cooldown_timeout():
	#enemy_attack_cooldown = true
