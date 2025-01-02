Return-Path: <linux-nfs+bounces-8874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F439FFB11
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08527A1D62
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF11A2C29;
	Thu,  2 Jan 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqbmIPI8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hykJgA2D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE01B4148
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832311; cv=fail; b=b4XPWmb91V1j4ADw/UZA1TDg3+6W6j595UhoTfPqNRipjx70eRuPP5FvPkd6L02Yb1HBp5JUVh4OnB9buebktrz67d6/2drH/WWouAeRVtF6R547u5J65lZl0/Z769equ2RMAmAhYV97SYHLOQam09XXP5BoPuIFkbrgiP6108w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832311; c=relaxed/simple;
	bh=yUF8baIfEI4TCrNP0496OgdWHjg3Kea3UDkNjMI8Uj8=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JF5NQWDJfuzkXn7uzFi2myyiAcFanC1cgPtsDWwarNN/eXoyJUgcyshyeq5txgaruuejWDm4+n9bHiVbopg7aA0MiRDOpJ1zaFy+jR/TTpksxta3B/YuopRM5Ac557qqPoYQHUfB+HbBe8iEtSvVxufUgXtYdPRDmkn5WQiRbf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KqbmIPI8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hykJgA2D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtrpM018980;
	Thu, 2 Jan 2025 15:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8MnW7RIaps/G3WBf5AO63xPKL9lutsuuqc3G7PUDlx4=; b=
	KqbmIPI8YfLEMeZFxu9XiP+17tCSZWD7SK5jeP120vVO8b+uL3494JVKWeG+Y52m
	AdVfHRpDegvEfFypkXyYX96G2RpSaYYG8E3Y4AsaIUXQzImpmuDPcL6ysxrEyia6
	NHcqb+K11b0fnb/aWk+rE7lgykIeckrhf4Yg3bvn2CljTa3nWeXATCg6VIrnK+hy
	9HncBRpWomnuQh5h2D5wAHwh9cEaUJ+u3tbCoGHfnJzNpbesfj6ARbJcosv/KZyA
	uLl29XHuv114h2aZTDTjomYBTdxwIuAX7WVJ/7qH5VuRgUlZ6ALi20UMzJvFN2M1
	KBwRF3AENfzPJN5kqha/wg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a5k7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 15:38:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502FWiOn012908;
	Thu, 2 Jan 2025 15:38:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8nx5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 15:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBdlVnnJ/RMINx+msYo5JPf3wW3B5Ci7Co5yychO5dyaVThRe4qc/sHQPF/tGYPGKcQBNOjUGfiOyr6WLa5M2Y/FzXGQTbQu4AbLuCdgJUz8tlz1ewqYhUEM315MNQeKLVlP8hDIrREa56+BW5NhVcKHtUb+v4v76YSTH1WwbdjNGKScsLUaXBdG/LxaI7sGTt5u8z74pGlqEfhR/dW/ativ1XtZJlRr6Hum4G1AWkwcyydO1xa2w4XfWOzN+DOkXKyw1SzLLZahzK8Y2w02IWKllCsU7D7NMNyote6pcYpJNZxatmSAnHheEyN7kSRDp1sfcs00HkrZ0h2XsWyVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MnW7RIaps/G3WBf5AO63xPKL9lutsuuqc3G7PUDlx4=;
 b=Z2psT4Okh/lq/+RgnDC4yNAyifxpNuy14BebfCKG04JpuaFbEhTYqjBdrc5/Ye/QUy9fV71oTj/DDu8AYXkCRNO9lCbhh0jN/2sAo9pM515kCaCGRZG1BBwSO8YW/Hg5Pv1ZSbnvRUQ9FQ72Nnxsw3vTXv7Blz5tkPDN/QZbNC1pEldet3PIs3ELUBEeVnDp1Ph/7IgdNWDwMSW3Vf09rgCKiXgpGv1eeLhM+xG8v3FBV8X3MqiKBxRdWPLj/ldzej9u3enHzN7uuPRYaYoezQLB2D5DZjFtNHyGZG0ysEQIamO4WNkBknv0tLZgDiaPsaCk3YBKak4QizwCDqgtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MnW7RIaps/G3WBf5AO63xPKL9lutsuuqc3G7PUDlx4=;
 b=hykJgA2DeCdRYK8h8KqlktuIMpGL54/pD8dd3cLKGb5Xbe/1U8DhobnKNIYgljYqmR+Ub/LsxEh3a/OO8Yt4mgLN6WvMMP1rfiQm69tQUcK8KjWjjlWD8m7hjLhPC5ERpqLNdWyVWK4mLOZrD43xC04o0PueJAzdMDcf2hp/2TE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7631.namprd10.prod.outlook.com (2603:10b6:610:180::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Thu, 2 Jan
 2025 15:38:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 15:38:20 +0000
Message-ID: <62b728d5-1c8d-4689-ac2b-f30edf9336fc@oracle.com>
Date: Thu, 2 Jan 2025 10:38:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Why is NFSv4.2 READ_PLUS off for RDMA transport?
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CALXu0UdnOg5KO7HS-tCCxqkWPDs5U4MRFqea69uSRyAC1wmqXA@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0UdnOg5KO7HS-tCCxqkWPDs5U4MRFqea69uSRyAC1wmqXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:610:75::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: e9619b61-4722-4509-11e1-08dd2b437c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0FIVTFFWE9NNC93MW5UR2drTkgwVkRjdFhtaTFuVmtTUXRJYWJESlJFSzhw?=
 =?utf-8?B?SU5mZ0M1NUZtMjNHVUhmVUNaNzc3THlEZU9UNnNFUWxRMGJWSlJvSk5VaWRp?=
 =?utf-8?B?aGJVZks0eGFIQU5tcmE4YXRRb0grNnN3cUFrWHQxb1RmcDdpNUpIMEpJMmRP?=
 =?utf-8?B?REgzWFEwaGY4aUhiOGU1dEhJcjdxS0FlRzhMQVF1WElnWnBDZFN4bHpmUWQ1?=
 =?utf-8?B?UURydDllNU5YeGFRT0svbGxVc21LUERaZ0taTTJzU2dKL09GM3hWbXpINzNR?=
 =?utf-8?B?V1FtdHVId0k4ZHIrK0xWK3dKZFp0b1M1eHlHVlZ1LzM2aWpzRTFYc2JJN3VG?=
 =?utf-8?B?VG1ZRUpsQy9wYnluZzNYaGN2azMwY3k0QUhXZkthdmhLOG9yYlZnREZHU2lD?=
 =?utf-8?B?ZnY5c2xINDJTa0hmOGlMUWFodEoxWHRuRFNuYnVlcysxOEJUNWd0TWtuYzgw?=
 =?utf-8?B?T0tCZDhHellwQmdBTFFLMWtId1R2ZzFQRll6R3RQYTJGMEowemgzTnYzaVdj?=
 =?utf-8?B?RWVrRDJXNkEzSWgwbHFBdW00Y1BtMkFqZzYweDZtajFvOHVWMDNhSEF6bWhi?=
 =?utf-8?B?MFlzeFd3SFlMa1FZU1dpZlExc2l2L0J0bVdFekJFd2g2T203SUY1d2ZTMkhJ?=
 =?utf-8?B?STdkQ1lIb3BnK2NiSUVyQXN5c1pMVjluYkk1TVB1KzdtcEh5dzZ3OXZoV2tN?=
 =?utf-8?B?enE0b1pqSHkwNnBFTXYwRWJScHMwUjM4SnVaUDc5bENmQWRyM0xxc0VNU29S?=
 =?utf-8?B?VDZ2aS9wdXJEbjVhbDRadFJHMUNlL1hydGFuWUtoL2tscFhPaUt4akc3aUJD?=
 =?utf-8?B?b0VOU1VTQ3BNTGFOemF6cEpoV2J1Ky82VjVCWUkxVDNVQURUYkVkR01FT1Jr?=
 =?utf-8?B?NW03MjhxaDVlVDdNeFhDM3FKR0M0aHYyZVo5TzUzMkh4MW9Pa2xibVlRbkZv?=
 =?utf-8?B?Q2VRTktpb08vKzRWMml2NkVVcXhzWEhiMUQzZTB2TC83QzU4VGh6RXhGNHEr?=
 =?utf-8?B?bzFGMjZqZzR2bHd2OUU3WGNNN0FvZElWcFREcTdzZDVSZktnUlduTkJOSWMx?=
 =?utf-8?B?N0wzZUNkaGhpcVRaNEpCMzkrMHhkSjJsQnZXVEsrcndJbTRNODNBWG1VMDgx?=
 =?utf-8?B?MWU3ZXp5S21ta05PbFdjTUJMdTN4d2ord0hwMVBTNzFaVis3QUFPRmc2bFcv?=
 =?utf-8?B?YVZYd2R5b0F5Z085b0JnUWFVQnEvZjFOWkxWQ1pXOG9LNExPNlpGRTRJemhB?=
 =?utf-8?B?S3ZTbkY1TGRSS0MwcmtlWjdveDhraE1GMk9ZZUZBTVBnVU9EckxuTi9MYWU2?=
 =?utf-8?B?VHJubzlGUDU2WTBTd2RCR3AzazU1dXhiQlFmeEtRMGRHVDZ1TU9taEtsY1gw?=
 =?utf-8?B?L2ZKTXJaNXdHa3ZKSTVzSVQ1ZUVyVURKczBmeUNJVDV5Q2tNRFpVTkVxUGFo?=
 =?utf-8?B?OE1MNXduOWN0VEJUYThCeVh1b0dKWmlXRkJMakhMWXVTUVBtNm9pNWFSTG5t?=
 =?utf-8?B?ckorZVJMUWhsRE5lalErWGx0TlZvanFWWklpU1IzTys4Q2JyS0hpQUNVWmZD?=
 =?utf-8?B?OEVTTGJFTndpRExZRVdXK0xKQ3JYT2g3bEhwZll5Mmhma2srTUpBQUZCanBW?=
 =?utf-8?B?SWJVTVZuWEJmTGZYdTdPbzVUNTY1ZlRpRlg1OGwwU2tTcnBMTU1mMG5zU3hU?=
 =?utf-8?B?ejl0U25wVjl4WndNTzkwSGh2aU1ydTU3MHBKNjVBNU1kOWdnbFdtd3VHVkxz?=
 =?utf-8?B?U3BKUjRreWVmNVpkSC85K3hJZi9XcjB1UitJVktlTmxmcnJRTFZ5ZVRvbXd3?=
 =?utf-8?B?WE9yT0E4YkU4VnBIL3FnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmhCT1R2U0FraDlMOGNzbVM3YnRONzlsaVJ6QXVVRUQxVEw4aWd2a2NuWFRU?=
 =?utf-8?B?aGtML0JTWlZ6WFhjL0Urb3JtRTVMSmdBMUhDS01YQXlHQ1hLYUk2RkZxbk01?=
 =?utf-8?B?b2prMXdzSzl0NUw0Qi9mcjdiTWRkc0RGRkRHSzk3d1R2UHgrK1NxdDU0cWZN?=
 =?utf-8?B?T0JpVWU5YVRuMWdSWWpHa0ticXRqZWVaYzVRVlJGMkZhOTNVcWRLaVg1R2cv?=
 =?utf-8?B?QjhtM3BXbVU0NjFxSk5LanVTZXlVK2t4Y3RuM1JrUEtZMHg1VVhLNEJDT3gw?=
 =?utf-8?B?Q0xlRzBIUmdXRFVGVFZuamptRjViNC95NHc5UjBxN2RkYXBOdFdpWDhuSnVP?=
 =?utf-8?B?VmZPQjAwTzFJUHpzbjIvVTQwYkpVVVZZL1JZclNOK3BTcnBySkpkYUNTYzNK?=
 =?utf-8?B?VnhzcUJtbzlxVnZqUUdHVVVXWCs4aUZlOWtJWnM2SDkvRWwvWWl3enRtaTdt?=
 =?utf-8?B?akluL2VyR3JsZlJKSkVwdDJiZnhRczV3bDlBZG1BOGhTeDZsdmsxRXVHYjJ1?=
 =?utf-8?B?S0V3VU1sYlFWL2ZYVDVHRXJTS1paVmgrQjlzYndNc3pjSUNsNHJCc0txeVZ4?=
 =?utf-8?B?Q3l2bWI0ZHBqVGZhUmRTT3hpNUZCMmlWQW5CeXovRlZWTGdjSVdCdURhdkxD?=
 =?utf-8?B?T1BCZlR6SVQ1WFpVRWNoc0ZIUTBRb1UzczFqUDViZEkwUS9aWC84L1ZFN0E5?=
 =?utf-8?B?czdKK2lCU21sbkZ4K29qLytMbG8xYVVReTYyNUx1dEVaVENHNmhacGNUSWYv?=
 =?utf-8?B?bzlGTG9Sc0E3bC96ZEJkbXNJK0I0ZmJPaTZ2WS9qSi9BbEdkdzdiaW5NVUZv?=
 =?utf-8?B?T3NQVlFBcnkzaWZIajRQdDhGTDNrMVczdGN5RXJaSHVXU1hyV3h2ZUFMSWc5?=
 =?utf-8?B?V0ovd3BvMGV5RDhDbWNMbFhTT21wWnpKdmNCVUxFdTRYcmtLMDM4YURGRUta?=
 =?utf-8?B?S0NXeWNYa05taHMxR1BDR3ZTRUk3S3R6Ym9sR0NNTlNRZUwwT2xHSGtRUlJO?=
 =?utf-8?B?aUFPRkZ3OUNEZi9GRjVoYzFzejl5MFhPTlByN1NmRjlwL3dZY21ZSC9kajZC?=
 =?utf-8?B?dXhseWFGbHp6QlFjWFhibWFyVkpnS3lTTVpwYjh0MVFMRGxpVmpqK2hvbStj?=
 =?utf-8?B?eXlvdWtSZFRoVTdPM0U1ZWF4eDFwVTVwOVRRcUNoK3pya0RkbGF5NVZ4R1dr?=
 =?utf-8?B?bWRZU0EwZ1Nzc3B5UUZWREtkSjhWMDI3Y25DZnZyblhRWkZPR0l1VDVCblpi?=
 =?utf-8?B?VytWOVZzUUFyRzNVR0Fud3BuRUJ0U2xIT0JDZlJyZnVRaE81d2doTVNOTGdM?=
 =?utf-8?B?K2c2UWRMakRpQ3FiWDFUbDl1VE9id281K2F1d2pnc2ZzZXNQc1krWHRqM3p3?=
 =?utf-8?B?L1lJSkxwdDNtYTE4L0R5UlRvSkYwT25BQU1HNnM1cXVjcGFld1V2cmZSc2I5?=
 =?utf-8?B?UXBkMzJkMVBEMnNuVllFRUFodGNTcFZySlRDVFpiWTE2NExLalZJN3hyMWR5?=
 =?utf-8?B?QUJ0bm9nOFltUnN2OEdtYkEyNUQrcXQ0aEdJWFc3bDMycGFYUTJLYzkwMjIv?=
 =?utf-8?B?YUx2NW5YcVYyekFZUHhpYndLUlhxdEtSVmJRVjV0b1ZMZlFHckFETU9LUVdU?=
 =?utf-8?B?aDZVWWIydHVndE5PNldBcTBTc3pPZkxMU0MyZnBvWVNrMkluYmFTZU5PR2dO?=
 =?utf-8?B?UnB4dUVOaWwyd0k3VGZ1TVJwbG0wUDJ1WXlZdjVnSjZqUDJWUngzWWpnb2p3?=
 =?utf-8?B?NUdIYUZXbEYyeWY5dndDdDVvVm1YV3MzWGZDR3FiSGl4K1JvRTdsVGNZRmxm?=
 =?utf-8?B?TlBmY2REMUtDZkNzSHd2Smx5UTY5SWdPd1NSb0pHVk84MzE1V3pXeWVDdUIx?=
 =?utf-8?B?Y1FMbmJoS0h0SkJmSTNGdFFsdk9QT3BjKy95QkV2bmE2ZitvZWVTL1B0NG9U?=
 =?utf-8?B?c0dBcDZmSzlwVXBhN1oxSlNianNEelpndklVN1dwSFBBelhVdTVpTDh0L3Y3?=
 =?utf-8?B?dTFxY1dta1htOVd6OGEvSlk4NzZOSWdPL2V4ZVpRWURqS05aUGhtQ0E1Nmhw?=
 =?utf-8?B?TlRwemdNaEo0V1dDYlNNazhkS202RU80TU55c0ozczZ4STFOM0dZNTZFTDV1?=
 =?utf-8?B?d2NWNE1SZXlpSXgwaW5xZllvQlYrSFA4MEJtWkFMcjdmTmIzZkF4dXROd1kr?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e/3qe7lSk3eSVImWxlhHEb2a40pktxrsyN8/uW8GGr9TkslsjET5P/j0bxKP5wtOqUN0yux74fIOLnuWEIeuXoPVzPWIJOx0cCQm6OEd65BKlfe+ACyOdkXhxVxp+AhOvtGXJsKkz5EDXcdUvzZTxWV2uhvGUMQ8Aev17s6EwlWEeYBII2PX9KM3waORAnDsE8g0XjLuXfNuBVqGJfteg0kFTEqwUk+BrJTcEeSxYsqDsPEIO0JXFxjDLhnxr/S9KcFmfDUiCFOPE11LdQzvMn07Fww/ON9W8N3auOzpsFq/MBKPMol0a9tGhI9sXj+Eq7QBq4492kuBByFo0+u1kvwwn0HlGTU+s4gt0ThGksilXAwRyiLM5R37BPN81q8fffWPw5WMmC7U8R0Xd4VODiGnAX42P8OgXVfmZ2czO/uBf9cVV17FPas7MHox+GEaOmmjj+xbVjKOzUvn2aMEDiuaLWSHCTkS8HRl7a8hqt7fO0DTaFe8tcvJN4CqofZx1SNK0c9DQrXcIsZVFJWlBAODhKcByjJ7sp/eFiOBUKnpCd0ONOnUCm2/nWM07LLXS2ci7bwRbE4l+TwUF/UQuxIRZqibYJNMc+AFrEqMC10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9619b61-4722-4509-11e1-08dd2b437c00
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 15:38:20.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdPqZVa9Nb3eEuSdHzy73oeCdKuY5px8NlDk5N13dyXMyWCPcoZjKlsDlg96W60VWIgFenwLZMUM1M/GnGx4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020137
X-Proofpoint-GUID: yV3MVwqkVJ2MZifrffYPdSnyeh67Ouly
X-Proofpoint-ORIG-GUID: yV3MVwqkVJ2MZifrffYPdSnyeh67Ouly

On 1/2/25 9:32 AM, Cedric Blancher wrote:
> Good afternoon!
> 
> Why is NFSv4.2 READ_PLUS off for RDMA transport?
> 
> fs/nfs/nfs4client.c has this code:
>   1084  void nfs4_server_set_init_caps(struct nfs_server *server)
>   1085  {
>   1086          /* Set the basic capabilities */
> ...
>   1090          if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
>   1091                  server->caps &= ~NFS_CAP_READ_PLUS;
> 
> Why?

It's complicated.

First, I refer you to Section 6 of RFC 8267:

    https://www.rfc-editor.org/rfc/rfc8267.html#section-6

Which specifies the data items that are permitted to use explicit RDMA
operations (RDMA Read and Write). Note that none of the fields in an
NFSv4.2 READ_PLUS result are permitted to use an explicit RDMA Write.
Therefore, the upper layer binding does not permit READ_PLUS to use
offloaded data transfer of specific data fields.

Why?

The way an NFS READ-like operation works on RDMA transports is that the
client registers the READ buffers with its NIC, then it tells the server
how to write into them (via an Rkey and offset).

Recall that for READ_PLUS, servers are allowed to return any number and
any mix of hole or data content segments. The client doesn't know in 
advance how the server will lay out the reply.

For NFS4_CONTENT_DATA, the client would have to know in advance that
the server planned to return content segments (which might be suitable
for offloaded transfer). It would have to know how large these segments
might be and how many of them there are. This is in order that the
client can register Write chunks for each returned data content segment.

We don't have NFS-over-telepathy yet, so the client can't know any of
this information in advance.

For NFS4_CONTENT_HOLE, of course, offload doesn't make sense. There's
no data to transfer to the client.

Not only that, the client is responsible for expanding hole segments
itself. It has to zero its own memory.

With NFS/RDMA, we really want the server to do that work -- in other
words, it should write the zeroes into the client's memory so that the
client's host CPU doesn't have to bother with it. Getting the server
to fill in client memory is the point of using NFS/RDMA.

----

So, based on this thinking, it was decided that for NFSv4.2 on RDMA
transports, the Linux NFS client won't emit READ_PLUS at all. This is
an implementation choice, not based on a spec requirement: of course
READ_PLUS can go over RDMA. But it won't be terribly efficient and
will involve touching or moving the file content by the CPUs on both the
client and server, which is what using RDMA tries to avoid.

HTH.


-- 
Chuck Lever

