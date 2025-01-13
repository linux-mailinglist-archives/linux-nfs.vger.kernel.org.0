Return-Path: <linux-nfs+bounces-9160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52BDA0B910
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E37E7A03F4
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416923ED49;
	Mon, 13 Jan 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eXmM8PSF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KudkIn0x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E623ED42;
	Mon, 13 Jan 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777266; cv=fail; b=j5cTNIgDZOCs6BQSEf/KVECym/1+42ETT8tUeXu3mSP6wfFLl/cLQvLvdsZn2eZgXdPgIVIaE5pX1OSE9V9rdU8QDRjCGMvawb4Kezl/ioiHe8JqHSl82SnZL/ySSMW23OzOjXnpKr65c5ttxes+BM8p050U1W9SygCsVHarrGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777266; c=relaxed/simple;
	bh=iY7uyGHBRIiWED9ZuNBoIrjp+nXdYZuTOGAFvRBcxbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cnl3uD0fmR0yyIGYEqpeoKmEADTuTXHitwuKHOSCNLS8lSDGjnQaNk/JXadp1zahH4ASDyf2l5Occ/lPdOvPyHlAY/A9eDJWC1mvgDTHlChFHPsGvBTKUiw/hDnjEeGBSPzTJZj998PkVKzhv4AfUqSPECVgZTq1St7NRzhfnrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eXmM8PSF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KudkIn0x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DDi42x028710;
	Mon, 13 Jan 2025 14:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BlThlZqotCtkuRtI5rSZXYpylLkAgGGKj0P7Si9Y2bI=; b=
	eXmM8PSFvbN9gRtETjGgahCpLHyI1i7n025+K2wJO06qVujd80bF1T1H31jMCZcw
	s+xQN/V/S8PLV8funIPr5nzdbymfxoRSoOGU7b3TBOjmpAjE221PdDsEzmUGuceQ
	9mi1ZU2UucfRkoupeD4ZNqUYUAM2brRDHk4VoP7t4uB19vcY9NDtWlV2du0KIhrG
	P0JWLjacsrbG3mFgUW7HfasxU86Auk1nIGq/81GZxl/n/hNGojhCWCAu7MwnRmmL
	pw5oMnG5Brt7xHFzHCG4SEr/23PulJ56hEtbJbNfUavs+2cCslygjKPDjgfIhqCL
	I693PhTihEXOkJUtwW+zBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjakmy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 14:07:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DD2swN020364;
	Mon, 13 Jan 2025 14:07:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3d9gne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 14:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9n+TX2oeMnw6zgZdUp69WHONiufweTa88F5F/4v3l6/Y5T3dOC9KRgeMX0Kt5LYrhmd1Rhc2zeizK7KGeLiQyfpzggojSFhfLUCIz9dVAFOJG6bPDdgSQ44nk85xmLpK4yLjoPDhp/qXYUvecO68S3g5mrfe9exAsgoV8tfxhvAX43SQ1jui+y9DMR/mXvaGddggMALBkZ/VhOcYrNzLu49KMQv2r2cxhgUyQ6X0IzN4gDxPivFUxrDqsN2GnGDP1oeU6j760e3VplbJvCGJdlN2N3YGk5jWMZDcpYvfff/F5yOi6T3NymJ4irXkPXyExq6JUptq0n3ZrjNvhwMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlThlZqotCtkuRtI5rSZXYpylLkAgGGKj0P7Si9Y2bI=;
 b=KMUk9uxfYF0Pm8aE5dqipndrR5MDohvdoc8PuBVW1iCNdPRi0lz/ZohhTHeL11EN0cnZE8Srm/FayU6pQERRrG4o0d4XivJDOIXckLlDJFXpRTCx1i1OoBqRXLPxlh3PHen/SAEW5YSH9OAuhfO1um3gY6W1GDYy8mQBpvozVzJzzx4p1c964TXBZgm+YHzLznAVaXf7t3brYQo0VhcaYJrtNLAfZiN2T/mq3Bm1kmA29cs1QYWo1L8Ty/EC5dQxYnKxsLj0hGQIKZk8WVJzpCQ338egnjJxSvERFpau5R719kqAxxBMnp1sr0HWXUyzXaD9AuW3atytYUkQBLA2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlThlZqotCtkuRtI5rSZXYpylLkAgGGKj0P7Si9Y2bI=;
 b=KudkIn0xhfxRbVZ4JDjKLnOOGS7BZgMJ34Aps/zggZB+QAMGodjcB7YlMsAvs4Fuoc5rjuhMlE2CJm6S9S2nLOWfyiUBR4KJwJ/xGiVRKI9rVomZoixnvdxDRy7d5Xfxx6pCdl2jjAWZ8UY0+x8ccJBzgi5mKC44k+MaUJO6Av0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7727.namprd10.prod.outlook.com (2603:10b6:408:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:07:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 14:07:11 +0000
Message-ID: <37d6dab7-5031-4b96-b66e-9ba8f17d1adc@oracle.com>
Date: Mon, 13 Jan 2025 09:07:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250113025957.1253214-1-lilingfeng3@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250113025957.1253214-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e0272f-4bd7-4cb0-406c-08dd33db92bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm9hSWp5ZVQ5TnNXTTVPUUwwdUdkeFFKRTFSbU1oUzJ3NVg2THhsVmJTN29L?=
 =?utf-8?B?dWtDczhjN2NpdnZacng1WjI3THRQMnIwZ0UwemZEeXhCcnIxU0pBci9HQzlF?=
 =?utf-8?B?VTh3M1lyLzh4YTRLdlVVYS96Tm9HU01GUWFlWlh5VnFncW43a3hxUmdsdVBm?=
 =?utf-8?B?WDJvK0NWbHpqTWZCSGNOSmpOSWxwenc3bGhFa0xadmZvTDJmNytNbmEwQmRn?=
 =?utf-8?B?Lyt6eFV5ZkJTWWJ3ekFoK2RmdXJYTXRncEpBcjl2a3RueWRsSWs4ZWN0d3pj?=
 =?utf-8?B?N2loNGVFekRnMzFZOHJ5bkhsL1gwckdqcjA1QXhacGRJZ00rL1R1czJEaGNF?=
 =?utf-8?B?V0d0NUkwbWlWbGRCSDJvUmdGMEp2dHNKT2NOQlpRYVJBdFdDNnJCSjNNYnkv?=
 =?utf-8?B?K2xCemJHdDVpdVRRNmNZMXpCUjNrcU5aVDk4UnVPT3dITlk0RkRxSENOUEJk?=
 =?utf-8?B?UjVrK29wWVBrRFlhTGw2QWdnNjkzdWtjQXpwUUV4KzBMWGZzOVVIdCt6RnRm?=
 =?utf-8?B?dlg5K1JGOFNKVWw3dU1ON2VXcjhQK2o5ZkFrZmNWb3J4Z2F4VEJNdzNCdHBM?=
 =?utf-8?B?RnBLSk05eTlQdnJGMjZaQjlFUXlkc2Z4MUZnL2wwbVNMSHVaUnVDcG80MmI0?=
 =?utf-8?B?TUpocklrN2lrZXBiRzZPZndGSUVQS0Vtd2NDMDYxcFUwV0M5NnpBL3lMN2lq?=
 =?utf-8?B?bDVwSDNNbmpGYkJIbG9hbGxBUXJTUHVHaGVRbVFodmVmMnB3ekdEcXl2QnNE?=
 =?utf-8?B?Kyt2SmpmSENkYjFva2s3dTFOWTRIcndoREN1Y3hJTWloU3NzQlJ4VE1UYlpq?=
 =?utf-8?B?cVVacjRTSlJtdlVxU0M0ZWMrMm0wclVtOExIRVhmVHU3QUp6UHE4NWlac3ZL?=
 =?utf-8?B?RVNONzJhN2QrMitUdHZrM05KQ2k0eTdidzV5Tkl1Wk93NEdIS3BoZFgrOXIx?=
 =?utf-8?B?N1JiNnIweDZKdjBmMmN5ZEZ3aU5UWTF1K3RTa0pyRE5FV0VsSnhjWEpDcnl0?=
 =?utf-8?B?bVNzSUljeGhBWW4vclFKTzJCaXFwNE0wa2VMRzZxQ2R0Y1J5ZFRacmRZVS90?=
 =?utf-8?B?azRzdGtkbmFRTmV6TTltbWNya2NoSHM3S0FxS0N3Mmw5cGtCNnIxWEVWVnVF?=
 =?utf-8?B?WEZOSUQ3YnJPdlA0blZkRUhkMGFoaWkyVDlrVTlXVFA0M2hVZmR2RWlBTHVB?=
 =?utf-8?B?Z3JXZjdXaSthUTdqZGhzN21XaVFBVG9XbzV6S2F6VGVXUEgvTTgwNkRaZjl5?=
 =?utf-8?B?b1FzMWFRUkFuY2hOSWY1d0t2VHE4MGZrSXRDQWtCY3JBZndubkl5b1dpQlhp?=
 =?utf-8?B?cGZBanpXZE9udXEwUG1HQlpUVWxKWStKYlppZWZqdk5Jc2RmZzhFU2hNTW5j?=
 =?utf-8?B?Tk5URmpxbHpKRWg1RENOOXFEbFc3UU5iMmp6Um1JNWtHVDNldmJBZFJWTURB?=
 =?utf-8?B?akxQNGFnMmo0WE5UZnpua1ErL0xwdEVVUUloTE1CbjNWa25RUnQwc0w1bEdj?=
 =?utf-8?B?MW0rMUk0TG9wZWFtZ295cjhEdFVtaFZ6WXQ0ZzRqUXA0elFHZWdkRXViRnVV?=
 =?utf-8?B?SGlxNVRybjhtaFNYRklOazN1ditMbWdQZlltQVJxL3Q5VDRRNzMxYUNFZm0v?=
 =?utf-8?B?ckVBOSttU3RXYWhQbjF2MnJPc203MTd0YWMxZUltWSsvRUNxVkRsU1FtdDFu?=
 =?utf-8?B?WGRYWk9NVDNWRVhXdXMra1hMUFVtUXRGUTY4MkU4aXFIZXQ4OXRzY0NLMHk1?=
 =?utf-8?B?VGFZZUFFQkFaMDVWWGg4eFIycExieEo0YjhyVmdMS05hdVdpbUZidW52R0VC?=
 =?utf-8?B?bk5uN0R1SWhPdGRQNW5tazFRUkNObzJsT21XSVYvNU5iRjlWVnNCUktLU1RQ?=
 =?utf-8?Q?DHC3jAQj2ZDuU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnZmSXgxUWFZaDV0WnZDMkFKcnhsNkFDQ2gxOTJQN1JtOUFzS283SGlWNVBQ?=
 =?utf-8?B?L0RCUWkvOU5QaXVMRXcyQStlalMxM1pZRVVwU1N4Z1dQNjM0L1lkQmxtQXBV?=
 =?utf-8?B?QmNiWFNGemhnWVJYQ2hqM2hwcG9VSzA1OEJJOXZwNzRzSnpTckVuYkpqODRU?=
 =?utf-8?B?N0pYNWZtMnY5YS9LOW85SlRjZjVoVWQ1NlhrbUUrK3R5Mm8xaU1HWmpCUzRy?=
 =?utf-8?B?VFhUeTNSY1ArZjFHaG5uZnQ3clFzWmt1dHFkK1JPZ1dScWZyd0FJQ3M3Nmwv?=
 =?utf-8?B?UEJlU2RPQm9wNTJ4US8rUWxJeGdTQVdjR0p2S0ZETG1oMVdIYjJlbTkvQ2R2?=
 =?utf-8?B?bnAxSXh5UGM2d1dpcExiNXpnYktpR25ZQ1d4TEt2Uklrb1FSSzB3TlpLL2lP?=
 =?utf-8?B?Z05EUHYrNjRWSC9tcEp1aS8wMTdDQlVDVWRBenhsQ0JSNTgrNjBMRCtBR3FT?=
 =?utf-8?B?Wnd2eUJEQWY1NUNOM3k5MkRVaVVHWXRjejBmZkVWTE83dzhiRFRuZGFHazR6?=
 =?utf-8?B?d3hSNk9QeE94bzNOVzYwY3hFbDV1MUREUWR1ZjlxaTdUZk1wdzE0QXo4MkQ4?=
 =?utf-8?B?OGxkeWR5L1IvbGVIYzMxdkJLWjVDZkNiY3M3TXZmNWVQU1JCb3FOeHlhT1hS?=
 =?utf-8?B?N0pmS21HT0NlR2N1dEI2dW9SU3E4U2kwajdaMS9adW5oL29SZzNOWlpPL0R2?=
 =?utf-8?B?L3o4RGlmdnRKWERyUkw4TXoyQVpiMVV1c2x4M0s1bTdjQmg5ZWdZblRHSEFx?=
 =?utf-8?B?WlZDWlNUcVp0SnVaTkZkeEU3M1hZQnh2ZHpsNnZDUnhpTm1MVzZOa2VSc1V3?=
 =?utf-8?B?MHIxLy83TTMycW5IQ2UrL3dCMEJ1OXBEMFZiSU9sMWlMbDBxYzBqbjdhL0VP?=
 =?utf-8?B?YzNBRUxkazY3M3RIVS9Ec0cwWEIvNCtqYUpjNFNXSk80ekF3aEM0UEJXbXNW?=
 =?utf-8?B?OGMwV0J6M3BOWWhMQUdRZm1sMU9SK204a1QyNEYwUk96eGgxNDA0L2VhR2Rn?=
 =?utf-8?B?cFVmN3JvTUZ6ZG16Z1o3VkZ5SlhIZmlpVTdoTmRNZXBzdXRFRmJ2bUx5c0NS?=
 =?utf-8?B?aHRZUEdMdjVudW96UXlBcXhWZnNicm5FeFBtUkZWUTdHWWxHWmluR2k3bVdX?=
 =?utf-8?B?MVB0am5XcmY5cTF0NkR6MUVFMXpYWXpXVlk1NDN6eFF0VjlteVEzV01hd3Ur?=
 =?utf-8?B?b3Nndm9wTzhjUnNrbnRJSzNsTG0zSXVrNEFSWWdTbTFKcnRrQ1lGSERWdm5I?=
 =?utf-8?B?bjFuTHhzd3dZQWRXOGlrT3pGbnlGTU1Yc0NYcXRkZWNrUTdBT1BHNWpZaVc4?=
 =?utf-8?B?VUpOc21LUXVSc1ZtN29jcmtSVFZlbFNITzhZbHIzbGwwZmRkRWF3ME5HTVpr?=
 =?utf-8?B?VzN6TEwwck9hR2M3aHMwMGlnUnNnVTBPRFEwc0lYam1FVXJPZHRYMXpORU52?=
 =?utf-8?B?d08rcjloSkhQQ0NscXU4ZWZ5S3Jjd2ZpUG9mSk4xVlN2Nkg0a3dOZ21SdUov?=
 =?utf-8?B?Y0RESHA1TWIwTlo4VFk0Sm5ZOFV6dUtzRjlqVGFRWUFNSjhIM3d2TG10aXd6?=
 =?utf-8?B?SFZMdlN3UVFYdTA4WDRRcVQwdGdxTWRBK3dvODhCRmpRSkZXb2V0Nk9kajVs?=
 =?utf-8?B?SisvdjltY2pZMVM1VGNJcFFsRXMxMnVERDVkSnhteEhEYlBuKzB5Qzc4WDJv?=
 =?utf-8?B?SnNuMEcyUXdCVzNFc0VMRDVZcEw4cDlwWCtTTS9YN2Vuei9iVnNKLzkvYzV4?=
 =?utf-8?B?WkJ5aUFoOEJ3eE95alV5NFdKMlE3a3N6ZTl5UU1COTkrSkVPN2x0OEt4czhF?=
 =?utf-8?B?MlJMVjRtTmM2bkRmWlo4Zms0VWlBbjB2QWxONjYwaDJkcHlaZ3lkYm52WWpN?=
 =?utf-8?B?QjZBM0dTcmd2cjk1eFdZMEJpOVFCM3ZSSkhJKzdaNzlrWEh0bkRIQ1pFN216?=
 =?utf-8?B?Z0htSldHYnpVOTdUMzFSc2RLampFMVdjYXBEMkNsRlhGWllEUTA2RzhrRmhz?=
 =?utf-8?B?YTI3eTdNdVZ1dXpnVVJMckFNZ04vNEpXT1FYZzJyUGszdFNrMXl1U2hMZUpX?=
 =?utf-8?B?dTV3WFJoclZuS2xJT2ZFZHJFeUNvc1dOaWNOM3VXMHZPRVFLOUdnSlI3eTZO?=
 =?utf-8?B?bWx3T3ZjVnF4ZzhiYm1LV29WOVZXUzNrbjJyV2RpbkdKZndML1NLUTlxM0hn?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dK5BUoZPtIh4m5N41RRKuqwJBBe7CEDR9qrF5NBYBS5w5EpSq2ZKe5TkKZj0PYMF9HtOufdqzRqTuIcd7cmGZOgfTPo3F4Seiy+jOkLpAlbIahEayvUy+ZTj3wxJZydDurFchNywslhLYud/MzsxMlxn4RzDR8AldqBM3mWdL7Li2TEA/Tvpx9a6Hb6UP5Q6dqZmXvtlHenD2MH9u4yWXubSreRmWed5gZdoS5I1uoKcaRfKAJHSZyD7uhWZpNnyJP+lCvoWJsgGeaLKwfKp6nVSxeISIFjj+2XCrBXaMCRqU/P5cJq5jyigsJfUomll/zqw8/RDw2Q8EJTKXXR2si+FDjp9gNpoiV9mFMbulFVf+wxuQ9EltHOOs5r1M60bOopjYF9iZp15GSmVlCfomekHhnEgd+51si5BcCOCTskxSXpSsGJI2Onwt864OT9nXAG5suQeUTz9rns47WXpYcGfsZXr2lINVc2lKKPJY9tvC0AzngdNqwMOSdJxznwM8fJWr0m+ZcsfDOkOVfHJJELzpPBNyNkEnH+Y8UbyTPqik7DbIsDTd7mYRvtfxs/FtUhJ1EeKYbI23bNAzH1/ZXNBx56yitDWkWXMcPPhA+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e0272f-4bd7-4cb0-406c-08dd33db92bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:07:11.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQvViywTaI0Pb52JEh/v6I1wMvdElV4u2Bp4t1pDFqdK4Crz7nXWailsKr9tl3isyJ81BcifOxDbqU7U5BpAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130118
X-Proofpoint-GUID: zDTJrJ8eULKkqEufWNLLBmwxaqwszPt_
X-Proofpoint-ORIG-GUID: zDTJrJ8eULKkqEufWNLLBmwxaqwszPt_

Hello!

On 1/12/25 9:59 PM, Li Lingfeng wrote:
> In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
> list, gc may be triggered in another thread and immediately release this
> nfsd_file, which will lead to a UAF when accessing this nfsd_file again.

Do you happen to have a reproducer that can trigger this issue?


> All the places where unhash is done will also perform lru_remove, so there
> is no need to do lru_remove separately here. After inserting the nfsd_file
> into the nfsd_file_lru list, it can be released by relying on gc.
> 
> Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")

The code that is being replaced below was introduced in ac3a2585f018
("nfsd: rework refcounting in filecache"). This fix won't apply to
kernels that have only 4a0e73e635e3 but not ac3a2585f018, for instance.

At the very least we need to add "Cc: stable@vger.kernel.org # v6.2" but
I'm not convinced "Fixes: 4a0e73e635e3" is correct.


> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   fs/nfsd/filecache.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a1cdba42c4fa..37b65cb1579a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
>   		/* Try to add it to the LRU.  If that fails, decrement. */
>   		if (nfsd_file_lru_add(nf)) {
>   			/* If it's still hashed, we're done */
> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +			if (list_lru_count(&nfsd_file_lru))
>   				nfsd_file_schedule_laundrette();
> -				return;
> -			}

The above change does not seem to be related to the fix described
in the patch description. Can you help me understand why this is
needed?


> -			/*
> -			 * We're racing with unhashing, so try to remove it from
> -			 * the LRU. If removal fails, then someone else already
> -			 * has our reference.
> -			 */
> -			if (!nfsd_file_lru_remove(nf))
> -				return;
> +			return;
>   		}
>   	}
>   	if (refcount_dec_and_test(&nf->nf_ref))


-- 
Chuck Lever

