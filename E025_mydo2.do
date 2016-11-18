capture program drop myprog
program myprog

cd "D:\GN Luo\20161103_STATA_#161026"
cd E025
import exc using "E025_SUM.xlsx", firstr clear 
// firstrow as variable names

// generate date 
ge int  date = Year
replace date = yq(Year,1)  if Quarter == 1
replace  date = yq(Year,2) if Quarter == 2
replace  date = yq(Year,3) if Quarter == 3
replace  date = yq(Year,4) if Quarter == 4
format date %tq

order  Professions Age Sex date
sort  Professions Age Sex date


///
keep if Age == "Aged 15 and over"
keep if Sex == "Both sexes"
drop if Professions=="All occupations"


xtline Percentage, t(date) i(Professions) overlay ///
	 xtitle("time") ///
	ytitle("Percentage(+%)") xtick(#6) ytick(#5) xmtick(##4) ymtick(##5) ///
	legend(on pos(3) textwidth(*8) cols(1) size(vsmall)) ///
	title("Both sexes") subtitle( "Aged 15 and over")
gr export 20161103_E025_Percent_`i'.png,replace
gr export 20161103_E025_Percent_`i'.tif,replace
gr save 20161103_E025_Percent_`i',replace


end
