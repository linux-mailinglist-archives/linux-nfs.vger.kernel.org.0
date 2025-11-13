Return-Path: <linux-nfs+bounces-16354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1DC596CF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 19:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80EE14E8692
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA43299AB5;
	Thu, 13 Nov 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvcSFAnL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rbuqdr1z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6B2F691D;
	Thu, 13 Nov 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055702; cv=fail; b=Zljz3DQju31yOR7VioGkNMfzEDKVkMGp5TeZcHriFHF+yu3TMmffUJnKdsk6w/qegpvtsvFqyLXe0C71kawMWaisc/UWvehDDRQDXIhb9ki4s5mHCh4T0Dn2X1jDbmBLY3urDqe5vHqRnHVs8te7Sh17/4tBqz/Gxg9YWuUv6V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055702; c=relaxed/simple;
	bh=DuR7ofJLEYn407EzMmzpQfhpSNrE5PNz+LSGkWpAJuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qF+Xi12fYBMwl2pfWeCUXaMH6bFK+SkyHYL0qSc8c/ynei2j8yPOn5X/D7SCjV0+LL3GN+iEABystA/cJhV7gUvfP+dF6I1GLE8iQ6FXFB1wt5ozHdCqrO+GusWahpLdhLVOpLliWA30EfYe37tM3MrVob9jX/tSvs4nmGFeQa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JvcSFAnL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rbuqdr1z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA2TH028782;
	Thu, 13 Nov 2025 17:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jnZMfJZAZwUcRMheCv6jVAYUpG4Y4GYsRh7386IgwwQ=; b=
	JvcSFAnLqBoTi6mTh+zXY7WQbj+FFPbAQRsUiRV7vEDcx7QolaZAo1AAjkTFtwsy
	qGg4oiFSsVHiDu+/22zucI9JHnTJ5tvLitaxxIf0CZFyPs0dsKeyw/Lj5Rp2D+II
	7c1z3H6D3LsIQu16iY7Tf1d/ppEy/7dW945tGSXRK6N5yOIgps48adMyyL7qskPF
	8YHwHCPqhlt3Cu7kNaUs/p7eEhKu1iPpl8bZlcGVSfkBUUHF6NKmhwKrEHLwrtov
	aAJAmMkDeVNR0pgQZsgJRmrNQM7XMbNP8OKyt6fwzMmvkDGhnrLxw/HMXx1IMPWh
	F9DfG9OghgjrJEWx0HbP0A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnjekh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 17:41:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADHLAk8000438;
	Thu, 13 Nov 2025 17:41:34 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vag0db4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 17:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOUwF1xPJU9uRdol9kK3njgKDlKK1h9jOc0x1o3fy6Q9ztiuxIMWN5nRQkePKqXCeLiFgSXfYwVDR21RLQkAZJDmtQ37zgeM6xdgY1L2a4+LTMnpZdI1+shCkBqrodUdq5QSpq1fpmA8AnQHa7mub+dPQBQM12ZZ0lQPX7cW/MYzBv5kgvL80z7NIyYt5FpIDxIC8fHpXiqEDPeTvMQwJ8GHlKSHuvkep1UK/SiWqITrDtJ181HO0m+1mBNBpLMJgxwsTjLgFDHd2mBg6LucYGo4KLSA5kOqHjcMRPs5wU8YlwhikywUfOxwmYOoW1KTdqALmxHndsDyjIO27aw4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnZMfJZAZwUcRMheCv6jVAYUpG4Y4GYsRh7386IgwwQ=;
 b=YW0+8cZ88V3RsjsO5eCG4rIxfm+INNs4ZjDEwYFAgm9vcYn/AP9maIZSKkvVQMRB+JQg14EW5+3FWcXrddVD3A4h4NnURmlEyfXGc2i1mluWUpqp/BuNAfjg01brmWdyh0STm5GV/to9dbW2L+PHEhL4aV0DC8HCLAVA/g97qCNUsqAzyzXJnET6YS2slItO1P5A7HugUmKTOqE8cH33O5dXCCSpehVBInUOwGB5wr40Q58o/AzhO2O/blOaKdTKqBFT2fIM5bdt/SIqHUzps0hbst0UXuej11NMpryOhobdOqMxHNM+inpYNNJIyn6LtnxTtK7yWK1c2RDDoBTXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnZMfJZAZwUcRMheCv6jVAYUpG4Y4GYsRh7386IgwwQ=;
 b=Rbuqdr1zX1QqvsHgbyJsADuSpBVmmNKDmw9NC9UDJfYpbN6D68ZwpqV8rlEgNQRL6GVMNRA8tj4jdyv++jvwFqEiBvuX1+C3sPAhEPtHZvl4fzPRrTnU9q8pR1+B8407po20pdbmhSd/9cJbRG3HeflzMrfEPsRABX8gM1i5WSU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7939.namprd10.prod.outlook.com (2603:10b6:408:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 17:41:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 17:41:23 +0000
Message-ID: <fc58b0f2-d00b-4e4e-a353-ffe43bec6c6e@oracle.com>
Date: Thu, 13 Nov 2025 12:41:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        neilb@brown.name, Jeff Layton <jlayton@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
 <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com>
 <CAJiE4O=zhEaJKQO7bBc8g9gXCiMoi7G7qSiVbQ5Cq+SwBK8OVw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAJiE4O=zhEaJKQO7bBc8g9gXCiMoi7G7qSiVbQ5Cq+SwBK8OVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:610:59::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 68642d1b-e7c3-41ab-816f-08de22dbdce7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TDJqOUZveFVTZ2JYZHpGUC9wVUovcmNNMVphTlBsSDVIS25jeDV4cUNPeERx?=
 =?utf-8?B?dENoOU9hN2ZhS0ZmK2pVVkZzVG0zR3lkWmcwL1lFRnl1Yi9CV3UzcWJGT2lP?=
 =?utf-8?B?TlhEMTVuS05La1pPcDQvalZVU0Nld1E1L3loTUxEOWx4c2s2ZlV2eVNjN2pK?=
 =?utf-8?B?dFFpTTlaNmRuL2ZBRm5jNHlyeVZLOUNkWHJXZVVtL2R0ZDZSemZ1VWQxb2Jo?=
 =?utf-8?B?QS9CODFFUUZZd2dDME43TFg0UHNUVitCd1E0elR0RjBpT2lmRlRVNjBORzBx?=
 =?utf-8?B?ZUdGZHdaOXJ1eC8rYkd5d2JlMGp6bFNhVXoyY3Jhd2JjOHN2K1BGUUdqNDUw?=
 =?utf-8?B?dWJYRWU0dVhHSTRwSjhFZnJ3NTArR3drbDBPY1YxT0hWOWsrZ1FqZ2JjekRq?=
 =?utf-8?B?T0NGRHUzODkrZzg0SU9yNXRGdU84eDczYXRqUTZILzgvWFlJY0N6VEJzcElP?=
 =?utf-8?B?SGtVQUFaYmx5WkJINUhNcDJsWlVQWEVaTkh3d0dhVHJRTDhxUk01L0lZR3hq?=
 =?utf-8?B?NkpFSXRieXQ2MmZCM1NzYnp2RGsvMFB2WlRaSk9RSElhYjlORE9XeHNhTGdw?=
 =?utf-8?B?SFRoK3Jicnd5Ry95cUdYTUtnSmhtcVNpSHpoTjZjbEpMRlBaUW1ibWxsa1Z6?=
 =?utf-8?B?VVhVaWNsTWI5R01DRmxEeGNPcC9Tb0FuUEsxL0ZNeGRLYnhHQmIxTDh5K1Yw?=
 =?utf-8?B?NXYwVExuUFZERlArYTA2aHIwMFpKWFNQTDdaaklscEwvVUtqTEl3bWY3VUl6?=
 =?utf-8?B?SWVGM2kxeXZrUG1nM1dDNldCdU9JRnFMTEZMTURyRU1kSUJWVXREaUduNnlm?=
 =?utf-8?B?bUlueGFGWk5XbmxZMHZjbXhVc3ROME9IRnRjVWVGYWlETlM2K2w0cG5XVisv?=
 =?utf-8?B?L1ZRcUIzbW11S0pNZ1pndjRrNlJEcmVucE5sRjdUREZkekM0V0F3S1VULzNv?=
 =?utf-8?B?VVBneTRUYjdiTmpYVzFheVNxUFpTVFRFeG50aGsyL2Q3QkhsenNnWFZMVXhT?=
 =?utf-8?B?YS9PbWUvMDNkbTNIMnJHNFpOU0EvL0l0MFRPMUMvcXVraTZWQzJURkxoNWJZ?=
 =?utf-8?B?akN2ZlIwRXFqZS83M2pEeHVrWGR0RHJVNDZTRlFDYU9xdkdRa0VEYmUvazh2?=
 =?utf-8?B?ejcwMCtRRmlVcjREMCtQb2xzYUVuc3ZMQXZUdCtNaTdjSWdHYURTbGZ3QkJm?=
 =?utf-8?B?NVErMzBVMU5pYVRLOGFnYzYwM0ZCY29ZR1JiWVRUTEVQaGg1R1J2empJbS9D?=
 =?utf-8?B?TWVkRThWNDJmSEdhbm14eUxsSC9DQWU1VUtOT2xVZlBwL3Z1M0JqRHZBNmdV?=
 =?utf-8?B?dkUvUzQ5Znh5L2dtUlRCdUdLbjNXMFVXQWN1ZlgyaVRDV2ozUHVtT3BpemVk?=
 =?utf-8?B?b1EzZUIwdUZYVlZ0N0RTNXJHekRSVmxTazlzditWVnFrYmJYTEVNZ1BvaURG?=
 =?utf-8?B?bXpJQTI2TUJ4cmQrcW02WVRwTU11UzIxQUNCNnZ4aGo4VjJJRDVtdUhhQWtQ?=
 =?utf-8?B?TGxsd3hqNU5DZEVoZEdLQ0dGZDRYTDBlMmMzSVVscEcrRDJqMmJCMDdZbG5F?=
 =?utf-8?B?d2lxZWdFSXA0QXpZbTNsSm5XUGJ5K2Ruc0RyaS9IaHFycHkzb09va2JoRDlu?=
 =?utf-8?B?dnZTRmJxWEo1cHRmbHdQOHNvaFBUUUdkRzZadXpZT1VBdXdGNkdLK05tWnJr?=
 =?utf-8?B?NGRiUzd5c3JTTXZwZGdmS0NXZ0RGMm1QYk5lRVdxNHJNV2lHWjBwQkFBLzNa?=
 =?utf-8?B?akcyVyt4M0VTNG5wejR5N2o2cDhhaEhvNWhnVkVISWg5NnlBQjlKcU5Ddkox?=
 =?utf-8?B?bjMzWmN5S2dRVUNwMlFvNTRDTmZ6cWZpSVVhVUhCRTlBWG54ZDVadmxLdCs5?=
 =?utf-8?B?WjEwTFkrSGFMdEJheTZPMzV4UnkvR21XN2poS3lVU2tVYzAwcGdFR2JOdGRp?=
 =?utf-8?Q?/Sbg89pmHwmOXSz/HNGmieDOSBMNRu0f?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WUZRNlhYNEM0UXV0RHJTNlVETU5nK0dFUGNyOHJETzZ6c1JBRzhZYXdkOGhC?=
 =?utf-8?B?dnVydXRKTlhvMjltUDhQaVZsY3RMeDFQOGtFVThkYUM1a21OQ1JXM0NqMk9H?=
 =?utf-8?B?dnlHd3RobDBXNzdDQ1U0T2FCaHVWUTVqSXRLcGpwZTlqODNPcEFLci9nY2p0?=
 =?utf-8?B?bTVmSFZpMFNBRlJLYUt2QmhKZTVmMko0MldXS1FpeGJlQTArcUVNTW5rOGRJ?=
 =?utf-8?B?M0ptUE5mdmdxYzhKeklhZ0ErTzlZRHRqMkNkK2g0WTZHYW4rYWl4STJNQ0dT?=
 =?utf-8?B?eld1NFJTSlZZUDBidTh4N1dKYytmcDdPQ2oxYnh2aUlrT0t5RFZyOU1veXNR?=
 =?utf-8?B?Z281RUVHRml5WlpUSUNMV3lWUS9yT3llN0hmcTBlbXV2R2N1MjhydmErcUJI?=
 =?utf-8?B?aW16SmdETGFLQjNWSE1mNnc4OUQwWDM2ZEtRNlpiOWhON05MRmd3djd2R2ZH?=
 =?utf-8?B?NjVrdEEwSjdhbEVZbWVUSGYwRFNyd2FZbkhBS3JKS2ltMzd0ZHRoRGxWSVhT?=
 =?utf-8?B?RVlPSXE4dk1yd0RwM1R0VEVYTVRCajVPSkdCa2xsOFRaK2FCbWNVUnMxY2ND?=
 =?utf-8?B?bXRTZnVBOXlIL0dKYW4yM2dVMC9jY0dLcEwyQ1FPM2s4NlNxYkhnYUtQTksy?=
 =?utf-8?B?NjR0QkNYS3c0bVBOWGJwRXhnT09JU2puc20yaG4zaDBtRkt6dmtrY3V2ampW?=
 =?utf-8?B?aklqbjh0OUVBbHdZVjBpZms4RjFZLy84ODVJb1JKZzVCQit5T0hXMkJXTGpB?=
 =?utf-8?B?UVVzSVBjRnNsWVZxRE1VYkV2WFJ4Y050Rmh0WEJZaWdQVnNkZG1Kb1RDdkxp?=
 =?utf-8?B?V3BnbDlKalQwbXdNSlA3c2NqMTV6bWFlM2wrZVI0WEFGV3dsYXp3cEFSdno2?=
 =?utf-8?B?WEpPSXp3ZVBYT2tvSU1aeE1mNEVobzB1dFNmQ3R1VFN0TnhkbHljTzQ1N3R1?=
 =?utf-8?B?dFVYOXBoZm4xMlFJTGQ1eUtVaDk3eTArQ3p2Y09xUmFLOHdzUVR3Y1E3TURa?=
 =?utf-8?B?Z1djWWFRUHlwTkcrZ3BIQlJQQVBYeXpTWFhVU2RFN3huMFBvSDRDUnA4cEpD?=
 =?utf-8?B?MllLM2FBVFhwamM2U05oYk8rQm51bzBKOWYrUU9LQ0JCaTc4S3JSSzJIeVpM?=
 =?utf-8?B?Z0hJaHdkZFk2cnpuRmQ4QzJtdzRDUzk2K1cwcHNjblVmaXN5a3ZpblRNY2Ny?=
 =?utf-8?B?d3F2UjJxeU9Kbjc1SnZmUTVicTJLTENXMU5jQTF2RTJaSGxFbG5lSDJhSVJk?=
 =?utf-8?B?TzdrU29CU0FIUEk3YW9NU3NrSC9NV1d0aTlaeU5mSFBJeXNIaXNMWGkzQlJx?=
 =?utf-8?B?UFVmMFczdjBDTzkzMFlNUWxBWUpnWmR1RDc5WHdTbDMvcWlrbWFKZldnZ29L?=
 =?utf-8?B?Q2ZUVjczeHlZcW1EczhuTXFVRnFvbWhHeEUwcnRPOTVHNDJ4NmgvVnpFcVNy?=
 =?utf-8?B?aVk1MGdWSDBsQVRWZWN6TG1iVEhNWVZGMnVDTWgwUDV1QVlCOVFMcWJ5NjY4?=
 =?utf-8?B?ZWovcUtFUWdkRTZ4VUJjUmhtN21iQytnNllTWjVxOFJzc3EvUDNKTUhFZ09I?=
 =?utf-8?B?L0hlNVpZdVg4SGVpYXI2cGFMWTdWSEZEejUzb0duNWtkYVlKdnp2SStwZFpt?=
 =?utf-8?B?eWRyVlF2WEdtQVhhSzlPWDR6bDdoSEJDTVZ4dlVRWW9Fa2EraGxyeENwdE5M?=
 =?utf-8?B?T0lPcmhsRERRY25zM3orUVpST0dyaHdUVVZQY0Q1YWZMUjRUTHNQMndkR3lQ?=
 =?utf-8?B?K0tqWlNFL0x0Y0k5ekprVG9zM0REaDRsQ3h0WmVIZ0daY1JqUlZ0WENmVzlK?=
 =?utf-8?B?NUJQL1RlNXAwT3ZKQnNqdWk4V0NIc0QyTmM1RHpDQ0RHbWNxL1pKSGFvc2Z1?=
 =?utf-8?B?aFRaL1dkdWRoQnlqc0w1bXRLR1d3Y0pPT3RROXRPK0xucWdKR3p1eTV5Ky94?=
 =?utf-8?B?aUJMYlVDMk9NMUc3Mk5HYlUxMzZEVGxMWHQ2UTJXazFUQjBGSGRreTVrS3Q1?=
 =?utf-8?B?azdmWWtOUkdUQjZQbmxTT0kxQy84bVRmREcwOGhId3dIZ3phMjMvb2dMZzd2?=
 =?utf-8?B?YnZVMGhzSEhYU1dSWGsyN0pyWHNZRUMwMjEwMmMvSE5jWnl4QVBMWDNKTnNv?=
 =?utf-8?B?OForTjMvUEc5bFdjQkZCdGRWOUVOb1hTMFE3K1c3UTZ4T05rTnJqTjU4bU1Y?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kkxTjnypDPxRkYw4Ea5ZpetU47XdRI/MZj3YiJfsd6Eiu74utWnPYp3KmKhZJro0mw2rJ2GRD0ahnQpVWCWklFv8PlxknQASr2+poRAKkZVHWFdgD4+6LrZ0S1XjFRly8ckPdBf3yTO8NsRt57j5oYNv3HSMQvACxWODXtzMqbUPpjBkmSWmAIGMkpwmI5GNeVz7GEJo6jby6gwjNpFKFHyFalw3d7cOr2tOq2FrW7B5u+Dmzpbcr7xPA6NqlSD75tCLrImKZvsvhg59+Itx2rrTJ/JzVCiqTzU1iu/nMXBwweYDOWwXOvIlWlJMbinNoGn77CXxBNeZeW4Td+2EHMW0IeUDl0IUj2fySvfp1jUJhA3Y89YUaFr/4K/BdTT4ENhQgshmG3AxbG+RtBjXRGN7Jd8jUOA/C00vdyGcmj2qt8ZGFyZQipSwWtUI8GpI/l93CuLzHL0LwDe3Kp86rIx51r7OwXxAsPYZp2Z208fEOzKO9EDZaKV0z8JRqCpJvXcIYY6eJhslVNO8C9OdFRoycZBG+IvmkevBX7TDTiLov0egOLqVmuksWrV4ErCURoFeWY5VIF3NUHAcfjDZ00PmqKLRGN9u1J+vYpIUaL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68642d1b-e7c3-41ab-816f-08de22dbdce7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:41:23.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7ju/qpwtgntxt5nzpHey2M7epl25dPXSQqZGDwuPQ2usCiSvAja7nEh0hWIbhW6XcJ05qykrqG1QrPJXMQPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130137
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=6916184f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=E8ne_XxX07vkcryyyjQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12098
X-Proofpoint-GUID: ln_98j-6SOPcgUH-6X-tCt2C44BUYUeZ
X-Proofpoint-ORIG-GUID: ln_98j-6SOPcgUH-6X-tCt2C44BUYUeZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX9i8T+ZRT4a8s
 tLMrkZIRfGBrQv/kXwT4u4gA+Ia5WDxlW/GYWOn5f1DK83/0wSUs6rFmP8lkahKFwWz02QQWLqY
 UjW6AgNxPca6yuzO5bHcAc4ckmnyPZ9Qttz+xhmNwsDr4sSSsHEsmBp7EK1p7OvieWDeKoSxMoU
 Z/AV/c2Fd9Tn6lzwdQVkTsyOea04s5C2X0HgKINvicXVUAUlfxKI+AbHb1qBFIJyOKDfemq7CyY
 Vn9Alzrd0uzzygAYTP7ASpvDuhZAkttneKb4HBNR+zKf/fztPLxFCIg+YqtCY6E400dmfchey/I
 MSu87bubyuLMtuqS2a2Mw6UvZsxkRBHUhprLAp1wTgfrv5qEjQlOhQGOrZeU+CatiaKkeyRp62g
 k/g7kSbO3gHq9UgUSDIPDyq3OP7Sp44aQk67d9yQhJIi+/e1n84=

On 11/13/25 11:39 AM, gaurav gangalwar wrote:
> On Thu, Nov 13, 2025 at 7:49 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
>>> Bumped up rpcrdma_max_recv_batch to 64.
>>> Added param to change to it, it becomes handy to use higher value
>>> to avoid hung.
>>
>> [ Resend with correct NFSD reviewer email addresses and linux-rdma@ ]
>>
>> Hi Gaurav -
>>
>> Adding an administrative setting is generally a last resort. First,
>> we want a full root-cause analysis to understand the symptoms you
>> are trying to address. Do you have an RCA or a simple reproducer to
>> share with us?
> 
> Issue found while testing fio workload over RDMA
> Client: Ubuntu 24.04
> Server: Ganesha NFS server
> We have seen intermittent hung on client with buffered IO workload at
> large scale with around 30 RDMA connections, client was under memory
> pressure.
> Ganesha log shows
> 
> 10/11/2025 16:39:12Z : ntnx-10-57-210-224-a-fsvm 1309416[none]
> [0x7f49a6c3fe80] rpc :TIRPC :EVENT :rpc_rdma_cq_event_handler() cq
> completion status: RNR retry counter exceeded (13) rdma_xprt state 5
> opcode 2 cbc 0x7f4996688000 inline 1
> 
> Which points to lack of posted recv buffers on client.
> Once we increased rpcrdma_max_recv_batch to 64, issue was resolved.

That still doesn't convince me that increasing the receive batch count
is a good fix, though it's certainly a workaround.

The client's RPC/RDMA code is supposed to track the number of Sends and
keep the correct number of Receives on the Receive Queue. The goal of
the implementation is to never encounter an RNR.

Therefore, if it's not doing that (and the RNR retries suggests that's
the case) there is an actual bug somewhere. The extra batch Receives are
an optimization, and should have no impact on correct operation.

If you can't reproduce this with the Linux NFS server, the place to
start looking for misbehavior is NFS/Ganesha, as it is the newer NFS
over RDMA implementation of the two servers. Maybe it's not handling
credit accounting correctly, or perhaps it's putting more Sends on
the wire than the credit limit allows.


-- 
Chuck Lever

