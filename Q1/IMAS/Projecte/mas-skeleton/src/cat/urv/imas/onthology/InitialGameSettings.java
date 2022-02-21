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
import cat.urv.imas.map.*;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.TreeSet;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Initial game settings and automatic loading from file.
 *
 * Use the GenerateGameSettings to build the game.settings configuration file.
 */
@XmlRootElement(name = "InitialGameSettings")
public class InitialGameSettings extends GameSettings {

    /**
     * Path cell.
     */
    public static final int P = 0;
    /**
     * Digger cell.
     */
    public static final int DC = -1;
    /**
     * Prospector cell.
     */
    public static final int PC = -2;
    /**
     * Manufacturing center cell.
     */
    public static final int MCC = -3;
    /**
     * Field cell.
     */
    public static final int F = -4;

    /**
     * City initialMap. Each number is a cell. The type of each is expressed by a
     * constant (if a letter, see above), or a building (indicating the number
     * of people in that building).
     */
    private int[][] initialMap
            = {
                {F, F, F, MCC, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F},
                {F, P, P, P, P, P, P, P, P, P, P, DC, P, P, P, P, P, P, P, F},
                {F, P, PC, P, P, P, P, DC, P, P, P, P, P, P, P, P, P, P, DC, F},
                {F, P, P, F, F, F, F, F, F, P, P, F, F, F, F, F, F, F, F, F},
                {F, P, P, F, F, F, F, F, MCC, P, P, F, F, F, F, F, F, F, F, F},
                {F, PC, P, F, F, P, P, P, P, P, P, F, F, P, P, P, P, P, P, F},
                {F, P, P, F, F, P, P, P, P, P, P, F, F, P, P, P, P, P, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F},
                {F, P, P, F, F, P, DC, F, F, P, P, F, F, P, P, F, F, P, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F},
                {F, P, P, F, F, P, P, F, F, P, PC, F, F, P, P, F, F, P, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, MCC, F, P, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F, F, DC, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F, F, DC, P, F},
                {F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F},
                {F, P, P, MCC, F, P, P, F, F, P, P, F, F, P, P, F, F, P, P, F},
                {F, P, PC, P, DC, P, P, F, F, P, P, P, P, P, P, F, F, P, P, F},
                {F, P, P, P, P, P, P, F, F, P, P, P, P, P, P, F, F, DC, P, F},
                {F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F},
            };

    /**
     * Number of initial elements to put in the map.
     */
    private int numberInitialElements = 0;
    /**
     * Number of those initial elements which will be visible from
     * the very beginning. At maximum, this value will be numberInitialElements.
     * @see numberInitialElements
     */
    private int numberVisibleInitialElements = 0;
    /**
     * Random number generator.
     */
    private Random numberGenerator;

    @XmlElement(required = true)
    public void setNumberInitialElements(int initial) {
        numberInitialElements = initial;
    }

    public int getNumberInitialElements() {
        return numberInitialElements;
    }

    @XmlElement(required = true)
    public void setNumberVisibleInitialElements(int initial) {
        numberVisibleInitialElements = initial;
    }

    public int getNumberVisibleInitialElements() {
        return numberVisibleInitialElements;
    }

    public int[][] getInitialMap() {
        return initialMap;
    }

    @XmlElement(required = true)
    public void setInitialMap(int[][] initialMap) {
        this.initialMap = initialMap;
    }

    public static final InitialGameSettings load(String filename) {
        if (filename == null) {
            filename = "game.settings";
        }
        try {
            // create JAXBContext which will be used to update writer
            JAXBContext context = JAXBContext.newInstance(InitialGameSettings.class);
            Unmarshaller u = context.createUnmarshaller();
            InitialGameSettings starter = (InitialGameSettings) u.unmarshal(new FileReader(filename));
            starter.initMap();
            return starter;
        } catch (Exception e) {
            System.err.println("Loading of settings from file '" + filename + "' failed!");
            System.exit(-1);
        }
        return null;
    }

    /**
     * Initializes the cell map.
     * @throws Exception if some error occurs when adding agents.
     */
    private void initMap() throws Exception {
        int rows = this.initialMap.length;
        int cols = this.initialMap[0].length;
        map = new Cell[rows][cols];
        int manufacturingCenterIndex = 0;
        this.agentList = new HashMap();
        numberGenerator = new Random(this.getSeed());

        int cell;
        PathCell c;
        Map<CellType, List<Cell>> cells = new HashMap();

        for (int row = 0; row < rows; row++) {
            for (int col = 0; col < cols; col++) {
                cell = initialMap[row][col];
                switch (cell) {
                    case DC:
                        c = new PathCell(row, col);
                        c.addAgent(new DiggerInfoAgent(AgentType.DIGGER, this.getDiggersCapacity()));
                        map[row][col] = c;
                        addAgentToList(AgentType.DIGGER, c);
                        break;
                    case PC:
                        c = new PathCell(row, col);
                        c.addAgent(new InfoAgent(AgentType.PROSPECTOR));
                        map[row][col] = c;
                        addAgentToList(AgentType.PROSPECTOR, c);
                        break;
                    case P:
                        map[row][col] = new PathCell(row, col);
                        break;
                    case MCC:
                        if (manufacturingCenterIndex >= manufacturingCenterPrice.length) {
                            throw new Error(getClass().getCanonicalName() + " : More manufacturing centers in the map than given prices");
                        }
                        if (manufacturingCenterIndex >= manufacturingCenterMetalType.length) {
                            throw new Error(getClass().getCanonicalName() + " : More manufacturing centers in the map than given metal types");
                        }
                        map[row][col] = new ManufacturingCenterCell(row, col, manufacturingCenterPrice[manufacturingCenterIndex], manufacturingCenterMetalType[manufacturingCenterIndex]);
                        manufacturingCenterIndex++;
                        break;
                    case F:
                        // Only SystemAgent can access to the SettableFieldCell
                        map[row][col] = new SettableFieldCell(row, col);
                        break;
                    default:
                        throw new Error(getClass().getCanonicalName() + " : Unexpected type of content in the 2D map");
                }
                CellType type = map[row][col].getCellType();
                List<Cell> list;
                if (cells.containsKey(type)) {
                    list = cells.get(type);
                } else {
                    list = new LinkedList();
                    cells.put(type, list);
                }
                list.add(map[row][col]);
            }
        }

        this.setCellsOfType(cells);

        if (manufacturingCenterIndex != manufacturingCenterPrice.length) {
            throw new Error(getClass().getCanonicalName() + " : Less manufacturing centers in the map than given prices.");
        }
        if (manufacturingCenterIndex != manufacturingCenterMetalType.length) {
            throw new Error(getClass().getCanonicalName() + " : Less manufacturing centers in the map than given metal types.");
        }
        if (0 > this.getNumberInitialElements()) {
            throw new Error(getClass().getCanonicalName() + " : Not allowed negative number of elements.");
        }
        int availableCells = getNumberOfCellsOfType(CellType.FIELD);
        if (availableCells < this.getNumberInitialElements()) {
            throw new Error(getClass().getCanonicalName() + " : You set up more new initial elements ("+ this.getNumberInitialElements() +")than existing cells ("+ availableCells +").");
        }
        if (0 > this.getNumberVisibleInitialElements()) {
            throw new Error(getClass().getCanonicalName() + " : Not allowed negative number of visible elements.");
        }
        if (this.getNumberVisibleInitialElements() > this.getNumberInitialElements()) {
            throw new Error(getClass().getCanonicalName() + " : More visible elements than initial elements.");
        }

        int maxInitial = this.getNumberInitialElements();
        int maxVisible = this.getNumberVisibleInitialElements();

        addElements(maxInitial, maxVisible);
    }


    public void addElements(int maxElements, int maxVisible) {
        CellType ctype = CellType.FIELD;
        int maxCells = getNumberOfCellsOfType(ctype);
        int freeCells = this.getNumberOfCellsOfType(ctype, true);

        if (maxElements < 0) {
            throw new Error(getClass().getCanonicalName() + " : Not allowed negative number of elements.");
        }
        if (maxElements > freeCells) {
            throw new Error(getClass().getCanonicalName() + " : Not allowed add more elements than empty cells.");
        }
        if (maxVisible < 0) {
            throw new Error(getClass().getCanonicalName() + " : Not allowed negative number of visible elements.");
        }
        if (maxVisible > maxElements) {
            throw new Error(getClass().getCanonicalName() + " : More visible elements than number of elements.");
        }

        System.out.println(getClass().getCanonicalName() + " : Adding " + maxElements +
                " elements (" + maxVisible + " of them visible) on a map with " +
                maxCells + " cells (" + freeCells + " of them candidate).");

        if (0 == maxElements) {
            return;
        }

        Set<Integer> initialSet = new TreeSet();
        int index;
        while (initialSet.size() < maxElements) {
            index = numberGenerator.nextInt(maxCells);
            if (isEmpty(index)) {
                initialSet.add(index);
            }
        }

        Set<Integer> visibleSet = new TreeSet();
        Object[] initialCells = initialSet.toArray();
        while (visibleSet.size() < maxVisible) {
            visibleSet.add((Integer)initialCells[numberGenerator.nextInt(maxElements)]);
        }

        MetalType[] types = MetalType.values();
        MetalType type;
        int amount;
        boolean visible;
        for (int i: initialSet) {
            type = types[numberGenerator.nextInt(types.length)];
            amount = numberGenerator.nextInt(this.getMaxAmountOfNewMetal()) + 1;
            visible = visibleSet.contains(i);
            setElements(type, amount, visible, i);
        }
    }

    /**
     * Tells whether the given cell is empty of elements.
     * @param ncell nuber of cell.
     * @return true when empty.
     */
    private boolean isEmpty(int ncell) {
        return ((SettableFieldCell)cellsOfType.get(CellType.FIELD).get(ncell)).isEmpty();
    }

    /**
     * Set up the amount of elements of the given type on the cell specified by
     * ncell. It will be visible whenever stated.
     * @param type type of elements to put in the map.
     * @param amount amount of elements to put into.
     * @param ncell number of cell from a given list.
     * @param visible visible to agents?
     */
    private void setElements(MetalType type, int amount, boolean visible, int ncell) {
        SettableFieldCell cell = (SettableFieldCell)cellsOfType.get(CellType.FIELD).get(ncell);
        cell.setElements(type, amount);
        if (visible) {
            cell.detectMetal();
        }
    }

    /**
     * Process the request of adding new elements onto the map to be run
     * every simulation step.
     *
     * Mainly, it checks the probability of having new elements. If so,
     * it finds the number of cells with new elements, to finally add
     * new elements to the given number of cells.
     *
     * This process also checks that if there is room for the given number of
     * cells. Otherwise and error is thrown.
     */
    public void addElementsForThisSimulationStep() {
        int probabilityOfNewElements = this.getNewMetalProbability();
        int stepProbability = numberGenerator.nextInt(100) +1;

        if (stepProbability < probabilityOfNewElements) {
            System.out.println(getClass().getCanonicalName() + " : " + stepProbability +
                    " < " + probabilityOfNewElements +
                    " (step probability for new elements < probability of new elements)");
            return;
        }

        int maxCells = this.getMaxNumberFieldsWithNewMetal();
        int numberCells = numberGenerator.nextInt(maxCells) + 1;

        // add elements to the given number of cells for this simulation step.
        // all of them hidden.
        addElements(numberCells, 0);
    }

    /**
     * Ensure agent list is correctly updated.
     *
     * @param type agent type.
     * @param cell cell where appears the agent.
     */
    private void addAgentToList(AgentType type, Cell cell) {
        List<Cell> list = this.agentList.get(type);
        if (list == null) {
            list = new ArrayList();
            this.agentList.put(type, list);
        }
        list.add(cell);
    }
}
