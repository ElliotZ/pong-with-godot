extends Area2D

export var speed = 400
export var pc = false
onready var screen_size = get_viewport_rect().size
var rand_engine = RandomNumberGenerator.new()
var cpu_input = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
  rand_engine.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  var direction = Vector2.ZERO
  # player can control the paddle mark with pc = true. otherwise the control is
  # passed to the AI script placed in the main scene.
  if pc:
    if Input.is_action_pressed("ui_down"):
      direction = Vector2.DOWN
    if Input.is_action_pressed("ui_up"):
      direction = Vector2.UP
  else:
    direction = cpu_input

  # movement speed is consistent even if framerate fluctuates
  position += direction * speed * delta
  # prevents the paddles from going off screen
  position.y = clamp(position.y, 16, screen_size.y - 16)

# this function links to a self emitted signal, which is connected via the editor
# GUI. this can also be done manually with scripting, typically in the _ready()
# function.
func _on_Player_area_entered(area):
  area.bounce(pc, rand_engine.randf_range(-1.0, 1.0))
