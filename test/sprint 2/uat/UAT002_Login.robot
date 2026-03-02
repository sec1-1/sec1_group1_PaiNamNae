*** Settings ***
Library         SeleniumLibrary
# ตรวจสอบ Path ให้ถูกต้องตามโครงสร้างโฟลเดอร์ของคุณ
Resource        ../../resources/keywords/auth_keywords.robot


*** Test Cases ***
UAT-001 : Login Process Flow
    [Documentation]    ทดสอบขั้นตอนการเข้าสู่ระบบโดยใช้ข้อมูลจาก auth_keywords
    # --- Step 01: Open Web Page ---
    Open Browser To Website
    Wait Until Page Contains    เดินทางร่วมกัน    timeout=15s

    # --- Step 02: Go to Login Page ---
    Click Element                xpath=//a[@href='/login']
    Wait Until Location Contains    /login    timeout=10s
    
    # --- Step 03: Login Success (ใช้ตัวแปรจากไฟล์ Resource) ---
    Input Text                  id=identifier    ${PASSENGER_USER}
    Input Text                  id=password      ${PASSENGER_PASS}
    Click Button                xpath=//button[@type='submit']

    # ตรวจสอบการเข้าสู่ระบบสำเร็จ (อ้างอิงจากชื่อนามสกุลใน Dashboard)
    Dashboard User Should Be Visible
    
    Log To Console    \n[SUCCESS] Login Completed with ${PASSENGER_USER}
    
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
    Open Browser    ${URL}     chrome
    Maximize Browser Window