extends CanvasLayer

signal back_pressed

@onready var window_button: Button = %WindowButton
@onready var sfx_volume_slider = %SFXVolumeSlider
@onready var music_volume_slider = %MusicVolumeSlider
@onready var back_button = %BackButton

func _ready():
	if get_parent().name == "PauseMenu":
		$TileMap.visible = false
		$Vignette.visible = false
	else:
		$TileMap.visible = true
		$Vignette.visible = true
		
	window_button.pressed.connect(on_window_button_pressed)
	update_display()
	sfx_volume_slider.value_changed.connect(on_audio_volume_changed.bind("sfx"))
	music_volume_slider.value_changed.connect(on_audio_volume_changed.bind("music"))
	back_button.pressed.connect(on_back_button_pressed)

func update_display():
	window_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"
	
	sfx_volume_slider.value = get_bus_volume_percent("sfx")
	music_volume_slider.value = get_bus_volume_percent("music")

func get_bus_volume_percent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var vol_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(vol_db)

func set_bus_volume_percent(bus_name: String, percent: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, volume_db)

func on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	update_display()

func on_audio_volume_changed(value: float, bus_name: String):
	set_bus_volume_percent(bus_name, value)
	update_display()
	
func on_back_button_pressed():
	back_pressed.emit()
	#queue_free()
