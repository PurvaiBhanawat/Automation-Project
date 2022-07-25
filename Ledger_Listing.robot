*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     DateTime
Library     Screenshot
Resource    ../../Resources/Keywords.robot

*** Test Cases ***
Ledger Listing Report
    [Documentation]   Ledger Listing Report Testing
    [Tags]  admin Ledger Listing MIS
    Keywords.Go to ERP 1
    Keywords.Open Ledger Listing Report
    Keywords.Verify Report