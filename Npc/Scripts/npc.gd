@icon( "res://Npc/Icons/npc.svg" )
class_name NPC extends CharacterBody2D

signal do_behavior_enabled

var state : String = "idle"
var direction : Vector2 =  Vector2.DOWN
var direction_name : String = "down"

@export var npc_resource : NPCResource

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	#setup Npc
	pass



func setup_npc() -> void:
	if npc_resource:
		sprite.texture = npc_resource.sprite
	pass
