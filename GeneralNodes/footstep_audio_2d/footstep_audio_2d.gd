class_name FootstepAudio2D extends AudioStreamPlayer2D

@export var footstep_variants : Array[ AudioStream ]


func play_footstep() -> void:
	get_footstep_type()
	play()


func get_footstep_type() -> void:
	for t in get_tree().get_nodes_in_group( "tilemaps" ):
		if t is TileMapLayer:
			
			var cell : Vector2i = t.local_to_map( global_position )
			pass
		pass
	pass
