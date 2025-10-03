Return-Path: <linux-nfs+bounces-14970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62507BB829B
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 23:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C3319E4DD5
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E932264C8;
	Fri,  3 Oct 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RnMH4iHc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mc1+v0e0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371A22154B
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525484; cv=fail; b=oT6fWgMxqjlmhHPLs3hWeTalxr5H73WThVz9lFO/FOxy5l6TEVfzO5eA+lBjmgmqXw4npenc2pvAYWOrGV+S4bMx7xPCTuD3Abhd0DYcKkyivNFBaqDvZhWPYPhg/TJVGAhNtDfwi7lVMsLJiMrfmyRIEdn4iZrvELXYVVRPdZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525484; c=relaxed/simple;
	bh=Pzvu05cFsIy+fbgnCMid6VsGzqduzWuEbHv98976vWA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nV1KLa3GC+8t0BHTOTRVaTAd8mHqd+F9lD2qOt3/X6asURXHqOtg3/uGyVqNGrXrsCJtUY6g2A80W825F+BIUUhWk01wG+PMdC5H/F0mUI4WqnOj1ZnrVT973cDfK9tow0rLk3idL4weHz/5k35z7gnn3nH03ojEAW6k/Kvwmcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RnMH4iHc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mc1+v0e0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593L0ced000943;
	Fri, 3 Oct 2025 21:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O2wHZXcbXUWOqG4P9FSJFkX5eCeA8w9+xFtkEQtaFgc=; b=
	RnMH4iHc5mTDsWceNto2u6yem4WTl0wu84MjbTAX3iT785BBMI6dGef5qt5yttXY
	xTlcOnwadZijhaDHOfJCNhL+AsV9FkXGyodl9kksoN408Wu2YUHwMrLJZ/FMMnME
	f1NBEp+boWOyx0Uecy2aThzl+fDCNJ0qlqATN4gYvn3apHUxvbGC2A2L4XxRExFg
	4rFSyL6DjbJpsflPbZWgC46G0l/HdPd7rB1X2YrmQDBH5jSHzJAMMEXMkgAiKMi0
	hhZTEUAzhfPVEn8kstr1IQHfQFH7FKKKQtjxgSw87h1vWmmOD9wnl9WdKcOmaadi
	UG0XTj3yT2ua+fGcpmfggg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jnjng1ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 21:04:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593Io8D0017244;
	Fri, 3 Oct 2025 21:04:35 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49hw24g0w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 21:04:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+S2rIPKJQfzTnlVsh8GTZDMCRF61KcedwolG0bJnc3eurhpyDDbJCiDdk6hxRffNZCygAKoxbuvy8wp0t8LdpD7bzNQKJkCZSfa2jqxtNejk+IdcxKsu9dC3Qv6pFKdab2AY93mCkV8P3gDSN6ZGG+5hDF4CJb1Vw36Y/jqtlPxx9It8g39COjfE4w4CQpf7wvTy0nDWpRBBhrG32wdUBovYT6QM4oH9refcywkrQ04w76ZKEtPR90pjL6Ksk6bkVLheSVJ8OH3wHVL60i4t4dXrcLs0sbTxgzbEn4eB3t9Du5BR4azrnFCIXVkXGq6qz4uWaw9lC5b17HsXS9UQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2wHZXcbXUWOqG4P9FSJFkX5eCeA8w9+xFtkEQtaFgc=;
 b=UZ4Om9F6vG1kXm7adzNoJxgeWAMWD1uF6MKYdLeUm+FbRmWDpnSYs+LnfDTTY+Ey308Ady7Wn2Vp7s5rb1P9Ay0Z3yeHlqkQSYaeATb6UTIl9kc1HZ8xUva8FRzRjKbQCx9cgag7NEtSAMmiJopfEURioRomrmJSjk61JpxaipmDm2/WVdL5u8wwu0sgilBo3ggaSb5YDFoCUl1ZCKSoy1w8x6CQL4BZOWqNjljr9tj4Y7ZreH9SPY5UtQH8i2JWBcwkl4rsgIwQkT5Oa8s9C1DTG9e5ONj0L/gYQKXEtBgD2M99TvclYblRatZXuHYPAlOxq0N1kIUIQUScGws+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2wHZXcbXUWOqG4P9FSJFkX5eCeA8w9+xFtkEQtaFgc=;
 b=mc1+v0e0FLz2dkSfrliEBuaYZ1YufRlGCfaWp+dXdsIenrHQbklLLJ9NgDQM8CAU4Mp0jxgQX74YlhusmkoUNf2HGtk3ji3vy0+/zV/Eu/wlFtQOtt/5hwrBudOuxgzRgT9IQ4j4auSJOvFubZvJedZFBznjMrlRo0QQvGKXhKM=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 21:03:45 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 21:03:45 +0000
Message-ID: <afb30180-e4a5-48d7-b0ad-7c7231f3533f@oracle.com>
Date: Fri, 3 Oct 2025 17:02:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] <INSERT SUBJECT HERE>
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        torvalds@linux-foundation.org, trond.myklebust@hammerspace.com
References: <20251003210107.683479-1-anna@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251003210107.683479-1-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:610:58::21) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf611d-a503-468f-9200-08de02c05719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlFXOE5zK2I2dkpOdSs5Q3ZZQU5LWWU1RElwak5TQ1gzNThUZmtzV3pJL1hG?=
 =?utf-8?B?eUM1dGM2OG9jcE4xcGJtMVk1SWkrVzhPaENDVFllZm9yN3ppb0o2SUg3UmlQ?=
 =?utf-8?B?aXFRWE83dkxZdlZPTUdHcDdYYUM3NVRwclRsaFpRQXo2c1pweXY4RnIxT1FI?=
 =?utf-8?B?Z0gxbEJidGVaWXZjOFV1V3czbDRoTjNaaDFzNklkTEt6QXNaS3ZYQ0NTY0hu?=
 =?utf-8?B?M3EvR3ZBcEUrNGtpZm1YVFhCRzh2bWFyL05ONERXMEV0OS8xcU9pWTRyalI1?=
 =?utf-8?B?MHJvVVF2Umt6WUE2SEp2OEFsNmdFTFMxcVpzZktvTHRhR2RMWEx1ZjM5U1lx?=
 =?utf-8?B?aGc1M2l5aTJFajJGK1hCV2t3WlpVQk9rWHQ1TEU5bmJ1TGdVUkJVTHpnemlJ?=
 =?utf-8?B?N2NKZTlaZjJIaWdtdUhYM0dZQWhIS05vZjJVMUhGN1VXZzZBYnIzaDhKbWhF?=
 =?utf-8?B?NGFQOVJJbERTaGw0d0xnRTNyeWFLemdXcVIwK1BSME1IRFRJTnBuQnVtR00z?=
 =?utf-8?B?UXBZeG9jdWpnMGx0eXQ2VkI4V3hVSmxLWUR0eThORGNSdUszUTdFUW9aYnB3?=
 =?utf-8?B?YlRXZUo0UlF4MFI3RmRJL3M4T1FLUUZ2NGdndkdsc3dETk9nb3JuYlM5M1pP?=
 =?utf-8?B?a2N3R3NoVDFLVHF2d0lsbzRJOGd4RHhjNlVIdW85djhCSWVZRE4xTTJvaGkw?=
 =?utf-8?B?SGM1d1AxNEg3ek8yY0NLSFJDTUhTZU9xNytOemxKWDdaNVQ2dEtxbG40SXdF?=
 =?utf-8?B?UDhyVHluZnIwZW45c3MySGhtSUpUQlIrNUZwY3NHWWdFVUx5Nlg2N2RvL1gr?=
 =?utf-8?B?bDNZYWJiTVVGelFxN2lmbXM0Z1hTenpOL2hKWjdRL0xnUWlPNTRxUU93SmdF?=
 =?utf-8?B?R2gxaERVcmFuTktHaGlNNjlsTFlxRDdtb2RVdm9oNVlhenBVc080akNDQTFE?=
 =?utf-8?B?M29Ka0xndFhpdE5XN2Jac3lmMHVTZ0xncUx0bEVFWGVEWEl4VHVBeTV6c3U5?=
 =?utf-8?B?bFVzK1Q4dkJPd05MV2hiTi9KYTlPRSt2NXZSQzFlbm85a2dRbG9qTHd6MlNn?=
 =?utf-8?B?Y0ZMV3h4WmNRZWpCWTc1Vk9TRUpzWCtuemMrMnUzZUwrMnlaZ2pSUzl1QmYx?=
 =?utf-8?B?TFN3YThEb1BqOFFhSmRLOGhySGlkMkpkUHdXTS9BS3pBc2R2UkNCNGtOLzFt?=
 =?utf-8?B?U2dvdysycGlOQTlWa1U1bW1pQWljOG1sN1B1eFdjTGhLb25neVEzdlBuKzBS?=
 =?utf-8?B?bEM1Rm14Vk1uQWRvN3h1Ny9lRnFDOHlnY3d2ZUlaemIwWFdxMHRJQkZRdXoy?=
 =?utf-8?B?ZmkwL1h0N3N1c3FoZE9DeFkyWHh6dmVGRFN0Y2ZUMTVlVFJTNCt5NnpiQi82?=
 =?utf-8?B?TlJNanM3blBUR2ZxcjZDd09wNDlSQUN5MVgydGp5ZUIzcnpZQVBsRndhbWYv?=
 =?utf-8?B?VVEzR0lRZFU5ZFVINFB6T1dBZ2R3OTJxWnRRVHdqMkFMT3RkN3lMbHhRaTdL?=
 =?utf-8?B?UGVLemt3bUtiK2lPUE1xWjJHeVAzTUVmMEpQWVAzYTdrL3B5MXYxbVQ2UkRz?=
 =?utf-8?B?RWlqa3hZVHVlb1pSMUNyNi9OTHB6YnlHb2JaRHJnOWJWYjlwK292dEhHU1lH?=
 =?utf-8?B?dnNTUVZkZGVGU01vUTJjbmVDSTU3TDMrOWQ1WlZMNGJGZ1c2VEdTcDUzK1hJ?=
 =?utf-8?B?YjVQeVg5KzhGblAxNUdoM0I0VER2YlNITnZXb0lNRU5IREFxRUtOSFVXWmdj?=
 =?utf-8?B?djRKRzJlV1FPU21hak1MMFpkRExxcTBITkYyZFN3Qm5VM3Q0bExoVHl6bC9j?=
 =?utf-8?B?QThpdU5GMWkybVZvOXcvMEdKc2ZJZHBVZDJZYW5ORjJUYmc2dUtUa1RlbnFh?=
 =?utf-8?B?Z29WclBMSU0ybTd5TnBUSkF4NHlDaE9nMnN5Q3Rrelh3VU5zWDIwbVByVWFn?=
 =?utf-8?Q?Dr6EgKJuKVqBth3C6VNS7m9gmcAe2+kE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBZak45eWJrakF4OUtWSFdvODlrOGIram9pOWc2Vnpydk55SXJKN3AzbkRL?=
 =?utf-8?B?TGpuVXFFR3hZZlc3SkQ2cGRmVmhhNDFUcE9tRC9sMjNVY2w2eW1uaHZZTGxV?=
 =?utf-8?B?Q2RDamd2YUMzQjhSaUV3aFpWWnBDUnY0ditwM3JUY2ZWTU9BNm94UWc1akxp?=
 =?utf-8?B?U0FaeiswbGFJWlU2MHBVdUhrUFo5OUg3NU0xeFg2R01JM0wxOHVOQ21HUXYv?=
 =?utf-8?B?bVhJT3drVlFrVDNlLzIzVVhNYXJOSnhjZnM2Ynp1UFBDWnRKUk40N0Fxbk9F?=
 =?utf-8?B?STVuZ0M2N0tBZFBONG8zT1ZTTDFKdXpRU25aTlVxU1d1VW9SbDUvOUh3RHpP?=
 =?utf-8?B?T1h2UFl1bGduSmNyWUErcVhvSVpiVzRDd25aNU9pY3RWa21ieDJxRWJ3eXFG?=
 =?utf-8?B?SkZtenF3NDVVSmFyNWxZbDBvcExFSTl3bi9HcDQralIwbDgrN3E3MWx2cjMw?=
 =?utf-8?B?L0U2NHV6SU50TVJ1bWVlNVRjWjFwcUtTV2Q5WXBSbFYzY3RJR1hQL2xINUZr?=
 =?utf-8?B?RURtOEdCb2oxYmN6dFYzVFFIR1RBMXh3eXhTTTltc3RQb3lpQVFFeHZqWnlV?=
 =?utf-8?B?YzZmamJtWnBweDNPaXo0a25SbTBabEhrZVZXQ2FxUUp4clFKVVRNSjIxaHVC?=
 =?utf-8?B?b2ZOUkQ3WlhmcHdzTzgvUE80UG8rOTB5RHNUYmFLWUNwTGRTK1lqcUdtMWJL?=
 =?utf-8?B?K2I0V2h3Y2FsYVRNWFJsSnFRcDgveFpjT2lEOGpmUllhZGVVVHpwQVc3WGNk?=
 =?utf-8?B?Y3BEOHgzVFZmZGhETWd6NXd4Q3pHb0FKNjUrdkhaU1hEWk40UnRCeGVyQmMx?=
 =?utf-8?B?RUcxemI1WkpsQk5MbWpEOXpXaVpPcGpLK2lsU3I0VE1kM3ZNQ0pUMGRTNGZT?=
 =?utf-8?B?RUlGVFBkTUwwZWdKU1ZhTVNncDdyaTRLT2Y4cVJYNlA0a0hhUG9taVo0TzJB?=
 =?utf-8?B?Zjk3a3JVWld1QStCNnNjUFJab3VtcG1naEpqbCtwZ1RMS2g5NUM4VkNtbGRw?=
 =?utf-8?B?akg4TmpmaVFxQ0p1R1hrTlJRd3gyZEtwKytKSUR2dGpNRi9DdjhaaG5FLzJy?=
 =?utf-8?B?VTlPNWdpcFlINXQ4Tkx6OGgwRlAvRkZ4NjJMeDM1a3FZZG1aSGtmaXRVaFhv?=
 =?utf-8?B?V2VRVWljb2Q1eVB4MmNuczJCUTMvT3RFMW1va0Q5RndwZVNMSW85Sk8xSlR4?=
 =?utf-8?B?UlJodmJwR1VMTjhIS0p0YTNjTHJTYngrSEVuYUcyYmUyeTVGRGNDVVRhTnpC?=
 =?utf-8?B?S0p0Qkl5Y0VtdnRpRWlSY3JwN256elFyaVI4MXlGaWI2NmYrTWNiMnR0Tlk4?=
 =?utf-8?B?Wm9QQXNTN09ueHBLYkRUWTlIY082VjZOUHFhZGdVaG5FZ2NxaGtnWGt5V1Js?=
 =?utf-8?B?SVZ6djYrTWZwY1VuTGltaFpLV1h4VzAxNDMzZVZhWERzSmlkTW1jT1Nrdks5?=
 =?utf-8?B?TnRZRG1FOXNuQkZqejlHNzFtYm4vaXRkUS9xbms5a0k5TnBYMjVXdTFFd3Ez?=
 =?utf-8?B?MTcvRUxOZmtBeU96b2xMSUtVUk9GQjUyTnBtRFNwcGdiWm1MQjFTaUxrS091?=
 =?utf-8?B?NDM1YkIrK1JmbEdEVDJDU2hTVytOa2lRZGxGN3ZmU3hHZjJmaFF0WUY2dk02?=
 =?utf-8?B?Wm9RNFZIV2dDcVFJTUsvTnl2WHBUcmxqSjRGRFlyQkJsdElMNTJ2bXV2Wk5k?=
 =?utf-8?B?Wkt6bXFtL0gwT2VBUGsyaEtsdTI1dWNPdkw3cStqMDc3Z0JWWU5ZVURhYzlW?=
 =?utf-8?B?cjM0NXpDSVRuR2V5dWxMWHFBKzlodm9uSFlTakMyclZibndzTmJiN2c1TGg1?=
 =?utf-8?B?cUo2ZW1wVk9hSGRjWXljVXA5cExrQ0lHNmlDcVdEMCtqL2hKNHpBRkpjeklX?=
 =?utf-8?B?MWM3N2hsdnlydndWY1RJUElhaXB5ZFRJT2ovUXM5NlZWaXFHRUZNZC9jYkZ4?=
 =?utf-8?B?bGVjRWRkdS9FTWJ6WnJLTGpkci8ramdvckk5MGZaMmJFZzNJS2F2V3V6NVQ3?=
 =?utf-8?B?OXNRejlRSThpMTNObS8wZmdiVklOdDlIdGNVVzBzR1dYY1UvZGFEOVM3a2RU?=
 =?utf-8?B?WDFsM1c2R1hzZDFJSU5PMUJPQ2hwNkFUSG12ZVhZSlNHaHNlc283L0pnMmFq?=
 =?utf-8?B?aWFPZU1zVHdOdTR0eDM2Vmw5RnRBSTBISUNCSGNMb0JMRW5vbVlRZGZRbWMw?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5yj5K8NjPuiqBcpDtV1fLiPLmXJVm9oLN98KQBNOiw8hNUqDqBms/ovAq8Ygc8xZDUb89FxC21kDzpgXk4N5+tc+Z+O+290qYB22rNDzODxgqAgWQqfA+YRuE4UPdhdQJEYWW6beRAyhvJeHMQwm0VK3Hry2yMcyZRgnTJIL1XUkSn3WiFKtK75AYIpz6tJVwjMx8VVJVwnkTujnbqgev26nQEDltKx/GIr+lfU+QukefEUBGG9U/pdCUva7q2/rqnhAT+Rqx6yxeueD7rxJ7g5oUdbKYf4l5Oi9fefrQ7SCFiNBxiXhylFhoWHHvyBUwg/Vf1Ov3x8py54rS1Scv2zd4nFntjB1r0ms9zZaNwON9rUGtryNK2ICZIDcHlQJ2v9X16AIyrTT7kuT3k3cv81UGm8RZFfu534QPlKFXBi/MuekGbMviE6ezhLwOjRoK+o/diKPPX186rz6rPiU88ZIh6amsUhYZysNF6jWcT1uUbKR7ehdO9hICehTJ5BD+fhBScF3x0RfuzLkn1vwu8/iN+i7aq//U5CV8iymv/0FRBCvKtb43s1+hTVCj7VwMl7JSHp7xqajxNnnkjv9+sd50ER5oRuOBlgbF/9WQHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf611d-a503-468f-9200-08de02c05719
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 21:03:45.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5gJKCYz6sRwDSczIkBpKVXIF4f6LBERYRyn1UXrB9OX1CcJ6zkiVyrqYXUWi2Ii581x6DwsclFRjXIO86A4pW4MKiCwhFR0fiSPlYjAtf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510030176
X-Authority-Analysis: v=2.4 cv=aZVsXBot c=1 sm=1 tr=0 ts=68e03a64 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=P6JkxrBpAAAA:8 a=3gY3yh4NIQ9PilevGCwA:9
 a=QEXdDO2ut3YA:10 a=dwOG0T2NmQ8MtARghG3a:22 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDE3MSBTYWx0ZWRfX4wfl0oSKTAzR
 LF0HPoPimkns7UOmsVi/sybsv/f5qg8WoGxqcGvmKGx0FcYJKEGVMzygRQKi05HP+bX3RA7xTlv
 mQhNq6peU0iV7i+qp/YivBBkxr9X/VDzz5ZYnjVBc0db2ZH8dPkNRbPaW1PHfh8DuCI3Dn6bvHD
 YWM28Adk8X7WqqvatAQ7VT5mEsW06t47eYXTzkpBbOf7DpvojJF6E/OT5QEb/dyHrAiEYE9QKCR
 88wCxzXW/h/eiAgOW9+Dm26XR5kgXet2pwWzjRLd1kS+LJbYbSqIuf4FNiCtG2guzWMYct+Qluf
 duxXrcBJqECri+h/4rC8vd+dVqEXufCX5H9V7q4wrLOBdtA9CdCU2G56hNT5dxqbHs6tmGwPUxI
 IYtKzEIP0CsUWVlCVX2bZRrzNfzgNP15L1NhFVIJOFcdY3ZmNA4=
X-Proofpoint-GUID: Kn0NP5C_kD3OgzTSC5jx09IRtMmKk-ln
X-Proofpoint-ORIG-GUID: Kn0NP5C_kD3OgzTSC5jx09IRtMmKk-ln

Looks like I went too quickly and forgot to fill out the subject line
my script generates. Please let me know if I should resend with a fixed
subject line: [GIT PULL] Please pull NFS Client Updates for Linux 6.18.

Anna

On 10/3/25 5:01 PM, Anna Schumaker wrote:
> Hi Linus,
> 
> The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:
> 
>   Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-1
> 
> for you to fetch changes up to 1f0d4ab0f5326ab6f940482b1941d2209d61285a:
> 
>   NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support (2025-09-30 16:10:30 -0400)
> 
> ----------------------------------------------------------------
> NFS Client Updates for Linux 6.18
> 
> New Features:
>  * Add a Kconfig option to redirect dfprintk() to the trace buffer
>  * Enable use of the RWF_DONTCACHE flag on the NFS client
>  * Add striped layout handling to pNFS flexfiles
>  * Add proper localio handling for READ and WRITE O_DIRECT
> 
> Bugfixes:
>  * Handle NFS4ERR_GRACE errors during delegation recall
>  * Fix NFSv4.1 backchannel max_resp_sz verification check
>  * Fix mount hang after CREATE_SESSION failure
>  * Fix d_parent->d_inode locking in nfs4_setup_readdir()
> 
> Other Cleanups and Improvements:
>  * Improvements to write handling tracepoints
>  * Fix a few trivial spelling mistakes
>  * Cleanups to the rpcbind cleanup call sites
>  * Convert the SUNRPC xdr_buf to use a scratch folio instead of scratch page
>  * Remove unused NFS_WBACK_BUSY() macro
>  * Remove __GFP_NOWARN flags
>  * Unexport rpc_malloc() and rpc_free()
> 
> 
> There is a conflict with the nfsd tree due to the localio changes. It should
> be resolved through this fix:
> 
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 3edccc38db42e..e70bc699e9a51 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -697,6 +697,10 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
>  		.dentry		= fhp->fh_dentry,
>  	};
>  	u32 request_mask = STATX_BASIC_STATS;
> +	struct inode *inode = d_inode(p.dentry);
> +
> +	if (S_ISREG(inode->i_mode))
> +		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
>  
>  	if (fhp->fh_maxsize == NFS4_FHSIZE)
>  		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
> 
> 
> Thanks,
> Anna
> 
> ----------------------------------------------------------------
> Al Viro (1):
>       nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing
> 
> Anna Schumaker (9):
>       SUNRPC: Introduce xdr_set_scratch_folio()
>       NFS: Update readdir to use a scratch folio
>       NFS: Update getacl to use xdr_set_scratch_folio()
>       NFS: Update listxattr to use xdr_set_scratch_folio()
>       NFS: Update the blocklayout to use xdr_set_scratch_folio()
>       NFS: Update the filelayout to use xdr_set_scratch_folio()
>       NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()
>       SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
>       SUNRPC: Update gssx_accept_sec_context() to use xdr_set_scratch_folio()
> 
> Anthony Iliopoulos (2):
>       NFSv4.1: fix backchannel max_resp_sz verification check
>       NFSv4.1: fix mount hang after CREATE_SESSION failure
> 
> Chuck Lever (2):
>       NFS: Remove rpcbind cleanup for NFSv4.0 callback
>       SUNRPC: Move the svc_rpcb_cleanup() call sites
> 
> Jeff Layton (8):
>       nfs: add tracepoints to nfs_file_read() and nfs_file_write()
>       nfs: new tracepoints around write handling
>       nfs: more in-depth tracing of writepage events
>       nfs: add tracepoints to nfs_writepages()
>       sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
>       sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer
>       nfs: remove NFS_WBACK_BUSY()
>       sunrpc: unexport rpc_malloc() and rpc_free()
> 
> Jonathan Curley (9):
>       NFSv4/flexfiles: Remove cred local variable dependency
>       NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
>       NFSv4/flexfiles: Add data structure support for striped layouts
>       NFSv4/flexfiles: Update low level helper functions to be DS stripe aware.
>       NFSv4/flexfiles: Read path updates for striped layouts
>       NFSv4/flexfiles: Commit path updates for striped layouts
>       NFSv4/flexfiles: Write path updates for striped layouts
>       NFSv4/flexfiles: Update layout stats & error paths for striped layouts
>       NFSv4/flexfiles: Add support for striped layouts
> 
> Leo Martins (1):
>       nfs: cleanup tracepoint declarations
> 
> Mike Snitzer (8):
>       NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>       nfs/localio: make trace_nfs_local_open_fh more useful
>       nfs/localio: avoid issuing misaligned IO using O_DIRECT
>       nfs/localio: refactor iocb and iov_iter_bvec initialization
>       nfs/localio: refactor iocb initialization
>       nfs/localio: add proper O_DIRECT support for READ and WRITE
>       nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
>       NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> 
> Olga Kornievskaia (1):
>       NFSv4: handle ERR_GRACE on delegation recalls
> 
> Qianfeng Rong (1):
>       SUNRPC: Remove redundant __GFP_NOWARN
> 
> Trond Myklebust (3):
>       filemap: Add a helper for filesystems implementing dropbehind
>       filemap: Add a version of folio_end_writeback that ignores dropbehind
>       NFS: Enable use of the RWF_DONTCACHE flag on the NFS client
> 
> Xichao Zhao (1):
>       NFSv4: fix "prefered"->"preferred"
> 
>  fs/lockd/svc.c                            |   6 +-
>  fs/nfs/blocklayout/blocklayout.c          |   8 +-
>  fs/nfs/blocklayout/dev.c                  |   8 +-
>  fs/nfs/callback.c                         |  10 +-
>  fs/nfs/dir.c                              |   8 +-
>  fs/nfs/file.c                             |  29 +-
>  fs/nfs/filelayout/filelayout.c            |  10 +-
>  fs/nfs/filelayout/filelayoutdev.c         |  10 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 808 ++++++++++++++++++++----------
>  fs/nfs/flexfilelayout/flexfilelayout.h    |  64 ++-
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 115 +++--
>  fs/nfs/inode.c                            |  15 +
>  fs/nfs/internal.h                         |  10 +
>  fs/nfs/localio.c                          | 405 +++++++++++----
>  fs/nfs/nfs2xdr.c                          |   2 +-
>  fs/nfs/nfs3xdr.c                          |   2 +-
>  fs/nfs/nfs42proc.c                        |   4 +-
>  fs/nfs/nfs42xdr.c                         |   2 +-
>  fs/nfs/nfs4file.c                         |   1 +
>  fs/nfs/nfs4proc.c                         |  12 +-
>  fs/nfs/nfs4state.c                        |   3 +
>  fs/nfs/nfs4xdr.c                          |   4 +-
>  fs/nfs/nfstrace.h                         | 215 +++++++-
>  fs/nfs/write.c                            |  34 +-
>  fs/nfsd/filecache.c                       |  34 ++
>  fs/nfsd/filecache.h                       |   4 +
>  fs/nfsd/localio.c                         |  11 +
>  fs/nfsd/nfsctl.c                          |   2 +-
>  fs/nfsd/nfssvc.c                          |   7 +-
>  fs/nfsd/trace.h                           |  27 +
>  fs/nfsd/vfs.h                             |   4 +
>  include/linux/nfs_page.h                  |   2 -
>  include/linux/nfs_xdr.h                   |   4 +-
>  include/linux/nfslocalio.h                |   2 +
>  include/linux/pagemap.h                   |   2 +
>  include/linux/sunrpc/debug.h              |  30 +-
>  include/linux/sunrpc/svc.h                |   4 +-
>  include/linux/sunrpc/svc_xprt.h           |   3 +-
>  include/linux/sunrpc/xdr.h                |   8 +-
>  include/trace/misc/fs.h                   |  22 +
>  mm/filemap.c                              |  34 +-
>  net/sunrpc/Kconfig                        |  14 +
>  net/sunrpc/auth_gss/gss_rpc_xdr.c         |   8 +-
>  net/sunrpc/sched.c                        |   2 -
>  net/sunrpc/socklib.c                      |   2 +-
>  net/sunrpc/svc.c                          |  11 +-
>  net/sunrpc/svc_xprt.c                     |   7 +-
>  net/sunrpc/xprtrdma/rpc_rdma.c            |   2 +-
>  48 files changed, 1472 insertions(+), 559 deletions(-)


