from brownie import network, SustainabilityToken, accounts

from brownie import network
from scripts.helpful_scripts import (
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
    get_account,
)
import pytest
from scripts.deploy import KEPT_BALANCE, deploy_sustainability_token

def test_deploy():
    account = accounts[0]

    sustainability_token = SustainabilityToken.deploy({"from": account})
    starting_value = sustainability_token.testFunc()
    expected = 1

    assert starting_value == expected


def test_stake_tokens(amount_staked):
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")
    account = get_account()
    sustainability_token = deploy_sustainability_token()

    val2 = sustainability_token.sendEvidence(account, "red.png", "QmPYZHs79FDH5vXMkYcsqrsnaQuA9q2yJKrC9FMrb1dzJv")
    print("breakkk")
    print(val2)
    val3 = sustainability_token.getSentEvidence()
    print(val3)


    