*** Settings ***
Library          SeleniumLibrary
Resource         common.robot

# task 2: Buy rise contract
*** Variable ***
${selected_market_type}     Synthetic Indices
${selected_market}          Volatility 10 (1s) Index

${selected_contract_type}   rise_fall
#setDuration: t, s, m, h, d
${selected_duration_type}   t
${selected_duration}        5
# stake || payout
${selected_amount_type}     stake
${selected_amount}          10
#1: up, rise, higher, touch || 2: down, fall, lower, no touch
${selected_contract_purchase}   1

${expected_error_msg}       Contracts more than 24 hours in duration would need an absolute barrier.
#1: up, rise, higher, touch || 2: down, fall, lower, no touch
${check_purchase_btn}       2

*** Test Cases ***
Open Deriv
    Login   ${my_email}     ${my_password}
    changeToVirtualAcc
    selectMarket    ${selected_market_type}     ${selected_market}
    setContract     ${selected_contract_type}
    setDuration     ${selected_duration_type}       ${selected_duration}
    setAmount       ${selected_amount_type}     ${selected_amount}
#    checkBarrierErrorMessage        ${expected_error_msg}
#    checkPurchaseBtnDisable         ${check_purchase_btn}
    chooseContract      ${selected_contract_purchase}