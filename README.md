> [!IMPORTANT]  
> 由于标准误调整等问题，该命令二阶段结果标准误和 t 统计量会产生偏误，最新命令 ivreghdfe2 可修复该问题，前往：
> https://github.com/codefoxs/ivreghdfe2
> 考虑到已有较多用户使用该命令，故该仓库仍保留，但不再更新。

# ivreghdfef
ivreghdfe output with constant term, F/LM tests and two stages.

## Install

```stata
* Latest version
cap ado uninstall ivreghdfef
net install ivreghdfef, from("https://raw.githubusercontent.com/codefoxs/ivreghdfef/main/") replace

* Old versions
cap ado uninstall ivreghdfef
net install ivreghdfef, from("https://raw.githubusercontent.com/codefoxs/ivreghdfef/v#.#.#/") replace
```

## Example

### Quick use

```stata
webuse nlswork

ivreghdfef ln_w ttl_exp age tenure not_smsa south , iv(hours) o( absorb(idcode year) cluster(idcode) )
```

### Output first stage

```stata
webuse nlswork
ivreghdfef ln_w ttl_exp tenure not_smsa south , iv(hours age) o( absorb(idcode year) cluster(idcode) ) first store(IV)

reg2docx IV_first IV_second using "IV.docx", replace ///
            b(%20.4f) t(%20.4f) ///
            scalars(N(%20.0fc) r2_a(%20.4f) cdf(%20.4f) rkf(%20.4f) rklm(%20.4f) hansenj(%20.4f)) ///
            order(ttl_exp hours age tenure not_smsa south) ///
            addfe("Id=Yes" "Year=Yes") ///
            title("IV 2SLS") ///
            mtitles("First stage" "Second stage") ///
            font("Times New Roman", 9) ///
            margin(top, 3.17cm) margin(bottom, 3.17cm)
```

### Set the format for summary results

```stata
webuse nlswork

ivreghdfef ln_w ttl_exp age tenure not_smsa south , iv(hours) o( absorb(idcode year) cluster(idcode) ) first store(IV) f(%5.4f)
```

## Reference

+ https://github.com/sergiocorreia/ivreghdfe

