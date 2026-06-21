extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options
@onready var background: Panel = $Background

func _ready():
	if GameState.current_level == "end":
		var style = StyleBoxTexture.new()
		style.texture = load("res://assets/images2/EndGameImage.png")
		background.add_theme_stylebox_override("panel", style)
	main_buttons.visible = true
	options.visible = false
	$ChronoDeckLogo.visible = true
	background.modulate = Color("#787878")

func _process(_delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	if GameState.current_level == "null":
		get_tree().change_scene_to_file("res://scenes/first_monologue.tscn")
	elif GameState.current_level == "one":
		get_tree().change_scene_to_file("res://scenes/first_monologue.tscn")
	elif GameState.current_level == "two":
		get_tree().change_scene_to_file("res://scenes/second_monologue.tscn")
	else:
		return

func _on_settings_pressed() -> void:
	main_buttons.visible = false
	options.visible = true
	if GameState.current_level == "end":
		var style = StyleBoxTexture.new()
		style.texture = load("res://assets/images2/EndGameImageBlur.png")
		background.add_theme_stylebox_override("panel", style)
		$ChronoDeckLogo.visible = false
	else:
		var style = StyleBoxTexture.new()
		style.texture = load("res://assets/images2/MainScreenBlurForReal.png")
		background.add_theme_stylebox_override("panel", style)
		$ChronoDeckLogo.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_options_pressed() -> void:
	_ready()
	if GameState.current_level == "end":
		var style = StyleBoxTexture.new()
		style.texture = load("res://assets/images2/EndGameImage.png")
		background.add_theme_stylebox_override("panel", style)
	else:
		var style = StyleBoxTexture.new()
		style.texture = load("res://assets/images2/MainScreen.png")
		background.add_theme_stylebox_override("panel", style)

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
	

func _on_dontclickthis_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/troll.tscn")
