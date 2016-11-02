package com.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.movie.answermodel.AnswerBean;
import com.movie.answermodel.AnswerDaoInter;
import com.movie.answermodel.AnswerDto;
import com.movie.boardmodel.BoardDaoInter;


@Controller
public class AnswerController {

	@Autowired
	private AnswerDaoInter inter;

	/*
	//선택자료
	@RequestMapping("answerDetail")
	public ModelAndView answerDetail(@RequestParam("no") String a_no){
		boardController 확인
	}
	*/
	
	//답변등록완료
	@RequestMapping(value="answerWrite", method=RequestMethod.POST)
	public String answerWrite(AnswerBean bean){
		boolean b = false;
		try {
			b = inter.answerInsert(bean);
			inter.answerBoardUpdate(bean.getA_no());
		} catch (Exception e) {
			System.out.println("answerWrite err: " + e);
		}
		if(b)
			return "redirect:boardList";
		else
			return "redirect:resources/error.jsp";
	}
	
	//업데이트
	@RequestMapping(value="answerUpdate", method=RequestMethod.GET)
	public ModelAndView answerUpdate(@RequestParam("a_no") String a_no){
		ModelAndView modelAndView = new ModelAndView();
		AnswerDto answer = inter.answerSelectPart(a_no);
		
		modelAndView.setViewName("redirect:boardDetail?no="+a_no);
		modelAndView.addObject("answer", answer);
		modelAndView.addObject("mode", a_no);
		return modelAndView;
	}
	
	//업데이트완료
	@RequestMapping(value="answerUpdate", method=RequestMethod.POST)
	public String answerUpdate(AnswerBean bean){
		inter.answerUpdate(bean);
			return "redirect:boardList";
	}
	
	//삭제
	@RequestMapping("answerDelete")
	public String answerDelete(@RequestParam("a_no") String a_no){
		if(inter.answerDelete(a_no)){
			inter.answerBoardUpdateReset(a_no);
			return "redirect:boardList";
		}else{
			return "redirect:resources/error.jsp";
		}
	}
	
	@RequestMapping("selectAllDelete")
	public String selectAllDelete(@RequestParam("a_no") String a_no){
		if(inter.answerCount(a_no) > 0){
			if(inter.answerDelete(a_no)){
				inter.answerBoardDelete(a_no);
				return "redirect:boardList";
			}else{
				return "redirect:resources/error.jsp";
			}
		}else{
			inter.answerBoardDelete(a_no);
			return "redirect:boardList";
		}
	}
	
}














