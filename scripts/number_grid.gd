extends Node2D
class_name NumberGrid

static var numpadNumber: PackedScene = preload("res://scenes/numpad_number.tscn")

@export var width: int = 4
@export var height: int = 4

func _ready() -> void:
	pass

func init_numbers() -> void:
	for heightInd: int in height:
		for widthInd: int in width:
			var newNumber: NumpadNumber = numpadNumber.instantiate()
			 
