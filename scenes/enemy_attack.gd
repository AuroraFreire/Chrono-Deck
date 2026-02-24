extends Label

var rng

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	$"../endTurn".pressed.connect(_on_timer_timeout)
	$Timer.start()

func _on_timer_timeout() -> void:
	rng = randi_range(0, 9)
	var num_text = str(rng)
	$".".text = num_text
