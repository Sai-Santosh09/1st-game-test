class_name Throwable extends Area2D

@export var gravity_strength : float = 980.0
@export var throw_speed : float = 400.0
@export var throw_height_strength : float = 100.0
@export var throw_starting_height : float = 49.0

var picked_up : bool = false
var throwable : Node2D

@onready var hurt_box: HurtBox = $HurtBox



func _ready() -> void:
	area_entered.connect( _on_area_enter )
	area_exited.connect( _on_area_exit )
	throwable = get_parent()


func player_interact() -> void:
	
	if picked_up == false:
		
		diasble_collisions( throwable )
		if throwable.get_parent():
			throwable.get_parent().remove_child( throwable )
		PlayerManager.player.held_item.add_child( throwable )
		throwable.position = Vector2.ZERO
		PlayerManager.player.pickup_item( self )
		area_entered.disconnect( _on_area_enter )
		area_exited.disconnect( _on_area_exit )
		pass
	pass


func diasble_collisions( _node : Node ) -> void:
	for c in _node.get_children():
		if c == self:
			continue
		if c is CollisionShape2D:
			c.disabled = true
		else:
			diasble_collisions( c )


func _on_area_enter( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.connect( player_interact )
	pass


func _on_area_exit( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( player_interact )
	pass


func setup_hurt_box() -> void:
	hurt_box.monitoring = false
	for c in get_children():
		if c is CollisionShape2D:
			var _col : CollisionShape2D = c.duplicate()
			hurt_box.add_child( _col )
			_col.debug_color = Color(1, 0,0, 0.5)
