package com.smart.home.service;

import java.util.List;

import com.smart.home.dto.QaDTO;

public interface BoardService {

	List<QaDTO> getMyQaList(String memberId);

}
