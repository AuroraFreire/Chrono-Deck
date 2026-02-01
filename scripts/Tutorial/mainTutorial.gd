extends Control
@onready var options: Panel = $Options
@onready var tutorial_1 = $Tutorial1
@onready var tutorial_2 = $Tutorial2
@onready var tutorial_3 = $Tutorial3
@onready var tutorial_4 = $Tutorial4
@onready var speech_box: Panel = $SpeechBox
@onready var deck = $DeckTutorial
@onready var card_slot = $cardSlotTutorial
@onready var texture_progress_bar = $CanvasLayer/TextureProgressBar
@onready var input_manager = $inputManager
@onready var next_button = $SpeechBox/nextButton

var checking_card_count = false
var checking_card_in_slot = false

func _ready() -> void:
	options.visible = false
	$SpeechBox/RichTextLabel2.visible = false
	$SpeechBox/TutorialArrow.visible = false
	$SpeechBox/RichTextLabel3.visible = false
	$SpeechBox/RichTextLabel4.visible = false
	options.process_mode = Node.PROCESS_MODE_ALWAYS
	deck.process_mode = Node.PROCESS_MODE_DISABLED
	card_slot.process_mode = Node.PROCESS_MODE_DISABLED
	texture_progress_bar.process_mode = Node.PROCESS_MODE_DISABLED
	tutorial_1.play("tutorial1")

func _process(_delta: float) -> void:
	if checking_card_count and input_manager.card_count >= 3:
		anim_3()
	if checking_card_in_slot == true:
		if card_slot.healthbar.value <= 74:
			anim_4()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PauseMenu"):
		options.visible = true
		get_tree().paused = true

func _on_back_pressed() -> void:
	get_tree().paused = false
	options.visible = false

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_next_button_pressed() -> void:
	get_tree().paused = false
	$SpeechBox/RichTextLabel.visible = false
	$SpeechBox/RichTextLabel2.visible = true
	$SpeechBox/TutorialArrow.visible = true
	deck.process_mode = Node.PROCESS_MODE_INHERIT
	tutorial_2.play("tutorial2")
	next_button.process_mode = Node.PROCESS_MODE_DISABLED
	checking_card_count = true

func _on_end_turn_pressed() -> void:
	texture_progress_bar.process_mode = Node.PROCESS_MODE_INHERIT
	texture_progress_bar.add_time(card_slot.chronarc_attack)

func anim_3():
	checking_card_count = false
	card_slot.process_mode = Node.PROCESS_MODE_INHERIT
	$SpeechBox/RichTextLabel2.visible = false
	$SpeechBox/RichTextLabel3.visible = true
	tutorial_3.play("tutorial3")
	checking_card_in_slot = true

func anim_4():
	checking_card_in_slot = false
	$SpeechBox/RichTextLabel3.visible = false
	$SpeechBox/RichTextLabel4.visible = true
	tutorial_4.play("tutorial4")
