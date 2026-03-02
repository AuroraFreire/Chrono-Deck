extends Node2D

const ITEMS_PATH = "res://Resource/"

@export var item: Item = null:
	set(value):
		item = value
		if value != null:
			$cardImg.texture = get_node("cardImg").texture
@onready var deck = $Deck
var card_slot_reference
var starting_position
var items_path = ""
var item_data = {
"PharaoStrike": preload("res://Resource/PharaoStrike.tres"),
"SandShield": preload("res://Resource/SandShield.tres"),
"PraySun": preload("res://Resource/PraySun.tres"),
"SolarBlade": preload("res://Resource/SolarBlade.tres"),
"SolarStasis": preload("res://Resource/SolarStasis.tres")
}

func _ready() -> void:
	Popups.visible = false


func _on_mouse_entered() -> void:
	if item != null:
		Popups.set_value(item)
	Popups.visible = true
	var texture = $cardImg.texture.resource_path
	items_path = ITEMS_PATH + $".".name + ".tres" 
	await get_tree().create_timer(0.1).timeout
	if texture == "res://assets/card_images1/PharaoStrike.png":
		print(item_data[name])
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images1/PraySun.png":
		print(item_data[name])
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images1/SandShield.png":
		print(item_data[name])
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images1/SolarBlade.png":
		print(item_data[name])
		Popups.get_node("Panel/Information").text = item_data[name].info
	elif texture == "res://assets/card_images1/SolarStasis.png":
		print(item_data[name])
		Popups.get_node("Panel/Information").text = item_data[name].info

func _on_mouse_exited() -> void:
	Popups.visible = false
