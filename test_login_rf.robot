*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//*[text()='Sign in']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${SIGNOUTBUTTON}     xpath=//*[text()='Sign out']
${VALIDATIONTEXT}       xpath=/html/body/div/form/div/div[1]/div[3]/span
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${ADDPLAYERBUTTON}      xpath=//*[text()='Add player']
${NAMEINPUT}        xpath=/html/body/div/div[1]/main/div[2]/form/div[2]/div/div[2]/div/div/input
${SURNAMEINPUT}     xpath=/html/body/div/div[1]/main/div[2]/form/div[2]/div/div[3]/div/div/input
${AGEINPUT}     xpath=/html/body/div/div[1]/main/div[2]/form/div[2]/div/div[7]/div/div/input
${MAINPOSITIONINPUT}        xpath=/html/body/div/div[1]/main/div[2]/form/div[2]/div/div[11]/div/div/input
${SUBMITPLAYERBUTTON}       xpath=//*[text()='Submit']
${CHANGELANGUAGEBUTTON}     xpath=/html/body/div/form/div/div[2]/div/div
${POLSKIBUTTON}     xpath=/html/body/div[2]/div[3]/ul/li[1]
${ZALOGUJBUTTON}        xpath=//*[text()='Zaloguj']
${PLAYERSBUTTON}        xpath=//*[text()='Players']
${SEARCHBAR}        xpath=//*[@id="__next"]/div[1]/header/div/div[1]/div[2]/input

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    Click on the Sign out button
     #log in with valid login and invalid password
    Type in email
    Type in invalid password
    Click on the Sign in button
    Find validation text
    [Teardown]  Close Browser

Add a player
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Add player button
    Type in name
    Type in surname
    Type in age
    Type in main position
    Click on the Submit player button
    Assert add player
    [Teardown]  Close Browser

Change language
    Open login page
    Click on the Language button
    Click on the Polski button
    Assert Zaloguj button
    [Teardown]  Close Browser

Players page
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Players button
    Assert players page
    Click on the Sign out button
    [Teardown]  Close Browser


*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text    ${EMAILINPUT}     user07@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}      Test-1234
Click on the Sign in button
    Click Element    ${SIGNINBUTTON}
Assert dashboard
    Wait Until Element Is Visible       ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     alert.png
Click on the Sign out button
    Click Element       ${SIGNOUTBUTTON}
Type in invalid password
    Input Text      ${PASSWORDINPUT}    Invalid-1234
Find validation text
    Wait Until Element Is Visible       ${VALIDATIONTEXT}
    Capture Page Screenshot      validation.png
Click on the Add player button
    Wait Until Element Is Visible       ${ADDPLAYERBUTTON}
    Click Element    ${ADDPLAYERBUTTON}
Assert add player
    Title Should Be     Add player
Type in name
    Wait Until Element Is Visible    ${NAMEINPUT}
    Input Text      ${NAMEINPUT}        Edward
Type in surname
    Input Text    ${SURNAMEINPUT}       Ziemba
Type in age
    Input Text    ${AGEINPUT}       25.12.1995
Type in main position
    Input Text    ${MAINPOSITIONINPUT}      Goalkeeper
Click on the Submit player button
    Click Element    ${SUBMITPLAYERBUTTON}
Click on the Language button
    Click Element    ${CHANGELANGUAGEBUTTON}
Click on the Polski button
    Click Element    ${POLSKIBUTTON}
Assert Zaloguj button
    Wait Until Element Is Visible    ${ZALOGUJBUTTON}
    Capture Element Screenshot    ${ZALOGUJBUTTON}      zaloguj.png
Click on the Players button
    Wait Until Element Is Visible       ${PLAYERSBUTTON}
    Click Element       ${PLAYERSBUTTON}
Assert players page
    Wait Until Element Is Visible       ${SEARCHBAR}
    Title Should Be     Players (4392) page 1

