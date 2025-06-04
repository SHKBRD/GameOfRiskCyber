extends Node2D
class_name GameOverall

static var day: int = 1
static var maxMistakes: int = 3
static var mistakesMade: int = 0

func make_mistake() -> void:
	# run previous mistake anim
	if mistakesMade != 3:
		$Mistakes.get_child(mistakesMade).reveal()
	
	if mistakesMade != 3:
		mistakesMade += 1

func _on_work_scene_mistake_made() -> void:
	make_mistake()


func _on_packet_scene_made_packet_mistake() -> void:
	make_mistake()
