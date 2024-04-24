extends CharacterBody2D

const  speed = 20
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var left_limit = -200
var right_limit = -100

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	LEFT,
	RIGHT
}

func _ready():
	randomize()
	start_pos = position

func _process(delta):
	if current_state == 0:
		$AnimatedSprite2D.play("idle")
	elif current_state == 1 or current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("west_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("east_walk")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			LEFT:
				dir.x = -1
				if position.x < left_limit:
					dir.x = 1
					move(delta)
				else:
					move(delta)
			RIGHT:
				dir.x = 1
				if position.x > right_limit:
					dir.x = -1
					move(delta)
				else:
					move(delta)
	
	if Input.is_action_just_pressed("chat"):
		print("chatting with npc")
		$Dialoge.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")

func move(delta):
	if !is_chatting:
		position += dir * speed * delta
	

func choose(array):
	array.shuffle()
	return array.front()


func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false


func _on_timer_timeout():
	$Timer.wait_time = choose([1,1.1,1.2])
	current_state = choose([IDLE,IDLE,IDLE,IDLE,IDLE,LEFT,RIGHT])


func _on_dialoge_dialogue_finish():
	is_chatting = false
	is_roaming = true
