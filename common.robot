*** Settings ***
Documentation    Suite description
Library         SeleniumLibrary

*** Variable ***
${login_btn}    dt_login_button
${email_field}  txtEmail
${pw_field}     txtPass


*** Keywords ***
Login
    [arguments]  ${email}  ${password}
    Open Browser    https://app.deriv.com      chrome
    set window size      1280    1080
    wait until page contains element    ${login_btn}       60
    Click Element    ${login_btn}

    wait until page contains element    ${email_field}      15
    input text      ${email_field}    ${email}      True
    input text      ${pw_field}     ${password}      True
    click element       //*[text()="Log in"]

changeToVirtualAcc
    wait until page does not contain element     dt_core_header_acc-info-preloader      30
    wait until page contains element        dt_core_account-info_acc-info
    click element       dt_core_account-info_acc-info
    click element       dt_core_account-switcher_demo-tab
    click element       //*[contains(@id,"dt_VRTC")]

selectMarket
    [arguments]     ${market_type}  ${market}
    wait until page does not contain element    //*[contains(@class, "sidebar__items")]//*[text()="Loading interface..."]       30
    wait until page does not contain element    dt_core_header_acc-info-preloader      30
    wait until page does not contain element    //*[@class="chart-container__loader"]      30
    click element       //*[contains(@class, "ciq-menu ciq-enabled")]
    click element       //*[text()="${market_type}"]
    click element       //*[contains(@class, "sc-mcd__item")]//*[text()="${market}"]

#    wait until page does not contain element    //*[contains(@class, "sidebar__items")]//*[text()="Loading interface..."]       30
#    click element       dc_t_toggle_item
#    click element       dt_purchase_call_button

selectContract
    [arguments]         ${duration_type}    ${duration}     ${amount_type}      ${amount}       ${contract_type}
    wait until page does not contain element    //*[contains(@class, "sidebar__items")]//*[text()="Loading interface..."]       30
    click element       dt_simple_toggle
    click element       dropdown-display
    click element       //*[contains(@class, "dc-list__item") and @id="${duration_type}"]
#    duration box not cleared :(
#    clear element text  //*[@id="dt_advanced_duration_input"]
    Clear Input Field   //*[@name="duration"]
    input text          //*[@name="duration"]    ${duration}    True
#    change slider value     //*[@name="duration"]       ${duration}
    click element       dc_${amount_type}_toggle_item
    clear input field   dt_amount_input
    input text          dt_amount_input         ${amount}
    wait until element is enabled       dt_purchase_${contract_type}_button
    click element       dt_purchase_${contract_type}_button

setContract
    [arguments]     ${contract_type}
    wait until page does not contain element    //*[contains(@class, "sidebar__items")]//*[text()="Loading interface..."]       30
    click element       //*[@id="dt_contract_dropdown"]
    click element       dt_contract_${contract_type}_item


setDuration
    [arguments]         ${duration_type}    ${duration}
#    wait until page does not contain element    //*[contains(@class, "sidebar__items")]//*[text()="Loading interface..."]       30
    click element       dt_simple_toggle
    click element       dropdown-display
    click element       //*[contains(@class, "dc-list__item") and @id="${duration_type}"]
    Clear Input Field   //*[@name="duration"]
    input text          //*[@name="duration"]    ${duration}    True
#    change slider value     //*[@name="duration"]       ${duration}

setAmount
    [arguments]     ${amount_type}      ${amount}
    click element       dc_${amount_type}_toggle_item
    clear input field   dt_amount_input
    input text          dt_amount_input         ${amount}

chooseContract
    [arguments]     ${contract_purchase}
    wait until element is enabled       //*[contains(@class, "btn-purchase--${contract_purchase}")]
    click element       //*[contains(@class, "btn-purchase--${contract_purchase}")]


Clear Input Field
    [Arguments]         ${input_field}
    wait until page contains element        ${input_field}      15
    ${current_value}=       get element attribute       ${input_field}      value
    ${value_length}=        Get Length      ${current_value}
    Repeat Keyword      ${value_length}     Press Keys      ${input_field}      BACKSPACE
    Repeat Keyword      1       Press Keys        ${input_field}        DELETE

Change Slider Value
    [arguments]     ${input_field}      ${ticks}
    ${current_value}=       get element attribute       ${input_field}      value
#    ${value_length}=        Get Length      ${current_value}
    Repeat Keyword      4     Press Keys      ${input_field}      ARROW_LEFT
    Repeat Keyword      1      Press Keys        ${input_field}        ARROW_RIGHT

setDurationDay
    [arguments]         ${duration_type}    ${duration}
#    wait until page does not contain element    //*[contains(@class, "sidebar__items")]//*[text()="Loading interface..."]       30
    click element       dt_simple_toggle
    click element       dc_${duration_type}_toggle_item
    Clear Input Field   //*[@name="duration"]
    input text          //*[@name="duration"]    ${duration}    True

setBarrier
    [arguments]     ${barrier_value}
    clear input field   //*[@name="barrier_1"]
    input text          //*[@name="barrier_1"]  ${barrier_value}

checkBarrierErrorMessage
    [arguments]     ${error_msg}
    wait until page contains element    //*[@class="purchase-container"]//*[contains(@class, "dc-popover__bubble")]//*[@class="dc-text"]
    element text should be      //*[@class="purchase-container"]//*[contains(@class, "dc-popover__bubble")]//*[@class="dc-text"]        ${error_msg}

checkPurchaseBtnDisable
    [arguments]     ${purchase_btn}
#    element should be disabled      //*[contains(@class, btn-purchase--${purchase_btn})]
    page should contain element     //*[contains(@class, "btn-purchase--disabled btn-purchase--2")]

checkOnlyStake
    page should not contain element     //*[contains(@class, "trade-container__fieldset")]//*[text()="Payout"]

Check Deal Cancellation or Profit Stop Loss
    click element       //*[contains(@class, "dc-checkbox__label") and text()="Take profit"]
    click element       //*[contains(@class, "dc-checkbox__label") and text()="Stop loss"]
    checkbox should be selected     //*[@name="has_take_profit"]
#    contain specific class that checks the checkbox
    page should contain element     //*[contains(@class, "take_profit-checkbox__input")]//*[contains(@class, "dc-checkbox__box--active")]
    page should contain element     //*[contains(@class, "stop_loss-checkbox__input")]//*[contains(@class, "dc-checkbox__box--active")]
    checkbox should be selected     //*[@name="has_stop_loss"]
    click element       //*[contains(@class, "dc-checkbox__label") and text()="Deal cancellation"]
#    uncheck : specific class is removed
    page should not contain element     //*[contains(@class, "take_profit-checkbox__input")]//*[contains(@class, "dc-checkbox__box--active")]
    page should not contain element     //*[contains(@class, "stop_loss-checkbox__input")]//*[contains(@class, "dc-checkbox__box--active")]
    checkbox should be selected     //*[@name="has_cancellation"]
    click element       //*[contains(@class, "dc-checkbox__label") and text()="Take profit"]
    checkbox should not be selected     //*[@name="has_cancellation"]
