extends Node

func _ready():
	pass
	
func _process(delta):
	change_scene()
	
func _on_exit_area_body_entered(body):
	var global = load("res://script/global.gd").new()
	if body.has_method("player"):
		global.transition_state = true
		global.scene_destination = 'npc_village'
		print("player in exit box")

func change_scene():
	var global = load("res://script/global.gd").new()
	if global.transition_state == true:
		if global.scene_destination == 'npc_village':
			get_tree().change_scene_to_file("res://scenes/npc_village.tscn")
			global.finish_transition()
