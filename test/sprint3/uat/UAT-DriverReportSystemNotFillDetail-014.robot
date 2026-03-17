*** Settings ***
Library           SeleniumLibrary
Resource          ../../resources/auth_keywords.robot

*** Variables ***     
# ตำแหน่งต้องอยู่ : sec1_group1_PaiNamNae
# คำสั่งที่ใช้รัน : robot test/sprint3/uat/UAT-DriverReportSystemNotFillDetail-014.robot

*** Test Cases ***
UAT-014 : DriverReportSystemNotFillDetail (Direct Input Mode)
    [Documentation]    ทดสอบการส่งรายงานระบบ
    Set Selenium Speed    0.2 seconds

    # --- Step 01: เปิดเบราว์เซอร์ ---
    Open Browser To Website

    # --- Step 02-03: Login ---
    Driver Login

    # --- Step 04: ตรวจสอบการเข้าสู่ระบบและไปหน้ารายงาน ---
    Go To Report System

    # --- Step 05: เลือกหัวข้อ ---
    Wait Until Element Is Visible    xpath=//button[text()='ปัญหาแอปพลิเคชัน']    timeout=10s
    Click Button                     xpath=//button[text()='ปัญหาแอปพลิเคชัน']

    # --- Step 06: อัพโหลดไฟล์ (2 รูป + 1 วิดีโอ) ---
    Upload 2 Image and 1 Video Report

    # --- Step 07: กดส่งรายงาน ---
    Wait Until Element Is Visible    xpath=//button[text()='ส่งรายงานระบบ']    timeout=15s
    Element Should Be Disabled       xpath=//button[text()='ส่งรายงานระบบ']

    # --- จบการทำงาน ---
    Log To Console    \n[PASS] Submit button is correctly disabled when no topic is selected.
    Sleep    10s

    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
    Open Browser    ${URL}    edge
    Maximize Browser Window