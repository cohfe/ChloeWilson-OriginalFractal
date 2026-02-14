int maxDepth = 7;

void setup() {
  size(900, 900);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
}

void draw() {
  background(0, 0, 6);
  translate(width/2, height/2);

  spiralN(0, 0, 360, 0, maxDepth);
}

void spiralN(float cx, float cy, float baseR, float startAng, int depth) {
  if (depth <= 0 || baseR < 6) return;

  float hueVal = (startAng * 180 / PI + depth * 45) % 360;
  float aVal = map(depth, 0, maxDepth, 20, 85);

  drawSpiralArc(cx, cy, baseR, startAng, hueVal, aVal);

  float endAng = startAng + TWO_PI * 1.35;     
  float endR   = baseR * 0.22;                 

  float t = 0.92;
  float iAng = lerp(startAng, endAng, t);
  float iR   = lerp(baseR, endR, t);

  float cX = cx + cos(iAng) * iR;
  float cY = cy + sin(iAng) * iR;

  float shrink = 0.58;

  spiralN(cX, cY, baseR * shrink, startAng + 1.4, depth - 1);
  spiralN(cX, cY, baseR * shrink * 0.85, startAng - 1.1, depth - 2);
}

void drawSpiralArc(float cx, float cy, float r0, float a0, float hueVal, float alphaVal) {
  
  int steps = 160;              
  float turns = 1.35;           
  float a1 = a0 + TWO_PI * turns;

  float r1 = r0 * 0.22;

  noFill();
  strokeWeight(max(1, r0 * 0.01));

  float prevX = cx + cos(a0) * r0;
  float prevY = cy + sin(a0) * r0;

  for (int i = 1; i <= steps; i++) {
    float u = i / float(steps);

    float ang = lerp(a0, a1, u);

    float r = r0 * pow(r1 / r0, u);

    float x = cx + cos(ang) * r;
    float y = cy + sin(ang) * r;

    float h = (hueVal + u * 120) % 360;
    stroke(h, 85, 100, alphaVal);

    line(prevX, prevY, x, y);

    if (i % 12 == 0) {
      noStroke();
      fill(h, 90, 100, alphaVal * 0.9);
      ellipse(x, y, r0 * 0.05, r0 * 0.05);
      noFill();
    }

    prevX = x;
    prevY = y;
  }
}
