package wasd;

import java.io.File;

public class Vector2 {
	private final double x;
	private final double y;

	public Vector2(double x, double y) {
		this.x = x;
		this.y = y;

	}

	public double getX() {
		return x;
	}

	public double getY() {
		return y;

	}

	public double length() {
		double leng = (Math.sqrt((Math.pow(x, 2)) + (Math.pow(y, 2))));
		return leng;

	}

	public Vector2 add(Vector2 vect) {

		double newX = x + vect.getX();
		double newY = y + vect.getY();

		return new Vector2(newX, newY);

	}

	public Vector2 subtract(Vector2 vect) {

		double newX = x - vect.getX();
		double newY = y - vect.getY();

		return new Vector2(newX, newY);

	}

	public Vector2 multiply(double scale) {

		double newX = x * scale;
		double newY = y * scale;

		return new Vector2(newX, newY);

	}

	public Vector2 divide(double scale) {

		double newX = x / scale;
		double newY = y / scale;

		return new Vector2(newX, newY);

	}

	public Vector2 normalize() {

		double lengRec = 1 / length();

		Vector2 newVect = new Vector2(x, y).multiply(lengRec);
		return newVect;

	}

	public Vector2 rotate(double deg) {

		double newX = ((x * Math.cos(Math.toRadians(deg))) - (y * Math.sin(Math.toRadians(deg))));
		double newY = ((x * Math.sin(Math.toRadians(deg))) + (y * Math.cos(Math.toRadians(deg))));
		return new Vector2(newX, newY);
	}

	public String toString() {
		String st = String.format("%f,", x);
		String st2 = String.format("%f", y);
		return st + st2;
	}

//	public static void main(String args[]) {
//		World test = new World(new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt"));
//		Vector2 v1 = new Vector2(1, 2);
//		Vector2 v2 = v1.rotate(90);
//
//		System.out.println(v2.toString());
//	}
}
