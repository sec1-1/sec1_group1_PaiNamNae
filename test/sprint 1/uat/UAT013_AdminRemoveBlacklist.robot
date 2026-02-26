*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-013 Admin Remove Blacklist ====
UAT-012-01 : Admin Login
    Admin Login
    Sleep    2s

    # ==== Expected Results ====
    Dashboard Admin Should Be Visible

UAT-013-02 : Admin Remove Blacklist
    Click Element    xpath=//span[normalize-space()="System"]
    Sleep    2s
    Click Element    xpath=//a[@href="/admin/users"]
    Sleep    2s
    Click Element    xpath=(//table//tbody/tr)[1]//button[@title="ยกเลิกการระงับ"]
    Sleep    2s
    Click Button     xpath=//button[normalize-space()="ยกเลิกการระงับ"]
    
    # ==== Expected Results ====
    Sleep                           2s
    Wait Until Element Is Visible       xpath=//h3[normalize-space()="คืนสิทธิ์การใช้งานสำเร็จ"]
    Element Should Be Visible           xpath=//h3[normalize-space()="คืนสิทธิ์การใช้งานสำเร็จ"]