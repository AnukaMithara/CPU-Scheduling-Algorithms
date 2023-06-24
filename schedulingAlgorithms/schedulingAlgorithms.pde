import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

class schedulingAlgorithms extends processing.core.PApplet {
    // Number of processes
    int numProcesses;

    // Array to store process details
    ArrayList<Process> processes1;
    ArrayList<Process> processes2;
    ArrayList<Process> processes3;
    ArrayList<Process> processes4;
    ArrayList<Process> processes5;
    

    // Variables for displaying process details
    int textY;
    int rectHeight = 20;

    // Scheduling algorithm instance
    SchedulingAlgorithm algorithm1;
    SchedulingAlgorithm algorithm2;
    SchedulingAlgorithm algorithm3;
    SchedulingAlgorithm algorithm4;
    SchedulingAlgorithm algorithm5;
    

    void settings() {
        size(1920, 1080);
    }

    void setup() {
        // Get number of processes from user
        String numProcessesStr = JOptionPane.showInputDialog("Enter the number of processes:");
        numProcesses = Integer.parseInt(numProcessesStr);
        
        //Get time quantum for Round Robin
        String timeQuantumStr = JOptionPane.showInputDialog("Enter the time quantum for Round Robin:");
        int timeQuantum = Integer.parseInt(timeQuantumStr);
                
        // Initialize process array
        processes1 = new ArrayList<>();
        processes2 = new ArrayList<>();
        processes3 = new ArrayList<>();
        processes4= new ArrayList<>();
        processes5= new ArrayList<>();

        // Get process details from user
        for (int i = 0; i < numProcesses; i++) {
            String arrivalTimeStr = JOptionPane.showInputDialog("Enter arrival time for process " + (i + 1) + ":");
            int arrivalTime = Integer.parseInt(arrivalTimeStr);

            String burstTimeStr = JOptionPane.showInputDialog("Enter burst time for process " + (i + 1) + ":");
            int burstTime = Integer.parseInt(burstTimeStr);

            String priorityStr = JOptionPane.showInputDialog("Enter priority for process " + (i + 1) + ":");
            int priority = Integer.parseInt(priorityStr);

            processes1.add(new Process(arrivalTime, burstTime, priority));
            processes2.add(new Process(arrivalTime, burstTime, priority));
            processes3.add(new Process(arrivalTime, burstTime, priority));
            processes4.add(new Process(arrivalTime, burstTime, priority));
            processes5.add(new Process(arrivalTime, burstTime, priority));
            
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
                                   
        // Set up variables for displaying process details
        textSize(16);
        textAlign(LEFT);        
    }

    void draw() {
        background(255);       
         drawAlgo1();
         drawAlgo2();
         drawAlgo3();
         drawAlgo4();
         drawAlgo5();
       
    }
    
    void drawAlgo1() {
        
        // Display Gantt chart
        int x = 50;
        int textY = 200;
        for (Process process : processes1) {
            // Draw process rectangle
            fill(200, 200, 200);
            rect(x, textY, process.burstTime * 20, rectHeight);

            // Draw process label
            fill(0);
            text("P" + (processes1.indexOf(process) + 1), x + process.burstTime * 20 / 2, textY + rectHeight / 2);

            // Update x position for next process
            x += process.burstTime * 20;
        }

        /* Display process details
        for (Process process : processes1) {
            text("Process " + (processes1.indexOf(process) + 1) + ": Arrival Time = " + process.arrivalTime +
                    ", Burst Time = " + process.burstTime + ", Waiting Time = " + process.waitingTime +
                    ", Turnaround Time = " + process.turnaroundTime, 10, textY - 50 + processes1.indexOf(process) * 30);
        }
        */
    }
    
    void drawAlgo2() {
        
        // Display Gantt chart
        int x = 50;
        int textY = 350;
        for (Process process : processes2) {
            // Draw process rectangle
            fill(200, 200, 200);
            rect(x, textY, process.burstTime * 20, rectHeight);

            // Draw process label
            fill(0);
            text("P" + (processes2.indexOf(process) + 1), x + process.burstTime * 20 / 2, textY + rectHeight / 2);

            // Update x position for next process
            x += process.burstTime * 20;
        }

        /* Display process details
        for (Process process : processes2) {
            text("Process " + (processes1.indexOf(process) + 1) + ": Arrival Time = " + process.arrivalTime +
                    ", Burst Time = " + process.burstTime + ", Waiting Time = " + process.waitingTime +
                    ", Turnaround Time = " + process.turnaroundTime, 10, textY - 50 + processes2.indexOf(process) * 30);
        }
        */
    }
    
    void drawAlgo3() {
        
        // Display Gantt chart
        int x = 50;
        int textY = 500;
        for (Process process : processes3) {
            // Draw process rectangle
            fill(200, 200, 200);
            rect(x, textY, process.burstTime * 20, rectHeight);

            // Draw process label
            fill(0);
            text("P" + (processes3.indexOf(process) + 1), x + process.burstTime * 20 / 2, textY + rectHeight / 2);

            // Update x position for next process
            x += process.burstTime * 20;
        }

        /* Display process details
        for (Process process : processes3) {
            text("Process " + (processes1.indexOf(process) + 1) + ": Arrival Time = " + process.arrivalTime +
                    ", Burst Time = " + process.burstTime + ", Waiting Time = " + process.waitingTime +
                    ", Turnaround Time = " + process.turnaroundTime, 10, textY - 50 + processes3.indexOf(process) * 30);
        }
        */
    }
    
    void drawAlgo4() {
        
        // Display Gantt chart
        int x = 50;
        int textY = 650;
        for (Process process : processes4) {
            // Draw process rectangle
            fill(200, 200, 200);
            rect(x, textY, process.burstTime * 20, rectHeight);

            // Draw process label
            fill(0);
            text("P" + (processes4.indexOf(process) + 1), x + process.burstTime * 20 / 2, textY + rectHeight / 2);

            // Update x position for next process
            x += process.burstTime * 20;
        }

        /* Display process details
        for (Process process : processes4) {
            text("Process " + (processes1.indexOf(process) + 1) + ": Arrival Time = " + process.arrivalTime +
                    ", Burst Time = " + process.burstTime + ", Waiting Time = " + process.waitingTime +
                    ", Turnaround Time = " + process.turnaroundTime, 10, textY - 50 + processes4.indexOf(process) * 30);
        }
        */
    }
    
    void drawAlgo5() {
        
        // Display Gantt chart
        int x = 50;
        int textY = 800;
        for (Process process : processes5) {
            // Draw process rectangle
            fill(200, 200, 200);
            rect(x, textY, process.burstTime * 20, rectHeight);

            // Draw process label
            fill(0);
            text("P" + (processes5.indexOf(process) + 1), x + process.burstTime * 20 / 2, textY + rectHeight / 2);

            // Update x position for next process
            x += process.burstTime * 20;
        }

        /* Display process details
        for (Process process : processes5) {
            text("Process " + (processes5.indexOf(process) + 1) + ": Arrival Time = " + process.arrivalTime +
                    ", Burst Time = " + process.burstTime + ", Waiting Time = " + process.waitingTime +
                    ", Turnaround Time = " + process.turnaroundTime, 10, textY - 50 + processes5.indexOf(process) * 30);
        }
        */
    }
    
    

    public static void main(String[] args) {
        PApplet.runSketch(new String[] { "schedulingAlgorithms" }, new schedulingAlgorithms());
    }
}
