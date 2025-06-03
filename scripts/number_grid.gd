extends Node2D
class_name NumberGrid

signal won_round()
signal lost_round()

static var numpadNumber: PackedScene = preload("res://scenes/numpad_number.tscn")

@export var width: int = 4
@export var height: int = 4
@export var buttonDistance: float = 100.0

var connectLine: Line2D
var connectOrder: int = 0
var currentNumber: int = -1
var dragging: bool = false

var readyToResetWin: bool = false

func _ready() -> void:
	init_numbers()

func _process(delta: float) -> void:
	handle_input()
	update_connect_line()

func get_number(num: int) -> NumpadNumber:
	var existingButtons: Array = get_children()
	for btn: NumpadNumber in existingButtons:
		if btn.number == num:
			return btn
	return null

func update_buttons_to_default() -> void:
	var buttonChildren: Array = get_children()
	for button: NumpadNumber in buttonChildren:
		button.self_modulate = Color.WHITE

func init_win_round() -> void:
	won_round.emit()
	readyToResetWin = true
	
	var buttonChildren: Array = get_children()
	for button: NumpadNumber in buttonChildren:
		button.self_modulate = Color.GREEN

func init_lose_round() -> void:
	lost_round.emit()
	var buttonChildren: Array = get_children()
	for button: NumpadNumber in buttonChildren:
		button.self_modulate = Color.RED
	
	reset_progress()

func update_connect_line() -> void:
	if connectOrder != 0 and connectLine.points.size() != 0:
		for pointInd: int in connectLine.points.size()-1:
			connectLine.remove_point(pointInd)
			connectLine.add_point(get_number(pointInd+1).position, pointInd)
		connectLine.remove_point(connectLine.points.size()-1)
		connectLine.add_point(get_local_mouse_position())


func add_connect_points(num: int) -> void:
	connectLine.add_point(get_number(num).position, num-1)
	
func handle_input():
	if Input.is_action_just_pressed("NumpadButtonPressed"):
		dragging = true
		update_buttons_to_default()
		if currentNumber != -1:
			_on_number_just_hovered(get_number(currentNumber))
			connectLine.add_point(get_number(1).position)
			connectLine.add_point(get_number(1).position)
		else:
			connectOrder = -1
	if Input.is_action_just_released("NumpadButtonPressed"):
		dragging = false
		if not readyToResetWin:
			init_lose_round()

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
	connectLine.clear_points()

func _on_number_just_hovered(numberObj: NumpadNumber) -> void:
	
	currentNumber = numberObj.number
	if dragging:
		if currentNumber == connectOrder + 1:
			connectOrder = currentNumber
			numberObj.confirm_number()
			if currentNumber != 1:
				add_connect_points(currentNumber)
				
			if connectOrder == width*height:
				init_win_round()
		elif numberObj.number <= connectOrder:
			pass
		else:
			init_lose_round()
			
	#print()
	#print("ORDER: " + str(connectOrder))
	#print("CURRENT: " + str(currentNumber))

func _on_number_just_leaved(numberObj: NumpadNumber) -> void:
	currentNumber = -1
