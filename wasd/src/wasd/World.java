package wasd;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class World {

	private File file = new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt");
	private int height;
	private int width;
	private double playerX;
	private double playerY;
	private double lookAtX;
	private double lookAtY;
	private int[][] twoDem;
	//

	public World(File file) {
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
		twoDem = new int[width][height];
//		twoDem = new int[hei][width];
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				twoDem[x][y] = sc.nextInt();
				System.out.println(twoDem[x][y]);
			}
		}
	}

	public Vector2 getStart() {
		// int playerX = twoDem[2][1];
		// int playerY = twoDem[2][2];

		Vector2 newVect = new Vector2(playerX, playerY);

		return newVect;

	}

	public Vector2 getLookAt()  {
		// int lookAtX = twoDem[3][1];
		// int lookAtY = twoDem[3][2];

		Vector2 newVect = new Vector2(lookAtX, lookAtY);

		return newVect;
	}

	public int getWidth() {
		return width;
	}

	public int getHeight() {
		return height;
	}

	public int get(int x, int z) {
		 int w = 1;
		 if ((x < width && x >= 0 && z < height && z >= 0) && (twoDem[x][z] == 0)) {
			 w = 0;
		 }
		
		return w;

	}

	public boolean isPassage(int x, int z) {
		boolean isT;
		// int h = twoDem[1][2];
		if (get(x, z) == 0) {
			isT = true;

		} else {
			isT = false;
		}
		return isT;
	}

	public boolean isPassage(Vector2 location) {
		double x = location.getX();
		double y = location.getY();

		return isPassage((int) x, (int) y);
		
	}

	public Tuple2<Double,Boolean> getDistanceToWall(Vector2 location, Vector2 normVD) {
		// which box of the map we're in
		boolean dirCheck;
		double rayDirX = normVD.getX();
		double rayDirY = normVD.getY();
		int mapX = (int) location.getX();
		System.out.println(mapX);
		int mapY = (int) location.getY();

		// length of ray from current position to next x or y-side
		double sideDistX;
		double sideDistY;

		// length of ray from one x or y-side to next x or y-side
		double deltaDistX = Math.abs(1 / rayDirX);
		double deltaDistY = Math.abs(1 / rayDirY);
		double perpWallDist;

		// what direction to step in x or y-direction (either +1 or -1)
		int stepX;
		int stepY;

		int hit = 0; // was there a wall hit?
		int side = 0; // was a NS or a EW wall hit?

		double posX = location.getX();
		double posY = location.getY();

		// calculate step and initial sideDist
		if (rayDirX < 0) {
			stepX = -1;
			sideDistX = (posX - mapX) * deltaDistX;
		} else {
			stepX = 1;
			sideDistX = (mapX + 1.0 - posX) * deltaDistX;
		}
		if (rayDirY < 0) {
			stepY = -1;
			sideDistY = (posY - mapY) * deltaDistY;
		} else {
			stepY = 1;
			sideDistY = (mapY + 1.0 - posY) * deltaDistY;
		}

		// perform DDA
		while (hit == 0) {
			// jump to next map square, OR in x-direction, OR in y-direction
			if (sideDistX < sideDistY) {
				sideDistX += deltaDistX;
				mapX += stepX;
				side = 0;
			} else {
				sideDistY += deltaDistY;
				mapY += stepY;
				side = 1;
			}
			// Check if ray has hit a wall
			if (twoDem[mapX][mapY] > 0)
				hit = 1;
		}

		// Calculate distance projected on camera direction (Euclidean distance will
		// give fisheye effect!)
		if (side == 0) {
			perpWallDist = (mapX - posX + (1 - stepX) / 2) / rayDirX;
		} else {
			perpWallDist = (mapY - posY + (1 - stepY) / 2) / rayDirY;

		}
		if (side == 0) {
			dirCheck = false;
		} else {
			dirCheck = true;
		}

		return new Tuple2<Double, Boolean> (perpWallDist, dirCheck);

//		return newTuple;

	}
	public static  void main(String args[]){
		World test = new World(new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt"));
		Vector2 locat = test.getStart();
		Vector2 NormVD = new Vector2(0.6,0.8);
		System.out.println(test.getDistanceToWall(locat, NormVD).getSecond());
		
	}
}
