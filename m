Return-Path: <linux-nfs+bounces-10177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34296A3A1FD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E4A1896878
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CAC194C86;
	Tue, 18 Feb 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FlerAnWN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gx1tnNpE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDF1459F7;
	Tue, 18 Feb 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894523; cv=fail; b=LjGJMxjfAHfXaq///j4S+TEX2MPwYT1jW+rYorBMh8NPS1Jxa7B7VGnPmHmkFluO9/zhQIO+6X34KfsqpB/6RFeYc682iL7xdiUBy6risCHM3xOL7w4RzEk40/uId0ar8DOHert2DRXNgNbgtFPuIqfKZ3M3G4a4N/s9sNMIXW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894523; c=relaxed/simple;
	bh=iSUj1aHjRy9KrFr5Is9ecnXI1+XLvSgyatf6XsYVNuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jApmy0nb+z8Kk6Ichzkx+3Pwy/IsI8mR7amdHHXD3OqGwr8eHs1CuEM7/cvDULDGuKYb5jvcTnh+TISFFkZL57EuNqwiJBGCD02o2yd/jX2jVKKJ5xvyeSHEdRU83tEbch4tzplAgz4SUlJyXxGwo9kBA6NjEuem0UgLPzgAxek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FlerAnWN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gx1tnNpE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFto7g018410;
	Tue, 18 Feb 2025 16:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GenphYlfBB9NFa38G1CMs1tujWckmWYhv3ccCXkjvR8=; b=
	FlerAnWN4tOjUZ2RclsMsoctKZwOWSCfYrNwbD8ZRDmLDlzoWnswzpxAtgizDgUI
	ebr3cOWdOpr+i8zS2o4br6S+RA0c6akfV+d+vEh+IDATBviiBdHYmdhKKNJJq/0p
	bK84jDtQjooQR2rixB02e4RM5slaDrFuth/5AK729QRL/FlAHiFrf00hZZS0fqoz
	YR3KKnxUiRogZVspspDdrY/LqgcvwoWMUZ3/9wy/EyTp8yIU1hGyXEhqcl1rSnRA
	pLox6w8LDmPcqomX0mbKjUugAfPzHXIOVKzrPucbo1jlMYG3CIsvBFmLSOZsfb7y
	bFx1/EkP5Zf3kN0c/257hA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjyby5gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:01:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IF5LCm002066;
	Tue, 18 Feb 2025 16:01:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcfgtmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doX4ZgXQGOYkw5mwbrBfL/lFQJDki2kkwEZU/SoSLn5PajTUaS+FOLCYcGE9GYDaSqtnB69ikNUy9ZN6wYK1MIB8DskQ+meXGwDF3Qh6bov8VXmbK04+q6FuvnIkhxTep3Dtmc97XvL5SeYdIJo2P6BEYnfs+RCWswfvmrBJLjoVikjrtIlYkHiZvtLwOYtAHEPFHPYbwvELoSr9HgZPpKd8wPLnmn+udgKepmyASxYJFauYKH0Tue+qkHKfzdu0Ard43EYngTxirYxszqDl8Z9JVwCehEoWi58rhqczKgNDKwDykRYUeKHqKEEApnA7DljAj8yMveXcWRxNqdqezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GenphYlfBB9NFa38G1CMs1tujWckmWYhv3ccCXkjvR8=;
 b=Y2JkkrEbvrNUAC/XwqrFtVKUDliwFV9L8ZSxDoIlF5SfnNg8DdJMyw8XCK+b4JK6FQDm/TF1rH4fncW9CrON2Jdzae3CQFi4o9AuApESRtVf16bjlT73ASQS8HP3Nv5C8Q8lbUcc5tTnm43yfKC/p80QZ5aHiaZ7OdUFL9NsoFFJ6ppIHSZJQagj+Vtd3abEr//C+BdLnoXq9Kz7s0FQ1zdCDp91JYaMQdmoi5IDE2W58WTQD3VfF+M/bUYgkxX1hW8559Cud7nxtWCLvA8zAx2ehPp89Zd465TONddFj/EtaXTtdnP8+MEMaB8cA4lvAfRPtmeXHcB3dQ5ztBGdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GenphYlfBB9NFa38G1CMs1tujWckmWYhv3ccCXkjvR8=;
 b=Gx1tnNpEXy5GUBi6tBoklkW8Qk/3zSOl1cIDPo5OHTtU1kgFc0XaH4ecIb+kIgUE5JDahruh+XrAC9tFRuGEI1nWwGO7W4Uvvm3AHfwPZF83SQQEKmDpJQJLNBixYudGQCnYAdDVWdznYmj1U/4Zxm5sE4nag9idUryoUSE8xUQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6341.namprd10.prod.outlook.com (2603:10b6:806:254::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:01:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:01:02 +0000
Message-ID: <d6a8fd60-b7d5-47ec-a8d8-a4136cd3ea62@oracle.com>
Date: Tue, 18 Feb 2025 11:01:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
        neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250218135423.1487309-1-lilingfeng3@huawei.com>
 <0ae8a05272c2eb8a503102788341e1d9c49109dd.camel@kernel.org>
 <04ed0c70b85a1e8b66c25b9ad4d0aa4c2fb91198.camel@kernel.org>
 <9cea3133-d17c-48c5-8eb9-265fbfc5708b@oracle.com>
 <8afc09d0728c4b71397d6b055dc86ab12310c297.camel@kernel.org>
 <7bbc3bf5-f364-47bb-8a3a-5b4e38fec910@oracle.com>
 <cb5540cc1f63a0761444850d153a41b2e33d5a8b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cb5540cc1f63a0761444850d153a41b2e33d5a8b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:610:38::44) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a5e81c-0f4a-448b-3dc4-08dd50357136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTd0VndHdFpnNWttWnNzai9vN2pxRnU1bldrOFBFY1Z4aHVkcEhWdCtIVWxO?=
 =?utf-8?B?NGhIM3dwNG9TSkZlbWhZS0dYWmxWU2k4Nm1Sa2JjMmFjaGZQK0lLSEVpME44?=
 =?utf-8?B?T2dKU3haYlNmRkVibGsrNXBYWlFISXY4aCszTk5ySFV0Mjc5dUc1djhUWDYz?=
 =?utf-8?B?US9TYlo0aldJVTJoYVR6NGlrV2lIUWhwOUs1RHpxNkVVWEw5ZTBFYkxGS0Fo?=
 =?utf-8?B?dXVqeFpIVFY5emhjSmYwcFBSREdWdzdDMEg1aDVjbW1WODZ3SC9RY3BHNzFm?=
 =?utf-8?B?RlJtRTFsMXdpNGhaRFk3WCtUNWpsY09ibzY0RmF0Q0dhR0tTeXlRT2I5WlJn?=
 =?utf-8?B?THZHbTYyaFdveHpqUFVJSVpKSDZhUFp5T0VraWUwZHozMGVYcCtUZTZJcmFY?=
 =?utf-8?B?SjFSczZtdVB1R0JiWHE3ZDE2d1phTXp0Q2Exbm9jL0xNb3cxeCs3bWJBV0ls?=
 =?utf-8?B?dGhqV3I0VTBYZ2JRZEVqVjQ3cFBNa0Y4YVdxYkovUVFYZHZsUzd4ZURrUlcz?=
 =?utf-8?B?QjJOZGY2dTFlTG9JdEtHMEx3aHVmdDZXZ2FBc2F2TEpqcnJ5Qmt5WFQ4ZVVH?=
 =?utf-8?B?MGI0akJQV1RqUVRvbXFhRis2a2pOOU81blUveEU2aEIyeWNZRkVoTUpEbmNN?=
 =?utf-8?B?UWVHemVZRmJ6TUdyUDBRNEdIQ0lBdy91RmtBVVpuZ3k4a1A0R1BWbnFmaDQ5?=
 =?utf-8?B?d1B6YVMzMkhudEx6bElZc0pnWnF5OVdsay9UblFTK2ExbE1xWmRBY1kwblV1?=
 =?utf-8?B?UFJNOHptNXk0NzVhdnp5a2V1OXhQRFRBdmpYNjVEV3VpZkR1cGtTMldxRGFZ?=
 =?utf-8?B?OEJCMUdzM1UzeWhMV1RKNnVKMFE2NDlqcE1IcXU0dWZ0bGQ2bHVaWFpKWEFz?=
 =?utf-8?B?YmJzNUowcWFENzZUU0RCUlppL0U1YnA5ZU1wVmJZYmFvc1ZYUlhxcWhjenNs?=
 =?utf-8?B?TURoTmREQ25tR2pKbGlqTVIrNWU2L1FqWGtvOVAxVDY2VjNrY3ZGbzZMaEdT?=
 =?utf-8?B?TXRQT3l0bVJUcE9hYmlvVEhYL1dNTjJDZTRrT1Rka09Lb3lTRUFlL0VrcFJl?=
 =?utf-8?B?R3ZTUG10RTE0K0pldXJHL1YwS2VsZ2xGR2p1TEhYWXBPclh1aStzY3RUNEtR?=
 =?utf-8?B?M2MrMnNTL3VPRTV4SUhJSDJRc0ZjWlFsQXBuZmF4b1JHbDBZNThhTkZUMUJT?=
 =?utf-8?B?eDFCT2pUNGVXbm1rVXpzRElaU0R1NU5iUm1NTVlOZW1IeHZTV2R2RHFRQVhT?=
 =?utf-8?B?d2VmU1U0djVWbnZkeno3WkdUZ0FNbklaLzZrRUYvZFBSaTYyTEM3TDlqdmlQ?=
 =?utf-8?B?SEhwRXZaT2dSZ3Fyb1F6MXN2anpoWUVBcTJnRzZTano1dHljVHhFM2VHVzdr?=
 =?utf-8?B?V1EwS3pBdGM2Mlp5T2gwbHp4NktFTFZiVHpXd1ZEQzJJWWx4VHBWTGtjYms2?=
 =?utf-8?B?NXh5U1plaXM2ajJ2WlRJNndDbk1oR1hVK3B1VDJvOExhd0E4NHhQK3lVYi9y?=
 =?utf-8?B?VlNOdGRuSElMRXlKaEJZZ3lRd3NqUXdUZitlSWsxNDNzRlo1Z0g1Y25VeWlT?=
 =?utf-8?B?YXZvcXlBTzErQ1ZLTmRUbzJsaG1zLzUvbjVsemVTV2JiTnNuMzVJczhQVE42?=
 =?utf-8?B?WnlhRGtWOHJwbnJPcDlFeVdhamo0VWZsaGEwK2x1NjVIOE5KRnYvYWo4eFJP?=
 =?utf-8?B?dFZIUjNlWGFYZXpVam9oN1F2ODVvSjhaS2JoRUNpZEplWDhaUmV2aUJZL3dI?=
 =?utf-8?B?UHB5ZndsQTdmTEl4Z3pYdFZzeEllSkFUNkplMlZCeEY4THBxMFAxSEw0Q1pY?=
 =?utf-8?B?WHdSN2hsYnV4dkhwNzRXcktibXIwSTRxUVBGWVlYUTA5UEhiMGZCdGRBTE9S?=
 =?utf-8?Q?zFdRVUE4V4lJW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEtVK3RLLzJ1aFZ1RE9sRjBZU3Z1cjI3bEs3VU9DNU1nUCtkMVZHRTBVcDll?=
 =?utf-8?B?blIvcU9SU2RUMUlVNzByZkhUZnppTVFLbDZoTmhCK29aQlg5L2tCUndJMVN6?=
 =?utf-8?B?MjVWaEFHOHhDRTZzN2xYZThYTlBFaWZwOWZiY1BTWXdhWUxLWHk5dTdjOXFk?=
 =?utf-8?B?cUpSTGxha0JKM2ZRMlFrSEszWnRnaEY5dUFSQnBtNXVZTU5KV0lpTjQ5dCtq?=
 =?utf-8?B?RGN4SkVlUnNoRXNZdGFhc3Mzd0xONkdKSjhqSVQrNHR1YTZvaFo5emhnYXMy?=
 =?utf-8?B?akRqQnFGTi9NL25PYzlkalFmVjNjVnh4endhQm5CN000U21Tc0tzVm95ZUpy?=
 =?utf-8?B?cnREYTFjOHJoQ1ZudkRWTVdTK050N1pycHlCbFdMN0JiTEI1d080MldqUnJJ?=
 =?utf-8?B?VUJLMEhEZmd2SHZUbFFkTHBEOUFZRXREQURQTEdLNHNKSnpDMm9zU0RxcGl2?=
 =?utf-8?B?ZHd6cm9zd2hzbk12d0lPTlBIS3NLU3piYjRYNEc2YVYraVNMRkFIYnM0eSsv?=
 =?utf-8?B?WDZQd1o3ZmIzYStaZW5yM29qa1dkTlcwaUEwQmgyN2V6RFVma1hHWVNtcTZN?=
 =?utf-8?B?VXhuK2FMbUlhZnh1OGduOWV6WUZaT056NG5VSUU3MXdUamswVUtsWmk5ZDVO?=
 =?utf-8?B?T1E4anozSlVJdmZEd0NEM2xWV25IOGIwYWlING1rc3pEQ1d4WDY1ZHJwd283?=
 =?utf-8?B?VngzRGs5ejhtWjJ0QkxPeVhMRWRxdVNBSTJha1FTVTBMKzJrZmV5WlhjWnlR?=
 =?utf-8?B?M1NLV214b2U0My90WlVOeGZ2RktDK3J0TUJ3ZkxQSk9MaWxIK3VqL0VsaUJh?=
 =?utf-8?B?Q0l2QWwrZlNpSmg1NnQyQjlPQzFOMFNUKzhjQW5ZaFVoVTRUTFF4bXFucHB1?=
 =?utf-8?B?L0ZZSjFkSC9tUEw5NTgzSytsdzZRTXhzbFcyNVZQYklROWQrSEJ5TTVMYk4x?=
 =?utf-8?B?eG9VQ29Gdkw3cXQ1dzE0dWV0QU9Bdy9QdVZzcGFmczlhcFZEME0xS3JNWkI0?=
 =?utf-8?B?b3QxWm44aUd0TjJLd0JhMDFBaVlVQ3doK1AvcE41VG0vVTYwTElPN3NnQmtN?=
 =?utf-8?B?Q1BxQUswZDR5WGE2NEJLT3o5bytBcVpBdlZPeG1tTEJLZ2hLWmRtbzdHWVpD?=
 =?utf-8?B?QlEvMUJqdHBqUHlKWWJFc0RVZ2RlZFZkR0pPdlVxdFdrOVRSTkQ1N3loYlVz?=
 =?utf-8?B?ZGJaUW1TNis3cVdTNzZwcW56OEJzb29NNWlPSnBXRk1wcTFRMkNacXdnZjNo?=
 =?utf-8?B?QlRtTzhxTDRhcjVKM1lIMmttbGIwWWtCZGRVU3lhV01SZkd1c2dIbmlicjlL?=
 =?utf-8?B?TFJRWFRLcG9KZ0VxM2NaYzJQcit4ODk2bWt4c0VEblNGbGo0LzlXbzMyU29h?=
 =?utf-8?B?ZndhRzlubkFQa1RjU1hOSXhlSWFudUo1UzJPYWJhS1dndUpEU1Y0STNmTnFO?=
 =?utf-8?B?eEtkZ21uSWhyT1d3eGQxM2lyeUtjdkZPL2tPbGFtRnk3Vk1VZVMyS3FkSloz?=
 =?utf-8?B?bXJwUlpkZCtJM1RzK0pXQTBIM3J5R1BEUnVwdlZoZnJLdFdyMVpKeDIzdU5p?=
 =?utf-8?B?UXYwWi92R1ZndlFiL1lCU3FPR3hScXFQcG1UdGZmZEY3WHU5MDRMS09lMGRv?=
 =?utf-8?B?TUlIN3BUdStEVjcrT1NySXJqZ0lpbnB4VGZxakU5M0tlbzFWWThWeXdERk5w?=
 =?utf-8?B?cWM1UE5SRmptVS9DUmxiV1lKcjVWM3VzaXNFdHE1dENwakFwQU9rWWhVTSsr?=
 =?utf-8?B?a2IvbjBzUW1YVTBseHEzZE1yZUdzb3E4SDdrMFZ4VjN6NFRuRmE4bzhXQ09Y?=
 =?utf-8?B?a0t6b0YxVzhaWjdWQlVoTjBTeWxwZWlGTlNYeFVOVkVVN0YwWis1WnFYUUkv?=
 =?utf-8?B?OXd5b2g0eTJsb0J3MHFxWHFWaTZCSUdSb2FhYkNVOHAzaTRsc215L2U5SXpB?=
 =?utf-8?B?cEcrMmw2clpZcVVMcnhTOG1vVU9Fb0xUUVF5TXpndm1pcGg2VndRWDVaSnhS?=
 =?utf-8?B?VjZqM2hmS3drWHFMaHVXKyt5a1A4MXBqWXJTZlI3Q05XUFhzY1d1NFpxRjVB?=
 =?utf-8?B?N0lZQ082SnNoUjlndGhrODVnR1g2b2MvSFVpYTZQVktlMU12a2JoR0xLMVZI?=
 =?utf-8?B?NjFlMnlmTmRHVEVpcDRscWNqUmxwMFB2Nlo4NnA5RGZ2THN3YjJISENqd0kv?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uB+pRSe5mtcU8sPSn9ki6UgXwDmhlaTO0uVotX08upr25bvVIGPrZQ/eiSyJCZrZ4efzz7kDU3YyutIsM0NCeTrAvOI1Bpz46GmyxlYI3slS9c8U0YpTb7v7uK09zsxv3BB3Hhj8c/XANjXXP9ZomyZNL4ct92Ru5BgTYV0G20GW4FHQDIpseILWpL8zA0F1zOEx7364kAmvGyU/MT/ZY8MiFowzNdcLy3/xS7SEnj/xNvPGsdV4m8019NIQ79Fqj8892QW6/yAZjQXo98n4TmMOceQrRkHf/dZ885eacHnLpxlXZg6JXjHOukjTFQpU1UGDj6R6u2aq6FJNhuERz40OYjDWvux4wL9Iw7OmVGD1GmJuPTfSi0phQ522XevtzSg0KVgNbCgUDKXvB5hRgrC98SXgBpVJbEhEhjP/XD3qJc5FYk7ld0H0+vIGWsiuJDOyYmQiKeOfrS2sWOxH7If23xxdlLb2tSC86YAWWDWvZPBNRBM3VvsNF7/lIuLLD8wfpD0BHrwG9+PtWPEuuz1wG0Z1IF/sqt7V8idTLgC5/o8wGr588PZwUZ4ngiTydV4JZyBxhGxRYTVp+A1wwa5uQKclquozEvI4OMwoOHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a5e81c-0f4a-448b-3dc4-08dd50357136
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:01:02.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmTfflRkaMQDCQXUZbfWqofmLJVCgXwpYid2vQv3u4UZybMsNhkwIFzMJ2d7bfNBJjPzZdvFCsepacOXe/EaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180116
X-Proofpoint-GUID: 88l7VrBE1Boq88e0vFj7pym2uQ2IA7tz
X-Proofpoint-ORIG-GUID: 88l7VrBE1Boq88e0vFj7pym2uQ2IA7tz

On 2/18/25 10:51 AM, Jeff Layton wrote:
> On Tue, 2025-02-18 at 10:02 -0500, Chuck Lever wrote:
>> On 2/18/25 9:40 AM, Jeff Layton wrote:
>>> On Tue, 2025-02-18 at 09:31 -0500, Chuck Lever wrote:
>>>> On 2/18/25 9:29 AM, Jeff Layton wrote:
>>>>> On Tue, 2025-02-18 at 08:58 -0500, Jeff Layton wrote:
>>>>>> On Tue, 2025-02-18 at 21:54 +0800, Li Lingfeng wrote:
>>>>>>> In nfsd4_run_cb, cl_cb_inflight is increased before attempting to queue
>>>>>>> cb_work to callback_wq. This count can be decreased in three situations:
>>>>>>> 1) If queuing fails in nfsd4_run_cb, the count will be decremented
>>>>>>> accordingly.
>>>>>>> 2) After cb_work is running, the count is decreased in the exception
>>>>>>> branch of nfsd4_run_cb_work via nfsd41_destroy_cb.
>>>>>>> 3) The count is decreased in the release callback of rpc_task — either
>>>>>>> directly calling nfsd41_cb_inflight_end in nfsd4_cb_probe_release, or
>>>>>>> calling nfsd41_destroy_cb in 	.
>>>>>>>
>>>>>>> However, in nfsd4_cb_release, if the current cb_work needs to restart, the
>>>>>>> count will not be decreased, with the expectation that it will be reduced
>>>>>>> once cb_work is running.
>>>>>>> If queuing fails here, then the count will leak, ultimately causing the
>>>>>>> nfsd service to be unable to exit as shown below:
>>>>>>> [root@nfs_test2 ~]# cat /proc/2271/stack
>>>>>>> [<0>] nfsd4_shutdown_callback+0x22b/0x290
>>>>>>> [<0>] __destroy_client+0x3cd/0x5c0
>>>>>>> [<0>] nfs4_state_destroy_net+0xd2/0x330
>>>>>>> [<0>] nfs4_state_shutdown_net+0x2ad/0x410
>>>>>>> [<0>] nfsd_shutdown_net+0xb7/0x250
>>>>>>> [<0>] nfsd_last_thread+0x15f/0x2a0
>>>>>>> [<0>] nfsd_svc+0x388/0x3f0
>>>>>>> [<0>] write_threads+0x17e/0x2b0
>>>>>>> [<0>] nfsctl_transaction_write+0x91/0xf0
>>>>>>> [<0>] vfs_write+0x1c4/0x750
>>>>>>> [<0>] ksys_write+0xcb/0x170
>>>>>>> [<0>] do_syscall_64+0x70/0x120
>>>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>>>>>> [root@nfs_test2 ~]#
>>>>>>>
>>>>>>> Fix this by decreasing cl_cb_inflight if the restart fails.
>>>>>>>
>>>>>>> Fixes: cba5f62b1830 ("nfsd: fix callback restarts")
>>>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>>> ---
>>>>>>>  fs/nfsd/nfs4callback.c | 10 +++++++---
>>>>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>> index 484077200c5d..8a7d24efdd08 100644
>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>> @@ -1459,12 +1459,16 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
>>>>>>>  static void nfsd4_cb_release(void *calldata)
>>>>>>>  {
>>>>>>>  	struct nfsd4_callback *cb = calldata;
>>>>>>> +	struct nfs4_client *clp = cb->cb_clp;
>>>>>>> +	int queued;
>>>>>>>  
>>>>>>>  	trace_nfsd_cb_rpc_release(cb->cb_clp);
>>>>>>>  
>>>>>>> -	if (cb->cb_need_restart)
>>>>>>> -		nfsd4_queue_cb(cb);
>>>>>>> -	else
>>>>>>> +	if (cb->cb_need_restart) {
>>>>>>> +		queued = nfsd4_queue_cb(cb);
>>>>>>> +		if (!queued)
>>>>>>> +			nfsd41_cb_inflight_end(clp);
>>>>>>> +	} else
>>>>>>>  		nfsd41_destroy_cb(cb);
>>>>>>>  
>>>>>>>  }
>>>>>>
>>>>>> Good catch!
>>>>>>
>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>>>
>>>>>
>>>>> Actually, I think this is not quite right. It's a bit more subtle than
>>>>> it first appears. The problem of course is that the callback workqueue
>>>>> jobs run in a different task than the RPC workqueue jobs, so they can
>>>>> race.
>>>>>
>>>>> cl_cb_inflight gets bumped when the callback is first queued, and only
>>>>> gets released in nfsd41_destroy_cb(). If it fails to be queued, it's
>>>>> because something else has queued the workqueue job in the meantime.
>>>>>
>>>>> There are two places that can occur: nfsd4_cb_release() and
>>>>> nfsd4_run_cb(). Since this is occurring in nfsd4_cb_release(), the only
>>>>> other option is that something raced in and queued it via
>>>>> nfsd4_run_cb().
>>>>
>>>> What would be the "something" that raced in?
>>>>
>>>
>>> I think we may be able to get there via multiple __break_lease() calls
>>> on the same layout or delegation. That could mean multiple calls to the
>>> ->lm_break operation on the same object.
>>
>> Makes sense.
>>
>> Out of curiosity, what would be the complexity/performance cost of
>> serializing the lm_break calls, or having each lm_break call register
>> an interest in the CB_RECALL callback? Maybe not worth it.
>>
> 
> I'd probably resist trying to put that logic in generic code.

Hrm, I consider the callback code itself as generic, since all callback
operations use it. It makes sense for example to specifically constrain
the number of CB_RECALLs on a single inode to one.


> I think
> for now I'd rather just add this logic in the nfsd4_callback handling.

Fair enough. Let's see a specific change proposal before letting our
imaginations run wild. ;-)


> Longer term, I'm wondering if we really need the callback workqueue at
> all. It basically exists to just queue async RPC jobs (which are
> themselves workqueue tasks). Maybe it'd be simpler to just queue the
> RPC tasks directly at the points where we call nfsd4_run_cb() today?

The workqueue is single-threaded, so it serializes access to various
data structures, and prevents multiple concurrent attempts to start or
shutdown a backchannel. The WQ can be removed, but only after
alternative serialization has been added. Not impossible, but not a
dev priority either.


> That's a bit more of an overhaul though, particularly in the callback
> channel probing codepath.
> 
>>
>>>>> That will have incremented cl_cb_inflight() an extra
>>>>> time and so your patch will make sense for that.
>>>>>
>>>>> Unfortunately, the slot may leak in that case if nothing released it
>>>>> earlier. I think this probably needs to call nfsd41_destroy_cb() if the
>>>>> job can't be queued. That might, however, race with the callback
>>>>> workqueue job running.
>>>>>
>>>>> I think we might need to consider adding some sort of "this callback is
>>>>> running" atomic flag: do a test_and_set on the flag in nfsd4_run_cb()
>>>>> and only queue the workqueue job if that comes back false. Then, we can
>>>>> clear the bit in nfsd41_destroy_cb().
>>>>>
>>>>> That should ensure that you never fail to queue the workqueue job from
>>>>> nfsd4_cb_release().
>>>>>
>>>>> Thoughts?
>>>>
>>>>
>>>
>>
>>
> 


-- 
Chuck Lever

