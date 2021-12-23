*** Settings ***
Documentation     This is the custom keywords repo
Library     RPA.Browser.Selenium
Library     OperatingSystem
Library     RPA.Tables
Library     RPA.HTTP
Library     RPA.PDF
Library     RPA.FileSystem
Library     RPA.Archive
Library     RPA.Robocorp.Vault


*** Keywords ***
Open the robot ordering website
    ${secret} =    Get Secret    credsCourse2
    go to   ${secret}[url]
    Click Element If Visible    ${modalOk}

Download CSV orders data and verify
    Set Download Directory  ${CURDIR}
    Download    ${orderCSV}   target_file=${CURDIR}/orders.csv    overwrite=True
    File Should Not Be Empty    ${CURDIR}/orders.csv
    ${orders} =    Read table from CSV    orders.csv
    Set Test Variable    ${orders}

Place order and save receipts
    [Arguments]    ${order} 
    FOR    ${row}    IN    @{order}
        Fill the order details    ${row}
        Preview the order
        Retry submitting order
        ${pdfFile} =  Store the order receipt as PDF file    ${row}
        ${scrnshot} =  Take screenshot of the ordered robot    ${row}
        Embed the screenshot to the receipt PDF file    ${pdfFile}    ${scrnshot}
        Order the next robot
    END

Fill the order details
    [Arguments]    ${row}
    Wait Until Element Is Visible    ${chooseHead}
    Select From List By Value   ${chooseHead}      ${row}[Head]
    Select Radio Button    ${chooseBody}    ${row}[Body]
    Input Text    ${numberLegs}    ${row}[Legs]
    Input Text    ${shipAddress}   ${row}[Address]

Preview the order
    Click Button    ${previewBtn}
    Wait Until Element Is Visible    ${previewImg}

Submit the order
    Click Button    ${submitOrder}
    Wait Until Element Is Visible    ${receiptDiv}

# Sometime the order button is not working in first attempt
Retry submitting order
    Wait Until Keyword Succeeds   5x    1s    Submit the order

Store the order receipt as PDF file
    [Arguments]    ${row}
    Wait Until Element Is Visible    id:receipt
    ${receipt} =    Get Element Attribute    id:receipt    outerHTML
    Html To Pdf    ${receipt}    ${CURDIR}${/}receipts${/}${row}[Order number].pdf
    ${pdfFile}    Set Variable     ${CURDIR}${/}receipts${/}${row}[Order number].pdf
    [Return]    ${pdfFile}

Take screenshot of the ordered robot
    [Arguments]    ${row}
    Screenshot    id:robot-preview-image     ${CURDIR}${/}receipts${/}${row}[Order number].png
    ${scrnshot}    Set Variable     ${CURDIR}${/}receipts${/}${row}[Order number].png
    [Return]    ${scrnshot}

Embed the screenshot to the receipt PDF file
    [Arguments]    ${pdfFile}    ${scrnshot}
    Open Pdf    ${pdfFile}
    ${receipt_list}=    Create List       ${pdfFile}     ${scrnshot}
    Add Files To Pdf   ${receipt_list}    ${pdfFile}

Order the next robot
    Wait Until Element Is Visible    ${orderAnother}
    Click Button    ${orderAnother}
    Wait Until Page Contains Element    ${modalYep}
    Click Element    ${modalYep}

Create zip archieve of receipts and screenshots
    Archive Folder With Zip    ${CURDIR}${/}receipts    receipts.zip
