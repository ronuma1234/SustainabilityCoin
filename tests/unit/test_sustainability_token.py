from brownie import network
#from scripts.helpful_scripts import LOCAL_BLOCKCHAIN_ENVIRONMENTS, get_account
import pytest
from scripts.deploy import deploy_sustainability_token

def test__approve():
    #Arrange
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")

    sustainability_token = deploy_sustainability_token() #Remember to complete the function to return the token

    #Act



    #Assert


#Remember to test Transfer and transferFrom functions

    