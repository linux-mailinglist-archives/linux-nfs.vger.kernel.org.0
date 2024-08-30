Return-Path: <linux-nfs+bounces-6018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507399654C6
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AADB215E8
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 01:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39057EAF9;
	Fri, 30 Aug 2024 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KlsUERyf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2094.outbound.protection.outlook.com [40.107.236.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E241D12FB
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982104; cv=fail; b=sHyhyc4ydXY/IOYqYjirjeKXHt00NyKipxvIIXEWxhKZ1r/uoKdJD4iOK/R+A2VL0IZBU/a+RdzSEsbJ3galijtL7nPM5BX1DpnDG3/m1CeJshdasICjv6rc3ySuqGsomXVmKI27mYwhHjwwo+RBtyWrq5oH1S38BSk4HxaMdt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982104; c=relaxed/simple;
	bh=sccsSDoipBVgg0oXiGu+SNC8jz0Qm/c2GcFNrB/qpXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mxZfYNVXO+2SG65kzhsXzGBNEmDsGXZRlj4iZppX+MZWdPCUhcP2Cx0kxqyciWYEpMsaIu2Hvt4M01Pg5r3EC4pHWm0psvg5iCuaUxELb5AwtK5pzJNifD/7vn/cKdofQbHO2uzTU598mftXnpTaojjY3cTCJNgtxLCESDy8KEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KlsUERyf; arc=fail smtp.client-ip=40.107.236.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3F8fREo4nlTKcKa+173MAp3yifah5gB8XD9JEUoz8MFLYQkngtJrifm4DKcxMe9OprVLhFtNfC39MxgDiCeGdyTv+RATfFBnwAmJGhgmnRhQal90F45ZMtAcK0Xdct5nXbsAPYQ+upJ2WoK1ZEV9hmCPDPUOlnhXe2TOh+alIHvgm5jMeHa1R3jWXtfRl6PbRg9EsjlsUmG196wvxV5r0TSF2gB8W6Vl9CRpEzuEVp5RGUk8kTKGNj9wQt0NzDsuHmZmS5JHbI1HniKBn5U71irmhmfnEmAIKd/ksQLYRbaojZh0h6LHR1y9A6/eynGkW3PUMXqm7lQpR3RPqgwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sccsSDoipBVgg0oXiGu+SNC8jz0Qm/c2GcFNrB/qpXo=;
 b=PiTvnQ1tzjU7vhnf3hVlREl2Bu0N4NwMP9e679kD69X+cmx/ZMrMRu3G9oqBLHIMIKDoCnPe5F54isaahf4jDSqBDSzHzRt2SFIU+zbHcry35QuCE8pZncnEH6y6CstGkEdOm5M4OYSxJbd78gvtLzeKRtOUnnMCpeSDHk2nqkB+1cBMYPbXdH661pgnRMZmUv44cUBn6bFcwe+bm1Vxvw8pTzLgv/XAXquAvp4WHs+caWSwi4cIEEKW8hO+5Zyhuck24xcaIjYZPjWq9LMfIcPv4mEi9cCfIbKOUVeKNWCx2HSX8lGmci+x+Ml0R8gUJyNCCD7hTmsxEmGhxd6YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sccsSDoipBVgg0oXiGu+SNC8jz0Qm/c2GcFNrB/qpXo=;
 b=KlsUERyfuAXxzUyBEyXnZC9CQAQxF7WNqmBNoGcYYZ/pM6GCn7SPah3EWuN6FA+EpyGeTN0+6v7v6GE2rlizTWGj33q9AVxBEZQeQ0N+R3TzFfxtp5GDmEFnZ8/w+AWo2CM1nb48Qji+taFXpIOP2EvHsx/bhQr4fE9xJfMGOP0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4528.namprd13.prod.outlook.com (2603:10b6:5:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 01:41:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 01:41:37 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Any idea how best to handle potentially large POSIX ACLs for
 getfacl?
Thread-Topic: Any idea how best to handle potentially large POSIX ACLs for
 getfacl?
Thread-Index: AQHa+nJPlVDQq4zD5USzay9O8vT3u7I+85yAgAAQboCAAAKRAA==
Date: Fri, 30 Aug 2024 01:41:37 +0000
Message-ID: <0c4d1a086b2d453cfa9e62b88bc28c0cc5720d20.camel@hammerspace.com>
References:
 <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
	 <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
	 <CAM5tNy7_gv_Gp17X+rZmZ4t_UTKWSX=+zGHGKPuhtF+--xOp-w@mail.gmail.com>
In-Reply-To:
 <CAM5tNy7_gv_Gp17X+rZmZ4t_UTKWSX=+zGHGKPuhtF+--xOp-w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4528:EE_
x-ms-office365-filtering-correlation-id: 2d1414b3-1f1c-4080-a27e-08dcc894e351
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEtudkdqYmlyM2x5VVM0L2pkQlNRa2ZiZG96NWcxNXFqdWFyUUg3VlVSQkQ1?=
 =?utf-8?B?aXlWa2xDOWpmdGV2ZUtqcEFQWUM5ZUJRMFFHZGk2cUpsUWFONEkva2VFN016?=
 =?utf-8?B?TUFGL3FKKzZlLzBUZEQxeEFxaEZneWVzZHpCZkJtOXBWUCs1K0xGT3pVR3lT?=
 =?utf-8?B?dDVLNHMyYmt0TGkzeTYzbFFHVmx6cVRZR2JNVWF2NDRXV0toL2dyZlBHV1Zq?=
 =?utf-8?B?Rit1Sk81YjlhN2M4WlR1cGJGTVhUZ1duazNBVFFnbW56bzIrYmJ5SGZwM3pq?=
 =?utf-8?B?RXl3RkZsNzk2NEU4TS9lREU2bW9ydXhrQ0U5SUhPN292OWZLaVJ3OFZGTnhW?=
 =?utf-8?B?WlB4ZzlPU2p1VHhJaGM1YkhxVUZJMFdmdDdrUkhXTzM5WmtQQ2srbytkbG5O?=
 =?utf-8?B?Q29rQTVCNzBFZjg1TmpsdTBpMGRKWkluQ0VROXc0VlVpNWJUc1ZucE5SSnRx?=
 =?utf-8?B?ZFdiNWc3R3NyUXh4aHluZW9hZUJFVTZxa29nZWJUQURoWldlQTlLaURKTnAv?=
 =?utf-8?B?V0VHQjB2bGZTUHFxOEY1U0ZPayttbmlzMjVMR0MrSnpBVEt0NmlFSWtteTZG?=
 =?utf-8?B?alkyUE9vT2xVWWpOZHhxbWw5dXRhT0UrZnFGamxvb2JxUk0rV29leVZtRU9n?=
 =?utf-8?B?V29rMjE5UERacVplZk9SOFV3NG5JakloMHM3dlR0K0crQ2JJRDQzQzN6aG9N?=
 =?utf-8?B?V29JblY3VGJIVjgwLzF3eXQ5TU14VHR6ZEJISXRvbDBuY01KcDFRSHhaVEFR?=
 =?utf-8?B?amR4aDd3VW5uVjlFNU9ieW1uQXpYTGkrSVRodTBZbHN6YTBlMWhWS0lsalRH?=
 =?utf-8?B?V3JPQ2hpN2FFY2MvYmxKcUIxOHZDNHgzZkRUa0tGVzAxaU9pRUlRNXNrNUF6?=
 =?utf-8?B?d0p1R2xpSElYWC9RV1JsckM4Tksra1FJRmVZMy9PcVFHR3ZNWEc3VFAxMmkz?=
 =?utf-8?B?c0UwYjUyd01jeDdGOGNYRU9oemQ2NXExQk11NjZJMFVpTjYydUduOEhiWW9v?=
 =?utf-8?B?UnVtRUp3bzV2djAwdjNuSnJzZm5iYUswNkZTLzVvTzU1VzAxL1RkTGM5T3dE?=
 =?utf-8?B?MFQzaWpPUHQyUGk0TXdaVTRLRUx1Q1ZKcmZVZTBnRnpXM25wKzFMNmVNczdS?=
 =?utf-8?B?RlJJV3VZU3JBTXBablNUTFdQQWRIVENoN1g0Qmc4bVBRTjV2WmZ1ejh3QmRu?=
 =?utf-8?B?RmY3TTZKOHBibUxRQW1wMEZJMEdwVk5mL0FheHhiK3M1dFNBcWUwYlA0ZmNo?=
 =?utf-8?B?T2hkMGNWZ2I0b1p4MDBsK1E5QmV0MURxdTdLcEtINEhUZHp2Rllwa3lBMTA1?=
 =?utf-8?B?WkxpekNvL0VEZVpGT0RyWmJ4aERLSW5EbE5ocjlmWlNtQnE0a1JSK2RqSmg5?=
 =?utf-8?B?NFRkdHNQK1E5cWFCMUVVYWh6a3pmNzloRVBYWk5JMGJEaVVGWE8wWEp3MmNr?=
 =?utf-8?B?Q0x1bFMyS3RSMktEQ0JyY20zRHROUUlITEh1S0Jab2VMYW9ablAvMGRTRlNY?=
 =?utf-8?B?ZUhuaEJqQVgwVXJ6dktHV0ZDYzBXZzNOcjQzcm5ZbGVKZkxIZ1JSWmN4N3JD?=
 =?utf-8?B?TWE2bDJoMTBIUnRGbjV2TEFYVXliOUJyWDBKSXJYdDdBMUNaTTAxdnFZc2Z1?=
 =?utf-8?B?ZFdjOTFOVFhCR0t0cSt5cEIvQVFEcE5wa2NMR0x5V1ErK1NldXBiSklGM2hq?=
 =?utf-8?B?dkNrRDRPQjhTU2xkQlYxS0l5a2o1TVNtVGkxUHRNOWZGcE1qOHNVUHhQN0tr?=
 =?utf-8?B?aVpMYURtUHNhRTFEMHhKZ3VieHlqakJrRFNDV056KzNCYWlBQ09yTkFSRHE5?=
 =?utf-8?B?RHVnSUV1YnVFOHkxdzh6aGd3K1JXUnBDN3BmbHNOUUhQUy9XSEZYd1grLzlm?=
 =?utf-8?B?OUl6dy9oSFk2Rk5YM2pDbFFzVE4zSXJhdWZMS2laRWkrc3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1Rzeks2aHRBSitCOFdBQm9qaVJCM1dLcklFVk5aWit3SDdIRTk2UU1HMVU2?=
 =?utf-8?B?VGUyRXNnaDVvam1JR25qeElCVDk5OXlHajdZVzNBNDh1RUFvMXlaT2gwWXJq?=
 =?utf-8?B?aURFNHk0b0Q5OVd5Y05SbHcralhTdlJldEFVRnBVZU4ybVU3WFg3Um56djQx?=
 =?utf-8?B?eVQvSlp6K21Edkh4M3kwbVh6UmliNVBzeXVEQm50azdTZXhaOFdxTStVbzFj?=
 =?utf-8?B?cm5wa0t6Q2ExZ0pneXFPbWowcHc4SkVPajBFWEYrWFFnbEpTOFF4Y0hOUW8v?=
 =?utf-8?B?QnlOdHZ6Q2hHMFEvZUFTR1piRENyTEZEZVpYdXJ2SHh0VjBMYjAvVlRCQnJH?=
 =?utf-8?B?V3g4ZTRVNndmaHF2Vy8xVDM1MXRyQjlON0ptM1JweDY0MWhJVmZNM1lqN2I3?=
 =?utf-8?B?OGxQcHlUdk5qZnFtZzJGbHAvaUJESmF5NHo1SktwLzV6SG0yb1AvVTkxM2d3?=
 =?utf-8?B?ajloL1VSUnA3NTk1Y0FGMGQ1UVgxWU9lNkRpdlc3aVhoTlFxdTVlOUkrLzEx?=
 =?utf-8?B?SVlodHBoeldIWHZMdTZDR09mWkZUZXF4WWZHNlZMNFBvQWxlN1VCSUI1NUt6?=
 =?utf-8?B?N3N4VTZma2g5b0p3REphQWdMYXpHVGhXT3dlVzh2SCtJcXd6VU9RNk1HT1pC?=
 =?utf-8?B?eW1FV05QbjgyUWJ5Qmd6SEJPTnF6eXlsOFdWSFhqelhwWXE2UnZFMXFFbWI5?=
 =?utf-8?B?VDNaSEtlaVVOUitFdHh3bjBvejRNOUtuVWxaZ1dJWGQ4L2RxMUlNQWNjWlhH?=
 =?utf-8?B?RVRYaTErWjg2UnNEdjMwODVtK1FyZ3B6QVFpZU1zbE1WTHlsUldLeitQbmgy?=
 =?utf-8?B?bTBBNysvNkFXRUxaYlVvazlLQ3p6aUc0QlBkWVBvVm1CTFV6ekVmNjVCK3lk?=
 =?utf-8?B?RGxQUFAzZ21yZi9pNVBGSHF1dDdYVXZuYkttUWpGbWFOUVIrWVRlbVgzakFC?=
 =?utf-8?B?MGs3VVlVNmx6OHRkOXZ0TDRiK3ZpYkF6RTE0emlPeEVERmV4ZWJuMnVOZGRi?=
 =?utf-8?B?NmVSM1RMWWJqNzZsQWlQcGpjZTVsK296WmZ6TC9hRVRRVkdZZkg0K0VZYk9E?=
 =?utf-8?B?Vi95cXhqaTN5UWpJQ3MyMk80dUxoTTc3alozR0QrSHdUdURFZUNFTFl3NDN0?=
 =?utf-8?B?SFA2Z3Y3Wml5Qk0zTmxBaTRyN2U4aTdjM2lyZzVyTXo5R29EM1VrV0xiWnJY?=
 =?utf-8?B?eTBrMkZaNmRKbnRFTURzWXd2Qm51ckZ5OFhqZHNyY0NMVmZ1emMzUTFJaXE2?=
 =?utf-8?B?NFgzSmloSFRrMzFiOWcwV0w1cTdRQXhmcGFjTHlsNzRmdHhUS2NaK1JmOUJy?=
 =?utf-8?B?dzdKbWFHWkNLV3ZhL3l2VjIreGxwdnhxU1lmRTcxWDhoRVNycUpldTI1NUVI?=
 =?utf-8?B?SUc4dmhYQW5USFVCVWgwWmZlU084NTA3eUI2bGIvZjNNVmd6YjBXTS93Ukw0?=
 =?utf-8?B?aGh5Y0k5eHAwNlB3b0FoOXpaeW9xcXhqYkYvcXhqcHFnQ2YzMXFReFZsaUU1?=
 =?utf-8?B?UXdlcWwwQ1FOUGtoWmhHODkzdWlSMDBvL2UxcVRYTjd6cnZzVjZZWXMxNTR0?=
 =?utf-8?B?YWNlWnVqUkNhL09KMHUyUGpHUExzdXRVSFRoSmdWakhaaFphaTdwL2JSaG9T?=
 =?utf-8?B?OSt1VzQwZEc2NzNZSzJwdzY5Sm5rSlBmcVdoZHpXOWFpdXNCL0w2QmlDMHJl?=
 =?utf-8?B?WStJOGh1RlUxeW8rdklkWHBSeGxsdGhUTUpwdXdDN3dVRFpYQzRqdzNtbHkw?=
 =?utf-8?B?Y0xuMFlxK1hTZk9ZL2cyNzlsdStwTDVEbXUvTXpmRUlxTVJTeDRjdVRxL3Vj?=
 =?utf-8?B?Nm1ZNVdLT3J2dzN0MENZaW1Db2pIMDB6VVUveXpCNWFiK3NUWVhOcnp5dHV6?=
 =?utf-8?B?aVUrM3AyV2dLOXowb3lpRG52SGltVWJUdDJrWnhNbkZlck9Semh4UFRuRTA5?=
 =?utf-8?B?T0FYRmxmbjRmRmhWQWdnYURRWGFvT2N5ektXd2tHSG1GYXRzMjZsMWNzM2Jx?=
 =?utf-8?B?Qi9TbXhZM09uR3U1ZmNUcEVFQWpLOGZFaEdHOUdUT0JpeFkxUVNLemZ1WUFo?=
 =?utf-8?B?YXBkaUhDbENBMEdYWEx2cEZlUkNjMkNndmdpL3QvV0JDNDY1a1BVVnZOMldL?=
 =?utf-8?B?U2pTdVVJa3RySXc1bW9GQTkvSFV5U29ReEN1Y29keXI4KzRNY2JqSTd5RU5j?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <478C6E31DF41DC438001313442C199A5@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1414b3-1f1c-4080-a27e-08dcc894e351
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 01:41:37.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OR8ID5doOCyEVtwrK1iFnTu+m+KFzrxkbQFjb8FMDCBoZA4nBKa0vuTsR2jdg7N7bHi60NIH0a4VHlxN2QpReA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4528

T24gVGh1LCAyMDI0LTA4LTI5IGF0IDE4OjMyIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDU6MzPigK9QTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjQtMDgt
MjkgYXQgMTc6MTkgLTA3MDAsIFJpY2sgTWFja2xlbSB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4g
DQo+ID4gPiBJIGhhdmUgYSByYXRoZXIgY3J1ZGUgcGF0Y2ggdGhhdCBkb2VzIHRoZSBQT1NJWCBk
cmFmdCBBQ0wNCj4gPiA+IGF0dHJpYnV0ZXMNCj4gPiA+IHRoYXQgbXkgZHJhZnQgaXMgc3VnZ2Vz
dGluZyBmb3IgTkZTdjQuMiBmb3IgdGhlIExpbnV4IGNsaWVudC4NCj4gPiA+IC0gSXQgaXMgd29y
a2luZyBvayBmb3Igc21hbGwgQUNMcywgYnV0Li4uDQo+ID4gPiANCj4gPiA+IFRoZSBoYXNzbGUg
aXMgdGhhdCB0aGUgb24tdGhlLXdpcmUgQUNFcyBoYXZlIGEgIndobyIgZmllbGQgdGhhdA0KPiA+
ID4gY2FuDQo+ID4gPiBiZSB1cCB0byAxMjhieXRlcyAoSURNQVBfTkFNRVNaKS4NCj4gPiA+IA0K
PiA+ID4gSSB0aGluayBJIGhhdmUgZmlndXJlZCBvdXQgdGhlIFNFVEFUVFIgc2lkZSwgd2hpY2gg
aXNuJ3QgdG9vIGJhZA0KPiA+ID4gYmVjYXVzZQ0KPiA+ID4gaXQga25vd3MgaG93IG1hbnkgQUNF
cy4gKEl0IGRvZXMgcm91Z2hseSB3aGF0IHRoZSBORlN2MyBORlNBQ0wNCj4gPiA+IGNvZGUNCj4g
PiA+IGRpZCwgd2hpY2ggaXMgYWxsb2NhdGUgc29tZSBwYWdlcyBmb3IgdGhlIGxhcmdlIG9uZXMu
KQ0KPiA+ID4gDQo+ID4gPiBIb3dldmVyLCB0aGUgZ2V0ZmFjbCBzaWRlIGRvZXNuJ3Qga25vdyBo
b3cgYnVnIHRoZSBBQ0wgd2lsbCBiZSBpbg0KPiA+ID4gdGhlIHJlcGx5LiBUaGUgTkZTQUNMIGNv
ZGUgYWxsb2NhdGVzIHBhZ2VzICg3IG9mIHRoZW0pIHRvIGhhbmRsZQ0KPiA+ID4gdGhlDQo+ID4g
PiBsYXJnZXN0IHBvc3NpYmxlIEFDTC4gVW5mb3J0dW5hdGVseSwgZm9yIHRoZXNlIE5GU3Y0IGF0
dHJpYnV0ZXMsDQo+ID4gPiB0aGV5DQo+ID4gPiBjb3VsZCBiZSByb3VnaGx5IDE0MEtieXRlcyAo
MTQwYnl0ZXMgYXNzdW1pbmcgdGhlIGxhcmdlc3QgIndobyINCj4gPiA+IHRpbWVzDQo+ID4gPiAx
MDI0IEFDRXMpLg0KPiA+ID4gLS0+IEFueW9uZSBoYXZlIGEgYmV0dGVyIHN1Z2dlc3Rpb24gdGhh
biBqdXN0IGFsbG9jYXRpbmcgMzVwYWdlcw0KPiA+ID4gZWFjaA0KPiA+ID4gdGltZQ0KPiA+ID4g
wqDCoMKgICh3aGVuIDk5Ljk5JSBvZiB0aGVtIHdpbGwgZml0IGluIGEgZnJhY3Rpb24gb2YgYSBw
YWdlKT8NCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciBhbnkgc3VnZ2VzdGlvbnMsIHJpY2sNCj4g
PiA+IA0KPiA+IA0KPiA+IFNlZSB0aGUgTkZTdjMgcG9zaXggYWNsIGNsaWVudCBjb2RlLg0KPiA+
IA0KPiA+IEl0IGFsbG9jYXRlcyB0aGUgJ3BhZ2VzW10nIGFycmF5IG9mIHBvaW50ZXJzIHRvIHRo
ZSBwYWdlIGJ1ZmZlcnMgdG8NCj4gPiBiZQ0KPiA+IG9mIGxlbmd0aCBORlNBQ0xfTUFYUEFHRVMs
IGJ1dCBvbmx5IGFsbG9jYXRlcyB0aGUgZmlyc3QgZW50cnksIGFuZA0KPiA+IGxlYXZlcyB0aGUg
cmVzdCBOVUxMLg0KPiA+IFRoZW4gaW4gdGhlIFhEUiBlbmNvZGVyICJuZnMzX3hkcl9lbmNfZ2V0
YWNsM2FyZ3MoKSIgd2hlcmUgaXQNCj4gPiBkZWNsYXJlcw0KPiA+IHRoZSBsZW5ndGggb2YgdGhh
dCBhcnJheSwgaXQgc2V0cyB0aGUgZmxhZyBYRFJCVUZfU1BBUlNFX1BBR0VTIG9uDQo+ID4gdGhl
DQo+ID4gcmVwbHkgYnVmZmVyLg0KPiA+IA0KPiA+IFRoYXQgdGVsbHMgdGhlIFJQQyBsYXllciB0
aGF0IGlmIHRoZSBpbmNvbWluZyBSUEMgcmVwbHkgbmVlZHMgdG8NCj4gPiBmaWxsDQo+ID4gaW4g
bW9yZSBkYXRhIHRoYW4gd2lsbCBmaXQgaW50byB0aGF0IHNpbmdsZSBwYWdlLCB0aGVuIGl0IHNo
b3VsZA0KPiA+IGFsbG9jYXRlIGV4dHJhIHBhZ2VzIGFuZCBhZGQgdGhlbSB0byB0aGUgJ3BhZ2Vz
JyBhcnJheS4NCj4gT2gsIG9rIHRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KPiBJdCBkb2Vz
bid0IHNvdW5kIGxpa2UgYSBwcm9ibGVtIHRoZW4uDQo+IA0KPiBJJ2xsIGp1c3QgY29kZSB0aGlu
Z3MgdGhlIHNhbWUgd2F5Lg0KPiANCj4gTWF5YmUgSSBjYW4gYXNrIG9uZSBtb3JlIHF1ZXN0aW9u
Pz8NCj4gVGhlcmUgYXJlIGEgbGFyZ2UgIyBvZiBYWFhfZGVjb2RlX1hYWCBmdW5jdGlvbnMuIEFy
ZSB0aGVyZSBhbnkgdGhhdA0KPiBzaG91bGQvc2hvdWxkIG5vdCBiZSB1c2VkIGZvciB0aGUgYWJv
dmUgY2FzZT8NCj4gRm9yIGV4YW1wbGUsIHRoZXJlIGFyZToNCj4gLSBPbmVzIHRoYXQgdGFrZSBh
ICJzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyIiAodXN1YWxseSB3aXRoIF9zdHJlYW1fIGluDQo+IHRo
ZSBuYW1lKQ0KPiB2cw0KPiAtIE9uZXMgdGhhdCB0YWtlIGEgInN0cnVjdCB4ZHJfYnVmICpidWYi
IGFyZ3VtZW50Lg0KPiDCoCAoSSBlbmRlZCB1cCB1c2luZyB0aGVzZSBmb3IgdGhlIGVuY29kZSBz
aWRlIGFuZCB0aGlzIGxvb2tzIGxpa2UNCj4gd2hhdA0KPiDCoMKgIG5mc2FjbF9kZWNvZGUoKSB1
c2VzLCBhcyB3ZWxsLikNCj4gDQo+IChJJ2xsIGFkbWl0IEkgaGF2ZSBiZWVuIHdhZGluZyBhcm91
bmQgaW4gdGhlIGNvZGUsIGJ1dCBoYXZlbid0IHJlYWxseQ0KPiBnb3R0ZW4gdG8gdGhlIHBvaW50
IG9mIHVuZGVyc3RhbmRpbmcgd2hpY2ggb25lcyBzaG91bGQgYmUgdXNlZC4pDQo+IA0KDQpUaGUg
InN0cnVjdCB4ZHJfc3RyZWFtJyBiYXNlZCBjb2RlIGlzIHRoZSAnbmV3ZXInIHdheSBvZiBkb2lu
ZyB0aGluZ3MsDQphbmQgYWxsb3dzIHlvdSB0byB3cml0ZSBjb2RlIHRoYXQgYWJzdHJhY3RzIGF3
YXkgc29tZSBvZiB0aGUgdWdsaW5lc3MNCmluIHRoZSBSUEMgbGF5ZXIsIHBhcnRpY3VsYXJseSB3
aGVuIHlvdSBuZWVkIHRvIG1peCByZWd1bGFyIGJ1ZmZlcnMgYW5kDQpwYWdlIGRhdGEuDQpUaGF0
IHNhaWQsIHRoZXJlIGlzIGRlZmluaXRlbHkgbGVnYWN5IGNvZGUgb3V0IHRoZXJlIHRoYXQgd29y
a3MgcXVpdGUNCndlbGwgYW5kIGlzIG5vdCB3b3J0aCBhIGxvdCBvZiBlZmZvcnQgdG8gY29udmVy
dC4NCg0KSSdkIHJlY29tbWVuZCB0cnlpbmcgdG8gdXNlIHRoZSB4ZHJfc3RyZWFtIGlmIHBvc3Np
YmxlLCBqdXN0IGJlY2F1c2Ugb2YNCnRoZSBiZXR0ZXIgYWJzdHJhY3Rpb24sIGJ1dCBpZiB5b3Ug
aGF2ZSB0byBmYWxsIGJhY2sgdG8gbWFuaXB1bGF0aW5nDQp0aGUgeGRyX2J1ZiBkaXJlY3RseSwg
dGhlbiB0aGF0IEFQSSBpcyB0aGVyZSwgYW5kIGlzIHN0aWxsIHN1cHBvcnRlZC4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

