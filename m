Return-Path: <linux-nfs+bounces-9903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700CBA2AB80
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3304162622
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A68236420;
	Thu,  6 Feb 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eclx1959";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ARWtZVoN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DB236428
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852559; cv=fail; b=fp98ycbrKZtrQ8ad02p8M+1DdNR2UuDrG5XiSJAW7sdnUnogkrImELpjhsEbsgWmv5IR+Z0kugLQ2/8YtKkhyJR6JhvQ5L/Ey/pi1GOO5tpbGIxfHCj2zwEGmQ0vto4yViiDPNIBIavas0tdWNspVQKATbVnNY++i/Ev35JFvIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852559; c=relaxed/simple;
	bh=sx4dc5O7KtwcFPg56pr1BgvOd1Iq8M91uzOD42h0Dr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MLZ5UB36BKBPnnHaKOG/hDg+RMzdQnI1xVqXf+RYsb0ApfqOgRxTedu0G1D9js2y6eA8UuhngvMhROYW6HQh6HanZZKjAJPVSdlrMDK8eI+pK3xKcv1ocsn0pdTus8/JDnyCjznIkdU7eKtTV/6s23GPOf8p9rYLM5VZuQnzaKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eclx1959; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ARWtZVoN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161fqVQ025123;
	Thu, 6 Feb 2025 14:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MSljaL/qaimgQx0z9Fx7W2+hJTL/PWlV+aBDrwtX3rk=; b=
	eclx1959JXzr3L1dOopoQLVh1g16HbpH4AqV8G+QhDX1/CqfG09Da1IG2hnHOojw
	jFEwVf28sjXeMJ0JWTelKzUeiTA48EOPxQUCIYRyZKbUlcKu8Ituu9xOp8NomUkF
	1zV966+vArEhNkUWtwdarwLLLEuYnCQsonIrpriSxf/cDPL1LjCKtOp57QuKrnbT
	pkDtSXZnidA0cyODV+bChR8a2bD6dE3MAjN4pA5qdF7thXJYTVKCkW9RWDzEjRZP
	OeiRPHXPGi2FkHwctE7n0IUEtfH3Wxe5Yu6LpYE7ASjRFK148r9Vi4KdgxmcpVEC
	qufZiGod55LVgGyaoFiZDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbthf4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 14:35:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516EBmsK027906;
	Thu, 6 Feb 2025 14:35:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dq62gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 14:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwdHFIjDGMJ4wQqMOKtVUMk8iM3LMDuqhNpBZC9vY8wNsw/JZfHYRUxxQ+/M+70F0RHdp/B16mABH74p7IXwnK2i3yRByQGhv8VbMmEHCz1ZSE6ek4I1TiwgYQfSRvvm6s4ANymVlQbdx0lQpv4cyyl+r8Ch12ViPwUjedFgnn79b1DMx61J+CffDtnORnSJgBynzCLlaLbd/A8T47V6XQUn484ehZmcBCKJZej2ru0l6Oq9Pzft4OAsZ90cDWxYeOhi0XowNX1Yk2CfqIhvkGkQHkYjodvNgQ/lU5w0Ec5FAA5s8GAIi1AK3wN7ufyKZN7SuUI2WCMTRrjddVgYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSljaL/qaimgQx0z9Fx7W2+hJTL/PWlV+aBDrwtX3rk=;
 b=srIecAMA4ZKHLeSristBp1DOfRYX+Q7DS1+XyiB/f7w0deBFA39EaitKELtnAMvJI6WbjzoQMl4Q0qPE2V99ln7v31+/b8uf54oX3UP/qAZJXbWyfLd5T6Qku/dQsHCnPgqrCzC7oEu4h9MFHi2Umbx8vmB6mO/+htmN9esS83An8iqj0BGEhNAB+LmDqOhcek/1CWkio0grldFg9yi7MzQSx1ASoEj1dUdMvpyZUWoA5SdQYPkGOkaqgqU4u93b2BshCopl6lRhO6MI7GGXc4UfKTfQbekSrnBHAHCmp0oeCagaABwg6+3qf7SkRPZa2S7YVaimE7F/JExF+eKeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSljaL/qaimgQx0z9Fx7W2+hJTL/PWlV+aBDrwtX3rk=;
 b=ARWtZVoNkF+uT8yv+OOSCWbh/D9LlxYNK3Lubmj8rQ19CxQN4RVAnqe8STBqIuNKJ1p1Q679mEweIhy0IFWfQpDezf+NqJywpXO2/dnWutEhwhHHfV0MXkpplWXwjuqtHHuMAI7Gi4Xa4Bm7VL4jI6kksmBh/uBJN3S2tgIizP0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 14:35:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 14:35:33 +0000
Message-ID: <38d0470a-f63f-4f42-a6db-dbef28211e60@oracle.com>
Date: Thu, 6 Feb 2025 09:35:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
To: NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <Z6QcwbsFfOahoJ1P@dread.disaster.area>
 <173881109569.22054.7095290604295647912@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173881109569.22054.7095290604295647912@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:b0::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: db846a20-759d-40e9-25ab-08dd46bb832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjJ2QzdkTSs0NmZtZ2x1Wk02TUxrMHo5OTBaT3V6VldMWjI0YUd4SjJ2NXBk?=
 =?utf-8?B?SUNEU1ZOZ0ZSTFpxeTU3a1d1cXhQQVJReWdaSFVJQllpUkZwZER3dWxuZThE?=
 =?utf-8?B?YTl0NlhEWVc4QVArTzlZU1JxWWZXN0ZvT2RGRjFYeU03Yy94NjJFbFk2YnR3?=
 =?utf-8?B?OU5GRVVqWEV4b1RtaGdYTXBIVGZIOTNTTWdEQUJqRnc2MXBjT1lneFE3aVE1?=
 =?utf-8?B?VTFROW13Z0V6OE42L2YwSHJDWkt0a0gxMVluVjdQMnVuT2hteEt2SUE0MWlz?=
 =?utf-8?B?U3BRZ1dXL3BNVGRNVlBjTFRReHQrNEIwUTJQbDc1a0NJT0NmRHVNWFUyMDRD?=
 =?utf-8?B?RnZuUTNDd0YzWWZGOXpLTkRtWjVvUC83QzlWQ0doV0R3YUN4VUJRMzZVUDFz?=
 =?utf-8?B?UG5EejZhU1NjTDdTNThwMkFTNU9ybWNnakhXZnpobGNKeUd1RC9UbFd1VDhz?=
 =?utf-8?B?VjR5TFlhZUhQdFR2OUllczNaNWpCOTVmN0JnMDduSVZ2bWNvRHJ3akxLTyti?=
 =?utf-8?B?a0NVU0JyVjkwZ1lsV1Q2MWtQbFpoV3RmR2VqZ2lpL2VuL1JDTmFSLzh0N29S?=
 =?utf-8?B?MGZWTVJqaWtNc0tlNjBYN0w4bGcyeXc4RkVlbnVDQ2kzOXNlSTBXWUZpYmhQ?=
 =?utf-8?B?ZnJZZHgvcnFjbC9BUDVQZ0MrUXBham5FaTJkdmpNYTQwODRQNldQNGYrelA0?=
 =?utf-8?B?ZXJmc1ZyUko4VUcvVDNlZDRiQ1NONkdUalQzN0lKT1pwRFY3eXlPU0t1ZXBO?=
 =?utf-8?B?SzExbUF6WVVVczhsS3BsWlVXcWsvMlBMbUhGbGkzYmdOY0xhbnpiWlAxaFdF?=
 =?utf-8?B?ZFJLejhvQit1eTB3aDZsZEpqWVgzUFdCOCtQM3Ixa09KUitrSVR2QjQzSlhu?=
 =?utf-8?B?Q1F0ZVQzdmpsdTZId3hDMDhvYjYvQ3E1UUNtd3NvOVhzaDhud0NIcXVNQ0Zi?=
 =?utf-8?B?NWFDWlR2WDFxZ2tNd1JxZzB1UGQrMi85L3ZvOEEzMkVuOUpWMUczNk95RllC?=
 =?utf-8?B?eFAwTlU1SkNFbkphUGw1WHVSb2tVK0x0UlJDTXRtYnJ3SHdtVTVvQXkvTHRx?=
 =?utf-8?B?cXpvY2ZTb3FjYXh1Z0IzMlNWN2Rha2tBaENsZXplUjBJUkEwT3hERm5tOUhL?=
 =?utf-8?B?WEFqM014azh3TmMyZWtWSFdjQXRPNlBKcktBRkZTa2ZLdmJNYWZXNzJrUE9I?=
 =?utf-8?B?M05jbTdFQThVVXdsQzByVmFNWDZQeHMvckgzL0VMajQwRkJzS09GVlRLcm1u?=
 =?utf-8?B?c0VCM2dZZWl3ZVZOSEVadUE5TUlnN2RUM1JPZ3kyTmZ3VjExNFZpNjgzNUUw?=
 =?utf-8?B?c1MzNjlVUTJDZ1pZTmFzbjdPR1lQUWFnOHZ2MTByUUlvZG9TbjMwY2ZCZkdC?=
 =?utf-8?B?ck1lMncxRmNadUFKWjRQUVBxekZDZXRTa0h0VkFRMk1OamNpWUh5WVdDbnph?=
 =?utf-8?B?N2t0dkNEL1ZrVkxxRmtRSHVFeXN3Mk93bUplakRSYWpSUzZTbU1Cc25EemR4?=
 =?utf-8?B?OUNRWXI5UmYrdURFOFVlWVJzT1R5U3ZEbFdiRlhWSnh5R1dlNHkzZzRPVlFi?=
 =?utf-8?B?WmhpWWU4NTRvb3FISEVyTEFlTGp3UU9BaVErUVowbUJBN1A3SHF1STJjOFJu?=
 =?utf-8?B?UUJsU3ZTQkF1WURGbXlhaFMzbk92Y25QMGw2dWUwZnEyRWxFZXFXSkU2WFZo?=
 =?utf-8?B?M1N0K0NIRGx5aFdmTXZBL2FBQWdWNUVNM0dITGE2cVh4VnI1Zmw0UXF5WW1E?=
 =?utf-8?B?OFNvSkJ2RVc0S3dSU3pvTnI0Tm5aMWZjK0Y5VlBWTVQ1VTZpekU2eFFZbDlR?=
 =?utf-8?B?cDh0Y1hOelBzQ1JFaDJ6T2k1dytXVVNzYjRYdWZZdWpVWXdGZVg4cStxNWZT?=
 =?utf-8?Q?Xs7Zyw5dknu6v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0xFbjQvQ3ZvczBxZmd6Sm5NYjVBSVlzYTl0cERJdlYxVlFIaGFKb2YrS2dP?=
 =?utf-8?B?dVNDQk95d0R2Q2gwQ3c0bFVaYzRWWEVIa3BUdTFUOGVkNEhOTmJvVEhtNlJX?=
 =?utf-8?B?Ty9GZ2lDVVUvQzdzRmZtWndpM2JEd2JaT0R3Z2V1SDl4MmJ1ZUpDSkNQOGxX?=
 =?utf-8?B?NmN2QXpRVlZ1MWhJeVNzZEdUc0RzQUN1UDVUM2FPV0xSb0N4dlRiZ1c5NDFJ?=
 =?utf-8?B?OVBTUEszWTZqbTFCWStTamIrU1RIbTF1eG44WFRGRmU1R1BqaGQ1Z2pWSzBD?=
 =?utf-8?B?LzB0S2JCNXBQeHNmMmgzM2VjYnhuYXo3UXRRR2VxT1kwRk5ZcnZ5YStCNWo2?=
 =?utf-8?B?ZFpDOXZWdmxHVWI1N0dnRDAvajgyTjA5Wkt4NnlKRXRJVFp1Ky94UEZQVjFt?=
 =?utf-8?B?U3VUaGNZYWd3Y3dYeTJCTGJEN0xES1oybmRrZThCS1RSVGdHNVYrRDBWUm13?=
 =?utf-8?B?eHBVVm9rd3FyQ2hNRmgwOGtucWhtS3hpRlJ1UVhVdTdsY3dXcVF4MUdEZDZH?=
 =?utf-8?B?Y3NOVUc0c3d3WVRPNndmSmNlTkUycGJjZ25Db25lQ3dSemtBaGlJcCs5NG0v?=
 =?utf-8?B?MjdqaHVZU0tCRitSQ3JZK0NzZ09vNG9IT0w5blFERU1MdlhLc2lpU3pRbkpw?=
 =?utf-8?B?V01yRjF3NEU3dDVsUFE1c011MGt1OXErc1V0ZHJ3QkJybVYwOHBmdTlVdHhB?=
 =?utf-8?B?aUR6aW1UdFo2bmYvNXVlOVZUNFZmRStnMjVVVjNsNzN3cHozeDVIUWlIRnZ4?=
 =?utf-8?B?SHVTQ3dEQ3hEb1dpRVFyaUhzc2cyZEd1R3R3aEo1ZGhFQnlTRUxvMXBhQUhw?=
 =?utf-8?B?YlRrSWEzN3BVVHhmM0xnM1F1Z2cxMHl5b2x1eDFTdk5oWTJvUjJCUVU3Y0hv?=
 =?utf-8?B?UU5aWmw3WTR2QzAxeFQ5d2NxMWlTSzJ5NHVPRWl0ZlNmWmlhMERlc2Y4MWZS?=
 =?utf-8?B?dEVHbVJSV2l6b294Zkg2bytHUzVUc09wVTJoaVBoRU05MzF0elphbWJyL1NP?=
 =?utf-8?B?MmQzbUZrYWlsQzVPSmx6T2RHemFndXhubFo5YjVhWVJ3ZXNYcFJEVUVOeUNC?=
 =?utf-8?B?MWRQV0NVek1VSG9aOXhZSlE3MVpKZ0ZnUW5BSGl2em1pMWIwMVh2TTd0aS93?=
 =?utf-8?B?dFgvN2tIaWlPS2IrcEZ0a3NHTlR5SjFhWmlKTncwODBzQnJGVGpGS28zemtF?=
 =?utf-8?B?RlMrY2tiTUFEZmFMTTVNUFQvRDU5aytuME16QStHaUJ5L2xTaW1YQVBhdGgz?=
 =?utf-8?B?MUgrY3h0aGZROXM2RUROY1hkQ0VpazNRSFc4aW4xakxKeDI4YmVSY01zclV1?=
 =?utf-8?B?emN4OWFNREhLMUFQVnVJT1lNK2x0d1V0S2pLWVZ2K1FWSVlwL0lNR2U5Mmkw?=
 =?utf-8?B?K2FWcGNEYmFTZzdhdWlMV2dlVVFXenFyN1VaTEdPVTdzS0NPL1BMRlE3RURv?=
 =?utf-8?B?bzFZd29DWUFXUlZGbzMyNUtDVmNRSWhaa3d2Z0tXVnkzTS9VcnRNMlUzTnJ0?=
 =?utf-8?B?S3o5aHEyRGQxMlFzS2RTdTVQU2dHaHVLcThSc1RKRHpVV2dSSkNZYjdQWkdl?=
 =?utf-8?B?VndSZ2pNN081aWJDS3V0ZjM4dU9DU2FYNlZ1Zm5oWGlqZkgvNGVZRUlBanp3?=
 =?utf-8?B?Uzg0dkN5SGk4TzhvcDcyQmI1b3Z6OTdHeUpqZ2xVWHRhYUc1YjNuYTNVOHZP?=
 =?utf-8?B?dmtRdjh1TnprUlZpVnI4YlRWMS9ibEwrUzk3ckFTaWpRdGM0Q0F3anRLd2Js?=
 =?utf-8?B?YUZPZ3d2bjBmdTArZEZtTmZTTjIvZ0UzYVNZdmIrdTRwYWxhWkhMSFgzbHhZ?=
 =?utf-8?B?cjVnQnBKb1NkUi9pckhNME9EWWdKL1UzaHJxNzdOUGhFK2lDNFZJUW5zS29H?=
 =?utf-8?B?S1p0eWkwVlVGeVFSdDFpeldjREdHSlRrVWQyYTJBNDZyemdHeVdwWmN4Q3NS?=
 =?utf-8?B?MkIxQ3FKeUFMNXo0Y0lrbmV3ZUc2M1BBS0E5NStQZGoyemlxNFBOYndub2dW?=
 =?utf-8?B?bzYrUUgzM2NNZThhemNZRmkrUURIbjArTjFIc0NMUjVJSUFvWTZBRFNUZE5S?=
 =?utf-8?B?cCt4R1hnWUFWZE81bWRzdEhkYUpmcDc4c0pRN3ZQaUJXalowa2xHbkVXUm9J?=
 =?utf-8?B?VDV4NExpYi85alowNjBUMXZIR3Z3ekkrS0RrR1lTanVEZEpFRmtZRWNIcWlt?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	89IcJFy7y0vtWr3sF8/Y5Wb9oEcoaPhnV7RmSkj/FHIN3xMcnrknvm81L2l1TddNbvqu/QvxGNiRV2NJkaAzWwBniD5eAATorDC0bc6O/UMjeVkJNZz/IXRq2xFCUjLikwOHXKrf/WzTi108NeiSMZ1WQATKz5xAZy3tBfmxWSHpDQGAhf1gFzvNAS8IzlwZr8EYPSnijophdy3hJsCRmETB9XQ1BqSB4MiwmsCtBsRaGEkNEK3jKYguvp3GzCX0x3Vy/zb67nIntB7mLjc3/yQn7JJb7dlsxYMEc/fZcrTTB2lNhAC1cMd7pyLCRb8DAjNSNB3wapp3rZ5b+HZ8G7XAI469to1UD1D1rdIXPiUtWfFG9j9+uI35hiWKl/mK5HDGZRMfzfLqhSr9Dkb/2w876wUJkbJB3JHzh2+Q6OFkGhmZiz8EKcJ3+m7v+GtayHu5iD/NzknwKeBK2nHY4McGxOecgPsj8BrL3dKFwki2lbQXS7UjErzhG5nOgzAzwEEmczuwqWBPWMQ3BY30racYOCVwUa1KMuaKjYzevbuUYpmsRbnz/d8pbxjBOuq2rTcuDlY4TzAhYW3z5ul6gJVSVar67lVvBchcshcYui0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db846a20-759d-40e9-25ab-08dd46bb832b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:35:33.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSxAAPcLU4VAmhQ8K1TmokcLNnoRUvGt7wAgUJgUiy4NYZ/E8qIA0+IQ4G8hEWzHUCs16F+2zwTVfApAG7Mq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=735 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060119
X-Proofpoint-GUID: gw0MdqWmyK8fa8oEHKVnvjjFkuaFXMTC
X-Proofpoint-ORIG-GUID: gw0MdqWmyK8fa8oEHKVnvjjFkuaFXMTC

On 2/5/25 10:04 PM, NeilBrown wrote:
> On Thu, 06 Feb 2025, Dave Chinner wrote:
>>
>> However, *every single shrinker implementation in the kernel* uses
>> this algorithm whether they use list-lru or not.
> 
> Yes, but we aren't doing shrinking here.  We are doing ageing.

The NFSD filecache uses this mechanism for both aging and shrinking.

What might be appropriate is to provide a list_lru API for aging. That
would have the benefit of using an existing common mechanism but make
it more appropriate for NFSD's usage scenario.


> We want
> a firm upper limit to how long things remain cached after the last use.

Do we need a firm limit? The age limit is not about correctness, is it?
What we don't want is a remote file access via NFSv3 to keep a file open
indefinitely. The current 2 second value is not a deep requirement, it's
merely a value that seems to work well.

That aspect is a little different than inode/dentry caching, where it
can be valuable (and at least, won't be harmful) to leave the item in
the cache.


-- 
Chuck Lever

