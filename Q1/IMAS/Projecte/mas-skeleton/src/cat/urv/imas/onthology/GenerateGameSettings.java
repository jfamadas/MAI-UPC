/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cat.urv.imas.onthology;

import static cat.urv.imas.onthology.InitialGameSettings.*;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Random;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;

/**
 * Helper for updating the game settings. To do so, just update the content of
 * the <code>defineSettings()</code> method.
 */
public class GenerateGameSettings {

    private static final int STEPS = 600;
    private static final String FILENAME = "game.settings";

    /*
     * ********************* JUST SET YOUR SETTINGS ****************************
     */
    /**
     * Override the default settings to what you need.
     *
     * @param settings GameSettings instance.
     */
    public static void defineSettings(InitialGameSettings settings) {
        //add here whatever settings.set* to define your new settings.
        settings.setSeed(1234567890);
        settings.setNewMetalProbability(40);
        settings.setMaxNumberFieldsWithNewMetal(3);
        settings.setMaxAmountOfNewMetal(6);
        settings.setDiggersCapacity(6);
        settings.setManufacturingCenterPrice(new int[]{8, 9, 6, 7});
        settings.setManufacturingCenterMetalType(new MetalType[]{
            MetalType.GOLD,
            MetalType.SILVER,
            MetalType.SILVER,
            MetalType.GOLD
        });
        settings.setSimulationSteps(STEPS);
        settings.setTitle("Practical IMAS");
        settings.setNumberInitialElements(10);
        settings.setNumberVisibleInitialElements(10);
        // settings for first date
        int[][] map
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
        settings.setInitialMap(map);
    }

    /*
     * ********************* DO NOT MODIFY BELOW *******************************
     */
    /**
     * Produces a new settings file to be loaded into the game.
     *
     * @param args nothing expected.
     */
    public static final void main(String[] args) {
        InitialGameSettings settings = new InitialGameSettings();

        defineSettings(settings);
        storeSettings(settings);
        testSettings();
    }

    /**
     * Produces an XML file with the whole set of settings from the given
     * GameSettings.
     *
     * @param settings GameSettings to store in a file.
     */
    private static void storeSettings(InitialGameSettings settings) {
        try {

            //create JAXBElement of type GameSettings
            //Pass it the GameSettings object
            JAXBElement<InitialGameSettings> jaxbElement = new JAXBElement(
                    new QName(InitialGameSettings.class.getSimpleName()), InitialGameSettings.class, settings);

            //Create a String writer object which will be
            //used to write jaxbElment XML to string
            StringWriter writer = new StringWriter();

            // create JAXBContext which will be used to update writer
            JAXBContext context = JAXBContext.newInstance(InitialGameSettings.class);

            // marshall or convert jaxbElement containing GameSettings to xml format
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty("jaxb.formatted.output", Boolean.TRUE);
            marshaller.marshal(jaxbElement, writer);

            //print XML string representation of GameSettings
            try {
                PrintWriter out = new PrintWriter(FILENAME, "UTF-8");
                out.println(writer.toString());
                out.close();
            } catch (Exception e) {
                System.err.println("Could not create file '" + FILENAME + "'.");
                System.out.println(writer.toString());
            }

        } catch (JAXBException e) {
            e.printStackTrace();
        }
    }

    /**
     * Checks that settings file was created and it is readable again.
     */
    private static void testSettings() {
        try {
            GameSettings settings = InitialGameSettings.load(FILENAME);
            if (settings.getSimulationSteps() != STEPS) {
                throw new Exception("Something went wrong, we loaded some different to what we stored on '" + FILENAME + "'.");
            }
            System.out.println("Settings loaded again from '" + FILENAME + "'. Ok!");
        } catch (Exception e) {
            System.err.println("Settings could not be loaded from '" + FILENAME + "'!");
            e.printStackTrace();
        }
    }

}
