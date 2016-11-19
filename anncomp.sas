/* tell SAS where to store the datasets on your computer
(This should be modified according to your folder structure) */
libname myLib "F:\SAS_for_WRDS_Test";
/* details about the PC-connect (this is always the same), it will trigger a login
prompt. Use your WRDS user name and password to log on*/
%let wrds = wrds.wharton.upenn.edu 4016;
 options comamid = TCP remote=WRDS;
 signon username=_prompt_;
/* everything after 'rsubmit' will be executed on WRDS!! */

rsubmit; 
/*******************************************************************************/
*   Program        :    anncomp.sas
*   Author         :    Mireia Gine
*   Version        :    1.0
*   Date Created   :    10/2008
*   Last Modified  :    10/2008
*
*   Program Description:
*   Usage          : Program to read Compustat Executive Compensation
*
/*******************************************************************************/;

options nosource ls=72 ps=max nocenter nonumber nodate;
title ' ';
libname comp '/wrds/comp/sasdata/execcomp';
 
proc contents data= comp.anncomp;
run;
 
data temp;
set comp.anncomp;
where co_per_rol in (16214,16215,26871,28581,30224);
name = trim(exec_fname) || " " || trim(exec_lname);
keep year gvkey co_per_rol coname tdc1 name;
run;
 
proc print noobs label;
var year gvkey co_per_rol tdc1 name;
run;

/* stop processing statements on WRDS and continue working locally */
endrsubmit; 
