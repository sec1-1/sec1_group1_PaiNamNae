*** Variable ***
${URL}    http://localhost:3001/
${VALID_USER}    Takumi
${VALID_PASS}    123456789

*** Keywords ***
Login With Valid User
    Open Browser    ${URL}    chrome
    Click Element    xpath=//a[@href='/login']
    Wait Until Location Contains    /login    10s
    Location Should Contain    /login
    Input Text      id=identifier    ${VALID_USER}
    Input Text      id=password    ${VALID_PASS}
    Click Button    xpath=//button[@type='submit']

Admin Login
    Open Browser    ${URL}    chrome
    Input Text      id=username    ${ADMIN_USER}
    Input Text      id=password    ${ADMIN_PASS}
    Click Button    id=login-btn
    Page Should Contain    Dashboard

Dashboard Should Be Visible
    Wait Until Element Is Visible    xpath=//span[normalize-space()='${VALID_USER}']    10s
    Element Should Be Visible    xpath=//span[normalize-space()='${VALID_USER}']

