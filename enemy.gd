extends RigidBody2D

signal hp_changed(new_value)
signal killed

var hp = 100
var velocity = Vector2(randf_range(150.0, 250.0), 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$health.max_value = hp
	gravity_scale = 0
	top_level = true
	$AnimatedSprite2D.play()
	killed.connect(on_kill)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$health.value = hp
	linear_velocity = Vector2(0, 0)

func take_damage(amount):
	hp -= amount
	if (hp <= 0):
		killed.emit()
	hp_changed.emit(hp)

func on_kill():
	print("Dead!")
