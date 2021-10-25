*** Settings ***
Documentation    Contain all template keywords
Library          AppiumLibrary                    run_on_failure=Nothing

*** Keywords ***
Wait Click Element
    [Arguments]                      ${element}
    Wait Until Element Is Visible    ${element}
    Click Element                    ${element}

Clear Input Text
    [Arguments]    ${locator}    ${text}
    Clear Text     ${locator}
    Input Text     ${locator}    ${text}
# Scroll FId Click

Scroll Find Click
    [Documentation]    Swipe until find locator
    [Arguments]        ${locator}
    FOR                ${counter}                       IN RANGE                     0             10
    Swipe              700                              1500                         700           100
    ${status}          Run Keyword And Return Status    Element Should Be Visible    ${locator}    loglevel=NONE
    Run Keyword If     ${status}                        Exit For Loop
    ${counter}         Set Variable                     ${counter}+1
    END
    Click Element      ${locator}

Scroll Find
    [Documentation]    Swipe until find locator
    [Arguments]        ${locator}
    FOR                ${counter}                       IN RANGE                     0             10
    Swipe              700                              1500                         700           100
    ${status}          Run Keyword And Return Status    Element Should Be Visible    ${locator}    loglevel=NONE
    Run Keyword If     ${status}                        Exit For Loop
    ${counter}         Set Variable                     ${counter}+1
    END

Element Not Found Scroll
    [Documentation]    Find element, if available click element, if element not available scroll.
    [Arguments]        ${locator}
    ${status}          Run Keyword And Return Status                                                 Element Should Be Visible    ${locator}
    IF                 ${status} == ${False}
    Scroll Find        ${locator}
    END

Element Not Found Scroll Click
    [Documentation]      Find element, if available click element, if element not available scroll.
    [Arguments]          ${locator}
    ${status}            Run Keyword And Return Status                                                 Element Should Be Visible    ${locator}
    IF                   ${status} == ${True}
    Click Element        ${locator}
    ELSE
    Scroll Find Click    ${locator}
    END
