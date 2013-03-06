START:		
			; Acquisition BP
			LDA BP			;2	BT+:1111 1110	BT-:1111 1101	BTok:1111 1011
			ADD ONE			;1	BT+:1111 1111	BT-:1111 1110	BTok:1111 1100
			JCC BPDETECT	;1	saut si un BP appuyé
			JCC START		;1	on recommence
							
BPDETECT:	
			NOT				;1	BT+:0000 0000	BT-:0000 0001	BTok:0000 0011
			ADD ALLONE		;1	BT+:1111 1111	BT-:0000 0000C	BTok:0000 0010C
			JCC BT_NEXT		;1	BT+: JUMP		BT-:0000 0000	BTok:0000 0010
			ADD ALLONE		;1					BT-:1111 1111	BTok:0000 0001C
			JCC BT_PREV		;1					BT-: JUMP		BTok:0000 0001
			JCC BT_VAL		;1 									BTok: JUMP
			
BT_VAL:		
			LDA POS			;2	chargement de la position
			STA AFF_POSVAL	;1	envoi vers Affichage
			LDA JOUEUR		;2	chargement du joueur
			STA AFF_J		;1	envoi vers Affichage		
			NOT				;1	changement de joueur
			STA JOUEUR		;1	sauvegarde du nouveau joueur
			JCC START		;1	retour
									
BT_NEXT:		
			LDA POS			;2	ACCU: 0000 0010		ACCU: 0000 1000
			ADD ONE			;1	ACCU: 0000 0011		ACCU: 0000 1001
			STA POS			;1	POS=ACCU			POS=ACCU
			ADD VAL_247		;1	ACCU: 1111 1010		ACCU: 0000 0000C
			JCC SENDPOS		;1	JUMP				ACCU: 0000 0000	
			STA POS			;1  					POS=ACCU
			JCC SENDPOS		;1						JUMP

BT_PREV:		
			LDA ALLONE		;2	1111 1111		1111 1111
			ADD ONE			;1	0000 0000C		0000 0000C
			LDA POS			;2	0000 0011C		0000 0000C
			ADD ALLONE		;1	0000 0010C		1111 1111C
			JCC START		;1	0000 0010		1111 1111
			STA POS			;1	POS=ACCU		POS=ACCU
			ADD ONE			;1	0000 0011		0000 0000C
			JCC SENDPOS		;1	JUMP			0000 0000
			ADD VAL_8		;1					0000 1000
			STA POS			;1					POS=ACCU
			JCC SENDPOS		;1					JUMP
			
SENDPOS:	
			LDA POS			;1	chargement de la nouvelle position
			STA AFF_POSMOD	;1	envoi sur le périphérique jeu
			JCC START		;1	retour au début

; données mémoire

; ALLONE	= 1111 1111
; ZERO		= 0000 0000
; ONE		= 0000 0001
; VAL_247	= 1111 0111
; VAL_8		= 0000 1000
; POS		= 0000 0000
; JOUEUR	= 0000 0000
			
; 39 instructions + 7 données = 46 octets
			
			
