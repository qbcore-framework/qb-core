QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
        incityhall = false, -- true lists job inside city hall
		grades = {
			['0'] = {
				name = 'Freelancer',
				payment = 10
			},
		},
	},
}