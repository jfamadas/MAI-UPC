/**
 * IMAS base code for the practical work.
 * Copyright (C) 2014 DEIM - URV
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
package cat.urv.imas.onthology;

import cat.urv.imas.agent.AgentType;
import jade.core.AID;

/**
 * Agent information for digger agents.
 */
public class DiggerInfoAgent extends InfoAgent {

    /**
     * Maximum units of metal of any type able to bring at a time.
     */
    protected int capacity;

    public DiggerInfoAgent(AgentType type) {
        super(type);
    }

    public DiggerInfoAgent(AgentType type, int capacity) {
        super(type);
        this.capacity = capacity;
    }

    public DiggerInfoAgent(AgentType type, AID aid) {
        super(type, aid);
    }

    public DiggerInfoAgent(AgentType type, AID aid, int capacity) {
        super(type, aid);
        this.capacity = capacity;
    }

    /**
     * String representation of this isntance.
     *
     * @return string representation.
     */
    @Override
    public String toString() {
        return "(info-agent (agent-type " + this.getType() + ")"
                + ((null != this.getAID()) ? (" (aid " + this.getAID() + ")") : "")
                + " (capacity " + capacity + ")"
                + ")";
    }

}
