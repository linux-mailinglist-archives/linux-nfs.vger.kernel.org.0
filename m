Return-Path: <linux-nfs+bounces-9750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F15FA21F0A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39D6162425
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F714A635;
	Wed, 29 Jan 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aqR1yULL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e45crFSl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342001DEFC5;
	Wed, 29 Jan 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160551; cv=fail; b=ehuoOyMQU5D+dLn7BlRsNM1SAxFxjMwpGNvwnwPc+Q70Gznyrr5n8o+eP9Cj3c0jHTE11Az9xFrOby9yKWSLn+zW4ZdheaFWo7KldfAZs3FGavXMezn9zhDuhcQBQluYAtHYHPscMfAISg7OzVYBF7GeluNo5AG0fpo1zqIQav4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160551; c=relaxed/simple;
	bh=LiXuMEWEkKL86EsuGDEgAf/nzQ2dPlnkerm8wvAhIc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sj2mP8AQMsOG78c2yacw3tYzjms/kb3/iig4kRvZ+Uon1LtDchTpTo9MgokZV4kPe+Iclkr2z4da8MljG4p+upPg9LdeEk9Whnr7EsISQVm1XwhSbYNo3oQ2J88Bmpj9AkmHNeKLg6BrbJ3GUAUgm3AQqZQfWAaEmOzV3o9wlGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aqR1yULL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e45crFSl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDwx3k011758;
	Wed, 29 Jan 2025 14:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qo+cQAmrGPtcGWievA85okEILJPfCg4pHJobM8V/gZ0=; b=
	aqR1yULLBpZwBcwvF/zvE34lum5ofy1M/2qvVAJDlvsJsT5Saz//Ym4Z6fTAPeoN
	WrrgZhgY+zo3N0FwZGUj6jZUPhICOmcGPH6/h9Cp2BEVf89kZLueiU8L+MGti9Kv
	F/WbOwcheogyC1xf28NZQ9hN0rrR2mbH+AoKq00+zoDQoJlcKbs5E8sUU7Iiahj4
	VgaAKMcha0xHOZ4Ze7Zh8U7NZNcF7d46XG3JLYJykXhu2T038eY8TORAWbprl9px
	pvdu09iO7rpmiWK99e0Upwn5zeOtlTqeUETJ/H1am9Mxdi50OTTQYEb6ucBAp8xp
	2cNWEJTPbEuNgG+AgkGVDQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmut85qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:22:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TCjr8C022049;
	Wed, 29 Jan 2025 14:22:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9tch4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+rr41oYMRL5anKOTi7kJliX+LFXZHBLB6T6mv+zFuAmzNsD/CuhiMeCqs/hbi8hnfOSQx/l5M+VgAmjgwA1R8JVZeQligqEAsdYvaRBOYgGNbHiTwYUdqn+Q6xnzOa0chKSXjWl558kKY9GlYShRgKQVhidUvx6ui+55nRItj2DmMiP4TwqF3wIj69/45nH4X9SnHvsfubXbxlOOfBejbmZOGcEPj7eAmslZKyEefq8pPhtkQQeEhrHwQA/YFS6+S6VPq6O8ZrVqEwNLNKFWVUaiFiEVHNpk5e1LURv9Tz9+eFx1A9BBw4EGYiLYJaiD+BooQ+0OmfhltbbyGP+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo+cQAmrGPtcGWievA85okEILJPfCg4pHJobM8V/gZ0=;
 b=rxvuLjlE6GUoxdcocm31l1Rq9bn74SzBix9jF3QGEJojrgpfdoesUDAMUNVmArovxo3pYOdWuqampImeLlvHYiFufdqrObmRwfAUbajEdCxTrKxIFO+qPGlPypGO3ojE62BB47GjNDuqurKp5VKMnJwbhq9x2I7ncf1i+zibrkYu8LL3Q3BWQrTJn+LmjBnz441o6YcZo7TA9jKtw0aDmv9XzDx2ND4mMVedPPTqf0luIpNgysPF9GGP5XWsIeIKFS8D8thAR3q9FCSP0e3VbkYipjn1Ms0TyBzqdloHDfF3eZ3k05xis5DxQZihVv4nP7Auo/uP8bmsye/VGNJ+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo+cQAmrGPtcGWievA85okEILJPfCg4pHJobM8V/gZ0=;
 b=e45crFSltrSSZKNWI1q6XQg0FpJtvsxsz89ING5u9nNKge1cDhMFWEGy6TLoTj2Gg2pTpzJ83MlbwmXEXnPK/P4MqbwQ69BO3ld/vOpc3ojgRUchzpppb56W/R7DtV2s5ihAkbNXE1w9nvsTFzwDZRVE+EBNoeyXa9YuDQ7jEXw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7844.namprd10.prod.outlook.com (2603:10b6:408:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 14:22:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 14:22:17 +0000
Message-ID: <2f2c7a8b-d44b-4f41-99db-f3401108198c@oracle.com>
Date: Wed, 29 Jan 2025 09:22:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:610:4e::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f47b85c-15dd-4b2c-dd4d-08dd4070558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnNWRi8xM0hsZ0VacC9qWDhjcnMwSjZJOG0vVUZtUnhGZHU4YnF6Tkg4d01L?=
 =?utf-8?B?RnF3Rk9DMzR5ZXdlZWV2ZGFhcEhBWnVmeEs3TWZMdEUzd2JUTmRNVk9aWlhU?=
 =?utf-8?B?NC9XdkZTciswKzRUQmdHcUVkTWlZYjMyRmliMVh3YVdreHJHNzNIT0J5MHZP?=
 =?utf-8?B?dEtFUkUxVDRFUTYxZEFadURIcUQzNzRjVy9Hdkd4Y2s4T1hhazllRTdoZnNO?=
 =?utf-8?B?UUt4WG83bmhHdlY4QmFTb3hzMC94dzZwY3FVVm9tYjB1d3BpNmVuclRDSTdo?=
 =?utf-8?B?ZjNaRG5KZ2VnYTM5bFRYUnhZK0hLNnpxRHBpOU5KaG9VOC9wN1hEaFNEV2Rz?=
 =?utf-8?B?aHhaZTk5NGEwbW5LVWRnc2dqb0NHWWZOM3RuMG9wN3lJL3ovcGptdSszMGJX?=
 =?utf-8?B?MzRDK3h1bDQxTGwxb21SNlg4b2VVd3UySFhXUXc0WTdrQkYwOE10QXlXQll0?=
 =?utf-8?B?c2NLa2krQjl2Tkl6QUN5dG5XamRTZldUQ29uWHJtN09qTjZYS2ttaXFBV2dF?=
 =?utf-8?B?NGJQbUdyUUFWb2p1Q0NVTGVETlRaOTgwSlpKRjg1MFBONmN6cnlyVHNwUDR1?=
 =?utf-8?B?UkFPNlRTV0R5dlFUQlk3K0t3eFpGM3NBa29xUUsvc05ReWQ1TFpFY0VkNFA5?=
 =?utf-8?B?ZVQ2aHVHblJaQ2hsVXZ4TzBGNE1SSTlhdGNVNmNzNDFEY0pxRERKaExKQkVt?=
 =?utf-8?B?ODVSeXlQU3g1bnVNdURLNkUyZGMyZFhwek8yZlh6bWVLTXhTYmMwUUhDQ1VJ?=
 =?utf-8?B?eUxIbEpzNXU0THVXTmhMWHlIR1RvRHBkeVFVYWk1Sy82aHdxdWl2ejBSYWkr?=
 =?utf-8?B?QnJvZ3JaYlo1WWJON1U0VGFtYVVrZjhxRCtldElVbGtKUmJ6YWFtMFIwZlBh?=
 =?utf-8?B?K05BeldzMWNXV2dkNmFwa3E0UmM5NjRwMUFWZlpwMXZiVyt1N3YyZmtPaE5U?=
 =?utf-8?B?NE1NMmxZMVlMbFJtckllMTR5WExoai9NMjl0YVFXR3FUTDFpUzk5MnZHeEEr?=
 =?utf-8?B?VEtGUHNUdkZHSldPTUhHSjV1aHBMWFpwTC8vTlluZmo1ZU1jMlRRWVRXK3oy?=
 =?utf-8?B?TmFBVjYrMXAvM3U0UE9BckROajA5dSs4VFJ5Q0tyVjZmTFJKWFdRczc4eEFV?=
 =?utf-8?B?QWE2OGYrb1V0ZG9jbWVEWk9iZ2EyblhiSUhveWliZXQxYUZkQzZGaVJYb2d1?=
 =?utf-8?B?R1RwM0t1NnNxUWZLNUgxVzcxYVdtbFBMVXY5LzhsV1EyeXF4djNFU0VlOTlL?=
 =?utf-8?B?V1RvdGRCWG9nYitXNjh6c0RqTThPTVlGT3dZc1hmcWhCY1FEcEpEcVp1dStm?=
 =?utf-8?B?ckUyU0g2RGk0SllaWHlianA0T1UvdXE5VGVmVG5UWktzV3kvWjVFcUY4QWtl?=
 =?utf-8?B?dW54UE1tZlc1eVc0eGVacm5EdXpUZUFYcG1PVng2WU10RDVCckMxSlJ5eXhO?=
 =?utf-8?B?aWVsOTJTODhaanVNYXljZk5CaGs1cm1UejVBWkx2cXhEVzVUNjgvd1RkSVlt?=
 =?utf-8?B?SzczSFZPOWFTZHQ2em01YVRiQXYxZnpmeHU4ZlJVSk51YXJINzd0U01NcHVH?=
 =?utf-8?B?RkVKR2krVElZVlB5V2VlSEhYWnpFcWVTdDNBNVloMjR4akVKME16WGxINFIx?=
 =?utf-8?B?RzZoMWQ0d3hzQm5SS09GYitveUJ5RmFIc1kvQ3RqbmF2OWJRaVlCdU1VUHpJ?=
 =?utf-8?B?NFdWanRtL1c0czNvMzRnRDAyU2EvakxhM254UlhFK1A3eWM0K21NTlpuTUVi?=
 =?utf-8?B?K2NLMUY3dHc5RGhjZkluT1IvYlh5d1VtaUZMTnpZazAzMVlyUHVZbkFWSEov?=
 =?utf-8?B?WVBpZEJod0d0RGx3cklBNE5LRytzdm9zWjAzQ1lxUGtOaDgwWUg5N3RDV2Ey?=
 =?utf-8?Q?VsFn2GrQRWwg7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0EvTCtNZnR1WUpMSDJiMWdzVGQ2aDZGMzBMejk3cnJsTXRvZS9Bc3lBOXV5?=
 =?utf-8?B?bkNSTXZJSW5ZaldONDRpSndhbThmd1hFNjUrMUFrWHdZTlNuR095V0RYSFNa?=
 =?utf-8?B?Wm4wZDZFa1lQSk10SldyUjRIZmNnSHFiTVNMQk9rbUlEdlpDS0d5TUtYMlMr?=
 =?utf-8?B?a0VqT3B3QUFBQ2JxQUFYTW1uL290MXhVbm85N3Z2MVhxVFhYUFNnV0hBQURH?=
 =?utf-8?B?TjVxbW9IUUZvY2JKeCtPSVNUVmdvSER0emp0YjlmQnIzUEZSbllkNklDeUo5?=
 =?utf-8?B?T3poUk9MYUlFSSt0eis0UkxNdU1pT0EvOXFwTk5zTEFCRUpZbU9haTY5R2tW?=
 =?utf-8?B?TEk4N1hIekNvazBWSFpSUjZhQTBac1RFRm5aV29TM3B6Z2R4SmFUeXNBVU05?=
 =?utf-8?B?OXFacG5FbUhlcWxBT09VNXZVUlFtaGE3cGlzNmt5M2ZsK0EzSTUvRW9XSFZh?=
 =?utf-8?B?WW0xMmJEQlVQZGdlY1ZQMXFSR1pEQmRjamVVWDhjbDNOb0NEVjhyemJ3cTE5?=
 =?utf-8?B?Qm9DYlZ0RjVjRXVNZWY4NmFLTytuNktwKzVaanpSVHMvVVE4bURqOStxR0x3?=
 =?utf-8?B?YlFwWTQ2eCtub3dPd3FmK3FuWnRMSkUzVGp3ZkhtaCtVV09RWWdDS0krSXh4?=
 =?utf-8?B?cjZ1ZjgyaXhsVURYTm4vTmFEWkEyUGNQeUNqdUhiRjZBZlNYWWt3Z1hXeW8r?=
 =?utf-8?B?S282aUM1MXRrVFdMYWhzTXJaOGU5YUI1UWhhVFBIZVRLZVh1K212UzJnSlBj?=
 =?utf-8?B?TElxUHJIOE5CajQwSU5CZ2hscW9TdzZTQno3WDRhTkVyN0g1WU9lQWVEREpj?=
 =?utf-8?B?NUszMlpkNm9YQXY3ZjRYRjZsMjlaZlJqdjhFS0YzNFlCa3pNWUZ4aGtFWVhX?=
 =?utf-8?B?R2tWV1E5YTlBSnVzWFR0MFBGN3NYR3BYa2krMkNndXpmZkZlcTlmZzlkOWNW?=
 =?utf-8?B?SjRVTkY5d3h4SE1USnBNNk94L1RwVWtsRU1CVXhGeHQ4TzB3NWRoUjNsNWFJ?=
 =?utf-8?B?MXhXQlArcWhYcjY5RmxRWjhONDVCT09LeGVaRlhneDVxVWwvS01tVlpQdVdt?=
 =?utf-8?B?emdhUkxTd3RPc2VweDJXNWVhT3VUS1Y0NG9Zd3g1ZDNCcTNSTzRsLzFPZmFr?=
 =?utf-8?B?VGtFTS9ESnNwc0Z3ZFlBVERwdkZoTlcxaHkrLzIyOUh0ZTcyNVVQUU94b1hN?=
 =?utf-8?B?M2hOYnFlUXJ4VlhCU04vVXZVMy9vNzRJTk1ZaUZtSjViMHh3cDM0S0RWNE82?=
 =?utf-8?B?KzRJOGY0UHpMUUd4MlFQUzJBemY4djBmL0hJZmtST3lyQUFLU1AyMStkRVFj?=
 =?utf-8?B?MXc1MldDQUVhY04weko3VmVFT3ZMNWcrSnBPc3J5OXM5NElTalNqZVFpamZa?=
 =?utf-8?B?SFBFMlFWR0FyUUJmNUlkaUxlZndHeHRYMmdBUFNPZWRGcGxxakFkZ2JwTDdP?=
 =?utf-8?B?UHk3dGhXdVZHMG1wOC9iRzVybkowZG5OeDFqa01Oak5sUjRISzE3VEdIbzE1?=
 =?utf-8?B?SEtnMXZldEd5VUlWbmN0eFNxNWFTMFdGTGptbzhSakQ0b1VmNENrQkJiYmor?=
 =?utf-8?B?bnRSQ1JCTURMenI5SXRmM1B6bmF4MVZTOHZXM3BTeUVOeVZnaVFIM0tteHFM?=
 =?utf-8?B?Rnc4Y2M2bFV1R3FWaEl6TTZ1TnFPUXN5VDFBL2tHSmdMeFlmNmhDY1VyVUMy?=
 =?utf-8?B?NCtNUS9LSitvQmR2N09XVCtWM2Z2S2N4V2NUOWtCWHBkL2JjTTdYckJxbWZC?=
 =?utf-8?B?SjlpMVFmai90bk5JbVRvejIrTXNmbnVPWk9CY09BQUlkcU1PbEJFS0ZNTnVu?=
 =?utf-8?B?eVY3VlRmVndIYnduNHRtUTVXSTdIRXlaVDYxa2FCeHQwa291c01NZktYRmFu?=
 =?utf-8?B?eVNrOTdLRitoYTlCQlBFQUFNOE5vQk9pTEVGTmxMK1FvTDFlWHNIaGpPNjNu?=
 =?utf-8?B?SkQ1Y2ZPLzM1SlQwL0dpeUJHcitKVjN6RGM5em9JN3BBcERyU1Y3Y3ZwbEJu?=
 =?utf-8?B?eDkrbFBZRlJXVlJrYVRraHo2d1FTSktmN3hkYk1NcnlKMUh6UnZGVnJKVk0z?=
 =?utf-8?B?V0hVaUdBN0gwWXlmMUJDaW5sQlJNeHAvK3FoWEY4c24wQjJYdE9lTUxuUXZT?=
 =?utf-8?B?RHVuQVlRUW4zaEJuZ0ZveEIzY3dsWk9QT2xGVkg3QmJYWlE5WG94U082N1Bx?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vCzHi6ZGb4mgOu9seOT/CWRZDM8q3OewLLdlJyx89bNox601y0IDDodcGdd7W6csdO3lTuY/TuyymnW4joKd3iA9O4EUqnj1Qc3HGO18LwgTiw0wG4qXD34fYPDLxNa4z/noyU3WGab9L9UWPgzPftwzuBqZ7BtCVIv4LduEh/3SYcSqcJ5ro2BPwpEF91iWuTdJ/P8h6ao0GOR0blhrna7b6jxlL290bkyHbee1KpZtcmLJkK+shWzs0js18Tht6Q+OBYys3B5N5xSh5nYPuHLJoMbaeuksgN65a2s7EN800COrTv0GHeGCQjr6TG22g5r29zpBNkPFt5Dnr2yEu5OnOtb1aiU6TNFom3thaBZ6sEE9DwVWwQoWHGpoQ+CHD4L9dFa63WOMXWVDSviYeZHVMWvcLJsIVBaLMf2rx/sULO/Upp649/Hj4ta6un1zljTh1bLsnBoux2G+ebBFBsuFWwjia7B9BVkIlk45JfJX4NIfyk3c+Waw4PBJWD6zBb4WDTwaaSw8VbyXIA+i2K2lytcvetE4zCzS0wReMzGdxZeMy7qq3kPR4i4T1LAJOaFv01wtXNZe/zbqdTGhY6g1ezPHg02pj2CkzHztQ0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f47b85c-15dd-4b2c-dd4d-08dd4070558b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:22:17.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1wiYJx3kXAf3xBhxoJCjsuJhW92531uFNFKY5vYsv1aycTasH+9mQSfSy+66AH+BBpMb8KfZpSp7h5h9rZ1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=972 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501290116
X-Proofpoint-GUID: YgdAtksTi1QEKgdW1Er_SIgv04S2vZpi
X-Proofpoint-ORIG-GUID: YgdAtksTi1QEKgdW1Er_SIgv04S2vZpi

On 1/29/25 8:39 AM, Jeff Layton wrote:
> While looking over the CB_SEQUENCE error handling, I discovered that
> callbacks don't hold a reference to a session, and the
> clp->cl_cb_session could easily change between request and response.
> If that happens at an inopportune time, there could be UAFs or weird
> slot/sequence handling problems.
> 
> This series changes the nfsd4_session to be RCU-freed, and then adds a
> new method of session refcounting that is compatible with the old.
> nfsd4_callback RPCs will now hold a lightweight reference to the session
> in addition to the slot. Then, all of the callback handling is switched
> to use that session instead of dereferencing clp->cb_cb_session.
> I've also reworked the error handling in nfsd4_cb_sequence_done()
> based on review comments, and lifted the v4.0 handing out of that
> function.
> 
> This passes pynfs, nfstests, and fstests for me, but I'm not sure how
> much any of that stresses the backchannel's error handling.
> 
> These should probably go in via Chuck's tree, but the last patch touches
> some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
> from Trond and/or Anna on that one.

A few initial reactions as I get to know this new revision.

- I have no objection to 7/7, but it does seem a bit out of place in
   this series. Maybe hold it back and send it separately after this
   series goes in?

- The fact that the session can be replaced while a callback operation
   is pending suggests that, IIUC, decode_cb_sequence() sanity checking
   will fail in such cases, and it's not because of a bug in the client's
   callback server. Or maybe I'm overthinking it - that is exactly what
   you are trying to prevent?

- In 1/7, the kdoc comment for "get" should enumerate the return values
   and their meanings.

- cb_session_changed => nfsd4_cb_session_changed.

- I'm still not convinced it's wise to bump the slot number in the
   ESERVERFAULT case.

- IMO the cb_sequence_done rework should rename "need_restart" to
   "need_requeue" or just "requeue" -- there is a call to
   rpc_restart_call_prepare() here that is a little confusing and
   could do with some disambiguation.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - make nfsd4_session be RCU-freed
> - change code to keep reference to session over callback RPCs
> - rework error handling in nfsd4_cb_sequence_done()
> - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
> 
> ---
> Jeff Layton (7):
>        nfsd: add routines to get/put session references for callbacks
>        nfsd: make clp->cl_cb_session be an RCU managed pointer
>        nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
>        nfsd: overhaul CB_SEQUENCE error handling
>        nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
>        nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
>        sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return
> 
>   fs/nfs/nfs4proc.c           |  12 ++-
>   fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
>   fs/nfsd/nfs4state.c         |  43 ++++++++-
>   fs/nfsd/state.h             |   6 +-
>   fs/nfsd/trace.h             |   6 +-
>   include/linux/sunrpc/clnt.h |   4 +-
>   net/sunrpc/clnt.c           |   7 +-
>   7 files changed, 210 insertions(+), 80 deletions(-)
> ---
> base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
> change-id: 20250123-nfsd-6-14-b0797e385dc0
> 
> Best regards,


-- 
Chuck Lever

