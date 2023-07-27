function checkForm(){
	const frm = document.memberform;
	if(frm.username.value==""){
		frm.username.focus();
		alert("이름을 입력 하세요");
		return false;
	}
	if(frm.userid.value==""){
		frm.userid.focus();
		alert("아이디를 입력 하세요");
		return false;
	}
	if(frm.idok.value==""){
		alert("아이디 중복을 확인하세요");
		return false;
	}
	
	if(frm.userpass.value==""){
		frm.userpass.focus();
		alert("비밀번호를 입력 하세요");
		return false;
	}
	if(frm.address.value==""){
		frm.postcode.focus();
		alert("주소를 입력 하세요");
		return false;
	}
	
	if(frm.job.value==""){
		frm.job.focus();
		alert("직업을 선택하세요.");
		return false;
	}
}

function checkEdtForm(){
	alert("수정");
	return true;
	
}

function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var addr = ''; // 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }


                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
    
    function idcheck(){
		const uid = document.getElementById("userid").value;
		const url = "idcheck.jsp?uid="+uid;
		window.open(url, "chkForm", "width=400, height=300, resizable=no, menubar=no, status=no, toolbar=0, top=100, left=300");
	}
	

	
	
	