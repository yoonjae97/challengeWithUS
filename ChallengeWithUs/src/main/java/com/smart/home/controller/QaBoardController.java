package com.smart.home.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.smart.home.dto.BoardDTO;
import com.smart.home.dto.PagingDTO;
import com.smart.home.dto.QaBoardFileDTO;
import com.smart.home.service.BoardService;


@Controller
@RequestMapping("/board")
public class QaBoardController {

    @Autowired
	BoardService service;

    // �� ���
    @GetMapping("/boardList")
	public ModelAndView boardList(PagingDTO pDTO) {
		System.out.println(pDTO);
	      // �� ���ڵ� �� ����      
	      pDTO.setTotalRecord(service.totalRecord(pDTO));
	      // �ش������� ���ڵ� ����
	      List<BoardDTO> list = service.boardList(pDTO);
	      // ModelAndView
	      System.out.println(list);
	      ModelAndView mav = new ModelAndView();
	      mav.addObject("list", list); // �Ʒ� jsp���Ͽ��� ����� �� �ִ� ������ ��
	      mav.addObject("pDTO", pDTO); // ����������, �˻���, �˻�Ű
	      mav.setViewName("board/boardList");
	      return mav;
	   }
	
	   // �۾��� ������ �̵�
	   @GetMapping("/qaBoardWrite")
	   public ModelAndView boardWrite() {
	      ModelAndView mav = new ModelAndView();
	      mav.setViewName("board/qaBoardWrite");
	      return mav;
	   }

	// �۾��� DB���
	   @PostMapping("/boardWriteOk")
	   public ModelAndView boardWriteOk(HttpServletRequest request, BoardDTO dto) {
	      // HttpServletRequest -> request, HttpSession
	      // HttpSession -> Session��
		   
	  String path = request.getSession().getServletContext().getRealPath("/upload");
	  
	  System.out.println("path->" + path);
	  System.out.println(dto.toString());
	  dto.setMemberId((String)request.getSession().getAttribute("logId"));
	  
	  
		//--------------------���� ���ε�--------------------
		//1. ���� ���ε带 ���ؼ� request��ü�� multipartRequest ��ü�� ����ȯ�Ѵ�.
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		
		//2. MultipartFile��ü�� ������
		List<MultipartFile> fileList = mr.getFiles("qafileName");
		System.out.println("fileList.size()->" + fileList.size());
		
		
		//���ε��� ���ϵ��� ������ �÷���
		List<QaBoardFileDTO> upFileList = new ArrayList<QaBoardFileDTO>();
		
		if(fileList!=null){//÷�������� ���� �� if 1
			
			for(int i=0; i<fileList.size(); i++){//÷������ �� ��ŭ �ݺ� ����
				MultipartFile mf = fileList.get(i);//÷�ε� .MultipartFile��ü ������
			
				String orgFileName = mf.getOriginalFilename();//���ϸ� ������
				System.out.println("orgFileName->" + orgFileName);
				
				if(orgFileName != null && !orgFileName.equals("")) {//���ε��� ������ ������ if2
					
					File f = new File(path, orgFileName);
					if(f.exists()) {//true:������ �ִ�. false:������ ����.
						//���ϸ� ����          0123456789
						//���ϸ�� Ȯ���� �и�    a.b.c.gif
						int point = orgFileName.lastIndexOf(".");//5
						String orgFile = orgFileName.substring(0,point);
						String orgExt = orgFileName.substring(point+1);//������
						
						for(int renameNum=1; ;renameNum++) {
							String newFileName = orgFile + " ("+renameNum+")."+orgExt;
							f = new File(path, newFileName);
							//������ ���� ������ �����
							if(!f.exists()) {//���� ��
								//���� ������� ���ϸ��� ���ε� �� �� ����Ͽ��� �ϹǷ� 
								orgFileName = newFileName;
								break; //�ݺ��� ����
							}
						}//for
					
					}
					//���ε� ����
					try {
						mf.transferTo(new File(path, orgFileName));
					}catch(Exception e) {e.printStackTrace();}
					
					System.out.println("���ε� �� ���ϸ�->" + orgFileName);
					
					QaBoardFileDTO upFileDTO = new QaBoardFileDTO();
					upFileDTO.setQafileName(orgFileName);
					upFileList.add(upFileDTO);
					
				}//if 2
			}//for 1
			
		}//if 1
		
		
	ModelAndView mav = new ModelAndView();
	try {
		//-------------DBó��-------------------
		//���� insert -> ������ ������ ��ȣ�� ����� �޾ƾ� ���ϸ��� db�� �߰� �� �� ����ؾ� �Ѵ�.
		int result = service.boardWriteOk(dto);
		
		//���ϸ��� �ִ� dto�� ���� ��ȣ�� �߰�
		for(int i=0; i<upFileList.size(); i++) {
			upFileList.get(i).setQaNo(dto.getQaNo());
		}
		
		//���ϸ� DB insert - 
		
		int resultFile = service.qaboardfileInsert(upFileList);
	
		//������
		mav.setViewName("redirect:boardList");

		
	}catch(Exception e) {
		e.printStackTrace();
		//���� �����(dto.no)
		service.boardDel(dto.getQaNo(), dto.getMemberId());
		//���ϸ� �����(dto.no)
		service.qaboardfileDelete(dto.getQaNo());
		//���� ����(upFileList)
		for(int i=0; i<upFileList.size(); i++) {
			fileDelete(path, upFileList.get(i).getQafileName());
		}
		
		//����....
		mav.setViewName("qaboard/qaBoardResult");
	}		
		return mav;
	}
	//�ڷ�� �� ���� ����
	@GetMapping("/qaBoardView")
	public ModelAndView qaBoardView(int no, PagingDTO pDTO) {
		ModelAndView mav = new ModelAndView();
		//��ȸ��
		service.hitCount(no);
		//�ش�� ����
		mav.addObject("dto", service.boardSelect(no));
		//�ش���� ÷������ ����
		mav.addObject("fileList", service.qaboardfileSelect(no));
		mav.addObject("pDTO", pDTO);
		//��������
		mav.setViewName("board/qaBoardView");
		return mav;
	}
	//�ڷ�� �� ���� ��
	@GetMapping("/qaBoardEdit")
	public ModelAndView qaBoardEdit(int no) {
		ModelAndView mav = new ModelAndView();
		//���� ��
		mav.addObject("dto", service.boardSelect(no));
		//÷�����ϼ���
		mav.addObject("fileList", service.qaboardfileSelect(no));
		
		mav.setViewName("board/qaBoardEdit");
		return mav;
	}

	//�ڷ�� �� �����ϱ�
	   @PostMapping("/qaBoardEditOk") //no, subject, content, filename, delFile
	   public ModelAndView qaBoardEditOk(BoardDTO dto, HttpSession session, HttpServletRequest request) {
		  dto.setMemberId((String)session.getAttribute("logId"));   
	      //1. ������ ���ε�� ���ϸ�� DB���� ��������
	      List<QaBoardFileDTO> orgFileList = service.qaboardfileSelect(dto.getQaNo());
	      
	      //2. ������ġ
	      String path = session.getServletContext().getRealPath("/upload");
	      
	      //3. ���� �߰��� ���� ���ε��ϱ�-> MultipartHttpServletRequest(request��ü)
	      MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
	      
	      //4. ���ε�� ����(MultipartFile)���
	      List<MultipartFile> fileList = mr.getFiles("qafileName");
	      //���� ���ε��� ���ϸ��
	      List<QaBoardFileDTO> newFileList = new ArrayList<QaBoardFileDTO>();
	      
	      //5. ���ε�� ������ ������ ���ε�(rename)
	      if(fileList != null) {
	         for(int i=0;i<fileList.size(); i++) {
	            MultipartFile mf = fileList.get(i);
	            //���ϸ��ϱ�
	            String orgFileName = mf.getOriginalFilename();
	            if(orgFileName != null && !orgFileName.equals("")){//���ϸ��� ������
	               File f = new File(path, orgFileName);
	               if(f.exists()) {//���� ���ϸ��� ���� ������ �����ϸ�
	                  //�������ϸ�� �ߺ��˻�
	                  int p = orgFileName.lastIndexOf(".");
	                  String fileNoExt = orgFileName.substring(0, p);
	                  String ext = orgFileName.substring(p+1);
	                  
	                  for(int fileNum=1; ; fileNum++) {
	                     String newFile = fileNoExt+" ("+fileNum+")."+ext;
	                     f = new File(path, newFile);
	                     if(!f.exists()) {
	                        orgFileName = newFile;
	                        break;
	                     }//if
	                  }//for
	               }//if   
	               //���ε�
	               try {
	                  mf.transferTo(new File(path, orgFileName));
	                  QaBoardFileDTO fDTO = new QaBoardFileDTO();
	                  fDTO.setQaNo(dto.getQaNo());
	                  fDTO.setQafileName(orgFileName);
	                  newFileList.add(fDTO);
	               } catch (Exception e) {e.printStackTrace();}
	            }//if
	         }//for
	      }//if
	      //DB���
	      /*
	       *    ���� DB����     -> List<DataFileDTO> orgFileList
	       *  ���� ���ε�� ���� -> ListMDataFileDTO> newFileList
	       *  ����������       -> List<String> delFile
	       */
	      // orgFileList�� ���� ���ε�� ���ϸ���� �߰��ϱ�
	      //orgFileList.addAll(newFileList);
	      for(QaBoardFileDTO newDTO:newFileList) {
	         orgFileList.add(newDTO);
	      }
	      if(dto.getDelFile()!=null) {//���������� ������
	         for(int i=0;i<dto.getDelFile().size();i++) {
	            String del = dto.getDelFile().get(i);
	            for(int idx=0;idx<orgFileList.size();idx++) {
	            	QaBoardFileDTO resetFile = orgFileList.get(idx);
	               if(del.equals(resetFile.getQafileName())) {//������ ���ϸ�� orgFileList�� �ִ� ���ϸ��� ������
	               orgFileList.remove(idx);
	               break;
	               }//if
	               }//for
	         }//for
	      }//if
	      //----
	      ModelAndView mav=new ModelAndView();
	      try {
	         //�� ���ڵ� ������Ʈ
	         int result = service.boardEdit(dto);
	         //���ϸ�� ->����, �߰�
	         service.qaboardfileDelete(dto.getQaNo());
	         service.qaboardfileInsert(orgFileList);
	         //������ ������ /upload�������� ����
	         if(dto.getDelFile()!=null) {
	            for(String delFilename:dto.getDelFile()) {
	               fileDelete(path, delFilename);
	            }//for
	         }//if
	         //�۳��뺸��� �̵�
	         mav.setViewName("redirect:qaBoardView?no="+dto.getQaNo());
	      } catch (Exception e) {
	         e.printStackTrace();
	         
	         //���ξ��ε�� ���� ����
	         for(QaBoardFileDTO fDTO: newFileList) {
	            fileDelete(path, fDTO.getQafileName());
	         }
	         //�۳������
	         mav.setViewName("redirect:qaBoardEdit?no="+dto.getQaNo());
	      }
	      return mav;
	   }
	   
	   //�ڷ�� �� �����ϱ�
	   @GetMapping("/boardDel")
	   public ModelAndView qaBoardDel(int no, HttpSession session) {
		   //���� ������ ��� �ʿ���
		   String path = session.getServletContext().getRealPath("/upload");
		   
		   //1. ������ ���� ÷������ ���� �����Ѵ�.
		   List<QaBoardFileDTO> fileList = service.qaboardfileSelect(no);
		   
		   //2. ÷������ ���ڵ带 �����.\
		   int delCount = service.qaboardfileDelete(no);
		   
		   //3. ����(DB����)
			int result = service.boardDel(no, (String)session.getAttribute("logId"));
		   
		   //4. ÷������ ����
		   for(QaBoardFileDTO dto : fileList) {
			   fileDelete(path, dto.getQafileName());
		   }
		   
		   //5. ������ �� ������� �̵�
		   ModelAndView mav = new ModelAndView();
		   if(result>0) {
			   mav.setViewName("redirect:boardList");
		   }else{//	���н� �� ���� ����
			   mav.setViewName("redirect:qaBoardView/"+no);
		   }
		   return mav;
	   }
	   
	   // ���� �����ϴ� �޼ҵ� ------------------------------
	   public void fileDelete(String path, String filename) {
	      try {
	         File f = new File(path, filename);
	         f.delete();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
}
}