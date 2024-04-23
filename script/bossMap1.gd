extends Node2D

@onready var entrance_marker: Node2D = $EmtranceMarkers

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transition_state = true
		Global.scene_destination = 'npc_village'
		change_scene()

func change_scene():
	if Global.transition_state == true:
		if Global.scene_destination == 'npc_village':
			get_tree().change_scene_to_file("res://scenes/npc_village.tscn")
			Global.finish_transition()
