package yososuproject;

public class Utils {

	public static String numberling(String aid) {
		//1. aid를 숫자로 바꾸고
		//2. 1 증가 시키고
		//3. 0으로 붙여준다.
		int temp = Integer.parseInt(aid);
		temp++;
		aid = String.format("%010d", temp); // 뒤에 번호 10번째 자리까지 생성을 하는것임 0이 10개
		//0000000000 aid 만큼 0000000000+ aid(11일경우)   -> 0000000011
		return aid;
	}

}
