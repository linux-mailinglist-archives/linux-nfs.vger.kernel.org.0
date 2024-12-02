Return-Path: <linux-nfs+bounces-8302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD159E0849
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB9178F21
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452E146588;
	Mon,  2 Dec 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OVwx0/lW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EtRnqIiL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1515C156;
	Mon,  2 Dec 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155560; cv=fail; b=STlITwTKMDQcfeWHUBPW2fw9MUkRpIbbNdRmYXaS2wm9c+mwhdowx2rgiB9ZCHZabKm9V6c33ycAadkdoBpSiAuibfig/VFRZ9fvKUl7lpDzvf8+9fV6Hvk3CkLILoNSxnGVlj+i2mWTW5PcCOa/QDo6p2EzptotLeY/yNrCNoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155560; c=relaxed/simple;
	bh=RWCcs62FBNJ9RrPYlUhz3g6duvPeS0xdC/C+DhzEuCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQGQaGFlkOhxsWaIcnoVT6iH5aC7pSVtthRQHYe1GYxootZ7/OOQz/0lEWmxOFvJpeaurE6AsQgQ7+uhzui5AEXos3/LeAHWkd3RysBZ+C2UBRhy8M7G6LDUxLMvS2YbgdNlJvuXWYXYM6GFhonudtn7cr7qSfke0tSSBcz5yts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OVwx0/lW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EtRnqIiL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DPOHf012852;
	Mon, 2 Dec 2024 16:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RWCcs62FBNJ9RrPYlUhz3g6duvPeS0xdC/C+DhzEuCU=; b=
	OVwx0/lWkBTFmcfVJ/RhVnRtA0cPiGu8EXb+M3PLYI+PEJFY9vaoiy0NA9GPqiEI
	2wgwyDqIOj/Xzy8wFLNfhefCQU7VEmPMwBE8EQ9rVc7GFbImH73NRl8XGaCwclCA
	D6Vo+mm75aSbpOQ7tNjmLBYblRVNHr81XAm0aeyw6VtjeIPXCVsZzwkNfZWfZBwy
	do4EiLE81LzU9zCjThCun6eTuPb7/RUv1NT+/x1jggu/YrBTN/S0kd/QTMbGR7g8
	AgKPfNAlrYt2IagE84RuwTmUg7PT4BxmEGfVDNmhMDF+IWaMyJGehBUJRRSjDVpG
	7oFPt66GoCuB9Yvrvh1PNw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c3v9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 16:05:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2F1BhJ000875;
	Mon, 2 Dec 2024 16:05:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s56rumw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 16:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5qxZ4QoFPlokaDmsg0mrmtqPCVlqTr9uxAFNgxnH2Wrd2b1sFqvgHzk/ElifPj2HvDzG5Rzfypv+pYyVeKmQVZO5exPnrnkzBhVi1fnDo020vyRG2djSodszoAuNk45CGSBM987WH+s8jQMLb2xGdt/tIxjZ5pQ1L6TSYLSisw7zPlRDQ2m+QcmXqCkOCtM+asZZ2f8YY2vFbmdFBUcNOnXZn8ijX99clb9KveC9yI/GVsxfKW028GKZghgpLcVQk1lfh0vqtx6uyvFbE9kotd7STPUKfANJX4mUNfkjMOrmwOB5ULjLjJP+t+UzJ35ee5Yz/2ZXkNOyKYhh7ItFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWCcs62FBNJ9RrPYlUhz3g6duvPeS0xdC/C+DhzEuCU=;
 b=UOOavdrg2bD9YsuIfyiE+/ySTQAIs/4+0MktDVmXglBHtxSta/mZk0NzM98fz2mm+W6Y4QXlsfaJa1nqYW9sfkqROg8bN5x57tcHAAj6A/Xe6nAmu89ziMgFlAh6xt1pp7cwnkU4wC0xI7tl7SPSHNl/Q4SV84MMyZ/H40IDAiPTz0JnyRl673LstJTC+4zp8Cnm+tqd3I/TrI0Qtt5OTRmRWftoXfGOw8nhQibNL1u/AP7UmDLrF9l/cR94mcNGDpjfKlHlt2vZZq6AmZaDyrVK2TGRCwpun2Mj1T4RHNSJWBUpIf+z/HL6e02pf5PbQ8SxeHxQF1jRS39+Rta5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWCcs62FBNJ9RrPYlUhz3g6duvPeS0xdC/C+DhzEuCU=;
 b=EtRnqIiLxKc2eGX93hQOWyHI9GI23KyJz1yLEC77rZN6LuunorK1cp3kQe13XbAnbaCGeF8hucdXxamFIEdfrUBT/ojRLRUQzX2iqYo8QFYy8FjFB0EhTyBye13hHgUCRBqVTAket10BZCm6Lgov28kUaLsU5G/tSn+byPZUGgA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8104.namprd10.prod.outlook.com (2603:10b6:8:1f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 16:05:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 16:05:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Tom Talpey
	<tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, Hou Tao
	<houtao1@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun
	<yangerkun@huawei.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        Li Lingfeng <lilingfeng@huaweicloud.com>
Subject: Re: [bug report] deploying both NFS client and server on the same
 machine triggle hungtask
Thread-Topic: [bug report] deploying both NFS client and server on the same
 machine triggle hungtask
Thread-Index: AQHbPyubgFqDSL8UhkefweGr4NOPrbLMThsAgAbbdoA=
Date: Mon, 2 Dec 2024 16:05:18 +0000
Message-ID: <D4E120A4-D877-48CC-AE40-D55DBB6265D0@oracle.com>
References: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
 <8b155d3c-62b4-4f16-ab00-e3d030148d29@huawei.com>
In-Reply-To: <8b155d3c-62b4-4f16-ab00-e3d030148d29@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB8104:EE_
x-ms-office365-filtering-correlation-id: 5e9a5e99-a969-4d7f-ba07-08dd12eb1dfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y282SStkTW1WWHdCQVdMa0w4eWp3RXVpNVZVQWFWMlpCZ25SRkUxcGYzc2U3?=
 =?utf-8?B?WmFPL2kvM3cxOFRoa09HNFZqTTZGbFBmb0VYSEtHM201QXBpVWZvTk52aUNw?=
 =?utf-8?B?VjlrSk8zQTg4bUZ5a2s0eEtrazBrT1lPN05rNmJWYTZUa0ZBV2g3cnhjd0xP?=
 =?utf-8?B?cGI2SksxOE55ODJhRUZpamNoeUJ5ckR2aGJlcklPLzZqOC9wejV2VUtTV3Z6?=
 =?utf-8?B?Q1FucGRoc0E5ZnlaRnZmNW1LOXRxeng3WlQvU2twRUNTUVRtYzY5VERBQUpD?=
 =?utf-8?B?ajNKUTdHdllqbjkwZE0rTkdZcHpqY3VmMFg0VVNUMkt6cVhrZzZRdEZyN1VE?=
 =?utf-8?B?M0FtZjFkRVB0TWVDc2NOV2pqTVl1VzVkaEdvdGpFbEl0Ri9XZVk3MHJTZTdR?=
 =?utf-8?B?RGI5Mm9sZVpIQi85bGpBS1hmemZ3MzRFYTBTRW5NNGRPTGZxZHpmRHJTNUJu?=
 =?utf-8?B?RXlvTFpFSG8yZlIyTlZLdWp1cEIrZmQ0NUpiTFhOekYrTjFqMElJeE0yN0N4?=
 =?utf-8?B?ZzBhWENkNkVSUlowVExUbkorT1RyR1E0ZjB5YnRDWkpWVTZrMEIwQWtSZGZL?=
 =?utf-8?B?cVhkOUx2Q3pmUk9IUldNNHhrUjFSdzU0ei84QmFXWW93eXlrOFdYaWlPbzhJ?=
 =?utf-8?B?WHJ4eFdzcStvRjVtSjlWSDE2OEt1eHVLUEU0K3JWS2h2YnNwemhUZzJRQUJS?=
 =?utf-8?B?MlhZUWtEUW9LVGc4QndRdFJlQUJCNExFVWd6T2JWNlVOZ2p4NlJHRnpLdWJ0?=
 =?utf-8?B?bUJjc2pNSWFrT3FJTnlIMTlZSmN5aTNCRUJrbVNMb1VMbGgxaWFscVkwK1Zq?=
 =?utf-8?B?UEdBczVveXRPaDhJTW50a1R3Q29wNFoyMEdFNUZ2YVBkcEFpMmhmMHA1a1B1?=
 =?utf-8?B?dklTZXlsYTdWTW9iWnEyNEdyUEVmbndSNkd1T245Rjh4TEQxZ0VzN2dzNUNE?=
 =?utf-8?B?cjZ0ZGgrb0pWM0VIUEFYLzRvWVplbHVvQVlUWmRSVktSK1BwMVJOOFNJc3I5?=
 =?utf-8?B?M0tEbGVucDRTNG5aQXlkVElYK2IyOHk0Wi96bGR2VEZRa1BwcVdLSmNzZU9w?=
 =?utf-8?B?UDdDUTd5bVVFT1MwaXo3TWV5M2t5RW0wV3Yrdy9mNS9OU3UxbGZuVzFWOVd2?=
 =?utf-8?B?eVA2RUVwcFk1Q2JpdmtXTmlLdWRZZFVMS0lNWS9ldHlKQUxGZ09oRHd1VWR0?=
 =?utf-8?B?K3pzYi9KZWJnUUlEb08wZi9Ra0MxWFpCbG0rUUozTWdxVzdONzYzaGF4SjdH?=
 =?utf-8?B?cm5valJ2S3RjWGowaGFCWC9SbmU5MHpON0FVR1N0WUVCa1pPS0RqZmJwU0to?=
 =?utf-8?B?RmFnMTgzd25GQmpCbnFNOExLZmxmbHVEbnNaZXNEOFNtZWpWNEkwVkVtcC9t?=
 =?utf-8?B?MlNua3gwb0FvTjMwZEpJcVFFcnkyMXVWN2U2eUMyRU9FajNraTBRaC9VRWVs?=
 =?utf-8?B?ZzNpWlhoVkFPemZaMkhZUjRocGxPLzgvdmRQSml6WktQUkV1V1BvZTBBbkJ2?=
 =?utf-8?B?SVBnU2s5eUl6N1dBV3A3bFZVcDBaK3ExTE9tR2o2Q0lKM2tsbFFNQXpJOFg4?=
 =?utf-8?B?R043WEpRNDdiOHg4c0NSblhFQ1NiejRzdzVwWW16ekRKSXIrdEluaEpIMzlk?=
 =?utf-8?B?MEN0aW9CK3lvc29HOTlxZVplVUVWM1ZQLzZ0ZVlqSUxvQjlNdDZDYmJScCs3?=
 =?utf-8?B?VjFlWmpwNGtzT1hDcWpsenhJUWdkYTl3d2s1eGRleW1QMDQwdkVjRXF2REFU?=
 =?utf-8?B?Ky94Y1lRZjUzeXJockdYa2lmcytXN0hkRnF6SjVSUUJJYnU0WmxqUEhKZWx3?=
 =?utf-8?Q?2ioPp5rnZ2Qa5U6UKQy18RO9oTVb/CbJWGTqk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDRuVm1IOVFuQnVaR1FHSE5tRXFJZmR4NzJTOEJ5TGp4RFp2cktzSXIrcEZp?=
 =?utf-8?B?YlRSbWp5M3E4TlVGSDRwY0ozMDlzL0ZwdVN3bHoyL0ZJUnZaMUlKK3VuUHJO?=
 =?utf-8?B?OGlnT2NpV0xmakczR1BnYUJiUXFIWlFlQnlwb2o0UUZMSDQrNjR3eWFUcEYz?=
 =?utf-8?B?Z2VoTkNRV3lmaUpnRnNNamZ0LzRydm12Qm9aN25IMHZmeTl0L3pRbEQxMVc1?=
 =?utf-8?B?NExrR2U5NEp6WEphWW10aXN0MU5TdG1Nd2lYSEkvdHBIaG0zbVBDV3pBMFBD?=
 =?utf-8?B?c1hjck9MelNWa3ltRmxDZllCcHJHSTM3Z2lUVGE5Z1pKcSswTlJkNTdXYm5v?=
 =?utf-8?B?OHNJSWtrNFRaNXJoYWgzOHNMU2Nxak0yNk5DS2xJalpnTUV1clNmWEwyNEZ3?=
 =?utf-8?B?L05DOVNGNUtRZjgzRkM3dTRPV1pCSG02QWJYTFlhdS95RlhBbUMzRzdFR0tB?=
 =?utf-8?B?cXVjTEdFNFNEODhxRzhCQjJiSElIaXZuK2xsQ3lzTHJnTFovZVNtcVlLTURO?=
 =?utf-8?B?T1Jmd29UU1cyZ2NNSFEvQll2MXBaR2VZQTVYVTk5UllVQVN0N0thNnlzSnhu?=
 =?utf-8?B?SUNJSDMxK0hiUk1IWDNrSThaaXFkNWlyQk1WS24ycnAzR3gvY0JDOGNZaHN4?=
 =?utf-8?B?R05NK1BicitGWHJmMDkzcTJHRWtmZUtIVjhpMUZsY2N4MGEyalVjWk9XeTYw?=
 =?utf-8?B?S2VORHBrK2lJN3RpNElpejdGaUlITTk2aHhwdjFHdFRRZHhyTmtEbWlpdkNj?=
 =?utf-8?B?RGMrWkllM3poeTBCUXQ0VGtLWVdnL0RpVmRDaVVYUGNpeDU4dzQwRlgvbnNk?=
 =?utf-8?B?YVhUM0x4dUY1Z3NLVWxJd2d1V0ExOGMzWi9RaFh0dlZNM29NeW1WNk42dk1C?=
 =?utf-8?B?cjIrM1NXN3o5ekFIaW5wb0F2eUk0SnZMU2xRaGRMRVpoR1ZNa05wNHZEQnBy?=
 =?utf-8?B?blZBZTVDQ3UxN2wyRWkyVzdRUUFRQ0RzSzYrV21SRjgvYTVpc3VDWHdia0Vr?=
 =?utf-8?B?a1NCQXRXRGtXZWRLS3FoMjUxUDJGZnE3MXdZM0UxY1N1bzlIMmQ2Y256Z1Vk?=
 =?utf-8?B?T2dZbHF4eGNDa1NaUG5BUmJWRDV4TzRTanJ3OXNLZnpleVZoWGV6MGgza1cz?=
 =?utf-8?B?Q09zR1dRR29rREpsY1JrM205R2tkaXhMb3NUNEVJVzhGSUZ5b3VYM2xMMjNX?=
 =?utf-8?B?QmhNOHpydXo2cm01VGdSK3FpNFdmY0x0WjRCTzlPWStqZWRTS3AxcW5EVE5C?=
 =?utf-8?B?NzlPY2JvNHk4UEp5bEErSmZ2cmhrY0lzSzRjK1Z3bVNhSG5CKytSeHRlQjRF?=
 =?utf-8?B?N05xUWdNOTNxdUNzaFF4eHdVdGZ2MjF2aGNPK2EwcnJ0dHZXRG5lMFZOUFNw?=
 =?utf-8?B?c3FuMVIrb3k3MFhyZ2ZvL3BhNzkxc3BKNmpYUVBoWG5kck04bG9vTmU2K2dz?=
 =?utf-8?B?NFU4ait1dDR6RC9yR0NzUUFkZEhiVmxXczdMWlV0bmxIa3pCNG9DdFowSWt4?=
 =?utf-8?B?SENPUXBKSDhaK3BCYmw1TXpKZjJQOXdqMGRtUkNiODZPbEpTUGt5cmV1WlFu?=
 =?utf-8?B?QWljOHpkN1VCRmhJNlpGa3pCaE8rWmJrT1pLNlJZcUpkdkpPbzg0dXl5dHJN?=
 =?utf-8?B?RHV5Si9pU1V0T21UUTlBQjh0Vi9ybHVVQ1NQVjk2YUF1MmNFellpZ1N2WjJR?=
 =?utf-8?B?Rm9FQ2ZiWDdoYzViRkRiM1dnSlpYcVVBZitxellqWnZIdlh0Qlk0WXlCNjVE?=
 =?utf-8?B?NHJ5ZktLZURYNjUzT2lwKzlVUFZIRjN2bFk5Vk9wNnVYaUtUS2Iwc1ZjOUc2?=
 =?utf-8?B?cVdjOVpuaGR5RXNGb202SmpwQlVmWlZqTDJyT3h6bDcxRXNKcm96SU9ydnJX?=
 =?utf-8?B?UkpxcGxUbzlVdVMzNlNJSDJ2MlVUZTFzLzloRU44ckdmYzh1dkoyZ0pOOFUr?=
 =?utf-8?B?akZIRFVCelBDR1IrRXJCZXZKakgvdjhJMVRrSW1rSSttQzdSUFN2ci9sUjll?=
 =?utf-8?B?TXpKMCtCTHN4U2Zoc3E1NnlWdkVXSUxqL3hsN0puaW14Tlh2MG5JendKUWxI?=
 =?utf-8?B?aHMvNGQ0OTlSRjBwK2toRjBQSUlMWFdSVjI2OFhLUDdMUUdTNWF1UmpqRmJp?=
 =?utf-8?B?Uk14bTdza2ZxUUZ3d0p2MnF5MnZDTUNoNGpnRER0eVRkc3o1ZnpBb01XNWV6?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21537BAA9116824DAB27551A31F0A78B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a/i2jmf0+ioCpjePyNUK3HQxW6B+TiWA3E/E5qn28Iwqko7geKBhnT76bpwnWLTPMFUBWNrUB+rj3JunRXJfxiT9cNBTR7muoWzqZyd77aJleakkaHsDLmZlQvi10gqV/HTsVEg2O2f45lj4ftjWcBJoCjmDkt97YyzBLEvYwc915Ko0C8fIDCDRXZRODuajSwcuDD24oMwtV9iEMooGZFp605VT0802WeO3cdEK9TT5m8GXsbEbmo9t2pJvGJrH99kTOk5SxEBg16HTRUN3N4f3kczvdOsYiiZe+xx7mrqYdgXLLhkZIRhoSYplUiy/jaLA8lkBR/SogxRHOz/GwC46sxgJQYEVfsp47/XCLO7Hp+O98S+ARErWimsw4Bcc+o1lK7jXDHXTMTXiD/TXoQA5Ej6tK9/XGwdmXp64rpDk0CsF3dyYE3XX/86U0Wfv/nai3avQSAJZGCGM9iiacpXlrY9HbddMOavTNgncZ6WUhMoP3auXcYHLwh4sCem7QVDuw5BHyCSUg245OAm1LhV3IUwyD9iU8MFOIALVjLB29f17XzB+eUhQwwSKUTDOpbVS3YrM9uBfDjYdSwJ2v7FW+UKsaYtNAmItVpB0UTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9a5e99-a969-4d7f-ba07-08dd12eb1dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 16:05:18.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2W4OPjYIed9+R4hKuPRarEL5vtIL4fEZpMKEN4diuX/Fgwl6E7P6lrSAi6OERDx0cX6i0OyDxtshUl3sDh9vBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_11,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020137
X-Proofpoint-ORIG-GUID: vs3WXRZEQb6UVmbbpll219PnuCfJNFOD
X-Proofpoint-GUID: vs3WXRZEQb6UVmbbpll219PnuCfJNFOD

DQoNCj4gT24gTm92IDI4LCAyMDI0LCBhdCAyOjIy4oCvQU0sIExpIExpbmdmZW5nIDxsaWxpbmdm
ZW5nM0BodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IEJlc2lkZXMgbmZzZF9maWxlX3Nocmlua2Vy
LCB0aGUgbmZzZF9jbGllbnRfc2hyaW5rZXIgYWRkZWQgYnkgY29tbWl0DQo+IDc3NDZiMzJmNDY3
YiAoIk5GU0Q6IGFkZCBzaHJpbmtlciB0byByZWFwIGNvdXJ0ZXN5IGNsaWVudHMgb24gbG93IG1l
bW9yeQ0KPiBjb25kaXRpb24iKSBpbiAyMDIyIGFuZCB0aGUgbmZzZF9yZXBseV9jYWNoZV9zaHJp
bmtlciBhZGRlZCBieSBjb21taXQNCj4gM2JhNzU4MzBjZTE3ICgibmZzZDQ6IGRyYyBjb250YWlu
ZXJpemF0aW9uIikgaW4gMjAxOSBtYXkgYWxzbyB0cmlnZ2VyIHN1Y2gNCj4gYW4gaXNzdWUuDQo+
IFdhcyB0aGlzIHNjZW5hcmlvIG5vdCBjb25zaWRlcmVkIHdoZW4gZGVzaWduaW5nIHRoZSBzaHJp
bmtlcnMgZm9yIE5GU0QsIG9yDQo+IHdhcyBpdCBkZWVtZWQgdW5yZWFzb25hYmxlIGFuZCBub3Qg
d29ydGggY29uc2lkZXJpbmc/DQoNCkknbSBzcGVjdWxhdGluZywgYnV0IGl0IGlzIHBvc3NpYmxl
IHRoYXQgdGhlIGlzc3VlIHdhcw0KaW50cm9kdWNlZCBieSBhbm90aGVyIHBhdGNoIGluIGFuIGFy
ZWEgcmVsYXRlZCB0byB0aGUNCnJ3c2VtLiBTZWVtcyBsaWtlIHRoZXJlIGlzIGEgdGVzdGluZyBn
YXAgaW4gdGhpcyBhcmVhLg0KDQpDYW4geW91IGZpbGUgYSBidWd6aWxsYSByZXBvcnQgb24gYnVn
emlsbGEua2VybmVsLm9yZyA8aHR0cDovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvPg0KdW5kZXIgRmls
ZXN5c3RlbXMvTkZTRCA/DQoNCg0KPiDlnKggMjAyNC8xMS8yNSAxOToxNywgTGkgTGluZ2Zlbmcg
5YaZ6YGTOg0KPj4gSGksIHdlIGhhdmUgZm91bmQgYSBodW5ndGFzayBpc3N1ZSByZWNlbnRseS4N
Cj4+IA0KPj4gQ29tbWl0IDc3NDZiMzJmNDY3YiAoIk5GU0Q6IGFkZCBzaHJpbmtlciB0byByZWFw
IGNvdXJ0ZXN5IGNsaWVudHMgb24gbG93DQo+PiBtZW1vcnkgY29uZGl0aW9uIikgYWRkcyBhIHNo
cmlua2VyIHRvIE5GU0QsIHdoaWNoIGNhdXNlcyBORlNEIHRvIHRyeSB0bw0KPj4gb2J0YWluIHNo
cmlua2VyX3J3c2VtIHdoZW4gc3RhcnRpbmcgYW5kIHN0b3BwaW5nIHNlcnZpY2VzLg0KPj4gDQo+
PiBEZXBsb3lpbmcgYm90aCBORlMgY2xpZW50IGFuZCBzZXJ2ZXIgb24gdGhlIHNhbWUgbWFjaGlu
ZSBtYXkgbGVhZCB0byB0aGUNCj4+IGZvbGxvd2luZyBpc3N1ZSwgc2luY2UgdGhleSB3aWxsIHNo
YXJlIHRoZSBnbG9iYWwgc2hyaW5rZXJfcndzZW0uDQo+PiANCj4+ICAgICBuZnNkICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5mcw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRy
b3BfY2FjaGUgLy8gaG9sZCBzaHJpbmtlcl9yd3NlbQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHdyaXRlIGJhY2ssIHdhaXQgZm9yIHJwY190YXNrIHRvIGV4aXQNCj4+IC8vIHN0b3Ag
bmZzZCB0aHJlYWRzDQo+PiBzdmNfc2V0X251bV90aHJlYWRzDQo+PiAvLyBjbGVhbiB1cCB4cHJ0
cw0KPj4gc3ZjX3hwcnRfZGVzdHJveV9hbGwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBycGNfY2hlY2tfdGltZW91dA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBycGNf
Y2hlY2tfY29ubmVjdGVkDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIHdhaXQg
Zm9yIHRoZSBjb25uZWN0aW9uIHRvIGJlIGRpc2Nvbm5lY3RlZA0KPj4gdW5yZWdpc3Rlcl9zaHJp
bmtlcg0KPj4gLy8gd2FpdCBmb3Igc2hyaW5rZXJfcndzZW0NCj4+IA0KPj4gTm9ybWFsbHksIHRo
ZSBjbGllbnQncyBycGNfdGFzayB3aWxsIGV4aXQgYWZ0ZXIgdGhlIHNlcnZlcidzIG5mc2QgdGhy
ZWFkDQo+PiBoYXMgcHJvY2Vzc2VkIHRoZSByZXF1ZXN0Lg0KPj4gV2hlbiBhbGwgdGhlIHNlcnZl
cidzIG5mc2QgdGhyZWFkcyBleGl0LCB0aGUgY2xpZW504oCZcyBycGNfdGFzayBpcyBleHBlY3Rl
ZA0KPj4gdG8gZGV0ZWN0IHRoZSBuZXR3b3JrIGNvbm5lY3Rpb24gYmVpbmcgZGlzY29ubmVjdGVk
IGFuZCBleGl0Lg0KPj4gSG93ZXZlciwgYWx0aG91Z2ggdGhlIHNlcnZlciBoYXMgZXhlY3V0ZWQg
c3ZjX3hwcnRfZGVzdHJveV9hbGwgYmVmb3JlDQo+PiB3YWl0aW5nIGZvciBzaHJpbmtlcl9yd3Nl
bSwgdGhlIG5ldHdvcmsgY29ubmVjdGlvbiBpcyBub3QgYWN0dWFsbHkNCj4+IGRpc2Nvbm5lY3Rl
ZC4gSW5zdGVhZCwgdGhlIG9wZXJhdGlvbiB0byBjbG9zZSB0aGUgc29ja2V0IGlzIHNpbXBseSBh
ZGRlZA0KPj4gdG8gdGhlIHRhc2tfd29ya3MgcXVldWUuDQo+PiANCj4+IHN2Y194cHJ0X2Rlc3Ry
b3lfYWxsDQo+PiAgLi4uDQo+PiAgc3ZjX3NvY2tfZnJlZQ0KPj4gICBzb2NrZmRfcHV0DQo+PiAg
ICBmcHV0X21hbnkNCj4+ICAgICBpbml0X3Rhc2tfd29yayAvLyBfX19fZnB1dA0KPj4gICAgIHRh
c2tfd29ya19hZGQgLy8gYWRkIHRvIHRhc2stPnRhc2tfd29ya3MNCj4+IA0KPj4gVGhlIGFjdHVh
bCBkaXNjb25uZWN0aW9uIG9mIHRoZSBuZXR3b3JrIGNvbm5lY3Rpb24gd2lsbCBvbmx5IG9jY3Vy
IGFmdGVyDQo+PiB0aGUgY3VycmVudCBwcm9jZXNzIGZpbmlzaGVzLg0KPj4gZG9fZXhpdA0KPj4g
IGV4aXRfdGFza193b3JrDQo+PiAgIHRhc2tfd29ya19ydW4NCj4+ICAgLi4uDQo+PiAgICBfX19f
ZnB1dCAvLyBjbG9zZSBzb2NrDQo+PiANCj4+IEFsdGhvdWdoIGl0IGlzIG5vdCBhIGNvbW1vbiBw
cmFjdGljZSB0byBkZXBsb3kgTkZTIGNsaWVudCBhbmQgc2VydmVyIG9uDQo+PiB0aGUgc2FtZSBt
YWNoaW5lLCBJIHRoaW5rIHRoaXMgaXNzdWUgc3RpbGwgbmVlZHMgdG8gYmUgYWRkcmVzc2VkLA0K
Pj4gb3RoZXJ3aXNlIGl0IHdpbGwgY2F1c2UgYWxsIHByb2Nlc3NlcyB0cnlpbmcgdG8gYWNxdWly
ZSB0aGUgc2hyaW5rZXJfcndzZW0NCj4+IHRvIGhhbmcuDQo+PiANCj4+IEkgZG9uJ3QgaGF2ZSBh
bnkgaWRlYXMgeWV0IG9uIGhvdyB0byBzb2x2ZSB0aGlzIHByb2JsZW0sIGRvZXMgYW55b25lIGhh
dmUNCj4+IGFueSBzdWdnZXN0aW9ucz8NCj4+IA0KPj4gVGhhbmtzLg0KPj4gDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==

