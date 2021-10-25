*** Settings ***
Documentation     This test suite mock user add cart behaviour
Library           AppiumLibrary    run_on_failure=Nothing
Resource          ../keywords/resource.robot
Test Setup        Begin App Test
Test Teardown     End App Test

*** Test Cases ***
Add To Cart
    [Documentation]    Test case mocking user add cart behaviour
    User Login
    Get Item List

*** Variables ***
#Element
${MENU}           accessibility_id=test-Menu    #//android.view.ViewGroup[@content-desc="test-Menu"]
${LOGOUT}         accessibility_id=test-LOGOUT    #//android.view.ViewGroup[@content-desc="test-LOGOUT"]
${LIST ITME}      xpath=//android.widget.ScrollView[@content-desc="test-PRODUCTS"]//android.view.ViewGroup[@content-desc="test-Item"]
${ADD CART}       xpath=(//android.view.ViewGroup[@content-desc="test-ADD TO CART"])
${ADD CART FIRST ITEM}    xpath=(//android.view.ViewGroup[@content-desc="test-ADD TO CART"])[1]
${DESCRIPTION ITEM}    xpath=(//android.widget.TextView[@content-desc="test-Item title"])[1]
${CART}           xpath=//android.view.ViewGroup[@content-desc="test-Cart"]
${CONTINUE SHOOPING}    xpath=//android.view.ViewGroup[@content-desc="test-CONTINUE SHOPPING"]

*** Keywords ***
Get Item List
    [Documentation]    Get all item available in the list
    @{LIST}    Get Webelements    ${ADD CART}
    ${length}    Get Length    ${LIST}
    FOR    ${counter}    IN RANGE    1    ${length}+1    1
# Add first item into cart
        Wait Until Element Is Visible    ${ADD CART FIRST ITEM}
        ${text home}    Get Text    xpath=(//android.widget.TextView[@content-desc="test-Item title"])[${counter}]
        Click Element    ${ADD CART FIRST ITEM}
# Check cart item 
        Click Element    ${CART}
        Wait Until Element Is Visible    xpath=(//android.view.ViewGroup[@content-desc="test-Description"])[${counter}]
        ${text cart}    Get Text    xpath=(//android.view.ViewGroup[@content-desc="test-Description"])[${counter}]/android.widget.TextView[1]
        Should Be Equal    ${text home}    ${text cart}
        ${status}    Run Keyword And Return Status    Element Should Be Visible    ${CONTINUE SHOOPING}
        IF    ${status} == ${True}
            Click Element    ${CONTINUE SHOOPING}
        ELSE
            Scroll Find    ${CONTINUE SHOOPING}
        END
    END
