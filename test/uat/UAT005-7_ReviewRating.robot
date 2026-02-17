*** Settings ***
Library    SeleniumLibrary
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-005 Passenger Give 1 Star ====
UAT-005-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-005-02 : Passenger Give 1 Star
    Passenger Login
    Sleep    2s
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[1]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[1]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    Sleep                   2s
    View All Route
    Sleep                   2s
    View Passenger Info
    Page Should Contain     1
    Page Should Contain     ${PASSENGER_SURNAME}

# ==== UAT-006 Passenger Give 5 Star ====
UAT-006-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-006-02 : Passenger Give 5 Star
    Passenger Login
    Sleep    2s
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[2]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s
    Sleep                   2s
    View All Route
    Sleep                   2s
    View Passenger Info
    Page Should Contain     5
    Page Should Contain     ${PASSENGER_SURNAME}

# ==== UAT-007 Passenger Do not Give a Star ====
UAT-007-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-007-02 : Passenger Do not Give a Star
    Passenger Login
    Sleep    2s
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[3]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาให้คะแนนก่อน")]    10s