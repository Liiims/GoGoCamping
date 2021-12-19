package org.kosta.gogocamping.model.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.kosta.gogocamping.model.domain.SellerVO;

@Mapper
public interface SellerMapper {

	ArrayList<SellerVO> getSellerNotAdmin();

	ArrayList<SellerVO> getSellerAdmin();

	void adminSeller(String sellerId);

}
