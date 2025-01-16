Return-Path: <linux-nfs+bounces-9318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846C4A13EA2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 17:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742AA7A06A5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3E22B8CF;
	Thu, 16 Jan 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUxMFp0u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pvZWk9/A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF81DE2BE
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043253; cv=fail; b=TtTpOu915Jhm/gbT8H+BvihyKtJsufbKlSsOKXyYkC/LDZ46lgScoRQJLJG6y+TLRo9eSZvnw2DbR2aGQn93fImD/AnIqf2+asvlon6CvBBR4DYxoHtlNjIRz5zjvc0i68CbOQ2h08Qa4AhGvUKEZTeiVN6FraoYr2EAk9s+Za4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043253; c=relaxed/simple;
	bh=rbgJOZLl2v4oKQRdXJ/xrmHjYYSbyYfLo5RzEQVcpsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oyV90gzDgc7oc6MoOIABka3PG5AZ21B1En7bOUxiYlu9ZWsPO4CVi4XTACjGcC0d65pNLtsY2lqBreMKZSEOHZv6MyBvn/c3boTmAxFWD1h7K+8hzJKv3YO8UCbLBB5gVZpYYRywdifju6m0dN+Q9fCWRgPxC3MvQzUo7qezVL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KUxMFp0u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pvZWk9/A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEuO6J028399;
	Thu, 16 Jan 2025 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rTBe7Vqof7N20FyuEUUasAtEMwpBRjTHEu3/hSYR6Tk=; b=
	KUxMFp0ufsZGVshUiH4Olzwf2loUS/5y80NsuCAJYA613vf6CUGR/KZa3OmniZar
	Pwa7t43wGv1oZZS0jnzrQozagU+l668RTUcRZqeIodH+W24I/AonVedfxb0hu2el
	Syq4OfWrRU2FGDO2zpeiALLP4pzlkVDqMLIahdX0Ng0JqJ5ZrXiiuyMfcdKutLRQ
	YBkISD58sL4k7ZH8NOtnh6SxXokG4WeEFXDOKHNK18TkOAvgC0nrOiqdNkTAl20m
	pojayIpfrcspeGXvT3yIEX8KT1/ITopsVvPgRURHgKfIAJEzfMPZKodoTosBoEpb
	MET6N9JGr2AqPWbHp6hv9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7yaj39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 16:00:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEoWip030053;
	Thu, 16 Jan 2025 16:00:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3aym38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 16:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYL0/Ule8YOthXWSiS1hCFXRi/2oB5SOTWF+clKcmwC2FdGVEX8ghI8VZDRmSNqt52fGAmt4sGl4ChImcELOi0AbKEHkSlllXxnLtMEW3j97FT57zqnmZOjzR/SyrbVQIes8YzlGTvvtgmJg6a7+tsC98q24tZFtalFKewtWAlFB4RPr4+BLA5p4Ag9gsQLcV8ueX/qWlmxEZc4M8sTCiHsmL/73yQnLTbVC9pBi5IkrQiIha4Ab9Sw7Gj9exChvBnH18X1ufwnckESC5lUBMS7Ue+Pq1IEp+hXsYqG2Qp8ly9fGhb2Zi37g8jWqBNBK3RWJlUa+pc4Mdg2T7w4RJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTBe7Vqof7N20FyuEUUasAtEMwpBRjTHEu3/hSYR6Tk=;
 b=uWseyQ+k3zafI8a4v7yTHL1DqbDuT1G6GbMCHiUvs2CUqlQEJT2n9PRGsRIHsnMCWE5t1otT3PPuxBjogJwUNwjZAd00JJEd/1beoDw9BHTKtMIYhqAs+P/qR+Vrla8bWhDJVLM2WpxelQiAlmIJT/MOnzCdK7BfiZx7PEESK3aWqIrVJ7Ya2VSLkDDGRh6hKt7rTDttpOb7pURAVhfSdc4R8euLRAmTuRNE5N6Af+bpy8BM4C5NRqJq0+VaavSM3Qlxpbry9F2XA/H5S9aMUKQEZzRiFouOZxITvnMJCfg7iB1Q+zwrLS5jZtR1Sw9DxW9gab2YBOrV/ZVd1AegQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTBe7Vqof7N20FyuEUUasAtEMwpBRjTHEu3/hSYR6Tk=;
 b=pvZWk9/AGaBZoUBKeoU1FfBuhn6oWn4Rok0cakhK6MsrFk+vhHcdt/6jA4VWB6dbTzyq3iJ1KEZ23OJzbiHFgvM6OrGYwKZg3UurF+JAEyh+6bgrvsa9sYNd2RamZ736j0zErRCMs6ZaNQDEa3DvU6lmzXHO0FawNyvSAfOQWe4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 16:00:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 16:00:44 +0000
Message-ID: <b4b38fc9-3a0a-4324-b7c9-5e080ef492a6@oracle.com>
Date: Thu, 16 Jan 2025 11:00:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-2-okorniev@redhat.com>
 <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
 <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
 <f2c87e35-2ce4-455b-bd1b-e567123b368f@oracle.com>
 <9757da07ce21d1c1275c637ae49cbe69a9c83a71.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9757da07ce21d1c1275c637ae49cbe69a9c83a71.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fe91eb-2b60-4f91-d2ff-08dd3646eec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE1DelE5ZXQwNTJJcmdLQUNld0FrZU1PMUxYQ1pVQytTZmNRWENzZ3ZIVTV0?=
 =?utf-8?B?VTJ2cDFFQ0o0SWxrbjFLVUhtRStKM0Ntcm5Ob3E3S0p2cTVaeS9iYmVtRENY?=
 =?utf-8?B?WHNzaEo0bkZmWFppRWdkeVBoTi80VmNHOWNaVFk3eS9hMHdJQlU4VXU1WTlt?=
 =?utf-8?B?cFBOV2loR2Ewby8wR1U0cXdscmc0QTlsRy84QVdPY0tkUHlhWmdqdE5HTktF?=
 =?utf-8?B?ZXdsQ081c2UvRStUaDJ4QmVMOGV4U0wvcldDTjFXeHBRRmRsQ2VUYnN5MCtW?=
 =?utf-8?B?NUd1cEZwT0ViNEphWXZUV21GUElUenY5S0RJQkRtVWV0WVF0LytSajhveFYy?=
 =?utf-8?B?d00zNng2VjgxWFIwd0prMnM4NjZ1ZzFvanhrYnNLZzgvd3FHakFLM3hYdCsw?=
 =?utf-8?B?STRsVnNWdll6eUJlWTBsOHlsY3BOM2w3d0d0ekJXWUZ0bHFrWDRRQjd4eWZW?=
 =?utf-8?B?UHJQakgvQ3BpUVp4R1Y1WW9taS81cXVleTl3TzF0UlR1WnVoR1FHNWdoOVN2?=
 =?utf-8?B?Y2x6WnRRTGM4L2lqZ0xpQWYrN2svaHFuS1hxdDVrRkVWZ0dCSytPbHJGUms1?=
 =?utf-8?B?U1ZsWFFhWm9HK0hhRnNlUXBZd3Bzeit3dXVBOXBacDBwbE12SHIvVThBRHdN?=
 =?utf-8?B?RGdTS2ZuZHYzYVE4djVHa2VuMzFZUDNwVkM5U1JEOSttN2ZudGZUcHB3VFdN?=
 =?utf-8?B?bDYwNjZPNzRYNzhERERQRzY3WWEzVmI3WEdld2Y5VjYwcHJLTGVTblpsam1X?=
 =?utf-8?B?QWNjd2tJU1RtQVVLQlM5WXBnVGc3c3padis0ZTVhTUkzZm14MVQrTlpZbkVL?=
 =?utf-8?B?ZmpYZm5MM1hLREpRZitsZDNWN1kzeFpRVzYxTTEza3kvUFcwMSszOFMvd0p1?=
 =?utf-8?B?TVVIQkRpWkZObURYNXFUYmc5N29ZUTFCWnVtUWRRZGp2RnNIS3lsaVlwVmI1?=
 =?utf-8?B?NEhIdGZlSEppMkdpZ1Z6TnZUd0RnR1pKamhPUkN5Zk5SUjFnNGkvUkFxL29D?=
 =?utf-8?B?NDlSdDJxdDJwSFlycnFUbVhjNmpyRnVkdTJDRVNhU1NEdXpLcU5xTFJMbFpU?=
 =?utf-8?B?NHQzUHZuQ1dwSC92bjJSZ3ViRncreXBJdTVUVnBHQVI1ZVB5YTBXZnMySk9u?=
 =?utf-8?B?NndpNzg0bEpQMlFtTzFEaXVlQk5PSVhaMGNESi9BWkE2OENGV0hjT0hIdDcx?=
 =?utf-8?B?eWRZM1RTUHFrN0Fjb3J5NEpaNytYY3Nqb0M3a1NTM1k5UmRwaFFWSXBaTUx6?=
 =?utf-8?B?a29GU3NvT3VhbGZldGFObGkyY2R4VFNzRUVjNU1xbFJXRVJEbDFzbGVtZjI1?=
 =?utf-8?B?bW53RVJyck1CRTlVdi9PdkdvYnhxcjdBOTlIQ0tGL3ZjSTlZVkprNUMzdzFq?=
 =?utf-8?B?MTNSZjJjTi8zdlVtV0dqandreG5SV0NldHlDSlhkVm9vR04vWmVDcnFXbmlH?=
 =?utf-8?B?L0dkcjRmMEdBYmFvMzVzdkJzdDRDN0dQU3V4ZXFZNDNpVlNPYmRkR0dtcDV6?=
 =?utf-8?B?N1VURzlkUnNsUm14Q0wrYUozTXBhblM1VE9yRHhROEp2SXFVQ0Q4OXB4R0dN?=
 =?utf-8?B?SmMvdlBqTkxGcnNIZ1U4QXZXUFN5RU5NQVJHQUFObi9QSCtYb0dVK1M0d25N?=
 =?utf-8?B?NzFCWUc4dzk5SlJNWnA4d0F4WXg3My9YRHRJRlQxaU14bUsvUmZYZVlsWTlp?=
 =?utf-8?B?RE9RM1czOFk0TjhXRzJWZkFuM0tMY2FHc0I5NGdlZmtBenRMNTdtcjE5N2NY?=
 =?utf-8?B?YlhRNzg4bEtUMzNERGNvd0VsaWc2UzljZThEbS9mdFBOdGx5YXliempOUnpj?=
 =?utf-8?B?NHg3SCtYaVlmNzlLSkkzaUJscitsek5JOFFBVjhqZHhqdy9BNzJkR095UHZh?=
 =?utf-8?Q?zTh5tLXEps4vH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi8wVjJtYklOb0VvajRha2pRa1Y0ZlJnbFRRQ0NzcTdpM1RQRUk1aHFyVkl2?=
 =?utf-8?B?OVhpRFNXSjFkTGRDSEpaQ3JJZEIrejJKcWpnekowenlrQWh4bXI4S3lEUkx2?=
 =?utf-8?B?N0VPaWUvekNvNmdxbng3ME1UMGZuSlB4S1h0RGNDUXBOUDFBWXkwSVluRG80?=
 =?utf-8?B?OXEzYXBMakEzdFY0M1pKS2ZxeS9PcVNZMHBqSGtFSFF4R2t5U09QT2EyaG92?=
 =?utf-8?B?bExubkhWUjh4WVcxRXhvMGpxbUpoNG9weEpJbkxDTlV0Rk14MkVuVW53akxm?=
 =?utf-8?B?OWd6ek1IRkRMZGh5em16OExnMVF6bitRSkFubUc0amNWSkxza00vdjNSbUFu?=
 =?utf-8?B?Sy9TVXI1MW9iQXhtYjBDd1U4bWxFUStLTDBVUHlybkxoZ29FK1UxNHlOYzNU?=
 =?utf-8?B?Uk81dFFpNnRGRmlXOHRzRExpZGlmVllnYWFqQXJsU0tVcnc1aXVKcy9VZVFh?=
 =?utf-8?B?empnTTd0YjJ4VHVuc011dFVwNm5RSmViVzF2RkE5emJXcVJSdUI4dmt4OUdm?=
 =?utf-8?B?MTdzdnBad21DS2k3RUozL2xwVDhUb1ByK3B0Zy9IZmF5MXZBMGlmbXJ1TU5w?=
 =?utf-8?B?Yk8vSGNTYmpwWDVHb2ZrSWNJcEUydWJlMGFjMm1RdWVIMWcyVzJYRGdydW1Q?=
 =?utf-8?B?eWJWQVMrdU5lZDdzMXVkWlcySUd4RHlrWVRkakpvYUhGbjFaQ1dGcUI0cGFV?=
 =?utf-8?B?OUdhRkIvVWFUMjZzV2g1RGVqZFp4cUUxUDdWaUhWYUErY09RY2JtRFgvbnZR?=
 =?utf-8?B?N21qeWJacXNQdVFTa2trcW82RTFVSnhNa2dPWGxQSEJuaUhoL1dmTEQrVVZO?=
 =?utf-8?B?NklzSjZKQ25IS3ZiUksrZVhueGJVcHhzTktxY3VtN2NTTHlnTWlRbmZ0ckJD?=
 =?utf-8?B?bU5TSmZzZ0RwSUJhcmFjK1NSN0hWbWxzS3J0TmR6U0gwclVtUktLT0ZacDVa?=
 =?utf-8?B?YzZ3cHJJNkV2RFJSUzVTcHRJMEx3bm1NNFNxVlpEcXJTclBra2dqYUFCai9q?=
 =?utf-8?B?cXdmdUcvb2ZBL00vOS9wVEVUN3ViREhJZ2RUZjgxRXBPVk9Xb2w4OVBqRVFF?=
 =?utf-8?B?L0lKcGlnOGlrUnhaZnc4ODRtaTFrTklrTThwMHRLQ1F5MGlpVmZsdTRiOVZn?=
 =?utf-8?B?YkgrMy82M0xGSks1OVMwMjgzQnJEK1g5c1lIWmFicDZraUorMytKZExYV0lP?=
 =?utf-8?B?TnB6d0NUUTg4SVhybDVhZDBqY2puZDhBMFhoRVlGWlRBYzBpU0FuQTZURlVX?=
 =?utf-8?B?NGMxcjJObHJoRmtUMGd0Wm01Q3BickEyVVlmbWJyMWI1U01ZOVByZVFmbFFB?=
 =?utf-8?B?Rno3b2pSS3NZWjdiU2lUQU03U2NOTUVtTkxueDlEWTRCemRIV3FxUHpGcUlE?=
 =?utf-8?B?ZG1jNnFEbGZ0QmFuTVlpTDBnU3loOWw2WThoWURyR3JFdlI5YlJndTFiRHBk?=
 =?utf-8?B?aVBtVTlnZ0RNaW9xODRpb2FuWDI4bkJzWmo4cDgwTTMwU1dsKzlONE9kaVVw?=
 =?utf-8?B?QU1qajZFUGw0alpST1QvSWthb21lbVQxbFF2TnQ1Mnk0L1VnYitDWW9Db3VX?=
 =?utf-8?B?MnFreGJ2bG9UTHN5K2VMblg5OXpnQzZqb1F5d0wrcWMwSERuNnNuTjZmczNF?=
 =?utf-8?B?Um5PNVQ4R1Z2eG5oUE5ha2pkVnNPdzR0OFJsSkdKNnhtVExwRVh4eXVNMXlp?=
 =?utf-8?B?b20vMFBsZXpnQWJJVTYzNy95UXB6K2k1Qzc5NjlIUjFEYW16a1VWVnJ4U0NL?=
 =?utf-8?B?b3IwbHY3S0Foc1p0dmNLb3JYQXVEcURSMzVuN3B2bnJReVhPbE9BcDNGOVk2?=
 =?utf-8?B?bmxBK0k5NkVORmFuVGlLdWozNDgzSU9tckw5YlBzOWV5Y0hKYXhBWVNvOEM5?=
 =?utf-8?B?Tk1kR04xZk9HT3VKYTM2Si8xRXAyZ24yOHVCYkswNVlkN3FKZmZkc1FHQXZs?=
 =?utf-8?B?T0MvNXJpckJTbHdZRitURkxiNFN0SUt0dnRxdnozYzdwZHJpQnl0Qmgwdk5p?=
 =?utf-8?B?TlBWQU9vNHROWGd4MjNDeTB0YVNqVTlKVzBBU0ZNOUxCT3hnTHcwMVZRZzFh?=
 =?utf-8?B?STJVcHlvZW8xUjNRWGF0c3liekNsazgyYnZDaUxjeU5UeFEyZjhld0JmYXNr?=
 =?utf-8?B?cVhEYjRQbEF3WWpmUDA3SDZhd2h6cWUyL0Z2ZTdUeU9mZE5meFJhd3dMb3Z4?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4yxiX818uehz8jmkq0qUISVqyjQSzgxgspEIf+i8JhWA0lQKjJjh2Q30T8yVjMMj7BFZSbM3y8q1FZG+m0brtyT9LR5Qo44iT/gwE2dOg2AxDPmFZ3zDukVt5dKHiKPlolFGyg0m8ZPRoaH8Gso/ZWgrtG7vT2OyVI2jKFEE1VEuCqAIm2CxQHf6WAo2arMS9fcfTkK0B4wyMfIh2L1Ubg9O1ALKcDEqfwzrWefr+ovHiP14PKUDHV5HwCqr0Sz7n60LHEkd2ATYEy8wuS+mNyEXEK+9l/MisEPpAgYtzQDwHJ7rXcB9OiBTzA2lJuIlOtP/x/6b/ETVAqdBITDQGqIAgB7NUmzzTf6AGXJjwyrTo5FruKkIatOpgaEIfTJZU3vcaORsHFnezYqv4ASF5qF4ntpbL95fFHgIAzEwnhp546S7sqHNmYpv8PJWCnK6M6AQ3icGGQwEM3rSKZKu+wUNsQmiaeQ1Q+Ck5Hw+Mj15aRnYSAVUE3wSstxNF2QtuX2qQ6O+7x6XWBOv7ZJyxn2FYAEWFdeFtmPzeQMo8+AhRiAH6d6JUid4zPLlALp/+Fv3iKXgqo/zpmJI/5eJaao7IyU+IJ8lRJAzRwSZLMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fe91eb-2b60-4f91-d2ff-08dd3646eec8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:00:43.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Xeax0/o1J58LliCCiR1GDFsF+bK/jOD01iNPv7SblJpnOFerTI7+Xfwim3W1z4NFroz1kufCmP/TWCAsq+oiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160120
X-Proofpoint-ORIG-GUID: N-_8JvFIQ3erB-GDnBoUfoSXAKwSTw-h
X-Proofpoint-GUID: N-_8JvFIQ3erB-GDnBoUfoSXAKwSTw-h

On 1/16/25 10:42 AM, Jeff Layton wrote:
> On Thu, 2025-01-16 at 10:33 -0500, Chuck Lever wrote:
>> On 1/16/25 9:54 AM, Olga Kornievskaia wrote:
>>> On Thu, Jan 16, 2025 at 9:27 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
>>>>> nfsd stores its network transports in a lwq (which is a lockless list)
>>>>> llist has no ability to remove a particular entry which nfsd needs
>>>>> to remove a listener thread.
>>>>
>>>> Note that scripts/get_maintainer.pl says that the maintainer of this
>>>> file is:
>>>>
>>>>      linux-kernel@vger.kernel.org
>>>>
>>>> so that address should appear on the cc: list of this series. So
>>>> should the list of reviewers for NFSD that appear in MAINTAINERS.
>>>
>>> I will resend and include the mentioned list.
>>>
>>>> ISTR Neil found the same gap in the llist API. I don't think it's
>>>> possible to safely remove an item from the middle of an llist. Much
>>>> of the complexity of the current svc thread scheduler is due to this
>>>> complication.
>>>>
>>>> I think you will need to mark the listener as dead and find some
>>>> way of safely dealing with it later.
>>>
>>> A listener can only be removed if there are no active threads. This
>>> code in nfsd_nl_listener_set_doit()  won't allow it which happens
>>> before we are manipulating the listener:
>>>           /* For now, no removing old sockets while server is running */
>>>           if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>>>                   list_splice_init(&permsocks, &serv->sv_permsocks);
>>>                   spin_unlock_bh(&serv->sv_lock);
>>>                   err = -EBUSY;
>>>                   goto out_unlock_mtx;
>>>           }
>>
>> Got it.
>>
>> I'm splitting hairs, but this seems like a special case that might be
>> true only for NFSD and could be abused by other API consumers.
>>
>> At the least, the opening block comment in llist.h should be updated
>> to include del_entry in the locking table.
>>
>> I would be more comfortable with a solution that works in alignment with
>> the current llist API, but if others are fine with this solution, then I
>> won't object strenuously.
>>
>> (And to be clear, I agree that there is a bug in set_doit() that needs
>> to be addressed quickly -- it's the specific fix that I'm queasy about).
>>
> 
> Yeah, it would be good to address it quickly since you can crash the
> box with this right now.

I'm asking myself why this isn't a problem during server shutdown or
when removing just one listener -- with rpc.nfsd. Have we never done
this before we had netlink?


> I'm not thrilled with adding the llist_del_entry() footgun either, but
> it should work.

I would like to see one or two alternatives before sticking with this
llist_del_entry() idea.


> Another approach we could consider instead would be to delay queueing
> all of these sockets to the lwq until after the sv_permsocks list is
> settled. You could even just queue up the whole sv_permsocks list at
> the end of this. If there's no work there, then there's no real harm.
> That is a bit more surgery, however, since you'd have to lift
> svc_xprt_received() handling out of svc_xprt_create_from_sa().

Handling the list once instead of adding and/or removing one at a time
seems like a better plan to me (IIUC).

Also, nit: the use of the term "sockets" throughout this code is
confusing. We're dealing with RDMA endpoints as well in here. We can't
easily rename the structure fields, true, but the comments could be more
helpful.


>>>>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> ---
>>>>>     include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/llist.h b/include/linux/llist.h
>>>>> index 2c982ff7475a..fe6be21897d9 100644
>>>>> --- a/include/linux/llist.h
>>>>> +++ b/include/linux/llist.h
>>>>> @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
>>>>>         return __llist_add_batch(new, new, head);
>>>>>     }
>>>>>
>>>>> +/**
>>>>> + * llist_del_entry - remove a particular entry from a lock-less list
>>>>> + * @head: head of the list to remove the entry from
>>>>> + * @entry: entry to be removed from the list
>>>>> + *
>>>>> + * Walk the list, find the given entry and remove it from the list.
>>
>> The above sentence repeats the comments in the code and the code itself.
>> It visually obscures the next, much more important, sentence.
>>
>>
>>>>> + * The caller must ensure that nothing can race in and change the
>>>>> + * list while this is running.
>>>>> + *
>>>>> + * Returns true if the entry was found and removed.
>>>>> + */
>>>>> +static inline bool llist_del_entry(struct llist_head *head, struct llist_node *entry)
>>>>> +{
>>>>> +     struct llist_node *pos;
>>>>> +
>>>>> +     if (!head->first)
>>>>> +             return false;
>>
>> if (llist_empty()) ?
>>
>>
>>>>> +
>>>>> +     /* Is it the first entry? */
>>>>> +     if (head->first == entry) {
>>>>> +             head->first = entry->next;
>>>>> +             entry->next = entry;
>>>>> +             return true;
>>
>> llist_del_first() or even llist_del_first_this()
>>
>> Basically I would avoid open-coding this logic and use the existing
>> helpers where possible. The new code doesn't provide memory release
>> semantics that would ensure the next access of the llist sees these
>> updates.
>>
>>
>>>>> +     }
>>>>> +
>>>>> +     /* Find it in the list */
>>>>> +     llist_for_each(head->first, pos) {
>>>>> +             if (pos->next == entry) {
>>>>> +                     pos->next = entry->next;
>>>>> +                     entry->next = entry;
>>>>> +                     return true;
>>>>> +             }
>>>>> +     }
>>>>> +     return false;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * llist_del_all - delete all entries from lock-less list
>>>>>      * @head:   the head of lock-less list to delete all entries
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>>
>>
>>
> 


-- 
Chuck Lever

