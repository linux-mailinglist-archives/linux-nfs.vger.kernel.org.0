Return-Path: <linux-nfs+bounces-9603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B63A1C42F
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3298B188819C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0892D057;
	Sat, 25 Jan 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SiMimgU3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bu58DqcR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56632AF00
	for <linux-nfs@vger.kernel.org>; Sat, 25 Jan 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737821377; cv=fail; b=H5OLzs3NCJ+MIItnj0MVA45tFPsvE5Xw1VV1v8FdMPvE1IAcn5b0NAUCbOQeI0fjKFCECXxsUpZFegvck9gycSrYZtUydyYmuJmNcYBxhn4H66q8gbmxrZmrKJa/RVvgjBLdWrMiWruvKPu9wc1MlMwfac8EZ5ktm1fqILzFsag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737821377; c=relaxed/simple;
	bh=V2XJeD7wCxZnjvI9ro+wXeHbus+oKhW3od6zmOnxLXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YQgrWU45PTCSCo+bjzMV11z2nFvbMmVB6PyYXVVft6IMoG1EayFPSbY5orT0FGAHwfVbHFgLJzjhHH5PGTgOEbXs+2lKzpSAaXq4OFc2oJ8iENz8b5nh9CTCeTiknUouiVPHr78XjiyLlhE3WDeFiICUthzFH1eOOB6Wxmddc3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SiMimgU3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bu58DqcR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PCeaTS013271;
	Sat, 25 Jan 2025 16:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c/qkRpzJSeOJBUns/N3NG3VO+NhugZiw4U4XipXDLFk=; b=
	SiMimgU3q9bzwvAEb3VqiXF5sW/LI48x/KkLE58ImDW7zdXi2RjujJ8HVeguJGD4
	9rQcNHFEl375cOsWfDzrkp21NsCjQsz38Lq+d3PCGkBapo45ZU59RlPfewW8+vuQ
	+aSsFARSiL0Zxo0LxzRsZO8XiyxLFn2RstTpmf23iJPJjdYM/RH85nfsgoI8jxgD
	w9psW5TAmFIOIxF925ht416bDVawr2cnKj1LQ6BucCQ+oCmyOG/3w8qJTWHdbKQ7
	F+zpo2Qm6wR5RcVtHUf+J7QCbdRmdUnqQqHe/A7G27cpyz2ITzMGxcu9x8d7kudL
	3mgR7yWAZhZkp95chOK3lw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cpva0cxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 16:09:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50PCZ3VG036774;
	Sat, 25 Jan 2025 16:09:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd5kk0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 16:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLJPJ+7q42h+5FL+ObmFE6aGkP7RJ6FhBNOHaFPuD0IYO4QtUJyNSMMP6I2TdN/Rvq8DY2j8SJ//iNetd4+iUT29izwol381ndMeWQgexa4j9xAwPIkJHBX3HRVX2t3+9kRHs7Zqiyjl6/3asXJzW5/+uZoEjcB0s/Cw92VAkTlwWhoKJelzkJ9GW6BBjkRPN5WQpCOoeqiVKlVvOgRGeSk6MWslQEooIhV8T4L/6zrY7COqC5ZR+wXQ3QWlVhxwqgeucRvN5p4QUMKrRw835f4wgn//+YqIKKSX0Y9AUoedOBoDjjmINQrotal8uizIrKHB8QTgijeCB6ZLzXoApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/qkRpzJSeOJBUns/N3NG3VO+NhugZiw4U4XipXDLFk=;
 b=PAq4k6jbkI9oF2tLkD47LLbbAZavuqdgpkGTD1sNLZZppCxM38XNNtgEWQrzea31LMRKEdVFD+p5uYBpmstQ0UNy+2vWyiG3F7nhC6E1LoGAsdkb6oa8fMcECoJ2teNbd4iQ1I3Vq+Y3OKk7kRiSLszv8RHtvAFcdnHBu2SByC5sx6vsvV6451XXCban19jyRt3XMw0YYCZgzWGHyoYKMFC3riqUbbn0TJXJEkJ9TzrAisrcqFIK4Y4pz4kMW90FceyiOM6f2FaP/s6lLKWO2rA0D85QVE/rhpuouyi8P+NeCxatZSdIWmsFTKPVVhe03vndYhD5mas+8tjGk6JmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/qkRpzJSeOJBUns/N3NG3VO+NhugZiw4U4XipXDLFk=;
 b=Bu58DqcRiDAz7oXswXb1NPVJrVCEC83c+ja7MW5B/ITFksdV5Uv2+9rJRGWkHLUJpwkBJzuRB3B+I+960gb5qsjP+7UVe8mF0hP+nxPJYTx5bZu1JiiV7hrXuEZjdQERClBRYpqyFvVmyQ/W4f64aEnUBV4m8M4OZ8KIRccDjww=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7400.namprd10.prod.outlook.com (2603:10b6:8:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Sat, 25 Jan
 2025 16:09:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 16:09:27 +0000
Message-ID: <bd891d2c-7db8-4645-85a6-689de1462e1b@oracle.com>
Date: Sat, 25 Jan 2025 11:09:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/5] nfsref: Improve nfsref(5)
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-nfs@vger.kernel.org
References: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
 <170050643888.123525.15735019118169614157.stgit@manet.1015granger.net>
 <20250125200217.7A01.409509F4@e16-tech.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250125200217.7A01.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3dbd88-9d53-4092-f189-08dd3d5aa4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUxsK3FsSElaelBSWDdlVmhHU053UkhsK1pxc2lCb1RqVitHUWJ6UVNoZUNz?=
 =?utf-8?B?VWxyeFYyTnVEUVhuZ2I5bUJJVk1FNlhSU3pDaDZrNnJQWktqa2x4UWpOUUp3?=
 =?utf-8?B?UHpKRnlnR0JuczdrVVl2cmxjUG5yZ2JVWGRPa1E3Rmhuem1LWm02cUhJb21R?=
 =?utf-8?B?bEJ0YnFEZmxJNUFyUGR2c2x5QjJRazJrc25lTFl6V0RUYzQ3em1QZEI5WUdM?=
 =?utf-8?B?UUp4Y2s2dS85enNieVM3b1Nocng4Ty9EKzJEQk9lTHdFUGZMU2MwTXdBWVA2?=
 =?utf-8?B?NlZqSExDbHhicHhMZTkvbU5BallZSFlXSWFRZmNTcGNLZzYxcWZ4UXljL2tZ?=
 =?utf-8?B?em1taVVqNTRLc01zcHQ2MjRKNGVSRFNIb2hzVkxMN2g4clB4NTJGZGFyR3BS?=
 =?utf-8?B?QUdMVGtURG45b2F1S1NSQXFrd2pHM25Zb1ZmeTJIMVBPY2JMRVZQZ3RoV3JW?=
 =?utf-8?B?cDBCZEdFTFV0OXMxUFdrZjFrNGN4N2hBMGI3WDhZR3hOTml5MzVGMXRiY3Fu?=
 =?utf-8?B?OHB6WkZaWmRIOHc4UHdoNWNYMld0RXUwU0U0REdDTEdQT3RZSHc4cmpPeGVj?=
 =?utf-8?B?c25aOStoMW9wdThsZExIaWJMdkFkV0txcUxWSDZ0dUg3T0pYZmJ0OHRaS3lQ?=
 =?utf-8?B?ODVYK0lhem84eGM1alYvamdTNm0waUxhR2lTWEhXWnExUWR4VTFBaDREbVdz?=
 =?utf-8?B?bHFhdTNka0psQWtvSHVlU1pnWVB3SHF4VWxYZWhCU1FvN3U1VlF3c1JNS1BJ?=
 =?utf-8?B?VzIyaG14SlUzQWRDR09WbkVmQzc5VnBsRGh4di9pdXRMcVBiREtrK0FlSFY0?=
 =?utf-8?B?bE52RWFhY3JTU1NHODlIQVFBcVczSjdwZXVwb3F1K3p3NzFaeDh2QUcvbnhZ?=
 =?utf-8?B?V3U4clliemVHdGw0VHIvcFd3V0VsQVptYms1WkRmdVJSS2ZQdWcvVW1GcjdB?=
 =?utf-8?B?RW5zeE5HQ1lHN1BKSXBzeWpuYzFFWHlXc2ZIRkV6b3o2Q0FrdFpkYzFOQzhK?=
 =?utf-8?B?UUpYTzkzWTcxR2ZmYVY4K05zY3FiVFhxSnlOZjU2eVFwYVFDa3ptWXVRL2Jj?=
 =?utf-8?B?QlJVMmkxYWZDZGJXNDdEaHRjN2J4cnZXT1UxYWpjdEdjS1VvbEFOdFR5V0xZ?=
 =?utf-8?B?SzNYdmlvWGhmUXJxMjBvZDR3bXUxWUVxU01qWUFBM2hueUdYVjlkN2Z4M1ZC?=
 =?utf-8?B?ak9kSFhFMUFwVXlPc1JnSGd3d3FGcFJTNjNhRmw1U1Nrdmk2RENRdkxFelNY?=
 =?utf-8?B?RFhCaXg0VENpUFBndVgybHNSN0t0Q3dRbVpja3gvYjkxS0VxMjNnZkpEeEUw?=
 =?utf-8?B?QlZ2YW5FODN0MG5jL1cwK1o0dUgvODB6TFRNSEFUNzU1ekoyMGhPOEtWTGdj?=
 =?utf-8?B?ZStLYk1WVm00S3VvZHVYbklxQzE3K1lmVlEvZFZlOVRtQVIwVWFFSXk4Z0FH?=
 =?utf-8?B?UzdSeURXK1NvMmZ4Q1pGQWk4c2NLejFKbkhKeDdZcnoyQVN1WWVvMzhVQkZj?=
 =?utf-8?B?ak1xUGJ6SWYzV1pQYzR2Wk1LN0xCUkNPc3VIVXg5OG5kWmJMNlVXb3pUWHZ0?=
 =?utf-8?B?NTg1eGlYWGNqMU1QUXlLc1BFT3dTWXdGVXNmbFB5OVo3a0JXWlgxcGlZcm9q?=
 =?utf-8?B?d0czNnhMOVNqNDBhejRDVms4dm5CSmhLSllhYXdWb2NQeUMwRHo2QVlsYWwx?=
 =?utf-8?B?c0h3Zy9lelordDRsZENOVmExYmxmelAxU0VRc0xJUlo3L1FKbUVjK1ZQdGR4?=
 =?utf-8?B?VVBTakVTcGZlZlk0UEpLNHRIZEhlM0xXLzhjZ0g4WHBveW0vOWdMS2dTOWV2?=
 =?utf-8?B?QXkwVHlCRHZkZDQxL2hFSnhNMzNtLzdNdk91WVdaYy92SjJiWGdYR3lPYzdC?=
 =?utf-8?Q?FNLlgB8Kr2UVU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUp3TjlVTHFRNnM5czQ2Ym53SlhERzVBemtDN1JCVUFlQUFiUExqYWxyMVFs?=
 =?utf-8?B?LzZmdmRWZDg2Y3dpcExpaW9Sb2dhUGRjOWF6QXdQVTVzRHFZcGp5K2ZkelZS?=
 =?utf-8?B?THVzYkJDajVreDA2OXFhaWlHN2FiUU8vL2REMkxPTjYvNThaTTNMVk0vVHhx?=
 =?utf-8?B?Z1B1ZkZkQlZFS04wOHBZbUJVdGViTVl1Ui9FTnlLQ1ZVTXEraW5ieTU4NmxH?=
 =?utf-8?B?b2RSRHZFSE8rOGlzUXYyaFhnaE1rc3JhSmFyVjRsSThkeWhIamVpVXU3TVRD?=
 =?utf-8?B?YWgra3BzRkpLUHBwRlMrV1RQeFRtekhQN3Z1NXpoRFl0L3VwZkFNMWR0cTJq?=
 =?utf-8?B?cm1wcG5WTzV1T1VJVktSNTdJREFTb0NPZVQ5UW9hK1hrRTF3QzRiSytId1Jx?=
 =?utf-8?B?S0drbDZXbFcrL3VKOFROVFNicUNyL08rRnowRk1uQkJYby9DWTI3K25PRXJn?=
 =?utf-8?B?ZWhTZXJPb2xGR25FYXlvUVNuOGg2ZWZseFFlWGdETFB2cEFpNW1HWXNtUzU0?=
 =?utf-8?B?bXRpTVYxRVBHYkxOS2V2di9NNFVSa2FQazdYeWhZM2d6VjhMTjNaMTVMRmpI?=
 =?utf-8?B?QklQN3F2eU9IdGtlc0J6M0FOYjVna3ZJT1pMclFHcUh1N2JPYXFPblNDcjZI?=
 =?utf-8?B?RHE5TmhIU3gwZjhVK3Z1UG5ObFR5YUxpNXJFdEdnTi9kZFM0emZsUk5KeUFj?=
 =?utf-8?B?d0ppV0t3VVBuUVY1WGFXeitCaHRLbHpnbmZ1YVA2MnNBR29GcEhHaFNvNnE0?=
 =?utf-8?B?eGwyWWdqVk91QUxIZklNak5oa2plaGpoY2h6aktRUkVVamJtbEU3YUZoNTV4?=
 =?utf-8?B?VStadHFKSGZIRTRPSlFNZ0Q4ZEI2SnJuMlM0U3BWcGVmbmVCNStrTEdmaHVG?=
 =?utf-8?B?VWgzRmRseUVYOFlsZlhRczNTclBUTFdrbURQVVphUVNlOGRwWUtBNmNvU1RG?=
 =?utf-8?B?b0ZFU1V6T0p6eXVLTUNPNHkvcG5mVGVUK1NUc2h0ZE9oQ2hZOWluQlhOY0ZX?=
 =?utf-8?B?UjRqWHJxWjZZUm50SWltdUxnbHZScjlSYjlCakk4NEp3ZlZmSDlhdkZRU3dH?=
 =?utf-8?B?R1NvSWRERmhQRnhoYkw0TTBvWldqK0NIditmZ0NGQzRSbklzMFQ3SDZzb0xO?=
 =?utf-8?B?NW9UazhybDlxa01VZ3dZcFdXVDZ6NXlkZGdTVjJzWjR5dnB5aXo0Tm5VWU1I?=
 =?utf-8?B?OXMvRWV4Qm1EdnRjOXF5Y1Y5UzNReHRZb0RHYWNkRFJUVktEVG9MRHFOZnFl?=
 =?utf-8?B?ZllvOEZiR21LSEt2N1BaT1Yrcjl3VjFkcUpHR3JZUkU1V2tpT0JjR3A2UFB3?=
 =?utf-8?B?Q0NvUDBZQndldGt4SW9RQjV3b0dXWkU2cUY1Z0F2QlZjRHpwQ3dnNkZXaDZh?=
 =?utf-8?B?MHZvSmlsRCs4VUMwR2VDWWVSYmJzZXRONC9yaE9rTTJSalFTZnV1MG40QkRG?=
 =?utf-8?B?Yy9LYmdVNk50NmYxZlZzWkpETHhEZVR6dkxYeXNkSUlZYTlFZkxSTUNqWnFz?=
 =?utf-8?B?amQwUThUVXZrUHhVZFdtUjcvZUpyL29UNjdUbHlERmVtdTB3cGFKcFBBYy95?=
 =?utf-8?B?Qmp5YWgrUklIYWxGMTFVTXNtbmdpT1hsZERURkRVNWtIS0I4T3pvS2dnQjJE?=
 =?utf-8?B?M3dGQm9rQUlTa3o5ZU1MY2lBWDJGdjdqaXhHU3BhSnFoRFdJVlZTMW5RejQr?=
 =?utf-8?B?cklScllOdlM5VXVsQ3VoNGFXVTlMVDBwMWlUWEFNbkRQMDNjbjB6K0M4MUZN?=
 =?utf-8?B?OW5OZ2cxV084QU5XUTRBRDNackh6UEgySDhsOVNvM29KWmVkM1RIVTlpd3h3?=
 =?utf-8?B?UWNmZldMQTVGNFUrM2ZKeDV6SzB4ZXNhaVdsSkFJRjQ5VTBsUXNoR1JYN1h6?=
 =?utf-8?B?RXJDVU1EN25pNWpWakdHdjJxMXZPYWxrRXBzUWJwNXFaNzhQRjZyc0tzeDVH?=
 =?utf-8?B?bGppMU5GdkZrQndBdjBmdzd3QlZCTE9YdUg1OWlNUzd1ak5KdlN3Vjhkd1NH?=
 =?utf-8?B?ZGpTcnJlejJIb0ZUWUVIRFB2cTZmcXVWRk9RMUtRSTFrRkEvZitJayswU0FI?=
 =?utf-8?B?ejNWbmNGOUEzLzQ2SkZNVS8zOEk2VUpnak5Rak5QdW1JNXpBZW4vbEYyTEpC?=
 =?utf-8?Q?OIDDw0+rpuYS5FT6Pr8lKOULh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2zG8hB1rBjOzuub34Fx8nrbGewtSa4/aTl00uFOCM2MPi8qo6GxBZ8TIIQFxK9xOZqe/UyN1V1XFVGk4SsNO5hC8J9kaAPnvbLGKQ7/llrBki9dsIWyFXFTjbQTqImTVvOkjp5/9yE+TfcwgCzYVAXUcz0uvrB5OPREzsWAA8ci4ORz/i1NhKW/TC1qwUcjhUemYKZMoPJSSo70G/dAF4egqDGTpEI4VRmv3vnGpLIPHx1etxDOhUK/6sxcX8VFRTuV7GmF0sSZv0P135o1gvzHLZXO2jODuRA7gnAWMqu6kCGbEexLxrFDDqb1BYNPm2LXgpnDLuVHIRfRo6WZvkcxuwW5Gzl9/XQXpXVck6Sk1wyokdnajk7uvJx/4N5vZifYwyKob5iz7XdPqAd9MI7tlwQR1Hcbb60tVQG/H0oRuY5YrVQFyPC3w8GPpA1dLP2y1F42ltfxNTnF7u2fFn3GZDH6QsIkhEWmf8J6BC0fXzx6S1ukOu8ESUaIrqv+6igzjl5cf+ElK+fMeth1MSaeH4uPfZ8assL7Qprrth9lXs2DQM8ebTD5SzV9ygOg31FR37niQBmQ+ngX+oxp1XV68JbMSKTqcLXGcGSMXGOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3dbd88-9d53-4092-f189-08dd3d5aa4c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 16:09:27.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFEujimQwBZcbgrXvz++8qUB4bitbbhNUiCZiq/EAtr74it0RXKQytAqrCt+vNO6ivo3UWhyg9mA8R3sYAFGGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501250118
X-Proofpoint-ORIG-GUID: Dtv51hoGtaYJpw-X5IU7PD60uyj2YE3Z
X-Proofpoint-GUID: Dtv51hoGtaYJpw-X5IU7PD60uyj2YE3Z

On 1/25/25 7:02 AM, Wang Yugui wrote:
> Hi,
> 
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Neil Brown says:
>>> ... I found the man page a bit confusing.  It starts off talking about
>>> "referrals", which are suitably defined.  Then drifts into talking about
>>> "junctions" which might be the same thing, but aren't defined.
>>>
>>> The intro suggests that the admin can use "refer=" in /etc/exports, but
>>> doesn't say why they might want to use "nfsref" instead, or how the two
>>> relate.
>>>
>>> Description says "Other administrative commands provide richer access to
>>> junction information." but there are no pointers in "See Also".
>>>
>>> The --type option, we are told, can specify nfs-fedfs but there is no
>>> further mention of this, or any pointers to more info.  Maybe add
>>> "(deprecated)"??
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   utils/nfsref/nfsref.man |   60 ++++++++++++++++++++++++-----------------------
>>   1 file changed, 31 insertions(+), 29 deletions(-)
>>
>> diff --git a/utils/nfsref/nfsref.man b/utils/nfsref/nfsref.man
>> index 12615497a404..1970f9dd4144 100644
>> --- a/utils/nfsref/nfsref.man
>> +++ b/utils/nfsref/nfsref.man
>> @@ -53,33 +53,37 @@ nfsref \- manage NFS referrals
>>   NFS version 4 introduces the concept of
>>   .I file system referrals
>>   to NFS.
>> -A file system referral is like a symbolic link on a file server
>> -to another file system share, possibly on another file server.
>> -On an NFS client, a referral behaves like an automounted directory.
>> -The client, under the server's direction, mounts a new NFS export
>> -automatically when an application first accesses that directory.
>>   .P
>> -Referrals are typically used to construct a single file name space
>> -across multiple file servers.
>> -Because file servers control the shape of the name space,
>> -no client configuration is required,
>> -and all clients see the same referral information.
>> +A file system referral is like a symbolic link
>> +(or,
>> +.IR symlink )
>> +to another file system share, typically on another file server.
>> +An NFS client, under the server's direction,
>> +mounts the referred-to NFS export
>> +automatically when an application first accesses it.
>>   .P
>> -The Linux NFS server supports NFS version 4 referrals.
>> -Administrators can specify the
>> -.B refer=
>> -export option in
>> -.I /etc/exports
>> -to configure a list of exports from which the client can choose.
>> -See
>> -.BR exports (5)
>> -for details.
>> +NFSv4 referrals can be used to transparently redirect clients
>> +to file systems that have been moved elsewhere, or
>> +to construct a single file name space across multiple file servers.
>> +Because file servers control the shape of the whole file name space,
>> +no client configuration is required.
>>   .P
>>   .SH DESCRIPTION
>> +A
>> +.I junction
>> +is a file system object on an NFS server that,
>> +when an NFS client encounters it, triggers a referral.
>> +Similar to a symlink, a junction contains one or more target locations
>> +that the server sends to clients in the form of an NFSv4 referral.
>> +.P
>> +On Linux, an existing directory can be converted to a junction
>> +and back atomically and without the loss of the directory contents.
>> +When a directory acts as a junction, it's local content is hidden
>> +from NFSv4 clients.
>> +.P
>>   The
>>   .BR nfsref (8)
>> -command is a simple way to get started managing junction metadata.
>> -Other administrative commands provide richer access to junction information.
>> +command is a simple way to get started managing junctions and their content.
>>   .SS Subcommands
>>   Valid
>>   .BR nfsref (8)
>> @@ -135,6 +139,10 @@ For the
>>   .B add
>>   subcommand, the default value if this option is not specified is
>>   .BR nfs-basic .
>> +The
>> +.B nfs-fedfs
>> +type is not used in this implementation.
>> +.IP
>>   For the
>>   .B remove
>>   and
>> @@ -163,18 +171,12 @@ you might issue this command as root:
>>   .sp
>>   # mkdir /home
>>   .br
>> -# nfsref --type=nfs-basic add /home home.example.net /
>> +# nfsref add /home home.example.net /
>>   .br
>>   Created junction /home.
>>   .sp
>>   .RE
>> -.SH FILES
>> -.TP
>> -.I /etc/exports
>> -NFS server export table
>>   .SH "SEE ALSO"
>> -.BR exports (5)
>> -.sp
>> -RFC 5661 for a description of NFS version 4 referrals
>> +RFC 8881 for a description of the NFS version 4 referral mechanism
>>   .SH "AUTHOR"
>>   Chuck Lever <chuck.lever@oracle.com>
> 
> Very nice info.
> 
> some test result here and then some question.
> 
> nfs client / nfs server: kernel 6.6.74/6.12.11
> nfs-utis: 2.7.1
> 
> test case 1 of refer= (only single refer= in /etc/exports) works well.
> #/etc/exports
> /mnt/test *(rw,async,crossmnt,no_root_squash,refer=/mnt@192.168.2.75)
> 
> test case 2 of refer= (add /mnt to /exports to test crossmnt) faild to work.
> #/etc/exports
> /mnt    *(rw,async,crossmnt,no_root_squash)
> /mnt/test *(rw,async,crossmnt,no_root_squash,refer=/mnt@192.168.2.75)
> 
> test case 1 of nfsref failed to work
> #/etc/exports
> /mnt/test    *(rw,async,crossmnt,no_root_squash)
> # nfsref add /mnt/test 192.168.2.75 /mnt
> # nfsref lookup /mnt/test/
> 192.168.2.75:/mnt
> 
>          NFS port:       2049
>          Valid for:      0
>          Currency:       -1
>          Flags:          varsub(false)
>          GenFlags:       writable(false), going(false), split(true)
>          TransFlags:     rdma(true)
>          Class:          simul(0), handle(0), fileid(0)
>          Class:          writever(0), change(0), readdir(0)
>          Read:           rank(0), order(0)
>          Write:          rank(0), order(0)# mount 192.168.2.74:/mnt  /nfs
> # mount 192.168.2.74:/mnt/test /nfs
> mount.nfs: Stale file handle for (null) on /nfs
> 
> 
> test case 2 of nfsref(crossmnt) failed to work
> #/etc/exports
> /mnt *(rw,async,crossmnt,no_root_squash
> #mount.nfs4 192.168.2.74:/mnt /nfs
> #find /nfs
> find: ‘/nfs/test’: Stale file handle
> 
> Question 1:
> refer= in /exports yet fail to work with crossmnt?
> 
> Question 2:
> nfsref yet fail to work, or we need more setting?

I'm afraid all of this has fallen out of my brain cache a long
time ago. Can you provide a little more context? Can you say
how you expect "crossmnt" to affect the action of a referral?


-- 
Chuck Lever

