//http://www.dataip.co.uk/Reference/BaudotTable.php
//http://www.baudot.net/docs/smith--teletype-codes.pdf
const FIGS=0x1B;
SI=0x0E; 
LTRS=0x1F;
SO=0x0F; 
NUL=0x00; 
SPACE=0x20; 
LF=0x0A;
CR=0x0D;

case C of 
  FIGS: Offset:=32;
  LTRS: Offset:=0;
end;
A:=LUT(C); //convert all including shift chars....


LUT_USTTY_FIGS_ASCII=

LUT_ITA2_LTRS_ASCII=[
NUL,'E',LF,'A',SPACE,'S','I','U',CR,'D' ,'R' ,'J' ,'N' ,'F' ,'C' ,'K' ,'T' ,'Z' ,'L' ,'W' ,'H' ,'Y' ,'P' ,'Q' ,'O' ,'B' ,'G' ,SI,'M' ,'X' ,'V' ,SO];




LUT_ITA2_ASCII=[LUT_ITA2_LTRS_ASCII,LUT_ITA2_FIGS_ASCII];



LUT_ITA2_FIGS_ASCII=[
NUL,
'3', 
LF,
'-', 
SPACE,
BEL,
'8', 
'7', 
CR
'$', 
'4', 
''', 
',', 
'!', 
':', 
'(', 
'5', 
'"', 
')', 
'2', 
'#', 
'6', 
'0', 
'1', 
'9', 
'?', 
'&', 
SI,
'.', 
'/', 
';', 
SO
];

