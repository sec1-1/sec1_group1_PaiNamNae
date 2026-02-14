*** Settings ***
Resource    ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT01-Login Success
    Login With Valid User
    Dashboard Should Be Visible

UAT03-Login Blacklist
    Login With Blacklisted User
    Error Message Should Be Visible
