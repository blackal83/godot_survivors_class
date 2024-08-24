extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal transitioned_halfway

func transition():
	$ColorRect.visible = true
	
	animation_player.play("default")
	await animation_player.animation_finished
	transitioned_halfway.emit()
	
	animation_player.play_backwards("default")
	await animation_player.animation_finished
	
	$ColorRect.visible = false

func transition_to_scene(scene_path: String):
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file(scene_path)

