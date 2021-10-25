*** Settings ***
Documentation     This test suite mock user checkout behaviour from product list
Library           String
Library           Collections
Library           AppiumLibrary    run_on_failure=Nothing
Resource          ../keywords/resource.robot
Test Setup        Test Setup Add To Cart
Test Teardown     End App Test

*** Test Cases ***
Add To Cart
    [Documentation]    Mokcing user checkout from list
    Add Item List To Cart
    Check Product In Cart
    Checkout Product

*** Variables ***
#Element
${ADD CART}       xpath=//android.view.ViewGroup[@content-desc="test-ADD TO CART"]
${CART}           xpath=//android.view.ViewGroup[@content-desc="test-Cart"]
${CONTINUE SHOOPING}    xpath=//android.view.ViewGroup[@content-desc="test-CONTINUE SHOPPING"]
${PRODUCT CART}    xpath=//android.view.ViewGroup[@content-desc="test-Description"]/android.widget.TextView[1]
${REMOVE PRODUCT}    xpath=//android.view.ViewGroup[@content-desc="test-REMOVE"]
# Product
${QTY}            xpath=//android.view.ViewGroup[@content-desc="test-Amount"]/android.widget.TextView
# Navigation
${BACK TO PRODUCT}    xpath=//android.view.ViewGroup[@content-desc="test-BACK TO PRODUCTS"]
# Checkout
${CHECKOUT INFO TITLE}    CHECKOUT: INFORMATION
${CHECKOUT INFO NAME}    accessibility_id=test-First Name
${CHECKOUT INFO LASTNAME}    accessibility_id=test-Last Name
${CHECKOUT INFO POSTAL CODE}    accessibility_id=test-Zip/Postal Code
${CHECKOUT INFO CONTINUE}    accessibility_id=test-CONTINUE
${CHECKOUT INFO FINISH}    accessibility_id=test-FINISH
${CHECKOUT COMPLETED}    THANK YOU FOR YOU ORDER
${CHECKOUT GO HOME}    accessibility_id=test-BACK HOME
${BTN CHECKOUT}    accessibility_id=test-CHECKOUT
${CHECKOUT OVERVIEW}    CHECKOUT: OVERVIEW
#New
${TEXT PRODUCT}    xpath=(//android.widget.TextView[@content-desc="test-Item title"])[1]
${TOGGLE VIEW}    xpath=//android.view.ViewGroup[@content-desc="test-Toggle"]
${FIRST PRODUCT}    xpath=(//android.view.ViewGroup[@content-desc="test-ADD TO CART"])[1]
${AMOUNT PRODUCT ON CART}    xpath=//android.view.ViewGroup[@content-desc="test-Cart"]/android.view.ViewGroup/android.widget.TextView
#Cart
@{LIST PRODUCT}

*** Keywords ***
Add Item List To Cart
    [Documentation]    Get all item available in the list
# Enter page products
    Wait Until Page Contains    PRODUCTS
# Toggle view
    Click Element    ${TOGGLE VIEW}
    FOR    ${counter}    IN RANGE    1    7    1
# Get product text then add to cart
        Sleep    1.5
        Element Not Found Scroll    ${FIRST PRODUCT}
        ${text}    Get Text    ${TEXT PRODUCT}
        Append To List    ${LIST PRODUCT}    ${text}    #Append product name to list
        Click Element    ${FIRST PRODUCT}
# Verify amount product
        Sleep    0.5
        ${amount product}    Get Text    ${AMOUNT PRODUCT ON CART}
        ${value}    Convert To Integer    ${amount product}
        Should Be Equal    ${value}    ${counter}
    END

Check Product In Cart
    [Documentation]    Check all product in cart
    Click Element    ${CART}
    FOR    ${index}    ${element}    IN ENUMERATE    @{LIST PRODUCT}
        Element Not Found Scroll    //android.widget.TextView[@text="${element}"]
        Element Not Found Scroll Click    ${CART}
    END

Checkout Product
    [Documentation]    Checkout Product
    Element Not Found Scroll Click    ${BTN CHECKOUT}
# Fill Checkout info
    Wait Until Page Contains    ${CHECKOUT INFO TITLE}
    Input Text    ${CHECKOUT INFO NAME}    Gilang
    Input Text    ${CHECKOUT INFO LASTNAME}    Romadhan
    Input Text    ${CHECKOUT INFO POSTAL CODE}    53283
    Click Element    ${CHECKOUT INFO CONTINUE}
# Checkout overview
    Wait Until Page Contains    ${CHECKOUT OVERVIEW}
    Element Not Found Scroll Click    ${CHECKOUT INFO FINISH}
# Checkout Complete
    Wait Until Page Contains    ${CHECKOUT COMPLETED}
    Click Element    ${CHECKOUT GO HOME}
    Wait Until Page Contains    PRODUCTS
