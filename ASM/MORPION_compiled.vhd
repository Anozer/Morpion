-- START
0 => x"2B",		-- LDA BP (1)
1 => x"78",		-- LDA BP (2)
2 => x"6D",		-- ADD ONE
3 => x"C5",		-- JCC BPDETECT
4 => x"C0", 	-- JCC START
-- BP DETECT
5 => x"2C",		-- NOT
6 => x"6B",		-- ADD ALLONE
7 => x"D4",		-- JCC BT_NEXT
8 => x"6B",		-- ADD ALLONE
9 => x"DC",		-- JCC BT_PREV
10 => x"CB",	-- JCC BT_OK
-- BT_OK
11 => x"2B",	-- LDA POS (1)
12 => x"70",	-- LDA POS (2)
13 => x"BB",	-- STA AFF_OK
14 => x"2B",	-- LDA JOUEUR (1)
15 => x"71",	-- LDA JOUEUR (2)
16 => x"2C",	-- NOT
17 => x"B1",	-- STA JOUEUR
18 => x"B9",	-- STA AFF_J
19 => x"C0",	-- JCC START
-- BT NEXT
20 => x"2B",	-- LDA POS (1)
21 => x"70",	-- LDA POS (2)
22 => x"6D",	-- ADD ONE
23 => x"B0",	-- STA POS
24 => x"6E",	-- ADD VAL_247
25 => x"E7",	-- JCC SENDPOS 
26 => x"B0",	-- STA POS
27 => x"E7",	-- JCC SENDPOS
-- BT_PREV 
28 => x"6D",	-- ADD ONE
29 => x"2B",	-- LDA POS (1)
30 => x"70",	-- LDA POS (2)
31 => x"6B",	-- ADD ALLONE
32 => x"C0",	-- JCC START
33 => x"B0",	-- STA POS
34 => x"6D",	-- ADD ONE
35 => x"E7",	-- JCC SENDPOS
36 => x"6F",	-- ADD VAL_8
37 => x"B0",	-- STA POS
38 => x"E7",	-- JCC SENDPOS
-- SENDPOS
39 => x"2B",	-- LDA POS (1)
40 => x"70",	-- LDA POS (2)
41 => x"BA",	-- STA AFF_POSMOD
42 => x"C0",	-- JCC START
-- DATAS
43 => x"FF",	-- ALLONE
44 => x"00",	-- ZERO
45 => x"01",	-- ONE
46 => x"F7",	-- VAL_247
47 => x"08",	-- VAL_8
48 => x"00",	-- POS
49 => x"00",	-- JOUEUR