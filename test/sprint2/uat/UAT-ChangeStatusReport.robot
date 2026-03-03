*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-010 Admin change report status from In process to Inspecting
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    Go To Check Report
    Click Element                   xpath=(//button[normalize-space()="ตรวจสอบรายงาน"])[1]
    Click Element                   xpath=(//button[normalize-space()="กำลังตรวจสอบ"])
    Wait Until Element Is Visible    xpath=//*[contains(text(),"อัปเดตสถานะสำเร็จ")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น กำลังตรวจสอบ")]    10s

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View Notification
    Page Should Contain             สถานะการรายงานของคุณถูกเปลี่ยนจาก "รอดำเนินการ" เป็น "กำลังตรวจสอบ"
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 

    # ==== Expected Results ====
    Page Should Contain             รับเรื่องแล้ว
    Page Should Contain             ${REPORT_TEXT}

UAT-ReportFail-011 Admin change report status from Inspecting to Respond to reports
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    Go To Check Report
    Click Element                   xpath=(//button[normalize-space()="ตรวจสอบรายงาน"])[1]
    Click Element                   xpath=(//button[normalize-space()="ตอบรับการรายงาน"])
    Wait Until Element Is Visible    xpath=//*[contains(text(),"อัปเดตสถานะสำเร็จ")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น ตอบรับการรายงานแล้ว")]    10s

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View Notification
    Page Should Contain             สถานะการรายงานของคุณถูกเปลี่ยนจาก "กำลังตรวจสอบ" เป็น "ดำเนินการเสร็จสิน"
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 

    # ==== Expected Results ====
    Page Should Contain             ดำเนินการแล้ว
    Page Should Contain             ${REPORT_TEXT}

UAT-ReportFail-012  : Admin change report status from In process to Reject
    #==== หน้าจอฝั่ง Admin =====
    Open Browser                    ${URL}    edge
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    Go To Check Report
    Click Element                   xpath=(//button[normalize-space()="ตรวจสอบรายงาน"])[1]
    Click Element                   xpath=(//button[normalize-space()="ปฎิเสธ"])
    Wait Until Element Is Visible    xpath=//*[contains(text(),"อัปเดตสถานะสำเร็จ")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น กำลังตรวจสอบ")]    10s

    #==== หน้าจอฝั่ง Passenger ====
    Open Browser                    ${URL}    edge
    Passenger Login
    Dashboard User Should Be Visible
    View Notification
    Page Should Contain             สถานะการรายงานของคุณถูกเปลี่ยนจาก "รอดำเนินการ" เป็น "ปฏิเสธ"
    # กดดูโปรไฟล์ตัวเอง
    # กดเข้าหน้า "การรายงานของคุณ"
    
    # ==== Expected Results ====
    # ผู้โดยสารอยู่ในหน้าดูทริป
    # เห็นผลการรายงานเป็น