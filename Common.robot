*** Settings ***
Documentation    This file holds the setup and teardown methods
Library    RPA.Browser.Selenium
Library    RPA.Dialogs
Library    Dialogs

*** Keywords ***
Begin Test
    ${browser} =	Get Value From User      Please enter the desired browser to start!
    Open Browser   about:none    ${browser}  
    Maximize Browser Window

End Test
    Close Browser