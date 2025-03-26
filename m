Return-Path: <linux-nfs+bounces-10915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C7A71E7C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3C8189671D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE71F5434;
	Wed, 26 Mar 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iMfX7dtx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b9UFrsLI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEB19CD19
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014040; cv=fail; b=t1kW7KiZK34rQminDtoUls4O64TjGddHzFqyPZUinE6kIFnZWSJmQ0NFQ+OId7j0JerqOV/1HjxbC2wD655cQO+C/eJ08rxUSwtqJOJ8dSfpKqDdq/UPp0MrfeJgpbIOcDhR5NHrvBsIUZuGEC7WNNhzyLsDsYjv4cf5vyPgzr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014040; c=relaxed/simple;
	bh=KMO1xNBkCNIYrbQUAW5mOA2tiToDLbMX8UrZKW6Wh8g=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BmonBGyIKIPPJMy1FHFi/JSXHeOZB5l1zsP6UnFK9+bKX8ABvAT9VYe0daT3A6ILJsZFBXtw8XlRj5sdIui13Hv8gOs5eh0ayFUOxwLW5lRewnXgni2z6o1y9NHlxLv1+tQ3/lPabGQx3nJHmM2cNxabvmmq9jb1A3hlRXV1bms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iMfX7dtx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b9UFrsLI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QHj1Or014126;
	Wed, 26 Mar 2025 18:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KMO1xNBkCNIYrbQUAW
	5mOA2tiToDLbMX8UrZKW6Wh8g=; b=iMfX7dtx/dteaNJD1/N6BGzQil/HXghKKD
	mOEOFahAuIYXxZtxOUoy6GaCIqRpmqv1TD/zqG2iLl4AkARwwyfCU7ikHLV3/2OB
	HNkMlkcrOb6pMnA441TIBAuQlkD+o1UqhaML1NWVqaBBlwKLmodvZu1B9G5TEEmo
	ypX5ORzHfRqfvDOH4p4bzX7/Mcwi/BeOjsXkXreSQPtfgL3si7CUzBHc0JNdp8V3
	MdoGvXBGcNqmgKMAEcmp5221B9oYt+fcRDhfurEb+AjMbb7Dd1lpXH7GFyVdIzlP
	rE7ji5nB7zvm+5X1nCk/orfW5i1v7T8VqrEVWssj6vpwpNSHgaRw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8724we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 18:33:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QI5EWU029853;
	Wed, 26 Mar 2025 18:33:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc2rmkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 18:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKcX89XJ2WHrRAY3ag0yL09Fkh01xRMniB3Z0zFgSgbdrmg8wVhKD0LmjkesL5nt99EK5MjqcvM9HuySdh6ml1z5FhNsuZWRC2nrGquQr/B1yHdkTF4m6k4enMPEAycMDaERq4oQ7R6EAEr1d/lC9VC7XSF3xID9SRehNPxfpEn6INht1Jk2lNsVXaPk8pAzUBSUCLz+kUPinC8W8lPn7XDDmF1FPmXR8C41nL2dWDIsPAdrF7235wyWImjzjQiMsRK7uUVYgSRsvC6WP1SJePPLLQ7XTb41E/rRtLpy+JJX1FyNq4Bm6BKp18Gm7KfWmV7vJS5Ecs1PwmUMxwrx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMO1xNBkCNIYrbQUAW5mOA2tiToDLbMX8UrZKW6Wh8g=;
 b=jwdlqiHihM6H7cqDuZ7hYwzoi6dbD6xOWY6Fa0/3JglpyuPQkYqZ7rW9nVbM7gVWlvqIbEK54p7nk8gtO3hHPuing1y8NUaeKCKP0qVZMmZKqjcZ5TvJm3uHCyqHb4MT+XCD6TBTVP9WZcQK54kwDMNvYfYVvgZavCXqGJR/6Fa2Y7IKXIxIWTVGVmcLRbuZJG7kc2jOiCLZkgz1rk5fMLGQbBwFUmhqZEeA/uq4irWKwMLrtYD/7L9eQ6f3VN60dkkh6XerFNVcgCKTydq04YUNHf1QOKktYqOARDbvzDSfQ0zHRUck9TDzDV1+7dcHwhSGptR7SBlatAdwZsKYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMO1xNBkCNIYrbQUAW5mOA2tiToDLbMX8UrZKW6Wh8g=;
 b=b9UFrsLIullRMep9MWkhUPZwn8w9xVX8+wOiAKiz6fGPEj5tl71M23zDf8Di1dYSldMGMPvLj17pHupked3gEpxRN+x+Yfu/eQe/AnpcBJ0xqmOkkIzp9vlZH8Ixynyg/RNccuuGqeyVCRcUVz0nTPKFyxZJh2RshBNjxyxREo4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA1PR10MB5970.namprd10.prod.outlook.com (2603:10b6:208:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 18:33:36 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:33:36 +0000
Message-ID: <6f3f542f-df57-4382-9f8f-acb25c6fae16@oracle.com>
Date: Wed, 26 Mar 2025 18:33:32 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: pynfs tests for NFSv4.1 OPENATTR / O_XATTR?
To: Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
 <9324cfc2-4a74-4577-bcfd-704ffd25240d@oracle.com>
 <CANH4o6Pq1Snhyk9sFeG5sdZ1LKekpSOrLb0Hc-sb-5wSDPDA4w@mail.gmail.com>
 <CANH4o6MOtoQPZp7=5KV+o_42++XKqTUPpGVgtOOwS0eVDQaTNg@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CANH4o6MOtoQPZp7=5KV+o_42++XKqTUPpGVgtOOwS0eVDQaTNg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BGiPxLinflCzmPAtDBXhHptt"
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA1PR10MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c61bfe-2aba-4164-2194-08dd6c94b728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlVVc05xbzE1VGNLTjQ5d3l6RWwrQkpmeUgxYjJTdkMwNTRwUFE1dXl4dWlj?=
 =?utf-8?B?RkpCdURGT1JOT0puSkgvM2tFTHdlL1hXS3h1UnB6MEFxdlh3ekxNMWF3YlhR?=
 =?utf-8?B?UnN5WnJZaWhOdlkxM3ZORlhuSnNHMUhySzRPSU9MT1l6SHBQWm5VL3JBM051?=
 =?utf-8?B?WWcrWmN6bFA1OFRsYU5VS1FJRTR6L0JRTCsxU2RqY0ZjVkdoMlVWVFRiR0dQ?=
 =?utf-8?B?Y3JJcHBJMzFJb2RjVHpuaHlJMzQ5b2hKd3EvY3NiR2ozM1BkSTB5ZTExNUZl?=
 =?utf-8?B?RHpPZVYxanM3Smd0anBTeDVOMUFUNUFWQUVWUnRsMFRHSHBWRWxOMGswU2lR?=
 =?utf-8?B?RkpzVjJkUWppVXNqSHg2eGZrYjl3U0tqbWduL0NBUlJ1aU9HTzNQakR5Smt0?=
 =?utf-8?B?aUNPdmRaNUhKWWU1eDQ5ejgvYlo1bnJlMWVqVm5KUU1Hcm1FYk9iZEZqTEYv?=
 =?utf-8?B?RENTdk1GWXRUdm5PSUxCNkZ1ZmZBOFl1MzBJUUVONmJlOXpub3p2aHJxcHc2?=
 =?utf-8?B?S3licVVndXdjSkNLVytIZVd2ek5TTllwd1RMSVNSK2tKTnZvS1l2RVlueUk2?=
 =?utf-8?B?Q0NBb3VkNDJNVWQvQ2V2R1Z4N0toWEhXL1JVT2xCY2pVSE9jdlVEbm1yNjg0?=
 =?utf-8?B?eGFMK1hzMVB5K1hZUFRLeTZLTGJLTmZwdWRicldVNzVLY3RUdytQclpEcmVY?=
 =?utf-8?B?cjRlQnBURmR1RmpieXcrRStra0ptTnJPRFloMVZnTERQZFoySXlTZjRTeGsw?=
 =?utf-8?B?QjFoaCtwR0dmQ2J4TFlzOHNCbWo3VlVQQkhNUkxDU3dUWEVBZlAzMXBpb3Qz?=
 =?utf-8?B?bkZrcDdaNHFyUW1aczJlOUMxR1VpWnpYbERHVUhyZlN4V1pWKzlaNVYrUk0z?=
 =?utf-8?B?b0dlUENhTW1YQS9RMVU3UGNpZUNnZ0wvaWNzSE4wM1dsc2NpeFB0cGtSNlZV?=
 =?utf-8?B?dGxKWHFFQjRNQUdqb2V0QlM5S2FwQ24wS2tmN3ltam15MHpuVHgzditxb1lB?=
 =?utf-8?B?OWtvVDVmR2Q1akQ4NWJVcnEvYlZkbGdCd2IrTHdoMFJaeFN0WHMyV0FoRUN0?=
 =?utf-8?B?R3pLR1QxaVBIZWcrYlVteFhBZkphOTAvZHk0Ulp1YXliVUtxYWNtdzhqK2M1?=
 =?utf-8?B?S29oOGdWYTZ4dk1MOFUyTkk1SVJsNlBubTk0QkRScGVhQU5mSDBNVHExSlBm?=
 =?utf-8?B?Y0swNG1wcVlGcjR4YUYzOEdXb1duV1pYNVgwbFJaVWNqdzVyaDFhUzg3a0U1?=
 =?utf-8?B?WFZITkJxM21hQmxhU1lMdDVjVlVYcWFYWDFIS2RLaVpsTmxlTFBza1lQZk1u?=
 =?utf-8?B?c1hvZzc2M1EyejZLRjVCek42Qkp2RWtCbU1lUTFYMElHVU1oNkZkVHdQMFhp?=
 =?utf-8?B?M3NDOXgxc3ZFQmRudFJlZU5pcXU3bkM5M2h3SUJtcGlFNWtNdnZ0M2doeEdY?=
 =?utf-8?B?L3FtSlpsV085N3FYSzVIZ081eUZBS1RrSFk4cG1iazE0S1BnVzYrZC95MTRH?=
 =?utf-8?B?bEEvbWNER2J4R0pWVmtuMmgxWlFvRVNOMnUxUkI3Nm9Uam5XZHhtY3ZYWGow?=
 =?utf-8?B?Y1VlMkNqK2tEMG1qak5DM1RPZzdMTm5hKzNjelZiazJWMWlvdDBKUXZNSGtD?=
 =?utf-8?B?WWhGallRRnFOOEVxVVBWL0xBTkFiQ3p3MzVqL3E2NUxmSFp4QVkwOUNNdThl?=
 =?utf-8?B?WW5VNXI5QnJSLysvWk5jbmhrL3VtaEIwY0FOWVNXOFZ1a0wxdFlHUHljVThs?=
 =?utf-8?B?UUdKOUI4QnNPUkdxb3NseW0zMkNmS09MdnRvNDErbzJtNmFIRW9wM3RBK3Vp?=
 =?utf-8?B?cjRyTExLWDFYUEtiSzVLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnJMWEpTVjBpQ3RGdDd0K0txbkNMb05SU29nZ2tUTCtrWU90cWRmWkFDaVoz?=
 =?utf-8?B?YlVsTFo0NGNhdVpWSDk3YWRSa1g5U2JtWjFpeHFmRmFYRFdNSjd2Qy9mWWlw?=
 =?utf-8?B?SU1EU0p2TXg4NnJYTkROUGxxZEpnSG5ZdkNQUUpDanVKbVE0TjFJcndHRnZM?=
 =?utf-8?B?ZVpZK2poNW1YN28zejVJb1greDlZT3NLYUF0WG9LT0ZhdE5vOUN6YWwrRW5l?=
 =?utf-8?B?NzZxekJEZTZieW00NGFMOFpNclozWTI4MGpHSHgvUXdOWUhiLzhGUkV4czkr?=
 =?utf-8?B?cmZ2ODBJcHlVRUUwMDNJQURjMVJleWwwZU91dEJSc1NHcTBOQ1JleEQxcDA5?=
 =?utf-8?B?QXdtYVNXdXQ0NmRzOUdOYklNc1l6YkxLdkU4STYrYmZMT3UyaWM1emFadE8w?=
 =?utf-8?B?Si9OZHJQbGwra3I3Yml4eGx3cWlSTnk5eWdNeXM1UldnSlBxMCtuR0FFem12?=
 =?utf-8?B?OXcwVmRiTDVBOGxRbzE5RXhlY29CKzZ5Umo5MWxLd3NSRERELzRWNFFiTGdW?=
 =?utf-8?B?ZkJqalVEeDRZcFF0MG1hNWZ5N1NTL2UzQkorU04wMVgxZWt4YlJNZ05IZHlW?=
 =?utf-8?B?ZjRPUFBNMm5PaVdESVdqQi9BUEN4Sml4Q2crbkl6YXFOQ283VjQvKzM3bkdl?=
 =?utf-8?B?VzJHWG12QmZGSW1ha3AxRHpTVGZPaHN5U0dHSlR5MHZLeTJBckZnYTdZdTFR?=
 =?utf-8?B?V0hPdlUxOWNTOGtxcnpvL05qNWttMFErVzhZNXc4VXY3VGdsU0FXcloydW5L?=
 =?utf-8?B?MTE1dHh6ZWNpNWlveEVUT3JwekM3MDgrWXUrdUJNWmlyN0NmVG4rYmtsYlEz?=
 =?utf-8?B?dmxONHlaU0huUzRCMzQ0Zk9HY0o5SDY5QUlQazJNWmo1M2ExL2ZjUEo0czh6?=
 =?utf-8?B?dzFXNFlqSE9jcnd6QTVsd0JmMHZjdTJncGZkV21melExR0kvbWhuYUpZcm5s?=
 =?utf-8?B?bEN1ZXh0VEZMTmxzOTRpb3ZNS3lVbkg4QkxTaUpLNnBkNUdOMWhJcDdnTmJr?=
 =?utf-8?B?c2cwN050WjlmN0dUTEJSY3IxWHV4b1lURkM2ekZoeEdPeWZPNjREUU1xdSty?=
 =?utf-8?B?ZXl1VUNLOHNENWFadk8xUFJXaVdTeUVEd0pvYllqMW44dVRNTmlwV1hYa0dj?=
 =?utf-8?B?aTc5cmRTem45UlJGczd2RnNxOU1rWFU2RitjREszVXJoakxINmJ4NUhSSy9v?=
 =?utf-8?B?Vk1oeitTODR1NGR4TUwwR3lTRVVmTGRkdmZvU01YUXp0c0ptWHdLSlJFc2xj?=
 =?utf-8?B?WUk1NEsxdStUUDFWZ2VOTnNySVVNQnBLMkI1eW85WVl2S3RQTEpmYlZydlk0?=
 =?utf-8?B?a0w3R3RmZVlJbEJtbXQrVmFRbzFwcEptd3UrL1BxMnVEUGxhZGZZRUFxMWJ6?=
 =?utf-8?B?aUErVkhpTVdFMUhDK0NraTNWQUFDbjlWUkVwTjRVTmNRSjJrL21ZU1ppNWNH?=
 =?utf-8?B?Qk1QNXJFTysrTVd3Vlh6YmJsZEt0THEyTjRWRitub1czdDRUWUptWkZxYllp?=
 =?utf-8?B?WUlIQ2JCYTQ0bmFGbmZ5TkEzNW1acVcvcVRVK0dhdUdFRmo2WGNPWUQ1dkR3?=
 =?utf-8?B?K3JQRERCRWNpaHA4akFlVjVuSlgwMkQzQThRLzZSNmtuRHk1ckZydGhkeHJw?=
 =?utf-8?B?bkRmS3JHSTlKRkRRMWVXRUJvMG1hSk4wd3Z2TkJaMkI4RFoyQkRYc1UwTDRh?=
 =?utf-8?B?Y0dxS1BVRzBsa3NxTUVpekZPQkRyb2ZXUjl6RUszL2FtWGtta3kyU1NpanRU?=
 =?utf-8?B?K3VDWk9rU0lSNkQvQ1VIcWZIU3djY0JrRy9NVzRzTkhwMjFiZG5XbE9MWWFu?=
 =?utf-8?B?dFI2cTVKbTQvOGNTREdDM0l0VUE1cjM1RG82R2ZWVVVHU09Bd1VTRS9Kdita?=
 =?utf-8?B?dmtWRGpKMEx1OFQveFp4aHFLd0lqeTdmNUFuUnUzQzlSNjR5NEVHUFlZTG9N?=
 =?utf-8?B?UDlSdUduRHJXZGxMWTE4aE1CRVd5Y0dSN0MzZnZjV0VqVG56YWgxcjUrbk80?=
 =?utf-8?B?YW5GNXlSSnFtdEFxdkJWdGF2SUFDZnRBcjVBUFZCZXh6UlQ0N1Bqa3h6TnhB?=
 =?utf-8?B?NHVtMXZOWmNHcER3a3RNenRvS3hMMWRlN0RrKy9INUEvUjU1L2t2WXkwYzJX?=
 =?utf-8?Q?/SbNykT6Yvkt++zsM956bN+Jd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4T5MCnZTJGQ62403agbz4hSgyxIdWZdSfGqmtNMOxhgumAy1SjQd9R26Uf4Etzic/wbdOKj5dLnqqBrCsvTHiwMHYr5MyLPhttKYek1QNYufHhCYG4XcP1FUjElyrlGziDCRD7bfU2to4xlzf45KuqFHhlxf20btqOV7hY0ODYL3DW/ZfDx7usTOMwyhuQ0GjIJkRFbEWlwb6MbMmXj2AzciDCf6wGDHqLV5qLuMKFGmyfgDd1rMz3CuxGkH0iTPdgdaTcUJA64ZfCSg1pFfnsVWDAYBuZRXGXyZCZwMDOpoeXl7b9/1A6fDg49FnaReH4nT6Lz8TakRtXuRbPNXuNgWvuEYozCMBTHnHhagWD1dNZ9Oafb1leZNZdU7fY6+02qG+lsKGoswt9qZqPFtsRR1WU5eFhh6nnRDX3nje4QGyL1vdswdesUyih5RXAmqjJJJELFcsCfC0FjCsBGSBE76SJxbydJex+CGUWsIDP8x0RDyJ49YBEWer1OK6qMgRsxUg2dkM4zKj8DNi2nDgUacg+7ehgqOKhKZ7KxlVnm9sLHesuXcgEr3PmCDM2JVXCDNiudOjY7hYWW824W1JjJCNdUO0yoBvF1z3ghHyyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c61bfe-2aba-4164-2194-08dd6c94b728
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:33:36.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/077UkEZbtLfColY3CgN3IcDlWzPRqnbA/8psoK5MgGrBqiA/9UN/OS+hE7fmco5lPbvjxd8MXadSQFaJFucQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260114
X-Proofpoint-GUID: I4GGc0Lhpx2654jspFDMR-SlYfZUSqsz
X-Proofpoint-ORIG-GUID: I4GGc0Lhpx2654jspFDMR-SlYfZUSqsz

--------------BGiPxLinflCzmPAtDBXhHptt
Content-Type: multipart/mixed; boundary="------------Qut0ilu9ThBrGfAdC0mXLFyo";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <6f3f542f-df57-4382-9f8f-acb25c6fae16@oracle.com>
Subject: Re: pynfs tests for NFSv4.1 OPENATTR / O_XATTR?
References: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
 <9324cfc2-4a74-4577-bcfd-704ffd25240d@oracle.com>
 <CANH4o6Pq1Snhyk9sFeG5sdZ1LKekpSOrLb0Hc-sb-5wSDPDA4w@mail.gmail.com>
 <CANH4o6MOtoQPZp7=5KV+o_42++XKqTUPpGVgtOOwS0eVDQaTNg@mail.gmail.com>
In-Reply-To: <CANH4o6MOtoQPZp7=5KV+o_42++XKqTUPpGVgtOOwS0eVDQaTNg@mail.gmail.com>

--------------Qut0ilu9ThBrGfAdC0mXLFyo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYvMDMvMjAyNSAyOjI2IHBtLCBNYXJ0aW4gV2VnZSB3cm90ZToNCj4gT24gV2VkLCBN
YXIgMjYsIDIwMjUgYXQgMzoxNuKAr1BNIE1hcnRpbiBXZWdlIDxtYXJ0aW4ubC53ZWdlQGdt
YWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gVHVlLCBNYXIgMjUsIDIwMjUgYXQgOTowM+KA
r1BNIENhbHVtIE1hY2theSA8Y2FsdW0ubWFja2F5QG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+
DQo+Pj4gaGkgTWFydGluLA0KPj4+DQo+Pj4gT24gMjQvMDMvMjAyNSAyOjI5IHBtLCBNYXJ0
aW4gV2VnZSB3cm90ZToNCj4+Pj4gSGVsbG8hDQo+Pj4+DQo+Pj4+IERvZXMgcHluZnMgaGF2
ZSB0ZXN0cyBmb3IgTkZTdjQuMSBPUEVOQVRUUiAvIE9fWEFUVFI/DQo+Pj4NCj4+PiBZZXMs
IGhhdmUgYSBsb29rIGF0IHRoZSAieGF0dHIiIGZsYWcsIHRoZSBYQVRUMeKAk1hBVFQxMiB0
ZXN0cywgYW5kOg0KPj4+DQo+Pj4gICAgICAgICAgaHR0cHM6Ly9naXQubGludXgtbmZzLm9y
Zy8/cD1jZG1hY2theS9weW5mcy5naXQ7YT1ibG9iO2Y9bmZzNC4xL3NlcnZlcjQxdGVzdHMv
c3RfeGF0dHIucHkNCj4+DQo+PiBObywgdGhlc2UgYXJlIGh0dHBzOi8vZGF0YXRyYWNrZXIu
aWV0Zi5vcmcvZG9jL3JmYzgyNzYvIEZBVFRSNF9YQVRUUl8qLg0KPj4NCj4+IFdlIG5lZWQg
dGVzdHMgZm9yIE5GU3Y0LnggT1BFTkFUVFIsIHRoZSBhbHRlcm5hdGUgZGF0YSBzdHJlYW0g
c3VwcG9ydC4NCj4gDQo+IC4uLiBhbHNvIGtub3duIGFzICJOYW1lZCBBdHRyaWJ1dGVzIiwg
c3BlY2lmaWVkIGluDQo+IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0bWwv
cmZjNTY2MSNzZWN0aW9uLTUuMw0KDQpBaCB5ZXMsIEkgc2VlLg0KDQpQYXRjaGVzIGFyZSBh
bHdheXMgd2VsY29tZSA6KQ0KDQpjaGVlcnMsDQpjYWx1bS4NCg0K

--------------Qut0ilu9ThBrGfAdC0mXLFyo--

--------------BGiPxLinflCzmPAtDBXhHptt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmfkSHwFAwAAAAAACgkQhSPvAG3BU+II
pA//Q3NOzBG2DkAtBghUMAJ6c3hEtk6I3VpimiFSXy0ZwUoutYJg0QGh6wSR5YnESrW8AgxrFuv3
Bv46iNmzaJ0iAZyAo/1TB+Uwo3TQoOXW9DgJ5nllVt+OyrnfunAbOWLtzxeKsNeYbCy03hWV5F86
jH9sQqRuPpnbyJ521KkgFPVf3a+elU6D9aOs9fWXTWAmiq/F3gLc/HIF3xJnXbtVQ4+iXFAmARda
tlpqtnrn0VysrbE8pqCfiqBXMEk5g+/q4YLGAyA2Wm2W/5CaK2kIPXzXySn6EnUsLRZ9K07f7HCj
hHeAycrxTAg8dA4lnO9legITDodqJA+t/s2ukIWo9HD25wy+blYuT0sqZzXSzB2iMtuvA6JpenX7
cI8uwailWtgq4blI1bP7B9bMNFjjESuhZrPOI3s9+sVGca/AFFIY0tn+6SgUBrmowdhEcx3w5htc
yGHnN3ECUhB6OpOokSCwExSOaNnp5vP7k3HL1Rezo9FLFDHcn75gISH3CpSUWBh4RJKbIzgrnNU4
VOcTIciay/Wlzl3hUBdoejIKm9psQfYtr72W5FThsxuE+pTebg45B2wZiUQyPl/WHU4hQ1r5Vb1R
W0woJEJB3+LoVs4yyiNTqDezc7rOy3S8AuczuWL5t/1inTW3SHeFRyzQLywJtg5U6Lgg68FcpuAh
wPA=
=woTN
-----END PGP SIGNATURE-----

--------------BGiPxLinflCzmPAtDBXhHptt--

