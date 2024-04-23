extends Node

func _ready():
	pass
	
func _process(delta):
	pass

func _on_inventory_closed():
	get_tree().paused=false


func _on_inventory_opened():
	get_tree().paused=true
