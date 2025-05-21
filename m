Return-Path: <linux-nfs+bounces-11849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C5ABF5C7
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 15:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361B4188E9C3
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F2DDA9;
	Wed, 21 May 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eav9L8iX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nv9Q/Fty"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E7233728
	for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833287; cv=fail; b=ACMtkck2T3/43RilWCfNwI8+7X567gF/2OVY9T3G5n0RGaXULXUz8OgobeVmVtc0TN+jUSev8WImI6RzcKoxMa/yWzcPi3j6CZ0uYVq0vrd4WnFm7k6pzQy8sUdF4BKzpLj40brZXMV85La4F0+90hqMQ9LBuuAFXqlKMaoRhUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833287; c=relaxed/simple;
	bh=GEeiw+xsTOBJkc8X/OyUrTksptktn9rcX7HehUlm5c0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aPC4AOSqAtX8dScjMpFOZfSratLOqHHTkmjlL2526CkYOhc6ptIw+WX7bnVOZ+Mq/itw7IIQ/ICyzi+c5ijdH7ZhA+mLWRx2ZkFyTpvxtWHwJswbUGtzGZXrGn2F/NGP7Ikl05o7pxTAk/8bBow0LSho9yEeKWpvs7FLfrYkTkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eav9L8iX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nv9Q/Fty; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LC7oWu016514;
	Wed, 21 May 2025 13:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o5Xjd9ijw3Q2T2o3PPgkwhaC8dNs6lRgaPzRSIoiF3I=; b=
	eav9L8iXgv8UnD1/uZTXhyPe8GXifSGWo7yMh+Mp2/6GhnMp7N4OGfTbqkNmejET
	WHiPrcMXCoi3I6BENkC70jx2yUU+01Ht/bjqSeTTG920vJnkQ2R8gsRnUXcPXVyq
	69RJiBrdCJom2d/Bn0Z54ly03JVyN44MVkvt/inlsP1lFWYNu8dWx/DZAOIZY/z5
	Rv3fhArNk060zI82sO2oQ5dx2cfjF9iqxy+RqWNB0bpx/xZEjsiRK7DPNj2VbLMU
	V/dtiSXJ9N0g7w/p1aSKMibUui/hrPZy/ngHrM7hNqxHyAdhqTTkd2yIp05LN1wY
	IeGkmNpdQHO1eifq2OLxMw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sdw0g8kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 13:14:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCMVY3032307;
	Wed, 21 May 2025 13:14:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwembdex-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 13:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUeNeW4+aRvM5//OuOMbOcjYyRgybb7m0JbL0MgKRn9VaKAHlXjOxgZKF66zzCGNBEO7C5nvaqzYtvk8aR/ivkkha4zsfuZGwmwzlSJqZ+aNMGy6kcZM0S2Zd8GnWkfnr17nTrUqBuQ+n8G5VMrFIDvFg8mU+N1pkjjJLBg9BQRcE8cFF4SGf1TemrUHsIrdf3aMX81ANl6sHlUyOlPoJaRem4kOxSO8me6V0gdwQFMuhb+JGhgoMCxPVP1FD5pnSpMyK4RG04G3A+pjLtCEqW7XvXt2e1wUBR+6oait7CAdQutSXT1/SGJuzTKb3rEKYZ61a3VSRVcy7gkOdPCxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5Xjd9ijw3Q2T2o3PPgkwhaC8dNs6lRgaPzRSIoiF3I=;
 b=g04SQbghXe8JlsUMZ+NEuA70SooP4McOIQESf5bKzWvc19LD5fgiu+CazU1CmdvnPmrJR5GaRP3sahYbiLt/x6LmGKkKqIycreA0PnbRNY0bg0Fi0Ozk7i6efVn+hN5Wb+gbxURPU3D8nghyD6Jr73TOoUlWdACKM3LNM1QhHZP1xgHeoMmM1I7wqsvWxDgMZ3sMTJgkKPuNOw2cO7xEdCbWkh2wZv7YyG7hrvexk898HpIG2fJFPsquSo66CSAYZc4UB2JgP+f/QVaaek1rqIHPjoaVZGigiJyDxZDASsoCNuz4WHz3lG4Rj+vwOZuxB6YqcrMt+a8HwPBb8xHTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5Xjd9ijw3Q2T2o3PPgkwhaC8dNs6lRgaPzRSIoiF3I=;
 b=nv9Q/FtyI48JqIJJOsb5fbSq/b+RoxdRAMMYH6KeThAlmQ7NztaXSbaFw7hUlLV6CpRM9TSB18RNqIWr4pd2qZhxt8byAQ4uBMfcJeohAQDzb2xfsQNP2qxPeXEKSHGArMyEhlY4DAxIwt1r2a/WJ8iuRfGX7OApZkBMpYbnoic=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5997.namprd10.prod.outlook.com (2603:10b6:8:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 13:14:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 13:14:35 +0000
Message-ID: <377b9fc2-98f2-4a00-97ea-e1eb4b4d8723@oracle.com>
Date: Wed, 21 May 2025 09:14:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <CAHnbEGJJ0YJzyd525e4q6viwXXntz58C5iAGE-RQ2m87175CmQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAHnbEGJJ0YJzyd525e4q6viwXXntz58C5iAGE-RQ2m87175CmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:b0::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af68b8e-65b2-4213-1720-08dd98696ea2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K2xHMXZJZW1adGhtb2UyNDFpdUhSR0plUEZQYWRxL09IOGh6akQvV0NIbjF5?=
 =?utf-8?B?d2g3a1RaV0FnTExGYUhSVzRhTUgyeGpNT3BDaGFYUkQ0TVFMT3p1VWU4bkMw?=
 =?utf-8?B?dlVaMGFaRC83Q25rYkMxT2ptNVZZUGVoa0hYTFRrNGlFY0Z2cEF0WGNFNEJs?=
 =?utf-8?B?K2J0eGRJVTBDWjM2UFVWczF1Sy9RamF0QlZWemNMZXl5ejExOXErVysyVm82?=
 =?utf-8?B?K2pVTDd1Qy9ubXNnSFFZZ0xtY1AwN2RFM3pRQU1OamZ0bndiUEJJUVo5UU1t?=
 =?utf-8?B?cm0ycFJ0a29TVXk0SUdBSHNGYXpSMTRHL0ZWUWJnQjFGZWRSNlVYYnJSRkNZ?=
 =?utf-8?B?Y2Q4eU1zc2s3VHNXVUNPTWVuNGJCbFRGaXFIRGFBeVVaWDNudW1uVVovbjlW?=
 =?utf-8?B?KzAwcWQ2SUhOTEp3alRiUlVaWjN0REw0V2MrSjAzV2lPdldsVlQzUFNyWXJ4?=
 =?utf-8?B?blRqREJ2TjNSZk90TkZrVklWcXRNRmF6VDlXb1RWSXRvMDRBclNpTnppemFu?=
 =?utf-8?B?MXRZTnpENW9HVUUzbDE4V3BnZ3ZWa3ExWUNSNUt2ZkJNcm12aXZlbURLWHpu?=
 =?utf-8?B?TENSdW56MWd1dFA1TmpsL0o0S1R1STV6Y1lJa1h5NXdUdWhrME1iV3E2Yk9X?=
 =?utf-8?B?aGcxY21WSlFyd3l3Wk5FUFNXM3FoVkVzWDhRQWpzUzhsTFBFS1ZucFE0dE5G?=
 =?utf-8?B?UVhTMm5TbFJsOVg1L1pQc1RDSkdhT3htTlZtS3g3WFI2a21QSVhZZFlPSmxN?=
 =?utf-8?B?VVhuSVQ3WENWUk1uM0NwT21Hb1FWek5NY1Z0Z3NtajNlYVEwMlA2cXEwdFh0?=
 =?utf-8?B?dDZmU2doZUN2VHJSWVZkYVVYZjYrNDFRZlNsUlJPRnpZSmU0TGtBb1ZKazJo?=
 =?utf-8?B?RmJXRFNVcWtNM0dicklHbU9XeXduYWQrTWhBL1JZNWY1U3RXOHFGWjNkY0x1?=
 =?utf-8?B?emlSUUYrUjhtZHFBbGhPWWp6OFd4aEdBTC9DVlVtRHpBWHQ3SUd1akFVNFhr?=
 =?utf-8?B?WExYQWh4d2FDMTMrQ3oxY09YN1gwZjJWQlFGQjkwTnQxbG5kNmUyYWY3MEJG?=
 =?utf-8?B?SzNibnc3WlNpeGwrQnMvVWdiZ3p4UXg5aWhEeWdCTS9nMmZUTjRUTWprTmtI?=
 =?utf-8?B?djJkQ2Mwb1hGYkJPYndMSVZMZ05yWXVHMGdvRzVyRTBlRXRyU08rTG1tOW83?=
 =?utf-8?B?TzFrMlE2ZW5Zb3JKZC9FTmM3dGQ4MHBEKzlTQjZYR21hN0pzYjR1d29WelBW?=
 =?utf-8?B?SlgvcjhjTDlxZ1c0TTZrVmpwVFFMb21YZkxNMjlNeW11OWlCNlNwYnhLLy9u?=
 =?utf-8?B?dHFtQ05KRlRLbEtwNEVKVCs5dzAxalFQZkFkSzlrVzdnc0I1SGtnWmsvOHZU?=
 =?utf-8?B?TmpCWTJyZ0pIWExDYm1rUkRzcUd6emt0SG10bDMreXFWZEFSSjVPRDAvYWNx?=
 =?utf-8?B?V0h5VEE0di9YeVl1bDhobjZjYmtxLzE1YjJ1V1JKRGdpNy91Q1BwU1JQSUhq?=
 =?utf-8?B?dFFJbmRpNVpUY0hrZjVRaXF4Q2tnTzhGc1Y3alJlZWdCMFU0UFR6NWx0VzAy?=
 =?utf-8?B?M2w0bHQ3NHZKWjFmZ0haN2U4NkgxQTkxK3F1ajV6QW5jNnhNeHhFK0dVQXcv?=
 =?utf-8?B?TklmcEZveFJPeVByTEFlcVVmYkw2V0VPM1ZKblNZaDlXLzVKZmIwVWgwOGdE?=
 =?utf-8?B?N0xieWNIdUFWRkZHTzZRNDBtRTFTUmcyVVdXYWs5Rit2aHRuRlFQcmN6NkZ2?=
 =?utf-8?B?bENpK1dxaklNeVpPKytWM1Q0NWJ4ZThIdUdXZnpNZ3QxcG0zbm9KRGhkNFhw?=
 =?utf-8?B?ZnZNa0V2R255dy9DSmg5ZndJNWF2dzJMM2tZaU1xTy9uRllzL2c3Skh6dzlu?=
 =?utf-8?B?OG9mbVNTYWRNdWVVbjlpWUVjNjBjSmpVbDFJWW54R0lIWGl2MmViamFJOXZK?=
 =?utf-8?Q?JjrNOnSrG6k=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V3MzakoxWkxMMmFEVFUycmlzNUpkdjVmRlpLcEJ3UXdTSjdUd0ZqQU52RFdj?=
 =?utf-8?B?cEtBMTRiZWtCY2puazArTUs2bGNaNjRnekZXN2JZamVzYlA3OHBxWDNvcWk3?=
 =?utf-8?B?WkNPN1JOK2E2emg3U0puYkhVNkFqNjN1UG5JeXFwcytWMlN2ZVFwS3hYQXVx?=
 =?utf-8?B?ZjVCdlpXSVMvYm12RXNEa2RmdXNBN0RYMlVXT1FaQTE3M2ZUUFdtazQ0cy9E?=
 =?utf-8?B?Rm9ZTHRwR0xsanQwVWtKbHpZUVBJUzlpNStnMHZ4dHRNaFc3VFdrYjZ6OFdF?=
 =?utf-8?B?V2dNNWVRQ2JZc0lPRjlOa3BHNUUzTEtSbnBoMXliaVFWeHAvRmwwbVZDa0hG?=
 =?utf-8?B?VS85aWlxWDBYN2p6TzRoQjNWbzV2L1J3QUx3Ym16am1obDhMRWhodTZkeW96?=
 =?utf-8?B?THJ0QUZLRERZbFg2WWF4YytmV2VCZkN0WWNCdi9OUVRnZkJHN2Z4WWxNb20z?=
 =?utf-8?B?cTBKUmR5YnJGQkRjL2tmL3hYOXVJMUE1TWVSdGlDdDJVY3AvNk5xRk1jSEVv?=
 =?utf-8?B?aDFnaTBBM0I1NFlZR1d3T0RTQzZsSGtiaU9DVHlnUDFUQUNUUjZ5VW5ZTkhy?=
 =?utf-8?B?Tm9Mb0Z0bmo5WXRidHdIWWs2anhSdWZaVW5XUldXQWJ2RHVXNXk0eXR3TmpH?=
 =?utf-8?B?cjRVSG5NblRVLzVIVElSODl3empicGFxc05adnFKK0dXeURERDBkc2pUb2M1?=
 =?utf-8?B?dXZNYytGeUVOU0NkZnhUbmJ2dzJQQWNwYUpqaE1icnl6VS9vcS8zR29ZcTY5?=
 =?utf-8?B?SGVaTmo4Vk1zM2pNbHJCT0Vvc3dsMjVhaUZlb2tjVEl5OEJzdi81dnBMaFZm?=
 =?utf-8?B?ZG1DeUZwa2N2ZEJBNFdjb2RaaW40NGl1REhBVkRXSi9YRUgweGN2VWlYSndK?=
 =?utf-8?B?bW5kRTFSa29VWW01NW1VbjNLV3hpcWRjdGFhY3VsR2lZRmQraTRwSnJDN2xj?=
 =?utf-8?B?Y21LNU96bnZZaHl6cFVzODBDV0N0QjNQNjk5Zi9BaExQY2FvT2MvaEhYUC9I?=
 =?utf-8?B?aW0rck1SMXpVUkFIM2xkNFdMU3RNTGh5MzJtcUNxc0F1aWVsSFZ3c1ZBSGRh?=
 =?utf-8?B?RXZEdElmSzBnU0MxRUJ6aUZGZ0diZXEvaGRsNDhyMk9ZdXExd2p3R3NWUUFC?=
 =?utf-8?B?TU5rTEF3d1dQdVY1cWtkajhDWXAreVdqMFdYQ3loSFZqeUdaQjZrb1FNNmRY?=
 =?utf-8?B?eFNrK2FFNDV0K2pQcjVJaC81WGsvVVBsM0Y2OEtmSHVzTk5VWUg4SjY1VmJO?=
 =?utf-8?B?RHNTNlJ1N0lIbGVWUFBxQXUvVVdRb1ZVR3RuSHhudlYyVlRGdXhFRG9kSGVQ?=
 =?utf-8?B?QmlNbDlNQjhUdExCc2hEMFpSWDJudnJqb2ZZV0MvZFQ0T0cwcWpHNjBDZmo0?=
 =?utf-8?B?QkwyWnBpQ3VkNHZ6Y2crakZMcDAyQnhHQXNiQnpuVFhJWXhhM09OdThOTDZk?=
 =?utf-8?B?c0FoWmVxYmdFWTJ2cTZnMlVjb0JIb3J4L3NoU0lMd1hON3phNzB3Kyt4TlI1?=
 =?utf-8?B?L25lRXFiT0wrbTZXVG8zb0Yzd2hMNnRleGIyS3VGeldXZkQ4TXBlZ0Vxd3R2?=
 =?utf-8?B?d3dCRmRaa3pYWDZGUEdZOU9tdVdNalJucFRpbHdDWFFZWTJpT0tncnVsRnZo?=
 =?utf-8?B?Vyt2bW5za09rRWFLZVZNa2JQV0tVU1ZvWkV2WEFScDJaMzdSSmZaSmJZbkZm?=
 =?utf-8?B?MTZTSXJQcnFPU25kb2FNRUVmWlZnWE9TSXY1L0ZPeThXSVI0dThoK0dqRVR4?=
 =?utf-8?B?dTJGeTI5cm9WMUpKdnJ3UTdqNWVoTU4veTd3M0ZYNVVzck9peHJuUUQ3NVFs?=
 =?utf-8?B?dG00QkZ2S0E2UGp3bVZMbHZWTFJFRzlZMG5BQnkzQVFKRHdkdWFVSlBZTjBU?=
 =?utf-8?B?Ty8zb0lpQVZkMU4vYXBmWWp6NG1XOHQ0V2dFRGlScjJFSGRZUHlIaDlxZ1A3?=
 =?utf-8?B?VUJsYU5iRUh6ekZnRUxacjhiZnR3bjlKaVU5STY3MFo1NmVTNVNYbStWMHlx?=
 =?utf-8?B?b0c3a3NGaXFDeDI3MXFXNTZ0aDBzZU43RVlNa3Y3RkQ1VVdYcHhyVFIvcldK?=
 =?utf-8?B?d0VFQjFzdE1rbmY3cTc2UnhKZjN0eUtiakhCa1VyYVpnZENsM1QzWHlLWFFH?=
 =?utf-8?Q?tOsVl1vM1L7gzvd+a47KA3OOx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	byCDrSlhKxVy7o8mueGOLKq3SA5wj4X/r0rh0+P7w9bOe5rvLbIb+fkCO5fVs4oBwrJC/vp0qjXAIou8CUY0VetMmgsTMCt58uJTMrc7uS2JQBXQkzUZ+tn3MQu6xG0gyPK4XuDEdGZKsxrD2nEOrkMCTRY9fRUb7Vwkm2ZLHYkBKQgwMl4+g1zZp7qsWxKeMSYj3ukoz+uqrBOr9xFKoXHgMs6VYY5+t1+whtsSYwGNNlcrMakB+jA3zhfGVo49K1SzBg97UJyIbIjNRyevM94AVhj93L+xvuRkTtW1WiWDTO2gwbbnkm8mmw0cpmWk6NQKjLzk68QZfl/5jFxl8XE4VIOPLx18Z3H/Dg/CSRY1Dt0XdF65N9wDOsfe5c7gSd/5o0WQ4VG3bDGNWWWuyNjTHZf/SWTU0p4d4jvbX7+WBWiz8SA00q/8H7cF1WpXMm+xH4+iclEKP89H2Hzt5I/4Cd4VwIWnpfanGv2n2aQI2r0llTwWeZo22DsEOc1MZHD17XORt6iG9hO1VZgYz4x5XhkzOxl6LASQqC6cMI4Cjco0DlCBJNd1yRhdQ7xE+AjDDM6caHa2d4hR5UsiUq9tFvr+Fo1kHYy/SUV8fVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af68b8e-65b2-4213-1720-08dd98696ea2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:14:35.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzENEskTDbdARebwCreySa0Cwz+63Dgvl2yamodut9TSqU1uVd5BfqQnpOfYKi40iOOafeUJOfizPnnY+DBhHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=843
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210128
X-Authority-Analysis: v=2.4 cv=ebE9f6EH c=1 sm=1 tr=0 ts=682dd1c1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SoLk730hQsyq8pEsXTwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyOCBTYWx0ZWRfX5va5vvNZba52 oLrcslq1Co2sUZEbPjBqcGb0cxxiMDOVfjmx/ybSbINOkH8jGXsU4JBVUBlwMX+Oqy+mTGKsYkv nJePANQyF5dTCMbdz5FQWR6+X5wR1ka5bbtpLhIM24WLN8s6CSbG2NF+V8w9Hci/em7UpKX5atc
 YIzO6jfi60v7jyShdA4/VUUIUwvjHIzH4pCz1ZUzOMrTLzRQFRUdtUjibO4YzpFtJQnpcoupzOH aQ1VyJGQlTWdmvgWk89qEimi/Kp8rFRF8u8sK6BYkhPTqDDWewM9Sb8UYl2XW+MYctkZKAphlfz uBe1oYcinbq6gEud6M/tBaXPzzzX95u80TCqnrQhPj1CQ1PAeb/RZ/JFpFYR34eRRuduouUe704
 Yh4gtaRvVlfLgdP9ZHMn5JYAMghqM1TMFoeLehUZBwnSQO1RVCEziLfYmoj3MLAZkvVEM3xg
X-Proofpoint-GUID: Ema_Ju9AXdBaPFzR6XlqlF0ueLx3lnXY
X-Proofpoint-ORIG-GUID: Ema_Ju9AXdBaPFzR6XlqlF0ueLx3lnXY

On 5/21/25 5:06 AM, Sebastian Feld wrote:
> On Tue, May 13, 2025 at 3:50 PM Jeff Layton <jlayton@kernel.org> wrote:
>>
>> Back in the 80's someone thought it was a good idea to carve out a set
>> of ports that only privileged users could use. When NFS was originally
>> conceived, Sun made its server require that clients use low ports.
>> Since Linux was following suit with Sun in those days, exportfs has
>> always defaulted to requiring connections from low ports.
>>
>> These days, anyone can be root on their laptop, so limiting connections
>> to low source ports is of little value.
>>
>> Make the default be "insecure" when creating exports.
> 
> I made a poll webpage for our sysadmins about what they think about this change.

Who are "our sysadmins" and what did you do to compensate for various
cognitive biases?


> Out of 26 people allowed to vote 24 voted "BAD idea, keep the secure
> option the default", and two didn't vote.
> 
> So this is a change which is virtually 100% hated by the people
> primarily affected by such a change.

I'm interested in understanding why changing the default behavior is a
problem. Is explicitly adding the "secure" export option on the exports
where it matters a heavy lift? If so, why?


-- 
Chuck Lever

