/**
 *
 * @author luke
 */
package capstone.game;

import javax.swing.SwingUtilities;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.BorderFactory;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseAdapter;

public class UI {
   
    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI(); 
            }
        });
    }

    // Set up game frame
    private static void createAndShowGUI() {
        JFrame f = new JFrame("Tic Tac Toe");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.add(new MyPanel());
        f.pack();
        f.setVisible(true);
    }
}

class MyPanel extends JPanel {
    
    GameState state = new GameState();
    // Variable for board size, so can be set as needed
    int boardSize = 450;
    int dividerSize = boardSize/9;
    
    public MyPanel() {
        setBorder(BorderFactory.createLineBorder(Color.black));
        
        // Get player moves
        addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                makeMove(e.getX(), e.getY());
            }
        });
    }
    
    private void makeMove(int x, int y) {
        // Convert mouse coords to UI coords
        int xLoc;
        int yLoc;
        if (x/dividerSize < 1) {
            xLoc = 0;
        } else if (x/dividerSize < 2) {
            xLoc = 1;
        } else if (x/dividerSize < 3) {
            xLoc = 2;
        } else if (x/dividerSize < 4) {
            xLoc = 3;
        } else if (x/dividerSize < 5) {
            xLoc = 4;
        } else if (x/dividerSize < 6) {
            xLoc = 5;
        } else if (x/dividerSize < 7) {
            xLoc = 6;
        } else if (x/dividerSize < 8) {
            xLoc = 7;
        } else {
            xLoc = 8;
        }
        
        if (y/dividerSize < 1) {
            yLoc = 0;
        } else if (y/dividerSize < 2) {
            yLoc = 1;
        } else if (y/dividerSize < 3) {
            yLoc = 2;
        } else if (y/dividerSize < 4) {
            yLoc = 3;
        } else if (y/dividerSize < 5) {
            yLoc = 4;
        } else if (y/dividerSize < 6) {
            yLoc = 5;
        } else if (y/dividerSize < 7) {
            yLoc = 6;
        } else if (y/dividerSize < 8) {
            yLoc = 7;
        } else {
            yLoc = 8;
        }
     
        // Convert UI coords to game state coords
        int xSuper;
        int ySuper;
        
        if (xLoc < 3) {
            xSuper = 0;
        } else if (xLoc < 6) {
            xSuper = 1;
            xLoc -= 3;
        } else {
            xSuper = 2;
            xLoc -= 6;
        }
        
        if (yLoc < 3) {
            ySuper = 0;
        } else if (yLoc < 6) {
            ySuper = 1;
            yLoc -= 3;
        } else {
            ySuper = 2;
            yLoc -= 6;
        }
        
        // Check to ensure subgame is playable
        if (state.getCurrentGame().GetSubGame(xSuper, ySuper).getStatus() == 0) {
            // Update game state if square is empty
            if (state.getCurrentGame().GetSubGame(xSuper, ySuper).getGamePiece(xLoc, yLoc) == 0) {
                state.PlacePiece(xSuper, ySuper, xLoc, yLoc);
                // Update UI
                repaint();
            }
        }
    }
    
    // Sets frame size
    public Dimension getPreferredSize() {
        return new Dimension(boardSize,boardSize);
    }
    
    // Draws the game in the frame
    public void paintComponent(Graphics g) {
        super.paintComponent(g);  
        
        // Draw the main board
        g.setColor(Color.BLACK);
        g.drawLine(dividerSize*3, boardSize/90, dividerSize*3, boardSize-boardSize/90);
        g.drawLine(dividerSize*6, boardSize/90, dividerSize*6, boardSize-boardSize/90);
        g.drawLine(boardSize/90, dividerSize*3, boardSize-boardSize/90, dividerSize*3);
        g.drawLine(boardSize/90, dividerSize*6, boardSize-boardSize/90, dividerSize*6);
        
        // Draw subboards
        drawTopLeft(g);
        drawTopMiddle(g);
        drawTopRight(g);
        drawMiddleLeft(g);
        drawMiddle(g);
        drawMiddleRight(g);
        drawBottomLeft(g);
        drawBottomMiddle(g);
        drawBottomRight(g);
    } 
    
    private void drawSmallX(Graphics g, int x, int y) {
        g.setColor(Color.BLUE);
        g.drawLine(x, y, x+dividerSize*2/3, y+dividerSize*2/3);
        g.drawLine(x+dividerSize*2/3, y, x, y+dividerSize*2/3);
        g.setColor(Color.BLACK);
    }
    
    private void drawLargeX(Graphics g, int x, int y) {
        g.setColor(Color.BLUE);
        g.drawLine(x+boardSize/45, y+boardSize/45, x+dividerSize*3-boardSize/45, y+dividerSize*3-boardSize/45);
        g.drawLine(x+dividerSize*3-boardSize/45, y+boardSize/45, x+boardSize/45, y+dividerSize*3-boardSize/45);
        g.setColor(Color.BLACK);
    }
    
    private void drawSmallO(Graphics g, int x, int y) {
        g.setColor(Color.RED);
        g.drawOval(x, y, dividerSize*2/3, dividerSize*2/3);
        g.setColor(Color.BLACK);
    }
    
    private void drawLargeO(Graphics g, int x, int y) {
        g.setColor(Color.RED);
        g.drawOval(x+boardSize/45, y+boardSize/45, dividerSize*3-boardSize/25, dividerSize*3-boardSize/25);
        g.setColor(Color.BLACK);
    }
    
    private void drawTopLeft(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(0, 0);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, 0, 0);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, 0, 0);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize, boardSize/45, dividerSize, dividerSize*3-boardSize/45);
            g.drawLine(dividerSize*2, boardSize/45, dividerSize*2, dividerSize*3-boardSize/45);
            g.drawLine(boardSize/45, dividerSize, dividerSize*3-boardSize/45, dividerSize);
            g.drawLine(boardSize/45, dividerSize*2, dividerSize*3-boardSize/45, dividerSize*2);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, boardSize/45+(x*dividerSize), boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, boardSize/45+(x*dividerSize), boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawTopMiddle(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(1, 0);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, dividerSize*3, 0);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, dividerSize*3, 0);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize*4, boardSize/45, dividerSize*4, dividerSize*3-boardSize/45);
            g.drawLine(dividerSize*5, boardSize/45, dividerSize*5, dividerSize*3-boardSize/45);
            g.drawLine(dividerSize*3+boardSize/45, dividerSize, dividerSize*6-boardSize/45, dividerSize);
            g.drawLine(dividerSize*3+boardSize/45, dividerSize*2, dividerSize*6-boardSize/45, dividerSize*2);
            
            // Draw game state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, dividerSize*3+boardSize/45+(x*dividerSize), boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, dividerSize*3+boardSize/45+(x*dividerSize), boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawTopRight(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(2, 0);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, dividerSize*6, 0);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, dividerSize*6, 0);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize*7, boardSize/45, dividerSize*7, dividerSize*3-boardSize/45);
            g.drawLine(dividerSize*8, boardSize/45, dividerSize*8, dividerSize*3-boardSize/45);
            g.drawLine(dividerSize*6+boardSize/45, dividerSize, dividerSize*9-boardSize/45, dividerSize);
            g.drawLine(dividerSize*6+boardSize/45, dividerSize*2, dividerSize*9-boardSize/45, dividerSize*2);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, dividerSize*6+boardSize/45+(x*dividerSize), boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, dividerSize*6+boardSize/45+(x*dividerSize), boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawMiddleLeft(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(0, 1);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, 0, dividerSize*3);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, 0, dividerSize*3);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize, dividerSize*3+boardSize/45, dividerSize, dividerSize*6-boardSize/45);
            g.drawLine(dividerSize*2, dividerSize*3+boardSize/45, dividerSize*2, dividerSize*6-boardSize/45);
            g.drawLine(boardSize/45, dividerSize*4, dividerSize*3-boardSize/45, dividerSize*4);
            g.drawLine(boardSize/45, dividerSize*5, dividerSize*3-boardSize/45, dividerSize*5);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, boardSize/45+(x*dividerSize), dividerSize*3+boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, boardSize/45+(x*dividerSize), dividerSize*3+boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawMiddle(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(1, 1);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, dividerSize*3, dividerSize*3);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, dividerSize*3, dividerSize*3);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize*4, dividerSize*3+boardSize/45, dividerSize*4, dividerSize*6-boardSize/45);
            g.drawLine(dividerSize*5, dividerSize*3+boardSize/45, dividerSize*5, dividerSize*6-boardSize/45);
            g.drawLine(dividerSize*3+boardSize/45, dividerSize*4, dividerSize*6-boardSize/45, dividerSize*4);
            g.drawLine(dividerSize*3+boardSize/45, dividerSize*5, dividerSize*6-boardSize/45, dividerSize*5);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, dividerSize*3+boardSize/45+(x*dividerSize), dividerSize*3+boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, dividerSize*3+boardSize/45+(x*dividerSize), dividerSize*3+boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawMiddleRight(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(2, 1);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, dividerSize*6, dividerSize*3);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, dividerSize*6, dividerSize*3);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize*7, dividerSize*3+boardSize/45, dividerSize*7, dividerSize*6-boardSize/45);
            g.drawLine(dividerSize*8, dividerSize*3+boardSize/45, dividerSize*8, dividerSize*6-boardSize/45);
            g.drawLine(dividerSize*6+boardSize/45, dividerSize*4, dividerSize*9-boardSize/45, dividerSize*4);
            g.drawLine(dividerSize*6+boardSize/45, dividerSize*5, dividerSize*9-boardSize/45, dividerSize*5);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, dividerSize*6+boardSize/45+(x*dividerSize), dividerSize*3+boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, dividerSize*6+boardSize/45+(x*dividerSize), dividerSize*3+boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawBottomLeft(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(0, 2);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, 0, dividerSize*6);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, 0, dividerSize*6);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize, dividerSize*6+boardSize/45, dividerSize, dividerSize*9-boardSize/45);
            g.drawLine(dividerSize*2, dividerSize*6+boardSize/45, dividerSize*2, dividerSize*9-boardSize/45);
            g.drawLine(boardSize/45, dividerSize*7, dividerSize*3-boardSize/45, dividerSize*7);
            g.drawLine(boardSize/45, dividerSize*8, dividerSize*3-boardSize/45, dividerSize*8);

            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, boardSize/45+(x*dividerSize), dividerSize*6+boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, boardSize/45+(x*dividerSize), dividerSize*6+boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawBottomMiddle(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(1, 2);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, dividerSize*3, dividerSize*6);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, dividerSize*3, dividerSize*6);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize*4, dividerSize*6+boardSize/45, dividerSize*4, dividerSize*9-boardSize/45);
            g.drawLine(dividerSize*5, dividerSize*6+boardSize/45, dividerSize*5, dividerSize*9-boardSize/45);
            g.drawLine(dividerSize*3+boardSize/45, dividerSize*7, dividerSize*6-boardSize/45, dividerSize*7);
            g.drawLine(dividerSize*3+boardSize/45, dividerSize*8, dividerSize*6-boardSize/45, dividerSize*8);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, dividerSize*3+boardSize/45+(x*dividerSize), dividerSize*6+boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, dividerSize*3+boardSize/45+(x*dividerSize), dividerSize*6+boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
    
    private void drawBottomRight(Graphics g) {
        // Get subgame for this subsquare
        SubGame subgame = state.getCurrentGame().GetSubGame(2, 2);
        // If subgame is over...
        if (subgame.getStatus() == 1) {
            drawLargeX(g, dividerSize*6, dividerSize*6);
        }
        else if (subgame.getStatus() == 2) {
            drawLargeO(g, dividerSize*6, dividerSize*6);
        }
        // Else if subgame is still playable
        else {
            // Draw board
            g.drawLine(dividerSize*7, dividerSize*6+boardSize/45, dividerSize*7, dividerSize*9-boardSize/45);
            g.drawLine(dividerSize*8, dividerSize*6+boardSize/45, dividerSize*8, dividerSize*9-boardSize/45);
            g.drawLine(dividerSize*6+boardSize/45, dividerSize*7, dividerSize*9-boardSize/45, dividerSize*7);
            g.drawLine(dividerSize*6+boardSize/45, dividerSize*8, dividerSize*9-boardSize/45, dividerSize*8);
            
            // Draw state
            for (int x=0;x<3;x++) {
                for (int y=0;y<3;y++) {
                    if (subgame.getGamePiece(x, y) == 1) {
                        drawSmallX(g, dividerSize*6+boardSize/45+(x*dividerSize), dividerSize*6+boardSize/45+(y*dividerSize));
                    } else if (subgame.getGamePiece(x, y) == 2) {
                        drawSmallO(g, dividerSize*6+boardSize/45+(x*dividerSize), dividerSize*6+boardSize/45+(y*dividerSize));
                    }
                }
            }
        }
    }
}