package ino.web.freeBoard.controller;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		List<FreeBoardDto> list = freeBoardService.freeBoardList();
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/search.ino", method=RequestMethod.POST)
	public HashMap<String,Object>  search(@RequestBody HashMap<String,Object> searchdata ){
		HashMap<String,Object> searchData= new HashMap<String, Object>();
		searchData.put("searchdata", freeBoardService.search(searchdata));
		System.out.println(searchData);
		return searchData;
	}

	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}

	@ResponseBody
	@RequestMapping(value="/freeBoardInsertPro.ino", method=RequestMethod.POST)
	public HashMap<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.freeBoardInsertPro(dto);
			map.put("num", dto.getNum());
			map.put("tf", true);
		} catch (Exception e) {
			map.put("msg", e.getCause().toString());
			map.put("tf", false);
		}
		return map;
	}

	@ResponseBody
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,FreeBoardDto dto){
		FreeBoardDto dtos = freeBoardService.getDetailByNum(dto.getNum());
		System.out.println(dtos);
		return new ModelAndView("freeBoardDetail", "freeBoardDto", dtos);
	}

	@ResponseBody 
	@RequestMapping(value="/freeBoardModify.ino" , method=RequestMethod.POST)
	public HashMap<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			System.out.println(dto);
			freeBoardService.freeBoardModify(dto);
			map.put("num", dto.getNum());
			map.put("tf", true);
		} catch (Exception e) {
			map.put("msg", e.getCause().toString());
			map.put("tf", false);
		}
		System.out.println("맵 : " + map);
		return map;
	}

	@ResponseBody
	@RequestMapping(value="/freeBoardDelete.ino", method=RequestMethod.POST)
	public HashMap<String, Object> FreeBoardDelete(int num){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.FreeBoardDelete(num);
			map.put("tf", true);
		} catch (Exception e) {
			map.put("msg", e.getCause().toString());
			map.put("tf", false);
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/freeBoardDeletes.ino", method=RequestMethod.POST)
	public HashMap<String, Object> FreeBoardDeletes(int[] valueArray ){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.FreeBoardDeletes(valueArray);
			map.put("tf", true);
		} catch (Exception e) {
			map.put("msg", e.getCause().toString());
			map.put("tf", false);
		}
		return map;
	}
	
}