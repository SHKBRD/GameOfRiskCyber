extends Button
class_name Packet

signal made_mistake()

enum PacketType {
	BAD,
	GOOD
}

var packetType: PacketType
@export var hp: int = 10

func generate_ip() -> void:
	var typePick: int = RandomNumberGenerator.new().randi_range(0, 1)
	packetType = PacketType.values()[typePick]
	var offset: int = 0
	if packetType == PacketType.BAD:
		offset = RandomNumberGenerator.new().randi_range(4, 9)
		offset *= ((offset % 2) * 2) - 1
	var remaining: int = 160 + offset
	var ipNums: Array = []
	for i: int in range(3, 0, -1):
		var chosenIPNum: int = RandomNumberGenerator.new().randi_range(1, remaining-i)
		ipNums.append(chosenIPNum)
		remaining -= chosenIPNum
	ipNums.append(remaining)
	
	var assembleIPText: String = ""
	var IPADD: int = 0
	for ipNum: int in ipNums:
		assembleIPText += str(ipNum) + "."
		IPADD += ipNum
	assembleIPText = assembleIPText.substr(0, assembleIPText.length()-1)
	
	$IP.text = assembleIPText
	$IP2.text = str(IPADD)
	

func _ready() -> void:
	position.x = RandomNumberGenerator.new().randf_range(0, 500)
	generate_ip()
	$HPCount.text = str(hp)

func _process(delta: float) -> void:
	position += Vector2(0, 0.5)

func _pressed() -> void:
	hp -= 1
	$HPCount.text = str(hp)
	
	if hp == 0:
		if packetType == PacketType.GOOD:
			made_mistake.emit()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	if packetType == PacketType.BAD:
		made_mistake.emit()
