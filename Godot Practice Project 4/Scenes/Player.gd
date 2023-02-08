extends Area2D


# Member Variables
export var speed = 400
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO;
	velocity.x += int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y += int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if (velocity.length() > 0):
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, $CollisionShape2D.shape.height * 2, screen_size.x - $CollisionShape2D.shape.height * 2)
	position.y = clamp(position.y, $CollisionShape2D.shape.radius + 10, screen_size.y - $CollisionShape2D.shape.radius - 10)
	
	$AnimatedSprite.flip_h = (velocity.x < 0) || ($AnimatedSprite.flip_h && velocity.x == 0)
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk";
		$AnimatedSprite.flip_v = false;
	if velocity.y != 0:
		$AnimatedSprite.animation = "up";
		$AnimatedSprite.flip_v = velocity.y > 0
