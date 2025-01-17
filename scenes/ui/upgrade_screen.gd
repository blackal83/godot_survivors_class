extends CanvasLayer

signal upgrade_screen_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = $%CardContainer


func _ready():
	get_tree().paused = true
	
func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	var delay = 0
	for upgrade in upgrades:
		var card_inst = upgrade_card_scene.instantiate()
		card_container.add_child(card_inst)
		card_inst.set_ability_upgrade(upgrade)
		card_inst.play_in(delay)
		card_inst.upgrade_card_selected.connect(on_upgrade_card_selected.bind(upgrade))
		delay += 0.2

func on_upgrade_card_selected(upgrade: AbilityUpgrade):
	upgrade_screen_selected.emit(upgrade)
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()


