*** Settings ***
Library          SeleniumLibrary
Resource         common.robot

#   task 1: Switch to virtual account
*** Variable ***

*** Test Cases ***
Open Deriv
    Login   ${my_email}     ${my_password}
    changeToVirtualAcc