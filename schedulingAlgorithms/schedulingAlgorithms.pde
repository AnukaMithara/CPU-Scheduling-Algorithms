import javax.swing.*;
import java.awt.*;
import java.util.*;


// Number of processes
int numProcesses,timeQuantum,TotalburstTime,totalCurrentBurstTime = 0;
int[] arrivalTimes,burstTimes,priorities;  

int processNumber1 = 0,processNumber2 = 0,processNumber3 = 0,processNumber4 = 0,processNumber5 = 0;


// Array to store process details
ArrayList<Process> processes1;
ArrayList<Process> processes2;
ArrayList<Process> processes3;
ArrayList<Process> processes4;
ArrayList<Process> processes5;        

// Scheduling algorithm instance
SchedulingAlgorithm algorithm1;
SchedulingAlgorithm algorithm2;
SchedulingAlgorithm algorithm3;
SchedulingAlgorithm algorithm4;
SchedulingAlgorithm algorithm5;    

void setup() {
    size(1920, 1080);
  
    //Initialize process array
    processes1 = new ArrayList<>();
    processes2 = new ArrayList<>();
    processes3 = new ArrayList<>();
    processes4 = new ArrayList<>();
    processes5 = new ArrayList<>();        
    
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
    
    if (option == JOptionPane.OK_OPTION) {
        numProcesses = Integer.parseInt(numProcessesField.getText());
        timeQuantum = Integer.parseInt(timeQuantumField.getText());
        String[] arrivalTimeArr = arrivalTimeField.getText().split(" ");
        String[] burstTimeArr = burstTimeField.getText().split(" ");
        String[] priorityArr = priorityField.getText().split(" ");
        
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
        }   
        // Create scheduling algorithms       
        algorithm1 = new FCFS();
        algorithm2 = new RoundRobin(timeQuantum);
        algorithm3 = new ShortestProcessNext();
        algorithm4 = new ShortestRemainingTimeNext();
        algorithm5 = new PriorityScheduling();
        
        // Calculate waiting time and turnaround time for all algorithms
        algorithm1.execute(processes1);
        algorithm2.execute(processes2);
        algorithm3.execute(processes3);
        algorithm4.execute(processes4);
        algorithm5.execute(processes5);                              
    } 
    background(255); 
    //Title
    textSize(50);
    fill(25, 42, 83);
    text("Comparision of Scheduling Algorithms", 500, 50);
    
}

void draw() { 
  
    if((totalCurrentBurstTime - 2) > TotalburstTime){
      noLoop();
    }
    
    drawTable();
    
    textSize(40);
    text("Time Quantum = " + timeQuantum, 1300, 200);    

    drawCharts();
    totalCurrentBurstTime++;      
    delay(1000);
    
    
}

void drawCharts() {    
    int initialX = 250;
    int initialY = 500;
    int rectHeight = 35;
    int gap = 100;
    int algo1TotalTime = 0,algo2TotalTime = 0,algo3TotalTime = 0,algo4TotalTime = 0,algo5TotalTime = 0;
    
    int x1 = initialX, x2 = initialX, x3 = initialX, x4 = initialX, x5 = initialX;
    int y1 = initialY, y2 = initialY + gap * 1, y3 = initialY + gap * 2, y4 = initialY + gap * 3, y5 = initialY + gap * 4;
    
   
    
    if (processNumber1 < processes1.size()) {
        
        for (int i = 0;i < processNumber1 + 1;i++) {
            
            if (algo1TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20); 
                rect(x1, y1, processes1.get(i).burstTime * 40, rectHeight);              
     
                // Draw process label
                fill(0);
                text("P" + processes1.get(i).processId, x1 + processes1.get(i).burstTime * 40 / 2, y1 + rectHeight / 2);
                
                textSize(15);
                text(algo1TotalTime, x1, y1 + rectHeight + 5);
                
                // Update x position for next process
                x1 += processes1.get(i).burstTime * 40; 
                algo1TotalTime += processes1.get(i).burstTime;             
            }
        } 
        
        fill(0, 255, 0);              
        rect(x1 - processes1.get(processNumber1).burstTime * 40, y1, processes1.get(processNumber1).burstTime * 40, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes1.get(processNumber1).processId, x1 - processes1.get(processNumber1).burstTime * 40 / 2, y1 + rectHeight / 2);
        
        if (algo1TotalTime <  totalCurrentBurstTime) {
            processNumber1++;
        }
    } else{
        for (int i = 0;i < processes1.size();i++) {
            
            if (algo1TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x1, y1, processes1.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes1.get(i).processId, x1 + processes1.get(i).burstTime * 40 / 2, y1 + rectHeight / 2);
                
                textSize(15);
                text(algo1TotalTime, x1, y1 + rectHeight + 5);
                
                // Update x position for next process
                x1 += processes1.get(i).burstTime * 40; 
                algo1TotalTime += processes1.get(i).burstTime;                
           
                text(algo1TotalTime, x1, y1 + rectHeight + 5);
            }
        }        
    }
    
    
    if (processNumber2 < processes2.size()) {
        
        for (int i = 0;i < processNumber2 + 1;i++) {
            
            if (algo2TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x2, y2, processes2.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes2.get(i).processId, x2 + processes2.get(i).burstTime * 40 / 2, y2 + rectHeight / 2);
                
                textSize(15);
                text(algo2TotalTime, x2, y2 + rectHeight + 5);
                
                // Update x position for next process
                x2 += processes2.get(i).burstTime * 40; 
                algo2TotalTime += processes2.get(i).burstTime;             
            }
        }
        
        fill(0, 255, 0);              
        rect(x2 - processes2.get(processNumber2).burstTime * 40, y2, processes2.get(processNumber2).burstTime * 40, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes2.get(processNumber2).processId, x2 - processes2.get(processNumber2).burstTime * 40 / 2, y2 + rectHeight / 2);
        
        if (algo2TotalTime <  totalCurrentBurstTime) {
            processNumber2++;
        }
    } else{
        for (int i = 0;i < processes2.size();i++) {
            
            if (algo2TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                
                rect(x2, y2, processes2.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes2.get(i).processId, x2 + processes2.get(i).burstTime * 40 / 2, y2 + rectHeight / 2);
                
                textSize(15);
                text(algo2TotalTime, x2, y2 + rectHeight + 5);
                
                // Update x position for next process
                x2 += processes2.get(i).burstTime * 40; 
                algo2TotalTime += processes2.get(i).burstTime;   
                
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
                rect(x3, y3, processes3.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes3.get(i).processId, x3 + processes3.get(i).burstTime * 40 / 2, y3 + rectHeight / 2);
                
                textSize(15);
                text(algo3TotalTime, x3, y3 + rectHeight + 5);
                
                // Update x position for next process
                x3 += processes3.get(i).burstTime * 40; 
                algo3TotalTime += processes3.get(i).burstTime;             
            }
        }  
        
        fill(0, 255, 0);              
        rect(x3 - processes3.get(processNumber3).burstTime * 40, y3, processes3.get(processNumber3).burstTime * 40, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes3.get(processNumber3).processId, x3 - processes3.get(processNumber3).burstTime * 40 / 2, y3 + rectHeight / 2);
        
        if (algo3TotalTime <  totalCurrentBurstTime) {
            processNumber3++;
        }
    } else{
        for (int i = 0;i < processes3.size();i++) {
            
            if (algo3TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x3, y3, processes3.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes3.get(i).processId, x3 + processes3.get(i).burstTime * 40 / 2, y3 + rectHeight / 2);
                
                textSize(15);
                text(algo3TotalTime, x3, y3 + rectHeight + 5);
                
                // Update x position for next process
                x3 += processes3.get(i).burstTime * 40; 
                algo3TotalTime += processes3.get(i).burstTime;   
                
                text(algo3TotalTime, x3, y3 + rectHeight + 5);
            }
        }        
    }
    
    
    if (processNumber4 < processes4.size()) {
        
        for (int i = 0;i < processNumber4 + 1;i++) {
            
            if (algo4TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x4, y4, processes4.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes4.get(i).processId, x4 + processes4.get(i).burstTime * 40 / 2, y4 + rectHeight / 2);
                
                textSize(15);
                text(algo4TotalTime, x4, y4 + rectHeight + 5);
                
                // Update x position for next process
                x4 += processes4.get(i).burstTime * 40; 
                algo4TotalTime += processes4.get(i).burstTime;             
            }
        }   
        
        fill(0, 255, 0);              
        rect(x4 - processes4.get(processNumber4).burstTime * 40, y4, processes4.get(processNumber4).burstTime * 40, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes4.get(processNumber4).processId, x4 - processes4.get(processNumber4).burstTime * 40 / 2, y4 + rectHeight / 2);
        
        if (algo4TotalTime <  totalCurrentBurstTime) {
            processNumber4++;
        }
    } else{
        for (int i = 0;i < processes4.size();i++) {
            
            if (algo4TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x4, y4, processes4.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes4.get(i).processId, x4 + processes4.get(i).burstTime * 40 / 2, y4 + rectHeight / 2);
                
                textSize(15);
                text(algo4TotalTime, x4, y4 + rectHeight + 5);
                
                // Update x position for next process
                x4 += processes4.get(i).burstTime * 40; 
                algo4TotalTime += processes4.get(i).burstTime;   
                
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
                rect(x5, y5, processes5.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes5.get(i).processId, x5 + processes5.get(i).burstTime * 40 / 2, y5 + rectHeight / 2);
                
                textSize(15);
                text(algo5TotalTime, x5, y5 + rectHeight + 5);
                
                // Update x position for next process
                x5 += processes5.get(i).burstTime * 40; 
                algo5TotalTime += processes5.get(i).burstTime;             
            }
        }   
        
        fill(0, 255, 0);              
        rect(x5 - processes5.get(processNumber5).burstTime * 40, y5, processes5.get(processNumber5).burstTime * 40, rectHeight);
        // Draw process label
        fill(0);
        text("P" + processes5.get(processNumber5).processId, x5 - processes5.get(processNumber5).burstTime * 40 / 2, y5 + rectHeight / 2);
        
        if (algo5TotalTime <  totalCurrentBurstTime) {
            processNumber5++;
        }
    } else{
        for (int i = 0;i < processes5.size();i++) {
            
            if (algo5TotalTime < TotalburstTime) {
                // Draw process rectangle
                fill(247, 111, 115);
                textSize(20);
                rect(x5, y5, processes5.get(i).burstTime * 40, rectHeight);
                
                // Draw process label
                fill(0);
                text("P" + processes5.get(i).processId, x5 + processes5.get(i).burstTime * 40 / 2, y5 + rectHeight / 2);
                
                textSize(15);
                text(algo5TotalTime, x5, y5 + rectHeight + 5);
                
                // Update x position for next process
                x5 += processes5.get(i).burstTime * 40; 
                algo5TotalTime += processes5.get(i).burstTime;  
                
                text(algo5TotalTime, x5, y5 + rectHeight + 5);
            }
        }        
    }
    
    
    
    
    
}


void drawTable() { //<>//
    //Set table dimensions
    int numRows = numProcesses + 1;                
    int numCols = 4;
    
    // Set cell dimensions
    int cellWidth = 600 / numCols;
    int cellHeight = 300 / numRows;
    
    int initialX =  400;
    int initialY =  100;
    
    // Draw horizontal lines
    for (int row = 0; row <= numRows; row++) {
        int y = row * cellHeight + + initialY;
        line(initialX, y, initialX + 600, y);
    }
    
    // Draw vertical lines
    for (int col = 0; col <= numCols; col++) {
        int x = col * cellWidth + initialX;
        line(x, initialY, x, initialY + 300);
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
    
    // Display table content        
    for (int row = 1; row < numRows; row++) {           
        int y = row * cellHeight + initialY;
        x = 0 * cellWidth + initialX;
        // Display cell content              
        text("P" + (row), x + cellWidth / 2, y + cellHeight / 2);            
    }
    
    for (int row = 1; row < numRows; row++) {           
        int y = row * cellHeight + initialY;
        x = 1 * cellWidth + initialX;
        // Display cell content              
        text((arrivalTimes[row - 1]), x + cellWidth / 2, y + cellHeight / 2);            
    } 
    
    for (int row = 1; row < numRows; row++) {           
        int y = row * cellHeight + initialY;
        x = 2 * cellWidth + initialX;
        // Display cell content              
        text((burstTimes[row - 1]), x + cellWidth / 2, y + cellHeight / 2);            
    } 
    
    for (int row = 1; row < numRows; row++) {           
        int y = row * cellHeight + initialY;
        x = 3 * cellWidth + initialX;
        // Display cell content              
        text((priorities[row - 1]), x + cellWidth / 2, y + cellHeight / 2);            
    }       
}

// method to create a label witha specified font
private JLabel createLabel(String text, Font font) {
    JLabel label = new JLabel("<html><div style='text-align: left; padding-left: 20px;'>" + text + "</div></html>");
    label.setFont(font);
    return label;
}

private JLabel createLabel2(String text, Font font) {
    JLabel label = new JLabel("<html><div style='text-align: center; padding-left: 0px;'>" + text + "</div></html>");
    label.setFont(font);
    return label;
}  

public static void main(String[] args) {
    PApplet.runSketch(new String[] {"Scheduling Algorithms - Group 01" } , new schedulingAlgorithms());
}
