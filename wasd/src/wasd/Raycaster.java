package wasd;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class Raycaster {
	private World world;
	private Player player;
	private int numThreads;
	private ThreadPool tp;
	private ReentrantLock rl;
	public Raycaster(World world, Player player, int numThreads) {
		this.world = world;
		this.player = player;
		this.numThreads = numThreads;
		this.tp = new ThreadPool(numThreads);
		this.rl = new ReentrantLock();
	}

	private void drawColumn(int width, int height, Graphics graphics, int columnIndex) {


		double max = (double) width - 1;

		double horiz = (double) columnIndex / max;
		
		double fovp = (horiz * 2.0) - 1.0;
		
		double fov = player.getFieldOfView();
		double angle = (fov / 2.0) * fovp;
		angle = -(angle);
//		System.out.println(player.getLookAt().toString());
		Vector2 vect = (player.getLookAt()).rotate(angle);
		
//		System.out.println("");
		System.out.println(player.getPosition());
		Tuple2<Double, Boolean> distance = world.getDistanceToWall(player.getPosition(), vect);
		
		double hp = height / distance.getFirst();
		double topY = (height/2) - (hp/2);
		double bottomY = (height/2) + (hp/2);
		if(world.getDistanceToWall(player.getPosition(), vect).getSecond()){
		graphics.setColor(Color.blue);
		}else {
			graphics.setColor(Color.CYAN);
		}
		graphics.drawLine(columnIndex, (int)bottomY, columnIndex, (int)topY);

	}
	public void stop() {
		tp.stop();

	}

	public BufferedImage render(int width, int height) {
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics graph = image.getGraphics();
		// Color color =
		graph.setColor(Color.BLACK);
		graph.fillRect(0, 0, width, height);
//		graph.setColor(Color.BLUE);
//		System.out.println(width + "asd");
//		for (int i = 0; i < width; i++) {
//			drawColumn(width, height, graph, i);
//			
//		}
		
		final Condition allColumnsDone = rl.newCondition();
		final AtomicInteger counter = new AtomicInteger(0);
		
		rl.lock();
		for (int i = 0; i < width; i++) {
			int j = i;
			Runnable task = () ->{
				drawColumn(width, height, graph, j);
				rl.lock();
				if(counter.incrementAndGet() == width) {
					allColumnsDone.signal();
				}
				rl.unlock();
			};
			tp.schedule(task);
		}
		allColumnsDone.awaitUninterruptibly();
		
		return image;
	}

	

//	public static void main(String args[]) {
//		World world = new World(new File("/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt"));
//
//		
//		Player player = new Player(world, 45.0);
//		Raycaster ray = new Raycaster(world, player, 1);
//		BufferedImage image = new BufferedImage(world.getWidth(), world.getHeight(), BufferedImage.TYPE_INT_RGB);
//		Graphics graph = image.getGraphics();
//		ray.drawColumn(world.getWidth(), world.getHeight(), graph, world.getWidth());
//	}

}
