extends Control

func ItemPopup(card: Rect2, item: Item):
	if item != null:
		set_value(item)
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 4
	if mouse_pos.x <= get_viewport_rect().size.x / 2:
		correction = Vector2(card.size.x + padding, 0)
	else:
		correction = -Vector2(%ItemPopup.size.x + padding, 0)
	%ItemPopup.popup(Rect2(card.position + correction, %ItemPopup.size))

func HideItemPopup():
	%ItemPopup.hide()

func set_value(item: Item):
	%Information.text = item.info
