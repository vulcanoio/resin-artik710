deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

BOARD_SHUTDOWN_ARTIK = 'The device is performing a shutdown. Wait 30 seconds or until the blue LED 703 is off and switch SW700 to the off position.'
SET_JUMPER_SD = 'Set SW402 dip switch to position 1:off, 2:off, 3:off, 4:on.'
SET_JUMPER_EMMC = 'Set SW402 dip switch to position 1:off, 2:off, 3:off, 4:off.'
BOARD_POWERON_ARTIK = 'Switch SW700 to the on position. Press and hold for 1 second the SW400 POWER push button.'

postProvisioningInstructions = [
	BOARD_SHUTDOWN_ARTIK
	instructions.REMOVE_INSTALL_MEDIA
	SET_JUMPER_EMMC
	BOARD_POWERON_ARTIK
]

module.exports =
	version: 1
	slug: 'artik710'
	aliases: [ 'artik710' ]
	name: 'Samsung Artik 710'
	arch: 'aarch64'
	state: 'experimental'

	stateInstructions:
		postProvisioning: postProvisioningInstructions

	instructions: [
		instructions.ETCHER_SD
		instructions.EJECT_SD
		instructions.FLASHER_WARNING
		SET_JUMPER_SD
		BOARD_POWERON_ARTIK
	].concat(postProvisioningInstructions)

	gettingStartedLink:
		windows: 'http://docs.resin.io/#/pages/installing/gettingStarted-Samsung-Artik710.md#windows'
		osx: 'http://docs.resin.io/#/pages/installing/gettingStarted-Samsung-Artik710.md#on-mac-and-linux'
		linux: 'http://docs.resin.io/#/pages/installing/gettingStarted-Samsung-Artik710.md#on-mac-and-linux'

	supportsBlink: true

	yocto:
		machine: 'artik710'
		image: 'resin-image-flasher'
		fstype: 'resin-sdcard'
		version: 'yocto-jethro'
		deployArtifact: 'resin-image-flasher-artik710.resin-sdcard'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
