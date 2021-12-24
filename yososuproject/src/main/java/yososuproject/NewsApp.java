package yososuproject;



public class NewsApp {

	public static void main(String[] args) {
		Crawling craw = new Crawling();
		String aid = "0000000001";
		int count = 0;
		
		while(true) {
			String address= "https://news.naver.com/main/read.nhn?sid1=100&oid=001&aid="+aid;
			craw.download(address);	 // craw 함수에 url을 전달 
			aid = Utils.numberling(aid); // utils.numberling 함수에 aid 전달 
			count++;				//
			if(count==10) break;	// 10개 씩 자를거임 
		}
		
		int size = craw.arr.size(); 
		
		for(int i=0; i<size; i++) {
			System.out.println(craw.arr.get(i).getTitle()); // 제목
			System.out.println(craw.arr.get(i).getAddress()); // 주소
			System.out.println(craw.arr.get(i).getCreatedDate());	// 날짜 
		}
		
	}

}
