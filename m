Return-Path: <linux-nfs+bounces-3101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855328B7A9C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74050B2285F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7CD770EF;
	Tue, 30 Apr 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="krcuq+5i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MZrtfbG/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A251527B9;
	Tue, 30 Apr 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488769; cv=fail; b=Fc11jvAf2mZqEQr6NSP315qZwn987ywjMkbY7XhwRtT64Dtufkt8/xnuU7erCDjE0ksIp/4azPrzk/3HDvrF4b3AO/R7XYx6HbQZMi2tuzPHXnUYGtlyF5W45yVTz0EZfIRe6T04vLvwIYb1/7Lacuy3KHjKShhYOpTVArv3SvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488769; c=relaxed/simple;
	bh=BhoiPDxeqxEL635p3gjmabD8XXl47p2z4PBMTp7ASPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oiIVDFyGinIk6c0RbpiLVh304iPQwjjswo+TPifEJhiLd8vwNWM+jh8vCKr8sEXLfRZM6BoP3vY9AmWZs3M/w9R+qt2H58m2IJ9Dh5coWeX0Qb0/kGiPqpixO79gcaFptjIoQhQOCY5eIMVVTrvUojyGltO1pDM3ZTTYMkaWM1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=krcuq+5i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MZrtfbG/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCj1R8016818;
	Tue, 30 Apr 2024 14:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BhoiPDxeqxEL635p3gjmabD8XXl47p2z4PBMTp7ASPY=;
 b=krcuq+5ijEBmm00dLCpRR1equvhkhKlUsWFA5CYpoISPgYntRgFZ+3BmJH00KhoAr27R
 puUIRSKcXogiFHwTdgzqIfErd+ST06cJdYw3JohFL2lxmWouU5hUBtzzK5romp7UFn8C
 ILOWX9HDxZkgNr23jR7hVR7l8N+Zwfd33jGyANmTMOvN5EU9TEixfQ8Csl0NP/Rdf2F8
 ulcEnmACiWPDFAMWe5uvlMAzOJ21SQkWcNENnrDN4oIukXWdM0CGHxfX9sDDeirr+9I4
 BNq75kM+IS2EFTqtKkdyV6NG+K0Iiql3sBeGFDZqiOZzb1HRVp2mHaLm5aP96djoCRxf 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsew85v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:52:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UDmtrC016719;
	Tue, 30 Apr 2024 14:52:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqte1p5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv4rxRHypipzAUK8KdnbwMMooCka6ofHNTXSDOFydqc7hKegKGb5n+ejUjmn+YxHVvhTGUh+QkMnSJDRq/lZCN8cnyQIaNWA9OwyQhQCwOXIyzp8OJ1E2HsXrOkXjauRjJnyKL1IeLSOMr6D76hi3RZw2j3xxHbpOJNbcgMciFFZXJYBC+pgxJagEsuxL4Di+lueyIcoEu6W8eIoy28qnG5IyGGisNPpszCBHhdxGfPbbaviuu8B0ALNcjZoFRawlAh/XNYIkvHe/M07oYNsLCQIilO2wf7eax7dgwv9YFBnJLLMz++RxzKJ81dww//MEwLrNwSsLoGc1HjNLdt3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhoiPDxeqxEL635p3gjmabD8XXl47p2z4PBMTp7ASPY=;
 b=dutmjPmMsLB1/Wjfwg1n8TyfZMrWH4QG2NXzcZmRk1ZVr89CDLPBA3cpCXh3exdO1czfOzSS7krZ4SK43mVE/0pothlO0VT40OVazNTU+bcEtGGebZTvXLNKI0MBvtMMhfx1QVLIV27ig0q5Tz1rniQaQq1A4eknnlQvttfcEGe9uSnI39VwRmGkdB5XytHk7sjLxuqpSMuMlNV+r0gftyFdMBcY8KQ4P3WsNcUu3rGbw4inohQLMe6EP3xfWK0kYSCJKUjzzMjX0UsHLvSNf0ZqO+4tSXM2JEcZOZmnAc5kCXpUif9ldQ8YpUAVB00ohxii6dgaP2NWZe8G7cknww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhoiPDxeqxEL635p3gjmabD8XXl47p2z4PBMTp7ASPY=;
 b=MZrtfbG/gMlMuFd1BawGn4Hw1mNAQUNSxKdup5SO201ZGKbSHqrNerz+o+XyENj/j9gX9LQ0erskF2zEW/kASEHqHPh69oUSI30EnAZOQj4NbhVLnHfsfT4W+lDU2M/DMLYRptQ3Ko5eKq83sCumSPBjQZHW3E9J9Neq7pgPWoc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6857.namprd10.prod.outlook.com (2603:10b6:610:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:52:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:52:39 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Topic: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Index: 
 AQHamkmDfBfBFsNf5kaeN/1BZO1Wh7GAavwAgABo5ICAAAR7gIAABDQAgAAI6gCAAAH/gA==
Date: Tue, 30 Apr 2024 14:52:39 +0000
Message-ID: <3B48378E-CE68-47FC-A8D3-7A7AEE383B25@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
 <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
 <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
In-Reply-To: <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6857:EE_
x-ms-office365-filtering-correlation-id: feda3fb9-d540-4a78-7d5c-08dc69252e91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d3RCRE8wd2UyT25NZkRkdGZrV3lJLzA1VTJzRkwzV2VOeTB3czJoYnB1WHJC?=
 =?utf-8?B?L1U4ZG9FVjB5MldKNkRDOUtzdnFWRHcwTWE1dGx2SnZWaFhQSDBiWjBXSzRO?=
 =?utf-8?B?Sys5VVUrRUl4V0pOSkNZUVhDdEVIM2NaazdqSzlVaHh1dno5NDhJb096Wmsr?=
 =?utf-8?B?UlpCQ1NOWDg3QkRSNDY0MDJwby96d0tJQnBKR0E0Und2emNwWmdvUFRGaHNv?=
 =?utf-8?B?ZU5HSFMzN0tOTjlJODY4WlBrVWlBQnhTSlRhaGRhM3RFVlBnd2QwU2xUbjVN?=
 =?utf-8?B?bFFIWkxZVHgrbEtnV2Z5M1ROVklzK2VDdTR4V203ZEFjWGNIdytxZjliSU9D?=
 =?utf-8?B?UWYyM2dyZ3FNY1M0RklhMG5PYXFIVEtJOHpXaEpUcm5rVnZPR0psR1pNWFF3?=
 =?utf-8?B?ZWJNd1hQOXUxWWQ3clJVM2Y1ZVJjRzhZb2tHRVZKSVBIQU5wQTBveW54U3NO?=
 =?utf-8?B?Tkd3MjVRM0pyNzR1azdkSnFiWHdKSWFrY2pUWVlYTmdnNDEzLzBhcUZDaWFM?=
 =?utf-8?B?ZGhNL3hYd2g0VWNvaE0vM0RSR3crVy84MWU4ZXZyTC9CSEU0WXJjT2ljKzBx?=
 =?utf-8?B?UzJpV3BwYzJqOGl6b0xveVhhVEI4SVc4cjZLSnVjUi8wNks4L21IcFdtL2dR?=
 =?utf-8?B?SGpuTTRIMFdkU0orUllYbzFFRXMwMlBpOWdRS2Y2Y2xCcmpOa29hWFlvbXFP?=
 =?utf-8?B?aHN5TzJlZlBRMDhPUGhrUmZxUDJDbGZTRXA0NUFUWXZ5dXJ2V2RLYWhjbnp0?=
 =?utf-8?B?c3VQOWNLb3d0R1pCWlBiLzlNN2dkYlA2dkhkVSt3SkRFa050bTlpQ0tNalo0?=
 =?utf-8?B?WEZHNXg0T1hQQVRCaXFUek14TUlPY2kyQlV2WmgwdjNCUmxaclJvN3k4WVg2?=
 =?utf-8?B?b2kzb1RvS05ZN1VSd1RLeEs5NmFjYzRvZGtsRWlta1VBSWtjZksvb2l6U25q?=
 =?utf-8?B?bENwbGxHb09jZzJSSTBPaFhvYXNxVzN6QkMzTFhIajhYTkdEM3F6eS9FZml2?=
 =?utf-8?B?djBENGxxOUVjNi9MMytXdUxrdVJsK3Q3dnU5dkt1WXU3NEZaTEZYYWFFdlla?=
 =?utf-8?B?MWZVZ1NYZVRFd2xBUXNsa0MrbkRpMTZHYkh1K1dsNEdPZFZXYnBOWE9vb1dw?=
 =?utf-8?B?aWNXZFZlRVkxc2h3VWJxZSs1RjhGZS83cWxaS2c3VkV6WFhMaXJHU3hrUWRG?=
 =?utf-8?B?bklkczZMMWhvUzY1akhmTGFMK3YrakZsNncrRVFxQ1QwUDVMWW90NDFXT045?=
 =?utf-8?B?aWZkTXlZN0JCdXFETVBzZHZLbmpFZ1RwUXhmejQzcmRxbmFma3g5c0pRTy81?=
 =?utf-8?B?VGZWN00ydFAyQjl5a0c5eFA4U2x2b1hLUlhFRk03U2pOa3FVeU9qcEZrbHVR?=
 =?utf-8?B?Rzl3cXJXdkFaM0RyT005SmlLUnhwazBhWlNKa3ppSVkrMHZkc21RMGV2Z21T?=
 =?utf-8?B?MXF3RFl3eU1nUWpCelBjMjkyZ0JraTdQMTFoMnFzNHlHeG9ZNjhhZTBDcC9h?=
 =?utf-8?B?dVY0MURXOW9FeUMvbFVSblhVZUhMZ1NpUG1Za0lJOElvbHZVbi9McHphSjdV?=
 =?utf-8?B?cWR0NForU3JSZWl4TkVLVW5qZnQ4VDNPc0Q3M3ZMbjU5M2MwSERsT0ZDa3Ez?=
 =?utf-8?B?dmZnN2loVzJaaTVCODJaRUNHc2RWUk90Q1VZVS9UWXdPM0t6YnN2T2twMm92?=
 =?utf-8?B?cXB2OGRvQmJQdzVrdGQzalhYSDU4RWNCM0ZxQlBZV3dQQWUxQ25nNlRuZlZP?=
 =?utf-8?B?blFTZDMrQmhNRWcyTTRPUXVFLzRmWC9pand3OHkzeXZ5elA4Q2srWGtGMkZH?=
 =?utf-8?B?QWhVdGYvUXdEOEtUN3JXdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0pEYUM1b1hCMmk1Y2E1dlcvZFZ1RzhCQlllT2drZGZwRlNUYWxoZk0zRUh1?=
 =?utf-8?B?WWFiclR4UE5IUGhIcFIwK1BaZTFaNDd5Vm14MXhrL1Q3RGwvTzJjUlJaaGVO?=
 =?utf-8?B?U2xxTVE2bWZIZHVCTWVzVWl1bHJsZkV6TU5FUzE4WG5CMHhEdEZzMGlBT292?=
 =?utf-8?B?RWlPZjN3OTRqODh1SGxORld3MXFnaldwNjRsN0tGM2hRcSszVFVrUlBER0g1?=
 =?utf-8?B?aEhxTkJPYUtibXJZRGk3QWdrL1d4bmJKWjBqbDF0K2JYQnVWZUhOMEtMZEln?=
 =?utf-8?B?UmlVL2x1a2xOS2ZKSGdYNEFSejBybUlsU3plN0V1WTQreE9JUXRwaWdTZXBG?=
 =?utf-8?B?SjJ1WVBFTGxwa3Bvdi9rWHhNN0NDS3A4Y3ZWUEtaNUZJSGtOeHYrY3dTZ1o2?=
 =?utf-8?B?cmpuZDhOQzJubGJLb3NTVllXaXpVVnA5WVY4cGlLeFJoR0VkSXJlWmhpRnlJ?=
 =?utf-8?B?RkFya0RLa0FhbUpXMWxKVWpWdERUT3NFcUR0MWthcGxqbjdCNFhrYklzeFNN?=
 =?utf-8?B?VjA5SXJ2TWl4SGNVQnFsVjdXSG5NRTFNQmk5SENZelRPVEtzaUJ0NWprdzIr?=
 =?utf-8?B?Y3VzeklGMXlOQlZ0SGRZVzFRZXZZSjY3eGczc0dwSHFiNlVsRE5tem1EVTAx?=
 =?utf-8?B?TURJdlQyaGF0WUdVdTRWYmJoYTM2V1BCUXBLbTNxdXVHVXpWT1Nwam9FVkYw?=
 =?utf-8?B?QzNhYWs1MHd6OXJhZlgzNlpDeTBBS01FZjJ3Uk9hRUlKU2FiZnl5dnB4bkRm?=
 =?utf-8?B?dU9BOEc2YjR4ZGE2MHJXb0EzSlI0NlZYeUlsd0pEakU4NFdYU3Y5bUp3aDlx?=
 =?utf-8?B?VlIyUmJJcFZ1VW5yUXdoVG5CN0xqNzllU21tQ1YySlVQRkJROGZXN2hTZXZp?=
 =?utf-8?B?eklVZUZ1RnJXSDE4MHkyeDZ4dUhoeHpZUnRYYWswWmNGTk91dnZBWklYcTEv?=
 =?utf-8?B?eUZ2N3RXelBaQkY5eFJVSFIxOWdiOGllUHlhTldwMVM1NUUxWkZTMXkvMWVp?=
 =?utf-8?B?RG1iR2JDTWFaMkN2Rk5xU2tXN3k1eHhVMjVEeXVSbkNXcGRrVmQwKzAweWtO?=
 =?utf-8?B?R3NhRktkTGgzSm0yVUFNa0VKRVUwMGQ2N2FmVG1UZ0poQzBJZTlMalJwZFRB?=
 =?utf-8?B?K2g2VXlUaDl0U3d5MFZIU3QwRGg0Vk5oZ01TQzN5d3VRRFJSbnNURzVQMHRJ?=
 =?utf-8?B?b1YveW9ydkdWdFp6Sk5jbXBKL2czUEZka2prNE5QNGU0T2dxc3kzTUlqU244?=
 =?utf-8?B?VEs2bGNYQS81TUpqTmpicFVLWURHRlRyRVFMZ2tyWGo5Ritnc3BpY0QvMk9C?=
 =?utf-8?B?bGFMcUlFVFROeTFEVllWWGZiaFdSdjJjRkQzMTJnZjI1dkk0K2RCaEN1bXRv?=
 =?utf-8?B?Si95M1R0UGVCeE9WeXIrS2wwTElOTG1RR3NOSXVmRUJRYmw3L1dodWZuNHE2?=
 =?utf-8?B?dXJQMm9YQXJzZzA4TmkrR0FMTitXUFFTaW9EVDBTeUpTczk4QjV1TC9NdWo5?=
 =?utf-8?B?WkFCVlJHcE9jNXo0ZndrYWE3Y1dxWTZhMi9YczdlL0huYzZqL2Riclg2UE52?=
 =?utf-8?B?Y2RXN1VOd1U3V0w2Y25scWZ2QnNvVzdibjAvbWUrRERjcGVLakQyNlBnRng0?=
 =?utf-8?B?UUVscFNNaE9VcVpTaXBTcC9QcStqU2g1alRZbXpaQlBDa01JejVjWmhUSDdC?=
 =?utf-8?B?VW80U3BKWFBSSGFETGs3aEFBcG10R045YUYzUHZYMWR4dlZPbXFuQ3ZlMUJp?=
 =?utf-8?B?SmkvdmpMZHUrSWYyZ3Nic3ppWVFmZ0xURUl6NCthd0hISzNYdG5LNXNKbmYx?=
 =?utf-8?B?L1hCOWtPdWF6bDQ0SUZuSTQ5VXdoTkpINTkwTkJSdDVQUVRrSXY1NUI5eUk3?=
 =?utf-8?B?Q2ZqODlmWVpxSG1ucGMxNGp2cXRjbUlHTWtnK0l6aXJjYk5JdUdUT1FubUMw?=
 =?utf-8?B?NFVmZnVrRkttQnJNQW9mWnA3YWhDRkpaNUpDNWFZQ0p1ZDVhK2hReVUrV0dz?=
 =?utf-8?B?NWIwK0gvT1ZsRmpWd1dUUHBUaWdMLzRoS0NnbGlGaXUxV1hrSEdFYnRRd1Rs?=
 =?utf-8?B?dnVSV1grSjYva3FkQzVBaGJGM0w0OEdzS1VNbTZGaUtBeTBWdTljSTF6NEdj?=
 =?utf-8?B?aDhERFJFOEFlOXpSNkJ6M05CeVUzMlpqV0QvWmhhLzBWRGFsS01FbFRtaTdB?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF28F9F31E09AB4498CAF8F0BE5DB1B3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1J5PcylvMgmWxo56ntk+c8CnhGITwnEoqRnk3l9rykCqmdM3W6rzcC9AOGphbWuIKg8aBe1sZ67PXKbIC5sdCdC3hnXSIwM2BUWUJPpHhLOHiKl93tALbcS+FHfsdTPrPCFT5Ylr+7wHftOyyKYFgfgHuGh70Z0UCC02enDVcmGDJxx48evv8th85zl4a6qtVnwUZQmrOxyvIs/qLHT2s7XYIV4kknC4ojUlsL1oaU88UzhE28FnJn9i6flUPS0wD1bX05OR0r8Q1e1uylHFnI+pgPsulk3TlvvEagsrqKJcT1nscMbNbX05y97O0ylrau7Tt5s0lwmskaYPSmZh6r9e4PCygIOi4pi6gz6fr6uFLEwQyEcUsbBTaflthE/JpVUkxG2sAlrVCIH84oDus0GGI7s6gzaZsYFYGGCcDgWhPO49PqAbONzjjoYXFyIRw68cEBGf4OAwCBHYJQn99GjYPqH64bULmIberzPy3/UBwxdpvQD4CStxW0vY4Bt1zpjKPZLwx12sOiXcGPWReKekhspS22UxdZZZd7+0kZa6z8BlJaU/FmJeqe06mH2UnuUV3wF0R5KOqGo4unEPLbBz2KlZ7xVL8FTCeqgfnR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feda3fb9-d540-4a78-7d5c-08dc69252e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 14:52:39.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1yNKpoz2EUg3pHLRuSqt7TJyxZSZi2Mv46lxWJxOztArSUqziBXqnsk50XtEFLXCKKkC90WCMmtj5smpBjvYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300105
X-Proofpoint-ORIG-GUID: NJqtJuZAWyqwjqrsHC6do8cWrMscdJc8
X-Proofpoint-GUID: NJqtJuZAWyqwjqrsHC6do8cWrMscdJc8

DQoNCj4gT24gQXByIDMwLCAyMDI0LCBhdCAxMDo0NeKAr0FNLCBaaHUgWWFuanVuIDx6eWp6eWoy
MDAwQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzMC4wNC4yNCAxNjoxMywgQ2h1Y2sgTGV2
ZXIgSUlJIHdyb3RlOg0KPj4+IE9uIEFwciAzMCwgMjAyNCwgYXQgOTo1OOKAr0FNLCBaaHUgWWFu
anVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gT24gMzAu
MDQuMjQgMTU6NDIsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4gDQo+Pj4+PiBPbiBBcHIg
MzAsIDIwMjQsIGF0IDM6MjbigK9BTSwgWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+
IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiAyOS4wNC4yNCAxNzoyNSwgY2VsQGtlcm5lbC5vcmcg
d3JvdGU6DQo+Pj4+Pj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+
DQo+Pj4+Pj4gQXZvaWQgZ2V0dGluZyB3b3JrIHF1ZXVlIHNwbGF0cyBpbiB0aGUgc3lzdGVtIGpv
dXJuYWwgYnkgbW92aW5nDQo+Pj4+Pj4gY2xpZW50LXNpZGUgUlBDL1JETUEgdHJhbnNwb3J0IHRl
YXItZG93biBpbnRvIGEgYmFja2dyb3VuZCBwcm9jZXNzLg0KPj4+Pj4+IEkndmUgZG9uZSBzb21l
IHRlc3Rpbmcgb2YgdGhpcyBzZXJpZXMsIG5vdyBsb29raW5nIGZvciByZXZpZXcNCj4+Pj4+PiBj
b21tZW50cy4NCj4+Pj4+IEhvdyB0byBtYWtlIHRlc3RzIHdpdGggbmZzICYmIHJkbWE/IENhbiB5
b3UgcHJvdmlkZSBzb21lIHN0ZXBzIG9yIHRvb2xzPw0KPj4+PiBXZSBhcmUgYnVpbGRpbmcgTkZT
IHRlc3RzIGludG8ga2Rldm9wczoNCj4+Pj4gDQo+Pj4+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC1rZGV2b3BzL2tkZXZvcHMuZ2l0DQo+Pj4+IA0KPj4+PiBhbmQgdGhlcmUgaXMgYSBjb25m
aWcgb3B0aW9uIHRvIHVzZSBzb2Z0IGlXQVJQIGluc3RlYWQgb2YgVENQLg0KPj4+IA0KPj4+IFRo
YW5rcyBhIGxvdC4gSXQgaXMgaW50ZXJlc3RpbmcuIEhhdmUgeW91IG1hZGUgdGVzdHMgd2l0aCBS
WEUgaW5zdGVhZCBvZiBpV0FSUD8NCj4+PiANCj4+PiBJZiB5ZXMsIGRvZXMgbmZzIHdvcmsgd2Vs
bCB3aXRoIFJYRT8gSSBhbSBqdXN0IGN1cmlvdXMgd2l0aCBuZnMgJiYgUlhFLg0KPj4+IA0KPj4+
IE5vcm1hbGx5IG5mcyB3b3JrcyB3aXRoIFRDUC4gTm93IG5mcyB3aWxsIHVzZSBSRE1BIGluc3Rl
YWQgb2YgVENQLg0KPj4+IA0KPj4+IFRoZSBwb3B1bGFyIFJETUEgaW1wbGVtZW50YXRpb24gaXMg
Um9DRXYyIHdoaWNoIGlzIGJhc2VkIG9uIFVEUCBwcm90b2NvbC4NCj4+PiANCj4+PiBTbyBJIGFt
IGN1cmlvdXMgaWYgTkZTIGNhbiB3b3JrIHdlbGwgd2l0aCBSWEUgKFJvQ0V2MiBlbXVsYXRpb24g
ZHJpdmVyKSBvciBub3QuDQo+Pj4gDQo+Pj4gSWYgdGhlIHVzZXIgd2FudHMgdG8gdXNlIG5mcyBp
biBoaXMgcHJvZHVjdGlvbiBob3N0cywgaXQgaXMgcG9zc2libGUgdGhhdCBuZnMgd2lsbCB3b3Jr
IHdpdGggUm9DRXYyIChVRFApLg0KPj4gWWVzLCBORlMvUkRNQSB3b3JrcyB3aXRoIHJ4ZSBhbmQg
ZXZlbiB3aXRoIHJ4ZSBtaXhlZCB3aXRoDQo+PiBoYXJkd2FyZSBSb0NFLiBTb21lb25lIGVsc2Ug
d2lsbCBoYXZlIHRvIHN0ZXAgaW4gYW5kIHNheQ0KPj4gd2hldGhlciBpdCB3b3JrcyAid2VsbCIg
c2luY2UgSSBkb24ndCB1c2UgcnhlLCBvbmx5IENYLTUNCj4+IGFuZCBuZXdlciBvbiAxMDBHYkUu
DQo+PiBHZW5lcmFsbHkgd2UgdXNlIHNpdyBiZWNhdXNlIG91ciB0ZXN0aW5nIGVudmlyb25tZW50
IHZhcmllcw0KPj4gYmV0d2VlbiBhbGwgc3lzdGVtcyBvbiBhIHNpbmdsZSBsb2NhbCBuZXR3b3Jr
IG9yIGh5cGVydmlzb3IsDQo+PiBhbGwgdGhlIHdheSB1cCB0byBORlMvUkRNQSBvbiBWUE4gYW5k
IFdBTi4gVGhlIHJ4ZSBkcml2ZXINCj4+IGRvZXNuJ3Qgc3VwcG9ydCBvcGVyYXRpb24gb3ZlciB0
dW5uZWxzLCBjdXJyZW50bHkuDQo+IA0KPiBUaGFua3MgYSBsb3QuICJUaGUgcnhlIGRyaXZlciBk
b2Vzbid0IHN1cHBvcnQgb3BlcmF0aW9uIG92ZXIgdHVubmVscywgY3VycmVudGx5LiIgRG8geW91
IG1lYW4gdGhhdCByeGUgY2FuIG5vdCB3b3JrIHdlbGwgd2l0aCB0dW4vdGFwIGRldmljZT8NCg0K
Tm8sIHJ4ZSBjYW5ub3QgYmUgY29uZmlndXJlZCB0byB1c2UgdHVubmVsIGRldmljZXMsIEFGQUlL
Lg0KDQoNCj4+IEl0IGlzIHBvc3NpYmxlIHRvIGFkZCByeGUgYXMgYSBzZWNvbmQgb3B0aW9uIGlu
IGtkZXZvcHMsDQo+PiBidXQgc2l3IGhhcyB3b3JrZWQgZm9yIG91ciBwdXJwb3NlcyBzbyBmYXIs
IGFuZCB0aGUgTkZTDQo+PiB0ZXN0IG1hdHJpeCBpcyBhbHJlYWR5IGVub3Jtb3VzLg0KPiANCj4g
VGhhbmtzLiBJZiByeGUgY2FuIGJlIGFzIGEgc2Vjb25kIG9wdGlvbiBpbiBrZGV2b3BzLCBJIHdp
bGwgbWFrZSB0ZXN0cyB3aXRoIGtkZXZvcHMgdG8gY2hlY2sgcnhlIHdvcmsgd2VsbCBvciBub3Qg
aW4gdGhlIGZ1dHVyZSBrZXJuZWwgdmVyc2lvbi4NCg0KTm8gbmV3IHRlc3RzIGFyZSBuZWNlc3Nh
cnkuIFRoZSBvbmx5IHRoaW5nIG1pc3NpbmcgcmlnaHQNCm5vdyBpcyB0aGUgYWJpbGl0eSB0byBz
ZXQgdXAgcnhlIGRldmljZXMgb24gYWxsIHRoZSB0ZXN0DQpzeXN0ZW1zLg0KDQoNCj4gQmVzdCBS
ZWdhcmRzLA0KPiBaaHUgWWFuanVuDQo+IA0KPj4+IEJlc3QgUmVnYXJkcywNCj4+PiANCj4+PiBa
aHUgWWFuanVuDQo+Pj4gDQo+Pj4+IGtkZXZvcHMgaW5jbHVkZXMgd29ya2Zsb3dzIGZvciBmc3Rl
c3RzLCBNb3JhJ3MgbmZzdGVzdCwgdGhlDQo+Pj4+IGdpdCByZWdyZXNzaW9uIHN1aXRlLCBhbmQg
bHRwLCBhbGwgb2Ygd2hpY2ggd2UgdXNlIHJlZ3VsYXJseQ0KPj4+PiB0byB0ZXN0IHRoZSBMaW51
eCBORlMgY2xpZW50IGFuZCBzZXJ2ZXIgaW1wbGVtZW50YXRpb25zLg0KPj4+PiANCj4+Pj4gDQo+
Pj4+PiBJIGFtIGludGVyZXN0ZWQgaW4gbmZzICYmIHJkbWEuDQo+Pj4+PiANCj4+Pj4+IFRoYW5r
cywNCj4+Pj4+IFpodSBZYW5qdW4NCj4+Pj4+IA0KPj4+Pj4+IENodWNrIExldmVyICg0KToNCj4+
Pj4+PiAgIHhwcnRyZG1hOiBSZW1vdmUgdGVtcCBhbGxvY2F0aW9uIG9mIHJwY3JkbWFfcmVwIG9i
amVjdHMNCj4+Pj4+PiAgIHhwcnRyZG1hOiBDbGVhbiB1cCBzeW5vcHNpcyBvZiBmcndyX21yX3Vu
bWFwKCkNCj4+Pj4+PiAgIHhwcnRyZG1hOiBEZWxheSByZWxlYXNpbmcgY29ubmVjdGlvbiBoYXJk
d2FyZSByZXNvdXJjZXMNCj4+Pj4+PiAgIHhwcnRyZG1hOiBNb3ZlIE1ScyB0byBzdHJ1Y3QgcnBj
cmRtYV9lcA0KPj4+Pj4+ICBuZXQvc3VucnBjL3hwcnRyZG1hL2Zyd3Jfb3BzLmMgIHwgIDEzICsr
LQ0KPj4+Pj4+ICBuZXQvc3VucnBjL3hwcnRyZG1hL3JwY19yZG1hLmMgIHwgICAzICstDQo+Pj4+
Pj4gIG5ldC9zdW5ycGMveHBydHJkbWEvdHJhbnNwb3J0LmMgfCAgMjAgKysrLQ0KPj4+Pj4+ICBu
ZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMgICAgIHwgMTczICsrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tDQo+Pj4+Pj4gIG5ldC9zdW5ycGMveHBydHJkbWEveHBydF9yZG1hLmggfCAg
MjEgKystLQ0KPj4+Pj4+ICA1IGZpbGVzIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCAxMDUg
ZGVsZXRpb25zKC0pDQo+Pj4+Pj4gYmFzZS1jb21taXQ6IGU2NzU3MmNkMjIwNDg5NDE3OWQ4OWJk
N2I5ODQwNzJmMTkzMTNiMDMNCj4+Pj4gLS0NCj4+Pj4gQ2h1Y2sgTGV2ZXINCj4+Pj4gDQo+Pj4+
IA0KPj4+IC0tIA0KPj4+IEJlc3QgUmVnYXJkcywNCj4+PiBZYW5qdW4uWmh1DQo+PiAtLQ0KPj4g
Q2h1Y2sgTGV2ZXINCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

