;program to find the complement of a given number
.include "/home/pi/m328Pdef.inc"
	
	ldi r16, 0b00111100		;identifying output pins 2, 3, 4, 5
	out DDRD, r16			;declaring the pins as output
	
	ldi r16, 0b00000000		
	
	rcall comp				;jumping to comp routine below
	
;following code is for displaying output
;shifting LSB in r16 to 2nd position	;0b00000001
	ldi r20, 0b00000010			;counter = 2
	
	rcall loopw					;calling the loopw routine
	
	out PORTD, r16				;writing the output to pins 2,3,4,5
	
	
Start:
	rjmp Start
	
	
;loop for bit shifting
loopw:
	lsl r16					;left shift
	dec r20					;counter--
	brne loopw				;if counter!=0
	ret
	
;The comp routine
comp:
	mov r0, r16				;using r0 for computations
	ldi r16, 0b00000001		;loading 1
	eor r16, r0				;computing the xor
	ret
	
	

	

