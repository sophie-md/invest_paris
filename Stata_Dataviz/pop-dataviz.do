*Création des vraiables de populations par rive

clear
xmluse "C:\Users\Clémence\Desktop\STATAAAAAAAAAAAA\basef.xml", firstrow

gen RivG=1 if ARRO==5 | ARRO==6 | ARRO==7 | ARRO==13 |ARRO==14 |ARRO==15
replace RivG=0 if RivG==.
gen central=1 if ARRO<10
replace central=0 if ARRO>=10
gen ouest=1 if AR==1| AR==2 | AR==6 |AR==7 |AR==8 |AR==9 |AR==15 |AR==16 |AR==17 
replace ouest=0 if ouest==.

drop if ANNEE==2010

duplicates drop ARO, force

bys RivG : egen pop_riv=sum(POP)
tab RivG

bys central : egen pop_cent=sum(POP) 
tab pop_cent

bys ouest : egen pop_ouest=sum(POP) 
tab pop_ouest
