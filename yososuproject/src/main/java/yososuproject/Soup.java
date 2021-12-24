package yososuproject;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Soup {

	public static void main(String[] args) {
        try {
            //아래 URL 은 삭제되었을 수 있으므로, 문제가 발생한다면 최신 기사의 URL 을 사용한다.
            Document doc = Jsoup.connect("https://news.naver.com/main/read.naver?mode=LSD&mid=sec&sid1=102&oid=214&aid=0001168041").get();

            Elements elements = doc.select("#articleBodyContents");

            String[] p = elements.get(0).text().split("\\.");

            for (int i = 0; i < p.length; i++) {
                System.out.println(p[i]);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }




}
			
			
		

