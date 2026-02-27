*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-009  : Admin change report status from ... to ...
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    # ไปหน้า Report Management
    # กดเลือกรายการรีพอร์ต
    # เปลี่ยนสถานะจาก ... เป็น ...
    # กดยืนยัน

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    # กดดู Notification และเห็นการแจ้งเตือนสถานะ
    # กดดูโปรไฟล์ตัวเอง
    # กดเข้าหน้า "การรายงานของคุณ"

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้าดูทริป
    # เห็นผลการรายงานเป็น

UAT-ReportFail-010  : Admin change report status from ... to ...
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    # ไปหน้า Report Management
    # กดเลือกรายการรีพอร์ต
    # เปลี่ยนสถานะจาก ... เป็น ...
    # กดยืนยัน

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    # กดดู Notification และเห็นการแจ้งเตือนสถานะ
    # กดดูโปรไฟล์ตัวเอง
    # กดเข้าหน้า "การรายงานของคุณ"

    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้าดูทริป
    # เห็นผลการรายงานเป็น

UAT-ReportFail-011  : Admin change report status from ... to reject
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    # ไปหน้า Report Management
    # กดเลือกรายการรีพอร์ต
    # เปลี่ยนสถานะจาก ... เป็น reject
    # กดยืนยัน

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    # กดดู Notification และเห็นการแจ้งเตือนสถานะ
    # กดดูโปรไฟล์ตัวเอง
    # กดเข้าหน้า "การรายงานของคุณ"
    
    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้าดูทริป
    # เห็นผลการรายงานเป็น

UAT-ReportFail-012  : Admin change report status from ... to Need More Info
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    # ไปหน้า Report Management
    # กดเลือกรายการรีพอร์ต
    # เปลี่ยนสถานะจาก ... เป็น Need More Info
    # ทำอะไรสักอย่างที่เกี่ยวกับการขอข้อมูล ผู้ใช้
    # กดยืนยัน

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    # กดดู Notification และเห็นการแจ้งเตือนสถานะ
    # กดดูโปรไฟล์ตัวเอง
    # กดเข้าหน้า "การรายงานของคุณ"
    
    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้าดูทริป
    # เห็นผลการรายงานเป็น

UAT-ReportFail-013  : Passenger sent info to admin 
    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    # กดดูโปรไฟล์ตัวเอง
    # กดเข้าหน้า "การรายงานของคุณ"
    # ใส่ข้อมูลเพิ่มเติม
    # ยืนยัน
    
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    # กดดู Notification และเห็นการแจ้งเตือนสถานะ
    Go To User Management Page
    # ไปหน้า Report Management
    # กดเลือกรายการรีพอร์ตที่ผู้ใช้กรอกข้อมูลเข้ามาแล้ว

    # ==== Expected Results ====
    # เห็นข้อความที่ผู้ใช้กรอกเข้ามา