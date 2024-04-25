extends Area2D

@export var itemRes: InventoryItem

func _ready():
	onDeath()

func onDeath():
	randomize()
	var randomSelect = randi_range(1,2)
	if randomSelect == 1:
		$AnimationPlayer.play("lootDropped-right")
		$Area2D/CollisionPolygon2D/pickUpBox.play("lootDropped-right")
		await get_tree().create_timer(10).timeout
		$AnimationPlayer.play("fade-right")
		$Area2D/CollisionPolygon2D/pickUpBox.play("fade-right")
		print("+1 slimeball")
		queue_free()
	else:
		$AnimationPlayer.play("lootDropped-left")
		$Area2D/CollisionPolygon2D/pickUpBox.play("lootDropped-left")
		await get_tree().create_timer(10).timeout
		$AnimationPlayer.play("fade-left")
		$Area2D/CollisionPolygon2D/pickUpBox.play("fade-left")
		print("+1 slimeball")
		queue_free()
