#version 120

uniform vec4 line_color;
uniform float line_width;
varying vec3 distance;

${tex.decl}
${light.decl}

float lambertian(vec3 Nn, vec3 L) {
    return max(dot(Nn, L), 0.);
}

float blinn(vec3 Vn, vec3 Nn, vec3 L, float Ns) {
    vec3 H = normalize(L+Vn);
    return pow(max(dot(Nn, H), 0.), Ns);
}

void main (void)
{
    vec3 dist_vec = distance * gl_FragCoord.w;

    // determine frag distance to closest edge
    float fNearest = min(min(dist_vec[0],dist_vec[1]),dist_vec[2]);
    float fEdgeIntensity = exp2(-(1.0/line_width)*fNearest*fNearest);
    vec4 solidC = gl_Color;
    vec4 lineC = line_color;

    ${tex.op}
    ${light.op}

    gl_FragColor = mix(solidC, lineC, fEdgeIntensity);
}