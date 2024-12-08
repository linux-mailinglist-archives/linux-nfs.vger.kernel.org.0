Return-Path: <linux-nfs+bounces-8429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692909E86A5
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 17:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262DD28122B
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50B170A15;
	Sun,  8 Dec 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ceMFrGnD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LZ2aIO5T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FB1714C6
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676202; cv=fail; b=pk4jvuTuhegRKs+rkSY6vGm+9K6c+ELxkMw8PQ9ug6ILD6WCwUPxNUYBPvuYPHS28WOORD/WxFc5bNRujOmm8M0v1ZcOasbytAYoJ9YKxvNZTkS2LK1kwenH3poJyz8fWdym8Zws+GRYfmGPiwRQI3r1V7Obqaqt2w2xorjQLEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676202; c=relaxed/simple;
	bh=wuGkmxz5eMmp90xPnNbtbr4UX9K3gBiD+/fa1LqYr84=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hNbLk1GXIteOT3MyGEdR0LUN3DUcYkLYPR/iVi0ZxfEsyDQ+0TTqAGTcTy4uX5Y4jA+ueGtOSAevUSttxoticfshypCSBfKS6wTemn+J01Mh3R3FnXNMlDMZpU6Dqh7bjWlAogXEXTUomKgFcGCyL+Go6U2CNgdz6EEGABSe9yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ceMFrGnD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LZ2aIO5T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8FP17B016163;
	Sun, 8 Dec 2024 16:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=e7WIvuks8CCnyhZ7bgmdaEvsUtUSFdiZ8PMd9O56uy0=; b=
	ceMFrGnDjK473mxYXiO4RV7cviCRELleyG3cgrJhta8nBNNTaDW1jZ/mMN8eGsSJ
	pSR6Ds1x2N2lir0e2HRdEmpnUOO0rlgNrezgP3O5UAC54LzQpLJURL8Wt/1TOMWD
	J0e/mOdD1V2IEhJ5j6ZZ5uuM87w/5MTnuA42fHCH5Cd8t+iNrUBQQVyrKQ+F9RBB
	2t/OsQ41RuIVHHfLkhgLSpehcMcWl0/S7vWO9DtXXxqnoVmduMFsWSZfrJEplJFC
	9IuFKVYrpLx0hAZjfhwlkuaCGsIdW8JX2uL2GvXEZkfx/lfFsxLZF/EDYQCI6Cn3
	kbrXITeZXRKZJWj28EikTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr601rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 16:43:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8CPZG5035650;
	Sun, 8 Dec 2024 16:43:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6h05x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 16:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMmiGX5fki9S6/I7tFNs+gwxUFCHIPRSUaZuDpz2c92VIp9HJD9Le2c+YUngzpuMFR2FseeWf/ybA8QlGh6pQzdLkkva8tZ2AVVWsdlOmmSDvXJZNe/OxdZuTs4+AUbb3uEGsGc5M3ZzAHJl4VyhfGJYbT0jJWO+iI1I+0RqZnu6bFrGRdk2SQjwvpq1+PWe6WQZJYwJ9h3wYM4dFwTeVl9/n0KgYLGxQ+a6CXkPOXzN6E1FayQaGx2CZWijbtVqPgfUSwLPDGP1Y57kPA4GaTC7UcniNdK4qqZeBSdIYlMhkOEOtKe+LrpPyFTuTlknoDWSngAfuAZSzR4gYljySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7WIvuks8CCnyhZ7bgmdaEvsUtUSFdiZ8PMd9O56uy0=;
 b=ySxHZwOPDGgXS/lr6CXil/nLjtLAznzd+qb6c87r0Wy5JAPt9HnvO8q0QILr8OBlhcVyR1o6WDleANK3PRhikGqCAgw6fMO5lDBankfH0xQPUWos3XAVWbQYWA/SINkQiYYjjdIuakQKL6JRDIL5JA8E6mCah0iPA5W3cM2/mudaFVHEQ7RGYIZCea9WKJXsldh2UQ7G5l6n6owaizK9UIusOmPZdOgBLyqyVbfvZnzT7ialTJZ3WeRjGa5kSDHo/rxcgGaL6t2ddn/UpeK/DxVd1+CSse9tjia63fFFWEUabAruuGr9qTjVIJHQ5Wf6mUs0lk4qLDz093DjS9IIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7WIvuks8CCnyhZ7bgmdaEvsUtUSFdiZ8PMd9O56uy0=;
 b=LZ2aIO5TZBHUd/ACQSBntp1xsdNPd3D0/uHOL1e+SPGi36M0TcEAnzU85+Wm0APd9FITG+y4meWoKtkJsUjng/4xu7NairbCF0icWYhyos8b6IZTstJBlnz3xe2Y7DWUHqqw7iaXCxE7BXvP8DSHopFShQx9JTSmNANrjN1F3WQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7779.namprd10.prod.outlook.com (2603:10b6:610:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 16:43:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 16:43:07 +0000
Message-ID: <6d3f9445-8cac-4844-a0b8-f11ce5bde1c7@oracle.com>
Date: Sun, 8 Dec 2024 11:43:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CALXu0UfT-M37mTF52BPP+cuFAi+gya=XeyerJgAzqXSs7Lmwcw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0UfT-M37mTF52BPP+cuFAi+gya=XeyerJgAzqXSs7Lmwcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: d1896ab4-8214-471c-f99b-08dd17a764d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckRQajZrQ215NTVmYnplVU44VWtzczhoVVZPaS82endwVzhpdTc1MHdJa0Vq?=
 =?utf-8?B?ZGRzcnF6QjdyWFZvdmpXQ1ZSTnBTT3RWcWg5eWhFUFRaQmRiaFRKY2g5eXB4?=
 =?utf-8?B?a2dpNkpybys5NmZYTS9MNEliYzZOUkNYWTBOanA3TmQ0aE5rVkpUMnkwTW5X?=
 =?utf-8?B?NnY0b3F6aXZhUmZ5T0NoOE90VjQ0VS9EeVJCN2ZoKzJOZThHSVlKTmF2ZXM0?=
 =?utf-8?B?MmoyYmY4UTJQclhzRk4raFE2dlFWUGRTQkZHRkJ0NktGQndzeHdCTUxDdzNz?=
 =?utf-8?B?c0hVUWtQbzlHRVpVaGk0cThzcWI3Vk4yQXFjcEpiVWQ0c080MTVhVTYxeDJs?=
 =?utf-8?B?NEhSc2JTSG5jb3RmL21VMDV0M1lUZ0NjYVowVmprRjlPdzRBQytTaDUwOXBs?=
 =?utf-8?B?RGZSOEVIZmVCMFhuYUJhKzFYd29aaWZDdmRtZkpBUW1OVGo4WkFEbmpKQi85?=
 =?utf-8?B?Wk1UQXArN09Falc0Q2RpaC9vNWdRVDliRDZCSG0rcHZIL1U1V1djaXNQNmdM?=
 =?utf-8?B?RW5PazhGZW5RYW5LR0FTWGRtZXM0cE1sNXpsQVBtZ2xEZ0hLOUZ3SU9uZmVl?=
 =?utf-8?B?ckRkdC9RaDVTT0s4QXRhc2xwOGtjaW9JNWg5NHFHVmNya1dZdjFpekVxWFdx?=
 =?utf-8?B?djdoVzc4U0JFcU1Tem40dW1FVEl0QjY1SFZ3aHRYTVZWbFNDUU94VkNPaXNn?=
 =?utf-8?B?Y2Y3R2d2T3RrZE9qeHBwOUhkaytGQmc5ckpXclZUVTh6ZHZhaFNkMTh3cjkx?=
 =?utf-8?B?RGdzTGFSTmpTL3FzK0JFL1Q1dEJPT25rSDcwZ0RzZ0ZxdWh3UE5EUGtHa3VX?=
 =?utf-8?B?RXM2WU9CNVErSk0relhvSDliL2U3QkdlVzRQTXB4RHNJM1ZXaUlXaDFJalN3?=
 =?utf-8?B?bHAwOGF5blNWSENnOWdlQ01ZT3JJYXdBelQyclNGSHFnUnhUU2phTk12Rjk2?=
 =?utf-8?B?U3FDNXpaZ3F6Z2xaSWFuOXpqS212SFI4bExNZ2EzTjFMekZ2NUw3cGlrOHVu?=
 =?utf-8?B?S1JzZDBueis0VDk2UlMvODJQWFBIQ2N0UlVZWGJia255bGlReWNiRG5BK3dD?=
 =?utf-8?B?TXlhTytxanZxdkwxUjFMYkY5Mm1najNNZ25kVDM0SlptbGlFcjBvL01oRGcw?=
 =?utf-8?B?SDRWMlpvYUt1bzRGUlNVQkZmSTByREJxMUQ4N3Z5MFhRSzFCb29XNUFmU09h?=
 =?utf-8?B?MlUvL2FTVkFzR2ZNZnlYeEEvcTdyVWhGMDh0a1VXSFFKNDJsWWFkL2N0Yk4z?=
 =?utf-8?B?dGNyNVFGN2NkckZZWC9lMXVDaC91UGIxSVdIUHNKU3l4UmlLc1BsSXZEOGo5?=
 =?utf-8?B?RU1kcVNzcTh4QzRhSWlNeUc5U3IrWUFnLzNoV2JPK05EV2w0K0xHeUVxMlZV?=
 =?utf-8?B?dVZ5dW5ZM0k2U2k5di9aVVJuWGx1ZGZ3dGZpdTV2TnF1MTlTNGNXeFRXOGZ1?=
 =?utf-8?B?eXIyMkc1M3MrWml6TEliY1lIMkE1NWtRa2xKMzhHZ0hWYjBodlhLZkxhUTVw?=
 =?utf-8?B?Y0JSeGtuUHpnK0hJVWJtVE4zcGJrUjg0TUJmS1FpdTRpTlZqbDBCTHVVRDBF?=
 =?utf-8?B?VkttcTUrUFJvNk9DenFQUUluZXN2TXV4NGlZS3ZoZ2UvcjlCYlBhNmFZNDA3?=
 =?utf-8?B?YjdQN0E4UXV4U0lBMG5rcG1EZ2NJSFhzNGdCdHVBaFNibnlZUjNJZXo4RVhu?=
 =?utf-8?B?ckhyOThraFVQdVNZREs3VTdPSnRZeTlUQWF2RThZdFFnQkNrUk51U2tlVTFQ?=
 =?utf-8?Q?K3EvB1ZyWOtYXndRJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBCeEZXVjdaakdhZDM1MDRyY2RxTGZ6SGx6VTdXSVVMWk1xVnZnbE9lOHhr?=
 =?utf-8?B?WlEzV0NSRDJBVkI1Q29yMUsrOXdDcWdXUW9pV3dVM00zVXFmQUx3MGhVM2x6?=
 =?utf-8?B?K0F1dTBtbHdWWGt3MFdoTlVwLzd2cWRJamljbWIrTTFKbG9waFY3WEk4cjRQ?=
 =?utf-8?B?enkzRGZmdjdqK0FiMjdvNjI5VUIxTm00YU56TDd4NHlBK2xHVkdQZ3Q0dTNv?=
 =?utf-8?B?MnFpM2VaTlFkVk5IQ3d4TzJ3ZmVwVHpFOERyUnpRZmZzcjNGQ2x0OW91bVFS?=
 =?utf-8?B?TXVBTDlVSFZZZlIzZGxjTWovb2VCcGRINnBENGp2OHE2SWtOTGx2WVZkbVF0?=
 =?utf-8?B?VHgxczRITFYwVXoyR3RRWVFpVGFTMlo4WTllMmx1QW1YblM0TWJSMFh4eXpi?=
 =?utf-8?B?UWxtWUNVY3RXZ21ueTFMSE9wL0l6SXhrVFNQaEZVcFFWei80TzNRUjBNYmFV?=
 =?utf-8?B?MmgyVWFieVhQRTNIMmp4WWRsbG9aNEdVRStCT2VwYkxxSDl5QXRObjdxNWhR?=
 =?utf-8?B?anV2RnZlMXJCa2xrTUV5Y0dKcWx3Z2lncGRvUE1keEpxM1ZkSjBDa2crRnNV?=
 =?utf-8?B?aDdOcHR1VHk1SmxBcUxmcEZpSDhNblBiMEVTNDlzM01oVHJuWFF2Wk1Hclgz?=
 =?utf-8?B?SkNVVTVEOWwzbzlxbmJkMTR0c2tCSStVWGNOWWFCai8wbCtRM2FZRkI2ZEQv?=
 =?utf-8?B?L0gzSC8yL0NTMkhIZ1ZMY3FFUkczaXpDNlFqZS8yVEg2Z1JpSVpmam1mNkp0?=
 =?utf-8?B?MnpRWk53Q01iY1pxcE80MU9UQ3FkNzF2R2s4ZGRRZXBab0ZQL2pLSElucW40?=
 =?utf-8?B?U1p3ZEdHNGpqWkxRZ0YwcHI2a2RIaGJ2ZmV0SGJDUGQ3NHYyRWUvTERIRVRs?=
 =?utf-8?B?WDhETUlmSTlMWEFuaTRDT0Z2WTdBczJ3WUxwYmRuUGNFdUtLS2ptcXMyd3Nl?=
 =?utf-8?B?WDA2TWJWaEpOUnpCYzFTb3VadlMrcUNFYk1EQ2JueU1Wc2dUV3JFRmJ3cmN4?=
 =?utf-8?B?UmN5MHZneTlHVzhYcDZmTHQ2V3hKOEp5WTJVRUQ5ZTY3cXlVUWVxZWFaU2JC?=
 =?utf-8?B?Z2ZSa2kra3dYSVFBWm5CdVJ4bC9aSkhwKzJNaEdsWjJTUUQyWUFLMFp0dXI1?=
 =?utf-8?B?TkQ0SmxDa0NvK2FzSVJxejh2N2tkayt2aE01bnlqaVlSaHBycGJPM3ZMTllV?=
 =?utf-8?B?SUZJMWhEMGtXVGhDNU96YnZWdXhCRWliNHp3TDZQODFpOCtZeVlJY2ZtVDVW?=
 =?utf-8?B?VGNkL1QrbFJRa2VTS24zUDl2K1B0cmR6QUdDZ3VNcXhVakhIeUtURENMeHVH?=
 =?utf-8?B?Qk1MMDNqTlR6RGVNM1ZOR0Y5QzdTem1WWlNBSjhVUW5MVHR3UlNxVG9PbVB6?=
 =?utf-8?B?TnlDT1Q5S0NkWkFHejU5VEsxZ3BMc0RqaHhkeEdvcEdQeERDbTRjRDFTK2pu?=
 =?utf-8?B?emNwM2Zqc2xzc2prWGlMUUg4TkdsQVNPRFpNOVpBUUpWNHZTb0l2OUZaQU0r?=
 =?utf-8?B?OGR0dVFlTlE0bC9GVEUrL2ZIWktqOGRtRHJyeW1CQVQyVFJ1N0VDak9DYXU3?=
 =?utf-8?B?eWtxeGFaNUF3MXlNUkFwTjhLRkNuME1PMWg1WDdueXZtdTFQTm9lMHBsRVE1?=
 =?utf-8?B?cy9KaStXOStqbE1pNVRxcW9uQnNFMm1xaTFMUXRod1pWT2NWT3hUT3MxQXZQ?=
 =?utf-8?B?c0NuV3FkaEUzUnN5Qklja2lNK0lMeTliSWV5TzdWa0x1Mm9CUTVUcUdxc1hq?=
 =?utf-8?B?VjFOY2hGZ3ZuV1VnV1M1SUdweUNxbkU0OXYrSXNMYjRpU0pxV29zL0d0V2RE?=
 =?utf-8?B?TFozR2FNK0JqWDJySUxyQmVwOHpUMTZMeHF0TmJiZUxpb1AvSlpmWlFkSTQr?=
 =?utf-8?B?b2NWRU90ZUFRSHIzdXdVQThMU09wZGNpL2hDdmtGVC9iSXUrVmJzM05YQ0Fj?=
 =?utf-8?B?a0tjaGZLRTMxemNDNzlTa2hoVFpZUjlicjEyUFlJMm9veitYRFFEYTg4NWph?=
 =?utf-8?B?blNIODQvYzNZT0Y2ZC9zVjdhZGlIN0pHMHV3bElxS1piT2djK0M0czZkdC9t?=
 =?utf-8?B?azVhWWhjRWNXQmlkejZoRWtBeks3NEE2VDJTSUw0aG0rT3YyeU1pZCs3VElh?=
 =?utf-8?Q?Gp5eH2ExZ0BHaB6SpqRyyYuxA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uGQefdhALRL4iiHL/08h1wJt+9XVTX8/stMO2HqM/vWFbWIXxdvF2nGM2aSzN1mxI4/fq0wIvPM09TpkBgeeoua3bPLpXOw7qYqnSeLODK7xh9qVrrYfI2UEw/KTAxn30VRO7xIcefevpG9nGWQyvtPcfSbEMNa5MaBCY6549rnax/Vz8iQG3tSPF5QTls3nChvcGEINPmk4VeoNHsuDvR0T9IXw9wh2YmjtgJ8HeP8LNcRt5C041P7y30hj9tZevHqvlqMY9WDruzSQDp5DEllza3vLa7eRwTYTAH67kuPThn6kycPMP+Y+Jp/EV3uRvsImxF/AZWxCrc6KMTOdTyorYUe6hp8FoZiugdzznBddh2bRF/QaDdtCJFO2fTss1a9eiThT1kEKIpDHty0tPHMPRf0/lrgRcMRhUr6f2nlGtiflV6x+4qz9q6TPPNZ5jp90jf8j1IpyAXbiHyCrcJT3wsWqFjhuHGA2a+2ofvIJLQl0oar4hk0txdLAdL3kQ0oSVI8O80kk23gdhJihHFzvH9b9lmy4/Mnv56tWTHGFw8P0UUW7dGh6cDtBUHwv3QFKpYd5DklbPLMD3md+LGMm3VUnIZom0TGQvPWEQbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1896ab4-8214-471c-f99b-08dd17a764d1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 16:43:07.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZcL14zlQpklMSKxnnwTlVcTtsK+GsciBsX/JhL0C6x9LQdSBpH/yF7qJRkaQGCbc10MGkQokJMuRE3pkXhKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-08_07,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412080139
X-Proofpoint-GUID: Aq65yiJ39kB9EmaSdX7mS1e2IVAopqhV
X-Proofpoint-ORIG-GUID: Aq65yiJ39kB9EmaSdX7mS1e2IVAopqhV

On 12/8/24 2:41 AM, Cedric Blancher wrote:
> On Fri, 6 Dec 2024 at 16:54, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> Hi Roland, thanks for posting.
>>
>> Here are some initial review comments to get the ball rolling.
>>
>>
>> On 12/6/24 5:54 AM, Roland Mainz wrote:
>>> Hi!
>>>
>>> ----
>>>
>>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
>>> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
>>> to the traditional hostname:/path+-o port=<tcp-port> notation.
>>>
>>> * Main advantages are:
>>> - Single-line notation with the familiar URL syntax, which includes
>>> hostname, path *AND* TCP port number (last one is a common generator
>>> of *PAIN* with ISPs) in ONE string
>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>>
>> s/mount points/export paths
>>
>> (When/if you need to repost, you should move this introductory text into
>> a cover letter.)
>>
>>
>>> Japanese, ...) characters, which is typically a big problem if you try
>>> to transfer such mount point information across email/chat/clipboard
>>> etc., which tends to mangle such characters to death (e.g.
>>> transliteration, adding of ZWSP or just '?').
>>> - URL parameters are supported, providing support for future extensions
>>
>> IMO, any support for URL parameters should be dropped from this
>> patch and then added later when we know what the parameters look
>> like. Generally, we avoid adding extra code until we have actual
>> use cases. Keeps things simple and reduces technical debt and dead
>> code.
>>
> 
> I think the minimum support Roland added (or what is left of it)
> should remain. It covers read-only ("ro=1") and read-write ("rw=1")
> attributes, which are clearly a property of the exported path.

Correct, the server mandates the security policy. However, a client
can mount an RO export any way it likes. It's not an error for a client
to mount an RO export with RW. Writes will fail. Mounting will not.


> exportfs -U generates nfs URLs with "?ro=1" for read-only exports, and> mount.nfs4 should treat such urls as the standard mandates, and not
> either drop an attribute (which is a violation of rfc 1738) or reject
> a mount request because support for "ro" parameter was dropped in this
> patch.

The only standards language I can find regarding query components is
the section of RFC 7532 I quoted here yesterday:

    An NFS URI MUST contain both an authority and a path component.  It
    MUST NOT contain a query component or a fragment component.  Use of
    the familiar "nfs" scheme name is retained.

Therefore all of the parameter mechanism needs to be postponed until
these details can be sorted out by standards action. Otherwise, we
risk implementing something non-standard, or worse, incompatible with
the standard, that will have to be maintained for a long time.

This is not a NAK; rather it's a "that's not ready yet" objection.
It's basically a way of getting the working parts merged sooner rather
than having them wait until every last detail is worked out.

Note that I will have the same objection to "exportfs -U" whenever
that materializes -- it should not emit URL query components that
haven't yet been standardized.

You do want URL copy-and-paste between NFS implementations to work 
nicely, yes?


>>> - This feature will not be provided for NFSv3
>>
>> Why shouldn't mount.nfs also support using an NFS URL to mount an
>> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
>> negotiate down to NFSv3 if needed?
> 
> NFSv3 is obsolete. Redhat support keeps telling us that for almost ten
> years now.

That is wishful thinking on Red Hat's part. Hammerspace is making
a business out of supporting NFSv3 data servers today, just as one
example.

Linux upstream still considers NFSv3 fully supported.


-- 
Chuck Lever

