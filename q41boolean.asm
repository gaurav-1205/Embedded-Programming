;logical and, or and XOR operations
;output displayed using 7447IC
.include "/home/pi/m328Pdef.inc"

;identifying output pins 2, 3, 4, 5 and declaring the pins as output
	ldi r16, 0b00111100
	out DDRD, r16

	ldi r16, 0b00000000		;initializing W
	ldi r17, 0b00000001		;initializing X
	
;logical AND
	;and r16, r17	;W and X
	
;logical OR
	or r16, r17		;W or X
	
;logical XOR
	;eor r16, r17	;W xor X
	
	
;following code is for displaying the output
;shifting LSB in r16 to 2nd position

	ldi r20, 0b00000010		;counter = 2
	
	rcall loopw				;calling loopw routine
	
	out PORTD, r16			;writing output to pins 2,3,4,5
	
Start:
	rjmp Start
	
	
;loop for bit shifting
loopw: lsl r16				;left shift
	dec r20					;counter --
	brne loopw 				;if counter!=0
	ret

	
