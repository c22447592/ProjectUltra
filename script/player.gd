extends CharacterBody2D
var current_health = GameData.player_health
var speed = 100
var player_state
var current_dir = "none"
var player_alive = true
var enemy_attack_cooldown = true
var enemy_inattack_range = false
var attack_in_progress = false
var sprint_state = false #while holding left shoft player gets speed turned to 150 
var input_disabled = false #stops the player from attacking or moving after death
signal healthChanged


@export var inventory:Inventory
@onready var footsteps = $footstep
@onready var swing1 = $swing1
@onready var swing2 = $swing2
@onready var swing3 = $swing3
@onready var gameOver = $gameOver
@onready var death1 = $death1
@onready var death2 = $death2
@onready var death3 = $death3
@onready var death4 = $death4
@onready var death5 = $death5
@onready var death6 = $death6
@onready var death7 = $death7

var swing
var death

func _ready():
	$AnimatedSprite2D.play("idle-front")
	self.global_position = Vector2(Global.playerx, Global.playery)

func _physics_process(delta):
	if !input_disabled:
		player_movement(delta)
		attack()
		enemy_attack()
		die()

func choose(array):
	array.shuffle()
	return array.front()

func play_steps():
	$footstep/Timer.wait_time = 5
	footsteps.play()
#Movement type 1 (Uses different idle animations, is geared for 4-directional approach)
func player_movement(delta):
	#function for player movement
	if Input.is_action_pressed("l-shift"): #sprint on
		speed = 150
	if Input.is_action_just_released("l-shift"): #sprint off
		speed = 100
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
		footsteps.play()
		play_steps()
		
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
		GameData.damage()
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("Player health is ", GameData.player_health)
		healthChanged.emit(GameData.player_health)
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_in_progress = true
		swing = choose([swing1,swing2,swing3])
		swing.play()
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
	

func die():
	if current_health <= 0:
		player_alive = false
		death = choose([death1,death2,death3,death4,death5,death6,death7,])
		gameOver.play()
		death.play()
		$AnimatedSprite2D.play("death")
		$CollisionShape2D.disabled = true
		print("You have been vanquished.")
		input_disabled = true
		
func collect(item):
	inventory.insert(item)
	print("collected")

func update_health():
	pass
	
func _on_regen_timer_timeout():
	if current_health < 10:
		current_health = current_health + 1
		print("Regen health = ", current_health)
		if current_health > 10:
			current_health = 10
	elif current_health <= 0:
		current_health = 0

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
