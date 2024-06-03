Return-Path: <linux-nfs+bounces-3531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA0B8D8448
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A214E1C20D4A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6301E4AB;
	Mon,  3 Jun 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=boatrocker.com header.i=@boatrocker.com header.b="rBIFlspZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2133.outbound.protection.outlook.com [40.107.116.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68181877
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422366; cv=fail; b=p8VVSpc84rIiwlw2pYc1qGg3tGQrzjM+dWiSTNSKGAIwYVL8KFag63LTDKMvIfdhtOwZz4Shpl5TKUbWkbZIkXpk8BEzuf3KYt+AH1bp8nCqjzXc36QN5RPeY0M5PkBJAvl4f8u+mUbcc7FxJrDwXSos9WOl1sTjdVYCgYdqlMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422366; c=relaxed/simple;
	bh=G8ek8BlMxPa858XUv98fSS7FmW9iytt3tWL4jeInvGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgsnbDScuAXSbLeNS9rQFag/Xto5l8xK+aoJ9zvBHhpz43cIG+21Q2oqV4fjhdB2HmCKELAp9VkPiSzR7RpmBv8naGbultlj7GZLU6tcxTWM5jWZsdUpoVxdEXvVw2kdrr6VtMOPu0AJjc0dgBYajSdkH4ngwntM7xc+LoUlSiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=boatrocker.com; spf=pass smtp.mailfrom=boatrocker.com; dkim=pass (1024-bit key) header.d=boatrocker.com header.i=@boatrocker.com header.b=rBIFlspZ; arc=fail smtp.client-ip=40.107.116.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=boatrocker.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boatrocker.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcgmM7xKJf+NsImHfZJscJ2AXryU09x0unIXY9GIFgL5nkEDa8zvRyfpCgTZAcfJk8x6lFf5Qa7ku+3TaMgnOiJ6T3lsT9fCJHPkODWlj6K7QW8Vh/DJOu9vSZ7cb0pg+u0db/K3DbYfJXlZXyV+7OVqDSTSwYWg+u+22aH5J+xPbahEax/Hdhc3hBFtHBQ1wq5xlZM2hlGAbq6GvRaniKrWA2PYcIMnXulC2sJk8PSJB+gTL9272PXvuzIr4z+JlnqHInwUb1C2L97fyVLonMCbDgfHWZFlwopws+B76YfGqIihCFp4+qI/53l89deQ1IJpKKtVn7qnmcLgg8F5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8ek8BlMxPa858XUv98fSS7FmW9iytt3tWL4jeInvGA=;
 b=ejgQ9lTaEz3H9AeHTem91/YOkRX846hySSbyWqq+WI6WigPt6WRHA1IbUr3j3ODCZo4BR7SMLrmZiyQwwEm6qhLZ95/o41w48aI4Qnzwbpu6b+OmdkpC8ImtY7w3h/E9stcBDJ+LZaodOeik0VNgYvOkMeqpBYmHpW1Qbui54cWvPQ+BGxocek+GVPmWKw/OA3waeFrIThtq1y7CcIuzGNDXFV/7TG5lowHLDWc0K6V2nMzS3C4TzDBPA9lgNHrVOcG/bLxavSAERlXRIt1ryNCEDJl1dE3IkSQcxohiPsaVEuNCUqnyFyGqQKP9F8NsmIUigQTCSKhC3ct5vOGAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boatrocker.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8ek8BlMxPa858XUv98fSS7FmW9iytt3tWL4jeInvGA=;
 b=rBIFlspZtfbDvx4ikAR7zmrEA19B5bC5BusM4xB9SDY//yuVwSByypvbOVaW5ioYQ+ghJfeaQhy1SBJ2FX+mwcpPrzF+xF45naWi6Nip+Y0pbheJPhEt+oTslUIhpObjDtL2TYJjiEhAk9MeczKYvp7mjb5eo+d/YkVDaH6XCn8=
Received: from YT2PR01MB10745.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f4::16)
 by YT2PR01MB10539.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 13:45:58 +0000
Received: from YT2PR01MB10745.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4ff7:1e0b:c13f:18ce]) by YT2PR01MB10745.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4ff7:1e0b:c13f:18ce%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:45:58 +0000
From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: RE: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize
 rpc_xprt->timeout
Thread-Topic: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize
 rpc_xprt->timeout
Thread-Index: AQHZVb74qq7nSKwNxkWOAfXkZrAi8K76nU8Agr4thqA=
Date: Mon, 3 Jun 2024 13:45:57 +0000
Message-ID:
 <YT2PR01MB10745E3B103A76945F104E56886FF2@YT2PR01MB10745.CANPRD01.PROD.OUTLOOK.COM>
References: <20230313151716.34280-1-andrew.klaassen@boatrocker.com>
 <FD077033-023F-4214-A9A4-BECCF319F973@hammerspace.com>
In-Reply-To: <FD077033-023F-4214-A9A4-BECCF319F973@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB10745:EE_|YT2PR01MB10539:EE_
x-ms-office365-filtering-correlation-id: fb473c52-81f9-40ff-00ea-08dc83d37f81
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10745.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDZqc0dRc1BrVktCSzkxVmNLRzRwK1NZT0s3eGhuUlhBVmZkQlFPN2M5aStX?=
 =?utf-8?B?OThicDB2QTBKckhSSGU0NUNxTmdmMXJJbUYxZTR1Yk91K2F3WkVSSUNpZVh4?=
 =?utf-8?B?VnViYUFRaXNhTC9xNVpMSVdDODl1dEpITTJlM3JxOElIbi8yTmE0SDR1bUx1?=
 =?utf-8?B?Um1Rcy83VzYvTzB1akYxTVhjYW42cjEwM285T0VIcDNBVlNrT3ZrZE5HYnli?=
 =?utf-8?B?czZiOFNSTW9kTjJvLzluSXRsSUtLUzVzbkowRTQzUXQvV3dFaUdaZzNmai9x?=
 =?utf-8?B?dnZUM2dzUFRGNmJUaldHeE9rRzRJbzMyc2IxblltV213VDI3TlppQkh4SVl6?=
 =?utf-8?B?RlBRU0FUK29veElCcFc5OENtMkd6d0V0V0sybXhIbkVVT0VPcjBhNEZyYVE3?=
 =?utf-8?B?OEhCcER4SWU2TEFVb3hrQW55UmlmR3FSdTVYY3dWL3dYUWRNUFM3NG5QamxQ?=
 =?utf-8?B?SklPU0FBWFJhR3JJRjcreTY2Wkk3RzFvMmdDMmFzYlFPbWViQ28yN2Fmamsv?=
 =?utf-8?B?UjFybi9oVUtRTnJ1akhsZTJTV0ZIc0laRlk1MEc3ZFFhODdrNXhuVDhWU2I1?=
 =?utf-8?B?WmQyMkkvT09xVStXSzdrMnJMNlorV0VDa3hjSFhnNVd2Zm1yOWdBMCtIeTRR?=
 =?utf-8?B?VDFkeXNIU01mMmExamdRakRtNlJnQVBDRG9PUERrb2dEY292QUJ4N2xITkFL?=
 =?utf-8?B?R2VFdmZ6bmFkaWdpODQ4V3A2azdmbnlPMVhVM1BKQm1xTFp5Rk0zb09TTW9w?=
 =?utf-8?B?bUF1M0dwZUk1ZHFCTGRqSTFFNXVCMDE1bkNFVkgyZVZBM2MyYnZHT09yOGYv?=
 =?utf-8?B?YjF5clgzMm4wOHdRWEsrenU5Z09kWEZSSDRaUG5Uekc2LytKbE54cG4wMHMr?=
 =?utf-8?B?SEtoci8xNEF0c1Z6VVR0S3E0MFQ4bStMME5Vcm8zK053MXVJbzc1d3BYNnFF?=
 =?utf-8?B?ajQwL2oyK2ZnbWh2NVhhT1BzcWhSUjlvRU05QytLdWtPclBMWlpUUitqNkRj?=
 =?utf-8?B?UWZnZmx1RVplYy9BbWRNVkFJa2VnQmRtcDhTOXRYNDJLUDdTMC9aVkdhbktP?=
 =?utf-8?B?c1FiN3ZLbmk1NFViSGoyVHVnVDhzUW1aRzV6ZndNczM5WmlPVmlPblhjV0hr?=
 =?utf-8?B?VlFXc2x5aGl3R3J1dnR1ZS9ISVY4c2pQWWtGOU5jMXhZN3EvTDZKQmZvK3ZS?=
 =?utf-8?B?VmhLUlRHMUNRTVFZTFFXdG0zRk9XMTFYS2tuOE92OVBJS01sd1ZMNUJGQ3Yx?=
 =?utf-8?B?dlJDY1F2ZEZjdS9WdU9BanprU2tXa1BULzlDSzFXT29weHRRYlF5c0VDZEVp?=
 =?utf-8?B?c2IwTm5XVUpibDRGNnF5SWRZVzZ0ZStFY0dVVjlKNUxnNVRvbFpZOWxJaVNw?=
 =?utf-8?B?Zk9tQ3h1VnFjd3NmN2g5RHNwdUdiUkQzbUZxbU8xdlBNMFZXUnRieDgzbUNw?=
 =?utf-8?B?VGdWSVlzbVJacjUxWHJHVmJJVFVoa1kvSGZOb2VkeFlZWEZlN1BtSnFaQXlm?=
 =?utf-8?B?TEUvQjJuR255Y1JJQkQ3Q0lEUjZQRUtNODZ4L3J3RnI1MTk5WHdSVEFxQ0No?=
 =?utf-8?B?cHg4ZFJ2dXJnYzhiT3VWeTVvNWRPZUh0bzY0MzJCTXhtcCtiUkQwY2tUdnA0?=
 =?utf-8?B?RzRYbk5UOEZaK05pTzdWZzlBOERaUXdiamFCTnlaTjczQ2sxN3I1V2FSRzY5?=
 =?utf-8?B?ZFZVYjg1VmR1OWZLd3E5MnJBMFhtVWJMbVlhZXIvVVpnV09hSTNRM2ZOeXdy?=
 =?utf-8?B?bTgwNjk3c2xWd3hLRlZSUW4vZGc3ZEk1QzJNME5ETStJSjZOQzlleWR2blhr?=
 =?utf-8?B?RnJ5YWhScXBXM3BETFBSUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXpDS0tBTGZOdzd2TFJ1eFQ2NGY4ekxPZk9MdGQ4YVRXajc0ZU93T08xL2x0?=
 =?utf-8?B?VnJqNzRibjc2QTRpL25vTWZYVy9nUjIxM1FlaXVRbC9LRUF0M0tzUzJBbVNj?=
 =?utf-8?B?b1lIUjBLN3oyUXpySUFYQWVLRXByZ1hPRWhIQlAwR3lodjJBSkp0WWVjajR5?=
 =?utf-8?B?cTZNdlFnaHVzYVJSd1Fpcy9pMW9Kclg4THVjdEJZckZsc2tvb0RhRGV3Ujdi?=
 =?utf-8?B?cXFQYThVUW9BeUpDc1hZanF5eDM5RGl5SFJ1YjlteG84ajlRRFJrNkVudHNu?=
 =?utf-8?B?dDd2aWNBeTloQUtyTkFEM3FnOE15VE5UQUcwM0Q1RVMwVmdSc3Q2NmQ5Z3Nv?=
 =?utf-8?B?MUIrR3kyOTl6Q2hSOS9SV3RTVGd1RjNPTEVjcTFuQ29kWjhTVTdHaVUvazJU?=
 =?utf-8?B?bGJReVNvK3dlUFh6bnRXbjdveGgxTjF4Snk0anA5SjJUeUtKQXJVUUlGc280?=
 =?utf-8?B?eHZvK2tlelZwQWhCSll0YllVNEZWdnFyTkg5eUMzTlhpMDJXRGgzWU03K3cz?=
 =?utf-8?B?SytpbjUvV2NLWVJEamJzbUZCQk9OTGhaK3VEYzVBNWdNOENQNFJaWmNGTmxT?=
 =?utf-8?B?clJMSm9BRHBnTVRtTmpIeU1uSU5jRkVJcWozcnNiVEY3Wi8zMnB1WFhOY1hV?=
 =?utf-8?B?S0pCOEFQOVBONmZGTUs1VEs3YTFIZnI0ZTJnOGdjWmkyWUJGcXc0WkxJWjZy?=
 =?utf-8?B?eUt1M0VNaUNWRUhqM0RiV09kRjdxRWRiVzl4aDkxajhLYVpueUc4V1FqcE5B?=
 =?utf-8?B?cmY0cCtsNWVFbmRiSjdJNTFjNzhUYWF4UnJSelNQNVpOd1M1VkRlVHlPN1RF?=
 =?utf-8?B?cWpFSXJualV0bkhXT0JZNFRlM3BzSzRRbzAvYUlVSHl2Mmlta29NRVdTa1pt?=
 =?utf-8?B?RlU1QzBpaFZyVm5WdkpnSE4ycU9WcElNcDZzYUpVdEs1S1oyVGRJeGtMU2xs?=
 =?utf-8?B?a2lIZW9IYXVIZ0NUL0U3NU5maHIxS1V2bzJRTEIxQk1ZRGlQNjhFM2MzYWhE?=
 =?utf-8?B?anhYTGMyRFZBVlkva0JDd3B1STdCN25JQ21YQThWK1BhdWh2aXNWbEtmQ3U5?=
 =?utf-8?B?bm1RR05jZmFsTmZlM09Db2lGaFpNMDRmTWVsampoeHdvWkhlYkJ4bDdZYU5u?=
 =?utf-8?B?dDA5RVp2S0hvSXpyaFZIdXlEM2Y3dzl1Ti9LV2lTcnF1RGNEUkhPc0FhNmdC?=
 =?utf-8?B?eUZsZjBqT0Y2STVtWjdhSHRINStOVXc2aVhtQjRLenYyTWdxMGNWTzdna0Qx?=
 =?utf-8?B?bHc1SHhCdXpuMmFoTG4vMnFQV0dzdmtWRVVSTkZzZ1pGeTY2OEtMb1d5OHI4?=
 =?utf-8?B?OEtNelRuVXNIMERGT2VzandNbWJOZjBJKzIwckVDR2tUZ0llNFJYVysvYkpz?=
 =?utf-8?B?dDF5d3R3bk80ZDNDVkhWbU1Ya3NoYVpIdGVnTzlRTUU0U0Myc0ppNTdsWC9G?=
 =?utf-8?B?NnRacmpodXI4dk1yb2pubEtRZ3ZXRGVtd0x4dDExdXcrcDRsT3locGFSVlR6?=
 =?utf-8?B?YXZ1ZUFaT2pWaHRuNlNRalNiTHRRRWpNZ1dQb2ZLTEpJcjd4c2dnK21rMDdO?=
 =?utf-8?B?Rml5RWM1cE4rVE1UQ1kzaDJ2aUFyOHdsT2kwV0dubGVCem1wK2hXNWlZQ3Na?=
 =?utf-8?B?YXdRU3ZNUWlFbCs4NGxacXdoWEU4dzFjRVkyQmhqKzgwYUlVZTZWa1NrYlF4?=
 =?utf-8?B?cU1BY0p5b1Bna2xEOUJFN001dHZ1akl1TWEvVklsUThqYXpOSk9xTzBuZ0sw?=
 =?utf-8?B?dUxUclNOSEFRSUZkcUlPSStKMEsrd1owWmo4bVBPVEE1TTFuV24wL3VRZy9t?=
 =?utf-8?B?dGQ4aTNJbzgxWm9XbmJ5d0FBSWplZVMrMnVhWVNON29ERWxwT3hXdHZsR3ZL?=
 =?utf-8?B?TkNzMTAwMFZxTkVhY1F3WHJyY3Y4MHQvMlZyRlZHQm5xYmVqMGM5OE5TbGtV?=
 =?utf-8?B?Y1pDU1pBSmM3ekFWNXRVbDI4R1hmdklyMVdQeUZmdGV5UXZVc21KMlh2WnNo?=
 =?utf-8?B?YVZMRFJDaW1GVFJRaGRYSENaYk1jWDhsYzVvZ3lXQUYraVdjQWVlei9mQWRm?=
 =?utf-8?B?RnRNOEFXeGhONTc5UHVkejBKQ3lQWW1Pc3Y4b3p0Z0hHL2ZBNmp4RCtscHdD?=
 =?utf-8?B?ekVaVHhDT0ZMNWFyOFlGQTB3cjdwYytaZktvQmZxdHlOaHB5S1NsZnFBcUtu?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10745.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb473c52-81f9-40ff-00ea-08dc83d37f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 13:45:57.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyVM2Oz6Jyyi0u1tMCBHjW9Sz7IMY9jg6AqfUVwhcbTAbaDGzkWDhbIYB1V4LCAAy6KXHjWy8gRWosCmn4mRtNQaXBFaT3AcW4FyXAzAmnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10539

PiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAxNCwgMjAyMyAyOjQwIFBNDQo+IA0KPiA+IE9uIE1hciAxMywgMjAy
MywgYXQgMTE6MTcsIEFuZHJldyBLbGFhc3Nlbg0KPiA8YW5kcmV3LmtsYWFzc2VuQGJvYXRyb2Nr
ZXIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdlIGFyZSB1c2luZyBhcHBsaWNhdGlvbnMgd2hpY2gg
aGFuZyBpZiBhbnkgTkZTIHNlcnZlcnMgZmFpbCB0bw0KPiA+IHJlc3BvbmQuICBXZSB3b3VsZCBs
aWtlIHRvIGJlIGFibGUgdG8gY29udHJvbCBORlMgdGltZW91dHMgc28gdGhhdCB3ZQ0KPiA+IGNh
biBjb250cm9sIHRoZSBtYXhpbXVtIHRpbWUgdGhhdCB0aGUgYXBwbGljYXRpb25zIGhhbmcuICBX
ZSBjdXJyZW50bHkNCj4gPiBjYW4ndCBkbyB0aGF0IHdpdGggVENQIE5GUyBtb3VudHMsIHNpbmNl
IFJQQyBjYWxscyBtYWRlIHRvIGFuIGV4aXN0aW5nDQo+ID4gTkZTIG1vdW50IGFyZSBmaXJzdCBz
dWJqZWN0IHRvIHRoZSBkZWZhdWx0IHVudHVuZWFibGUgU3VuIFJQQyB0aW1lb3V0DQo+ID4gb2Yg
MiBtaW51dGVzLg0KPiA+DQo+ID4gKEknbGwgbm90ZSB0aGF0IHRoZSBleGlzdGluZyBORlMgbWFu
cGFnZSBzZWVtcyB0byBub3QgZGVzY3JpYmUgY3VycmVudA0KPiA+IGJlaGF2aW91ciBjb3JyZWN0
bHksIHNpbmNlIGl0IHNheXMgdGhhdCB0aGlzIHR3by1taW51dGUgdGltZW91dA0KPiA+IGFwcGxp
ZXMgdG8gaW5pdGlhbCBtb3VudCBvcGVyYXRpb25zICh3aGljaCBpdCBkb2VzIG5vdCksIGFuZCBk
b2VzIG5vdA0KPiA+IHNheSB0aGF0IHRoZSB0d28tbWludXRlIHRpbWVvdXQgYXBwbGllcyB0byBv
cGVyYXRpb25zIG9uIGV4aXN0aW5nDQo+ID4gbW91bnRzICh3aGljaCBpdCBkb2VzKS4pDQo+ID4N
Cj4gPiBBbiBleGlzdGluZyB0aHJlYWQgZGlzY3Vzc2luZyB0aGlzIHBhdGNoIGNhbiBiZSBmb3Vu
ZCBoZXJlOg0KPiA+DQo+ID4gTGluazoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC0NCj4gbmZzLzQ1ZTJlN2YwNWExM2FiYWI3NzdiM2IwODY4NzQ0Y2RiZmM2Mg0KPiA+IDNmMmQu
Y2FtZWxAa2VybmVsLm9yZy9ULw0KPiA+DQo+ID4gVGhpcyBwYXRjaCB1c2VzIHRoZSBSUEMgY2Fs
bCB0aW1lb3V0IHRvIHNldCB0aGUgeHBydCB0aW1lb3V0LiAgSW4gdGhhdA0KPiA+IGRpc2N1c3Np
b24gdGhyZWFkLCBKZWZmIExheXRvbiBoYXMgcG9pbnRlZCBvdXQgdGhhdCB0aGlzIG1heSBvciBt
YXkNCj4gPiBub3QgYmUgdGhlIGlkZWFsIGFwcHJvYWNoLiAgSSBoYXZlIHN1Z2dlc3RlZCB0aGVz
ZSBhbHRlcm5hdGl2ZXMsIGFuZA0KPiA+IHdvdWxkIGJlIGhhcHB5IHRvIGdldCBmZWVkYmFjazoN
Cj4gPg0KPiA+IC0gQ3JlYXRlIHN5c3RlbS13aWRlIHR1bmVhYmxlcyBmb3IgeHNfW2xvY2FsfHVk
cHx0Y3BdX2RlZmF1bHRfdGltZW91dC4NCj4gPiBJbiBvdXIgY2FzZSB0aGF0J3MgbGVzcy10aGFu
LWlkZWFsLCBzaW5jZSB3ZSB3YW50IHRvIGNoYW5nZSB0aGUgdG90YWwNCj4gPiB0aW1lb3V0IGZv
ciBhbiBORlMgbW91bnQgb24gYSBwZXItc2VydmVyIG9yIHBlci1tb3VudCBiYXNpcyByYXRoZXIN
Cj4gPiB0aGFuIGEgc3lzdGVtLXdpZGUgYmFzaXMsIGJ1dCBpdCB3b3VsZCBkbyBpbiBhIHBpbmNo
Lg0KPiA+DQo+ID4gLSBBZGQgYSBzZWNvbmQgc2V0IG9mIHRpbWVvdXQgb3B0aW9ucyB0byBORlMg
c28gdGhhdCBSUEMgY2FsbCBhbmQgeHBydA0KPiA+IHRpbWVvdXRzIGNhbiBiZSBzcGVjaWZpZWQg
c2VwYXJhdGVseS4gIEknbSBndWVzc2luZyBuby1vbmUgaXMNCj4gPiBlbnRodXNpYXN0aWMgYWJv
dXQgb3B0aW9uIGJsb2F0LCBldmVuIGlmIHRoaXMgd291bGQgYmUgdGhlDQo+ID4gdGhlb3JldGlj
YWxseSBjbGVhbmVzdCBvcHRpb24uICBJJ20gZ3Vlc3NpbmcgdGhpcyB3b3VsZCBhbHNvIGludm9s
dmUNCj4gPiBjaGFuZ2luZyB0aGUgU3VuIFJQQyBBUEkgYW5kIGV2ZXJ5dGhpbmcgdGhhdCBjYWxs
cyBpdCBpbiBvcmRlciBmb3IgaXQNCj4gPiB0byBhY2NlcHQgdGhlIHNlY29uZCBzZXQgb2YgdGlt
ZW91dCBvcHRpb25zLg0KPiA+DQo+ID4gLSBVc2UgdGltZW8gYW5kIHJldHJhbnMgZm9yIHRoZSBS
UEMgY2FsbCB0aW1lb3V0LCBhbmQgcmV0cnkgZm9yIHRoZQ0KPiA+IHhwcnQgdGltZW91dC4gIE9y
IGRvIHRoZSBvcHBvc2l0ZS4gIFRoZSBORlMgbWFucGFnZSBkZXNjcmliZXMgdGhlDQo+ID4gY3Vy
cmVudCBiZWhhdmlvdXIgaW5jb3JyZWN0bHksIHNvIHRoaXMgYXQgbGVhc3Qgd291bGRuJ3QgbWFr
ZSB0aGUNCj4gPiBkb2N1bWVudGF0aW9uIGFueSB3b3JzZS4gIEkgYXNzdW1lIHRoaXMgd291bGQg
YWxzbyBpbnZvbHZlIGNoYW5naW5nIHRoZQ0KPiBTdW4gUlBDIEFQSS4NCj4gPg0KPiA+IFVzZSBy
cGNfY3JlYXRlX2FyZ3MtPnRpbWVvdXQgdG8gaW5pdGlhbGl6ZSBycGNfeHBydC0+dGltZW91dA0K
PiANCj4gSnVzdCBiZWNhdXNlIHNvbWV0aGluZyBjYW4gYmUgZG9uZSBpbiB0aGUga2VybmVsLCBp
dCBkb2VzbuKAmXQgbWVhbiB0aGF0IGl0DQo+IHNob3VsZCBiZSBkb25lIGluIHRoZSBrZXJuZWwu
IElmIHlvdeKAmXJlIHVuaGFwcHkgd2l0aCBzdW5ycGMgdGltZW91dHMsIHRoZW4gaXQNCj4gc2hv
dWxkIGJlIHF1aXRlIHBvc3NpYmxlIHRvIGRvIHRob3NlIGNhbGxzIGluIHVzZXJzcGFjZSwgYW5k
IHBhc3MgdGhlIHBvcnQNCj4gbnVtYmVyIGRvd24gYXMgcGFydCBvZiB0aGUgbW91bnQgc3lzY2Fs
bC4NCg0KQW4gdXBkYXRlLCBzaW5jZSBJIGdvdCBhbiBlbWFpbCBmcm9tIHNvbWVvbmUgaW5xdWly
aW5nIGFib3V0IHRoaXMgcHJvYmxlbSBhbmQgbXkgcGF0Y2g6IEkgd29ya2VkIG9uIHRoaXMgZm9y
IGEgbGl0dGxlIHdoaWxlIHRvIHRyeSB0byBmaWd1cmUgb3V0IGhvdyB0byBkbyB3aGF0IHlvdSBz
dWdnZXN0ZWQsIGJ1dCBJIGRpZG4ndCBmaW5kIGFueSB3YXkgdG8gcGFzcyBhbiBleGlzdGluZyBw
b3J0IG51bWJlciB0byB0aGUgbW91bnQgc3lzY2FsbCBpbiBhIHdheSB0aGF0IHdvdWxkIHByZXNl
cnZlIHRoZSB0aW1lb3V0IG9wdGlvbnMgb24gdGhlIHVzZXJzcGFjZSBzdW5ycGMgY2FsbC4NCg0K
SWYgeW91IGhhdmUgYSBxdWljayBwcm9vZi1vZi1jb25jZXB0IEkgY291bGQgdHJ5IHRvIHRha2Ug
aXQgZnJvbSB0aGVyZS4gIFVuZm9ydHVuYXRlbHkgbXkgY29tcGFueSBoYXMgbW92ZWQgbWUgb24g
dG8gb3RoZXIgcHJvamVjdHMgYW5kIEknbSBub3QgYWJsZSB0byBkZWRpY2F0ZSBtdWNoIHRpbWUg
dG8gaXQuDQoNCkFuZHJldw0KDQo=

