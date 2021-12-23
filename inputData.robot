*** Settings ***
Documentation   This file holds the variables and input data used by robot

*** Variables ***
# ${browser} =    chrome
${baseUrl} =    https://robotsparebinindustries.com/#/robot-order
${orderCSV} =   https://robotsparebinindustries.com/orders.csv

# # Filepath
# ${projDir} =    C:/Users/09433J744/Documents/Robots/Robocorp-Course_2
# ${outputDir} =  C:/Users/09433J744/Documents/Robots/Robocorp-Course_2/output

# Locators
${modalOk} =        //div[@class='modal-body']//button[text()='OK']
${modalYep} =       //div[@class='modal-body']//button[text()='Yep']
${chooseHead} =     css:select#head
${chooseBody} =     body
${numberLegs} =     //input[@placeholder='Enter the part number for the legs']
${shipAddress} =    css:input#address
${previewBtn} =     id:preview
${previewImg} =     id:robot-preview-image
${submitOrder} =    id:order
${receiptDiv} =     id:receipt
${orderAnother} =   css:button#order-another

