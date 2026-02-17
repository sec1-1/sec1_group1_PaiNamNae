*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-012 Passenger Double Review ====
UAT-012-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-012-02 : Passenger Double Review
    View My Trip
    Sleep    2s
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[12]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]
    Sleep    2s

    # ==== Double Review ====
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[12]
    Sleep    2s
    Click Element       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ส่งรีวิว"]

    # ==== Expected Results ====
    Dashboard User Should Be Visible
        Wait Until Element Is Visible    xpath=//*[contains(text(),"Already reviewed")]    10s