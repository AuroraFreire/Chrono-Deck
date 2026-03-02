extends Node2D

const ITEMS_PATH = "res://Resource/"

@export var item: Item = null:
	set(value):
		item = value
		if value != null:
			$CardImg2.texture = get_node("cardImg").texture
@onready var deck = $Deck2
var card_slot_reference
var starting_position
var items_path = ""
var item_data = {
"HackClock": preload("res://Resource/HackClock.tres"),
"DigitalEcho": preload("res://Resource/DigitalEcho.tres"),
"PlasmaPulse": preload("res://Resource/PlasmaPulse.tres"),
"StasisField": preload("res://Resource/StasisField.tres"),
"TemporaRift": preload("res://Resource/TemporalRift.tres")
}

func _ready() -> void:
	Popups.visible = false

func _process(_delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	if item != null:
		Popups.set_value(item)
	Popups.visible = true
	var texture = $CardImg2.texture.resource_path
	await get_tree().create_timer(0.1).timeout
	if texture == "res://assets/card_images_2/DigitalEcho.png":
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images_2/HackClock.png":
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images_2/PlasmaPulse.png":
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images_2/StasisField.png":
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images_2/TemporalRift.png":
		Popups.get_node("Panel/Information").text = item_data[name].info

func _on_mouse_exited() -> void:
	Popups.visible = false
