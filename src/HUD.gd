extends CanvasLayer

signal start_game

func _ready():
	$LivesLabel.hide()
	$ScoreLabel.hide()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		start_game()

func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()

func show_game_over():
	show_message("Game over")
	yield(get_tree().create_timer(5), 'timeout')
	show_message("This too shall pass")
	$ScoreLabel.hide()
	$LivesLabel.hide()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func update_lives(lives):
	$LivesLabel.text = "lives: " + str(lives)

func _on_StartButton_pressed():
	start_game()

func start_game():
	$StartButton.hide()
	$MessageLabel.hide()
	update_score(0)
	$ScoreLabel.show()
	update_lives(3)
	$LivesLabel.show()
	emit_signal("start_game")
