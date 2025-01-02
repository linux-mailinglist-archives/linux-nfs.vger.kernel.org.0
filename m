Return-Path: <linux-nfs+bounces-8878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39F9FFB4B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9D918834D0
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76D1B4134;
	Thu,  2 Jan 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vfx5lWFZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JF+yG4fK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83FC16C687
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833703; cv=fail; b=Jrewzt3HLOfhiXtuzLZzOtVngoWeBDhDq/kRc7JlFSTvY+v146qsw3latE9PQG/vnZz7m8AUYAdwpR4aHLLRB8TQWUCOlh/L8dHyvrRfkWTXL9LBEw7GaUTzvalSOT61MR3o/IGz+Vu1fLx0oCLQJtsXeOEBnf0YKMuZOCEM+gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833703; c=relaxed/simple;
	bh=z534tscwsDDAlrZIBwhVUCf+Zxsp6BGbEebyhzxFS/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ex9Hj7F6mVK2n1c9I58XIPxVbXeFQRPlvNRuT09Qr4xMqHp8RTdXqH283laft5YXC0Hb0eK/hLNaiOBI/7PtT/5UxekEbKE4FWIlqN+kLzwj+0Opj5xSvhnCBGmALepgOQlgMg4uEe7C/G2LA3yIV+T3khF4vd3vx8VZ0dNiIzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vfx5lWFZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JF+yG4fK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502FtrvK017078;
	Thu, 2 Jan 2025 16:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l6zyRcuq5N+4ogB+zfOaTT0GrMtGSsf5UJSLyzj+dU8=; b=
	Vfx5lWFZgKZOWaXK+vpXYROmvBjnf4/+HlXEYlryE+ey+svMeHuhPF2hI8Mha8CF
	XTOw4OLB9ApUqxBZlikhvXPeodbSl9mefWbgeRC04Zd12fFtClc0YSsZErjIeubN
	oG6IlOBLgl3HXsOYJ1ybTnEQsjJAlJz+Nnf0bRS6ClDqoKPmtJprAirqr93lv0Qb
	+q6lxFn6xFFVdoA6mGbFQhekAgRe+ihJrheazbQctXj1JypfM2Wmgj2R+W1IOu7+
	w7QofUv43v0uAEGLwFF7sPBFC/zLiWy4ARosbIsGlAT8dCUY9YP4N08sBwoVUOEj
	v/qCKbZVTikaEuvjBURy9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rbwmpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:01:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502EhRgG012529;
	Thu, 2 Jan 2025 16:01:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8r826-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:01:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaLFx5HZd0aYGwRY8X7yUNsHEDkMHirNGHENXiqnuGx2BlOCYg08rkQzt4ugXfgPAmwHe96OfE56Spj/MRkhUZ4ikv/mNg/Xk7OrCinRnM9zGJwMLf1AWwv1gALu60CXsPDm0SETCtSetjulyatNlEddOT27gAbRja7N+3wW1VEYkFvcJW1A1LMRWii/1lRYmnYlDSrLHm25P/VDAIeLW/EUgTW+qieIQJ2PNSn1m/wyN7Ud2EkEYZrjlqQ7+YazkmOhuGWge4xnAMsrx5db7uSdAZgOiN0eqmwKrJehS8paGDLYRJ1tHuiPcB+/5l+q7mcQUXRkpkSm5VhlTsTfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6zyRcuq5N+4ogB+zfOaTT0GrMtGSsf5UJSLyzj+dU8=;
 b=cZyuw2lhFekjWD6hQ4nXZdidJy3zrWSFpd1gR44GKRSZ/dft+rslmxdVFU/Ir7CGZcub1N9qJ32/aF2h4zdaf6tX+oGGQxuQjRILSs+eF6BB4vB/lPiP+5+XF+isY1qIIlmdbnYsf8T/ePgX49XFLpANZKfXYkUl3nqkiDUO2jHFTaaEUOtvvtgUgKLUtoQ/395zfPGpctR2eApwpIW7oP1xhN3GjT/qaAvYM11FtqtB56/zOo7dWPSUChYGmXXbgs104MeBdixIS3xuomtsftVe2QH6mS4bjQwq9tOhKzxd3vZ0EQPzO37cgzgbhTNhhX7I3VqkNLSmdkhBmfe3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6zyRcuq5N+4ogB+zfOaTT0GrMtGSsf5UJSLyzj+dU8=;
 b=JF+yG4fK6wPLpo39UdZWK4teE11tn+7YQwzUQJVtJFuEnRa9SJzfFwSKn7rU8RvuUylAVL/zZy94JQ8rchWtgjPxuKTeKhPGcKS9+hvdF8XoEQKk/rfMKgrjuY1Ql7A1o821UGVDc/ZZZPhJThMrHp3JDfuUt/Q5V2V6xiu76YI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7661.namprd10.prod.outlook.com (2603:10b6:806:386::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 16:01:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 16:01:16 +0000
Message-ID: <c65f85d0-c52a-45de-bc3f-d9bf827ce83c@oracle.com>
Date: Thu, 2 Jan 2025 11:01:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Write delegation stateid permission checks
To: Jeff Layton <jlayton@kernel.org>, Shaul Tamari <shaul.tamari@vastdata.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:610:77::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 328c2e48-8173-4703-d2e2-08dd2b46b0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE41NGp1NkZsUHBsbWdiK3hGS1d2bDYwaDA1ZlhGTkR4VURueTBYdkZuQXhX?=
 =?utf-8?B?S3g3UjNKSjRuMll5cFRzNDRCa3BMemIzZkREQVhQai9pc2xwUExOSC9jbGtJ?=
 =?utf-8?B?UXlOeVpxb240WUZ1cHFuTW00WW8yUjRRRXhSd0hjQkpiUnkvd3BZeDE4aVlT?=
 =?utf-8?B?bkRVS1ZWM2FsVFRJNVBQcHg5SzJ5RkJTZU5MNjdVbFYyUzJCN0xyczJGYy9G?=
 =?utf-8?B?akFoejlkZk9GWUR5cTIrKzdiWE9pQXBYMzV6TmZ5c1Y0TGU1dlVrWTN2MTRp?=
 =?utf-8?B?dnZFOVNJUlJEb0JqTHcrenRtcW1hakZqb0szV2VoU0V6U2d3WStBUVdBNXI3?=
 =?utf-8?B?RmR6NC80ZVVVemJvNVQ0KytiR081Q3hKbHNBT0svUUpidy9wSHE2TEpWeDZN?=
 =?utf-8?B?b0x4NGdxWG93OXljRThSZjBHT0dOVlZ2NVNVUHNBb3k5TVlwcWtnMjczUDA5?=
 =?utf-8?B?NEEzOThMallPZlEzbVJWUjRPanViQWMrS0hoa3JVV20xbStONlcyM3M4ZVlE?=
 =?utf-8?B?M003aVZERXdtbkU2TVFFdjJQNFRTdkJkSkt1V2VLT0lBaU1lRTFlU2sxdWZF?=
 =?utf-8?B?M3h0Mk9sT0JKVWRTVVJ3ZjNpMGFKWUEySWFBTzdmZnhIeWthaHVCT01xekRI?=
 =?utf-8?B?RWJBRGlmRmU2aTYvR2hqRnkzUDRsZ2ZDb1h2OGhGd3oxamJIeWplLy8vYUFM?=
 =?utf-8?B?aHYxYTFqU2o5c1ZSd3JaOW1seHJpaWtneXVuTThRQitmR3RxOGY0Z1d0ZzB5?=
 =?utf-8?B?Riszb1lVOWR2ZG41dk9Ic2lWM2hPOXZJNE1JbnJiRDU4Vys3akI0ck1CRlQx?=
 =?utf-8?B?REVZMFJ5V2U1d0Q3alNFelk4MlBCWjNCaWc3ZTBPcGZMQkFVMXIrdkxmRHJz?=
 =?utf-8?B?emR0UGRqVGRldXo1YXgzQ0FXMWNWZ29IRHJXUXFMM1NmNlljZ21kVHc4ZDh3?=
 =?utf-8?B?U0RFbVdWQTFIckR1R0ZtME1wM3QyL0lEVkR3NVF1QUpYazA5dGYvbTEvRnNT?=
 =?utf-8?B?LzFxL2FBcng2OGJXSFA3LzlrMGNaTnppeFRYVksxWm8xVnlYUFNSeFUwR0ZO?=
 =?utf-8?B?dkNFV0xLeFMzMXZ6cEhGdzFMOWxoU1I4YWZIQ0N3eGl0bUV0SmxkWVJ2ODZI?=
 =?utf-8?B?emJyVDVCMzFNekJEMFp5dDJkaEFSc0UzZVNGS0lzUVRsSGZzdGg2UnRJcWJk?=
 =?utf-8?B?RXNCczAzYTZYTFQvWGxPVUE4NHRxOVNxRDhDSWtrcjBjVXpCeVZENkxjamxT?=
 =?utf-8?B?Sm1jc1NiamswZ1M3UThRYlh3WGUrVVpBZDE4aElqVERyd2FpZDcrdUpRajg2?=
 =?utf-8?B?VjhkdGh2ZGszaFJ6U2JHcHZBZWhjcCtUWG12WjIza3lUUzJ6bnRZcWVmOE1l?=
 =?utf-8?B?Z0F6RGRxNVZOcnBJWElBUzhOS010Nko3Rks0aG9WbTMrNTdxQ0ZjL05SaE1x?=
 =?utf-8?B?WjVxSDV1aTB2bHBWZmJEU3djZ0FILy9NUnI3WnB4OXBua2JJN09XZmZqK3lN?=
 =?utf-8?B?dXZvOU1lTkJ1RzNMakFsS3hGaG9jRFhWMU91M2JFY0NmRHFRTlUyZnVHalZR?=
 =?utf-8?B?Z2J0VzhIRnNvTmt1STZadTdQMklPTmpBRkRVVGtvdnZnTHRpOUltSStDUlVF?=
 =?utf-8?B?Q05UQytRZCtnL2V5T242WTFDWmFtb2tQS3cwNmRGR2ZNNysvV0Ura2d2UVF2?=
 =?utf-8?B?QXFneGt1aFpoTEc4dG5vMWwyNjlpK2JBS2dHRGpLOHRmQlRPenUzTU1UN0Jl?=
 =?utf-8?B?Z004MnR5Nk1kNHNIZHNUb2lUUnF3S29jRGpzQWViZ0U2bW9IQXM5V2tzaXJY?=
 =?utf-8?B?RVIrbjJtcGdEcENpeVNpRDBLVFpQRVEzU1MyVm94aG9jamR5MTZXSXpNZXdZ?=
 =?utf-8?Q?Lo+i4nDGHK5gU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODZVcnZIWVRRT1MzSitSK0UzTVRucjFUWUI1Q25NWjBhWVB6bUJEUXRzSFBu?=
 =?utf-8?B?akhzcVdNSEVNTFBjdkk2Q3RGKzZxZERXc1ZRTmlSQkpGdFd1N3lsNHgyRld1?=
 =?utf-8?B?YWdTRGtQNjJ6dHNhbEp4ZkZQaEI0R0FpZUxtOGVOeU16OHFlQy9zNUtHR0Vh?=
 =?utf-8?B?dTl6bFIya01HbjlGRVZ1eEZvcm1veVkrQTBOVVFZb3cvNk1IZ0RsdTFkc3Bj?=
 =?utf-8?B?SkJ1aTF5Q2xPaHJzbnNRVEZmM2NuMXI1ci83bUp5QzF0LzAySmMwV09jbFhk?=
 =?utf-8?B?ZjExM2JwdFY1Z3owWG5iWmIvSzVibDBWLzFVeVJLdmpWUUQwZCt4N2J6L2E0?=
 =?utf-8?B?TlEwMnlWYnczNkhQSG0zZC9rUFBHS21rSTFqZmlCcXN5dWdLanZnQ1NIeUs2?=
 =?utf-8?B?U0xmWjhUYzVvWW1qNVB0cUZTTDVmN0N1NnFxbE9OQk9rOVpJcEc2cDFJd2Uv?=
 =?utf-8?B?bTJraUczYlVwbzJlT2hzb3Y4c3FTSmJYV2lnSTcwRE1hN0lJeVRWN1VRMmND?=
 =?utf-8?B?MUlyQldiQUQ5ZUxVRWJQOW5NVXR4Ui8vN1lrUTRuNEtkSE9sT2pBTXc3WWF3?=
 =?utf-8?B?OHpWZkd0ei9IOVptbnM0cE4xL2lSc2dtZ01xM292VjJ0b01Mc1RFdyt3UC9r?=
 =?utf-8?B?dUU4aTJCY3k0ZmRLd3ZBVGg4OEJNOGptSXRiUnpraDN2QUpoM0F2TzdzenUr?=
 =?utf-8?B?ZnZCZTVYS3Y3YWwrMVY2dXJZZXp2LzNZbHFoaTNtMTNySDVYdjgvMWFVU1M0?=
 =?utf-8?B?SXN3bFQzVkY2SHRUSXRwT3doc0J5a3dJU3ByQTJibVZWT3M5eldlRExKNUpK?=
 =?utf-8?B?ajVTaVFqYUZTdDJLQ1pwNTZ0VHJMMW1YaFV2TWRiVmNCRUJMKzdrN0hlRVFH?=
 =?utf-8?B?b21lTEVkMWpuSHRKWWdVeGtIN1ZTMnJSZUVBU2Y4UCszZVhnK3dWbkdNd3A1?=
 =?utf-8?B?ZTgwTTNqZ25lNndYMFdjczJQQWMzYTVCMGwvWjluMW9FalFBYTNvcm4rNzVT?=
 =?utf-8?B?UTVUcGpSTTdwZ1A4SHVXUmNoM1M5YjBvZWliZmYveUR4RG1ibGlrbTBYa1lL?=
 =?utf-8?B?L2ZHeXp0a0VzcWlFUUlkNWZQNXd3Y3NjNXY3L1dpNUpCb21telBoelQyK0NH?=
 =?utf-8?B?bFhKdE5OcUFNWmZrbTloL3psWGFYeTc5K1g4SGtQc29zNVh6cktmOU4wSGdr?=
 =?utf-8?B?QlNmc2x3SUV2ek03bnBjUVNmVCt5NnJJNE9tQm1wWjc0anRYUkpwN2p3VVVu?=
 =?utf-8?B?bSs5MmdCUmkva1JvVHVHNUk0Z3gweXdHTW0vbkVVUHZzZk84Uk9hVjVQY3NP?=
 =?utf-8?B?OVkzbkVHMWdDbE93c3hnNXVETmtDdUpzTVFBS2dNaFpwL1Q0NXh0NlhqUDZT?=
 =?utf-8?B?WkpmK2JJU0xEbiswNnpnd3lwZklVVXdacVpHQW95MWhCQkVzcGJ0QmZEUFVs?=
 =?utf-8?B?dXdZY25YV09UeVpaOGlmbi9tSU5pQ2toTWJ6VjlhWGhmdDQ3NFNsYUpYRVhC?=
 =?utf-8?B?LytBLzh2aHo4Z3dqeTZmVkZrRUJCV3FscHVsbG1WdEIyeVE5TUVwN3A4N1Fr?=
 =?utf-8?B?RGdHVUJ4ejJGdm5zMml4a2d5bFovRjltaXYrNVhLdnl0QzdYcWVFVFQyekRX?=
 =?utf-8?B?WENmNWxyUmd3L2Vob0ZhUEloZGNVNDlMZmFsVjB0Rm0xQzJMQ1ZNaUx3TkZI?=
 =?utf-8?B?dlR2bFB1Z3I5a0doSzJ0Y0dqb3hXQzVoY3lyRUFuc1kza1NoMGZNWGErRDVx?=
 =?utf-8?B?QXFiV09hL3d5MXBxSVZDa0pmRER6ay9UWE9xYU94UEpBaGhaRkt1TUdXc0xr?=
 =?utf-8?B?K2lWRytRbVNDZ2krMmgvVHFvdThvQS93WkpodVRUZEJTNlNBM05UTSsvTm1N?=
 =?utf-8?B?dVNxY2dEVXdJcWJlU3B6OFU1cHU4dUlLVGFIYXU0bVBnSVNmWmtUMU9CQWxo?=
 =?utf-8?B?MitrbTBaU0tPTUFYSkVGY2ZqTnU3WHBQRE9WNFhmQXpmTG56UGtqTlpPQTUy?=
 =?utf-8?B?V2s1Z3EwUzQwMm1OeTk5UWwwVFJGYThQQ1pOQ3FxbkltQzJqaHhvNlJwd3Uw?=
 =?utf-8?B?bXdOZnNoYnJkcnVyS1MyYzM4aldxa3BBeHE5YjNoZ1A1dThvVHhlY0YyNHpP?=
 =?utf-8?B?TWlSLzI4dDNmVmRyRWo0U2RMRjJyVGFRb2RlazVDemRRdDZsK0pEcy9QV3Er?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6v4944rs4KFwVg4pPWOa6S1Zwog38JMbt3mkzbBmIKb7n8PtwlEbm6cMmzd/BfcCQXHvXcA3PxGh//pJ0HZxKvU5CI75SrL1i1LzGerJwyzroBKzoAaaRvhVVUqThnf0hFeFqOJZoSqGzIXzAWT+ENMgLRueOC7FplsZ1IYAzBEcUlFKQmEqLdcctcVF37Wg//zoVsH4riGxjY2NGugdgEGG9LbhoDFF1u7fHwz8FCy+EdLeqF97vqFw8zTAYcBc438hnMVoDXyUR6U1cJ/XLPiroTFbdRzwSt9AhU2Ps95cvKEfbM//dn1ztENjZOZ6cxM8Bdq7B2kE/FKvd5G3k2kwvTugi390aqAj3Y7D8kqwdQ/0F+Y7H8ioyz+vhGzoYwYhmxrHb5KkSvFbE4disRKfS3pecsAT/r3mbdGFmMtTMDUNLJMP2R3MyXyAHmZ9tNuZn6ET0a/wogYq80nZ7spi/Oqsy8GgoTHidjTRgeOhxwtxX0qVHdN9FK3FJUyWRS1aS7f9eCLrmEW9vgZkZYv+K5ExmmMwx6XGmm0yZlZBBzMAhwjDFTYJJ3Tgxbw5XIa1+nakoEC0KtquiGbOB+VE0chCH8tJttEYr0ogIGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328c2e48-8173-4703-d2e2-08dd2b46b0a9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 16:01:16.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bcd8DfGvcXrYycqtuM8E8aa8i/FUc9DuvOwil2Mhgmf49nyL64zovD2NPWBsfIMp3c4vKVfhx6xzRfANzcdfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020140
X-Proofpoint-ORIG-GUID: L7ox6XmLbPFS5fRAknJDhnNVIwamd2G5
X-Proofpoint-GUID: L7ox6XmLbPFS5fRAknJDhnNVIwamd2G5

On 1/2/25 8:41 AM, Jeff Layton wrote:
> On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
>> Hi,
>>
>> I have a question regarding NFS4.1 write delegation stateid permission checks.
>>
>> Is there a difference in how a server should check permissions for a
>> write delegation stateid that was given when the file was opened with:
>> 1. OPEN4_SHARE_ACCESS_BOTH
>> 2. OPEN4_SHARE_ACCESS_WRITE
>>
> 
> (cc'ing Sagi since he was looking at this recently)
> 
> A write delegation really should have been called a read-write
> delegation, because the server has to allow the client to do reads as
> well, if you hold one.

Another way to put it is the write delegation is equivalent to a RW
open. It permits the client to handle opens on this file locally without
having to send another OPEN on the wire (as long as certain conditions
hold true).

So, therefore, the client is permitted to use that write delegation
state ID for READ operations.


> The Linux kernel nfs server doesn't currently give out delegations to
> OPEN4_SHARE_ACCESS_WRITE-only opens for this reason. You have to
> request BOTH in order to get one, because a permission check for write
> is not sufficient to allow you to read as well.
> 
> 
>> Should the server check permissions for read access as well when
>> OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
>> ?
>>
> 
> Possibly? When trying to grant a write delegation, the server should
> probably also do an opportunistic permission check for read as well,
> and only grant the delegation if that passes. If it fails, you could
> still allow the open and just not grant the delegation.
> 
> ISTR that Sagi may have tried this approach though and there was a
> problem with it?
> 
>> or there is an assumption that the client will query the server for
>> read access permissions ?
>>
> 
> The client should always do an ACCESS call to test permissions unless
> the user's access matches the ACE that gets sent along with the
> delegation.

NFSD currently doesn't return this ACE, so the ACCESS round trip is
still needed.

Basically the ACE tells the client what set of local open(2) calls
are allowed without having to return the write delegation.


-- 
Chuck Lever

