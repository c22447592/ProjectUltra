extends CharacterBody2D

var speed = 16

var health = 100
var damage

var dead = false
var player_in_area = false
var player

func _ready():
	dead = false
	
func _physics_process(delta):
	if !dead:
		$detetction_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) / speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("static")
			
	if dead:
		$detectionArea/CollisionShape2D.disabled = true
		

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		
		
#stopped @ 10:30 second of video as arrow not part of my work.
#link to video
#https://youtu.be/pZNg4bpi1u4?si=_VPNMEyOOZw5NFH3&t=628
