Return-Path: <linux-nfs+bounces-8701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33039FA192
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 17:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CF5188E482
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97967346D;
	Sat, 21 Dec 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="baqHDjFs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i+dSaArb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2B2594B0
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734797483; cv=fail; b=WoIGjXOgBBZlRdbwdF9dmErVSx8fXEvSc2SkxD+q48XeaVdVF5UTnUA4Y24CusaBxKjRR9HlDH9Agcmv+YCQncMghup9TQC3gLMykeJEC6WmcB66ewNy76R00dP4Xio0kwj7Gdcv0Le1dXI31Xfx4TFSxzrIutO/lF/fsDoZzNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734797483; c=relaxed/simple;
	bh=KTJUu6NuLbxWivURB51638A02d5OTVddEAfuuiGO+L4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=og9FiOYiqe+75Tpy19YX1NQYVUyEg8tNlB9KklfXo2mzBO+VXrOAORRPDT4L8wORRZn8/VuuNwYTKnc5YK729x24448BBHaspaVL9LqVx/o8uVLrv4W0rHqVNsODa17okE3sozdR26wlkoGXQh4pQdkZdhy9Wr+lfgPb+X5ZPZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=baqHDjFs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i+dSaArb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BLCrcJ3007326;
	Sat, 21 Dec 2024 16:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wrBUdJuensEklxXrH8A+XPzz74yLJTxbmLCaJsG7PZU=; b=
	baqHDjFsVZKG7PybfTUGaG2xJijsP0EMqk1GoIQl29nroe9euexKBUjMMhMhKziR
	ihL/SACqDZvdhLGiIbebLFcxO4i4vNC1p/22Mmlw7IkL5K3mK3gxP3g56Xay8ScQ
	4n7JxgvQMvLr6jWVFQFSSsUXoiv5lFRYiMMMVUlRVZRX7kIP7Okr0c26KZMVPh7A
	uUAWjl2QorbFidz1l6Pbj+lAy8zrnE52tFUo7u2YplG05N14eCwPvZ9auSCOIgWx
	kPGYkNA7LfgoYnD87TP2cMjKCWrY5n5MciU1wxicyu86C9VQxodaeMJz93mnbd0X
	ZNJTMtc7IVIxhj2QPtLP5Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq9jgc1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Dec 2024 16:11:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BLBRi9I027577;
	Sat, 21 Dec 2024 16:11:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nm45kwuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Dec 2024 16:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq+4341wRjNNc43pmvY72rdnuUDH2tNz3oaGWrFXUc/9aH09YzwX/+ihKwaohTLtiWQjvS0qnRFkMiCgWbaaoUerh+ixwk+YX2FBl7yviFtA6s68pTp3NVjjVVs62Z5RHsbPitZ44r+Nj2+dqvGWtYVo32KFxZgRNPWnBMdualpzQaI7uel9DkFPH36PrFjGpm4vHSUeliJvuncORfKhNpMaV7LL8iFuifQ/FtAW9ekIfSRtoQpdF0KD55rH8xr857YD2Jui3gnEs1MRFtAWRHxa5cVNpEv8JMpYV4ZOQF3WZDNRvyfxu9KaCg3BT9pafOEbw+DsG+yHWjpJ0n+rPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrBUdJuensEklxXrH8A+XPzz74yLJTxbmLCaJsG7PZU=;
 b=G+ph2eXVp+lYrWzBIQ8LCzmyPDt2/sKqTBfKGpXxiIopnm0fI64BkERKDdM9VJGY6fCj7RQc/1uEKoPReEjDXR20Mff1/9LMoC1MSY8znapsl3LcGmVutVM/GB0w0pqHnwxHKVpSt/0kg23dogolLIWhEF0NPmUhv92R/pQqjwtkjxjsQzrPaQuwRBuwlCnCJ6xNLQnS/ZmyWn8kc1ql7784pTxyevQjHqOZa6SiK1q+mcLfem7BKP+OGw4Bq1t+3xmWt7GK7yehFtCtN5ZNbxfPzmme8q3KyzEcudx43MVI6U58kfEgkBTjxtZr62aaFFQC+6ZAPKa2+E7iXs7zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrBUdJuensEklxXrH8A+XPzz74yLJTxbmLCaJsG7PZU=;
 b=i+dSaArbX8fdfGB6hgTcEdxjR2zqVEq4SAYoil3f4UOnyC5IDwkAjTGpao2WjTEFVko7u3OtUxC5Fg2vdQflF5djgTZCsr584dRdED+pBTdBVuPBL/QWikTkTNzWLQcEkVOkfTCsWHe2csqElPJP1xuKOBcZ/drbSbBfwsAUgN8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Sat, 21 Dec
 2024 16:10:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 16:10:53 +0000
Message-ID: <270d1fc8-2411-468e-a8cd-efcb33d67e0b@oracle.com>
Date: Sat, 21 Dec 2024 11:10:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
To: Olga Kornievskaia <aglo@umich.edu>, cel@kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>
References: <20241220154227.16873-9-cel@kernel.org>
 <20241220154227.16873-15-cel@kernel.org>
 <CAN-5tyF=bshFm8FHT+s8mX4SJr1OksH59D05dKY7svtehVueQw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyF=bshFm8FHT+s8mX4SJr1OksH59D05dKY7svtehVueQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:610:54::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbab722-0921-409a-16e7-08dd21da0b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDE4RndUeFZtSkhTN3lDb2tlSHBheHJxTU1sSHRjSzB6MWlPMk9QbUVHbEpK?=
 =?utf-8?B?YUxMcDQwQ0dOZm1GUGpZY1k1VDNKWWxIc1V6c3BXWnpSd0U5NHB1MjJVN256?=
 =?utf-8?B?Q053OUkveVZmQ21wakx0aGlFR0RkYmM2RnhXV1VzdkQwU0N3QmpXbTVqSjBH?=
 =?utf-8?B?ME1PTGxFVWpYTE50RnY2RXVNc1A5NjhBVmczeHFLcFQwRG1NRmpObStlMlYx?=
 =?utf-8?B?UWhyZVUza2ZHb3ozVys3US9VRC9UUzNGNGsxK09RMzJIeXZQWmp3NTY3S2xM?=
 =?utf-8?B?Q0paYUM1TzBqb0NuY04rZ0JUdU0rbTB1OXRkTU5pQ2lQUlh3Z3czTEhRbU1m?=
 =?utf-8?B?NExZL25ub0l6SG5Pam9ObDBXajh0d3dPMVN0VDlLY1dzdmwwSHVvUGdSUnNo?=
 =?utf-8?B?QURuWStMYVpwWHpGNEhWdGY0cjZWcHZFeGY2ZU4veGFSVUI0WU9HMzVOQWht?=
 =?utf-8?B?MzNIeUZRNmM3UWFqR05FT3VJZ015d051L1pPL3czejBIN1E3RFIvWFZleFd1?=
 =?utf-8?B?V2tCNFN1cjZqbS9rK0VFeU9LZzVhSGlLZkgrSFhNYllHdTM4a293WGhXcU5E?=
 =?utf-8?B?R1piWStyTHVCQmJtWXU4SHpNa1Nzb3hWYnBzUFlNTWFvWWxGN2VGc3ZEMURL?=
 =?utf-8?B?VWlLMjgxcThwcWpzbkZRVjhRQ1dBTWxRQ0VvK1dzZVRKTXNzRmtGQ3FhMjRp?=
 =?utf-8?B?bEkvNENBQ0RnLy93azY3SEhtdU44dmpuNjMvNDJKRjQxTXVvVWRLTG9rN29U?=
 =?utf-8?B?L3QySTc4TFpCWVhFdU9jdjE2NmNWSkErQlArQU1pSGtmeW54UHdLSEdSWCsz?=
 =?utf-8?B?M3lBakRQQ3FiUGNpajhuRHlrb0k4MEc0SGFnMjQvTFRlR2lwcE9KK3V2dW14?=
 =?utf-8?B?SlNjWmpLMHN2WUJGRHRJb08zNFVYd0Z3YmtYM3RUNXozd2cxREFrT213UXhE?=
 =?utf-8?B?d0ZERHBESytYVFNnZFpGeTNFRVlLSEFaREp3TVpERVVqaFdWeENQNitNWjhU?=
 =?utf-8?B?KzZtc2daeWF1QlpaZEdCY0xTNTMvbTdhdStuUU9OTGtHU2tOTDRQNXhtblNK?=
 =?utf-8?B?R2ttSWVLc01ZaFJSQ0tCb0RJMkpPWHBJNThiZExodURZK3FmdDFNS2s2WEJj?=
 =?utf-8?B?bkc1elJnYWNFMk84VCtuMmxsQjhVM3FaQWhkY0VuWTN4cTRGMUlEQVBzd1V6?=
 =?utf-8?B?L0dkdzhUa2Q3SzBmbmxpbTd3dzBLOGRvWEFTMXc3ZUlFdG9JZzQ5VHhoUFZs?=
 =?utf-8?B?T3A4MWtLSWo1QzY1aUdJcS9VRFZVamFmQmNYazdnRmNIVUh6aXJnQkFvNWc3?=
 =?utf-8?B?YlYyMEJoZ1JKRXRGNDJXRlowRGlYcDJjb2lBMGd5ak9uT1IxWmVkM1hNVnNx?=
 =?utf-8?B?VWIySmZQL3B0ZzRXZjJyOFVNa2U2dVNpMGp0Z0xFbnhpa2oyVTJURU54enNN?=
 =?utf-8?B?VjhxMGdtNzBJb1RuenNjYVhXdnJaY2YzZFJpWGNXc1l2eGduaGR3dTY2dWp6?=
 =?utf-8?B?N3BpK296cmhrbEFqUm13SFh5U2trYlNHY0xpL1VTRWN4cTZvMmdnS0hXRHhh?=
 =?utf-8?B?cGJycVE3L3NmY0VmRW1oVmZvN29UZWdPWnUvZWVLYUE1R0VoZFJpK0lJUndN?=
 =?utf-8?B?Z3VTNFBmWmdrUno4RWlNTitjTTNXUEo1d1BpN2F4Z2lVOHQzekFoSDlxOVNP?=
 =?utf-8?B?ZVVvNit4MCtacDByRE1mc2dSS0RaY2RYcUhUNzJnQ0N5OFZTb2lYNVNZaFlW?=
 =?utf-8?B?cmV6amcrN1RCRGE5YWNmUUNjYmM0YktmRGsvdHFiU0VydWg1YmRSeWMrU2NQ?=
 =?utf-8?B?WGorcmRYM0JZSkl4cVplTk1VNzZrRG5udnFOTFZvL3hRcUlHemxSalc5WkJh?=
 =?utf-8?Q?DyIAZWFyN77Ck?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0xUWlZ2ald2aVdiVVJNYmwzcjdLM0htaWZLR3Z1d1dXSStVdTlEdGJOcXk0?=
 =?utf-8?B?RmZaUWFDUDRiZmZURUhyYkR0K0s3UTFpTkV5NXYrNlhOQnRFNmVvMzFwd2xh?=
 =?utf-8?B?N3FUYlVnN2dKZm9xWTQxTTlIdytHNmFEd2ZHVHVuSlZ5NTd1UitvS0w5Y2NI?=
 =?utf-8?B?QXVWQStoL0pycFU2dnd0Qm4vNHk2eHhRVVhjMGdUTFBIdTg3dW8va2ZKSDUx?=
 =?utf-8?B?WVhLVTdmaDYvVEYwSncxTW1mM3lsT1RJd0M3dmRjTEFETFYrV0RmUVcySkcy?=
 =?utf-8?B?Rjd3Q2FudEtyZlZZdU1ZOFA0SXJ0OHYrWFUvSmZqZWRCZGkrRnhPYXM2MGNk?=
 =?utf-8?B?QS9TM0xxUTViSmJKai9XeWRNZTJ0aHJoRThZSjRqN29PbTlGbEJxWUJEcTZa?=
 =?utf-8?B?VlNyTDViR2l1QW5wN1NyMnZ2SDY4ZkVjWW0zQUJVbXlLTmVtckVhaW1aSTRi?=
 =?utf-8?B?dW56WlpNNUIzblA3cHV6d2xjZ3FKVktkdHRVMi9FNlBnTEp2aEtwQ0daM2F2?=
 =?utf-8?B?R3NzNWs2U0hjaTd2Wm5PY3l3MWE4QWhqNElIbkx0cUJxSkt2RjZRdkhidzln?=
 =?utf-8?B?Zmt1OGx0L3kvUUJxaENpUUVXbG0wYUNMMlBUM045SmVBS2ZKbzBML1RXYWY1?=
 =?utf-8?B?ZDBXY25pSWJsbVZsTVNsK2huM0FyOXdZQnl2M051NjBlWjI5OUZVWXJZOG5E?=
 =?utf-8?B?RW0rTEN1OHQwS0hwUlhRdUV6YkhiRmpXTVBMOThFQ0wvRUhuSTdNMUJ2UGMx?=
 =?utf-8?B?ZzNIaytpZ2N6djhXTUVZbXpYdUhhN1VOY3JwNUZ5WG5sdjJjdHFqZWkvSXdU?=
 =?utf-8?B?TXIvQUhmaFZITmE1RTdJcy9KWnVCYnoxbGp1dzl3WmErRzlqNEp2NlN1cnRr?=
 =?utf-8?B?a0hNcFhadCtFcGV4V1Z4T2t0RHBMR2llZzhRU2tUTFpCbnNNZWloUE5pckEz?=
 =?utf-8?B?WlUxT3pjdFVyUHh3cVQxaWpmNnVkb2s3a2NkRkRjbWJ2SWo0RlFUS0FZSTc5?=
 =?utf-8?B?WmZ5VXVDZGJjOTJqYXFSZDljRUhuRVlCbTY1QythNVVNakxKMVZsVlVlK2tn?=
 =?utf-8?B?cDV3UDRTWGNnU3ZrcHJJWWpJbXdWZ2hoNmo3ZWhWeWhHZmlwcE43RzBML0JI?=
 =?utf-8?B?M1c1Ni9zWkV5aVhYbnVRcjYrUG5Kc1BlcnJuZUFHVFF0MzJQV0RVR205VHZW?=
 =?utf-8?B?U0tYd0Qya3BLRGtGcGZZZlVxdnlma05ic2hmSXZmaEszUjdPS09GLzZoQy9h?=
 =?utf-8?B?TjZCRnArOURVVFZHek1ncWZDSlI4VHdOazQzUm5SdmcrbWZVWlMyTzRiOTNu?=
 =?utf-8?B?ZG9VSm85YzdFYjNaSGcwQVlFa1g2elphMjQyTlhGWnltbzJadFZINmsyVEsv?=
 =?utf-8?B?VmRKUGdOZlRTTUxvKzN2cGJGalQ4UUVaU3plUWRid24wNmNwclhmd1EyZEEy?=
 =?utf-8?B?RHY3UFpHcjRBNmx3QlRoMlk1WkcxUE9uWGttdVdlVGhpdHEzSCtaNUFRZGZt?=
 =?utf-8?B?ZVU1SHRvbFpNM1JsTE9pRXJiQXloL0NvdFVwaG05citwRk92eHVTbXA0Y3NJ?=
 =?utf-8?B?MXNBcVBnZEdVcWp4cFEyVjgrQllXS0xKUmF0R1ZvaEN1dzdPV3l2d2FTNDNV?=
 =?utf-8?B?UlViV01ja2J4cC83eldqZkxSZnAyazh1TkRuV1c0OUUxbGhwRCtNK3BGdzZX?=
 =?utf-8?B?aGZ4ZGRadkRxcCtjSUFZUlpnbitjUERHS0ZqTVVwVkp1d25SUnc0ZGt4Vkgr?=
 =?utf-8?B?bTQ4enFhN3pLS1liQVV6WmNBVDJ2N1BlOU9zWDJ2U0J4MGFzMmNPWFB4a3Y1?=
 =?utf-8?B?MjF3aUdOOHROY28ySlJSMlZSOTlCYS9yVGMzbTZEU21FTnROYXJQcFV3NllM?=
 =?utf-8?B?MWU2Y3lCbXlmSFkvb2lLVExUdkFNU21uTVNXUllvZkhRSTZyYm9nNlF3KzMy?=
 =?utf-8?B?U2dybUMxR3lmUmx4ZXZGZnhTTCtzSWtaTVpabzh2b2s5MXRYQlZEMVZ5TVU4?=
 =?utf-8?B?U1lPWWcreWcwb3phS2dzaXVRWGZSVG02OVErbkdiem9iM2JzR0VvS051eVpS?=
 =?utf-8?B?V0VlVUgzTERxbTlUWElVVUVuNVhkOXpXQVNtcHNlL3RERXdhd0NLZzgzTVVi?=
 =?utf-8?Q?jzUSkp+XQDbVvC5WsRZ0O44XJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GSaWGWguDU3WKgEploXc+sbxocLqNQiazcZo/Bb5bvX1bng+kbdMz6LOzmj2fb0CD8OdAGFy/yw0Zgqtm7Q03CR9ajCY8SFEh7R35Ch7ZGL4DM0OoraJUd0R2jdN+lZqNHRztXgQOwikU6BtSsuXza9Gkb6hkGHLqFa/QnedNuf8f4w/cK+djMkKLU46C7CChU0d5ZIVDbd7SygBmo1D2WCae/fI9Gl911UpFhBUEw2icvhr/RlUJ9dmHylD0kpiPtXJUpQZkucrNiKn5I2/+fjwQ76xNsVQQdA2bNGS4FXxLq8MQ03rGuW8raCLyncMWCzsX/RdXIqQnBGrK0fGonW6lm3uQz2TN4wAnJHr8O/x5h8OuR9F0x/Tb34ncaVKxCFzSJEpzksRqQMYMjLVvyle8iNQSd6cVpsKDRYGLhTD7b5GEfcE2ZJzSbNn51nKzjiGig7Qgtp3iDh7/6Elkscu+ZVKKTuiztUoW4kAcO8U8Sw6OvTeGC6pphKWG0/gMCS1s1srP8UnxZIWoeNfckFfaXyLLZnRzs9BTn68OCezPsy1RF5OihdwurmPWvXBzDjzetPx6yKkuBDX9w46KaPJIUxnhWMRJPOdLfwuTCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbab722-0921-409a-16e7-08dd21da0b73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2024 16:10:53.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMiXSyLgmPO9LZbWXhVPiQzW0aoPuK0p8GSXRVfmJ47Mfj5KNWHBmUTMBf46JMx4GJJrhul28CkLtLuF8vdXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-21_07,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412210144
X-Proofpoint-ORIG-GUID: ss_Y2ekxEgD9JUk1aIFPxQkkZ24hCez8
X-Proofpoint-GUID: ss_Y2ekxEgD9JUk1aIFPxQkkZ24hCez8

On 12/21/24 9:36 AM, Olga Kornievskaia wrote:
> On Fri, Dec 20, 2024 at 10:46 AM <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> We've found that there are cases where a transport disconnection
>> results in the loss of callback RPCs. NFS servers typically do not
>> retransmit callback operations after a disconnect.
>>
>> This can be a problem for the Linux NFS client's current
>> implementation of asynchronous COPY, which waits indefinitely for a
>> CB_OFFLOAD callback. If a transport disconnect occurs while an async
>> COPY is running, there's a good chance the client will never get the
>> completing CB_OFFLOAD.
>>
>> Fix this by implementing the OFFLOAD_STATUS operation so that the
>> Linux NFS client can probe the NFS server if it doesn't see a
>> CB_OFFLOAD in a reasonable amount of time.
>>
>> This patch implements a simplistic check. As future work, the client
>> might also be able to detect whether there is no forward progress on
>> the request asynchronous COPY operation, and CANCEL it.
>>
>> Suggested-by: Olga Kornievskaia <kolga@netapp.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/nfs/nfs42proc.c | 70 ++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 59 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index 7fd0f2aa42d4..65cfdb5c7b02 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -175,6 +175,25 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
>>          return err;
>>   }
>>
>> +/* Wait this long before checking progress on a COPY operation */
>> +enum {
>> +       NFS42_COPY_TIMEOUT      = 3 * HZ,
> 
> I'm really not a fan of such a short time out.

I'm not wedded to 3 seconds.

For the purpose of a proof-of-concept, it can be valuable to make
such timeouts short to exacerbate races. But perhaps we are about to
step out of the realm of proof-of-concept. Suggestions are welcome.


> This make the
> OFFLOAD_STATUS a more likely operation rather than a less likely
> operation to occur during a copy. OFFLOAD_STATUS and CB_OFFLOAD being
> concurrent operations introduce races which we have to try to account
> for.

However, we have to close these windows whether the timeout is short or
long. Making a timeout longer simply to avoid races seems like a band
aid to me.

Back to choosing a value.

For a very long running copy, every 3 seconds might indeed be overkill.
We could use the advertised lease timeout (or a fraction of it) instead.

Neil suggested an exponential backoff here. That feels to me like an
optimization that can be made later if we find there is evidence in
favor of doing so.



>> +};
>> +
>> +static void nfs4_copy_dequeue_callback(struct nfs_server *dst_server,
>> +                                      struct nfs_server *src_server,
>> +                                      struct nfs4_copy_state *copy)
>> +{
>> +       spin_lock(&dst_server->nfs_client->cl_lock);
>> +       list_del_init(&copy->copies);
>> +       spin_unlock(&dst_server->nfs_client->cl_lock);
>> +       if (dst_server != src_server) {
>> +               spin_lock(&src_server->nfs_client->cl_lock);
>> +               list_del_init(&copy->src_copies);
>> +               spin_unlock(&src_server->nfs_client->cl_lock);
>> +       }
>> +}
>> +
>>   static int handle_async_copy(struct nfs42_copy_res *res,
>>                               struct nfs_server *dst_server,
>>                               struct nfs_server *src_server,
>> @@ -184,9 +203,10 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>                               bool *restart)
>>   {
>>          struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
>> -       int status = NFS4_OK;
>>          struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
>>          struct nfs_open_context *src_ctx = nfs_file_open_context(src);
>> +       int status = NFS4_OK;
>> +       u64 copied;
>>
>>          copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
>>          if (!copy)
>> @@ -224,15 +244,12 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>                  spin_unlock(&src_server->nfs_client->cl_lock);
>>          }
>>
>> -       status = wait_for_completion_interruptible(&copy->completion);
>> -       spin_lock(&dst_server->nfs_client->cl_lock);
>> -       list_del_init(&copy->copies);
>> -       spin_unlock(&dst_server->nfs_client->cl_lock);
>> -       if (dst_server != src_server) {
>> -               spin_lock(&src_server->nfs_client->cl_lock);
>> -               list_del_init(&copy->src_copies);
>> -               spin_unlock(&src_server->nfs_client->cl_lock);
>> -       }
>> +wait:
>> +       status = wait_for_completion_interruptible_timeout(&copy->completion,
>> +                                                          NFS42_COPY_TIMEOUT);
>> +       if (!status)
>> +               goto timeout;
>> +       nfs4_copy_dequeue_callback(dst_server, src_server, copy);
>>          if (status == -ERESTARTSYS) {
>>                  goto out_cancel;
>>          } else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
>> @@ -242,6 +259,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>          }
>>   out:
>>          res->write_res.count = copy->count;
>> +       /* Copy out the updated write verifier provided by CB_OFFLOAD. */
>>          memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
>>          status = -copy->error;
>>
>> @@ -253,6 +271,36 @@ static int handle_async_copy(struct nfs42_copy_res *res,
>>          if (!nfs42_files_from_same_server(src, dst))
>>                  nfs42_do_offload_cancel_async(src, src_stateid);
>>          goto out_free;
>> +timeout:
>> +       status = nfs42_proc_offload_status(dst, &copy->stateid, &copied);
> 
> Regardless of what OFFLOAD_STATUS returned we have to check whether or
> not the CB_OFFLOAD had arrived while we were waiting for the reply to
> the OFFLOAD_STATUS.

I think that could be done. The only reason to add that extra complexity
is because CB_OFFLOAD carries a verifier and stable_how, and
OFFLOAD_STATUS does not.

But it seems to me this race scenario should be pretty infrequent. And
I'm not yet convinced that the COPY will misbehave if the client ignores
a racing CB_OFFLOAD request. It might be a little slower, is all.

For me, the Minimum Viable Product for this series is that COPY should
always be able to make forward progress. Are we at that point yet?
Anything else is an optimization that should be made based on whether
there is evidence that shows there is a substantial application-visible
improvement.


>> +       if (status == -EINPROGRESS)
>> +               goto wait;
>> +       nfs4_copy_dequeue_callback(dst_server, src_server, copy);
>> +       switch (status) {
>> +       case 0:
>> +               /* The server recognized the copy stateid, so it hasn't
>> +                * rebooted. Don't overwrite the verifier returned in the
>> +                * COPY result. */
>> +               res->write_res.count = copied;
>> +               goto out_free;
> 
> In case OFFLOAD_STATUS was successful and CB_OFFLOAD was received we
> should take the verifier from the CB_OFFLOAD otherwise we are sending
> the unneeede and expensive COMMIT because OFFLOAD_STATUS carries the
> completion and value of copy it does not carry the "how committed"
> value and thus we are forced to use async copy's "how committed"
> value.

I quibble with the description of COMMIT as "expensive".

- If the COPY was UNSTABLE, then a COMMIT will have to be done whether
the client checks for an intervening CB_OFFLOAD or not.

- If the COPY was FILE_SYNC, then the COMMIT is a no-op, and the only
expense here is an extra network round trip.

- This is not a performance path. If the client missed the CB_OFFLOAD
in the first place, then it's already waited a few seconds longer than
the server took to do the COPY.

So my feeling is that avoiding the COMMIT is an optimization. It isn't
required to make COPY or OFFLOAD_STATUS work correctly AFAICT.


>> +       case -EREMOTEIO:
>> +               /* COPY operation failed on the server. */
>> +               status = -EOPNOTSUPP;
>> +               res->write_res.count = copied;
>> +               goto out_free;
>> +       case -EBADF:
>> +               /* Server did not recognize the copy stateid. It has
>> +                * probably restarted and lost the plot. */
>> +               res->write_res.count = 0;
>> +               status = -EOPNOTSUPP;
>> +               break;
> 
> This is the case of receiving a BAD_STATEID from OFFLOAD_STATUS and
> this would lead to copy falling back to read/write operation. IF we
> don't check the existence of CB_OFFLOAD reply, then OFFLOAD_STATUS can
> and will carry BAD_STATEID as the server is free to delete copy status
> after it get CB_OFFLOAD reply (which as i said we have to check).

I don't agree that the client /has/ to check for it. I think it's an
optimization for an infrequent race. As the meme goes: "Change my
mind". ;-)

But back to changing the logic in this arm: what is the problem with
falling back to a read/write copy in such cases? This seems to me like
an infrequent case where we should prioritize recovering reliably.


> And
> If we did then we need take the result of the CB_OFFLOAD and not act
> on OFFLOAD_STATUS's error.

Checking for CB_OFFLOAD after an OFFLOAD_STATUS operation seems racy to
me. There is still a gap where the client has done OFFLOAD_STATUS,
checks for the CB_OFFLOAD and doesn't see one, and then the CB_OFFLOAD
actually shows up. So this does not eliminate a race, it merely narrows
the window.


>> +       case -EOPNOTSUPP:
>> +               /* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
>> +                * it has signed up for an async COPY, so server is not
>> +                * spec-compliant. */
>> +               res->write_res.count = 0;
>> +       }
>> +       goto out_free;
>>   }
>>
>>   static int process_copy_commit(struct file *dst, loff_t pos_dst,
>> @@ -643,7 +691,7 @@ _nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
>>    * Other negative errnos indicate the client could not complete the
>>    * request.
>>    */
>> -static int __maybe_unused
>> +static int
>>   nfs42_proc_offload_status(struct file *dst, nfs4_stateid *stateid, u64 *copied)
>>   {
>>          struct inode *inode = file_inode(dst);
>> --
>> 2.47.0
>>
>>


-- 
Chuck Lever

