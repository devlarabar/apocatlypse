extends Node

@export var mob_scene : PackedScene
@export var coin_scene : PackedScene

@onready var MobTimer = get_node("MobTimer")
@onready var ScoreTimer = get_node("ScoreTimer")

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Music.play()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$CoinTimer.start()
	$Hud.update_score(score)
	$Hud.show_message("Get Ready")


func game_over():
	ScoreTimer.stop()
	MobTimer.stop()
	$CoinTimer.stop()
	$DeathSound.play()
	$Hud.show_game_over()


func _on_score_timer_timeout():
	score += 1 # Every second, we get a point for surviving
	$Hud.update_score(score)


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction - 180

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_start_timer_timeout():
	MobTimer.start()
	ScoreTimer.start()


func _on_hud_start_game():
	new_game()
	


func pick_up_coin():
	score += 2
	$Hud.update_score(score)
	$CoinSound.play()


func _on_coin_timer_timeout():
	var coin = coin_scene.instantiate()
	var screen_size = get_viewport().get_visible_rect().size
	var randX = randi_range(0, screen_size.x)
	var randY = randi_range(0, screen_size.y)
	coin.position = Vector2(randX, randY)
	add_child(coin)
