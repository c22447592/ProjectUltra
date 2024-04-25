extends Area2D

@export var itemRes: InventoryItem

func _ready():
	pass
	#onDeath()		
	
func collect():
	$Area2D/CollisionPolygon2D/pickUpBox.play("fade-left")
	print("collected slimeball")
	queue_free()
	
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




func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		collect()
		

	
