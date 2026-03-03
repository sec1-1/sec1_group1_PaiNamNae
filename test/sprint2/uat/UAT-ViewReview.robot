*** Comments ***
# คนเขียน Test: วีรภัทร วิเศษสมบัติ 663380025-7

*** Settings ***
Resource       ../../resources/keywords/auth_keywords.robot

*** Test Cases ***
UAT-ViewReview-015 Passenger view review
    # ==== Passenger create review ====
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,150)
    Click Element                       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[2]
    Click Element                       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Select All Checkboxes
    Input Text                          xpath=//textarea[@placeholder="เขียนรีวิวของคุณ... (สูงสุด 501 ตัวอักษร)"]    ${REVIEW_TEXT}
    Upload 2 Image and 1 Video
    Click Element                       xpath=//button[normalize-space()="ส่งรีวิว"]
    Wait Until Element Is Visible       xpath=//*[contains(text(),"รีวิวสำเร็จ")]    60s

    # ==== Another passenger view Review ====
    Open Browser                    ${URL}    edge
    Passenger View Review Login
    View All Route
    View Passenger Info

    # ==== Expected Results ====
    Page Should Contain     ${PASSENGER_REVIEW_SURNAME}
    Page Should Contain     ${REVIEW_TEXT}
    Page Should Contain     สะอาด
    Page Should Contain     คนขับมารยาทดี
    Page Should Contain     ตรงเวลา
    Page Should Contain     ขับปลอดภัย
    Page Should Contain     บริการเป็นกันเอง

UAT-ViewReview-016 Passenger Upload 4 File
    # ==== Passenger create review ====
    Setup Delay Selenium
    Open Browser                    ${URL}    edge
    Passenger Login
    View My Trip
    Execute JavaScript                  window.scrollBy(0,150)
    Click Element                       xpath=(//button[normalize-space()="รีวิวผู้ขับ"])[3]
    Click Element                       xpath=(//button[@type="button"][.//span[contains(normalize-space(),"★")]])[5]
    Select All Checkboxes
    Input Text                          xpath=//textarea[@placeholder="เขียนรีวิวของคุณ... (สูงสุด 501 ตัวอักษร)"]    ${REVIEW_TEXT}
    Upload 4 Images

    # ==== Expected Results ====
    Page Should Contain                 รีวิวผู้ขับ
    Wait Until Element Is Visible       xpath=//*[contains(text(),"เพิ่มรูปได้สูงสุด 3 รูป")]    10s
