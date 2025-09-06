#delimit;
clear;
version 19.5;
pause on;
program drop _all;
set more off;
capture log close;

/* replace with your working directory */
global F9 "E:/Dropbox/CGAF/2019/project_40pct/writing/revision/replication/";

/* IMPORTANT NOTE: NIH priority scores are NOT public information, and were provided to one of the authors under a confidentiality agreement. 	*/
/* The scores provided in these data are random draws from the empirical distribution of actual scores, they are not actual scores. 		*/
/* As a result, the data and Stata code below can be used to repliacte the numbers in Tables 1 & 2 in the main manuscript, but they cannot	*/
/* and should not be used to identify which specific drug would be affected by an hypothertical NIH budget cut. Because the scores are randomly	*/
/* generated, the results differ slightly from thos that can be observed in Tables 1 and 2, but are qualitatively similar. 			*/

/* For the file to run, the reader should create two subfolders names graphs and tables respectively, within the working directory. */

cd /;
cd "${F9}";

/* The file sustained_rdm.dta is an approval level file (N=557) with covariates relating to direct and indirect acknowledgements of NIH grants.	*/

use "${F9}sustained_rdm.dta", clear;
gen priority=rvw_dsgntn==1;
gen standard=rvw_dsgntn==2;
replace sprtng_grant_amount_drct=sprtng_grant_amount_drct/1000000;
replace sprtng_grant_amount_ndrct=sprtng_grant_amount_ndrct/1000000;
gen affctd_ndrct25=frac_ttl_rdm_ffctd_pubs>=0.25;
gen frac_any_nih=nb_pubs_ylnkd/nb_pubs_ttl;
recode frac_any_nih .=0;
gen indirect_link=frac_any_nih>0;
gen indirect_link25=frac_any_nih>=0.25;
order applno approval_yr actv_ngrdnt trade_name applicant rvw_dsgntn kpss_drct kpss_ndrct direct_link indirect_link;

label var nb_linked_patents "Number of Linked Pre-approval Patents";
label var nb_linked_rdm_ffctd_patents "Number of Linked & Affected Pre-approval Patents";
label var nb_patents_ttl "Number of Pre-approval Patents";
label var frac_linked_patents "Fraction of Pre-approval Patents Linked";
label var frac_linked_rdm_ffctd_patents "Fraction of Pre-approval Patents Linked & Affected";
label var priority "Priority Review";
label var standard "Standard Review";
label var kpss_drct "KPSS Patent Value (in $ millions, direct linkages)";
label var kpss_ndrct "KPSS Patent Value (in $ millions, indirect linkages)";
label var direct_link "Directly Linked (at least one grant)";
label var indirect_link "Indirectly Linked (at least one grant)";
label var nb_linked_rdm_ffctd_projects "Nb. of Supporting Affected Grants, direct linkages";
label var nb_sprtng_grants_drct "Nb. of Supporting NIH grants (direct linkages)";
label var sprtng_grant_amount_drct "Supporting Grant Amounts (in $ Millions, direct linkages)";
label var nb_sprtng_grants_ndrct "Nb. of Supporting NIH grants (Indirect linkages)";
label var sprtng_grant_amount_ndrct "Supporting Grant Amounts (in $ Millions, Indirect linkages)";
label var priority "Priority Review";
label var standard "Standard Review";
label var approval_yr "Approval Year";
label var nb_pubs_ttl "Nb. of Cited Publications";
label var nb_pubs_nlnkd "Nb. of Unlinked Cited Publications";
label var nb_pubs_ylnkd "Nb. of NIH-Linked Cited Publications";
label var nb_linked_rdm_ffctd_pubs "Nb. of NIH-Linked Counterfactually Cut Publications";
label var actv_ngrdnt "Active Ingredient";
label var trade_name "Brand Name";
label var affctd_drct "Counterfactually Cut [Direct Linkage]";
label var affctd_ndrct "Counterfactually Cut [Indirect Linkage]";
label var affctd_ndrct25 "Counterfactually Cut [Indirect Linkage, >25%]";
label var frac_any_nih "% of publications acknowledging BIH support";
label var frac_linked_rdm_ffctd_pubs "Fraction of counterfactually cut publications (denom. is NIH-linked publications)";
label var frac_ttl_rdm_ffctd_pubs "Fraction of counterfactually cut publications (denom. is all cited publications)";

label define ffctd 0	"Not Affected";
label define ffctd 1	"Affected", add;
label values affctd_drct ffctd;
label values affctd_ndrct ffctd;
label values affctd_ndrct25 ffctd;

/* This chunk of code produces Table 1.					*/

* Compute stats per row on the same sample within each variable pair, listwise per row ;
* Row 1, direct_link vs affctd_ndrct ;
local sample1 if !missing(direct_link, affctd_ndrct) ;
quietly summarize direct_link `sample1', meanonly ;
local n_direct    : display %9.0f r(sum) ;
local p_direct    : display %4.2f 100*r(mean) ;
quietly summarize affctd_drct `sample1', meanonly ;
local n_aff       : display %9.0f r(sum) ;
local p_aff       : display %4.2f 100*r(mean) ;

* Row 2, indirect_link vs affctd_ndrct ;
local sample2 if !missing(indirect_link, affctd_ndrct) ;
quietly summarize indirect_link `sample2', meanonly ;
local n_indirect  : display %9.0f r(sum) ;
local p_indirect  : display %4.2f 100*r(mean) ;
quietly summarize affctd_ndrct `sample2', meanonly ;
local n_aff_ndrct : display %9.0f r(sum) ;
local p_aff_ndrct : display %4.2f 100*r(mean) ;

* Row 3, indirect_link25 vs affctd_ndrct25 ;
local sample3 if !missing(indirect_link25, affctd_ndrct25) ;
quietly summarize indirect_link25 `sample3', meanonly ;
local n_indirect25  : display %9.0f r(sum) ;
local p_indirect25  : display %4.2f 100*r(mean) ;
quietly summarize affctd_ndrct25 `sample3', meanonly ;
local n_aff_ndrct25 : display %9.0f r(sum) ;
local p_aff_ndrct25 : display %4.2f 100*r(mean) ;

* Labels and headers ;
local title   `"Table 1: Share of linked drugs under different criteria"' ;
local h1      `"Any NIH Funding"' ;
local rlbl1   `"At least one patent directly acknowledges:"' ;
local rlbl2   `"At least one patent-to-paper citation connected to:"' ;
local rlbl3   `"At least 25% of patent-to-paper citation connected to:"' ;

* Build the Word doc, Garamond 11 body and bold 14pt title with no padding after ;
putdocx clear ;
putdocx begin, pagesize(letter) font("Garamond", 11) ;
putdocx paragraph, font("Garamond", 14) spacing(after, 0) ;
putdocx text ("`title'"), bold ;

* Table 4 rows × 3 cols, top row headers and three data rows with left labels ;
putdocx table T = (4,3), layout(fixed) width(100%) halign(left) ;
putdocx table T(.,.), font("Garamond", 11) ;

* Row 1, headers centered and not bold ;
putdocx table T(1,1) = ("") ;
putdocx table T(1,2) = ("`h1'") ;
putdocx table T(1,3) = ("An "), append ;
putdocx table T(1,3) = (uchar(8220)), append ;   // “
putdocx table T(1,3) = ("at risk"), append ;
putdocx table T(1,3) = (uchar(8221)), append ;   // ”
putdocx table T(1,3) = (" grant"), append ;
putdocx table T(1,2), halign(center) ;
putdocx table T(1,3), halign(center) ;

* Row 2, label + metrics for direct_link / affctd_ndrct ;
putdocx table T(2,1) = ("`rlbl1'") ;
putdocx table T(2,2) = ("`n_direct' [`p_direct'%]") ;
putdocx table T(2,3) = ("`n_aff' [`p_aff'%]") ;
putdocx table T(2,2), halign(center) ;
putdocx table T(2,3), halign(center) ;

* Row 3, label + metrics for indirect_link / affctd_ndrct ;
putdocx table T(3,1) = ("`rlbl2'") ;
putdocx table T(3,2) = ("`n_indirect' [`p_indirect'%]") ;
putdocx table T(3,3) = ("`n_aff_ndrct' [`p_aff_ndrct'%]") ;
putdocx table T(3,2), halign(center) ;
putdocx table T(3,3), halign(center) ;

* Row 4, label + metrics for indirect_link25 / affctd_ndrct25 ;
putdocx table T(4,1) = ("`rlbl3'") ;
putdocx table T(4,2) = ("`n_indirect25' [`p_indirect25'%]") ;
putdocx table T(4,3) = ("`n_aff_ndrct25' [`p_aff_ndrct25'%]") ;
putdocx table T(4,2), halign(center) ;
putdocx table T(4,3), halign(center) ;

* Column widths, 55% for the label column, 22.5% each for metric columns ;
putdocx table T(.,1), width(55%) ;
putdocx table T(.,2), width(22.5%) ;
putdocx table T(.,3), width(22.5%) ;

* Minimal borders, top 1pt, header rule 0.25pt, bottom 1pt, no verticals ;
putdocx table T(.,.), border(all, nil) ;
putdocx table T(1,.), border(top, single, black, 1pt) ;
putdocx table T(1,.), border(bottom, single, black, 0.25pt) ;
putdocx table T(4,.), border(bottom, single, black, 1pt) ;

* Note directly below the table, Garamond 10, zero spacing before/after ;
putdocx paragraph, font("Garamond", 10) spacing(before, 0) spacing(after, 0) ;
putdocx text ("Note:"), underline ;
putdocx text (" The denominator consists of the 557 drugs approved by the FDA between 2000 and 2023. The patents taken into account were extracted from the FDA Orange Book; patents granted after the approval year were excluded from the analysis. There are 271 (48.6%) drug approvals that do not cite any at-risk NIH research. Of this set, 94 (16.9%) are associated with patents that do not reference any scientific publications; a further 132 (23.7%) have patents that do reference scientific publications, but none of these publications acknowledge NIH grant support; finally, 45 approvals (8.1%) have patents that do reference scientific publications that acknowledge NIH grant support, but none of these grants would disappear under our hypothetical 40% cut.") ;

* Save to requested path ;
putdocx save "${F9}tables/table_1.docx", replace ;

count if nb_pubs_ttl==0;
/* 94 (16.9%) approvals associated with patents that do not reference any scientific publications 						*/
count if nb_pubs_ylnkd==0 & nb_pubs_ttl>0;
/* 132 (23.7%) approvals have patents that do reference scientific publications, but none of these publications acknowledge NIH grant support	*/ 
count if nb_pubs_ylnkd>0 & nb_linked_rdm_ffctd_pubs==0;
/* Approvals with patents that do reference publications that acknowledge NIH grant support, but none of these grants would be cut		*/


/* This chunk of code produces Table 2, in two separate chunks for eacg panel.	*/

foreach threshold in affctd_ndrct affctd_ndrct25 {;

    quietly count if `threshold' == 0 ;
    local N0 = r(N) ;
    quietly count if `threshold' == 1 ;
    local N1 = r(N) ;

    local myresults "N = (r(N_1)+r(N_2)) Below = r(mu_1) Above = r(mu_2) Diff = (r(mu_2)-r(mu_1)) pvalue = r(p)" ;
    display "`myresults'" ;

    table (command) (result[Below Above Diff pvalue]),
        command(`myresults' : ttest nb_pubs_ttl, by(`threshold'))
        command(`myresults' : ttest nb_pubs_ylnkd, by(`threshold'))
        command(`myresults' : ttest nb_linked_rdm_ffctd_pubs, by(`threshold'))
        command(`myresults' : ttest priority, by(`threshold'))
        command(`myresults' : ttest approval_yr, by(`threshold'))
        command(`myresults' : ttest kpss_ndrct, by(`threshold'))
        command(`myresults' : ttest nb_sprtng_grants_ndrct, by(`threshold'))
        command(`myresults' : ttest sprtng_grant_amount_ndrct, by(`threshold'))
        nformat(%15.0fc N) nformat(%04.2f Below Above Diff) nformat(%04.2f pvalue) ;

    collect label list command, all ;
    collect label levels command 1 "Nb. of Cited Publications"
                                 2 "Nb. of NIH-Linked Cited Publications"
                                 3 "Nb. of NIH-Linked Counterfactually Cut Cited Publications"
                                 4 "Priority Review"
                                 5 "Approval Year"
                                 6 "KPSS Total Patent Value (in $ millions)"
                                 7 "Nb. of Supporting NIH grants"
                                 8 "Linked Weighted NIH Investments (in $ millions)", modify ;

    collect style cell result[N], nformat(%15.0fc) ;
    collect style cell result[Below Above Diff], nformat(%8.2f) ;
    collect style cell result[pvalue], nformat(%04.2f) ;
    collect style cell result[N Below Above Diff pvalue], halign(center) ;

    collect label levels result Below "Not at risk (N=`N0')", modify ;
    collect label levels result Above "At risk (N=`N1')", modify ;
    collect label levels result Diff  `"`=uchar(916)'"', modify ;

    local dagger = uchar(8224) ;
    collect stars pvalue 0.10 "`dagger'" 0.05 "*" 0.01 "**", attach(Diff) ;

    collect layout (command) (result[Below Above Diff]) ;

    local spanner "" ;
    if "`threshold'" == "affctd_ndrct"  local spanner "At least one of the cited publications disappears under 40% cut" ;
    if "`threshold'" == "affctd_ndrct25" local spanner "At least 25% of the cited publications disappear under 40% cut" ;
    collect label dim result "`spanner'", modify ;
    collect style header result, title(label) ;
    collect style cell cell_type[column-title]#result, halign(center) valign(center) ;

    * Remove the vertical rule after the left stub ;
    collect style cell border_block, border(right, pattern(nil)) ;
    collect style cell result[Below], border(left, pattern(nil)) ;
    collect style cell cell_type[column-header]#result[Below], border(left, pattern(nil)) ;
    collect style cell cell_type[column-title]#result, border(left, pattern(nil)) ;

    * Visually collapse the space under the table by removing bottom borders ;
    collect style cell cell_type[data], border(bottom, pattern(nil)) ;
    collect style cell cell_type[column-header], border(bottom, pattern(nil)) ;
    collect style cell cell_type[column-title], border(bottom, pattern(nil)) ;

    collect preview ;

    putdocx clear ;
    putdocx begin, pagesize(letter) landscape font("Garamond", 11) ;
    putdocx paragraph, font("Garamond", 14) spacing(after, 0) ;
    putdocx text ("Table 2: Indicators of drug importance across different measures of connection"), bold ;

    collect style putdocx, layout(autofitcontents) ;
    putdocx collect ;

    * Styled note directly under the table ;
    putdocx paragraph, font("Garamond", 10) spacing(before, 0) spacing(after, 0) ;
    putdocx text ("Note:"), underline ;
    putdocx text (" N=557 drugs approved since 2000 with 2,668 pre-approval patents (avg.=4.8, median=4, min.=1, max.=34). p-values corresponding to two-tailed t-tests of equality for the outcomes between at risk and not at risk drug approvals indicated (") ;
    putdocx text ("`dagger'") ;
    putdocx text (" p < 0.10, * p < 0.05, ** p < 0.01). The KPSS patent value comparison is based on a subset of 329 approvals, corresponding to public firms (35 at risk approvals; 294 not at risk approvals).") ;

    putdocx save "${F9}tables/table_2_`threshold'.docx", replace ;

};


/* Figure S1 (Supplementary Online Material) */

gen nb_patents_ttl2=nb_patents_ttl;
replace nb_patents_ttl2=15 if nb_patents_ttl2>15;
gen nb_pubs_ttl2=nb_pubs_ttl;
replace nb_pubs_ttl2=70 if nb_pubs_ttl>70;
gen nb_pubs_ylnkd2=nb_pubs_ylnkd;
replace nb_pubs_ylnkd2=70 if nb_pubs_ylnkd>70;
mylabels 0(10)100, myscale(@/100) suffix(%) local(pct_yaxis);
twoway (histogram nb_patents_ttl2, frac discrete xlabel(0(1)15, labsize(small) tlength(.75) format(%4.0f) grid glwidth(vvthin) glcolor(gs13)) ylabel(`pct_yaxis', labsize(small) tlength(.75) angle(horizontal) format(%9.3f) grid glwidth(vvthin) glcolor(gs13)) gap(9) color(stblue%50) lwidth(none) graphregion(color(white)) xtitle("Number of Listed Patents", size(medsmall)) ytitle("Proportion of Approved Drugs", size(medsmall))) (histogram nb_linked_patents, frac discrete color(stred%30) gap(9) lwidth(none) graphregion(color(white))), legend(order(1 "Total" 2 "NIH-linked") position(1) ring(0) size(small))saving("${F9}graphs/gph/figure_s1a.gph", replace);
graph export "${F9}graphs/tif/figure_s1a.tif", as(tif) width(2000) replace;
graph export "${F9}graphs/png/figure_s1a.png", as(png) width(2000) replace;
graph close;
mylabels 0(10)40, myscale(@/100) suffix(%) local(pct_yaxis);
twoway (histogram nb_pubs_ttl2, frac discrete xlabel(0(10)75, labsize(small) tlength(.75) format(%4.0f) grid glwidth(vvthin) glcolor(gs13)) ylabel(`pct_yaxis', labsize(small) tlength(.75) angle(horizontal) format(%9.3f) grid glwidth(vvthin) glcolor(gs13)) gap(9) color(stblue%50) lwidth(none) graphregion(color(white)) xtitle("Number of Referenced Publications", size(medsmall)) ytitle("Proportion of Approved Drugs", size(medsmall))) (histogram nb_pubs_ylnkd2, frac discrete color(stred%30) gap(9) lwidth(none) graphregion(color(white))), legend(order(1 "Total" 2 "At risk") position(1) ring(0) size(small)) saving("${F9}graphs/gph/figure_s1b.gph", replace);
graph export "${F9}graphs/tif/figure_s1b.tif", as(tif) width(2000) replace;
graph export "${F9}graphs/png/figure_s1b.png", as(png) width(2000) replace;
graph close;


/* Figure S2 (Supplementary Online Material) */

gen frac_ttl=100*round(frac_ttl_rdm_ffctd_pubs,0.0001);
cumul frac_ttl, gen(cml) freq;
sort cml;
gen cmltv=_N-_n+1;
mylabels 0 50 100 150 200 250 286 350(50)500 557 600, local(pct_yaxis);
mylabels 0 10 20 30 40 50 60 70 80 90 100, suffix(%) local(pct_xaxis);
twoway (line cmltv frac_ttl, ytitle("Nb. of Approvals") ylabel(`pct_yaxis', labsize(small) tlength(.75) tlwidth(*.5) angle(horizontal) grid glwidth(vvthin) glcolor(gs13)) xlabel(`pct_xaxis', labsize(small) tlength(*.5) tlwidth(*.5) grid glwidth(vvthin) glcolor(gs13)) xtitle(`"Fraction of connected publications at risk of being counterfactually cut"') graphregion(color(white)) plotregion(margin(small) style(none)) xscale(range(0 100)) yscale(range(0 600)))
(scatteri 286 0 557 0, recast(line) lcolor(stred) lwidth(medthin) legend(off))
(pcarrowi 420 58 294 0.5, barbsize(vsmall) mcolor(gs0) mfcolor(gs0) mlcolor(gs0) lpattern(shortdash) lcolor(black) lwidth(thin) text(420 80 "557-286 = 271 post-2000 drug approvals do not" "reference at risk NIH-funded publications", size(small) just(left)) saving("${F9}graphs/gph/figure_s2.gph", replace));
graph export "${F9}graphs/tif/figure_s2.tif", as(tif) width(2000) replace;
graph export "${F9}graphs/png/figure_s2.png", as(png) width(2000) replace;
graph close;

capture drop nb_patents_ttl2 nb_pubs_ttl2 nb_pubs_ylnkd2 frac_ttl cml cmltv indirect_link25 priority standard affctd_ndrct25 frac_any_nih;

/* Sensitivity Analysis (Supplementary Online Material) */

use "${F9}budget_cut_sensitivity_analysis.dta", clear;
mylabels 0 50 100 150 200 250 286 331 400 450 500 557 600, local(pct_yaxis);
mylabels 0 10 20 30 40 50 60 70 80 90 100, suffix(%) local(pct_xaxis);
twoway (line nb_ffctd alpha, ytitle("Nb. of Approvals Linked to At-risk Grants") ylabel(`pct_yaxis', labsize(small) tlength(.75) tlwidth(*.5) angle(horizontal) grid glwidth(vvthin) glcolor(gs13)) xlabel(`pct_xaxis', labsize(small) tlength(*.5) tlwidth(*.5) grid glwidth(vvthin) glcolor(gs13)) xtitle(" ""Size of Counterfactual NIH Budget Cut") graphregion(color(white)) plotregion(margin(small) style(none)) xscale(range(0 100)) yscale(range(0 600))) || (scatteri 286 40 0 40, recast(line) lcolor(black) lwidth(thin) lpattern(shortdash) legend(off)) (scatteri 286 40 286 0, recast(line) lcolor(black) lwidth(thin) lpattern(shortdash) legend(off)) (scatteri 286 40, msymbol(circle) msize(vsmall) mcolor(black) mlcolor(black) text(240 55.5 "40% Budget Cut""(President's FY26 Proposal)", size(vsmall) just(center))) (pcarrowi 252 50 283 40.5, barbsize(vsmall) mcolor(gs0) mfcolor(gs0) mlcolor(gs0) lcolor(black) lwidth(thin)) || (scatteri 557 0 557 100, recast(line) lcolor(black) lwidth(thin) lpattern(shortdash) legend(off) text(540 74 "Total number of approvals (2000-2023)", size(vsmall) just(center))) || (scatteri 331 100 0 100, recast(line) lcolor(black) lwidth(thin) lpattern(shortdash) legend(off)) (scatteri 331 100 331 0, recast(line) lcolor(black) lwidth(thin) lpattern(shortdash) legend(off)) (scatteri 331 100, msymbol(circle) msize(vsmall) mcolor(black) mlcolor(black) text(150 74 "331 (59.4%) of approvals are connected" "to at least one NIH grant", size(vsmall) just(center))) (pcarrowi 157.95 87.5 328 99.5, barbsize(vsmall) mcolor(gs0) mfcolor(gs0) mlcolor(gs0) lcolor(black) lwidth(thin) saving("${F9}graphs/gph/figure_s3.gph", replace));
graph export "${F9}graphs/tif/figure_s3.tif", as(tif) width(2000) replace;
graph export "${F9}graphs/png/figure_s3.png", as(png) width(2000) replace;
graph close;

