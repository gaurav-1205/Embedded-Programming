.include "/mnt/AE946185946150BF/College/Embedded programming/laptop/m328Pdef.inc"
sbi DDRB, 5			;set pin 13 as output(DDRB pin 5)
ldi r16, 0b11111100 ;identifying output pins 2 3 4 5
out DDRD, r16 ;declaring pins as output

ldi r17, 0b00000011 
out DDRB, r17 ;declaring pins as output

ldi r28,0b00000101  ;the last 3 bits define the pre-scaler, 101 => division by 1024

out TCCR0B, r28 ;pre-scaler used = 1024. So new freq. of clock cycle = 16MHz/1024 =  16KHz

;clr r13 ;output bits. we are only interested in bit 6 from the right


;these are the intial values
ldi r16, 0b00000000 ;Z=0
ldi r17, 0b00000000 ;Y=1
ldi r18, 0b00000000 ;X=1
ldi r19, 0b00000000 ;W=0

ldi r30,0b00000001 ;Used for XOR operation


loop: 

     mov r1,r19
     eor r1,r30 ;W' is stored in r1 ----------
     mov r24,r1 ;W' stored in r24

     mov r26,r1 ;A= stored in r26!!!!!!!!!!!!!!!!!!


     ;finding B=WX'Z'+W'X

     and r1,r18 ; W'X stored in r1

     mov r2,r18
     eor r2,r30 ; X' stored in r2 ----------

     mov r3,r16
     eor r3,r30 ; Z' stored in r3 ----------

     mov r6,r2 ;Copy X' to r6
     and r6,r3 ; X'Z' stored in r6

     and r6,r19 ;WX'Z' stored in r6

     or r6,r1 ; B stored in r6!!!!!!!!!!!!!! 

     ;finding C = WXY' + X'Y + W'Y

     mov r8,r17 ;copying Y to r8
     and r8,r1 ; W'Y stored in r8

     mov r9,r17
     and r9,r2 ; X'Y stored in r9

     mov r7,r17
     eor r7,r30 ; Y' stored in r7 ------------

     mov r10,r19; Copying W to r10
     and r10,r18; WX stored in r10
     and r10,r7 ;WXY' stored in r10

     or r10,r9
     or r10,r8; C is stored in r10!!!!!!!!!!!!!!!!

     ; Finding D = WXY+W'Z

     ; now i'll overwrite r8,r9

     mov r8,r24 ;W' stored in r8
     and r8,r16 ;W'Z stored in r8

     mov r9,r19 ;W stored in r9
     and r9,r17
     and r9,r18 ;WXY stored in r9

     mov r11,r9
     or r11,r8 ; D is stored in r11!!!!!!!!!!!!!!!

     ;Now, since the number we want is DCBA and the output is from pins 0-1,  we left shift A by 0 , B by 1, C by 2 and D by 3
     ;Then we make DCBA by using or operator on the left shifted values of A B C D

     mov r16,r26
     mov r17,r6
     mov r18,r10
     mov r19,r11


     ;now  bit shifting

     lsl r26
     lsl r26
     ;For B
     lsl r6
     lsl r6
     lsl r6
   
     ;For C
     lsl r10
     lsl r10
     lsl r10
     lsl r10
     
     ;For D
     lsl r11
     lsl r11
     lsl r11
     lsl r11
     lsl r11
     
	ldi r21, 0b00000000
     or r21,r26; Left shifted A is stored in r15,
     or r21,r6 ; AB(whole left shifted) stored in r15
     or r21,r10; ABC stored in r15
     or r21,r11; DCBA stored in r15 in that order  (since DCBA = A OR B OR C OR D, where ABCD are left shifted by 0,1,2,3 respectively)

     out PORTD, r21 ;writing output to ports

     ldi r25, 0b01000000 ;times to run the loop = 64 for 1 second delay
     rcall PAUSE ; call the pause label
     rjmp loop
     
PAUSE: ;this is the delay function

lp2:  ;loop runs 64 times
    
    IN r23,TIFR0 ;tifr is timer interupt flag(8 bit timer runs 256 times)
    ldi r29,0b00000010
    and r23,r29;need second bit
    BREQ PAUSE
    OUT TIFR0, r29 ;set tifr flag high
    
    dec r25
    brne lp2
    ret

