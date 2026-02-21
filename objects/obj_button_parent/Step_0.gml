if !mouse_check_button(mb_left)
	pressed = false
	
if pressed if scale > 0.6
	scale -= 0.1
	
if !pressed if scale < 1
	scale += 0.1
