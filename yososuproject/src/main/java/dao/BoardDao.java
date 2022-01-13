package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.Board;

public class BoardDao {

	private Connection con;
	private ResultSet rs;
	private PreparedStatement ps;

	public BoardDao() {
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3307/yososu?serverTimezone=UTC", "root", "1234");

			// con =
			// DriverManager.getConnection("jdbc:mysql://localhost:3306/yososu?serverTimezone=UTC"
			// , "root","dhkfeh!!12");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("db연동 실패");
		}
	}

	public static BoardDao boardDao = new BoardDao();

	public static BoardDao getBoardDao() {
		return boardDao;
	}

	// 1. 게시판 글 쓰기
	public boolean boardwrite(Board board) {
		String sql = "insert into board(b_password, b_title, b_contents, b_writer) values(?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, board.getB_title());
			ps.setString(2, board.getB_password());
			ps.setString(3, board.getB_contents());
			ps.setString(4, board.getB_writer());
			ps.executeUpdate();
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	public ArrayList<Board> boardList (){
		ArrayList<Board> boards = new ArrayList<Board>();
		String sql = "select * from board";
		try {
			ps = con.prepareStatement(sql);
			rs =ps.executeQuery();
			while(rs.next()) {
				Board board = new Board(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getInt(7)
				);
				boards.add(board);
			}
			return boards;
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
}
