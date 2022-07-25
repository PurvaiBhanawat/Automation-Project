*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${url}      https://demoprojects.e-connectsolutions.com/eprash-test

*** Test Cases ***
TestingInputBox
     open browser   ${url}  ${browser}
     Maximize Browser Window
     title should be   E-Prashasan
     ${userID_txt}      set variable     id:LoginIdForShow
     #to store variable, if we dont do this then we will have to write it ID everywhere.
     element should be visible  ${userID_txt}
     element should be enabled  ${userID_txt}

     input text  ${userID_txt}  econnect
     sleep 4s
     clear element text  ${userID_txt}

     close browser



