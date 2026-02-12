extends Node2D

@export var item: Item = null:
	set(value):
		item = value
		if value != null:
			$cardImg.texture = get_node("cardImg").texture

var starting_position
var card_slot_reference

func _ready() -> void:
	card_slot_reference = $cardSlot

func _process(_delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	print("pila")
	if item == null:
		return
	var size = $Area2D/CollisionShape2D.shape.get_rect().size
	Popups.ItemPopup(Rect2(Vector2(global_position), Vector2(size)), item)

func _on_mouse_exited() -> void:
	print("dentro")
	Popups.HideItemPopup()
