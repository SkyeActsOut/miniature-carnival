extends Node

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("192.168.1.180", 32523)
	get_tree().set_network_peer(network)
	network.connect("connection_failed", self, "_on_connection_failed")

func _on_connection_failed (error):
	$"VBoxContainer/Login/Connect & Disconnect/Status".text = str ("ERROR CONNECTING TO SERVER:\n", error)

func _on_Connect_pressed():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("192.168.1.180", 32523)
	get_tree().set_network_peer(network)


func _on_Disconnect_pressed():
	get_tree().set_network_peer(null)
