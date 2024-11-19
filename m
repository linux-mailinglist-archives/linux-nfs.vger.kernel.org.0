Return-Path: <linux-nfs+bounces-8119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511F9D2AF6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D2FB2C217
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51561D0E10;
	Tue, 19 Nov 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BBCjE0mv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nrp/xzaR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB31CF5C7
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033438; cv=fail; b=BXCVwIkEMfM0/CdqEB8qwOzu2G1flmN0GFPNDBKmtvFrMdKSd1N+bUculXGcs2To3sRcz9IEZUhvyuUFPScKt1w0jElW2eey1cW5pUpoLvkKCA9vugvl8Jz3/jWdBg6/w4HHhrpHZxN3u5EsP6Gksa1Jb/UueqwxKaw+iubzlGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033438; c=relaxed/simple;
	bh=Evj658+fH7ADMIoWosgGy/4vTlWlMZLrEmkMSuIocnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XO0t5D7yMmLz26FU3JXe4SlKtBaV56CIRnlE0kxIxelP6LF273ofdX08UdYQ+4bWbXMCGmxXoLv1aXN8/PqKZdlDwFcsm/NAZ+MVy2Cw9DrH2X5G6+URhUbFSoXMijOdSauAMvL2PsG1K2lfiwV0+M0qyKKvbKVyMu9bN4q+GFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BBCjE0mv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nrp/xzaR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGMYiB009508;
	Tue, 19 Nov 2024 16:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Evj658+fH7ADMIoWosgGy/4vTlWlMZLrEmkMSuIocnM=; b=
	BBCjE0mvO3YiSSihizYlfG+OVr+SVDVIvnBPVdjDrKrS6gYW1mrD4PR5XIRBm5Q7
	Kj3ky6HC/oxJtEEqQEewW7B6HgP2ULsbcJkLOiWcxcJFuRc0tnIYo89mPOC2Cmrd
	Tr6TqGE4OB6sIPXcwWhCnubZFD8qdyGe7Z6p0ldwHIOy960tC8mVYFFLILBfPjOJ
	pG0+Km0x1fBSRFBIX1MEttudjXEFVOL/oyaGO2vyLrlbzGopom5tf5dKkELV8eNF
	VYpzTKfdWUdYAxBe9/IYp50JQN0LW1MyXtu7MgSZUJ16jyllvFFqCAkfCa7Jn7M6
	sWJGNPVzRqzn9/4A8JwYvw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc5cxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:23:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGAMXE007762;
	Tue, 19 Nov 2024 16:23:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8rs85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvfk+eEcR/r2QbegD5g9nwH2dr7m4a8p2sc4b2YfMbHGKBQ9zg3sMUi8MMA8TqNnC5j0yQfgiPy89X4dcmEI+P/tkHJGCDard9muo4yxM8zp5PdNAGTJb11TmftISwNWZN6mLxjouOXF374AQq8VxAbZOGMeqyb+seK3egp5jdeQT/gUag3ODAOiG1MZ6GNr0yd7c8B4QaVh0zwOk1/yPgqNR9zVLMv0Knk4qTk0NSm0HxZuysX4js6e2c80IxyQRfK8Qki1lMdIPGLnzQzgNsjsblRh0JcXQQHvXDpuvNENwYyer9KsZRi2vbtXQsEyA4tjY9BFvz8fp+xVmQdh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evj658+fH7ADMIoWosgGy/4vTlWlMZLrEmkMSuIocnM=;
 b=sClJ30pBItzdhWjNvLqlv1sUwdM00fohujtH2ELaUzX8ZJPI0homdP9/yhgqbCXhVL174Qj/8+Lpuw3ieYPT+Pl5YkB+tZ+KkK3eMW+F/SzxGPCAVfuVFWHJ16YpH6Ojx7fLIAHlgmGE9+m9/G5Zyb2xij4S56h8XnRxk6uvzzj2nz9id0+pvUpniuO/p1A/8QQDrRbuBSkJfrg/b0Cvesy7cL/4THRCbFHQ1FIQwYSkqI8Jl9vUzUCHeUqF3E2PxSwNVbS2sRoO0y6UYrpMrB8f5TGRZdYNSbdzyg7VjIk8tglBk1ESB3scA9ZYlHyoOkIBSE79NJ5Dhy4ttqbsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evj658+fH7ADMIoWosgGy/4vTlWlMZLrEmkMSuIocnM=;
 b=nrp/xzaRF2YGTt74qgOX7PTws5wCcyWqVoTsrVd1BAmFjYe9I/nVJJi5LOctxRrL5Rce9gJMMf3bb7KZ5u0Ahn+2AUVj/9hlOvR04+U+R/vt/L3KOFZwi3Gml6aBCwUIcQVV/IuG8rPmZGMBXX5gdEFNz/PzfsrMkro1ffStdUI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Tue, 19 Nov 2024 16:23:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:23:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: "snitzer@kernel.org" <snitzer@kernel.org>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Tom Haynes <loghyr@gmail.com>, "anna@kernel.org"
	<anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: OPEN_XOR_DELEGATION performance problems
Thread-Topic: OPEN_XOR_DELEGATION performance problems
Thread-Index: AQHbOnidHhsk8MJ1xkCj/5AQiG7N2LK+tTQAgAAUnAA=
Date: Tue, 19 Nov 2024 16:23:45 +0000
Message-ID: <4210AE90-97EE-4B32-AC67-1DB80082D4CC@oracle.com>
References: <d5b8d3d6c7592808ad1332ae8c7c2f2cc9635550.camel@kernel.org>
 <ec60bdca5eea7d459ce81144914f7bd56cd747a9.camel@hammerspace.com>
In-Reply-To: <ec60bdca5eea7d459ce81144914f7bd56cd747a9.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6056:EE_
x-ms-office365-filtering-correlation-id: 57593a6e-dee2-4ddf-b35b-08dd08b68a1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmZ5VlRrcXZKUmxNT1hlcFhmY3V6WHRkMkRsUVNOZjJDQmRGeERsQWd1Skxt?=
 =?utf-8?B?bm5tc3hrMlZwYVcrNlBPZXlsK0laRitsMEI0U2RUZDZaUVY4ektoVUZSeVlJ?=
 =?utf-8?B?TEZpMVRZYklXVHM1ck0yb2hyU1BLREY1SytINjczM2s2RDdLKzQxc081V1Nv?=
 =?utf-8?B?NEppelZ1cWJzV0UxbDJjemxwVUZVeHR3anFPZUsvRTMxWUNkVng5cW43cUVC?=
 =?utf-8?B?TDlkQUd0UldFNk9jbEM3QXRzdnFqekUxZ0EvVFVFemVGekRqOHV3dWdoekcv?=
 =?utf-8?B?dmMzcERTbWtMTWVMWlZ1aGtJN3ByRExyT3VjdGdqTVFPL252b08zSVdOQjFX?=
 =?utf-8?B?MFB5UkxoV3pZdjFQYkZad2JkaUtTM2NMeVFKQ1ZxeGcrYTAvTENVMkk3REFN?=
 =?utf-8?B?NUR4TGN3NGYyQ3lGbnFjT3gxM1JIZ0ZxZjF6TUViWi9MdTlIVnJLWkNkanBR?=
 =?utf-8?B?YXFpa2pjNTk5MFU2S1NKVWVBRkZUZ1BUWHFKRU9tTDV4cVdqa1BsRnZuRHdi?=
 =?utf-8?B?MFdxUklIWm00bHlnbHBvek95eGFsZHJEaU55WjV6Szc0Z3kxSFo0SFJCRmls?=
 =?utf-8?B?UWl4d2NOY1QyYjdZVEdma29yWGk2MG1ia0pyNmUzcWtBR2ZxZEpMZ1YzMWVL?=
 =?utf-8?B?Tmc1QTF5ZjJZZVVmaHZNM3NTcjljbU1nTFhrKy92N3UzVDRZcVhBWXpqc2sx?=
 =?utf-8?B?TTNPeUVZRFZSQXpjcldyUXZDN0dRcWZpLzh0TWVFZUNLNElENHorZE5OdnIw?=
 =?utf-8?B?K3I5M2k4VW12Wk5ZeXBGY3JEcCtCZVZhTk11bVpvWm1TcXpsUXZJekFWSDV5?=
 =?utf-8?B?OVF0Y3BXTURTellTeW5sdVZlYWJadVdqVWpwNDRmM3NCRk1idGpJK0pFb1Iw?=
 =?utf-8?B?b2h4ZEZKYmI3NEprd3d5aXZXWTA4bnhLOVcrbzF6ZytGRHFYWFZmeWpTb0c4?=
 =?utf-8?B?YmZKRGc4NFRydTZtbnJLWXF3WGRBR2RPVFRjMlYwT0IzNm5acDExa1B5UXVX?=
 =?utf-8?B?QmlyWk9mM3RJZ21SQ3lsQ0pBL2JRZmdKbmtIYnFpRzhBMU5PdGl2WC84WTFT?=
 =?utf-8?B?UFBUVVVHc0dkd3RTcVZ6SEduQkUzS0lLbkRQaWZMZjIreFNmUEpVOWdHVTFp?=
 =?utf-8?B?YUJWM2tFK1hROG43Y3VTcnptem5FK0pDMUFlV0FCdEtFdmZabm1mUHBtVDFm?=
 =?utf-8?B?ZTlOaE5XL0Vza1RJUUZEc1p6UE00bm1hblNZa1U0bXptTXd2K0phbkcxbUhp?=
 =?utf-8?B?R1diWGZ6MjBabEVnKzRKeG44ODV1eklkS1RZbjlOUmtQMmtzblB0RllUM2s4?=
 =?utf-8?B?YjYyZ2luRVdEY2wxWWtIbkFvbk81dkRaNUZpMnN4VUxpSkZSV1B5NWt0Vlhm?=
 =?utf-8?B?MWtyOE1pcU1QRWIxWnhxUU5LWnRTR0FMWWQzUGYyeGxmMVVlN2pvZVg0THB3?=
 =?utf-8?B?dlVKb1QvRGFpNStCcW1uRXBlNVJmeEVwcUVjTkZ1TFo3d21xZmRCNDRRc3VZ?=
 =?utf-8?B?b3h3eU8vbm8zbzBsOGU3dVZEKzZhS09NdEJlV2Y3bmlaKzFTME10SUt4OG9k?=
 =?utf-8?B?enhOZ084Y0xVYllwTHFRRzlYLzJaSjdWcFlDVkJRRXkvUHdYMTFGdGxLeTVz?=
 =?utf-8?B?UHNkd2l6cnBqN3B1WVlSNG9ObUVGQi9LK3NQeUlkWFhQUkJjS0N4OUk3L3hP?=
 =?utf-8?B?UXhCdGE0L0wzVG05dTBMdmoxdm92RHVwSnVNbi9OM25BZWczNWVLaC9WZXZP?=
 =?utf-8?B?T1FFblpIanVkOHJFTDRHU3pPSEhMbGlPQWdoRjNlaDBBWm5MODZRc2lJSkNh?=
 =?utf-8?B?LzJZODRBenZmSUpHa2VxQUdpNHUrUWtsVkxIU1E3amtES3VvTU9ZRUZIUjRl?=
 =?utf-8?Q?DdLTdL8o1o5yZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckFlbEtOSmZ0dXBqLzhoeWZYSXRMOEM4QlhWR1E1UGd1ZXBQc0hZMWxJeVVq?=
 =?utf-8?B?VE9TeEdiWmVjWWhFdXN0ZkFSYXVQWVJlcXBLSG1kOHBlZjZSMjErT2YzMkJU?=
 =?utf-8?B?ZGFUQlRXWG9RWEpNcUtOclovSGNwQ0tKYi9vazZwQnQ5ZE5mZjBYSFJ3dW5n?=
 =?utf-8?B?WlpRbzgrV1g3TGJZR0JwVDNZQzBpQUEwTUcwQzNXRmh5MU5qRUNHQzFuemhN?=
 =?utf-8?B?N0MveVZOY0JVb281bWl5QldEc0liODdvRXpuZXNOK203azhlNm5NZzN2ejVB?=
 =?utf-8?B?UDN0T2UzZkx2cFVJakNMb2s1dVJLR25vVnR2UmZKamwvTVl5WVFlQ242VGla?=
 =?utf-8?B?Q2J1OWRiM1FwaWZOaEloeUw5Q1gwL3czM3dmeStZOVlNTm5RRTNKbEI0VkFB?=
 =?utf-8?B?WWVYcDVrVTlVSEw4RDZ1UHRoUjk1bEdCTHRkcWQvU1ZJZHRvSXprdXJzK3Y5?=
 =?utf-8?B?c1Jydklrc0NkL0daem5JQjhESE9nK00vRHBZMlkrNmFSVjhWSXFEYTJUR1Ro?=
 =?utf-8?B?Q1loNzRnWmtGV1lJeWFxYk41N1U5b3o3NU5Kd3hlNmhwSS9KSURvNDZJYlQ3?=
 =?utf-8?B?UW9vSnN2VDhObllFNmtSUW5MMUFjdlRYRm9oMWw5VUNzREg2anQ3MFU3MnlJ?=
 =?utf-8?B?aVh2ZXpLS3lLWHNTTHYyWnNTRysxNXYrRnpDQjJkcVZwNkcxcHRvWU5PZmwx?=
 =?utf-8?B?Qmc3ZzRJSCtLTSs1TTFSdWM5eHEwSURWYUZsR1N6RzZJYXpPQUlxbk5SWU9p?=
 =?utf-8?B?aEdJL0MyZzNGcWJKc3JTSnBFdXhvL0pZTWRzNE1ZZzVHeVlWdEpxKzhwY1Ji?=
 =?utf-8?B?aVBvVzFpWFFibVZFcStrMGdBNkx3SE9HS2FrRm8reXR2VUxkcDRBNjJNVG1Z?=
 =?utf-8?B?T0IwbEJDVGNjSEVpKzc5L0VoaklIaHhzcVhxam1FeUZqalRzdFZsd1NKb0ZE?=
 =?utf-8?B?eWJNdzBpdmNjRGVuMGNFNUVYMms0L1EzL1d4RTBHQU9VM1hvdXFpZm9hdE1q?=
 =?utf-8?B?STNmRHZGZzhKR2Exb2RHNVFPREZ1VDkzUXNKSXBoN0pvZXk5RVZ3b2tPdVNs?=
 =?utf-8?B?Wk5iQVNGL3hZdSs1NS9aejgyMmc3dUdtQTY5WWYrdTlIcUN1UGgrTktoRDJ1?=
 =?utf-8?B?bGFWY0xxK2hyd0xIR0p0d0FrQksrM2VHTUI2R2JGU2dxcG5HdG1UMmdGT0xJ?=
 =?utf-8?B?Z1ZKcXNac2FKcXVDM2RXYVVRWGdkdGpHSWNIZ2x6dEoyNUZaMk8wRjZieXIy?=
 =?utf-8?B?L2VpdFZKdlU1M0VkOUdJMHRyTXhWLzNHK0F1TXFUYTl5TmFuUW5iVlNseVpp?=
 =?utf-8?B?eGZVdmdvUkdKM2dZZ2dwOGRIczNZRWRxazl6TVRTQ1UxNHJiV3FLTndCRmw1?=
 =?utf-8?B?bE1uazd4K3hQY2g3KzdRM3pwcXpxWVkydFNlbUdjTTJTWWNtUVdyOGhDZ1hH?=
 =?utf-8?B?QUZaNzJLZmMrdlZOVyswYWtFcUM5NzNmcnpXTk5KVDV0TnpPVWFRdWhIdG9C?=
 =?utf-8?B?bUk3czRJeGRBZlcwaVRJRW5EbHlrcVl4QitueFMxUC9KY0dmYVFURGlyVlVZ?=
 =?utf-8?B?S09hc0s4c0p6NW5NZEJLZjBXVk1zN2pvVUE1dXA4VVBsSUhWdzBaa2VPMUdr?=
 =?utf-8?B?WVNwellQV1k0aXB3WW5VZVg5NHE1eXIwUHN5eXIxQUdaZWUwUmFBa3Y5a2s1?=
 =?utf-8?B?SlZsbGZ6L25mdmFqNUFXVnFtbjdpY2RHWE5FZ3Z6a3QwUVNlbnhBT3luaDNx?=
 =?utf-8?B?NXlqRDFQK1JXc2FHZU8ydTdoZjA1dkFBc2RwQUU1UGxUYlo2d3k4SG45YlFs?=
 =?utf-8?B?WWszMUI3OTJob2lhL09qcHlhWTNJZHM4cnliZU9rbzljZUhNSTYxKzlJaVA2?=
 =?utf-8?B?RG55UlVNb1NtR3ZYaXArWVJXSGxHeGNVODd2Vithbk5kVGFxaGlNenBHc0NW?=
 =?utf-8?B?QWJjbVhwV3p6OHp0U1NIZzh5TTY5QWYzTHNtNTZVK21sL3c0UWM0dkNJZVpp?=
 =?utf-8?B?MHR2eFVDSDdGaHdMRzRYb1J1V21hR2JjVkpUM3M2N0lQK3duSEgrM01zZFB3?=
 =?utf-8?B?aEFLejZVUHdscDBrb05zK0xFOW0xdDdCVzJpdGo4Y051WkgyQXcwZHMvTGdi?=
 =?utf-8?B?TXZ2aGZzZndOMllLbEp4TFFZRlFHc2F5UEozTXFCWi9QWmhmQ0Jxa1RSeHpp?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2D27F989BE2414EA6AF7E7A9F7CF086@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YMTB+e2kHFHmK6EHiS/tmP36/kXK2ftX2O4t+dO3ZRsip8Vrmh2qNqFYCOvjFMZ+nrDF4OuWgEMC3CQVF3uy5dmGxrfKlXUn03zlAVCpT9twhMdJWRygh45MIYk/+JSgHBlEBVWXQiPp4iALtr4bx6qDAnPUyDiWt1e7fwqMQfpYhnJjOmowcTZmUlrENCE+B06NrVld15jx3MESntg+7zwovZWK6RKvE7U/Epa+frnk3c+q+ypCBu8+FHhJyWXYrsbfV6+4ivpKZjgvBo2zK04j4wWaSzpIkRBaSBSzkTz5g2eSjA4EgVvKTNAuwjwdfCazIH3mwXAD042m9m+03Re6DQ52KmXa6wtLFw2zT0PHAxw/FZ9CW3k/7rnpaa8JH7hWdTrFjpXQQQeirHUOmH5TXNZ8yoldbB79htP0Cqv/XKYROUoyYhJZOW8xknEWE8fJzUlrM0V6gqEZUpXGEHpSE7EWNDRF2sEe3/N7jVkHcsJjonlngXUcTNrz81cskOndlW3pKgQx6Gj86Hy0p70YuA1eYF7OXLOz9RFHkf9TgX++L+Y6FI1//GSjPklajEy8ColgQpycDHYxCSNvCtcdGkwFSCsA7j2yYQ9Pjm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57593a6e-dee2-4ddf-b35b-08dd08b68a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 16:23:45.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F84TDZA1wRQcePde7JNJJ0QM95IKlPFxOG+w1cshYjGaRLfcEPZGvbSb2ZlZOMcyTbM6w0EKapeVuZT7PkSrWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190122
X-Proofpoint-GUID: tylECr9GeFM_1tbOmCTmpex1DIfOJlDc
X-Proofpoint-ORIG-GUID: tylECr9GeFM_1tbOmCTmpex1DIfOJlDc

DQoNCj4gT24gTm92IDE5LCAyMDI0LCBhdCAxMDowOeKAr0FNLCBUcm9uZCBNeWtsZWJ1c3QgPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNC0xMS0xOSBh
dCAwNjo0NSAtMDUwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+PiBXZSBhdHRlbXB0ZWQgdG8gaW1w
bGVtZW50IHRoZSAiZGVsc3RpZCIgZHJhZnQgZm9yIHY2LjEzLCBidXQgaGF2ZSBoYWQNCj4+IHRv
IGRyb3AgdGhlIHBhdGNoZXMgZm9yIGl0LiBBZnRlciBtZXJnZSwgd2UgZ290IGEgY291cGxlIG9m
IHJlcG9ydHMNCj4+IG9mDQo+PiBhIHBlcmZvcm1hbmNlIGlzc3VlIGR1ZSB0byB0aGUgT1BFTl9Y
T1JfREVMRUdBVElPTiBwYXRjaDoNCj4+IA0KPj4gDQo+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1uZnMvMjAyNDA5MTYxNjQ1LmQ0NGJjZWQ1LW9saXZlci5zYW5nQGludGVsLmNvbS8N
Cj4+IA0KPj4gT25jZSB3ZSBlbmFibGUgT1BFTl9YT1JfREVMRUdBVElPTiBzdXBwb3J0LCB0aGUg
ZnNtYXJrICJBcHAgT3ZlcmhlYWQiDQo+PiBzdGF0aXN0aWMgc3Bpa2VzIHNpZ25pZmljYW50bHku
IFRoZSBrZXJuZWwgcGF0Y2ggZm9yIHRoaXMgaXMgdmVyeQ0KPj4gc2ltcGxlLCBhbmQgZG9lc24n
dCBzZWVtIGxpa2VseSB0byBjYXVzZSBhIHBlcmZvcm1hbmNlIGlzc3VlIG9uIGl0cw0KPj4gb3du
LiBNeSB0aGVvcnkgaXMgdGhhdCB0aGlzIHRlc3QgaXMgb25lIHRoYXQgY2F1c2VzIHRoZSBjbGll
bnQgdG8NCj4+IHJldHVybiB0aGUgZGVsZWdhdGlvbiwgYW5kIHNpbmNlIGl0IGRvZXNuJ3QgaGF2
ZSBhbiBvcGVuIHN0YXRlaWQsIGl0DQo+PiBoYXMgdG8gcmVlc3RhYmxpc2ggb25lIGR1cmluZyB0
aGUgdGVzdCBydW4sIGFuZCB0aGF0IGNhdXNlcyB0aGUgYXBwDQo+PiBvdmVyaGVhZCBzdGF0IHRv
IHNwaWtlLg0KPj4gDQo+PiBUcm9uZCwgVG9tLCBNaWtlIC0tIEkga25vdyB0aGF0IHRoZSBIUyBB
bnZpbCBoYXMgc3VwcG9ydCBmb3INCj4+IE9QRU5fWE9SX0RFTEVHQVRJT04uIElmIHlvdSBydW4g
dGhlIGZzbWFyayB0ZXN0IGFnYWluc3QgaXQgd2l0aCB0aGF0DQo+PiBzdXBwb3J0IGJvdGggZW5h
YmxlZCBhbmQgZGlzYWJsZWQgKGVpdGhlciBvbiB0aGUgY2xpZW50IG9yIHNlcnZlcg0KPj4gc2lk
ZSksIGRvIHlvdSBzZWUgYSBzaW1pbGFyIHNwaWtlIGluICJBcHAgT3ZlcmhlYWQiPw0KPj4gDQo+
PiBJZiBzbywgdGhlbiBJIHN1c3BlY3Qgd2UgbmVlZCB0byBjb25zaWRlciBsaW1pdGluZyB0aGUg
dXNlIG9mIHRoYXQNCj4+IGZsYWcNCj4+IGluIHNvbWUgY2FzZXMuIEkgaGF2ZSBubyBpZGVhIHdo
YXQgaGV1cmlzdGljIHdlJ2QgdXNlIHRvIGRlY2lkZSB0aGlzDQo+PiB0aG91Z2guDQo+IA0KPiBB
cyBhbHJlYWR5IHN0YXRlZCB3aGVuIHdlIGRpc2N1c3NlZCB0aGlzIGF0IEJha2VhdGhvbjogdGhl
IHNlcnZlciBpcw0KPiBzdGlsbCBpbiBjaGFyZ2Ugb2YgaGV1cmlzdGljcyB3LnIudC4gd2hldGhl
ciBvciBub3QgdGhlcmUgbWF5IGJlDQo+IGNvbnRlbnRpb24gZm9yIHRoZSBmaWxlLiBUaGUgT1BF
Tl9YT1JfREVMRUdBVElPTiBmbGFnIGNoYW5nZXMgbm90aGluZw0KPiBpbiB0aGF0IHJlc3BlY3Qu
DQoNCmZzbWFyayBpcyBhIHNpbmdsZS1jbGllbnQgdGVzdC4gVGhlcmUgc2hvdWxkIGJlIG5vIGNv
bnRlbnRpb24NCmZvciBhbnkgZmlsZXMgZHVyaW5nIHRoaXMgdGVzdC4NCg0KDQo+IFllcywgSSdt
IHN1cmUgeW91IGNhbiBmaW5kIHRlc3RzIHdoaWNoIGNhdXNlIHJlY2FsbHMgb2YgZGVsZWdhdGlv
bnMsDQo+IGFuZCB0aG9zZSB3aWxsIGJlIG1hcmdpbmFsbHkgc2xvd2VyIHdoZW4gdGhlIGNsaWVu
dCBoYXMgdG8gcmUtZXN0YWJsaXNoDQo+IGFuIG9wZW4gc3RhdGVpZC4NCg0KVGhlIGZzbWFyayBy
ZXN1bHQgcmVncmVzc2VkIDkyJS4NCg0KDQo+IEhvd2V2ZXIgdGhlIGlzc3VlIHdpdGggdGhvc2Ug
dGVzdHMgaXMgdGhhdCB0aGV5IGFyZQ0KPiBkZWxpYmVyYXRlbHkgc2V0dGluZyB1cCBhIHNpdHVh
dGlvbiB3aGVyZSB0aGUgc2VydmVyIGlkZWFsbHkgc2hvdWxkbid0DQo+IGJlIGhhbmRpbmcgb3V0
IGEgZGVsZWdhdGlvbiBhdCBhbGwuDQo+IA0KPiBGdXJ0aGVybW9yZSwgdGhpcyBpcyBubyBkaWZm
ZXJlbnQgdGhhbiBhIHNpdHVhdGlvbiB3aGVyZSB0aGUgY2xpZW50DQo+IHVzZWQgYSBkZWxlZ2F0
aW9uIHRvIGNhY2hlIHRoZSBvcGVuIChpLmUuIGF2b2lkIHNlbmRpbmcgYW4gT1BFTiBjYWxsKQ0K
PiBhZnRlciB0aGUgYXBwbGljYXRpb24gY2xvc2VkIHRoZSBmaWxlIGFuZCB0aGVuIGxhdGVyIHJl
LW9wZW5lZCBpdC4NCj4gU28gdGhlIHBvaW50IGlzIHRoYXQgdGhpcyBpcyBub3QgYSBzaXR1YXRp
b24gdGhhdCBpcyB1bmlxdWUgdG8NCj4gT1BFTl9YT1JfREVMRUdBVElPTi4gSXQgaXMganVzdCBh
IGNvbnNlcXVlbmNlIG9mIHRoZSBjbGllbnQncyBhYmlsaXR5DQo+IHRvIGNhY2hlIG9wZW4gc3Rh
dGUuDQoNClRoZSByZWdyZXNzaW9uIHdhcyBiaXNlY3RlZCB0byBKZWZmJ3MgWE9SIHBhdGNoIG9u
IHR3bw0Kc2VwYXJhdGUgb2NjYXNpb25zLiBUaGlzIGRvZXMgaW5kZWVkIGFwcGVhciB0byBiZSBh
DQpzaXR1YXRpb24gdGhhdCBpcyB1bmlxdWUgdG8gT1BFTl9YT1JfREVMRUdBVElPTi4NCg0KSXQn
cyBwb3NzaWJsZSB0aGF0IG91ciB0aGVvcnkgb2YgdGhlIGZhaWx1cmUgaXMgd3JvbmcuDQpBcyBk
ZXZlbG9wZXJzIG9mIHRoZSBvbmx5IG90aGVyIHNlcnZlciBpbXBsZW1lbnRhdGlvbiBvZg0KT1BF
Tl9YT1JfREVMRUdBVElPTiwgY2FuIEhhbW1lcnNwYWNlIGhlbHAgdXMgdHJvdWJsZXNob290DQp0
aGlzIGlzc3VlPw0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

