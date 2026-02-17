*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/keywords/auth_keywords.robot

*** Test Cases ***
# ==== UAT-011 Passenger Close Review Page ====
UAT-011-01 : Passenger Login
    Passenger Login

    # ==== Expected Results ====
    Dashboard User Should Be Visible

UAT-011-02 : Passenger Close Review Page 
    Click Element       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[11]
    Sleep    2s
    Click Element       xpath=//button[normalize-space()="ยกเลิก"]
    Sleep    2s
    # ==== Expected Results ====
    Location Should Contain         /myTrip
