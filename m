Return-Path: <linux-nfs+bounces-9633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D1A1CD5F
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 19:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E9D188617C
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A434644E;
	Sun, 26 Jan 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RiyOe0L9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eYH6zkSc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8839A59;
	Sun, 26 Jan 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737914610; cv=fail; b=oXyt2dfYub5xHinRLZQjmnYEfom0y5+cOyyGH/0+xNkrsqab2PMv8HArrqaTBX0syBQXrA0RmcXNiBIm5gfrSY4sbXidcsjoRxwXwaDcCmmpkSLTIwOF9kYk2Ybd9Z2Kru3fnhnxtjSjc4Rxmwu9OWjjkVzPdLLO/hAWCeXDnZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737914610; c=relaxed/simple;
	bh=jQv2V0mRUU/ehxIjjlORn9Bl+JDAitOOmF3vIUI9OFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QRlkYSDi3Ari+BJTlv6Ffk3sZyNlF72iieQ2NvwEw6Eqbw0h2mVNuw+/ABC3PiUAbmCZW42+CueuTjOtyYIeR/2DctBTEs1NBcTV7pCxqFfYgLx/HkNvOgFRxr7cj/iHSRZ7xrFYxV60GFU8Aui8Nl5x6so4lqbNfOZo8Ddb8y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RiyOe0L9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eYH6zkSc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QHtgr4020868;
	Sun, 26 Jan 2025 18:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uGd6bXprBdefP3JOQEJU8TiM5HrMHGPwvlZAZWgnyu0=; b=
	RiyOe0L9CppZkydtKQdmarjYxPDvBNjFknB/R5Ne0o21O5238Oa8DMoWdhH97VNx
	wIFbDdIsbdJfWO88rG/HUfU+/r5dxIVafk0zSNuXV4ZTpygzx+2aV+ZGM1zzNqfy
	U1LpCpT4bb7hAEVUXtDL0pwvcMoh/wyDIP5DGvzFHWR9olU4S3Lxkyuhqa+l7wHg
	t77C1JBz0DCyv2NSkXzVTuuR4wl5V1Wg/uP2EjwRS31v6VDWCaDotfJoemUmHgV+
	9WvSTbvPmds56kFOO3U5kuP0fLOsCvMCgHjws48dBZSIErGdQOsaGKMiytXv6m/m
	bYABzhOTFBPIs/5worV3Aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cpva1gh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 18:02:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50QGL7Dj034283;
	Sun, 26 Jan 2025 18:02:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd67879-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 18:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZ0Ce1vEUAOrjtHflTbKSO2HCAkC6ZeqSaPaQ1vEd/fCa3gXKRFCG38hxN6X3AobPzk/mi0ZahRIouNB1R2B9yCDEfcDQMpaU+krHBcPBd6DTg9DFtdj5ZZrJFNH6l8TAyJEoa5RnS8MNq/SQL+sj5PwHuVgCtmFKKcd1WFaosNt/ba206XLY2xj2/qbXE37HCQzT0hYBMndCG1gbmCz2UmpE//CvlHWAFt0d/V1fVAxNABk2d36G4wmbOBHT1rcpAmKe9oPspsREdqeQCubI8pDUWF0vOeW1I+JyPHyhG2sUIVPpVyeGUXlj2FRxgfQcAzx5sNwge6ws84Y7c/4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGd6bXprBdefP3JOQEJU8TiM5HrMHGPwvlZAZWgnyu0=;
 b=sf3MzyXXr8zdpSetqKPC14TEkoiV6Fb1gOhmwOObdkIaOGf6MZsdvCxLr1A2af9Ni5ETd1qveQdUMfT6z68XONQfDAkfT7XDYJYV+blsHrX7cufQfVjmZt5LBobAAuymS2/CxKmyus6FMVeLv2Q1J1ydyCw/oiGFtIkBWD/XZ6p05gOLm3Gf3s+Yl/Lwti+Ajh9uYmdpx40kPeIgF+gw+Sut0foUusDeXVW1sKAjGUERWfzFsDxU0K7Kt5oMkC5C2vMhXDRnWSqdpuvzIOclaGR5W8tLuU821kznUQa02HGB6Hjg443dNeBR5qknjAOYnUvfn9EFzdtWAbv1cSOL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGd6bXprBdefP3JOQEJU8TiM5HrMHGPwvlZAZWgnyu0=;
 b=eYH6zkScx8IyfZ4uH+4PKC3g/issXz31Y0LSVJ2RukGo7p7sAJynlCaQvGX8I7u9AFQ0x9K1Ge7SKLlmglOBO/Wb1paHYy3UVtTa7kHLaxJCwLdBXGesiaqkwY7kyL6JM+nYklGIrk61Yuu7lgD+cNQwQL6dZ1BafnUnAejSHq0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 18:02:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 18:02:39 +0000
Message-ID: <c76d3a7d-9f79-4784-9695-3d1cecb495a9@oracle.com>
Date: Sun, 26 Jan 2025 13:02:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: clear acl_access/acl_default after releasing
 them
To: Rick Macklem <rick.macklem@gmail.com>,
        Li Lingfeng <lilingfeng3@huawei.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, Trond.Myklebust@netapp.com,
        zhangjian496@huawei.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com
References: <20250126094722.738358-1-lilingfeng3@huawei.com>
 <CAM5tNy5DfZ18qCSbAX8TnUd2z3DZS=XmY3ka7X5KKVLW1n-6ng@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy5DfZ18qCSbAX8TnUd2z3DZS=XmY3ka7X5KKVLW1n-6ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:610:77::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c51787-0055-4ae6-b4b6-08dd3e339f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE95MDdyZUloN05kakFvcU03ejJBay9iRG4wWjdCclFhbEdlS1FVT0RwSUxh?=
 =?utf-8?B?WFJhS2s2OFpRWkdxQkxxYVVkQUV4QlhacjB2djdEaVF6NTRaYVQ4aEwzUis4?=
 =?utf-8?B?OHg5cmtzL0U2dFRzZjhwYTV3bjZyTGdMWTBwRXR1OXFScG9hcTB2SzVnQ2xh?=
 =?utf-8?B?SjdyblZqdmQ4SG5SZWlvYWhVM2w5SE42TU1tZGtPVGNtMzEybFVPUHNDd3VL?=
 =?utf-8?B?WGpMMW9kZTNDeWZyb25WU20zT3J3SnovUTJPMmZSVXlGU3NJUzZMa1dDN3BZ?=
 =?utf-8?B?YWpSZjhmMzcxM1Iva2ZjajFoWldjNExWd3p5dWFKekhEdHQyZTBkbmw3dkcw?=
 =?utf-8?B?UnpWTmJiVXcxckw3WU1aRHJ1YXZVZ2YzaU16OC9BdGVVUGJpaTErWUNjRVNr?=
 =?utf-8?B?YzUzTllDd3ZGNytUY2xtajcveDhqbWRBMGo0M09iQ2w5aTBFMVhLOUxjNFEz?=
 =?utf-8?B?dzd1N1d1SjdEZ2FneFZleHp0cmxMZStSYVFVeFByWFJoblJDSFBhSXBveVdx?=
 =?utf-8?B?em0yS0lDcEcwQkcwdDhSaDN2ZHIrTStaVDhSWG5xM25nMEVNVktpdmEwMDMy?=
 =?utf-8?B?TUp5bVlMWmJEUzFDNlBjWVdUOEkvQzVlK09HZS9id25lL0Q2ZEU4N29HdEFT?=
 =?utf-8?B?ZDVyL3dsRzN6MmdmSGxQWnhOT3VSSkZ3a1BmVWRUVGVGY1dvQmVpUHh1NHE0?=
 =?utf-8?B?L2s0ai9IT0RISHBVbUlHTnJSd2o1WHVlWHBKMm1VaHJRa0hIdWNRYThKczdt?=
 =?utf-8?B?cVIzWmk3NjRBbnVFNFZXSVFLR0JSZXBkUGNVMzNYN1pNUEpBNkdlZWx1L080?=
 =?utf-8?B?UElSbjJvaVFMTGtTK1NNTENnenpFMzYvL2x6TkRMY0ppaVoxaUZEL1BJaU9n?=
 =?utf-8?B?YUpCSTF4TEt6YitGQ3F2dTM2U2xZNnBUR2s1MmsxRGY3bUdtcWdWVmVoLzIx?=
 =?utf-8?B?TDlnbFFjUlA0azRPM0VnL0hGYldSRHMwVTlmRVA4WXJIVmpvM2RiZ2hLRHl0?=
 =?utf-8?B?aHJMcW1rajJXeE5CdFFrcC95MWFrNGd3QXpEVklsUTlla0dFZDYrTzVhN1d4?=
 =?utf-8?B?VjM0WkkvTThBNmYrWktvdHhiWkpjalI4MDk1aXNEbVNMVDFaaktTUVEraGlC?=
 =?utf-8?B?YTUwUEtkTDgzamF3ODZhVDZLQTNIZjU0NEU5SzM5ZUNEeURkSlRSYnkxSFcv?=
 =?utf-8?B?bFdOWEc4NWhiUVl6MHpPckpVdHUyQlpPdlhpSDY3YmNoajBndk42azN4Q1pj?=
 =?utf-8?B?UDFMYzlnY084K2VCZXlOMjZ3WXMxa2dGZWNOaE9DaHVnMXhRdnphbUcwSi8x?=
 =?utf-8?B?a1hidmFaVmJTVzVubmhES2o3QzRSTTFyL1RSRXN6UitDN0o0SjJsaVpXbkpj?=
 =?utf-8?B?QmUxVWg4dktLaDdzV1VvdWgzSVAvd3o1U3ZSREZIOXdRMTJyUFdjLzNPTWJh?=
 =?utf-8?B?M1FRNDhaa0o4SmF4MnUzZk5XUFp3bkNxbi9CeUZoVmxXTkhib0RCYVpMWFNY?=
 =?utf-8?B?UGw0QUNRMVBpbXVtWklIY2pCTWlpVUhUYzFnQktoa3ZINnVMdmU1R2hqdlNt?=
 =?utf-8?B?enhCMXRMUHRWcGFHdkNUcXRiZWdhN0JYMzlSekVRb3dZWFZBaHJHa0RtalhX?=
 =?utf-8?B?RGZjQ2ZpNUxLNHBEd21VemJMWmJRMkRZSlF2UW1HdERkcXN1ZXhwOXJuRGNH?=
 =?utf-8?B?VG9jMU43N0pXVG5hYklmVzAzTExCZGpKd3BTL0FQcDF2SllNcE5rcXhHMWFa?=
 =?utf-8?B?YkwweDhzcWVjMXNCeGhZUUE1U0hQOWtUNC9GaWVoL1Nyck1ROEhuWGhOMGxV?=
 =?utf-8?B?RWp2dXVOVE1ocG1TMUhRUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmlPVXB6YXgzaUs5ZzVLNDBhRnc2b0RvdmNNLzN0aEdaMkVLTU1KUUVvb3E3?=
 =?utf-8?B?dEJ2bm9uU3VVR1R2MkRKa29sYmxPWGt2WHJYS2ZpQ0xDWGlmWU9US2xjUHdK?=
 =?utf-8?B?aEt4V1V4ZGVDTVE2dk45d1FCa0RiRzZnMEtBSC8rdHRCT3JPQXZXMFJQNXp2?=
 =?utf-8?B?Wm13c2hOVXdwQTJsc0RMVHFwQVVMZmtsaUl0V29qTjYyS2dpSTI4RERFcGZi?=
 =?utf-8?B?NFIzT1ptYVpLYlc1VWhjTnZCNERnTzVMTHk4a2FXYmgxRzE2RC9ZM1NPTVpL?=
 =?utf-8?B?NmNiamxUdU9tUGZrTGYwQmFHOWZFSzVLUmlxVjJ1c1JPWU9BdllJUFF6dWhk?=
 =?utf-8?B?YzAwbmRRZlV0eXErdlpPSUUydDJqMUxUbVdTNjVqU3Buc0E5YlpuSmtFZmVi?=
 =?utf-8?B?WG9lRzNNVWJ4L3RKbnJrWXJRU3dBVUxyMUJnRS9rKzczS09QL3pZYXpiWUxY?=
 =?utf-8?B?Q21zaTdCQ1dzUXZ2Y3dMZlhZdDlBNWkxeVZrcXpCazg1RWllaWtwRG0zNSt0?=
 =?utf-8?B?djhYbkxtZEdWZWE2VlVqbUg2NFB2ak5zTWdtSWRZNGhTM2hNMkt2VXVGUkla?=
 =?utf-8?B?SGxrM3VRTk5OOGNsSnBoT09kdGl5akN1bU1GK3F3N1RqbVZUMEVxdkdRMms5?=
 =?utf-8?B?VXRJRHhjVXhDMVh4emowdE5MUXAzZmo2dUhEdGJCSEMvQnpuVlNHYWg4bmNm?=
 =?utf-8?B?aDFuSmRwMW1tbnh2NG1va2NHVVE4aW5PYmV3eDlZUFF6eTU5ejRwN0RPbzZG?=
 =?utf-8?B?WFpvVkdBWUVSM2duNnV0MHFVZ0pGVWhicTlyS2NIcStsUUE5YVdhMkNlTXF5?=
 =?utf-8?B?cFJZeHI3aHdkekUrcnJGZjU2em5TV1pYV3JkY0dQUjFsc2xPaXpUbElPSCs0?=
 =?utf-8?B?VTZGQ2kzM1B1akdmL3dROHVLU3gzcm1YNzlQQ2RqMVlwMGFJVmJpOWpKYWFL?=
 =?utf-8?B?TG5WTWVTRlM0SzJydkYxakQxNldvV2FPSXZrS2xzWWxlQlRESVdzNmpSQ2Nv?=
 =?utf-8?B?ZmVQa0VSNDFHWnNkMGgyUGY4bjNpVS9GcUd5Tk9WcVJ1UE14SlJQUXhkZDRS?=
 =?utf-8?B?ZUNKa25Oc0c1SzlOK3dXMXVxQmY3V09SVWtvS2M1ZXIxcG9kR040Ung0WlVK?=
 =?utf-8?B?aW9QbFNiQWRXWEVMcUxrY0lzODJrRGdOSHBNTEFkY0wydlNjZ2lOcmtDZFBQ?=
 =?utf-8?B?UE55bWFLbWtPbDd1dnNMMFJWQzNTTXVJakFMU25RZVc5OXNTaUVnUVVaTFpW?=
 =?utf-8?B?bEhkV1VnV1FXSXlaSmtMVHFTVExNZWZkTDE5cEJxYmhIZHFoeGRtN3hxeWJT?=
 =?utf-8?B?UFdxRlEyK2tPVkVQWlV0anc2SG9EdTFjOXhaV0Z3RHQrUENHMXZMTExDaUFa?=
 =?utf-8?B?emdYVHVCaFJpVDgzc05oNnVSZjB4ZGsxdmNGTzVVVlR5aERsOTlRZXJQbExt?=
 =?utf-8?B?YVlPcjJoVWNYRVZwdU5IUlpYVEV0SVdyWFVETE1HRXlzTHRMMi9WUXkwUGkx?=
 =?utf-8?B?QUh1Rnl1TnZNdks3d2JtL21lSGVsVTg5Vk5WM2xzVVVma3JhakxMajM2YWpy?=
 =?utf-8?B?UnB4NVNuNHJoVTVodmhyNzdYNXNkQlBHNVRkaTNBVE1hOWN4VU5MWklRZUxI?=
 =?utf-8?B?UE9mb3RvbVpDa09heDBhUEhnRzBDRGpvOEgzRTQzeWVhYnlEaFB6UDBkTmgw?=
 =?utf-8?B?NkRrbWRrSDJnS3FaOHhXcHRvMk5peGZKeTJVdmRWK2dLTGdHZTZVUEppVmFF?=
 =?utf-8?B?dUVhUUtJdnpqZFJudHhsUWNmSSsrYTdqQ2NFeTA1amhnNUVneHNHNlpxK0Vl?=
 =?utf-8?B?cU5QdFdJRFdpZ0hoRm1iOWUvaEZoZ3RobVV4WWlCNXRxaFdlK1ViYVZqS2x6?=
 =?utf-8?B?OUlpTzV4WEYydFdORlo1SmZQN0FTWU1qV0NrSGNHMWJybHVOckZOc2szdGdR?=
 =?utf-8?B?OTRkNTZTRlN5TmJWdEJmZ0wwc0FXNGp0aU4xQVltbDJuK2Q4bmRNNWx4Tlk1?=
 =?utf-8?B?RU15OUQ3NUY2MS9XNHJONjB2aWdtMmtJTFhKOEJiOGV6WmE2L3c3MVdsUnpo?=
 =?utf-8?B?TTQ4UU1xUHM4czBFVnlCSUtIM1BEckl6S01SaWR5OHdDZXp3dUV6SnhKOW8w?=
 =?utf-8?B?SzdJUVpzbGs0OXAyRE44Yld4bUtIalhEblNGc3Y4dityci96dG9WS1o0eDJR?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8UdIEiCEeWz0uvw2OsQoelGMWav+9wweN3ixiTwg+MqUEYV+ch8ApTnoxxk6FNrhA7/EexCxSvI+rLdOXtenOR6TcU0cr8mQyFdpyhVEpENn7cyAKGNMaAHMvr3+R+vaJ6JyFklVHv5TkljTOPiWm11SDHTWmCIri2r7T6IWDwwhgwiK3PUJiB2pQKy3hF00PMkffUxNG6cvK+eDBCQs4OQHTdLvLXGNVeCIUdFRQ4PfcQPT0FbLBb0vZaxlCLu0aZQBS/oriccMZocHl0LYcAeDhRPeB4k/AdViMsomcxWaaA8k+4eQByqXowuHNkWV6FLDU4Qa1kQyDilM4PbQOOZQtURF/iR2N/YWxYbMXYE1+Q3fyC5EQId/pcH7mjJu/Bi4xN/g9M9iaEO9qUo/t1nqbn/aKyJLzkZ4dCBJ2zEC06SmI+V/FlHWmgxM3VqijW+hLNKTxzjxSPMzZaAuA+FtqquXaakcXsw0SmvvpkiJrIyMJm9uiPDMoiYeo3VNBEmgGS5HhXNNpZ8xolLxYZtMLARBwkBxUZBafYlcsgig8IspfnGrXSPdz1CtNg905FYMMuyPbrRYhW7PfrC3muGXK73hS3Y9YNLdOwQlscM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c51787-0055-4ae6-b4b6-08dd3e339f55
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 18:02:39.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfiPdwxl4cXsdZMX/EHEUHu3iF5Dz1hDzZvIS4PyXkqoOrE+eebgSIPyyFu7MezuCtcGeCo1h3ip/Yp1cj9s6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501260146
X-Proofpoint-ORIG-GUID: oI6CJFRCvbu6tZ872WbskB1yfH3AR1sY
X-Proofpoint-GUID: oI6CJFRCvbu6tZ872WbskB1yfH3AR1sY

On 1/26/25 8:51 AM, Rick Macklem wrote:
> On Sun, Jan 26, 2025 at 1:29 AM Li Lingfeng <lilingfeng3@huawei.com> wrote:
>>
>> If getting acl_default fails, acl_access and acl_default will be released
>> simultaneously. However, acl_access will still retain a pointer pointing
>> to the released posix_acl, which will trigger a WARNING in
>> nfs3svc_release_getacl like this:
>>
>> ------------[ cut here ]------------
>> refcount_t: underflow; use-after-free.
>> WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
>> refcount_warn_saturate+0xb5/0x170
>> Modules linked in:
>> CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
>> 6.12.0-rc6-00079-g04ae226af01f-dirty #8
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.16.1-2.fc37 04/01/2014
>> RIP: 0010:refcount_warn_saturate+0xb5/0x170
>> Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
>> e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
>> cd 0f b6 1d 8a3
>> RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
>> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
>> RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
>> R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
>> R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
>> FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   ? refcount_warn_saturate+0xb5/0x170
>>   ? __warn+0xa5/0x140
>>   ? refcount_warn_saturate+0xb5/0x170
>>   ? report_bug+0x1b1/0x1e0
>>   ? handle_bug+0x53/0xa0
>>   ? exc_invalid_op+0x17/0x40
>>   ? asm_exc_invalid_op+0x1a/0x20
>>   ? tick_nohz_tick_stopped+0x1e/0x40
>>   ? refcount_warn_saturate+0xb5/0x170
>>   ? refcount_warn_saturate+0xb5/0x170
>>   nfs3svc_release_getacl+0xc9/0xe0
>>   svc_process_common+0x5db/0xb60
>>   ? __pfx_svc_process_common+0x10/0x10
>>   ? __rcu_read_unlock+0x69/0xa0
>>   ? __pfx_nfsd_dispatch+0x10/0x10
>>   ? svc_xprt_received+0xa1/0x120
>>   ? xdr_init_decode+0x11d/0x190
>>   svc_process+0x2a7/0x330
>>   svc_handle_xprt+0x69d/0x940
>>   svc_recv+0x180/0x2d0
>>   nfsd+0x168/0x200
>>   ? __pfx_nfsd+0x10/0x10
>>   kthread+0x1a2/0x1e0
>>   ? kthread+0xf4/0x1e0
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x34/0x60
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>> Kernel panic - not syncing: kernel: panic_on_warn set ...
>>
>> Clear acl_access/acl_default after posix_acl_release is called to prevent
>> UAF from being triggered.
>>
>> Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
>> Link: https://lore.kernel.org/all/20241107014705.2509463-1-lilingfeng@huaweicloud.com/
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>> Changes in v2:
>> - Clear acl_access/acl_default after releasing them, instead of
>>    modifying the logic for setting them.
>> - Clear acl_access/acl_default in nfs2acl.c.
>> ---
>>   fs/nfsd/nfs2acl.c | 2 ++
>>   fs/nfsd/nfs3acl.c | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
>> index 4e3be7201b1c..5fb202acb0fd 100644
>> --- a/fs/nfsd/nfs2acl.c
>> +++ b/fs/nfsd/nfs2acl.c
>> @@ -84,6 +84,8 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
>>   fail:
>>          posix_acl_release(resp->acl_access);
>>          posix_acl_release(resp->acl_default);
>> +       resp->acl_access = NULL;
>> +       resp->acl_default = NULL;
>>          goto out;
>>   }
>>
>> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
>> index 5e34e98db969..7b5433bd3019 100644
>> --- a/fs/nfsd/nfs3acl.c
>> +++ b/fs/nfsd/nfs3acl.c
>> @@ -76,6 +76,8 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
>>   fail:
>>          posix_acl_release(resp->acl_access);
>>          posix_acl_release(resp->acl_default);
>> +       resp->acl_access = NULL;
>> +       resp->acl_default = NULL;
>>          goto out;
>>   }
>>
>> --
>> 2.31.1
>>
> This version looks fine to me, rick

Rick, may I add:

Reviewed-by: Rick Macklem <rmacklem@uoguelph.ca>

?

-- 
Chuck Lever

