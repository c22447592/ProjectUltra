extends CharacterBody2D

var slimeKing_health = 400
var speed = 100

var player_inattack_zone = false
var player_detected = false
var player = null
var can_take_damage = true

func _physics_process(delta):
	deal_with_sword_damage()
	
	#chases the player and flips animation dependent on player position
	if player_detected:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("move")
	else:
		$AnimatedSprite2D.play("static")

func _on_detection_area_body_entered(body):
	player = body
	player_detected = true


func _on_detection_area_body_exited(body):
	player = null
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
			slimeKing_health = slimeKing_health - Global.sword_damage
			$damage_cooldown.start()
			can_take_damage = false
			print("Slime King health = ", slimeKing_health)
			if slimeKing_health <= 0:
				$AnimatedSprite2D.play("static")
				print("Boss defeated. Regicide...")
				self.queue_free()
			elif slimeKing_health <= 200:
				halfHealthAbilitiy()
				
func halfHealthAbilitiy():
	var slime_scene = preload("res://scenes/green_slime.tscn")
	var slime_instance = slime_scene.instantiate()
	get_parent().add_child(slime_instance)
	slime_instance.position = position
			
#func deal_with_spear_damage():
	#if player_inattack_zone and GlobalPlayer.player_current_attack == true:
		#slime_health = slime_health - GlobalPlayer.spear_damage
		#print("slime health = ", slime_health)
		#if slime_health <= 0:
			#$AnimatedSprite2D.play("static")
			#self.queue_free()
		
func _on_damage_cooldown_timeout():
	can_take_damage = true
