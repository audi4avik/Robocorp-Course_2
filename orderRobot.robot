*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordechromered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.

Resource    inputData.robot
Resource    orderKeywords.robot
Resource    Common.robot

Test Setup    Common.Begin Test
Test Teardown    Common.End Test


*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot ordering website
    Download CSV orders data and verify
    Place order and save receipts   ${orders}
    Create zip archieve of receipts and screenshots
