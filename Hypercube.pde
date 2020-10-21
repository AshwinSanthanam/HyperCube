import java.util.Collections;  

float[][] points;
int[][] connectors;

float angle = 0;
float side = 2400;
float cameraZ = 4;
float cameraW = 4;

float angleStep = 1;
float xAngle = 45;
float yAngle = 45;
float zAngle = 0;

void setup()
{
  size(1920, 1080);
  points = new float[16][4];

  points[0] = new float[] { +1, +1, +1, +1 };
  points[1] = new float[] { -1, +1, +1, +1 };
  points[2] = new float[] { -1, -1, +1, +1 };
  points[3] = new float[] { +1, -1, +1, +1 };

  points[4] = new float[] { +1, +1, -1, +1 };
  points[5] = new float[] { -1, +1, -1, +1 };
  points[6] = new float[] { -1, -1, -1, +1 };
  points[7] = new float[] { +1, -1, -1, +1 };

  points[8] = new float[] { +1, +1, +1, -1 };
  points[9] = new float[] { -1, +1, +1, -1 };
  points[10] = new float[] { -1, -1, +1, -1 };
  points[11] = new float[] { +1, -1, +1, -1 };

  points[12] = new float[] { +1, +1, -1, -1 };
  points[13] = new float[] { -1, +1, -1, -1 };
  points[14] = new float[] { -1, -1, -1, -1 };
  points[15] = new float[] { +1, -1, -1, -1 };

  //setupLineConnection();
  setupPlaneConnection();
}

void setupLineConnection()
{
  connectors = new int[32][2];
  connectors[0] = new int[] {0, 1};
  connectors[1] = new int[] {1, 2};
  connectors[2] = new int[] {2, 3};
  connectors[3] = new int[] {3, 0};

  connectors[4] = new int[] {4, 5};
  connectors[5] = new int[] {5, 6};
  connectors[6] = new int[] {6, 7};
  connectors[7] = new int[] {7, 4};

  connectors[8] = new int[] {0, 4};
  connectors[9] = new int[] {1, 5};
  connectors[10] = new int[] {2, 6};
  connectors[11] = new int[] {3, 7};

  connectors[12] = new int[] {8, 9};
  connectors[13] = new int[] {9, 10};
  connectors[14] = new int[] {10, 11};
  connectors[15] = new int[] {11, 8};

  connectors[16] = new int[] {12, 13};
  connectors[17] = new int[] {13, 14};
  connectors[18] = new int[] {14, 15};
  connectors[19] = new int[] {15, 12};

  connectors[20] = new int[] {8, 12};
  connectors[21] = new int[] {9, 13};
  connectors[22] = new int[] {10, 14};
  connectors[23] = new int[] {11, 15};

  connectors[24] = new int[] {0, 8};
  connectors[25] = new int[] {1, 9};
  connectors[26] = new int[] {2, 10};
  connectors[27] = new int[] {3, 11};

  connectors[28] = new int[] {4, 12};
  connectors[29] = new int[] {5, 13};
  connectors[30] = new int[] {6, 14};
  connectors[31] = new int[] {7, 15};  
}

void setupPlaneConnection()
{
  connectors = new int[24][];
  
  connectors[0] = new int[] {0, 1, 2, 3, 0};
  connectors[1] = new int[] {4, 5, 6, 7, 4};
  connectors[2] = new int[] {0, 3, 7, 4, 0};
  connectors[3] = new int[] {5, 6, 2, 1, 5};
  connectors[4] = new int[] {0, 4, 5, 1, 0};
  connectors[5] = new int[] {3, 7, 6, 2, 3};
  
  connectors[6] = new int[] {8, 11, 15, 12, 8};
  connectors[7] = new int[] {12, 13, 14, 15, 12};
  connectors[8] = new int[] {13, 14, 10, 9, 13};
  connectors[9] = new int[] {9, 10, 11, 8, 9};
  connectors[10] = new int[] {8, 12, 13, 9, 8};
  connectors[11] = new int[] {11, 15, 14, 10, 11};
  
  connectors[12] = new int[] {8, 0, 3, 11, 8};
  connectors[13] = new int[] {8, 0, 4, 12, 8};
  connectors[14] = new int[] {12, 4, 7, 15, 12};
  connectors[15] = new int[] {7, 15, 11, 3, 7};
  
  connectors[16] = new int[] {11, 3, 2, 10, 11};
  connectors[17] = new int[] {2, 10, 14, 6, 2};
  connectors[18] = new int[] {7, 15, 14, 6, 7};
  
  connectors[19] = new int[] {9, 1, 2, 10, 9};
  connectors[20] = new int[] {9, 1, 5, 13, 9};
  connectors[21] = new int[] {13, 5, 6, 14, 13};
  
  connectors[22] = new int[] {8, 0, 1, 9, 8};
  connectors[23] = new int[] {12, 4, 5, 13, 12};
}

void draw()
{
  if(angle >= 90 * 5) exit();  
  background(0, 0, 255);
  stroke(255, 255, 0);
  strokeWeight(5);
  fill(125, 125, 0, 150);
  translate(width / 2, height / 2);
  displayPoints();

  //saveFrame("output/gif-" + nf((int)(angle * 2), 3) + ".png");
  
  angle += 0.5;
}

void displayPoints()
{
  float[] rotated4D;
  float[][] points2D = new float[points.length][3];
  float[][] points3D = new float[points.length][3];
  
  for (int i = 0; i < points.length; i++)
  {
    float[] point4D = points[i];
    rotated4D = rotateZW(point4D, angle * (PI / 180));
    rotated4D = rotateZ(rotated4D, angle * (PI / 180));
    float[] point3D = projectTo3D(rotated4D);
    points3D[i] = point3D;
  }
  
  for(int i = 0; i < points3D.length; i++)
  {
    float[] point3D = points3D[i];
    float[] rotated = new float[] { point3D[0], point3D[1], point3D[2], 0 };
    rotated = rotateX(rotated, xAngle * PI / 180);
    rotated = rotateY(rotated, yAngle * PI / 180);
    rotated = rotateZ(rotated, zAngle * PI / 180);
    float[] point2D = projectTo2D(rotated);
    float[] scaled = scale(point2D, side);
    points2D[i] = new float[] { scaled[0], scaled[1], rotated[2] };
  }

  //connect(points2D);
  ArrayList<float[][]> planes = generatePlanes(points2D);
  drawPlanes(planes);
}

ArrayList<float[][]> generatePlanes(float[][] _2DWeighted)
{
  ArrayList<float[][]> planes = new ArrayList<float[][]>();
  for(int[] connector : connectors)
  {
    float[][] plane = new float[connector.length][3];
    for(int i = 0; i < connector.length; i++)
    {
      float[] point2DWeigthed = _2DWeighted[connector[i]];
      plane[i] = new float[] { point2DWeigthed[0], point2DWeigthed[1], point2DWeigthed[2] };
    }
    planes.add(plane);
  }
  Collections.sort(planes, new PlaneComparator());
  
  return planes;
}

void drawPlanes(ArrayList<float[][]> planes)
{
  for(float[][] plane : planes)
  {
    beginShape();
    for(int i = 0; i < plane.length; i++)
    {
      //println(plane[i][0] + "," + plane[i][1]);
      vertex(plane[i][0], plane[i][1]);
    }
    endShape();
  }
}

void connect(float[][] points)
{
  for (int[] connector : connectors)
  {
    float[] point1 = points[connector[0]];
    float[] point2 = points[connector[1]];

    line(point1[0], point1[1], point2[0], point2[1]);
  }
}


float[] projectTo3D(float[] point4D)
{
  float wScale = 1 / (cameraW - point4D[3]);
  return new float[] { point4D[0] * wScale, point4D[1] * wScale, point4D[2] * wScale };
}

float[] projectTo2D(float[] point3D)
{
  float zScale = 1 / (cameraZ - point3D[2]);
  return new float[] { point3D[0] * zScale, point3D[1] * zScale };
}

float[] scale(float[] point2D, float factor)
{
  return new float[] { point2D[0] * factor, point2D[1] * factor };
}

float[] rotateZ(float[] point4D, float rad)
{
  float sin = sin(rad);
  float cos = cos(rad);

  float x = point4D[0] * cos - point4D[1] * sin;
  float y = point4D[0] * sin + point4D[1] * cos;

  return new float[] { x, y, point4D[2], point4D[3] };
}

float[] rotateY(float[] point4D, float rad)
{
  float sin = sin(rad);
  float cos = cos(rad);

  float x = point4D[0] * cos - point4D[2] * sin;
  float z = point4D[0] * sin + point4D[2] * cos;

  return new float[] { x, point4D[1], z, point4D[3] };
}

float[] rotateX(float[] point4D, float rad)
{
  float sin = sin(rad);
  float cos = cos(rad);

  float y = point4D[1] * cos - point4D[2] * sin;
  float z = point4D[1] * sin + point4D[2] * cos;

  return new float[] { point4D[0], y, z, point4D[3] };
}

float[] rotateZW(float[] point4D, float rad)
{
  float sin = sin(rad);
  float cos = cos(rad);

  float z = point4D[2] * cos - point4D[3] * sin;
  float w = point4D[2] * sin + point4D[3] * cos;

  return new float[] { point4D[0], point4D[1], z, w };
}
