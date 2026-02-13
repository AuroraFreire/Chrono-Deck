extends Node2D

var card_in_slot = false
var current_card = null
var current_card_image_path = ""
var deck_reference
var rng = RandomNumberGenerator.new()
var chronarc_attack
var card_effect = ""
var card_count = 0
var current_effect = ""

@onready var healthbar = $Healthbar
@onready var texture_progress_bar = $"../CanvasLayer/TextureProgressBar2"
@onready var card_slot = $"."
@onready var input_manager = $"../inputManager2"

func _ready() -> void:
	texture_progress_bar.process_mode = Node.PROCESS_MODE_DISABLED
	healthbar.init_health(80)
	deck_reference = $"../Deck2"

func place_card(card):
	texture_progress_bar.process_mode = Node.PROCESS_MODE_INHERIT
	current_card = card
	card_in_slot = true
	card_count += 1
	if card_count >= 2:
		input_manager.process_mode = Node.PROCESS_MODE_DISABLED
	var card_texture = card.get_node("cardImg").texture
	if card_texture:
		current_card_image_path = card_texture.resource_path

func take_damage():
	if card_in_slot:
		deck_reference.process_mode = Node.PROCESS_MODE_DISABLED
		if current_card_image_path == "res://assets/card_images2/DigitalEcho.png":
			healthbar.health -= 15
			texture_progress_bar.reduce_time(0)
			current_effect = ""
			delete_card()
		elif current_card_image_path == "res://assets/card_images2/HackClock.png":
			texture_progress_bar.add_time(3)
			current_effect = "HackClock"
			delete_card()
		elif current_card_image_path == "res://assets/card_images2/PlasmPulse.png":
			healthbar.health -= 9
			texture_progress_bar.reduce_time(5)
			card_effect = "PlasmaPulse"
			current_effect = "PlasmaPulse"
			delete_card()
		elif current_card_image_path == "res://assets/card_images2/StasisField.png":
			texture_progress_bar.reduce_time(1)
			card_effect = "StasisField"
			current_effect = "StasisField"
			delete_card()
		elif current_card_image_path == "res://assets/card_images2/TemporalRift.png":
			healthbar.health -= 15
			texture_progress_bar.reduce_time(7)
			current_effect = "TemporalRift"
			delete_card()

func delete_card():
	if current_card:
		current_card.queue_free()
		current_card = null
	card_in_slot = false

func _on_end_turn_pressed() -> void:
	deck_reference.process_mode = Node.PROCESS_MODE_INHERIT
	card_slot.process_mode = Node.PROCESS_MODE_DISABLED
	input_manager.process_mode = Node.PROCESS_MODE_INHERIT
	card_count = 0
	await get_tree().create_timer(0.67, false).timeout
	chronarc_attack = rng.randf_range(4, 13)
	if card_effect == "PlasmaPulse":
		chronarc_attack *= 0.25
		card_effect = ""
	if card_effect == "StasisField":
		chronarc_attack *= 0.5
		card_effect = ""
	texture_progress_bar.reduce_time(chronarc_attack)
	await get_tree().create_timer(0.67, false).timeout
	card_slot.process_mode = Node.PROCESS_MODE_INHERIT
