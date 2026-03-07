class_name State_Lift extends State

@export var lift_audio : AudioStream

@onready var carry: State = $"../Carry"




func Enter() -> void:
	player.UpdateAnimation( "lift" )
	
	player.animation_player.animation_finished.connect( state_complete )
	player.audio.stream = lift_audio
	player.audio.play()
	pass




func Exit() -> void:
	pass




func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return null



func Physics( _delta : float ) -> State:
	return  null



func Handleinput( _event : InputEvent ) -> State:
	return null


func state_complete( _a : String ) -> void:
	player.animation_player.animation_finished.disconnect( state_complete )
	state_machine.ChangeState( carry )
	pass
