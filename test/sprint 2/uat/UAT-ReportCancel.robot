*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-008  : Passenger press cancel button
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View My Trip
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Click Element                   xpath=(//button[normalize-space()="ยกเลิก"])

    # ==== Expected Results ====
    Location Should Contain         /myTrip
