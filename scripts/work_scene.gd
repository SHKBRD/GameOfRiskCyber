extends Node2D
class_name WorkScene

var quotaRequirement: int = 4
var quotaFilled: int = 0

var maxMistakes: int = 0
var mistakesMade: int = 0

func _ready() -> void:
	%NumberGrid.connectLine = %ConnectLine


func _on_number_grid_lost_round() -> void:
	pass # Replace with function body.


func _on_number_grid_won_round() -> void:
	pass # Replace with function body.
