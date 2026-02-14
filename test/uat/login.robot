*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT01-Login Success
    Login With Valid User
    
    # ==== Expected Results ====
    Dashboard Should Be Visible