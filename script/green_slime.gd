extends CharacterBody2D

var slime_health = 80
var speed = 75

var player_inattack_zone = false
var player_detected = false
var player = null
var can_take_damage = true
var vel = Vector2()

@onready var hit1 = $hit1
@onready var hit2 = $hit2
@onready var hit3 = $hit3
@onready var hit4 = $hit4
@onready var hit5 = $hit5
@onready var hit6 = $hit5
@onready var hit7 = $hit7
@onready var hit8 = $hit8
@onready var hit9 = $hit9
@onready var hit10 = $hit10
@onready var hit11 = $hit11
@onready var hit12 = $hit12
@onready var hit13 = $hit13
@onready var hit14 = $hit14
@onready var hit15 = $hit15
@onready var hit16 = $hit16
@onready var hit17 = $hit17
@onready var hit18 = $hit18
var hit

@onready var slimeNoise1 = $slimeNoise1
@onready var slimeNoise2 = $slimeNoise2

func _physics_process(delta):
	deal_with_sword_damage()
	#update_health()
	
	#chases the player and flips animation dependent on player position
	if player_detected == true:
		#increasing speed variable slows down the enemy
		var direction = (player.position - position).normalized()
		vel = vel.lerp(direction * speed, 10 * delta)
		position += vel * delta
		$AnimatedSprite2D.play("move")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		vel = Vector2.ZERO  # Reset velocity when player not detected
		$AnimatedSprite2D.play("static")

func choose(array):
	array.shuffle()
	return array.front()

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		slimeNoise1.play()
		slimeNoise2.play()
		player_detected = true
		player = body
	

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		slimeNoise1.stop()
		slimeNoise2.stop()
		player_detected = false


func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
		
func deal_with_sword_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			hit = choose([hit1,hit2,hit3,hit4,hit5,hit6,hit7,hit8,hit9,hit10,hit11,hit12,hit13,hit14,hit15,hit16,hit17,hit18])
			hit.play()
			slime_health = slime_health - Global.sword_damage
			$damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", slime_health)
			if slime_health <= 0:
				print("Enemy defeated.")
				$AnimatedSprite2D.play("static")
				drop_loot()
				self.queue_free()
			
#func deal_with_spear_damage():
	#if player_inattack_zone and Global.player_current_attack == true:
		#slime_health = slime_health - Global.spear_damage
		#print("slime health = ", slime_health)
		#if slime_health <= 0:
			#$AnimatedSprite2D.play("static")
			#self.queue_free()
		
		
func _on_damage_cooldown_timeout():
	can_take_damage = true
	
func drop_loot():
	#slime ball drop
	var slimeball = preload("res://scenes/slimeball_collectable.tscn")
	var slimeball_instance = slimeball.instantiate()
	slimeball_instance.global_position = $lootDrop.global_position
	get_parent().add_child(slimeball_instance)
	
	#gold coin drop
	randomize()
	var decideCoin = randi_range(1,2)
	if decideCoin == 2:
		var coin = preload("res://scenes/gold_coin_collectable.tscn")
		var coin_instance = coin.instantiate()
		coin_instance.global_position = $lootDrop.global_position
		get_parent().add_child(coin_instance)

	
	
#func update_health():
	#var healthbar = $healthbar
	#
	#if slime_health >= 60:
		#healthbar.visible = false
	#else:
		#healthbar.visible = true
