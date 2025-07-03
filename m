Return-Path: <linux-nfs+bounces-12881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E7AF81C1
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749821CA13BC
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECA29B208;
	Thu,  3 Jul 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcfVVEFp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkOehAKO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625929346E;
	Thu,  3 Jul 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751573288; cv=fail; b=O937zFjYE9kqobFa+dO6ZYW7yZlLgvlIq1qModm2y18v1Ofbx+KZIbcnFI6JpvKB4ATuBJVb9tyiNpvgqyoDytyFS/cTy1kmCC1rdCtZ4ovaH55euEvwKuHrWAthRSUMk4xN7Q9cEGHSGsee30SYH1cYsPW3679gzmRZ50I3oMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751573288; c=relaxed/simple;
	bh=ZFNXNiEvDR9ZW09kDqDY8z5ydoIkpnHEqiiup99iaCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQaKrSVAT4ddmfivgsefnZ9sJ+5e6aO7va+/5lyeu9+8Su30vdA/+DJrK3ZDy1fdhbkipsP6q4O4vHK7ZqbjYh5tSXmULGhw8dv8mQAZ1QqjFjsZA+ERfzz8Ki9A0ZyHv7fx0MRf1RvZIPKZ0o9xvu2pJ6lvkoaKcl36FdLhTIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OcfVVEFp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkOehAKO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563HZ7or001305;
	Thu, 3 Jul 2025 20:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8mBFfRUzCYIo523JrzaY0pZohsTrAgBs/V8ZBSkiZE8=; b=
	OcfVVEFp0w6FbT7E1BeEa7ZMs30j3mFfW9lbI/b57wc/6lGnwlx+2QBekqZAzYL2
	ZbC1BFqvxvtF+XzX+HFM3f4/NN0zByHDprrZxvSoh6XxC8B5s0CyS5D1Qc1h2QDV
	+WSbJ1cKH3oStiBPTD705galI5XNMI7R1DqnSeOJunkcpqk43CnNJKzcLdkpZFFk
	3ZxZO4lbuQS6iemcPXHAPpdIR7GwRotMw379beoisG1iDapaMxvqe4jkDyJl2z9D
	En+XlESQJLaFx9TlIdOEkx9QrNrGRUqzllJaktXHOpUBAwIgBfMbLAVTSz0ik5Us
	WoP3ACRsKyLhueZIQmDwNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af9qyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 20:07:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563JEOhN032567;
	Thu, 3 Jul 2025 20:07:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6umbrae-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 20:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huT3lt5DXIDLaYrbeLxYLuHBSE/jN0OM3ItogNTMQWAetXgFEJNTJ531khBF9Zb5xcyBozv0NFqKMV0noD5F7RDQ0saofcAK3AqPtd+943Z7tmq34FkWssa7ZDimxmXLR+uNN/LewowK2bZGyUQF9BiHEn0UQSLocQl0Rv2r6uyLEGAIIfpijgqG2dWNwTdAbNrNduKq6ClWD8874DY44YL7KbJx1dnAQ3/6kiNE7tqCqqFjpMxtoxpaODdbEd18+8GoUt2iRg2oP7sgbiJjUpzrngfylzU62Z4SDItmuSYQxvgsfB+9MhVt71W3RxV3aq4wvz0m+h/klJQC9Frd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mBFfRUzCYIo523JrzaY0pZohsTrAgBs/V8ZBSkiZE8=;
 b=SXl0ArpWuTiq5wa5u8NEYdhItN9Q2X8XaohINP+NSaITw6vWPwRkgww96d4oodBeVI2m/y7LwXZ3POVxsYJBHXuISGOPl6UOCpKa4ZQfzgyX4qKCyF3u5Xoxjl0bsxN6KHk6eSNdZRETMLYvHhFdQ5BLwcj+bsuRJ+FoA5SEJfA2hWWf1L2ffJMwMWnEuvqXYAimTqGbQCGe6gETttC8eicL/UjPPnaJP/naYX4WPSHgy7whVZaNXZ6TUDOWnvWe+SvIpXDYbgbay/ueK8yfZhFxV83vo27JfxYkCebgTIYIcPzsPM4msvCj8AiBNZPsU30Pzicm7rPNHOuFugpEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mBFfRUzCYIo523JrzaY0pZohsTrAgBs/V8ZBSkiZE8=;
 b=EkOehAKOxEgNlm+5DmsCH9c4H6xafIcAUlLVVCBqv78pFiHUQIwOU8pY10iwfTiuCdEbsd9GYqStGEFknW3UYk8R1V24gU6Ujc2K0Br1c/WC68TZLQ73e0wl7KLsGHVKVTYdvXBbS577Xtj3s1NmKuEdw2ohoav8pufeCAUfigg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8047.namprd10.prod.outlook.com (2603:10b6:208:4f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 3 Jul
 2025 20:07:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 20:07:53 +0000
Message-ID: <520bd301-4526-4364-bbfa-5f591ab8f60a@oracle.com>
Date: Thu, 3 Jul 2025 16:07:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ, stable
 WRITE or COMMIT
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
 <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: af538535-9ec5-4213-7666-08ddba6d4b64
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?alRPZFRWOGdLRU9CWHhsWTdydDdLZjFpSDMwK2VHVzc5YTVSTDZ4ZUl4TTJ6?=
 =?utf-8?B?VnM3aVdQOUwwYWxlaFhxSG5NbkQ1OEU0V3NBTEpvb1NEQUdWaEs5TDVDUk5L?=
 =?utf-8?B?eDlVOFpxeW01SmxsU2NlY1pRN25NbW5yZ3hVT0kySG44QXM3d2gzVVRkbzho?=
 =?utf-8?B?TFVPRFlTSVg1UkFSOGgyZjNsOXJDV244MS8yeDR3TUd0bEdUbTVTd0hCdXVv?=
 =?utf-8?B?c1FUMnZkVFN6QkxoQ2hTdWgyek50UUd4dzdHUFI4YWwvZDVpYk44ZkZEaGpt?=
 =?utf-8?B?TzRDcHZvOGwrNGhDU2xQVGpPdnoyM01uYVFHOU9lWGFUakdXNFhCOHJ6VVRz?=
 =?utf-8?B?VnZrcklpaXpaUnRPaVkzRXJzSkJqU3RwVnpaOFc1U1F0Y0lISmRDb2pLTTYz?=
 =?utf-8?B?VFVLQ1gxNm93OVRnUmU1dlFSVStWcHQzVEt3NUY1UzdhMi9iRndocHRyRVI1?=
 =?utf-8?B?WkJCaUV5WkRFWEV0aHBKb1hWbjdYWVRZSGE1clZSbDRLcmpPRS8xL3JwNlRM?=
 =?utf-8?B?SzR3dE1NWTJQcUFhYUt4bTN0aFNldWozL3g1clhjWmQrQnVZZk1uT3FTL3B1?=
 =?utf-8?B?RHpUdmdGcUt6enkySCtyUWp2SGg0Wm0waUNtR1B6VFVEOERZZ1EzOWpucGJU?=
 =?utf-8?B?aktrbkMwdVBLWlhyaWtZay90ZXEzUEg5UW0yUnF3VlI1OVphYS9XZ1hiMlJI?=
 =?utf-8?B?ZjFuaCtZU3ZUamhpTy9sWWZyRCtFaU1ZeE5JRkpSd0J2NWZGL1drQ1N0ZWoz?=
 =?utf-8?B?S0xHTnpDUEZESXlPd0pqWDJDVjd1akJBbkhOZUV0WEVXdzBnVnA5MndWMzJV?=
 =?utf-8?B?RDU0b2hackJOUW1aQzBlekNLQ1V6RzNtbTd3SlJGd0V4Z1E1V0YrTUErNFNS?=
 =?utf-8?B?WHpRNWJIWVZNVnM5MkF1RVI5bEdNYzgzRVBBZUtOcnVheHpsbEttZTRsSjFq?=
 =?utf-8?B?dUVkUmlheCtJN3pDNVFGZWd1SjZFc2NhTVVTODhCWE5CL3NqZlJwQUR2TnR6?=
 =?utf-8?B?YXlkeHRMVjFnR1lrUGpNTmkvNEtIMHFHZTlIUkd3anlXa3EvM2tNMzZBY0M0?=
 =?utf-8?B?YnJJNWdTZC94dE81R25Jd2hBaGsxUWFxNTFEWGFCNC9ucW9GbjdJWENSMzJw?=
 =?utf-8?B?SlpYeUtQU3FZaXdxMWJRUmpqQ1MzQmk4UG55NVFzbkRFZUo4RHI4ekI3SFly?=
 =?utf-8?B?eVk4cGRwdmJSTFNuSE5KTnR2Sis3ZDZJQU1RV3A4bnNKR1plc2VSZ2o5OVli?=
 =?utf-8?B?Tzhmb3FvNkErRElmS3lQdkg0Nm52MTc3eEFOREdBdGNUZzFuOXpFMHg4c3Vq?=
 =?utf-8?B?c3BBUkNVQm43bklxVEJQT0RIUHlkdVcwMWVsV2Z0NmVta1V1aEFmSVp4dWZh?=
 =?utf-8?B?c0F5czF3eThjcmFQSXlRaFkxeUx4NmNLOVllMTU1M0xSRWZQN3o5R3hGR0RT?=
 =?utf-8?B?TG1ySmhFNzNGay9CenFTTzgxc3lTRmpFLzM3QS9IOFAxNElJdkVCVkk0bW1X?=
 =?utf-8?B?Y2x6a2s5OVJlYkpFM3prMG15d3p3VmRrMGlPZWM4OENGZ09xeUdzbWpkZDlr?=
 =?utf-8?B?UFVWakJWMWZNYjhmL2lvY1l1MTdnNFphbGV1WUg2WG5oZEJ6cm85N1VheXZH?=
 =?utf-8?B?TEwwdHdYdUNIZThKaDhxK1ozdm1uVmQ0MmQ1cW1SblJVeVNiTnN5SElYNnha?=
 =?utf-8?B?WTlZdllQVExMS3lmZlh5QWNBeXk5cDUwbWM3MkQ4YUpKV0tsbmZHbjc3dG9k?=
 =?utf-8?B?R1lDenA3M2VCUXMvQndqQWd0TCsvL01xN2VYUjJHUEcvNFVtM1FPNUVFWU85?=
 =?utf-8?B?eWJLRWI4em5DL3lQcm5nN3lDUm5qUWJwZk9PemhzaFFLNVQ2blZ5RkUxSTFq?=
 =?utf-8?B?a3JFamFrNTRuWEsxdDJhYXBhUy9rZzlDVlNqalF6d2poSHo1WkVYRGR3WUVl?=
 =?utf-8?Q?1ow42e+VX8Q=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z0EzdGJZVmdxTk1vRS81cTZXeFhEVU40NkkzWHBEUGZYalE0Nk4zSHhWSUQr?=
 =?utf-8?B?QzdNQ0dpb1FEdVh1UDJtblo5eHhCbGpUMHFlWjUwbVltV3BHWW1jd0FNRWUr?=
 =?utf-8?B?RU4rdTJ1SDVrd3BXUk9GK2kwUkkwZzh6OWtCRW5VaWVrQ3pqdVk0Zy9URngx?=
 =?utf-8?B?STBrZFFsRW1HUW1JaTU3K20xMlVMaTRNS2srOTVTTGVpeThkYzErOHVHTTFj?=
 =?utf-8?B?MEFTUHhGS3poRitWZE1JQ3RnanFNYkRSeDBhZ0lJdzBqNmwwQStETU43MkRH?=
 =?utf-8?B?cVJEdnFValp5ckw2ZFZDZWpkSTVwS1JySVBwL0ZnMWU5L1VhNWd2SUJuTTZt?=
 =?utf-8?B?RWY0M2lpamdvNUNqcE51RlNobXlod052TWpBYUpXTlhiVytQSU5Icm5zQU9H?=
 =?utf-8?B?K2Vtak4yWlZ4MmlBV0VzK0t0OTdaTzFVMW9yaFgwNTdSN0FIVGozZWl4QmNV?=
 =?utf-8?B?eGhkUjFCbmRzYWNBRVo0bzl2MW5MTlp6akV4TFV3RDZqZ1pzc0lhcXJ5TWJi?=
 =?utf-8?B?QW5BeGdxcG11TmNDRFZBa2tieFh0akx6aFBlZENuRXBKNE1pOEp0U2pmVm9N?=
 =?utf-8?B?akJmcGY1NmVIMlNzQnhWRXpQdG1JNmNPa3YyZVZmbDNFZ1JHaGtiYlEvcC9G?=
 =?utf-8?B?QW1iSldCUnlzaHVlMk5hTnpOOGVkbFZQeUMyTEFaMklKaVd3em1PTHQxdExM?=
 =?utf-8?B?cVMzQ3hBcnp6TEdLL1ovQmQwZVRBcWhlSm41QUpvd2t5MnZGeDlJQ0F0UDZO?=
 =?utf-8?B?UlRPVWJEVmthUnl2MnpJbnBSVTBvMEJ5Y1dEVmFYbGFRem5naENueWlBVXhZ?=
 =?utf-8?B?Y3NBZzJzQTJGUUNGYnRjZVNrU09MdUJhU0ZKaUhMVENIQzZUYysxSzRVZjFp?=
 =?utf-8?B?dnpHMWRaWkplV284VGNYemNvNVlFV0ZnMkhDRllLZDZTUUM2V1Nab2E5Z3pw?=
 =?utf-8?B?ODltSDF3TDVJSnRSTSt3NVJoZkNBWmY4YkdLQ2JjVmN6Vm1yZVdST0RiNTZK?=
 =?utf-8?B?OGFnbWlGM0JodnFtYVlMRFFxbEk0OFY4TXg5T2w4VkpiY240amZOV2lHWWsy?=
 =?utf-8?B?QlNYQXB1Ums0SU1WeTFzSlFPd2poeEFpM2ljbXdnWGtLMXQ4TFI5ZnJlaHBB?=
 =?utf-8?B?R3RyVStUUC9DSUNEZFhERkhSRnVWSFpqTnRNK0dURExrWDNqc2dPbVVLUS9n?=
 =?utf-8?B?SS9OMko4ZDRjZE1wbzRvQ3lUeDh4UEw2TVdDYnQ1Vi9na01iWC84Y0dJKzVV?=
 =?utf-8?B?dU1heWJaV3A4N2U0c29tNWsza3g0NFZySUFna0w0TFVKVjljai9iNk1Wd29P?=
 =?utf-8?B?ZWlPTUlTSEJ4R2pqeFlmUkZWTHFLVnhZMndXWFNuL3NraUpUM1hrdzJLV2hY?=
 =?utf-8?B?ZTZtaVBwUExtalhUY1NYRXh4Q0RVL3Btb1p3ZUFlM0pZQTdLNlR1ZllQZzg5?=
 =?utf-8?B?RWh6YnF3Q3NqVE43TzNDTmgwd0d6c0JJR0ZuRWFPQndKWWdyMEVXbEw1ZGpt?=
 =?utf-8?B?R0dhM0haSXlUd2Y4eGx3b01wWFZwdlBBVHR5cjhLWS81SksrWFpSbVQwUkZi?=
 =?utf-8?B?M3ZFTFJNMjRNSk1DNXZjL1dBOE1oZllNUVBiVWIyYUI2YWhlLzBGSXhrajNN?=
 =?utf-8?B?a1NTbHg1MU5RY3JGQ3BDUzVqbU1FclV5bHNDT0o0U1E3eEpNZXlDTDNJaDR5?=
 =?utf-8?B?Q2pIaGUrcU54Qm11aXpoLzNlbFo4STRwRUovVXpXNlVPVGh0WkFKTVYrbmI4?=
 =?utf-8?B?VHEzUDI0eEt3cGtueWtYYnZhUXZHYzJYbFY3c2RrcG5Id3RzdDBvV3p5Mi81?=
 =?utf-8?B?Rm0rRzFEYS9OeVRGWkZraFhyckozWnh3b1kwbWZleXAvRld4VlNJaWdWZzBl?=
 =?utf-8?B?NHB0U2pRTE54TmNJeGNUTTNOWXJoOUZRNWh3dHdlZG1vREJKTTVpWmhIU253?=
 =?utf-8?B?SFNyY0xRR2lFRXNscXRYeWtxUWNwWHMvMTZKWmMvU29pZW9tTnhKemRJeXlT?=
 =?utf-8?B?WkZCcWQ1N05Kc20rTTJxelpxSXQyN3ZndHlCWUIvdkppQ2dPMGZEdmZDNkl0?=
 =?utf-8?B?N21aVG44alJSM1VxOU1KdE1FdnZtejBlRHIxSnhmZ3pYcEpEU2FqckhTWjhE?=
 =?utf-8?Q?QkpKLnbxk6keU4MTVusSN0WK6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uR79P4krFPqeW73X02vpYLAixGxZYxUSX5TI/zOMoAXogUp5erCk+C1vI7LHnMJV0glZ9kFKEz53boegpDnuRCxtFty8ulnJ4XVU07+jZixKM9f7lu+SU1mpBzjMgmk92pptF4/xQV4JkC71ZwgSbOufBysKqLTjXQhirlm78P3DQNOvFwa/7WM683s92ROhJRr8dFg50oEfff+2Z6aNFKK4cQcpAH7NxhVZmxTSvu3lcdQAr0DcEfwJUmy7N6vTKTOjVlJClTFEsf7b5jQgHO1NqLzMNCuHrZ+cqgsTpxQAF/YG7UJGWRH98aym2nDBqqDys54lKD2L9em/ReBkwmWyHYw9qVseo2JFuwHoE/JhFVhJopa6cV2zDZ7oi4GE2zkkysez466fBepX6uEOJKg7Q5F7rfJwyDxd/StTNZ4zpfYcafVnM79PuRN+y0r16oP6ozuqCRuiOwipc9xVxImHBVLjywiw8mQRHmc+JArkeuNcG4UAMN0fiMjOgfH8VvqKL4A0/FBzuTK6f0/g6zMRD6xxp7DxsTxzDNYvkY0Bc6dSK3J1YStTKdy9ppDsrCDF5l2x+TqdZLtIFSsiQrJNQIVmoZYteUGXua6sR3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af538535-9ec5-4213-7666-08ddba6d4b64
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 20:07:53.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LxSURYXfe72JLPfWsUEg72W5xMxyZEhI1pRa2/TEloRLiLizTS65FvVNpv+h3WI0OIw2JKoIoLOrDhwg7IQgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_05,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507030165
X-Proofpoint-ORIG-GUID: n34sUVh7k9WKXYQjhQSiZZ2mb_0RwxjN
X-Proofpoint-GUID: n34sUVh7k9WKXYQjhQSiZZ2mb_0RwxjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE2NSBTYWx0ZWRfXz+eelNpPlQ+F HDHiSvYeJip5+SriEhrc+Gd6+feFMQ0dKJkQd3zOmLVuYckOTLgFRMv0CgLEaZxx9WMU0F2q8hv 06mM7iM9ErUMRcsLZvN/JOHGOIO9j6OYfUAQggd/KBTPlS7fPHmLdw+X4YTSn3d5O7h2zvnQR4x
 nfw1WgPyQnDsBDMzQ2ypZcTT03n4F8bb+eSCdD4Y0WGwZHwXxCK8Tnho/Gl+ZNyJfzN7kUvC/UL 6n1MeQhOwsP5jNtQRlGy4y2/3AOOX8xloeE+5KkSjWM+0Q2+YMLSR+mI7Wlt5fqB9jOVaFgoHsv xDSurp7pmAmRF8fnk2jqf7J8a3UQH7dNN4pAzPQbQTFWXzZD9hmPlUXy+u36QB8aLNsj9zQyeJo
 WAhf5K8AYLZnr/CJ0z/0WVerBtzQoiLrGTYJ7BlKYqhtuDQ6pcfechFMtjuA/ZIS1D76ieXq
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6866e31d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=omVGs16SzRfYwZDEWwcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057

On 7/3/25 3:53 PM, Jeff Layton wrote:
> Recent testing has shown that keeping pagecache pages around for too
> long can be detrimental to performance with nfsd. Clients only rarely
> revisit the same data, so the pages tend to just hang around.
> 
> This patch changes the pc_release callbacks for NFSv3 READ, WRITE and
> COMMIT to call generic_fadvise(..., POSIX_FADV_DONTNEED) on the accessed
> range.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/debugfs.c  |  2 ++
>  fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---------
>  fs/nfsd/nfsd.h     |  1 +
>  fs/nfsd/nfsproc.c  |  4 ++--
>  fs/nfsd/vfs.c      | 21 ++++++++++++++-----
>  fs/nfsd/vfs.h      |  5 +++--
>  fs/nfsd/xdr3.h     |  3 +++
>  7 files changed, 77 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc90bd5c2d9d5e15c8e0682c0d610c..b007718dd959bc081166ec84e06f577a8fc2b46b 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -44,4 +44,6 @@ void nfsd_debugfs_init(void)
>  
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +	debugfs_create_bool("enable-fadvise-dontneed", 0644,
> +			    nfsd_top_dir, &nfsd_enable_fadvise_dontneed);

I prefer that this setting is folded into the new io_cache_read /
io_cache_write tune-ables that Mike's patch adds, rather than adding
a new boolean.

That might make a hybrid "DONTCACHE for READ and fadvise for WRITE"
pretty easy.


>  }
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..11261cf67ea817ec566626f08b733e09c9e121de 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -9,6 +9,7 @@
>  #include <linux/ext2_fs.h>
>  #include <linux/magic.h>
>  #include <linux/namei.h>
> +#include <linux/fadvise.h>
>  
>  #include "cache.h"
>  #include "xdr3.h"
> @@ -206,11 +207,25 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>  
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
> -				 &resp->count, &resp->eof);
> +				 &resp->count, &resp->eof, &resp->nf);
>  	resp->status = nfsd3_map_status(resp->status);
>  	return rpc_success;
>  }
>  
> +static void
> +nfsd3_release_read(struct svc_rqst *rqstp)
> +{
> +	struct nfsd3_readargs *argp = rqstp->rq_argp;
> +	struct nfsd3_readres *resp = rqstp->rq_resp;
> +
> +	if (nfsd_enable_fadvise_dontneed && resp->status == nfs_ok)
> +		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, resp->count,
> +				POSIX_FADV_DONTNEED);
> +	if (resp->nf)
> +		nfsd_file_put(resp->nf);
> +	fh_put(&resp->fh);
> +}
> +
>  /*
>   * Write data to a file
>   */
> @@ -236,12 +251,26 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  	resp->committed = argp->stable;
>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>  				  &argp->payload, &cnt,
> -				  resp->committed, resp->verf);
> +				  resp->committed, resp->verf, &resp->nf);
>  	resp->count = cnt;
>  	resp->status = nfsd3_map_status(resp->status);
>  	return rpc_success;
>  }
>  
> +static void
> +nfsd3_release_write(struct svc_rqst *rqstp)
> +{
> +	struct nfsd3_writeargs *argp = rqstp->rq_argp;
> +	struct nfsd3_writeres *resp = rqstp->rq_resp;
> +
> +	if (nfsd_enable_fadvise_dontneed && resp->status == nfs_ok && resp->committed)
> +		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, resp->count,
> +				POSIX_FADV_DONTNEED);
> +	if (resp->nf)
> +		nfsd_file_put(resp->nf);
> +	fh_put(&resp->fh);
> +}
> +
>  /*
>   * Implement NFSv3's unchecked, guarded, and exclusive CREATE
>   * semantics for regular files. Except for the created file,
> @@ -748,7 +777,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>  {
>  	struct nfsd3_commitargs *argp = rqstp->rq_argp;
>  	struct nfsd3_commitres *resp = rqstp->rq_resp;
> -	struct nfsd_file *nf;
>  
>  	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
>  				SVCFH_fmt(&argp->fh),
> @@ -757,17 +785,30 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>  
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE |
> -					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
> +					    NFSD_MAY_NOT_BREAK_LEASE, &resp->nf);
>  	if (resp->status)
>  		goto out;
> -	resp->status = nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
> +	resp->status = nfsd_commit(rqstp, &resp->fh, resp->nf, argp->offset,
>  				   argp->count, resp->verf);
> -	nfsd_file_put(nf);
>  out:
>  	resp->status = nfsd3_map_status(resp->status);
>  	return rpc_success;
>  }
>  
> +static void
> +nfsd3_release_commit(struct svc_rqst *rqstp)
> +{
> +	struct nfsd3_commitargs *argp = rqstp->rq_argp;
> +	struct nfsd3_commitres *resp = rqstp->rq_resp;
> +
> +	if (nfsd_enable_fadvise_dontneed && resp->status == nfs_ok)
> +		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, argp->count,
> +				POSIX_FADV_DONTNEED);
> +	if (resp->nf)
> +		nfsd_file_put(resp->nf);
> +	fh_put(&resp->fh);
> +}
> +
>  
>  /*
>   * NFSv3 Server procedures.
> @@ -864,7 +905,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
>  		.pc_func = nfsd3_proc_read,
>  		.pc_decode = nfs3svc_decode_readargs,
>  		.pc_encode = nfs3svc_encode_readres,
> -		.pc_release = nfs3svc_release_fhandle,
> +		.pc_release = nfsd3_release_read,
>  		.pc_argsize = sizeof(struct nfsd3_readargs),
>  		.pc_argzero = sizeof(struct nfsd3_readargs),
>  		.pc_ressize = sizeof(struct nfsd3_readres),
> @@ -876,7 +917,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
>  		.pc_func = nfsd3_proc_write,
>  		.pc_decode = nfs3svc_decode_writeargs,
>  		.pc_encode = nfs3svc_encode_writeres,
> -		.pc_release = nfs3svc_release_fhandle,
> +		.pc_release = nfsd3_release_write,
>  		.pc_argsize = sizeof(struct nfsd3_writeargs),
>  		.pc_argzero = sizeof(struct nfsd3_writeargs),
>  		.pc_ressize = sizeof(struct nfsd3_writeres),
> @@ -1039,7 +1080,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
>  		.pc_func = nfsd3_proc_commit,
>  		.pc_decode = nfs3svc_decode_commitargs,
>  		.pc_encode = nfs3svc_encode_commitres,
> -		.pc_release = nfs3svc_release_fhandle,
> +		.pc_release = nfsd3_release_commit,
>  		.pc_argsize = sizeof(struct nfsd3_commitargs),
>  		.pc_argzero = sizeof(struct nfsd3_commitargs),
>  		.pc_ressize = sizeof(struct nfsd3_commitres),
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1cd0bed57bc2f27248fd66a8efef692a5e9a390c..288904d88b9245c03eae0aa347e867037b7c85c5 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -152,6 +152,7 @@ static inline void nfsd_debugfs_exit(void) {}
>  #endif
>  
>  extern bool nfsd_disable_splice_read __read_mostly;
> +extern bool nfsd_enable_fadvise_dontneed __read_mostly;
>  
>  extern int nfsd_max_blksize;
>  
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8f71f5748c75b69f15bae5e63799842e0e8b3139..bb8f98adb3e31b10adc4694987f8f5036726bf7f 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -225,7 +225,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
>  	resp->count = argp->count;
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
> -				 &resp->count, &eof);
> +				 &resp->count, &eof, NULL);
>  	if (resp->status == nfs_ok)
>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
>  	else if (resp->status == nfserr_jukebox)
> @@ -258,7 +258,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
> -				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
> +				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL, NULL);
>  	if (resp->status == nfs_ok)
>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
>  	else if (resp->status == nfserr_jukebox)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index ee78b6fb17098b788b07f5cd90598e678244b57e..f23eb3a07bb99dc231be9ea6db4e58b9e328a689 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -49,6 +49,7 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
>  
>  bool nfsd_disable_splice_read __read_mostly;
> +bool nfsd_enable_fadvise_dontneed __read_mostly;
>  
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1280,6 +1281,7 @@ bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
>   * @offset: starting byte offset
>   * @count: IN: requested number of bytes; OUT: number of bytes read
>   * @eof: OUT: set non-zero if operation reached the end of the file
> + * @pnf: optional return pointer to pass back nfsd_file reference
>   *
>   * The caller must verify that there is enough space in @rqstp.rq_res
>   * to perform this operation.
> @@ -1290,7 +1292,8 @@ bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
>   * returned.
>   */
>  __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		 loff_t offset, unsigned long *count, u32 *eof)
> +		 loff_t offset, unsigned long *count, u32 *eof,
> +		 struct nfsd_file **pnf)
>  {
>  	struct nfsd_file	*nf;
>  	struct file *file;
> @@ -1307,7 +1310,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	else
>  		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
>  
> -	nfsd_file_put(nf);
> +	if (pnf && err == nfs_ok)
> +		*pnf = nf;
> +	else
> +		nfsd_file_put(nf);
>  	trace_nfsd_read_done(rqstp, fhp, offset, *count);
>  	return err;
>  }
> @@ -1321,8 +1327,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
>   * @stable: An NFS stable_how value
>   * @verf: NFS WRITE verifier
> + * @pnf: optional return pointer to pass back nfsd_file reference
>   *
> - * Upon return, caller must invoke fh_put on @fhp.
> + * Upon return, caller must invoke fh_put() on @fhp. If it sets @pnf,
> + * then it must also call nfsd_file_put() on the returned reference.
>   *
>   * Return values:
>   *   An nfsstat value in network byte order.
> @@ -1330,7 +1338,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  __be32
>  nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>  	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
> -	   __be32 *verf)
> +	   __be32 *verf, struct nfsd_file **pnf)
>  {
>  	struct nfsd_file *nf;
>  	__be32 err;
> @@ -1343,7 +1351,10 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>  
>  	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
>  			     stable, verf);
> -	nfsd_file_put(nf);
> +	if (pnf && err == nfs_ok)
> +		*pnf = nf;
> +	else
> +		nfsd_file_put(nf);
>  out:
>  	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
>  	return err;
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index eff04959606fe55c141ab4a2eed97c7e0716a5f5..2d063ee7786f499f34c39cd3ba7e776bb7562d57 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -127,10 +127,11 @@ __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
>  __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				loff_t offset, unsigned long *count,
> -				u32 *eof);
> +				u32 *eof, struct nfsd_file **pnf);
>  __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				loff_t offset, const struct xdr_buf *payload,
> -				unsigned long *cnt, int stable, __be32 *verf);
> +				unsigned long *cnt, int stable, __be32 *verf,
> +				struct nfsd_file **pnf);
>  __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct nfsd_file *nf, loff_t offset,
>  				const struct xdr_buf *payload,
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 522067b7fd755930a1c2e42b826d9132ac2993be..3f4c51983003188be51a0f8c2db2e0acc9a1363b 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -146,6 +146,7 @@ struct nfsd3_readres {
>  	unsigned long		count;
>  	__u32			eof;
>  	struct page		**pages;
> +	struct nfsd_file	*nf;
>  };
>  
>  struct nfsd3_writeres {
> @@ -154,6 +155,7 @@ struct nfsd3_writeres {
>  	unsigned long		count;
>  	int			committed;
>  	__be32			verf[2];
> +	struct nfsd_file	*nf;
>  };
>  
>  struct nfsd3_renameres {
> @@ -217,6 +219,7 @@ struct nfsd3_commitres {
>  	__be32			status;
>  	struct svc_fh		fh;
>  	__be32			verf[2];
> +	struct nfsd_file	*nf;
>  };
>  
>  struct nfsd3_getaclres {
> 


-- 
Chuck Lever

