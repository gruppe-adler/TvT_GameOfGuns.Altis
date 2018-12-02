/*  Manually executed to help with adding uniforms to the config
*
*/

doit = false;
sleep 1.5;

player sideChat "addUniformHelper now running.";
doit = true;

/*newUniforms = [];
newVests = [];

while {doit} do {
  _uniform = uniform player;
  _vest = vest player;

  if (_uniform != "" && newUniforms find _uniform == -1) then {
    newUniforms pushBack _uniform;
  };

  if (_vest != "" && newVests find _vest == -1) then {
    newVests pushBack _vest;
  };

  sleep 0.5;
};*/


while {doit} do {
  _uniform = uniform player;
  _vest = vest player;
  copyToClipboard format ["['%1', '%2']", _uniform, _vest];
};
