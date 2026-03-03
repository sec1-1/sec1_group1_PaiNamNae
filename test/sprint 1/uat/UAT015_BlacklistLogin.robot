*** Settings ***
Library    SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-015: Login
    Open Web Page
    Click Element                       xpath=//a[@href='/login']
    Wait Until Location Contains        /login              10s
    Input Text                          id=identifier       ${BLACKLIST_USER}
    Wait Until Element Is Visible       id=password         10s
    Input Text                          id=password         ${BLACKLIST_PASS}
    Click Button                        xpath=//button[@type='submit']

    # ==== Expected Results ====
    Sleep                               2s
    Page Should Contain                 เข้าสู่ระบบไม่สำเร็จ
