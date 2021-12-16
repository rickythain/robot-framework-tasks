*** Settings ***
Library          SeleniumLibrary
Resource         common.robot

# Task 3: Buy lower contract
*** Variable ***
${selected_market_type}     Forex
${selected_market}          AUD/USD

${selected_contract_type}   high_low
#setDurationDay: duration || endtime
${selected_duration_type}   duration
${selected_duration}        4
${selected_barrier}         +1
# stake || payout
${selected_amount_type}     payout
${selected_amount}          15.50
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
    setDurationDay     ${selected_duration_type}       ${selected_duration}
#    setBarrier      ${selected_barrier}
    setAmount       ${selected_amount_type}     ${selected_amount}
#    checkBarrierErrorMessage        ${expected_error_msg}
#    checkPurchaseBtnDisable         ${check_purchase_btn}
    chooseContract      ${selected_contract_purchase}