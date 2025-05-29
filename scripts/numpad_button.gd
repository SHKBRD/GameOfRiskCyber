extends Sprite2D
class_name NumpadNumber

var number: int = 0
var readInput: bool = false

func init_numpad_button(num: int) -> void:
	number = num

func _on_area_2d_mouse_entered() -> void:
	readInput = true


func _on_area_2d_mouse_exited() -> void:
	readInput = false
