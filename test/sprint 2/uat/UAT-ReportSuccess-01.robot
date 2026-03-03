*** Settings ***
Library           SeleniumLibrary
# ตรวจสอบว่า Path ถอยหลังไปหาไฟล์ auth_keywords.robot ถูกต้อง
Resource          ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-001 : Login and Go to Report (Super Slow)
    
    # --- ตั้งค่าความเร็ว (Slow Motion) ---
    Set Selenium Speed    0.2 seconds

    # --- Step 01: Open Web Page ---
    Open Browser To Website
    Wait Until Page Contains    เดินทางร่วมกัน    timeout=15s
    Capture Page Screenshot     filename=01_homepage.png

    # --- Step 02: Login Process ---
    Click Element                   xpath=//a[@href='/login']
    Wait Until Element Is Visible   xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    timeout=15s
    Input Text      xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    ${PASSENGER_USER}
    Input Text      xpath=//input[@type='password']                         ${PASSENGER_PASS}
    Click Button    xpath=//button[@type='submit']

    # --- Step 03: Verify Dashboard ---
    Dashboard User Should Be Visible
    Log To Console    \n[SUCCESS] Login Completed
    Capture Page Screenshot     filename=03_dashboard.png

    # --- Step 04: คลิกที่ "การเดินทางของฉัน" ---
    Wait Until Element Is Visible    xpath=//a[@href='/myTrip']    timeout=15s
    Click Element                    xpath=//a[@href='/myTrip']
    Wait Until Location Contains    /myTrip    timeout=10s

    # --- Step 05: คลิกที่ "ทั้งหมด" ---
    Wait Until Element Is Visible    xpath=//button[contains(., 'ทั้งหมด')]    timeout=10s
    Click Element                    xpath=//button[contains(., 'ทั้งหมด')]
    Capture Page Screenshot     filename=05_all_trips.png

    # --- Step 06: กดปุ่ม "รายงาน" (ใช้ JS Click เพื่อแก้ปัญหาโดนบัง) ---
    Wait Until Element Is Visible    xpath=(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]    timeout=10s
    Scroll Element Into View         xpath=(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]
    
    # ใช้ JavaScript คลิกเพื่อป้องกัน Error 'ElementClickIntercepted'
    Execute Javascript    document.evaluate("(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # --- Step 07: รอหน้าต่างรายงานเปิด ---
    Wait Until Page Contains    หัวข้อปัญหา    timeout=10s
    Capture Page Screenshot     filename=07_report_modal.png

    # --- Step 081: เลือกหัวข้อปัญหา (ใช้ JS Select เพื่อความชัวร์) ---
    Wait Until Element Is Visible    xpath=//select    timeout=15s
    # เลือก 'SAFETY_ISSUE' และสั่งให้ Vue อัปเดตสถานะ
    Execute Javascript    document.querySelector('select').value = 'SAFETY_ISSUE'; document.querySelector('select').dispatchEvent(new Event('change'));
    
    # --- Step 082: กรอกรายละเอียดเหตุการณ์ ---
    Input Text      xpath=//textarea    ${REPORT_TEXT_SUCCESS}

  # --- Step 083: เพิ่มไฟล์ภาพและวิดีโอ ---
    Choose File     xpath=//input[@type='file']    ${REPORT_IMAGE_SUCCESS_PATH}
    Sleep           1.5s
    Choose File     xpath=//input[@type='file']    ${REPORT_IMAGE_SUCCESS_PATH}
    Sleep           1.5s
    Choose File     xpath=//input[@type='file']    ${REPORT_VIDEO_SUCCESS_PATH}
    Sleep           5s

    # --- Step 09: กดปุ่ม "ส่งรายงานความปลอดภัย" ---
    Wait Until Element Is Visible    xpath=//button[contains(., 'ส่งรายงานความปลอดภัย')]    timeout=10s
    Execute Javascript    document.evaluate("//button[contains(., 'ส่งรายงานความปลอดภัย')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # --- Step 10: ค้างหน้าจอไว้ ---
    Log To Console    \n[SUCCESS] Report Sent! Holding screen for 10 seconds...
    Sleep    20s
    
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
    Open Browser               ${URL}    edge
    Maximize Browser Window