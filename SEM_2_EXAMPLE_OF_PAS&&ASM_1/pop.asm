    .686
    .model flat
    .data
    
    .code
    
    EXTRN	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD: NEAR
	EXTRN	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE: NEAR
	EXTRN	BIT_$$_UNSET_BIT$LONGWORD$BYTE: NEAR
	EXTRN	BIT_$$_SET_BIT$LONGWORD$BYTE: NEAR
    
    
    public SINGLE
    public DOUBLE
    public UNIVERSAL 
    public UNIFORM 
    public SORTT 
    public RANDOM
    public SWAPP
    public REVERSE 

SINGLE proc
; Temps allocated between ebp-20 and ebp+0
; [82] begin
		push	ebp
		mov	ebp,esp
		sub	esp,20
		push	ebx
		push	esi
		push	edi
; Var ent1 located in register eax
; Var ent2 located in register eax
; Var child1 located in register edi
; Var child2 located in register esi
; Var trail located in register al
; Var i located in register bl
; Var bit1 located in register al
; Var bit2 located in register al
		mov	eax,dword ptr [ebp+8]
		mov	dword ptr [ebp-20],eax
		mov	eax,dword ptr [ebp+12]
		mov	dword ptr [ebp-16],eax
		mov	edi,dword ptr [ebp+16]
		mov	esi,dword ptr [ebp+20]
; [83] trail := my_random(31);
		mov	eax,31
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
; Var trail located in register al
; [84] for i := 0 to trail - 1 do
		movzx	eax,al
		dec	eax
		mov	byte ptr [ebp-12],al
; Var i located in register bl
		mov	bl,0
		cmp	byte ptr [ebp-12],bl
		jb	@@j135
		dec	bl
@@j136:
		inc	bl
; [86] bit1 := Get_bit(ent1, 31 - i);
		movzx	edx,bl
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,dword ptr [ebp-20]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-8],al
; [87] bit2 := Get_bit(ent2, 31 - i);
		movzx	edx,bl
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,dword ptr [ebp-16]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-4],al
; [88] if bit1 = 1
		cmp	byte ptr [ebp-8],1
		jne	@@j150
; [89] then Set_bit(child2, 31 - i)
		movzx	edx,bl
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j155
@@j150:
; [90] else Unset_bit(child2, 31 - i);
		movzx	edx,bl
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j155:
; [91] if bit2 = 1
		cmp	byte ptr [ebp-4],1
		jne	@@j161
; [92] then Set_bit(child1, 31 - i)
		movzx	edx,bl
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j166
@@j161:
; [93] else Unset_bit(child1, 31 - i);
		movzx	edx,bl
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j166:
		cmp	byte ptr [ebp-12],bl
		ja	@@j136
@@j135:
; [95] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	16
SINGLE endp

DOUBLE proc
; Temps allocated between ebp-24 and ebp+0
; [101] begin
		push	ebp
		mov	ebp,esp
		sub	esp,24
		push	ebx
		push	esi
		push	edi
; Var ent1 located in register eax
; Var ent2 located in register eax
; Var child1 located in register edi
; Var child2 located in register esi
; Var trail_start located in register al
; Var trail_size located in register al
; Var i located in register bl
; Var bit1 located in register al
; Var bit2 located in register al
		mov	eax,dword ptr [ebp+8]
		mov	dword ptr [ebp-24],eax
		mov	eax,dword ptr [ebp+12]
		mov	dword ptr [ebp-20],eax
		mov	edi,dword ptr [ebp+16]
		mov	esi,dword ptr [ebp+20]
; [102] trail_start := my_random(31);
		mov	eax,31
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
; Var trail_start located in register al
		mov	byte ptr [ebp-16],al
; [103] trail_size := my_random(31 - trail_start);
		movzx	edx,byte ptr [ebp-16]
		mov	eax,31
		sub	eax,edx
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
; Var trail_size located in register al
; Var trail_size located in register al
; [104] for i := 0 to trail_size do
		mov	byte ptr [ebp-12],al
; Var i located in register bl
		mov	bl,0
		cmp	byte ptr [ebp-12],bl
		jb	@@j184
		dec	bl
@@j185:
		inc	bl
; [106] bit1 := Get_bit(ent1, 31 - (i + trail_start));
		movzx	eax,bl
		movzx	edx,byte ptr [ebp-16]
		lea	edx,dword ptr [eax+edx]
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,dword ptr [ebp-24]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-8],al
; [107] bit2 := Get_bit(ent2, 31 - (i + trail_start));
		movzx	eax,bl
		movzx	edx,byte ptr [ebp-16]
		lea	edx,dword ptr [eax+edx]
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,dword ptr [ebp-20]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-4],al
; [108] if bit1 = 1
		cmp	byte ptr [ebp-8],1
		jne	@@j199
; [109] then Set_bit(child2, 31 - (i + trail_start))
		movzx	eax,bl
		movzx	edx,byte ptr [ebp-16]
		lea	edx,dword ptr [eax+edx]
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j204
@@j199:
; [110] else Unset_bit(child2, 31 - (i + trail_start));
		movzx	eax,bl
		movzx	edx,byte ptr [ebp-16]
		lea	edx,dword ptr [eax+edx]
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j204:
; [111] if bit2 = 1
		cmp	byte ptr [ebp-4],1
		jne	@@j210
; [112] then  Set_bit(child1, 31 - (i + trail_start))
		movzx	eax,bl
		movzx	edx,byte ptr [ebp-16]
		lea	edx,dword ptr [eax+edx]
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j215
@@j210:
; [113] else  Unset_bit(child1, 31 - (i + trail_start));
		movzx	eax,bl
		movzx	edx,byte ptr [ebp-16]
		lea	edx,dword ptr [eax+edx]
		mov	eax,31
		sub	eax,edx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j215:
		cmp	byte ptr [ebp-12],bl
		ja	@@j185
@@j184:
; [115] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	16
DOUBLE endp

UNIVERSAL proc
; Temps allocated between ebp-8 and ebp+0
; [121] begin
		push	ebp
		mov	ebp,esp
		sub	esp,8
		push	ebx
		push	esi
		push	edi
; Var ent1 located in register eax
; Var ent2 located in register eax
; Var child1 located in register edi
; Var child2 located in register esi
; Var i located in register ebx
		mov	eax,dword ptr [ebp+8]
		mov	dword ptr [ebp-8],eax
		mov	eax,dword ptr [ebp+12]
		mov	dword ptr [ebp-4],eax
		mov	edi,dword ptr [ebp+16]
		mov	esi,dword ptr [ebp+20]
; Var i located in register ebx
; [122] for i := 0 to 31 do
		mov	ebx,0
		dec	ebx
@@j224:
		inc	ebx
; [124] if my_random(2) = 1 then
		mov	eax,2
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
		cmp	eax,1
		jne	@@j226
; [126] if Get_bit(ent1, 31 - i) = 1
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,dword ptr [ebp-8]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j230
; [127] then Set_bit(child1, 31 - i)
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j244
@@j230:
; [128] else Unset_bit(child1, 31 - i);
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
		jmp	@@j244
@@j226:
; [130] if Get_bit(ent2, 31 - i) = 1
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,dword ptr [ebp-4]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j246
; [131] then Set_bit(child2, 31 - i)
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j255
@@j246:
; [132] else Unset_bit(child2, 31 - i);
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j255:
@@j244:
		cmp	ebx,31
		jl	@@j224
; Var i located in register ebx
; [135] for i := 0 to 31 do
		mov	ebx,0
		dec	ebx
@@j262:
		inc	ebx
; [137] if my_random(2) = 1 then
		mov	eax,2
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
		cmp	eax,1
		jne	@@j264
; [139] if Get_bit(ent1, 31 - i) = 1
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,dword ptr [ebp-8]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j268
; [140] then Set_bit(child1, 31 - i)
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j282
@@j268:
; [141] else Unset_bit(child1, 31 - i);
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
		jmp	@@j282
@@j264:
; [143] if Get_bit(ent2, 31 - i) = 1
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,dword ptr [ebp-4]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j284
; [144] then Set_bit(child2, 31 - i)
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j293
@@j284:
; [145] else Unset_bit(child2, 31 - i);
		mov	eax,31
		sub	eax,ebx
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j293:
@@j282:
		cmp	ebx,31
		jl	@@j262
; [148] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	16
UNIVERSAL endp

UNIFORM proc
; Temps allocated between ebp-12 and ebp+0
; [155] begin
		push	ebp
		mov	ebp,esp
		sub	esp,12
		push	ebx
		push	esi
		push	edi
; Var ent1 located in register eax
; Var ent2 located in register eax
; Var child1 located in register eax
; Var child2 located in register edi
; Var mask located in register esi
; Var i located in register ebx
		mov	eax,dword ptr [ebp+8]
		mov	dword ptr [ebp-12],eax
		mov	eax,dword ptr [ebp+12]
		mov	dword ptr [ebp-8],eax
		mov	eax,dword ptr [ebp+16]
		mov	dword ptr [ebp-4],eax
		mov	edi,dword ptr [ebp+20]
; [156] mask := my_random(high(longword));
		mov	eax,-1
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
; Var mask located in register esi
		mov	esi,eax
; Var i located in register ebx
; [157] for i := 0 to 31 do
		mov	ebx,0
		dec	ebx
@@j306:
		inc	ebx
; [159] if Get_bit(mask, i) = 0 then
		mov	dl,bl
		mov	eax,esi
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		test	al,al
		jne	@@j308
; [160] if Get_bit(ent1, i) = 1
		mov	dl,bl
		mov	eax,dword ptr [ebp-12]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j314
; [161] then Set_bit(child1, i)
		mov	dl,bl
		mov	eax,dword ptr [ebp-4]
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j328
@@j314:
; [162] else Unset_bit(child1, i)
		mov	dl,bl
		mov	eax,dword ptr [ebp-4]
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
		jmp	@@j328
@@j308:
; [164] if Get_bit(ent2, i) = 1
		mov	dl,bl
		mov	eax,dword ptr [ebp-8]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j330
; [165] then Set_bit(child2, i)
		mov	dl,bl
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j339
@@j330:
; [166] else Unset_bit(child2, i);
		mov	dl,bl
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j339:
@@j328:
		cmp	ebx,31
		jl	@@j306
; Var i located in register ebx
; [168] for i := 0 to 31 do
		mov	ebx,0
		dec	ebx
@@j346:
		inc	ebx
; [170] if Get_bit(mask, i) = 0 then
		mov	dl,bl
		mov	eax,esi
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		test	al,al
		jne	@@j348
; [171] if Get_bit(ent1, i) = 1
		mov	dl,bl
		mov	eax,dword ptr [ebp-12]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j354
; [172] then Get_bit(child1, i)
		mov	dl,bl
		mov	ecx,dword ptr [ebp-4]
		mov	eax,dword ptr [ecx]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		jmp	@@j368
@@j354:
; [173] else Unset_bit(child1, i)
		mov	dl,bl
		mov	eax,dword ptr [ebp-4]
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
		jmp	@@j368
@@j348:
; [175] if Get_bit(ent2, i) = 1
		mov	dl,bl
		mov	eax,dword ptr [ebp-8]
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j370
; [176] then Set_bit(child2, i)
		mov	dl,bl
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j379
@@j370:
; [177] else Unset_bit(child2, i);
		mov	dl,bl
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j379:
@@j368:
		cmp	ebx,31
		jl	@@j346
; [179] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret 16
UNIFORM endp		

RANDOM proc
		push	ebp
		mov	ebp,esp
		push	ebx
		push	esi
		push	edi
; Var ent located in register edi
; Var ent1 located in register esi
; Var pos located in register bl
		mov	eax,dword ptr [ebp+8]
		mov	esi,dword ptr [ebp+12]
; [22] ent1 := ent;
		mov	edi,eax
; Var ent located in register edi
		mov	dword ptr [esi],edi
; [23] pos := my_random(31);
		mov	eax,31
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
; Var pos located in register bl
		mov	bl,al
; [24] if Get_bit(ent, pos) = 1
		mov	dl,bl
		mov	eax,edi
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		cmp	al,1
		jne	@@j12
; [25] then Unset_bit(ent1, pos)
		mov	eax,esi
		mov	dl,bl
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
		jmp	@@j21
@@j12:
; [26] else Set_bit(ent1, pos);
		mov	eax,esi
		mov	dl,bl
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
@@j21:
; [27] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	8
RANDOM endp

SWAPP proc
; Temps allocated between ebp-20 and ebp+0
; [33] begin
		push	ebp
		mov	ebp,esp
		sub	esp,20
		push	ebx
		push	esi
; Var ent located in register ebx
; Var ent1 located in register esi
; Var pos1 located in register al
; Var pos2 located in register al
; Var bit1 located in register al
; Var bit2 located in register al
; Var flag located in register al
		mov	ebx,dword ptr [ebp+8]
		mov	esi,dword ptr [ebp+12]
; Var flag located in register al
; [34] flag := true;
		mov	byte ptr [ebp-20],1
; [35] while flag do
		jmp	@@j31
@@j30:
; [37] ent1 := ent;
		mov	dword ptr [esi],ebx
@@j35:
; [39] pos1 := my_random(31);
		mov	eax,31
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
		mov	byte ptr [ebp-8],al
; [40] pos2 := my_random(31);
		mov	eax,31
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
		mov	byte ptr [ebp-4],al
; [41] until pos1 <> pos2;
		cmp	byte ptr [ebp-8],al
		je	@@j35
; [42] bit1 := Get_bit(ent, pos1);
		mov	dl,byte ptr [ebp-8]
		mov	eax,ebx
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-12],al
; [43] bit2 := Get_bit(ent, pos2);
		mov	dl,byte ptr [ebp-4]
		mov	eax,ebx
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-16],al
; [44] if bit1 <> bit2 then
		cmp	byte ptr [ebp-12],al
		je	@@j59
; [46] flag := false;
		mov	byte ptr [ebp-20],0
; [47] if bit1 = 1 then
		cmp	byte ptr [ebp-12],1
		jne	@@j63
; [49] Unset_bit(ent1, pos1);
		mov	eax,esi
		mov	dl,byte ptr [ebp-8]
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
; [50] Set_bit(ent1, pos2);
		mov	eax,esi
		mov	dl,byte ptr [ebp-4]
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j72
@@j63:
; [52] Set_bit(ent1, pos1);
		mov	eax,esi
		mov	dl,byte ptr [ebp-8]
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
; [53] Unset_bit(ent1, pos2);
		mov	eax,esi
		mov	dl,byte ptr [ebp-4]
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j72:
@@j59:
@@j31:
		mov	al,byte ptr [ebp-20]
		test	al,al
		jne	@@j30
@@j32:
; [57] end;
		pop	esi
		pop	ebx
		leave
		ret	8
SWAPP endp

REVERSE endp
; Temps allocated between ebp-12 and ebp+0
; [62] begin
		push	ebp
		mov	ebp,esp
		sub	esp,12
		push	ebx
		push	esi
		push	edi
; Var ent located in register esi
; Var ent1 located in register edi
; Var bit1 located in register al
; Var bit2 located in register al
; Var i located in register bl
; Var pos located in register al
		mov	eax,dword ptr [ebp+8]
		mov	edi,dword ptr [ebp+12]
; [63] ent1 := ent;
		mov	esi,eax
; Var ent located in register esi
		mov	dword ptr [edi],esi
; [64] pos := my_random(31);
		mov	eax,31
		call	BIT_$$_MY_RANDOM$LONGWORD$$LONGWORD
; Var pos located in register al
		mov	byte ptr [ebp-12],al
; [65] for i := ((pos + 31) shr 1) + 1 to 31 do
		movzx	eax,byte ptr [ebp-12]
		add	eax,31
		shr	eax,1
		inc	eax
; Var i located in register bl
		mov	bl,al
		cmp	bl,31
		ja	@@j90
		dec	bl
@@j91:
		inc	bl
; [67] bit1 := Get_bit(ent, i);
		mov	dl,bl
		mov	eax,esi
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-8],al
; [68] bit2 := Get_bit(ent, 31 - i +  + pos);
		movzx	edx,bl
		mov	eax,31
		mov	ecx,eax
		sub	ecx,edx
		movzx	eax,byte ptr [ebp-12]
		lea	eax,dword ptr [ecx+eax]
		mov	dl,al
		mov	eax,esi
		call	BIT_$$_GET_BIT$LONGWORD$BYTE$$BYTE
		mov	byte ptr [ebp-4],al
; [69] if bit1 = 1
		cmp	byte ptr [ebp-8],1
		jne	@@j105
; [70] then Set_bit(ent1, 31 - i + pos)
		movzx	edx,bl
		mov	eax,31
		mov	ecx,eax
		sub	ecx,edx
		movzx	eax,byte ptr [ebp-12]
		lea	eax,dword ptr [ecx+eax]
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j110
@@j105:
; [71] else Unset_bit(ent1, 31 - i + pos);
		movzx	edx,bl
		mov	eax,31
		mov	ecx,eax
		sub	ecx,edx
		movzx	eax,byte ptr [ebp-12]
		lea	eax,dword ptr [ecx+eax]
		mov	dl,al
		mov	eax,edi
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j110:
; [72] if bit2 = 1
		cmp	byte ptr [ebp-4],1
		jne	@@j116
; [73] then Set_bit(ent1, i)
		mov	eax,edi
		mov	dl,bl
		call	BIT_$$_SET_BIT$LONGWORD$BYTE
		jmp	@@j121
@@j116:
; [74] else Unset_bit(ent1, i);
		mov	eax,edi
		mov	dl,bl
		call	BIT_$$_UNSET_BIT$LONGWORD$BYTE
@@j121:
		cmp	bl,31
		jb	@@j91
@@j90:
; [76] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	8
REVERSE endp
		    
SORTT proc 
;begin
		push	ebp
		mov	ebp,esp
		sub	esp,52
		push	ebx
		push	esi
		push	edi
; Var cur_gen located in register eax
; Var i located in register eax
; Var j located in register ebx
; Var m located in register edx
; Var temp located at ebp-40, size=OS_NO
		mov	edx,dword ptr [ebp+8]
		mov	dword ptr [ebp-52],edx
; [186] for i := 0 to cur_gen.len - 1 do
		mov	eax,dword ptr [edx+4]
		dec	eax
		mov	dword ptr [ebp-48],eax
; Var i located in register eax
		mov	dword ptr [ebp-44],0
		mov	eax,dword ptr [ebp-48]
		cmp	eax,dword ptr [ebp-44]
		jl	@@j389
		dec	dword ptr [ebp-44]
@@j390:
		inc	dword ptr [ebp-44]
; [188] m := i;
		mov	edx,dword ptr [ebp-44]
; [189] for j := i + 1 to cur_gen.len - 1 do
		mov	ecx,dword ptr [ebp-52]
		mov	eax,dword ptr [ecx+4]
		dec	eax
		mov	ecx,eax
		mov	eax,dword ptr [ebp-44]
		lea	esi,dword ptr [eax+1]
		mov	ebx,esi
		cmp	ecx,ebx
		jl	@@j396
		dec	ebx
@@j397:
		inc	ebx
		mov	eax,dword ptr [ebp-52]
		mov	esi,dword ptr [eax]
; [190] if cur_gen.population[j].fit > cur_gen.population[m].fit
		imul	edi,ebx,40
		imul	eax,edx,40
		fld	qword ptr [esi+eax+16]
		fld	qword ptr [esi+edi+16]
		fcompp
		fnstsw	ax
		sahf
		jp	@@j399
		jna	@@j399
; [191] then m := j;
		mov	edx,ebx
@@j399:
		cmp	ecx,ebx
		jg	@@j397
@@j396:
; [192] temp := cur_gen.population[m];
		mov	eax,dword ptr [ebp-52]
		mov	ecx,dword ptr [eax]
		imul	eax,edx,40
		lea	edi,dword ptr [ebp-40]
		lea	esi,dword ptr [ecx+eax]
		mov	ecx,40
		rep	movsb
; [193] cur_gen.population[m] := cur_gen.population[i];
		mov	eax,dword ptr [ebp-52]
		mov	ecx,dword ptr [eax]
		imul	edi,edx,40
		mov	esi,dword ptr [ebp-52]
		mov	eax,dword ptr [esi]
		imul	esi,dword ptr [ebp-44],40
		lea	edi,dword ptr [ecx+edi]
		lea	esi,dword ptr [eax+esi]
		mov	ecx,40
		rep	movsb
; [194] cur_gen.population[i] := temp;
		mov	eax,dword ptr [ebp-52]
		mov	ecx,dword ptr [eax]
		imul	eax,dword ptr [ebp-44],40
		lea	edi,dword ptr [ecx+eax]
		lea	esi,dword ptr [ebp-40]
		mov	ecx,40
		rep	movsb
		mov	eax,dword ptr [ebp-48]
		cmp	eax,dword ptr [ebp-44]
		jg	@@j390
@@j389:
; [196] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	4
SORTT endp
end
