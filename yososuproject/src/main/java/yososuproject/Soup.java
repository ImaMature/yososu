package yososuproject;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Soup {

	public static void main(String[] args) {
		int page = 2;
		
		//오늘 날짜 가져오기
		SimpleDateFormat dtf = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();

        Date dateObj = calendar.getTime();
        String formattedDate = dtf.format(dateObj);
		
		for(int j=1; j < page; j++) {
			String url = "https://news.naver.com/main/list.naver?mode=LS2D&sid2=263&sid1=101&mid=shm&date="+formattedDate+"&page=" + j;
			Document doc;
			try {
				doc = Jsoup.connect(url).get();
				Elements elements = doc.getElementsByAttributeValue("class", "list_body newsflash_body");
				
				Element element = elements.get(0);
				Elements photoElements = element.getElementsByAttributeValue("class", "photo");
				
				for(int i=0; i<photoElements.size(); i++) {
					Element articleElement = photoElements.get(i);
					Elements aElements = articleElement.select("a");
					Element aElement = aElements.get(0);
					
					String articleUrl = aElement.attr("href");		// 기사링크
					
					Element imgElement = aElement.select("img").get(0);
					String imgUrl = imgElement.attr("src");			// 사진링크
					String title = imgElement.attr("alt");			// 기사제목
					String imgUrl2 = imgUrl.split("106_72")[0];
					Document subDoc = Jsoup.connect(articleUrl).get();
					Element contentElement = subDoc.getElementById("articleBodyContents");
					String content = contentElement.text();			// 기사내용
					StringBuilder sb = new StringBuilder(); 
					String strarr [] = content.split(".");
					
					System.out.println(content);
					//System.out.println(Arrays.toString(strarr));
					
				}
				//System.out.println(j + "page 크롤링 종료");
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
	}




}
			
			
		

