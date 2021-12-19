package org.kosta.gogocamping.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kosta.gogocamping.model.domain.CustomerVO;

@Mapper
public interface CustomerMapper {

	public CustomerVO loginCustomer(String customerId, String customerPassword);

	void registerCustomer(String customerId, String customerPassword, String customerName, String customerEmail, String customerTel, String customerBirth, String customerPostNumber, String customerAddress, String customerDetailedAddress);
	
	public CustomerVO findCustomerId(String customerId);
	
}
