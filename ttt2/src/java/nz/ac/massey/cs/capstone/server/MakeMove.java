/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server;

import nz.ac.massey.cs.capstone.server.util.GameManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Max
 */
public class MakeMove extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String a = request.getParameter("a");
        String b = request.getParameter("b");
        String x = request.getParameter("x");
        String y = request.getParameter("y");

        GameManager.makeMove(request.getSession(), Integer.parseInt(a), Integer.parseInt(b), Integer.parseInt(x), Integer.parseInt(y));
    }

    @Override
    public String getServletInfo() {
        return "Submit the next move to the server";
    }
}
