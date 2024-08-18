extends PanelContainer

signal upgrade_card_selected

@onready var name_label: Label = $%NameLabel
@onready var desc_label: Label = $%DescriptionLabel

func _ready():
	gui_input.connect(on_gui_input)

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	desc_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		upgrade_card_selected.emit()
	
	
