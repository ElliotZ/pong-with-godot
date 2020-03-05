extends Area2D

export var initial_speed = 200
var _direction = Vector2()

onready var _speed = initial_speed
#onready var _direction = Vector2.LEFT
onready var screen_size = get_viewport_rect().size
#var stopped = false
#signal out_of_bounds_left
#signal out_of_bounds_right

# Called when the node enters the scene tree for the first time.
func _ready():
  _direction.x = randf()
  _direction.y = randf()
  _direction = _direction.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  # modify the position property of an object to make it move.
  #if not stopped:
  _speed += delta  # multiply this by something to increase acceleration
  position += _direction * delta * _speed

  if (position.x < 2):  # ball is out of bounds from the left
    _reset_ball(true)
  if (position.x > screen_size.x - 2):  # from the right
    _reset_ball(false)

  # ball bounces when it reaches the top or the bottom of the viewport
  if ((position.y < 2 and _direction.y < 0) or
      (position.y > screen_size.y - 2 and _direction.y > 0)):
    _direction.y = -_direction.y

# this function gets called when the ball hits the player. random should be a float.
func bounce(pc, random):
  if pc:
    _direction.x = abs(_direction.x)
  else:
    _direction.x = -abs(_direction.x)

  _speed *= 1.05  # change this to modify the change in speed after each bounce
  _direction.y = random
  _direction = _direction.normalized()

#func stop():
  #stopped = true

# this function gets called after the ball goes out of bounds either from the left
# or from the right.
func _reset_ball(for_pc):
  position.x = screen_size.x / 2
  if for_pc:
    _direction = Vector2.LEFT
    #emit_signal("out_of_bounds_left")
  else:
    _direction = Vector2.RIGHT
    #emit_signal("out_of_bounds_right")
  _speed = initial_speed
