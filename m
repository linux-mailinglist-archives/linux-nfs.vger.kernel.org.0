Return-Path: <linux-nfs+bounces-3633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABF902690
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C1C1F26553
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481CC142E92;
	Mon, 10 Jun 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OHj5J38h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2138.outbound.protection.outlook.com [40.107.102.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01243146
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036499; cv=fail; b=SHhMBTDkFt6Rf0Uh0mSLxG0uErHucWHgd3PIGMeGVBeZTJ1aCSvF8hi35k+7eXQpRr1UtYnvgSTZXI5ISY6/7NSzdGf4CnTAx90nezOLZgYY135R64rDVa8FpRIhSGI3dHMg536wO3ekYlpBauYT7X5vVH+Ll3wrwBJ2wufO1BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036499; c=relaxed/simple;
	bh=MUsZ8Vz6BP4KSp1X1eqgSbu+1idtomCTJjHMteYu6tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NesxRoZzy3wyQ3BdMhOb1CYUEMIKVCpmnkPVbMyVNmF7+ugYmQrY1c5blWYpuEj/QixEdfiOA+D6k2p8pqS/olhX0kaBt9fxyJl+Jl45Co4birV7DpcGPdQ4bciSACN5aUPsT4qDZX1MYDgB6vruOWaBeiYUWhwi1YT0oXW16jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OHj5J38h; arc=fail smtp.client-ip=40.107.102.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMvSXuUxVFK5x1bUcq37ea1FM0kzYbZcQ/Dj9o1D926ExzT5pe+K+gMgXuQ0tcMoxQhFAntNqR0bmKlVjqWfxw0Fd8w6UMMQ1VgxeYWdoaO6ZB17FZ6PvhHgEYxVkoi0udX8qXeWuIGy3aLiJPXbk64zU+FuFQP2H3EOnsHNzGIZDxLrplRlaDrCx+OH2Mjw6nzklnvQHmztQ0PWcU3tot2kBapqD2oO9u8nfpuRnYKHsJk4lOzdkycFk1fPmlB8uHu8Jp9RUz1SycVBLxfiyM9EUafhZ99coJdB6xICgUq16lm06HnHtUK4XZXjY8m3AUijqQtH73gvbr2OWQfSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUsZ8Vz6BP4KSp1X1eqgSbu+1idtomCTJjHMteYu6tw=;
 b=N0MStiJ2wLlNuLV/oNkmHVA8ygpJ/V3PFT1x/jnNPuW5tSMgh5C4tJhpfXt53UqfZB6+kh1ASfR0p+CvFvlViVe6ann/gr2frLgJHdDbZna0VJ50z+znTJzFqbmP7O3z6KMRLoT5UEdbBgqzsrW1w+yf1d8vYic3kr3o/+5HjGZwNsi9cbMqmYFBOiKL3p0NlQFkWypYsCVh/75FLnl2TcdtMiq7djIHAU6C8jbJ/regdiPCiX/jrwH63pJVIKeMefHDdIKJnHud5POEY8UnKVjCAgIBTxDkH6Mbg4iJfqjqhb7FlKjxvi4M5s5sBZmcX1tfMTx8RML34hwt//QqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUsZ8Vz6BP4KSp1X1eqgSbu+1idtomCTJjHMteYu6tw=;
 b=OHj5J38h3rA0CN8C7UnBJlqVw5NjuM/qstTBzo33/hgpH++TMTvyHpvsd01HRWzi8aeRVQ+GDyL7eRcF0uyrQiDfDogfKkOpIJ7zu2k+gYcIQ0twdWsAx2YWxKCV0fZrW+mtJmi9JGSvFrK2sl7edlZ5IPWaKw1wtzWCAsXUgis=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4751.namprd13.prod.outlook.com (2603:10b6:5:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.15; Mon, 10 Jun
 2024 16:21:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 16:21:33 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "cel@kernel.org" <cel@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
CC: "tom@talpey.com" <tom@talpey.com>, "hch@lst.de" <hch@lst.de>,
	"dai.ngo@oracle.com" <dai.ngo@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>, "kolga@netapp.com"
	<kolga@netapp.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Topic: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Index: AQHau0eXWuSoQ4zLOEupu2fJidW957HBLfMA
Date: Mon, 10 Jun 2024 16:21:33 +0000
Message-ID: <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
References: <20240610150448.2377-2-cel@kernel.org>
In-Reply-To: <20240610150448.2377-2-cel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4751:EE_
x-ms-office365-filtering-correlation-id: a14b10b5-6688-43da-18dd-08dc896964fa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWZIcnl3Skh3Q1A3c0F0SjVZSzkybnNPNUV4NTlBR3I1MTA4K0JMSm5uWWpN?=
 =?utf-8?B?clRxY21odVdFTW5hazVmUzdmL0dIbjdpN0ZLOUxTYmwxNE1qM0tyRmpWSXNE?=
 =?utf-8?B?VHlBUTRmaGRsYUtZdlhhVktSc3FyeGVsQzdLTGZjYkJvYXFuS1VqQ1U3a0Vq?=
 =?utf-8?B?M3hRbE01M0V1TytCaHVUcGxIZk8wVU9oSGp0dGcrMHoxdGVPeGN1THpsT2dn?=
 =?utf-8?B?cGNwcDQ3aDJ3ZDZmZzZ3a0hpTHVZNmh5anFBSFovc2p4eVd6RDQwZjNBclBw?=
 =?utf-8?B?N1Y1cFJEc1UxNytZTTNLek84emRoS1ozQm5FRmJuSWhxV3hRcW8xTDZQM0p1?=
 =?utf-8?B?NDVPY0dVZjAwclBHWTRsWGFqQmo1b2pxUXJYdkoxT1dLSE5hVHNXQnEwTjB5?=
 =?utf-8?B?QVpGS1dMbCtCYTJ2aGZoRjE0Nk5uOG5VRklHdmU2cmxxUmFxQ0szZWx3WGM4?=
 =?utf-8?B?R1VMa3g1WnhpT0FYTk5LY2dlM09YRWtaaER2UkFKaFdFSGc0a3dWaWp3TXUz?=
 =?utf-8?B?VTBjS0ZqQTZMT04zenZJNk0wd3M2YXhNZGpEQTBMQWovRnBEa0JJZkJtcFIv?=
 =?utf-8?B?MUxWdGNKR2tSSm95Q05zUVdZcTdFWExMRW5DL0E2SjJ0UXRmbUJNd2tkZUlw?=
 =?utf-8?B?MW0wdUlnbnNpUDZTbXluSXNmd0RzSm5STk5GY1JWbmgxa24wSVgwZmxMQi9S?=
 =?utf-8?B?V1VGeDR0QnJORWtRQzV4Y1pEQ2FWY3M1b1JOL3FibUJ4UTAzZHZod2RMQTBk?=
 =?utf-8?B?enZXZDRLWktsU0hrNy8wMW4rM0NFWVhsWWE5a0NhSGtjbEI4bTAwdWdkZ0tR?=
 =?utf-8?B?WHZSVmlpV3JRbllJNXE3Ym9OWEFqTWNHNlB6T1hHenZGUVhVSmp0UVEycWtj?=
 =?utf-8?B?NGppVXhVNDhYUVpSSWZndFVFTkE2WWN4aE1WR2lFai9ReFdwa0dpUEgxVTd4?=
 =?utf-8?B?WTZFVG9rNUFWdG5XSHNQNlV0MHBtREhXOWlPWTZZWHNSa0diWm1vVVlyRG02?=
 =?utf-8?B?OFZ4VFZUOTFWdEJOZDk4MWNidEs5d0dyZm1YeHlqK1ZuS0xtRVBJU3lsSmFy?=
 =?utf-8?B?MmZGclBsUnFQYldmazAxYWZIekp0WW5QRWUwbGt4Nm5MUy9JZmZkbElOaFJG?=
 =?utf-8?B?K2N3QWxFQTBRMDdWVGl2YnRCUlZZOXFtcU14Z3QrT3ZaNlFMTU5WRlIxU0pO?=
 =?utf-8?B?bjNTNzc5d0p3TVBndGY4aGFXYzFWTzk5aExSb3JKbDBVcTVKaUIrcDhxRzNu?=
 =?utf-8?B?UjZ4b29yREg5NG83cXFxMmxrdXpaVGprU3FHS2cxanlrNklJZHdoOXdmYlM0?=
 =?utf-8?B?R0Zod0g2emE3NCs2QXdyV3hhOGhNaG02UmRqVSs4S0ZVK0ZlaWFWcEpCYzVq?=
 =?utf-8?B?eHRkRGQvVU82Um92Z1NyMTJhdDdZS0M2cVZkQU01OFRIQ0RVZlJ0R3NQbDJL?=
 =?utf-8?B?Sm5TYVZPRTNGRDdZMm5KNFRuc0MvdVVET25zYUZEekNkSVY0NnNiRjY5NmNO?=
 =?utf-8?B?dnd6TkZVV044VWR5bDU2ODNGL2hRZmErazhqZ0tnaDNaMlNja3dnNG80ZFdk?=
 =?utf-8?B?eGdKaUFMRklIK0hyMnNodU1MQmxpelNOdFF5dFV1YW9yQm4wZ3JyZEFMTmMx?=
 =?utf-8?B?ajBqV0ZFelhEZXNIdjgzNzEvdnRPMzJyL1cwYXJ2Mmp1M3dKZ2s2Nm9DWmJE?=
 =?utf-8?B?L2I3bG0yY2s2dE52dUlCeURUa2R2bEJqK0RqOHRUMGM2dTVmUVZrQld4UWFz?=
 =?utf-8?B?TGJ1eXJ1OURUQXJxWWJVaGJYMDIzZnNNcU51QTZPVHJPZ0xCY3JDV2IwRkh5?=
 =?utf-8?Q?gV5OEo/3kKsnf6f2vCmDWWqx/Y+lKX6rzNHwA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFc3Tk05V1AzbzRmME1TMVQ1NEVWSjZVRzJhUnkyZXlVOGZIa2Z4NzRNZExG?=
 =?utf-8?B?bG5yWmNiVFdYVlZ4UzJkQUJ3S2l3WlptZkRFRXVlblk2MGR2NHZDck0zTmtW?=
 =?utf-8?B?TlduWWZSTGxMVUxlTlR1RkJWTHlUNXI0azJ5Y0svSktYQVZ0ZlVWVnpiWkhz?=
 =?utf-8?B?ajdDL3VCbnpQUTlDanFSYjZWd0Nud0FiYTY4dWlXYXNOMU5naFVSSzdNdk4v?=
 =?utf-8?B?TkZzZnFXc2FwZkZ2YmFoTUEyOTNxekNla3p5emNEWmkxQWExR3hNUldOTTYy?=
 =?utf-8?B?S0xXNWR4WWVvZ0YrMHNJMG1mMGQ2WWVFR2RSbHRtcTRqN0MzWlVwSVJ0bks0?=
 =?utf-8?B?ZGpybVh3bXljRC80cFRKL1hNM2hoQ29oOWlIUnd0eUsvSm9FOHNQOXZtOWNv?=
 =?utf-8?B?ckVVVXVzOGt4ZWpsK0d0aU44dS8rMTMwME1oZWljSkQxM3NISnlPWTZQRnpr?=
 =?utf-8?B?dkVnZFF1R3lTSys2OCtueXZ3dGNBWXVRVXV4eDdxYlZhNUNGUHFoNjhXSmdi?=
 =?utf-8?B?aE04NG83bVZpR0pXaXoxaVEwTjd1V3VyU3N3bFFnRVMwZEQrV3d1UzBNZkRQ?=
 =?utf-8?B?aGl6RGVFSUc1Nmo0UTNtUGtSdlN2ZnJwZm5DcHUwam1nUm5pTU1yY2dQenhm?=
 =?utf-8?B?d2FuSlF6ZkFEMExzaDYrNUpZL2xSVUZ6cXdjczVWU1l1VUphdGwzVVRwQk9T?=
 =?utf-8?B?U1AxNmNPdGdpSWtmbnc0V05xcVcxNVFHZXZhQVlIWkQ3MCt3ejlKcXJwZnJo?=
 =?utf-8?B?NTE4Q000dm5VSDdUS3paNzJWZ3VLbUZVd2lNM3pPRXdyN0ZwYWo4b29yNzNz?=
 =?utf-8?B?RHlrbWgvMTRQK3RIczVVK3ZXbnFIcXg2amtPMnEwNm5udG0xYjI1aVVQdHBa?=
 =?utf-8?B?U1cxOWx4bDVyZVFTZE96Ui9SRysyMElaTWNOQ2xxWDAzRkd2WVFmWlJudldO?=
 =?utf-8?B?NTFmNUZpaDFha29Pa0t1Y0ltNFhsRHhySllacGtpaGVzTjFJOTBXQjR0RUV1?=
 =?utf-8?B?SkF2Mytwd1VCNkJkYkIzRTdVcUo1RzlsS2ltb3Y5RXlKTm1tMEpEVklkZ3Zp?=
 =?utf-8?B?QmIvR3pjUklLWFF3MVpCQjZCalNZbzE0cW9VTDdMVTJKbHE1aFJ0NjZsYndx?=
 =?utf-8?B?aHg4Y2F5RzBmZFAzUExVWm5ibzNVTEpqS0dvMkpVMDlaemNEUnUyc0lZeld1?=
 =?utf-8?B?TjNRbFI3QXJ0SkhYVWE2RWdmMHFRSU14MTBUT1UwVS94YXB5RDIycDd4eWJT?=
 =?utf-8?B?UDNHZ3Q5aStTZFJqdHp4aUlTYkZLcklNOFFwQXB5eVpHbWN3b1dURU82b0hv?=
 =?utf-8?B?Z05Pcjg3ZmdwVlI3enQwcDAzTFVEbk9meDg4MHV5YVVBOUdseDJvaW93V3RC?=
 =?utf-8?B?a1VSUXJMYTdRRmVaN2h1YndnN1JLaHAwaEFjQTJrZGhVVmcycVpKTUZwTXQ0?=
 =?utf-8?B?Q0ZsTTU5MU5sSDlnUGJxYTRqam9GMUptMzRTSStWaFBQWHdGYms0T2kvSys5?=
 =?utf-8?B?TmVUa0tDWXlkajRVLzNlSU1Vd3psSUp1LzJCeThXUHRxTG9lZ1RSYzl3aFBM?=
 =?utf-8?B?ZmZqVWNBVVVVcFpLREk1aExRWlVScTZ5djgyMFg5Tkt3S2xTdDBYTGRIU255?=
 =?utf-8?B?OEQ5Y2Y5Zk1hUmdjQ0hCRjJGSVRUbGZxOXlIRkd5UzNMaVdHa0JMeGZBVnJL?=
 =?utf-8?B?QU5XdG1vczRFbGRacExKTkhSbWx2TzhJRm03N2FoZHlpL091Titqbkg0R1NX?=
 =?utf-8?B?RVBFdUZuWlR1NksyMlNnc2tPUm56R3FpY0liNUVLUm80aTdENlpVT1RuSDB5?=
 =?utf-8?B?WVAxa2FkV1FCanlhczJueTFSMGJibktrK2VGMnFzSjJjS0hKNnBWNE56ZExs?=
 =?utf-8?B?VFMrTUduR283NXpoYzhLZDNkOWdnMUI3MWRJNUgrQlpJMVo4Zmd5NmUwTzhm?=
 =?utf-8?B?R3p5M3lrMWUzT2FSSlJteFBSSUlMLzU0bVc3ZVp2M2d1TUFqMlVzRTVKR2ZW?=
 =?utf-8?B?b0Z0TEdpZ0RZWXBna2VsN0NzTU9BeEFXL3JISVdJMXl3RC8vTjZUVGNJcFBk?=
 =?utf-8?B?YnZzbjJRVTd2a0d2WG5sYS9zRThpblRTYWRWRllQYmtVSzRDRkp6L2lXSVUz?=
 =?utf-8?B?LzlFSXNYQUFyOE9UV2JJM250amtoaVdJaVJ6dzlnTUlUcGQvcEIvbmhWMzJT?=
 =?utf-8?B?eEZYL2lJREV1c0E1Q2UrRzV3dDVkbWZrMU00eldET3lUVFVsY0h3NzB5Vlk5?=
 =?utf-8?B?V1ZOa2ZWd0hWemxwaEQ0TkJtOG9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <374E05ED71D6DE4C9D7021D72E896326@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14b10b5-6688-43da-18dd-08dc896964fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 16:21:33.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsbBTayAe+24UyVPOGj2F2b4xKdsHJ2d8Wt3Bb+DG0rIUQY5LDHDud8OFdDWw1X9LowQfX6r2pW3I/czrbMs9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4751

T24gTW9uLCAyMDI0LTA2LTEwIGF0IDExOjA0IC0wNDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToN
Cj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiBJIG5v
dGljZWQgTEFZT1VUR0VUKExBWU9VVElPTU9ERTRfUlcpIHJldHVybmluZyBORlM0RVJSX0FDQ0VT
Uw0KPiB1bmV4cGVjdGVkbHkuIFRoZSBORlMgY2xpZW50IGhhZCBjcmVhdGVkIGEgZmlsZSB3aXRo
IG1vZGUgMDQ0NCwgYW5kDQo+IHRoZSBzZXJ2ZXIgaGFkIHJldHVybmVkIGEgd3JpdGUgZGVsZWdh
dGlvbiBvbiB0aGUgT1BFTihDUkVBVEUpLiBUaGUNCj4gY2xpZW50IHdhcyByZXF1ZXN0aW5nIGEg
UlcgbGF5b3V0IHVzaW5nIHRoZSB3cml0ZSBkZWxlZ2F0aW9uIHN0YXRlaWQNCj4gc28gdGhhdCBp
dCBjb3VsZCBmbHVzaCBmaWxlIG1vZGlmaWNhdGlvbnMuDQo+IA0KPiBUaGlzIGNsaWVudCBiZWhh
dmlvciB3YXMgcGVybWl0dGVkIGZvciBORlN2NC4xIHdpdGhvdXQgcE5GUywgc28gSQ0KPiBiZWdh
biBsb29raW5nIGF0IE5GU0QncyBpbXBsZW1lbnRhdGlvbiBvZiBMQVlPVVRHRVQuDQo+IA0KPiBU
aGUgZmFpbHVyZSB3YXMgYmVjYXVzZSBmaF92ZXJpZnkoKSB3YXMgZG9pbmcgYSBwZXJtaXNzaW9u
IGNoZWNrIGFzDQo+IHBhcnQgb2YgdmVyaWZ5aW5nIHRoZSBGSC4gSXQgdXNlcyB0aGUgbG9nYV9p
b21vZGUgdmFsdWUgdG8gc3BlY2lmeQ0KPiB0aGUgQGFjY21vZGUgYXJndW1lbnQuIGZoX3Zlcmlm
eShNQVlfV1JJVEUpIG9uIGEgZmlsZSB3aG9zZSBtb2RlIGlzDQo+IDA0NDQgZmFpbHMgd2l0aCAt
RUFDQ0VTLg0KPiANCj4gUkZDIDg4ODEgU2VjdGlvbiAxOC40My4zIHN0YXRlczoNCj4gPiBUaGUg
dXNlIG9mIHRoZSBsb2dhX2lvbW9kZSBmaWVsZCBkZXBlbmRzIHVwb24gdGhlIGxheW91dCB0eXBl
LCBidXQNCj4gPiBzaG91bGQgcmVmbGVjdCB0aGUgY2xpZW50J3MgZGF0YSBhY2Nlc3MgaW50ZW50
Lg0KPiANCj4gRnVydGhlciBkaXNjdXNzaW9uIG9mIGlvbW9kZSB2YWx1ZXMgZm9jdXNlcyBvbiBo
b3cgdGhlIHNlcnZlciBpcw0KPiBwZXJtaXR0ZWQgdG8gY2hhbmdlIHJldHVybmVkIHRoZSBpb21v
ZGUgd2hlbiBjb2FsZXNjaW5nIGxheW91dHMuDQo+IEl0IHNheXMgbm90aGluZyBhYm91dCBtYW5k
YXRpbmcgdGhlIGRlbmlhbCBvZiBMQVlPVVRHRVQgcmVxdWVzdHMNCj4gZHVlIHRvIGZpbGUgcGVy
bWlzc2lvbiBzZXR0aW5ncy4NCj4gDQo+IEFwcHJvcHJpYXRlIHBlcm1pc3Npb24gY2hlY2tpbmcg
aXMgZG9uZSB3aGVuIHRoZSBjbGllbnQgYWNxdWlyZXMgdGhlDQo+IHN0YXRlaWQgdXNlZCBpbiB0
aGUgTEFZT1VUR0VUIG9wZXJhdGlvbiwgc28gcmVtb3ZlIHRoZSBwZXJtaXNzaW9uDQo+IGNoZWNr
IGZyb20gTEFZT1VUR0VUIGFuZCBMQVlPVVRDT01NSVQsIGFuZCByZWx5IG9uIGxheW91dCBzdGF0
ZWlkDQo+IGNoZWNraW5nIGluc3RlYWQuDQoNCkhtbS4uLiBJJ20gbm90IHNlZWluZyBhbnkgY2hl
Y2tpbmcgb3IgZW5mb3JjZW1lbnQgb2YgdGhlDQpFWENIR0lENF9GTEFHX0JJTkRfUFJJTkNfU1RB
VEVJRCBmbGFnIGluIGtuZnNkLiBEb2Vzbid0IHRoYXQgbWVhbiB0aGF0DQpSRUFEIGFuZCBXUklU
RSBhcmUgcmVxdWlyZWQgdG8gY2hlY2sgYWNjZXNzIHBlcm1pc3Npb25zLCBhcyBwZXINClJGQzg4
ODEsIHNlY3Rpb24gMTMuOS4yLjM/DQoNCkknbSBub3Qgc2F5aW5nIHRoYXQgdGhlIHJldHVybiBv
ZiBhbiBBQ0NFU1MgZXJyb3IgaXMgY29ycmVjdCBoZXJlLA0Kc2luY2UgdGhlIGZpbGUgd2FzIGNy
ZWF0ZWQgdXNpbmcgdGhpcyBjcmVkZW50aWFsLCBhbmQgc28gdGhlIGNhbGxlcg0Kc2hvdWxkIGJl
bmVmaXQgZnJvbSBoYXZpbmcgb3duZXIgcHJpdmlsZWdlcy4NCg0KSG93ZXZlciB0aGUgaXNzdWUg
aXMgdGhhdCBrbmZzZCBzaG91bGQgYmUgZWl0aGVyIGNoZWNraW5nIHRoYXQgdGhlDQpjcmVkZW50
aWFsIGlzIGNvcnJlY3Qgdy5yLnQuIHRoZSBzdGF0ZWlkIChpZg0KRVhDSEdJRDRfRkxBR19CSU5E
X1BSSU5DX1NUQVRFSUQgaXMgc2V0IGFuZCB0aGUgc3RhdGVpZCBpcyBub3QgYQ0Kc3BlY2lhbCBz
dGF0ZWlkKSBvciB0aGF0IGl0IGlzIGNvcnJlY3Qgdy5yLnQuIHRoZSBmaWxlIHBlcm1pc3Npb25z
IChpZg0KRVhDSEdJRDRfRkxBR19CSU5EX1BSSU5DX1NUQVRFSUQgaXMgbm90IHNldCBvciB0aGUg
c3RhdGVpZCBpcyBhIHNwZWNpYWwNCnN0YXRlaWQpLg0KDQo+IA0KPiBDYzogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+IFgtQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmfCoCMgdjYu
NisNCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+
DQo+IC0tLQ0KPiDCoGZzL25mc2QvbmZzNHByb2MuYyB8IDEyICsrKy0tLS0tLS0tLQ0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzZC9uZnM0cHJvYy5jIGIvZnMvbmZzZC9uZnM0cHJvYy5jDQo+IGluZGV4
IDQ2YmQyMGZlNWMwZi4uYzI0ZjQ1ODcwYjI4IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnNkL25mczRw
cm9jLmMNCj4gKysrIGIvZnMvbmZzZC9uZnM0cHJvYy5jDQo+IEBAIC0yMjY5LDIzICsyMjY5LDE3
IEBAIG5mc2Q0X2xheW91dGdldChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLA0KPiDCoAljb25zdCBz
dHJ1Y3QgbmZzZDRfbGF5b3V0X29wcyAqb3BzOw0KPiDCoAlzdHJ1Y3QgbmZzNF9sYXlvdXRfc3Rh
dGVpZCAqbHM7DQo+IMKgCV9fYmUzMiBuZnNlcnI7DQo+IC0JaW50IGFjY21vZGUgPSBORlNEX01B
WV9SRUFEX0lGX0VYRUM7DQo+IMKgDQo+ICsJbmZzZXJyID0gbmZzZXJyX2JhZGlvbW9kZTsNCj4g
wqAJc3dpdGNoIChsZ3AtPmxnX3NlZy5pb21vZGUpIHsNCj4gwqAJY2FzZSBJT01PREVfUkVBRDoN
Cj4gLQkJYWNjbW9kZSB8PSBORlNEX01BWV9SRUFEOw0KPiAtCQlicmVhazsNCj4gwqAJY2FzZSBJ
T01PREVfUlc6DQo+IC0JCWFjY21vZGUgfD0gTkZTRF9NQVlfUkVBRCB8IE5GU0RfTUFZX1dSSVRF
Ow0KPiDCoAkJYnJlYWs7DQo+IMKgCWRlZmF1bHQ6DQo+IC0JCWRwcmludGsoIiVzOiBpbnZhbGlk
IGlvbW9kZSAlZFxuIiwNCj4gLQkJCV9fZnVuY19fLCBsZ3AtPmxnX3NlZy5pb21vZGUpOw0KPiAt
CQluZnNlcnIgPSBuZnNlcnJfYmFkaW9tb2RlOw0KPiDCoAkJZ290byBvdXQ7DQo+IMKgCX0NCj4g
wqANCj4gLQluZnNlcnIgPSBmaF92ZXJpZnkocnFzdHAsIGN1cnJlbnRfZmgsIDAsIGFjY21vZGUp
Ow0KPiArCW5mc2VyciA9IGZoX3ZlcmlmeShycXN0cCwgY3VycmVudF9maCwgMCwgTkZTRF9NQVlf
Tk9QKTsNCj4gwqAJaWYgKG5mc2VycikNCj4gwqAJCWdvdG8gb3V0Ow0KPiDCoA0KPiBAQCAtMjM1
OSw3ICsyMzUzLDcgQEAgbmZzZDRfbGF5b3V0Y29tbWl0KHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAs
DQo+IMKgCXN0cnVjdCBuZnM0X2xheW91dF9zdGF0ZWlkICpsczsNCj4gwqAJX19iZTMyIG5mc2Vy
cjsNCj4gwqANCj4gLQluZnNlcnIgPSBmaF92ZXJpZnkocnFzdHAsIGN1cnJlbnRfZmgsIDAsIE5G
U0RfTUFZX1dSSVRFKTsNCj4gKwluZnNlcnIgPSBmaF92ZXJpZnkocnFzdHAsIGN1cnJlbnRfZmgs
IDAsIE5GU0RfTUFZX05PUCk7DQo+IMKgCWlmIChuZnNlcnIpDQo+IMKgCQlnb3RvIG91dDsNCj4g
wqANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

