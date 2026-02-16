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
    Click Element    xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[1]
    Sleep    2s
    Click Element    xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Wait Until Element Is Visible    xpath=//*[contains(text(),"รีวิวสำเร็จ")]    10s