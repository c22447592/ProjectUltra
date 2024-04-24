extends Node2D

@onready var heartContainer=$CanvasLayer/HBoxContainer
@onready var player=$thePlayer
@onready var audio_file1 = $AudioStreamPlayer2D
@onready var audio_file2 = $AudioStreamPlayer2D2
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var spawn_area = Rect2(Vector2(-267,89), Vector2(647,375))
	spawn_slimes(10, spawn_area)
	heartContainer.setMaxHearts(player.player_health)
	heartContainer.updateHearts(player.player_health)
	player.healthChanged.connect(heartContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
