Return-Path: <linux-nfs+bounces-12609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13DAE29CD
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73833188CD7D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE862AE8D;
	Sat, 21 Jun 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b0lepZ7L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N/Dj08SZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC037101EE
	for <linux-nfs@vger.kernel.org>; Sat, 21 Jun 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519317; cv=fail; b=HG4zA6kmTj0ET6fDzJLVllB4+bJv+iv/x17a2NFAHGv6hl/LwMCNQTTZHZWkuh92gyd6jWmTL5DUHBRjB6YJznftRx2JT6Sj82/YiouBtdDOOZuj4TbZPknUbcADM6w/uuZGsmYxdt+lm1NCVtNZa/0bD/zEbYt/l5fHQ8ER3+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519317; c=relaxed/simple;
	bh=nIdj9gUjXvI2vdPNsyb9uohGrc1v94lZIy10BFwLNzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EMmYE8LiT4MChFNhyWrrJ3zyTQrj4noFd+ZJN6wc+ej6i22qyyomwU8Si1mkx4Eadjy8nH1DFrLVEBpqF6zNT/XZjE8HneKph0a3eO7AoY1W78X40MbfcoLFncX6ToMMdtreappjK8EDpyj2f8Kr7a7T66wUA6Qp/sLwjG6VWSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b0lepZ7L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N/Dj08SZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LAMvbE015399;
	Sat, 21 Jun 2025 15:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GiP283uOUoHEflH65eNK1jQ7Jmr/FHGR1mKCBb9Wx8E=; b=
	b0lepZ7Ln4q4JgXpXxPbJAATgPOg++LC+ejOqsO3t0D6EDQG0IX7KDyF9wrnyG8U
	QMgHNhqK/Rsb0VV+k0ETXqfC4PENNco/ND/rtgkSss2sLUTks4M7OUgzDpc6Az22
	C5OTSoeD0tkKQNsjzJdal+VkLeJe616K7pjkfMNde7TNn6/5UQ4DwjLAlHLP+rUt
	CjmPz3pwaiWHBAYmtJYLxs+EoBNmwc6nbQ/TaWgo2QbpH3ltFQzADYIauExHCLHE
	JgtuoaY94JBh8EpzdxXabb1pb/xAKoyyyX/ZiFc9ZMYqaddOJDupOpz2rePDfyJN
	nRyDgO5x3rL72aq8FkV4Fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87r85u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 15:21:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55LDWVa3028293;
	Sat, 21 Jun 2025 15:21:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47dk67tufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 15:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+R9RybAreT2XCKsCVC3GnFcQxrj1LIXBLmqAj6kefrio9s3H4zR58hTiA0zyq5B62V6Tf2w+ZSPV7EJRVJ7F6paTPXCBE7wK/pOgyAu9CGVtJxTMvNa0WPJb5Xd1wcQRg9eyuusF8bGCH4Pg4K9nhR/p9r1ZXAF4n9mbUMshsESMumji0X3uuYlzn0RbcMxqb9V6Q2/98xaIaauJrk5wVJDi0AD4MaIT5nXBYR4htEwfZ7X0xn+q1OQqMJ6ov9jzzvn/VVyCZHC01L0bWRDSrXs4ON7sLuknLMAZXM5wBv1Zer9keR3aFbXDd51iiQ0fu9Z9rA0vueGwo9vSHC/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiP283uOUoHEflH65eNK1jQ7Jmr/FHGR1mKCBb9Wx8E=;
 b=DNlld4KuEnLedwVkdsrLs4QqBu6jRQkdhtLZFnFrMPRg0JR1wNRHVIN/dJQCbv3V5tc/7DHMwYeivImCKUhRuApTgyzT1EsO6J8SpFzS7474LrRe/Ab5muc/FQwjNDC4FWN3tqYvuNTJp1N9aODulgRh1UlN18L3rtF2FqXwzXW24ehLOtz6rp0AqMj74II9d/KxvUQd8Z/sao2U2aT3extlKMQbEVUZt6ghWqhm0syrqrtv45jkCgJ6Hq2dRMqfm7WRdGPoWEebyOD0CZ2dtCBYMkTkc+87arj3aLJYNF3NXY2lgvC/+gbVgxrvbUKvsfBzH5CCO8zcmgIjpCek0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiP283uOUoHEflH65eNK1jQ7Jmr/FHGR1mKCBb9Wx8E=;
 b=N/Dj08SZcVhxgmhnpmkGOfj0e/knE99OaQs4Mf/m8CqS2uKEWo7avp8u2gOv9quJv5ABcV6SvBinM5OC9H0/+wGWgOFikB6z3kurK3HnAEOaDPDRA6S6gzi8hqhDiNSr0O3bQI21IK2jXB/P3E8UG0yHs9AQgPAXBV9F7WLI7wg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Sat, 21 Jun 2025 15:21:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8857.026; Sat, 21 Jun 2025
 15:21:24 +0000
Message-ID: <b8f44a6a-6e35-4d59-bfbc-fac0454f7c22@oracle.com>
Date: Sat, 21 Jun 2025 11:21:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 RFC] improve some nfsd_mutex locking
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Li Lingfeng <lilingfeng3@huawei.com>
References: <20250620233802.1453016-1-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250620233802.1453016-1-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 23345db5-e2ea-4fe1-48f5-08ddb0d74902
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?STc0aGVTblFxU3pOMks2UjdZNXB1cHlPK2JJMkk2MTV1Nk5LNWo1cGV4VDQ3?=
 =?utf-8?B?NzNHdFpLcDROUi9wRjY5RExJek9EcHhlM1JpU01GNzU2ZUpVNHo3d3Q2Ympt?=
 =?utf-8?B?cUM2RW9Db3VoTjZUcUlhNHA5b211bThQMU9NVnpFZGlxMzBoZlhaTFpwZTFW?=
 =?utf-8?B?ZmNyOGVGWlVQN09PZDhzWHlGUWJnUmFQcWRacklkLzkzcHhLWkVHdGd4ZTNW?=
 =?utf-8?B?Z2dlZ3B6cmJiZW9saWpvSjE2M1dBdW1sZy96L0F1dnd6bXhwZHRaTHI2WVBr?=
 =?utf-8?B?MlU1dkdUWTE0VmN3OEF5dkRLVmV2dDhyd1JVNUw4QitEQ3ZkSy9VTWdvNTMr?=
 =?utf-8?B?NHJudWZXSTdueFEySDd5U2pObXZxbmQ4VC93WTBYMFZJVkdSL3hVSmZyK24r?=
 =?utf-8?B?NWF1RDdYV2htUHJ3bDNUK0hNblJvbWNqTG83eFRLTGdmSWd2bW5vM3RtNks2?=
 =?utf-8?B?aitzSWhGY2VxamhWWWJUQlhBeU11bG9qdnF5dDNuamE3TS91aHZLd29qUHhZ?=
 =?utf-8?B?dGsxQWxDbWJEVDFuTmxxUEVXbFZUbndNMFdSdUxJSWJXaWl3UW1EeEY2bUFU?=
 =?utf-8?B?blZXUlExUVdETm9iVG5JNVZtZVNic3hieDF2dGk2NjN5WVNxbXRHQ3lDbzU1?=
 =?utf-8?B?aEg5TGhpOUNqTjRrdHdrdEE0TGg1ZXljMmFFVzFXZmtyZnNkSGoyTjQ0akg4?=
 =?utf-8?B?dXFpeW9YNGZaNlpWaFZwZ2tramdsWnJlczZEZk40REVWYW9sZmRQZFNSWEJJ?=
 =?utf-8?B?WWxqVmtpZ29tQjE5N0NvalFvYlVhbEg4bWJwQmpIbHJZMDUxaTJ4QlRwUHdq?=
 =?utf-8?B?TjJUbGtucTM4dWtEZk96dEpKaU5sZkU0N1hrVXNsSWh4VmV3MmVWY1RnZith?=
 =?utf-8?B?Z3RHZGllMUl1ajRyNFVQYVJOQll4cnVqUkZrZDVNNDJ5YWV5OVNlckFtTlgx?=
 =?utf-8?B?dWJ6WnJoSjBhRUZxQlo0N2JjMjRodUJrd3BKZDI1KzAxM2c0SGlYTm1xNmxF?=
 =?utf-8?B?WCttc0p5VXNwemt0MEQ1L1ZzSFdNa0lnU3RVYWIyUStZd2gxcm9tN3JuV0dT?=
 =?utf-8?B?VE56NXZsVE5CdnE3NkIveTlTd3NoMnBwVmhMOG1sMHpCT2pxSHZyaVNZSzBm?=
 =?utf-8?B?eVltMi92eGE3M2ZFYm1KMWFUQzdOSmFnMjZkRDllM2YrazZMS2ZJNGFNa1FS?=
 =?utf-8?B?WVB4MU1yUm1wSTJ4cCs5L2pUcU56SmIrL1NKanJISVJjalFWeHdYeTJuRExN?=
 =?utf-8?B?a04xSXJXS3J3OFpMRmlTc2ZXcG8xRFdmZjRqQXJWQkFSNTEyNndRTHp3a1lX?=
 =?utf-8?B?TlBTR3ZoMktRZWNJUExxYXloeDR1V0ZQQWNZVkN0bHNWZ214MTA1QjA3QVI4?=
 =?utf-8?B?Q0NVNnFqTTJuaUNuRmkwQktYWndNUmJyQnhhK09Pa1BlSlVUcDZkUDAwd3hk?=
 =?utf-8?B?N2xETzQxVmxUdjFlZjBLRzZITkZYWk1nOWlDQWlzV0pja0cyRyttNjhjSDMx?=
 =?utf-8?B?MVR1ZkJncTFGaFJsL01xTDRicUpIYzUzYlY1aE1Xdm41TjYzL0duMjNrUnk5?=
 =?utf-8?B?Sm5iWTIzays0UWRuYlh4MGlob3RpY1plY3pKWitUbElXVTdzYXBaYTBjU1BG?=
 =?utf-8?B?TmZnUmVseGNOY2NnQkFKNkhQTDRHVFQwN2Zjay9zUUJNSVhxRTZmR3RTVVZu?=
 =?utf-8?B?eElBTW1EbUc4VHJJdnNNdG5JbUlmMnZ6K25Wc0dwWWlxUWN0L3lrTkN1RXdm?=
 =?utf-8?B?WVpSTUE2TFZnSVZQT1Mzcjk1WkROT0VDUkVyL1JZZ3F6cGdGNzJwNXA4U3BR?=
 =?utf-8?B?ZFNGaUxqT1NQekVCUkZnaWtFek4zM1dvVWV6MEQzUGIwczBmZU80UXBMd1V3?=
 =?utf-8?B?V0FOUCt0YS95TnVMbk5jbHJrd0hUZVZvOE81bFpwQU5lV0ZjeU1kUytOTEdo?=
 =?utf-8?Q?C5ZGdKJfl4Y=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OTQ1b1FoVFZETXBybUN6M1dkN0lSMUZ5eE5DOE5UZmVHTW94Y1JwZi9PZzkv?=
 =?utf-8?B?ZWY2TGdLM01GOHhUNnh3djlMV0huNkNwMkZPVUZGNkQzMEp1WG4yL2RoRGFV?=
 =?utf-8?B?WGd3V2dpbWROQ0lsMkVuVWdKMkhMbEVLcHRsL2J2aTZQb2l4Ykxlc1dWaElX?=
 =?utf-8?B?dGZVcFYxdDV3V25qZnNPbjNEWjg0MjdIVEhVc3FDbm03OFNDZ21hOVpZaTh3?=
 =?utf-8?B?UWE0bkZweSsyMlZuQ3BzVDR4NUVEdGtuc0JzSkNHVVBPQTZGY1ZYbFVlSVlV?=
 =?utf-8?B?MmpvK2ppTlhYekVkS1dFQ0w0TElwK3BIUHJPZTFaOUVUc0VpZituVTBtWmti?=
 =?utf-8?B?Z0ZaZnVna3k2djhEaFpDR0FJM054cjRkNHNFV1BTY1RMNDcreEFXdDhUODdi?=
 =?utf-8?B?M2NmWE5xVjNTbi91NjFwbnJCdnRWSks4YXF5R2Q3dDFEaUhNR3Y1aFJvYk9o?=
 =?utf-8?B?MHNFVEEvVFllMjh5NmtTbUo3VnZ3QzU0OXJCWHhqejlNRFRyUnBNMlVoLzRk?=
 =?utf-8?B?ajdXN0cwc3pRZEhWdUJGZ21aZVU2L2kzOHVxS2crb2VQcytCaU5sTU9zVzBn?=
 =?utf-8?B?aHVZRGNVYVIvRTRwdkRrVXFMUVhvZUwrejRzOTlESzJ0d1JKNURYaktKWjc4?=
 =?utf-8?B?djJtbXdiMGdMRCs3M0hhNFE1K0h1dkZRem9GaG82cm1kOE5vWFkyT3p4K2Nq?=
 =?utf-8?B?TXlHT1dTU3dBcWFiQkZlT0JrTE5nSTBzRHVhUFZ5Y3FzYnJtaG53SEZZYnRZ?=
 =?utf-8?B?MFY5V3dUYnpDMGVWWm9DdUQydnZHdElkUXhFQW54TTNMeHFmZE14TVAvQkFX?=
 =?utf-8?B?ZFc3MTlCUUVud09FK0FpZ2duM0I2b0t0RGp2TC9vVE1TUXovbVo5aUNIbTlh?=
 =?utf-8?B?TXpZQU1FSHp4ZmxMMnlTbSt2ODAvRVhDcGFBZlhjbXorMzB4OHNmSXhqbHFS?=
 =?utf-8?B?NnR2ZEt3L0Z2RFEyMmg2MDZ4eGtpd0Y0WEtLaUFDSmxaSmlJaDV2cDFYU1lX?=
 =?utf-8?B?Wm4rV2ZLcUJYWXFFOUZPWlpuN210OCtIL3dmRG1NMmZVS3R1K1Y5bnFQOWNu?=
 =?utf-8?B?UHc3c0d0aDFyK0lUQnluUXpWRDQ5VHUrTkM4aFJCY2lSNVZIVE93VnBJc3RL?=
 =?utf-8?B?VGlxMDZCajIyMGpYMzcxZm5uYmdvYlJjTVQyRmV2NllxVlNXUmVDWk5FUXgy?=
 =?utf-8?B?cHcyNlFBSzVuSHQ4NWw5TWU2Sno4aktjazlJd1VIdmFWaXA3eGI5Rit6Tit4?=
 =?utf-8?B?d3BEVi9nejFKNG9saEUyd2dlcStNYVVKcWtuYzVHd1hyd1NSV293eFQ2S1JK?=
 =?utf-8?B?SW1IRW5vbk9JTjlJSTIwRmJoWWhNTkgrak1zTU1jWGcxMzcyMDBJbU10S1pr?=
 =?utf-8?B?N2Vkc0ppck1SV0VzckNWQThGaG5jeWlkN1hGMUhWK1FRZVZscGhRaE9TNFp2?=
 =?utf-8?B?bDUrSjRLbVRWTE9aQlUydlE3amN5TERWNkNyeDFCQWM1cmlIVFJ3RmxhWG9G?=
 =?utf-8?B?U1I5Qm0rZDNpN2s5MzBPK1hjb1BZRVh3VmQ1anUzZGl3aDZuM0kxLzIxQVpK?=
 =?utf-8?B?R1VZL01XTGRpMDMvejBhOGFzUmdMOGppTHZIL2E0YTQ5WmsrdFRwMVRsaEd3?=
 =?utf-8?B?VVVMR3Z5SFZuSkJES09jS3Nic2l1TTFlR0Z1RGFhWXJoWi8yWktKMlJkVUVI?=
 =?utf-8?B?MUdiV0ZNM3JpM01jcWNaakljeG4zQVBNMWJQZUg4L0pzVzdIUUVOdVVwd0g5?=
 =?utf-8?B?Wnk5czFaaHRZRDNOUURHZTkwQVhZcnE5b1FIK0J2ZXl0TzBySXpJNGlURkxY?=
 =?utf-8?B?TWR2Y29CVW8xYTdVNHIydmpPOFFuUkNuT1RHTEhTbFhNakZ3WTN5QjJ6N2Jz?=
 =?utf-8?B?blE0VHMvZ1RZQ0FsQ2xhVFhWdDg0WkoycDB4L1AvSDRkOUhlVkxtandQZUp4?=
 =?utf-8?B?OEJQODByMkw3Z1JYUThJK2VKRlFxSisvaEJhK3hGNVlFV2dBZzlhVUxJc1Vo?=
 =?utf-8?B?SEkxWlYrM2NNWTVUalFTRzJJdVFReFhUWmNyS0JzU2IzamlkREU4QWNnQkFF?=
 =?utf-8?B?ek05akx1cEM1Ulg3OW5PYy9CSWxKVHV3bklmTFk1OVB0S0FudldBcGJ2clZs?=
 =?utf-8?Q?laraYs/dX9Sbv0MsbiNc1rvYQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O/9kJXdrj+jCmaJc06iyoDmxumQq39CkWgFckaqxnF2KySMOyocCuTh/0kwsNwqVG2OAqPUMw5PkJeFX7RHgPdA+D/TN4SGkq3zY4pI1PC6UJNKRITo0fIOH3oYVXoC6qSBDOFsAIEOQwe6wYylrehFZJEor6CwjiDt8I6sEAZNcHOg6ng67i+o+QLxugJlWbUqlx2/MvG13/hZkcZjrSRwCZs9QSv3esTUgEpI1I6Js8e3TCxBsuNMzr+vyk9DTy/LLHNHkhcbfpd3bohQmjBnywPn75c6LXFUe/mNXt0eSVnIxVEnrJg1yr/rMDfAFeUavYYqo6i59SSM/1RZ3iaam2PkCPsV7yR9Aeh7cIwCCs0V/KtXDjRhuu0msXp0CQ/Jc1zGeiEeiWBkIj5zaz4VX14fH1FjheXXbnUJGVH30oOPabEb/N4FG1EXaxM/WR1L2J070HOoy0+O+5FCFLDO3Pdc+A7aKOvHP7IniP8I8IQhZd1Nm8Zjoaudg1lXeGRcjyPre2lgKRqbZVk7DTnvUQ2jFF7625nO5NNb4XhiyuNozouHlSeRxuPQBUqXc/HDGE0PDlTN4cRAiHALKdzEte99qLqlFj/zziU3d6Yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23345db5-e2ea-4fe1-48f5-08ddb0d74902
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 15:21:24.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPN3g/z0bvEqOR40Arg1H+Op/vJAhGJiwmpCx5/HYPDbWItImItpRpHa6/ogYx5Gqp2whpz5/bPrn3gcjcWXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_04,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=766
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506210095
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=6856cdfa b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=0ixgAFyxWW4_7fDR_pYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA5NSBTYWx0ZWRfXzsjaGroqmpim VLOJD6sEfgNnNh5NZXSjWmLJrrZGcJuMrsnClO9GGLeC6uu+cGNLypV4zFdCORCGVHSYK73TSfM Haelo7m5aniytzjj5e+JX+qxbDXIyjRRUrvsDaceIbZw0w6mXcc1ut6M7dEraWOrUwY7dYn2IRm
 w7VhHr//ZBxdhQ6fFlqCMgLoVAwM2We8iSNF64yzhghPNsIv2NoS88SxoXspKzzilcYkymUd2wr csRf7rZj4IMVorxJxZurWsYuPFQGKQGCJ4xV1IAUNy63Vb6dzFa/3T4pda6HUpKUdqWBaBAxRcl oKrqf+rtp70GSP6c2Le1Tms8kuBY5RgXFyuRu1+mim52j+U1ZoDgPDSzRvhQ7W9W6HqtvpgZgSb
 CBAkRmf3AiwGqM0kDddgVFrn9dkg7ivHA04SAl8+yEMVEg/cXiOp2dxkhqHCt6JjyY3UlbqA
X-Proofpoint-GUID: KosWYiTKCPZ9Gw7Qf1hcNrWYCCS5NZhk
X-Proofpoint-ORIG-GUID: KosWYiTKCPZ9Gw7Qf1hcNrWYCCS5NZhk

On 6/20/25 7:33 PM, NeilBrown wrote:
> The first patch hopefully fixes a bug with locking as reported by Li
> Lingfeng: some write_foo functions aren't locked properly.
> 
> The other two improve the locking code, particulary so that we don't
> need a global mutex to change per-netns data.
> 
> I've revised the locking to use guard(mutex) for (almost) all places
> that the per-netfs mutex is used.  I think this is an improvement but
> would like to know what others think.
> 
> I haven't changed _get/_put to _pin/_unpin as Chuck wondered about.  I'm
> not against that (though get/put are widely understood) but nor am I
> particularly for it yet.  Again, opinions are welcome.

I think of get and put as operations you do on an object. Saying

  nfsd_startup_get();

seems a little strange to me. As I said before, it seems like you
are protecting a critical section, not a particular object.


-- 
Chuck Lever

