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
package cat.urv.imas.behaviour.prospectorcoordinator;

import cat.urv.imas.behaviour.diggercoordinator.*;
import cat.urv.imas.behaviour.coordinator.*;
import cat.urv.imas.behaviour.system.*;
import cat.urv.imas.agent.AgentType;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import jade.proto.AchieveREResponder;
import cat.urv.imas.agent.ProspectorCoordinatorAgent;
import cat.urv.imas.map.Cell;
import cat.urv.imas.map.PathCell;
import cat.urv.imas.onthology.GameSettings;
import cat.urv.imas.onthology.MessageContent;
import jade.lang.acl.UnreadableException;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * This method handles the Map sent from above
 */
public class MapHandling extends AchieveREResponder {

    /**
     * Sets up the template of messages to catch.
     *
     * @param agent The agent owning this behaviour
     * @param mt Template to receive future responses in this conversation
     */
    public MapHandling(ProspectorCoordinatorAgent agent, MessageTemplate mt) {
        super(agent, mt);
        agent.log("Waiting for the updated map.");
    }

    
    // PARTE 1 DE LA RESPUESTA
    /**
     * Triggers when the ProspectorCoordinator receives a message following the template
     * @param msg message received.
     * @return AGREE message when all was ok, or FAILURE otherwise.
     */
    @Override
    protected ACLMessage handleRequest(ACLMessage msg) {
        // Declares the current agent so you can use its getters and setters (and other methods)
        ProspectorCoordinatorAgent agent = (ProspectorCoordinatorAgent)this.getAgent(); 
        try {
            // If the received message is a map.
            if(msg.getContentObject().getClass() == cat.urv.imas.onthology.InitialGameSettings.class){
                // sets the value of the agents map to the received map.
                agent.setGame((GameSettings) msg.getContentObject());
                agent.log("MAP Updated");

                // Send map to underlying level
                ACLMessage mapmsg = new ACLMessage(ACLMessage.INFORM);
                mapmsg.clearAllReceiver();
                for (int i = 1; i <= agent.getNumProspectors(); i++ ){
                    mapmsg.addReceiver(agent.getProspectorAgents().get(i-1));
                }
                mapmsg.setContentObject(agent.getGame());
                agent.log("Map sent to underlying level");
                return mapmsg;
                
            }
        } catch (UnreadableException ex) {
            Logger.getLogger(MapHandling.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(MapHandling.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // PARTE 2 DE LA RESPUESTA (SOLO SE EJECUTA SI LA 1 DEVUELVE NULL O AGREE)
    /*
     * @param msg ACLMessage the received message
     * @param response ACLMessage the previously sent response message
     * @return ACLMessage to be sent as a result notification, of type INFORM
     * when all was ok, or FAILURE otherwise.
     */
    @Override
    protected ACLMessage prepareResultNotification(ACLMessage msg, ACLMessage response) {
        return null;
    }

    
    @Override
    public void reset() {
    }

}
