*** Settings ***
Resource    keywords.robot
Resource    setup.robot
Resource    template.robot

*** Variables ***
# Element
${USERNAME FIELD}    accessibility_id=test-Username    #//android.widget.EditText[@content-desc="test-Username"]
${PASSWORD FIELD}    accessibility_id=test-Password    #//android.widget.EditText[@content-desc="test-Password"]
${BTN LOGIN}         accessibility_id=test-LOGIN       #//android.view.ViewGroup[@content-desc="test-LOGIN"]
# Credential
${PASS}    secret_sauce
${USER}    standard_user
# Home Page
${MENU}    accessibility_id=test-Menu    #//android.view.ViewGroup[@content-desc="test-Menu"]

*** Keywords ***
User Login
    Clear Input Text                 ${USERNAME FIELD}    ${USER}
    Clear Input Text                 ${PASSWORD FIELD}    ${PASS}
    Click Element                    ${BTN LOGIN}
    Wait Until Element Is Visible    ${MENU}

