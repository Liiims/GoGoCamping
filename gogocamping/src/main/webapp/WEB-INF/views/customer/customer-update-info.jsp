<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<body>
	<div class="container">
		<div class="row h-100">
			<div class="col-lg-9 mx-auto text-center mt-7 mb-5">
				<div class="hero__search">
					<div style="">
						<h3 style="font-weight: 700;">ȸ�� ���� ����</h3><br><br>
						<form action="updateInfo" method="post">
						<input type="hidden" name="customerId" id="customerId" value="${customerInfo.customerId }" >
						<input type="text" name="customerName" id="customerName" placeholder="  �̸�" required="required" readonly="readonly" value="${customerInfo.customerName }" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;"><br><br>
						<input type="text" name="customerEmail" id="customerEmail" placeholder="  �̸���" required="required" value="${customerInfo.customerEmail }" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;"><br><br> 
						<input type="text" name="customerTel" id="customerTel" placeholder="  ��ȭ��ȣ ex) 010-1234-5678" required="required" value="${customerInfo.customerTel }" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;"><br><br>
						
						<h5 style="font-weight: 700;">�ּ�</h5><br> 
						<input type="text" id="customerPostNumber" name="customerPostNumber" placeholder="  �����ȣ" required="required" readonly="readonly" value="${customerInfo.customerPostNumber }" style="width: 344px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;">
						<button type="button" class="site-btn" id="address_kakao" style="height: 50px; background-color: #245207; border-radius: 10px; border-radius: 10px;">�ּҰ˻�</button><br><br>
						<input type="text" id="customerAddress" name="customerAddress" placeholder="  �ּ�" required="required" readonly="readonly" value="${customerInfo.customerAddress }" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;"><br><br>
						<input type="text" id="customerDetailedAddress" name="customerDetailedAddress" placeholder="  ���ּ�" required="required" value="${customerInfo.customerDetailedAddress }" style="width: 445px; height: 50px; border: 2.5px solid #245207; border-radius: 10px;"><br><br>
						<button type="submit" class="site-btn" id="hash" style="height: 50px; background-color: #245207; border-radius: 10px;">�����ϱ�</button><br><br>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript">
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //�ּ��Է�ĭ�� Ŭ���ϸ�
        //īī�� ���� �߻�
        new daum.Postcode({
            oncomplete: function(data) { //���ý� �Է°� ����
            	document.getElementById("customerPostNumber").value = data.zonecode; //�����ȣ �ֱ�
                document.getElementById("customerAddress").value = data.address; // �ּ� �ֱ�
                document.querySelector("input[name=customerDetailedAddress]").focus(); //���Է� ��Ŀ��
            }
        }).open();
    });
}
</script>
</body>