Return-Path: <linux-nfs+bounces-18720-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHmuKKGQg2lCpQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18720-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 19:32:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35135EBAD7
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 19:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F51304EAAA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37BC426ED6;
	Wed,  4 Feb 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NQvw6txQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="brP7jHfO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD2425CF4;
	Wed,  4 Feb 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229809; cv=fail; b=qSwAJCoPRU6fgldlbAP/p8YwjBDB7NiVrldVIhkluLPbOXvA9LodnXh4qPJIto+u6wro057rwY4nOgSatrNtzfFE0SRwOcWByYb0UuwlB5ryTH4JmSNM+EXBXU50K4IECl7TEk1wIffLbtsJeUwtSXozWkaujAIGn8TRaLXzBZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229809; c=relaxed/simple;
	bh=Li1hYcehvfOvMw60/fjEwWM6XVo3a2Xvoub9a9ikYk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iKBElNEcEWVi2xFI99NxO8lpLhBH5bykQkFPNCYpvfh/BlgudruvfLhWzd8OeBKWWzawzCfAQ8ZCWk29Rc7WpktuXbCvhmPB0Ku4we8UxsAg7IH3VDU/eb3TuMdAbvKsS3myMKNIDk5+V4a/ygycOAR6Ms7GIuM8j5Fy8o6878o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NQvw6txQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=brP7jHfO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614DOL6c3258504;
	Wed, 4 Feb 2026 18:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P2eJ9yhHaDb5jyVmf4xxLlQ9OoaxjEoeDgZExMnd3Cg=; b=
	NQvw6txQ0W16abR1RG+uDKmf7iLWNU0Go3J7/q9XUv19oLHcm3QjBPbYktOYdCsc
	WumT93FpHWRil43G8N53Z+8B3szrFkZF6oGy9DBr1dOD59pSMYoMnxLzObsbe1FF
	jHO+ouMkfhvo6yWTJKyZsFHdkgmMFgnYjRlCY6MPRTYo1c0ONBVIg51xi7mRheYD
	BSiZVjlWrZGXIeAcJkkY7coYY4a0GcX6dcOyqsaIdc9jJfh7HbyGkNQs9N0vR4rO
	HCz7GzuifjRkqmGfnx6TwYvk6XNWTICsocfvHqH5GdieCZ+j5YTjugr68HD1DgI8
	yI3xxhPKHgjEwmDC9UZTlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqjd76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 18:29:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614H0lMT003342;
	Wed, 4 Feb 2026 18:29:53 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186bt853-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 18:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX1dcK4hEUw2LYJKOTqoXaxDMNbm15zYsi/+8IzTJKKB0a6onJ6rjwPvkQFxpXgpF4z9khF5lfvfeB1rALr1Vs18HNxAQiZkiaNZoCcoPNEaG9ZztslICgln5ibdPBsC1rZF1bbBoYrkK7G99LtE8VgYWYwq2Np6wZG/qQF42fQdAE1+6ohDdujL0tx8Posp80BAD7U/nd+2sxUNpoQ52cst1lj8g3qCuqz1BelFI2zw5+V8tR69ubyFlMTNKSgdKWfJ/QMe1jnoIxTWFedsmhutfJydOpNb8rXFNqIqDQFtNq1LKEc3I0Gy4A+xcghdKzza1Lj+B5e92vS2169eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2eJ9yhHaDb5jyVmf4xxLlQ9OoaxjEoeDgZExMnd3Cg=;
 b=AWPfsJf/wxFp73otOqEbCCuoEF3oUeiPLTHmOjnj21aZoHmIAIUtAyDJSDttFqet00jXfJbqmPAIJa01LQqcngno5dBc55lZbORqYn5E4XgRIdTYSM6NNMxiXM6oL90nn0qvYuvPtpwT/+oWjUlHhI2v9W6NoP3MExwFWCEeGGnqJDSLmclmsaFhqQEMGHIcogWV0NO3F0zxEyZvIMq37Sa0gSLU+a6OFGhY9bZWVXhBKZNhUWXVCrnm/rscBV7WWNUmzzYoNMUlnGXa465eyQ4wAPV2GCYLowf5tboQ4B81AwAR3KB9KOwsbShyQe+8y7wk1NaINr1CdCZm0/UZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2eJ9yhHaDb5jyVmf4xxLlQ9OoaxjEoeDgZExMnd3Cg=;
 b=brP7jHfO3dw5TejanT5goovAbRgZuukO7NwhvnSdNwc+xt4cxBtKm3Vtj3NliKzXkzAU7kDqX/jWexq8zZnkVlgJsc3dmeTUJFyggU0huygRMRN2Sv3vB8TT8czxPl+ZGA2ck5jwfm1hbH3tuz235VNcsuuELvKG1h9QVNDoE4Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 18:29:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9520.010; Wed, 4 Feb 2026
 18:29:48 +0000
Message-ID: <c0af23c2-bdf1-456b-a82a-0f224d640473@oracle.com>
Date: Wed, 4 Feb 2026 13:29:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <20260204094500.2443455-4-andriy.shevchenko@linux.intel.com>
 <aYN35agQMKaIGZA0@smile.fi.intel.com> <aYN6zA79q6yOLFmA@smile.fi.intel.com>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <aYN6zA79q6yOLFmA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 404bcd55-3f69-4a90-e4b5-08de641b60f8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dllKN0xHaml0SHczTHh1aVVkSnJqM21hT0h2aWUvT3QxZCsvRjhtcDFRVHhz?=
 =?utf-8?B?UHZZNVB2V3BPNVc1OHZaTnNoWlFhcGpwQzNLd1ZIWGxGK0dMZlB6V0kybWdt?=
 =?utf-8?B?czFNOFRqVkVUY2FLby9aY1Z1bDJ2STk1U082THZrM1VDZkJuRFFBU3pTcmU3?=
 =?utf-8?B?RlNIYnQybjVjbU5sNmVUVVpVNTZ0U0hxYlR4d0NybC9JWEdWTkNISHRBczNZ?=
 =?utf-8?B?dWxYL3ZoVUxvbmdrMTMxQ2ZPNHBDdDVmMlJJVTYwVWsrWkF3Y2ZRdjcvVTFx?=
 =?utf-8?B?UkZ4Smo5d20xbThEdnJhcWg2WXNRa3pGeXFRcG1rUFk1WUF0OFZCZkkxYlFX?=
 =?utf-8?B?U2ZKT240aU1FTjl2RjJtM2JWV0lha2xjQk1PakdHOEdGcmxmRnlUb0tWeGhv?=
 =?utf-8?B?ODRQdjFlSjBFTGFTaFAwRGZHdWlkMStBMmRNdmx1eWxMc2ZobFdURDFoUDhM?=
 =?utf-8?B?UDgzMENNSHVVNEwxcGRISlRpelM1ZkhEVlc2Ukd2Y0ZSNnpEcnJVODMyV09y?=
 =?utf-8?B?M0JSaGlXK2pqR3IxaktDMHlua0hTWEplUlNYTTU2UXNFaUsxN3daV1Q3YjJW?=
 =?utf-8?B?cEwyQWdXM0xsV3hwdDh1YVgwK1p0ZHdMVWN6V1d2dlAyTlpkWTE4OXhjUWw3?=
 =?utf-8?B?bXh0Nlk5cUtaN1lJMGN3RU5oUkZEY0JqRUwvZkRsbTRYa212ZytZVGhnc28w?=
 =?utf-8?B?OUVZY2xwZVlhRC82dVRLdFFKOUZYZHRJUnlPdGgzK2ZUUFZKekRhRFRNZTBV?=
 =?utf-8?B?RisvbUxIOG5RU3JiR1RzR3JPckQyUHRzdEU1SUV5aHV5bHBsUEdYUG14dWZJ?=
 =?utf-8?B?WjNyR3ppK2NldjVubGtielIrOUR5M3BibmE5M0JOQ2kydTFRVU9YV1d2VW9i?=
 =?utf-8?B?MXoxK2E4NHd0SFRBY2JkaHA5UTFveEhoY3pROTRUWDVhY0wxV3Z3THZmMnli?=
 =?utf-8?B?WjN3a1EydzE4SEJxcjZtS013TldaMkt6Zk1HUTZycUpwSDNMS2owSXB1L2lH?=
 =?utf-8?B?SWpkaEx4RUExdjZtdjVRamdGTkFZSHVRU2tnOTZ0dkNicTVCajhtTW9xdEda?=
 =?utf-8?B?RVI2VzMwZlR2L3JNZW1FeG0xOEszNnozcE0vaVQ2OU1vOXNBQ2NEcE1qL3JP?=
 =?utf-8?B?YUcrRGV5RUlvTnZFVkc0VEIvZUNtQXY3L0RDQTlMR3pBZmxOWUlKSThRSFRs?=
 =?utf-8?B?ZFFVTE84dWt0QU96cDFuUmdWeXdwUFBTQlBmcnBWbUltVUptVDhKeDBrSGR4?=
 =?utf-8?B?amhxNzA5bzVXbHh4N2JMVG4xWStsaVBPNkRXaTdRcG1XM2h1UUlrVlVCcXVp?=
 =?utf-8?B?a1daM0oyT1NoVCt3NHlYdjJ0V2xzSlYrS1gvNWZNcW5jclNqejYxNTVJTmhy?=
 =?utf-8?B?WmRGbFYyQ1pOVXNNN1V6TU9NV1NJM2ZPR1hzQ2ZPcjBla01zNUptNGkyN1NO?=
 =?utf-8?B?SnJkRlhMb0RFRkxZbkRJREIwbjJMMHMvUGJDMFNLQzdoMTdlSWYwWFA2NjlL?=
 =?utf-8?B?L0dkUmU2WEx3dU9JWGJ3ZXZsdkQzOGVSWTNjZ2RSZmN6VU9iZUF4LzUxVjBL?=
 =?utf-8?B?Tkh0elYzVGRUY1A2WEpPeXpyOEkzK3J5K3hpc0xLZ2g5Z1IrK2VPMTBhZnEv?=
 =?utf-8?B?a0s3ajFXdzFUY3RTTllOQW9POXdnLzZZc2d6b1VvWHluQ3pGWnl5Uk90Q1RI?=
 =?utf-8?B?SWJyemp0RUoyeTMvaXNGVjZQNEQ1SjUwbGFVcEdHSTlMN05tcGtBanpzQTNP?=
 =?utf-8?B?T3E0NEN3eTI2N0M4TEZhK1lPcVdJOUI0a3lXNzE0bW4vMVdDRlBlTU83UVBt?=
 =?utf-8?B?cWV2ZDU1bjBWT3VuUUVqM0xVSm1vRnRnb2VwTnVlRzZKaFdzNHhyUXg3ektz?=
 =?utf-8?B?YkxMeWQxcDkyVENoL0h3NkUybVFReW11V1FPcmNSM0pqMXpIUlpSL1lJbUtT?=
 =?utf-8?B?MTR0bVFtR2lSMEwwRGFZMFRvQWkxVEw2RDNkOVlWQ00reEd1bk1VVTdCQnh6?=
 =?utf-8?B?WUtNcWlNdlRuNUhpREZYckxmYXZaK3p2ODVHTXBnVktvemNXcmlkblVVVXJ2?=
 =?utf-8?B?Zi83TnM5aWF0eldhR2szSHhuRzNkRVJWZ09QS2ZEK2dSbkdrUTZ4bXZpQ2xk?=
 =?utf-8?Q?0UBw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dGVpeDRUTUZtYWhKeHV5WmJoTlFJK3NNU01xWmo3M2FMSE1hc3VXZjM2aE9p?=
 =?utf-8?B?cmtDRmRGMHFWZ09MNHdZUzZPUk5hNXAzUVMyTHgxTUUvWER0K1J1bHFQL2Zl?=
 =?utf-8?B?MGtLMWI1S1ZIQUNFSWlkVWFXbTI4M1I4dzE2RUIyaGVKNS8yVCt0MDBpN09r?=
 =?utf-8?B?dkYzd0N4WmI1N3h4RmovcTFFZzUxaTdDbVpSQXFQWjVIdy9JTUZISk1MM3pC?=
 =?utf-8?B?QWg4bnBGcmxNR21wZHNXVEw5VmFoVnMyL2tabW5uUnVrK2loTGx2Z1psTU95?=
 =?utf-8?B?ZWdmYkVJRExieXNjSUl2b1BTMGNMT1dCcXJVOHFKTGFzQ1o0V1lCL3Zsc1NN?=
 =?utf-8?B?OGlJUmlTK2dlOHlNSjZUcUk1WVNxNUpkc0wzYm1vZmhjZXg5WU1FcHdqQkRn?=
 =?utf-8?B?SFV2S2lST2Zkbm5sRFdsUVM4dWZKMS82WE9Wc3BkeGhDbTBCZVpFazNCMTJu?=
 =?utf-8?B?Q0FSNmFhQ2VHTk1PZTdvdEw2NXNYZSt4TFdDYUVzUXdnb2V0c2w2MFVXWWMr?=
 =?utf-8?B?aStpbEVVVVlRVXBCV1gvOERHZGlqbVFtRlRhTWZXMUdSZUZVQ2pudGtVS1Ny?=
 =?utf-8?B?Y3RGTGtWUi8vendNWW12MG8rcVEvOXpidDVnUkdYTVJlKytlNVltTU5zRnJy?=
 =?utf-8?B?YUU3c2lHTFZ1aTBKcDlYUFNEYUVaR3pPVUJpdUZpWUdqcUdWcGJhcEh2Skd1?=
 =?utf-8?B?ZGJHQXZXZkpHWGFrRENraDVtZ20vTWd1WkdBb0ZCMlR4c052c3U3Wmo2MjQr?=
 =?utf-8?B?SHhSSUgzd0IzMUJwb3JydnpYb1RORlJrMzhxNStGS3Zvby9iR0ZUNnVmUTNJ?=
 =?utf-8?B?RnVBeXhPelY1Y0RwMENkSXAzNlNJL3J3M3luL0E1VXNOUERYVmFFTVVWeUdi?=
 =?utf-8?B?dGFsdHZtbEdzUzNJMWJ3M1pGK2ZabHlKT2JjQno0bFZhR3h6NDBGTnhZaXRF?=
 =?utf-8?B?U0RPMkRxVlU2V0lXTUVUTDdZTXl6ek9sNmh1U0paaG1mcEFmM2J4b1BIUVpy?=
 =?utf-8?B?YWVFclVjSElnSTNZVE1xVFVYdXdJUzJDQUp4WmYrekhzSE1zY0tQa3BxZDY1?=
 =?utf-8?B?UWZrM3F3bnB0aUdad0JkaEc3a1pvL254TUd2SUM0U015OWJxQUx3bEFFQ3Bn?=
 =?utf-8?B?N3d3SXFNRDJqeERqZzRpYVNhTWJhREo2YlkyL1E1a2J0a2lkQ3AzNUcvVkVC?=
 =?utf-8?B?TUdCSm9CVHpDWGpLQnd1TGhWM0FyZFJpa1VLZTdZL3VXK21lNW1xN3IwK3Jn?=
 =?utf-8?B?ZHk5Y3pWQnpxRGhrcUp6ZTNsNUdHNllmeVJ2UlJDeFdET0R4aTAxNnlTN0lL?=
 =?utf-8?B?RHJJNG9IVlQ4SHhvRVlnUHFoOUlXeWFBb2s5Vm1RUGtGMzFBZU1RZ1AxQTNC?=
 =?utf-8?B?c09TalVuUzhwcWZyVG41R0F2amkxTTV5NjFGdzJMYnU5NW0yUys0bWlDTGlk?=
 =?utf-8?B?RjRtandaL2Q5WTd1M2VpN2ZMYkpVT3RpTFoxdzZDbmdrMmhpZmxVWWNrdTJY?=
 =?utf-8?B?R0REdDdxcE82bzVMd3hvWU9GMnVMQnN0akhiNm1NWm9FVlZPZFNvL29TZ2lI?=
 =?utf-8?B?NlNBaTIwaEVCbEJtNTdrWVFTR3FHSGQ3Yy8vamg4RXg2MVNITkp6SG5QY1pL?=
 =?utf-8?B?V3M0U1RKc1J5akVqRlNnVnVDSHF4NkJ2emNuaXU2dXBid2IzeEorNzNBNUdm?=
 =?utf-8?B?V3QrQUNoc1FBVXdKL3VRT3pWRWtvY0FwcVdvdjRVWnQrRGpiVms1NUVud1c0?=
 =?utf-8?B?VzFFNEFDaWZvbEordDcrbjV6eUM3b2hOK2Z4cEdwMjlRQUNhLzJ5alVvZnR3?=
 =?utf-8?B?eFFraTM4dWZqTTZwTHhXRTBXanNCZy83WGFVOHJsdFBHQ0gzZHk5VHRUamxS?=
 =?utf-8?B?dUdTaFpSbkJLWDNWUjlyZktlMnd2N1FpTmwzTGVXV2pMa2F2Snhkc2NZdFly?=
 =?utf-8?B?T0hCcUtUOVZpdk5SSFNkbWxiMEVsMEQzSktVUTM0VHFaNUZVYjNYc043dWdJ?=
 =?utf-8?B?ZlMzeTBQN2JYK2lHNjF3RnhnckNIWnRzc21FTFRnMU1FbGFHMGE2RDlxS2ha?=
 =?utf-8?B?RmlrbExleDlTelRlNEQ2WHN5aTFKZDZpZzE1VEJJTkk4MjNWMXhpTjFBRzMz?=
 =?utf-8?B?U2FHdmdWbHJ3WStGVUlLZzAvci9YZTNWSHFXa1V0aXBHN2N2S2tzb0tCOWNx?=
 =?utf-8?B?b1dhYW51L3dQcU9hQXdxVFBkYzZZVjE5RGp1RlAwbkhqRUlHMTc2WlczSFpp?=
 =?utf-8?B?aWpUL2dYaisxYi9PbFJoS1l2d0Y3QjdYYld0R2JKQjY0bDVFQnBIajlMS0hp?=
 =?utf-8?B?Z21RME1MMlBtN21aU3JDYmpNUzJqcG4wdG5wS002ZkxlN25EVjh6Zz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2KPgwRlGj9cZwRSG6leGNu/Hh/XEkC8sJ9um6vjhEcMa7sE0oAYgtoS33sj+BuaWkceduXnLuecXIblgsj+u1npnSFGDnUjmD2SOsO2G4XOHchE8fhnYlSPApHnxu+7nKEUzHaDv8Z9zMiDJU138xNUQR7FA8+yEFA5NK4QLnwzIYPWApio3yjo2epocvZ3pGyThzWw2N/6FV7YdcUmv8vApls6jDiRVqn4wmBcmVoGHqRRDuxxec4rYgJmJCN8/PSZ+Md/Flt/qT9rER04Ot79c/bHZYwn1+KajNwItjNTpDns6jolY/+sbNMPhjbhLHzPIaQL/DSuhKOVA1FeqMF7/8S+1ly+5WDCuHd4LisDEEDfEj0taKPDBQw3iU6aFlPED2Ch6ufdBxVgLt6Lxnr2Ig7tACUgfSWEENW+ysKeHBku/fkf0u+4yogKfmmdTuJp5HEYKLdgtqhrx7P70lPYo6uQjZLAK2GMsqJVko7KVC0jH7lM+PiDgKh5xKgKTRQ2gXJv0H88b8Csz+cgy8jsl/UtH7nTBbNcVehWejVG832AAryndyNntseq9gO9xIgiIKj36XCxsOLxO/VPNa/jeHpIlCB5KwoT300O9Hh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404bcd55-3f69-4a90-e4b5-08de641b60f8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:29:48.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ42/jaNBxD3FKCfZ5beZGbEAnVn+VXebl2iNd5Jb2ktVhzA43OmDEUW6LT4wKHGCCH8NA7Q993/mby0WtlL8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602040141
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=69839022 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=o2xCZa-lLYPS4Ke5Ld0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oSXQUNtU1xqsGL8KG1qnCGL8f4kiqeWU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDE0MSBTYWx0ZWRfX1ZEfyjn7S75I
 6wUkgURApgM2RXkB3BsAR2xyBKtCFAABCXXXXpOhP50mSz6Xgth0TSR5iZuhuoljnjiVS9WLDHa
 HLJayc4kzthYGBgO7Z1WB/bgX7UkX0l09G+yPZPACrDqCyedsCPWsaRQSULSU1HZAKW/e/rnuSG
 ojfHzmtNU8o48AbsuIrUAaB0K7pbEPKbK5jtZeLV244NksJewPPVMV1j7ruTDxVQHcccKd3GUc2
 6fSzjsSF6fcQygeESfVcqhQzU4HPFVbZQqWqIR1XsYrghqifx0GkUy4vjnCKuGyQ6oNRsu3PJQF
 lwIGHAd4UtYHJjCOYWse8U+1uZud5IFjVCHHlLVGYolA45rKfr0RvGZjZNYMEqfRfk9gnvfA/ty
 3Ni5Vw1pNXxaiEOduSSVCac5/pDKP7B5HvAVj7Lj7XGG/p0OJPpAME7tEjLbEcTOTs/nJZzQFlR
 FJ/M9Ew5DzZsDMI4T9A==
X-Proofpoint-GUID: oSXQUNtU1xqsGL8KG1qnCGL8f4kiqeWU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18720-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com,glider.be];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,lkml,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 35135EBAD7
X-Rspamd-Action: no action

On 2/4/26 11:58 AM, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 06:46:36PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 04, 2026 at 10:41:23AM +0100, Andy Shevchenko wrote:
>>> Clang compiler is not happy about set but unused variables:
>>>
>>> .../flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
>>> .../flexfilelayout/flexfilelayout.c:1505:6: error: variable 'err' set but not used [-Werror,-Wunused-but-set-variable]
>>> .../nfs4proc.c:9244:12: error: variable 'ptr' set but not used [-Werror,-Wunused-but-set-variable]
>>>
>>> Fix these by forwarding parameters of dprintk() to no_printk().
>>> The positive side-effect is a format-string checker enabled even for the cases
>>> when dprintk() is no-op.
>>
>> I'm afraid this is not end of story...
>> I received a dozen of minutes ago a new report and now I'm investigating.
>>
>> Patches 1 & 2 though are ready to go.
> 
> Okay, if I'm not mistaken the only leftover is the missing tk_pid field due to
> conditional inclusion. However, if we do that unconditionally the data structure
> won't be expanded (there is a gap of 3 bytes. (Dunno about m68k, there may be
> actually +2 bytes due to 2-byte alignment.) The rest of the conditionally included
> members seem not being used in dprintk().
> 
> That said, removing ifdeffery around tk_pid in struct rpc_task should fix that
> problem.
> 
> If you can fold this to the patch 3, would be nice:
> 
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index ccba79ebf893..0dbdf3722537 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -95,10 +95,7 @@ struct rpc_task {
>  	int			tk_rpc_status;	/* Result of last RPC operation */
>  	unsigned short		tk_flags;	/* misc flags */
>  	unsigned short		tk_timeouts;	/* maj timeouts */
> -
> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
>  	unsigned short		tk_pid;		/* debugging aid */
> -#endif
>  	unsigned char		tk_priority : 2,/* Task priority */
>  				tk_garb_retry : 2,
>  				tk_cred_retry : 2;
> 
> Otherwise I can send a new version.

Please send a full series respin, thanks.


-- 
Chuck Lever

