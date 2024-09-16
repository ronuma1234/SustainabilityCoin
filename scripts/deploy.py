from brownie import accounts, config, SustainabilityToken, DocumentVerifier, network
from web3 import Web3
import yaml
import json
import os
import shutil

KEPT_BALANCE = Web3.to_wei(100, "ether")

def copy_folders_to_front_end(src, dest):
    if os.path.exists(dest):
        shutil.rmtree(dest)

    shutil.copytree(src, dest)

def update_front_end():
    copy_folders_to_front_end("./build", "./front_end/src/chain-info")

    with open("brownie-config.yaml", "r") as brownie_config:
        config_dict = yaml.load(brownie_config, Loader=yaml.FullLoader)
        with open("./front_end/src/brownie-config.json", "w") as brownie_config_json:
            json.dump(config_dict, brownie_config_json)
    print("front end updated")

def deploy_sustainability_token(front_end_update_flag=False):
    account = get_account()

    sustainability_token = SustainabilityToken.deploy({"from": account})

    if front_end_update_flag:
        update_front_end()

    return sustainability_token

def get_account():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])
    




def main():
    deploy_sustainability_token(front_end_update_flag=True)