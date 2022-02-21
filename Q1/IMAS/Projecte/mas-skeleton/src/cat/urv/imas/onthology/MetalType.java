/**
 * IMAS base code for the practical work.
 * Copyright (C) 2016 DEIM - URV
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

/**
 * Type of metal.
 * It provides a way of representing this type of metal.
 */
public enum MetalType {
    SILVER {
        @Override
        public String getShortString() {
            return "S";
        }
    },
    GOLD {
        @Override
        public String getShortString() {
            return "G";
        }
    };

    /**
     * Gets a letter representation of this type of garbage.
     * @return String a single letter representing the type of garbage.
     */
    public abstract String getShortString();

    /**
     * Gets the MetalType according to its short string.
     * @param type of metal in short string format.
     * @return The type of of metal.
     */
    public static MetalType fromShortString(String type) {
        switch (type) {
            case "S": return SILVER;
            case "G": return GOLD;
            default:
                throw new IllegalArgumentException("Metal type '" + type + "' is not supported.");
        }
    }
}
