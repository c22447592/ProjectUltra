extends Node

@onready var heartContainer=$CanvasLayer/HBoxContainer
@onready var player=$testPlayer
@onready var game_menu = $CanvasLayer/game_menu as gameMenu

func _ready():
	heartContainer.setMaxHearts(10)
	heartContainer.updateHearts(GameData.player_health)
	player.healthChanged.connect(heartContainer.updateHearts)

func _process(delta):
	pass

func _on_inventory_closed():
	get_tree().paused=false


func _on_inventory_opened():
	get_tree().paused=true

func _input(event):
	if event.is_action_pressed("esc"):
		if game_menu.visible == true: #open
			game_menu.visible = false
			
		elif game_menu.visible == false: ##closed
			game_menu.visible = true
			
