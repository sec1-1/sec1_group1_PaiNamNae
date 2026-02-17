*** Settings ***
Library    SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-003 : Step 01 Open Web Page
    Open Web Page

    # ==== Expected Results ====
    Wait Until Element Is Visible       xpath=//h1[contains(.,'เดินทางร่วมกัน')]

UAT-003 : Step 02 Go to Login Page
    Open Web Page
    Click Element                       xpath=//a[@href='/login']
    Sleep    5s
    # ==== Expected Results ====
    Location Should Contain             /login

UAT-003 : Step 03 Login Success
    Open Web Page
    Click Element                       xpath=//a[@href='/login']
    Wait Until Location Contains        /login              10s
    Input Text                          id=identifier       ${VALID_USER}
    Wait Until Element Is Visible       id=password         10s
    Input Text                          id=password         ${VALID_PASS}
    Click Button                        xpath=//button[@type='submit']
    Sleep    5s
    
    # ==== Expected Results ====
    Location Should Contain             /login
    Page Should Contain