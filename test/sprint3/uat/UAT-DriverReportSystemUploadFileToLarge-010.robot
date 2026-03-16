*** Settings ***
Library           SeleniumLibrary
# ตรวจสอบว่า Path ถูกต้องตามโครงสร้างโปรเจกต์ของคุณ
Resource          ../../resources/variables/credentials.robot

*** Test Cases ***
UAT-010 : DriverReportSystemUploadFileToLarge
    [Documentation]    ทดสอบการส่งรายงานสำเร็จ

    # --- ตั้งค่าความเร็ว ---
    Set Selenium Speed    0.2 seconds

    # --- Step 01: เปิดหน้าเว็บ ---
    Open Browser To Website

    # --- Step 02: Driver ทำการ Login ---
    Click Element                   xpath=//a[@href='/login']
    Wait Until Element Is Visible   xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    timeout=15s
    Input Text      xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    ${DRIVER_USER}
    Input Text      xpath=//input[@type='password']                         ${DRIVER_PASS} 

    # --- Step 03: กดปุ่ม Login ---
    Click Button    xpath=//button[@type='submit']

    # --- Step 04: ไปที่การรายงานระบบ ---
    # --- Step 05: เลือกหัวข้อ ---
    # --- Step 06: ใส่รายละเอียด ---
    # --- Step 07: อัพโหลดรูปภาพ 4 ภาพ ---
    # --- Step 08: กดรายงาน ---
    # --- Step 09: ไปที่หน้าผลการรายงาน ---

    # อยู่ต่ออีก 20 วินาทีก่อนจบ (Teardown จะทำงานหลังจากนี้)
    Sleep    20s
    [Teardown]    Close Browser
    
*** Keywords ***
Open Browser To Website
    Open Browser               ${URL}    edge
    Maximize Browser Window