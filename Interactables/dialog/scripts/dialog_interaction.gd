@tool
@icon("res://GUI/dialog_system/icons/chat_bubbles.svg")
class_name DialogInteraction extends Area2D

signal player_entered
signal player_exited
signal player_interacted
signal finished

@export var enabled : bool = true

var dialog_items : Array[ DialogItem ] 

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	area_entered.connect( _on_area_entered )
	area_exited.connect( _on_area_exit )
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append( c )
	
	pass


func player_interact() -> void:
	player_interacted.emit()
	await get_tree().process_frame
	await get_tree().process_frame
	DialogSystem.show_dialog( dialog_items )
	pass


func _on_area_entered( _a : Area2D ) -> void:
	if enabled == false || dialog_items.size() == 0:
		return
	animation_player.play("show")
	PlayerManager.interact_pressed.connect( player_interact )
	player_entered.emit()
	pass


func _on_area_exit( _a : Area2D ) -> void:
	animation_player.play("hide")
	if PlayerManager.interact_pressed.is_connected( player_interact ):
		PlayerManager.interact_pressed.disconnect( player_interact )
	player_exited.emit()
	pass


func _get_configuration_warnings() -> PackedStringArray:
	if _check_for_dialog_items() == false:
		return [ "Requires at least one DialogItem node." ]
	else:
		return []


func _check_for_dialog_items() -> bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false
