extends Node2D

@onready var game_menu = $CanvasLayer/game_menu as gameMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("esc"):
		if game_menu.visible == true: #open
			game_menu.visible = false
			
		elif game_menu.visible == false: ##closed
			game_menu.visible = true

