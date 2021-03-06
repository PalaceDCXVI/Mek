#version 430

layout (location = 0) in vec3 Position;
layout (location = 1) in vec2 TexCoord;
layout (location = 2) in vec3 Normal;
layout (location = 3) in ivec4 BoneIDs;
layout (location = 4) in vec4 Weights;
layout (location = 5) in vec3 Tangent;
layout (location = 6) in vec3 Bitangent;

out vec2 TexCoord0;
out vec3 Normal0;
out vec3 WorldPos0;

out vec4 Debug0;
out ivec4 Debug1;

const int MAX_BONES = 32;

uniform mat4 gWVP;
uniform mat4 gWorld;
uniform mat4 gBones[MAX_BONES];

void main()
{
	mat4 BoneTransform;
	BoneTransform	= gBones[BoneIDs[0]] * Weights[0];
	BoneTransform	+= gBones[BoneIDs[1]] * Weights[1];
	BoneTransform	+= gBones[BoneIDs[2]] * Weights[2];
	BoneTransform	+= gBones[BoneIDs[3]] * Weights[3];

	Debug0 = Weights;
	Debug1 = BoneIDs;

    vec4 PosL    = BoneTransform * vec4(Position, 1.0);
	//gl_Position  = gWVP * PosL;
    gl_Position  = gWVP * vec4(Position, 1.0);
	TexCoord0    = TexCoord;
    vec4 NormalL = BoneTransform * vec4(Normal, 0.0);
    Normal0      = (gWorld * NormalL).xyz;
    WorldPos0    = (gWorld * PosL).xyz;
}