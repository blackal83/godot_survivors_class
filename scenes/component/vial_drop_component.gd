extends Node

@export_range(0, 1) var drop_percent: float = 1 #.5
@export var health_comp: Node
@export var vial_scene: PackedScene

func _ready():
	(health_comp as HealthComponent).died.connect(on_died)


func on_died():
	var adjusted_drop_precent = drop_percent
	var quantity = MetaProgression.get_upgrade_quantity("experience_gain")
	if  quantity > 0:
		adjusted_drop_precent = drop_percent + (quantity * .1)
	print("adjusted drop: " + str (adjusted_drop_precent))
	
	if randf() > adjusted_drop_precent:
		return
	
	if vial_scene == null:
		return
	if not owner is Node2D:
		return
	
	var spawn_pos = (owner as Node2D).global_position
	var vial_inst = vial_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_inst)
	vial_inst.global_position = spawn_pos
	
