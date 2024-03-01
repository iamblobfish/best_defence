extends RigidBody2D

var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0
	top_level = true
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity = Vector2(0, 0)
