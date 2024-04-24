extends Node2D

@onready var audio_file1 = $AudioStreamPlayer2D
@onready var audio_file2 = $AudioStreamPlayer2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var spawn_area = Rect2(Vector2(-267,89), Vector2(647,375))
	spawn_slimes(10, spawn_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		audio_file1.play()
		audio_file2.stop()
	else:
		audio_file2.play()
		audio_file1.stop()

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