extends Panel
@onready var backgroundSprite: Sprite2D=$Background

@onready var ItemSprite: Sprite2D=$CenterContainer/Panel/Item
@onready var amount_text: Label=$CenterContainer/Panel/Label

func update(slot: InventorySlot):
	if !slot.item:
		backgroundSprite.frame=0
		ItemSprite.visible=false
		amount_text.visible=false
	else:
		backgroundSprite.frame=1
		ItemSprite.visible=true
		ItemSprite.texture=slot.item.texture
		amount_text.visible=true
		amount_text.text= str(slot.amount)
		





