extends Node2D

var starting_position

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	Popups.ItemPopup(null, null)

func _on_mouse_exited() -> void:
	Popups.HideItemPopup()
