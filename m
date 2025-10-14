Return-Path: <linux-nfs+bounces-15243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB2BD9D4C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 151824E588E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76FC19F48D;
	Tue, 14 Oct 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IUP1yuag";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v1hCy7Jb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44A2E62C4
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450280; cv=fail; b=Z6Ue2UU6INqmD5bvbHpQsG/sUAasX2Jq3CX1hKWOhqF/mqQQdi7Zj0psl7mUMb4FNcRAvQrsu0Fk1AfxOHKUUrFKaiSuAAd84w88C3zot12eEoe4vSTu0d2+kIYs3L2KPKVmQWM2xvkKZjMefc663EnaNe9zTABEodnxRRcjx0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450280; c=relaxed/simple;
	bh=SfkHMiUDVVuOHBzwZIOdqABh3f2kj5SO5Q7ZPjNV3WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yyw5p8WTA9QAOm6k4/yU2JWB1xXa/7LKWDbU3HY/KLyMNMcg9HiekjAO8yhTC7aWFGng3r4aRoktG2QyYLg2A0U0To3sLOPGF7vlBdmz5Et0v8rC6Q3JbSSqkt6GFbX/uTOCrz4Q1VnlkcYfs7k/jNDnMfs9G+gYmIfe4HC5uJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IUP1yuag; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v1hCy7Jb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECu7L4031564;
	Tue, 14 Oct 2025 13:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VpPrRIzqe4RDZv31xI6AfJjPsKw3JxSY8K1LijOg/u4=; b=
	IUP1yuagrPiK3Rn3xXC5qLxfF+8lFv46lCOgvW5dMstnq9oSg3vySccOgC50oTcX
	HzDkGXNa6xhfS67BHhNtKJT3n6iu7WZyHlMCgWBsx/YPJQaYc2YlQQCr/vpDUw5t
	trQBTUvKQ24Bz1an4XJF8OEWPzVgxqhgIeKn+qZ21TkVVGrmd/B3FPuVGZ2kCUdP
	S5OODHOQJROM0qo5bK6dkZCr/NECUtROGfFz7UF40pTGgpjv0cbCPr9oZ6oJW95D
	sRd3d0hujb6L8hOwEqXx4U9JirYtLbZRHNtLCPBDmQ/+pHeJ+yt4rggCOOPzBP/6
	+fTJnuK7rptNNXccUJHNgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyme9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:57:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EDXjnt037160;
	Tue, 14 Oct 2025 13:57:53 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8yw8b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb8fQm5fOvZxxWbn63GUpNmrhmbb6XvfGSl+MmxQ1xHyk0kje3LwDwJizEkzFU/0xztM986F5lLpWsNAiugt9vYV8wOC8k1k0PBTuoE8/IKFNL3lnHOZLAni3C3KOcXOaduQ3LgrlfpRDaINUepOg4SJchgTWMxpgbJsK7rsb+z2n7PEXOjGqKv1DEOAEplhrYQhh/6p/P6Vf4wnMkd0+tTArnGmhD9fdzPep0qYNkZ4OPmq5VqYOVGil9mxiPqrSTJAPOTcjg5Q2XQ4o26wBc0Am+9ii9AXQYoIbwEqGFR2ExE0+uTQSbH+nnTSCOofDmg6cLfgN5x2FIoVPx4E0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpPrRIzqe4RDZv31xI6AfJjPsKw3JxSY8K1LijOg/u4=;
 b=FWPS21FOmDuGkKhQ06dLuSYSQWxMgWznb3f+4bddeW/01R+WqzKrYvWY5x9nCugo3nIaQZRY/02GXKoz0+/oQde1SLnWGNCFxdmTtgaFRHOncxUAgnLGZ50OjgopHVH/PpFWrfab5W1QpL67TjBGzS7BsVQ/G8xLC+o1zLTv8OkI//xpdVdHuAaOXqRmRvuCqrwQgfONcWPjyWVK6fk+fKmZPhW3RsA9v2hxjRZaKPeKk89FUiW3CQT7Y0tDhSnLImqp/v12Xa6x9RxK5b94ZolTNtJuhgJVsyjOdCVgTAc1nOx6A17anGOItwzTIRaHxeTEw0A6UjI0s8BmqdOwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpPrRIzqe4RDZv31xI6AfJjPsKw3JxSY8K1LijOg/u4=;
 b=v1hCy7Jbp/8FTApgP+f/xUShS0/eq7Shp4LwL2F60hDlvx8C1KxfJ7A+rSKnvvUURqwWPcq+Ud20XOAaNdzjhe69MrPeqFCDTnW38NCLhe/o2MLqpAhqnrAAjVrb5brguK8CgreIvjVmn68oXzVyfXEaX8h67nyx3CZdjcibq74=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7126.namprd10.prod.outlook.com (2603:10b6:8:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 13:57:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 13:57:48 +0000
Message-ID: <9b6e1279-b978-4a46-9f1c-baf275e4eb62@oracle.com>
Date: Tue, 14 Oct 2025 09:57:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251014000544.1567520-1-neilb@ownmail.net>
 <20251014000544.1567520-2-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251014000544.1567520-2-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:610:55::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f89e30-ed10-45f7-bb9f-08de0b29a8a1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bHI0bXRwbTFQd3NIUG1ncmNwbmZXVlgrT3UzcjhoMnBRVUV4WjBCRmxwdnlw?=
 =?utf-8?B?QkNxeFpHelBSS0tmc203aVhNWEIzUllCNmRBem5abVNlSkVOQVFmUXVmek5j?=
 =?utf-8?B?NDhmZ3hicVp1QnlyVTMyU1NqVlg4MUI1TmdJZkZQNk1zN2E4S3VMQm9RaGY2?=
 =?utf-8?B?ZUpLeENXR29XV2lqeUVnN0xCSm9DTVFaeWhRQkJQWlEzUHJ4a1pIV3dueGNw?=
 =?utf-8?B?eG1NWWFmdTRxSjlhY1ZxM1Y4RHBIUVZEakc3dHBSeU5yMUVIMkRLQ1FHeXVV?=
 =?utf-8?B?OE5WS1RvZS95N25PTk1wKzdnbmd2YWdUR2pLTmwzbzkyQW8xU1ZYbWVsR2Jl?=
 =?utf-8?B?bm5kSlZYLzFVWjBsRDgwdjdBNHdYbnY1RndGNmhsNldrTllDSCt3NWdnRXQz?=
 =?utf-8?B?TjBLSmhya2czWDdQSkJJbk1DZVZncndzSGp5RWw0ZXcxdkhLSWtrV1lVaith?=
 =?utf-8?B?LytLUnpjRGpXdWlzVStHbXVLZHlXYm9jY1VpNXJ3RldJNUdzNDlIZk5yeEZu?=
 =?utf-8?B?V2xKV2dQcTZBaXNaWFhlSUQwMXpUL2V0ZVdBS3l5VU42YjlVN1Y5RkdoWE9N?=
 =?utf-8?B?akRrYWExQlpEbFV0WS80MlBNNDBhWCttQ0NuNE1ObG83VDc4MTE0Ty9RMUk3?=
 =?utf-8?B?UEFBa01tQkdsZ25kVWlzMGU1VDB2VGhrU0JYSWJKVTVuVUJBeFFKRm5mWURX?=
 =?utf-8?B?RTZLMHdFdUppTXltQmZvMmd3V09XV0JpbVpIa0xKd1RsQ25YUTA4MU8rNDZy?=
 =?utf-8?B?Ry9PN1FFdjVkTHpyWXlNbUZWUWJSdGlVbVN0WUx4V2tHYWREbThPY1NidFNB?=
 =?utf-8?B?K25qazA5S2I4Z0VJc2tucUNuY09BNDJVQW1uZVhwdlRlSElTYzVYbklHdDFQ?=
 =?utf-8?B?OEFid2UyMEp5NXdDcU5KWnJCaWhJb3BzcWZ0T3BqMW04ZkMrTjZwTjlYWkNh?=
 =?utf-8?B?UjBsRG5GK0pYTEVZQVhIbHFKUFpKcGFvNzNRcW84TlBoVTl2SzMrM0hQZEN1?=
 =?utf-8?B?SjNwOG9FRWVsbW1ZWUkzUzg1cnA1WWVzcXFBeVJPd3ZpNmxRVm9XV1Q1THB3?=
 =?utf-8?B?dUV6eHBBdWZHU09uRVhqemxuTE10TVFvRnlEWWE3N2Z0TWEzc3B3Q21BMms1?=
 =?utf-8?B?ZVZ1SENsS1pnYVppSmozdHFYMDJWSXN6MGhzU3I0dHRVVzRsampMZDRITWZR?=
 =?utf-8?B?RElSRVJYbEZjZlZvc1JXYmxGdzNIOElsdVRHeHBaMVFRTmhoNENlMzd2OGtW?=
 =?utf-8?B?MGdIWW4vRWY0WGNlT0NwMitKeDQvZTArYm1Jb1NjYlhFV1Z2aGpjSFExZXox?=
 =?utf-8?B?RGw4a0dsTVhxbWhJNk9aSlNLK1BkWko1RWhiQzJ1YVB2bDFiMnMwR3ZPQXpr?=
 =?utf-8?B?Z2N3WkhyenVxMjdLUE5zL1hWcDd0eWJhc1VkeXQwVExVaDZpdzh4NUp5dTJL?=
 =?utf-8?B?QVVqY2drZWJxdE4vclBleDRGT3pMWUExZGM0U0s1R0JiejhLSDU5UW9USlo0?=
 =?utf-8?B?YitMd3hGbEdFeFl1SXJ5Ujd1S3JldjhnaElxQ1B4ak9ua1RmMGd6WHZseVBw?=
 =?utf-8?B?MzZ0WGFRZEluVUV4dHpJeEZMdmszT09xcWRlSElETmZ3WFRMeWlDbXR4bnh4?=
 =?utf-8?B?Y2xoOG5WL2xjaHVtUXBoOENwYUtKWVZ3eEdQbGphQkxCWk5QWXo4bzdmUk50?=
 =?utf-8?B?c1RCc1FCdUZ5dWNwMlllOHVMeGVDUDZ5NS9HYkhxQ2hCSkVpcDZsb2doVTc2?=
 =?utf-8?B?UEJ0SW9zNnBpRU9wZkgwWVczNFEyTk03S05seUxqUjVXTFJGWWcyQVZPRCtn?=
 =?utf-8?B?YXVxRUc2a3Z0dUIvUzg2OCthd0tSM1h4NUo0K2drRndyQkVEN2tyL0taSlFl?=
 =?utf-8?B?UmNBUjJIMGduMHEwVTZQRFROQ1B0Yk45VysxNEMvcTNSSGNGcUNudEdxdXVW?=
 =?utf-8?Q?5LKSopmXN4L4boICZ/vw3ZAnWJDQ5W1f?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YURzVmRWbmFQaitGVGxhWXlQVkdSbk1pZmFEMWk5UlR2aHk2M2RVZmQwMmZv?=
 =?utf-8?B?VGxjZUF5eHBhbG1PVklsalZQOWg0SFRBa2N6RVIxV2F0ME4wMFhZbjFVS2VG?=
 =?utf-8?B?TmtVek9LZTdjM1RWS2JlL1hqL0llS2Nua1JDRm1PUzhWUFlKZENWeXUzbklP?=
 =?utf-8?B?NzB5Sk1PRlEzT1JvN3d2SVMzK3NUa200Q3p2MnZmc05IRGpsT0xMMHdqeVlr?=
 =?utf-8?B?UVA1Z3hiRm1sa09VY0U3VDRpOUlNWVVONHRHNXpNazE2SkJFR2NYcXI2K3RU?=
 =?utf-8?B?OU5QbHNtNlJQUS84TGZuQmJsNVFLNGxjSC90WmRFTEcyZ2NaWE00WkI2UFZM?=
 =?utf-8?B?TER4c2tjL3Nua281N2d0TSs3QVd4Nm0vTXI1ZHQrdUl2bllWaUdyWnNhTnBr?=
 =?utf-8?B?RWZoS1VCV3FNc2VGZVZGeGI3WVVwRkcxdCtHS2VHeVEwZG1xNVR4aUwrSmNt?=
 =?utf-8?B?TlRrVnBQeHVJS2VnN0J3RkJVWW9QN0dYZE1Lc0lwSlMyRmRzWEdJQ0pSSmE0?=
 =?utf-8?B?TzdpZGtVOVI3cXFjcjNFNTAwSWlxbFNjWllYd1lKanNVbm1ZcDJsYlZHVmd5?=
 =?utf-8?B?c2RGRmM1Y0NPU3BWMHpyQmV6SXdsTlRDK0d5eHlMeHNPY0FNTWl0QlkzRXdY?=
 =?utf-8?B?UHQ2dGd4Nm4wVHZ1YUxVR0cySjExOVdZcVg1N0lzOFFQV2hJWWdsRGNmcXp2?=
 =?utf-8?B?UFE4M1krRVV0blMxY2NVZEhpL2lLdHBrQ0tHZ2dMa2YzMml1VnV4Q3F2c1hh?=
 =?utf-8?B?UVExQXZoTmtBMVM4c0F6c3pncmFpSXBjZkNENTRPTDI5ckVPMmFkL0FEMjY4?=
 =?utf-8?B?ZFN6WnFKRWptdldNWGlYMXhvR29HQjFPbXh6Y3lmWmtPRXlPUVkrNVhlb05S?=
 =?utf-8?B?OXpEWWJFYWlTbWtiNTdjTGs3K1hSM2JmSDd0Z1lnenI5ZFVtL2h4UmpZQ0xF?=
 =?utf-8?B?RDFJMVJvZVh1T0x2ZlBSWEM2aE5zVlBhWVkxSkE3Y2UrbERmMWd5RFJTYmhp?=
 =?utf-8?B?K3FURDVBbVBmdjlOMmxIcHRXYUxrQUVTb2ZBMTNXdlpmQU5EQXNNNXhSZGRW?=
 =?utf-8?B?cGJRU1I4TkhodkxaZUh6WjlXbjdFRGQ2M3JTM01QaTVNZHQyemphVHpjeGRz?=
 =?utf-8?B?OUVnNVdHRmdEV0x1ZHpvQzVxOW9wY3A0Q2JUZ0hZYmdZQlFSWVFsejBmaFBN?=
 =?utf-8?B?MlRmeTJMRzZndWUybW10eG5JUUVKaU1oMFcwbHRzSEw5R2lkQ1FVdXR3dFRL?=
 =?utf-8?B?Uno5NmhjQ3RDMzRNU3BiRHpzQ2w1akYyYzJXNGFsaXVhOEIxZjVCaHkzZGlZ?=
 =?utf-8?B?ay9uVDFDRTdDUmU3YXZkZkVTZWRhdytHYkRHaEJncHpma1JoTFFrMWo0U3cx?=
 =?utf-8?B?UWI2MnVPek44Y3hPVmxEMG9ncEVwUFBMUktqTzZDRmNZTDZ1T0pJb3Z2dEFl?=
 =?utf-8?B?My9Ma25RSVUwd2JMcGJZSHpWMng1eHkzd2dqWGV3ZHQvQVplcHN5QWdybUJR?=
 =?utf-8?B?UVpIUU9SelZva01zM1QyVUVDY2h0VGFCTTVuaVhZd1BBREM5S0FnUnU0TFJh?=
 =?utf-8?B?MmRUdHZueEprOE9aMHJUMHYyelU5WEtaL2F1VkdIaU1kRUVreFlXY0laS2ky?=
 =?utf-8?B?czZqeTd0QllkZGZFbmdwYkV1Mit4ZHpiOFBSeXpmc0ZxYWczc0V3eEo4d3k2?=
 =?utf-8?B?Y1pKRnZQV0VTdXNZaXpraktTempqbTZHL0I3UUxDYytqVVU4eEpvWmg1NjN6?=
 =?utf-8?B?OFVrR3Z2MU5pVFdENmNNMzk1MWUvWWdKRnl6MDNNMlBKNmx0dWp6cnpNay9F?=
 =?utf-8?B?RThrM1NWcnJ6dGF4djhPNk9PNmJNaGwzaStuVlppN1R4T0NpWTgyRTN4WTR0?=
 =?utf-8?B?em1Ddm5HR1NwZUNGOEZSRE9mQVBUSi9aR1lnTlJnbHFlQUpqa3JJT1hybzdY?=
 =?utf-8?B?RkQ4Z3RINnNlRXhnVVlVemp5RC9MOHNLdk1Wc0k2WHN4YUE5NTJMMVZ3aXVQ?=
 =?utf-8?B?cUczR2MrcEtPTDNtc1Qwd1IvTFBvSXlDV2J5STltVVpWSkNia2NzQkx2WlpY?=
 =?utf-8?B?S1RBb1pnS2xwTGhrR1NmVndadE93UnZqc0FnVXpFOHdtVW5qS3M2aGtPTms5?=
 =?utf-8?B?b0dzbFBqMWM4NXRKU3Q4MEVSLzYrdFBvRWtnU3V0UVpNdGo3dUxwdlBZWEkv?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mh5Wvurd1WDDvmuIDiotWaLlJ+2tDpVNicGb9+BwTupN34DCZi0RbrxWTN4o2Ga4bGCbbP4D/tcJvCVPljrS1n2jGzmsqIvcCxGCpjDSVD1JODenSE5my2ckY/qOVJiL2FjhPXE5vby9a0HIhPi46dCmwF62xCXCFVlYeAcTPrGMtCUdNY1uUjRPc4J4m9MPkwt1DkU21LV3dVS7fjD4DXaoU74iLgTqK2m8223+wZ3jwMgBIGYTmX/I0hK2jqxwshyfesVt0eFzPGYq1xUb4NP5GxsVl0jU2SZhNYFVnuQeSswH1ixAI7r88nNRbEdmEjWQdyz0bWThZuAXtfadPEJH5C2sYDHDPdssNlSNPp+StEaF00GuwoQqYSN9um2Zs8NS9Q4sUdKJD4cWPUvDmFOwy9qiRWbY6V3vSuLHD/DUouI30BlISF2psdaS3cc8KXVjYs5LJh2cjyox0CL19WabeclEgs3clygi7vpci+OQwR00Jk7oRzVUrvXWtl9aatWUrP4SKAxAXrKvg7qfx8apMCsgGxCKapVbRpV+Oj+fFd3apCh8ulaOMAGmVslvmNmGxUx+IKe5O/53bT1qu2ee0LCE1PWhzON2zaEixrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f89e30-ed10-45f7-bb9f-08de0b29a8a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:57:48.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIqmvFBqjofzQnzOelQsU4cRrhgo24aiAvP1qnLuS7qS/SldXJxCzZYvNc026uKxFuWQGwbvcmmVmyKOERy51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140106
X-Proofpoint-GUID: NuBZjsINRuPmf8RXSiggyZ-0yTVvWk2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX/yf/llQvtRll
 6ggGSFsvUSVi+Vv7h8vbSLvMvQXZQ4LglserdQF1gO+Vo+6cAHDsuYtDncLo9jbdrtdALYtSlzf
 D1tCsyXm6Ixh+DFiVldLZYOZijhDezDdydqzW8tlSd1HeUvL/IIRx9kJkTguJHXes1yzfiAOEcs
 4Xp80SGruUS9u80CbdoPmbqlFP0Inrhg00+GPTIOi9mQabHK6XHUq/WF9MmsWbOV7pbsV9Mb7S5
 ge4kWT6TurU5Rmni2CotdtIIksI0AZAsFvmsR2Ao0STBScTjRLds2FqL4c9sLrfMZt8txtQvHRW
 EQx5UPOiHmDSYiYRUzQlYtqK6OUR9tDfK7R1B8zI5NxdUngumeVA8ocDdrQOVtSWg4uhUpoFreF
 l0kodHTLhI6UFLRY46e7hOHj86bkLw==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ee56e2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VEwAz9gvRWmaUDE6U50A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NuBZjsINRuPmf8RXSiggyZ-0yTVvWk2U

On 10/13/25 8:04 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
> new SEQUENCE reply when replaying a request from the slot cache - only
> ops after the SEQUENCE are replay from the cache in ->sl_data.


s/replay /replayed /

You might consider moving reply construction to a helper, where it
can be more extensively documented without adding more clutter to
nfsd4_sequence().


> However it does this in nfsd4_replay_cache_entry() which is called
> *before* nfsd4_sequence() has filled in reply fields.
> 
> This means that in the replayed SEQUENCE reply:
>  maxslots will be whatever the client sent
>  target_maxslots will be -1 (assuming init to zero, and
>       nfsd4_encode_sequence() subtracts 1)
>  status_flags will be zero
> 
> which might mislead the client.
> 
> This patch moves the setup of the reply to *before*
> nfsd4_replay_cache_entry() is called.  Only one of the updated fields is
> used after this point - maxslots.  So that field is copied to
> client_maxslots so that can be used as needed.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9053ef4d79f..1c01836e8507 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4360,6 +4360,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_client *clp;
>  	struct nfsd4_slot *slot;
>  	struct nfsd4_conn *conn;
> +	u32 client_maxslots;
>  	__be32 status;
>  	int buflen;
>  	struct net *net = SVC_NET(rqstp);
> @@ -4398,6 +4399,27 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>  
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> +
> +	/* prepare reply so that it is ready for nfsd4_replay_cache_entry() */
> +	client_maxslots = seq->maxslots;
> +	seq->maxslots = max(session->se_target_maxslots, client_maxslots);
> +	seq->target_maxslots = session->se_target_maxslots;
> +
> +	switch (clp->cl_cb_state) {
> +	case NFSD4_CB_DOWN:
> +		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
> +		break;
> +	case NFSD4_CB_FAULT:
> +		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
> +		break;
> +	default:
> +		seq->status_flags = 0;
> +	}
> +	if (!list_empty(&clp->cl_revoked))
> +		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (atomic_read(&clp->cl_admin_revoked))
> +		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
> +
>  	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>  	if (status == nfserr_replay_cache) {
>  		status = nfserr_seq_misordered;
> @@ -4425,7 +4447,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
>  	    slot->sl_generation == session->se_slot_gen &&
> -	    seq->maxslots <= session->se_target_maxslots)
> +	    client_maxslots <= session->se_target_maxslots)
>  		/* Client acknowledged our reduce maxreqs */
>  		free_session_slots(session, session->se_target_maxslots);
>  
> @@ -4495,23 +4517,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  
>  out:
> -	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
> -	seq->target_maxslots = session->se_target_maxslots;
> -
> -	switch (clp->cl_cb_state) {
> -	case NFSD4_CB_DOWN:
> -		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
> -		break;
> -	case NFSD4_CB_FAULT:
> -		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
> -		break;
> -	default:
> -		seq->status_flags = 0;
> -	}
> -	if (!list_empty(&clp->cl_revoked))
> -		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> -	if (atomic_read(&clp->cl_admin_revoked))
> -		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  	trace_nfsd_seq4_status(rqstp, seq);
>  out_no_session:
>  	if (conn)


-- 
Chuck Lever

