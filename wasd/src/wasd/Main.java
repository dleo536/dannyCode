	package wasd;

	import java.lang.management.ManagementFactory;
	import java.lang.management.ThreadMXBean;

	import javafx.embed.swing.SwingFXUtils;
	import java.awt.AWTException;
	import java.awt.Robot;
	import java.awt.image.BufferedImage;
	import java.io.File;
	import java.io.IOException;
	import javafx.application.Application;
	import javafx.application.Platform;
	import javafx.event.EventHandler;
	import javafx.geometry.Bounds;
	import javafx.scene.Cursor;
	import javafx.scene.Group;
	import javafx.scene.Scene;
	import javafx.scene.canvas.Canvas;
	import javafx.scene.canvas.GraphicsContext;
	import javafx.scene.control.Button;
	import javafx.scene.image.WritableImage;
	import javafx.scene.input.KeyCode;
	import javafx.scene.input.KeyEvent;
	import javafx.scene.input.MouseEvent;
	import javafx.scene.layout.StackPane;
	import javafx.scene.paint.Color;
	import javafx.scene.transform.Affine;
	import javafx.stage.Stage;

	public class Main extends Application {
	  private GraphicsContext gc;
	  private Canvas canvas;
	  private Color background;
	  private World world;
	  private Player player;
	  private Raycaster raycaster;
	  private WritableImage imageFirstPerson;
	  private boolean wantsOverlay;
	  private int ndraws;
	  private double accumulatedTime;
	  private static final int FRAMES_PER_TIMING = 25;

	  public static void main(String[] args) {
	    launch(args);
	  }
	  
	  @Override
	  public void start(final Stage stage) throws IOException {
	    stage.setWidth(768);
	    stage.setHeight(512);
	    centerMouse();
	    ndraws = 0;
	    accumulatedTime = 0;

	    stage.setTitle("Wasd"); 

	    wantsOverlay = false;
	    background = Color.GRAY;


//	    String worldPath = "/Users/dannyleo/cs330_2018/wasd/src/wasd/world.txt";
	    String worldPath = getParameters().getRaw().get(0);
	    world = new World(new File(worldPath));
	    player = new Player(world, 45.0);

	    int nThreads = Integer.parseInt(getParameters().getRaw().get(1));
//	    int nThreads = 1;
	    raycaster = new Raycaster(world, player, nThreads);

	    Group root = new Group();
	    canvas = new Canvas(stage.getWidth(), stage.getHeight());
	    gc = canvas.getGraphicsContext2D();
	    draw();
	    root.getChildren().add(canvas);
	    Scene scene = new Scene(root);
	    scene.setCursor(Cursor.NONE);
	    stage.setScene(scene);
	    stage.show();

	    canvas.addEventHandler(MouseEvent.MOUSE_MOVED, new EventHandler<MouseEvent>() {
	      @Override
	      public void handle(MouseEvent e) {
	        if (e.getX() != canvas.getWidth() / 2) {
	          double diff = canvas.getWidth() / 2 - e.getX();
	          player.rotate(0.1 * diff);
	          centerMouse();
	          draw();
	        } else {
	        }
	      }
	    });

	    final double MOVE_DELTA = 0.3;
	    final double TURN_DELTA = 2;

	    canvas.addEventHandler(KeyEvent.KEY_PRESSED, new EventHandler<KeyEvent>() {
	      @Override
	      public void handle(KeyEvent e) {
	        switch (e.getCode()) {
	          case A:
	            player.strafe(-MOVE_DELTA);
	            draw(); 
	            break;
	          case D:
	            player.strafe(MOVE_DELTA);
	            draw(); 
	            break;
	          case W:
	            player.advance(MOVE_DELTA);
	            draw(); 
	            break;
	          case S:
	            player.advance(-MOVE_DELTA);
	            draw(); 
	            break;
	          case Q:
	            player.rotate(TURN_DELTA);
	            draw(); 
	            break;
	          case E:
	            player.rotate(-TURN_DELTA);
	            draw(); 
	            break;
	          case F:
	            stage.setFullScreen(!stage.isFullScreen());
	            canvas.setWidth(stage.getWidth());
	            canvas.setHeight(stage.getHeight());
	            break;
	          case O:
	            wantsOverlay = !wantsOverlay;
	            draw();
	            break;
	          case ESCAPE:
	            raycaster.stop();
	            stage.close();
	            break;
	            
	        }
	      }
	    });

	    canvas.requestFocus();
	  }

	  private void centerMouse() {
	    Platform.runLater(() -> {
	      try {
	        Bounds bounds = canvas.getBoundsInLocal();
	        bounds = canvas.localToScreen(bounds);
	        Robot robot = new Robot();
	        robot.mouseMove((int) (bounds.getMinX() + bounds.getWidth() / 2),
	                        (int) (bounds.getMinY() + bounds.getHeight() / 2));
	      } catch (AWTException ex) {
	        ex.printStackTrace();
	      }
	    });
	  }

	  public void draw() {
	    ThreadMXBean bean = ManagementFactory.getThreadMXBean();
	    long startTime = bean.getCurrentThreadCpuTime();

	    BufferedImage image = raycaster.render((int) canvas.getWidth(), (int) canvas.getHeight());
	    imageFirstPerson = SwingFXUtils.toFXImage(image, imageFirstPerson); 
	    gc.drawImage(imageFirstPerson, 0, 0);
	    if (wantsOverlay) {
	      drawOverlay(200, 200, 0.5);
	    }

	    long endTime = bean.getCurrentThreadCpuTime();
	    accumulatedTime += endTime - startTime;

	    ++ndraws;
	    if (ndraws == FRAMES_PER_TIMING) {
	      System.out.println("Average milliseconds per frame over last " + FRAMES_PER_TIMING + " frames: " + accumulatedTime / (double) ndraws / 1.0e6);
	      ndraws = 0;
	      accumulatedTime = 0;
	    }
	  }

	  public void drawOverlay(int width, int height, double opacity) {
	    double x = canvas.getWidth() - width;
	    double y = canvas.getHeight() - height;

	    Affine oldTransform = gc.getTransform();
	    double aspectWorld = world.getWidth() / (double) world.getHeight();
	    double aspectViewport = width / (double) height;

	    double fitWidth;
	    double fitHeight;
	    double scale;
	    if (aspectViewport < aspectWorld) {
	      fitWidth = width;
	      fitHeight = width / aspectWorld;
	      scale = width / (double) world.getWidth();
	    } else {
	      fitWidth = height * aspectWorld;
	      fitHeight = height;
	      scale = height * world.getHeight();
	    }

	    gc.translate(canvas.getWidth() - fitWidth, fitHeight);
	    gc.scale(1, -1);
	    gc.scale(fitWidth / (double) world.getWidth(), fitHeight / (double) world.getHeight());

	    // Draw cells
	    for (int r = 0; r < world.getHeight(); ++r) {
	      for (int c = 0; c < world.getWidth(); ++c) {
	        int cellType = world.get(c, r);
	        gc.setFill(new Color(cellType, 0.25, 0, opacity));
	        gc.fillRect(c, r, 1, 1);
	      }
	    }

	    // Draw player
	    double playerRadius = 0.25;
	    gc.setFill(Color.WHITE);
	    gc.fillOval(player.getPosition().getX() - playerRadius, player.getPosition().getY() - playerRadius, 2 * playerRadius, 2 * playerRadius);

	    // Draw ray
	    gc.setStroke(Color.GREEN);
	    gc.setLineWidth(0.1);
	    Vector2 target = player.getPosition().add(player.getLookAt().multiply(5));
	    gc.strokeLine(player.getPosition().getX(),
	                  player.getPosition().getY(),
	                  target.getX(),
	                  target.getY());
	    gc.setLineWidth(1.0);

	    gc.setTransform(oldTransform);
	  }
	}

