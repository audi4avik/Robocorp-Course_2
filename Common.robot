*** Settings ***
Documentation    This file holds the setup and teardown methods
Library    RPA.Browser.Selenium
Library    Dialogs

*** Keywords ***
Begin Test
    ${browser} =	Get Value From User      Please enter the desired browser to start!
    Open Available Browser    browser_selection=${browser}  
    Maximize Browser Window

End Test
    Close Browser