extends StaticBody2D

@export var itemRes: InventoryItem

func _ready():
	onDeath()

func onDeath():
	randomize()
	var randomSelect = randi_range(1,2)
	if randomSelect == 1:
		$AnimationPlayer.play("lootDropped-right")
		await get_tree().create_timer(10).timeout
		$AnimationPlayer.play("fade-right")
		print("+1 slimeball")
		queue_free()
	else:
		$AnimationPlayer.play("lootDropped-left")
		await get_tree().create_timer(10).timeout
		$AnimationPlayer.play("fade-left")
		print("+1 slimeball")
		queue_free()
