Return-Path: <linux-nfs+bounces-15368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E6BED845
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7362719A1F00
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528991F0E2E;
	Sat, 18 Oct 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkT0PGxT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k1Qs4u6F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942311EF363
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814464; cv=fail; b=oiEptbMvUz7tKu/RrWwP8HarrN6Os3Rj7akNWD1GtnFKRDA8k2rNBqC5RQbjvyNrscoQBmzEnvgu5erInS1i3MxsPLh9Uh9mLuEAsekXuYPUefOIIymsa0OEc32qFmk+nD7zSMo8gsDYeVIBFarwlZkfmikzJFJH8E6VzPVA5Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814464; c=relaxed/simple;
	bh=Ud8g2Wf5ChLxIXwT1Z5aREd2F5kyre7iq+c9WjVv8H4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eD2Q3XBcIvuTrB5SCAd9cBP3rzbfKuG7g6+iumzL9DARab1UGa1PqB5V35bH5KN0Pra92bMPPfxqM9iXFH3P+GPFKS0p3BQPbmiou+Oa0BL3Zs4hPESEXQxLaK6mazDASMXs9HwC7zeJozFzx8Unlv1Y07s1nSIHaAR5ltkvVTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mkT0PGxT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k1Qs4u6F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I9guZQ026482;
	Sat, 18 Oct 2025 19:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7DcHNb27LaF2EKmFfXrDUjQcnTO6kRtpUmpL2JiISNk=; b=
	mkT0PGxT7iktPrcjdqKMd8p/ZG57DPbon18nZKR4LtaZDcinKt0213dc0c7Dg5mm
	+RtjEyqDLEj4aEBJNwzD1jDvDcvP7f+aEc6pibm1boC3giwUcg6WWqVycXsdrGHS
	aNiacvDVgrP2Hy/JAbUROwAN3eJiVcxvzxpVyjazCKpaOnRymG3270iMPz5RsrgL
	Qw46UAP0TsPO6kiCzIn+yBHyGo38ZNVEuMg16mMECisbyovwROt+6ZLnLgIHWnvh
	nO8vDbypmpFsaP7Ux/zRIODw2Sb/cwRal0nAyCiTBUVBXiieTjijwttPtf6F7C7b
	HVybALJzbhz3VxWnQPqDoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvrfev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:07:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59II2691013116;
	Sat, 18 Oct 2025 19:07:37 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9f8up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7WqEc9FK9kSAEEFiI8f1zpUz8Rxcjx7eoLXLyRkxLwbpHDvgmj6GVn8pf3N0LgQevVYqIWAluSlQOu/tJ0qnFDWCVbkIfhX1AMlrqUBDwoh1Jim58srKNv4R+9jyJqZ/3bbvrjuSH8oIl2rXJFvJoBXHoiRU6luBOrYrirqXCrOAHnne2ODEMWf8L2INHNGSLyFS8xPYOYBhJdOOLPw0Dym8k3Cfin3rr76GN24CNdTHwHNk1euzqroHOP7QRRSEJ7h8zE/ddhgyRnG3TU5QAh2nNPRxv2We6kYB2XL/7Spj3hJAED9BOzg+JUia3HBy2IOi60k7MBjZDh/uWRN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DcHNb27LaF2EKmFfXrDUjQcnTO6kRtpUmpL2JiISNk=;
 b=eJIC957Titx2Xs2/NQc1MKPq4QU7H3yAgw7QjHtAgM8SBXYoEJJ2cEz8qaBEzhSCarJfNPRReuaSlmhszeLF+CkBOrOCGSt0PkriaiO8XCa2rDZtOYO9Q+a1SuLhsOee81CvXjxfL4aglNQIg9XHfjR3yVSn2Sni9IhzV3zsEVPJUo/Y6hAtlz4CYp5/Fbm/vlLyQqgetmsnrZHqBlLH26TyRRYQLRKGAzfxT7hdKRhCQPyBo9NrqbRTpC+NzOOA+fPHGo9P07nVf0j8uMsmm+8l60eESDoe8C9U2DJxHq0adeN3MRKPMJUYFHEjTvStP1asYOtQgfr2hZjQnIEw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DcHNb27LaF2EKmFfXrDUjQcnTO6kRtpUmpL2JiISNk=;
 b=k1Qs4u6FbPkM0TDqJ3MUaZDss2SJ0BpDKRB4B4dJoVWF4VUqA0LFFyoT4OgnoR4CsnJIge9BcdpCHhdrScuYJXWPOYupAj2YxX4dgzBIjjj0raen7HP0EpE+6E8iViHV13PnreAs1M70P40R2Sr5ZB+zcVwHhLpGnbM1CnzU+Ew=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 19:07:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:07:33 +0000
Message-ID: <bd3183cd-d5a8-499e-b288-17216d451c42@oracle.com>
Date: Sat, 18 Oct 2025 15:07:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] nfsd: replace sid_flags with two bools.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-6-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-6-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0421.namprd03.prod.outlook.com
 (2603:10b6:610:10e::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4e4a12-8f57-44c7-0438-08de0e799798
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dExGdjBJem5mdjY3SFY1SnhPNDlMVXV6MmxUUGNGb0ErWk50YUduKzBDTXZT?=
 =?utf-8?B?RGVPWmJRZmkyZVpQMGpQbEQzZlNXeXhMQWI0dk1qUmhzb3FxVVp6Z2daQXJi?=
 =?utf-8?B?TTBHWGVsYlVmYStCWVVxZVk5VG1vaUhibWNDRjNDdit1Nyt2aDR5WDBZN0Ni?=
 =?utf-8?B?UUZUZmlOOEw2OTVGcC9VWEk2N3IxUGhqeXEvZ1FHSTRuWEcwWitRV3Q5OGpD?=
 =?utf-8?B?TVY1VHI5NnZlQ0NNODlVa3QyNW5vRHdoYzIyMzZiTGEva1RZa3lKUFkwQzZq?=
 =?utf-8?B?YkQvc2ozekUyd1NJbllGSlE2UVpmZ3lzUjdENElBOHBGd1czMFpua3NYR0dC?=
 =?utf-8?B?MmNYd1BpbG41Tk1EQkszeEpIRy8vaHF3cjQ2c3dUOU53WkRWMS9WdU1RZllh?=
 =?utf-8?B?UDZYN3o5YUMwMjB1bTB0SjhtNE5MUEd6a05rT3FSaFBCczhVN1lIbmlabFdF?=
 =?utf-8?B?TENqNndzUnVXeUF2RFdnN1hIMENJMGN5cXJ5NCtVZkx2Zm55ZEZ3RnBWY1Bw?=
 =?utf-8?B?VHlXYkhwZTVkZ3I4MUh4NjBCWlQ3Umd6SjJlM1lHUmthS0NlVEI3K25McEVs?=
 =?utf-8?B?K3NUaUk3UW9kQWxSUEZ0WjBUa2NyL1VBS0ZqRFY1WGMyUEZVR3FVanZBd3d6?=
 =?utf-8?B?a0xOWGl3L1Rld1pmZTlzN2kyZDczQ0NMY2tGR0NleExaR2xBZlREM0ZZVmNi?=
 =?utf-8?B?dklOcjlDZHlIUnVQbjViU1JxMzE5Q3Q5dkhlbjF4RzhFTEVjejdHWnVHY2lB?=
 =?utf-8?B?aCtFeHlSVjVPK0s2WVF6Y1hWUDZ2ZEdyMkxrOU9UUTJXSkx0WlFUclo3MDV6?=
 =?utf-8?B?eWpXczBReU9wL29jZEVkNW9RcU9Relk2UGRVUmFaRWM0cDZWQlpPd25qZGNX?=
 =?utf-8?B?N1l2L0tlbjZYZHJneDZIT2pVVlhwS2c0Sk1WdVM1bjZQRk5PcHJ1SVhjVHRv?=
 =?utf-8?B?MUxFdSsyVWdYN29XT1BwSFBHUmNSbkU4bEdxYkc4YWZyUTRJWTdoOGVQN3Z2?=
 =?utf-8?B?YXRRN3Bzd2NFVVZ6NHljV2wrbkhzdmVGOTQ5ei9vdkVjakQyV0JEMDdnM3BQ?=
 =?utf-8?B?Nyt3V2Uva2tJOFRjSXVTV2RwVXVtcTg2M2IySUJsNk1LdjdhWGVhUTdQbG56?=
 =?utf-8?B?b09RWnNXV1Jmb1pqdC8vUEI4KytFWGNNeXJyaFhONG41KzA4T2FlRHJkblUz?=
 =?utf-8?B?L3pQZ0ZVZmNLOXdRdWF1SmFYSXIzN1hodUVNVTJTM2NNV3Z3MWtzSmRsU3RU?=
 =?utf-8?B?a3FpM09DSjdEKzhkRTJGYnEvTXFKUE1OUE1sS1VQbVlHQlVjcVBaS1RwaWVy?=
 =?utf-8?B?U0NYTWNCckxjMFFhbGlCUWxQb242dzJpRjBBSjZDVENFSHlhMDFoK3ZQb3VE?=
 =?utf-8?B?MjhVZVF4WWJPUW12YXpRRXdhcEszNGxMWUpjSVNJeDlnREd3NmFJcG1mbFVm?=
 =?utf-8?B?QTErWGRUZkIyUldiTXVrZzExSE1BSURBNDBhbTdtWHp3dEpOMlpldXNLM2x2?=
 =?utf-8?B?a0JXbWhXMloza05uK3BvWTN6RHRyMkZYSWI0K3Fna051YUhLY3dIMno3MklQ?=
 =?utf-8?B?QjFJREhnS2RnTEFubTRBYVlvb2s4dlRWdytpbE56SHBBVHZtd0RSM3VndTI1?=
 =?utf-8?B?OTdqNTgwcTVvZWFUaStwc1RzbTUyQTBiOWhMOFUyNWNMYXEzdXdySU1sYlIz?=
 =?utf-8?B?ZWxCRnJJbHNvMkswWTlSaVJGRDdTU3UrYXNNWDZWNjkySDZUdGcwWkxzb3lX?=
 =?utf-8?B?Q3R3QVdpVXdjQjlTWWVEb0NxQ3lwRzNNbW9vSzlnZmJrM3JDUzU2d2dRd3Vv?=
 =?utf-8?B?Y0dWRU01V09VT1VqNWlwZzE0bXUvc3NDVXpKUkRLUG53bE94SldLdW5ha053?=
 =?utf-8?B?eGlMeStqRm5FQnYvN3dLVUxqYW8vWHcxdGE5TkpBUXV5bUFMcWM0U21hSmEv?=
 =?utf-8?Q?NZiPZHpg5HSDQ3LCTeEmmVsRzWfZIp5o?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aWk1YnBObjdBdGJGd1cyMnd4M3BnQXI4cmxjeTJOTXExQVVJVHFwUTYrYmlQ?=
 =?utf-8?B?aEp6UUJqaXZLVEhnK1I1NVpIZW95aE1tdmVXYnkzY2Y1eWFIVXBZOEpUN0lN?=
 =?utf-8?B?VEZRRTdUYmttd3VwM1Z4NURlMVFRVWJsNzMvMTN4MWs3OTR3ZUduZnd0cWJh?=
 =?utf-8?B?a1ZJelNwbHlQOEVpbnpPdGtJUmw4cWRFbWkrVjZScTRzVkMxVndmcU1YVDBR?=
 =?utf-8?B?aHBhaUFOZXlGWUtLcFh4TVduVCtwdmlEelBJRlNoRGFIQmJQTXJQdzRhL2dK?=
 =?utf-8?B?K2VRZXV0MXZBbkhrRVBpQlFIYUJ3MW5WSnBTcHhLd0diemdzbkRHSkpWWStm?=
 =?utf-8?B?Z0VDVlRCN3RXaEU5aEtYT2h3cVJnREVnbFdVaUsrNTB6cVozM0Y4QWhqYUVh?=
 =?utf-8?B?eDBnNjh1VWdIZ3dHeFY3RDdVQnY1RzRRVjluN09CVmdUS2V3d3JmZ2U5SlV2?=
 =?utf-8?B?SUZtZXphQTVkaU14VUt5R0tqWTVyZlg0WjliY1pqcnFXbnltR1RZMm1xVjZD?=
 =?utf-8?B?dEJJK1BuVXIwNlB1bFhIWHlYUDl3dm5yRkYvUXd4czFNMVdvbWNQQjV2c3d2?=
 =?utf-8?B?c3BEcVZmL3NKWVlhTDlPa2Q3Q0Rrb1NCdytIbUg5TXQzVmhxVHFWRHpQS2hG?=
 =?utf-8?B?dU80R2JpZ1QyY0tOTEc2ZGdRTTM1dTEyZ3IvSm4zcklkYjF4Y2orZjZ2VUxE?=
 =?utf-8?B?ZEE2QWdQUGpTSFdGaUFlS3loUVozUFFkM0pJZGF1bStBV0lscTd4SU1sK0RC?=
 =?utf-8?B?dnRjVDNYc1pha1Yzejd4dnJENjR1OHFsRXFvaEh6a3RaOGNJQnZiM2c3Nlcz?=
 =?utf-8?B?ZVh2cmprcFdyeGd0LzNxT3NVTnI5RllJMk5sMlIwNDBKaGovOHVyUlhaK2s3?=
 =?utf-8?B?M09uMWFEa0Z5OUtzWkp0QkdKL3lIQ1Y0aHhYZVdwNUJ1TUFSN2VOQlY3dmJp?=
 =?utf-8?B?b3pBdFZSQWlBbkNMQldCaXBuc3NRbGtJQUt1VjlhVk4xMUNKSVZUQjVlVnZj?=
 =?utf-8?B?SmgzcWs3c21rMTF2TExjL0RpNFozMzJybnhZd1QvQ2NoZ0NBR2NsZmluT29n?=
 =?utf-8?B?VzRyTEdjSnR4Qkk5OG9aS1NmMFpXUC9tTFMybkYya1pNQ3ZRNW1lMXdTRVJo?=
 =?utf-8?B?ZVVVeWx5Z0VMbURVRFNCcTJKb3RwU2V5Vk90OFVBTmgxbjc4VU5YTGFNaTlV?=
 =?utf-8?B?clFEZzJpQnk4Y0N5M0ErMVNxL3ZjSlVQQkpPVmUycTZEZEQ1eFIyNHhWZnBT?=
 =?utf-8?B?czJVaFFrYXJWTFdnaW9tblViMUhTWCtZeDFqclVzaHFTazVvbVBUZFZJV0do?=
 =?utf-8?B?VjcyZTlUU2c1Y3MxSDZhTTJBcWhoQ1M5eDJsbU50MEVFSVZwdjc4V3FlVUVO?=
 =?utf-8?B?Ky9PYjFvZFF6OHVIcFJEcm9FeDZVOFR0NkZndDdPZ2NJRzhKSjJuM0dTUlNy?=
 =?utf-8?B?TE84Y0tVdnFHaWJJeEEwVTNtZXEyUzNNdnNla2Vrc084ak5SQzRYNC9pdFdS?=
 =?utf-8?B?dWQzR09jaGdJV1p4ZFBnS0UzSStTOGJlSi85ME1BeHp5QVBSODZidzFmTjVs?=
 =?utf-8?B?eG5PeFFONlFGdDlYQzFvSWVTTys5ZWhzZzZxQkxwZmV4RmJJZklXampXQXZz?=
 =?utf-8?B?NnRxUDFQeDNFOUprMGpjSHppRmxvTzZMc0p3Z2toUTJldzNrTDgySjdqWEg2?=
 =?utf-8?B?a1FGZVFXN3lVVHRxeWR0TDlaT0tRcWxYWk5ERGF4a0c2V2JmTEtGcjhERzlq?=
 =?utf-8?B?OXFka1owakppSStNS016VHZ2ZnVsOXBNZ0JkeTRSUGdXdWRac2ZUNTdUcjZD?=
 =?utf-8?B?VkdjYWNQZFJYd3QxNVpJMjgzU2VIL3BOaHRXb003Tk45TXBkZWtoRDZhU2g1?=
 =?utf-8?B?RCt1SjBxWThaUjIxTWVzOWxCa2w5clR1OGhNbnVpRUZaUWplV1JXa0pOTlpx?=
 =?utf-8?B?eGlqbG9ZMG52QXN1QlA0RWZxaSs4SkY3dTZUTDhFSWh2SG5tK3BrVmkwL05q?=
 =?utf-8?B?cWI5TVZFb2FLMW9lc2tKbGpjZk91TWk5bDJZTnZxZEJBNVg5MWtVa0gvS0xG?=
 =?utf-8?B?bTNPcFFVTWlMT2NJbUNCYUhNL3B0dVI4MGNpOGJTcUJoWjFoK3gwMjRBYWdm?=
 =?utf-8?B?RTFpMDRoSjYzU0tNajE3Rmx0dmNHSFd3QzkrK1B4YWFBYk9tMzdSL3FGMjN6?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5qDHSE39gL1nhrDo+HSgFBGyOnXKI4saMY22+ZwMJ+F2xdzdVgh4A8I5rk0Ky+eLeVTt0jtb1Bn3IYa9AQ4ZrFc3n571dP+9UFrq4niijtMa3Gn0yNCMAHcZVsVGixqZznkh02zkbEvAGYIfqRHoyeM5+qmu12FSSdVc//sNMUI59Dceo2qkK7eUhLEL3v0hYzNAF+eAXVfjonzLHqx7l/jlpG1Tc0KY0LtIagbzQV0q6el7LeDItM9EQdfUPKf+Wf1/T56eF4QLy16kiX2/aZYEfPa6wxyHN3/4Ta1Jd5Y+oRd1eIwyEZJxxa45jChun6j06jMlZRdHJ5DLpCJLMUqtMJxGsR7RiwMcT8YcyqxPYQ1WKo69nFpLIqeeVUmu6rPMVUVw9fD1eDNmY3wSHLvFhccnXqEqwLRSK1DkjSVMBzHUnTSpa/LGDad8V8SCs5/AZOCHsQqd9DYfXMzchX1T/+t8HWYKD80eD8aWxnq+8Y0ESWaUp8Tr1r8eTEotUwbOugD/YvTzE3LBd/oW6ouIXZj3/ImBGtZz/OXSPu2knLoSlmWssZYd5eCSoCc7Txt9ctZJm+9v7M19/tHXBZ2mU1EQkAvfEaKtM+HOrqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e4a12-8f57-44c7-0438-08de0e799798
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:07:33.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8NR5gs0aREBs0OXF+x3alt6p6kLj390KBWHUlfchV5mrJ9JodaozOJlASK4TewQgTsBSVr/eon13o2wY0qgqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=937 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5S0I5Fuzu68H
 4vZwTJhJ9NH7Wk99Jx5rSqtYpDXT09fdGXRUwWVFOQKPsERYUjzTJLM3awwRkNT1JaVJSU7oizf
 sPwL0mKEYVVCbsqFzptMwQcn5Ry8P4WOXZEXe5hVNcW+xDo1t9K42hpMkSfMukD2xWRbiewj8wS
 xQ8iOzXhkFnf4dhzK1+5xnHyB9mfwaEyti7eYG9Bu7pcK+kVISqXl5E7ZlBcQGrJChJV41ecOFv
 JzZVIq78XmYiXchV/UB1oihPUD+yFrA3iWseRCx9YD8opmfYkSOTpSgeQ7TOuf1BU0JD6Ksl6Am
 eleHZgMXj4GjCbQF5XPu6iDt+5AGMuIIikbnvuCUMFM1AQz31ICBjPZis9m4STC5h+O/uOgo9g8
 tfHi6FhWWrAVJWfL8T092ahiiAtq/g==
X-Proofpoint-ORIG-GUID: 8guREmAYhzNQFFxruKpPf4VF-P_A847A
X-Proofpoint-GUID: 8guREmAYhzNQFFxruKpPf4VF-P_A847A
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f3e57a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oQZ-2p17F68SW6ghOxIA:9 a=QEXdDO2ut3YA:10

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Rather than having accessor macros (which I find to obscure the code),
> use to bools for the two flags stored in sid_flags, and access them directly.

s/use to bools/use two bools/

Otherwise, LGTM.


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c  |  8 ++++----
>  fs/nfsd/nfs4state.c |  6 +++---
>  fs/nfsd/xdr4.h      | 10 ++--------
>  3 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 944f10a08c77..7b6a40cf8afd 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -717,9 +717,9 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		return nfserr_restorefh;
>  
>  	fh_dup2(&cstate->current_fh, &cstate->save_fh);
> -	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
> +	if (cstate->have_save_stateid) {
>  		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> +		cstate->have_current_stateid = true;
>  	}
>  	return nfs_ok;
>  }
> @@ -729,9 +729,9 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	     union nfsd4_op_u *u)
>  {
>  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
> +	if (cstate->have_current_stateid) {
>  		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
> +		cstate->have_save_stateid = true;
>  	}
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 59abe1ab490d..dbf5300c8baa 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9081,7 +9081,7 @@ nfs4_state_shutdown(void)
>  void
>  get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> +	if (cstate->have_current_stateid &&
>  	    CURRENT_STATEID(stateid))
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
> @@ -9090,13 +9090,13 @@ void
>  put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
>  	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> -	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> +	cstate->have_current_stateid = true;
>  }
>  
>  void
>  clear_current_stateid(struct nfsd4_compound_state *cstate)
>  {
> -	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> +	cstate->have_current_stateid = false;
>  }
>  
>  /**
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 0ca30a92d40c..7218c503e5fe 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -43,13 +43,6 @@
>  #define NFSD4_MAX_TAGLEN	128
>  #define XDR_LEN(n)                     (((n) + 3) & ~3)
>  
> -#define CURRENT_STATE_ID_FLAG (1<<0)
> -#define SAVED_STATE_ID_FLAG (1<<1)
> -
> -#define SET_CSTATE_FLAG(c, f) ((c)->sid_flags |= (f))
> -#define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
> -#define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
> -
>  /**
>   * nfsd4_encode_bool - Encode an XDR bool type result
>   * @xdr: target XDR stream
> @@ -194,7 +187,8 @@ struct nfsd4_compound_state {
>  	stateid_t	current_stateid;
>  	stateid_t	save_stateid;
>  	/* to indicate current and saved state id presents */
> -	u32		sid_flags;
> +	bool		have_current_stateid;
> +	bool		have_save_stateid;
>  };
>  
>  static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)


-- 
Chuck Lever

