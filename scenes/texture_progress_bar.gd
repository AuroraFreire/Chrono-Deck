extends TextureProgressBar

@export var total_time: float = 75
var time_left: float

func _ready():
	time_left = 60
	max_value = total_time
	value = 60

func _process(delta: float):
	time_left -= delta
	time_left = max(time_left, 0.0)
	value = time_left
