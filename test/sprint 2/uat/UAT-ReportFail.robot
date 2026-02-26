*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-003  : Passenger Report and upload image 4 file
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View All Route
    # กดหน้าอะไรสักอย่างที่ดูทริปที่เดินแล้ว (รอแก้ไขให้รัน Project บน Localhost ให้ได้ก่อน)
    # กดเลือกทริปแรก
    # กดรีพอร์ต
    # อัพโหลดรูป 4 รูป Keyword "Upload 4 File"

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้ารายงาน ไม่สามารถรายงานได้ 
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"

UAT-ReportFail-004  : Passenger Report and do not select topic
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View All Route
    # กดหน้าอะไรสักอย่างที่ดูทริปที่เดินแล้ว (รอแก้ไขให้รัน Project บน Localhost ให้ได้ก่อน)
    # กดเลือกทริปแรก
    # กดรีพอร์ต
    # กรอกข้อมูลจาก Keyword "Do Not Select Topic Report"

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้ารายงาน ไม่สามารถรายงานได้ 
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"

UAT-ReportFail-005  : Passenger Report and do not fill report detail
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View All Route
    # กดหน้าอะไรสักอย่างที่ดูทริปที่เดินแล้ว (รอแก้ไขให้รัน Project บน Localhost ให้ได้ก่อน)
    # กดเลือกทริปแรก
    # กดรีพอร์ต
    # กรอกข้อมูลจาก Keyword "Do Not Fill Report Detail"

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้ารายงาน ไม่สามารถรายงานได้ 
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"

UAT-ReportFail-006  : Passenger Report and do not fill anything
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View All Route
    # กดหน้าอะไรสักอย่างที่ดูทริปที่เดินแล้ว (รอแก้ไขให้รัน Project บน Localhost ให้ได้ก่อน)
    # กดเลือกทริปแรก
    # กดรีพอร์ต
    # กดรีพอร์ต ส่งรีพอร์ต

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้ารายงาน ไม่สามารถรายงานได้ 
    # พร้อมขึ้นข้อความว่า "(รอ Frontend Design)"
