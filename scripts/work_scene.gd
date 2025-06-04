extends Control
class_name WorkScene

signal mistake_made()

var quotaRequirement: int = 4
var quotaFilled: int = 0

func _ready() -> void:
	%NumberGrid.connectLine = %ConnectLine
	update_ui_counters()

func update_ui_counters() -> void:
	%QuotaProgressBar.max_value = quotaRequirement
	%QuotaProgressBar.value = quotaFilled
	%Numerator.text = str(quotaFilled)
	%Denominator.text = str(quotaRequirement)

func add_to_quota() -> void:
	quotaFilled += 1
	update_ui_counters()

func _on_number_grid_lost_round() -> void:
	mistake_made.emit()
	


func _on_number_grid_won_round() -> void:
	add_to_quota()
