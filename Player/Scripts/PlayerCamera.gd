class_name PlayerCamera extends Camera2D

@export_range( 0, 1, 0.05, "or_greater") var shake_power : float = 0.5
@export var shake_max_offset : float = 5.0
@export var shake_decay : float = 1.0
var shake_trauma : float = 0.0



# Called when the node enters the scene tree for the first time.
func _ready():
	LevalManager.TileMapBoundsChanged.connect( UpdateLimits )
	UpdateLimits( LevalManager.current_tilemap_bounds )
	PlayerManager.camera_shook.connect( add_camera_shake )
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	
	if shake_trauma > 0:
		shake_trauma = max( shake_trauma - shake_decay * delta, 0 )
		shake()


func add_camera_shake( val : float ) -> void:
	shake_trauma = val
	pass


func shake() -> void:
	var amount : float = pow( shake_trauma * shake_power, 2 )
	offset = Vector2( randf_range( -1, 1 ), randf_range( -1, 1 ) ) * shake_max_offset * amount
	
	pass


func UpdateLimits( bounds : Array[ Vector2 ] ) -> void:
	if bounds == []:
		return
	limit_left = int( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int( bounds[1].x )
	limit_bottom = int( bounds[1].y )
	pass
