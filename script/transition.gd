extends Area2D

@export var next_scene_path = "res://scenes/beach.tscn"
@export var x = 0
@export var y = 0


func _on_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file(next_scene_path)
		Global.playerx = x
		Global.playery = y
