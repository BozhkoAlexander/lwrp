function replaceWeapons()
	txd = engineLoadTXD('/models/transporter.txd', true)
	engineImportTXD(txd, 355)
	dff = engineLoadDFF('/models/transporter.dff', 355)
	engineReplaceModel(dff, 355)
	
	--/models/people/omyst.txd
	txd = engineLoadTXD('/models/people/omyst.txd', true)
	engineImportTXD(txd, 210)
	dff = engineLoadDFF('/models/people/omyst.dff', 210)
	engineReplaceModel(dff, 210)
	
	--swmyst
	txd = engineLoadTXD('/models/people/swmyst.txd', true)
	engineImportTXD(txd, 184)
	dff = engineLoadDFF('/models/people/swmyst.dff', 184)
	engineReplaceModel(dff, 184)
	
	--/models/people/somyst.txd
	txd = engineLoadTXD('/models/people/somyst.txd', true)
	engineImportTXD(txd, 206)
	dff = engineLoadDFF('/models/people/somyst.dff', 206)
	engineReplaceModel(dff, 206)
	
	--male01
	txd = engineLoadTXD('/models/people/male01.txd', true)
	engineImportTXD(txd, 183)
	dff = engineLoadDFF('/models/people/male01.dff', 183)
	engineReplaceModel(dff, 183)
end
addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()), replaceWeapons)