import java.util.ArrayList;
import java.util.Queue;
import java.util.List;


class ShortestRemaningTimeNext implements SchedulingAlgorithm {
   private List<Process> processn = new ArrayList<>();
   private List<Integer>bt=new ArrayList<>();
 
    @Override
    public void execute(ArrayList<Process> processes) {
      
         //sorting according to arrival times
        for (int i = 0; i < processes.size(); i++)
        {
            for (int  j = 0;  j < processes.size() - 1; j++)
            {
                if (processes.get(j).arrivalTime > processes.get(j + 1).arrivalTime)
                {
                    swap(processes, j,j + 1);                
                }
            }
        }
        
       
        int currentTime = processes.get(0).arrivalTime;
        int completedProcesses = 0;

        while (completedProcesses < processes.size()) {
            Process shortestProcess = null;
            int shortestTime = Integer.MAX_VALUE;

            for (Process process : processes) {
                if (process.arrivalTime <= currentTime && process.burstTime < shortestTime && process.burstTime > 0) {
                    shortestProcess = process;
                    shortestTime = process.burstTime;
                }
            }

            if (shortestProcess == null) {
                currentTime++;
                processn.add(null); 
                continue;
            }

            processn.add(shortestProcess);
            shortestProcess.endTime=currentTime+1;
            bt.add(1);
            shortestProcess.burstTime--;
            currentTime++;

            if (shortestProcess.burstTime == 0) {
                completedProcesses++;
            }
        }
         for (int h = 0; h < processes.size(); h++) {
    Process process = processes.get(h);
    int turnaroundTime = process.endTime - process.arrivalTime;
    process.turnaroundTime=(turnaroundTime);
    process.waitingTime=turnaroundTime-process.burstTimeC;
}
 Process curP=processn.get(0);
 List<Process>mergedJob=new ArrayList<>();
 List<Integer>mT=new ArrayList<>();
 int count=0;
 boolean h=false;
for(int l=0;l<processn.size();l++){
  if(processn.get(l).processId==curP.processId){
    count++;
    h=true;
  }
  else{
    mergedJob.add(curP);
    mT.add(count);
    h=false;
    count=1;
    curP=processn.get(l);
  }
  

}
if(curP!=null&&h){
mergedJob.add(curP);
mT.add(count);
}
    
processn=mergedJob;
bt=mT;
 
        for(int i=0;i<mergedJob.size();i++){
        print("|"+bt.get(i)+"|");
        }
        
    }
    public List<Process> getProcess(){
      return processn;
    }
    public List<Integer> getBt(){
      return bt;
    }
    void swap(ArrayList<Process> processes, int index1, int index2)
    {
        Process temp = processes.get(index1);
        processes.set(index1, processes.get(index2));
        processes.set(index2, temp);
    }   
}
