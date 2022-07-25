*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     DateTime
#Resource    ../../Resource/Keywords.robot (Circular import is a bad practice ;) )

*** Variables ***

${browser}  chrome
${url}  https://demoprojects.e-connectsolutions.com/eprash-dev
#Data folder moved from resource to Qmate
${groupdata}    Resources/Data/MIS.json
@{alldates}
${date_text}
${date}

*** Keywords ***
Logintoapp
    open browser    ${url}     ${browser}
    wait until page contains    Password
    input text  id:LoginIdForShow       kritika.rsmml
    input text  id:PasswordForShow    admin
    click element  xpath://*[@id="btnLogin"]

Ledgerlisting
    go to       ${object["Ledger Listing"]["url"]}
    sleep   1s
    click element   ${object["Ledger Listing"]["Account Name"]["Locator"]["Locator1"]}
    click element   ${object["Ledger Listing"]["Account Name"]["Locator"]["Locator2"]}
    input text      ${object["Ledger Listing"]["Account Name"]["Locator"]["Locator2"]}       ${object["Ledger Listing"]["Account Name"]["Value"]}
    press key        ${object["Ledger Listing"]["Account Name"]["Locator"]["Locator2"]}   \ue007
    click element    ${object["Ledger Listing"]["Voucher Type"]["Locator"]["Locator1"]}
    click element   ${object["Ledger Listing"]["Voucher Type"]["Locator"]["Locator2"]}      #${object["Ledger Listing"]["Voucher Type"]["Value"]}
    click element   ${object["Ledger Listing"]["Unit"]["Locator"]["Locator1"]}
    input text      ${object["Ledger Listing"]["Unit"]["Locator"]["Locator2"]}      ${object["Ledger Listing"]["Unit"]["Value"]}
    Press Key       ${object["Ledger Listing"]["Unit"]["Locator"]["Locator2"]}      \ue007

    click element   ${object["Ledger Listing"]["Show Child Unit"]["Locator"]}
    Select From List By Label   ${object["Ledger Listing"]["Show Child Unit"]["Locator"]}       ${object["Ledger Listing"]["Show Child Unit"]["Value"]}
    click element   ${object["Ledger Listing"]["Status"]["Locator"]}
    Select From List By Label   ${object["Ledger Listing"]["Status"]["Locator"]}    Approved
    click element   ${object["Ledger Listing"]["View"]["Locator"]}
    Select From List By Label   ${object["Ledger Listing"]["View"]["Locator"]}      Ledger View

    #wait until page contains    Ledger List Report

Getdate

    click element       ${object["Ledger Listing"]["Date From"]["Locator"]["Locator1"]}
    click element       ${object["Ledger Listing"]["Date From"]["Locator"]["Locator2"]}
    select from list by label   ${object["Ledger Listing"]["Date From"]["Locator"]["Locator2"]}     Apr
    click element       ${object["Ledger Listing"]["Date From"]["Locator"]["Locator3"]}
    select from list by label   ${object["Ledger Listing"]["Date From"]["Locator"]["Locator3"]}     2022
    Get WebElement      ${object["Ledger Listing"]["Date From"]["Locator"]["Locator4"]}
    @{alldates} =   Get WebElements    ${object["Ledger Listing"]["Date From"]["Locator"]["Locator4"]}
    FOR     ${date}     IN       @{all dates}
            ${date_text} =    Get Text   ${date}
            Run Keyword If        ${date_text} == '1'   Clicktodate  ${date}
    END

    ${currentdate}=  Get Current Date
    ${convert}=     Convert Date    ${currentdate}      result_format=%d-%b-%Y
    Log         ${convert}      console=yes

Clicktodate
    [Arguments]  ${date}
    click element       ${date}
    #sleep   3s
Load json
    ${data}     Get File    ${groupdata}
    ${object}=   Evaluate    json.loads('''${data}''')   json
    set global variable     ${object}
    Log Many    &{object}       console=yes

Viewbutton
     click element       ${object["Ledger Listing"]["Viewbutton"]["Locator"]} 

check error
    wait until page does not contain    Sorry, an error occurred while processing your request      15s
    capture sceenshot
    ${check} get text  //tbody//tr//td[@class='center']



