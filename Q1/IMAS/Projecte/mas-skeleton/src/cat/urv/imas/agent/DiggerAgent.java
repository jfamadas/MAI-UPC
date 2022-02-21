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
package cat.urv.imas.agent;

import cat.urv.imas.onthology.GameSettings;
import cat.urv.imas.behaviour.digger.*;
import cat.urv.imas.onthology.MessageContent;
import cat.urv.imas.onthology.MetalFieldList;
import jade.core.*;
import jade.domain.*;
import jade.domain.FIPAAgentManagement.*;
import jade.domain.FIPANames.InteractionProtocol;
import jade.lang.acl.*;
import java.util.ArrayList;


public class DiggerAgent extends ImasAgent {

    /*      ATTRIBUTES      */
    private AID diggerCoordinatorAgent;
    
    private GameSettings game;
    
    private int[] currentPosition; //This has to be initializaed (TODO Aleix)
    
    private boolean waitingMapFlag = true;
    
    private MetalFieldList currentMFL;
    
    
    /*      METHODS     */
    public DiggerAgent() {
        super(AgentType.DIGGER);
    }

    public GameSettings getGame() {
        return game;
    }

    public void setGame(GameSettings game) {
        this.game = game;
    }

    public AID getDiggerCoordinatorAgent() {
        return diggerCoordinatorAgent;
    }

    public int[] getCurrentPosition() {
        return currentPosition;
    }

    public void setCurrentPosition(int[] currentPosition) {
        this.currentPosition = currentPosition;
    }

    public boolean isWaitingMapFlag() {
        return waitingMapFlag;
    }

    public void setWaitingMapFlag(boolean waitingMapFlag) {
        this.waitingMapFlag = waitingMapFlag;
    }

    public MetalFieldList getCurrentMFL() {
        return currentMFL;
    }

    public void setCurrentMFL(MetalFieldList currentMFL) {
        this.currentMFL = currentMFL;
    }
       
    
  
    public float[] computeBids(MetalFieldList metalFields){
        
        float[] bids = new float[metalFields.getMetalFields().size()];
        //TODO: itera cada metalfield i per cada un computa la bid
        for (int i = 0; i < bids.length; i++ ){
            bids[i] = i; //EXEMPLE, S'HA DE FER
        }
        
        return bids;       
    }
    

    
    
    /**
     * Agent setup method - called when it first come on-line. Configuration of
     * language to use, ontology and initialization of behaviours.
     */
    @Override
    protected void setup() {

        /* ** Very Important Line (VIL) ***************************************/
        this.setEnabledO2ACommunication(true, 1);
        /* ********************************************************************/

        // Register the agent to the DF
        ServiceDescription sd1 = new ServiceDescription();
        sd1.setType(AgentType.DIGGER.toString());
        sd1.setName(getLocalName());
        sd1.setOwnership(OWNER);
        
        DFAgentDescription dfd = new DFAgentDescription();
        dfd.addServices(sd1);
        dfd.setName(getAID());
        try {
            DFService.register(this, dfd);
            log("Registered to the DF");
        } catch (FIPAException e) {
            System.err.println(getLocalName() + " registration with DF unsucceeded. Reason: " + e.getMessage());
            doDelete();
        }
        
        
        /*      SEARCHS     */
        // search CoordinatorAgent
        ServiceDescription searchCriterion = new ServiceDescription();
        searchCriterion.setType(AgentType.DIGGER_COORDINATOR.toString());
        this.diggerCoordinatorAgent = UtilsAgents.searchAgent(this, searchCriterion);        
        
        
        /*      BEHAVIOURS        */
        
        // It triggers ONLY for the voting protocol (Selectivity)
        MessageTemplate mt1 = MessageTemplate.and(MessageTemplate.MatchPerformative(ACLMessage.INFORM),MessageTemplate.MatchProtocol(MessageContent.SELECTIVITY));
        this.addBehaviour(new SelectivityVoting(this, mt1));
        
        // It triggers when the received message is an INFORM.
        MessageTemplate mt2 = MessageTemplate.and(MessageTemplate.MatchPerformative(ACLMessage.INFORM),MessageTemplate.MatchProtocol(null));
        this.addBehaviour(new MapHandling(this, mt2));
    }
    
    

}
