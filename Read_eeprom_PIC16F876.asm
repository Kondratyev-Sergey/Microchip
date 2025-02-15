;*******************************;*******************************
; Read from PIC16F876 eeprom. Arguments: eeprom_address - address to eeprom, 
; W - data from eeprom.
;-------------------------------
read_eeprom:
;-------------------------------
	MOVF 	eeprom_address,w; Write address
;-------------------------------
	BCF 	STATUS, RP0 	;
	BSF 	STATUS, RP1 	; Bank 2
;-------------------------------
	MOVWF 	EEADR 		; to read from
;-------------------------------
	BSF 	STATUS, RP0 	; Bank 3
	BCF 	EECON1, EEPGD 	; Point to Data memory
	BSF 	EECON1, RD 	; Start read operation
;-------------------------------
	BCF 	STATUS, RP0 	; Bank 2
	MOVF 	EEDATA, W 	; W = EEDATA
;-------------------------------
	BCF 	STATUS, RP0 	;
	BCF 	STATUS, RP1 	; Bank 0
;-------------------------------
	return
