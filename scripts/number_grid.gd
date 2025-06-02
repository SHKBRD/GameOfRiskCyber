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

func _process(delta: float) -> void:
	handle_input()

func get_number(num: int) -> NumpadNumber:
	var existingButtons: Array = get_children()
	for btn: NumpadNumber in existingButtons:
		if btn.number == num:
			return btn
	return null

func handle_input():
	if Input.is_action_pressed("NumpadButtonPressed"):
		dragging = true
	else:
		dragging = false
	if Input.is_action_just_pressed("NumpadButtonPressed"):
		print(currentNumber)
		_on_number_just_hovered(get_number(currentNumber))
	if Input.is_action_just_released("NumpadButtonPressed"):
		reset_progress()

func init_numbers() -> void:
	var numberButtons: Array = []
	for number: int in height*width:
		numberButtons.append(number+1)
	for heightInd: int in height:
		for widthInd: int in width:
			var chosenNumber: int = numberButtons.pick_random()
			numberButtons.erase(chosenNumber)
			
			var newNumber: NumpadNumber = numpadNumber.instantiate()
			newNumber.position = Vector2(widthInd*buttonDistance, heightInd*buttonDistance)
			
			newNumber.init_numpad_button(chosenNumber)
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
	if dragging:
		if currentNumber == connectOrder + 1:
			connectOrder = currentNumber
			numberObj.confirm_number()
		else:
			reset_progress()
	print()
	print("ORDER: " + str(connectOrder))
	print("CURRENT: " + str(currentNumber))

func _on_number_just_leaved(numberObj: NumpadNumber) -> void:
	currentNumber = -1
