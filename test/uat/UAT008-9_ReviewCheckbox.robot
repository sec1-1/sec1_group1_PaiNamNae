*** Settings ***
Library    SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-008 Passenger Select Few Checkbox. ====
UAT-009-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-008-02 : Passenger Select Few Checkbox.
    Passenger Login
    Sleep    2s
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[5]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[4]
    Sleep    2s
    Select Few Checkbox
    Sleep    2s

    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    Sleep                   2s
    View All Route
    Sleep                   2s
    View Passenger Info
    Page Should Contain     สะอาด
    Page Should Contain     ตรงเวลา

# ==== UAT-010 Passenger Select Few Checkbox. ====
UAT-009-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-009-02 : Passenger Select All Checkbox.
    Passenger Login
    Sleep    2s
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[6]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Select All Checkboxes
    Sleep    2s

    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    Sleep                   2s
    View All Route
    Sleep                   2s
    View Passenger Info
    Page Should Contain     สะอาด
    Page Should Contain     คนขับมารยาทดี
    Page Should Contain     ตรงเวลา
    Page Should Contain     ขับปลอดภัย
    Page Should Contain     บริการเป็นกันเอง


