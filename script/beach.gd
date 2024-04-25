extends Node

@onready var heartContainer=$CanvasLayer/HBoxContainer
@onready var player=$testPlayer

func _ready():
	heartContainer.setMaxHearts(player.player_health)
	heartContainer.updateHearts(player.player_health)
	player.healthChanged.connect(heartContainer.updateHearts)

func _process(delta):
	pass

func _on_inventory_closed():
	get_tree().paused=false


func _on_inventory_opened():
	get_tree().paused=true
