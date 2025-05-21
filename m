Return-Path: <linux-nfs+bounces-11851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C68ABF8C2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6861B166215
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AC143C69;
	Wed, 21 May 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RhFaxvX4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bEYDwayg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFD17B505;
	Wed, 21 May 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839826; cv=fail; b=VDbT5KvZ8Wlgf8U3efgMS6tYDcKWgSOuqNzjbTPxwJHG1EwQEDh/SMcypbwqdBHPRUAMUuFpDeZIgYGk+S6ab5LquAUdkHhSE1e9+2kTQIAve45ixFLqreUt1QP1MLr/TEJqe6ZVPTShwgrZe9NQ4kQMNZ9wq97/DODwFugEOpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839826; c=relaxed/simple;
	bh=2lRmJhWuq4FHyC+DXtkz2N0bpEtW1NlbejUj3zFjIV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ptIJPXIkurqxYsBYdy0edjvjvycvgZP2uPv+3GDamwkdauZsQdEWqP2i3HqDrnivJCLdtslRE0W5jfEcHs1ftkHSMEEnvlLqllIZQy0ELxNYVAQksYp/hmF1CAb4+FnQVUXEHdlFguY1sIra5l+lFSfZxUC4VmK3SqU80/JGIdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RhFaxvX4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bEYDwayg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LEnQJu032187;
	Wed, 21 May 2025 15:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KAORHTS+D0d9GVkTZUZmJ2KzGnaQ0P5mPOctBUYjt+g=; b=
	RhFaxvX4Khep6UTXVqetvY67y89NbyNG18O86f3TboKL3kWVlikI97ZI3yP/KSyb
	KysIVAVzOxjUivupchADbfHK4dwjGLUsDqRISaddemqh54X1THwAvW4vrmv/bEQ1
	cXATRu1Hqo5/WXwwlh64NNH3xroqKp/IcNiGr42UGL5q8dSrnOFJYJl4Oyo5WYaS
	GEUkf5PfRTX74zAfcKgXXRbWn9QdD/hsJI0qh1s4zN/cNTfuOgzbMC9mE9gbdZTT
	a1Rk5DQJDhrt0W3YeU63RHkoJREY8rQeVS5D778Bm2f9YHQVy64CEnrt+l1IUa8h
	uwhN2VPr20uMGC0Aqxtjvg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sgnpr4p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 15:03:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDq4bj034648;
	Wed, 21 May 2025 15:03:36 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwepygvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 15:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3O8/tjtiWZUVdMbgFY3KW+ftwFb9n2Zo9Q0tOJX/0OZNvwRJJoP0YvePsKdp37YlZ6ttvujssaL5GPAP4sZiXAxu1klMDn1gTsW7PtKXPLOeH2i5vb+H5nfDwhIEd8dxHvPWix+WIVaAlKt2yKY3oDQMUtfzGPOKTiXHUwMRHFS0HqdjBFK8vkRvkKnE0TSn97yKP0qRRxSyAm3uT1UT6pmidOlqvgGABmH+Px7qbwdRQNNbzTCsRJB5JFcLhdjtdthXDLEdsqhsZpi7xQd8vJ/pKnfDjsZ/LLlk3kTn7IpiDXeI2F/lECbXl19vnydYj9wjNbhES+q1/ueAvyh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAORHTS+D0d9GVkTZUZmJ2KzGnaQ0P5mPOctBUYjt+g=;
 b=qbTjugRZ57tVy6+e/3kMhPaGQ+CzAypOXD7ybr0Z4G7n/WkM+OhfQsM7R7Y35Iz7Ig0RrjwDXjFoelsZlEtkwpacDtmw+WPTq+YZan60Opw1ms45W2S+2/YKmhAgfTgjvY2sgg91Pzo4pVlKO6UvCJqJhhVC28TSUUvrf1CnWKD+HW06mQGlFE44vjrvtpk3zQMBK5rUDv0TnW9moJBsxGp/XY87hDKCW/Wcng+DnIcgr4xbYHF6ylPUF47qQp4Dn+uTxFBpE1O9VrlEDIWUO4yzbK0Y4z8Nij8G9X7y4fAkRluIjZVoDJmH7PVjwnm7ecDxXALYvJ49Fyng9ZkMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAORHTS+D0d9GVkTZUZmJ2KzGnaQ0P5mPOctBUYjt+g=;
 b=bEYDwaygmy8QoRttK8wDO+mYeCtIz4SgjqAdv0CkivK7L0trASqD/ue5ips7RVmnpKKFsjZpKRGpKBKMw4EVYbMEjm29/P2PoiJDxdtRD6MV9rim49sVfgxKsih3ninedIr/ZnXirTGn0dsDSbgRz/hJs2wiSmi/eD+HBg96BnU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:03:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 15:03:29 +0000
Message-ID: <9bc18e5e-86ba-4ac1-99f3-2335afd98fb4@oracle.com>
Date: Wed, 21 May 2025 11:03:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfs mount failed with ipv6 addr
To: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Brown <neil@brown.name>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <6bb8f01e-628d-4353-8ed5-f77939e99df9@windriver.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6bb8f01e-628d-4353-8ed5-f77939e99df9@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:610:60::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f055d9-8d5d-4988-3e10-08dd9878a582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3lvekZmZWJPKzczNS9xMDk2azdwblp6TzJCbEhwWW9oN0diOWljdVFPbTV5?=
 =?utf-8?B?OU5Oa1pIS0hSYUtOT2RKa2wvekNIMFZLZW9aL3ZadUk1ckFoNEx2bzJuVkwx?=
 =?utf-8?B?Y3FyRDhwTXJuRnFtbXl3VzUrMlJuVW4yb3Ezc1kzam1PSW5HVDZPaXZSWGRl?=
 =?utf-8?B?UjJZWTBIOEZmSXpGRExDdERieWdhMTB5U0QxcVJKZklaUjdRMG5mMFRDeXll?=
 =?utf-8?B?N0RBRXgyQm9EcGtoU1Z3aHltenVYWENleS9GTUgrSWF1d3JIeUloaXU4Zlc2?=
 =?utf-8?B?RGJuSDFhRTdFTk5heWtBaGFlNzEzTEgybVFySUtQLzBXc0JpT1BiRWwySVlz?=
 =?utf-8?B?UXhzWmJ5MlkwQzhVaHI3SWhOendEVDVGYkx1WFFNbzIwZVhzVUJQZEpaMVNk?=
 =?utf-8?B?VjdndDVkYVZTMVp6TzQrMy81YUYxUG9raWdiV3dlVmdxdGsrSnpWTysrZkpV?=
 =?utf-8?B?NzBLeUdnWm1HRjh5OHpBYzRnOFRSWjlKY3hUek92ZjlpcEJpYkZ2Z3YybDN6?=
 =?utf-8?B?UkNGdU02ZndqUTZZdnZKT0tCVHFLSGZUU1ZwdCtFamVaajRwelA2UjhMdnVo?=
 =?utf-8?B?b2hrY1M1c2R5OUhUNEI4WEZtNStGNGZNMXhTMVFvWktsODNRcG5rNHRwUVEy?=
 =?utf-8?B?Qzg3dVhSR1BzTXJGMGhhZWw3WG5iUU94WUdSNWJNOE90SWdIRERLdm5tR3pY?=
 =?utf-8?B?NzlpcDZ4Q3N5RHUxcmlYU25PbXRLQmUrUEFxN1NJSGs1N1VsQWc3QXhEY0dh?=
 =?utf-8?B?M3c3L1pvU2haK09KbEJTR01uMDdxczI3YVdDdHFjQW5MbEdwejdBZi9SdWda?=
 =?utf-8?B?L1VMc1RlT2F5VTAvK3Q4eWtKcUtUWFhYQjZPUWRzOE42aFd3aXFnenMyV2Ru?=
 =?utf-8?B?Q2dXSkgyL2pGRzh2c05XVXBLMFIxSitZTUszZ25OR2VTQ2FLZzlxVXNYTHk5?=
 =?utf-8?B?WmNra0M3cTlWeVZ5TUQ1eFhROVkxL3dOSVhrTHZpYmY3K21heElPd0JQKzRa?=
 =?utf-8?B?T1orTmtHV0MrV0FmOHlaV0Y5ZDdUZDZ1UjJmOTBub1QxZVd0dE0xb0RaMElM?=
 =?utf-8?B?RFdSOElMdlQycmtuTUQyNHRPRDd2Zk45NlF3Uzl3RktmT1h0REpwK3hCcmFl?=
 =?utf-8?B?Ym1RSFNCdHlyemhVRTJvL0tQNllXSlEwNC9zZ1QxQU5KaTdWTnhBZDhuSWZN?=
 =?utf-8?B?STQwNnRpeFdIaHZNaExZa3J0Q0UzMU5xWUdvU1UxU2x3N01MTXRMVEZ1TDhw?=
 =?utf-8?B?QTFxTFUrdnNNRUpNRHJnUUpaNjZ5a2J3dW1iOGVDQ1lEblZ0MjR6dVgwcDEz?=
 =?utf-8?B?RmJhdDErYUhoT05pMlc1UFFpc2xEbENzb2h1SEV0K3k1MXVsRE9rbllmZFEw?=
 =?utf-8?B?dklFcEEvNjZWcndWOHJwcG90aytUMXNRU3NFMkFXelFhN2YxV0M5Z2tCNlFV?=
 =?utf-8?B?ZHhscTRXVHMyRXpwbTVPS2NDblZHQXkyYzNZRCtTYS9Xc0dubWdOT3J0aXZC?=
 =?utf-8?B?OWVDQnpLOXNXWmltZS9mQ1Nya3d2S1Y5SFNrNUJyWmFMT0pSUU0waTEya3Ax?=
 =?utf-8?B?SFUyVWRDOXdhV3k3dFhPVmM4bGh5QThWQkR0Z2NaR0ZyVTEzYysrNUVrSXlv?=
 =?utf-8?B?bGhHa0h2NVZHR09YS1NyMlhOZ1NzS0w3N2d5S1JYd0djVnBEODNxQy9VeDgz?=
 =?utf-8?B?emx3NFQ1UVB5REhkMFYyWWJSb1dSNjNrL3o3MVBDVDRMK3M2TS9QU05yVVdz?=
 =?utf-8?B?SXRXMXp1ekNBS2pvWmZXMmFkSlFGNXhqSXVLVmdKMFE2SUhPVzUzekpwS3ZR?=
 =?utf-8?B?eHpYa1lTK2dueEdNbEpjVi81dytXU0JKOHQ0WFpEd3NDMWQ5K0tJZGFYSGt0?=
 =?utf-8?B?QUx3SzB3aHFYUUdNYm5pSjA1eTZjUXo2RVlsVTZNWGxlQlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm5TODVKMnVYcmoyR2lZU1MreXZqUUttSmpacGVXNW9PSUxIcUNoV3VZWE5U?=
 =?utf-8?B?SStXcmxyandvN3JKN014NnQ5SVJwbkU5aVlzQUZlcEdFWnpZM0RwL3YrYWRI?=
 =?utf-8?B?enJZVFFuTmFaYTRUcGI2UnlXaW1DNmp2YkJ1ajcrcFlPdWg1SHhqQ01SZjJt?=
 =?utf-8?B?bnhReElaV0EvVmsvOGp0RkFZNFNubHdEUHJNRUc1cHBhbm5taU03V0h2VXFW?=
 =?utf-8?B?RHM5TnBvYVpUa2k5ak1meTRvNHUwak5DRWdTa2lTV1lJN2M3enljY0t1VHVN?=
 =?utf-8?B?eGVPbnArRitrL3BXZzUwOWNYYVQ3V3dSMUorQXFzS21JOVQrQXVpcktRY3Rs?=
 =?utf-8?B?a2MrRHZaaCtCT2Vnbm53dmY1R09OblB4cGRDbW1ITXltZHFVemdPa1NpL1Zw?=
 =?utf-8?B?N1NqWGtwQk80QmZTd2N5aGZ0dm9JVkhKV0RRbGErTk1pQUlRajB4d0tzYkxZ?=
 =?utf-8?B?YkJUZ0RTNDMvMlVqTzRpZmhaMHdESmlXeGNBdGhHanJkelRGenJUY0FBMEdJ?=
 =?utf-8?B?Z0FmalUzVUg2eGNUL3VpRWtrMGlMQU5jdFNXLzZjV3RTVWFLaDBjVjcySDBF?=
 =?utf-8?B?TVdlV09JeC80bSt6ZS9lalZHSWVhZ3FJTXRMMkovSGticDhrUGFsZzExMXIx?=
 =?utf-8?B?MjZ4bEVSVmZKZ3FSR2xwNzBSK3hUYzR4Mk5CRFRDN1hRbXl5cnhYM3QwZ3ZB?=
 =?utf-8?B?UmxCMDZTdVd4aFAvY3NDd2ZCb2c3cXR3bm5BWTd1Z1FJTnZCdXBHUWJXY3J4?=
 =?utf-8?B?TG5QaTA5emxZdlJURjRiZ09pQTZoNVBLQXBYeWVFSmhTZmNCc0VVVjVyWnBr?=
 =?utf-8?B?N0d3bVRQazZ2cFRFRG1TWTcxRlZ1ckNRWHNIZFh3NUh4OXJqNVBlZjJqSnBG?=
 =?utf-8?B?L3pqWmxJOXBjc3VrS3lsbG4xVFFFN0hKQ00vU3c1eDk2R1VxVHNPU0lTSS9o?=
 =?utf-8?B?bkZGSmptRFJ6Y25PMmhHNnVvcDRueWg5cmU4ZEd6Z3hObXYvaER6VTFWZXd1?=
 =?utf-8?B?TFpmWDQ1eWZvOUFRT3dUQUMwdnVqaXVmdi9kMHhaa2lIejlmSmIyQm1mYjNL?=
 =?utf-8?B?YmpmRC9oMTNIbFdVOTR2aVIyZVlJclVEeDlDdEUzSzdGaU1lTlYwYWF0czNV?=
 =?utf-8?B?VXFRdWpXZHdISG5LV2dWV1FZbWdEUVBLUXhlMFNaTjc2c1dSZzl5V2NhTm9i?=
 =?utf-8?B?aE1ZMXlRN0xnYjZZc05BeSt0b3JWMy9iVDhiVW9NT3Jad25IL2xjaWFsWUNv?=
 =?utf-8?B?anI0Y2lyMUxxWERxMzlabzdBUGdORlVxSDRZdHE5SzRRclM4RndXYnhQdHJN?=
 =?utf-8?B?ZDNCczR6NXVtekpWVUZCUy8xckVJV0hrN3hTT1pUNCtXbEtUVlo3TzlIUGJj?=
 =?utf-8?B?bmhNY3ZWU2lIOGtsbk50Y2gwMG41dHRZRzdRa1dDQTVlV3RJUXpVcjkvOEll?=
 =?utf-8?B?OHVTRXFDSWRraHdFYjQyY0hSSWcwZWJoZ2duQnkyR3RUMGo3T1RjQW01d0J2?=
 =?utf-8?B?eGtaS3hoMDNWUkJZVDBKeEFUQXZwbEw2YTc1d0R1ZUkwVEk4OHYxMVM0OFlw?=
 =?utf-8?B?bjI0K09QZW9ESlJBWXg3eDU0TlcyTU1Va2Q0dm1OYzBjbDZjZzYyYkpKMUY2?=
 =?utf-8?B?K0cxYWFtN2lPdlpYZXZ2RzFtOURiTTNmbFVERmM5NDNQMVNMRVdWNXA1Sys3?=
 =?utf-8?B?MzhCbzBOT0F6RzMyRStSY1g0bjBzUkpLU0pxdTlpUFhxSEsxNklrUEp5alNN?=
 =?utf-8?B?bkVXS0V5WFlQeWhqV0RCVVkxSURQRG55cEV2MDVVOWd4NE1HaGhUNG9xMjEx?=
 =?utf-8?B?QWVHWWdlbEtrYzRRMXFQZVAwdFZzaHF0cVBIWm16VFRGaE9hK2c0OHdWOFh4?=
 =?utf-8?B?YTZHRi9XdG50SytSV211ZndFZFo3VUVtaG9GVWpwTTByYXI2cHN5a2NiK2NX?=
 =?utf-8?B?TXBwOXhvZmpvNnVNWUpQY3JZMmI5eWZYTWYwbVZVZkY2S0ZaQlNrcVZ6T2Fr?=
 =?utf-8?B?VzQrajdOY2pPUnY3VnhNVXg2aFRScVVRMTdZMVVWWXJNQlBpOGlCUkxLMzMy?=
 =?utf-8?B?M1RZbzJLc0ZSOEtMSFdzRnZUQkJtYStxallSekdSUHZ3SlVCWG9ZRE92eDRQ?=
 =?utf-8?Q?lqj56wlRYLW0HxHOjCnK5an+W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PbfGKgxV6BRLJjk150q/McNmLgQ88JTZdDD6McdWfJar880wJ7zBWk9A2+AmBA5+8Dcph0OqifzJYW4zjHRI+RqAwitF9i4XFhp5u9sp7mJXYuodgC2pqKO3yGO7TH8Kv9e3Lnn+Qk3kSi+FfYY6A4Vk2DNwz78EonNVCRouKEfYItHJKBy85L7/F9OC7TL+tsxw3DarTSR29xfaajXb48OJps5JTHdvDp9IQeNZPWQVmQcyKpBm1id9HX89Ul1ddyTuHxVlFGRoc/eR73hQmNhvN7BD/wWMSycp0V/Yvz42V3dhM6obDE7SGZ7lMwVQM4KAblnL+YqC63X2Z3dyys6rTy/z94AcXcdWj/BWDM0VIg2E3SBLUY0WLegpXd3wCR3lPIxBbMtg8DkaKtsvU3U2JUxeWFaMZ7JqO3j5F2kx96xqdRtcDg9ghteWo/0AISGj1Q7a5174HB5O4MsN634+bA1GMRbtOWAtc+5psnmDn7P2gOdRM77I7LLp17JEX6ysJuOqPa3yf5YU/hdEeiK1x2KcTNGOa4EERTtCOJnEBCdKTNpI9tgBXCFq3GAxsZx2eQtCE1da8Du9yQ18nYB24gykXAzOiap7c/ae+0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f055d9-8d5d-4988-3e10-08dd9878a582
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:03:29.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNkfYzSw3IqZk2ZXsp/+0RyglZFBNJWJEU2Es+r55w9ckBSdpXuqQ6AEDjg8qoeDxnlhrkCShDpEs5m4lN1bIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505210147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0NyBTYWx0ZWRfXyGwuLy4jtr8M UsNCL4/Pyk0w+Ku0ueA+KuywCdCwQgUz9wta695ITm6DzEf+rcMUvmxBhGppGZq+Gm/IcvIKHIz ev2AVsiT3Nw5sJjZ+arJ912K3hMOmSPy2CP8Vscrz5tbH378A9zvJ33HKZ9jGGSJ2+zLbn9r2lu
 LYNXf5v4BLquoED1Fi6rgMlmLYcMo0PYsRWQzwstG9SNBu2Y5oPg5Kdw6n3z6Ms0tfLof4vrbk7 aRPhcz1tIwscipTK5aY9N3804e5ORstHJXIgHlhKlzX1jyB8WXptCl4/6kMYYOcXBc4w5SLFwuH xlm3VEW8lse0P1J41cOjorU2+23ygA8MV0dVJZi5EgyF+zkxQzVVV5QRrJv6LUmk3b2TYu9oX1X
 IzTFZAKkpzIZNsALRedi77SVL78man28eE94jyJ0Z6OmeRXa11Z7FobnhWre9Pki2UXsA78D
X-Proofpoint-GUID: zbsgPnNigrUHhk5NY9c7O45WQjcoG6cn
X-Authority-Analysis: v=2.4 cv=QO9oRhLL c=1 sm=1 tr=0 ts=682deb4b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Xo-1OflTFCLLJV3nN9MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: zbsgPnNigrUHhk5NY9c7O45WQjcoG6cn

On 5/21/25 10:11 AM, Yan, Haixiao (CN) wrote:
> On linux-5.10.y, my testcase run failed:
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -
> t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
> mount.nfs: requested NFS version or transport protocol is not supported
> 
> The first bad commit is:
> 
> commit 7229200f68662660bb4d55f19247eaf3c79a4217
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Mon Jun 3 10:35:02 2024 -0400
> 
>   nfsd: don't allow nfsd threads to be signalled.
> 
>   [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]

commit 3903902401451b1cd9d797a8c79769eb26ac7fe5
Author:     NeilBrown <neilb@suse.de>
AuthorDate: Tue Jul 18 16:38:08 2023 +1000
Commit:     Chuck Lever <chuck.lever@oracle.com>
CommitDate: Tue Aug 29 17:45:22 2023 -0400

    nfsd: don't allow nfsd threads to be signalled.

Adding Neil and the linux-nfs@ list ...


> Here is the test log:
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=/
> dev/zero of=/tmp/nfs.img bs=1M count=100
> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /
> tmp/nfs.img
> mke2fs 1.46.1 (9-Feb-2021)
> Discarding device blocks:   1024/102400            
> done
> Creating filesystem with 102400 1k blocks and 25688 inodes
> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
> Superblock backups stored on blocks:
>     8193, 24577, 40961, 57345, 73729
> 
> Allocating group tables:  0/13     done
> Writing inode tables:  0/13     done
> Writing superblocks and filesystem accounting information: 
> 0/13     done
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /
> tmp/nfs.img /mnt
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /
> mnt/nfs_root
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /
> etc/exports
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/
> mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/
> wr-test/bin/svcwp.sh nfsserver restart
> stopping mountd: done
> stopping nfsd: ..........failed
>  using signal 9:
> ..........failed
> exportfs: /etc/exports [1]: Neither 'subtree_check' or
> 'no_subtree_check' specified for export "*:/mnt/nfs_root".
>   Assuming default behaviour ('no_subtree_check').
>   NOTE: this default has changed since nfs-utils version 1.0.x
> 
> starting 8 nfsd kernel threads: done
> starting mountd: done
> exportfs: /etc/exports [1]: Neither 'subtree_check' or
> 'no_subtree_check' specified for export "*:/mnt/nfs_root".
>   Assuming default behaviour ('no_subtree_check').
>   NOTE: this default has changed since nfs-utils version 1.0.x
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo
> hello > /mnt/nfs_root/hello.txt
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /
> mnt/v6
> 
> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -
> t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
> mount.nfs: requested NFS version or transport protocol is not supported
> 
> Thanks,
> Haixiao
> 

I am not able to reproduce this behavior:

[root@pynfs-nfsd ~]# mount -v -o vers=3 [::1]:/export/pynfs-4.0 /mnt
mount.nfs: timeout set for Wed May 21 10:55:59 2025
mount.nfs: trying text-based options 'vers=3,addr=::1'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying ::1 prog 100003 vers 3 prot TCP port 2049
mount.nfs: prog 100005, trying vers=3, prot=17
mount.nfs: trying ::1 prog 100005 vers 3 prot UDP port 20048
[root@pynfs-nfsd ~]# nfsstat -m
/mnt from [::1]:/export/pynfs-4.0
 Flags:
rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp6,timeo=600,retrans=2,sec=sys,mountaddr=::1,mountvers=3,mountport=20048,mountproto=udp6,local_lock=none,addr=::1

[root@pynfs-nfsd ~]# uname -r
5.10.237-g024a4a45fdf8
[root@pynfs-nfsd ~]# cat /etc/redhat-release
Fedora release 33 (Thirty Three)
[root@pynfs-nfsd ~]#

Maybe I missed something.


-- 
Chuck Lever

