*** Settings ***
Library           SeleniumLibrary
Resource          ../../resources/auth_keywords.robot

*** Test Cases ***
UAT-001 Driver Report Trip Success
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                                       
    Input Text                      xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]    ${DRIVER_REPORT_TEXT}
    Upload 2 Image and 1 Video

    Scroll Element Into View        xpath=(//button[contains(@class, 'bg-red-600') and contains(., 'รายงาน')])[1]
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 
    Input Text                      xpath=//textarea[@placeholder="https://example.com"]    ${TEST_URL}
    
    # ==== Expected Results ====
    Page Should Contain             รับเรื่องแล้ว
    Page Should Contain             ${DRIVER_REPORT_TEXT}

UAT-002 Driver Report Trip Upload File Too Large
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                                       
    Input Text                      xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]    ${DRIVER_REPORT_TEXT}
    Choose File                     xpath=//input[@type="file"]    ${INVALID_VIDEO}
    Input Text                      xpath=//textarea[@placeholder="https://example.com"]    ${TEST_URL}

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ขนาดไฟล์ต้องไม่เกิน 50MB")]    10s

UAT-003 Driver Report Trip Upload Invilid File
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                                       
    Input Text                      xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]    ${DRIVER_REPORT_TEXT}
    Choose File                     xpath=//input[@type="file"]    ${PDF_PATH}
    Input Text                      xpath=//textarea[@placeholder="https://example.com"]    ${TEST_URL}

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาเลือกไฟล์รูปหรือวิดีโอเท่านั้น")]    10s

UAT-004 Driver Report Trip Upload Image 4 File
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Click Element                   xpath=(//button[normalize-space()="รายงาน"])[1]
    Select From List By Value       xpath=//select[contains(@class,'w-full')]                                       
    Input Text                      xpath=//textarea[@placeholder="รบกวนระบุรายละเอียดเพื่อให้เราตรวจสอบได้รวดเร็วขึ้น..."]    ${DRIVER_REPORT_TEXT}
    Upload 4 Images
    Input Text                      xpath=//textarea[@placeholder="https://example.com"]    ${TEST_URL}

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหา
    Wait Until Element Is Visible    xpath=//*[contains(text(),"เพิ่มรูปได้สูงสุด 3 รูป")]    10s
