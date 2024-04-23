extends Control

signal opened
signal closed
var isOpen: bool = false

@onready var inventory: Inventory = preload("res://UI/PlayerInventory.tres")
@onready var slots: Array=$NinePatchRect/Inventory/VBoxContainer/GridContainer.get_children()

func _ready():
	update()
	
func update():
	for i in range(min(inventory.items.size(),slots.size())):
		slots[i].update(inventory.items[i])

func open():
	visible=true
	isOpen=true
	opened.emit()

func close():
	visible=false
	isOpen=false
	closed.emit()
