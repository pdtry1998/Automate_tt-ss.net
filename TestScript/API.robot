*** Settings ***
Resource    ../Keyword/API_Keyword.robot
Force Tags      api
Suite Setup        Start Video Recording
Suite Teardown    Stop Video Recording

*** Variables ***
${UserId}     2
${expectedEmail}       janet.weaver@reqres.in
${expected_Name}        Teerayut
${expected_Job}      Qa

*** Test Cases ***
Get User Id Verify Id And Email
    # รับค่า UserId เพื่อไปใช้ใน keyword Get User Id
    Get User Id        ${UserId}
    # เอาค่า actual id ที่ได้จาก keyword Get User Id มา compare กับ expectedId
    Should Be Equal As Numbers     ${id}       ${UserId}
    # เอาค่า actual email ที่ได้จาก keyword Get User Id มา compare กับ expectedEmail
    Should be equal     ${email}       ${expectedEmail}


Create User
    # ใช้ keyword Create User โดยส่ง request ไป {"name": "${expectedName}", "job": "${expectedJob}"}
    Create User     {"name": "${expectedName}", "job": "${expectedJob}"}
    # เอาค่า actual name ที่ได้จาก keyword Create User  มา compare กับ expected name
    Should be equal     ${actual_name}      ${expected_Name}
    # เอาค่า actual job ที่ได้จาก keyword Create User  มา compare กับ expected job
    Should be equal     ${actual_job}      ${expected_Job}

*** Test Cases ***
Update User
    # ใช้ keyword Update User โดยส่ง request และ UserId ไปใช้ใน keyword Update User
    Update User    {"name": "Update${expectedName}", "job": "Update${expectedJob}"}     ${UserId}
    # เอาค่า actual name ที่ได้จาก keyword Update User  มา compare กับ expected name
    Should be equal     ${actual_name}      Update${expected_Name}
    # เอาค่า actual job ที่ได้จาก keyword Update User  มา compare กับ expected job
    Should be equal     ${actual_job}      Update${expected_Job}

*** Test Cases ***
Delete User
    # รับค่า UserId เพื่อไปใช้ใน keyword Delete User ซึ่งมีการ verrify ใน keyword แล้ว
    Delete User     ${UserId}