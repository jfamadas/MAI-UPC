/**
 *  IMAS base code for the practical work.
 *  Copyright (C) 2014 DEIM - URV
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package cat.urv.imas.behaviour.diggercoordinator;

import cat.urv.imas.behaviour.coordinator.*;
import cat.urv.imas.behaviour.system.*;
import cat.urv.imas.agent.AgentType;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import jade.proto.AchieveREResponder;
import cat.urv.imas.agent.DiggerCoordinatorAgent;
import cat.urv.imas.map.Cell;
import cat.urv.imas.map.PathCell;
import cat.urv.imas.onthology.*;
import cat.urv.imas.onthology.MessageContent;
import jade.core.AID;
import jade.lang.acl.UnreadableException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This method handles the Map sent from above
 */
public class SelectivityVoting extends AchieveREResponder {

    /**
     * Sets up the template of messages to catch.
     *
     * @param agent The agent owning this behaviour
     * @param mt Template to receive future responses in this conversation
     */
    public SelectivityVoting(DiggerCoordinatorAgent agent, MessageTemplate mt) {
        super(agent, mt);
        agent.log("Waiting for bids.");
    }

    /**
     * Triggers when receives a message following the template
     *
     * @param msg message received.
     */
    @Override
    protected ACLMessage handleRequest(ACLMessage msg) {
        // Declares the current agent so you can use its getters and setters (and other methods)
        DiggerCoordinatorAgent agent = (DiggerCoordinatorAgent)this.getAgent();
        try {
            float[] bids = (float[]) msg.getContentObject();
            List<AID> diggers = agent.getDiggerAgents();
            int currentDigger = diggers.indexOf(msg.getSender());
            List aux = agent.getBids();
            aux.set(currentDigger, bids);
            agent.setBids(aux);
            
            int receivedBids = agent.getReceivedBids()+1;
            
            if(receivedBids == agent.getNumDiggers()){
                agent.setReceivedBids(0);
                agent.log("Received all bids.");
                
            }
            
            

                 
        } catch (UnreadableException ex) {
            Logger.getLogger(SelectivityVoting.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /*
     * @param msg ACLMessage the received message
     * @param response ACLMessage the previously sent response message
     * @return ACLMessage to be sent as a result notification, of type INFORM
     * when all was ok, or FAILURE otherwise.
     */
    @Override
    protected ACLMessage prepareResultNotification(ACLMessage msg, ACLMessage response) { //Useless method
        return null;
    }

    @Override
    public void reset() {
    }

}
