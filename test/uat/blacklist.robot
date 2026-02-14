*** Settings ***
Library    SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT02-Admin add User to Blacklist
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page