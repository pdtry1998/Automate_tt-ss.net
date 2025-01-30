*** Settings ***
Resource    Redefine_Keyword.robot

*** Keywords ***
Get User Id
    # มี Arguments 2 ตัว ตัวแรก ${user_id} ไว้รับค่า user_id     ตัวที่2  ${response_status}=200 เป็น expected response status
    [Arguments]    ${user_id}=${user_id}       ${response_status}=200
    # สร้างตัวแปร header เก็บ Content-Type=application/json
    ${header}     Create Dictionary
    ...     Content-Type=application/json
    # ประกาศตัวแปร response ใช้ Keyword Get จาก RequestsLibrary ประกอบ header , url , request เข้าด้วยกัน
    ${response}=     Get    headers=${header}     url=https://reqres.in/api/users/${user_id}      data=${EMPTY}
    # set ค่า response json ลงในตัวแปร ${json_resp}
    ${json_resp}        set variable    ${response.json()}
    # set ค่า response text ลงในตัวแปร ${text_resp}
    ${text_resp}        set variable    ${response.text}
    # log json_resp ที่ console
    log to console  ${json_resp}
    # verify Response status โดยเอา response status expected มา compare กับ actual
    should be equal as integers  ${response.status_code}     ${response_status}     url=${response.url}
    # ถ้า response status actual = 200
    IF    ${response.status_code} == 200
        # ให้ไป get value จาก id มาและเก็บไว้ในตัวแปร {id}
        ${id}   Get Value From Json And Set Variable    ${json_resp}    $.data.id
        # ให้ไป get value จาก email มาและเก็บไว้ในตัวแปร {email}
        ${email}        Get Value From Json And Set Variable    ${json_resp}    $.data.email
   # ถ้า response status actual != 200
    ELSE
        # set ค่า ${id} = Null
        ${id}   set variable    Null
        # set ค่า ${email} = Null
        ${email}    set variable    Null
    END
    set test variable      ${id}
    set test variable      ${email}

Create User
    # มี Arguments 2 ตัว ตัวแรก ${body} ไว้รับค่า request     ตัวที่2  ${response_status}=201 เป็น expected response status
    [Arguments]    ${body}=${body}       ${response_status}=201
    # สร้างตัวแปร header เก็บ Content-Type=application/json
    ${header}     Create Dictionary
    ...     Content-Type=application/json
    # ประกาศตัวแปร response ใช้ Keyword Post จาก RequestsLibrary ประกอบ header , url , request เข้าด้วยกัน
    ${response}=     Post      headers=${header}    url=https://reqres.in/api/users      data=${body}
    # set ค่า response json ลงในตัวแปร ${json_resp}
    ${json_resp}        set variable    ${response.json()}
    # set ค่า response text ลงในตัวแปร ${text_resp}
    ${text_resp}        set variable    ${response.text}
    # log json_resp ที่ console
    log to console  ${json_resp}
    # verify Response status โดยเอา response status expected มา compare กับ actual
    should be equal as integers  ${response.status_code}     ${response_status}     url=${response.url}
    # ถ้า response status actual = 201
    IF    ${response.status_code} == 201
        # ให้ไป get value จาก name มาและเก็บไว้ในตัวแปร {actual_name}
        ${actual_name}   Get Value From Json And Set Variable    ${json_resp}    $.name
        # ให้ไป get value จาก job มาและเก็บไว้ในตัวแปร {actual_job}
        ${actual_job}  Get Value From Json And Set Variable    ${json_resp}    $.job
    # ถ้า response status actual != 201
    ELSE
        # set ค่า ${actual_name} = Null
        ${actual_name}   set variable    Null
        # set ค่า ${actual_job} = Null
        ${actual_job}  set variable   Null
    END
    set test variable      ${actual_name}
    set test variable      ${actual_job}

Update User
    # มี Arguments 3 ตัว ตัวแรก ${body} ไว้รับค่า request ตัวที่2 ${user_id} ไว้รับค่า user_id   ตัวที่3  ${response_status}=200 เป็น expected response status
    [Arguments]    ${body}=${body}      ${user_id}=${user_id}      ${response_status}=200
    # สร้างตัวแปร header เก็บ Content-Type=application/json
    ${header}     Create Dictionary
    ...     Content-Type=application/json
    # ประกาศตัวแปร response ใช้ Keyword Put จาก RequestsLibrary ประกอบ header , url , request เข้าด้วยกัน
    ${response}=     Put       headers=${header}     url=https://reqres.in/api/users/${user_id}      data=${body}
    # set ค่า response json ลงในตัวแปร ${json_resp}
    ${json_resp}        set variable    ${response.json()}
    # set ค่า response text ลงในตัวแปร ${text_resp}
    ${text_resp}        set variable    ${response.text}
    # log json_resp ที่ console
    log to console  ${json_resp}
    # verify Response status โดยเอา response status expected มา compare กับ actual
    should be equal as integers  ${response.status_code}     ${response_status}     url=${response.url}
    # ถ้า response status actual = 200
    IF    ${response.status_code} == 200
        # ให้ไป get value จาก name มาและเก็บไว้ในตัวแปร {actual_name}
        ${actual_name}   Get Value From Json And Set Variable    ${json_resp}    $.name
        # ให้ไป get value จาก job มาและเก็บไว้ในตัวแปร {actual_job}
        ${actual_job}  Get Value From Json And Set Variable    ${json_resp}    $.job
     # ถ้า response status actual != 201
    ELSE
        # set ค่า ${actual_name} = Null
        ${actual_name}   set variable    Null
        # set ค่า ${actual_job} = Null
        ${actual_job}  set variable   Null
    END
    set test variable      ${actual_name}
    set test variable      ${actual_job}

*** Keywords ***
Delete User
    # มี Arguments 2 ตัว ตัวแรก ${user_id} ไว้รับค่า user_id     ตัวที่2  ${response_status}=204 เป็น expected response status
    [Arguments]    ${user_id}=${user_id}      ${response_status}=204
    # สร้างตัวแปร header เก็บ Content-Type=application/json
    ${header}     Create Dictionary
    ...     Content-Type=application/json
    # ประกาศตัวแปร response ใช้ Keyword Delete จาก RequestsLibrary ประกอบ header , url  เข้าด้วยกัน
    ${response}=     Delete       headers=${header}     url=https://reqres.in/api/users/${user_id}
    # verify Response status โดยเอา response status expected มา compare กับ actual
    should be equal as integers  ${response.status_code}     ${response_status}     url=${response.url}


