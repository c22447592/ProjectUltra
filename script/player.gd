extends CharacterBody2D
var speed = 100
#var player_health = 250
var player_state

@export var maxHealth=250
@onready var player_health: int = maxHealth

var player_alive = true
var enemy_inattack_range = false
var enemy_attack_cooldown = true

func _physics_process(delta):
	enemy_attack()
	
	if player_health <= 0:
		player_alive = false
		player_health = 0
		$AnimatedSprite2D.play("death")
		print("You have been vanquished.")
	
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)

func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle-front")
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("walk-up")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk-down")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk-right")
		if dir.x == -1:
			$AnimatedSprite2D.play("walk-left")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		player_health -=50
		if player_health < 0:
			player_health=maxHealth
		print_debug(player_health)

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

