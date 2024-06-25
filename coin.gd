extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func coin_picked_up():
	queue_free()


func _on_area_entered(area):
	# Execute function from Main script
	get_tree().root.get_node("Main").pick_up_coin()
	coin_picked_up()


func _on_timer_timeout():
	queue_free()
