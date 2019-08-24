;using the 7447 decoder
.include "/home/pi/m328Pdef.inc"

;identifying output files 2,3,4,5
	ldi r16, 0b00111100
	out DDRD, r16
	
;declaring pin as output
;loading the number 5 in binary
	ldi r16, 0b00100000
	out PortD, r16
	

Start:
	rjmp Start
