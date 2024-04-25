class_name  gameMenu
extends Control
@onready var save_button = $MarginContainer/HBoxContainer/VBoxContainer/save_button
@onready var menu_button = $MarginContainer/HBoxContainer/VBoxContainer/menu_button
@onready var settings_button = $MarginContainer/HBoxContainer/VBoxContainer/settings_button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button
@onready var margin_container = $MarginContainer as MarginContainer
@onready var options_menu = $options_menu as OptionsMenu
@onready var main_menu = preload("res://mainMenu/main_menu.tscn") as PackedScene



# Called when the node enters the scene tree for the first time.
func _ready():
	handle_signals()
	
func on_save_pressed() -> void: #save button
	pass
	
func on_menu_pressed() -> void: #menu button
	get_tree().change_scene_to_packed(main_menu)

func on_settings_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	
func on_exit_pressed() -> void: #exit button pressed
	get_tree().quit()
	
func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false

func handle_signals() -> void:
	save_button.button_down.connect(on_save_pressed)
	menu_button.button_down.connect(on_menu_pressed)
	settings_button.button_down.connect(on_settings_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
