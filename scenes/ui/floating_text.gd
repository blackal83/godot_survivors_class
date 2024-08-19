extends Node2D


func _ready():
	pass

func start(text: String):
	$Label.text = text
	
	var tween = create_tween()
	tween.set_parallel()
	
	#move the damage text up 16 pixels over .3 secs
	tween.tween_property(self, "global_position", global_position + (Vector2.UP) * 16, .3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	
	tween.chain()
	
	#move the damage text up an additional 32 pixels and scale down to 0 over .5 secs
	tween.tween_property(self, "global_position", global_position + (Vector2.UP) * 48, .5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ZERO, .5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.chain()
	
	tween.tween_callback(queue_free)
	
	#sclae the damage text to 1.5 over .15s
	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1.5, .15)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, .15)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
