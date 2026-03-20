class_name Pathfinder extends Node2D

var vectors : Array[ Vector2 ] = [
		Vector2(0, -1), #for up
		Vector2(1, -1), #up-right (north east)
		Vector2(1, 0), #Right side
		Vector2(1, 1), #down-right (south east)
		Vector2(0 , 1), #down side(south)
		Vector2(-1 , 1), #down-left(south west)
		Vector2(-1, 0), #Left
		Vector2(-1, -1) # up-left (north west)
]


var interests : Array[ float ]
var obstacles : Array[ float ] = [0, 0, 0, 0, 0, 0, 0, 0]
var outcomes : Array[ float ] = [0, 0, 0, 0, 0, 0, 0, 0]
var rays : Array[ RayCast2D ]

var move_dir : Vector2 = Vector2.ZERO
var best_path : Vector2 = Vector2.ZERO

@onready var timer: Timer = $Timer


func _ready() -> void:
	#1- Gather all raycast nodes
	for c in get_children():
		if c is RayCast2D:
			rays.append( c )
	
	#normalize the vectors
	#for v in vectors:
		#v = v.normalized()
	for i in vectors.size():
		vectors[ i ] = vectors[ i ].normalized()
		pass
	
	
	
	#pathfinder function
	set_path()
	
	timer.timeout.connect( set_path )
	pass


func _process(delta: float) -> void:
	#this lerp fixes the sudden movement changes which makes the enemy movement better
	move_dir = lerp( move_dir, best_path, 10 * delta )
	pass



func set_path() -> void:
	#get player dir
	var player_dir : Vector2 = global_position.direction_to( PlayerManager.player.global_position )
	
	for i in 8:
		obstacles[i] = 0
		outcomes[i] = 0
	
	for i in 8:
		if rays[ i ].is_colliding():
			obstacles[ i ] += 4
			obstacles[ (i + 1) % 8 ] += 1
			obstacles[ (i - 1) % 8 ] += 1
	#if no obstacles
	if obstacles.max() == 0:
		best_path = player_dir
		return
	#most desired direction
	interests.clear()
	for v in vectors:
		
		
		
		interests.append( v.dot( player_dir ) )
	
	for i in 8:
		outcomes[ i ] = interests[ i ] - obstacles[ i ]
		
	
	best_path = vectors[ outcomes.find( outcomes.max() ) ]
	
	pass
