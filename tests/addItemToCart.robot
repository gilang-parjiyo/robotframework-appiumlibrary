*** Settings ***
Documentation     This test suite check add product to cart then remove product
Library           AppiumLibrary    run_on_failure=Nothing
Resource          ../keywords/resource.robot
Test Setup        Test Setup Add To Cart
Test Teardown     End App Test
Test Template     Add Item To Cart

*** Test Cases ***
Add To Cart
    [Documentation]    This test case use data driven testing
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
# Remove Product from cart
    Wait Click Element    ${REMOVE PRODUCT}
    Wait Until Page Does Not Contain Element    ${PRODUCT CART}
# Continue shooping
    Wait Click Element    ${CONTINUE SHOOPING}
