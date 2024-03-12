extends Control

var _score = 0

func _ready():
	$Score.hide()
	$Lifes.hide()


func start_game(lifes: int):
	update_lifes(lifes)
	_toggle_center_sides()


func update_score():
	_score += 100
	$Score.text = "Score: %d" % _score


func update_lifes(lifes: int):
	$Lifes.text = "Lifes: %d" % lifes


func default_message():
	$Center.text = "Press Up or Down to select level\n\
		Press Enter to start or Esc to exit"


func won():
	_toggle_center_sides()
	$Center.text = "YOU WON! SCORED: %d" % _score


func lost():
	_toggle_center_sides()
	$Center.text = "YOU LOST! SCORED: %d" % _score
	_score = 0
	$Score.text = "Score: 0"


func finished():
	$Center.text = "CONGRATULATION!!!\n\
		You finished all levels with score: %d\n\
		Press Esc to exit" % _score


func _toggle_center_sides():
	if $Center.is_visible():
		$Center.hide()
		$Score.show()
		$Lifes.show()
	else:
		$Center.show()
		$Score.hide()
		$Lifes.hide()
