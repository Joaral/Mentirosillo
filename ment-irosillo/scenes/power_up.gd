extends Area3D



func _on_body_entered(body: Node3D) -> void:
	Globals.coins += 1
	
	
	prints ("Me rozaste el pezón")
	prints ("Coins: ", Globals.coins)
	
	queue_free()
