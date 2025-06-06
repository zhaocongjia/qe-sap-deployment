from lib.process_manager import subprocess_run


def test_no_command():
    '''
    Run subprocess_run providing no commands
    result in an error
    '''
    exit_code, stdout_list = subprocess_run([])
    assert exit_code == 1
    assert stdout_list == []


def test_echo():
    '''
    Run subprocess_run using the true subprocess.
    Test is really running an echo command
    and check the stdout.
    '''
    test_text = 'Banana'
    exit_code, stdout_list = subprocess_run(f"echo \"{test_text}\"")
    assert exit_code == 0
    assert stdout_list == [test_text]


def test_multilines():
    '''
    each stdout line has to be in a different stdout array element
    '''
    str_list = ['a', 'b', 'c']
    test_text = ''
    for string in str_list:
        test_text += (string * 10) + "\n"
    _, stdout_list = subprocess_run(f"echo \"{test_text}\"")
    assert len(stdout_list) == len(str_list) + 1
    for i, line in enumerate(str_list):
        assert line * 10 == stdout_list[i].strip()


def test_stderr():
    '''
    Run subprocess_run redirect the stderr to stdout
    '''
    test_text = 'Banana'
    exit_code, stdout_list = subprocess_run(f"logger -s {test_text}")
    assert exit_code == 0
    assert len(stdout_list) > 0


def test_err():
    '''
    Run subprocess_run with a command that fails
    '''
    not_existing_file = 'Banana'

    exit_code, stdout_list = subprocess_run(f"cat {not_existing_file}")
    assert exit_code == 1
    assert len(stdout_list) > 0


def test_env():
    '''
    Check that env variable are controllable
    '''
    _, stdout_list = subprocess_run('printenv')
    assert 'BANANA_VALUE' not in stdout_list
    exit_code, stdout_list = subprocess_run('printenv', env={'BANANA_VALUE': '1234'})
    assert exit_code == 0
    assert 'BANANA_VALUE=1234' in stdout_list
