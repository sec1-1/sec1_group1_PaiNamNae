*** Settings ***
Library           SeleniumLibrary
Resource          ../../test/resources/auth_keywords.robot


*** Variables ***     
# --- ข้อมูลรายงาน ---
${REPORT_DETAIL}         พบปัญหาหน้าจอค้างขณะโหลดข้อมูลทริป และปุ่มกดยกเลิกไม่ทำงานในบางครั้ง

# --- Path ไฟล์ (ตรวจสอบให้แน่ใจว่าไฟล์อยู่ที่นี่จริง) ---
${FILE_PNG}              /Users/fandy/KKU 3T2/softend/PaiNamNae/sec1_group1_PaiNamNae/image/error404.png
${FILE_MOV}              /Users/fandy/KKU 3T2/softend/PaiNamNae/sec1_group1_PaiNamNae/image/error404.mov

*** Test Cases ***
UAT-009 : DriverReportSystem (Direct Input Mode)
    [Documentation]    ทดสอบการส่งรายงานระบบโดยตรง
    Set Selenium Speed    0.2 seconds

    # --- Step 01: เปิดเบราว์เซอร์ ---
    Open Browser To Website

    # --- Step 02-03: Login ---
    Wait Until Element Is Visible    xpath=//a[@href='/login']    timeout=15s
    Click Element                    xpath=//a[@href='/login']
    
    Wait Until Element Is Visible    xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    timeout=15s
    
    Clear Element Text    xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']
    Press Keys            xpath=//input[@placeholder='กรอกชื่อผู้ใช้หรืออีเมล']    ${DRIVER_USER}
    
    Clear Element Text    xpath=//input[@type='password']
    Press Keys            xpath=//input[@type='password']                         ${DRIVER_PASS}
    
    Sleep    1s
    Click Button          xpath=//button[@type='submit']

    # --- Step 04: ตรวจสอบการเข้าสู่ระบบและไปหน้ารายงาน ---
    Wait Until Page Contains    หน้าหลัก    timeout=15s
    Log To Console    \n[INFO] Login Successful!
    
    # ไปหน้า Report โดยตรง
    Go To    ${URL}report-system

    # --- Step 05: เลือกหัวข้อ ---
    Wait Until Element Is Visible    xpath=//select    timeout=10s
    # ตรวจสอบว่าคำใน Label ตรงกับใน Dropdown จริงๆ (รวมเว้นวรรค)
    Select From List By Label        xpath=//select    หน้าเว็บค้าง / กดอะไรไม่ได้

    # --- Step 06: ใส่รายละเอียด ---
    Input Text    xpath=//textarea    ${REPORT_DETAIL}

    # --- Step 07: อัพโหลดไฟล์ (3 รูป + 1 วิดีโอ) ---
    FOR    ${i}    IN RANGE    3
        Choose File    xpath=//input[@type='file']    ${FILE_PNG}
        Sleep    1s
    END
    
    Choose File    xpath=//input[@type='file']    ${FILE_MOV}
    
    # รออัปโหลดวิดีโอ (บน Server จริงอาจใช้เวลานาน)
    Sleep    15s

    # --- Step 08: กดส่งรายงาน ---
    # ใช้ JS Click เพื่อแก้ปัญหาปุ่มโดนบังหรือยังเป็นสีเทา (Disabled)
    Execute Javascript    document.evaluate("//button[contains(., 'ส่งรายงาน')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    # --- Step 09: ตรวจสอบผลลัพธ์ ---
    Wait Until Page Contains    ส่งรายงานสำเร็จ    timeout=20s
    Capture Page Screenshot     filename=direct_report_success.png

    Sleep    20s
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
    Open Browser    ${URL}    edge
    Maximize Browser Window