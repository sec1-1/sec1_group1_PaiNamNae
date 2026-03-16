*** Settings ***
Library           SeleniumLibrary
Resource          ../../resources/auth_keywords.robot

*** Test Cases ***
UAT-001 Driver Report Trip Success
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Click Element                   xpath=//button[contains(text(),"พฤติกรรมผู้โดยสาร")]
    Select From List By Label       xpath=//select[option[contains(text(),"passenger 01")]]                         passenger 01 (1 ที่นั่ง)                                   
    Input Text                      xpath=//textarea[@placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."]    ${DRIVER_REPORT_TEXT}
    Upload 2 Image and 1 Video
    Scroll Element Into View        xpath=//button[normalize-space()="ส่งรายงาน"]
    Upload link
    Click Element                   xpath=//button[normalize-space()="ส่งรายงาน"]  
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ขอบคุณที่แจ้งรายงาน")]    60s  
    Go To User Profile Page
    Click Element                   xpath=//a[normalize-space()="ประวัติการรายงาน"] 
    Execute JavaScript              window.scrollBy(0,325)
    Click Element                   xpath=//button[normalize-space()="ดูรายละเอียด"]  
    
    # ==== Expected Results ====
    Page Should Contain             รอการตรวจสอบ
    Page Should Contain             ${DRIVER_REPORT_TEXT}

UAT-002 Driver Report Trip Upload File Too Large
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Click Element                   xpath=//button[contains(text(),"พฤติกรรมผู้โดยสาร")]
    Select From List By Label       xpath=//select[option[contains(text(),"passenger 01")]]                         passenger 01 (1 ที่นั่ง)                                          
    Input Text                      xpath=//textarea[@placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."]    ${DRIVER_REPORT_TEXT}
    Choose File                     xpath=//input[@type="file"]    ${INVALID_VIDEO}

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหาเส้นทาง
    Wait Until Element Is Visible    xpath=//*[contains(text(),"ขนาดไฟล์ต้องไม่เกิน 50MB")]    10s

UAT-003 Driver Report Trip Upload Invilid File
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Click Element                   xpath=//button[contains(text(),"พฤติกรรมผู้โดยสาร")]
    Select From List By Label       xpath=//select[option[contains(text(),"passenger 01")]]                         passenger 01 (1 ที่นั่ง)                                          
    Input Text                      xpath=//textarea[@placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."]    ${DRIVER_REPORT_TEXT}
    Choose File                     xpath=//input[@type="file"]    ${PDF_PATH}

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหาเส้นทาง
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาเลือกไฟล์รูป วิดีโอ หรือเสียงเท่านั้น")]    10s

UAT-004 Driver Report Trip Upload Image 4 File
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Click Element                   xpath=//button[contains(text(),"พฤติกรรมผู้โดยสาร")]
    Select From List By Label       xpath=//select[option[contains(text(),"passenger 01")]]                         passenger 01 (1 ที่นั่ง)                                          
    Input Text                      xpath=//textarea[@placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."]    ${DRIVER_REPORT_TEXT}
    Upload 4 Images

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหาเส้นทาง
    Wait Until Element Is Visible    xpath=//*[contains(text(),"เพิ่มรูปได้สูงสุด 3 รูป")]    10s

UAT-005 Driver Report Trip Not Select Passenger
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Click Element                   xpath=//button[contains(text(),"พฤติกรรมผู้โดยสาร")]                               
    Input Text                      xpath=//textarea[@placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."]    ${DRIVER_REPORT_TEXT}
    Upload 2 Image and 1 Video
    Scroll Element Into View        xpath=//button[normalize-space()="ส่งรายงาน"]
    Upload link
    Click Element                   xpath=//button[normalize-space()="ส่งรายงาน"]  

    # ==== Expected Results ====
    Page Should Contain             รายงานปัญหาเส้นทาง
    Wait Until Element Is Visible    xpath=//*[contains(text(),"กรุณาระบุผู้โดยสาร")]    10s

UAT-006 Driver Report Trip Not Select Topic
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]                                       
    Input Text                      xpath=//textarea[@placeholder="โปรดระบุปัญหาที่คุณพบเพื่อให้ทีมงานสามารถตรวจสอบได้..."]    ${DRIVER_REPORT_TEXT}
    Upload 2 Image and 1 Video
    Scroll Element Into View        xpath=//button[normalize-space()="ส่งรายงาน"]
    Upload link

    # ==== Expected Results ====
    Element Should Be Disabled    xpath=//button[normalize-space()="ส่งรายงาน"]

UAT-007 Driver Report Trip Not Fill Detail
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Click Element                   xpath=//button[contains(text(),"พฤติกรรมผู้โดยสาร")]
    Select From List By Label       xpath=//select[option[contains(text(),"passenger 01")]]                         passenger 01 (1 ที่นั่ง)                             
    Upload 2 Image and 1 Video
    Scroll Element Into View        xpath=//button[normalize-space()="ส่งรายงาน"]
    Upload link

    # ==== Expected Results ====
    Element Should Be Disabled    xpath=//button[normalize-space()="ส่งรายงาน"]

UAT-008 Driver Report Trip Not Fill Any Info
    Setup Delay Selenium
    Open Browser To Website
    Driver Login
    View My Route
    Scroll Element Into View        xpath=//button[normalize-space()="รายงานปัญหา"]
    Click Element                   xpath=(//button[normalize-space()="รายงานปัญหา"])[1]
    Scroll Element Into View        xpath=//button[normalize-space()="ส่งรายงาน"]

    # ==== Expected Results ====
    Element Should Be Disabled    xpath=//button[normalize-space()="ส่งรายงาน"]