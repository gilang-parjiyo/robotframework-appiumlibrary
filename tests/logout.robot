*** Settings ***
Documentation     This test suite check user logout behaviour
Library           AppiumLibrary    run_on_failure=Nothing
Resource          ../keywords/resource.robot
Test Setup        Begin App Test
Test Teardown     End App Test
Test Template     Login Behaviour

*** Test Cases ***
Login Sauce Labs
    Problem User    ${PROBLEM USER}    ${PASS}
    Correct Credential    ${USER}    ${PASS}

*** Variables ***
# Element
${USERNAME FIELD}    accessibility_id=test-Username    #//android.widget.EditText[@content-desc="test-Username"]
${PASSWORD FIELD}    accessibility_id=test-Password    #//android.widget.EditText[@content-desc="test-Password"]
${BTN LOGIN}      accessibility_id=test-LOGIN    #//android.view.ViewGroup[@content-desc="test-LOGIN"]
# Credential
${PASS}           secret_sauce
${USER}           standard_user
${LOCK USER}      locked_out_user
${PROBLEM USER}    problem_user
# Home Page
${MENU}           accessibility_id=test-Menu    #//android.view.ViewGroup[@content-desc="test-Menu"]
${LOGOUT}         accessibility_id=test-LOGOUT    #//android.view.ViewGroup[@content-desc="test-LOGOUT"]

*** Keywords ***
Login Behaviour
    [Documentation]    Mocking user login behaviour
    [Arguments]    ${case}    ${username}    ${pass}
    Log To Console    Case ${case}
    Clear Input Text    ${USERNAME FIELD}    ${username}
    Clear Input Text    ${PASSWORD FIELD}    ${pass}
    Click Element    ${BTN LOGIN}
    Wait Click Element    ${MENU}
    Wait Click Element    ${LOGOUT}
    Wait Until Element Is Visible    ${BTN LOGIN}
