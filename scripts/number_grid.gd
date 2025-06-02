extends Node2D
class_name NumberGrid

static var numpadNumber: PackedScene = preload("res://scenes/numpad_number.tscn")

@export var width: int = 4
@export var height: int = 4
@export var buttonDistance: float = 100.0

var connectOrder: int = 0
var currentNumber: int = -1
var dragging: bool = false

func _ready() -> void:
	init_numbers()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("NumpadButtonPressed"):
		dragging = true
	else:
		dragging = false

func init_numbers() -> void:
	for heightInd: int in height:
		for widthInd: int in width:
			var newNumber: NumpadNumber = numpadNumber.instantiate()
			newNumber.position = Vector2(widthInd*buttonDistance, heightInd*buttonDistance)
			newNumber.init_numpad_button(heightInd*height + widthInd + 1)
			newNumber.mouse_hovered.connect(_on_number_just_hovered)
			newNumber.mouse_left.connect(_on_number_just_leaved)
			add_child(newNumber)

func reset_progress() -> void:
	var numpadButtons: Array = get_children()
	for numberButton: NumpadNumber in numpadButtons:
		numberButton.reset()
	connectOrder = 0
	currentNumber = -1

func _on_number_just_hovered(numberObj: NumpadNumber) -> void:
	
	currentNumber = numberObj.number
	
	if currentNumber == connectOrder + 1:
		currentNumber = currentNumber
		numberObj.confirm_number()
	else:
		reset_progress()
	print()
	print("ORDER: " + str(connectOrder))
	print("CURRENT: " + str(currentNumber))

func _on_number_just_leaved(numberObj: NumpadNumber) -> void:
	currentNumber = -1
