*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../../resources/auth_keywords.robot

*** Test Cases ***
UAT-ReportFail-016 Admin change report status from In process to Inspecting
    #==== หน้าจอฝั่ง Admin =====
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Maximize Browser Window
    Execute JavaScript    document.body.style.zoom='60%'
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    Go To Check Report
    Click Element                   xpath=//button[normalize-space()="รอดำเนินการ"]  
    Click Element                    xpath=(//button[normalize-space()="ตรวจสอบ"])[1]
    Wait Until Element Is Visible    xpath=//textarea[@id='admin-notes' or contains(@placeholder,'อธิบาย')]    15s
    Input Text                       id=admin-notes    ${ADMIN_NOTE}
    Wait Until Element Is Visible    xpath=//button[normalize-space()="กำลังตรวจสอบ"]    15s
    Wait Until Element Is Enabled    xpath=//button[normalize-space()="กำลังตรวจสอบ"]    15s
    Scroll Element Into View         xpath=//button[normalize-space()="กำลังตรวจสอบ"]
    # Retry JS click until toast appears (ensures action took effect)
    FOR    ${index}    IN RANGE    3
        Execute JavaScript    var e = document.evaluate("//button[normalize-space()='กำลังตรวจสอบ']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if(e){ e.click(); };
        Sleep    1s
        ${toast}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[contains(text(),"อัปเดตสถานะสำเร็จ")]    4s
        Run Keyword If    '${toast}' == 'True'    Exit For Loop
    END
    IF    '${toast}' != 'True'
        Capture Page Screenshot    ${OUTPUT_DIR}${/}debug-click-fail-${index}.png
        Log Source
        Fail    Could not click กำลังตรวจสอบ and see success toast
    END
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น กำลังตรวจสอบ")]    15s
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น กำลังตรวจสอบ")]    10s

    #==== หน้าจอฝั่ง Driver ====
    Open Browser                    ${URL}    edge
    Maximize Browser Window
    Driver Login
    Dashboard User Should Be Visible
    View Notification
    Page Should Contain             สถานะการรายงานของคุณถูกเปลี่ยนจาก "รอดำเนินการ" เป็น "กำลังตรวจสอบ"
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 
    Execute JavaScript              window.scrollBy(0,325)
    Click Element                   xpath=//button[normalize-space()="รับเรื่องแล้ว"]
    Click Element                   xpath=//button[normalize-space()="ดูรายละเอียด"]  

    # ==== Expected Results ====
    Page Should Contain             รับเรื่องแล้ว
    Page Should Contain             ${DRIVER_REPORT_TEXT}
    Page Should Contain             ${ADMIN_NOTE} 

UAT-ReportFail-017 Admin change report status from Inspecting to Respond to reports
    #==== หน้าจอฝั่ง Admin =====
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Maximize Browser Window
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    Go To Check Report
    Wait Until Element Is Visible    xpath=//button[normalize-space()="กำลังตรวจสอบ"]    10s  
    Click Element                    xpath=//button[normalize-space()="กำลังตรวจสอบ"]
    Wait Until Element Is Visible    xpath=(//button[normalize-space()="ตรวจสอบ"])[1]    10s  
    Click Element                    xpath=(//button[normalize-space()="ตรวจสอบ"])[1]
    Wait Until Element Is Visible    xpath=//textarea[@id='admin-notes' or contains(@placeholder,'อธิบาย')]    20s
    Input Text                       id=admin-notes    ${ADMIN_NOTE_SUCCESS}
    Click Element                    xpath=(//button[normalize-space()="ตอบรับการรายงาน"])
    Wait Until Element Is Visible    xpath=//*[contains(text(),"อัปเดตสถานะสำเร็จ")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น ตอบรับการรายงานแล้ว")]    10s

    #==== หน้าจอฝั่ง Driver ====
    Open Browser                    ${URL}    edge
    Maximize Browser Window
    Driver Login
    View Notification
    Page Should Contain             สถานะการรายงานของคุณถูกเปลี่ยนจาก "รอดำเนินการ" เป็น "ดำเนินการเสร็จสิ้น"
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"]
    Execute JavaScript              window.scrollBy(0,350)
      
    ${btn}=    Set Variable    xpath=//button[.//span[contains(text(),"ดำเนินการแก้ไขแล้ว")]]

    Wait Until Element Is Visible    ${btn}    10s
    Wait Until Element Is Enabled    ${btn}    10s
    Click Element                    ${btn}

    Click Element                   xpath=//button[normalize-space()="ดูรายละเอียด"]  

    # ==== Expected Results ====
    Page Should Contain             ดำเนินการแล้ว
    Page Should Contain             ${ADMIN_NOTE_SUCCESS} 

UAT-ReportFail-018 Admin change report status from In process to Reject
    #==== หน้าจอฝั่ง Admin =====
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Maximize Browser Window
    Admin Login
    Dashboard Admin Should Be Visible
    Go To User Management Page
    Go To Check Report
    Wait Until Element Is Visible    xpath=//button[normalize-space()="รอดำเนินการ"]    10s
    Click Element                    xpath=//button[normalize-space()="รอดำเนินการ"]
    Wait Until Element Is Visible    xpath=(//button[normalize-space()="ตรวจสอบ"])[1]    10s  
    Click Element                    xpath=(//button[normalize-space()="ตรวจสอบ"])[1]
    Wait Until Element Is Visible    xpath=//textarea[@id='admin-notes' or contains(@placeholder,'อธิบาย')]    20s
    Input Text                       id=admin-notes    ${ADMIN_NOTE_REJECTION}
    Click Element                    xpath=(//button[normalize-space()="ปฏิเสธ"])
    Wait Until Element Is Visible    xpath=//*[contains(text(),"อัปเดตสถานะสำเร็จ")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(text(),"สถานะรายงานเปลี่ยนเป็น ปฏิเสธ")]    10s

    #==== หน้าจอฝั่ง Driver ====
    Open Browser                    ${URL}    edge
    Maximize Browser Window
    Driver Login
    View Notification
    Page Should Contain             สถานะการรายงานของคุณถูกเปลี่ยนจาก "รอดำเนินการ" เป็น "ปฏิเสธ"
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"]
    Execute JavaScript              window.scrollBy(0,350)  

    ${btn}=    Set Variable    xpath=//button[.//span[contains(text(),"ถูกปฏิเสธ")]]

    Wait Until Element Is Visible    ${btn}    10s
    Wait Until Element Is Enabled    ${btn}    10s
    Click Element                    ${btn}

    Click Element                   xpath=//button[normalize-space()="ดูรายละเอียด"]  

    # ==== Expected Results ====
    Page Should Contain             ไม่พบปัญหา
    Page Should Contain             ${ADMIN_NOTE_REJECTION} 