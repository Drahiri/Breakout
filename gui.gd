extends Control
#
func _ready():
	$Score.hide()
	$Lifes.hide()


func start_game(lifes: int, score: int):
	$Score.show()
	$Lifes.show()
	$Center.hide()
	$Lifes.text = "Lifes %d" % lifes
	$Score.text = "Score: %d" % score


func update_score(score: int):
	$Score.text = "Score: %d" % score


func won(score: int):
	$Lifes.hide()
	$Score.hide()
	$Center.text = "YOU WON! SCORED: %d\nPress Up or Down to select level" % score
	$Center.show()
