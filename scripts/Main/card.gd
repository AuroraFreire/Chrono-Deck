extends Node2D

@export var item: Item = null:
	set(value):
		item = value
		if value != null:
			$cardImg.texture = get_node("cardImg").texture
var card_slot_reference
var starting_position

func _ready() -> void:
	Popups.visible = false

func _process(_delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	if item != null:
		Popups.set_value(item)
	Popups.visible = true

func _on_mouse_exited() -> void:
	Popups.visible = false
