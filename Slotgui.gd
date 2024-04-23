extends Panel
@onready var backgroundSprite: Sprite2D=$Background

@onready var ItemSprite: Sprite2D=$CenterContainer/Panel/Item

func update(item: InventoryItem):
	if !item:
		backgroundSprite.frame=0
		ItemSprite.visible=false
	else:
		backgroundSprite.frame=1
		ItemSprite.visible=true
		ItemSprite.texture=item.texture
		





