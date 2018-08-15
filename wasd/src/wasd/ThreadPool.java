package wasd;

import java.io.File;
import java.util.concurrent.LinkedBlockingQueue;

public class ThreadPool {
	private int numThreads;
	private LinkedBlockingQueue<BooleanTask> queue;
	private BooleanTask bt;
	private Thread threads[];

	public ThreadPool(int numThreads) {
		this.numThreads = numThreads;
		this.queue = new LinkedBlockingQueue();
		this.threads = new Thread[numThreads];
		for (int i = 0; i < numThreads; i++) {
			threads[i] = new Thread(() -> {
				boolean posioned = false;
				while (!posioned) {
					BooleanTask task = null;
					try {
						task = queue.take();
//						System.out.println(task);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					posioned = task.run();
					
				}

			});
			threads[i].start();
		}

	}

	public void schedule(Runnable r) {

		try {
			queue.put(() -> {
				r.run();
				return false;
			});
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void stop() {
		boolean isScheduled = false;
		boolean isJoined = false;
		
		for (int i = 0; i < numThreads; i++) {
			
			while (!isScheduled) {

				try {
					queue.put(() -> true);
					
					isScheduled = true;
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			isScheduled = false;
		}

		for (int j = 0; j < numThreads; j++) {
			while (!isJoined) {
				try {
					System.out.println("isJoined");
					threads[j].join();
					System.out.println(j + "isJoined");
					isJoined = true;
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			isJoined = false;
		}

	}
	public static void main(String args[]){
		ThreadPool threadPool = new ThreadPool(4);
		threadPool.stop();
		
	}
	
}