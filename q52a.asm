.include "/home/pi/m328Pdef.inc"

;identifying output files 2,3,4,5
	ldi r16, 0b00111100
	out DDRD, r16

	ldi r31, 0b00000001
	ldi r16, 0b00000000		;initializing W
	ldi r17, 0b00000001		;initializing X
	ldi r18, 0b00000000		;initializing Y
	ldi r19, 0b00000001		;initializing Z

;For finding A	
	mov r1, r16				;W
;	mov r2, r17				;X	
;	mov r3, r18				;Y
;	mov r4, r19				;Z
	
	
	eor r1, r31				;W'			this is A
;	eor r2, r31				;X'
;	eor r3, r31				;Y'
;	eor r4, r31				;Z'
	
	
;following code is for displaying the output
;shifting LSB in r1 to 2nd position

	ldi r20, 0b00000010		;counter = 2
	
	rcall loopw				;calling loopw routine
	
	out PORTD, r1			;writing output to pins 2,3,4,5
	
Start:
	rjmp Start
	
	
;loop for bit shifting
loopw: lsl r1				;left shift
	dec r20					;counter --
	brne loopw 				;if counter!=0
	ret

