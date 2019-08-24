.include "/mnt/AE946185946150BF/College/Embedded programming/laptop/m328Pdef.inc"

;identifying output files 2,3,4,5
	ldi r16, 0b00111100
	out DDRD, r16

	ldi r31, 0b00000001
	ldi r16, 0b00000000		;initializing W
	ldi r17, 0b00000000		;initializing X
	ldi r18, 0b00000000		;initializing Y
	ldi r19, 0b00000001		;initializing Z
	
	;for finding D
	mov r1, r16				;W
	mov r2, r17				;X	
	mov r3, r18				;Y
	mov r4, r19				;Z
	
	
	mov r5, r16				;W
	mov r6, r17				;X	
	mov r7, r18				;Y
	mov r8, r19				;Z
	
	
	eor r1, r31				;W'			
	eor r2, r31				;X'
	eor r3, r31				;Y'
	eor r4, r31				;Z'
	
	and r5, r6
	and r5, r7
	
	and r8, r1
	or r5, r8				;WXY + W'Z			this is D
	
	
	
	
	
	
;following code is for displaying the output
;shifting LSB in r5 to 2nd position

	ldi r20, 0b00000010		;counter = 2
	
	rcall loopw				;calling loopw routine
	
	out PORTD, r5			;writing output to pins 2,3,4,5
	
Start:
	rjmp Start
	
	
;loop for bit shifting
loopw: lsl r5				;left shift
	dec r20					;counter --
	brne loopw 				;if counter!=0
	ret


	
