package com.goott.pp.member.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;



public interface MemController {

	ResponseEntity<String> login(Map<String, String> loginMap, HttpServletRequest request) throws Exception;

	ResponseEntity<String> logout(HttpServletRequest request) throws Exception;

	ResponseEntity<String> regNewMember(Map<String, Object> regMap, HttpServletRequest request) throws Exception;

	ResponseEntity<String> overlapped(String id) throws Exception;

	ResponseEntity<String> modifypw(Map<String, String> changepwMap, HttpServletRequest request) throws Exception;

	ResponseEntity<String> modifyemail(Map<String, String> changeemailMap) throws Exception;

	ResponseEntity<String> resignMember(String id, HttpServletRequest request) throws Exception;

	ResponseEntity<String> findMyId(Map<String, Object> findMap, HttpServletRequest request) throws Exception;

	ResponseEntity<String> findMyPw(Map<String, Object> findMap, HttpServletRequest request) throws Exception;


}
