#version 300 es
in vec3 a_position;

#ifdef UV_NUM
in vec2 a_uv;
out highp vec2 v_uv;
#endif

#ifdef JOINTS_NUM
in vec4 a_joint;
in vec4 a_weight;

    #ifdef JOINT_VEC8
    in vec4 a_joint1;
    in vec4 a_weight1;
    #endif

uniform mat4 u_jointMatrix[JOINTS_NUM];
#endif

// max targets num is 8
#ifdef MORPH_TARGET_NUM
    uniform float u_morphWeights[MORPH_TARGET_NUM];
    #ifdef HAS_MORPH_POSITION
    in vec3 a_morphPositions_0;
        #if MORPH_TARGET_NUM > 1
        in vec3 a_morphPositions_1;
        #endif
        #if MORPH_TARGET_NUM > 2
        in vec3 a_morphPositions_2;
        #endif
        #if MORPH_TARGET_NUM > 3
        in vec3 a_morphPositions_3;
        #endif
        #if MORPH_TARGET_NUM > 4
        in vec3 a_morphPositions_4;
        #endif
        #if MORPH_TARGET_NUM > 5
        in vec3 a_morphPositions_5;
        #endif
        #if MORPH_TARGET_NUM > 6
        in vec3 a_morphPositions_6;
        #endif
        #if MORPH_TARGET_NUM > 7
        in vec3 a_morphPositions_7;
        #endif
    #endif

    #ifdef HAS_MORPH_NORMAL
    in vec3 a_morphNromals_0;
        #if MORPH_TARGET_NUM > 1
        in vec3 a_morphNromals_1;
        #endif
        #if MORPH_TARGET_NUM > 2
        in vec3 a_morphNromals_2;
        #endif
        #if MORPH_TARGET_NUM > 3
        in vec3 a_morphNromals_3;
        #endif
        #if MORPH_TARGET_NUM > 4
        in vec3 a_morphNromals_4;
        #endif
        #if MORPH_TARGET_NUM > 5
        in vec3 a_morphNromals_5;
        #endif
        #if MORPH_TARGET_NUM > 6
        in vec3 a_morphNromals_6;
        #endif
        #if MORPH_TARGET_NUM > 7
        in vec3 a_morphNromals_7;
        #endif
    #endif
    #ifdef HAS_MORPH_TANGENT
    in vec3 a_morphTangents_0;
        #if MORPH_TARGET_NUM > 1
        in vec3 a_morphTangents_1;
        #endif
        #if MORPH_TARGET_NUM > 2
        in vec3 a_morphTangents_2;
        #endif
        #if MORPH_TARGET_NUM > 3
        in vec3 a_morphTangents_3;
        #endif
        #if MORPH_TARGET_NUM > 4
        in vec3 a_morphTangents_4;
        #endif
        #if MORPH_TARGET_NUM > 5
        in vec3 a_morphTangents_5;
        #endif
        #if MORPH_TARGET_NUM > 6
        in vec3 a_morphTangents_6;
        #endif
        #if MORPH_TARGET_NUM > 7
        in vec3 a_morphTangents_7;
        #endif
    #endif
#endif

uniform mat4 u_mvpMat;

#ifdef UV_NUM
#endif

void main() {

    vec3 position = a_position;

    #ifdef MORPH_TARGET_NUM
        #ifdef HAS_MORPH_POSITION
        position += u_morphWeights[0] * a_morphPositions_0;
            #if MORPH_TARGET_NUM > 1
            position += u_morphWeights[1] * a_morphPositions_1;
            #endif
            #if MORPH_TARGET_NUM > 2
            position += u_morphWeights[2] * a_morphPositions_2;
            #endif
            #if MORPH_TARGET_NUM > 3
            position += u_morphWeights[3] * a_morphPositions_3;
            #endif
            #if MORPH_TARGET_NUM > 4
            position += u_morphWeights[4] * a_morphPositions_4;
            #endif
            #if MORPH_TARGET_NUM > 5
            position += u_morphWeights[5] * a_morphPositions_5;
            #endif
            #if MORPH_TARGET_NUM > 6
            position += u_morphWeights[6] * a_morphPositions_6;
            #endif
            #if MORPH_TARGET_NUM > 7
            position += u_morphWeights[7] * a_morphPositions_7;
            #endif
        #endif
        // TODO normals and tangents
    #endif

    mat4 finalMat = u_mvpMat;

    #ifdef JOINTS_NUM
    mat4 skinMatrix =
        a_weight.x * u_jointMatrix[int(a_joint.x)] +
        a_weight.y * u_jointMatrix[int(a_joint.y)] +
        a_weight.z * u_jointMatrix[int(a_joint.z)] +
        a_weight.w * u_jointMatrix[int(a_joint.w)];

        #ifdef JOINT_VEC8
        skinMatrix +=
            a_weight1.x * u_jointMatrix[int(a_joint1.x)] +
            a_weight1.y * u_jointMatrix[int(a_joint1.y)] +
            a_weight1.z * u_jointMatrix[int(a_joint1.z)] +
            a_weight1.w * u_jointMatrix[int(a_joint1.w)];
        #endif

    finalMat = finalMat * skinMatrix;
    #endif

    gl_Position = finalMat * vec4(position, 1.0);

    #ifdef UV_NUM
    v_uv = a_uv;
    #endif
}
