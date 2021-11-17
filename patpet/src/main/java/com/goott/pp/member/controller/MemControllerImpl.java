package com.goott.pp.member.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goott.pp.common.base.BaseController;
import com.goott.pp.member.service.MemService;
import com.goott.pp.member.vo.MemVO;

@Controller
@EnableAsync
@RequestMapping("/mem")
public class MemControllerImpl extends BaseController implements MemController{
	@Autowired
	MemService memService;
	@Autowired
	MemVO mem;

	//!!로그인!! 보안문제 때문에 세션에 아이디값만 바인딩 시켜주도록 함
	@Override
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam Map<String, String> loginMap, HttpServletRequest request) throws Exception {
		String message;
		String contextPath = request.getContextPath();
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");

		mem = memService.login(loginMap);
		
		if(mem==null) {
			message = " <script> " 
					+ " alert('아이디나 비밀번호를 확인해주세요..');" 
					+ " location.href='" + contextPath + "/mem/login';" 
					+ " </script>";
		}else{
			String dck = (String) mem.getIs_left(); 
			if(dck.equals("Y")){
				message = " <script> " 
						+ " alert('탈퇴회원입니다.');" 
						+ " location.href='" + contextPath + "/';"
						+ " </script>";
			}
			else{

			String id = mem.getMem_id();
			HttpSession session = request.getSession();
			
			session.setAttribute("isLogOn", true);
			session.setAttribute("memId", id);
			message = " <script> " 
					+ " alert('로그인 되셨습니다.');" 
					+ " location.href='" + contextPath + "/';"
					+ " </script>";
		}
		}
		return new ResponseEntity<String>(message, header, HttpStatus.OK);
	}

	//!!로그아웃!!
	@Override
	@GetMapping("/logout")
	public ResponseEntity<String> logout(HttpServletRequest request) throws Exception {
		String message;
		String contextPath = request.getContextPath();
		HttpSession session = request.getSession();
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
		session.removeAttribute("isLogOn");
		session.removeAttribute("memId");
		
		message = " <script> " 
				+ " alert('로그아웃 되셨습니다.');" 
				+ " location.href='" + contextPath + "/';"
				+ " </script>";

		return new ResponseEntity<String>(message, header, HttpStatus.OK);
	}
	
	//!!회원가입!!
	@Override
	@PostMapping("/register")
	public ResponseEntity<String> regNewMember(@RequestParam Map<String, Object> regMap, HttpServletRequest request)
			throws Exception {
		String message;
		String contextPath = request.getContextPath();
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
		
		try {
			memService.regNewMemInfo(regMap);
			message = " <script>" 
					+ " alert('회원가입을 환영합니다. 다시 로그인 해주세요.');" 
					+ " location.href='" + contextPath + "/mem/login';" 
					+ " </script>";
		} catch (Exception e) {
			message = "<script>" 
					+ " alert('회원가입을 환영합니다. 다시 로그인 해주세요.');" 
					+ " location.href='" + contextPath + "/';" 
					+ " </script>";
			e.printStackTrace();
		}
		return new ResponseEntity<String>(message, header, HttpStatus.OK);
	}
	
	//!!회원가입 아이디 중복검사!!
	@Override
	@PostMapping("/overlapped")
	public ResponseEntity<String> overlapped(@RequestParam("id") String id) throws Exception {
		return new ResponseEntity<>(memService.overlapped(id), HttpStatus.OK);
	}

	//!!비밀번호 수정!!
	@Override
	@PostMapping("/modifypw")
	public ResponseEntity<String> modifypw(@RequestParam Map<String, String> changepwMap, HttpServletRequest request) throws Exception {
		String message =null;
		String contextPath = request.getContextPath();
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
		
		try {
			memService.chgpw(changepwMap);
			message = "<script>" 
					+ " alert('수정이 완료되었습니다.');" 
					+ " location.href='" + contextPath + "/mem/myMain';" 
					+ " </script>";
		}catch(Exception e) {
			message = "<script>" 
					+ " alert('다시 시도해주세요.');" 
					+ " location.href='" + contextPath + "/mem/myMain';"
					+ " </script>";
			e.printStackTrace();
		}
		return new ResponseEntity<String>(message, header, HttpStatus.OK);
	}
	
	//!!이메일수신여부수정!!
	@Override
	@PostMapping("/modifyemail")
	public ResponseEntity<String> modifyemail(@RequestParam Map<String,String> changeemailMap) throws Exception{
		memService.chgemail(changeemailMap);
		return new ResponseEntity<String>(HttpStatus.OK);
	}

	//!!회원탈퇴!!
	@Override
	@ResponseBody
	@PostMapping("/resign")
	public ResponseEntity<String> resignMember(@RequestParam("id") String id, HttpServletRequest request)
			throws Exception {
		HttpHeaders header = new HttpHeaders();
		HttpSession session = request.getSession();
		header.add("Content-Type", "text/html; charset=utf-8");

		memService.dropMember(id);
		session.removeAttribute("isLogOn");
		session.removeAttribute("memId");
		
		return new ResponseEntity<>("success", header, HttpStatus.OK);
	}

	//!!회원ID찾기!!
	@Override
	@PostMapping("/findid")
	public ResponseEntity<String> findMyId(@RequestParam Map<String, Object> findMap, HttpServletRequest request) throws Exception{
		   String id= memService.searchId(findMap);
		   return new ResponseEntity<String>(id,HttpStatus.OK);
	   }
	
	//!!회원PW찾기!!
	@Override
	@PostMapping("/findpw")
	public ResponseEntity<String> findMyPw(@RequestParam Map<String, Object> findMap, HttpServletRequest request) throws Exception{
		   String pw= memService.searchPw(findMap);
		   System.out.println(pw);
		   return new ResponseEntity<String>(pw,HttpStatus.OK);
	   }
	
	//!!회원정보가져오기!!
	@ResponseBody
	@PostMapping(value="/getmyinfo", produces="application/json;charset=utf-8")
	public List<MemVO> getmyinfo(@RequestParam("id")String id)throws Exception{
		List<MemVO> memlist = memService.getInfo(id);
		return memlist;
	}
	   

}
