extends Sprite2D
class_name NumpadNumber

signal mouse_hovered(NumpadNumber)
signal mouse_left(NumpadNumber)

var number: int = 0
var readInput: bool = false
var confirmed: bool = true

func init_numpad_button(num: int) -> void:
	number = num
	%Label.text = str(number)

func _update(delta: float) -> void:
	if confirmed:
		modulate = Color.GREEN
	else:
		modulate = Color.WHITE

func confirm_number() -> void:
	confirmed = true

func reset() -> void:
	confirmed = false

func _on_area_2d_mouse_entered() -> void:
	readInput = true
	mouse_hovered.emit(self)
	modulate = Color(0.5, 0.5, 0.5, 0.5)

func _on_area_2d_mouse_exited() -> void:
	readInput = false
	mouse_left.emit(self)
	modulate = Color(1.0, 1.0, 1.0, 1.0)
