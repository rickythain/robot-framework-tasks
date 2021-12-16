*** Settings ***
Library          SeleniumLibrary
Resource         common.robot

#   universal tester
#   an attempt to create a single test file to execute any test depending on set variables and statements
#   comment and uncomment statements to use / to not use.
#   change value of variables to test different parameters.


*** Variable ***
#   Synthetic Indices || Forex
${selected_market_type}     Synthetic Indices
#   Volatility 10 (1s) Index || AUD/USD || Volatility 50 Index
${selected_market}          Volatility 50 Index

#multiplier || rise_fall || high_low || touch
${selected_contract_type}   multiplier
#setDurationDay: duration || endtime
#setDuration: s, m, h, d
${selected_duration_type}   duration
${selected_duration}        2
${selected_barrier}         +1
# stake || payout
${selected_amount_type}     payout
${selected_amount}          10
#1: up, rise, higher, touch || 2: down, fall, lower, no touch
${selected_contract_purchase}   2

${expected_error_msg}       Contracts more than 24 hours in duration would need an absolute barrier.
#1: up, rise, higher, touch || 2: down, fall, lower, no touch
${check_purchase_btn}       2

*** Test Cases ***
Open Deriv
    Login   ${my_email}     ${my_password}
    changeToVirtualAcc
    selectMarket    ${selected_market_type}     ${selected_market}
    setContract     ${selected_contract_type}
#    setDuration     ${selected_duration_type}       ${selected_duration}
#    setDurationDay     ${selected_duration_type}       ${selected_duration}
#    setBarrier      ${selected_barrier}
#    setAmount       ${selected_amount_type}     ${selected_amount}
#    checkBarrierErrorMessage        ${expected_error_msg}
#    checkPurchaseBtnDisable         ${check_purchase_btn}
#    chooseContract      ${selected_contract_purchase}
    checkOnlyStake
    Check Deal Cancellation or Profit Stop Loss

