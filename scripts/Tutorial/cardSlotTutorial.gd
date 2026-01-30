extends Node2D

var card_in_slot = false
var current_card = null
var current_card_image_path = ""
var deck_reference
var rng = RandomNumberGenerator.new()
var chronarc_attack

@onready var healthbar = $Healthbar
@onready var texture_progress_bar = $"../CanvasLayer/TextureProgressBar"
@onready var deck = $"../DeckTutorial"

func _ready() -> void:
	healthbar.init_health(75)
	deck_reference = $"../DeckTutorial"

func place_card(cardTutorial):
	current_card = cardTutorial
	card_in_slot = true
	var card_texture = cardTutorial.get_node("cardImgTutorial").texture
	if card_texture:
		current_card_image_path = card_texture.resource_path

func take_damage():
	if card_in_slot:
		deck.process_mode = Node.PROCESS_MODE_DISABLED
		healthbar.health -= 15
		texture_progress_bar.reduce_time(6)
		delete_card()

func delete_card():
	if current_card:
		current_card.queue_free()
		current_card = null
	card_in_slot = false


func _on_end_turn_pressed() -> void:
	deck.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(0.67, false).timeout
	chronarc_attack = rng.randf_range(4, 13)
	texture_progress_bar.reduce_time(chronarc_attack)
	await get_tree().create_timer(0.67, false).timeout
	get_tree().paused = false

func _process(delta: float) -> void:
	if healthbar.health <= 0:
		pass
