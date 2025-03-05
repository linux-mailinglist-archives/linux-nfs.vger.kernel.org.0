Return-Path: <linux-nfs+bounces-10476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83CEA5016D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BCD170787
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85724E4A1;
	Wed,  5 Mar 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0SsGzep";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hsdoyEu0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDB24E4A0;
	Wed,  5 Mar 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183594; cv=fail; b=I62joXitpRV0XBvRcrcQcVVgQHxhqquWKAkpgkor7ULl2Z8GTkLZL1carqSRMrdtD/KPnU4zUiJaN1Xmne7eD3pYahPJqFTQKJOOOX5dF+NVieqnQFneHjE4VI3CkoXEqlZC8dqQGghfLjkLtj3HtlPOrQ2asCbOEsD4s5Uaj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183594; c=relaxed/simple;
	bh=aj42U3dKXLOcgtGlWNkvkBBOI/opX9jGEigV08XVu/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bw8IjZN06pXPe0eZB38YlfzRvjI8lO7HC2+oJW9oDsntlihRnUwR7C2CCcQziqVpjCV8Mncaqcajfm6dQpfrMiz4gtt2QxaDv67+F3GXYtdzuXfNx2LgDIiFSc8pbinpaSWXv2l67ohIy3JTRGGdK9p3MvxVsAvbBEjzKiLCd8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0SsGzep; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hsdoyEu0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C3xhl006997;
	Wed, 5 Mar 2025 14:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XkTwldY35jBSY6Y0opz8Xr4BEnXROHGq5H7ahkJNi/k=; b=
	Q0SsGzepmmFhzcf5Jlluop6bSglXI7bnVa8Kc7WpHrO6ByAiH7uy8j8EvQg5jaZG
	YPXJ031okwwwR/YKsZWPjqz6CUwpI20heKm1XlO19U5tRpfAmmYp9AjixCZTFTha
	llOGQSSL+MwQeT9TK66Ic5t/bk1JY3i6J/UTeqR2sXa5DTDzBhJJXWm0kUAaK/Rv
	aZxqKUDxKpbkrO/IEjyUvbFSBahav1rRyg10oy4OqCk0NEP9yLOBY4VDhxWS0W7t
	YvcLbhO/zVmgvYCstb/L+mEB1lZHWDCvNMc0T6UdVAlhyZRpaIZTvTg50uS51Q12
	ajKIMSEURgSGcfGCwJWM6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qfr7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:06:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525D1FSZ022791;
	Wed, 5 Mar 2025 14:06:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwwctbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6mdhBo0IC3W1qivcDi3kSft0fw5ixZArW+89ZmGB6+Lr+Uy8lJD8o6E87OtaigOD6uc9F+P4CP9KMU5u/h0pA35vfuRCQm5N/ftPBMOTToeWveuQlyFqPn08cnsMrn2gV/UQC4Il+DSqDbxYC9VGBPiWdL2hNxiy30X5TZoOVwisCeE9w0osCi6Jl3/6nL/0cvQqJw/2kU4xo/aN0aawvirglgSy24PygHXpGqz8bB1TnLj+NHsGV6/0FqMerblguJ4R4D1a7ICbmcoq3ZVJtGCWLcKSiIYffYASmO+xHKsN6YCfSo5HP47CoxgSSxTLcP0iZ0bjb6aHxtDooIchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkTwldY35jBSY6Y0opz8Xr4BEnXROHGq5H7ahkJNi/k=;
 b=biTttRvaLhJjf8QYI5hCe6CfK2pBQb4S9EOL70z2XZe2q7djgsjN8g2dePeIclN3IcU7lU2snRQZjiEleuXEXrroKhcoiOqJ5qJO9oW4rGaqaGsB5Pm9tQM0keD+wrvBLlFdXAO4akmuxJiVULFjhuxBPUyxbN9cNZy3eQesS5Rcl0ZtyFrkS0U3WYB0RtEJX8aAUOYWtv2m/Dl7e0VobyFixwA2AqQIppZ00jEglg6M3Ok9oxPtRZEQ7vBMliC2rY8dbehmlZVi4S1Nfu6xugEZmLquYhuMZVjg3RfY5tQrgsFKMNc77kFhZPnBBKMo2KneuvrEev5dPGqWjqKGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkTwldY35jBSY6Y0opz8Xr4BEnXROHGq5H7ahkJNi/k=;
 b=hsdoyEu0ySpi0WaiZQsXVTqQt0/r3pPCRjNI5zAs2UkhHRDzAwB0XmOvt40w+f7ZVpg8nwfmATEIXvmvenx+Av1Uy7KURhaOBdleFsXc/QOaWX/ZVciiHNK0yqSZ6iW0iUVro2xEPAznzTDBXYolUbBeU41dlmQGiW4sz3oI2AY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7113.namprd10.prod.outlook.com (2603:10b6:208:3fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:06:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:06:16 +0000
Message-ID: <139ad682-dec1-4e72-8802-38dc4faf4143@oracle.com>
Date: Wed, 5 Mar 2025 09:06:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/nfsd/nfsctl.c: fix race between nfsd registration
 and exports_proc
To: Maninder Singh <maninder1.s@samsung.com>, jlayton@kernel.org,
        neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubham Rana <s9.rana@samsung.com>
References: <CGME20250305093229epcas5p477214b3cd1e48e3d862531b647d34585@epcas5p4.samsung.com>
 <20250305093222.1051935-1-maninder1.s@samsung.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250305093222.1051935-1-maninder1.s@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 988c5bb6-a02f-44ff-103d-08dd5beee500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtUTTlPWS92R3gyL3F6TmVZN1ZFRC92OVNlQ2JZNnIza1Z1cWVXamRTNURN?=
 =?utf-8?B?ZzdmVUNwU2I4REdaTWpSdGpMNHZKRnR4VnF3NFUvMlJoajlUdEM1TTVXYlhB?=
 =?utf-8?B?ODJCN3pPQi83TXZzMm11TzJwNUQzdU9IaUtOVXA2czQ3OTBBaEZtUEdRb0h0?=
 =?utf-8?B?TWhGdE92dDl4U3huZmwwMUZYNGdVS3hFVnBuRE1wOHlXOG1SN21UY2lWZmhE?=
 =?utf-8?B?UVR0S2Z1QnJDYmVOTW9qNTlzKy8wR0xZb3QyZlFPQkl3dWJFazRBcVBlcnNJ?=
 =?utf-8?B?Z0ZYVjNJREsyckNBOUFLL3Vlak84Y0FZQnB6Q01IRXROLzVyTGRKUFlydSsv?=
 =?utf-8?B?aWZsekxaQ0hRNUdNdnBFOVNpM09wYmlpQ0QvQUt3YjhvY01KY1UyajBUUnZv?=
 =?utf-8?B?TDMvU01vdlU4aXFHMWk5azJVNnY5QllLUmlsUGk0NjJ2WElobHcwQlVrRU1j?=
 =?utf-8?B?cExwc3RaS3JlSHRzN2F6d1BJS0loNG8rSzBXSXZUQ24wRlV1SXRIUW1KbXNh?=
 =?utf-8?B?NUx1S1I2ekI4SC9TK0MzR05NNE1CaDJEWVNldzNXRXd2T2VLT2dhbFFwd3hG?=
 =?utf-8?B?bnlZaG5peVNrZXdVQzlVOXQyckZ5V3pQV1lXeXhoQUpkZnRuRVNHcGFnY2xj?=
 =?utf-8?B?RjFpU1VLLzNXOTlPQkg4ODZNc1dxV2lSN2JCTGo2TWh3NjZ6eVJJbGFvZzFj?=
 =?utf-8?B?L0xKOW85MmRkUWxvNjd5aU9IZG1pbTgyYTNJMGNIYWd6NXZiWnNpYXliNWZW?=
 =?utf-8?B?Nm1uUkNsc3ZxNWFPTzJWcGZ0L3lpUDY3cmNhalBJNi9PT1ZSeFczSWhHUC9J?=
 =?utf-8?B?dlloQzhIMEgyUVRVWEt1UXBmSmsyWHVtMWlVOGJhQ0RwcWpNQ3E2d1dDTWRi?=
 =?utf-8?B?R0M3WjJGbXVXOGpNWmxJdmxHZGVFK3NYWkFtRWtyNHA2L09nU21reEdQZzU4?=
 =?utf-8?B?cVVRR3ZtUloyUy9HWDdEWHFxR3M5ZTM0a2NxVlM4VmdacW53MTZkQ2xsOU92?=
 =?utf-8?B?Wk8ybGRLZ3JwZm9TbHE2bjhaVlVKb2tFcUNka0daV2JJbWlPbk5hUkFWdkdj?=
 =?utf-8?B?LzlpZ2d4aVkyeURIQ1MzbmdkVmh0ODBaTDd3L0NrclN1QWh6bkhoTWFDVGZ2?=
 =?utf-8?B?endBZGh3RVJ2QkE4bFJUU2JoQUJRcEY0SnRFK3FrZ0dpN1RYMVRYRFBkSWRh?=
 =?utf-8?B?enVaUjVBWnBLTE5XTm1ERzRoNnVZZDJpUUtWNUdzVDBhRDRZQ3VUMXFydkov?=
 =?utf-8?B?dll2Wnp4V3MwMTdlUVg2OFN0RkFzQWV5d1ppQyt2em1XQUVXTW84Z2VCQlNi?=
 =?utf-8?B?MytVanZXOWtJZzBlc2NJZmlpKzR6VG5uREsrb2htek1nckUzTFZhcWRxUFh4?=
 =?utf-8?B?c21tSFVoRlhLbFdxVDZheENkbm5CKzIzL29iZitHaW5NNVFnYm91NkZYY21p?=
 =?utf-8?B?aklVZ0J4cWNDeEJUR0h2SDNrNzFlRXFrUEZjSEttRUlCaWYrZHpZMTFKcUxY?=
 =?utf-8?B?QkxwakpXV2xpMFo0bTV1M1gySXRHRDJ1emhsK2pDZ1pteDRwMnNkY2c0TDFi?=
 =?utf-8?B?azNQSGFqdGZEQUtJc0dkUVhNT08rR01jVVBGWEE5YnZPUkQ5Wk94dTR4NE15?=
 =?utf-8?B?SHVrNzFMeGJOOFNYYnNuU0pHY05uWTN0UEJkVlNDM1VoeHcvMmo3TTlTZWNG?=
 =?utf-8?B?NXV6YUlwQU9kWE1LRkhDUGN0UUFHOVQwb2JLSXU2SzAxdHM1dHkybHhMbzNB?=
 =?utf-8?B?cW9oUzVJdFZZZ1JNakFjaE52dWF6ajlnV3dkbFNLM0dtNlpWSlFoeEptK3lE?=
 =?utf-8?B?RG9pemt4ZXFwRFFVY2E2UUFFNXVLbmRINmw3TUp2dHd6Y0ZuRkVmL0NJaUJa?=
 =?utf-8?Q?7yp4ht3zhzuQG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amNjVlBYYkRwUVJEWkxQM3lXbnFETkgweVdZUGpNZWlwTEdXeHFiTlhRZXRQ?=
 =?utf-8?B?N1FFaDViaHVLSTA1b3ZMOHd2bEYxTzdxUWhyRzlpMW5nemc5YldTaVZEQ3dv?=
 =?utf-8?B?NHBuZTdraHQxRGRWdGtINmJ1eTFNbm5laWsxd3ZmOVQxV3ZZQXdDeXRKRWI0?=
 =?utf-8?B?TTdTWDR3dks5cVhEK0R3cGQ5VG9UV0kzRGpJZkgwQUdRWlBaL2ZkUUNNd0h5?=
 =?utf-8?B?L3lRQ01HWFJVd3VYeFFvVFVjYzhrN2dML29YMEt5dCtSTE5oQ0s3aXJMWVRN?=
 =?utf-8?B?cmpMbTBkR0k5RWRQYlZ5QzE4NFNTalVHZzZ4TWxsSytid2d1VDd2dytha0p3?=
 =?utf-8?B?SlN5TUdHaWo1RloyMHB5dVo1NU5zWnpWRjZhYjJZaEx3WnR6YmxqQ1R5SUx0?=
 =?utf-8?B?eEVaQVVRSlQrcFFDSnhlYmdlRmpoWURJbktoQTR2QzA1K2x3R0FvM0g0Nlcz?=
 =?utf-8?B?T0V0Rmk2V1ZueUQveDNRU2VWRkVhN3dON2RRNVdKRVZ4Yy9uQmxFR1JEWFpa?=
 =?utf-8?B?eGJpRHBIY3J2dG44UWlCRW9IK21kcDUxaWM1RlhMc1R5YXVzbmJMZFlleGJk?=
 =?utf-8?B?SmhmenFSZHZJQmxiNWJTQWIvUzF2NDdBNWNHdzdZSEl0Z243QXhENUJTM3pz?=
 =?utf-8?B?TytYYUo3WmI0ZHF4d0JhV3BEVDhoNjc0WUZyWHJzRUt5TnB3eVlxNFpJbVhV?=
 =?utf-8?B?U3loNm1EbHNCRWo5NTdGQzE3WlhRYkRqODJrQkg3UGdyMEM5NUw0K2dIZng5?=
 =?utf-8?B?NXp1VUxRVGprMklNWlZROGFkNzhFc2lSTjg2ZGpwcEhKY1l0SjUvdGJKaG55?=
 =?utf-8?B?SUY4YndCMFFtUk10NDFxdDBsL0g0bkd6NndDZzR4dzhQaFZHR3NETzVsUTNW?=
 =?utf-8?B?bUYxS0Vqb3M5UG53RFJMTXUvTXJrbGZVUG1Md0U4OEl0dFE5Qkd6RDFGc0dS?=
 =?utf-8?B?QUhLLzR2OUl2L0ppM2tPVUM4UjNzNUdRazlOTnZDbm1neEFaZnI1cDFLVFpt?=
 =?utf-8?B?aG95QU5lbzgxZUp0cU5tY2svbklEeVE4Z0M4eFJGelllZWpxdUNFOHZFMm1R?=
 =?utf-8?B?ZTlpdStBL2x1elRWYTMwZStITi9UV3hxTWJneTJNT2JsbFVjWGJwTFA4VjFR?=
 =?utf-8?B?QWRic09xVGVMc0ZiTkJGek0xdU5JK1hpdTA2RG9QQ1pMNDNCRlF5emR2MUt5?=
 =?utf-8?B?d0pnQnU4dWZFaTEyV3k5R0xTaklUVnA3emh1S1k0YVk4eSt5TGowUVFIQnFQ?=
 =?utf-8?B?MzN1Q2pNcVhPeldjTkZwemdWWU1XTUZ6NHcwdy8yV3dwSklrMGR6aGgzSVhG?=
 =?utf-8?B?eDVuS0p0bm9CL1VpTFhXbklUNmVLbW5Pck5wZEJoY3BBdUoya09zTE9KZEVx?=
 =?utf-8?B?WDlCTCt3Y01ZWnhaNGtlSDZuOGRGVFN4OE5uZDFuMmNiWkxYN1RaRFprYWJm?=
 =?utf-8?B?ODdlSWhKalFJYVRqWFVTQVZUUFhiU0J2NDBCVGUraXNvZldQQ3E1ZTVFcVQ1?=
 =?utf-8?B?VVlteU1nMGQydmFYVll1b0JyMDBNM1lOK2RjeFNxNjJHNnZXejQyczBxWkpz?=
 =?utf-8?B?dEdjV2JJcVNFODA1NVlKMXcwVU9Mb21DWkFsOWZiUURZSjMzd01CejJkVHRQ?=
 =?utf-8?B?a2FDZzlIcFVyZzc5RFJJOEM5WVIrRDZ2Z2xiaUszbzZPdlZ0ektTdjdGOHNI?=
 =?utf-8?B?eGRjWElHamVJdEVJVDBxYitCanVoMURvb1paTXJ1MGV0MlpJZDh4aW1YTnRq?=
 =?utf-8?B?aVdaV0ZDamp1VFNKVnFqU1Q2ck5yempaemtwak9rb0VuVVJrWmh2Rlk0NWh1?=
 =?utf-8?B?b1pja1ptTGVQQUFJK3cxcjlMK0dDdHdrY1NTSHRQZXVTOEFmTlVhckswQktG?=
 =?utf-8?B?RTd4Mk1UU1JlR2VveWtobUdRdVNEQmEvOWVkOVdvUkpaYThmYTRYMlVUTkNO?=
 =?utf-8?B?K2NwU1dQZ1cweFhQL2pyd1A3ZkduT3U3OVpCTTBIbkZlWWlqd2VJdnBEY2Ex?=
 =?utf-8?B?WTZzQTEyQllvc1pPeldmaG9DQlo2SVJDYkRiSkFpU01mK0VTb21TRkFtRjlo?=
 =?utf-8?B?dDhTYlZQSG44MFErWU1OZDlSZXpETDlCNTRpbXV2K3M4NGIxVElOV3FJc1Vs?=
 =?utf-8?B?YWJCQzJjS0EzM2tndFhkWDcwQXpqMktucTVER3grVjdXQjlaOUlHc2FNLzJa?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DAKh3yL8t7L/FJtwd/DldSnFTwuohwZFpa6dfu9B+tsAZU75HOG8nb8066s14YHsx4UGd88TOaZEupEp6CsdclJjEV5Hc2dPoBFsm1y23kfpTmCtD0zLJgG5OgnlMcaIrVZ3dE3d+ak+62XsFGL2u/vCXdo8CKW/Qtu/ZGgt2Sylm4FVVlQysoEi3S1HLDVpPctmW/1k8wMgiux/s+MMeMuzSK5gmz/z+W9N6JPB3B2UejDL4saPwyjmWBTuefFt9SKaSzARl392n3i1AXgCfwutwxTFJrZW7NLt/QMedwr/o1E5CESX6l28tOZqIWd3BYVH7zJW68zzB+jn4fMfUC7zO4QJMOmjeh6S/GBKNUi77Ejgy1uGTHWcSTcZPoxcYwspV53NmOCCEOKzdbZP9E7MvPXPy7Z+6sqfO78S3iEH1iclsVOwKV9dnuMnHynQuhzy3rIFEh32HU6f4quO/Mas2xf3ov1DCb81fCEF3bvUSVg7Os9L4gtrcYPCziyLktE2n0InTup0Rgok9rcg1eZrBxO9COe/jzPgyiUp5AhEHZ3G85qPKx+ZfltZMUFDC2SYXaDR8yKQlwPnPYPDyWC804BXGnXqFUZoccRsY1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988c5bb6-a02f-44ff-103d-08dd5beee500
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:06:16.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDlOA+MTXNTOL7YtXyMjQOIBCPl7YtR2nGurj/7UFzFsX4B+LTUcsmzSmHsNx2dEOMMIR/qzVWQtSSU2JPmxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_05,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503050112
X-Proofpoint-ORIG-GUID: 3X5DWmzbu5Vzcsrk9EUsai77Gh5avq2j
X-Proofpoint-GUID: 3X5DWmzbu5Vzcsrk9EUsai77Gh5avq2j

On 3/5/25 4:32 AM, Maninder Singh wrote:
> 1) As of now nfsd calls create_proc_exports_entry() at start of init_nfsd
> and cleanup by remove_proc_entry() at last of exit_nfsd.
> 
> Which causes kernel OOPS if there is race between below 2 operations:
> (i) exportfs -r
> (ii) mount -t nfsd none /proc/fs/nfsd
> 
> for 5.4 kernel ARM64:
> 
> CPU 1:
> el1_irq+0xbc/0x180
> arch_counter_get_cntvct+0x14/0x18
> running_clock+0xc/0x18
> preempt_count_add+0x88/0x110
> prep_new_page+0xb0/0x220
> get_page_from_freelist+0x2d8/0x1778
> __alloc_pages_nodemask+0x15c/0xef0
> __vmalloc_node_range+0x28c/0x478
> __vmalloc_node_flags_caller+0x8c/0xb0
> kvmalloc_node+0x88/0xe0
> nfsd_init_net+0x6c/0x108 [nfsd]
> ops_init+0x44/0x170
> register_pernet_operations+0x114/0x270
> register_pernet_subsys+0x34/0x50
> init_nfsd+0xa8/0x718 [nfsd]
> do_one_initcall+0x54/0x2e0
> 
> CPU 2 :
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> 
> PC is at : exports_net_open+0x50/0x68 [nfsd]
> 
> Call trace:
> exports_net_open+0x50/0x68 [nfsd]
> exports_proc_open+0x2c/0x38 [nfsd]
> proc_reg_open+0xb8/0x198
> do_dentry_open+0x1c4/0x418
> vfs_open+0x38/0x48
> path_openat+0x28c/0xf18
> do_filp_open+0x70/0xe8
> do_sys_open+0x154/0x248
> exports_net_open+0x50/0x68 [nfsd]
> exports_proc_open+0x2c/0x38 [nfsd]
> 
> Sometimes it crashes at exports_net_open() and sometimes cache_seq_next_rcu().
> 
> and same is happening on latest 6.14 kernel as well:
> 
> [    0.000000] Linux version 6.14.0-rc5-next-20250304-dirty
> ...
> [  285.455918] Unable to handle kernel paging request at virtual address 00001f4800001f48
> ...
> [  285.464902] pc : cache_seq_next_rcu+0x78/0xa4
> ...
> [  285.469695] Call trace:
> [  285.470083]  cache_seq_next_rcu+0x78/0xa4 (P)
> [  285.470488]  seq_read+0xe0/0x11c
> [  285.470675]  proc_reg_read+0x9c/0xf0
> [  285.470874]  vfs_read+0xc4/0x2fc
> [  285.471057]  ksys_read+0x6c/0xf4
> [  285.471231]  __arm64_sys_read+0x1c/0x28
> [  285.471428]  invoke_syscall+0x44/0x100
> [  285.471633]  el0_svc_common.constprop.0+0x40/0xe0
> [  285.471870]  do_el0_svc_compat+0x1c/0x34
> [  285.472073]  el0_svc_compat+0x2c/0x80
> [  285.472265]  el0t_32_sync_handler+0x90/0x140
> [  285.472473]  el0t_32_sync+0x19c/0x1a0
> [  285.472887] Code: f9400885 93407c23 937d7c27 11000421 (f86378a3)
> [  285.473422] ---[ end trace 0000000000000000 ]---
> 
> It reproduced simply with below script:
> while [ 1 ]
> do
> /exportfs -r
> done &
> 
> while [ 1 ]
> do
> insmod /nfsd.ko
> mount -t nfsd none /proc/fs/nfsd
> umount /proc/fs/nfsd
> rmmod nfsd
> done &
> 
> So exporting interfaces to user space shall be done at last and
> cleanup at first place.
> 
> With change no Kernel OOPs.
> 
> 2) Also unregister of register_filesystem() was missed in case
> genl_register_family() fails.
> Corrected that also.

Thanks for the report.

You observed the original problem on 5.4, so the fix for that should be
constructed so it can be backported to LTS kernels.

The fix for 2) is only applicable for recent kernels that have NFSD
netlink support.

Can you therefore split these two fixes into separate patches so they
can each be handled appropriately by stable@?


> Co-developed-by: Shubham Rana <s9.rana@samsung.com>
> Signed-off-by: Shubham Rana <s9.rana@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  fs/nfsd/nfsctl.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index ac265d6fde35..d936a99ada2a 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2291,12 +2291,10 @@ static int __init init_nfsd(void)
>  	if (retval)
>  		goto out_free_pnfs;
>  	nfsd_lockd_init();	/* lockd->nfsd callbacks */
> -	retval = create_proc_exports_entry();
> -	if (retval)
> -		goto out_free_lockd;
> +
>  	retval = register_pernet_subsys(&nfsd_net_ops);
>  	if (retval < 0)
> -		goto out_free_exports;
> +		goto out_free_lockd;
>  	retval = register_cld_notifier();
>  	if (retval)
>  		goto out_free_subsys;
> @@ -2305,22 +2303,28 @@ static int __init init_nfsd(void)
>  		goto out_free_cld;
>  	retval = register_filesystem(&nfsd_fs_type);
>  	if (retval)
> -		goto out_free_all;
> +		goto out_free_nfsd4;
>  	retval = genl_register_family(&nfsd_nl_family);
> +	if (retval)
> +		goto out_free_filesystem;
> +	retval = create_proc_exports_entry();
>  	if (retval)
>  		goto out_free_all;
> +
>  	nfsd_localio_ops_init();
>  
>  	return 0;
> +
>  out_free_all:
> +	genl_unregister_family(&nfsd_nl_family);
> +out_free_filesystem:
> +	unregister_filesystem(&nfsd_fs_type);
> +out_free_nfsd4:
>  	nfsd4_destroy_laundry_wq();
>  out_free_cld:
>  	unregister_cld_notifier();
>  out_free_subsys:
>  	unregister_pernet_subsys(&nfsd_net_ops);
> -out_free_exports:
> -	remove_proc_entry("fs/nfs/exports", NULL);
> -	remove_proc_entry("fs/nfs", NULL);
>  out_free_lockd:
>  	nfsd_lockd_shutdown();
>  	nfsd_drc_slab_free();
> @@ -2333,14 +2337,14 @@ static int __init init_nfsd(void)
>  
>  static void __exit exit_nfsd(void)
>  {
> +	remove_proc_entry("fs/nfs/exports", NULL);
> +	remove_proc_entry("fs/nfs", NULL);
>  	genl_unregister_family(&nfsd_nl_family);
>  	unregister_filesystem(&nfsd_fs_type);
>  	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
>  	unregister_pernet_subsys(&nfsd_net_ops);
>  	nfsd_drc_slab_free();
> -	remove_proc_entry("fs/nfs/exports", NULL);
> -	remove_proc_entry("fs/nfs", NULL);
>  	nfsd_lockd_shutdown();
>  	nfsd4_free_slabs();
>  	nfsd4_exit_pnfs();


-- 
Chuck Lever

