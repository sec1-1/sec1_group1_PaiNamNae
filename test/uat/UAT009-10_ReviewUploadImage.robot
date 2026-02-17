*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-009 Passenger Upload Image File ====
UAT-009-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-009-02 : Passenger Upload Image File
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[9]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Choose File         xpath=//input[@type="file"]    ${IMAGE_PATH}
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    Sleep                   2s
    View All Route
    Sleep                   2s
    View Passenger Info
    Sleep                   2s
    Element Should Be Visible       xpath=(//div[contains(@class,"rounded-2xl")])[1]//div[contains(@class,"grid")]//img
    Page Should Contain             ${PASSENGER_SURNAME}


# ==== UAT-010 Passenger Upload Invalid File ====
UAT-013-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-010-02 : Passenger Upload Invalid File
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[10]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Choose File         xpath=//input[@type="file"]    ${INVALID_PATH}
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ไม่สามารถรีวิวได้")]    10s