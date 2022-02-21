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

/**
 * Types of agents.
 */
public enum AgentType {
    PROSPECTOR {
        @Override
        public String getShortString() {
            return "P";
        }
    },
    DIGGER {
        @Override
        public String getShortString() {
            return "D";
        }
    },
    PROSPECTOR_COORDINATOR {
        @Override
        public String getShortString() {
            return "PC";
        }
    },
    DIGGER_COORDINATOR {
        @Override
        public String getShortString() {
            return "DC";
        }
    },
    COORDINATOR {
        @Override
        public String getShortString() {
            return "C";
        }
    },
    SYSTEM {
        @Override
        public String getShortString() {
            return "S";
        }
    },
    SILVER_DIGGER_COORDINATOR {
        @Override
        public String getShortString() {
            return "DC_S";
        }
    },
    GOLD_DIGGER_COORDINATOR {
        @Override
        public String getShortString() {
            return "DC_G";
        }
    };
    public abstract String getShortString();
}
