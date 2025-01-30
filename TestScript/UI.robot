*** Settings ***
Resource    ../Keyword/UI_Keyword.robot


*** Variables ***
${General_TimeOut}      10s

${URL}            https://www.saucedemo.com/
${BROWSER}      chrome

${USERNAME}       standard_user
${PASSWORD}       secret_sauce

@{ITEM_NAMES}     Sauce Labs Bolt T-Shirt    allTheThings() T-Shirt (Red)      Backpack     flashlight
@{BUTTON_CONTAINS}    sauce-labs-bolt-t-shirt    test.allthethings()-t-shirt-(red)      sauce-labs-backpack     flashlight

@{ITEMS_LIST}       ${EMPTY}

${Bolt_T-Shirt}    Sauce Labs Bolt T-Shirt
${T-Shirt_Red}    Test.allTheThings() T-Shirt (Red)
${expected_price}       34.54

${VIDEO_PATH}       output_video.mp4

*** Keywords ***
Login to sauceDemo
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Web Element Should Be Visible   ${LOGIN_BUTTON}
    Input Web Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Web Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Web Element       ${LOGIN_BUTTON}
    Get Text And Verify Text        ${PRODUCT_TITLE}         ${PRODUCT}

Input information and click continue
    # ใส่ค่า Firstname = Teerayut
    Input Web Text    ${FIRSTNAME_FIELD}     Teerayut
    # ใส่ค่า Lastname = Saetee
    Input Web Text    ${LASTNAME_FIELD}      Saetee
    # ใส่ค่า Postcode = 83000
    Input Web Text    ${POSTALCODE_FIELD}    83000
    # กดปุ่ม Continue
    Click Web Element    ${CONTINUE_BUTTON}

*** Test Cases ***
Login to SauceDemo
    Start Video Recording
    Login to sauceDemo
    Sleep   2s
    Stop Video Recording
    [Teardown]    Close Browser

Add item to cart
    Login to sauceDemo
    Add Items To Cart
    Click Web Element    ${SHOPPINGCART_PATH}
    Get Text And Verify Text    ${YOURCART_TITLE}        ${YOURCART}
    [Teardown]    Close Browser

Remove backpack
    Login to sauceDemo
    Add Items To Cart
    Click Web Element    ${SHOPPINGCART_PATH}
    Remove Backpack
    Verify Items After Remove Backpack
    [Teardown]    Close Browser

Proceed to Checkout and Enter Information
    Start Video Recording
    Login to sauceDemo
    Add Items To Cart
    Click Web Element    ${SHOPPINGCART_PATH}
    Remove Backpack
    Click Web Element    ${CHECKOUT_BUTTON}
    Get Text And Verify Text        ${YOURINFORMATION_TITLE}     ${INFORMATION}
    Input information and click continue
    Get Text And Verify Text    ${OVERVIEW_TITLE}        ${OVERVIEW}
    # verify items again and verify price with tax
    Verify Items After Remove Backpack
    Verify Price With Tax
    Click Web Element       ${FINISH_BUTTON}
    Get Text And Verify Text        ${COMPLETE_TITLE}       ${COMPLETE}
    Get Text And Verify Text    ${TANKYOU_PATH}     ${THANKYOU}
    Stop Video Recording