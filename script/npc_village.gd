extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_beach_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_state = true
		Global.scene_destination = 'beach'
		change_scene()

func _on_north_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_state = true
		Global.scene_destination = 'bossMap1'
		change_scene()

func change_scene():
	if Global.transition_state == true:
		if Global.scene_destination == 'beach':
			get_tree().change_scene_to_file("res://scenes/beach.tscn")
			Global.finish_transition()
		if Global.scene_destination == 'bossMap1':
			get_tree().change_scene_to_file("res://scenes/bossMap1.tscn")
			Global.finish_transition()
