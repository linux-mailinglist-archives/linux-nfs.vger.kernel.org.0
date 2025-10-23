Return-Path: <linux-nfs+bounces-15570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F8C0181C
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D3D188D5FE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24E328B6A;
	Thu, 23 Oct 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gF6HiA3P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rrT9nRb2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897803321A3
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226578; cv=fail; b=mi4CV6YfkKFVMM/Yj5uJktxyxyN5KqQQNwjvwhttCcAMM4biGB75U1UUoFjiS9vrYhlZCqPSPctWBlf1UKf6x8ibNLj4tE4hOYTlAwPAhPK41oHZ/xRtoVyJ4HlUw+5FZthqjpcEEBdI5URjyno5F4eTSjOs3D83/hVJ3gx1eK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226578; c=relaxed/simple;
	bh=UsEYPV2MExoegtVttcRkvBQyLr+d5BiCaghU0BCmlac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHYIGIRqwEkdK3tlYISl9l2Da07sECiO/+tmKs0kSoCTl/v5tW6dQuBQTYTQ0tRk3xC3lI/EM2ksiQoZYchMY0a4/oDH1TvhsFDO95hhebVQwFW3Ny7rfQum3SNXE0XTZC2ZNzNwV2PGfvVuD25oN5pBYQnir3Vjsv7sTHAWe84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gF6HiA3P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rrT9nRb2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBELgU002429;
	Thu, 23 Oct 2025 13:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8ZDdQoq8rhV3dhS+ULE9v7a1vfsYoXCfrPx7ccdzPGo=; b=
	gF6HiA3PPAhlQk3gD0b4t6URp0fEfb0z+E5Xv5yaCETbtFb5HQtDsqE5JW1FI2EO
	tFP8d2eIr9Fz7Bvkx3d6cI0/HcGYLvH5AQnImauYb3tz+52AYKc9nUxBLiZmrsHn
	uj2RzsTZrJD4Qj7FNVNfPbvu54CFwKwO74QAt/t+YmpCIONj8zlxSLaK3xjfBQns
	R6PUFgy98KTcNxZO/MSedVykiYUID/ZK1oqtbW2vVnWCjgAyDFaQyIGo3BfUOPPT
	PsRkUCHcH/sdwOYTC/bydMQXmI3VEl9FJxbacvHCPQe/44Qpz15SJL5fOTr01UjH
	0Mrv3n3uSz1bsLG7eCdrKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah07vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:36:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NCH6pK022350;
	Thu, 23 Oct 2025 13:36:03 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfm6cq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeuKJMTZIMusI0toob53yLnwOBjbA0S4S90rnDzEZt7dLRlQjakugyjxAZ42hLuyj2X0Pi1J8sOmMc0T6vu6pXS4/FkIXTQXAc/z/L1/AZMKIqCwbgSeDggelDtPjKPmZBPKz/7mogvlH3x5g485ogE+g7yOgrMEE12o12TOg5HD8VAt/rRZmqVDaUcNO2GrXXMMAiFvfD1Jc4BhRvJ5mUFlUVhVeSK8WFUmm5RSWlwIsRFWSpvbXh+NnLGGYrcZXAkRHFl5DcHsy+oqWJ5klskVzfrtxC1crxL48lbs/OS768XMlDPO2fWKuIDvJvfBCS18yVhDb3rAej8LsoDa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZDdQoq8rhV3dhS+ULE9v7a1vfsYoXCfrPx7ccdzPGo=;
 b=UWH8LCcTzI3YrCkMDJXkGQdLdv6qQRBz5VkSkc2jQP0GeZVy3zmhtuDT7VW3H4GKP5p1JZ0iDqOlaQRZcQ4re21411HYNyV8bcfFxZQI036wCFmi8TOfIjU+5sVfNuGdbVi+lHGrt9n12QW4UHhWnyrrTOMyxchfOJCwNwtLWHTcvGdgtXtFWW3UUts5NjNfN5gZYzlOKSkKzcPcpEHVaJg5sk8gYfWYyGEvYY/I5QsvhBEsTbYNzIm2rPPS9IlVAqYPp+vO3/q1oafBsg7IdQdWwCLWKWMWewFLvlO3Zv2q1wBHQO+lTQ8BVcVSKJpiLGGDRsjm1KOk9uTMj2+9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZDdQoq8rhV3dhS+ULE9v7a1vfsYoXCfrPx7ccdzPGo=;
 b=rrT9nRb20JGJk2QQYnzXEyyRBUaCgOwYw/twAZHFuMnES6ULOQ2ULhEddkkbXzuG+F6Gb4wPJ0ROKQQwGnAKxVcFPRyjPMGLJuiiYPHhZXBkfWERhdnWnTdFMM4mv8++AMji8ibS56lM30+JYXSKJus5vMmug62nGZF5woR2Z6o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 13:36:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Thu, 23 Oct 2025
 13:36:00 +0000
Message-ID: <fe0c00c8-88aa-445d-a13d-9d41e69e8362@oracle.com>
Date: Thu, 23 Oct 2025 09:35:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] nfsd: revise names of special stateid, and
 predicate functions.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251022223713.1217694-1-neilb@ownmail.net>
 <20251022223713.1217694-2-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251022223713.1217694-2-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:610:60::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db05b9e-d02e-4409-ce1f-08de12391a99
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?alFFSXdseWxtZmF6VHRUSE9yM2dSMlFxSU5mMTNGdk1DVTlqN0RrZnQ0b3JD?=
 =?utf-8?B?RjJGa3k5VDJkL1l3dVJSa0lFYXNhMzkydnBmNU1QU0xYcXYxdCszbVdodzN0?=
 =?utf-8?B?TFBRSkVxR0RGdGR2TC8vRXk0Ti92OFBiNXBoZXN1bG56czdjampBbGFJbTFv?=
 =?utf-8?B?aTVUTVNKbzFGbE41OGRmTmVXV2RkQVQzQWhNWE90R2VZMUNNbXV5bG90Sld4?=
 =?utf-8?B?cGpRTWtHdjN4bk5XakNMZzV5UVZsbURVS1ZCVUpvRnNCUmFHb0RlN2IxOXZq?=
 =?utf-8?B?dW83WjRVd3N5MitxcjRsZ21wd3VJeDdXZjgvV2Nia21YdDdSVDNSd3NNM3hu?=
 =?utf-8?B?Mzl0cVF3eGxhS3hkR2dxRkJ2aSt1TS9jdlROdHorU0NXZVZQTm9NTVRLdTBm?=
 =?utf-8?B?bzdweUgwUzRlalZOcitjajFQV1RPWEZYaTZic1lpTlNuYjFLaFZENjdVTWpz?=
 =?utf-8?B?Z2FsNDBld2p3bTRDbWxkUUZWMkVpTXJlNmhFdm9GRWd5dVBxTjRiNkVXdTNu?=
 =?utf-8?B?dzVUS0R4Y1BIeXRGaDVoaXMvMmZZVlZmOUFiQ1VaS21hTzcyZWNoOEJmWGdp?=
 =?utf-8?B?blhvY0NYcHJjRnl2aDRvbkVOT0doeGtzV00rMFRpVTdnS1M1WHM0Um1nZ1RR?=
 =?utf-8?B?Wm1ja1lxaWRnNHdEN3d1MUt4cVMzaldpencwUmhZeWVJTGNFajNZYzAzTU9G?=
 =?utf-8?B?YkFUaUoxZ0FlMlVhZFBzaytla0hYRy8zUXNTcHFlUFM5cklZT0g0QTY2bFAw?=
 =?utf-8?B?bVN5QnR1L1ZobDhrYUlSNnBWVm8zN3VreXlQNWFsUFk3RmoxWkVYa1pJREdw?=
 =?utf-8?B?Y3NxL1NiRnNhTTZkdEZuL2tFS0lhaENnb0t2SExPOE9raTQ5eGljamUycG4r?=
 =?utf-8?B?TkZ6cHZZR0JRblVoUmY5RFJBVmtwcjdHWHpwMkwwVzExcmhxbVNjek1LZWk1?=
 =?utf-8?B?WXdUZHlJSHRJaE1sYWg3YUd0NGpPcVZyQjZ3U0hUZTZocW8rOTJvemlXdGZW?=
 =?utf-8?B?dUxpWjBueWhha0hEMlFYTkFIU1FON0svUXpwMjdLMStUVStWcytxSThNa1Iy?=
 =?utf-8?B?MENYR1Jqa1UzRkN1ZkpJSmx6c29ZVWpHdFozTERaeE14OWEyc3daRG4relg4?=
 =?utf-8?B?aUIzeUdFMkM4RlFQVmZid3lZb3FZV1QrNXFYY20rRWJDUnVIYzNEUzBkWW9X?=
 =?utf-8?B?NUltZm9YWVIrNXhjZDV1cmdjaDZNWlZYcXc4am5oaGhzUkFnSTlXMVdRemZy?=
 =?utf-8?B?OXQzV0d4UkFEOUVURWVwamcyV05ZazJMQ1pqL3NtZTBiZ21XMHNzTXZlbmFM?=
 =?utf-8?B?U3RRcTIxWDJjWFdjRXJrV2NSVyt0V2R3cDFmUUVVNDdibHcyRHF5Y0RqUWwx?=
 =?utf-8?B?RGthUzRwYXYzR1pGdEE3ejFFZG1BRkNpdmxPVUFOOWhqU2M3U2NZVmNKclRC?=
 =?utf-8?B?citDUHhTd0NpMEpQWHB2QjEwL0lIMkZWT2VrK2dqLzhUS2tqbWpWL2NMZmQ0?=
 =?utf-8?B?SmplbFI4WVBkYjd0L3FCbm9ENWpzc0x5SWxvYVpDYUlUbmVRbTZlZjJ5dUp2?=
 =?utf-8?B?UlZLZ1JXenQ0R0VFMElDSzdqUm9wclpNRVJXYlUveUIzN3NaaSsrZGdOL20y?=
 =?utf-8?B?RCt1U3J1R0M2dU1nZk9VY2g4YmFwaFBRa09iYnhDQjluSmlFbkdidkFJMURx?=
 =?utf-8?B?eG9YM3BxSFJtR25MaWNmVDJzRkNWOVlGWWYxM2hVa3dOYjRkYVhGRGdqS0ND?=
 =?utf-8?B?bDljSHA1dm9NMHI5c2FlVTN3Y2ZZbzRCazJQNERSQ3Bwb1FMUno3Q09jaVJW?=
 =?utf-8?B?SGxwcEZ3amZ4REsrK2drODJsdnA1SWVLb1RZTFRWaFB2emtuekNIQTA3emR4?=
 =?utf-8?B?OTgvVXFyMEh4U2VQK0JjRnl2eGg4d3B1WnV6MW4yOHFDUWxuN0l4Kzc1bVF5?=
 =?utf-8?Q?WtAfJot/z2hbfR9B7/ydg/JkV63CBnok?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Yy9wL01xdkFreUtPUExlZi9VdXd6blo1WGwxZlJZZGRIWDNKTFVrRGRpU0ds?=
 =?utf-8?B?RDhhRnkySDM5R2dRbk1VUnRaUGt1azlYdVlFVkhSOUFOT0o4aTY5N3dra0Ux?=
 =?utf-8?B?RUFqZlQxaDhWcmpWRndyVytFa09nZDZUMkFBR2NuM1I2UldsRWt2NTZMRUZk?=
 =?utf-8?B?N1BIVVRuYTVtQ2tiS29TeEYwQWVPQkUyU20xcHBxalp4MnBpRHNLeGRmQk1Z?=
 =?utf-8?B?eHp2aVpXVXBvOG9wS2dDK1ZQaXJRaFVzVU5MQkZGanBHbHRNSHBnQkJDNW40?=
 =?utf-8?B?Wm1pSjRYZVErOFljR3NwRk9tQlBLanBCSjlXdmpLdDRRR1hHaDJQby9wZE1i?=
 =?utf-8?B?ZCtGTVp5OHViSCtrN2pXOXI5akJ2cTg1UXZrVnI1R3NkQWdqL2pwRktEbHFU?=
 =?utf-8?B?T25pTlZBWUtjdmt0U1FnVS9RT2VTcUZKSnhGY2VIeFprV00yRHhmVWJQV0lj?=
 =?utf-8?B?cTF3akNqWWdmQ216eWRyVGZpYnAxdFlWMFpsVkdrUHhoQzJ6L2Vuait6cndW?=
 =?utf-8?B?WGNHNWJhRFJPVTlFb0wvUndCUGFtV3h6MDB5MThTcEdOdGt0UHp6cnJhVDVq?=
 =?utf-8?B?QUI5dkIyOFF6Snd2STkyTWVjZkVJT1B0Wm5jQlZ3cHpCYnJXZUNpODZpcE55?=
 =?utf-8?B?WVBFWHRyTEdDb0tTUEltWkpwVUpNZDBLTEkrbGlrUVlIbXVveEpuaTZXY0hO?=
 =?utf-8?B?cmRGRVJaOXNrdUxtUnh5enZnNVBUd2kxOFVpR3JEcTVweW93alZwV2pLdzAz?=
 =?utf-8?B?VWFwdXBQMXBvdDBsT3E0M29oR3lqaGZkM2pUZjEySEdXdjBRRmhraEdrMmtK?=
 =?utf-8?B?T0lyZVZoM3RBOUxyVG0zSTRrOGhyVzhJMnBzVWl5RkZ0YkNuaUcvSzVHTzJV?=
 =?utf-8?B?THNZUm81bW9mT3RyRVFjSkNNY2VLRHdjdUdOQ2RYaFRDdGhWT0NHeStRZHJF?=
 =?utf-8?B?MW5JODdRWTdkN0F3QVRrOTJqTUhCZ0JGanp4QkE5MTNtTGFIRXZ3cllLcWFT?=
 =?utf-8?B?QVA0RlZwUXhPL3hhd1RSMTFSSnFlenorQ2d6enAxc0RHTmp6QzloZXZhdklB?=
 =?utf-8?B?d3VrUGVZYWNvWWxXSG9heHh3QVFjbmpUM3I3bWd5M083dEJ5azFOSW1Nd3RX?=
 =?utf-8?B?S1UxYVJHaFRQSEU3MnZVdXkrdWV3elZQV0VvdEdScnc5VFNsMERNMWtmbzYv?=
 =?utf-8?B?NGx2L2R3YWoyaVVaZnd3ZGdidk01SnFEU1QrclFXL28vSCt2ZTliMjVqWWR1?=
 =?utf-8?B?Ym1XZm1YUGNhSGFlWHczNEc4VzZhQWdseDA4MWJYanY0dS9CMVdQc0RtNVFp?=
 =?utf-8?B?dXVuVUJGakZmd09xdEEzbXM3cUdIWEs2bCtOalljazRnYlNnMDkwQWE0OTVG?=
 =?utf-8?B?RXp5UTkxNk94c296UzNCalJyVzRORUljTVpidlRqYUR4ZjJRMHVGaTlQbGUv?=
 =?utf-8?B?ZW9BY29MdmVTMTJNa1c0QWFnVnNHM01ua3FPQ3A3c01OczlmUFByYXgrQzQ0?=
 =?utf-8?B?QlBsK2M3OGpIeFVrMDdUcEw3NVJPbWlzanhRSDZlMUMxaEZ6ZGtlQ2FSRlgv?=
 =?utf-8?B?UEJFOTBFNWQ4dzdZWm5HQmRKZ1ZyRnlkeUdpL01XYUJDUGE5bXQvM045bkxE?=
 =?utf-8?B?Rkh4TERkMGRxVTlNMVVqcS95b2tXSkNXc0ltamlVNmdRcDZYdlhUQzQyVWhi?=
 =?utf-8?B?TFBIalVpQlhUMC9oaGcwQlhyRmJUTUpzd2o5Q3FCd1BScWpUZlBBMlhvbVNR?=
 =?utf-8?B?Mk9nWkNEME1HMVREa0dYZjNSRmIvTUZCOFpBOFVxYmMyczg5OEY2MzlXRi81?=
 =?utf-8?B?bkk2TjA3TXo4RmxXMjRqWWZIQVBvc2xxUzJ4Y252QURkcUNSbjZYalRTcXM3?=
 =?utf-8?B?TmtLYnZEZFF0UUpkYmFMQ2Z3MmhDNG1KcHFUd0tJaHJ0UHRZWnpnaUFEck1x?=
 =?utf-8?B?enc3blhOdTZVRzA4TTBVaUNyb3h6aWNxbU9kU3c0RHBGTFVpWHcva29XS1da?=
 =?utf-8?B?cVZSU3U1VVQ2S0xWMkFPVm5DdUovNEhyVGpabE1MSUNUL1hObWNjY1NJdGZW?=
 =?utf-8?B?UytNZWtlamxJMCtzcVdDTmxoMlZTdlZuL01TbXZDQ2VqNWFBTDM3dEcyUWtY?=
 =?utf-8?Q?6aIxNQR1CA/V8KddafrrdCNC/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GtkpA2x0pAXgSbUShtJqroIgryQAW5tJYCyDJ5+iYMW9VnyMgC8Kev82NWFy1xtT5oPWY25/WLBIckLaU7/Qhj4TAmGXZnY0ecrdLcmjted3P+be27kdCenU0MulDsuDL8s5SYD08SMGe3B6WdJRo+zYnTvKhfrzEcTL4sYinBg9ceaorSPq0ZNqJDJ+i1jpx1T8l6gH8u41h37K3tV6zahMZAOKxPWFyZokcP6SwQjfs3PhSJTPLh6FkwRpz54aDOx9LvAwF/7HICEO8c2q/0rNcti7URMS/vmJ8t8FDwhjJnNFdkopYuXO6jg4jmvjYQlJjz3C4bFabKUzU5O2ebULzgeaZ5Ndpl0oWZ4vTkme3O93R1tocaSbTOoNe6PdHggwdKDsMU/jJJ2+/1bpqbY2lo1razxrY5/TjhivaSetQpsmXGlRRDoA+kt9QJNCd+OC8Yp5NdkRvPJ0b9rNN6wO298PCHP9u3tmqWL6nKlIg78VsR+kkxlVnpFKwzl5hCtyTBWWcb0v5Y2q8c+agmOWQ5e4vOZjlfZVau+E92mBZPNvc0afnWEQ6zKO9Pj8TuJdGt/KIQ5kJTu7J/mFhBWEJ+XAiYUHzPFrHr8FAyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db05b9e-d02e-4409-ce1f-08de12391a99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:36:00.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0KtSdl7r8ZOjyWo4bWzywiPs/ix14ndc2FRG9E2x3Qpjt5VY6WNcdpEpYDrE6XmJpRwjnLRrpIfcKVWoGtYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=880
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230124
X-Proofpoint-ORIG-GUID: ZPwPpKASMfcECiljg2SvXdb2rsI9dEX_
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fa2f45 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zzLD-v2X0-J3c8VzWaoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfX1QL6oWKqvbv5
 xPNRKqihB+J5f/qSJMiyOjI1oUIHGxs1PtLxyhDfbkGU9EKr06IhnDO4QRzv19ICqNWHgbQBkV2
 +bzaLlxARp7lXx8TSEXQhK32Pc8YSk+oAKJJbgb8+5f72zZGuIAIAWNuapvi+Q6njn+KKStuUqB
 Fr9lpQnIvGUnTD9m9Jt6ghUn28IJDVWZ8aoOqzLPK+Nu5tJOgA7Wz87Cpizl2pZPnSvGwTTg9NF
 XqsF+K4JJnRCwRenuNdp4Rv81sHVOWiYV+aP8/cjCU/dk9+V99YRx7nQ1MpyWFbYFYxrR8Jm9Bj
 W+CvIoKmD53dDQ8p5icFJWGKOrHsEKZwcGeyxEuQSn951udz89xWq7vunsuxrlJT7XitOZZnwxf
 fhj62BpVgaaQSdhUbs40KWEjO6WG383TYVLSGGj1tPtw/kyZOsc=
X-Proofpoint-GUID: ZPwPpKASMfcECiljg2SvXdb2rsI9dEX_

On 10/22/25 6:34 PM, NeilBrown wrote:
> When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
> is testing the stateid to see if it is a special stateid.  I find that
> IS_CURRENT_STATEID(foo) is clearer.
> 
> There are other special stateid which are described in RFC 8881 Section
> 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
> currently names them "zero", "one" and "close" which doesn't help with
> comparing the code to the RFC.
> 
> So this patch changes the names of those special stateids, adds "IS_" to
> the front of the predicates, and introduces IS_SPECIAL_STATEID() which
> tests if a given stateid is any of those listed in 8.2.3.
> 
> I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
> it IS_READ_STATEID().

IMHO IS_BYPASS_STATEID would be a more purpose-specific name.


> Places where we now use IS_SPECIAL_STATEID() didn't previously check for
> "current_stateid", but I think they should.  I don't think that change
> actually affects behaviour.

This needs expansion, it's a little hand-wavy. How are you certain that
including IS_CURRENT_STATEID in some of these checks is OK?


> -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
> -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
> -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
> -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))

A comment here that directs the reader to Section 8.2.3 of RFC 8881
would be nice.


> +#define IS_ANON_STATEID(stateid) (!memcmp((stateid), &anon_stateid, sizeof(stateid_t)))
> +#define IS_READ_STATEID(stateid)  (!memcmp((stateid), &read_bypass_stateid, sizeof(stateid_t)))
> +#define IS_CURRENT_STATEID(stateid) (!memcmp((stateid), &current_stateid, sizeof(stateid_t)))
> +#define IS_INVALID_STATEID(stateid)  (!memcmp((stateid), &invalid_stateid, sizeof(stateid_t)))
> +
> +static inline bool IS_SPECIAL_STATEID(stateid_t *stateid)
> +{
> +	return IS_ANON_STATEID(stateid) ||
> +		IS_READ_STATEID(stateid) ||
> +		IS_CURRENT_STATEID(stateid) ||
> +		IS_INVALID_STATEID(stateid);
> +}

Might be nicer overall if these were static inline functions rather than
pre-processor macros.

The other patches in the series LGTM.


-- 
Chuck Lever

