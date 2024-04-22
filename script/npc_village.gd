extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_beach_entrance_body_entered(body):
	var global = load("res://script/global.gd").new()
	if body.has_method("player"):
		global.transition_state = true
		global.scene_destination = 'beach'


func _on_west_entrance_body_entered(body):
	var global = load("res://script/global.gd").new()
	if body.has_method("player"):
		global.transition_state = true
		global.scene_destination = ''


func _on_east_entrance_body_entered(body):
	var global = load("res://script/global.gd").new()
	if body.has_method("player"):
		global.transition_state = true
		global.scene_destination = ''


func _on_north_entrance_body_entered(body):
	var global = load("res://script/global.gd").new()
	if body.has_method("player"):
		global.transition_state = true
		global.scene_destination = ''

func change_scene():
	var global = load("res://script/global.gd").new()
	if global.transition_state == true:
		if global.scene_destination == 'beach':
			get_tree().change_scene_to_file("res://scenes/beach.tscn")
			global.finish_transition()
