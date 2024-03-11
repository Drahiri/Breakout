extends Control

var score = 0

func _ready():
	$Score.hide()
	$Lifes.hide()


func start_game(lifes: int):
	$Lifes.text = "Lifes: %d" % lifes
	$Score.text = "Score: %d" % score
	_toggle_center_sides()


func update_score():
	score += 100
	$Score.text = "Score: %d" % score


func won():
	$Center.text = "YOU WON! SCORED: %d\nPress Up or Down to select level\nPress Enter to start" % score
	_toggle_center_sides()


func _toggle_center_sides():
	if $Center.is_visible():
		$Center.hide()
		$Score.show()
		$Lifes.show()
	else:
		$Center.show()
		$Score.hide()
		$Lifes.hide()
