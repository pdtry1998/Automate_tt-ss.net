*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn
Library     Collections
Library         ScreenCapLibrary
Library         RequestsLibrary
Library           JSONLibrary
Library            Zoomba.APILibrary

#*** Variables ***
#${General_TimeOut}      10s

*** Keywords ***
Click Web Element
    [Arguments]    ${Locator}   ${Timeout}=${General_TimeOut}
    [Documentation]    Click element identified by locator.
    ...
    ...    *Format keyword*
    ...
    ...    Click Web Element | ${Locator} | ${Index}=None | ${Timeout}=${General_TimeOut}
    ...
    Wait Until Element Is Visible    ${Locator}     ${Timeout}
    Click Element    ${Locator}

Web Element Should Be Visible
    [Arguments]    ${Locator}   ${Timeout}=${General_TimeOut}   ${msg}=None
    [Documentation]    Verify that the element is visible.
    ...
    ...    *Format keyword*
    ...
    ...    Web Element Should Be Visible | ${Locator} | ${Timeout}=${General_TimeOut}
    ...
    Wait Until Element Is Visible    ${Locator}    ${Timeout}

Input Web Text
    [Arguments]    ${Locator}    ${Text}    ${Timeout}=${General_TimeOut}
    [Documentation]    Input text into text field identified by locator.
    ...    *Format keyword*
    ...
    ...    Input Web Text | ${Locator} | ${Text} | ${Timeout}=${General_TimeOut}
    ...
    Web Element Should Be Visible    ${Locator}    ${Timeout}
    input text    ${Locator}    ${Text}

Get Web Text
    [Arguments]    ${Locator}    ${Timeout}=${General_TimeOut}
    [Documentation]    Get text by returns the text value of element.
    ...
    ...    *Format keyword*
    ...
    ...    Get Web Text | ${Locator} | ${Timeout}=${General_TimeOut}
#    ${result}    BuiltIn.Run Keyword And Return Status    Wait Until Element Is Visible    ${Locator}    ${Timeout}
#    BuiltIn.Run Keyword If    '${result}'=='False'    Wait Until Page Contains Element    ${Locator}    ${Timeout}
#    Comment    ${Text}    seleniumlibrary.Get Text    ${Locator}
    Web Element Should Be Visible       ${Locator}
    ${Text}    Wait Until Keyword Succeeds    3    1    Get Text    ${Locator}
    RETURN    ${Text}

Get Text And Verify Text
    [Arguments]    ${Locator}       ${TextExpected}
    [Documentation]     Get text compare expect
    ...
    ...    *Format keyword*
    ...
    ...    Get Web Text | ${Locator} | ${Timeout}=${General_TimeOut}
    Web Element Should Be Visible       ${Locator}
    ${TextActual}     Get Web Text        ${Locator}
    Should Be Equal    ${TextActual}    ${TextExpected}     msg=Actual text was ${TextActual} but expected was ${TextExpected}

Get Value From Json And Set Variable
    [Arguments]  ${json}        ${json_path}    ${index}=0
     ${id}      get value from json    ${json}      ${json_path}
     ${value}      set variable   ${id}[${index}]
     RETURN   ${value}