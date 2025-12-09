extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Globals.coins += 1
		
		var stage = get_tree().current_scene
		if stage.has_node("HUD"):
			stage.get_node("HUD").update_ui()
		prints ("Me rozaste el pezón")
		prints ("Coins: ", Globals.coins)
		queue_free()
