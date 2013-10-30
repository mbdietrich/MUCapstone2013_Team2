/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server;

import nz.ac.massey.cs.capstone.player.bot.BotCompilationException;
import nz.ac.massey.cs.capstone.server.util.BotManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Max
 */
public class CodeSubmit extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        String s = request.getParameter("code");
        try {

            BotManager.compile(request.getSession().getAttribute("email").toString(), s, this.getServletContext().getRealPath("."));
            response.getWriter().print("OK!");
        } catch (BotCompilationException e) {
            response.getWriter().print(e.getMessage());
        }
    }
}
