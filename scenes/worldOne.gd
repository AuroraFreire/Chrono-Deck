extends Control

func _ready() -> void:
	play_musicOne()

func _process(delta: float) -> void:
	pass

func play_musicOne():
	AudioController.play_egyptAmbient()
