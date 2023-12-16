#version 460

in vec4 vertexColor;

flat in vec2 flatCorner;
in vec2 Pos1;
in vec2 Pos2;
in vec4 Coords;
in vec2 position;

uniform float GameTime;
uniform vec4 ColorModulator;

out vec4 fragColor;

vec4 colors[] = vec4[]( // frame color index
    vec4(0),							//0 (no color)
    vec4(  255,   255,   0, 255) / 255.0,	//1 (bg)
    vec4(0, 255, 255, 255) / 255.0,	//2 (frame outer)
    vec4(255, 0, 0, 255) / 255.0,	//3 (frame inner)
    vec4( 0,  0, 255, 255) / 255.0	//4 (frame dot)
);

int bitmap[][] = int[][]( //frame top left corner map (mirrored for all corners)
    int[](0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0),
    int[](0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0),
    int[](0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 3, 0, 0),
    int[](0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 3, 0, 0),
    int[](0, 0, 0, 0, 0, 0, 2, 2, 3, 3, 3, 2, 2),
    int[](0, 0, 0, 2, 0, 0, 0, 0, 2, 3, 3, 2, 2),
    int[](0, 0, 0, 2, 2, 0, 4, 0, 2, 3, 3, 3, 3),
    int[](0, 0, 0, 2, 2, 0, 0, 0, 3, 1, 3, 1, 3),
    int[](2, 2, 2, 2, 3, 2, 2, 3, 3, 3, 3, 2, 1),
    int[](0, 3, 3, 2, 3, 3, 3, 1, 1, 3, 1, 1, 1),
    int[](0, 0, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1),
    int[](0, 0, 0, 0, 2, 2, 3, 1, 2, 1, 1, 1, 1),
    int[](0, 0, 0, 0, 2, 2, 3, 3, 1, 1, 1, 1, 1)
);


void main() {
    vec4 color = vertexColor;
    if (color.a == 0.0) {
        discard;
    }

    fragColor = color * ColorModulator;

	// tooltip
    if (flatCorner != vec2(-1))
    {
        //Actual Pos
        vec2 APos1 = Pos1;
        vec2 APos2 = Pos2;
        APos1 = round(APos1 / (flatCorner.x == 0 ? 1 - Coords.z : 1 - Coords.w)); //Right-up corner
        APos2 = round(APos2 / (flatCorner.x == 0 ? Coords.w : Coords.z)); //Left-down corner

        ivec2 res = ivec2(abs(APos1 - APos2)) - 1; //Resolution of frame
        ivec2 stp = ivec2(min(APos1, APos2)); //Left-Up corner
        ivec2 pos = ivec2(floor(position)) - stp; //Position in frame
        ivec2 corner = min(pos, res - pos);

        vec4 bgcol = colors[1]; //bg color
		vec4 frcol1 = vec4(255, 0, 0, 255) / 255.0; //dot color 1
		vec4 frcol2 = vec4(0, 255, 0, 255) / 255.0; //dot color 2
		vec4 frcol3 = vec4(0, 0, 255, 255) / 255.0; //dot color 3
		vec4 frcol4 = vec4(255, 255, 0, 255) / 255.0; //dot color 4
		vec4 frcol5 = vec4( 0,  255, 255, 255) / 255.0; //dot color 5
		
		// cycle dot colors (switch statements dont work aight)
		float franim = floor(mod(GameTime * 4096.0, 8));
		if (franim == 0)
			colors[4] = frcol1;
		else if (franim == 1)
			colors[4] = frcol2;
		else if (franim == 2)
			colors[4] = frcol3;
		else if (franim == 3)
			colors[4] = frcol4;
		else if (franim == 4)
			colors[4] = frcol5;
		else if (franim == 5)
			colors[4] = frcol4;
		else if (franim == 6)
			colors[4] = frcol3;
		else if (franim == 7)
			colors[4] = frcol2;
		else
			colors[4] = frcol5;
		
		// frame
        if (corner.x < 13 && corner.y < 13)
        {
            int bit = bitmap[corner.y][corner.x];
            if (bit != 0)
                bgcol = colors[bit];
            else
                discard;
        }
        else if ((corner.x < 4) || ( corner.y < 4))
            discard;
        else if (corner.x >= 4 && corner.x <= 5)
            bgcol = colors[2];
        else if (corner.y >= 4 && corner.y <= 5)
            bgcol = colors[2];
        else if (corner.x == 6)
            bgcol = colors[3];
        else if (corner.y == 6)
            bgcol = colors[3];

        fragColor = bgcol;
    }
}
