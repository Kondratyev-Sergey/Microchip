;*******************************;*******************************
; Converting 1 byte hex to 3 bytes ASCII bcd; input-hex_low, output-dec_hundreds,dec_tens,dec_ones for 3 dec ASCII
;-------------------------------
; Check hundred's
;*******************************
hex1_to_dec3:
;-------------------------------
	clrf	dec_hundreds
	clrf	dec_tens
	clrf	dec_ones
;-------------------------------
next_hunds:
;-------------------------------
	movlw	D'100'		;take 100 (64 hex)
	subwf	hex_low,w	;time3-100, result in W
	btfss	STATUS,C	;result=-x?
;-------------------------------
	goto	next_tens	;goto tens
;-------------------------------
	incf	dec_hundreds,f	;increment hundred's
	movwf	hex_low		;save rest
;-------------------------------
	goto	next_hunds
;----------------------------------------------------
; Check ten's
;----------------------------------------------------
next_tens:
;-------------------------------
	movlw	D'10'		;take 10 (0A hex)
	subwf	hex_low,w	;time3-10, result in W
	btfss	STATUS,C	;result=-x?
;-------------------------------
	goto	next_ones	;goto one's
;-------------------------------
	incf	dec_tens,f	;increment ten's
	movwf	hex_low		;save rest
;-------------------------------
	goto	next_tens
;----------------------------------------------------
; Save one's
;----------------------------------------------------
next_ones:
;-------------------------------
	movf	hex_low,w	;take rest
	movwf	dec_ones	;save dec_ones
;-------------------------------
; Add ASCII "3" (07=37)
;-------------------------------
	bsf	dec_hundreds,5	;set 1
	bsf	dec_hundreds,4	;set 1 3x
	bsf	dec_tens,5	;set 1
	bsf	dec_tens,4	;set 1 3x
	bsf	dec_ones,5	;set 1
	bsf	dec_ones,4	;set 1 3x
;-------------------------------
	return