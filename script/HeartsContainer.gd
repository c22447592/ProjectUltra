extends HBoxContainer
@onready var heartGuiclass = preload("res://scenes/heartGui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxHearts(max: int):
	for i in range(max):
		var heart= heartGuiclass.instantiate()
		add_child(heart)
		
func updateHearts(player_health: int):
	var hearts= get_children()
	
	for i in range(player_health):
		hearts[i].update(true)
		
	for i in range(player_health, hearts.size()):
		hearts[i].update(false)
	
