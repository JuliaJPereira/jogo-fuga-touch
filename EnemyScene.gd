extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta * speed
	if position.y > get_viewport_rect().size.y + 20:
		queue_free()
	
func destroy():
	queue_free()
