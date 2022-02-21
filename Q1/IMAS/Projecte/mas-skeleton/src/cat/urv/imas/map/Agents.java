/**
 * IMAS base code for the practical work.
 * Copyright (C) 2017 DEIM - URV
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */
package cat.urv.imas.map;

import cat.urv.imas.agent.AgentType;
import cat.urv.imas.onthology.InfoAgent;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Agents list in a cell.
 */
public class Agents implements java.io.Serializable {

    /**
     * Information about the agent the cell contains.
     */
    private Map<AgentType,List<InfoAgent>> agents = new HashMap();

    private int amount;

    public Agents() {
        agents.put(AgentType.DIGGER, new LinkedList());
        agents.put(AgentType.PROSPECTOR, new LinkedList());
        amount = 0;
    }

    public void add(InfoAgent agent) throws Exception {
         if (agent == null) {
            throw new Exception("No valid agent to be set (null)");
        }
        // if everything is OK, we add the new agent to the cell
        this.agents.get(agent.getType()).add(agent);
        amount += 1;
    }

    public void remove(InfoAgent agent) throws Exception {
        if (isEmpty()) {
            throw new Exception("There is no agent in cell");
        } else if (agent == null) {
            throw new Exception("No valid agent to be remove (null).");
        } else if (!agents.get(agent.getType()).contains(agent)) {
            throw new Exception("No matching agent to be removed.");
        }
        // if everything is OK, we remove the agent from the cell
        this.agents.get(agent.getType()).remove(agent);
        amount -= 1;
    }

    public List<InfoAgent> get(AgentType type) {
        return agents.get(type);
    }

    public InfoAgent getFirst() throws Exception {
        if (amount == 0) {
            throw new Exception("There is no agent in the cell");
        }
        for (AgentType type : AgentType.values()) {
            if (agents.get(type).size() > 0) {
                return agents.get(type).get(0);
            }
        }
        throw new Exception("Agents is empty? No agent found");
    }

    public int size() {
        return amount;
    }

    public boolean isEmpty() {
        return amount == 0;
    }
    
    public String getMapMessage() {
        StringBuilder string = new StringBuilder("|");
        for (AgentType type : agents.keySet()) {
            string.append(type.getShortString()).append(":").append(agents.get(type).size()).append("|");
        }
        string.append("|");
        return string.toString();
    }
    
    public String toString() {
        StringBuilder string = new StringBuilder("(");
        for (AgentType type : AgentType.values()) {
            string.append("(").append(type.getShortString()).append(":").append(agents.get(type).size()).append(")");
        }
        string.append(")");
        return string.toString();
    }

}
