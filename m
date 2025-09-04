Return-Path: <linux-nfs+bounces-14045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDBCB444E2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C621BC0499
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A43148C9;
	Thu,  4 Sep 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UobPIt9R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i5MrqeFo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A623218BA
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008487; cv=fail; b=M889DqIPFP7GO26etFomMTq52EhsOHvdvvNy7lIk9wtmjoGbEV0+6V1KuOG18yR2GC1D05OqOOyj7gG/6AUVqDAmzBMXTwltIdszWIV24hno1pSLamnRtzlqcXER2XWvOXUhFJ1Het58sGiUTE8hO7eIpEi6a1XBjRV3gEdN0Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008487; c=relaxed/simple;
	bh=/nhrTBSLLUZza+vLtB90cqaECYofn9UpBVQeM2QcU+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L74Coo1TNqvFpKJORoULoZjqaJcTWps0K6wgVgEo2efmXuITVQlhWBo+SqGFgp3D8SltUpRqNKzgl5gQ8IaKvSP8FBEGMrLZERMdTfB1f+/AfNkB8X6NFyAWRei2q19OOBqT17WY9ATzcC/jIjh+FrAztLPY7H8wCokeAjGrDSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UobPIt9R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i5MrqeFo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Hilww007069;
	Thu, 4 Sep 2025 17:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3LiZn02qevcQzm8aUI8PPSX127zvKdodMA+iOu+r7n0=; b=
	UobPIt9Rs4Yu3vuQsutIiR8t6vV8akE60AMTNbvJ4jXjXnpZoRCiM2lXFuOXGc8y
	2hhFgMelTbE9dRSUj0gipF0SNtzyHdwQH4PSw5T70TNXRbpn5aoeDEMzArc7KWTI
	OcxpqfBOnYob8zp5mZaM0v83Toqkw3NvhNYOqKX+YPWsdQ/RB1TlBTs3Psv3JMY0
	Oxo/tpw8DgF2/9Ka0FlpZg+tAmsCCQAKQyAEXJtjGAb7YlXxmI9UqucpkvQXn73b
	Vw8o4Ea/CTInw8JBThAycgPaiJ7xvCGx5MBGjGjWZALe13ASC2wtaaag60J5l9ol
	KPu0W1xg2IoIzbdxtD5vVA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yfecr0q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 17:54:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584H7aIf040664;
	Thu, 4 Sep 2025 17:54:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbk55f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 17:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEHYSeZYtvqHaxqnsZ0TiAAiOErUnHgzPg53f+FDWOBrgsgweGgCtXTXkbCtpfZqd0Uc8D1amTioGhyVfmYvbkaUbtWbJQ5j5W1AkjmDRpQSjroEYtaQYmvyl8bCOPQDfgCqDTAnlbEQ2Mx5dtkp4azPJMYNaJiLejmTI3bm+9DOC8WK1m/RaY/8q/uDChAmJX94e8I/V4l82EX+i0IgmhsKL28Uu2uK5NE3pRhu+WUZlAJr4i0sKRPv4gHZDP1Gb7Pb7kFFeH61NbppTfJFnLfzNRe6JpSWV0VPG3uFJ3fVAtm7nbsTyMk5qDNxei4WWM3g4b46AIeTTcKTNJ92dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LiZn02qevcQzm8aUI8PPSX127zvKdodMA+iOu+r7n0=;
 b=AsYHI71pbL7XJpIKjW5SVN/obo55izw/hnSh6pPUQWlDcP11WZfzznHxv5RyAN3gBaqN/5ZiqmaMCe5OkdqSS8FUq63xdU/H3Iu3kBpj/MuWH26K5M+GXL234N7IQEplQBG9cDho+FgEKi77xT8/xyXBIva9xKI3qYWtx8SK3kTZQcsNDmBodVxMQdgw72nKB9hREUPPNo2XkDS/ervhvMt1JMyPJLHFgUyvX9ggSS00S1APPMyLiPKbyzaTJ5zOS7apsBnBb0fYTIfqDdiGQnIj4svfxl+oPpaa0MRLNK98hIrwZhev9RswxlqEmIeDibVoqCqruyBxpdjJS7A0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LiZn02qevcQzm8aUI8PPSX127zvKdodMA+iOu+r7n0=;
 b=i5MrqeFoEVHur+gP7RR8KGVMXNgmydhtIiao+nnpG9Yxn3BnXE+BUhXfSyONocqdY1trtnMf4u21hnYo0nm7u4Es/9hcZvuS4PtzWs2KLXSiWj5bONbZDeaUkXY9qJ92yRnOx+SnhWKYK+rwcPwP8M/BSlNbPxI/IACTwYdhru0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPFCA9331432.namprd10.prod.outlook.com (2603:10b6:518:1::7c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 17:54:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 17:54:35 +0000
Message-ID: <9a3839fa-c4d6-4c01-8397-ddef8b2b18b9@oracle.com>
Date: Thu, 4 Sep 2025 13:54:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org> <aLmlY-xdYh73UaAf@kernel.org>
 <3e877306-6e1b-4428-8a1c-e0bf4e768367@oracle.com>
 <aLm_PxH2FJc7PVZ1@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLm_PxH2FJc7PVZ1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:610:38::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPFCA9331432:EE_
X-MS-Office365-Filtering-Correlation-Id: ec32d6d1-e6a7-417d-a210-08ddebdc1c2a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QzJpTFVKV1JzM0hmWitDaUd5cXl0Mk1zcms5aVE4c0RKcjdNLzVaYVVMOG9u?=
 =?utf-8?B?YmVTQjFzSlpEcFN0OW9yd3Zkclk0S0E1WjFKY1VFWXJSU09DdVJlWWRPbDA0?=
 =?utf-8?B?TzN5QkdiR0VMaFJ0MVNzQTU1am5yc3dtOC84dHpmeWhzWVdXaXVVYWFIbjNj?=
 =?utf-8?B?ZHJYejJNaUZGd08yOENzYUk5Vy90RnhtK015ZnZWSXI0aXZKUVl3b2I3QVEx?=
 =?utf-8?B?RVBiWkx2UlNpODExbjg4cFdWV1ljWjFFcDRjS1VHWVozem91UlNJa3ZQTE5M?=
 =?utf-8?B?bm1JeXVrREdoNlhyUXRBR1l4bzZSR1hYNzM2eGNkNzV5OFFoM2ppK09WTUJs?=
 =?utf-8?B?TlJIN0RYVGN1WDNPQ0V5enREZXBGNkxXVXZsTXBVd1pHUDVENVI4ZzRPZ3pp?=
 =?utf-8?B?eFprdENSbDZFbkE0dXV1WXpaQld1UTBqeVdRMW1tTzdMQk9wRFVtUDc4cTgv?=
 =?utf-8?B?OTBjNnY5L2lxQU9CWmh4MTdFc05PdkNPYnF5VDdFS1gwVno1OXJCS0ZkRmNl?=
 =?utf-8?B?VS9rVHlLaFJPMmlXbmNhYUJxcXlHV3dKaVJjT2JqQlRyd2k2aVlmbGFoaGVT?=
 =?utf-8?B?VVpoTzBVMnZlb05OL040ZVByRVBqekxMd1pxZ3pqSXpuQldxamdCSVU4bHBB?=
 =?utf-8?B?MzZPc0ZRN29SN1BsaThvdHBkcGQ0QlA4YUVCUmx5eGtGVVc5MWw5UEk5bjF3?=
 =?utf-8?B?L2VqY005SHNEM1I3M2pJMDlPVW01b0dkOGhFZW5hbFdKM0NXaXZRM3kxZEN4?=
 =?utf-8?B?azYvWUtkTmxXRXJzZ0Mxcysva1I4bjNaU2ZXN1hVQldEUWwyYUtUT2JZcW9j?=
 =?utf-8?B?VnN3emRwdE80eXNORlhMMzJwODdsczMreXEzNk8yemZZZEtxejRpVjVtbC8x?=
 =?utf-8?B?ek1yalBja2Q5ejJ5SHgxOXFrUXRqS1VNNDRCS3pkUkN0elFnQkpneklkVy9P?=
 =?utf-8?B?QktOSWxMTXVSRWI2NnZDZmRBcDdKQ2wrVG9MV2tPeXJSN2NEOGw4ZEpsOUpu?=
 =?utf-8?B?eGFZYWpPY0NGUmo4b3lEYjh5YUs1elJldkZkd0lUWklkNUxSN2I0b0ZGQ3I4?=
 =?utf-8?B?OHpaRHlHM1hXQzJjdmR6QkFYUDFmcVVhaWwycGhZM1FnNWNvMXBCaklrWW9Y?=
 =?utf-8?B?SkdYT2ZYNnlFakVGeFRDN2V1QXFwT2RMaFZqMkR1dE5xbEw5cDFKMDZtbnlU?=
 =?utf-8?B?bWRsNTZwQkovaTJGQ1Vzb0ROZ0tiNGhzWHZRdXcxbGxnMDUzaGh0R3NsZ1hJ?=
 =?utf-8?B?MElBUFlZK0ZEeTYyRzBkdXRqTGgvWFgwbWFSZ3BxSUd4QWVJUUk2cFJRZmVl?=
 =?utf-8?B?RGZrcU5ybTgrRmdkbkNZMHRIVUhjRG8xNUJtMFptQ09jYVFOaXFsMisvcGo3?=
 =?utf-8?B?bnFJdlRiMnE2SVZYYzlDWlRKeDRRdGExNWhzdkFuV3Y0b01YRk1YL2p3MWFC?=
 =?utf-8?B?MmVhN08xRkxzUG56S2NTMnlPSTkvYlJkN3dBZllzRTdXRVZqSzVkZFl2dTVv?=
 =?utf-8?B?d0RReWdzc1JVcDZBM3BiMXVEWHNzQ0hTdGxQZXBwTmhZZUt5RTZwTU8xSG9m?=
 =?utf-8?B?d3FQNXZma21BRUlkbS9pZTVmakpicHRCdWRKWnZ0L0N3S1R0a0U3Y3B3TVc0?=
 =?utf-8?B?TTFBTEV0UXdVaklOQjBtV2NWWElaNUorZXVVZ0lKekdNOWhObnlOUVlYNE5O?=
 =?utf-8?B?SjQ1SlBMRDhqUDg2YmRYQzJuRG9Nd2s3cUJBbmZGV0xnNkpLUTB1RUMrQTFx?=
 =?utf-8?B?SHZiY2YwWk42S3ZNa011SC9hYmFmQkw2TzllUDJqMTVhVUFtVnJXOVJQaWF4?=
 =?utf-8?B?SHpxVyt3M2RKdHNtUGNxdVBtVEhGdE9sSXJtMGZ3QjJZSzFIYmNBODFTeTVn?=
 =?utf-8?B?bFU4TGlRaXduN3VhcVpmY1pvTDVNMmxYUlVaYUhlTk9LNER2WWl2RmFnVDVT?=
 =?utf-8?Q?7VZ0kZ4Us70=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QWIvbVErRUdrRXhZT3h6ZVl4U1AyZVZscXIwbXhsdEVFZlUyS2I4NXRBMFda?=
 =?utf-8?B?OURtQnlVMXZ2YkFBS1pacHNGbVZ5T3pCTTVyYmRwdlhkSDU2eVNTSkJsRzg1?=
 =?utf-8?B?M21XdlFSSDk1QnpEbVA2Q3hPRzY1ZVdpN1ZuMjZIT085WDV5eFNsVVRnbWNp?=
 =?utf-8?B?bUM1NGpkMDQ1djNkZktwTFJFM1ZYb29IYVNJbmwvaVZKN20ralJiUzY3ZHdq?=
 =?utf-8?B?L3VKK1Jwa24yTkY5d0pDalN3eUpscXIveGtkOGhVbnFqaDE5TnEvNm1NM2tF?=
 =?utf-8?B?NnBkSDh5djVTdmF3ZE5DOUlTL2ROVTE5bFZzUnVxSVlrTGxQSFdLYzgxbHhI?=
 =?utf-8?B?QVo5YXE1T2tod2tPMGZ6YmdNT2Z0K01WZ3h6RXFpNlFSR0VKckJmb2RHSHpK?=
 =?utf-8?B?NHcyQTRlNVBYaE4rbS9yVjlTYTNIbUkwcmVkK0RpNjlqUS95Y1B4emlNbVlh?=
 =?utf-8?B?SEVXOU1OMjdWaGNpaWZ4eWVSQ0ppVTlFa1dIVHp5eENXcDBlRmJoQmVtTXUr?=
 =?utf-8?B?dVBpcWpWWHpyWCt6bVJXd1dtK296ODdGVXMwb1gyYTBHbTQvZW12V3VoRlFi?=
 =?utf-8?B?OTJnWVJNa1loQ0UxT0k3RXM5Wlhjd1piZit3SWVuM3pYM0s1YWdiZXRQcnhU?=
 =?utf-8?B?OUtoclplcGNaZUpBL3N6U2E2czFrU1RKKzZoZnQxWlRyMnVHcUJIaUFGOVl0?=
 =?utf-8?B?cE82YkNzUnlIbG5BWlJldWZ5TldFWTRvd3oyNjE1S3RIWm5ERDJsYWFjc3JL?=
 =?utf-8?B?M3NjRkNJc0poYVE1R0hUcWVrbTZ3U2k4cUEwMWVMYmhMbkxtTEhRb2hUL3hD?=
 =?utf-8?B?OXBRb0M5Nk1va0pqd3NoRWJUU3FkRE5GWDR5ZDJ2b2NGenYvdzhrYXNtYkh1?=
 =?utf-8?B?VDZxK2pDaHROMkk2Mm4wWTRieEpUKzBzOUp6OE1UKzdoRkdsZUY5enNUZzJR?=
 =?utf-8?B?elJFczNJb1phUElYd09QcGJ1d1ZRUi9GRk8xcXRUVVJiQm5GTnRBWERNWllx?=
 =?utf-8?B?Um5VcW9PY0J2TDBFUkMvU1A2MVJ0aEJQaXN3R21LdHBYYUx6N0FsN0lpdVdF?=
 =?utf-8?B?c20waEkyWXdyRTM4Wm90dTFpMkZ2aVloZ3NUWXdTZFNiTHRibnZ0OTNmS1Bj?=
 =?utf-8?B?aGtUUXRVSjY3Z0NJREdRUlFoSXZuSUM0d3hXOEZ1UVQxSjM2clZBc2kxUTF2?=
 =?utf-8?B?b2tIV25ZUk02SGFUR2VtdW54VUpXVUt6SXdKM0ZXK0g3R3ZVbEd0RXRSOEta?=
 =?utf-8?B?bVhiZDVFUldNcEk3ZEVQeFZpTzhXV0k2Wlh0cWxSVHg3elptOERwMmxKNDRG?=
 =?utf-8?B?cU44VUtHbmVWVS93UndqWXhZZnBqRHZQcVFQTktGajhZVkd1NG51dnIxSm5r?=
 =?utf-8?B?S2tZa3VGdDdLVnQxTElVd3ZYUWZDdlR5YmtQZ2RHY1oyVGxsUFVBb1daRCtk?=
 =?utf-8?B?YUxFK1MxN3F4VHR6TDVjZFJpRFFzV1VnODFZNW5xcGNSK0h3bWV4SjU3U05P?=
 =?utf-8?B?MDF0N0hLck9mNUJpL3N1Ynh0RzlLbFRxbXhmaGVwalN4bG5QOC9laGw2WnI3?=
 =?utf-8?B?ejd1ZERVaEFrSGVVb3FCVklRYXBYYlhLdWJ5bVRzOVZzYXpOS09vMk1aWUc5?=
 =?utf-8?B?aitkRjdCb2tlMHhvY3ZKZXJzSkdPUDQxTXI4WG9sdUJwUUZTUWduSU0xUnZP?=
 =?utf-8?B?RXRabzliVW84N2RLb1lnRHYzbWtJOHZRNVlidE8wQU9qcHNzS093VTRaaS9a?=
 =?utf-8?B?dEZyMDdxN2ZZeTVpV0dkdnFXOWlXSk5weXdWeXhnUjVlRjJzWkVKMnF3ekc4?=
 =?utf-8?B?d3A3Q05SZFBNVmhXNjdXT2psMi9QNWVGWmVqK3htRXRMMUx0ZWZhb05HQ0xw?=
 =?utf-8?B?ak5NcWdQQmZnM3hhWjY5MnROUDdzYTNOb2JkazBsY1NZd1RlWU5qc2FkUExP?=
 =?utf-8?B?Q0tJMmR3TjVZckNkc0t1clRyUEx6bHNjanB3THQ2RTdOY2ZUTnd4RmRodXg3?=
 =?utf-8?B?bVVleHlWYnk1d1RJMy9DaXVXY3huWXFtblNxWXR2NWhWMUNNWWpPQzVKckZ1?=
 =?utf-8?B?UTFSdTNMM2N2bkxiYzBkZllFTjFJQm16dTNheFNNdHJWUzRlcFRJOGRUVG1m?=
 =?utf-8?Q?0iEePrmb4KPQak+9rvPp72T6S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m4vSpFAPWyyTg6ohLqcq0mp5NkIJRn+gHn/IONsQ5TmV2keG8nqBKL7QKI6QMB0/sflA3hkA7hs22BhebPOS+fSDn94M5Krj7BAnTlSDagMqPB1LOTulp9A2LzwH1Z48MwddScw8wPWl7S9ypkAdCZ9qBoypQAuwPv98OQ8dFL1lWIYT4vBYP4gkVLKtcJr4SGXhv+btcRfXrUU9z9VCe2MMX/afFeFJVzXFmiXxcO/bhGGe31vzD0gNIXdUiFnR+pnAfJ5TNyU/D3N1/G3QUY5IM2uZ8H5igYQCtwtbbimZKgvwQKjg8NvyZzfvv3doVlJM7vSevX9+9BHHEiYOTbxmzIAodNb/qqGFuNQ1wYcpUcPfr23354g+zuAs0aDLY/YYVRlpurU4nZ9LuL5wXD50qy9iVyCz23k0NQG4LpURL4zZ7C3QPU1saOapsPcPoMvCyaXCq6hj2BKnj5BqO6o2W3zeMqXZi4AFI17bUD//6kmAgPtNRRe2vJ/eupRBvI4D9bsS0ZyQ7a9bq74toCpcACnOtjZhSshzAlTGOAufMfI4vPkWI29QKUMI6VOte1kaoEKMHEqzJL0DiYYMVhsrorkk3LaWTeyKyCz0rnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec32d6d1-e6a7-417d-a210-08ddebdc1c2a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:54:35.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DuW4uDtj2OBEboJefkh1XJN0QsxbfmitJCHQqwV63oaLc7tj2ywmwnKIY4EeR+vyuk+MQFb/lLK5zt5Fj08+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCA9331432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040176
X-Authority-Analysis: v=2.4 cv=fc2ty1QF c=1 sm=1 tr=0 ts=68b9d261 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=xHSzuO-mkpSHTTEddqgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FWmao-7sRaqmiVVV2NK1Pre7hBspMZ7l
X-Proofpoint-GUID: FWmao-7sRaqmiVVV2NK1Pre7hBspMZ7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE3NSBTYWx0ZWRfX+u5Q5n19VoE8
 2CMGmc6w4cN0zdoj1L8Dpuj03FE8qA+L6kvOEBsxM9zYfe3lmxjGa+q4PH5nRYs2fcnNmwKbMCW
 LE+Ai8DGQtPDms6ZpIyCnNpMtFvRP1MnpekLuDdK1dEFYwpl5uhHHXA3OnQ/A4aBtDzIM0GMovM
 tmDh57u/ZpoQLkWTANvCKIK3sChh3E+nURFptFqDFASZ/RWuRv190pty/D40830imgss9O6XiNf
 N+A4dpNReeBk8GmKW6LSx8NXZD/CftnxAYuUSAt7MLcLeJFVglj3SttJATTaDdxPutqwgNsnJuW
 dO5Vm67bPA7OD4YeRVO/VThqiFVI0xk/qysvVeQiJVLmLtpFcwupf+BQnAXx0E/Sh5cHpoZUD7d
 ngMGSbgK

On 9/4/25 12:33 PM, Mike Snitzer wrote:
> On Thu, Sep 04, 2025 at 12:10:00PM -0400, Chuck Lever wrote:
>> On 9/4/25 10:42 AM, Mike Snitzer wrote:
>>> On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
>>>> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
>>>>>
>>>>> I am testing with a physically separate client and server, so I believe
>>>>> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
>>>>> particular "fsx -Z <fname>") show READ traffic and I'm getting the
>>>>> new trace point to fire quite a bit, and it is showing misaligned
>>>>> READ requests. So it has something to do with dt.
>>>>
>>>> OK, yeah I figured you weren't doing loopback mount, only thing that
>>>> came to mind for you not seeing READ like expected.  I haven't had any
>>>> problems with dt not driving READs to NFSD...
>>>>
>>>> You'll certainly need to see READs in order for NFSD's new misaligned
>>>> DIO READ handling to get tested.
>>>
>>> I was doing some additional testing of the v9 changes last night and
>>> realized why you weren't seeing any READs come through to NFSD:
>>> "flags=direct" must be added to the dt commandline. Otherwise it'll
>>> use buffered IO at the client and the READ will be serviced by the
>>> client's page cache.
>>>
>>> But like I said in another reply: when I just use v3 and RDMA (without
>>> the intermediary of flexfiles at the client) I'm not able to see the
>>> data mismatch with dt...
>>>
>>> So while its unlikely: does adding "flags=direct" cause dt to fail
>>> when NFSD handles the misaligned DIO READ?
>> Applied v9.
>>
>> Multiple successful runs, no failures after adding "flags=direct".
>> Some excerpts from the last run show the server is seeing NFS
>> READs now:
>>
>> Filesystem options:
>>   rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
>>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
>>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
>>   local_lock=none,addr=192.168.2.55
>>
>> nfsd-1342  [004]   463.832928: nfsd_analyze_read_dio: xid=0x89784d89
>> fh_hash=0x024204eb offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
>> nfsd-1342  [004]   463.833105: nfsd_analyze_read_dio: xid=0x8a784d89
>> fh_hash=0x024204eb offset=47008 len=47008 start=46592+416
>> middle=47008+47008 end=94016+192
>> nfsd-1342  [004]   463.833185: nfsd_analyze_read_dio: xid=0x8b784d89
>> fh_hash=0x024204eb offset=94016 len=47008 start=93696+320
>> middle=94016+47008 end=141024+288
> 
> OK, thanks for testing!
> 
> So yeah, patch 9/9 of v9 does workaround the problem relative to
> flexfiles+RDMA (though patch header should really be updated to add
> "flags=direct" to the dt command line):
> https://lore.kernel.org/linux-nfs/20250903205121.41380-10-snitzer@kernel.org/
> 
> Is it a tolerable intermediate workaround you'd be OK with?  To be
> clear, I'm continuing to work the problem (and will be discussing it
> with Trond)... but its a tricky one for sure.

1/9 through 4/9 are merge-ready. Though I'm thinking maybe the DIRECT
support should remain "ENOTSUPP" for the moment -- just add DONTCACHE
and BUFFERED for now.

For 5/9, I would like to continue improving that code. It will be easier
and less risky if we do that before there are non-developer users of
that code (ie, done before it is merged). I will spend some time on it
to give some detailed feedback.

6/9, as we've discussed, is risky until we can gain more confidence that
managing the unaligned ends via a buffered write is not going to result
in corruption. So, not merge-ready.

7/9: I think we need to be smarter about the trace points. There are
some exceptions (like where NFSD_IO_DIRECT is turned off for an I/O)
that need either a trace point or a counter. The code paths are likely
to change anyway as they are polished. So, I don't plan to merge at this
time.

8/9 will need to be rewritten as the code evolves. We can wait to merge
that.

9/9: I would rather wait for thorough root cause analysis. It doesn't
make sense to me that picking the end page rather than the first page
should make any difference at all. I like to have a little more meat on
the rationale bone before merging fixes.

And whatever is found, it needs to be squashed into 5/9.

The "dt" reproducer is very low profile -- less than 20 operations on
the wire for the non-pNFS case. IMO grabbing a network capture (on
RoCE) would be helpful.


-- 
Chuck Lever

