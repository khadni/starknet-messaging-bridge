%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1
from contracts.token.ERC20.ITDERC20 import ITDERC20

# Sending a message to L1