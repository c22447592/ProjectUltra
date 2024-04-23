extends Node

func _ready():
	pass
	
func _process(delta):
	pass
	
func _on_exit_area_body_entered(body):
	if body.has_method("player"):
		Global.transition_state = true
		Global.scene_destination = 'npc_village'
		Global.player_start_position_x = 5
		Global.player_start_position_y = -49
		change_scene()

func change_scene():
	if Global.transition_state == true:
		if Global.scene_destination == 'npc_village':
			get_tree().change_scene_to_file("res://scenes/npc_village.tscn")
			Global.finish_transition()

func _on_inventory_closed():
	get_tree().paused=false


func _on_inventory_opened():
	get_tree().paused=true
