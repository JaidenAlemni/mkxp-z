uniform mat4 projMat;
uniform mat4 tilemapMat;

uniform vec2 texSizeInv;
uniform vec2 translation;

//uniform highp int aniIndex;
uniform float aniIndex;

attribute vec2 position;
attribute vec2 texCoord;

varying vec2 v_texCoord;

const float atAreaW = 96.0;
const float atAreaH = 128.0*7.0;
const float atAniOffset = 32.0*3.0;

// const int nAutotiles = 7;
// const float tileW = 32.0;
// const float tileH = 32.0;
// const float autotileW = 3.0*tileW;
// const float autotileH = 4.0*tileW;
// const float atAreaW = autotileW;
// const float atAreaH = autotileH*float(nAutotiles);
// const float atAniOffsetX = 3.0*tileW;
// const float atAniOffsetY = tileH;

// uniform lowp int atFrames[nAutotiles];

void main()
{
    vec2 tex = texCoord;
    // lowp int atIndex = int(tex.y / autotileH);

    lowp int pred = int(tex.x <= atAreaW && tex.y <= atAreaH);
    // lowp int frame = int(aniIndex - atFrames[atIndex] * (aniIndex / atFrames[atIndex]));
    // lowp int row = frame / 8;
    // lowp int col = frame - 8 * row;
    // tex.x += atAniOffsetX * float(col * pred);
    // tex.y += atAniOffsetY * float(row * pred);

    tex.x += aniIndex * atAniOffset * float(pred);

    gl_Position = projMat * tilemapMat * vec4(position + translation, 0, 1);

    v_texCoord = tex * texSizeInv;
}
