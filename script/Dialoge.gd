extends Control

signal dialogue_finish

@export_file("*.json") var d_file

@onready var npcMumble1 = $npcMumble1
@onready var npcMumble2 = $npcMumble2
@onready var npcMumble3 = $npcMumble3
@onready var npcMumble4 = $npcMumble4
@onready var npcMumble5 = $npcMumble5
var npcMumble

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false

func choose(array):
	array.shuffle()
	return array.front()

func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	npcMumble = choose([npcMumble1,npcMumble2,npcMumble3,npcMumble4,npcMumble5])
	npcMumble.play()
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var file = FileAccess.open("res://dialoge/gorgod_dialogue1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("ui_accept"):
		npcMumble.stop()
		npcMumble = choose([npcMumble1,npcMumble2,npcMumble3,npcMumble4,npcMumble5])
		npcMumble.play()
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		emit_signal("dialogue_finish")
		npcMumble.stop()
		return
		
	$NinePatchRect/name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/text.text = dialogue[current_dialogue_id]["text"]
