Return-Path: <linux-nfs+bounces-9303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8DA13C3A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED6F16391A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28922B5A1;
	Thu, 16 Jan 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msRHuKxb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fCswYuQB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19022ACD0
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037659; cv=fail; b=b0ZB0I+An2wDIg64Cg4ku6ZJTJnaYprzHhoD84I96E3xOY6BcSdrMR1idxVkvI1cMSpCurdYHEQ+aeKOi8El1uJhGVoz0Q3fblMvE3pHw3WWVfywS7G6KcpjC9JYxrvWdXTWmQRy+W3cIUjwZzFPo7uiqbFuyHfkyoMPldTGg10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037659; c=relaxed/simple;
	bh=qYH4bi/ASSULYPq6/6xK+YlQGOnVb6lnOmE92+rn/jk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FG8qwFAK2jXLXcGEFmTfRnDkLleAM2B5TNlLZihTmviH/bg5YQj1ljPK5ikXswhSTBaieB4baDQADPJGfI3EbZz1O7bkz6/WJUn2t2yaJN3MGnTzVk6Eux9WnHGlYTcTlpiQ7rjtJ5TvRlzafLPQmgUf+4YFq8YZnrtJDvigglE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msRHuKxb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fCswYuQB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN5lY029004;
	Thu, 16 Jan 2025 14:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8D3JtzWSH16sE337L0y0/ZnOnLlkdeTP1CWRqC736ks=; b=
	msRHuKxb/8RlmfErYwPTZyCRQlEm3xJWq50B5O+4B1QK+M8gD9JgZ/LPOwu5BCxL
	x7NzeymnKnNAkUnbbrugwk+1CVjBdIbzYru0DFThyHWFZgNIqjeP7tpJDSmITK6X
	z4eSZ6wrtnsRyCfjl7P0SFGfECIbH+echRimOwHJgqZIY3ZNuG9B25ZbNxBHjTEH
	NlWfzu14svn4q4Dz+t//skW61PZ0vjFHvrA+wwLawJsscmbXinZrtONN+sHy9RZ3
	ABRBmWfFpf56uaqMXe84qPrxdkzK1IiCCt+BPxHldpFg1aJReju2lh/pMqoumTWO
	UnCLSEiMTWn57lzObved7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2jf24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:27:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDa91q034819;
	Thu, 16 Jan 2025 14:27:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3auuug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mp3pM1cAZbVwsoWy3w8RxTkze2Etri+IxzEzXuhDrRIV+2MlD3+pan6qGVeb+nRZjf0sLf++ZqFjc1bzIY22Ohx4PphzDKJO4GSU8ykCJVVUlFBrItWriV7hNi50Y/Y/vVp68oMiOsppawSmvZdr3U1tWRwFzOQviFjeBJNI9fLwvz8ytd6gHngNZl7X1Ddjoh3rVSbfNGg0aY5KzngnTI/WGrIlagSlc4bSYBs9MaY0U3Fj5iISEV0sANR3COCzEvcOIcPLZ1MtlrAygjPpNvQA71aeYeNByDK/jiYHWod/4QqUZQQzJMMmgVzXKFWWzcsw2dAuqQJd0mb4KJlkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D3JtzWSH16sE337L0y0/ZnOnLlkdeTP1CWRqC736ks=;
 b=umWTqucdidStGf3mZPDL4GJ66pLSvZ8aox6uHHYf2jFge4ag9uSCU1ReLeLJmxTsyJtz2OvvaXuDXj+HLX2nY58yButsB1xOojarGziCDW+2KOoVQb4ZNhIc9kZSdbNhtnh7jvIJHZSOwJOS2CcLijrmDXC7qTw+8YVQNm1gOGFNMP4G94Ecq50zOepUbXfE7cNig1xShj4ZCJYhh1AaFVhG+0iowCRnVnSwJAeG1J4Sva7RUdnXBfVgsysPwbUNCAdF/k6qgXQQftgQxTduD07yqKyn1LG7/if9Fqj4mQyuRL2NVwzY1gq6yK2koSyYgRKRaa69Fso3mRqE6Tt5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D3JtzWSH16sE337L0y0/ZnOnLlkdeTP1CWRqC736ks=;
 b=fCswYuQBR5mp14YoTo+27SmjY5QgnMGyYGlmdVc8tuqOUmczrBvXjl2Fvbgbed73HdFtkpCz61KPaBduXeqaJJ8qgI+azWa0HFkficnl/Xhy/DC/5gBdEwwc1wW8KY9rO8yvSjxRMmSlbxJN6miPtnWJHEnZ0I0PR3hBGP8Hol0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6186.namprd10.prod.outlook.com (2603:10b6:208:3bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 14:27:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:27:23 +0000
Message-ID: <62d3ced2-8c90-4699-b3c4-c58489ec9f19@oracle.com>
Date: Thu, 16 Jan 2025 09:27:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: fix management of listener transports
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-4-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250115232406.44815-4-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:610:119::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 63541c61-7c5c-4e44-e0ef-08dd3639e454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0NRb0lsU0NXbVJGbk50eStlTmcyM2tjeUpzNGVmQ0h3cCtVbWl3cVNxRFhr?=
 =?utf-8?B?cloxaStvekN0RllJY1U5MWNiaTNXOXNHUG11dHF3QVE4LzNoaUdlUUVwajF5?=
 =?utf-8?B?c0Ezb1F0ZVpBSkE2NVZYNU92SW9uWS9SUkliNDJyNHpnU2hFRmRTa2k2aUpR?=
 =?utf-8?B?cW9NVGVweU5qRng5L09JZ1VUZ1UyNGFDTGFSWnNUNGtud3ZGL3pFdTNlT0to?=
 =?utf-8?B?RURRQlRBM1VsQkdKREdaTmlpYWRlZkwvS3E0aWR3YTBMRHBTMVVjenA0WitE?=
 =?utf-8?B?dGVpcWNkeTE0Z0p5OXRXNmZrSmZHWmtKNVo1NDBJcGFJTDArWmt5dk4wYlVZ?=
 =?utf-8?B?NzY2TVlEN1k0aFhCNmRYVzMxVTkzL2RJTkRseGx4bDdud25wMm5VdGRDTXk0?=
 =?utf-8?B?Sys1eC9vVU5iNU43dUJqeTFWOUdnZ3hhcVZ5UlJHYW01NzBGc3VTaHR4bmo5?=
 =?utf-8?B?czdHY0d2OStWRmJlYmxhVTNVUnM2c1ViWVBFZmtETzhPVnpmVHRnUkw3VW4r?=
 =?utf-8?B?MEh6cTA3VkFHUFJRL29tYmlaUXQ0anpUUkxpcXJUSlRhNXVHVHdTR2d2Q0dt?=
 =?utf-8?B?U3JJUG8zRmhQSDZmc3p2WUVVZ2pOdVNnNVJ1QWRRMEd3VURWaWw1aDRUY2tn?=
 =?utf-8?B?c0ZMZE9iT3Rsc0RiNDNuNTgydDFmaUlFN2ZpbU5YUWNGanZWdzk2amQ5Nmhw?=
 =?utf-8?B?ZWliL3NxdTk3YWdXMjlwRUVOdVJKdGxMZXhidDd5ZDNqbUJJam9mOGJEaUhk?=
 =?utf-8?B?bUdiSC84dDVEZHVRUWF0cGg3bEZIODhRaTY0ZkJKMXBFUlJtQXBnRUdXdnJP?=
 =?utf-8?B?eWxZd29YS3FydklLQTVaYktUai9WNDAwOXVjRHd6Q0IrN0IwN3RnWWc3Mno5?=
 =?utf-8?B?MFYwcHEvK051SmFIazVXRXpnOFNiOHBrQllmNWY4bVI3eTdkb1lobFRFcEpL?=
 =?utf-8?B?UU9uejBMaGhmZEdhYkwwMCt6WUNGYisxOVRRclVXL0FkVnlSWnQ4U0d0WWVn?=
 =?utf-8?B?cEpGQTVhUFRpNitYVkUwcmVRS3oreHBHOEpuSlRzTkZEU2R2c0d4MXcxeVRv?=
 =?utf-8?B?K3plNFExUGNKanBlRUlnR2R5Z29SMFVxdlRMczZPdFBHYXgxenJZU1dRcEFO?=
 =?utf-8?B?QzA1bFc3MVo3SUZyMEdJOUNaRUg2ekc4WVBsLzNTdE90dkFER2xTZzZXV0VD?=
 =?utf-8?B?b2pPRkdnZ1FuNlhzNmUyLzd6Z1c0YnY3NmN4NjJlYU1udncyL2V3a2FQUEVC?=
 =?utf-8?B?NWdybEFkc2c0ZHNwWFd2Z3RibUxtcXhQaS9wazdVVWsvT0xNY0lsY2pTRGRl?=
 =?utf-8?B?OVk3SWxyU0tIYUF4QzRYWWF6UzRRTnBCeEZRSUM0NFNsKzRXbTZ2Z25IbXpt?=
 =?utf-8?B?Y3U5eStSVVZBcmlpMWI3ZUs5WDl6ZlhvNFBwVVVpUUlYQVJJY0tXQVVWNnF2?=
 =?utf-8?B?aDQ4QmU1QTUybWRDeHdIQ1JPYkNXSW9zUno1R0M1TzlPaDRuOTc1WFdyUTFr?=
 =?utf-8?B?SkNkcU9aVXJNNWo0V0tKZG1QMFZHUkpWTU5HL245dEhCcExlaTF1WVF4YU14?=
 =?utf-8?B?emdxODkwYjFOOEtDM1ZPbWp3LzlleUhlQXRtaHg3WllBeTVQeEROVExUOVRJ?=
 =?utf-8?B?M0UwcnY4L0VSVzBMWG9CVVJQNGxKVjJYcEd3K1B0WCtoK0N4dHpXbWxMQXJM?=
 =?utf-8?B?VWxKODNvSXJaRWRSNWNnRjVob25id2VBNEY2MmVlTTZLbHl6RW4zTDlDVFc1?=
 =?utf-8?B?bG5PNXNaNWVNcmxKTmdERUN5Um9XMU5Oc0lMZ210UENsMVE4ZDlwUnBtc1h3?=
 =?utf-8?B?RUxvVkJPVjJ3UWhzUDZOaDNWOVFNa3RzT1RONWROUStqaHJiMm5rTFI3TFps?=
 =?utf-8?Q?0Ko43pC0ka1zP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjlZUzNNdVZwRU9XUjdmbXBsYTY0elIxQzRBZVFtdmVkZlkycThRY2w5QkhN?=
 =?utf-8?B?VG5Ld3VCZVRDVUZWTVdpNkxhaW1lMS82dzFVRS9CU0FaUkttUXp2bHFKcU1U?=
 =?utf-8?B?Ny9DYnJIUHdxMFFHTHgrZFM5YzJ2M3ZFUE1lb3ZBTUY1ak9nQ013WExOMkpF?=
 =?utf-8?B?bUt0NHNFZFJ1RnZyQ3Z2UHUzT21Fd01KVkNlQWEwekFTTVNZcGErNU5VcXlQ?=
 =?utf-8?B?ckJCWXUyKzVPdHFlVEh1RktudmoydzRqU2NEaDlyMC9aekQ1UlMzazRtTTdW?=
 =?utf-8?B?L096N1VpRmozUkpPNDY3NWdMck4vbGtHRVBuV2lHbjZVeTJJeHFjdXdWQWo0?=
 =?utf-8?B?UWQyeXhVZVNWdmNQWTlpOFVjcXYrUTM0R2NSUTNaQmpDVG5hbmRrOU55Njh1?=
 =?utf-8?B?SFZPYkR6MUM1d0srTWFGaHJWQ0ZWbnpEb0N3eldHVlhpKzFDOTFWS1BaM0tL?=
 =?utf-8?B?K3BxdHJESmFjcmc5QmFIT0UyaTJIMWhuWnJzcXZDanNrQWhMOXNZNHd6QlBt?=
 =?utf-8?B?cmpudkVtVzlFZHQvTDgxcE9WYWFGWStsd2MrNmlXRFIrK0hzbThYSnd5OGNK?=
 =?utf-8?B?VmNhZlFaQlRvd1hQZkcxalRhMVhzVzlkVTdWS0RScjlZZzhJVkZOMzVGYlY5?=
 =?utf-8?B?TjNUTGszamxSWWRza1B1blZjREUxU2hpRVdVTDRSR1hqWmU0NWIxeXdFSU94?=
 =?utf-8?B?TENmWXRwZnBEWE5hTE85eWQ2c002YW9vR1Y3ZWtlUXJESHRHL0h1aGVabE43?=
 =?utf-8?B?Wm1MT2NoVWh0Z1FQMjlzWXVoVTYxMU9CbnM3RXF5dEM2UUE2ZzRTOVlGbUFo?=
 =?utf-8?B?ditpMHFEYWJJMlNDU0dGbFNpYTJXZ3RTK3h1NmlTblczSkJpMW9UcXBRcXBC?=
 =?utf-8?B?Nm1teXRpVUU2RUFkbUROYWdZcHZmaWxSWVE2MUphMS9tOGYzaGk4dGZ6TlBo?=
 =?utf-8?B?QWcvUHFhbnA4M1l6Y1NnbEdzMXRBVmc2d2IvS2FqYkJwbHR5bENDTDl5SVBa?=
 =?utf-8?B?OEVzbDR2ZnorNitpUm1DRGJ4Wm9MSGQrdlNhQkw5YUZCN3ZpaTAvczBLQ0pQ?=
 =?utf-8?B?Y3dCcWEvWU5HZnUzTDNRbHgzRHBPYU5lSkt0MEV2dHhqRzZhWmVCR2ZNUkxx?=
 =?utf-8?B?OVpuTmE3YlZzOVA0aEZQTU14aUR5N0tSMEwvUDZLdWNzNmtkWGM4MTJGbk5x?=
 =?utf-8?B?dWtDSi96VU9Lb2RlSWNZd1BnK2JtMFllZWd6eVRXNXhLMk12MUdwL1diVzRM?=
 =?utf-8?B?WGtDajhRdFdtT3U5b2NYU2ozSGtMN29vakM0WEdwSUl3M0lRS3E0UCtGWjJa?=
 =?utf-8?B?ZU5GWjhUTy95bkVZNGVWeHVIZkpsL1NpdUo1aWpVTEs4c2h3cjVYa3NvZDBl?=
 =?utf-8?B?RTV6SGRoRnRrR3NvSGsyUDRGNW84SnpJSG9VY0dncVhZamlGd3QyMWtGcXky?=
 =?utf-8?B?alYwWndOUFZ6VWhyTVpqT2RXWmdsMzExekdtM2JMbXR5OVdPQm1MSDJXR1NQ?=
 =?utf-8?B?aVB1elBIY1JacC9aMk1KSUthYkdWVElBTy9vUXhlTUtLcXM3VVk3eTFKTE1R?=
 =?utf-8?B?VlhIUG5scUI5Qk4vNzVwWE5FZHh6TEVDNlErSzMrSDBsVDUvU1g0SENBSU95?=
 =?utf-8?B?ZmlWeVdkb0pwa2Y1dmhDcnVCa1VYa0sva3dpckxCL2FPM242NnI0SnY5emp2?=
 =?utf-8?B?MjBiTEQ0Y0MxZ0FIT1BXeGMyekZkcTl1MmZpOG9Jdk1PdjBiTjZNNE0rdExU?=
 =?utf-8?B?TjdqTG91dlhJSkphclVaSXFIRXFQWmFiL0ZZcmUrRldMRElxRVNTYlVRWTdZ?=
 =?utf-8?B?QndSS3NablNiNnRIQWk1bUlibzVuTEdrRzBXNlBaQU81c2RqS0hrT2dBbDZ5?=
 =?utf-8?B?L0owdmlUUzFFVVd4TmJlWmsycyt4WEtUUFF1SzlDVFNLaG9aczBPbzByV0Fh?=
 =?utf-8?B?TXFWR016VzVWN1pVbytyeHQySGcxNVNOajY4WlJlTENqMWIxTnlMc3FTNnlp?=
 =?utf-8?B?TlNoeE40azVKSEZDZ2Y5Q3o1UEJDYk5Zekhic045MW5FdzgzYXJ1U3ZuV3VD?=
 =?utf-8?B?T25Bc3BYU3hBLzN3eG9SYjRRUmlwaDZlVzBITDNCek5MUkN4R2lMbWMra1p0?=
 =?utf-8?B?dXZKdmsvd0dZTGJtMmJMSkNvblhGSHlyczdLOTl5TGJNc1pGUTVWYVFkaFJJ?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	srYpC/hhcStWZV9Ik8N89C4axGoFY7jiQ0yccKlAu0c7LhWXv0RhPMYugdhPpBsOQn4ldfYE5RKQjWmidzpuU4y5QDhPmBLwPUtMEV4W1GUvqI9gRZJazcAbp7bs9FT9FjnQ58+Kmgk6fBWrxtpnMgB3DdLUFKVdND4Kl0KxRgnVMGrifaQe2BHEXZ+StmMU2MuiuNZ9gAEvDwZ6sl4llpRQlIQoJc263CehAo8n4bHALsjSTu2fT/C/UWMUnaNxOROwhk33h6cOTQbuRqAJkkgAau+Zb8tB6WWNFfWiSWGmdkRXhTytvXMheOIYfWgQB/iZOYNdRiBHHKafqa+zVGNX4oYlXUgK+4GOrPSp+pqE21emQdPXUhqdQpM0tFAj6fBhkKwFdJ7A6+mV3f3Es7DnYOLNZCAPSJVQDuqYng+QYHOWZC6PANd8op1BB37Ri15e8lTikYg+kI46n5Ktz9ublhQ0vLIUB3UYK3I0h7EMrToz7K+Av+MSrYr7rXVqFSYTp20ngUQaTfs3t3sPcWv0v2GU73l1JVzQMmXi9Upwvua6b/dINaDYEpfeGndrVHOEWHnDjWF3wElZ1CmEwKobCfesydI74I14pw4VGDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63541c61-7c5c-4e44-e0ef-08dd3639e454
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:27:22.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdI0wGz3IFtlJ+XxgfNS0Ev7GEAFqtrd6msBP1YInjkVnnKIOSqLkUvlTOHu8szycvLhaB5P47JX8so7Y6nQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160109
X-Proofpoint-ORIG-GUID: eIucYoGiWL_cJPOcR9mFwua0LvZuki0b
X-Proofpoint-GUID: eIucYoGiWL_cJPOcR9mFwua0LvZuki0b

On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
> When a particular listener is being removed we need to make sure
> that we delete the entry from the list of permanent sockets
> (sv_permsocks) as well as remove it from the listener transports
> (sp_xprts). When adding back the leftover transports not being
> removed we need to clear XPT_BUSY flag so that it can be used.
> 
> Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>   fs/nfsd/nfsctl.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 95ea4393305b..3deedd511e83 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1988,7 +1988,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>   	/* Close the remaining sockets on the permsocks list */
>   	while (!list_empty(&permsocks)) {
>   		xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
> -		list_move(&xprt->xpt_list, &serv->sv_permsocks);
> +		list_del_init(&xprt->xpt_list);
>   
>   		/*
>   		 * Newly-created sockets are born with the BUSY bit set. Clear
> @@ -2000,6 +2000,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   		set_bit(XPT_CLOSE, &xprt->xpt_flags);
>   		spin_unlock_bh(&serv->sv_lock);
> +		svc_xprt_dequeue_entry(xprt);

The kdoc comment in front of llist_del_entry() says:

+ * The caller must ensure that nothing can race in and change the
+ * list while this is running.

In this caller, I don't see how such a race is prevented.


>   		svc_xprt_close(xprt);
>   		spin_lock_bh(&serv->sv_lock);
>   	}
> @@ -2031,6 +2032,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   		xprt = svc_find_listener(serv, xcl_name, net, sa);
>   		if (xprt) {
> +			clear_bit(XPT_BUSY, &xprt->xpt_flags);
>   			svc_xprt_put(xprt);
>   			continue;
>   		}


-- 
Chuck Lever

