*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-008  : Passenger press cancel button
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View All Route
    # กดหน้าอะไรสักอย่างที่ดูทริปที่เดินแล้ว (รอแก้ไขให้รัน Project บน Localhost ให้ได้ก่อน)
    # กดเลือกทริปแรก
    # กดรีพอร์ต
    # กดยกเลิก

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้าดูทริป
