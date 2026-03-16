*** Settings ***
Library           SeleniumLibrary
# ดึง Resource เดิมมาใช้เพื่อเอาค่า USER/PASS ของ Admin
Resource          ../../resources/variables/credentials.robot

*** Variables ***
# ประกาศ URL ไว้ที่นี่เพราะเราไม่แก้ไฟล์ credentials
${URL}            https://cssec1web69.cpkku.com/

*** Test Cases ***
UAT-010 : Admin Login and Verify Dashboard
    [Documentation]    ทดสอบการเข้าสู่ระบบในฐานะผู้ดูแลระบบ (Admin)
    Set Selenium Speed    0.2 seconds

    # --- Step 01: เปิดหน้าเว็บ ---
    Open Browser To Website
    Wait Until Page Contains    เดินทางร่วมกัน    timeout=15s

    # --- Step 02: ไปหน้า Login ---
    Click Element                   xpath=//a[@href='/login']
    Wait Until Element Is Visible   xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    timeout=10s

    # --- Step 03: กรอกข้อมูล Admin ---
    # ใช้ตัวแปรจาก credentials.robot (admin123 / 123456789)
    Input Text      xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    ${ADMIN_USER}
    Input Text      xpath=//input[@type='password']                         ${ADMIN_PASS}
    
    # --- Step 04: กดปุ่ม Login ---
    Click Button    xpath=//button[@type='submit']

    # --- Step 05: ตรวจสอบหน้า Dashboard ของ Admin ---
    # โดยปกติ Admin จะเห็นชื่อ 'System' หรือมีเมนูจัดการผู้ใช้ (User Management)
    Wait Until Page Contains    ${ADMIN_FIRST_NAME}    timeout=15s
    Page Should Contain         จัดการผู้ใช้    # หรือข้อความอื่นๆ ที่มีเฉพาะหน้า Admin
    
    Log To Console    \n[SUCCESS] Admin Login Completed.
    Capture Page Screenshot     filename=admin_dashboard.png

    Sleep    10s
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
    Open Browser                ${URL}    edge
    Maximize Browser Window