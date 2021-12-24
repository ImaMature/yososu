package yososuproject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


//https://news.naver.com/main/read.nhn?sid1=100&oid=001&aid=0000000001
public class Crawling {
	
	public ArrayList<Domain> arr = new ArrayList<>();
	
	//네이버 뉴스 다운로드
	public void download(String address) {
		StringBuilder html = new StringBuilder();

		try {
			//네이버뉴스 사이트에 접속하게 해주는 객체  url 생성, 그안에 네이버뉴스 주소인 address를 넣어준다.
			URL url = new URL(address);
			//사이트에 접속해줌. 엔터의 역활을 해준다.
			URLConnection con = url.openConnection();
			//연결이되면 데이터를 받아오는데 받을때 아스키코드로 받아오는걸 inputStreamReader, BufferedReader로 감싸줘서 가변적으로 받아온걸 바꿔준다.
			BufferedReader download = 
					new BufferedReader(new InputStreamReader(con.getInputStream(),"EUC-KR"));
	
			//데이터를 받아오는데 더이상 부을 값이 없어서 line에 null값이 되게되면 나오게 된다.
			while(true) {
				String line = download.readLine();
				if(line == null) break;
				html.append(line);
			}
			download.close();

			System.out.println("다운로드 종료");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//html 내용을 파싱해야서 articleTitlie (id)를 찾아야 함.
		
		//만약 크롤링해서 인터넷뉴스에 있는 제목을 따올려고 할때, F12버튼을 눌러 소스를 일일히 확인해서 뭘 split으로 잘라서 가져와야할지 확인해야하고,
	    //만약 여러개를 찾으려고 하면은 다 달라서 힘들지만, jsoup는 그런 것들을 단순화 시켜서 찾기 쉽게끔 문서화처럼 시켜준다고 보면 된다. 그래서 찾을때도
	    //뉴스제목이 articleTitle인데 찾으려는 값이 뭔지만 안다면 그것만 입력해주면 알아서 찾아주기에 훨씬 편리하다.
		Document doc = Jsoup.parse(html.toString());
		
		//내부적으로 Elements는 Element들을 가지고있다.
		Elements articleTitle =  doc.select("#articleTitle");
		Element title = null;
		Elements articledate = doc.select(".t11"); //.은 클래스를 찾게 해준다.
		Element title2 = null;
		try {
			title = articleTitle.get(0);
			title2 = articledate.get(0);
			Domain news = new Domain();
			news.setAddress(address);
			news.setTitle(title.text());
			news.setCreatedDate(title2.text());
			arr.add(news);	
		} catch (Exception e) {
			System.out.println("페이지를 찾을 수 없습니다.");
		}	
	}
}
