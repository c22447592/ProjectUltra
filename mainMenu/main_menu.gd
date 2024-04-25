class_name MainMenu
extends Control


@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/start_button
@onready var load_button = $MarginContainer/HBoxContainer/VBoxContainer/load_button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/options_button
@onready var start_game = preload("res://scenes/beach.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_button.button_down.connect(on_option_pressed)
	
func on_start_pressed() -> void: #start button
	get_tree().change_scene_to_packed(start_game)

func on_exit_pressed() -> void: #exit button pressed
	get_tree().quit()
	
func on_option_pressed() -> void:
	pass
