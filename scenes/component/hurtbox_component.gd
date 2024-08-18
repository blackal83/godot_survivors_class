extends Area2D
class_name HurtboxComponent

@export var health_comp: Node

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(other_area: Area2D):
	if not other_area is HitboxComponent:
		return
	if health_comp == null:
		return
	
	var hitbox_comp = other_area as HitboxComponent
	health_comp.damage(hitbox_comp.damage)
	
	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	
	floating_text.global_position = global_position + (Vector2.UP * 16)
	floating_text.start(str(hitbox_comp.damage))
