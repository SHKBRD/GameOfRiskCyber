extends Button
class_name Packet

enum PacketType {
	BAD,
	GOOD
}

var packetType: PacketType

func generate_ip() -> void:
	var typePick: int = RandomNumberGenerator.new().randi_range(0, 1)
	packetType = PacketType.values()[typePick]
	var offset: int = 0
	if packetType == PacketType.BAD:
		offset = RandomNumberGenerator.new().randi_range(4, 9)
		offset *= ((offset % 2) * 2) - 1
	var remaining: int = 160
	var ipNums: Array = []
	for i: int in range(3, 1, -1):
		var chosenIPNum: int = RandomNumberGenerator.new().randi_range(1, remaining-i)
		ipNums.append(chosenIPNum)
		remaining -= chosenIPNum
	ipNums.append(remaining)
	

func _ready() -> void:
	position.x = RandomNumberGenerator.new().randf_range(0, 500)
	generate_ip()

func _process(delta: float) -> void:
	position += Vector2(0, 1)



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
