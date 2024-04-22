extends CharacterBody2D

var slime_health = 50
var speed = 25
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("move")
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

#https://youtu.be/pZNg4bpi1u4?si=_VPNMEyOOZw5NFH3&t=628
