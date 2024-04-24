extends Node

@onready var heartsContainer=$CanvasLayer/HBoxContainer
@onready var player=$testPlayer
func _ready():
	heartsContainer.setMaxHearts(player.player_health/25)

func _process(delta):
	pass

func _on_inventory_closed():
	get_tree().paused=false


func _on_inventory_opened():
	get_tree().paused=true
