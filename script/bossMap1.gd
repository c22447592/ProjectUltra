extends Node2D

@onready var audio_file1 = $AudioStreamPlayer2D
@onready var audio_file2 = $AudioStreamPlayer2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
