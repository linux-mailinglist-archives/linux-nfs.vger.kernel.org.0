Return-Path: <linux-nfs+bounces-14820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36FBAE245
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F00B1C6EE5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BE168BD;
	Tue, 30 Sep 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p3eUlTyF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tkp+GYv+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B523ABBD
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252520; cv=fail; b=R2XbB4DlWI7+8oPZYertx0k9R8+Nu3+TAL9zDn48lc2SrM450V+8DWfpGLTNAtYv2UtWkMmgepM6KyhQariGmo+2WVSU/lOPHx7XA5q0hJ+DykArQyED/RFpCati1luE2ilofqeTYjDRb7TZ4mgVO+d8WGgr4QmDKreJLs2Q/CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252520; c=relaxed/simple;
	bh=qsrAAxH0jXo+vW5G360mIR7w6XKBpPpDr74BZu5muUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeD6t3Ypz4RwfYy8et4yXLG/PibSIhf5YFyA+LxOVAe0OhLtFHsknnWnJca6AZPGAM+C3FODok7Qvz2VNsxoHrCsY7gz1SJ4Cr4CZZbZkk8Hy71l+xtiL06tSpHt+zcwCwEBOfSADrC59vDZqgCnJZeXCwqcQp+2/aOnVSOzS+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p3eUlTyF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tkp+GYv+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UGePRg018692;
	Tue, 30 Sep 2025 17:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H+ABtzPe7rUYp40iq4YOiuHL9ui/667qrwa3jb2hjo4=; b=
	p3eUlTyFWrqW/02xLmdv/Koank+lu0AaSU61Qqgd3DZ0EI9ut5IE/kUAotCcPz9R
	t09oYmwSt3SZhbBWc5GgU2/c4LZ941dOw7972aGNRlMkFAEGW/8nflQYFRvH/OGC
	EBmGr7HBElk/y2nwbrFKA5zT/nxdTj3cYmaooHuLAmADvtysj72fd+nalpDe6WFL
	9zVrjm7jBuXbEoG5KNxzdMsYjv37+SI6AeVHaCEyywmiqKe1QDiFfxlLI2QIhw5Y
	Io4I78CH7kfRwGDqG1HjKGoh3FpPKLVd9o+5TCz8YcLe0bcM/lS0Gdvh97Aj0S1O
	ida1Lk8ObVqktDeDXKmC7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gjwu02qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 17:15:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UGCt4x027573;
	Tue, 30 Sep 2025 17:15:10 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c84c0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 17:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKzWpOMsoa0998qtUz1E925MCmMUo5YBibrlw/vk4s0un5t/oJwZqHKnehvkdedQW3VMvwIAcFnOudHRzfbSe8/ubDCR0th8B52PEPTvaaq0vCcGjcJ3Pbz2c9JDZoUg3FljBveAnUjm8Xk32pHZQI3UEYLwCThmXa425NYp/uFFNwAulw2+eBiOae+AaQ8qTIs377AoiMEZat1scQ3CqMBt2w4jOKZHa+5zR//eRHc4Rrmq+NF01QiY04d4jiUtusfxbtqL3/WKIcviI0wW8cGii2agXz4rav7FfUFU9ZgVDHp5br7szP11lGuhogRZFbpIRpejVlbFLDRx1R6Z3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+ABtzPe7rUYp40iq4YOiuHL9ui/667qrwa3jb2hjo4=;
 b=QV1jlTgCQW+V61hc7BVjslLlrNdR3uq6lCiERUNwg6hn8n7cJLHxxBUBXdq4h3jHQJTpu4iwu4Pvw94V2lOi5X7iqE+f9DHKL3J+FyEBBF2MvqTwNAscnOG1Wc7Xr3sQ/EieY94MHSzoayMQXCJvCLorGZBlAtz9xEWy8DaGE+oTIAU49AB4lxjLv2pypoxndSETEjvs+GRHSsjusOiJX2TnFm4bHocJHDaNuCZSwQhj3QxbWo4+o531C/w6BUNcJA3m80CMBwD6jSOEAGbC99Sbn7OX7wQhR/onfpdGbn4V4ITv7XtShboCvXRctGbY7P0m2k2ssaX2DKN3pfRNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+ABtzPe7rUYp40iq4YOiuHL9ui/667qrwa3jb2hjo4=;
 b=Tkp+GYv+KXxzsrYuXmbX/H42wQfAubvJw5UzN3/2JWdAqt4Q8lMq4G9vlQA9/KIuz0aMfwlzXUDtnwv/adsRIlmOr82W8U5lthdO9wqoz1KwLABcBFzCmDv2o87CmxQ4fc9+wa5XSKIAX1pHBZ0gZ7oiDmqDreCt7TWV3mtIJVs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7811.namprd10.prod.outlook.com (2603:10b6:a03:56e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 30 Sep
 2025 17:15:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 17:15:07 +0000
Message-ID: <178769c5-e29d-48d6-91df-4bb45c48aae1@oracle.com>
Date: Tue, 30 Sep 2025 13:15:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] NFS LOCALIO O_DIRECT changes for Linux 6.18
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org> <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org> <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aNwEo7wOMrwcmq9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0060.namprd14.prod.outlook.com
 (2603:10b6:610:56::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f903759-107d-43d2-8084-08de0044e79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWVuNUluRlFZVTVMdVJIRVVpRll6VEJUMHg2SENyb1hwQlIwNlFRakpIZ2p3?=
 =?utf-8?B?TU9zTzI0M2t1bk9WaFo0bnFkL05oamxEWTBrSmluMWw1eDZGNXFkM0pTczRC?=
 =?utf-8?B?YUloazJHbTVMYUZMQzFNREM4Yy90ZGw5eDhUUkppVWVWdmVId1Y3L2F4MklY?=
 =?utf-8?B?RjJFVUZUeVdFREI3bVAwRG5lQ0lwODJGQU1YUVUrNzFvbTR3Q2E1S0NZRDV3?=
 =?utf-8?B?N2VNV1o0TUthbkNMN1NPUThpUndHb3hLT1QycXlCV0NJcW14V3hvZHVlcml5?=
 =?utf-8?B?ZGNrZEdhWFBCQUl0WlVON21Wb2FDYUpxUUQxakNlNnJYcmVQaG5HSXJWWDBv?=
 =?utf-8?B?dzI4cnR3MmJyajAyOHFvbFJIK2JRTjdvM2tKOGp5SjhMOVVMRE14M3N2TUNM?=
 =?utf-8?B?dFVqT0JTOHhaeFBtcXRqU3JCT0YzL2dBb2huUVd4NU11a2thUVg5bE1ZVGdQ?=
 =?utf-8?B?N2czMFRHMDJNRXZrSWpHZWloR1UvbFNoK0M1YXpmc2hQUjJNUXpkam9SR1N6?=
 =?utf-8?B?N1QxYkx2bFBkUkJSQ2RhOG9MQkNUdzU3c2laQ3JuTXdEYlBXMStEdm9nWVhw?=
 =?utf-8?B?VXROZ041QWltTkFuS2l3Wk5KbFd0VnJxaFcza3dndzBudXhpSm9WWUNWOVJP?=
 =?utf-8?B?Q2IrZXZYZkxGU0Y2ZTBteDU3aVlzbjlpTzdobEZMcW9YVjlZcERyeUZFcWlt?=
 =?utf-8?B?b1p0YjFuZk16T0RhNDBTNXM5aUwxellpTzh6WGp1OXFxSm9xRE9KQlBYMFRI?=
 =?utf-8?B?dkd1SWJ0TFA3NVBuT25BQU5LRzdTVXg2ampFWU9Za3hJRFNNZEVVRUo2K043?=
 =?utf-8?B?bjBaZjRnWjZVSmRzTWc4Q2pHY2VieXNZazJIL3NXSE16ZXNZM1NSbHZrak5B?=
 =?utf-8?B?YW5nakNtbG5wSnphNEZ6d0F4YlRXdEtVY1RTQmV4NFIvYkJqZlpRMm1iamxI?=
 =?utf-8?B?b1I4ektWUW1NNkEyZzhidDdLakxiWVQ1NkRUS1FaTHRLWEtsWWpvdW16VnJ1?=
 =?utf-8?B?SjMyUi9uY0RWVVNiVWRMMDEzM2FPd3FtV2tnNWRXazVYK2VWQ1Q4NlNsRytz?=
 =?utf-8?B?eDY3VzBMZkVvbmhpY1VMTGlYQzRpZTJhMU8xWlAwbzBYaC8yZmh6ZVhNRkJT?=
 =?utf-8?B?ck50S3NzbzR1TDN0a3JIdzVMTW5kNjM3aTVQcDNtR1ZHVzZBWHFVMTB3L0w1?=
 =?utf-8?B?VDZxdnY5cmwwb1hueDBsSWFRdCtLa1hBLzdyVVZCbGxoK3NKSWxoOTArWUFy?=
 =?utf-8?B?aUJBVGQrckpFQUlyeFVIZVF2bVNXMysyVGVUeHllb0R3WkR5djRPY1JYZVdp?=
 =?utf-8?B?ajZGbU1iMCtTeDc4MFJ6MFpGejVQRFk5Ri9rMk5adXQzdkR3RWZnNWlLR1Nn?=
 =?utf-8?B?T1ZyeCtqNXJZS0paODhpNU1mVG5DYWczbXFjWTRVNGgzL1lBVUNXUkt6Ryta?=
 =?utf-8?B?U1FIMWxncnB3ZEhBQWp1Zm5ZVUMzajY1RkJud1U2RDA5WWJMbFkyVThlNVVG?=
 =?utf-8?B?SkxhNk55Q2lRNE5kR01EdzZHY1E0WGRmemQzMGsweDIxR0lia29wb1NMZFlT?=
 =?utf-8?B?UUFuMFZ1UDNPUVJESWptZlI4M0hjcFJvZnB0dW5CRjFKOWVPLy9qWDdOWWo3?=
 =?utf-8?B?RGVzN1ZrZWZZZnpBUFJGZzhYeGhOODZDR1J5NlJZaXh6MklSVWp5NUk5alJw?=
 =?utf-8?B?dzlyelJzbTlRMlhlYTBEQmdTb1BLaEZJaXVVcElVUVhGeWFaNXNyR0JmeCtx?=
 =?utf-8?B?MWIrL0tDU0tZalYyQU5POUxFYVdYbjlEU3JtVEFKWVQ0eU5ZWUQwekRHY1NT?=
 =?utf-8?B?dDJiRDRsWG4vbWh3a0dzTTl4d0lxYVhIVXVKWURTZHM5Snkzb3BXNEZNalZj?=
 =?utf-8?B?b05uUnlSdmwrcDRrQXFlTnd1OVhMaSt1R2NBUUY2TzJiYzQxR1Z3Ky9tZ2Qr?=
 =?utf-8?Q?yDFS2SFg+xKOjp4+3kH8krqXpnjjeBTI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEZYbllPM2dTMUFmVG0rN0hZMVFPeWFDL2lqdnhhcFdXRVE0UThTQ3JQL1Y2?=
 =?utf-8?B?bGduZHFJcy9YWXNaNERLY2tQUy9ZTlVHb29wS2swNDVvRjUyRW1kK0VhYXRK?=
 =?utf-8?B?ejZhekprMzkrWW00cWk3OWJkclAyV2dEWHFjTXF1MXpjMC9KMkRYUkdCSWJx?=
 =?utf-8?B?SFlMSU9qUE9zVUhVUWZEdStHcXU1T2FjRTIyQkhZWHVENnFHb2lUME9vN3c4?=
 =?utf-8?B?SHRwdkd4RDh4ME5ta3N4MXV3YjVFMXZ5emMrRTV0NzBhSm5UVndGSGVray9Q?=
 =?utf-8?B?Vk1MQ3pEL2M4Tkh0OURLeW5GSnRHVGdhcytaRGQxelo0bzZGZU5sQVNHemVO?=
 =?utf-8?B?MkZIR2RSSVVsREdQdDYxek1SZDY1cVZ4c0tKRUJIOHc5a05LRWVHUWMzWmFa?=
 =?utf-8?B?dzRDNjQwenl6Z1JVQ2FqNHNnR0w0OWtGY08xbXBrOHZucG1jbHpRTkRMcmUx?=
 =?utf-8?B?VVRZVFEySWVlcFpxSEZKUlFRRm9ZWnFyc2xKajlLY3JjT21MTmdnSHlmZTdn?=
 =?utf-8?B?eEJWNmw2L0NrU3NwY0trRUNiS1RJaWs2T3V5U1F0OFdOSFFDbmZkT1p6amZh?=
 =?utf-8?B?SE5TdDhRMzFFWW1aUmlZVTZFYWNFdUtnWkVST242V2M1T3dFVm10a2Jpd28v?=
 =?utf-8?B?OXRmQ21VZmlvM1V6Ujdvd3pNSjRjVDhsbDUwVThQS3kvUURIWWcyZmtVMmVN?=
 =?utf-8?B?cnduWngyZ3JGam80K3RuN2xJSHd5YU9YbGgwYjVmcENtVlFlYkhndWUwMlNs?=
 =?utf-8?B?bEdBOHlhbkVDT3JTemhjYm50UFlaYUNZdGgyclNlTkJCeVk0ZHdDRGJiNmJ0?=
 =?utf-8?B?bHphWUthWXM3SnltTmtDUGh4NkJlMUZENm9WalFZVmh4YUtrcFFZc01LYTUw?=
 =?utf-8?B?OFlaVk9EbTdmK2xyVnFXQVFFcVdaWDE5VmY3NEcrdm9kOUw0eE0wOFgxdzlh?=
 =?utf-8?B?TlJGKzNLbjRoRlpmM1BuTG1ZNGdyb0pWNGg2NjNGVGE1ckZSbk9EM292OVJG?=
 =?utf-8?B?aDlnVnR5RndRWlZmUWwxMkhuWEYrZXh4SlBuMVlaN2RtVE82cGRuWXJydDkv?=
 =?utf-8?B?ZllsL0czVEV4Mm4zS05CMStRbVlvSG0xSUNaa2RDQis5ZDJ3cjhTNnNtbUUw?=
 =?utf-8?B?aTJDSWVaZ0NYcTlHdy94bkpjbGF1dElZYXo3djNyQ01TeWNzcDRSTUFZelg0?=
 =?utf-8?B?M1VrZDZ5aVc3dlhQRWNFY2hMSWJ0bm15K3BSYnRPYWo3cmpHUUJOakloRHU1?=
 =?utf-8?B?K0VtYXR3NDRIemVqbXluRGFVTWgyZ1VvOGdrcTdSK2psY0xaVHJoMU5ZR2NM?=
 =?utf-8?B?YUxjRGVRaEpJaFN3d0k4dDVtQ0sxQTFhL291a0w2cFVmZWFGQm5qV2pMSkIv?=
 =?utf-8?B?a3JDb05lcTN3MGFpbWRrdGo0SGFhQXpJdWU1NVdqeTlhbGRYK3F2N3VlY1Ny?=
 =?utf-8?B?bGpjNndMSGFyQ1ovZ2s4VzdIMHlyWGhXY05tdndBMUJQbExUNW5INi9EanpF?=
 =?utf-8?B?UVZ5S25lVytCSTd3UU1TbzZmSVY2eWhWU2c0bWJLZTZKdEN6dHFydldsMkxH?=
 =?utf-8?B?Ulkra29hMU1NRUJaM0ZreXZLVk5xSUFxS2VxYm9aVkRrZFpZR2owNDlFWU5U?=
 =?utf-8?B?YkRrWVd3bjdKdEhURDZ1K2k5R2ZlVEI5Z2IzY1UxMWp1K3JHN0VtaU4zVjFX?=
 =?utf-8?B?SUZkYUhydytxVkxMZkNKT08vVmhEQ1ZWdDNDYjNFQnRvWE5LbWVFOXZQOXRj?=
 =?utf-8?B?dXFLVGpFMmVGalJyOUIxbFR4WjBNV015Mjh2VUYyMUd5Q240UnFoTDFPQkNI?=
 =?utf-8?B?MUdtVDU5cWhuYUhTckVMeUZMVm1QSGdSSk9BVE56MXRnT2NYRE83OEQ5elk5?=
 =?utf-8?B?R29PME5wWlRTajZIRU9EK0tLK1prakIzV2pzd3ppOGRRdFlpcC9BMUZERWZP?=
 =?utf-8?B?dGlmYkhXaGt4REl1RnI0bFpuWDZjVCtyc1JTZ1hZQUU4ZlcrQlNHd0h3cklx?=
 =?utf-8?B?Myt0SDVDY25qWUF3SjZZbUszb2cwVHR6eWZiQnl4Rzl3aDZTMTl5VW5jMkMv?=
 =?utf-8?B?NjV4WGJhRUxQSDMwT0dQbjh4WHBlZFVGQlZkN1RFam9sZTRLZWVLRFVwdjJi?=
 =?utf-8?B?d3gxYkt5SGo0em1xdUNhdVdpT2hxL1ZxcnVWS1dhVm03YjVVS0lXMHUyUlVw?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x7sOl2Z3VxgGGSg3JBdhbXXTFXvKzznvU9WZHp25F2ADVzAd6llzQal0hIl6PWLQk6Kdloj6fg204yGUwyHsmLHP7m0MsPOnLAJfgdnnIOmqQg7dztJyMtVdxFaZ07LkLnp9r4VSo7XhaFcoyQHAs02e+prxE/xaFRdU4vFZjpvLlamsgUc4eniJdNI1fhKJx0W2WBTumkrl1nXinBBMvNj+mr8IJSEK1uC330kq1q5zKHNm8Nt1yP8prtsItXMXfbgjEGZXhMzd+7/xKjkhuJ+qE/ZbmgntDL8Aho+d8YeXCYzP19Kh8Kz1Yjyi36Vjbv+ObM309op4zE+GpIo/sT4sj1otarvkUTZUAfU7OTOp/GG4KkaKSkWxa09FI3O7Pnt9Sk+1aUUhBaENZX7ELLI3b4ZSUXzo8BVf5IvXSycda+WwPG1+QVSjVcr+y4ML9Ha0XrjJRx4i8Th1g2VlxntZXtCmG97qYymy7V6+rQzYbR+yiw0d5dLnC1ub4SBkhrA8W/0xqfV8tifF2MvU5g8wMBDGSy+t9xhce2+vDbjp1nVNgnfaZOMLE3MF/dzY+EkLWwl0jWR0M6DRxSCn9xdBs2r6TRnLxToKVEfgsqg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f903759-107d-43d2-8084-08de0044e79b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 17:15:07.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIp342F4o+XiTyIOc3rcLaguHpbDQ8oeoFh1hjdZH7jK4dIh//+7fzQd3rmeTETVPJZrU2A6I93MYjr8c7X8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300155
X-Proofpoint-GUID: eIEUEl8MKls0xLt2A6oQlrhbQ4LRZ5Oy
X-Proofpoint-ORIG-GUID: eIEUEl8MKls0xLt2A6oQlrhbQ4LRZ5Oy
X-Authority-Analysis: v=2.4 cv=ddmNHHXe c=1 sm=1 tr=0 ts=68dc101f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UEY-TPaaUjpdjCTY6wUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE1MCBTYWx0ZWRfXybOQ+hg/D3aG
 CGLTdvkSXSf8+O38b9n0VEXnB4T4+97dtW5DTTSvVllR+BvZCYiXIUlLTao044B6ANGGSQFxu5f
 JZpPpvZ0NA2EMpcFT8hT/yQzAnjmd/ctSwzC3Ek4SXpxER79IhBzV4H8tyh3/DxzKJ+QZselMvi
 dVrnGpLLM6kT/niHoHlNCVuE4RFg9FSw6g6IOMR4I3WYnfHSQExTRgvXaPhgr3SgQgVCL4wXWCf
 T/PCI1EfOBcuNzY/aXgz2zWDhM1NEifyVl279jxymZKT4L7a602UU7Ftv11E8iWjmVzF0myORo8
 FKinaOrpyfh23587AyEpLm3IUzP1GS5IfWniRFykTOnHb+Y2d9a4qggasnotbb7aZDA35tmUP15
 PRCJr1VpnBQv1cW4Sl5dMKuaHRfX/Q==

On 9/30/25 12:26 PM, Mike Snitzer wrote:
> Hi Anna,
> 
> Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
> which will be included in the NFSD pull request for 6.18, I figured it
> worth proposing a post-NFSD-merge pull request for your consideration
> as the best way forward logistically (to ensure linux-next coverage,
> you could pull this in _before_ Chuck sends his pull to Linus).
> 
> If you were to pull this into your NFS tree it'd bring with it Chuck's
> nfsd-next (commit db155b7c7c85b5 as of now) followed by my dependant
> NFS LOCALIO O_DIRECT changes.
> 
> You'll note that I folded 3 commits from Chuck's current nfsd-testing
> branch into a single "NFSD: filecache: add STATX_DIOALIGN and
> STATX_DIO_READ_ALIGN support", the commits from cel/nfsd-testing are:
> 
>  9cc8512712b11 NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>  e5107ff95c56d NFSD: Prevent a NULL pointer dereference in fh_getattr()
>  ed7edd1976c04 NFSD: Ignore vfs_getattr() failure in nfsd_file_get_dio_attrs()
I strongly prefer that the second and third patch above be permitted to
soak in nfsd-testing before being merged. These two modify very hot code
paths in NFSD, and therefore deserve proper test experience.

Please don't push NFSD patches through other trees without at least an
Acked-by from the NFSD maintainers. The first patch has been acked, as
you requested, and is ready to be applied to the NFS client tree. That
Ack does not apply to the second and third patches above.


-- 
Chuck Lever

