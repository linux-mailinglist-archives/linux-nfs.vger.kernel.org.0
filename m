Return-Path: <linux-nfs+bounces-14030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03312B43CF5
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64C57B7F34
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1183009F5;
	Thu,  4 Sep 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFV4U0h1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a9vYiurz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562782FE05F
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992113; cv=fail; b=pEGKwRx7mzfzB2XTdmfpjhaG9TmVqRM4Rdc8wv9G5KY7GxXpkBl6E0w9X4/cw7WAm/HYtKWNkBS6rqgubp8a1cYnE8Gfvi0Y/YdeXX7d4L88WM813hMMcDKfJNEDA39ydlW7HDhg5UyFyiAuAKirrGpTUqjAUSNjOiaQnTBuOIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992113; c=relaxed/simple;
	bh=O4AwnvvEp+MYV6sazsvvQmjmF5stgjqyjYUgc4i5fBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTslJlIU1UJar/CIQg2JrlHM4qwSBNcXR3EF77o4UopUxOWl52xiUssI7x7MHbwAilpFfFgWKO08IpEKLI5jW9z3GWqoJ2zpbj3O8PK8lem9OFk1YJ912zzQVjGp4pprb/NsP5IGL9KHx0M1lSK0HlAq8/9npzvDycWMbjXgwQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aFV4U0h1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a9vYiurz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584BYXos002994;
	Thu, 4 Sep 2025 13:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AmudsGc31S5LgdB8nsnS3c+zNRa9iNRe61pyvRcieeY=; b=
	aFV4U0h1p6amA2U0iSj3va1nFmTG5mPmUFHRUdQu0ggPRkISMYRKQ1rWaVlpzCaX
	+9lKUteHC3i/jkuSH32hZfNFqwfHu+JUjoYHWv7KjGu8mpKNVSszLgPGa/LG9pPk
	zRJfHc15eNfgIKJ5w0TBImpDTQgyrmcX3A1Fpz6if6krYwohwAZXMt761Xd5ygwV
	AIidP3j8mDxT7FUZ3ef2k6JbJhYUBodE15J8wwLgPJLposLF2uO1FW05LHhAeRkJ
	AIhLmNIrGAr1f01Ru0hCTMBJfvhg6IcuWLdcj2QFuJE9yrL+u+rFRqBIagzhu0XC
	tL+wS2N+IpbGvFeHIe/7zQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ya0w87s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 13:21:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584C1Y5a031100;
	Thu, 4 Sep 2025 13:21:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbnwh4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 13:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk1agw17JrbARGIHqwi7J1suCDxo+0e5l5JpIhaX5nZgSrC+InpLmUKH85XbuDSWZq0aIDt5F7xsFuu+n16hofSV5ePAZ3G3AcfZoPUtN0LNZkdhCyu75u0VgkgWLzl0INsjkrwMKp7Ye/2llGqF/kfwDtRDQVxzp3X4qlzndtXfyk66qyjJ95kJbrfcNIlLpEIrUb2IuOsNd+xfxTBlL/fJAxohCxntEXmOg/PA96DqZQ2gv3eZXcV/WrR+q+GLzDFL5eK94SqaLF0dRBm/wXxzBn9SQUpVYL1uG0dV1mDE1UJCzmHbI45RF8wqAFj9gIOKM+YylgVxnnwnXfOBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmudsGc31S5LgdB8nsnS3c+zNRa9iNRe61pyvRcieeY=;
 b=f9/4DRQvQDW4JTH/lcc7LS8DXES4QJ07FU3LsfQ+X7YwDTOEXPEZQM8DqthHdy7PJxTtHZYM8FAuweYADMXFQclSSEby/XdkXBxl9qzS+ANpNjoRP0XnInX4iEl5J6FUKe12HdhJxanfGSkuImc43flOux8gFGzgukAbEC6+LCz1tE1ZsNm+ndu/TtgWo41+kS6LCLRzzcw/dwJrqLMEKif4Ft3k1c1Q60cF5EH+0KVPSkbTHrAwDCyFkB/SDBn1tdX1gmg7LN5/GlFRcrBGgQAHULRtmh4C/frSPOL7QzWzmi9wKzB6hKkiglqT9o8xNO4glEL3g0+xn3ubd2P3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmudsGc31S5LgdB8nsnS3c+zNRa9iNRe61pyvRcieeY=;
 b=a9vYiurzsYB1OjeRFjSt0AWq1BNCaTEVvEdVZt5tkx2oa1RCIc9HrwMEiYXW2roKcJgpfrh1bZfmhID2KbMwjq+eOKm0qPn0Gx+8ESFpGNYPmo9zDLlxTQ2Zvp6sYogBywgRB3Tpze/Xgjr/F+iWHN6FVt0rmnnY+R7LcQD1uq8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPFCC66F9CF6.namprd10.prod.outlook.com (2603:10b6:f:fc00::d49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 13:21:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 13:21:40 +0000
Message-ID: <456f8683-9995-4c9e-b572-c94c26b0e242@oracle.com>
Date: Thu, 4 Sep 2025 09:21:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Don't force CRYPTO_LIB_SHA256 to be built-in
To: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
References: <20250803212130.105700-1-ebiggers@kernel.org>
 <20250904022915.GA1345@sol>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250904022915.GA1345@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPFCC66F9CF6:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b3dcd7-281a-487c-ab84-08ddebb5fbaf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dXNwTko0Z1dMRlVEZ3Jva2tlY2JrSEJFZkhzd3RQc2FJSjhVMWNacUQySUFr?=
 =?utf-8?B?Y1N1cXpqZXF5UU1YZ0tHWE5LeDJNRkQxQ0phZUJ5YlFFaStrZ2JRNkloU1RR?=
 =?utf-8?B?OXhXbHZmOWwzNjVLRmhDR2hpSGhqSTlXZmVaaitDM3hGUy9QdXg5emhxak5Z?=
 =?utf-8?B?VjJEZU5NOVVzVkJmVk1xZG5VemI2R0ZDT0pmSG5lQTUycFE3TC84OG9HbjRZ?=
 =?utf-8?B?VnZUMkduU05oVmZ4SGg5ZTZCTU1PL0pROEo0YVVyZkRzckFmNjBsdXlQbWRp?=
 =?utf-8?B?eGdQWWtjYUUvaytZWnpJRTJRTEF5ZWM1ZlFlZzVlV0U4eVlSWEtLSmZPa2Rx?=
 =?utf-8?B?cTV4akcyQTFGbmpJVG8zTzFYa0VyYVl1MmFhV3Jsb2hJWUZ2T2lEb1I0WjZs?=
 =?utf-8?B?a1lZVzdKYzFJUHZYMDZva2kyRi9ybllCWUV4K3UwLzhqcSt0dk9JMGJVTFd0?=
 =?utf-8?B?RHNjYzdaVmtDM20rVG8vbVZXeUw4Z0tQYjRuYWJCdmFvSjZvR2VwaVdaa25p?=
 =?utf-8?B?N3N5ZEhwNjZmL0cvRE16aWNUMTk5dVNoZWl5bzFvMnJBYThHRk9ta2lEU2VV?=
 =?utf-8?B?VHBIN3pZajdBMWpJMW9OZWpTVGV0YU1iWmw5UzVkODYyaEtSMWJ4dHcrVkw1?=
 =?utf-8?B?Vmd1Q2JmdktJNnZDQW4raElaSERhdDFhVCt5eXFkeDgrMEpSdko0dUNkSXFY?=
 =?utf-8?B?V0hoUkM0MHlQV0FkWmdBMXMvTHpDSmRmazdpNk1PRHhuVWtWdzRzdUhBb3lu?=
 =?utf-8?B?Z1JnM3NEdjZSc1J5Y1dobkFzOEhmT2FWNFl2OFNmcGUrWnp1WUhqVnA2QzhO?=
 =?utf-8?B?NFB3cjV3RkI3Mlg1c2ZuQ2MyS1lPdFJYSTF2NlBSWTdhZlcvcnZPa29uQ2Fn?=
 =?utf-8?B?WVpoR3gzU3JXTC9UaFRoSVR4M0NxczVLWDNpNHlKL2s4MnlXbXQzYjN0Z1FW?=
 =?utf-8?B?S1lqbjg3RGhLazc0aGljRzJibWlKY2VHRzdrdkVRRG5KZzJLV3JEMFB0eU9r?=
 =?utf-8?B?TWRjckhvSlhlSUExa2NqSEo2OGZTOUZTWU52TE43ekJQNnJYWVdEUVdQS3Na?=
 =?utf-8?B?VzRraVdrdFB1TnBablFocHlIV05paS94ZWlpVldQMWZ2b1NJSjJyUktWNlhX?=
 =?utf-8?B?RjJSNDFKcXNYcFV3b0JlRm9tenN0aHNIdmhMVG5LNUg1RXJkbkVVMkw5aWdV?=
 =?utf-8?B?dWhPYTgxem9VMWpJekpZcWlnaEM4MlZtamVCZ0Q3YlBJM2NZb1UxYWlPLzJt?=
 =?utf-8?B?bDErbnprdUtmOVdzMUozMm9Vdzg3TGRmMUhycmh4aVFRaS8za3FLUkcweG43?=
 =?utf-8?B?U01ERzViV0pQU0dlNkhvYnVHTkxodEFZRzhGa0dKZElneDE0VHhKN1hFeEtv?=
 =?utf-8?B?eXlBZC9iK0FUd3N0em15cWpVeU5SZUp6Z2l3RGs4dzNsZE1qTENZZEFmYWtN?=
 =?utf-8?B?MWphWEhzcEhFU1ZVclhHZEFYMDIvdlZwZXNFS05UMzl3S3FvRUdheUR3L2tJ?=
 =?utf-8?B?SmlueWdEVjZMdXZ3b0hYZnh0cnZsV3R6dGZOQzdYdkpuRXpxUXJmWFRadi9u?=
 =?utf-8?B?bjRtYnkwQkxYaE9BMVpxNG9Veko1dHNmNXkzQXZPaHV6OXdabWhjcFBiU0pG?=
 =?utf-8?B?Y3plR0ZOL3JQNkRkbmRDN3Exd3BLUlpuTitNc0dISmtDU1UvdDJuSHB4ZExM?=
 =?utf-8?B?SGl5bGhaUEhwbCtHekw5MWJCN0YzNXcraHhGell4MG9mbUswZG5iZ3Y0d1Az?=
 =?utf-8?B?SE1QeTc4QUUvUWpQK3lvdHduWko0ZVN3cEZQSzc1aDVyOEp1VGFnTkhhTkY5?=
 =?utf-8?B?WWI1L1h2ODg2V2ZaYk9HWW5oM0ZYMk1GRGgzaVVJd29ld1JmNGdIVW5hZk9E?=
 =?utf-8?B?UkNlRjAyM2drdWE0MFdrTUZhemFGMEVOaTVTalNSRi91OTJQRWFNYUZORG9I?=
 =?utf-8?Q?LrjcYzu3bJk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SXdTY1gwTjVzNk1OcEZhQnVmWnh5QnpMdTFRcWg5Z0MwUm9uQWh3Sy9pUkRG?=
 =?utf-8?B?YTJkR0VGbnFLZmFUMW0vdVljTFhnbG1seE1HeERTNjNMY2tTc055bGgwMVk2?=
 =?utf-8?B?N0hRc1JwbFNwRjRoT3c3MjJRdDd5RlQyYWtKMXoxTVA0N1gvK0JQVG8xMHJD?=
 =?utf-8?B?VmpsSHlmSWxmRWFQYXh6bkIrbFJDck45WGw0cmxGcGNRK25aMlZ5QzUweTEw?=
 =?utf-8?B?cWl2N2pScFJsWHFIZCtKQmluUjhnVkFzTzBURUpPY3AyM05EMW1NNDAzNE1m?=
 =?utf-8?B?bWdIQWdiTXVvektSbzVZdkc0YlBlY2xlb2EvMFZGSjlRMjgycFBOVlZ0d1dQ?=
 =?utf-8?B?U25jMjAzdmlRUzFOMjJCWEdtSXVZOEVtV2ZjUkhnakNOcGNrN0VoemxiWHFJ?=
 =?utf-8?B?M052UnFsbTJncFFjVC92OW1nYWdOUWJwSkFPeEJ6ZDJ6SHBiRDRDOFhnbWJH?=
 =?utf-8?B?Q1B2SVNyR3BPNURsWVYzdWdHWjBJNUJrL3RFWkpSc3p6NjJSb01uK3luYm5t?=
 =?utf-8?B?NnpQbzZ1ZVNnQlhnSElUS05tOHVWNTVYczhld0d6c1dhRVZEYk9JTk9DQk1a?=
 =?utf-8?B?T2tuUi9oV1RKeDV0UEVncjVnYVpHbWozWFhDSHNmQVJkM1pBNHRwWUdtMEZt?=
 =?utf-8?B?Ym9INjhZWHhtMzRieXlVQmpVNlZZNHpGQ2U2S3FLSzZNZHFMb3FSOVJFcmNq?=
 =?utf-8?B?VDFjcnUwK1E3U3krcmNVaUtDdVJya2Z4c2FuZVYrRk1BMlIrblBPc0NCZ0Zu?=
 =?utf-8?B?Rko2c0xCVk1sdGxtVWtmTUIrblg2MjdSQU5lTmFLcGpVZUtSL0VNdlZPRVVN?=
 =?utf-8?B?S2hFTnllclRLOFpZdEFaS2pZZ0JQZ21IMU44VlhKdXE4T1RxelJxVXlubkhw?=
 =?utf-8?B?MVJLblFhMlN5SzArem94UmhaeHVKV1F0UktiaGJkOEUxdGR1OWMvZVluYW9X?=
 =?utf-8?B?cktJS09wdUhwUzBISlUzZVBNbTk3VmhmeENieWtzYnZqcGw0aWdDbUZxajlr?=
 =?utf-8?B?NDFvbTZxZEs4NUhjWG43NVc4aGpwM0d2Slg5czFnQjN1emN6MGs2d2RNUVN6?=
 =?utf-8?B?MjBKV3ZjVjBNSmVLL3ZwTGtRRnZvVE8wN2llVmJOTDVpNWxPREVnR0ZWQVNC?=
 =?utf-8?B?L1pzYmVIN1M4cjRLUlNrdEcxWXdkdTBkQ2tHb2pMMW42a2hub201ZFBGSGI5?=
 =?utf-8?B?N1FUQ2I0Q01JM2dOSVBzNmNKdlJ1L1pkc1hETUczYWhReW51UjdtS2JPcWRM?=
 =?utf-8?B?L3YyZnE4dHJLS1JLejZmZDNKRCt4T0F1RGZUN3F3RThTTWxYUEFHQ2dPajJM?=
 =?utf-8?B?ZXFxRjBXQmJCWGZNd2c4YkhxSmRjbnlCanJKS0Z5WTRaTjNRMjV0OVQ3RDdi?=
 =?utf-8?B?TGFuVFY5WllJcGh0R2hPSzhPVXR6S3Y4blEyRDdqeHNFT2JZeHN5UVd1eW1h?=
 =?utf-8?B?Q1kxQ3ZKZUJVbC9XTkFGdWIzVG1laDN6VHZjTE9xM1NwRDYvWmpZRXRYQUxS?=
 =?utf-8?B?L3dLVnNOMWVLNWhjOHBlc0ZsZEh4MUZpaVh2TUVRZzdackpjeXZtUE1uVy9w?=
 =?utf-8?B?Q1NaK2gyN1JEdFdZQWNQajJ2VE0yR3V5c050ZDk0UkMyQ2dlcmtJVUNCYUdI?=
 =?utf-8?B?ajQrNzJYZmI2enVuVDVXTGd6TmlDNCs1VmhyZVFWZ3pqYVdFWkFRaVVzRnha?=
 =?utf-8?B?alJMN05hM3lVV0tjQmxwa2NHc1hNR0JNdlRGbi8wMlViZHQrUmg0d0pNTklX?=
 =?utf-8?B?bXRnTkVpZXRPWklzdlZsQ1ZxazNBNVVCd1NBMWVVZG05WGNNZlBWc0xZai9C?=
 =?utf-8?B?clhDV0k4ZnpKMmtnRTZiSENoaW1NSllvazYyeVhZeEp4MHZoN2RRSEJUaUU2?=
 =?utf-8?B?a1ZZN2NZaDNneXBJYWRjUHF4WFVpQW5KN1U0Yy85dVFXUzJza3dmeWlHUUdG?=
 =?utf-8?B?a1BtZmFzSkdsUGU1UStBcVFvNlZBUVhhaEVicnVYTTU3aFpwMityWnJzMHo3?=
 =?utf-8?B?RHBWZjVvMWtkKzczNVZYc2d3NHRMRFN6M1lwZXJTQXhMZm0rcHQyNnlNNkdp?=
 =?utf-8?B?Yko1WWtDU1hqc2ttMjVUdVF1ckFSbDFDdHlKUXdyemtuSnBWR2JkZXRwQlh2?=
 =?utf-8?Q?eX4Fy8W37FHGY8sbshftKEP5+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rMOR4nbJNKuzQulUKTWokKNfzzV0M+3Xd11Phj+fOdjeTMc1jVSe6tblKN+7NsMBBsGtdOv9oSPZKVj/NZnl5vZMPi1y6BzB8yhGoS9CA+TYzU0pebsnM6cs5VOMvXQThrTo6Rdw5EuMcvIfDc+HfsMOa/2No6KCdJ+e8P7irTNRgtffIq99w05qEX+kp985+lpovQTCo5GaT9kLpGMKYYS0+bJCUhGfBU8jZ1AMLw5gGw3NEFUad9NU+SVr9UvEPY2Ghbv1fyypXhLNjxieWsefWlvZvmsMH06GMOFTqnWmZHnhwwFVrxHq2QXbDdJGvh2Hw7bN4w9/0gs182/0fo0bHDguoXSaSjXMLjirrneTzvyBxo4C+8IV5THk7i1e771ec3Vj0VihJFjUbxEao/2YkaUSUgwuaDIRIgwbQpwr1/luK2dLLUoRA1lw73Ay43LrVGy2VzrXfXWD6mzoPugaVQlW2eKZA9B4UR1ACBHT+XgT6lnaQ78p6aj1DrdHge8k+jhwXSl8p2DQMjmoQOhdrZE2Gvxj0gOlro+AusgH8YnS+6NzhtSFmMDKxVgA5gqvsxOiKNWhatVoJu7SoAAAfk2upE46m4pDcJA+47E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b3dcd7-281a-487c-ab84-08ddebb5fbaf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:21:40.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr1Bfw2Z9w35ty8eLhoMtmMeiYmTg57HQyXoL3j507c3EV0V0VpAJCM0m+2zIKQ7Wguyd2vE9bchfPWpX/T1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCC66F9CF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=866 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040131
X-Authority-Analysis: v=2.4 cv=eOYTjGp1 c=1 sm=1 tr=0 ts=68b99267 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=WTsGIKrFUVhqaxTzRpEA:9
 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDExNCBTYWx0ZWRfX98OzsXgSPESA
 bjkpeU2a2WK8dg4lz15cG7jXa9CMQvdJ2cUIbAyfE+Guywn/SzcdLeCDJGLlKWVWVuGUP16fRF8
 ViJJ8gkhtkJ6AaOglY+tBwJu9Sbwt3CrSkNAAHD8Ygzn1UV32wf3lP44AopsS2tOOHOcwGo2dBL
 2ge7uOWUbgq14z49ktb71ZNROUkhq767if3ZghtEauAJknW39qi1woQQbFR1y8CkYFox7vOf3Mj
 i03f/VGGeUcJAkPnQ9bPpR80gZ/zBEsROluOG7pkUYFAJZZsLx0vkdzrzhqateD56SDTWkiKfqB
 N0NRqveba9tF8n774N7Ey+36Mho9DfMx9LCGbsCfcJPK8Ruypn/nrYKAmIuji5mzuH/VoWivYcj
 dLjGNBr+qdaSlVXjiuyeTcSAYVsyjw==
X-Proofpoint-GUID: -mTGf8ggsKVlH-TAsJxWXVK33mYfzZHh
X-Proofpoint-ORIG-GUID: -mTGf8ggsKVlH-TAsJxWXVK33mYfzZHh

On 9/3/25 10:29 PM, Eric Biggers wrote:
> On Sun, Aug 03, 2025 at 02:21:30PM -0700, Eric Biggers wrote:
>> Now that nfsd is accessing SHA-256 via the library API instead of via
>> crypto_shash, there is a direct symbol dependency on the SHA-256 code
>> and there is no benefit to be gained from forcing it to be built-in.
>> Therefore, select CRYPTO_LIB_SHA256 from NFSD (conditional on NFSD_V4)
>> instead of from NFSD_V4, so that it can be 'm' if NFSD is 'm'.
>>
>> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>> ---
>>  fs/nfsd/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Looks like this patch hasn't been applied yet.  Could it be taken
> through the nfs tree?  Thanks,
> 
> - Eric

For some reason, I marked this patch "superceded" in patchworks so it
got lost. I can apply it today.


-- 
Chuck Lever

