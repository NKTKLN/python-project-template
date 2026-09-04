import pytest

from app.main import main


def test_main_greets(capsys: pytest.CaptureFixture[str]) -> None:
    main()

    assert capsys.readouterr().out == "Hello from python template project!\n"
