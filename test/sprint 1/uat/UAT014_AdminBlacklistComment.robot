*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-012 Admin Give Blacklist and Select Reason ====
UAT-012-01 : Admin Login
    Admin Login
    Sleep    2s

    # ==== Expected Results ====
    Dashboard Admin Should Be Visible

UAT-012-02 : Admin Give Blacklist and Select Reason
    Click Element    xpath=//span[normalize-space()="System"]
    Sleep    2s
    Click Element    xpath=//a[@href="/admin/users"]
    Sleep    2s
    Click Element    xpath=(//table//tbody/tr)[1]//button[@title="ระงับการใช้งาน"]
    Sleep    2s
    Click Element    xpath=//input[@value="เหตุผลอื่นๆ"]
    Sleep    2s
    Input Text    xpath=//textarea[@placeholder="จงระบุเหตุผล"]    มีคดีฆาตกรรม
    Sleep    2s
    Click Button     xpath=//button[normalize-space()="ระงับผู้ใช้"]
    Sleep    2s
    Click Button     xpath=//button[normalize-space()="ระงับผู้ใช้"]
    
    # ==== Expected Results ====
    Sleep                           2s
    Wait Until Element Is Visible       xpath=//h3[normalize-space()="ระงับสิทธิ์การใช้งานสำเร็จ"]
    Element Should Be Visible           xpath=//h3[normalize-space()="ระงับสิทธิ์การใช้งานสำเร็จ"]