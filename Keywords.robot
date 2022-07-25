*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     DateTime
Resource    PageObject/Ledgerlist.robot
Resource    PageObject/PayrollMIS.robot
Resource    PageObject/IncomeTax.robot
Resource    PageObject/GSTR1.robot

*** Variables ***
${browser}  chrome
${url}  https://demoprojects.e-connectsolutions.com/eprash-test
@{alldates}
${date_text}
${date}
${groupdata}     Resources/Data/MIS.json

*** Keywords ***
Go to ERP 1
    [Documentation]  Open ERP Login page
    Ledgerlist.Logintoapp
    Ledgerlist.Load json

Open Ledger Listing Report
    [Documentation]  Open Ledger Listing report and select filter
    Ledgerlist.Ledgerlisting
    LedgerList.GetDate
    Ledgerlist.Viewbutton

Verify Report
    [Documentation]  Verify if Report contains any error
    Ledgerlist.check error

Login to ERP Page
    PayrollMIS.Logintoapp
    PayrollMIS.Load json

Salary Report
    PayrollMIS.Open Report
    PayrollMIS.Fill Salary Report
    PayrollMIS.View Button
    PayrollMIS.Verify Report

Arrear Report
    PayrollMIS.Open Report
    PayrollMIS.Fill Arrear Report
    PayrollMIS.View Button
    PayrollMIS.Verify Report

Leave Encashment Report
    PayrollMIS.Open Report
    PayrollMIS.Fill Leave Encashment Report
    PayrollMIS.View Button
    PayrollMIS.Verify Report

Go to ERP page
    IncomeTax.Logintoapp1
    IncomeTax.Load json1

Income Tax Report
    IncomeTax.Income Tax Deduction

Go to ERP 2
    GSTR1.Logintoapp
    GSTR1.Load json

Open GSTR1 Sales Report
    GSTR1.Open Report
    GSTR1.Fill GSTR1 Report
    GSTR1.Viewbutton