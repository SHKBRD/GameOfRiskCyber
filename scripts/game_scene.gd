extends Node2D
class_name GameOverall

static var day: int = 1
static var maxMistakes: int = 3
static var mistakesMade: int = 0


func _on_work_scene_mistake_made() -> void:
	# run previous mistake anim
	if mistakesMade != 3:
		$Mistakes.get_child(mistakesMade).reveal()
	
	if mistakesMade != 3:
		mistakesMade += 1
