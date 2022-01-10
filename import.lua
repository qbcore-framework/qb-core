-- This file primarily is for implicit handling for restarts of `qb-core`
-- Whenever qb-core is restarted, the shared object table containing
-- function refs becomes invalid. To solve this, we must reassign our
-- table again with the update function ref pointers at resource start

-- Any changes to the resource name, means this handler won't work anymore

QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resName)
    -- We only want to reassign funcref table,
    -- when qb-core resource status changes.
    if resName ~= 'qb-core' then return end
    -- Lets refresh local table with updated func refs
    QBCore = exports['qb-core']:GetCoreObject()
end)