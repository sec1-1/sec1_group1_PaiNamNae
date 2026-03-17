*** Settings ***
Library           SeleniumLibrary
Resource          ../../resources/auth_keywords.robot

*** Variables ***     
# ตำแหน่งต้องอยู่ : sec1_group1_PaiNamNae
# คำสั่งที่ใช้รัน : robot test/sprint3/uat/UAT-DriverReportSystem-009.robot

*** Test Cases ***
UAT-009 : DriverReportSystem (Direct Input Mode)
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

    # --- Step 06: ใส่รายละเอียด ---
    System Report Text

    # --- Step 07: อัพโหลดไฟล์ (2 รูป + 1 วิดีโอ) ---
    Upload 2 Image and 1 Video Report

    # --- Step 08: กดส่งรายงาน ---
    Wait Until Element Is Enabled    xpath=//button[text()='ส่งรายงานระบบ']    timeout=30s
    Click Button                     xpath=//button[text()='ส่งรายงานระบบ']
    Wait Until Page Contains         ส่งรายงานสำเร็จ    timeout=30s

    # --- Step 09: ตรวจสอบผลลัพธ์ ---
    Go To Report History Page
    View Latest Report Details

    # --- จบการทำงาน: ค้างหน้าจอไว้ตรวจสอบรายละเอียด ---
    Log To Console    \n[SUCCESS] Report sent! Holding screen for 10 seconds...
    Sleep    10s

    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Website
    Open Browser    ${URL}    edge
    Maximize Browser Window