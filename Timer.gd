extends Timer

var slime1= preload("res://scenes/green_slime.tscn")


func _on_timeout():
	randomize()
	var mobs = [slime1]
	var kinds = mobs[randi()%mobs.size()]
	var mob = kinds.instance()
	mob.position = Vector2(randf_range(10,990), randf_range(10,990))
	add_child(mob)
	
