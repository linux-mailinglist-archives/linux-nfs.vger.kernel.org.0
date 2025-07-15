Return-Path: <linux-nfs+bounces-13078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA1B060B8
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F551C812D7
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0E2EA492;
	Tue, 15 Jul 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eKjOBlzM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c1BgjW3k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1942EA498
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587970; cv=fail; b=LJ8P6LwmYPwVNWb3W4a+t9Tw4wu+irr/jdhdsZMvN+Rx8bCQm3+mMACmFrlHJl+jcPI62cnWaiCP191AJv2rBSJmwbbhJ0zk2VHZsH7V4SzYc3sBhyMWHtPCpGyvPrk6FUTkVtj8l6gPi92Hp1KZEwKPdX8vtzQkAGSsnI96cp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587970; c=relaxed/simple;
	bh=uZUp1diffUs7ELoWx5ggmNtuWrJ67GsmiJxT1O5jBYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yt4CU3nBVoLZzsk4wy1/DSdcbRrgOOpu1BZ2gterQeDbArJ261R67sNMBgpTcySxdNzSATDpMfiYrWoXX+6LZY6KLEibh0hU7storQu05evv0e4hBxhkY03t3BCeqgFH5eGwWkIk8K92oYnrm08RcYA1l3hQfeaIDklZYnoH7FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eKjOBlzM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c1BgjW3k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZBSr003475;
	Tue, 15 Jul 2025 13:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sDo4gkW/zneGhvZD0uAN4U4SwWoU4oU2rbDTUPoK8T8=; b=
	eKjOBlzMg4Ds+3Tv8v/VS5DTbhNxJQofM+CLFc8FUqZvF275xc6coIW/YAdLwsR+
	De4YK3QoDaUajeakp6s543kdWLUWMWrLXT4c7nGkCy3jkZJBsOF7SmapViht3ZAT
	aeQS+uUblpU7OKZMzz4Pc1gfZ9MxpPGsbwQR/sKq0DwyMgoQ/0dQmGH76UGtD+Z0
	W1BeMDDfFaMKWDuo1WDA23jOUbYFNgYPPuEAOXFraztN9dwyWXlZrjY6hf2J5XGG
	MjNX0YGKHVTTRwQKFexS+XFnkH2JnVNuzkSm8QtyVtgNNtCtqJDETrYPbtW0+IAO
	x92jfR2Nc6YOXbceJLYT5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7xx00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:59:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCFO1E013526;
	Tue, 15 Jul 2025 13:59:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59grv9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihjRXOBVrR7uyLIrXSOHmmyu2XIN+SZmH27c1JcikhvB3TPKnfPosmhua6EuLpDsswmDAj4EjVxasAs7e7nlhe3LnFzVSlxIEKusoqW0EJnv7ENlQPvuu5o1KY3dH92/Ms3ICiBOfMNVet9hcAvUcwiop4x+jnA2lGGfrT+Zmbc7z4woTbLpg/LtApjdn6dkRCqthgpnqRoK9yt0TbrNKPcBRvd3GCc29HkVsdoFGcTV8tEvtKHWPEqiw6xrDlO2a7DjUtGY7MCdSPx11TMvZo023QtVQ+fe22pD2cmcWgoCeLHq/EfNqi/0+pZ4XiWYX/X+MUkiRdY3cF2T4CZEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDo4gkW/zneGhvZD0uAN4U4SwWoU4oU2rbDTUPoK8T8=;
 b=CIzXnuZsPWSEw7fGk1XVSg4xB96RrLiBjh+Kr9/0Y1P3+gS9npJvjPk90WFr8LbIhnP3nBDgJg92NMJWXn/oH3itmVWolLMLSKKsqT1qRfxczguB2yknC+8W6ICli+TcvdpHkU3GV5BOKEW1ndum4yHHKUve8YAvqfgzPCPqbjlWUsLJX+3CV0jjKqbSwMAAfoorjzit/M6d5jnp8kO3P5QJ/9xMHdV029nx2Nka50m1IZS+GwbQD1x30tgtQjLxFZ2CsHhNgZg+WWjfOaAD9KYk0P3bepFL/Ud1P6j2VfZjsDDw3nnrqpkMtfqhvRTDqO2W9VffqKuRKXcGKBVAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDo4gkW/zneGhvZD0uAN4U4SwWoU4oU2rbDTUPoK8T8=;
 b=c1BgjW3kmvDYe7M+LlLXamikyD+c4jLZ05H2wLK7LOCQ+j8P6Mj2bnx+mkFs548U2xV4kMjJrktgKfRYstCtYeoNRsu+dqmR/gh6VCbSjq8HX2F9eAgREs+PmlaYhT04T0A2OFBV5ILINGcnyZvvLZVXz5D2EFnvnrBrav5Hj3g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5084.namprd10.prod.outlook.com (2603:10b6:610:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 13:59:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Tue, 15 Jul 2025
 13:59:07 +0000
Message-ID: <ef2837a6-1551-4878-a6da-99e9bc6d1935@oracle.com>
Date: Tue, 15 Jul 2025 09:59:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO
 modes
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250714224216.14329-1-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250714224216.14329-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:610:51::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbae783-0e7c-44a0-5ab8-08ddc3a7c41e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?elhnVTVHNEkyY2hQYjNWQnhtOXBpZjgxOEhNY3J2NU1SYWNYWXZCUFR5Vk1Z?=
 =?utf-8?B?cHB0cGpRTVI0TnRGMUxSL2p1dHhRNG1pRG55VkR1Y3loaGxyTVdzR1Q1dDlP?=
 =?utf-8?B?Wm5rakhhVEdFTVdSNGkwaWJBNCtGQ0FSMXA0QWFoeGdrQ3U2dzJMdVdyNkhM?=
 =?utf-8?B?WnFEVGRXU0ZmS0tXTnB0SGx0VklXSGp1QWNvVUQyL04xUEgzVVQ3a0xrU0pJ?=
 =?utf-8?B?T2N2RlJlb1lMYWgwNXRySlB2VC84TFNyUFM2czJMdkd4Y09iK1NhUDVnSmM2?=
 =?utf-8?B?dmpzYVJFSXh3QXZqbkFITWRjc2ZUSitYZHo1bmVSQ2t5Rmhwd1d3RTNSM294?=
 =?utf-8?B?bUtFZFdKOFEyTm56SGdyWFBhbXZPZW1Mem9uWDRKaEZTQnJSa0NlTlU2aS9H?=
 =?utf-8?B?d3lPclk1cUVtOUJnL2JadHRSbUEwYXlYbjJOUUR3UGZvNDZOenk0OW9GZ2Jo?=
 =?utf-8?B?QkpIdkRIbUlUdUxHa2ZTMUxVRzkrbXlvUmlZMXArQkQrMjN0bHBRNXhKTkIz?=
 =?utf-8?B?eDlzekRxd0RGMzlSWHN6TFh2Q1luVExtcU4vMW9taWxpVkpwTDlxclloM3Az?=
 =?utf-8?B?a05LanBQcFpScThZNUdIWWR1THhXTlJUSUNmZVpJL3U4OG9VYi9wOVdndm1F?=
 =?utf-8?B?U0w4RVdFdWcyam93WW5iRDR5YmZLSnFVL3dDOE1wWkpNbzc4M1ZpdmZOeVYx?=
 =?utf-8?B?eHhPa1pjVnQ4K1ljQ1gzaVlYWXNKTUtlK29IWEFyMjhNZm4wbGRvVDl3S2sv?=
 =?utf-8?B?bzFWTDMxQlkrOU0rMXBLZUdZaSt2QmF6cTRDQUVOVjBLeHhPY0Nockk4RW96?=
 =?utf-8?B?UzNFOG0vYUNacyttL2kxRktOcDFlNlMwQlhaOXJ0L204OGxLSEg0Z1lTeW9I?=
 =?utf-8?B?SCt0WXQwTlNLeTF0V2NSUGtuNEpUTkhYa1FuRlVwNXN4dnM0eVN2dWdKQkE2?=
 =?utf-8?B?cG41TWpqUTFhQ01yQWFwbVN6TkZ3OFU5MEpNcms0UThjU3d0UXUraGIyS3NP?=
 =?utf-8?B?RVgwRCtGbEdQeXNLcmlZVlg2TWRkanQydTg3V3ZMMEZDRHJLeitBb21IZlAx?=
 =?utf-8?B?ZHRQZGhJZmRicnUvdmVjOE93TXR1RFRiVzlPanJ2WHcyTElycHltQjZnYWFx?=
 =?utf-8?B?cEdpUnkyUDA1MVJZT1pGSi9iaXBWZlBpNUZZZng4Z2FYL080REliVzk5Z0lY?=
 =?utf-8?B?ZHBNL0pTUVVPei82WTk5Z2g1OEYxSW0xdGFzbUgzK3krRUc0NVdJWVFBek5r?=
 =?utf-8?B?aHBjUHc4SkRaOWVLVWJCbUhIWExLRTRMbmFRRFNDZG9ackFsSU1tdWh3SlVM?=
 =?utf-8?B?VDc1b0t2YWd2Qi80RXZkRWM4Q3RCV1JIQXVvaXBjUVZ1MjE2ZkdzTXkzN2g1?=
 =?utf-8?B?ZVBzSVo1bWFST0d3dU93OFR3ckdkMFdLTDZlSC9sVGRpVkhibjBZa2tGcmw0?=
 =?utf-8?B?VVJ0dzJRcWxNVnRqdGlQa2JNbjRlQ1JjMlZhYkxyWE1CYUdMMDFJam8zUVRn?=
 =?utf-8?B?Z1dKb05BZllJM3ZHaGJrOVpwZFJMMHhoL1BvdjRleXB4YlM5bm50a1QyRmxt?=
 =?utf-8?B?ZDFTNVdiZzJMRXFJWGpEVkdBU0tGWXRmMmovc01zY25qaEJFMmFhRXhNWHpG?=
 =?utf-8?B?Z2I0WFNCNFFkaVR6UHo0QzFNbEZ6TzJDZ2RDdFE3VFZSYTNzVlNXMjZKM0Rh?=
 =?utf-8?B?ZVNHRVQ2NG5xZFRPTTRIVUk3VTQrSU94TjM1b24vaWhUbFdKUnhxVjJPNWll?=
 =?utf-8?B?NjNPNm5SL3ZsbVFBVzk2SWFGVDZoa1M2RnF5TzNwREljUTU5Z2pFWnRNZHd6?=
 =?utf-8?B?SHdMYnlXbFBXVlJGZFkyTEF1YXJPb2tYYXVQSGxGZGNMKzFab3JHY1U0MC9E?=
 =?utf-8?Q?aYcGZeFKoSShv?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTVEVTRyVlU1bWlmamJYcG1FSm4yYmFYOUM3ZE1ZaExiSUJodHV1cm9uL3Zk?=
 =?utf-8?B?TjZXLzk4K2IrZTZtNzkyUFdrSjBIRFBuOFVWbE9iRGRheVJLWklxcUxJSURn?=
 =?utf-8?B?dTFQYVp4SU1zcG5OTE1WUVpORk42VFFJYzJEK3RpckM5RUlSMlJhWHBCVzlI?=
 =?utf-8?B?WUtweENMdU1IMWZJZ1VCeGUyQlhzSVNRSGEyY2NQYk12UjZNdWhrbm5OR0R4?=
 =?utf-8?B?UmQ5d3BNZm9kcmhyclV3Wjg3NCswTERZelM2UG1sNW5XWXlvaVF4Q3Bxell4?=
 =?utf-8?B?dE5Pd29Qb2pVSnNzdjFTVkFjdjlKemJKbW5qMEw4dmcyRDBmTDRCS1JWVVNq?=
 =?utf-8?B?Wi9VbEt3RUFiVzZoZlA3YUFPOG5YWGo4TVQ4d3E2bDJjMzNlK085dmpHVFkz?=
 =?utf-8?B?eGdSZlBhR3J1aFhRVSt5MmVMTk9hVm1YZkpaNWF3d3FnNzMrOHhPVlZMdWdp?=
 =?utf-8?B?UjNISkovb0NWN3ZhLzRvU3V5SkRyRmQvQWJtVHFZM2FxVlU3cFQ1YXFRZGVn?=
 =?utf-8?B?OHlha1dSdmpSRmlGOVMvRk5qT1YxZnFPb2JWbjI5UndpNE1EdVZHTXJ6aUYv?=
 =?utf-8?B?YVQ4T2l4dHgydWlwZk1IU093UWNPV0IrSCtKR0FFZUxnTDU1ZHF6b0V1ZzBH?=
 =?utf-8?B?UVpsUS9RL0FKRVVxYmo0bVdQN2IvL1Y5WFlja3VCTjBSTnZ2Yy9keTg3eDFx?=
 =?utf-8?B?alg5Nm0zQkpTaUFISEpqVUkwMHdLTmRrUDlJeGs0MDhyWVZDQTR2VC9KWnFL?=
 =?utf-8?B?cFBMWVZIbnFuZTM0Y0xVZ3JyZHpQaFpaSGRabHY4aE9BYktNNjBZNXpFRk1V?=
 =?utf-8?B?REhEamNTTzlXR0UwSGU4cE9wN0pGWmRJVHBkdGIxSHN1dWxGdnNjMEl6dnEr?=
 =?utf-8?B?MlgwUlBUcXY1SGFlUFdvalRJOVZlTzZEV1VXK1QwNExnbVJ1MlNZME1lWGQ5?=
 =?utf-8?B?SWJrSkp4a0hwM0gwVThTYWJzeHo2YUJ3SU5ESjRxcVg1clZMOGJaV1B1Y0pK?=
 =?utf-8?B?L2l3bkI0eFVuUEZIbjh1NmExdUFhQmd2RVVKUVYvTkV4VDB6SE40NWNUVk1Z?=
 =?utf-8?B?YzhtMy9pK1VFRU80c3B4YldtUFZQcDhNVDlBTzAzREtwSG9PZDdwRkNhSG1s?=
 =?utf-8?B?ckNRVVp5bWNnUGROemxVY0I2LzJHT3g0d3NMSDZidGp1SGdvZ2dVcU5uY1NY?=
 =?utf-8?B?SVNYUTczdzBCOXFPU25OMVUzNy91R3pZU2NNek9kSEIzN29OZkF4YmF6WjJ6?=
 =?utf-8?B?eS9uTjhNbk9Rb2poM3dUd29zSnJhRkczMVp2OWNzT0VrU21GTm4xcnhLZnBt?=
 =?utf-8?B?Y21uZktwZTBHKytlZFFQcUlXb1J3L3JoRm94L0JQci8wRlJLU1ppVWNoMzAy?=
 =?utf-8?B?UGVmNXdXay9HYXpacTRZcVpNNitOUEFaWlRLbGMrY0d0SXREK3lSTFlnamUw?=
 =?utf-8?B?MDJpejQ5bGpNejJFMVZJQUJMRTlpZVpPY3JXc1lGY0ZTblBVSjB3R29OcnJx?=
 =?utf-8?B?eVBNSFdMNDgvQkFsd2hwc016R2FDWHJtZ1FiVnd6Wmx4cDBGVWtUUlN3Z3hW?=
 =?utf-8?B?ZVVheklidFFxR2ZUYzJPS3ZJaWc5RU1HcmhudTRvQUliWWFUelArODBWSmJp?=
 =?utf-8?B?QTJxOWM1b1NtN0hpeUhPV2R0eG5YY25jTU0wN1kxZ1pMSklaWk42Y1kzakt5?=
 =?utf-8?B?VllMT25tdmlKUzZzemhKbVZQNlFNalU2TVR2L2JkTGUyUVd3NTJicjZTTEI1?=
 =?utf-8?B?Zkl5QVAxSldMUUlISlhpT0UxQlR1MzI1RXlJRnJsc2dpdWJZbFp5NEw2ZzEz?=
 =?utf-8?B?TGhvVzUzQ0J3Q1BGUTVHenloNWlLTk51UW8wZlBlRUpva0xRNXVRbDZTaGxU?=
 =?utf-8?B?QXFHK0JlVUM0VWRrU3ZCMkxxVGxEUExhZ3VzR0N3Z0Q3QkkvZGw0WXVZTFNG?=
 =?utf-8?B?VEgwV1JPZGJnZnA4UE1RTjZySmtkOGxhRTdQeFRyc0sxdTlzdWtyQXJnazBF?=
 =?utf-8?B?UmJQS2Z6ZUJvdmdQR2xFNTllaVlRTGhQTDQ2NC9uY0RaR2FyMmswWHZXbk9r?=
 =?utf-8?B?UG5JMzJMMGFTNmY0L0hxOU1tYkVKQkxrdUZQNGxLNFNCR29uZS9jRWdqMkRB?=
 =?utf-8?Q?iqcJ9hymcxMXkzF4GtwENPuLT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4b811PN9Lf3z/J4D3td6diC077aEAYeEBrqEvWUPvgVJousEb5epln7oOgGhkzOuFyd8BI7DeXC9vT+0ZWZYm3Qf8NIAiRm7WzStdBsTC159K3RYXB9S9ChVA14zkE78i1kXSPwy12RFxD94HXvNGnywykJGYMWBw5chYbc3I8Dqx90DVSwUzfqygkfkx4yLsNn2uVbz5G8h2UlUHGRF2rFGm2ZTC17HFcikmRm5fVoMqQ4CTBmActCPr30jADw88B7C/irojTwQ9pP7Vd1IF/7J0r5gd0rhZluci4bghS26JWdxyMcUVJCfHpqVbnbntBJJBpHRB426YFg/ANSZDLFWWAdYBlw10CONlkDSq5d4Q9Szjd0i4pmdE9XtrXm11Sh8w5vGzsAAZ8ACU2bJbgKrEKqgejF02OxSh0t5/yUufzKNJ+f+2oVNLKfiaHrruFyEzP8+dj/BOHYPkOfATwn61qhQ0prTRI8pCh+5danBsDqQbuozRmUl/l1F/sE1XoU00cLGX79IpQi/1lez+Kl5kHwlTh0fwJohAJ6786KPTaFh2YyfBr23CkTPDTO7xPFktPN2LzgdZCiBukst8/nmLn5jTXegGmLz2Q3ukrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbae783-0e7c-44a0-5ab8-08ddc3a7c41e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:59:07.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdjiL4RYUMgPPfJu8EkQCPwUchvrh4EJT4b/5iQIuoYwtXA0INQ9CzntprnjhY3qtAqZyxLBUtvk2j9UBMBcSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150128
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68765eae b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=WLGaNtMBAAAA:8 a=MD3bPN9r4_Ekn9tjrqUA:9 a=QEXdDO2ut3YA:10 a=gcKz3hfdHlw52KqWNJGX:22 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: Jgw9p1hhVRu0FEW5vv-7H8Ez69BOsNNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyOCBTYWx0ZWRfX4Q4/bwRTvuhN v1RFDyNhagOIsLtv6MTotiKD+gGXyxmfD8+Rcm5cy2dzKhYNOxAiTf/MMNbKVXrOqXdMvvj014r AXQQkLyjoGT70NwTbDoKzb40zzIcWPIvCicThSunJOdW6MFmWcSlVFFUg016kprI85lY4qBZ8T1
 vxIVBNXZWvslYj4gfiEBR+x9SMSJZ25/v9EwhvfdfKsY8rUgfgsxyxgHycqzp3De6wXNYR6L4w2 jOnoFATUAKJlcSq4SHMVEJ4tGyilAeoPbuXBqjUezQjT/xOSIpVcmUAqUfWSCaV7/i4+APFYmw2 Bwfawhg7Fu5RNJftl0Yel1X/3sitMVXhPWSRFuyOVSE2vs7BiX+bnz2fBvz1SiC8gy10lsnUQLu
 R98Xl5oomiou8FYtW9jODW0eMSYSNVWNu3EkCV/voTug48VzfuFKSVs2AgQWWCOgLmfp6UWG
X-Proofpoint-GUID: Jgw9p1hhVRu0FEW5vv-7H8Ez69BOsNNP

Hi Mike,

There are a lot of speculative claims here. I would prefer that the
motivation for this work focus on the workload that is actually
suffering from the added layer of cache, rather than making some
claim that "hey, this change is good for all taxpayers!" ;-)


On 7/14/25 6:42 PM, Mike Snitzer wrote:
> Hi,
> 
> Summary (by Jeff Layton [0]):
> "The basic problem is that the pagecache is pretty useless for
> satisfying READs from nfsd.

A bold claim like this needs to be backed up with careful benchmark
results.

But really, the actual problem that you are trying to address is that,
for /your/ workloads, the server's page cache is not useful and can be
counter productive when the server's working set is larger than its RAM.

So, I would replace this sentence.


> Most NFS workloads don't involve I/O to
> the same files from multiple clients. The client ends up having most
> of the data in its cache already and only very rarely do we need to
> revisit the data on the server.

Maybe it would be better to say:

"Common NFS workloads do not involve shared files, and client working
sets can comfortably fit in each client's page cache."

And then add a description of the workload you are trying to optimize.


> At the same time, it's really easy to overwhelm the storage with
> pagecache writeback with modern memory sizes.

Again, perhaps this isn't quite accurate? The problem is not only the
server's memory size; it's that the server doesn't start writeback soon
enough, writes back without parallelism, and does not handle thrashing
very well. This is very likely due to the traditional Linux design
that makes writeback lazy (in the computer science sense of "lazy"),
assuming that if the working set does not fit in memory, then you should
simply purchase more RAM.


> Having nfsd bypass the
> pagecache altogether is potentially a huge performance win, if it can
> be made to work safely."

Then finally, "Therefore, we provide the option to make I/O avoid the
NFS server's page cache, as an experiment." Which I hope is somewhat
less alarming to folks who still rely on the server's page cache.


> The performance win associated with using NFSD DIRECT was previously
> summarized here:
> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> This picture offers a nice summary of performance gains:
> https://original.art/NFSD_direct_vs_buffered_IO.jpg
> 
> This v3 series was developed ontop of Chuck's nfsd_testing which has 2
> patches that saw fh_getattr() moved, etc (v2 of this series included
> those patches but since they got review during v2 and Chuck already
> has them staged in nfsd-testing I didn't think it made sense to keep
> them included in this v3).
> 
> Changes since v2 include:
> - explored suggestion to use string based interface (e.g. "direct"
>   instead of 3) but debugfs seems to only supports numeric values.
> - shifted numeric values for debugfs interface from 0-2 to 1-3 and
>   made 0 UNSPECIFIED (which is the default)
> - if user specifies io_cache_read or io_cache_write mode other than 1,
>   2 or 3 (via debugfs) they will get an error message
> - pass a data structure to nfsd_analyze_read_dio rather than so many
>   in/out params
> - improved comments as requested (e.g. "Must remove first
>   start_extra_page from rqstp->rq_bvec" was reworked)
> - use memmove instead of opencoded shift in
>   nfsd_complete_misaligned_read_dio
> - dropped the still very important "lib/iov_iter: remove piecewise
>   bvec length checking in iov_iter_aligned_bvec" patch because it
>   needs to be handled separately.
> - various other changes to improve code
> 
> Thanks,
> Mike
> 
> [0]: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org/
> 
> Mike Snitzer (5):
>   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>   NFSD: pass nfsd_file to nfsd_iter_read()
>   NFSD: add io_cache_read controls to debugfs interface
>   NFSD: add io_cache_write controls to debugfs interface
>   NFSD: issue READs using O_DIRECT even if IO is misaligned
> 
>  fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
>  fs/nfsd/filecache.c        |  32 ++++++
>  fs/nfsd/filecache.h        |   4 +
>  fs/nfsd/nfs4xdr.c          |   8 +-
>  fs/nfsd/nfsd.h             |  10 ++
>  fs/nfsd/nfsfh.c            |   4 +
>  fs/nfsd/trace.h            |  37 +++++++
>  fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
>  fs/nfsd/vfs.h              |   2 +-
>  include/linux/sunrpc/svc.h |   5 +-
>  10 files changed, 383 insertions(+), 18 deletions(-)
> 

The series is beginning to look clean to me, and we have introduced
several simple but effective clean-ups along the way.

My only concern is that we're making the read path more complex rather
than less. (This isn't a new concern; I have wanted to make reads
simpler by, say, removing splice support, for quite a while, as you
know). I'm hoping that, once the experiment has "concluded", we find
ways of simplifying the code and the administrative interface. (That
is not an objection. call it a Future Work comment).

Also, a remaining open question is how we want to deal with READ_PLUS
and holes.


-- 
Chuck Lever

