{smcl}
{* *! version 0.1.1 21Sep2025}{...}
{vieweralsosee "[R] reg" "help reg"}{...}
{vieweralsosee "[R] areg" "help areg"}{...}
{vieweralsosee "[R] xtreg" "help xtreg"}{...}
{vieweralsosee "[R] reghdfe" "help reghdfe"}{...}
{vieweralsosee "[R] ivreg2" "help reghdfe"}{...}
{vieweralsosee "[R] ivreghdfe" "help reghdfe"}{...}
{vieweralsosee "" "--"}{...}
{viewerjumpto "Syntax" "ivreghdfef##syntax"}{...}
{viewerjumpto "Example" "ivreghdfef##example"}{...}
{viewerjumpto "Store results" "ivreghdfef##results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{hi:ivreghdfef} {hline 2}}ivreghdfe output with constant term, F/LM tests and two stages{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}
{p 8 14 4}{cmd:ivreghdfef} {it:y} {it:x} [{it:controls}] {ifin} , {opt iv:(instrument)} {opt o:pt(options for ivreghdfe)}
[{opt rego:pt(options for reghdfe)} {opt first} {opt store(string)} {opt f:ormat(%fmt)}]

{synoptset 35 tabbed}{...}
{synopthdr}
{synoptline}
{syntab: Main}
{synopt: {opt iv}({it:instrument})}Instrument variables{p_end}
{synopt: {cmdab:opt:ion}({it:options for reghdfe})}Options for ivreghdfe, like absorb(), cluster(), and so on. More details in {help ivreghdfe}{p_end}

{syntab: Other options}
{synopt: {cmdab:rego:pt}({it:string})}Options for reghdfe. Default is same as {cmdab:opt:ion}. More details in {help reghdfe}{p_end}
{synopt: {opt first}}Show the first stage regress result{p_end}
{synopt: {opt store}({it:string})}Prefix for store. More details in {help estimate}{p_end}
{synopt: {cmdab:f:ormat}({it:%fmt})}Format for summary results. More details in {help format}{p_end}
{synoptline}
{p2colreset}{...}

{marker example}{...}
{title:Example}

{hline}
{pstd}Quick use{p_end}
{phang2}{cmd:. webuse nlswork}{p_end}
{phang2}{cmd:. ivreghdfef ln_w ttl_exp age tenure not_smsa south , iv(hours) o( absorb(idcode year) cluster(idcode) )}{p_end}

{pstd}Ouput first stage{p_end}
{phang2}{cmd:. webuse nlswork}{p_end}
{phang2}{cmd:. ivreghdfef ln_w ttl_exp tenure not_smsa south , iv(hours age) o( absorb(idcode year) cluster(idcode) ) first store(IV)}{p_end}
{phang2}{cmd:. }{p_end}
{phang2}{cmd:. reg2docx IV_first IV_second using "IV.docx", replace ///}{p_end}
{phang2}{cmd:. b(%20.4f) t(%20.4f) ///}{p_end}
{phang2}{cmd:. scalars(N(%20.0fc) r2_a(%20.4f) cdf(%20.4f) rkf(%20.4f) rklm(%20.4f) hansenj(%20.4f)) ///}{p_end}
{phang2}{cmd:. order(ttl_exp hours age tenure not_smsa south) ///}{p_end}
{phang2}{cmd:. addfe("Id=Yes" "Year=Yes") ///}{p_end}
{phang2}{cmd:. title("IV 2SLS") ///}{p_end}
{phang2}{cmd:. mtitles("First stage" "Second stage") ///}{p_end}
{phang2}{cmd:. font("Times New Roman", 9) ///}{p_end}
{phang2}{cmd:. margin(top, 3.17cm) margin(bottom, 3.17cm)}{p_end}

{pstd}Set the format for summary results{p_end}
{phang2}{cmd:. webuse nlswork}{p_end}
{phang2}{cmd:. ivreghdfef ln_w ttl_exp age tenure not_smsa south , iv(hours) o( absorb(idcode year) cluster(idcode) ) first store(IV) f(%5.4f)}{p_end}
{hline}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:ivreghdfef} stores the following in {cmd:e()}:

{synoptset 24 tabbed}{...}
{syntab:Test statistics}
{synopt:{cmd:e(cdf)}}Cragg-Donald Wald F statistics{p_end}
{synopt:{cmd:e(rkj)}}Kleibergen Paap rk Wald F statistics{p_end}
{synopt:{cmd:e(rklm)}}Kleibergen Paap rk LM statistics{p_end}
{synopt:{cmd:e(hansenj)}}Hansen J statistics{p_end}

{syntab:Scalars}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(num_singletons)}}number of singleton observations{p_end}
{synopt:{cmd:e(N_full)}}number of observations including singletons{p_end}
{synopt:{cmd:e(N_hdfe)}}number of absorbed fixed-effects{p_end}
{synopt:{cmd:e(tss)}}total sum of squares{p_end}
{synopt:{cmd:e(tss)}}total sum of squares after partialling-out{p_end}
{synopt:{cmd:e(rss)}}residual sum of squares{p_end}
{synopt:{cmd:e(rss)}}model sum of squares (tss-rss){p_end}
{synopt:{cmd:e(r2)}}R-squared{p_end}
{synopt:{cmd:e(r2_a)}}adjusted R-squared{p_end}
{synopt:{cmd:e(r2_within)}}Within R-squared{p_end}
{synopt:{cmd:e(r2_a_within)}}Adjusted Within R-squared{p_end}
{synopt:{cmd:e(df_a)}}degrees of freedom lost due to the fixed effects{p_end}
{synopt:{cmd:e(rmse)}}root mean squared error{p_end}
{synopt:{cmd:e(ll)}}log-likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log-likelihood of fixed-effect-only regression{p_end}
{synopt:{cmd:e(F)}}F statistic{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(N_clustervars)}}number of cluster variables{p_end}
{synopt:{cmd:e(N_clust}#{cmd:)}}number of clusters for the #th cluster variable{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters; minimum of {it:e(clust#)}{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(sumweights)}}sum of weights{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}
{synopt:{cmd:e(drop_singletons)}}{cmd:1} if singletons were dropped, {cmd:0} otherwise{p_end}
{synopt:{cmd:e(df_a_nested)}}Redundant due to being nested within clustervars{p_end}
{synopt:{cmd:e(report_constant)}}whether _cons was included in the regressions (default)
or as part of the fixed effects{p_end}

{synoptset 24 tabbed}{...}
{syntab:Macros}
{synopt:{cmd:e(cmd)}}{cmd:reghdfe}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(dofmethod)}}dofmethod employed in the regression{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(indepvars)}}names of independent variables{p_end}
{synopt:{cmd:e(absvars)}}name of the absorbed variables or interactions{p_end}
{synopt:{cmd:e(extended_absvars)}}name of the extended absorbed variables (counting intercepts and slopes separately){p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(clustvar}#{cmd:)}}name of the #th cluster variable{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(footnote)}}program used to display footnote{p_end}
{synopt:{cmd:e(dofmethod)}}method(s) used to compute degrees-of-freedom lost due the fixed effects{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions not allowed by {cmd:margins}{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(title2)}}subtitle in estimation output, indicating how many FEs were being absorbed{p_end}

{synoptset 24 tabbed}{...}
{syntab:Matrices}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(dof_table)}}degrees-of-freedom table{p_end}
{synopt:{cmd:r(table)}}main results table{p_end}

{synoptset 24 tabbed}{...}
{syntab:Functions}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker author}{...}
{title:Author}

{pstd}公众号：凯恩斯学计量{p_end}

{phang}{p_end}