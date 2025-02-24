Return-Path: <linux-nfs+bounces-10317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5D6A42EB8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 22:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA0A7AAFFA
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50D51957FC;
	Mon, 24 Feb 2025 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XItJPE8m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ogtW/n/V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1667193404
	for <linux-nfs@vger.kernel.org>; Mon, 24 Feb 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431490; cv=fail; b=OK8+uEK9i9NsfANhAMFc1gwxGnqig6MGwcRewIIj4SXHApgQaFo+quMxHHaEul9uUcci/M3s70Y1GX+DXidNsr0hAvLhXcSsHKQmfmzMYNyMluTlZwC9TLh8KFag48vEKrhPLm0eMiZFDG2slEMX/fEO9zC68lMvq9jnof6Mlrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431490; c=relaxed/simple;
	bh=UP4y4yKcUh/1tkfL9qd1ggLJ8PicpeKK1e9dSKyvv08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nre4OICpP4G92ZTB2ownhjFvIMVfUJvBK3CvNQVmqd+GocFL96RBXH/coyJgHw7fELaklX4/b83Aa49dQ1xHDILt4D2a2os6Gr9hC8C/D3kfpLhx03qAqDemWvGLV4JSqepOqEZQYTVxBY2Q6Mx+qUk2DeglC2Vb+1q2ylg6L6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XItJPE8m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ogtW/n/V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKfcvP013239;
	Mon, 24 Feb 2025 21:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sD/w3UQiyV0PvzS+pftx1okTJM/zy6jhb+StmIkEuLg=; b=
	XItJPE8mA3dgRjWpuF/m5lb+r16McsHmm1RLmxE/+sFYZl+0Z1aNTl3tUtpyBAtw
	Bx0t0kkM8cu7iFOx0voIb0DFqiQzVUv1E2bPytAIwuhJq0XK84Xvo/wUnw4eKQQ1
	dPoI4fgRuVn6UpWLgRfTdsSQ8TRpg6aCC/pr3iPgQrx8gul5l510wzvBS9RfmlSk
	9hI1ipNrnvO/DWBOqRvwF/GBtPtem3Wi69ztsnEDB81EuGNbEn9yTN8gvLjH/mSF
	mAmMXegpCp3XXpdqCFSX5nZdgPA46GEGethKl7n09milmecarn799if6AvLfqR2A
	MUwEp6a49Bz1LPt/WaNffw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbkn14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:11:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJcP44010336;
	Mon, 24 Feb 2025 21:11:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5180tcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgP5NX8QOZRKaV7hpyi/uVqiN4ZQO+33sDqjfgT9a7JS/5H+ZYQzRV7VA1XejtWNMykoUcc5dIj0Q655qWYs+PuPbk1wZkczvsUvkeJ249euO6ImJdAdR8RNqT3MiUUCWiMxZJh0695D+9Fhfejw8j4So0JjvL7rgflaB2QsYxMralRKudjv3VXFsc36Vgjuaok4l+Z3R/ht+EYxQaHDE92UFzV3wHfLDbrokd15DY3IBElL4ZMv8GGBVw52pCiSnFwCHmzv224JzpCag7Vwjj+HUMebr9nKscJfQiusBld/aDh5g38vs+u4POPO/7r2JFG4h+6PI95uiKjr1G2WSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD/w3UQiyV0PvzS+pftx1okTJM/zy6jhb+StmIkEuLg=;
 b=I3mEcM3QApWnfAN6ZmQ0ZMuBZmbfAcSoD5/sA1hZC3e3ua41t5eT0GPah+ViJbRWsN1HyakycCvcPu/vkZtnbNegU0utmw5g9tIJZ/p6RCeeAngG0mgDkxSrJmYrBwcX9HMO/V/iSVc3nToOyy4tcq4aPGi2t17ueFiGAMMKvWJluN5VP73P6hdwNgwppLsKXPVrpSkhD0zU7X6aFtxuTC+dc0reUiWgkPUO0gCbjLuH/br0gyOigo+huiUB5gCor1VSpk+4BoVS833mqdaQIhnaMqxOKniH5h0Ni7dN1oPd5tWyYwKSqeeAyZVHY37pejkYyEIE2NVhEedP/67eCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD/w3UQiyV0PvzS+pftx1okTJM/zy6jhb+StmIkEuLg=;
 b=ogtW/n/VgEFq+pAvY3z6MzFN/IUM15hDIRnyI8HTxpepdTspcostxNNFOG4vK4nLpjA6rLlOOsELme3+bct0GbVx+Oy5/BoGrybnS+gssv3q7lfG3HAvSnfwnO3tZGFbZ9eeWdfVjSrA7ez4f8g7Leh8qCT7uNjgg1KORqP9VhI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SN7PR10MB7101.namprd10.prod.outlook.com (2603:10b6:806:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:11:09 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 21:11:09 +0000
Message-ID: <34b7aa6a-e315-4fad-8fdf-1799feecb530@oracle.com>
Date: Mon, 24 Feb 2025 13:11:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
 <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
 <4d607c89-8500-4d4a-ae42-09987b16e2d0@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <4d607c89-8500-4d4a-ae42-09987b16e2d0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:408:ff::31) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SN7PR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: e0825700-0001-48dc-cf59-08dd5517c2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWtFVm9iL3Nyc3pwK0hrSFhET0MwNjlXUllEaFpaVENTQitlQUVjUVNNbGpu?=
 =?utf-8?B?aU1LMlFiSUgwdDhxMWtWSlpMTjVCM1lzTDllTlZoazZJNG9zZmtvNEJlaEdK?=
 =?utf-8?B?NzNnYnNPK3l1c1Q5M2ZuNHFxeFFzZElpei9WbUMwMU5CMFpUZDJxZklyM2s2?=
 =?utf-8?B?STVlSDdQWmlZNXpSdi9ZcVBEVkFFRGQyREQvNnNHejc3eXFMakZXdDRBeUZS?=
 =?utf-8?B?dXZOeTBYNTBUcC9CN3JQQ3NnRk1iSm91OWNkMndBMnlWTEM4UWlzeHdEL2lW?=
 =?utf-8?B?TlY1cExuZHhBeUlIVGg1R3lkb3Awano2YXIwZGs4MXJoOHh2RFNmVGNFK0ta?=
 =?utf-8?B?alhkRWhqcDk3YUVhckVBdmlrUjNVYUJIOUtPUFFCRnZrYncyQmxxa0ZDbTVh?=
 =?utf-8?B?SGtpSGRnR2FHZmlOcEpCMkovZU5Nd0lWZy9jbWxySHpER3NaMjFDVUxEbEhM?=
 =?utf-8?B?aC82U3h5bC9nUWJVZ1BtZWRRWlZ1em1lcEx0TmI4YTFoU1B3SkFVeFNMTVAz?=
 =?utf-8?B?RDdRbmp1S2dEL2xZNTVoSlBwcHVIWDFTc3RFMXJLVk5hcis5WG1LVG5zVDlU?=
 =?utf-8?B?NjVnQm95S3RoMThGM2RFOC9iU0Y1U2FFdFhHSzA5WWhaTFVST3Vsa2RHc2xp?=
 =?utf-8?B?dU5vRG1KNzh0Sk1pbDhqejk3anl5N1VDRW1oYUh0NllKZ3owcmtReE5WenJ5?=
 =?utf-8?B?MHkrRjY1WTZuVlRmbXY0WHREQTRSaGV3VW82aTgvcUYraDRSemFqdHZRTS93?=
 =?utf-8?B?dS91M1pNVUxxSXFCQlMrZUlRU1A3SGhBQ2tIalllV3NxU1FjMEZDSmxEcHly?=
 =?utf-8?B?VTRiVmNnV0xjNWhMelVLMXQwcVQ5S1ZHbnUvMHhJWHQ1YlF0NW9hbVpXOW42?=
 =?utf-8?B?Y3k0djM4cHNTaExaczluelhaWGgwcHI2YVhxSklEWExNbGxZbHB5Vk5pYzJQ?=
 =?utf-8?B?dGRWUUxpeFBYSEt6ZTQwd3hkM1R6dGJ0T3MvcmdOenlmcVBrS3UxeHpuMGRu?=
 =?utf-8?B?VXpyNU9kc0E4ZVVuN3BGYmM4b2FGWUdSZW1CdERNN0lhbzNqOWIrMTFNSjg4?=
 =?utf-8?B?bnBuU1pMdDRsV29tNUNlS2VGZDRTVjk0RHRmR0NaZHNJWGpEcDNkV01kZnBK?=
 =?utf-8?B?NWpPazJKOE53aC95Yjh0MmkzRDJFcC9McVA3NmhZNUl1ay9pZmRpOFdheldH?=
 =?utf-8?B?dDBiOFR4S3JxSUNPSy9DZ2ZrNFV5NCtYNXlYbkpvWi9WK04yTTlNRXc2M3hv?=
 =?utf-8?B?Z3dTVDBWbHVod2N2YS94L256ajNpbFF1NDJGVTVXR1pjYVp6RHpGNTRzcFJN?=
 =?utf-8?B?b0k1YkoxZU0yeDdCQTFpMkVSM3Q1NUZtRkprVUxlekl1ZWdSTlhaZUdEYTFp?=
 =?utf-8?B?MmcwR0x4NTlRZ1J2cmxobS8zeFhnVG0vQm5VUjA5MFovMXR0RXZTcFJhTFNN?=
 =?utf-8?B?a2ZndktIam44NjdVS3ZUZ1BBZTBnSENhVFNPK0NPaGdUSU5UMFlkWkVyUk1h?=
 =?utf-8?B?QlRoVXFIWmJVb3V5OEVTS1NabURVY1FzMXNWM2tuc0Q2cktDQy9pcnhxZlRN?=
 =?utf-8?B?RTVlZFlseEx6cC9WbHBNeS92MTlOeTIrZkpwRXkrd2M1Nm5XK20wLzh2OXlt?=
 =?utf-8?B?RTUvMHpwZ01wOHVGTWJCaWtKTG9pUi8yR0hXZWJKcHNRNXFNaEhPV2Z2NHdz?=
 =?utf-8?B?RG1nMFM5dkdCWEx6UGI1UWkxajhad1RSeGdHVG1qTnV5VURJTXIyaENXdG9O?=
 =?utf-8?B?QnhRa0VmcHBCTHkvSXE5YUdWd09uZmgvUmNNU0hSOXozV0Y1NUNBTHpCV1V4?=
 =?utf-8?B?ekswQ3FZZnIrSDRZTm9ZYUJNd0c3bVQ3NG9uSmNkaEtBT3JqTlIxV3E5Wkkz?=
 =?utf-8?Q?yRNaRLAiN5EJR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdNRjFjWHNtcXhncFBQbnA4YktjZ29kMGYrSUdaQ2NldlcvZyt6WVMxU1dF?=
 =?utf-8?B?aklKWTZsU3NiSDlZa1F0V1FITWpnK3FKMTVaREhZZ3ZTY3dMQVo0bVk0R3Rn?=
 =?utf-8?B?bzlWTzVIZWxqL0V3Ylk5cjJ2eittMURzQzBNZnF5eVRkVEk2WWY1ZnJvR0lo?=
 =?utf-8?B?QzkyTlQrZnBqZTNWRWdBeWViWit1Sy9VTGMra2FhV0FiNVk2TWVBa05Balc1?=
 =?utf-8?B?Wkl1bFNRc3RqcFVNdWpodUZZRVRCdFZkTXJSQ0U5clhBb3A5SU1UWkp1UEdi?=
 =?utf-8?B?QXdyakhiZVMyRmptV24vbXZYZ045TUxDcHNwMkw2Ykw4TzNQNWluMFdpM0lD?=
 =?utf-8?B?d293ZUNtMUdTOUp4UkZ0azdVV2llY3owQVpJUjB1VDdrdzNPOVFaYUxKaGVJ?=
 =?utf-8?B?OU9ERU1hazdVblVhQUNyZ2U0MWxCaTIwVXJUV0Z6S2IzbmhXVUFrRTVkdVFI?=
 =?utf-8?B?bEpCVGdjSno1QUc5aXBtcjk1M3VEZkxQcDIrZndQS1IwczZiK3MwT2kycWk5?=
 =?utf-8?B?T2s3VmNZb3hpdERsaGNuUVJUMnIwQ0ZPelhWczRLbm9SWXdPaTRGRlRCNHdh?=
 =?utf-8?B?QW91TVJ6OVhncjR2a25mN3pSRWNFT2dhajVkb3JGTmhQM3pqOE9FeGZuaU52?=
 =?utf-8?B?anlRNFNINFNkcVZhbDBQNmxOaU4xNTlPeTJhYWxFcU5UbkpRNFdQVTAvWlpz?=
 =?utf-8?B?Q0hkUEpGdXVyTjd4cE5sdUprK2ZNdG9sako4elgxa3grZ05LRE9waWRlQ0tz?=
 =?utf-8?B?WGpXWUJ1aW1pUVpxYnZqdTBOaWtJZWU2Y2lPalBuUHNLdThHYW1BV0ZzSEpi?=
 =?utf-8?B?R0Y4OUhXVEUrUFBpTTZ0Mi9JRCtLMllTOXk4WGVJK2UxUXpDOCtxVFNPa1Fr?=
 =?utf-8?B?ZG1PU245SUF0a2NDMDJuazhuQmM5dlF0cjByVjFveWk0UDRrbXI5RWJTbnRx?=
 =?utf-8?B?cm5jTy9BNGlPdEp1clB5ZE9JYmtsTTA5RHhQU29YaTFkbzFSZFprREM5OVNx?=
 =?utf-8?B?a2Npak1jaUQrQVhyR1c0ajRxZ3hneENXSzRxV2YzaXNWVlpIR0JtZnc0Y0di?=
 =?utf-8?B?TUxsTG9BU0E3TmJwUklReXViWm95ZUtzSzBiZnJvV3dRRTZuVEpZVS9RblUv?=
 =?utf-8?B?YWtzdEt5Yy9WaDMxVmFnaWx3VEtBTjNrTGcvRFUxRTF6Y1hGUThuSVNGTFYv?=
 =?utf-8?B?bUl1ZG1FUmFwQjhMVlEyZGdpUmV5elVseHh5a3BXK205UENaUGphL2dsRHMv?=
 =?utf-8?B?dm5QRW52TzUxWlY1d0dBZ2UyME5KNlVvYWc2Q0drZ2wxaWlibExreEk1ZGRp?=
 =?utf-8?B?UmdGWUs3T2wrWVpJaGQxOUF4ZDlobmp4SUhUL25rZ1B6ZmczNGU0ekNJd0Vu?=
 =?utf-8?B?ZW9OWWxtWllpL2FONGZQSU5SRDRwZVJHNkl0L01EZ21DS1djMTgrQldDcmRm?=
 =?utf-8?B?WnBkeUM4YVlQK2RPTFFkOG5rMk5sNHYvd2ZpNGkxZXdzRDFTZUt6TWZ3KzQy?=
 =?utf-8?B?dzkvTXhwTFJIcFlXKzkzaHFuS25hNkpNd3NieGNaVnFvYVI5VmVsUllCUzhy?=
 =?utf-8?B?cjhlVDdZTlpFTUlSSEt5YitueTlLeVZZMGpMTGRjUzgrbzlCdHV2R1NyWC9X?=
 =?utf-8?B?VUI2VjhTSGNvazZxcjVrVGNrNUdrTllMUWhkUExNTERNS0hzdDFGUnAxaStT?=
 =?utf-8?B?SGRiNGxiRDFTdDdGc215VmFmVkhnNGhRY2RJeVpad3JhbXdzVjkydFRtRFhk?=
 =?utf-8?B?ZTErOTFJUktTclZweGpKNWkzNlZSRjM4dTVtTEpSZzFidzIwZUo1VWhOVVhm?=
 =?utf-8?B?U0dYRTdFS1F6ODU1UytNejdWN0dDK2hEalBmUXU4SFRkcDBhL3ovRVRpMXdJ?=
 =?utf-8?B?UlFxNEh0MzF4Z1pnNzNzc0VOSVhvZE5CcWNwQlV3eDhRMlVFNUh5c2kzWTM5?=
 =?utf-8?B?QVI4QlBVQnZwZUFCVHNMVDVEOTNYTm00VXA5Wk05Z3dzaW9tMGRxcHBtSDU4?=
 =?utf-8?B?L2x5bktwa2JVRXRCNFUrcWJJYzZRWEluVVExd0lmblVDZm5rK1IyQ2NUMHdj?=
 =?utf-8?B?cnVDTS9hZ0VsTTBqNlhVbkVzV3ZxOXB6UnNyZVg2VW5yZ1JuSVcxd3dLTjE0?=
 =?utf-8?Q?gGEOpxMxCpoCzSrrd0f28WNnX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oHGmh0qBQKuIhbprtMY700zCHYCnKQ7/jAt3rPMZPpowIrIM4+dd5R2S+G971dsxXjcTz3LkjIcJJn/Z62TElh11JR/abHcuNaxxdzAR0nEt8SjrLzmKdVGFPrAM7MTifJf+8rK4FQkn4HOPOha0lc81z0scQRU0tjBTT83kC6EgNoLugwQiz9W10NDacbrhg9JR1xlt+02ubV+vfbSM5tpVoqlrjYv8bYCYBOmmgn7elSiGwRQpOXome58ay2EjlCGiv3GfJ39DMQxo8sTA6EfxR0jjahwp2rGb4oSfu7UAc6949nbJos4hTDKA0pk1/hgOtPbuBYSNXI4ktAJ7BOePfdFIrd6AnkBa2zfsTdbWpGfyj0ZhlIkONAQXayaSRn4vOQ7XQFE8U1Tw7myxCLxfyuK6Fkx1sdrroz7pXyEniMRnwCU/3iTC2f17vfejLM8MTYxmBWH0rY5VYZ6SfIaiXyv6CuR2I5D901XMlK332N8lqOTyTom8ImBb22LGCaPPjiEdyVLaGMWBuKPOWUAABCdwj2+RB3Jtbbzq0DuRBG6Nh1FyBcc6D1KrWSwsR5N/E+GSL5Eau8tt4uTr0q3llVaFwivvL9PeULKS0yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0825700-0001-48dc-cf59-08dd5517c2b8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:11:09.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wUE0y47Dmja6cH83AevfOzs5ZxXrlS8H8G1/oSHBmDHsMqtuk9P0B+5rgQF4hsQvtdD1r/0GOogNhpGLuEVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240135
X-Proofpoint-ORIG-GUID: 6QLcAgwOen2p5BajyFAT843E11e77PX9
X-Proofpoint-GUID: 6QLcAgwOen2p5BajyFAT843E11e77PX9


On 2/24/25 6:48 AM, Chuck Lever wrote:
> On 2/21/25 6:42 PM, Dai Ngo wrote:
>> Allow READ using write delegation stateid granted on OPENs with
>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>> implementation may unavoidably do (e.g., due to buffer cache
>> constraints).
>>
>> When the server offers a write delegation for an OPEN with
>> OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
>> and nfs4_ol_stateid are upgraded as if the OPEN was sent with
>> OPEN4_SHARE_ACCESS_BOTH.
>>
>> When this delegation is returned or revoked, the corresponding open
>> stateid is looked up and if it's found then the file access mode,
>> the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
>> access.
> I probably don't understand something. The patch description seems to
> suggest that a WR_ONLY OPEN state ID is also granted read in this case?

Currently nfsd allows a WR_ONLY OPEN state ID to do READ. The access check
is done in access_permit_read:

static inline int
access_permit_read(struct nfs4_ol_stateid *stp)
{
         return test_access(NFS4_SHARE_ACCESS_READ, stp) ||
                 test_access(NFS4_SHARE_ACCESS_BOTH, stp) ||
                 test_access(NFS4_SHARE_ACCESS_WRITE, stp);       <<====
}

Is this behavior intentional or is it a bug?

-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/state.h     |  2 ++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b533225e57cf..0c14f902c54c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   	return rc == 0;
>>   }
>>   
>> +/*
>> + * Upgrade file access mode to include FMODE_READ. This is called only when
>> + * a write delegation is granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE.
>> + */
>> +static void
>> +nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp = stp->st_stid.sc_file;
>> +	struct nfsd_file *nflp;
>> +	struct file *file;
>> +
>> +	spin_lock(&fp->fi_lock);
>> +	nflp = fp->fi_fds[O_WRONLY];
>> +	file = nflp->nf_file;
>> +	file->f_mode |= FMODE_READ;
>> +	swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
>> +	clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
>> +	set_access(NFS4_SHARE_ACCESS_BOTH, stp);
>> +	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);	/* incr fi_access[O_RDONLY] */
>> +	spin_unlock(&fp->fi_lock);
>> +}
>> +
>> +/*
>> + * Downgrade file access mode to remove FMODE_READ. This is called when
>> + * a write delegation, granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE,
>> + * is returned.
>> + */
>> +static void
>> +nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp = stp->st_stid.sc_file;
>> +	struct nfsd_file *nflp;
>> +	struct file *file;
>> +
>> +	spin_lock(&fp->fi_lock);
>> +	nflp = fp->fi_fds[O_RDWR];
>> +	file = nflp->nf_file;
>> +	file->f_mode &= ~FMODE_READ;
>> +	swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
>> +	clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
>> +	set_access(NFS4_SHARE_ACCESS_WRITE, stp);
>> +	spin_unlock(&fp->fi_lock);
>> +	nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);	/* decr. fi_access[O_RDONLY] */
>> +}
>> +
>>   /*
>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>    * clients in order to avoid conflicts between write delegations and
>> @@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>   		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>>   		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>> +
>> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_WRITE) {
>> +			dp->dl_stateid = stp->st_stid.sc_stateid;
>> +			nfs4_upgrade_rdwr_file_access(stp);
>> +		}
>>   	} else {
>>   		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
>>   						    OPEN_DELEGATE_READ;
>> @@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_stid *s;
>>   	__be32 status;
>>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_stid *stid;
>>   
>>   	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>>   		return status;
>> @@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   
>>   	trace_nfsd_deleg_return(stateid);
>>   	destroy_delegation(dp);
>> +
>> +	if (dp->dl_stateid.si_generation && dp->dl_stateid.si_opaque.so_id) {
>> +		if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
>> +				SC_TYPE_OPEN, 0, &stid, nn)) {
>> +			stp = openlockstateid(stid);
>> +			nfs4_downgrade_wronly_file_access(stp);
>> +			nfs4_put_stid(stid);
>> +		}
>> +	}
>> +
>>   	smp_mb__after_atomic();
>>   	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
>>   put_stateid:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 74d2d7b42676..3f2f1b92db66 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -207,6 +207,8 @@ struct nfs4_delegation {
>>   
>>   	/* for CB_GETATTR */
>>   	struct nfs4_cb_fattr    dl_cb_fattr;
>> +
>> +	stateid_t		dl_stateid;  /* open stateid */
>>   };
>>   
>>   static inline bool deleg_is_read(u32 dl_type)
>

