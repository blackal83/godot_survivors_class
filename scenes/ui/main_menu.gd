extends CanvasLayer

var options_scene = preload("res://scenes/ui/options_menu.tscn")

func _ready():
	$%PlayButton.pressed.connect(on_play_pressed)
	$%UpgradesButton.pressed.connect(on_upgrades_pressed)
	
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)
	
func on_play_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_inst = options_scene.instantiate()
	add_child(options_inst)
	options_inst.back_pressed.connect(on_button_closed.bind(options_inst))

func on_upgrades_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/meta_menu.tscn")

func on_quit_pressed():
	get_tree().quit()

func on_button_closed(options_inst: Node):
	options_inst.queue_free()


