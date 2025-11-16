Return-Path: <linux-nfs+bounces-16431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A00C6189D
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E95D0353336
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6461930E0E9;
	Sun, 16 Nov 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hu4S/VoQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EMy3a/JU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93642286A7;
	Sun, 16 Nov 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763310602; cv=fail; b=I8IDkw9CI7cg0xWS7aJIgqVchrgwCDhzlYEFor4XHAScdPPJQKlV/bI9V+H8SlR9yLmaU8ANWODWu6LZ9n9+arKJ+C4lI9ls5gE2C8XYiHTF9Aukm6+YIwbWEdDG/IrtcvPzRPIJWNdrryjAHStq1WG1VFxe6ojHQRGlBmLEzL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763310602; c=relaxed/simple;
	bh=kjfl5gSMwBVNPgeOIV3JW7+CtamI8VxWHc24gpbtnbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSRaVyPLEeH2oDKi0IogSuM0+slq0YxiEDX7yPfSsdKfOi5WIMH1ooW3boJuBjl05fxiiH9KFv9DMlS87+guQo/rAL+iLp8ppVLlXiH3ZxkJYQmZLlimuQPqZfHP8rrwC+QiHBzOEs8qX7ZlRHxQuksuk7kY+K1vLO86adRzzhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hu4S/VoQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EMy3a/JU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGBsrcs011447;
	Sun, 16 Nov 2025 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mGKJ0w3K9g1I50LPfiG9PTJ0Ca+yu0FoXBUMkOltztA=; b=
	Hu4S/VoQvujz+6r+zVXhmm7haFKGhTc7V22wKR3SWmTJcpFsNWhKOx9e+0HLdSgV
	/+b/BtBc9SXQgwHxH+xJTXh1wfgtfG/0p3oRlxyQWXwYWiJGdbsULiugBceYxhjQ
	g0DzlyVbZtH8yymGReVJ4DInC83bpEL5YMo8Gfb6z0mSx7RAD4eElsT15j6iY3DF
	ZNoKp6Kq7+1mqGa7WgBsFBVq+kRglFUmw54vIDLmvBPMOQr8/1j+12IR1s3QtoHq
	c8Tiko6BKcsWOO9nFklWVipamSqlPUuE8bkqWHfI1nykNkHOLt1clNJ8PS30PCNR
	lnp2SAvQ8GmZdtARrFGkKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuh51b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Nov 2025 16:29:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGE5Y0r007756;
	Sun, 16 Nov 2025 16:29:42 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy6t3jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Nov 2025 16:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUP3sx2mrWAsCv5svEqf8PnZ37VBaN079jMAXwtyBLC1tWLJxcw7IM/Zm02bzbiwWXHB7N89VbIFVINKWTt3skxXyU0f1PiJ33r5B9KCtS96Je3Qc7utpB2yPGJcSbaAmVz8TLzWQzsVK9GiEJxR/A9EMr+izIz3k0GKvU8Q82cKho8HHLD2suJ98BppQM67GTgaNAQRN82CNOAPWCPahM/xpPeTkFyvoTNJ1Sc1g/UzecRPJMuDk35giRvqH86QVjV5ISTMJpuPjjfZVbu0On7OySHN+9y22nNtANufyEDK+aK4uCMoNA4Rourdyc+x1hgBuW9oDdFmIxM7hVvSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGKJ0w3K9g1I50LPfiG9PTJ0Ca+yu0FoXBUMkOltztA=;
 b=RESyJ9BP2JZymhI3PCS7qb2lXsZ5pzXDAM4Y4cPPjkA/eHvDtIvkhlcnM1kZdNDasZiQPib4XZWzeDjbDkXS58JBr7yKL/NiM86Z1pDej2GOFkvB10rAztXKAdk2zVq2na4Jkee9c85Ko6XJievlHsn4mW65cIKTsJzWWFsLzQ/wRNXrvDwiqDV2CJOsnT5R1bUnxSi5Idh+G/dKjtSJ16bjC5CU2XZ0kYzr21yVdHeGm1ly9VNPUDqW9E4DPr27ZKVwuEbFu++6Qd0t1MZG+bv2t2FZC4Ob9S/tZGyo3ElEj/NMwWFwGOODfC4VE5IF8FbFTpPRQKV0dLUywpVU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGKJ0w3K9g1I50LPfiG9PTJ0Ca+yu0FoXBUMkOltztA=;
 b=EMy3a/JUOMFkrtvFx1d24QqMOyd75cp79Rv6e/MioOf0BVz2zFwUjsq88puBDFkWguJXt6G8SLxDaXGqR+ZaNkMZWmjBalIusrfBGGWhM44KSXYW42PN3oZbDUoxb21Dj4cPsO5SH0S8vzVDtf7leKLgJoan89z1z2lu+4SyqLg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 16:29:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Sun, 16 Nov 2025
 16:29:38 +0000
Message-ID: <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
Date: Sun, 16 Nov 2025 11:29:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Tyler W. Ross" <TWR@tylerwross.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <aRZL8kbmfbssOwKF@eldamar.lan>
 <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
 <aRZZoNB5rsC8QUi4@eldamar.lan>
 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:610:50::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: d045d37d-a75c-400b-e8a5-08de252d560a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cWY1VWR6T0ZYaklJU09OTHEwN0JHUnN0SFFWQjREb0hlOWNaQ2hDYnFEY0Ri?=
 =?utf-8?B?NDFyOEh0WkNnc3NWcXZmejJteEZrY1V2VUVuNE9PYXRmTEUrU1ZWZjh4VVlk?=
 =?utf-8?B?NytXbXV0Y0NjdVFselJONjRXdEpPL3pOK2t2cUtucjh1ZkFNc2s1MWpqWjM1?=
 =?utf-8?B?aytzVGJ0OGsxQWNjUFg2R3liUUptdWN5cHl1UE8ycWE2YUlwYWQvSHRaYXJw?=
 =?utf-8?B?WCtGUDJUVVBxNDNYTWxBdkk3VExlY1JnUEdXTmRPV002YjR6T25QL2hUMnJM?=
 =?utf-8?B?WkVJOFJpQXpIeXViWmlnYUlSM2JwTzA4QUtyQ3lHR2NwYUErU2dNZnppbUkz?=
 =?utf-8?B?cUk5aVY1ejNOM2dlTTNxVzFGSlBjYkRad0VjNW9KeE1NajV1K2pXMzVCRW1u?=
 =?utf-8?B?dmt3cGJra2hCc1Z1T0MraTVkY2RzcWxneDRNRVd3Sk95dDBLS3ZYVTRDaTB4?=
 =?utf-8?B?K2NjaWdEQUE3OGNXcE54RWg0UGlYSDNEWVBZbE9ZSm9BeDg2bW4rdGllVW5V?=
 =?utf-8?B?QVZ5d0YzRmY1UWYyUHRaK1pzS0N5Nmc1QWZ2VnhiR2VsQzNqcGplajdWSTNC?=
 =?utf-8?B?NHVpL0ZIWS94SlhPenJOTUFQOE1wV1pPWHlreFBrY0RKem5OeFFoZFFlMlNK?=
 =?utf-8?B?dzJoZWpSdk1HWWtCS21HRm5xb2FhV2VnQVV2c0cwVXlUUWhZOTlTWlJRdGEy?=
 =?utf-8?B?UENDN3UvNzRHWkREYVh3U1NrN1hmUmM2Qm1YZlYrNjFaR3ZVcUZVeUFidC9J?=
 =?utf-8?B?c0FZNk9kbnd3Sk9kNHBjdmMySDBweVB1ZEtOdVh1VHhPU3lZckZpNTVhNDQ5?=
 =?utf-8?B?cFZGK1lkSS9uMU5UWm9XYk9tTUtXRXpNMmFiNHBwSlBFOGtlTUhVbkFrMElo?=
 =?utf-8?B?UzNDdW5vVG1VUk1JY0RRUXlwdXZNS2ZjYkZCS2JLNFFuY1pmNkF1bFU3RFBT?=
 =?utf-8?B?QUg1NllxTjBBRzNjRVlONEY2L3lxaTM0SGNaNk44M0o0b2pqUC8zVmJJem1B?=
 =?utf-8?B?dnFxQkdaWVRzaHBkdzBsenRZNzhIaW9ZM1pkbC9FblN5VFdSZW9QcmZCMGFY?=
 =?utf-8?B?SnQ5TEhyaUlTa3pvR1pIQVEzc21CWDRwOCtGVUpETWt5Z0lsSFlWam8wc0lE?=
 =?utf-8?B?dG9JS1Q0OW55QitpQk5PUHQreld0Wk9GQ0JwMTh3aDdsZDVHWGU1b1kwZElh?=
 =?utf-8?B?YklLamNUNmVkRmJRRklXTmdZT3lkd0d5TzlKRWY1dCtEM2FPRmhrQTJ4STZZ?=
 =?utf-8?B?WnJBclpkT3ZWYlF2U0ZGYTI2WGVvQVU0SkVVZm1neFZlNkE3V0xwMUo2UXZt?=
 =?utf-8?B?ODRwUytGaVVDL01yM0w0NGlFMFVlY210UGphM0FQcDFWTHNtN1pUYUZCQjlW?=
 =?utf-8?B?MDgzMm5oLzZESm5UdGRkL3lkMG9QSnpWUm5iVnl1L3lvdUUwTHR2Vklqc3Zs?=
 =?utf-8?B?N2gzM1NndzMxZkgyMjBmMGt3cmdzUHJ1UmRpSGJiaHUyUVRqdXdiaFdHdTdB?=
 =?utf-8?B?THhqK1VZS09sYUVRcGNtNnE2M2pqTnhrZHdsbGNyanZscFVMcEZOaUdqeTJq?=
 =?utf-8?B?aHBYeFZNNVJZek16WHlPL1lLejdzNTVyejlST0R0Q1NZc1NrTzFrUGlKdnpZ?=
 =?utf-8?B?WG5leTlGOXVTcitUdGxjdnFpbDIvZXdUTXJhN1hQZEFKR0g2MS96dnZ4SDRR?=
 =?utf-8?B?a2xlUDF5T0ZGYTZydmNvUHZDbUwreFprVjBxdXpSa0lkYWJYSitBbkYxV0RB?=
 =?utf-8?B?V3N0K0Z0NlRGVUduMitFd3FzZklZZ2Y1em84OVMyYXVBck16anVMd0l5SzN3?=
 =?utf-8?B?TmxkNmE0NTZEbEZ4L0t0b0JFbjZzT3VrcU5zME1RQTAxMSt5L2xXQVNQaXFH?=
 =?utf-8?B?OEZZcFJBTkswRFhaOFFmSkxCZDB1TGFlU0pWV21wREhaeC8ySjhVNXFrdXJS?=
 =?utf-8?B?dGlvODNvVlpzK2lYWm5qcE11bGxzbDZWTitySzVIOHR1SEY4OGZCbXZ2OXRS?=
 =?utf-8?B?OVJEYlQ3eEp6MG53cHFOcFlYT2RCMnBnYTNxZHJLVnZIK0h3WW1ualREL1dV?=
 =?utf-8?Q?8pgXmu?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VjZDa2dRd2Q1azRLMmxQdTFBT0tIYURodW4wK01MQ04vT3E0SFdQME1YcUJz?=
 =?utf-8?B?SGRRNWtjOXQxeXhMcDRSMXRYTDFxdE5ZVm5qZDFQTS9LR0lOUENwZFpFc09R?=
 =?utf-8?B?djNYakN2d1psdWhGOElYMlBoNkM3UzRRSTNPbUg5MmoyWXBpV2d1UnFiM29n?=
 =?utf-8?B?Qm93WUN6SERIYktRN3NoM0d2bit4UzRDQ1p3YUtFMlA2SGltc2UzYldpeWV3?=
 =?utf-8?B?SGh1TzJkL25XM3lCc0c3S1VRVkVqckZaU0R1eEtaUTFHQXBkRlhmKzlSYU9X?=
 =?utf-8?B?d3A0ZlBMNE85dnJLR3p2dTlKNXBKdHo5Tm5KNDQ3MWo5T3oxWlhydEg2TVdL?=
 =?utf-8?B?Y3RTbVpVQUx1MjYwaGJZYzczL25RTFZjckhRQURqTDd4N1BiRnZVZVd5ckNX?=
 =?utf-8?B?aTFzOVlXNldyaFFveERLekp1ZU5HWkhRaHBWTzJVeHMwZ0NuLytONjZ0U0Y5?=
 =?utf-8?B?N3F5djVNK0dmSkkrUFlNa0ZpMEFiVUVBSy9IUkEwanVBSEJvU0N4S2lUbGF2?=
 =?utf-8?B?S3h3Q2ZBTXpVcjB0bGRTakY0S2pSbEtPc0VqZkRrcTlxOUF0Si85SmNvZ1Fa?=
 =?utf-8?B?M21qbkFBVVlVUkRNYlViSjBRTytiWTFKVUlMZUhQWWRGTWpmdjA2VXRhWGNW?=
 =?utf-8?B?eXgxNXVWSHErSmFCVm5QZjRZakVwcjFNTWlkcHViYWEwaXBsaGZ5bWU4WHVY?=
 =?utf-8?B?dGd6RHZQa2NXNDZvMno1QnlMRHhBZDF1VWRGeXpMTlFucXdKR04wSG9OMDhY?=
 =?utf-8?B?VXZ1TDN5dFJiaHdUdGNXTkRVZ1lnN2ZSeHQ3ZlJpWWg5QmpOSTUzK0lWSWF2?=
 =?utf-8?B?OU9VT0tvbEtrL1ZIVkhQY1hPWkZrd29oQjNvSDNHQk4zQ25XbWdLdUQySU8w?=
 =?utf-8?B?NkFldzFNTmU4NXFBb2JxRVRDNmh5SUJkaEoxQ0krNERab1dZN0NqTjllTkFl?=
 =?utf-8?B?Q0szT2xGVTI1Q1pNazN0YzZrQXAxTkdoY3AzcWVDeTgzelZHKyszTVc1WjEy?=
 =?utf-8?B?d2psaWhoQlVmVE5EdlVhcU5vaUhiaXU5NEpqQi9GTnQzVnBJWmxFRXcxc244?=
 =?utf-8?B?RURKNW1XVTJqdFdlQ2I0Z05WandvT2VRdFp4U0wwQWhNTU84OU5IZHFERENV?=
 =?utf-8?B?T3hXVWhwNldiZVZNSVZPZThyY2hlcnlWdVgrZHBsbWxYYURPSzIrMXNkSGRF?=
 =?utf-8?B?ZGdXZnRHWlZsTzV3bmFUajVoQmNkRDM3NkVBQzlRNDUyRW5ETzdpdEpHYTRZ?=
 =?utf-8?B?YUpqTTVMRUNUNFpPbGVsR1BhZjhWdmdEemswaHdUNVMxOWtDUXE0MWIrZzNL?=
 =?utf-8?B?ekl5cHJ5bktyVTBQMVdJMXorcmtxNlNyN205L2tvRW1nUFZXR0h4MzRoNFVN?=
 =?utf-8?B?RWRHM01xV08zdEJjV09TZUQyY2o2dHJzSEtVZllkUVF5MG9vcVdqaVArTS92?=
 =?utf-8?B?eGJ0VXBGemhnTHVFYVByQVRIRHN2cXZOVXB2WHN5ZkdaRE5Za25aSFloQXBj?=
 =?utf-8?B?R3dheDd2NmRjTlJSYTdGNGFHT1pOSGpIdm5pUDArNDgyNy80NjhmZ0F3YWhC?=
 =?utf-8?B?QUhPdlM0S2ZvbDF2TTV3S3VZL1QxbkJ4Y3hvSUl6bHpPMk9CUTFyY0hLM1hR?=
 =?utf-8?B?bDlvUmVzeWFEZ1BUVDBPbnZ1b2QzNWdyVzVUNlB4MlM2ZlljbDA3d2pqYlpS?=
 =?utf-8?B?dXI2akljb2JHVmh2cUFUUnlTNTMwZE1UNTFSVVFxM2ZQNHhzNFgrY0MvV3ow?=
 =?utf-8?B?WE12VnJJaHNOWTdoYnNqd0xiaGRuNS95bVhLZ2Y1TlN3STFqQ21zR1ZORFZM?=
 =?utf-8?B?Z1dYT28wdFlCb3NMbDB1QUdwUEVORVo2WXR0VStERXZ6QmRRcHZUUk02c2hI?=
 =?utf-8?B?MDkxdWd3MExkVHdQNXpQekJuVWU1RFUySGxSV29mNXAzZW13bXVqandlOTRX?=
 =?utf-8?B?Sm9sdkFLSkh2cVNDbnduc3ovaWgyU0pSLzc2VVFxS3FNNUJyLzQ2dDhHWXY0?=
 =?utf-8?B?cG13TDBYR3JxVFFnbW0xNE9KNG5jNktxTC9OOVYyQm9CNUM3ZEtJKzdWbXQy?=
 =?utf-8?B?cWE3VHQyWE53dmtWa3VIN2NBb3BMQnNLdHJqUS9sZ1ZLQm5LMXJ3VHNrV3px?=
 =?utf-8?B?eHhTV3phVFJMZlJwY1g4WEx3Y3lqYkE4eUQ2YUhhTjlQZmtkK0hQVkVyOG1l?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tTz7C8AEgHlqDtkHDGprdWmNqEaYy/GwvKFnqywOd/7QMjJXnPCmRjLJpDnrMjriUb2fOeEQ3Q3YjX8ocYAXve+QFHcCzBNfg6QBaeX8OSZZsBKwXXLsOZHreG0EuSwIKzvG6tu/svwNPaEkwaglxKzF9CL8wZ3QOh2jN9zkiEBMaunjAtFqjR/lAazJdtwoINae80vDMo8Kv8SC71t1dcGIrtnjiRj4HJRM8MBzVfzcuCFJX28WyouhZ8RT6QTrUNbkF5dEck2+y3WfnWfV02Es2uGZEa+ootsNfjkSjnTdPVNLO8X6ZGC5mp23ndKp4S6oVIjGcCNaTBus2+0T0vPNFZqH658E5JofUEPwGaWZcEo60KP635mLifQl1faAoeugnvLGfhFN3B5SoZs8O2dN9KCu9ojwuyPS6OGeYY2WUf4sp0q9Dz18YXiPylyCYgOt9NiRuWdqNZpvf3Fsk+AzAQToTikoPZtzzftp11jX11aniYFPbwhT4bJ9Q8WgqTX8f6K9bALTuhVGrcyWqDux4P/XvxebEqDQaIrN1Omj49wnALcqd/eQnp7zH9qSGnCyzGc2TguRE4S/eMzXRw7cI8aJiHVTCyxll9ot9qY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d045d37d-a75c-400b-e8a5-08de252d560a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 16:29:38.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gacw8iAVav1jlTyMeUA+kG2T3eXLpNyUq/HpnwIOAhpt20AxJq6tKAKInv6Yt31Mi94xMb4g568QjxBhJP+F+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511160137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX16Zj5GFMToqG
 +oAawa0vN2dNWVh8gkq+eATOfQOeZaMblvENu+hVskSDBismF7LOHFf0hxyu4aWH6dTWQhSxV9h
 1b+nZHuNcPsXpsGBO8x9UI/yQenvChAVe1Hoh0eSQpYuzrVAG4l7ZlGwrDCaxHZzYVQUO2OyVta
 myIQ19+o+/u66Y/A04Lw6c+YYHupnE9paGdTVM9MgMCLyDimHfgMOp1er2AHbWysyISfSeuFKve
 uz3bC1kSuqlY2dWgbrqsAmsTsYFvCRS1xO6GScc/Jxtqor+0m6qW2gNqsYYxbS6za/XwRThCzVn
 JOy2hgoiKHei0rrCLO0nWml+8sGFOffL4Rx1n1myCmFOJ4unagey6M+C+uCOHsWIZ5o4qKNwNOA
 IsHIF6KRPmdPen/Dpl6AGkh+hGO7Wg==
X-Proofpoint-GUID: y_ByRWrhtBA20rbLkxx9L6BcAMgg5DVG
X-Proofpoint-ORIG-GUID: y_ByRWrhtBA20rbLkxx9L6BcAMgg5DVG
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=6919fbf7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ID6ng7r3AAAA:8 a=_-F3z6XJesxesWQ1zhgA:9 a=QEXdDO2ut3YA:10
 a=AkheI1RvQwOzcTXhi5f4:22 a=cPQSjfK2_nFv0Q5t_7PE:22

On 11/15/25 7:38 PM, Tyler W. Ross wrote:
> On Friday, November 14th, 2025 at 7:19 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>> Then I would say further hunting for the broken commit is going to be
>> fruitless. Adding the WARNs in net/sunrpc/xdr.c is a good next step so
>> we see which XDR data item (assuming it's the same one every time) is
>> failing to decode.
> 
> I added WARNs after each trace_rpc_xdr_overflow() call, and then a couple
> pr_info() inside xdr_copy_to_scratch() as a follow-up.
> 
> If I'm understanding correctly, it's failing in the xdr_copy_to_scratch()
> call inside xdr_inline_decode(), because the xdr_stream struct has an
> unset/NULL scratch kvec. I don't understand the context enough to
> speculate on why, though.
> 
> [   26.844102] Entered xdr_copy_to_scratch()
> [   26.844105] xdr->scratch.iov_base: 0000000000000000
> [   26.844107] xdr->scratch.iov_len: 0
> [   26.844127] ------------[ cut here ]------------
> [   26.844128] WARNING: CPU: 1 PID: 886 at net/sunrpc/xdr.c:1490 xdr_inline_decode.cold+0x65/0x141 [sunrpc]
> [   26.844153] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd grace netfs binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd ccp kvm cfg80211 hid_generic usbhid hid irqbypass rfkill ghash_clmulni_intel aesni_intel pcspkr 8021q garp stp virtio_balloon llc mrp button evdev joydev sg auth_rpcgss sunrpc configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_cryptoapi sr_mod cdrom bochs uhci_hcd drm_client_lib drm_shmem_helper ehci_pci ata_generic sd_mod drm_kms_helper ehci_hcd ata_piix libata drm virtio_net usbcore virtio_scsi floppy psmouse net_failover failover scsi_mod serio_raw i2c_piix4 usb_common scsi_common i2c_smbus
> [   26.844217] CPU: 1 UID: 591200003 PID: 886 Comm: ls Not tainted 6.17.8-debbug1120598hack3 #9 PREEMPT(lazy)  
> [   26.844220] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   26.844222] RIP: 0010:xdr_inline_decode.cold+0x65/0x141 [sunrpc]
> [   26.844238] Code: 24 48 c7 c7 e7 eb 8c c0 48 8b 71 28 e8 5a 36 fc d7 48 8b 0c 24 4c 8b 44 24 10 48 8b 54 24 08 4c 39 41 28 73 0c 0f 1f 44 00 00 <0f> 0b e9 b7 fe fe ff 48 89 d8 48 89 cf 4c 89 44 24 08 48 29 d0 48
> [   26.844240] RSP: 0018:ffffd09e82ce3758 EFLAGS: 00010293
> [   26.844242] RAX: 0000000000000017 RBX: ffff8f1e0adcffe8 RCX: ffffd09e82ce3838
> [   26.844244] RDX: ffff8f1e0adcffe4 RSI: 0000000000000001 RDI: ffff8f1f37c5ce40
> [   26.844245] RBP: ffffd09e82ce37b4 R08: 0000000000000008 R09: ffffd09e82ce3600
> [   26.844246] R10: ffffffff9acdb348 R11: 00000000ffffefff R12: 000000000000001a
> [   26.844247] R13: ffff8f1e01151200 R14: 0000000000000000 R15: 0000000000440000
> [   26.844250] FS:  00007fa5d13db240(0000) GS:ffff8f1f9c44a000(0000) knlGS:0000000000000000
> [   26.844252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.844253] CR2: 00007fa5d13b9000 CR3: 000000010ab82000 CR4: 0000000000750ef0
> [   26.844255] PKRU: 55555554
> [   26.844257] Call Trace:
> [   26.844259]  <TASK>
> [   26.844263]  __decode_op_hdr+0x20/0x120 [nfsv4]
> [   26.844288]  nfs4_xdr_dec_readdir+0xbb/0x120 [nfsv4]
> [   26.844305]  gss_unwrap_resp+0x9e/0x150 [auth_rpcgss]
> [   26.844311]  call_decode+0x211/0x230 [sunrpc]
> [   26.844332]  ? __pfx_call_decode+0x10/0x10 [sunrpc]
> [   26.844348]  __rpc_execute+0xb6/0x480 [sunrpc]
> [   26.844369]  ? rpc_new_task+0x17a/0x200 [sunrpc]
> [   26.844386]  rpc_execute+0x133/0x160 [sunrpc]
> [   26.844401]  rpc_run_task+0x103/0x160 [sunrpc]
> [   26.844419]  nfs4_call_sync_sequence+0x74/0xb0 [nfsv4]
> [   26.844440]  _nfs4_proc_readdir+0x28d/0x310 [nfsv4]
> [   26.844459]  nfs4_proc_readdir+0x60/0xf0 [nfsv4]
> [   26.844475]  nfs_readdir_xdr_to_array+0x1fb/0x410 [nfs]
> [   26.844494]  nfs_readdir+0x2ed/0xf00 [nfs]
> [   26.844506]  iterate_dir+0xaa/0x270

Hi Trond, Anna -

NFSv4 READDIR is hitting an XDR overflow because the XDR stream's
scratch buffer is missing, and one of the READDIR response's fields
crosses a page boundary in the receive buffer.

Shouldn't the client's readdir XDR decoder have a scratch buffer?


> [   26.844517]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844521]  __x64_sys_getdents64+0x7b/0x110
> [   26.844523]  ? __pfx_filldir64+0x10/0x10
> [   26.844526]  do_syscall_64+0x82/0x320
> [   26.844530]  ? mod_memcg_lruvec_state+0xe7/0x2e0
> [   26.844533]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844535]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844537]  ? __lruvec_stat_mod_folio+0x85/0xd0
> [   26.844539]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844541]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844550]  ? set_ptes.isra.0+0x36/0x80
> [   26.844555]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844557]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844560]  ? do_anonymous_page+0x101/0x970
> [   26.844563]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844565]  ? ___pte_offset_map+0x1b/0x160
> [   26.844570]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844572]  ? __handle_mm_fault+0xac6/0xef0
> [   26.844577]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844578]  ? count_memcg_events+0xd6/0x220
> [   26.844581]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844583]  ? handle_mm_fault+0x1d6/0x2d0
> [   26.844585]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844587]  ? do_user_addr_fault+0x21a/0x690
> [   26.844591]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844593]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   26.844595]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   26.844597] RIP: 0033:0x7fa5d15678a3
> [   26.844606] Code: 8b 05 59 a5 10 00 64 c7 00 16 00 00 00 31 c0 eb 9e e8 11 03 04 00 90 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 21 a5 10 00 f7 d8
> [   26.844607] RSP: 002b:00007fffa272d848 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
> [   26.844609] RAX: ffffffffffffffda RBX: 00007fa5d13b9010 RCX: 00007fa5d15678a3
> [   26.844610] RDX: 0000000000020000 RSI: 00007fa5d13b9040 RDI: 0000000000000003
> [   26.844611] RBP: 00007fa5d13b9040 R08: 00007fa5d1707400 R09: 0000000000000000
> [   26.844613] R10: 0000000000000022 R11: 0000000000000293 R12: 00007fa5d13b9014
> [   26.844614] R13: fffffffffffffea0 R14: 0000000000000000 R15: 0000564585c1c200
> [   26.844617]  </TASK>
> [   26.844618] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> TWR


-- 
Chuck Lever

