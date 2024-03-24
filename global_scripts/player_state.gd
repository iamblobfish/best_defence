extends Node
var currency: int = 1000
var game_history = {}
signal out_of_money

signal on_currency_amount_changed


# TODO: thing about thread safe state change
func reduce_currency(amount: int):
	if currency < amount:
		out_of_money.emit()
		return false
	currency -= amount
	on_currency_amount_changed.emit()
	return true

func add_currency(amount: int):
	currency += amount
	on_currency_amount_changed.emit()
