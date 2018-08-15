package wasd;

import java.io.File;
//import java.io.IOException;

public class Player {
	private World world;
	private double view;
	private Vector2 posit;
	private Vector2 lookAt;

	public Player(World world, double view) {
		this.world = world;
		this.view = view;
		this.lookAt = world.getLookAt();
		this.posit = world.getStart(); 
	}

	public double getFieldOfView() {
		return view;
	}

	public Vector2 getPosition() {
		return posit;
	}

	public Vector2 getLookAt() {
		return this.lookAt;
	}

	public Vector2 getRight() {

		Vector2 right;
		right = lookAt.rotate(-90);
		return right;
	}

	public void rotate(double degrees) {
		lookAt = lookAt.rotate(degrees);
	}

	public void advance(double distance) {

		if (world.isPassage((posit.add(lookAt.multiply(distance))))) {
			posit = posit.add(lookAt.multiply(distance));
		} else {
			
			posit = posit;
		}

	}

	public void strafe(double distance) {

		if (world.isPassage(posit.add(lookAt.rotate(-90).multiply(distance)))) {
			posit = posit.add(lookAt.rotate(-90).multiply(distance));

		} else {
			posit = posit;
		}
	}
//	public static  void main(String args[]){
//	World test = new World(new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt"));
//	Player player = new Player(test, 2);
//	
//	System.out.println(player.getLookAt());
//	//System.out.println(test.getDistanceToWall(v1, v2).getSecond());
//}

}
