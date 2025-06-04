extends Control
class_name PacketScene

var packetScene: PackedScene = preload("res://scenes/incoming_packet.tscn")

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func send_packet() -> void:
	var newPacket: Packet = packetScene.instantiate()
	$MobArea.add_child(newPacket)
	

func _on_timer_timeout() -> void:
	send_packet()
	$Timer.start()
