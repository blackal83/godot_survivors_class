extends CanvasLayer

signal upgrade_screen_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = $%CardContainer


func _ready():
	get_tree().paused = true
	
func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_inst = upgrade_card_scene.instantiate()
		card_container.add_child(card_inst)
		card_inst.set_ability_upgrade(upgrade)
		card_inst.upgrade_card_selected.connect(on_upgrade_card_selected.bind(upgrade))

func on_upgrade_card_selected(upgrade: AbilityUpgrade):
	upgrade_screen_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()


