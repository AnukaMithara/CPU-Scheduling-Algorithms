import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

class schedulingAlgorithms extends processing.core.PApplet {
    // Number of processes
    int numProcesses;

    // Array to store process details
    ArrayList<Process> processes;

    // Variables for displaying process details
    int textY;
    int rectHeight = 20;

    // Scheduling algorithm instance
    SchedulingAlgorithm schedulingAlgorithm;

    void settings() {
        size(1920, 1080);
    }

    void setup() {
        // Get number of processes from user
        String numProcessesStr = JOptionPane.showInputDialog("Enter the number of processes:");
        numProcesses = Integer.parseInt(numProcessesStr);

        // Initialize process array
        processes = new ArrayList<>();

        // Get process details from user
        for (int i = 0; i < numProcesses; i++) {
            String arrivalTimeStr = JOptionPane.showInputDialog("Enter arrival time for process " + (i + 1) + ":");
            int arrivalTime = Integer.parseInt(arrivalTimeStr);

            String burstTimeStr = JOptionPane.showInputDialog("Enter burst time for process " + (i + 1) + ":");
            int burstTime = Integer.parseInt(burstTimeStr);

            String priorityStr = JOptionPane.showInputDialog("Enter priority for process " + (i + 1) + ":");
            int priority = Integer.parseInt(priorityStr);

            processes.add(new Process(arrivalTime, burstTime, priority));
        }

        // Choose the scheduling algorithm
        String algorithmChoice = JOptionPane.showInputDialog("Choose the Scheduling Algorithm:\n" +
                "1. First Come First Served (FCFS)\n" +
                "2. Round Robin\n" +
                "3. Shortest Process Next\n" +
                "4. Shortest Remaining Time Next\n" +
                "5. Priority Scheduling");
        if (algorithmChoice.equals("1")) {
            schedulingAlgorithm = new FCFS();
        } else if (algorithmChoice.equals("2")) {
            String timeQuantumStr = JOptionPane.showInputDialog("Enter the time quantum for Round Robin:");
            int timeQuantum = Integer.parseInt(timeQuantumStr);
            schedulingAlgorithm = new RoundRobin(timeQuantum);
        } else if (algorithmChoice.equals("3")) {
            schedulingAlgorithm = new ShortestProcessNext();
        } else if (algorithmChoice.equals("4")) {
            schedulingAlgorithm = new ShortestRemainingTimeNext();
        } else if (algorithmChoice.equals("5")) {
            schedulingAlgorithm = new PriorityScheduling();
        } else {
            // Default to FCFS if invalid choice
            schedulingAlgorithm = new FCFS();
        }

        // Calculate waiting time and turnaround time
        schedulingAlgorithm.execute(processes);

        // Set up variables for displaying process details
        textSize(16);
        textAlign(CENTER);
        textY = height / 2 - 50;
    }

    void draw() {
        background(255);

        // Display Gantt chart
        int x = 50;
        for (Process process : processes) {
            // Draw process rectangle
            fill(200, 200, 200);
            rect(x, textY, process.burstTime * 20, rectHeight);

            // Draw process label
            fill(0);
            text("P" + (processes.indexOf(process) + 1), x + process.burstTime * 20 / 2, textY + rectHeight / 2);

            // Update x position for next process
            x += process.burstTime * 20;
        }

        // Display process details
        for (Process process : processes) {
            text("Process " + (processes.indexOf(process) + 1) + ": Arrival Time = " + process.arrivalTime +
                    ", Burst Time = " + process.burstTime + ", Waiting Time = " + process.waitingTime +
                    ", Turnaround Time = " + process.turnaroundTime, width / 2, textY - 50 + processes.indexOf(process) * 30);
        }
    }

    public static void main(String[] args) {
        PApplet.runSketch(new String[] { "schedulingAlgorithms" }, new schedulingAlgorithms());
    }
}
