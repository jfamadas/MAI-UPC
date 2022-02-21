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
package cat.urv.imas.behaviour.coordinator;

import jade.core.AID;
import jade.lang.acl.ACLMessage;
import jade.proto.AchieveREInitiator;
import cat.urv.imas.agent.CoordinatorAgent;
import cat.urv.imas.onthology.*;
import cat.urv.imas.onthology.MessageContent;
import jade.domain.FIPANames;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Behaviour for the Coordinator agent to deal with AGREE messages. 
 * The Coordinator Agent sends a REQUEST for the
 * information of the game settings. The System Agent sends an AGREE and 
 * then it informs of this information which is stored by the Coordinator Agent. 
 * 
 * NOTE: The game is processed by another behaviour that we add after the 
 * INFORM has been processed.
 */
public class RequesterBehaviour extends AchieveREInitiator {

    public RequesterBehaviour(CoordinatorAgent agent, ACLMessage requestMsg) {
        super(agent, requestMsg);
        agent.log("Started behaviour to deal with AGREEs");
    }

    /**
     * Handle AGREE messages
     *
     * @param msg Message to handle
     */
    @Override
    protected void handleAgree(ACLMessage msg) {
        CoordinatorAgent agent = (CoordinatorAgent) this.getAgent();
        agent.log("AGREE received from " + ((AID) msg.getSender()).getLocalName());
    }

    /**
     * Handle INFORM messages
     *
     * @param msg Message
     */
    @Override
    protected void handleInform(ACLMessage msg) {
        CoordinatorAgent agent = (CoordinatorAgent) this.getAgent();
        agent.log("INFORM received from " + ((AID) msg.getSender()).getLocalName());
        agent.log("MAP Updated.");
        try {
            GameSettings game = (GameSettings) msg.getContentObject();
            agent.setGame(game);
            agent.log(game.getShortString());
            // Send the map to underlying level
            ACLMessage mapmsg = new ACLMessage(ACLMessage.INFORM);
            mapmsg.clearAllReceiver();
            mapmsg.addReceiver(agent.getDiggerCoordinatorAgent());
            mapmsg.addReceiver(agent.getProspectorCoordinatorAgent());
            mapmsg.setContentObject(agent.getGame());
            agent.log("Map sent to underlying levels.");
            agent.send(mapmsg);
            
            
            /************PROVES**************/
            
            MetalField mf = new MetalField(new int[]{1,2},"G",3);
            MetalField mf2 = new MetalField(new int[]{1,3},"G",3);
            List<MetalField> metalFields = new ArrayList<MetalField>();
            metalFields.add(mf);
            metalFields.add(mf2);
            MetalFieldList currentMFL = new MetalFieldList(metalFields);
            agent.setCurrentMFL(currentMFL);
            
            ACLMessage mflmsg = new ACLMessage(ACLMessage.INFORM);
            mflmsg.clearAllReceiver();
            mflmsg.addReceiver(agent.getDiggerCoordinatorAgent());
            mflmsg.setContentObject((Serializable) agent.getCurrentMFL());
            agent.send(mflmsg);
            
            /***********END PROVES***********/
        } catch (Exception e) {
            agent.errorLog("Incorrect content: " + e.toString());
        }
    }
    
    

    /**
     * Handle NOT-UNDERSTOOD messages
     *
     * @param msg Message
     */
    @Override
    protected void handleNotUnderstood(ACLMessage msg) {
        CoordinatorAgent agent = (CoordinatorAgent) this.getAgent();
        agent.log("This message NOT UNDERSTOOD.");
    }

    /**
     * Handle FAILURE messages
     *
     * @param msg Message
     */
    @Override
    protected void handleFailure(ACLMessage msg) {
        CoordinatorAgent agent = (CoordinatorAgent) this.getAgent();
        agent.log("The action has failed.");

    } //End of handleFailure

    /**
     * Handle REFUSE messages
     *
     * @param msg Message
     */
    @Override
    protected void handleRefuse(ACLMessage msg) {
        CoordinatorAgent agent = (CoordinatorAgent) this.getAgent();
        agent.log("Action refused.");
    }

}
