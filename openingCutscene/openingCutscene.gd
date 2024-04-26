extends Control

@onready var nextScene = preload("res://scenes/beach.tscn") as PackedScene



func _on_timer_timeout():
	GameData.player_health = 10
	get_tree().change_scene_to_packed(nextScene)
