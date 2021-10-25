*** Settings ***
Library     AppiumLibrary
Resource    resource.robot

*** Variables ***
${APP}    ${EXECDIR}/SauceLabs.apk



*** Keywords ***
Begin App Test
    Open Application                 http://127.0.0.1:4725/wd/hub
    ...                              platformName=Android
    ...                              app=${APP}
    ...                              automationName=UIAutomator2
    ...                              deviceName=Pixel
    ...                              udid=emulator-5554
    ...                              noReset=true
    ...                              autoGrantPermission=true
    ...                              appWaitActivity=com.swaglabsmobileapp.MainActivity
    Wait Until Element Is Visible    ${USERNAME FIELD}


End App Test
    Sleep                     2
    Close All Applications

Test Setup Add To Cart
    Begin App Test
    User Login


