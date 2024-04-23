extends CharacterBody2D
var speed = 100
var player_health = 250
var player_state

var player_alive = true
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var attack_in_progress = false

var current_dir = "none"
func _ready():
	$AnimatedSprite2D.play("idle-front")

func _physics_process(delta):
	player_movement(delta)
	attack()
	enemy_attack()
	
	if player_health <= 0:
		player_alive = false
		player_health = 0
		$AnimatedSprite2D.play("death")
		print("You have been vanquished.")
		self.queue_free()
		
#Movement type 1 (Uses different idle animations, is geared for 4-directional approach)
func player_movement(delta):
	#function for player movement
	if Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	#left and right directional movement
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-right")
		elif movement == 0:
			if attack_in_progress == false:
				anim.play("idle-right")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-left")
		elif movement == 0:
			if attack_in_progress == false:
				anim.play("idle-left")
	#up and down directional movement
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-up")
		elif movement == 0:
			if attack_in_progress == false:
				anim.play("idle-back")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk-down")
		elif movement == 0:
			if attack_in_progress == false:
				anim.play("idle-front")
		
	move_and_slide()
		
	#Movement type 2 (better for 8-directional movement)
	#var direction = Input.get_vector("left", "right", "up", "down")
	#if direction.x == 0 and direction.y == 0:
		#player_state = "idle"
	#elif direction.x != 0 or direction.y != 0:
		#player_state = "walking"
		#
	#velocity = direction * speed
	#move_and_slide()
	#
	#play_anim(direction)
#
#func play_anim(dir):
	#if player_state == "idle":
		#$AnimatedSprite2D.play("idle-front")
	#if player_state == "walking":
		#if dir.y == -1:
			#$AnimatedSprite2D.play("walk-up")
		#if dir.y == 1:
			#$AnimatedSprite2D.play("walk-down")
		#if dir.x == 1:
			#$AnimatedSprite2D.play("walk-right")
		#if dir.x == -1:
			#$AnimatedSprite2D.play("walk-left")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		player_health = player_health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(player_health)
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_in_progress = true
		if dir == "right":
			$AnimatedSprite2D.play("attack-sword-right")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.play("attack-sword-left")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("attack-sword-up")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("attack-sword-down")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false 
	attack_in_progress = false
