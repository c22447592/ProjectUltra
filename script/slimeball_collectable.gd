extends Area2D

@export var item: InventoryItem
var player=null

func _ready():
	pass
	#onDeath()		
#func onDeath():
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		print("test")
		player = body
	randomize()
	var randomSelect = randi_range(1,2)
	if randomSelect == 1:
		$AnimationPlayer.play("lootDropped-right")
		$Area2D/CollisionPolygon2D/pickUpBox.play("lootDropped-right")
		if player:
			player.collect(item)
			queue_free()
		else:
			await get_tree().create_timer(5).timeout
			$AnimationPlayer.play("fade-right")
			$Area2D/CollisionPolygon2D/pickUpBox.play("fade-right")
			print("+1 slimeball")
			queue_free()
	else:
		$AnimationPlayer.play("lootDropped-left")
		$Area2D/CollisionPolygon2D/pickUpBox.play("lootDropped-left")
		if player:
			player.collect(item)
			queue_free()
		else:
			await get_tree().create_timer(5).timeout
			$AnimationPlayer.play("fade-left")
			$Area2D/CollisionPolygon2D/pickUpBox.play("fade-left")
			print("+1 slimeball")
		queue_free()
