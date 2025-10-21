*! Version 0.1.2 21Oct2025: Revise help file
*! Version 0.1.1 21Sep2025: ivreghdfe output with constant term, F/LM tests and two stages

cap program drop ivreghdfef
cap program define ivreghdfef, eclass
    syntax varlist(fv ts) [if] [in], iv(string) Opt(string) [REGOpt(string) store(string) first Format(string)]
    
    marksample touse
    markout `touse'
    
    if "`regopt'" == ""{
        local regopt = "`opt'"
    }
    
    if "`first'" == ""{
        local qui1 = "qui"
    }
    
    if "`format'" == ""{
        local format = "%10.4f"
    }
    
    gettoken y xlist: varlist
    gettoken x control: xlist
    
    tempvar esample
    qui ivreghdfe `y' (`x'=`iv') `control' if `touse', `opt'
    gen `esample' = e(sample)
    local cdf = e(cdf)
    local rkf = e(rkf)
    local rklm = e(idstat)
    local rklmp = chi2tail(e(exexog_ct), e(idstat))
    local hansenj = e(j)
    local hansenjp = chi2tail(e(exexog_ct)-1, e(j))
    
    tempvar x_raw
    qui gen `x_raw' = `x', after(`x')
    
    `qui1' dis as res "================================= First stage results =================================="
    `qui1' reghdfe `x' `iv' `control' if `esample', `regopt'
    local b1 = r(table)[1, 1]
    local p1 = r(table)[4, 1]
    if "`store'" != ""{
        est store `store'_first
    }
    cap drop `x'
    qui predict double `x'
    dis as res "================================= Second stage results ================================="
    reghdfe `y' `x' `control' if `esample', `regopt'
    local b2 = r(table)[1, 1]
    local p2 = r(table)[4, 1]
    ereturn scalar cdf = `cdf'
    ereturn scalar rkf = `rkf'
    ereturn scalar rklm = `rklm'
    ereturn scalar hansenj = `hansenj'
    if "`store'" != ""{
        est store `store'_second
    }
    cap drop `x'
    qui gen `x' = `x_raw', before(`x_raw')
    
    dis as res "=================================    Results Summary   ================================="
    dis as res "==> First stage coefficient"
    dis as txt "beta for `x' <- `iv': " _c
    dis as res `format' `b1' _c
    if `p1' < 0.1 & `p1' >= 0.05 {
        dis as res "*"
    }
    if `p1' < 0.05 & `p1' >= 0.01 {
        dis as res "**"
    }
    if `p1' < 0.01{
        dis as res "***"
    }
    if `p1' >= 0.1{
        dis as res ""
    }
    dis as res "==> Second stage coefficient"
    dis as txt "beta for `y' <- `x'_predict: " _c
    dis as res `format' `b2' _c
    if `p2' < 0.1 & `p2' >= 0.05 {
        dis as res "*"
    }
    if `p2' < 0.05 & `p2' >= 0.01 {
        dis as res "**"
    }
    if `p2' < 0.01{
        dis as res "***"
    }
    if `p2' >= 0.1{
        dis as res ""
    }
    dis as res "==> Weak-identification"
    dis as txt "Cragg Donald Wald F Test: " _c
    dis as res `format' `cdf'
    dis as txt "Kleibergen Paap rk Wald F Test: " _c
    dis as res `format' `rkf'
    dis as res "==> Under-identification"
    dis as txt "Kleibergen Paap rk LM Test: " _c
    dis as res `format' `rklm' _c
    if `rklmp' < 0.1 & `rklmp' >= 0.05 {
        dis as res "*"
    }
    if `rklmp' < 0.05 & `rklmp' >= 0.01 {
        dis as res "**"
    }
    if `rklmp' < 0.01{
        dis as res "***"
    }
    if `rklmp' >= 0.1{
        dis as res ""
    }
    dis as res "==> Over-identification"
    dis as txt "Hansen J Test: " _c
    dis as res `format' `hansenj' _c
    if `hansenjp' < 0.1 & `hansenjp' >= 0.05 {
        dis as res "*"
    }
    if `hansenjp' < 0.05 & `hansenjp' >= 0.01 {
        dis as res "**"
    }
    if `hansenjp' < 0.01{
        dis as res "***"
    }
    if `hansenjp' >= 0.1{
        dis as res ""
    }
end