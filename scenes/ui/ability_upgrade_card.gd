extends PanelContainer

signal upgrade_card_selected

@onready var name_label: Label = $%NameLabel
@onready var desc_label: Label = $%DescriptionLabel

var disabled = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	desc_label.text = upgrade.description

func play_in(delay: float = 0):
	if disabled:
		return
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")
	

func play_discard():
	$AnimationPlayer.play("discard")
	
func select_card():
	disabled = true
	$AnimationPlayer.play("selected")
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()
	#get_tree().get_first_node_in_group("upgrade_card")
	await $AnimationPlayer.animation_finished
	upgrade_card_selected.emit()
	
	
func on_gui_input(event: InputEvent):
	if disabled:
		return
	if event.is_action_pressed("left_click"):
		select_card()
		

func on_mouse_entered():
	$HoverAnimationPlayer.play("hover")
