import java.util.Comparator; 

class PlaneComparator implements Comparator<float[][]>
{
  public int compare(float[][] plane1, float[][] plane2)
  {
    int diff = (int)((getZAvg(plane1) - getZAvg(plane2)) * 100);
    return diff;
  }
  
  public float getZAvg(float[][] plane)
  {
    float sum = 0;
    for(float[] point : plane)
    {
      sum += point[2];
    }
    
    return sum / plane.length;
  }
}
