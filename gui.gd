extends Control

var score = 0

func _ready():
	$Score.hide()
	$Lifes.hide()


func start_game(lifes: int):
	update_lifes(lifes)
	_toggle_center_sides()


func update_score():
	score += 100
	$Score.text = "Score: %d" % score


func update_lifes(lifes: int):
	$Lifes.text = "Lifes: %d" % lifes


func won():
	$Center.text = "YOU WON! SCORED: %d\nPress Up or Down to select level\nPress Enter to start" % score
	_toggle_center_sides()


func lost():
	$Center.text = "YOU LOST! SCORED: %d\nPress Up or Down to select level\nPress Enter to start" % score
	score = 0
	$Score.text = "Score: 0"
	_toggle_center_sides()

func finished():
	$Center.text = "CONGRATULATION!!!\nYou finished all levels with score: %d\nPress Esc to exit" % score


func _toggle_center_sides():
	if $Center.is_visible():
		$Center.hide()
		$Score.show()
		$Lifes.show()
	else:
		$Center.show()
		$Score.hide()
		$Lifes.hide()
