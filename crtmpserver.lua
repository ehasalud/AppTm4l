-- Start of the configuration. This is the only node in the config file. 
-- The rest of them are sub-nodes
configuration=
{
	-- if true, the server will run as a daemon.
	-- NOTE: all console appenders will be ignored if this is a daemon
	daemon=false,
	-- the OS's path separator. Used in composing paths
	pathSeparator="/",

	-- this is the place where all the logging facilities are setted up
	-- you can add/remove any number of locations

	logAppenders=
	{
		{
			-- name of the appender. Not too important, but is mandatory
			name="console appender",
			-- type of the appender. We can have the following values:
			-- console, coloredConsole and file
			-- NOTE: console appenders will be ignored if we run the server
			-- as a daemon
			type="coloredConsole",
			-- the level of logging. 6 is the FINEST message, 0 is FATAL message.
			-- The appender will "catch" all the messages below or equal to this level
			-- bigger the level, more messages are recorded
			level=6
		}--[[,
		{
			name="file appender",
			type="file",
			level=6,
			-- the file where the log messages are going to land
			fileName="/tmp/crtmpserver",
			--newLineCharacters="\r\n",
			fileHistorySize=10,
			fileLength=1024*256,
			singleLine=true
		}]]--
	},
	
	-- this node holds all the RTMP applications
	applications=
	{
		-- this is the root directory of all applications
		-- usually this is relative to the binary execuable
		rootDirectory="applications",
		
		
		--this is where the applications array starts
		{
			description="FLV Playback Sample",
			name="flvplayback",
			protocol="dynamiclinklibrary",
			acceptors = 
			{
				{
					ip="0.0.0.0",
					port=1935,
					protocol="inboundRtmp"
				},
				{
					ip="0.0.0.0",
					port=10000,
					localStreamName="cmwffpuscbcenfhvyccl",
					targetStreamName="cmwffpuscbcenfhvyccl",
					protocol="inboundUdpTs"
				},
			},
			validateHandshake=false,
			clientSideBuffer=0,
			keyframeSeek=false,
			--enableCheckBandwidth=true,
			--[[authentication=
			{
				rtmp={
					type="adobe",
					encoderAgents=
					{
						"FMLE/3.0 (compatible; FMSc/1.0)",
						"My user agent",
					},
					usersFile="users.lua"
				},
				rtsp={
					usersFile="users.lua"
				}
			}, ]]--
		},

		--#INSERTION_MARKER# DO NOT REMOVE THIS. USED BY appscaffold SCRIPT.
	}
}

