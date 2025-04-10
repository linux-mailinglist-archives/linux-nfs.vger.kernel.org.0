Return-Path: <linux-nfs+bounces-11091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074D9A84C4C
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837BC1BA68DE
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF128EA50;
	Thu, 10 Apr 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ogK5Ggpt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jy6hGgCZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D128EA63
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310568; cv=fail; b=b5Blw8kmMRSrjd7Hpz7xv/Syi0n5TyFHyIIghWwd3JNsGfPyDhnrlMwnhkUKwZa89W9xDCvy5vodNE/Yaa/8InDQHgzwiSqFYwU2qZqajPTZKPfBTRsjUIigf5ozA290mXkBs0v04GaH2hws11P/LCa4Sja3TG/Q9fghpc+2UTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310568; c=relaxed/simple;
	bh=bJfYiCFVeB7lvGC5fxCG5rUyU+/0JyxkSyXUmhknmBE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2B36a+23sk0kfYV3r7DHKaS8XbyE24ir8pBnSlcUiel2zoHSgarbvz0cGlSJRZ9Z4ZGitatsyRSBnRFOc5Jnaz7qysmcQ2Qb0Eqf2qlWHN27JFYftaq/ZsOB65stgrNXf9gOr2xW7OR3WR/zllJkvRozpj7yrnJdPEgSDcihuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ogK5Ggpt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jy6hGgCZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AIH3E9012793;
	Thu, 10 Apr 2025 18:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O2Ono6OA3BAke9hkUz/nwsFZ7tWLh9LdZOzoBGlSm7M=; b=
	ogK5GgptTmxNogVmZbaktNQRxS5TZEXfddBKnATIaQMTaxC+ucoyICjhnXPlh21L
	uM5hhJJgc4B6b9voFGfXYcM2QOw1T48VMmewytWolMAM3Z4DX+OTvf3lHZ8io6S8
	FxHoV8IINyzYAxRJU6Wq2O8bmWBqvWbhpwuNLQ6PM7DWunH3H2kniYwpSA5GViyZ
	KQoVATKihwlknByVUrjTLn5Cx0uMb2idrDzX5PRCh74B/J1rWQ3STSjTaBCXQNZM
	dfcHOav5yw5PTnJd6SoS3frEEdkKDlTC4p/8Kgdj0ImHwMCijeT9gB10rLz0EMUx
	ESLzNynrCWzdKi01YwiStA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xk4hr1x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:42:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AI9rHv022201;
	Thu, 10 Apr 2025 18:18:17 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydbn9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcdzgcRhDBUEpZQTk3onMqjpaovalIxzMzvK80FxWoIgvUMB3nrsrGDdNrWaYk3pj1QvlRrt/2B/1sqzdD6oLszVB0QZPfyFm9ksMvg6kIp/iCGQ/e0gqGTkxNSP8JFQsJudJN2yLin1Wj/txFLw0ES2YgaA9h1QppN1vTvFIORFGvtcI+XyADqL5F/Hw1J4qfzCB+oXNgauCk7ZvtnhkKbAHpG6PeAn2OYJ4oGXz3xoxk9TDmIxUkGEjDb33CkW0q/WDQ0OuUBAN+pcb4VF1tpbe4OIxnqJy6QyXG9M8JgimJf81jIE5Qwohxq4LCKVcVbd3BJgf56UCxMfSBaeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2Ono6OA3BAke9hkUz/nwsFZ7tWLh9LdZOzoBGlSm7M=;
 b=kV0coq9B/dnfghnoZhG0idOcegC4ALuqMcn7oplVfHF2mNyXDEXPAuVPkdVeQYi+EcbAKM7r2rvMRido4xIU/CEZAgzD0ThlNN2ZBLD5yIzuWbG0AEWkIDzDqXWAxeAvPMeGUJJegQt2Yryb9io8H3rOpw6l5mbLFutrQ2/hB2JdSWexzADysBVXG156AOHruzG+YKuscta7AM+5ZGQL1cKKX0OMjVPHEZUCxIdoxU3hVsN0uJiX2aG0HKHnv5ti8UH6+HG6dSYuAD3fMq5ebB0noZrWYayJFZ7x//UCNgD7Byo/OUM6nqr8F9FZ+z7T8lvoMwd4N6h/0jxFQOZuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2Ono6OA3BAke9hkUz/nwsFZ7tWLh9LdZOzoBGlSm7M=;
 b=Jy6hGgCZ+1eyOuRWXth55DznU/uhbyRkd+d3+8lcy/iM4dk4qFWigBYeVC/dnF0MA/JikrB2iOF7LmFc/3E3s8ub6s+KNmscgUQuo3mvDiEH+A2cOziR6iqPxhxaxgnZARntrR1mnEafGAD44L1zmAUNQHdVmsNrIPVP7VLfbNk=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CY8PR10MB6683.namprd10.prod.outlook.com (2603:10b6:930:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 18:18:13 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 18:18:12 +0000
Message-ID: <3687346f-6a58-4e0c-bc95-da4d9322e11f@oracle.com>
Date: Thu, 10 Apr 2025 19:18:08 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Bryan Schmersal <bryan.schmersal@bossanova.com>
Subject: Re: [PATCH] Import CHECKADDRINUSE from errno and drop "errno." when
 it is referenced. Was causing an exception.
To: bryan@schmersal.org
References: <20250408172722.377963-1-bryan@schmersal.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250408172722.377963-1-bryan@schmersal.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0543.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CY8PR10MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e628bc-5a0c-404a-532c-08dd785c0da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEdRekVNc2VTa1lzb2YyaVQ2dmdWZFJHR3BTdnJhS1VRRVZBMTdocUNqdGhr?=
 =?utf-8?B?bkFCcWV4eHlHa25KT0tCbXVwRWdZYjIxeEF1VlZPUGNJOVh1Q0tKOWdZM1Bj?=
 =?utf-8?B?bVdUcThVaTV0T2w3cGZoY3Jla0Ztd2grK2ZEV24yREpTU3oxWGV3cW93OFN3?=
 =?utf-8?B?alA3ZVlyYXQySG1aelJ1VGxDcTI2RndzMUo0K1ZKTkR3ZEtoOWM4K0RMbjJv?=
 =?utf-8?B?b2RDRkhCcG9iREw4OWdiZlJZZ0V1VTJRRG4yRnBNaGdrSDNzRFpDOUJ2Rk9y?=
 =?utf-8?B?NzhRNmFxZlVKcXRMOFd0cW1mazdyaDFRVmt4eW9qRkFac2ZNSm04UHhuaDhN?=
 =?utf-8?B?YmxZVTRjN0VrM0poSlAwZjkzK1RWSnBLZXNLMkdFb0l6amtNcTRrc3N6Vjgv?=
 =?utf-8?B?a3o5TjBkWkY5SktSTXl2OVlPWUhpanlobDN2WWJLenE3TEJya24xbEVYQzg2?=
 =?utf-8?B?YnJoQTkzS3ZYcnFCaGNGOVlwQzZrRlloVXNzM0RUTjhUUWhOUm8yVG9GVzY0?=
 =?utf-8?B?bGFEcHJXYlEwNndPbE1EMHY5OWEzUjRCSzNhWkxWM1VGZHdWclFwNnk0VTh5?=
 =?utf-8?B?ZU1PMUw5UGtwdzA5cDd1bVk5T2VXTkEwdzNKekFvMUhIWWdCUmFueHVRSDdw?=
 =?utf-8?B?T2V3TmQ4V3F0YzIrcVhQREFRS2p1bnRQL0VyM0N6RCtaMDB5UzhaL1g5cGdY?=
 =?utf-8?B?bDRlb0Zsby8vVkgwckNTblg1YzUzN1ppRllTa0dkY2R5QnZZMEdEaWNQdEFl?=
 =?utf-8?B?a3VKZ1RqbmpMSmpZNE5FOE9JdlFQOExHZE13QVh1SDJIaTZtdkdtM2RDTjh3?=
 =?utf-8?B?OUhmWnM3b254QTRlMmhnUjA1L21RL09IOUJDU0ZsQU4rME1NaGthWmRxYlZl?=
 =?utf-8?B?SXdnUUNadzkwb2tkVmw2OENQQldrZ2pDbTc1aXpXTmY4RDlpL3E5NUk1Mk82?=
 =?utf-8?B?bmJ5V09kVDN1ZFUwdEF0bXcrVUZoUmtLVmtqOExOSytuL3dXTlFwd1hiTWMz?=
 =?utf-8?B?QkcrZlRIRmZiZitQaUtjRHovQ2x4R1NzZitSRjdEZDNVWTcvZkQzdVBBbGRY?=
 =?utf-8?B?b2d6K01jaFRLcFl6eW56eDU2VHBXMG93VSttZ1loeHVwMDdXOUc3VEQ1eHpT?=
 =?utf-8?B?NytVT01rUlN5OWRPKzVhaXkwZDh2RGc2Q1Z0dUhPL3M1TFhPWWV0a1lQUlkr?=
 =?utf-8?B?YXVTS3NvNFpUV0w0MjhvS0djSFYyM0ZidkM1bjRvdjZMbGVHRWdHQjZ5Vjdh?=
 =?utf-8?B?VWI5cXRrU1AvQ3A2WSs0ZEJpYTZSbTN2bklJRllRdEJBbWFESnkyczFScHNr?=
 =?utf-8?B?bmxSbDdPaTBGOFovc3VxS3g1RFFNa0FhUE9tK2ppZ0NJeEhSTGU3VDJPYitV?=
 =?utf-8?B?amhRUmRQNmVMTW1YWkhsODlzNXdMRVcvb3JMV01QNlk4WXpTeVR2VmRObVJs?=
 =?utf-8?B?R0hMenJDeTJOdXBEeEV0R2ZXWmpUNU9NTDNLaG5ySndHVEFvSjlqSHhaeFpF?=
 =?utf-8?B?alhDTU0wTGt0cHJUd2FObDV1MFlqKzNHYmIwQkJMd0I2ekRxdG95MmtkOVdp?=
 =?utf-8?B?Vm9qUTVNNXZYb1RWRDg5dkUxTjNDbmM5UkhIK3RoSVBFb29jZkpueXFPbmR6?=
 =?utf-8?B?b1lKMXkxbytnYW5Zbnd1SVlONk9iWXNyazZ3TmZsdmRsV0ovT0JPYmlpM0xq?=
 =?utf-8?B?SVp3M2xKVUduNm5MOXBEdnVJcVpGMCs5NDhtSjNVamhxY2lrblY2aWdsT2g5?=
 =?utf-8?B?TWVWR0hDcFhJeTZhNldRR1RyQUoxTXkrNTVrYUF2OXBZV2tqcElCVmxFSVZQ?=
 =?utf-8?B?UFZMWC9rbXN5S0lQZzNqRXBNZGVnSGorRG9YaXZHMnhzVHlwRzRSMHZURmNM?=
 =?utf-8?Q?R9zcG2nR1oSDd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm5hTlRpUFdleG5wZFFZU0NpWlFaOXovNlZDZmlXYnRLU3JXVU5mbHZwV25U?=
 =?utf-8?B?RlFCb3c4dVpEZ2I4QTRIeThqOSs5N1F5UmFVU2w0RmF2Y0xpOTlIZm9NNzNy?=
 =?utf-8?B?U2lkbHRRQjR5NGlwa2RuR0wzbXRLWVhwazRhMm5zdWFrK3hjRmp4S1dqK1Ew?=
 =?utf-8?B?dmxEVXpnV2FBUHkrR3djcGNOallxQ3g4enZ0bDNDL1hMUDV3c2YvS0JsbzJh?=
 =?utf-8?B?T1VkUGYvZjd0YnVwZDgya3NnVzczWkZZZm12ejZ3WnVaRktpQ21EUmx4blhv?=
 =?utf-8?B?cUlRZ0dSMmNveHpidlB3WXpyanlLWkZQMFRMakZ1aTF6MGRYcjUzOE1zWkQ4?=
 =?utf-8?B?VUtaclAxOEYxdnQ3aDhOeU9VZFI5N3RkbGE1T00xYzVWeHUyVDRRYTlMN2hV?=
 =?utf-8?B?NlR0emdtZlFPc3VzZWhoSXVudVNMTklETDVKQzh2YnRSNXQ5NnF3bmh3REMy?=
 =?utf-8?B?clpIYnZhVzB3V0J1blFjTGVrd2ltb1VZUTFxdFBQTXlLeTBWUWRhN1hyTUx0?=
 =?utf-8?B?UjhrRW00MEZQNG5ZNEVNelVIcEhmYytwVEtSRHlGUHpPQmdZRkg2eTFFL0Ir?=
 =?utf-8?B?UUZMRSswMmpwNWlmNVZQSkxtU3JlT2dBU0pKUXFjSkRHa0ZGNEhmNVlEcTBP?=
 =?utf-8?B?WFpTaS9EU3pxNTFBVWtpc2dvNGJtRTh1NEg3ajJoM09UcUtjemdQMjNYeWk3?=
 =?utf-8?B?TDVOZ1FWaE9wWkppODBmWmpnZ3lpVUJVZFM4U3ROVW54MjZNMjhHdlBlYmZF?=
 =?utf-8?B?eDBIM1IvMlNxNkE4dy9IL3JQbHBLenJVMm5wdy80ZWxYNVpUaTZTNTl4T0Nq?=
 =?utf-8?B?QW94TVJGaXlYNUE3WlQxUE8wZmRTT1dveHM2S2FVSjdUSlN4REdqRGcvSmNI?=
 =?utf-8?B?V1BjSVA0L2ZHUGc5MVA1Vk1pcGppSEllN1hjU3c5RmE5UEJxQUxoUXJhbnd4?=
 =?utf-8?B?UnRWRDBabkpGY29aVG00S2ZCRmE2WHRDOG91MEdMM1VLcFQzZWlLMlQyRnAv?=
 =?utf-8?B?V0NKQzd6UzdUZVNNYUIrdVc1L25ta0FaUU1BTEMyVU5MTHpObnA2eis0WWJ0?=
 =?utf-8?B?dC85ZlFtdDZHYkFlZm9MdGt2aE1tY29LblUyQ0JEK2Z6NFIyRy9RNmFsWnd0?=
 =?utf-8?B?dzJydW5odHBoc3QydGtWTHlWTjdCNVpYN0tlSjR5bEd1eDFhNy9lU2YwOGU5?=
 =?utf-8?B?eVZsOUJocTlpaGYxckNjN0FjMWtOTGVZNUx6R2JaWmhPcXBHYXQ1b2hOMU5T?=
 =?utf-8?B?K21CakVucU0wT3NMcHBHRUlDK0lCSDV3VW9Zb2RWM25KTVU2dDllMW9PR3JC?=
 =?utf-8?B?U0dOa2Q4UENKWTZwNVZKTEE1YkxZR0R4OWU1N2U3SDNYb2xEc2pQTGlYeXZT?=
 =?utf-8?B?T0xVVEYrRTJIREtqSVU3MzYyTmZrV3R3WHR5UklYS0Z3SW51NHp1RUdBbzdE?=
 =?utf-8?B?UWkyL3kyUmY0cEEyTjd4VTd0MlRrUmFXT3dCUFJDMW5EdUY1akI4MTRXcWVl?=
 =?utf-8?B?UzZ2RldyU1Y3RzMwRllLZjVlMGkraXROWmcySUNDbnM1MTZDUzUwLzJUY1B4?=
 =?utf-8?B?bzk2UnJJMVR4bUdJblIyVkpRbVBuSUF2L2JoSDh1cE5WUEdXbnZ0ZXBoaWRI?=
 =?utf-8?B?TzBIMEhYRTNDZU5FTVd1M2UvTU5pb05RMUhybW1rNlM1cm1JWWtpN1JRQlRG?=
 =?utf-8?B?YlRneUtYRHhHdFVLaXJ3S1VMRDhheUdHU0pNUFQ1YTRmQzZmUVdvY0NYNXpm?=
 =?utf-8?B?Y1BuTHBCeVpSclYzM2VML0pGMDR1TkFGS0JWZXpYV0F2ZlhUK1FLTTI2cHNx?=
 =?utf-8?B?Y1RURDhuR29tdktjU3hYL1l6RWtYQUVZUnhXR1VWZWNFR3JGLzU0bThjelpF?=
 =?utf-8?B?cXJsdlNjSFdyaTlMbVk2ZDNVNXoyQ1hMelRhVXZNZWVDbzZsYkhabUsrRUh0?=
 =?utf-8?B?akZzeUZHamFINFgwY0t6NzA1d0xQM0V2ZnZmeTI1NDJtemN6eDFVa2NVRmhv?=
 =?utf-8?B?c0JtdHJwQ1Z5TkJqOXRhNk5Kd01zVW1UK211ay9WZElmczRONTZoZHRSZjM5?=
 =?utf-8?B?TUdoMkZtb1JUd1BFc2t3TlpwK0NGL2djanZpR0gvcjdMcU95b0lWZ3hZWTha?=
 =?utf-8?Q?jFpQ6KtL2G9JhYJdX/VVoN6T/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1ADRCP1Y7DHGxNzz9sqKUmeuHEDVEvUrmNCv4ceLQsg28DMVb8Vp1qcRz6Cw3eg1A1vbUSLv+/iL0S3xYCLYNg6jDDqf/biw9/JHLXODQ1xoehUc0FMolUuROhkRyKjqitPcJP41b1sXYoQa1HxgLufrxFSZC3KTBOetmgPfaBzO5kqqlauoCGZpaimuMdkjvB/K1lmgUOtRN5zhYJbkkKTNFEDThu5lXsNQvyk1pE8jkACbL1hnFoX/huKhIuL2B8v6O4axyjW0UOYso51bZBD3auvkqPKmaUVtPcZ3L0DciRFfI2+taWp9dkrzhguWHdDl8/YLBC05chTT/Qp2t0gRdOb183/Sn9WxWI2sM+GQcBaJKaYpmVrnvpMPJ10O6ji30+6yJ0Gi+/BJOTN4u08kMUfr0CMe5XTSCK5HAg4tf7wwyE4GcXsxuD5RfugOd+gP42oxczWXRyFbBUK1v1+UZ0V7zC5V/jcV+hrZb3BFBTjLw5UbTGbdu4Pl5hRB5CAEZNlKhY8+QyreIMQjDwGmuGzRtkb/xyQAo/IJpAhflmNMtacYPS7LjE2xOC46L293BxaYb6Hicd5rGW1474Q2NOGcccjd6qtPD8uW48k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e628bc-5a0c-404a-532c-08dd785c0da8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:18:12.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQuItaOS1l++BHXeN3KJGZaUYaUcKAmuAmVpCYq/o4Ou9ND3YZo9MRzQ0i/M5s8RtgLOXNipjjsqYg7S7bLWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100131
X-Proofpoint-GUID: b8SypPpkzzb5qPTMcvbDzih5wu-r4WEB
X-Proofpoint-ORIG-GUID: b8SypPpkzzb5qPTMcvbDzih5wu-r4WEB

On 08/04/2025 6:27 pm, bryan@schmersal.org wrote:
> From: Bryan Schmersal <bryan.schmersal@bossanova.com>
> 
> ---
>   rpc/rpc.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

hi Bryan, thanks very much for this.

Applied; tagged pynfs-0.4


In future, if you submit further patches, please remember to add a 
Signed-off-by: line.

Also, it's normal to add a subsystem identifier to the description, e.g:

	[PATCH pynfs] …

or:

	[PATCH] pynfs: …

which makes it easier to keep track of things, especially on a list like 
linux-nfs that deals with multiple kernel subsystems, as well as other 
out-of-tree userland elements like pynfs.

I've fixed up the above for this patch.


Thanks again, much appreciated,

best wishes,
calum.


> 
> diff --git a/rpc/rpc.py b/rpc/rpc.py
> index 124e97a..84088f6 100644
> --- a/rpc/rpc.py
> +++ b/rpc/rpc.py
> @@ -6,7 +6,7 @@ import struct
>   import threading
>   import logging
>   from collections import deque as Deque
> -from errno import EINPROGRESS, EWOULDBLOCK
> +from errno import EINPROGRESS, EWOULDBLOCK, EADDRINUSE
>   
>   from . import rpc_pack
>   from .rpc_const import *
> @@ -846,7 +846,7 @@ class ConnectionHandler(object):
>                   s.bind(('', using))
>                   return
>               except OSError as why:
> -                if why.errno == errno.EADDRINUSE:
> +                if why.errno == EADDRINUSE:
>                       using += 1
>                       if port < 1024 <= using:
>                           # If we ask for a secure port, make sure we don't



