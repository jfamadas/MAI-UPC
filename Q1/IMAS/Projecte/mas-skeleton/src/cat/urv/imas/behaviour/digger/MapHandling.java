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
package cat.urv.imas.behaviour.digger;

import cat.urv.imas.behaviour.diggercoordinator.*;
import cat.urv.imas.behaviour.coordinator.*;
import cat.urv.imas.behaviour.system.*;
import cat.urv.imas.agent.AgentType;
import cat.urv.imas.onthology.*;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import jade.proto.AchieveREResponder;
import cat.urv.imas.agent.DiggerAgent;
import cat.urv.imas.map.Cell;
import cat.urv.imas.map.PathCell;
import cat.urv.imas.onthology.GameSettings;
import cat.urv.imas.onthology.MessageContent;
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
public class MapHandling extends AchieveREResponder {

    /**
     * Sets up the template of messages to catch.
     *
     * @param agent The agent owning this behaviour
     * @param mt Template to receive future responses in this conversation
     */
    public MapHandling(DiggerAgent agent, MessageTemplate mt) {
        super(agent, mt);
        agent.log("Waiting for the updated map.");
    }

    /**
     * Triggers when the Prospector receives a message following the template
     *
     * @param msg message received.
     * 
     */
    @Override
    protected ACLMessage handleRequest(ACLMessage msg) {
        // Declares the current agent so you can use its getters and setters (and other methods)
        DiggerAgent agent = (DiggerAgent)this.getAgent();
        try {
            // If the received message is a map.
            if(msg.getContentObject().getClass() == cat.urv.imas.onthology.InitialGameSettings.class){
                // sets the value of the agents map to the received map.
                agent.setGame((GameSettings) msg.getContentObject());
                agent.log("MAP Updated");
                // Sends back an inform saying that he has received the map
                ACLMessage reply = new ACLMessage(ACLMessage.INFORM);
                reply.addReceiver(agent.getDiggerCoordinatorAgent());
                reply.setContentObject(MessageContent.MAP_RECEIVED);
                agent.setWaitingMapFlag(false);
                return reply;
            }
            /*            
            // If the received message is a MetalFieldList.
            else if(msg.getContentObject().getClass().equals(cat.urv.imas.onthology.MetalFieldList.class)){
                MetalFieldList metalFields = (MetalFieldList)msg.getContentObject();
                agent.log("MetalFieldList received. Computing bids...");
                while(agent.isWaitingMapFlag())
                {}
                // calls the method computeBids() froms itself to calculate the bid for each metal field
                float[] bids = agent.computeBids(metalFields);
                ACLMessage bidmsg = new ACLMessage(ACLMessage.INFORM);
                bidmsg.addReceiver(agent.getDiggerCoordinatorAgent());
                bidmsg.setContentObject(bids);
                agent.log("Bids sent to DiggerCoordinator.");
                agent.setWaitingMapFlag(true);
                return bidmsg;
            }  */
        } catch (UnreadableException ex) {
            Logger.getLogger(MapHandling.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(MapHandling.class.getName()).log(Level.SEVERE, null, ex);
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
    protected ACLMessage prepareResultNotification(ACLMessage msg, ACLMessage response) {
        return null;
    }

    @Override
    public void reset() {
    }
    


}
