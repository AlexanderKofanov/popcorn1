if !mouse_check_button(mb_left)
	pressed = false
if on
	pressed = true
if pressed if p > 0
	p -= 2
if !pressed if p < 8
	p += 2
