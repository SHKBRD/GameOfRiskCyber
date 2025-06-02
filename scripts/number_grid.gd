extends Node2D
class_name NumberGrid

static var numpadNumber: PackedScene = preload("res://scenes/numpad_number.tscn")

@export var width: int = 4
@export var height: int = 4
@export var buttonDistance: float = 100.0

func _ready() -> void:
	init_numbers()

func init_numbers() -> void:
	for heightInd: int in height:
		for widthInd: int in width:
			var newNumber: NumpadNumber = numpadNumber.instantiate()
			newNumber.position = Vector2(widthInd*buttonDistance, heightInd*buttonDistance)
			newNumber.init_numpad_button(heightInd*height + widthInd + 1)
			add_child(newNumber)
			 
