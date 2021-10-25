*** Settings ***
Documentation     This test suite check add product to cart then remove product
Library           AppiumLibrary    run_on_failure=Nothing
Resource          ../keywords/resource.robot
Test Setup        Test Setup Add To Cart
Test Teardown     End App Test
Test Template     Add Item To Cart

*** Test Cases ***
Add To Cart
    [Documentation]    Mokcing user add item to cart
    ${BACKPACK}
    ${BIKE LIGHT}
    ${BOLT T-SHIRT}
    ${FLEECE JACKET}
    ${ONESIE}
    ${TSHIRT RED}

*** Variables ***
#Element
${ADD CART}       xpath=//android.view.ViewGroup[@content-desc="test-ADD TO CART"]
${CART}           xpath=//android.view.ViewGroup[@content-desc="test-Cart"]
${CONTINUE SHOOPING}    xpath=//android.view.ViewGroup[@content-desc="test-CONTINUE SHOPPING"]
${PRODUCT CART}    xpath=//android.view.ViewGroup[@content-desc="test-Description"]/android.widget.TextView[1]
${REMOVE PRODUCT}    xpath=//android.view.ViewGroup[@content-desc="test-REMOVE"]
# Product
${BACKPACK}       xpath=//android.widget.TextView[@text="Sauce Labs Backpack"]
${BIKE LIGHT}     xpath=//android.widget.TextView[@text="Sauce Labs Bike Light"]
${BOLT T-SHIRT}    xpath=//android.widget.TextView[@text="Sauce Labs Bolt T-Shirt"]
${FLEECE JACKET}    xpath=//android.widget.TextView[@text="Sauce Labs Fleece Jacket"]
${ONESIE}         xpath=//android.widget.TextView[@text="Sauce Labs Onesie"]
${TSHIRT RED}     xpath=//android.widget.TextView[@text="Test.allTheThings() T-Shirt (Red)"]
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

*** Keywords ***
Add Item To Cart
    [Documentation]    Get all item available in the list
    [Arguments]    ${product}
# Enter product detail
    Sleep    2.5
    Element Not Found Scroll    ${product}
    Click Element    ${product}
# Add product to cart
    Element Not Found Scroll Click    ${ADD CART}
    Wait Click Element    ${CART}
    Wait Until Element Is Visible    ${PRODUCT CART}
# Verify product quantity product
    Wait Until Element Is Visible    ${QTY}
    ${qty product}    Get Text    ${QTY}
    Should Be Equal    ${qty product}    1
# Checkout product
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
