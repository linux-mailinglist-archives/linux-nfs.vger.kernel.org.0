Return-Path: <linux-nfs+bounces-9940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18358A2C647
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 15:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911D33AB387
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF6238D2F;
	Fri,  7 Feb 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IJZUklSL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tIRJKzQq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC3238D27
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939967; cv=fail; b=c7VHq130d31yPV1zczXKVjlPylFVavzGD9RZiK5WN1O4+CPdvApGZnEwrwIQLu2VIbz6ir+xp2pma4Gv1JP1JReaGEYg2fbCJgBoUjfU0grpl8tt9KICw2kgCa545u3chPG163rskvrKVYoCjIhoGrtggWIXYPSltAF+pZfnrtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939967; c=relaxed/simple;
	bh=rnh4uPKciWbQuOQyyawlIZOWeFTuK3Rh7ZHWGCFDVYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pzyd5XW5tNuOUkA0DgRgamxtFZTw3d8WmrA8ROLWoSsluzPG7t5+6VJvd8Hjn0jpVl00NpnhiZVLrowLZ4RZHzGmtjPhrvvOgnzoHQXFks/D72OVYlkMD7eaLTGdhdZq31KhzTfv5yasWT/hxW4fY/PURbchMExNDoM69jdSUPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IJZUklSL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tIRJKzQq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517EpDxL017631;
	Fri, 7 Feb 2025 14:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oRIVFWYGwKYOZO1sawR62AhdsesRlZ6TfISWXDojzW8=; b=
	IJZUklSLz/X+S2kYEpZjJpBAo3PXddCzro4s1THJjPxp0v/0NQ2uc+7W0fFCryII
	7Jfyjmc1OvWfFFwbdUNkTc5xwzwDWZowdCIXoElWLjgQbu0F5hcuqxULfgGs+75p
	nZW9A+0vlir+R54O1L8YsEo9Pa3Rg3l3BIrQ9oz8DIES9q32FifDORgbIX7G2CB0
	+ET3s7dKdbwC/+2FzTeEXmAoZ9oZFJn9COeqPrBmvakoDQ43EarfB4L9Vs4ciB+e
	cBhGthJksjKlI4Zls1W9aDnWhCNbjDFEawOjRrxBRP1we8tYRusnCXMyopxphJp1
	tX1R+4jHUw4KXZk3XKb2JQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtkkw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 14:52:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517EVMxE022619;
	Fri, 7 Feb 2025 14:52:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ebyqsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 14:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRn+CQF7iPqPF7gNoEw50ZjlbvlbPorgJS4hv7dGkP4RgO2Aihe/ucA72Vz2Sq2DrUtXAPGP/STUcB8eYDz64DrnXu9w6i28Nv4MYJJ1JR8X+LA6HwQL8BM3LTzDQ+GCLnyo6/ZxlLQUCljFlA/HP2+8YQzaKMnX2VDhb1DPbD5NEx6sk/0ZNMm5d02rxmkOjtl2fnhefkf5S725fJQ5JQIBPnCVQewM5GC80eh4vA21BWjUhn8ZjbZHMVAuQI/Zc9RvlEOyuN/4Sz+pz2VMQ/Q0Y11RNGNTSnyTi38fILh8zHBaEDkm6kKAGQ3681+9qkti1StH/0Z2MwoG4AF2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRIVFWYGwKYOZO1sawR62AhdsesRlZ6TfISWXDojzW8=;
 b=dazdMiEv4tOGYt8bxWv/dtuXZ20cKuyW87iZF1ABAPd6fvz2DjMId3UwJ+9AFUehQQYb57Ow1Nb/Vr4U5+b2y1x6pxWptaxAune0Thd0p51BTFKKJo4K+66iGMXMPKJxRooY3AzLiR4aUSFaJWvHAjwOwG32inthUYMGbPXEHcARLPUaqrrmPb29lyDnZZJMrqRRlhOzKqaa3+zamQykTbUpyhwsq480HH4mENTQ+7DWWDgo1yzKye2OsgzRTtXgQnBdlji+YEc0DcDysqPNsKo769K+SQ9N9hmXZSYYjgYcSO86DA9HujlcWc+nQiNV90pV5NDCTkAkiotEHILBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRIVFWYGwKYOZO1sawR62AhdsesRlZ6TfISWXDojzW8=;
 b=tIRJKzQq6rkjUQuIhY8GPh7RuFWdiCNiOVjgh1xNwEnrTetuCsVui6J7O5uL5JiAA9pgjTzZov4ZB0qWsCAnU8BVvbaCn3JNqC09aB/3rsL0Vp3KR3IaCogLZpoLCcygetWgWtVG2nGSRYX8m02lEKQcjaGCn63yPR9G1Oo0vJQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 14:52:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:52:20 +0000
Message-ID: <9340215f-9c4d-490c-acc8-0450862a99e1@oracle.com>
Date: Fri, 7 Feb 2025 09:52:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Dave Chinner <david@fromorbit.com>
References: <20250207051701.3467505-1-neilb@suse.de>
 <20250207051701.3467505-5-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207051701.3467505-5-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:610:4d::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: f19f7fd1-91da-47f0-db5f-08dd478705e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3JHK3pEUGhYdnhCTTlTRzhQb1NGYW9qMnExNHNtc0VCT0E0TU80YjlRYWp2?=
 =?utf-8?B?NE5Yb0ljeU9rTUtUeUZYL1p1eG1YVHZRcUMraDVqUWlMS1ZFc1U1dGY1TjFl?=
 =?utf-8?B?dm9xc0l0UTRTWXk2OVUrbUY0WlBoQlJnekpuVkJ0aVNIRk5PM0FXNzdoSW5R?=
 =?utf-8?B?R2ZZSEIrVkFLTHM1RTZUaTFpY3U3LzRyc0lQUFFFeWo5M283dmtkZlUrNzQw?=
 =?utf-8?B?NHRTdEtIUXpNTm5jREt6c1dheUFYMWYzSmZURWM4dmg4cGFsOXV1azF2ckY3?=
 =?utf-8?B?Z3VVdXo5R1dEV2tEWlkzSXZzSktZeFNtWHZEdGR4dS9xWEtsN0YwK1lVUHh4?=
 =?utf-8?B?RHNPcmRoT0FGbGdGU3lISkhGcVhLUkt0b0w1Q2hmWi80d0xHRmVxWkdEKzd1?=
 =?utf-8?B?Vk9LSWFPdy9mSlp4UzUvUkpBREpFc0c5SkM4NkRHMVFJMktPYUFLRWFSVmFk?=
 =?utf-8?B?anJUdnFyMUdXdmliUzZoVVZPR3hVRFlMdWR2VGNkditQRE5pa3hBVmk0dFNp?=
 =?utf-8?B?TFZwdUMrR3I1UG85TlVRL1NMMzRnckw5Yi82MkZjWXlycGFnOEswSVduODRl?=
 =?utf-8?B?K0I5eFhkSDBOSVpoc0M4QXJQbnoxbExiVzViK0VZRGkyTlhvbjZYN2JLUzVY?=
 =?utf-8?B?a3ZBenlOdW1VY1QyYWt5S1MzQzlFRk1Vdkg2Y3lsWU9CMnM5NENnb0E2SXlO?=
 =?utf-8?B?V0E4VTZEL1pDQ1JIZzIxMlhHYnc5Q2paZCs3NmE3d0VKbFhwZDJLVXhSRXl3?=
 =?utf-8?B?SUVmZyszYko2T01wb2hxNXN5ZCtWUllka3hmQzhxbW1EamFEVTJyN2FGRERV?=
 =?utf-8?B?Z0NZSWJGeHdxTXF0eTZVT2FkTTc4SGg2WW5QUS9NTzNLVzIvMndEalp1VXJh?=
 =?utf-8?B?cXd3QzI0Yk9naFZyV250WHlnUzJaOWxNT0VqMTVPS2RjYi9Vd3VPUkFrck1X?=
 =?utf-8?B?OWtjcHJvNzQ2U2lkWFZnMCtLYWdZYVFzMW14MnFSM0NETWN4ZHdjQUNwL2xS?=
 =?utf-8?B?dFQwc2IzUUt3WWN4aDFGcjhGdkRaMHJ5ek5LdlQ2UVdXblljSUdVNjNKMk1Q?=
 =?utf-8?B?ZE1RS2lKZzVJT1ZTRWFZbVdyRnZGa1oxVThHL2VYQVNTTGEwQ1hsakcvajUz?=
 =?utf-8?B?cGJxWjl4aHZxNnllNi9DVlVlN1pTR1lESkJRaGNLSXJPMDhHTmFpcWJ5WlBx?=
 =?utf-8?B?cFpQNUg5WE5XaGc1czVvQzJzMDdIclVKN0QxTUtUNHhMdThQSVo3TmpzQ0hi?=
 =?utf-8?B?YnVnMDMwc3lYSlBNV1FxUjBkb3pwcm9nU3hVRitEc2FGd0YxLzEzZCs3L3J1?=
 =?utf-8?B?MytuRzdoSWEwZ21VQWt5N2lacTBjTExuNnRSRnI1bW9JUm1FdGJEamJrR3hC?=
 =?utf-8?B?ZnFVcjkzV2p3NXFBcEJBUXJJM1RRYjVTcndMRHVUWmtRQVNJRGRPOHdLV1hZ?=
 =?utf-8?B?dDU5YXlYZThhNndraFZUQ0c3aGpCTnFsU3U2Ym5TN2VLY2dlR2liZ1R1Q0R3?=
 =?utf-8?B?NlZvcHRObjdTWXlEd2ZLRFZuVzBkSVI1bVk0RzlVdDFkUjl2VU5idExBaVZK?=
 =?utf-8?B?RU9VUEhWQWRIalhUb255dVc2YTlsSjdONGRYVXdDMVNXeTRJQ2tyY1pUMFhO?=
 =?utf-8?B?RC9aZWh1NDFoZnNMMVBDRTdsUmJha3lPblExZHJlcDZZNSt6YjR2S3lyZE5L?=
 =?utf-8?B?K2xxNC84a3l6V0N6UTNDUHNNMExjTllWZ01La01YTW1lSWJCS1dVVi8ySDhv?=
 =?utf-8?B?Z2dCbzhNZyszQzEzVDR0eVFubTV2ZG8xdUZ4UDdlOXExUnU2MEVLdzFhbU5J?=
 =?utf-8?B?dTVWVjF0eWxPSmtnbHVUL3JRRU9PSFRLV2VRNUpISG5MSE12UEgyMWxXMG8r?=
 =?utf-8?Q?xDkRFsbSJpryS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHRwVGt4SWMrSHFvZTVXUXJDeDB6b0JYSDNwa2doTkhMY3JUS0wxcFR3SUI4?=
 =?utf-8?B?UkVXNm1CYm9vMkpmaVVWSGE4VjJkdzQ5L2t4WEtWR0NhK0tvN2lTVG1KVGZS?=
 =?utf-8?B?VHNmK1JBUjJGSFBOOEhkdWJBZVY3UW5GQ3AyVXordVRoUUlLSFIydHJRM0ND?=
 =?utf-8?B?VHpOWFZ2WUVjdG5YRnFzMFpLcUhNQnlkbzRrNUR3cTl4ZXVyTWZEa3lPZkVH?=
 =?utf-8?B?a1AxeW1tNGFxUWljZXZFTGpWT2Q5YkFxSTlSdGxDVFlLczRvNXB3NUdILzRk?=
 =?utf-8?B?UjFBK2RsSFVwVld4MmR6b0VhRVRQTjhEeCthWXZHZlkvbTRPVWRwV3dtWUlW?=
 =?utf-8?B?eXBWNFlNSHVEcU9nMlNMUENEQzZ3NjNwTTFuUjh5WlRsLzI2QTYrcXhUS1Vz?=
 =?utf-8?B?Ni9HcFlwcFMzL0tNdngyL1NrbG1VY2JxRVZsODhMWkZxNVhublpOOXZLS05t?=
 =?utf-8?B?N0p0VzhNOXhxbU9jOFFGeXVkZllYaVA5MS9Za1ArNzVzM1h6RWNtVUQ2TnQ5?=
 =?utf-8?B?aXYwZ0VDM21xMUxNTjRSN1BBVGJBSU9XM3R3YitHUXhXTFlOYzh5VG1XakNY?=
 =?utf-8?B?c3BoWjJRT0RFNEZuMjczL2Y1VFlwTHV2eTlHT3hockU3OWtaalM2cHV3ZnAy?=
 =?utf-8?B?cmtCSzB5QlhkUlk1aHpPSW82Mm01OGVtYjNnUzhoWFhvcys4aWp4MVNJajBz?=
 =?utf-8?B?MkgzVmk2SmdtUHUwTnE4OVk1M2JkdHVzemNrOEFUcXZCTTN1ZkR0MDEwd1VY?=
 =?utf-8?B?TzlSUHo1bU1DTjRpckdlZnhYVzY3c0xYckRPUE5jU01WYUtRQzByNDRZQ2dv?=
 =?utf-8?B?SXlrZm1TSk03R3kzZzZJUWpyL0RzQTc3Nml4SlNpc0d1Zm02RWRBeGl4V2dB?=
 =?utf-8?B?b0hPWHNFSURuQlphVTVORWY2WjdhbmFEemtxV1hoWW1yeFA3MFNrQzA2a3BH?=
 =?utf-8?B?WFdhQnRySVlHSHZOdTY3ZHk4OTJERTAzRktGVlQvKzVLelBZRTBjd1lwcjRk?=
 =?utf-8?B?d2J5TTF0L1cxWG1uK1JPZVA3NStwWFR5QVhubi96ZVhocyt1OEV3aE5WL1BZ?=
 =?utf-8?B?Njh3cStUQWtkcEZlZ1Jsckd1OWhLUDFTQlorM0pibmpCN0oxU284M2JtbEJr?=
 =?utf-8?B?MGN0UHpQT3NTZjFwZ3U2bWxvb2xFMGtPSGdBSG5ZaVg0RWVjTjJkNVdZZjFk?=
 =?utf-8?B?Wkd5aG44eFJ4SHBtSHRGcDRNaStGa3ozUytydmJ1cE9zcmNpZVZaWEdrSVIy?=
 =?utf-8?B?TkQ2V3FtSlArOTBWeW0rTFdJWWR3L3psWkNJcTVraXZZc0NMdGtpNGhUTXd2?=
 =?utf-8?B?UzVKTk1Nd1dPd05zb0xNRXNDaE5lZjFwdDZ3TzJ3QThaaW9vVzFvbGNhUU1E?=
 =?utf-8?B?dWdNUUttaHQ0dW5aajEvbXJSbjRYNnFRbU9nang2T3FkbmZsRWVKYlY5UjJo?=
 =?utf-8?B?eTB2SUhpOTc5V3FYZkFqeWVJVmtrQkgvc1Z5RUNubjhMelo5ZjFDNUZTQVcy?=
 =?utf-8?B?TE5KcUlQMmswT2ZKTkF0QUcyaWt2RldZcHpiSkF6QXFLOHd1aXprT3VDUndu?=
 =?utf-8?B?dUdPUGxPZDNTVTlWNjRmdXprN3ZoQ1pwamRlL2dxdnUwSGRYaWZhMXduTFd6?=
 =?utf-8?B?NzRqR3RVUmowUVVpSkM3VXkyTHFlMXlkc0U4aEN1OGxncmdMN0ZaWkhIcENM?=
 =?utf-8?B?QktoZjF3RW5hTHBaSFhNSEdySXI5RnRHYjhPQnExb2pnNnZZQzhpMCt2ZWZq?=
 =?utf-8?B?SlhDSVZNdFpwUGhvNFRyck9RWlE1K0NHWmhVNVp3Nk9ncG5URklDWGFnbWF2?=
 =?utf-8?B?eGJ3YkVCWGNhUTA2T1YzSlBwVmk5LytFVUREdzNLa3Q4TXQ3ckFIZDdYT1lJ?=
 =?utf-8?B?bXBFbFQ3ZVhSeVV6L0FQV0FhQ05aMDhUeENHSUlpZ3N2aGxPTW1qWGUxaW1u?=
 =?utf-8?B?d3FDQkVvdzdDaUNvYk41QmY3WURsOUl6UEwxNW9URzBOa1BiN1hmN1BIUXln?=
 =?utf-8?B?RDBCZkptWW91ZHRrRzE1UVh3MU1RQ1MrUkh3MmNkRUVGZ2lWTy9DWG1TT2l5?=
 =?utf-8?B?Wi94UjJ4a245M3puTEFZT0I4SmlZQ0lJb21uUnZXbXhDVXdhRnhydlBPU0s4?=
 =?utf-8?B?OFBUWmRQMTBhN1VWKzlmcjVQQ2xIcTd3d05aaFlveGRpMHNFQnNNcGx3MTA3?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PGlaMBKYOJR0zz8kP6o895xCx6cZ7SaESoIdFPysdIHIdlJGQvrGRegXXZih8LwN2FPH0/EuVK92DEIY56N7TQj8Jq9pljxWir8Xa39BJJNiE5dcs49sqGeTFvK8HR8xGwegtYhq+ZKPjHUde8fW7Gbu/bU2nHyKv2EiBXNCVa4LCvXnqCnChQ0OCoHy95AOV2uIjCcFFlVrjzyKdNfVoA8JvCuLjHvWzvMx2yncjN5GmeJ8pLaLiY4uJPJ/00HZoBjaBz7RLgVlh5W9IZ5p/OnT6KlGk+QOBHkTkPJd/7duWiMFlLuzFbQtKKEzTq2nUqSDkigimT5r04SySv3aMsF+fE1pJxQm57pZWTCC5/2iZFLmbKxXLTstWnRWmjeyGd1I/hivVPLT6rliKIlfYf34cJoxxo9E/fGgWtzMq1u2t/UKmpydi/qUUeVRa1gW/0y6A0ZDGd2u3xTOBm3GBDlJID3tLHuAQ1QIXlxF9hl09C8YNoOVjOYpZdT5DpE+j14PIW3F6qb6FW/wDNiQcsiOuKOhTZcaPUWeTC0/kIuBZBffQuwzOGC3CmUqlPNYEOlBPwF4LcmetSSK8GIix5PVOGitzooMngbbEGKoNSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19f7fd1-91da-47f0-db5f-08dd478705e9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:52:20.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te+O1nzbQabf1cONMBOHzC/7mcIwpzEOudwhscmqzwJxwWMhwcsIplBAfNdgoG9ic2amc4ovURNJnM3ulwGmfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502070113
X-Proofpoint-GUID: hJWnVXe09dozemmQSCyrIoHHOQ0jBr6W
X-Proofpoint-ORIG-GUID: hJWnVXe09dozemmQSCyrIoHHOQ0jBr6W

On 2/7/25 12:15 AM, NeilBrown wrote:
> The filecache lru is walked in 2 circumstances for 2 different reasons.
> 
> 1/ When called from the shrinker we want to discard the first few
>    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
>    because they should really be at the end of the LRU as they have been
>    referenced recently.  So those ones are ROTATED.
> 
> 2/ When called from the nfsd_file_gc() timer function we want to discard
>    anything that hasn't been used since before the previous call, and
>    mark everything else as unused at this point in time.
> 
> Using the same flag for both of these can result in some unexpected
> outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
> nfsd_file_gc() will think the file hasn't been used in a while, while
> really it has.
> 
> I think it is easier to reason about the behaviour if we instead have
> two flags.
> 
>  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, please
>      put it there when convenient"
>  NFSD_FILE_RECENT means "this has been used recently - since the last
>      run of nfsd_file_gc()
> 
> When either caller finds an NFSD_FILE_REFERENCED entry, that entry
> should be moved to the end of the LRU and the flag cleared.  This can
> safely happen at any time.  The actual order on the lru might not be
> strictly least-recently-used, but that is normal for linux lrus.
> 
> The shrinker callback can ignore the "recent" flag.  If it ends up
> freeing something that is "recent" that simply means that memory
> pressure is sufficient to limit the acceptable cache age to less than
> the nfsd_file_gc frequency.
> 
> The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
> free everything that doesn't have this flag set, and should clear the
> flag on everything else.  When it clears the flag it is convenient to
> clear the "REFERENCED" flag and move to the end of the LRU too.
> 
> With this, calls from the shrinker do not prematurely age files.  It
> will focus only on freeing those that are least recently used.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
>  fs/nfsd/filecache.h |  1 +
>  fs/nfsd/trace.h     |  3 +++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 04588c03bdfe..9faf469354a5 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
>  
> -
>  static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
>  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_add(nf);
>  		return true;
> @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>  	return LRU_REMOVED;
>  }
>  
> +static enum lru_status
> +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
> +		 void *arg)
> +{
> +	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
> +
> +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
> +		/* "REFERENCED" really means "should be at the end of the LRU.
> +		 * As we are putting it there we can clear the flag
> +		 */
> +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> +		trace_nfsd_file_gc_aged(nf);
> +		return LRU_ROTATE;
> +	}
> +	return nfsd_file_lru_cb(item, lru, arg);
> +}
> +
>  static void
>  nfsd_file_gc(void)
>  {
> @@ -537,7 +554,7 @@ nfsd_file_gc(void)
>  
>  	for_each_node_state(nid, N_NORMAL_MEMORY) {
>  		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
> -		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
> +		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
>  					  &dispose, &nr);
>  	}
>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index d5db6b34ba30..de5b8aa7fcb0 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -38,6 +38,7 @@ struct nfsd_file {
>  #define NFSD_FILE_PENDING	(1)
>  #define NFSD_FILE_REFERENCED	(2)
>  #define NFSD_FILE_GC		(3)
> +#define NFSD_FILE_RECENT	(4)
>  	unsigned long		nf_flags;
>  	refcount_t		nf_ref;
>  	unsigned char		nf_may;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index ad2c0c432d08..9af723eeb2b0 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
>  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
> +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
>  		{ 1 << NFSD_FILE_GC,		"GC" })
>  
>  DECLARE_EVENT_CLASS(nfsd_file_class,
> @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
> +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
>  
>  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
> @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
>  	TP_ARGS(removed, remaining))
>  
>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
> +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
>  
>  TRACE_EVENT(nfsd_file_close,

The other patches in this series look like solid improvements. This one
could be as well, but it will take me some time to understand it.

I am generally in favor of replacing the logic that removes and adds
these items with a single atomic bitop, and I'm happy to see NFSD stick
with the use of an existing LRU facility while documenting its unique
requirements ("nfsd_file_gc_aged" and so on).

I would still prefer the backport to be lighter -- looks like the key
changes are 3/6 and 6/6. Is there any chance the series can be
reorganized to facilitate backporting? I have to ask, and the answer
might be "no", I realize.


-- 
Chuck Lever

