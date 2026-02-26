*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-007 Passenger Comments Under 501 Characters ====
UAT-010-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-007-02 : Passenger Comments Under 501 Characters
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[4]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Input Text    xpath=//textarea[@placeholder="เขียนรีวิวของคุณ... (สูงสุด 501 ตัวอักษร)"]    ${REVIEW_TEXT}
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    Sleep                   2s
    View All Route
    Sleep                   2s
    View Passenger Info
    Page Should Contain     ${REVIEW_TEXT}
    Page Should Contain     ${PASSENGER_SURNAME}