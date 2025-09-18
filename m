Return-Path: <linux-nfs+bounces-14575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EEBB8654B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795533B65C5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453626B77B;
	Thu, 18 Sep 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvR+4DPG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oDcuEXSR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E92848BE
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218118; cv=fail; b=kmAATo/yQh6Xi6bl013usINatNbw82MM4lAmxggGobatv+VfKftiZL6xs1G6TMgU0WoQT0f7Iwp732zvjkvEOU1uujs7wEsjo9y1OwAkeLYtucRy4gCS0ti3/KqSnhfT4HoTH9tDH7HGQ5tEz3u3EM07U/QX3bBQEyThUZQEZko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218118; c=relaxed/simple;
	bh=wNF6hb0k+sAr2grfqGWk1CP4R4wPzjbrWeMMRFVdT1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l2vZEs/3i+fRMLMDdJoQsFll/xi/EgyzpKyovIcWlpN0C6Iws3Z+DUY2ZJAwew+gTiWshb9iJKZ/gYJJzv4D+V6O3PKC/Cb+1//u919ACrXTBi/LBHO7zRgWWmTsxb5ydmWbzH2JJSjYqTUnK+/i1Sz8ZhA/7qoV8hI/fdIEoco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KvR+4DPG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oDcuEXSR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGAmY3002503;
	Thu, 18 Sep 2025 17:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Cp2gcDWXcW+wmGUtmwLaqHmczq+iHE8golqEtOsK6lU=; b=
	KvR+4DPGuSK30ZCRQrKgU+GeYpvA9u/GJnbWoSIcbqlcNML8MHAQorrTF5i3e7B7
	YVsO8Tqlxsgv/6I1YwS6IJcwaOr/0efp7tn0fmgwqu+XWGg8wHHquWuvGmjAt2Sn
	+ADDxpsLj5h4lqHvnUTJKR4fzGwrSSYUvIXA9kYqJmlqpv09M2A04OiZKngvfyr6
	SwDToRx64V0yp6Pp8fmmwcc+TfPu4cMCnjEyG7YCYDq/kNmWaR2rSU9mlOJaLtYP
	v2DD3SkcgkpU1ricKi5sybtjoGqowZn3Xg9NT8bH8ak9ucIuW8QOHodd8WK8Ei9D
	exNFGvx08nTgyrlx3BhE7Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx940e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:55:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHnwIk028794;
	Thu, 18 Sep 2025 17:55:08 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fg8ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IANzitZegvA1766XVSaZtVcry/d2bKsu5kTb5HHB5tKqbtvgzn/YoN/1Q972yuXSbtzxdCq9fPaBDb3hakvPs2pisDsYBpcmCoAZfMHhXpW/jlvBWYp2O7f9d8Gd31spUb+arDwbzoe/Nd9KX81+Di4BsaRJiix5GlKffuCDnF8gChQ6Yj/iqENpK4m80jEnUT6imHLgvd5h2+RHJr9R4yzeQjmGadeume1Br6gaufVIygBwlpME8YF2b6CCgHHgVmN/JnuUpGrrsS4GGPebjRDZYjzSh1yxx5Ag7Sn65MdrjShskGDm4LRhsbSbh60Ph5OaJfza41LbUaqP0dySHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp2gcDWXcW+wmGUtmwLaqHmczq+iHE8golqEtOsK6lU=;
 b=QX58EoWofsgeHW/Dq1bAN21LpsoNIsQFZl2yDT7LNbGCQO+ss5e6DrTxqIpvSNRoxz7yEa0JneOce9PAnnlsIiBUGvm7KyCD/bBjN+H6lNNIY/0909oqOVN54JsRbK19sS61otH+vzpJcJJOdCPM/bYl9jSCE0E7ueD09+ZtHaOSaOS3fWHbE+xSBgEN5tKsEZcevHjYaXppnGX6ZUc0Obh8QbnqEgDR7nr03CzAZH7QE7ZH6CKgsH0V/D6RFtbZutT3dxr6TXBBjWU/FA6UPaV3K6wbpnTHwaQpBBhsTOErjA9HRjbX59cZQIL+Z5tVNaxGY9YYgbb1QI1ULJoOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp2gcDWXcW+wmGUtmwLaqHmczq+iHE8golqEtOsK6lU=;
 b=oDcuEXSRBse+BcfmJdfXgX8H085u/dQqW5FHLWN3ZCiehXbRk4zghStASgWp6RY0s+jXnSoBhtQjIdEaSZUqQ+3jPb5p+quadSw4d+aBnW5k2iBM8OoizrnJoOe6E8Aa/J8gxvbTnArd3L2T1IokYE4m0FLnhpOuEOd4m8CKfaY=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH3PR10MB7138.namprd10.prod.outlook.com (2603:10b6:610:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 17:55:05 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:55:05 +0000
Message-ID: <9d8fb1e9-d40c-4c00-a555-e37ac0d4f290@oracle.com>
Date: Thu, 18 Sep 2025 13:55:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] nfs/localio: add tracepoints for misaligned DIO
 READ and WRITE support
To: Mike Snitzer <snitzer@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-7-snitzer@kernel.org>
 <23118649-3dc6-443b-beb7-9360199e93e3@oracle.com>
 <aMxFhX-jHnfv1F24@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aMxFhX-jHnfv1F24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::27) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH3PR10MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d515b9d-049f-4488-3de0-08ddf6dc7fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUQ4Z0tOU052RkV5bytDTll5TG4xcDB0czZhcHlzZHB2aWlheGhPcDVtN1hl?=
 =?utf-8?B?bERrTzdGVEJYcFpjckZjTitCU3R1ZVlHMmZhSTNtY2JHMXVOZFdMa2Izd1JP?=
 =?utf-8?B?aStjNDh2NzR3bysraHFybnZOdUU1UmNNVC9sUC8zM2pzL2xuUnJaaUlNYVNn?=
 =?utf-8?B?eXdaT3RZbDBNQ096ZWg3TllZS1JhRU5NbkFlVU0vWWxyU0tZUG4ybUFuQ04x?=
 =?utf-8?B?YThVL0YwbCt0WGdGeDArVzltRnNPdWZsb1RLaDN2R09OQ1VWWmZuTkFMZlJK?=
 =?utf-8?B?UGgxZWhDQVdwOHBxN2ZqWWl6VkFwWEdMdGI3MTJKWUJVUEZpK3lyUDE2MUJh?=
 =?utf-8?B?K1luL0Q4RW11Q3I1cU51emx6UThwVjRURHdYRXUrTEVNenY2a0VQY04vaVpS?=
 =?utf-8?B?SGpnVmc0c2lhZXNIbHQwaS91K09JSEdSWDc5YWpXVkxFaVpPSm0yQmdmUU15?=
 =?utf-8?B?ZjVyZDJOMytnQnNSNitzZkpPcG1Ib3czbFN6TUpKM09mcTJkYTZzdG8zWWdS?=
 =?utf-8?B?bDNHZXVkTERHQ1FUdktZTW5TOUVwRG50VWdoc1ZQQ0JlNGtadDRSamZWaTVX?=
 =?utf-8?B?RVZ5VDcyOTRWTzRZK1VBU0tRdkUyK0tIektsMzNVa2tBUjV0UElTZXdoMkx6?=
 =?utf-8?B?c2hxdG9HaU1yQ0xkam11YytJYXFnRHRuemI1RHU4M1EwZ1ZUaklzdDBDTWky?=
 =?utf-8?B?bXdPcWNhOFBQZG9NMmRWT0pvazZSa1pJcEVBc3pIZ3JjMlJheXZvWU1RdVBh?=
 =?utf-8?B?NnBGRjdpaFByOUJua0laa3BZV01GaFhFQ3BkOFlJcnJSZUpDVnB2MjVMNFFy?=
 =?utf-8?B?NDZjMFF4Mi9mTEl2R2NTcmhqRlZVL1UvRy83N01LQW5nWTZtY3RQREZJalpM?=
 =?utf-8?B?T2lRVTRtR21YTG9iZFN0OFI4SUxKS0t6dmI2Slpmb1IvVzVUUnZwNXBkRmF4?=
 =?utf-8?B?dDE2Y0J2WW0zdDZkTzduSnhmYjVpc2h5Y2ZzL1lTbzk3dk55ODQxc2x4Uk5P?=
 =?utf-8?B?SE5yQS9TWkN0YS9wSE1ZQVl5WFNub0JBRVZLZjJwR2lHNG9QdTBEd3o4MUw5?=
 =?utf-8?B?cUdnTzBCMisyQkQwS0syeGdIeVdPby9VTGxsWUdSSncyT2JiVk45eSttNXZs?=
 =?utf-8?B?VC9wb0pQanZyMEFqakxUR0JQYnR3YzQ0SWJXQnpBMFNGMHRBK3JiRDQ2WnFF?=
 =?utf-8?B?Mm4rSDQvL01SVXA3V213QTIwZW5CT0Jqa0NrZTRwUE1QSkh0VFpIVVdwWXpF?=
 =?utf-8?B?a2FZWGpWSWdQQXh1QlRCTjBEdFFUeVhxak82aWEyd0F3Ynk3SUlJcW9Vcm5h?=
 =?utf-8?B?R3o5QXVUTjlZU1RBNHFybnlFeFhYdGUrNWNCdWxJZ25tazFTWC9DSTBtbXVo?=
 =?utf-8?B?T2RYNy8xbE0vRnhGajRBb0EwQmUrSFZnNVV5WUY4K1VNbEUxMWRVY0VucnZM?=
 =?utf-8?B?Sm9zb1VwVTJNdkhCNFJ6SW8yZms2cnYrblZEV2lFREtvcjV2M0IxbXpBayt2?=
 =?utf-8?B?dTJYdzBQaWdRK2FMVnI3N1ZPRmNqWXVISVZ1OXcvUVBaZGI2L1lHYU4reGJi?=
 =?utf-8?B?TXN5MUt3eHluSlB1dVJFVGhoTUJWSHVNSGsxOUJxZjNOczdFbEZ3L2dpalFr?=
 =?utf-8?B?MlJsdTdHcDBWNWdzOGZYbmZUMHlSTjk0VFZRcmFGaXdkczB4TjE3anQ2d1pa?=
 =?utf-8?B?STI2Zisrbmo0dlRmc1VYYVgvQ2ZqSmlLdFlCZzVnLzFYWFR3QldNTXdEL2Ji?=
 =?utf-8?B?ZTlDVFVlVCtaUUQ1SmUveE9BQ2k2R2VHbDlZWE1SWG5ZbHpOak5nMENOclkz?=
 =?utf-8?Q?/Y31AemHow5KQgWCJgXxNO2aAXNLknv+plrXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzRrb0xZOGdDT2JidXdnY3lLaFRZODZnYXVsc1NmTjNmK0hFNGgrQVpiMDND?=
 =?utf-8?B?aFZOQ2UzaHIwUXl0QzZLdmE2TWlZQm5lRnI4OFd4UGllWkQ5RWt2bmExMmRy?=
 =?utf-8?B?WFI1Z0NMeEp3dWxsWkRyRUNEc2s1M2Y1OVIrdWNwNGZ5WUt5U09GdTRobnlT?=
 =?utf-8?B?Q3BYMzg4VEg5NlkvWnREcitHZVBidVR1cHVSRjRxdDlZcmRlS2Rvc0NQalZr?=
 =?utf-8?B?Q1hjR1VlSy83dGVWdHJ4Ni9ZWG12bXBCNXRoOXRNS0V0eTZLdmtkeTJIU0dm?=
 =?utf-8?B?dEZ6M2hZKzVxa1B5UW9PZnUwdW5IVWN0dFB0KzR5Ty8yaUNiNm9YMlZBOXRT?=
 =?utf-8?B?UXRPMmIwV3ZzVlJGUTRkelg2cCtDYWFMbkhPaFd3bFZLbzZHT3RMcy93c3gy?=
 =?utf-8?B?UTY3QUN2RUcrRzhjaHNnWDByeWoySitxbGtiSDNJNG14dUsyUFpzZEQxZlVW?=
 =?utf-8?B?UVNIZjhqalNNU0xGcUdtQTRveko2Z2VLemRDMHZrb05aRmU5VEhuaEdqYXBl?=
 =?utf-8?B?NnVkNTc2bTNxS3hrWmJzeDN5M1VPbU8vUDRCU1ljMU9PS0VFQzM5N0lWS05p?=
 =?utf-8?B?ZDY3TlM0NTRtalZpQXQzMys2K280Rk9mT3g4dTlTeWI1VmZrL012Nm5uLzVH?=
 =?utf-8?B?dlZuYVJTNVVsN240Z1liVmFPWm5tK0QvekJYMWt4bmw4cjEzTlFrR05GOU1n?=
 =?utf-8?B?VGdyMVpXcERDdkxDYS9EY1RvZ2Z3dXh5RVlva3RaMlVQSTdTQVpvWnY4cEZQ?=
 =?utf-8?B?QnlkUE11Y0l4dDU3ejNNU3V4NzVGcmtuZTU5L0R0WHJ5VlhxTzM1cTdOcnFa?=
 =?utf-8?B?THYzUVhvTnc2RDlKemF3SW91cG5sTm5aNnROZnB5bDRxZDNvdFljblpsWFpP?=
 =?utf-8?B?WU02dkJWU0pHSXQ3VjR4M1NGNXFldFV1L2U5U08yL0RvWUJ1eTF5K1MwM3NF?=
 =?utf-8?B?QVpzZjBpNGl2bU43QzNJdXNud0JIS09TcGxjVk5pY0pLRWt3OW9pVXYvRi8v?=
 =?utf-8?B?YzdGYTlNdkxOVXBSbUhsZDVBRVpsSmRtREdwK0JnS3kvbkE0VGJRajNEWkdN?=
 =?utf-8?B?VThZbktCSFVqSHdIcDNtMVhBV3hFNmhGYmkzaUhhQ254eUVQT3B3cDRPVUpP?=
 =?utf-8?B?ajkzRkpyWmVIMlFiWGpTYTNJdU9XaGpsR0d5dWdSYWxaMmc3QTZXZ094dW85?=
 =?utf-8?B?V1A1bWZyOUtUd3Z3QjJoczg1WjJwano2bXBRbUtJdEhvcUZoSFdYajRpVTNX?=
 =?utf-8?B?NWo1WkJCSGx2cVA4ZEoxYVY5ZTQ3RHhNRlRycVdnNU9hclRjNFo1UDNPUVhj?=
 =?utf-8?B?aDdJa2xQK1ppRGpMTXFnVFJuR0pHUmNCYkg4T2RVb3ZncGFsTERGNnlFejYw?=
 =?utf-8?B?VlJSbFBuNnl4OXBaMnFQcjJRbFdGbmpOZ0lLTUFoMjNyM1dqNnZwdjBwQ3k3?=
 =?utf-8?B?aCtRYWp3NUQyemxNTUpyYjZaTG9FRmRsSGcyNzA2NWY2MFczTU5Hd3IzSFI1?=
 =?utf-8?B?eVlQZlBxOUkzYXBuazFXa3BwUWNwQ0RockJhUFloeXRtMlg5Ukg5K3ZoOWtS?=
 =?utf-8?B?cmZRK0FnUWQ2a0dXcStGM0t0YlZJSXlRL3o1VzI1ZjdHcW1NRFFld0twbWh3?=
 =?utf-8?B?Q1BNT2ZVTWV2NWpkeVMyQ3hoU1FCOHpENDBYZkFNNExRTzNOWnc1U2k1V2gz?=
 =?utf-8?B?RFVGSHh0YTRXeDhPNUNPSFZVNDgwQWQ1R25uYWczOG9vUkVYdU1RbzFKUXBu?=
 =?utf-8?B?aXExY29tYmhlMjY0ZU9HQTNCckZKMTdLR2hya1JXcStRV3N2L3dyN3RxSkR4?=
 =?utf-8?B?cjNaZTZ0QXNIa243V0R4eVlNaHFWMkdXc3pPb2U3SDVLeXJ1SjZNQ3RXVm11?=
 =?utf-8?B?Sm15UzBhK3hWdTVIQVVtZ2ZKY0p2cllxeGxNRnZ1ZjNPZ1lNMXFwaTgrZVJZ?=
 =?utf-8?B?TUZMSVU4MmVZRDVhclpJblJRTDNsNEkzd1RqTFd0L1UwMTVaVWtUeHRMRnd0?=
 =?utf-8?B?YUtRZGFjdnZmakhYR1lsSWFXbWxrQkkwNFBmNGliUUZ3WitXWkpRL0d5ZGhz?=
 =?utf-8?B?NDE1cWJnL2hqaDNKNkczUncvRTFTQnVmbE9nQTZlcUhHL0duRDdJVTljRDJ3?=
 =?utf-8?B?ZjBndEZDT0RNSktKdUhvRkU4NjlZUFk5c0xuT3N5OHlDL0xOV2NqSVY4NHFD?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KRVK19rIM5qy3RN9Mmqs1vUhyq2VJvInIcULPifcUXy+5IRen2WD43tqeuQoTMPDuiEwy++DHueHGBeis+q5zlrYNsQvT6FKDDfgM5NY9igFmLydhK57DrY31C7IbVhySG3w+/9pWX5FW+Zra7l45hPrZeV44VTrrVtJN7yht496j3e7Ln5TA09POaKhQCsWf+x+WUAsR3p185u2g2QolN3AdiV1JirykVihBMwH7vwdHVKGo+L/0fh7UY7XtF07A5+rja1q6NBOfKbRZ59K5atbj7PuCDTtVfNfFxUf1YH5muwqiku37s0DirHkVgvBPpGkXP4fp+bqBaqEhST7c9WlORbTRcWekT2Tu2bQ0i8uuGX9NvvqSKo/zZbHQs7ZmtEscVIIs9LPx6Ye6Sh7eg3JyWIX7+PlZuNli8I5VLyE7eHeIPJKXRbqnb7cu85AV3Rvk54bTcFbjj1UcUNda7t3I1/aOEkvcsfQteAHu9HJjyC0RGlDi//q/6zbUW5FwXm4dK7hLD2xys9oPHH64/O/I126DriAt2RJ6KmUYh2MlVkvOhvH6Vzyjtuvfs5L6v1l/TIQodv/zbn8IeitJK9ZKkOiyazK+Ek5csBncto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d515b9d-049f-4488-3de0-08ddf6dc7fda
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:55:05.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdBf7YkzdWM7f+OQPXvPlI8Ee/4PPsXnVPZQZL56ksk1dtp5gblYKZE4klbR+8pq4SXU2GUUyVr1yEOHmZV1aOrdaymL3fTbOxuIdotJjYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180158
X-Proofpoint-ORIG-GUID: wQWkiiPdKOsk2z85AsqirJZrISJNHaPP
X-Proofpoint-GUID: wQWkiiPdKOsk2z85AsqirJZrISJNHaPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5uHx/XK5Zz8b
 lhEdUTGPpJ03PQxLYUf+796kVoQg0ztnTjmDG+iRrHuPuQvrgFGAK14vmfQVqKOI4Xfy+uNSobs
 pFr0hPI+YOo0P5gy08AH9XqvQcDWNsjWQXL3FZkaPWdKjlnOSTbF+EZ5atzlJxqNy0T+yqvfUia
 KQVyqXl666Sopmer1jw9aI/Bql3gL2cfDpvrIKHhcA8kqOWV2WNZTgp7KPd7E5SAnkKBc3ncJz0
 oESypyLV5IwYdOC1HOjwfNyVYVde2WGgKfDeARw2h44IJCr1ZPhd4DqXIL75j8zDXGMn+31Ypi4
 eGFr0Uv1ktKN+wV3EDXpmHi2ki9BwhNEVoFXDklQA7KBe4zna6ZXrJxygYBVOWRxp4hG6I0L8Ai
 n151JFb7
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cc477d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=P6JkxrBpAAAA:8
 a=ELpnLdM56Eintand2LgA:9 a=QEXdDO2ut3YA:10 a=dwOG0T2NmQ8MtARghG3a:22



On 9/18/25 1:46 PM, Mike Snitzer wrote:
> On Thu, Sep 18, 2025 at 01:33:30PM -0400, Anna Schumaker wrote:
>> Hi Mike,
>>
>> On 9/17/25 2:18 PM, Mike Snitzer wrote:
>>> Add nfs_local_dio_class and use it to create nfs_local_dio_read,
>>> nfs_local_dio_write and nfs_local_dio_misaligned trace events.
>>>
>>> These trace events show how NFS LOCALIO splits a given misaligned
>>> IO into a mix of misaligned head and/or tail extents and a DIO-aligned
>>> middle extent.  The misaligned head and/or tail extents are issued
>>> using buffered IO and the DIO-aligned middle is issued using O_DIRECT.
>>>
>>> This combination of trace events is useful for LOCALIO DIO READs:
>>>
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_read/enable
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
>>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>>>
>>> This combination of trace events is useful for LOCALIO DIO WRITEs:
>>>
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_write/enable
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
>>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
>>
>> I'm having a lot of trouble compiling this patch. I'm seeing errors like this:
>>
>>
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
>>       | ^
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>       |                               ^
>> fs/nfs/nfstrace.h:1800:1: error: incompatible pointer types passing 'const struct nfs_local_dio *' to parameter of type 'const struct nfs_local_dio *' [-Werror,-Wincompatible-pointer-types]
>>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
>>
>>
>> Am I missing a patch somewhere along the line?
>>
>> Thanks,
>> Anna
>>
>>>
>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>> ---
>>>  fs/nfs/internal.h | 10 +++++++
>>>  fs/nfs/localio.c  | 19 ++++++-------
>>>  fs/nfs/nfs3xdr.c  |  2 +-
>>>  fs/nfs/nfstrace.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 89 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>>> index d44233cfd7949..3d380c45b5ef3 100644
>>> --- a/fs/nfs/internal.h
>>> +++ b/fs/nfs/internal.h
>>> @@ -456,6 +456,16 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
>>>  
>>>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>  /* localio.c */
>>> +struct nfs_local_dio {
>>> +	u32 mem_align;
>>> +	u32 offset_align;
>>> +	loff_t middle_offset;
>>> +	loff_t end_offset;
>>> +	ssize_t	start_len;	/* Length for misaligned first extent */
>>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>> +	ssize_t	end_len;	/* Length for misaligned last extent */
>>> +};
>>> +
>>>  extern void nfs_local_probe_async(struct nfs_client *);
>>>  extern void nfs_local_probe_async_work(struct work_struct *);
>>>  extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
>>> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
>>> index 768af570183af..cf1533759646e 100644
>>> --- a/fs/nfs/localio.c
>>> +++ b/fs/nfs/localio.c
>>> @@ -322,16 +322,6 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>>>  	return iocb;
>>>  }
>>>  
>>> -struct nfs_local_dio {
>>> -	u32 mem_align;
>>> -	u32 offset_align;
>>> -	loff_t middle_offset;
>>> -	loff_t end_offset;
>>> -	ssize_t	start_len;	/* Length for misaligned first extent */
>>> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>> -	ssize_t	end_len;	/* Length for misaligned last extent */
>>> -};
>>> -
>>>  static bool
>>>  nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>>>  			  size_t len, struct nfs_local_dio *local_dio)
>>> @@ -367,6 +357,10 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>>>  	local_dio->middle_len = middle_end - start_end;
>>>  	local_dio->end_len = orig_end - middle_end;
>>>  
>>> +	if (rw == ITER_DEST)
>>> +		trace_nfs_local_dio_read(hdr->inode, offset, len, local_dio);
>>> +	else
>>> +		trace_nfs_local_dio_write(hdr->inode, offset, len, local_dio);
>>>  	return true;
>>>  }
>>>  
>>> @@ -446,8 +440,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
>>>  		nfs_iov_iter_aligned_bvec(&iters[n_iters],
>>>  			local_dio->mem_align-1, local_dio->offset_align-1);
>>>  
>>> -	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
>>> +	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
>>> +		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
>>> +			iocb->hdr->args.offset, len, local_dio);
>>>  		return 0; /* no DIO-aligned IO possible */
>>> +	}
>>>  	++n_iters;
>>>  
>>>  	iocb->n_iters = n_iters;
>>> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
>>> index 4ae01c10b7e28..e17d729084125 100644
>>> --- a/fs/nfs/nfs3xdr.c
>>> +++ b/fs/nfs/nfs3xdr.c
>>> @@ -23,8 +23,8 @@
>>>  #include <linux/nfsacl.h>
>>>  #include <linux/nfs_common.h>
>>>  
>>> -#include "nfstrace.h"
>>>  #include "internal.h"
>>> +#include "nfstrace.h"
>>>  
>>>  #define NFSDBG_FACILITY		NFSDBG_XDR
>>>  
> 
> This change ^ was critical for fixing unknown type issues for 'struct
> nfs_local_dio' issues on my build. But I haven't seen the issue you've
> reported above. I'll try applying my changes on very latest upstream
> tree.
> 
> Which tree/branch are you using for your baseline?  Also, which
> version of gcc (which distro even) are you using?

I'm using my linux-next branch from: git.linux-nfs.org/projects/anna/linux-nfs.git.
It's v6.17-rc6 plus the patches I'm planning for the next merge window.

Anna

> 
> (I even tried including "internal.h" directly in "nfstrace.h" but that
> caused all sorts of different compiler issues). 
> 
> Thanks,
> Mike


