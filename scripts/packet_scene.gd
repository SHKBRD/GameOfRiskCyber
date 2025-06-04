extends Control
class_name PacketScene

signal made_packet_mistake()

var packetScene: PackedScene = preload("res://scenes/incoming_packet.tscn")

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func send_packet() -> void:
	var newPacket: Packet = packetScene.instantiate()
	$MobArea.add_child(newPacket)
	newPacket.made_mistake.connect(made_mistake)
	

func made_mistake() -> void:
	made_packet_mistake.emit()

func _on_timer_timeout() -> void:
	send_packet()
	$Timer.start()
