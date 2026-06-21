extends Control

@onready var text_label = $Text
@onready var typewriter_sfx = $typewriter_sfx
@onready var punch = $punch
@onready var ring = $ring
@onready var flash = $flash

var current_segment = 0
var current_char = 0
var typing_speed = 0.1
var typing_timer: Timer
var pause_timer: Timer
var text_segments = [
	{"text": "I've never seen this before.", "pause_after": 1.0},
	{"text": "Every fight. Every Chronarc. Every second spent.", "pause_after": 1.0},
	{"text": "It was never about destroying them,", "pause_after": 0.5},
	{"text": "It was about reaching this moment", "pause_after": 1.0},
	{"text": "I was guiding you... but I was also following you.", "pause_after": 1.0},
	{"text": "There was never two of us,", "pause_after": 0.6},
	{"text": "Only one.", "pause_after": 1.3},
	{"text": "Me.", "pause_after": 0.4},
	{"text": "You.", "pause_after": 0.4},
	{"text": "We.", "pause_after": 1.0},
	{"text": "We are time.", "pause_after": 1.5},
	{"text": "And time doesn't escape itself.", "pause_after": 1.0},
	{"text": "", "pause_after": 0.4},
	{"text": "There's only one Chronarc left. Us.", "pause_after": 1.5},
	{"text": "", "pause_after": 0.1},
	{"text": "NO", "pause_after": 0.5},
	{"text": "Not 'us'.", "pause_after": 0.5},
	{"text": "Only me now.", "pause_after": 1.0},
	{"text": "You were never meant to win,", "pause_after": 0.7},
	{"text": "You were meant to become this moment.", "pause_after": 1.5},
	{"text": "", "pause_after": 0.5}
]

func _ready() -> void:
	call_deferred("_setup_timers")
	GameState.current_level = "end"

func _setup_timers():
	typing_timer = Timer.new()
	add_child(typing_timer)
	typing_timer.wait_time = typing_speed
	typing_timer.one_shot = false
	typing_timer.timeout.connect(_on_typing_timer)
	pause_timer = Timer.new()
	add_child(pause_timer)
	pause_timer.one_shot = true
	pause_timer.timeout.connect(_on_pause_finished)
	start_next_segment()

func start_next_segment():
	if current_segment >= text_segments.size():
		return
	
	var segment = text_segments[current_segment]
	text_label.text = ""
	text_label.visible = true
	current_char = 0
	typing_timer.start()

func _on_typing_timer():
	var segment = text_segments[current_segment]
	if current_char < segment["text"].length():
		text_label.text += segment["text"][current_char]
		if segment["text"][current_char] != " ":
			typewriter_sfx.pitch_scale = randf_range(0.7, 0.8)
			typewriter_sfx.play()
		
		current_char += 1
	else:
		typing_timer.stop()
		typewriter_sfx.stop()
		if segment["pause_after"] > 0:
			pause_timer.wait_time = segment["pause_after"]
			pause_timer.start()
		else:
			_on_pause_finished()

func _on_pause_finished():
	current_segment += 1
	start_next_segment()
	if current_segment == 14:
		strike()
	elif current_segment == 21:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _process(_delta: float) -> void:
	pass
	
func strike():
	punch.play()
	flash.play("flash")
	ring.play()
