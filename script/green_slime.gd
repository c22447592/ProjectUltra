extends CharacterBody2D

var slime_health = 50
var speed = 75

var player_inattack_zone = false
var player_chase = false
var player = null
var can_take_damage = true

func _physics_process(delta):
	deal_with_sword_damage()
	
	#chases the player and flips animation dependent on player position
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("move")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false	
	else:
		$AnimatedSprite2D.play("static")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
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
			slime_health = slime_health - Global.sword_damage
			$damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", slime_health)
			if slime_health <= 0:
				$AnimatedSprite2D.play("static")
				self.queue_free()
			
#func deal_with_spear_damage():
	#if player_inattack_zone and GlobalPlayer.player_current_attack == true:
		#slime_health = slime_health - GlobalPlayer.spear_damage
		#print("slime health = ", slime_health)
		#if slime_health <= 0:
			#$AnimatedSprite2D.play("static")
			#self.queue_free()
		
func _on_damage_cooldown_timeout():
	can_take_damage = true
