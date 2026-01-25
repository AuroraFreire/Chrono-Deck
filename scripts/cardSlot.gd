extends Node2D

var card_in_slot = false
var current_card = null

@onready var healthbar = $Healthbar
@onready var card_manager = $"../cardManager"
@onready var texture_progress_bar = $"../CanvasLayer/TextureProgressBar"
@onready var countdownLabel = $"../Countdown/countdownLabel"

func _ready() -> void:
	healthbar.init_health(200)

func take_damage():
	if card_in_slot:
		healthbar.health -= 15
		texture_progress_bar.reduce_time(6)
		delete_card()

func delete_card():
	if current_card:
		current_card.queue_free()
		current_card = null
	card_in_slot = false
