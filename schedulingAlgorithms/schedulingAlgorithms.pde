import javax.swing.*;   //<>//
import java.awt.*;
import java.util.*;

boolean buttonPressed = false;
PApplet sketch; // Variable to hold the reference to the current sketch

// Number of processes
int numProcesses,timeQuantum,TotalburstTime,startTime,totalCurrentBurstTime = 0;
int[] arrivalTimes,burstTimes,priorities;  
int ganttWidthFactor;
int processNumber1 = 0,processNumber2 = 0,processNumber3 = 0,processNumber4 = 0,processNumber5 = 0;

float[] averageWaitngTime = new float[5];
float[] averageTurnaroundTime = new float[5];

String[] arrivalTimeArr;
String[] burstTimeArr;
String[] priorityArr;

// Array to store process details
ArrayList<Process> processes1;
ArrayList<Process> processes2;
ArrayList<Process> processes3;
ArrayList<Process> processes4;
ArrayList<Process> processes5;
ArrayList<Integer> RRbt;

ArrayList<Process> processRR;
List<Process>processSR;
List<Integer>SRbt;

// Scheduling algorithm instance
SchedulingAlgorithm algorithm1;
RoundRobin algorithm2;
SchedulingAlgorithm algorithm3;
ShortestRemaningTimeNext algorithm4;
SchedulingAlgorithm algorithm5;    

void setup() {
    size(1920, 1080);
    //surface.setResizable(true);
    sketch = this; // Assign the reference to the current sketch
    
    //Initialize process array
    processes1 = new ArrayList<>();
    processes2 = new ArrayList<>();
    processes3 = new ArrayList<>();
    processes4 = new ArrayList<>();
    processes5 = new ArrayList<>();  
    RRbt = new ArrayList<>();
    processRR = new ArrayList<>();
    processSR=new ArrayList <>();
    SRbt=new ArrayList<>();
    
    
    getUserInput();
    
    background(255); 
    //Title
    textSize(50);
    fill(25, 42, 83);
    text("Comparision of Scheduling Algorithms", 600, 50);
    drawlabels();
    drawTable();
    
    textSize(30);
    text("Time Quantum = " + timeQuantum, 265, 95); 
    
}

// method to create a label witha specified font
public JLabel createLabel(String text, Font font) {
    JLabel label = new JLabel(text);
    label.setFont(font);
    return label;
}

public JLabel createLabel2(String text, Font font) {
    JLabel label = new JLabel(text);
    label.setFont(font);
    return label;
}  

void getUserInput() {
    
    //Set font size for the question and input fields
    Font font = new Font(Font.SANS_SERIF, Font.PLAIN, 30);
    
    // Create a panel with a customized layout
    JPanel panel = new JPanel(new GridBagLayout());
    GridBagConstraints constraints = new GridBagConstraints();
    
    // Create and configure the text fields
    JTextField numProcessesField = new JTextField(10);
    numProcessesField.setFont(font);
    JTextField timeQuantumField = new JTextField(10);
    timeQuantumField.setFont(font);
    JTextField arrivalTimeField = new JTextField(30);
    arrivalTimeField.setFont(font);
    JTextField burstTimeField = new JTextField(30);
    burstTimeField.setFont(font);
    JTextField priorityField = new JTextField(30);
    priorityField.setFont(font);
    
    // Add the components to the panel
    constraints.anchor = GridBagConstraints.CENTER;
    constraints.insets.right = 40; // Add left padding
    constraints.insets = new Insets(10, 10, 10, 60); // Add vertical spacing
    
    constraints.gridx = 0;
    constraints.gridy = 0;
    panel.add(createLabel("Enter the number of processes", font), constraints);
    constraints.gridy = 1;    
    panel.add(numProcessesField, constraints);  
    
    constraints.gridx = 0;
    constraints.gridy = 2;
    panel.add(createLabel("Enter the time quantum for Round Robin", font), constraints);
    constraints.gridy = 3; 
    panel.add(timeQuantumField, constraints); 
    
    constraints.gridx = 0;
    constraints.gridy = 4;
    panel.add(createLabel2("Enter arrival times for all processes (Space-separated)", font), constraints);
    constraints.gridx = 0;
    constraints.gridy = 5;
    panel.add(arrivalTimeField, constraints);
    
    constraints.gridx = 0;
    constraints.gridy = 6;
    panel.add(createLabel2("Enter burst times for all processes (Space-separated)", font), constraints);
    constraints.gridx = 0;
    constraints.gridy = 7;
    panel.add(burstTimeField, constraints);   
    
    constraints.gridx = 0;
    constraints.gridy = 8;
    panel.add(createLabel2("Enter priorities for all processes (Space-separated)", font), constraints);
    constraints.gridx = 0;
    constraints.gridy = 9;
    panel.add(priorityField, constraints);
    
    // Show the custom dialog and retrieve the user input
    int option = JOptionPane.showConfirmDialog(null, panel, "Add processes", JOptionPane.OK_CANCEL_OPTION);
    
    if ((option == JOptionPane.OK_OPTION) && (numProcessesField.getText().trim().isEmpty() || 
        timeQuantumField.getText().trim().isEmpty() || arrivalTimeField.getText().trim().isEmpty() || 
        burstTimeField.getText().trim().isEmpty() || priorityField.getText().trim().isEmpty())) {
        JOptionPane.showMessageDialog(null, "Error: No input provided. Please try again.");
        
        buttonPressed = true;
        restartApplication();
        
    } else if (option == JOptionPane.OK_OPTION) {
        
        
        numProcesses = Integer.parseInt(numProcessesField.getText());
        timeQuantum = Integer.parseInt(timeQuantumField.getText());
        arrivalTimeArr = arrivalTimeField.getText().split(" ");
        burstTimeArr = burstTimeField.getText().split(" ");
        priorityArr = priorityField.getText().split(" ");
        
        arrivalTimes = new int[numProcesses];
        burstTimes = new int[numProcesses];
        priorities = new int[numProcesses];            
        
        //Validate input array sizes
        if (arrivalTimeArr.length != numProcesses || burstTimeArr.length != numProcesses || priorityArr.length != numProcesses) {
            JOptionPane.showMessageDialog(null, "Invalid input! The number of values provided doesn't match the number of processes.");
        } else {
            //Parse values and assign to arrays
            for (int i = 0; i < numProcesses; i++) {
                arrivalTimes[i] = Integer.parseInt(arrivalTimeArr[i]);
                burstTimes[i] = Integer.parseInt(burstTimeArr[i]);
                priorities[i] = Integer.parseInt(priorityArr[i]);
                
                //Add values to processes
                processes1.add(new Process(i + 1,arrivalTimes[i], burstTimes[i], priorities[i]));
                processes2.add(new Process(i + 1,arrivalTimes[i], burstTimes[i], priorities[i]));
                processes3.add(new Process(i + 1,arrivalTimes[i], burstTimes[i], priorities[i]));
                processes4.add(new Process(i + 1,arrivalTimes[i], burstTimes[i], priorities[i]));
                processes5.add(new Process(i + 1,arrivalTimes[i], burstTimes[i], priorities[i]));
                TotalburstTime = TotalburstTime + burstTimes[i];
            }
            
            //Set start time
            startTime = arrivalTimes[0];
            for (int i = 0; i < numProcesses; i++) {
                if (startTime > arrivalTimes[i]) {
                    startTime = arrivalTimes[i];
                }
            }
            
            TotalburstTime += startTime;
            
        }   
        // Create scheduling algorithms       
        algorithm1 = new FCFS();
        algorithm2 = new RoundRobin(timeQuantum);
        algorithm3 = new ShortestProcessNext();
        algorithm4 = new ShortestRemaningTimeNext();
        algorithm5 = new PriorityScheduling();
        
        // Calculate waiting time and turnaround time for all algorithms
        algorithm1.execute(processes1);
        algorithm2.execute(processes2);
        RRbt = algorithm2.getBt();
        processRR = algorithm2.getProcess();
        
        algorithm3.execute(processes3);
        algorithm4.execute(processes4);
        SRbt=algorithm4.getBt();
        processSR=algorithm4.getProcess();
        algorithm5.execute(processes5);     
        
        ganttWidthFactor = 1600 / TotalburstTime;
        
    } else if (option == JOptionPane.CANCEL_OPTION) {
        exit();
    } 
}

void draw() {
    
    drawButton();
    
    if ((totalCurrentBurstTime - 1) > TotalburstTime) {
        noLoop();
    }
    
    drawCharts();
    if (totalCurrentBurstTime > TotalburstTime) {
        findBestWaitingTime();
    }
    
    totalCurrentBurstTime++;      
    delay(1000);
}

void drawButton() {
    //Restart button
    fill(241, 243, 244);
    rect(1710, 120, 150, 100);    
    //Draw the button text
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Restart", 1710 + 150 / 2, 120 + 100 / 2);      
}

void mousePressed() {
    //Check if the mouse click is within the button's boundaries
    if (mouseX > 1720 && mouseX < 1720 + 150 && mouseY > 120 && mouseY < 120 + 100) {
        buttonPressed = true;
        restartApplication();
    }
}

void findBestWaitingTime() {    
    float minWaiting = averageWaitngTime[0];
    
    for (int i = 0; i < 5; i++)
        {
        if (averageWaitngTime[i] < minWaiting)
            {
            minWaiting = averageWaitngTime[i];
        }
    }
    
    //Draw rectangle(s)
    int xx = 10;
    int yy = 520;
    int gap = 100;
    fill(255, 255, 0, 20);
    
    for (int i = 0; i < 5; i++)
        {
        if (averageWaitngTime[i] == minWaiting)
            {             
    rect(xx, yy + gap * i,TotalburstTime * ganttWidthFactor + 280,95);
        }
    }
}

void drawlabels() {
    int init = 100;
    textSize(20);
    fill(0);
    textAlign(RIGHT);
    text("First Come", 190,460 + init);
    text("First Served (FCFS)", 200,485 + init);
    text("Round Robin", 200, 575 + init);
    text("Shortest Process Next", 200, 675 + init);
    text("Shortest Remaining", 200, 763 + init);
    text("Time Next", 190, 788 + init);
    text("Priority Scheduling", 200, 870 + init);
    
}

void drawCharts() {    
    int initialX = 250;
    int initialY = 550;
    int rectHeight = 35;
    int gap = 100;
    int algo1TotalTime = startTime,algo2TotalTime = startTime,algo3TotalTime = startTime,algo4TotalTime = startTime,algo5TotalTime = startTime;
    
    int x1 = initialX, x2 = initialX, x3 = initialX, x4 = initialX, x5 = initialX;
    int y1 = initialY, y2 = initialY + gap * 1, y3 = initialY + gap * 2, y4 = initialY + gap * 3, y5 = initialY + gap * 4;
    
    
    
    if (processNumber1 < processes1.size()) {
        
        for (int i = 0;i < processNumber1 + 1;i++) {
            
            if (algo1TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20); 
                rect(x1, y1,processes1.get(i).burstTime * ganttWidthFactor, rectHeight);              
                
                // Draw process label
                fill(0);
                text("P" + processes1.get(i).processId, x1 + processes1.get(i).burstTime * ganttWidthFactor / 2, y1 + rectHeight / 2);
                
                textSize(15);
                text(algo1TotalTime, x1, y1 + rectHeight + 5);
                
                // Update x position for next process
                x1 += processes1.get(i).burstTime * ganttWidthFactor; 
                algo1TotalTime += processes1.get(i).burstTime;             
            }
        } 
        
        fill(0, 255,0);              
        rect(x1 - processes1.get(processNumber1).burstTime * ganttWidthFactor, y1, processes1.get(processNumber1).burstTime * ganttWidthFactor, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes1.get(processNumber1).processId, x1 - processes1.get(processNumber1).burstTime * ganttWidthFactor / 2, y1 + rectHeight / 2);
        
        if (algo1TotalTime <  totalCurrentBurstTime) {
            processNumber1++;
        }
    } else{
        for (int i = 0;i < processes1.size();i++) {
            
            if (algo1TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x1, y1,processes1.get(i).burstTime * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes1.get(i).processId, x1 + processes1.get(i).burstTime * ganttWidthFactor / 2, y1 + rectHeight / 2);
                
                textSize(15);
                text(algo1TotalTime, x1, y1 + rectHeight + 5);
                
                // Update x position for next process
                x1 += processes1.get(i).burstTime * ganttWidthFactor; 
                algo1TotalTime += processes1.get(i).burstTime;                
                
                text(algo1TotalTime, x1, y1 + rectHeight + 5);
            }
        }        
    }
    
    
    if (processNumber2 < processRR.size()) {
        
        for (int i = 0;i < processNumber2 + 1;i++) {
            
            if (algo2TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                
                if (RRbt.get(i) != 0) {
                    textSize(20);
                    rect(x2, y2,RRbt.get(i) * ganttWidthFactor, rectHeight);
                    
                    // Draw process label
                    fill(0);
                    text("P" + processRR.get(i).processId, x2 + RRbt.get(i) * ganttWidthFactor / 2, y2 + rectHeight / 2);
                    
                    textSize(15);
                    text(algo2TotalTime, x2, y2 + rectHeight + 5);
                }
                // Update x position for next process
                x2 += RRbt.get(i) * ganttWidthFactor; 
                algo2TotalTime += RRbt.get(i);             
            }
        }
        
        fill(0, 255,0);              
        rect(x2 - RRbt.get(processNumber2) * ganttWidthFactor, y2, RRbt.get(processNumber2) * ganttWidthFactor, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processRR.get(processNumber2).processId, x2 - RRbt.get(processNumber2) * ganttWidthFactor / 2, y2 + rectHeight / 2);
        
        if (algo2TotalTime <  totalCurrentBurstTime) {
            processNumber2++;
        }
    } else{
        for (int i = 0;i < processRR.size();i++) {
            
            if (algo2TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                if (RRbt.get(i) != 0) {
                    textSize(20);
                    rect(x2, y2,RRbt.get(i) * ganttWidthFactor, rectHeight);
                    
                    // Draw process label
                    fill(0);
                    text("P" + processRR.get(i).processId, x2 + RRbt.get(i) * ganttWidthFactor / 2, y2 + rectHeight / 2);
                    
                    textSize(15);
                    text(algo2TotalTime, x2, y2 + rectHeight + 5);
                }
                // Update x position for next process
                x2 += RRbt.get(i) * ganttWidthFactor; 
                algo2TotalTime += RRbt.get(i);   
                
                text(algo2TotalTime, x2, y2 + rectHeight + 5);
            }
        }        
    }
    
    
    if (processNumber3 < processes3.size()) {
        
        for (int i = 0;i < processNumber3 + 1;i++) {
            
            if (algo3TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x3, y3,processes3.get(i).burstTime * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes3.get(i).processId, x3 + processes3.get(i).burstTime * ganttWidthFactor / 2, y3 + rectHeight / 2);
                
                textSize(15);
                text(algo3TotalTime, x3, y3 + rectHeight + 5);
                
                // Update x position for next process
                x3 += processes3.get(i).burstTime * ganttWidthFactor; 
                algo3TotalTime += processes3.get(i).burstTime;             
            }
        }  
        
        fill(0, 255,0);              
        rect(x3 - processes3.get(processNumber3).burstTime * ganttWidthFactor, y3, processes3.get(processNumber3).burstTime * ganttWidthFactor, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes3.get(processNumber3).processId, x3 - processes3.get(processNumber3).burstTime * ganttWidthFactor / 2, y3 + rectHeight / 2);
        
        if (algo3TotalTime <  totalCurrentBurstTime) {
            processNumber3++;
        }
    } else{
        for (int i = 0;i < processes3.size();i++) {
            
            if (algo3TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x3, y3,processes3.get(i).burstTime * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes3.get(i).processId, x3 + processes3.get(i).burstTime * ganttWidthFactor / 2,y3 + rectHeight / 2);
                
                textSize(15);
                text(algo3TotalTime, x3, y3 + rectHeight + 5);
                
                // Update x position for next process
                x3 += processes3.get(i).burstTime * ganttWidthFactor; 
                algo3TotalTime += processes3.get(i).burstTime;   
                
                text(algo3TotalTime, x3, y3 + rectHeight + 5);
            }
        }        
    }
    
    
   if (processNumber4 < processSR.size()) {
        
        for (int i = 0;i < processNumber4 + 1;i++) {
            
            if (algo4TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x4, y4,SRbt.get(i) * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processSR.get(i).processId, x4 + SRbt.get(i) * ganttWidthFactor / 2, y4 + rectHeight / 2);
                
                textSize(15);
                text(algo4TotalTime, x4, y4 + rectHeight + 5);
                
                // Update x position for next process
                x4 += SRbt.get(i) * ganttWidthFactor; 
                algo4TotalTime += SRbt.get(i);             
            }
        }   
        
        fill(0, 255,0);              
        rect(x4 - SRbt.get(processNumber4) * ganttWidthFactor, y4, SRbt.get(processNumber4) * ganttWidthFactor, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processSR.get(processNumber4).processId, x4 - SRbt.get(processNumber4) * ganttWidthFactor / 2, y4 + rectHeight / 2);
        
        if (algo4TotalTime <  totalCurrentBurstTime) {
            processNumber4++;
        }
    } else{
        for (int i = 0;i < processSR.size();i++) {
            
            if (algo4TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x4, y4,SRbt.get(i) * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processSR.get(i).processId, x4 + SRbt.get(i) * ganttWidthFactor / 2, y4 + rectHeight / 2);
                
                textSize(15);
                text(algo4TotalTime, x4, y4 + rectHeight + 5);
                
                // Update x position for next process
                x4 += SRbt.get(i) * ganttWidthFactor; 
                algo4TotalTime += SRbt.get(i);   
                
                text(algo4TotalTime, x4, y4 + rectHeight + 5);
            }
        }        
    }

    
    if (processNumber5 < processes5.size()) {
        
        for (int i = 0;i < processNumber5 + 1;i++) {
            
            if (algo5TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x5, y5,processes5.get(i).burstTime * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes5.get(i).processId, x5 + processes5.get(i).burstTime * ganttWidthFactor / 2, y5 + rectHeight / 2);
                
                textSize(15);
                text(algo5TotalTime, x5, y5 + rectHeight + 5);
                
                // Update x position for next process
                x5 += processes5.get(i).burstTime * ganttWidthFactor; 
                algo5TotalTime += processes5.get(i).burstTime;             
            }
        }   
        
        fill(0, 255,0);              
        rect(x5 - processes5.get(processNumber5).burstTime * ganttWidthFactor, y5, processes5.get(processNumber5).burstTime * ganttWidthFactor, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes5.get(processNumber5).processId, x5 - processes5.get(processNumber5).burstTime * ganttWidthFactor / 2, y5 + rectHeight / 2);
        
        if (algo5TotalTime <  totalCurrentBurstTime) {
            processNumber5++;
        }
    } else{
        for (int i = 0;i < processes5.size();i++) {
            
            if (algo5TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x5, y5,processes5.get(i).burstTime * ganttWidthFactor, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes5.get(i).processId, x5 + processes5.get(i).burstTime * ganttWidthFactor / 2, y5 + rectHeight / 2);
                
                textSize(15);
                text(algo5TotalTime, x5, y5 + rectHeight + 5);
                
                // Update x position for next process
                x5 += processes5.get(i).burstTime * ganttWidthFactor; 
                algo5TotalTime += processes5.get(i).burstTime;  
                
                text(algo5TotalTime, x5, y5 + rectHeight + 5);
            }
        }        
    }
}


void drawTable() { 
    //Set table dimensions
    int numRows = numProcesses + 1 + 1;                
    int numCols = 4 + 10;
    
    // Set cell dimensions
    int cellWidth = 1540 / numCols;
    int cellHeight = 380 / numRows;
    
    int initialX =  100;
    int initialY =  120;
    
    // Draw horizontal lines
    for (int row = 0; row <= numRows; row++) {
        int y = row * cellHeight + initialY;
        line(initialX, y, initialX + 1540, y);
    }
    
    line(4 * cellWidth + initialX, 1 * cellHeight / 2 + initialY, initialX + 1540, 1 * cellHeight / 2 + initialY);
    
    // Draw vertical lines
    for (int col = 0; col <= 4; col++) {
        int x = col * cellWidth + initialX;
        line(x, initialY, x,initialY + 380 - cellHeight);
    }
    
    // Draw vertical lines
    for (int col = 5; col <=  numCols; col++) {
        int x = col * cellWidth + initialX;
        int init = initialY;
        if (col % 2 == 1) {
            init = initialY + cellHeight / 2;
        }
        
        line(x, init, x, initialY + 380 - cellHeight);
    }
    
    line(initialX, initialY + 380 - 380 / numRows, initialX, initialY + 380);
    
    // Draw vertical lines
    for (int col = 4; col <= numCols; col++) {
        int x = col * cellWidth + initialX;
        int init = initialY + 380 - 380 / numRows;       
        line(x, init, x, initialY + 379);
    }
    
    // Display column topics
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0);
    text("Process ID", initialX + cellWidth / 2, initialY + cellHeight / 2);
    int x = 1 * cellWidth + initialX;
    text("Arrival Time", x + cellWidth / 2, initialY + cellHeight / 2);
    x = 2 * cellWidth + initialX;
    text("Burst Time", x + cellWidth / 2, initialY + cellHeight / 2);
    x = 3 * cellWidth + initialX;
    text("Priority", x + cellWidth / 2, initialY + cellHeight / 2);
    
    x = 4 * cellWidth + initialX;
    text("FCFS", x + cellWidth, initialY + cellHeight / 4);
    x = 6 * cellWidth + initialX;
    text("Round Robin", x + cellWidth, initialY + cellHeight / 4);
    x = 8 * cellWidth + initialX;
    text("Shortest Process Next", x + cellWidth, initialY + cellHeight / 4);
    x = 10 * cellWidth + initialX;
    text("SRTN", x + cellWidth, initialY + cellHeight / 4);
    x = 12 * cellWidth + initialX;
    text("Priority Scheduling", x + cellWidth, initialY + cellHeight / 4);
    
    text("Average time", initialX + cellWidth * 2, initialY + 380 - 380 / numRows + cellHeight / 2);
    
    for (int column = 4; column < numCols; column += 2) {           
        int y = cellHeight / 4 + initialY;
        x = column * cellWidth + initialX;
        // Display cell content         
        text("Waiting", x + cellWidth / 2, y + cellHeight / 2);            
    }
    
    for (int column = 5; column < numCols; column += 2) {           
        int y = cellHeight / 4 + initialY;
        x = column * cellWidth + initialX;
        // Display cell content             
        text("Turnaround", x + cellWidth / 2, y + cellHeight / 2);            
    }
    
    
    // Display table content        
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 0 * cellWidth + initialX;
        // Display cell content              
        text("P" + (row), x + cellWidth / 2, y + cellHeight / 2);            
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 1 * cellWidth + initialX;
        // Display cell content              
        text((arrivalTimes[row - 1]), x + cellWidth / 2, y + cellHeight / 2);            
    } 
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 2 * cellWidth + initialX;
        // Display cell content              
        text((burstTimes[row - 1]), x + cellWidth / 2, y + cellHeight / 2);            
    } 
    
    for (int row = 1; row < numRows - 1; row++) {   
        int y = row * cellHeight + initialY;
        x = 3 * cellWidth + initialX;
        // Display cell content              
        text((priorities[row - 1]), x + cellWidth / 2, y + cellHeight / 2);            
    }
    
    
    
    //Waiting times
    for (int row = 1; row < numRows - 1; row++) {       
        int y = row * cellHeight + initialY;
        x = 4 * cellWidth + initialX;
        
        averageWaitngTime[0] += (float) processes1.get(row - 1).waitingTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes1.get(i).processId == row) {
                text(processes1.get(i).waitingTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 6 * cellWidth + initialX;
        
        averageWaitngTime[1] += (float) processes2.get(row - 1).waitingTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes2.get(i).processId == row) {
                text(processes2.get(i).waitingTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 8 * cellWidth + initialX;
        
        averageWaitngTime[2] += (float) processes3.get(row - 1).waitingTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes3.get(i).processId == row) {
                text(processes3.get(i).waitingTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 10 * cellWidth + initialX;
        
        averageWaitngTime[3] += (float) processes4.get(row - 1).waitingTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes4.get(i).processId == row) {
                text(processes4.get(i).waitingTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;        
        x = 12 * cellWidth + initialX;
        
        averageWaitngTime[4] += (float) processes5.get(row - 1).waitingTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes5.get(i).processId == row) {
                text(processes5.get(i).waitingTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    
    //Turnaroundtimes
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 5 * cellWidth + initialX;
        
        averageTurnaroundTime[0] += (float) processes1.get(row - 1).turnaroundTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes1.get(i).processId == row) {
                text(processes1.get(i).turnaroundTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 7 * cellWidth + initialX;
        
        averageTurnaroundTime[1] += (float) processes2.get(row - 1).turnaroundTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes2.get(i).processId == row) {
                text(processes2.get(i).turnaroundTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 9 * cellWidth + initialX;
        
        averageTurnaroundTime[2] += (float) processes3.get(row - 1).turnaroundTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes3.get(i).processId == row) {
                text(processes3.get(i).turnaroundTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 11 * cellWidth + initialX;
        
        averageTurnaroundTime[3] += (float) processes4.get(row - 1).turnaroundTime / numProcesses;
        
        // Display cell content   
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes4.get(i).processId == row) {
                text(processes4.get(i).turnaroundTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    
    for (int row = 1; row < numRows - 1; row++) {           
        int y = row * cellHeight + initialY;
        x = 13 * cellWidth + initialX;
        
        averageTurnaroundTime[4] += (float) processes5.get(row - 1).turnaroundTime / numProcesses;
        
        // Display cell content 
        for (int i = 0;i < numProcesses;i++)
            {
            if (processes5.get(i).processId == row) {
                text(processes5.get(i).turnaroundTime, x + cellWidth / 2, y + cellHeight / 2); 
            }
        }
        
    }
    
    //Display average times
    int itr1 = 0;
    for (int column = 4; column < numCols; column += 2) {           
        int y = initialY + 380 - cellHeight / 2;
        x = column * cellWidth + initialX;
        
        // Display cell content     
        text(String.valueOf(nf(averageWaitngTime[itr1++])), x + cellWidth / 2, y);            
    }
    
    int itr2 = 0;
    for (int column = 5; column < numCols; column += 2) {           
        int y = initialY + 380 - cellHeight / 2;
        x = column * cellWidth + initialX;
        // Display cell content         
        text(String.valueOf(nf(averageTurnaroundTime[itr2++])), x + cellWidth / 2, y);            
    }
    
}

void restartApplication() {
    //Use reflection to get the name of the current sketch class
    String sketchClassName = sketch.getClass().getName();
    
    //Createa new instance of the current sketch class
    try {
        Class<?> sketchClass = Class.forName(sketchClassName);
        PApplet newSketch = (PApplet) sketchClass.newInstance();
        PApplet.runSketch(new String[]{sketchClassName} , newSketch);
        surface.setVisible(false); // Hide the current sketch window
    } catch(ClassNotFoundException | IllegalAccessException | InstantiationException e) {
        println("An error occurred while restarting the application.");
        e.printStackTrace();
    }
}

public static void main(String[] args) {
    PApplet.runSketch(new String[] {"Scheduling Algorithms - Group 01" } , new schedulingAlgorithms());
}
