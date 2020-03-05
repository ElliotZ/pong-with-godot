extends Panel

onready var screen_size = get_viewport_rect().size

# TODO: Scoreboard and maybe pause, maybe a title screen and press any key prompt
#       Change following AI code to include potentially the left paddle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if $Ball.position.x < screen_size.x / 2:
    $Player2.cpu_input = Vector2.ZERO
  elif $Ball.position.y > $Player2.position.y + 16 and $Ball._direction.x > 0:
    $Player2.cpu_input = Vector2.DOWN
  elif $Ball.position.y < $Player2.position.y - 16 and $Ball._direction.x > 0:
    $Player2.cpu_input = Vector2.UP
  else:
    $Player2.cpu_input = Vector2.ZERO
