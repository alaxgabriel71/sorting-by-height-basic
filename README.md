# Sorting by height (basic)

This project works with a default scenario of Factory IO simulator and a Ladder PLC program.

## Scenario explanation
Based on three conveyors, a transfer, and a couple of sensors, the goal of this scenario is to sort incoming packages based on their heights.

Once a package comes to the conveyor entry, it goes to a bar of height sensors: high or low.
The PLC saves the height detected and turns on the load motor.
When the loaded sensor is activated, the LCP consults if the height saved before and trigger the transfer to move the package to the left, if high, or to the right, if low.
The secondary conveyors take charge of the task to drive the packages to their destination.

![sorting by height basic ladder demonstration](https://github.com/user-attachments/assets/4ee79521-d4ed-460d-ad86-d4396fac1f7e "sorting by height basic ladder demonstration")

## Tools used
- [Factory IO](https://factoryio.com/): 3D factory simulator;
- [OpenPLC Editor](https://autonomylogic.com/download/): Code editor for PLC programming;
- [OpenPLC Runtime](https://autonomylogic.com/docs/2-1-openplc-runtime-overview/): Allows running PLC programs created on the OpenPLC Editor.

## Content
The project folder is available to download.

## Demonstration
Watch the demonstration video [here](https://youtu.be/Ny2kuNujqdM).

## Ladder

![sorting by height basic ladder schematic](https://github.com/user-attachments/assets/5d34a139-1d1d-4f5d-868f-667da3b1a05e "sorting by height basic ladder schematic")
