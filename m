Return-Path: <linux-nfs+bounces-10956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C375EA75AD6
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Mar 2025 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBDD169399
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Mar 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2E1AF0B4;
	Sun, 30 Mar 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TGLXy730";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zjW84E1h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412913C9A3
	for <linux-nfs@vger.kernel.org>; Sun, 30 Mar 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743351470; cv=fail; b=DqcDk3ziL/h2aVj58L/7420dvFwm0IbyxC03YCwNfbE8rpebgJ5Mg52cHKirndh8ozDtUXAiT6VP1kGIVP8aKZrbj8KqA+zaTWq20j0LqejFFhNuVqnssQc86GjHC865jz1jPvIQNztriruhQzVtBW1f0llO0QlQEMweCRXZPno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743351470; c=relaxed/simple;
	bh=bNRtazssX4wZCCoMNMUSu/2YyzZdXmvMcvt4Gpp8K3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g65HmRWp2uG15zs/jq83lFBT3rZ2VZBLZ/Uwuk3VJ/E8PuGj4l3L53SubtyGVBcDL3mENRLxVykxIn93g+biQ4zQK37n1iZxVn5fjqNfKuqHj8XM7DmuSgpc5GSvPOa3XdapuAdE5iaQupZx98pqoy9bBxEN1bkVwCuiUGW+bl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TGLXy730; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zjW84E1h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UDVNPn024895;
	Sun, 30 Mar 2025 16:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9SUzx8ELW/ZcQEh0KNnCTE6ShUMvDqhQoTHdre8xbzA=; b=
	TGLXy730EIhYshyJiAoS33QiSRFJHDMXeSDV/touYwmW3ks+PyeS24HuP+1Z5hZv
	vhg9SsnykkrNcRIcWjpWopeOZvzHRYk4tpFoZo68msxU6Q0qDgfS4TIMArTkYKzv
	9SEmtaapTQoDy/1iJiYNkl1vVCdFi7zL7YykD8VfPJY0fI6asuFnM2Q3pdSmHESe
	87V3QSkTjf+jt6SWWp0ip2/+eqYALjQbb1erXFrQ0D9dkk+G1xwXkb/hVMA1mStE
	mwV1oXXBxA9H+sZsikNQuYSKd5oeEkModMJLsPuburCJnl4Xef0kPzuFDUEI1t1+
	IQj4ZWw7g4WN4m1NK6/UOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs1ygr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Mar 2025 16:17:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52UDktSf004574;
	Sun, 30 Mar 2025 16:17:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a6wf9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Mar 2025 16:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiIRMMF+zdMC2CqssDXMNrkf8basRLGoxurbYhpV4u82AHu/ZHGz2hKHCRBeBhWQH8dulyLlA8h4ymFJ/YugurCvGtV5hfpaAdfg0MZ5Excxc436rKocV5t9ORyToiDxfECHW8NyflAJgzTYlDBHAOKvwAW2syB6ZXH6AwU76q8u0uoOQODvAc/VE++fV4Jp4UICOYABFuKVYqNt5S1KN+Tt8YcS5aRibzTN09250xvpjRGPvEGNR9zwVIz+m7chjzRJqLqITZYjiBwN2tYr1y7sb1UuxEQILkcAyIrqxPKcX93Otb0WdxlI7JYfqfOSkhyQ7tR3P37N9ifwsJDA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SUzx8ELW/ZcQEh0KNnCTE6ShUMvDqhQoTHdre8xbzA=;
 b=bTe5sYMbIR6pTko+gxU6y0lYB7rwOB4ILMuj5ZIwWZyxvXzbzToUdBtKX7pL98jTNCmWyuTFD7Y/IuZr4hJ72HnPwpVY7dPgr/9jBJwDdzq97ctxD0dtaura97OQ0t185lqLfIwHpAIBvfDofhfmO+cxEQuFS+L5iyIxFKAT49WJELsC/q/iNYatZszp92l7I2kCR00ORFNIRk2TsK/GHNjvt2oM8+Bf18UHZlWCbdd1IdkhAIM5gDPP1yGXtTeHKF/Mrrumho+CuGCvRR/JAFCZqC01Q21KZ+xaJfQIvtz/rVhpCWZvgRm54PoZdsES2k4Z/UDhjHGA3+mnSWzOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SUzx8ELW/ZcQEh0KNnCTE6ShUMvDqhQoTHdre8xbzA=;
 b=zjW84E1hv2DfaoIVmgouYRbWxa0mlqlsg3ITDCbeoU4YQUiLS/TZOFHy5MGYRSqcFoRWOGECyHQBIaCuCoPMWbZxIlwNb0PNmOm9ETqiPkGWoaqowrAHXLMZ0Q5NjtKDD/PLOkSI4sl1i456YO+Jl0BfPg8gKAOEu+AZFN2qADk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BY5PR10MB4243.namprd10.prod.outlook.com (2603:10b6:a03:210::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Sun, 30 Mar
 2025 16:17:23 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8583.033; Sun, 30 Mar 2025
 16:17:21 +0000
Message-ID: <c8cf22d7-47fe-4d48-9599-48e57ccf6de6@oracle.com>
Date: Sun, 30 Mar 2025 12:17:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in
 nfsd_permission
To: Tom Talpey <tom@talpey.com>, NeilBrown <neilb@suse.de>,
        Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com
References: <>
 <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
 <174319880848.9342.18353626790561074601@noble.neil.brown.name>
 <058327d3-83b4-4b1e-8ca5-786764e218b6@talpey.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <058327d3-83b4-4b1e-8ca5-786764e218b6@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::20) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|BY5PR10MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 403d6138-cd79-4f04-919f-08dd6fa659b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVJybS80YVZacjB1T1BnL2U1VEcwbEd0R245TXRNS2Q4RHFQYkJYYkVtRm5s?=
 =?utf-8?B?KzVJUjZGdXh6WUZWbjdYYkJvb21SZXkvWkJUbnYxVTJ0SjJ2REFsQitkMjN3?=
 =?utf-8?B?dUFqU1dOcjh5emRkMWFpN001cUlSbm5zd2YrMFBPWVgwbVNUSzhHRHJJdDN5?=
 =?utf-8?B?emlQK1RyL3hoSXRtMllQMGFmVXJkY0prSVBKcXFOM3ZKSjhkNTFVK2ZUQXBN?=
 =?utf-8?B?YWh2b0pUYm0rQXUwV1BTM0hYdHBMU0lmSjFDRkhXanZPNUVhWFg4eVp6U0JH?=
 =?utf-8?B?Z3VaOUxwTm9uYmt3aGVZZG5Qd1lsSzBMZFZIZGJNOUlkZDF3YytZRi9Kalph?=
 =?utf-8?B?NkdIa3JOcnljZElIY0YvOFo1bHcyaXBtU1pDcnA0WlN4eS9mbkdRakRiY1F3?=
 =?utf-8?B?NlRWYnFmNzZQSlFUejY2ZVB1bCtKbnhsdlVjZEl5S2N5dEhLdlgzWFQ3RERn?=
 =?utf-8?B?RlU0bWtEOEVmZEpzcXZoNmFMdGE1YVFGampzTXBSZjVKZGJTcWJIKzlwU091?=
 =?utf-8?B?dWZxajlvV0VRQ05DUW52OGxVZHR5N2J2YW9QM0xuQlFpV21qUm1TWmljZWJz?=
 =?utf-8?B?NmsxZ1kyMFZkODllK3dQWHN6aUlRNjhadjRnYUsvSDNHWUYybDVZbGkyZ3cz?=
 =?utf-8?B?S0I0SVZMaUxIdnBpbFA3RHhiT0xDWUlOWHh1RkY5bjBkTWs3OXR5d3V3Sm1C?=
 =?utf-8?B?dWRyWWc1anFMejZ1b2lUUzd0amJwc016ZDZXWWU4RDBIQS9yQ0RtTERRMmQx?=
 =?utf-8?B?VDVhL1dsVWFSazE4K2dJUXc4ZTllZ3JUcGJLT0FndmtxSHNJOWdNaDFLdWV3?=
 =?utf-8?B?L1ovOU5aa3ZNRjJucEV3aFBwMnhIMjhwRHZ6UHV5L3BpdFNvTjc5UGxFMDVa?=
 =?utf-8?B?alJrcmlIYWR5MFYvdFVPWFJ4SUhqU0NlMHI0ZnRZSnNScThHVWJFSzdUTUFo?=
 =?utf-8?B?MDFpcHZVMmxwRFVSeTl2Q05MSUI2MFRmZkN4ZGdFK3ByVzd4L1hXcDdJUmh3?=
 =?utf-8?B?WGRuS1dWN2QvZU85L0hWS2phcHhJVzVrWndobnFsRVhGZ2g3U1c2NDZvakdV?=
 =?utf-8?B?ekN1R3hmd3o4ZUpHS1dUTTgySHovaloxSlE4L2QvejhkYk4xS2xYSHFwOWRk?=
 =?utf-8?B?T1hFT3JBR1ZEZVQ2R0FKbWFVMW1DQ2ZHL0gxblg5blJCenN2MDVLY2xCbVhm?=
 =?utf-8?B?RDJ3QzJPa0dmMkZXczBuK0ROMFVKcUJlQWFnUThMcnoyWEI0L0cxZXlTdHZa?=
 =?utf-8?B?U0xaazM1Yk5XNTV4dllPcjFlbTNWbzUza3grczJRZzcwSW5IWVMrK3JUdXI3?=
 =?utf-8?B?a0xSdExQL3Q5elNhTmVmVm9zVVBpTGpkMXI5YXoxdjdvVGMyT0JZcE00bWll?=
 =?utf-8?B?UE9kMENjcmhVWmtEaDZsS1NZVDZ2WW16ZnVScWhadjFWMW1iL2JRYWhWb2Ju?=
 =?utf-8?B?UmhTSFhTTWZ1NVQxWjVBVVFXbHd6NlhiU1UxeTRuTFJQZ0J1YjdrVlhWZnZ2?=
 =?utf-8?B?WEI3dHdsQkhTN2pRWjhPK1dseHhWbEFTY29VMnR2anhuOVlrOEdiTnI3aEVQ?=
 =?utf-8?B?S0lmUVdBVXZjcUdad2Y5U2JLZm1qVjN4UFJRdldyVjVxaFJSRVB4K0tGekhQ?=
 =?utf-8?B?SzB1amVKVHRzK3pZc0VMV3JRL21yTHIreFlnQ1pHd0tnRGk0QzZVVHFaTUx2?=
 =?utf-8?B?azBSbTdJNWdmbW5GUU5wWDhmTXo4bFJwbVpLY09weDRQRUJQRkVEYXhkc295?=
 =?utf-8?B?MnNYS1c5NHB6VnJMdzkxa0wyaUFkVlJYbGQrZXFlVTIxbTEreldsVHNqZGh3?=
 =?utf-8?B?cFF5cGNBZloyRUdoUEtrVkJuN1dGSlhWZ2R0NlR5K0RmcnBwU3NQdi9oaWlx?=
 =?utf-8?Q?Pk/0athtkEcdG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE0vMXdnalMzMUs0K3F2eHdhT1hZMnIrRDNIZ0RXcm1oTG1EUlV1OFpHRWZh?=
 =?utf-8?B?OW5sN0o2M2Q4MndQdzBPTDFuWjZOMFZycXJSckJ6QWIxbDJ6RjFlUFYrNno4?=
 =?utf-8?B?RGM4dnpWSGhFMjRtcUpoMm5FL3NXcFIySXJ3eVNWUXVZandhMkwzemNvRElV?=
 =?utf-8?B?ZktwUW1RQ1puQ3FEK0tkUVNmM1E0TjJDbVExcWpiRGhEYXdPRks5VEN3MGI3?=
 =?utf-8?B?Nm9Pc0Q0T21CTE9oWk5uR2NidjlmNllVUk92MXlUM3JUbHd1RUtiYm9WQ0pa?=
 =?utf-8?B?bThiMUlrZnJvQTlvZXRJMUFoRTBiOENJSXFhRnhLNUcwUStzT3YzUzRQbUlx?=
 =?utf-8?B?aUxNSXNUWXBrb1hDQ3I1alFLVXZNemIvUjdVOTQxa003Ums0ditVNmErZ3BH?=
 =?utf-8?B?VW5Fb29NRjhHNUZhNkRSckJ2L2FxV3BuZlI2S0ZBSHkyM3R0NWoxTy9Dc2FT?=
 =?utf-8?B?OTE1VHNURTluT0VoMWJlMWk3KzRmeVZMeHVXSzd4VlE2K3Urd2tETDNRVnoy?=
 =?utf-8?B?SnFoMGFVZ3UvVXovQlUvUHVOc0c5QlFTUGhQTEVOVzR4ZWtvZU9aazk0eU5T?=
 =?utf-8?B?T0hya2hTY2hhRE9CRUdPcWNiem10K1V4VG5PWGQveS8zcndDOVFYNSt2NGkw?=
 =?utf-8?B?WUJ2eHF6WDlGQ25ITHlPYjl0eHNFWWJxU2ZuWlFHTHMzaVdlRS9lSUtwdFRK?=
 =?utf-8?B?ZVhKQXVhZHlUZ3h3RlVoa2lXWVI4cThUV1JYd1BOQm9RQmxaaEhxdHhRWVdF?=
 =?utf-8?B?QllRa2dhdXJBN21rWGt6b0psaGtFKzRVY3ExSkl2NnVrdHFiaS9hcnhQSDZL?=
 =?utf-8?B?UTdqYTZja3NZSDF3SzdCdGxmVDNFeGJvOWNDVXZUWlNUNUF1bWNFMGl3OWFo?=
 =?utf-8?B?d05qdG9QZXpicjEvbkxFdGQ2TVFUd2xwL1htdVRXZFg2UTVlTHhxZjRXeHpY?=
 =?utf-8?B?MkNGRXBraEZOVmNueXRmenAycmtzbzQ2OVVDRjJNem5oZ2Q3dXRQMlYrQ25V?=
 =?utf-8?B?Zy9zOWEyMXVkbmhHMEdQbXhmTkdsbnowMzJDNjRROUVtUk0yOG9QRW9qY1Jn?=
 =?utf-8?B?UFJ3Zy9IYURRMXM5d3hGK2dPZzd4ZGNicE9GclpTVFhNcFZZbmhTYWNYWEEr?=
 =?utf-8?B?cktJRUdTa2x4ZmZDUGVqdzM3Ykg2Tm80L3d2dS9OVzNXeS9VZlExRU1WZFpZ?=
 =?utf-8?B?aEVFMzYyd1MvN3VHamdnOVZ4NFR6akNqZFk5VTBFOTkrQ09IWnBROStmM2Nh?=
 =?utf-8?B?cm5ld1IxZk85b1U2cWhSK2hERFl2YUVMQmIzNkJyTzNTaytCd2FhM0o3L3p3?=
 =?utf-8?B?aks0ZVIvNW1JckpTL3gxbkljNHBmYmJlL0prZFBJcXovU3NEZnd2ZXZkYzI5?=
 =?utf-8?B?dDJoY3lwRWlhRnhBUUdBeVdKKy92N1l0UTZqQXh6eXkvUGFhUlhNbW5hZjNq?=
 =?utf-8?B?OWhYS3dRdnZJV0NOVHlNeGw4cDEyRDZMeWhMaFBKam9wQUtFOGExZmFrbGhS?=
 =?utf-8?B?RG4wNFRmVU1vQW9UZ3EwUVdDY3hTTm82SGNvQnRycGhKMzZEMHVUUGJSTGQv?=
 =?utf-8?B?b21ueVFwV1pEZVRPS014RWdPaVNiR3JzK0VmRjA2ZWxTY3dUSlUzL1RocVRr?=
 =?utf-8?B?bkR3YVJ1TVZsTll5S3BaUTdzTEFyMnBKTWtrSkhpbnZsMFJWcDRHRkhiTE9H?=
 =?utf-8?B?eXRYVlYzdEpmNm9xNnFNWEVnNisycHdaSTZzSmRFSlpQRXlPcEtTTUR1Z3l4?=
 =?utf-8?B?QyswampNUlRmNHB3cTZad2pJTy9PenpyWnRHdFkrYWNwOVJLSjBHVDhmRXVo?=
 =?utf-8?B?MFgwS21rcmVpSUltNWpIYXYwT2ZWQ01wRG9tR3FzOUNBYWtSSG9yQjJLVXRr?=
 =?utf-8?B?U3RBd3pBNTNtcHZ6bjdacWd1QU9FaDZySW1LNlRKNEsxRjNkQVNMbC9XaVBh?=
 =?utf-8?B?NE9pVnQvbk9RUHZrZXJCL0tqK2V2aTFMTHJLS0Z5ZDBVN0hYWVBSYkVBNEUr?=
 =?utf-8?B?L1JlbW84aU9KMGxLVFVXOW5POGxOdVpVV2NzNVZQTCsxdUlYNjBReDRKUHFw?=
 =?utf-8?B?T0EvdDR5cERMaVpZMnJDaldZYmRZYVA3S0FRSDNxaCtzL0thclpmYThPN0Zi?=
 =?utf-8?Q?/6dkeIgpIChjSCw/bZPV+URge?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kFE7nsZgVyc0AWW1bNWMMaPciVtNIBgMmZOevcZeBoP3cA4DO6AdIV/ijWV3ZmZcsooEIJEd77zgJJFmOIvJIvvjvyJYnE/Ar/opRkvu/zLdB4K8QjAY7ALxbad71DbdrtDm1HVtscBZ7hrWnhMxUBXqmU7/sTMA30wnbPx4KiMKXBCbbxKDOescKjITV5OJ4hZRf5eCjT48xyGBL+wfkv7alWXnIR+nw2yB889UvQCIqO93os6VNuHoHPjf3EVIbV/WMhlPNLFx/EC6mQtsT6ayodtpIEJj3MGuobA/7lA4oZ5KPDXeCj5LnKMcycmjKLH0qHjcp1JSIObVQtK9rEy37jwIin+68qHXyMWK55x58WgV20bHPzAH9KaNoLc8hA0Z49sU35vi4x8ualqs+HBq0wewrJUiaky4EbU+nAk8DNmtjrPOPGlW7aJHUOpEho8rbRKmemFlH3b7VhxwCV33CPV4Nl41E+CCWZ/A7reR+kpTM9U5Qe0AKCoc6NR4NvbsZIrWPoNn6rfQDwrihrnBmXt/m4NrgOSJo0SMHZacP8zmd18k6cl1a8wlGi9II9wWZXnNqVBY8xqltKUCXxkAXwrHbAN3JRT4ysiRpac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403d6138-cd79-4f04-919f-08dd6fa659b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 16:17:21.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy/cm379OH2M3Sm/GRn3fx4+Oy8ReCpI/+34zXnSU2qqiHRxeEe+VLP3aeKIOISHGb46kTxSGxMTW6rYtk+7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-30_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503300112
X-Proofpoint-ORIG-GUID: p8Th-740BF_tf5qIqpoYUZVDC_WEv1Qy
X-Proofpoint-GUID: p8Th-740BF_tf5qIqpoYUZVDC_WEv1Qy

On 3/28/25 7:29 PM, Tom Talpey wrote:
> On 3/28/2025 5:53 PM, NeilBrown wrote:
>> On Sat, 29 Mar 2025, Olga Kornievskaia wrote:
>>> On Thu, Mar 27, 2025 at 9:43 PM NeilBrown <neilb@suse.de> wrote:
>>>>
>>>> On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
>>>>> On Thu, Mar 27, 2025 at 7:54 PM NeilBrown <neilb@suse.de> wrote:
>>>>>>
>>>>>> On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
>>>>>>> NLM locking calls need to pass thru file permission checking
>>>>>>> and for that prior to calling inode_permission() we need
>>>>>>> to set appropriate access mask.
>>>>>>>
>>>>>>> Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>> ---
>>>>>>>   fs/nfsd/vfs.c | 7 +++++++
>>>>>>>   1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>>>> index 4021b047eb18..7928ae21509f 100644
>>>>>>> --- a/fs/nfsd/vfs.c
>>>>>>> +++ b/fs/nfsd/vfs.c
>>>>>>> @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred,
>>>>>>> struct svc_export *exp,
>>>>>>>        if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>>>>>>>                return nfserr_perm;
>>>>>>>
>>>>>>> +     /*
>>>>>>> +      * For the purpose of permission checking of NLM requests,
>>>>>>> +      * the locker must have READ access or own the file
>>>>>>> +      */
>>>>>>> +     if (acc & NFSD_MAY_NLM)
>>>>>>> +             acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>>>>>>> +
>>>>>>
>>>>>> I don't agree with this change.
>>>>>> The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is
>>>>>> also
>>>>>> set.  So that part of the change adds no value.
>>>>>>
>>>>>> This change only affects the case where a write lock is being
>>>>>> requested.
>>>>>> In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
>>>>>> This change will set NFSD_MAY_READ.  Is that really needed?
>>>>>>
>>>>>> Can you please describe the particular problem you saw that is
>>>>>> fixed by
>>>>>> this patch?  If there is a problem and we do need to add
>>>>>> NFSD_MAY_READ,
>>>>>> then I would rather it were done in nlm_fopen().
>>>>>
>>>>> set export policy with (sec=krb5:...) then mount with sec=krb5,vers=3,
>>>>> then ask for an exclusive flock(), it would fail.
>>>>>
>>>>> The reason it fails is because nlm_fopen() translates lock to open
>>>>> with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
>>>>> acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
>>>>> inode_permission(). The patch changed it and lead to lock no longer
>>>>> being given out with sec=krb5 policy.
>>>>
>>>> And do you have WRITE access to the file?
>>>>
>>>> check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
>>>> granted the file must be open for FMODE_WRITE.
>>>> So when an exclusive lock request arrives via NLM, nlm_lookup_file()
>>>> calls nlm_do_fopen() with a mode of O_WRONLY and that causes
>>>> nfsd_permission() to check that the caller has write access to the
>>>> file.
>>>>
>>>> So if you are trying to get an exclusive lock to a file that you don't
>>>> have write access to, then it should fail.
>>>> If, however, you do have write access to the file - I cannot see why
>>>> asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.
>>>
>>> That's correct, the user doing flock() does NOT have write access to
>>> the file. Yet prior to the 4cc9b9f2bf4d, that access was allowed. If
>>> that was a bug then my bad. I assumed it was regression.
>>>
>>> It's interesting to me that on an XFS file system, I can create a file
>>> owned by root (on a local filesystem) and then request an exclusive
>>> lock on it (as a user -- no write permissions).
>>
>> "flock" is the missing piece.  I always thought it was a little odd
>> implementing flock locks over NFS using byte-range locking.  Not
>> necessarily wrong, but definitely odd.
>>
>> The man page for fcntl says
>>
>>     In order to place a read lock, fd must be open for reading.  In order
>>     to place a write lock, fd must be open for writing.  To place both
>>     types of lock, open a file read-write.
>>
>> So byte-range locks require a consistent open mode.
>>
>> The man page for flock says
>>
>>      A shared or exclusive lock can be placed on a file regardless of the
>>      mode in which the file was opened.
>>
>> Since the NFS client started using NLM (or v4 LOCK) for flock requests,
>> we cannot know if a request is flock or fcntl so we cannot check the
>> "correct" permissions.  We have to rely on the client doing the
>> permission checking.
>>
>> So it isn't really correct to check for either READ or WRITE.
> 
> Just one thing to mention, newer versions of the flock(2) manpage do
> mention the NFS/NLM behavior w.r.t. open for writing:
> 
>        Since Linux 2.6.12, NFS clients support flock() locks by emulating
>        them as fcntl(2) byte-range locks on the entire file.  This means
>        that fcntl(2) and flock() locks do interact with one another over
>        NFS.  It also means that in order to place an exclusive lock, the
>        file must be opened for writing.
> 
> Not sure this solves the question, but it's "documented". The text
> should maybe be revisited either way.

Thanks, Neil and Tom, for digging this out.

I agree that the new code comment should explicitly mention that
this logic is necessary due to our NFSv3 implementation emulating
flock() with fcntl() byte-range locks.


> Tom.
> 
>> This is awkward because nfsd doesn't just check permissions.  It has to
>> open the file and say what mode it is opening for.  This is apparently
>> important when re-exporting NFS according to
>>
>> Commit: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
>>
>> So if you try an exclusive flock on a re-exported NFS file (reexported
>> over v3) that you have open for READ but do not have write permission
>> for, then the client will allow it, but the intermediate server will try
>> a O_WRITE open which the final server will reject.
>> (does re-export work over v3??)
>>
>> There is no way to make this "work".  As I said: sending flock requests
>> over NFS was an interesting choice.
>> For v4 re-export it isn't a problem because the intermediate server
>> knows what mode the file was opened for on the client.
>>
>> So what do we do?  Whatever we do needs a comment explaining that flock
>> vs fcntl is the problem.
>> Possibly we should not require read or write access - and just trust the
>> client.  Alternately we could stick with the current practice of
>> requiring READ but not WRITE - it would be rare to lock a file which you
>> don't have read access to.
>>
>> So yes: we do need a patch here.  I would suggest something like:
>>
>>   /* An NLM request may be from fcntl() which requires the open mode to
>>    * match to lock mode or may be from flock() which allows any lock mode
>>    * with any open mode.  "acc" here indicates the lock mode but we must
>>    * do permission check reflecting the open mode which we cannot know.
>>    * For simplicity and historical continuity, always only check for
>>    * READ access
>>    */
>>   if (acc & NFSD_MAY_NLM)
>>     acc = (acc & ~NFSD_MAY_WRITE) | NFSD_MAY_READ;
>>
>> I'd prefer to leave the MAY_OWNER_OVERRIDE setting in nlm_fopen().
>>
>> Thanks,
>> NeilBrown
>>
> 


-- 
Chuck Lever

