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

func _ready() -> void:
	Popups.visible = false

func _process(_delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	if item != null:
		Popups.set_value(item)
	Popups.visible = true
	var texture = $cardImg.texture.resource_path
	items_path = ITEMS_PATH + $".".name + ".tres" 
	var item_data = load(items_path)
	await get_tree().create_timer(0.05).timeout
	if texture == "res://assets/card_images1/PharaoStrike.png":
		Popups.get_node("Panel/Information").text = item_data.info
	elif texture == "res://assets/card_images1/PraySun.png":
		Popups.get_node("Panel/Information").text = item_data.info
	elif texture == "res://assets/card_images1/SandShield.png":
		Popups.get_node("Panel/Information").text = item_data.info
	elif texture == "res://assets/card_images1/SolarBlade.png":
		Popups.get_node("Panel/Information").text = item_data.info
	elif texture == "res://assets/card_images1/SolarStasis.png":
		Popups.get_node("Panel/Information").text = item_data.info

func _on_mouse_exited() -> void:
	Popups.visible = false
