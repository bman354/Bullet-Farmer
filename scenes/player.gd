extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D


const SPEED: float = 300.0
const ACCELERATION = 10.0
const JUMP_VELOCITY = -400.0

var last_direction := Vector2.DOWN
var direction : Vector2 = Vector2(0,0)

func _physics_process(delta):

	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		last_direction = input_vector
		velocity = input_vector * SPEED
		play_walk_animation(input_vector)
	else:
		velocity = Vector2.ZERO
		play_idle_animation()

	print(input_vector)
	move_and_slide()
		
func play_walk_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			play_if_not("farmer_walking_right")
		else:
			play_if_not("farmer_walking_left")
	else:
		if direction.y > 0:
			play_if_not("farmer_walking_down")
		else:
			play_if_not("farmer_walking_up")
		
func play_idle_animation():
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			sprite.play("farmer_idle_right")
		else:
			sprite.play("farmer_idle_left")
	else:
		if last_direction.y > 0:
			sprite.play("farmer_idle_down")
		else:
			sprite.play("farmer_idle_up")
			
func play_if_not(anim_name: String):
	if sprite.animation != anim_name:
		sprite.play(anim_name)
