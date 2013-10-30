/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package nz.ac.massey.cs.capstone.server;

import nz.ac.massey.cs.capstone.server.util.GameManager;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author Max
 */
public class SessionCleanupService implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        //nothing to do here
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        GameManager.disconnect(session);
    }
}

