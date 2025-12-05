Return-Path: <linux-nfs+bounces-16961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E7CA8037
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Dec 2025 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA15A314B5FC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Dec 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA91317711;
	Fri,  5 Dec 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jD/IcvkX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QzXFeGQU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A4313E21;
	Fri,  5 Dec 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946027; cv=fail; b=l3DxY8mLxCgGCStS41/uPPKxSkQei6y/yLt/G3wfrQXOirnJUNsJXIs3GNMyobann4sN8OFh+U6THGwkroWeK/zsmO0FOfcIhS44pqaOw4wpto/sQEv1lOVUDCATI5ZmXW1SzGcyXjPK+Wmk5FYZ2lxi8oXIGau+s6Vii8QDJpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946027; c=relaxed/simple;
	bh=GyMNyTplogLF7X/HrKmVprj1s/oimUyYtgQRVkKSxec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P1TJQrYABPrXAgnWky4j63Jlha/Oo4ViXshU0uriUqUTXu9FWd8qaeqXRgt6J5VsZVgKm7bP3+EHZotm4XZE1IJFd+LXgJGxKV4dWIe+7DzVZosp4IykjbHZDGOXz7d47TH3KEo3LskKk1cNjH9STBrmdmGfOTIV5BwbXEj9v7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jD/IcvkX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QzXFeGQU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5ECXMk3931481;
	Fri, 5 Dec 2025 14:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iLjYk1CDZ9F5DisRWf68ZRsiGDlZfReg5NEvJEfQabw=; b=
	jD/IcvkX3OzWZV+e+gO55f/lSMY3HKlBRp+Tb//VebGsZI7H/apt3g2D4OE8kHZg
	BPULmAm+E3pnivUw3jBELWArJbvQj1AsXNo8CzotfdKaD2BZ+18mTmgFPdfKfPhX
	jlUgklzxmLTn6Aq1iKdeZuH7fNnu70RIsk+ziUjPnyZZbvLnm8YDfNu3urFVypsj
	bZYtgYSmQMtmxczv+WULRRJtomaYTLEIvxk8V5szEWZwi3c3qJDQvdJyjUMJ01Vh
	nUUjhkXoYZrne+BokeCIVV0YsAJoWORbj//6NNri80gKkO3vEL9EIiR6IzmnpYc5
	LiR4ZHiL4r7Jsxr5uXWlQg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wnj9ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 14:46:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5E7nhm037938;
	Fri, 5 Dec 2025 14:46:31 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9d9n8t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 14:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPIYQc70rYzSbC1uyAAy7CA2+aOKqMKr3hvLLWa/5WsAsXK66S2C6kUF+wLzlmJUXqqiJUNpPwgxmCW9//K3Vyg2y1CsrmY0AV0Ml0P19V8YquQBK31GWEmMAsBi2Ptx7KMsiaeRfNfNrMNgYI1FRxGtVTfqgTbGBBngLr3/NiTcg8L10/hSfD6YmZNvFT7DHcjMNbxacpYT6cYauku+3IMUrdSTQyDFQjGe9MDQ/+wCyAXEyfGCb9liSRp/cggUyGSXY+LeMRwZUJetLrzXDlyeWYuqnRPOUEQ+Ggmb5u9zrzQz+xNuy/xjXV7xxLUGunsg21zNqYafwWqpHFaAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLjYk1CDZ9F5DisRWf68ZRsiGDlZfReg5NEvJEfQabw=;
 b=KYlnw72JiEG1kv/jpynah00ezGsjg5RKki/S2XHhdLj+IjxQSD330/LL/oG6Mtb6nuSFJJ5kkNgqOpsSIzIWPXvfE4DHXrLixPQmYfkwfH5na+aOEQmzCuXZcrJICTzmTvKSjPK5D6hc0X6TzZ4h38lYPgrt/bbPXIhKZqO8oBRqYzIwsH4Q12um9JkzVQVuOxlXMvZVR5SzHhbyQ2eyaKfg0spQeN82rE3X0UHSU+9f02a9CCm6XhEYpHijepTdkC7lCUXSsIKfCNqXYumn0IHB6CFSeP0e6qghlqWFcTyyNNm8M8qxSs//DL+eONA3bGTEOlNO58P7ffM1PfAU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLjYk1CDZ9F5DisRWf68ZRsiGDlZfReg5NEvJEfQabw=;
 b=QzXFeGQUNKeMBcggsQBeArP5t2nyVhFoAnJSz77cwqt0rRW0Z/NA3iQgMMAPkcugqQK7KJkn7zfxNQ8f/C//VLxtveFOnevvzoLEQtcuJLHx9vjENap7GKJIxVXOQzohUxBlp64zija+z6/Als52h4QQDXhYyKKSphF/QhgEQi4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 14:46:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 14:46:28 +0000
Message-ID: <85120c29-5b60-4d6b-9a90-e15637c57e1b@oracle.com>
Date: Fri, 5 Dec 2025 09:46:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] SUNRPC: use kmalloc_array() instead of kmalloc()
To: Gongwei Li <13875017792@163.com>, trondmy@kernel.org, anna@kernel.org,
        jlayton@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, linux@treblig.org,
        ligongwei@kylinos.cn, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20251121030139.53241-1-13875017792@163.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251121030139.53241-1-13875017792@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 988eb573-d164-4d65-f24b-08de340d1266
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MkpBMmtMNm0ySFlNUjgrSEZwd2d5Vk5vbnhnRjlKTldCOW51dWZuVkZKbXA2?=
 =?utf-8?B?MWo5RkloQVoycjArVk1JTjE1bFAwcWwyMVUvYU5ETkwxc3R6UWdJeEpUbTRu?=
 =?utf-8?B?bmh6L2ptU2d0dzkxSnhmWmJuSmFFMFRlMVRrVVZ0NVZML2hGRWUzbStIS1dj?=
 =?utf-8?B?eUxVUExlQjQ4c2dRbGZYclp1Qk1MSmNMZ3lFNzNxL0p3U096dU5PQ3A0MTZw?=
 =?utf-8?B?UG5QREovcXB2aUVjSFpnbTVzaHFDczhNV1F2T3ZpSXlHMUR0Z3ROSXZObk1S?=
 =?utf-8?B?Ym52eENGTGZhTDU5UDk5eHA2MkplN0pmZnFEOGpvai93d0RQMmY4Q1BoQjAz?=
 =?utf-8?B?QTB2RUVkejhKS0tkbTdpL2V1S3VOSGNLdVpkZTVKbktPR0gwWWo4R29ER1Vx?=
 =?utf-8?B?VnZJTFZqNUh4ckQrRjhSUHR2Y0kweXkwb1grajFmTnZHVEQxZ1dLRWxOQkpF?=
 =?utf-8?B?cFIyZDFKbU5PK01CdUJadW5jbkRWZnpieFBwZlBzTHlnZFZQa0ZvZStqWTVn?=
 =?utf-8?B?Q2l0S3FuV3BnY05YZVJFeUVqTjlhNjFCdG1sQi9CaTZ6V0k4UVA4d3dMRXZK?=
 =?utf-8?B?NXk4SGc1djh6SVV0YnF5cmh5b3lLdG1xRS9vUDRJSGdwUGFIZ0Q4T3Y1VWVY?=
 =?utf-8?B?RHFMS1BrZHdoclVXZ0JRZngrZ0tIVXpnSEJ0UHp2WDdzdTQyUTYxNVNlSWRU?=
 =?utf-8?B?NnNSOGVFSG04TFdpMWtveFBNL2NCZmVZRHJrWTh1d1pkTUc1d2s1UXRPR016?=
 =?utf-8?B?ZUVMVzgwYUJyc2YzN01XSGoweE1ZODFnK3FnRzJuVHlHZjdQUXh6MEV3Nlg2?=
 =?utf-8?B?azlzQnh4VkxjendqbEVYQndKU1lZeGs5WlFENUZnUHFpUUpaYk1Cb0paWVRP?=
 =?utf-8?B?QmFZZW94T3A1cGNkUjR6LzFYR1RCamtxdVlRNUhZdWV6MkZvS2RmcmlWMXJU?=
 =?utf-8?B?UjlLM2VqSXFaRHU2S2U2VjFwSU5XOGpYNEJzcUNxZEIySFFlazZLU0RNMUto?=
 =?utf-8?B?YUd3a0NqYmt2cnVmbXllSkJYaWZSTnBEeWR1VVZXTTRLOHpPNmhSM1pVaFYw?=
 =?utf-8?B?YVd1NEVhUW1qalp3ZGpCVGNkanpwOGVNK0NJR1B2V243d3o1Q1JFQUkxZmp6?=
 =?utf-8?B?cVdST0N3SEMvUitZbXJxSDZxNnJyS3Q5TlUxZllZMGpLdHgzL1B3N0svcUFu?=
 =?utf-8?B?R2NLQ2Z6RFRWOXFuTVh2WFNqdDR6emp5MU1KZWZ2WGhRVFEwaUZBYWNPTlJO?=
 =?utf-8?B?M1lGemJpZmZNVVN1Z0hlS2NKQUI1RFdQZ2laUTVPRmFVVzVJOEx2Mkwvc0Rh?=
 =?utf-8?B?dnQ3WFlIQlpEZ1B4UVI4Y3VGWkViZGE2eHQ2SFpnR2pVL1BXd1Z4WDVxSzBh?=
 =?utf-8?B?QmI0azN4cVUxSDQ5T0xCSWhzaXZENlh4bE81R3dqbXBFekgySlUzcnh2K0Zv?=
 =?utf-8?B?NlFxT08vdmYySHVmY1BjZElXZHhPVWJ1WWdRbSt1aHJOWUd5Q0dyWGhTc015?=
 =?utf-8?B?YTFER0l5bHhqWEhudFllYmt2cHE2Q2pKOXBhZjQ0eUIzblBhdXJjOFMyZDBh?=
 =?utf-8?B?UVcvVm5zdGdXZXhXcWs1dlpPYlQza1UwSjZIaHB6Uk9RZGJKaFBoek94ZjBV?=
 =?utf-8?B?Q0txR1pwdjl4V0pFUEVSUGk0TjRheU5wWHgvSFlsSExQQjQ3QVdidUZTR2Vw?=
 =?utf-8?B?eG9pWkZEaUlFUSt1RXBqakE3Rm54cDNnMzV6c2h5a1FVdmgrNk03cVJHZGN0?=
 =?utf-8?B?Zm82V1U3VDJueXk0b1JqelBBU2ZwVEl3ZERWQ2FTeVZsUDh0enZGaTc0NnJt?=
 =?utf-8?B?cGNOT2JHT1BJN09YQ2VCbjlxNTdkcjBuaDM1VFJDM25IdGl2QzNOK1EvM1U3?=
 =?utf-8?B?V0F1Zm43Z3ZCR09DUnVpcWJRR09OWXR5cWVIeVdQZFprMHYyZDkvYUx4VU1B?=
 =?utf-8?Q?4YMa5/T47ssnAImVS1udmt99mGOr1zqv?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SGFBMFdSRWFZRVVKUXZTTzRmU050ZU5IL0sxNGZmMUdtcCsyc0hXdFRmN1pY?=
 =?utf-8?B?bHNobEhRRW9YdHpmZngzbDdZbGJtQVNDbFFpWXhzTW5wVkZxZDY1QWFzdUJI?=
 =?utf-8?B?QWdTYVdzQVRyWlM2cDhNVCt5dlFYMUsxRlhaTXpqU1doRzZ3Z1VkY3dxeXZM?=
 =?utf-8?B?V3pyODFDQWxFVFdsc0J6SXU2Qm5UaDdoeWhDU1lFbmpQTTdiQ3F4UktTdXBP?=
 =?utf-8?B?blU0TDFEU3lUR0JVanVqS1FybUJMeVRBTFowaWJrdm5CNG5YdWV6Q3g5UnhS?=
 =?utf-8?B?UG1UTXhLR0pKUFM3NGhWNnJwdHNJS2RXci8rczlpWVB2RFJ4bUJLWktUMDg2?=
 =?utf-8?B?aGxDOHVEa280T0Y4MThLQ2ZtYTl3U1UvaTBlcmYwWU1sdnpBTE4zTmtDcE1L?=
 =?utf-8?B?VmZWcjFRV1NLS2VtU1ZDOTFoWW5LaWQzSkV3Q3hnMHFNRFBmR04zd29haDVC?=
 =?utf-8?B?V1lHVUJ5cjBMc1htdU9OdHBYeStHb2p0eFVqSXNES1BTdWxkUkpzcVJicEFZ?=
 =?utf-8?B?VXNER2VvbCtCd1FxcUNnWUVTa2tpZUYvNmJxVHZnVVZmbEdkYXRPbTVOemFO?=
 =?utf-8?B?OWorb0xoWjZ5ck52eTIvR3YyN2s3Q1ptL3FwazBEZnhzNnZRTDAvQ0h4SWR4?=
 =?utf-8?B?YnplNWluR3haNFp2OGsraFVRaUhMNXMzbVJ4VjZrVDdUSkJQUGZPM0FYMnlH?=
 =?utf-8?B?dDQrYWN4cXJ0aTZjTVJncGZBZjFDRllSWUtET3p0dEIrUTJvdmdpTzZPeXNR?=
 =?utf-8?B?SG4vTjlHMmluN1FoVkdHOGJsL2JNWmd3eU1PcTR4VjNUMTVQbHMyR1ZzZDE0?=
 =?utf-8?B?bndvNC9DU3Q4S2t5NWJGVGlVcDd3NG51eVYzZEdDaldFS0grWEZIL2ltamtR?=
 =?utf-8?B?anNFUjArck5NdUxkUjF3cXVPTFk1Vk9ROHZybHFObktCR1ZlKzlvQnVMNXBv?=
 =?utf-8?B?dXQzWmlsNkRZWXZVazlnVytibTFmdkpSRU9nWURJcHRDbTFiVWJSMFdCMGdZ?=
 =?utf-8?B?NVJyZUlHalkyTkllczd6U21XV2MzK25Ob0krb1RmYkRLSDdHOVU4ckxSUFhY?=
 =?utf-8?B?R0UrV29BVGpXcWcrVllRbDB2bmpBQ1VROHF6L0RCM1pNanBhWFJaOWp1VXRI?=
 =?utf-8?B?SXFpU3Joci9yN0ZSeXdyYk5tOExHVHlOUDRHK3EwWXNBdUYwVmxFeC9lMU14?=
 =?utf-8?B?dmpiNXFwUDhieUN4WCtIRUZsT3loTzJycnNSY2JsK1JtaGdCeDBWYWFHUHNU?=
 =?utf-8?B?TVA5Q251YVZYRnplNXZMSVhDeHlyWW5qMXppanFLRzUzeTZCMzRmbFFoWCtU?=
 =?utf-8?B?a3NkMVUwTnp2YVpITERrcTJ6OVQzVUlMSWVRYUJackxlU3VsRjFwS3JPRC9V?=
 =?utf-8?B?dmx5b1VBQStEczhvV1VOUFZ4V0IxNlhkVXA1RVVqazUrV1dOdTFJVlNid2dX?=
 =?utf-8?B?bkpIdHNqNkd6M3lwSW9XNVE2RjM5WElobHpCc3lra1lyUThpVk1FUTlKOGpV?=
 =?utf-8?B?VTA1b2dIeFNjSGwyVGQ0RENxZG8vcm9mYzkvVm1pZ0kvYUZISEkzUUpEWVJC?=
 =?utf-8?B?cU9CV1U2d0Uyd3RqM0lIcGE4QzdpNmxqeUFFK2dnUXIzWGYwU2lRUVppNmM1?=
 =?utf-8?B?blkwUkZkcVVVcTlJZktPYmNOQnhQMHF4bVFTSm45VkhkOXNkUmFJVkhNK2dD?=
 =?utf-8?B?ckQvQVNmYzZJcDd0UFFqUTRtdHUyUHFpN3dsMUdGSmVxSUIyU2p5YVU0VWt1?=
 =?utf-8?B?ZkxQZWMwcnlZSjVoeGkzeVJad2podklnRjluNk51dDBOT3lDZjF6b20ra1ZS?=
 =?utf-8?B?M3JkYXBEeXdtVHF1clVYREpMbDJlTGR3ZVhFWWhhSVl4SFpkRzQvc1p2ZURw?=
 =?utf-8?B?SDNicmV0dmxMS3VRdGVrOFE1NVMrKzljRHEwM0ZqM2czRUVoTnBpakQ0OVpW?=
 =?utf-8?B?QSt4M0Vua0hFblh2VTMxSHhQWUhSZFpoVVZDRXZzS3BkQ0RuSWs4bWpRZDhs?=
 =?utf-8?B?MjJzZzArWEUvUXpJUlVWYkROMWFEMlZIUjhUY0UxYTVTRE93UzRxeDIzN0My?=
 =?utf-8?B?QkswcnBNUEVFajNLbDhST2o5VWIyNi81cExmQUQxeWdQSnplY3JnT2tGZlFx?=
 =?utf-8?Q?vHsJOWohj926xhcEaQ+yu78ep?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bk86stfeO4tnTe/VE6gGvvsTTvupKScqzto5DXZXXm7x2iwMEKRLXQn+kp5OzbFwZ2AFJzwhRgKMYGVXd6ukY+njRv8rb3CZ7s2XhberZzpKGurbViYWgfRAswvKRk751DVnmTtr3Fd2v7ouuey+lu7qP0kvIcqgVjJr8lEt6Fx5Qf5Jl/3tZ8cB02FQaRoXd0T9vynFtpwoKUJIn68iKm5XouCQRUO+bagSSP0aXJvajedSfQjhFwg4CBVRzQoMVt7n1gDmzoAWW7Q310h1mOUTETfUoBe2BeYyCCcgCSJ7EGgnwGIN8ZN2JTWo3teXf2GCK3Xd7HICtBnQsvaflaGnxpar7q66j3kYsgQv+YHfJmLNvAnEZEOnsSCkokmrxkPbcndqFZlazGVxIdzhWEPIPw5QfP8BySXAUoyBPtR6yZRQpHQawZcre558fngNJkOkLvXGcdJGPanO7gyrxg5vELx337hNqoW6a6w8ZuUJRZqQhU6a5p8BdlDLB9730+G+VFWqGvSCDSjquVPafOzcfBKTZ8PlX/l62iiH6gz9JXFcXToTBQTea1s6JwvUP/wQe9oNYa5Nulb4FWARJqpxd5M0+hV9oDfohXy+vBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988eb573-d164-4d65-f24b-08de340d1266
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 14:46:28.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYFtXWLDprIlSs/kta6QwrjeonkTuTVtHwAbRLAnKCEozifluIHMu2sQoV3n9zw9/N1bhlUaJ3OKiGAOMe+2Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512050106
X-Proofpoint-GUID: fMRstAqoeiu8fubdt3-3gyuMAWbgjVrf
X-Proofpoint-ORIG-GUID: fMRstAqoeiu8fubdt3-3gyuMAWbgjVrf
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=6932f047 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CJRuBsAsd3EcaBWHjcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNiBTYWx0ZWRfX3qO1PSAQAJEX
 7Y1n+VS5vtDc63ht9OXCZip8PvKYyvVTA9/zXoSOj6i29PGLn3puFUHput/55d4H3dHyIgqyn8N
 YrLiBVLcgfD7I6HWU0XYUWFrnVU3NDEtcphqGHWHw9uVq+8/wDKt5FPYd7RqYwOxKrY4CBo2Xdv
 sOA0sJj1zjrKZU+5m6B9eI6Stq8VSEtgqnznwcOt8Pb3rmgCIrXBlA9/IegGKV7bIRk13MEs9qE
 Ug1thb9M412LFhlIjE8CPGOLqaLFA1fSwhilGY7I5h7I+GfEpW4YYwBUlFdh/E0Yi7qa2ZQxu70
 +fwJhntgZtambdPSJ8a9VVHhSei4Pm2rJ8E/jUKUCxP66fqZEbbKyWu1DIGS3JQXbvyJhBGoedP
 eVyk3kY2MpLMyRdZJS84msa8s0a/1Q==

On 11/20/25 10:01 PM, Gongwei Li wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> Replace kmalloc() with kmalloc_array() to prevent potential
> overflow, as recommended in Documentation/process/deprecated.rst.
> 
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>  net/sunrpc/auth_gss/gss_krb5_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> index 16dcf115de1e..9418b1715317 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -404,7 +404,7 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *cipher, struct xdr_buf *buf,
>  		WARN_ON(0);
>  		return -ENOMEM;
>  	}
> -	data = kmalloc(GSS_KRB5_MAX_BLOCKSIZE * 2, GFP_KERNEL);
> +	data = kmalloc_array(2, GSS_KRB5_MAX_BLOCKSIZE, GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  

The commit message's claim about "preventing potential overflow" is
technically misleading since no overflow was ever possible here.

1. GSS_KRB5_MAX_BLOCKSIZE is a compile-time constant (#define
GSS_KRB5_MAX_BLOCKSIZE (16))
2. The multiplication 2 * 16 = 32 is computed at compile time
3. There is no runtime variable involved, so overflow is already
impossible

kmalloc_array() is valuable when at least one operand is a runtime
variable (e.g., user-controlled count), but here both operands are
constants.

This appears to be a mechanical/automated cleanup patch that follows the
letter of the recommendation in the "open-coded arithmetic in allocator
arguments" section of Documentation/process/deprecated.rst without
considering whether the recommendation actually applies. The
deprecated.rst guidance about kmalloc_array() is specifically about
preventing overflow when array sizes are computed from runtime values
(although admittedly the text in deprecated.rst is not explicit about
this).

Aside from addressing an (impossible) overflow, is there another reason
to make this change that I might have missed?


-- 
Chuck Lever

