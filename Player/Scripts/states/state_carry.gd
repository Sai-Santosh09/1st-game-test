class_name StateCarry extends State

@export var move_speed : float = 100.0
@export var throw_audio : AudioStream

var walking : bool = false
var throwable : Throwable

@onready var idle: State_Idle = $"../Idle"
@onready var stun: State_Stun = $"../Stun"






func init() -> void:
	pass



func Enter() -> void:
	player.UpdateAnimation( "carry" )
	walking = false
	pass




func Exit() -> void:
	pass




func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		walking = false
		player.UpdateAnimation( "carry" )
	elif player.SetDirection() or walking == false:
		player.UpdateAnimation( "carry_walk" )
		walking = true
	
	player.velocity = player.direction * move_speed
	return null



func Physics( _delta : float ) -> State:
	return  null



func Handleinput( _event : InputEvent ) -> State:
	if _event.is_action_pressed("attack") or _event.is_action_pressed("interact"):
		return idle
	return null
