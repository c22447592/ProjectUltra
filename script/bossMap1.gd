extends Node2D

@onready var heartContainer=$CanvasLayer/HBoxContainer
@onready var player=$thePlayer
@onready var audio_file1 = $bossMusic
@onready var audio_file2 = $ambientForest

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var spawn_area = Rect2(Vector2(-267,89), Vector2(647,375))
	spawn_slimes(10, spawn_area)
	heartContainer.setMaxHearts(10 )
	heartContainer.updateHearts(GameData.player_health)
	player.healthChanged.connect(heartContainer.updateHearts)
	audio_file2.play()
	audio_file1.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		audio_file1.play()
		audio_file2.stop()

func spawn_slimes(number_of_slimes, area_rect):
	var slime_scene = preload("res://scenes/green_slime.tscn")
	for i in range(number_of_slimes):
		var slime_instance = slime_scene.instantiate()
		var random_position = Vector2(
			randf_range(area_rect.position.x, area_rect.position.x + area_rect.size.x),
			randf_range(area_rect.position.y, area_rect.position.y + area_rect.size.y)
		)
		slime_instance.position = random_position
		self.add_child(slime_instance)
		
func _on_inventory_closed():
	get_tree().paused=false

func _on_inventory_opened():
	get_tree().paused=true
