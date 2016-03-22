clear
*xmluse "C:\Users\Clémence\Desktop\STATAAAAAAAAAAAA\Baseconsolidee_finale_finale.xml", firstrow
xmluse "C:\Users\Clémence\Desktop\STATAAAAAAAAAAAA\basef.xml", firstrow

replace CATEGORIE="proprete et eau" if CATEGORIE=="propretÃ©"
replace CATEGORIE="proprete et eau" if CATEGORIE=="proprtÃ©"
replace CATEGORIE="voirie" if CATEGORIE=="voirie "
replace CATEGORIE="urbanisme" if CATEGORIE=="urba"
replace CATEGORIE="sport" if CATEGORIE=="sports"

replace CATEGORIE="Sport" if CATEGORIE=="sport"
replace CATEGORIE="Culture" if CATEGORIE=="cult"
replace CATEGORIE="Environnement" if CATEGORIE=="envir"
replace CATEGORIE="Crèche" if CATEGORIE=="famil"
replace CATEGORIE="Logement" if CATEGORIE=="logement"
replace CATEGORIE="Patrimoine" if CATEGORIE=="patrim"
replace CATEGORIE="Ecole" if CATEGORIE=="scol"
replace CATEGORIE="Urbanisme" if CATEGORIE=="urbanisme"
replace CATEGORIE="Voirie" if CATEGORIE=="voirie"

bys ARRO : egen pop=mean(POP_2016)

*Comparaison entre catégories d'investissements
bys CAT : egen Mont_meanbycat=mean(MONTANT)
bys CAT : egen Mont_cat=sum(MONTANT)

*Réfléchir à comment faire cette comparaison avec des invetsissments par tête...
graph bar Mont_mean , over(CAT , label( labsize(small) angle(45)))
graph bar Mont_cat, over(CAT , label( labsize(small) angle(45)))

format Mont_cat %12.0f
preserve
keep CAT Mont_cat 
duplicates drop CAT, force
outsheet * using "C:\Users\Clémence\Desktop\STATAAAAAAAAAAAA\cat.csv", comma replace
restore


*Comparaison Avant/Après élections
graph bar Mont_cat if ANNEE<2013, over(CAT , label( labsize(small) angle(45))) 
graph bar Mont_cat if ANNEE>2014, over(CAT , label( labsize(small) angle(45))) 


*Comparaison entre arrondissement et catégories
bys ARRON : egen Mont_ar=sum(MONTANT)
bys CAT ARRON : egen MONT_bycatbyAr=sum(MONTANT)
graph bar MONT_bycatbyAr, over(CAT , label( labsize(small) angle(45))) 
gen Montpop_byAr =Mont_ar/POP_2016
preserve
duplicates drop ARRO ANNEE, force
graph bar Montpop_byAr, over(ARRO , label( labsize(small) angle(45)))
collapse (mean) Montpop_byAr, by(ARRO)
outsheet * using "C:\Users\Clémence\Desktop\STATAAAAAAAAAAAA\arro_pop.csv", comma replace
restore

gen MONTpop_bycatbyAr=MONT_bycatbyAr/POP_2016
preserve
collapse (mean) MONTpop_bycatbyAr, by(ARRO CAT)
keep if CAT=="Crèche" | CAT=="Culture" | CAT=="Ecole" | CAT=="Sport" | CAT=="Environnement" | CAT=="Voirie"
outsheet * using "C:\Users\Clémence\Desktop\STATAAAAAAAAAAAA\arro_cat_pop.csv", comma replace
restore

graph bar MONT_bycatbyAr if CAT=="Crèche", over(ARON , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyAr if CAT=="Ecole", over(ARON , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyAr if CAT=="Culture", over(ARON , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyAr if CAT=="Sport", over(ARON , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyAr if CAT=="Environnement", over(ARON , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyAr if CAT=="Voirie", over(ARON , label( labsize(small) angle(45))) 

graph bar MONTpop_bycatbyAr if CAT=="Crèche", over(ARON , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyAr if CAT=="Ecole", over(ARON , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyAr if CAT=="Culture", over(ARON , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyAr if CAT=="Sport", over(ARON , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyAr if CAT=="Environnement", over(ARON , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyAr if CAT=="Voirie", over(ARON , label( labsize(small) angle(45))) 

*Comparaison Rive Gauche/ Rive Droite
gen RivG=1 if ARO==5 | ARO==6 | ARO==7 | ARO==13 |ARO==14 |ARO==15
replace RivG=0 if RivG==.
 gen pop_riv=1523996 if RivG==0
 replace pop_riv=730266  if RivG==1
 
bys CAT RivG : egen MONT_bycatbyRiv=sum(MONTANT)
gen MONTpop_bycatbyRiv=MONT_bycatbyRiv/pop_riv

graph bar MONT_bycatbyRiv if CAT=="Crèche", over(RivG , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyRiv if CAT=="Ecole", over(RivG , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyRiv if CAT=="Culture", over(RivG , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyRiv if CAT=="Sport", over(RivG , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyRiv if CAT=="Environnement", over(RivG , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyRiv if CAT=="Voirie", over(RivG , label( labsize(small) angle(45))) 

graph bar MONTpop_bycatbyRiv if CAT=="Crèche", over(RivG , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyRiv if CAT=="Ecole", over(RivG , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyRiv if CAT=="Culture", over(RivG , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyRiv if CAT=="Sport", over(RivG , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyRiv if CAT=="Environnement", over(RivG , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyRiv if CAT=="Voirie", over(RivG , label( labsize(small) angle(45))) 


*Comparaison centre Vs Périphérie
gen central=1 if ARO<10
replace central=0 if ARO>=10

gen pop_cent=366217 if central==1
replace pop_cent=1888045  if central==0

bys CAT central : egen MONT_bycatbyCent=sum(MONTANT)
gen MONTpop_bycatbyCent=MONT_bycatbyCent/pop_cent


graph bar MONT_bycatbyCent if CAT=="Crèche", over(central , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyCent if CAT=="Ecole", over(central , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyCent if CAT=="Culture", over(central , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyCent if CAT=="Sport", over(central , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyCent if CAT=="Environnement", over(central , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyCent if CAT=="Voirie", over(central , label( labsize(small) angle(45))) 

graph bar MONTpop_bycatbyCent if CAT=="Crèche", over(central , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyCent if CAT=="Ecole", over(central , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyCent if CAT=="Culture", over(central , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyCent if CAT=="Sport", over(central , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyCent if CAT=="Environnement", over(central , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyCent if CAT=="Voirie", over(central , label( labsize(small) angle(45))) 

*Comparaison Est/Ouest
gen ouest=1 if AR==1| AR==2 | AR==6 |AR==7 |AR==8 |AR==9 |AR==15 |AR==16 |AR==17 
replace ouest=0 if ouest==.

gen pop_ouest=821392 if ouest==1
replace pop_ouest=1432870 if ouest==0

bys CAT ouest : egen MONT_bycatbyouest=sum(MONTANT)
gen MONTpop_bycatbyouest=MONT_bycatbyouest/pop_ouest

graph bar MONT_bycatbyouest if CAT=="Crèche", over(ouest , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyouest if CAT=="Ecole", over(ouest , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyouest if CAT=="Culture", over(ouest , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyouest if CAT=="Sport", over(ouest , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyouest if CAT=="Environnement", over(ouest , label( labsize(small) angle(45))) 
graph bar MONT_bycatbyouest if CAT=="Voirie", over(ouest , label( labsize(small) angle(45))) 

graph bar MONTpop_bycatbyouest if CAT=="Crèche", over(ouest , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyouest if CAT=="Ecole", over(ouest , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyouest if CAT=="Culture", over(ouest , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyouest if CAT=="Sport", over(ouest , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyouest if CAT=="Environnement", over(ouest , label( labsize(small) angle(45))) 
graph bar MONTpop_bycatbyouest if CAT=="Voirie", over(ouest , label( labsize(small) angle(45))) 







