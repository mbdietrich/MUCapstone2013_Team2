/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package capstone.server;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author Max
 */
public class SessionCleanupService implements HttpSessionListener {

    public void sessionCreated(HttpSessionEvent se) {
        //nothing to do here
    }

    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        GameManager.disconnect(session);
    }
}

