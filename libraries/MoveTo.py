from appium.webdriver.common.touch_action import TouchAction
from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword


@keyword(name='Move To')
def moveTo(locator, coordinate1, coordinate2):
    appiumlib = BuiltIn().get_library_instance('AppiumLibrary')
    driver = appiumlib._current_application()
    element = appiumlib._element_find(locator, True, True)
    action = TouchAction(driver)
    action.tap(element)
    action.perform()
