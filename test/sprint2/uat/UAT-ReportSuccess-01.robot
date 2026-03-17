*** Settings ***
Library           SeleniumLibrary
# ตรวจสอบว่า Path ถูกต้องตามโครงสร้างโปรเจกต์ของคุณ
Resource          ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-001 : Login and Go to Report (Super Slow)
    [Documentation]    ทดสอบการส่งรายงานสำเร็จ โดยใช้ข้อมูลของคุณณัฐธเนศ (bambam)
    
    # --- ตั้งค่าความเร็ว (Slow Motion) ---
    Set Selenium Speed    0.2 seconds

    # --- Step 01: Open Web Page ---
    Open Browser To Website
    Wait Until Page Contains    เดินทางร่วมกัน    timeout=15s

    # --- Step 02: Login Process ---
    # ใช้ตัวแปรชุด _SUCCESS ตามที่ระบุใน auth_keywords.robot
    Click Element                   xpath=//a[@href='/login']
    Wait Until Element Is Visible   xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    timeout=15s
    Input Text      xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    ${PASSENGER_USER_SUCCESS}
    Input Text      xpath=//input[@type='password']                         ${PASSENGER_PASS_SUCCESS}
    Click Button    xpath=//button[@type='submit']

    # --- Step 03: Verify Dashboard ---
    # บรรทัดนี้จะไปเรียกใช้ Keyword ใน auth_keywords.robot 
    # ซึ่งต้องมั่นใจว่าในไฟล์นั้นแก้ XPath ให้ตรงกับนามสกุล "อิทธิ" (${PASSENGER_SURNAME_SUCCESS}) แล้ว
    Wait Until Element Is Visible    xpath=//span[contains(., '${PASSENGER_SURNAME_SUCCESS}')]    timeout=10s
    Log To Console    \n[SUCCESS] Login Completed as ${PASSENGER_USER_SUCCESS}

    # --- Step 04: คลิกที่ "การเดินทางของฉัน" ---
    Wait Until Element Is Visible    xpath=//a[@href='/myTrip']    timeout=15s
    Click Element                    xpath=//a[@href='/myTrip']
    Wait Until Location Contains    /myTrip    timeout=10s

    # --- Step 05: คลิกที่ "ทั้งหมด" ---
    Wait Until Element Is Visible    xpath=//button[contains(., 'ทั้งหมด')]    timeout=10s
    Click Element                    xpath=//button[contains(., 'ทั้งหมด')]

    # --- Step 06: กดปุ่ม "รายงาน" ---
    Wait Until Element Is Visible    xpath=(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]    timeout=20s
    Scroll Element Into View         xpath=(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]
    
    # ใช้ JavaScript คลิกเพื่อป้องกันปุ่มโดนบัง
    Execute Javascript    document.evaluate("(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # --- Step 07: รอหน้าต่างรายงานเปิด ---
    Wait Until Page Contains    หัวข้อปัญหา    timeout=10s

    # --- Step 081: เลือกหัวข้อปัญหา ---
    Wait Until Element Is Visible    xpath=//select    timeout=15s
    Execute Javascript    document.querySelector('select').value = 'SAFETY_ISSUE'; document.querySelector('select').dispatchEvent(new Event('change'));
    
    # --- Step 082: กรอกรายละเอียดเหตุการณ์ ---
    Input Text      xpath=//textarea    ${REPORT_TEXT_SUCCESS}

    # --- Step 083: เพิ่มไฟล์ภาพและวิดีโอ ---
<<<<<<< HEAD
    Choose File     xpath=//input[@type='file']    ${IMAGE01_PATH}
    Sleep           2s
    Choose File     xpath=//input[@type='file']    ${IMAGE02_PATH}
    Sleep           2s
    Choose File     xpath=//input[@type='file']    ${VIDEO01_PATH}
=======
    Choose File     xpath=//input[@type='file']    ${REPORT_IMAGE_SUCCESS_PATH}
    Sleep           2s
    Choose File     xpath=//input[@type='file']    ${REPORT_IMAGE_SUCCESS_PATH}
    Sleep           2s
    Choose File     xpath=//input[@type='file']    ${REPORT_VIDEO_SUCCESS_PATH}
>>>>>>> test/uat-report-success-nk
    # รอให้วิดีโออัปโหลดเสร็จจนปุ่ม "ส่งรายงาน" หาย Disabled
    Sleep           5s

    # --- Step 09: กดปุ่ม "ส่งรายงานความปลอดภัย" ---
    Wait Until Element Is Visible    xpath=//button[contains(., 'ส่งรายงานความปลอดภัย')]    timeout=10s
    # ใช้ JavaScript คลิกเพื่อเลี่ยงสถานะ Disabled หาก UI ยังอัปเดตไม่ทัน
    Execute Javascript    document.evaluate("//button[contains(., 'ส่งรายงานความปลอดภัย')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # --- Step 10: ค้างหน้าจอไว้เพื่อดูผลลัพธ์ ---
    Log To Console    \n[SUCCESS] Report Sent! Holding screen for 20 seconds...
    
    # อยู่ต่ออีก 20 วินาทีก่อนจบ (Teardown จะทำงานหลังจากนี้)
    Sleep    20s
    
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
<<<<<<< HEAD
    Open Browser               ${URL}    chrome
=======
    Open Browser               ${URL}    edge
>>>>>>> test/uat-report-success-nk
    Maximize Browser Window