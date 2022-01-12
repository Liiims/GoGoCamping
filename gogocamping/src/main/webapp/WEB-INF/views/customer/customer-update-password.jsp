<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
	<div class="container">
		<div class="row h-100">
			<div class="col-lg-9 mx-auto text-center mt-7 mb-5">
				<div class="hero__search">
					<div style="">
						<h3 style="font-weight: 700;">��й�ȣ ����</h3><br><br>
						<form action="/customer/updateNewPassword" method="post" onsubmit="return checkpassword()">
						<input type="hidden" name="customerId" id="customerId" value="${sessionScope.loginVO.customerId }" >
						<input type="password" name="password" id="password" placeholder="  ���� ��й�ȣ" required="required" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;"><br><br>
						<input type="password" name="customerPassword" id="customerPassword" placeholder="  ������ ��й�ȣ" required="required" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;" onkeyup="passwordStrength()"><br>
						<span id="strengthPassword" ></span><br>
						<input type="password" name="customerPwck" id="customerPwck" placeholder="  ��й�ȣ Ȯ��" required="required" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;" onkeyup="checkPassword()"><br>
						<span id="checkPassword"></span><br>
						<button type="submit" class="site-btn" id="hash" style="height: 50px; background-color: #245207; border-radius: 10px;">�����ϱ�</button><br><br>						
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="<c:url value='/js/core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/sha256.min.js'/>"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript">
	$(function() {
		$("#hash").click(function(){
			var customerPassword = $("#customerPassword").val();
			var customerPwck = $("#customerPwck").val();
			if(customerPassword != customerPwck){
				alert("��й�ȣ�� Ȯ���ϼ���.");
				return false;
			}else{
				var customerPw = CryptoJS.SHA256($("#customerPassword").val()).toString(); 
				$('#customerPassword').val(customerPw);
			}
		});//click
	});//ready
	function checkPassword() {
		var customerPw = document.getElementById("customerPassword").value;
		var customerPwck = document.getElementById("customerPwck").value;
		if (customerPw == customerPwck) {
			document.getElementById("checkPassword").innerHTML = "��й�ȣ ��ġ"
			return true;
		} else {
			document.getElementById("checkPassword").innerHTML = "��й�ȣ ����ġ"
			return false;
		}
	}r
	function passwordStrength() {
		var strength = document.getElementById('strengthPassword');
		var strongRegex = new RegExp(
				"^(?=.{8,})(?=.*[a-zA-Z])(?=.*[0-9])(?=.*\\W).*$", "g");
		var mediumRegex = new RegExp(
				"^(?=.{8,})(((?=.*[a-zA-Z])(?=.*[0-9]))|((?=.*[a-zA-Z])(?=.*[0-9]))).*$",
				"g");
		var enoughRegex = new RegExp("(?=.{6,}).*", "g");
		var pwd = document.getElementById("customerPassword");
		if (pwd.value.length == 0) {
			strength.innerHTML = '��й�ȣ ����üũ';
		} else if (false == enoughRegex.test(pwd.value)) {
			strength.innerHTML = '��й�ȣ�� ª���ϴ�.';
		} else if (strongRegex.test(pwd.value)) {
			strength.innerHTML = '<span style="color:green">����</span>';
		} else if (mediumRegex.test(pwd.value)) {
			strength.innerHTML = '<span style="color:orange">�߰�</span>';
		} else {
			strength.innerHTML = '<span style="color:red">����</span>';
		}
	}
	function checkpassword() {
		var password = CryptoJS.SHA256($("#password").val()).toString(); 
		if (password == "${sessionScope.loginVO.customerPassword}") {
			return true;
		} else {
			alert("���� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			return false;
		}
	}
</script>
</body>
