extends Node2D

export(PackedScene) var enemy_scene
var screen_size
var MIN_PADDING = 45
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.game_initialized and $EnemyTimer.is_stopped():
		$EnemyTimer.start()
		$Background_audio.play()
		
	if Globals.game_over:
		$EnemyTimer.stop()
		$Background_audio.stop()
		$Canvas/GameOverLabel.show()
	else:
		$Canvas/GameOverLabel.hide()
		
	if Globals.game_initialized:
		$Canvas/Label.hide()
	else: 
		$Canvas/Label.show()

func _on_EnemyTimer_timeout():
	create_enemy()
	
func create_enemy():
	var enemy = enemy_scene.instance()
	enemy.position.x = rand_range(MIN_PADDING, screen_size.x - MIN_PADDING)
	get_tree().get_root().add_child(enemy)
	add_child(enemy)
