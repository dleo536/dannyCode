package wasd;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Test {
	private File file = new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt");
	private int height;
	private int width;
	private double playerX;
	private double playerY;
	private double lookAtX;
	private double lookAtY;
	private int[][] twoDem;
	
	public Test(File file) {
	this.file = file;
	Scanner sc = null;
	try {
		sc = new Scanner(file);

	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	width = sc.nextInt();
	height = sc.nextInt();
	playerX = sc.nextDouble();
	playerY = sc.nextDouble();
	lookAtX = sc.nextDouble();
	lookAtY = sc.nextDouble();
	twoDem = new int[height][width];
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				twoDem[y][x] = sc.nextInt();
			
			}
		}
	}
	public static  void main(String args[]){
		Test test = new Test(new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt"));
		System.out.println(test.width);
		System.out.println(test.height);
		System.out.println(test.twoDem[0][0]);
	}
}

