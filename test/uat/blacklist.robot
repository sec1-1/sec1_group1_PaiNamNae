*** Settings ***
Suite Setup    Admin Login
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT02-Admin add User to Blacklist
    Go To User Management Page