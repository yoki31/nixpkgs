{ lib, buildPythonPackage, fetchPypi, installShellFiles
, Babel, requests, requests_oauthlib, six, click, markdown, pyyaml, cryptography
, pytest-runner, coverage, flake8, mock, pytestCheckHook, pytest-cov, tox, gntp, sleekxmpp
}:

buildPythonPackage rec {
  pname = "apprise";
  version = "0.9.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-BOMeSvwmGiZvA95+e2bceCGXRwowU5+zJAl7Sn4wKqM=";
  };

  nativeBuildInputs = [ Babel installShellFiles ];

  propagatedBuildInputs = [
    cryptography requests requests_oauthlib six click markdown pyyaml
  ];

  checkInputs = [
    pytest-runner coverage flake8 mock pytestCheckHook pytest-cov tox gntp sleekxmpp
  ];

  disabledTests = [ "test_apprise_cli_nux_env"  ];

  postInstall = ''
    installManPage packaging/man/apprise.1
  '';

  pythonImportsCheck = [ "apprise" ];

  meta = with lib; {
    homepage = "https://github.com/caronc/apprise";
    description = "Push Notifications that work with just about every platform!";
    license = licenses.mit;
    maintainers = [ maintainers.marsam ];
  };
}
