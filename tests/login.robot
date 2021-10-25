*** Settings ***
Documentation     This test suite check user login behaviour
Library           AppiumLibrary    run_on_failure=Nothing
Resource          ../keywords/resource.robot
Test Setup        Begin App Test
Test Teardown     End App Test
Test Template     Login Behaviour

*** Test Cases ***
Login Sauce Labs
    Missing Password    gilang    ${EMPTY}    ${MSG MISS PASSWORD}
    Missing Username    ${EMPTY}    Password    ${MSG MISS USERNAME}
    Wrong Username    users    ${PASS}    ${MSG WRONG CREDENTIAL}
    Wrong Password    ${USER}    password    ${MSG WRONG CREDENTIAL}
    Locked User    ${LOCK USER}    ${PASS}    ${MSG LOCKED USER}
    Problem User    ${PROBLEM USER}    ${PASS}    ${EMPTY}
    Correct Credential    ${USER}    ${PASS}    ${EMPTY}

*** Variables ***
# Element
${USERNAME FIELD}    accessibility_id=test-Username    #//android.widget.EditText[@content-desc="test-Username"]
${PASSWORD FIELD}    accessibility_id=test-Password    #//android.widget.EditText[@content-desc="test-Password"]
${BTN LOGIN}      accessibility_id=test-LOGIN    #//android.view.ViewGroup[@content-desc="test-LOGIN"]
${ERROR MESSAGE}    //android.view.ViewGroup[@content-desc="test-Error message"]/android.widget.TextView    #accessibility_id=test-Error message
# Error Message
${MSG MISS PASSWORD}    Password is required
${MSG MISS USERNAME}    Username is required
${MSG WRONG CREDENTIAL}    Username and password do not match any user in this service.
${MSG LOCKED USER}    Sorry, this user has been locked out.
# Credential
${PASS}           secret_sauce
${USER}           standard_user
${LOCK USER}      locked_out_user
${PROBLEM USER}    problem_user
# Home Page
${MENU}           accessibility_id=test-Menu    #//android.view.ViewGroup[@content-desc="test-Menu"]

*** Keywords ***
Login Behaviour
    [Documentation]    Mocking user login behaviour
    [Arguments]    ${case}    ${username}    ${pass}    ${message}
    Log To Console    Case ${case}
    Clear Input Text    ${USERNAME FIELD}    ${username}
    Clear Input Text    ${PASSWORD FIELD}    ${pass}
    Click Element    ${BTN LOGIN}
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    Menu    2
# Check behaviour invalid credential
    IF    ${status} == ${False}
        Element Should Contain Text    ${ERROR MESSAGE}    ${message}
    ELSE
# Check behaviour valid credential
        Wait Until Element Is Visible    ${MENU}
        Go Back
    END

*** Comments ***
This test suit test user login behaviour
