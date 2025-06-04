extends Button
class_name Packet

func _ready() -> void:
	position.x = RandomNumberGenerator.new().randf_range(0, 500)
	
func _process(delta: float) -> void:
	position += Vector2(0, 1)



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
