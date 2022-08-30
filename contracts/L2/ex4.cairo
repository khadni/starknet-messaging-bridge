
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_contract_address, get_caller_address
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@storage_var
func l1_evaluator_address_storage() -> (l1_evaluator_address : felt):
end

@storage_var
func rand_value() -> (value : felt):
end

#
# Getters
#

@view
func l1_assigned_var{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res : felt):
    let (res) = rand_value.read()
    return (res)
end

@view
func evaluator_address{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res : felt):
    let (res) = l1_evaluator_address_storage.read()
    return (res)
end


@external
func set_evaluator_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    l1_evaluator_address : felt
):
    l1_evaluator_address_storage.write(l1_evaluator_address)
    return()
end


## l1_assigned_var should store the random value sent by L1 function
@l1_handler
func ex4Kha{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, sent_value : felt
):
    # Make sure the message was sent by the intended L1 contract
    let (l1_evaluator_address) = l1_evaluator_address_storage.read()

    with_attr error_message("Message was not sent by the official L1 contract"):
            assert from_address = l1_evaluator_address
    end

    rand_value.write(sent_value)
    return ()
end