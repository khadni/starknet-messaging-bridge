%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1
from contracts.token.ERC20.ITDERC20 import ITDERC20
from starkware.cairo.common.cairo_builtins import HashBuiltin

# Sending a message to L1
# Write a contract on L2 that will send a message to L1 MessagingNft (0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E) 
# and trigger createNftFromL2
## Your function should be called create_l1_nft_message

@external
func create_l1_nft_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(l1_user : felt):
   
    let (message_payload : felt*) = alloc()
    assert message_payload[0] = l1_user

    let l1_contract_address = 0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E
    send_message_to_l1(to_address=l1_contract_address, payload_size=1, payload=message_payload)
    return()

end