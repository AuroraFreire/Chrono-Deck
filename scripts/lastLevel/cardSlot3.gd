extends Node2D
var card_in_slot = false
var current_card = null
var current_card_image_path = ""
var deck_reference
var rng = RandomNumberGenerator.new()
var chronarc_attack
var card_effect = ""
var card_count = 0
var rng2
@onready var healthbar = $Healthbar
@onready var texture_progress_bar = $"../CanvasLayer/TextureProgressBar"
@onready var card_slot = $"."
@onready var input_manager = $"../inputManager"

func _ready() -> void:
	$"../Countdown".process_mode = Node.PROCESS_MODE_DISABLED
	healthbar.init_health(20)
	deck_reference = $"../Deck"
	$"../EnemyAttack/Timer".timeout.connect(_on_timer_timeout)
	$"../endTurn".pressed.connect(_on_end_turn_pressed)

func _on_end_turn_pressed() -> void:
	$"../EnemyAttack/Timer".start()
	card_count = 0
	await get_tree().create_timer(3.0, false).timeout
	$"../EnemyAttack/Timer".stop()
	chronarc_attack = rng.randf_range(4, 13)
	if card_effect == "SandShield":
		chronarc_attack *= 0.5
		card_effect = ""
	if card_effect == "SolarStasis":
		chronarc_attack = 0
		card_effect = ""
	await get_tree().create_timer(0.67, false).timeout
	card_slot.process_mode = Node.PROCESS_MODE_INHERIT

func _on_timer_timeout() -> void:
	$"../EnemyAttack".visible = true
	rng2 = randi_range(0, 9)
	var num_text = str(rng2)
	$"../EnemyAttack".text = num_text
