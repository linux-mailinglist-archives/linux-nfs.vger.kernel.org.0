Return-Path: <linux-nfs+bounces-16157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7AC3D610
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 21:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0E33B05C2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1733345F;
	Thu,  6 Nov 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjadyX7G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BFMFZ7jL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64954332ED3
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461473; cv=fail; b=WwNfb5xYqvHnmrYOFcb/9Xke3TStzFqN/a56SHdWpNEJRb4kg98rMdMrWQ9ECvVqQ2PVc6OnwW/BgCs7/L1j9jfcpWeLRJXN/cYUHTOT5Fz6Dsl/INh/D7+7QiTQTRGeItTtJqzkfDtohKadrqK7KobE/rCBUgGxW3eA/n4YQVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461473; c=relaxed/simple;
	bh=IY8zs0mOoBUahy+VNTDlecVYJpjyDhHe78rRDjFGaAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4ybOGw3tlinxOfHXvduqaIxCw0OINqZFt8EeMRl/gmyJPTaUlAROqSX2XgF8kmsZZ0A5uqoK3V4u3TZzmD4FCgHagEpIdZ38o6PMvyLLNjENDsxnPkcoIW0X6L3ldpATLNsxc9BNvk6ZZNKt3rxtFaIqUarf2K/ljGjRusXIRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DjadyX7G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BFMFZ7jL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IgqTK009167;
	Thu, 6 Nov 2025 20:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LyWOC6JX1B7mzDvGgWIomBOUDr05hRDqUWtmigfDkvc=; b=
	DjadyX7GsBRkH940jjX8EcfBVcV8I8IpD5g8lKkxSlOuhRMexYu5xUPjm1lU9pQ4
	m8APnvYPrJfAklXNNlHWl/rYHdyiY8lnbx9INjzTjGHGac49PzCLXDExadp1M7dr
	QLIWhZfGIdynTs5Q5cVwAIHWvQ9V3cuUTeyADqAf+OYWvGtpXPIRi9inrFT7b2yP
	3bpZnP7OCFULSd5D66pFLd4RSOvGle/NREKssM56nmXnkBS5wnviJaMUT5UynmG6
	VebAqbmkb+XPeQVMluqZio12kGySY8tVCyX5lvj+FsDMXG9AuL6acdwNFkC3r87X
	JNYW9MmnASJ2V5QG9LfA4g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjjx2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 20:37:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Iwbjs002646;
	Thu, 6 Nov 2025 20:37:42 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngggyh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 20:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xukhno7szWt6QzwZogDd++Hw6AGz/ocsEy1LXPNSyR4oD/Dh27sFlSkpIyeJ7C0LDAo88nMLQaBKvPrlOGgXBuH8WROCnCVVtL3NenjC7TQGyfH/GmtK13igEhn0TA2AycXW3ORKvKOROfJDekpapJkPt1c4INj3V3CGkqtTKK6aViH11WM1uMSnYe2EhwZAdwBsJraB/pc2CqMELkdvlHfJz3/Y14m4VO+nlaNUIKzupgHOaS1la3i+2hpz7JQn/vn/3ahgw3dJbSORJulM7i8FGiFTkfdwhby2iDyIYp736oT6sn4v7lkcFWLWTX/BtNUOZ2QwVhL7dMbbS6//yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyWOC6JX1B7mzDvGgWIomBOUDr05hRDqUWtmigfDkvc=;
 b=G3mqyeFwcr2jKQbWFmeQIPsyB7G5SHjlPgtoBOWaq+Wt+kDKeJX4joa8e9r189Zr0npKxgTt8OT1kKXk9eGQD3Ch/Yrs16dVueRUvxZO7kRKHK0vG5ggVrTHTgMmUGhu0GLGOcfE01qzn9JdUce0qgeVXGYnBABzhOgrGPKyd99y/X/1aqzcvMaesX75IOyTfA+Q0YWunKlXJKCHYBw9LXdOYMG0fz2TTY9JGoowh5/OgrC4l2leis5jsejtvQKcSHE21Fj4hu0h+uZu+mxaC3FTt9zMr8SzfA9Ph/3DRe773WFyfDxeJw75t+nyFdd9YIUlmHI8i1Ut8NrYXeuFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyWOC6JX1B7mzDvGgWIomBOUDr05hRDqUWtmigfDkvc=;
 b=BFMFZ7jLZ6L4rbhB+Gqq+nuQFrf6KO/9RhI5yo6rZzAjLGYu81HwFrwbwibGoGV/c7BovS/9uX/vQTY4VyueyoFPfH2GPvgCYaMVx08UOt7sqsSi/r4BbSihcIIyqvYnst58WnTUkEpcoKNxDCO2DuqVYQeN/G6v+RKF2X1K+iA=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 20:37:38 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 20:37:37 +0000
Message-ID: <49c8197b-99e6-4dfe-89d6-485e22af8808@oracle.com>
Date: Thu, 6 Nov 2025 12:37:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locks: Introduce lm_breaker_timedout op to
 lease_manager_operations
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251106164821.300872-1-dai.ngo@oracle.com>
 <20251106164821.300872-2-dai.ngo@oracle.com>
 <8f4ce8f03919de7e29e2fc601ed9e25f392aa2c3.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <8f4ce8f03919de7e29e2fc601ed9e25f392aa2c3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SN7PR10MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eabd0e6-bdae-4be0-4ef5-08de1d7452dc
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZGdUa0hnQVZ3bDNMUGM2V2x1b1R6b3ZEeVdud3h3R2VDYS9ObnBEU2plSVJI?=
 =?utf-8?B?UjZuRTh5dG5HcTFVK3pCQW02WDZrcFp3bkVIQ1o4SUdCS01sMTdDalJwbFFZ?=
 =?utf-8?B?a2ZnMXNueXdjdHROdXpPSk5jVk9Ca3ZYZ0JtQUZrNHE5Ni81TkJ3OWJYK0NN?=
 =?utf-8?B?cno1UlFuMkZnTlNhVSswQkxSQ3lwUmN3QWlid2tLVHRxTEI3bW1DQXdpN0V4?=
 =?utf-8?B?Q3ZOZGxUYSs5c0NSUjFRSEZ1Z01LdTlxN0lMWWtaR1dMWlpQRFhxM2JOd2g4?=
 =?utf-8?B?VFNnR29rbWVhZDcyTG1Qd1VsVmk4Zm9Ud1RBQjFVbVdidlMwWno5bWNkSFVv?=
 =?utf-8?B?TGRJeEovZ09remVDeXphYUtSRXdRd2twYUlBOFZKMklPbHZKMjY1TjFsYVdn?=
 =?utf-8?B?NVpvZUJocjlUOWtFdjRXTXB1VVhXWElzcUFoTGE5c2RCYzF6ZWpYQ0k5MlMv?=
 =?utf-8?B?YnA5bTFUc2h0N01MOU1sV1RhaS9hNUJJUHNDWVZqaW14QmUxWDA5cXkvWW8w?=
 =?utf-8?B?Z3o2S1lvU0J5MXd6bDl3NHdDY1AwWGtuVXRXdTBUNW1EWjF3QnFtUVVYRVZN?=
 =?utf-8?B?ZE53bkxscFhsSEpMSXQyaStQVEFqa24ybjZlWkNxUGx2Ylcvc0N1RHJBRTNC?=
 =?utf-8?B?WXJUMStuNG5YV2hYdUhUM0hGUG5MTmRTVzJkWi92aFYrdndNNzQ2VjVMOTZC?=
 =?utf-8?B?eFdneTI1OXBweDY5amhOWU5PV1U1dEsvMzdVaHUxYkprbnA2ZXFrcHVyK25o?=
 =?utf-8?B?elQvOVJzUlkrUG91bnVPdEw4UkRLY2ZxNlBOcHdIeW5YNEFOUllXclUyR3Zw?=
 =?utf-8?B?dVlzb3M4aFU2bkdzOG1oWXBIQ3l0dlhvOFJ3MWxXZURjYW1EWkhNdVVHVUZ0?=
 =?utf-8?B?TUNOY0FJYkU2U0FUeDdGRTNNVGR5ZklVL3ZKTXlsbzBKYWg1WTEwZThqZzl3?=
 =?utf-8?B?bGEwT3o3QWt6QjhOVUhNUWl0TXVOYzJxNll2RkVhVmxVZUlYQzJPZWRYb2tG?=
 =?utf-8?B?UDByUThFWXVIOTgxZ1JuS2Q2UERNUlhaWlpQUzM5azdFUm0vUWFVampEOEcz?=
 =?utf-8?B?LzY1SEhTRlFjZGRWTEZMcDMzbkc3YlpyRVFnUGF5UElFUWgrSDlGdzFrSkFz?=
 =?utf-8?B?c1JYa2F3dWUrVzdwOTZGZWZzcERHS2xlZUtsQlJ3L3lmQTZYOXI5T0xURll1?=
 =?utf-8?B?RnUzZEdvTGI1QmRDWTdNZGFJV2s0QVpna0NFMlZMUWtBTy96RG5KYktRUUtp?=
 =?utf-8?B?Tk1HR25JOVlzRktjSktqb2crd2thaGUxT3ZtdXJudHFjWTFQdTh3UXhJRlJN?=
 =?utf-8?B?Y0xpWm1kVzg2cTFnY1h3OEpkejluaURISGZxTUtoQitkQjVDclo1R3VESjE5?=
 =?utf-8?B?U3VOY3dVbU1UckpFSmJzckxONTVqMEJMMkhTcjFRS2VFcDJNbkR3dSttd3RC?=
 =?utf-8?B?V0FSOEtKcjBXQ3NxdHk2ODVMQUpNb1VHSFBNNzNwUzV2akUrbVB3YkpLZXNB?=
 =?utf-8?B?eURwVUtSMjdicmw1ZzBCRTY4Y2ltNFdYQjd5OHZZZ3RoNnZ3d0JjRDFXeWZL?=
 =?utf-8?B?S0VPR2NQQ2hFS1NQRE9wZjFXaHVlSkM3Y3FVd3FNdHUvYitld0R3V1FMcXFM?=
 =?utf-8?B?TjA2ckp6b3JaU1poWUYrbmxzSENoOVVPOEdTcmNYbzVBMzgyWi92RC9lczJ4?=
 =?utf-8?B?dHVtYTFkUVB4YWdXYUJrNmkxZlFRYzFBRVhTMWRBNGF3eWxtN3hnSDFtQ3RN?=
 =?utf-8?B?R3N4VGxuN3U0cjBSeHE4bFN4RFhUd3J2NUpFd3VkdktRYjh1QndFMnRlYUlt?=
 =?utf-8?B?cW94ekE5NnBRemU4N0RUS2d5b0poYk1yQ0dOZFcyVU5CbjRXcHM2MjdkaXp4?=
 =?utf-8?B?dGl0U1hoK2FKZHR2SVgyNHh2ajgrazVRZkhwa2RJR0RuMDVGeTRadnNEcXpl?=
 =?utf-8?Q?JLGzdG7Lmo2Sx6lxpmCVk8hrOhx9SWIh?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ejlTc1RyMGt3WVZSUXgvRlo0Rk16V3NPT2hFTHNWaWttTUJ0MWw2ay9TVTJj?=
 =?utf-8?B?UllMaGdDRE9oSDM5c0s0TVBrWUpGczFJY1JUOVpNbFZXcS9HK0dldEY5Z2xr?=
 =?utf-8?B?bXRnWi9TSk5kNjdFNmxteHRwV05sZE5NL0s1c2JCa2lkeWVFV1V4ZmpSSlhW?=
 =?utf-8?B?REdkTTRZN2hXbytRT0g3dFo5K3E2R0VoMVZkaDRHRnlKM2daYUVPTUY3QjFp?=
 =?utf-8?B?dWIwQU5rdkRycTBLbVNBU0tzKzNHVGJWU2RlTHowcTA1MWZuRWtCSms4eXRX?=
 =?utf-8?B?QjE0K0FFQ3ZLeXRFdkNON2JXMXRYSVFMQ2toWlNOaEdRTG1oV3JEWURGT1VW?=
 =?utf-8?B?SHlhN3lkVlN3LzBJU095NGhaYmt3S3lIMjRvUzlYUlgwb0dIZ21pUTR2UEVU?=
 =?utf-8?B?ZGJXZWR3cG9XeVltVVRLTmI3WWpWZVZSc1ArWWZLSHlOZHdXRENvSTkxODRo?=
 =?utf-8?B?cWlCWDllN0xOakticGkxWDYyUVZLZGpDOUxibW5zczEwRExDQ2d0amI5QTdV?=
 =?utf-8?B?N29PSjNpRkNSTi83dFdGUDRwMFdvM0lFZkJFSjQ2QW9NZDM0TUhNeDM2Zkk1?=
 =?utf-8?B?QTV1QmdEdmRNSDVIUnlFKzltbTIxSzFTUi8xN09DUyt6ZmFSR0dKVUgybzQ4?=
 =?utf-8?B?RnV6L1U0WkxtWnVzOHJlQlFGMHJ1QVkxZjZoMWNFdXNCSEYwWC9YTi91YmVj?=
 =?utf-8?B?VGpUTWtkRFRRSGRmdmhjQjlhTXVIWjhyVzlKVTg2R054NVBKbnZaR3gyQ2pS?=
 =?utf-8?B?NWJ2bjF3di83WEIxcWs1Y3JkcUtrRHhFQzMwYmc5M005aFJYcFNDTFc3d3V4?=
 =?utf-8?B?RHRnRkZsV1M0RnlPaHJkak5wamxKKzJkTUlrRHk0THRRWWpMeXVsQlJaWkw2?=
 =?utf-8?B?eVlYTmVPRWtnNzR6MTRoUk9sNDE5Zk1zL2F2V3NvUXYreTArRU9VQVh5OHpJ?=
 =?utf-8?B?cnNDK3l3Q1J2WXZmU0xQYkpTY3BLQmVBU0dEUGRjcUU0SW1NWmNvN0JQUDBW?=
 =?utf-8?B?aWJXNG9qbkdqczR0b1VCSkxyRjUrYUVaRThEWXhublpLMlFqYjRzQlU1Zldj?=
 =?utf-8?B?TmVhNVVGQW9JZi9vUER2UnFCNEhTclYzSDJXRmZ3K2twMWQ1ZjJhRUJKa2Jq?=
 =?utf-8?B?VEF4UlZMTDV1NzlLS2lDeXVoaE1IZExraWtJc0FJV1Q4dGpEL3NDZ0pXb3hH?=
 =?utf-8?B?c2dweVpmTit3WlorV21ES204MWlLOEJGSVdWcTV0Tmx6aVVqRzUvYnh0TVF6?=
 =?utf-8?B?TnR3Wm1zdFI3UzMydkg5RC83TFF3S1lxWFU4b3g2dFlyL081WVBrZXU3YzBj?=
 =?utf-8?B?QmZFenNtWXNCMTQwU24wQVVsaVJ2d05YTzM1RlpNTG5KbU80K3ZmNXVRYmZi?=
 =?utf-8?B?YXdpUU44YlhhSlpES1BUS1had05mcVlMemNDN0EwdU5IcGphOHJKZU5xQlBn?=
 =?utf-8?B?UXdSbHNrMy9PcXVjaFBzQlFSaDJ6RHcxWmhiMmNhSFpaMktaV3RQS0EzMHY3?=
 =?utf-8?B?ZkJsRTBReCs0Y3dUQ0pHYVcyZEUwQXdBTnlNa092cHNVaGZkSWdhSnF5aVN4?=
 =?utf-8?B?a2pyWlVUWC9kLzBjRlRjQWxQd2tuQjVzU05vZnNBVWZ1QTUzRWlaQ3Z1QlRl?=
 =?utf-8?B?UEU2ak1BQ3JEajJZaFdWbWlGK0ZUZnYybjY2ZjNlR0hsbW43TUZ1ZnB4NXRo?=
 =?utf-8?B?dWxISjRJYW9OcGtoOWE5YnpTVm0xakp2d2JhcFg5UHpvUHBuUFRNQlU3ejZJ?=
 =?utf-8?B?L1plQ3RYNTNZd1l5dVh5TnFKYWZvdEJPeW0reStjSjdXVXVoVkdsQUxPd0Nt?=
 =?utf-8?B?Y3NXR05QN1NjNnBKWHd5RzZEK1BSdnNZMU5xRGNLS1RMcHpKbnJvUjRlZFh0?=
 =?utf-8?B?a243d3FNaldiSTEvZDV5YTVsd2xlY2tuVGRIaGh2c3dQUWVNL0piME02aGZ5?=
 =?utf-8?B?K3B6cW1SVkZCaU9XdlpCS09lM0NPOFZJb0xsSGdBR1VpamRvWGxXb01rREp0?=
 =?utf-8?B?aUQyT2ZUUGxZZHYzRnBCd0ljcWsrYVBmY2pOaTM0SWticUM1Q3RCRmI1ei9G?=
 =?utf-8?B?YjBwbFpWTGk1OUJYQmlDY2NIZVVnMXlGbmF3c09IVFBiNExNYzZGVDU4bWxO?=
 =?utf-8?Q?PBBqUzUZBfy4d8Jhh63VZ8F8i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZOkt/9Ym2R9EzbyyNY3ARKgztRFq3MYX+iQljWDs+9dkJ5w7wNeKoP8lTm9p4u7rYSejOkmRTs9FCHy6D2U9iPFFrONv3GO7J796qQZKicNdW2MITHHnxdzYH66ELMPafZ0G7Lh/RpV5ZdBI5QUH3Hn2mS6rYbSIJQu892rgw8Cx+aKU+oUACQ+yLAByb2q6uaZ8GWuZfHPRhAD5+Pc14ZlLTt/rAL/082MMBl9sM+6HUTxOIG5ifDlBXixvL19GLlK8N0CcqBY5FD7AxMi6UI80ltO6uoxEPtaiThkw4ZrJJrvFGRk/tBH5k52sg0mBUzcd9GPuO2E2zQwTxDe9Vf3m31uTmdq6W6cCLR7HgaWreV6cxp3YBNT3HYHl6Ya8QY+X1DK6sgRsZ2m7DmfZs+abf5th92+zXxI0DvMkvIDJBvATz9sViOgygBelYbKziWEk4MDBVPywyKWHfc2WWR2lGP+Xz9vl/Ib9vv7mPmisk9rQuQDuOm5Swa7ZyXWSs5M4tsj6sJ6tz3KZzNwpbY7b/PY1mKHiurKQAd07C1I6+16uZh1tRULrbNht4FKGLbXJmJZIXYWdYnN8fIS9d7fFna/Up2a7FvoskcTEEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eabd0e6-bdae-4be0-4ef5-08de1d7452dc
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:37:37.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+F2u2w7isKoX2pvIyP4aASZbydz0BsQJiD4xP+c5gexLtPZMz0a2Ya7MUS2p2WcEUjwHTDtmGksll5X6T8Dhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX4ocA1pv/Okmv
 eu6TGelJD/qS97kTWBLvssUPuxTzZUOK6gdE8gEFeA2IW85zsxpba5iTg8bigbClSytkEbNdrCN
 DYAo42Di/WC9RPI+X/DwUM1CEutvH7uw9bAnfyWOzYuhdk016AYb+/DuPhhf750S+jtClqoF978
 0bsRdjPwuReetVd849K6G8xBtAAO06G3HVFaPtMCFRHAePGRggr4QCR/AgbK1g6gQ4kXj49+ee5
 vOQgd3bxDqKB8aXyta4FtPMEbHh5BMFL7ng6xIG3rYlWX83Pi6lRKK9IlxvYsk3mmYYa6mbXF1N
 Rgmk2jwHoBs+YlwZyuSHlEdpa55VaEuPg88EQk9dC2iMF5LyVNU/na8ghJtC/ddy0K34j3oZS4F
 Gn1zAG4tHS+IuUVa+4hT7g6YO6WMe1gMnBDhfHRPxR9IMHYW4y0=
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690d0717 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=wg0iEPHttGIzWQ57Ic8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13634
X-Proofpoint-GUID: g3m9dpXIuYR0Yl8tt66UugBNXQSqytqp
X-Proofpoint-ORIG-GUID: g3m9dpXIuYR0Yl8tt66UugBNXQSqytqp


On 11/6/25 9:23 AM, Jeff Layton wrote:
> On Thu, 2025-11-06 at 08:47 -0800, Dai Ngo wrote:
>> Some consumers of the lease_manager_operations need to perform additional
>> actions when a lease break, triggered by a conflict, times out.
>>
>> The NFS server is the first consumer of this operation.
>>
>> When a pNFS layout conflict occurs, and the lease break times out -
>> resulting in the layout being revoked and its file_lease beeing removed
>> from the flc_lease list, the NFS server must issue a fence operation.
>> This ensures that the client is prevented from accessing the data
>> server after the layout is revoked.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 ++
>>   fs/locks.c                            | 14 +++++++++++---
>>   include/linux/filelock.h              |  2 ++
>>   3 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 77704fde9845..cd600db6c4b9 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>   
>>   locking rules:
>>   
>> @@ -416,6 +417,7 @@ lm_change		yes		no			no
>>   lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>> +lm_breaker_timedout     no              no                      yes
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 04a3f0e20724..1f254e0cd398 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
>>   	while (!list_empty(dispose)) {
>>   		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>   		list_del_init(&flc->flc_list);
>> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
>> +		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
>> +			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>> +				struct file_lease *fl = file_lease(flc);
>> +
>> +				if (fl->fl_lmops->lm_breaker_timedout)
>> +					fl->fl_lmops->lm_breaker_timedout(fl);
>> +			}
>>   			locks_free_lease(file_lease(flc));
>> -		else
>> +		} else
>>   			locks_free_lock(file_lock(flc));
>>   	}
>>   }
> I think this would be fine in the case initial task that calls
> __break_lease(), since that task will also be the one to call
> locks_dispose_list() for the lease (and hence will fence the client). I
> think though that if you have multiple tasks that end up blocked in
> __break_lease(), that the later tasks could end up proceeding before
> the client is properly fenced.
>
> We'll need to ensure that any other breaking tasks block until the
> fence operations are complete.

Thanks Jeff, this can be a problem. I'll post v2 patch.

-Dai

>
>   
>> @@ -1482,8 +1488,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +		if (past_time(fl->fl_break_time)) {
>>   			lease_modify(fl, F_UNLCK, dispose);
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index c2ce8ba05d06..06ccd6b66012 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>   
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>   
>> @@ -49,6 +50,7 @@ struct lease_manager_operations {
>>   	int (*lm_change)(struct file_lease *, int, struct list_head *);
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>   
>>   struct lock_manager {

