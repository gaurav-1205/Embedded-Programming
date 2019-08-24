.include "/mnt/AE946185946150BF/College/Embedded programming/laptop/m328Pdef.inc"
;works as 1 second on arduino: 16MHz

	sbi DDRB, 5			;set pin 13 as output(DDRB pin 5)
	ldi r16, 0b00000101	;the last 3 bits define the prescalar, 101 => division by 1024
	out TCCR0B, R16		;prescalar used is 1024... so new frequency of clock cycle is 16MHz/1024 = 16KHz
	
	clr r18				;output bits...we are only interested in bit 6 from the right
	
	ldi r20, 0b00100000	;initializing
	
loop:
	eor r18, r20		;change the output of the LED
	out PORTB, r18
	ldi r19, 0b00100000	;times to run the loop = 64 for 1 second delay
	rcall PAUSE			;call the PAUSE label
	rjmp loop
	
PAUSE: 					;this is the delay (function)

lp2:					;loop runs 64 times
	IN r16, TIFR0		;the tifr is the timer interrupt flag(8bit timer runs 256 times)
	ldi r17, 0b00000010
	AND r16, r17 		;need 2nd bit
	BREQ PAUSE
	OUT TIFR0, r17		;set tifr flag high
	dec r19
	brne lp2
	ret
	
	
;prescalar * loop_iterations * timer_duration = 16 million cycles
;16MHz = 16 million cycles in 1 second

	
