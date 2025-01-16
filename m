Return-Path: <linux-nfs+bounces-9313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4FA13E04
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D768E188AC2A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160322B8CB;
	Thu, 16 Jan 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wk+My/oU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ej0FjV3e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D222B8D7
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042139; cv=fail; b=UtFEUAs8L2qYxb/lHIkU9gnUyasMzmli2WH3m7EYY0naHoMFRYBguF2jawELLt4Kltw9wcF1H7/KjK22oPYcMfNCZ0B3AUPW7TxF7hWNrVLVlb1qPfSFgz9dobYtLsr6zJWruTBlLpG+bXA9MMgIxpl5mX4ZPVID74t1pd+yEvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042139; c=relaxed/simple;
	bh=BB/EsHpdiRxleVqNhMQiavjgAQoauJOiHcu0iXcokWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=esrUmxTJ2qUvs+jrkNeNZqyDqhABuhFJYXetvDVDCk5RcDrQuT3ia687BKR/dssKDhrS4pUR/YtktpNsRtGuARtd5HcPeUwCH/y7zngrwCbh4I7aR1TjOlJLKltGmvkBxdfOeAFWnYr0DHFZTCK3gEyTfJy93ZWSs3eClB6Fbng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wk+My/oU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ej0FjV3e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEuf5U001972;
	Thu, 16 Jan 2025 15:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+Uov9uPlbEZdk6H0EWGUg+x2Gtz+4IOqOXvPxKgIXpI=; b=
	Wk+My/oUB8MvmEUHi4SwZNKVNo/UU4swAvv+uIg8B+frJnd68NIlVfWuTowlUbR4
	//pSTQYI8Y1MJsxVvKaEu2U4VY9g3qPfm8AQGh1JKSa1RjdJ5k7raIxME8P+Cj1E
	WFPv5aemORrp/PP2/BcnnTimp3wo9HXkTd2+pV4ibrcYv2bVSTRNT3MY9mV8wusI
	ejOr2NlNO/gkIUB/UIslP8DpKRSysgfsh/YvNmIdMQXPlQF9a4OmBlE856IfvMbN
	KHZGS0aw8ZK807YITnK5AYNc1HjjMSoz5yInRUEzQUsABf5Ql/5X3HI0Dn1yMMER
	NPUO/Hr9vL445LbtF3jNhQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446912u6e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:42:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GFGgLO020261;
	Thu, 16 Jan 2025 15:42:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3ha38v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTrvu8O3jH0NSghB+IbyigPcZgWXaSSQSRTRXe6KaUOlH+MAPiZboepS1W4pko5zUpX1OSeIOnKuqOI2+voIBy715GL50Zx12KAbGIUe9IXktXBXneHZ6DXR8qRcwMcwfxRfUialtIfr2wuR/UzA/l+5u50rzGW7jFybJfXgQ43ggeXupWJr7TrGecJPWxskMTuZ/eWWq7UfHY0zzwbTEc2uPpztHLVA9ttKONy8yp6GsFEUV4htUpxvPzuGSHCT90D9KJrfYkq0A67emx8ckxEMpeVRyKKYAeGmrMKNAi/VMHSUtWyudKm3s1efz4XhfGeiUoaZDwp7uw8VAnCHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uov9uPlbEZdk6H0EWGUg+x2Gtz+4IOqOXvPxKgIXpI=;
 b=iP0IJLFPVE0cDynecPmvHNWN9LLZ7hXXVOdpVyttD+rLU6bla/KdL5ZrghnITlx7YlRZUmBiBdgyUVMS5SdydQBzZdqcjbDyk0XubB0EPdhDIqxbRzM1oNbWEA92VjYB4aZNymAnAodelqfXskOaTWDsjDiGpgtlb6odUmnHGWGeFGZN856s046bx1PFDY21WIn3PyMzcuJSYNpS/dh7WJ4AKdG0thvhG/3P7luLo5burBnG35wAzaDBCrtZ+BuOhuuObCtprqpIzvEeNbXhdnn653L/yLLHSnm9x4cWQo+4ZT74Xwm1rN6YQ8dqc6cgEms6iEF0dMIb5zHe+z1jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uov9uPlbEZdk6H0EWGUg+x2Gtz+4IOqOXvPxKgIXpI=;
 b=ej0FjV3elh8n5dpFM19WmBAZTFMtTfT2hqJtpSGidpvOUXp2C8l4irrEZNAjCa/gHZR1379UUF0zV+DWCsjwLG+GS6ZdLbISntA/3w7fRRqBChlp+MwOLpnl6gSAdjIaf5gyKASytflnMxOhoJESYu+uZjDuZAq6qVmFU67L0nA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 15:42:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:42:10 +0000
Message-ID: <d23f5d28-1d7e-4e3e-86da-d0d4d85a9e66@oracle.com>
Date: Thu, 16 Jan 2025 10:42:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: fix management of listener transports
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-4-okorniev@redhat.com>
 <62d3ced2-8c90-4699-b3c4-c58489ec9f19@oracle.com>
 <62694be2aea08c40af7b0cea9d8c1b67a7b2cbe7.camel@kernel.org>
 <1db5da8c-6608-4f0b-967b-a7ba564af6b0@oracle.com>
 <CACSpFtAWK-JWY5T9FK1m+2+s4Jecy1nJOrCtTUFZL7D6YdyO6A@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CACSpFtAWK-JWY5T9FK1m+2+s4Jecy1nJOrCtTUFZL7D6YdyO6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 101f952a-7e0f-416a-a047-08dd364456d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlduQkFySkdacnZBWlRPRnM4OWtWK0g5bHNnd3llZnB5MHpFaFdUSHhJQW5N?=
 =?utf-8?B?bXM4aVVmbkNJekhtZ2lSYytDeEZ3cFovSjNuaC9vcCtBZU1sbklVN1VZQTlC?=
 =?utf-8?B?MjFYakdRK2lBaTRES1VjUUxYNHRnQ0RrQzZ1SDc0eEcrMU1EU1NTV01GM1dQ?=
 =?utf-8?B?dnhtUm1iSHhKUkhmeEJKK1lHekUvL3h0RjJSNVdGZ1FmaHZ1UW5oMWJ6Y25s?=
 =?utf-8?B?cldYVTJmU2tidFQ1RlVCVG5QcjlkZVY3d1diajNxNTZ1Um1OYlJudktEbWho?=
 =?utf-8?B?dGNYVFlaSWFiTG5iSmZpSkVKR0huUXZTTEpxcTdsVXFJWUZVSW5rc29IM3p6?=
 =?utf-8?B?WHA5cktreXNjRXpUdkdKbUk0TEpORW9OazJPSVV6emdoR1hZcGQ3Z3BjdGpU?=
 =?utf-8?B?bkRjNVhzNmtNMnBpU3pjVUNVU2U5a1lHSUFWdWVyR2VxSDFYQmJkSnhLVS84?=
 =?utf-8?B?U3ovdUQrM2JKdnBCV1huQXd2eks5Mm1yd2ZHaVVTckVxYUxWNTF1S2p5TU1x?=
 =?utf-8?B?MUl5cjFJbVhQNmIvU2NoR2FYV2Nrd1VnbUJPOG5oRmN5aE5COSt4UTl6OHUr?=
 =?utf-8?B?VXZMcFA0b2tYQ0JUN29Pdkg5SjZiajZ0NENodU1EaWlPa1pKdjR0S3Bic0ZW?=
 =?utf-8?B?b0VQdDViVWw3bXl3Vkpjckl2NkRRNGtBaGFsQmZObEJXZDRZY0ZuN1pDSDZL?=
 =?utf-8?B?NUJkZVN4QldzUTl1SHNOTEtXeHBUdnlMZDFHbmdOVmxTcWcwcXBDOGkxbWVF?=
 =?utf-8?B?a2FlT3RBM2MrRi9MTXphcmZxeUl4ZkJoTmZuRzE1UVZtcEx1K250dDcvd0ph?=
 =?utf-8?B?LzlpeU9IWlU0UnJXa2xIRHQyaXo1dUhIbHlldEpaczFvVXh6NGFXcEEwOWZX?=
 =?utf-8?B?M0cvbTJ5WFBXSjgxTmt0aW1ndEEzWlBaQ3ZFMXFpV2M3b1VrdmU1cVo0K3Zu?=
 =?utf-8?B?ZFYxZ3RCblJ6V3pnV0Y0TTNmRHE3QmhXcVdMYzFyYXp0YWlJeTNzd0luTzMw?=
 =?utf-8?B?N0FSOC9xSU9GVW9CU0VNOWkybFY4YVYxYkV3aEpjRXgxb1BQWEFKS21GTE5l?=
 =?utf-8?B?eWVJRkI5RU80OGJrVUNPVU4xYVZseTUvU1pHMFBtenFjUmhDMUdGQW0zazhs?=
 =?utf-8?B?UG1aeGZ3cW9zYnU0bDVHRVpXUS9COCt0dC9VNzc5K1JBWlJic2d1anVEUjBB?=
 =?utf-8?B?WmRldVdqS01mQ1U5OFZWMW5mcWdSbDlWMVcwTDIyUTR6VldWZTRuclFGdURw?=
 =?utf-8?B?SWkyYmFWNU9CRzJvdjVhL0E5Q0p0MW9CdmhRMWRwZS9pMS9LUE1EUTJVNzgx?=
 =?utf-8?B?YW5aN21KZ2ZQbmJTdmtKOXpCcENybGo5WGJUZ3UrSU5iSXA0VE1CSUNZRWJU?=
 =?utf-8?B?YXppMHUwMG1JVks5S2FMM3N4ZGRRRWJ6TnpscFNhdmFkRnpwelRiVWVSOUdE?=
 =?utf-8?B?STVKQkRDSEo4YlZKeVBSVStpNVpFRUo3U0hGZmJjVkZYSHZod2UzRU9ET3pU?=
 =?utf-8?B?STdBeDJjNWxwRzFTMi90VThCS0lEWGJjcVF4WTNIclJVY1hVYytTRDlneTRF?=
 =?utf-8?B?Q005RFQxcHBLcjd3bS9EQ2FmSEk1b0Njc2g3M1RWOEt6Vk14TWFXSmZvMVVQ?=
 =?utf-8?B?bVhneVk4b2tSTXBBV2VzYTJkcjdHTUMxSzY4bWZDZmxWRXVOa0hqWXBrVVli?=
 =?utf-8?B?MW1BK1lqTUlxTUZjSm13bS9TaVpWT2dzVi9Yc0U0VGVucGhCS3VJNGQ2bWQv?=
 =?utf-8?B?RjdSdWYvdjBRWUlvSExEd1o1VGpYQ1BQWTdJcTV5a0pSYndqcFRnOFVqM2lx?=
 =?utf-8?B?eTNTeVZZL0N0NHlNT2t0bzNaOTZ0ZlVqeTNLcTlqZE1OdVFaZU9HckcvdS94?=
 =?utf-8?Q?4+Y33U2AQOLvs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3pHM212V1pBQmI2d0pFYmVOQzdBRGZMY1diMTdHd3FweENZektVa1R3ekpX?=
 =?utf-8?B?Rm5paGF3Tk5mSFU2aG9wVEczQWRqS24zZSswaGx4SjNDa2pWN251S2lJRXp6?=
 =?utf-8?B?dG5SdlJNWjBCN005OXdWbC8wMzk3Mklhb00zTTRTSmJMajVzZ0RBOE1iWlpK?=
 =?utf-8?B?ZDZmbmI5QlFiam9hOWErcHJwUDgvRlRsV21BY2lPZG9nS0swSDI0anlOZGNI?=
 =?utf-8?B?STIrc0ZsSHlWNWhUWHpuRldOWFlRZ1ZPeW52V0x1bmpQVE95dlY1TTNDajEx?=
 =?utf-8?B?V2dsdytFakozYWFWcWZQdXVLMWQwMTQ5YXd5cWxwZG44bSsyNW8vSndZcmx6?=
 =?utf-8?B?Rklvd0VJamhnR2tLWEdkdkNqWk1pellkUWJPTU95L0tlK3E4UzdsN2MzL25H?=
 =?utf-8?B?ZWNCUlFXREFuSFQ2RmMwVi9sdm1DWU4yck1QS2dxTUNmTTZLR25xaTIzN2RM?=
 =?utf-8?B?b2FoRlZ2MzA1KzUrbjBOM1VqbHdNbFFISFJwZ203NU1UTTdTeXRwWkdETmdj?=
 =?utf-8?B?QmdkTEdQdDQ5WDFTeUdzMmV4UVNibGFlRThjWGNvMStVTEJkY1lCOHBqRWJy?=
 =?utf-8?B?NmJYTnF3K0xSOTF0dVNwYnVyRThvckJXUWRCMUswcGJVcnlwNytlam9PT1pU?=
 =?utf-8?B?SkE4VWlaS0U3Z1MvY25Kd1Mxa0ZBWkYrcmtnR1k5YUFhaHNIMC9Jd1h4TEN2?=
 =?utf-8?B?YUluRUlic3U1RE5nVCthd0pPNDRBd3RabFc3blY1MEZkRG1NZEFDenU5UDhS?=
 =?utf-8?B?RWV5RjBCS1dJcGwyQmwxTnltYy9sZmtvV0FJREUvNi9YOTZpbmJuSk5rMHF5?=
 =?utf-8?B?M0N3bWlGaCtrak9VYzBKSDBsbTViMzhVb3RyUFBMN1huOXMvWEhHYTNhOCtx?=
 =?utf-8?B?dGRFakRoUHR5Zll6blNDU25pNnZuWDFmclhrWHV3ZHFHWmpTY3lBMkJVZjlx?=
 =?utf-8?B?RFMxcUV0NGxmN25JZFNNdHh3RCtFcjZyakVTWjBQVWtVYi9SeUJ1OWNWcU1h?=
 =?utf-8?B?dXpWN2JiYmxwVVlpWXNMemNEclgwVDZlTmNuODhTNVozTEcwczlaTmVFaEJK?=
 =?utf-8?B?c05vcVRxZ21RK0hxQ0M5UlFJSjBncnV2S1FnL28yeXdIZ1M4alh6dlM1OCtB?=
 =?utf-8?B?VG1Mb28yRFlkVDYrblo0SEVwQ2hWcVJZZmR6MVNvcVFBZHdlQU1RdVYvTnJk?=
 =?utf-8?B?UDhxZi9jUGozdGszN0xOZHF5T1RTRHJ3eWlwVFBUZE50b2hzMTF5bFR1N2hy?=
 =?utf-8?B?dWxQeWl1aityMUd4VFZYR2Q3dVdqbFpZOXZyU2Q2MkQrTUlJUXNZRWtzT1E3?=
 =?utf-8?B?R2w0ZmVEYmJ1QmlnandHbk80VkQvVFZNdEgrSlpUSVdXRTl5dndHdDRHSEli?=
 =?utf-8?B?eHlZWVdhOStTRWVQOFA4Mk80L05RWVY1eUdOeCtCcHdQR0lva3BwdmdzL1Jy?=
 =?utf-8?B?Zzd3WDM0amE1TjVGY2FDRlgvVENBeWlwbmxCTElDS3FyUFNqSEErcTVGdkRX?=
 =?utf-8?B?TEZQeUsxRFY4eTVIcmJQVFhUWEtVUzlQa1BWNi9VbC9iNUVYZGtqMWt4Z0x3?=
 =?utf-8?B?VTljMllOanRENU1RZFRyb1hwUjRiMUxjR28vWEtYb0IxTGhXY0hCTVkwUEdz?=
 =?utf-8?B?cTNtbjNtUll4VDZGNUxiaWJUVTZXSnA1RHNVWnByUU9pUlllcTE5MmU0S2pl?=
 =?utf-8?B?YjRuL0o3ZXpQeVVZU2xXMGhVQlExd1EyQzlabjh1Q2ZRKzN0cnYxRk15eFJO?=
 =?utf-8?B?K0FUTFFyd2p2ZU4xWEdkT0hlTkVrZndlZzFSdTJiaWFPZEJpMmF5aVpQVk80?=
 =?utf-8?B?QjdFZ0RKdVpKbFQ5VkVJMnlFQ01HWmRVTzc5dGlQRUgwSEtkVUdabGF4emli?=
 =?utf-8?B?VTZoRlF4VndpdTJ3MG15QnRucldyaUZnaE1VYmQwQmR3UTlZYmdENU1WUy9G?=
 =?utf-8?B?QUhFNVYvZjlhUktxSDJ2enFMc0NDRTBpUm1VNGN3b2t5WHIwejdhVmU4Ykdv?=
 =?utf-8?B?QU5QWWRCWXdMQ2gzcURjTkM3UnlRa3RSWnJrYk5wMU4rNTJIZ09QeklaTkhj?=
 =?utf-8?B?OTRONDBIRUhYckgyZTBiYmFYck1zbkdxSnJvaXkrb1R2Ly8rYk9Fa1pYMVF3?=
 =?utf-8?B?Vy9zWFZkQ2tMS3Jtd0NpSVZsQm1aR0M4MWdUZUpheFVoSEoxNHJ2RmdaTTF0?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bzAMKMZW6KVeNJGRVobsvbY23eewfrqNJmMGv8/NROWEwiVukikQFRrTQLZaR6HYK6KAY+lsbhMFCUmcljqimHmZfzW+UzJ+dVAqhxppbr62d+TLpBx6zMTU/RFVOv4nGcT/cFep1rB/fLFENonBrZBLXZGU/o+v+bXTwdPTdYMbY5mysq7FPZKuTn4qrxexBhiqXslTxtxqz32v8m2Ab93g2bfnCDjw5ImhgqDRknObAHhmV+j5R3f9U8qnBTD4uKx9bOsXvkWwdjOx+UlZ+5rBGFYXXjNvt1LMDgZnrL+JUJ4A5mrY37T4P8Cwhj4k7waBM/uIIhTQXPrpIjn/1v3Du/DR8we/0PNRcrpH+9nZjQ9PAE1Xyfo3lber7R3nZK3Q78+xXU6A17pBvTVh+QZPPZXcESDLUC1F/D7r4WjnUJP0+68tUfiDtv3GncEbkFBU6qDrmgRB9ElUtXhRj45tIyChqFbMC9UtSOGK8iGujiylD3W0kOprk6evuyI9WeHL7PmkS56slQYqWG+o4QPlaLFAsElVNxCkefNdizKVRixmG7ZfRY7Sen3nSIXPOSAwB48tBLN6JlTjp6cBcnSfQH2siwOTft5lE6aZHms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101f952a-7e0f-416a-a047-08dd364456d9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:42:10.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM4j4haZ7qqmsu0cu5n5dVbPO0wf+lcmMJrOtdhEzaAYSTT2oO/9Qx6WfZJCxfDhzQFpWQBuBZLyMsy8Zkbd6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160118
X-Proofpoint-ORIG-GUID: 7vQT_-ExG7lV0ffUBoqAs4W29gXfIwo-
X-Proofpoint-GUID: 7vQT_-ExG7lV0ffUBoqAs4W29gXfIwo-

On 1/16/25 10:34 AM, Olga Kornievskaia wrote:
> On Thu, Jan 16, 2025 at 9:55 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/16/25 9:46 AM, Jeff Layton wrote:
>>> On Thu, 2025-01-16 at 09:27 -0500, Chuck Lever wrote:
>>>> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
>>>>> When a particular listener is being removed we need to make sure
>>>>> that we delete the entry from the list of permanent sockets
>>>>> (sv_permsocks) as well as remove it from the listener transports
>>>>> (sp_xprts). When adding back the leftover transports not being
>>>>> removed we need to clear XPT_BUSY flag so that it can be used.
>>>>>
>>>>> Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> ---
>>>>>     fs/nfsd/nfsctl.c | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>> index 95ea4393305b..3deedd511e83 100644
>>>>> --- a/fs/nfsd/nfsctl.c
>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>> @@ -1988,7 +1988,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>      /* Close the remaining sockets on the permsocks list */
>>>>>      while (!list_empty(&permsocks)) {
>>>>>              xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
>>>>> -           list_move(&xprt->xpt_list, &serv->sv_permsocks);
>>>>> +           list_del_init(&xprt->xpt_list);
>>>>>
>>>>>              /*
>>>>>               * Newly-created sockets are born with the BUSY bit set. Clear
>>>>> @@ -2000,6 +2000,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>
>>>>>              set_bit(XPT_CLOSE, &xprt->xpt_flags);
>>>>>              spin_unlock_bh(&serv->sv_lock);
>>>>> +           svc_xprt_dequeue_entry(xprt);
>>>>
>>>> The kdoc comment in front of llist_del_entry() says:
>>>>
>>>> + * The caller must ensure that nothing can race in and change the
>>>> + * list while this is running.
>>>>
>>>> In this caller, I don't see how such a race is prevented.
>>>>
>>>
>>> This caller holds the nfsd_mutex, and prior to this, it does:
>>>
>>>           /* For now, no removing old sockets while server is running */
>>>           if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>>>                   list_splice_init(&permsocks, &serv->sv_permsocks);
>>>                   spin_unlock_bh(&serv->sv_lock);
>>>                   err = -EBUSY;
>>>                   goto out_unlock_mtx;
>>>           }
>>>
>>> No nfsd threads are running and none can be started, so nothing is
>>> processing the queue at this time. Some comments explaining that would
>>> be a welcome addition here.
>>
>> So this would also block incoming accepts on another (active) socket?
>>
>> Yeah, that's not obvious.
> 
> I read these 2 comments as "more comments are needed" but I'm failing
> to see what is not obvious about knowing that nothing can be running
> because in the beginning of the function nfsd_mutex was acquired? And
> there is already a comment in the quoted code.

The patch appears to reviewers as a diff. There is no part of the
"For now, no removing" code that appears in this fix. Even when
going back to the source code and viewing the change in context,
the "For now" code block is far enough above the new dequeue_entry()
call site that it's simply not obvious what's going on.

A new comment here might read

	/* We've already corked new work above, so this is safe: */


> I have contemplated that instead of introducing a new function into
> code that isn't NFS (ie llist.h), perhaps we re-write the
> nfsd_nl_listener_set_doit() to remove all from the existing transports
> from lists (permsocks and sp_xprts) and create all new instead? But it
> does seem an overkill for simply needing to remove something from the
> list instead.

Or change the management of "permanent sockets" to use a different
data structure, possibly. The temporary sockets see high traffic and
benefit from the waitless list, but listeners can use something more
conventional, as long as the thread scheduling logic looks for work
there.


>>>>>              svc_xprt_close(xprt);
>>>>>              spin_lock_bh(&serv->sv_lock);
>>>>>      }
>>>>> @@ -2031,6 +2032,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>
>>>>>              xprt = svc_find_listener(serv, xcl_name, net, sa);
>>>>>              if (xprt) {
>>>>> +                   clear_bit(XPT_BUSY, &xprt->xpt_flags);
>>>>>                      svc_xprt_put(xprt);
>>>>>                      continue;
>>>>>              }
>>>>
>>>>
>>>
>>
>>
>> --
>> Chuck Lever
>>
> 


-- 
Chuck Lever

