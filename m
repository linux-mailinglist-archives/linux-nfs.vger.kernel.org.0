Return-Path: <linux-nfs+bounces-22034-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAd2Ce9AGGrIhwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22034-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 15:19:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC85F29F0
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2288E300BC83
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2E3F164D;
	Thu, 28 May 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e3MOeoyt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ii540/z+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55D3F20FC;
	Thu, 28 May 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974237; cv=fail; b=gJ46TtGvybY1EkXv+ClKBxOWXOhOZtvHeMK7a8o9fpXrIk2wZns5Oxlz6CPfr24ZgkfPYoR1/7MXA1cCJ+eACuzzd9DMpbK4Rkaxwzhm6hmMNPrHoOkNt/syWCQ+s66eFHMkDwDMJ20X2/8bk3x7hSXT52+bLWI2UipLQYLt0cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974237; c=relaxed/simple;
	bh=c0Eq0mCXfJfImo+Qnh+mma+ZQurw/V/bLm+EM9mRfKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFJtMQBFqwIF/GKQUlelZZzc2ttILqwZ5V24dB8WjONWT+Eg3avlK8hEpCMLu7X9/1joZa05eb/GM6HY21vVOdzQdu1L9H9eQDUFV4CmCfzmAEwlt/e/MStulRmbPRu0WqgPSGMNde/fSZw02NJU6ZbwPPRe/oTSbuOSkUDEoGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e3MOeoyt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ii540/z+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKiIB83778875;
	Thu, 28 May 2026 13:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qdvCiKu+Cp73EXx1TpcY3F2pqFhuMY1Kut1jJX6RhWs=; b=
	e3MOeoyt9reY6LA4faSVaq3Qzv90eUKTXl/lWlKK3qLWlQTzFjHXxeNlpngtsnLQ
	/O7fawELFMaskCCQ6Z9EFcVO8PfFOui9h4IM25SiOFdhEsc/TRD8mdxT+d29g/Ll
	o3GpuZujGQfGZL+qJwXxBAt5JwPdytEBl6k1kPgzMnMxnJ489GkH6+wkXZksUg1u
	DfGUNk1RbLrt6uCUG87HTEdp3nl9CjbV8fZIOGQbIe8TV7Du2cRWt4cmYsEKyVi9
	doLmkoYrxuxSGAYKRlpJ1HefrlGjuHFHSAEYnHhcSzEUsItQGDRHCTFTLVN25jFF
	v3NV3iykF1oLcbxqXKfyGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7wpgwth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 13:16:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64SDFLrb028558;
	Thu, 28 May 2026 13:16:41 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4edjseyxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 13:16:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSxokoK6qpMUcttmt7qoz/HV2D/EpXL/HyYT6JUNCtusimnPhmoHR7hhfnn8kGJ8v69iKZh1GFvihd+/M1Z1S0VG4mfnvVLumgoL+EyB/3/xZvLYGI7bPOPwr5u5K+mnLHQ3z5aoIbWbakekPwAi/YShd6ZJLL1AfYs8ccMfE5VVnnINVpJ1loQgbI4asP+xsNYLvaifmeIGL6DzwDMbQXDiyzvqezzLaKAWTD/tVEJpQ4BLsNUKRqlEKWYzxDht+3fcBHX2jTMnG+iUZWWIWyxzWbyc7fuoePBvgQ1Gw5ZBHyC2a+f905qw6TAJ7GhRnI7V0XjKRAFdrRr2kl11QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdvCiKu+Cp73EXx1TpcY3F2pqFhuMY1Kut1jJX6RhWs=;
 b=pAX/Cttk2bz1ZlYQfkHrp/uA44viSLDOcVsZX9eN+5KO44hNh2A91zx9JsG/yJzS6GRPoI0BjB+FyadjjoKrm6/aQ4nQuaIA1iSpNCT4KhdjdrxUqaREOyEqq3E63EiHLka7B9gFod+Qrkfs90lwTgIhAMYydGFMKbtVsXytY94l/kG0WuQFphzdm48IBaIGYsyWsl43NKmxS9bQsKFfjNtBtfxErg74Xv9Ryura7t2Nd6sl0nMassUitaH8Qzt3bDD1EBVmWDSZV9EpyslokwzvlFFxB9aQh+m8FE2gZ1L0iRl9LFaHoWBqYUV/825JBn1H4u6P9ZhynNID0dOQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdvCiKu+Cp73EXx1TpcY3F2pqFhuMY1Kut1jJX6RhWs=;
 b=ii540/z+aDNdd8kNrKcMzwPMNBfHy4Yt0LoZxyoLGINScLmW7X5tLpniNbWepp2l9LhQoMZATIhqzW/ncjNrcUzfcTm58kw27k1hK3tq1Q2Ia+rDY7SfMAL1kJfHxhtNzlTrxDtmxLegUZkBspU1TP7Wl7+jfLoaEO/U++YMIa8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8322.namprd10.prod.outlook.com (2603:10b6:208:576::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 13:16:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:16:38 +0000
Message-ID: <93abf217-12d5-43da-88fb-81fa1e70f0e1@oracle.com>
Date: Thu, 28 May 2026 09:16:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: revisiting alloc_pages_bulks semantics?
To: Christoph Hellwig <hch@lst.de>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20260527071816.GA17632@lst.de>
 <df21e8b0-a67b-4b71-8178-91221b596949@kernel.org>
 <20260527121920.GB6079@lst.de>
 <276835c4-78d4-411d-8097-93cdfb000648@oracle.com>
 <20260528090054.GA8376@lst.de>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260528090054.GA8376@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:610:e7::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d85612-8827-4fff-3624-08debcbb59bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|3023799007|4143699003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VtU5e8iPY5++EDxZWc5GUhgRLYj5O5NMHun8D42+EMarjGfhbj/3qtr0+xzZQFEQpCr5BtnSsiLxIPORxTWvocg5HHKhzjVtOCdSg0kM+N6whdO5Ac0g8BFuC7sZa7Q5AZ9kIiZVMVx9mDaFBFciMuPg2Ff+hKmaPNnDr1W5HqfDFoth4Yntmb17VOMcsBHysVjrgMVCeHbizk7YNdTkMJ4wrIXRUBD77t1VvCbZT9gVNB/Hig0+FMYscqMGBCHXjw01RgrFAGaxO185DK/Df8UDmzl3cM47d8rer8v9hYEWKoGK/UG7kYUoQTGfDuDGNVpvbVYxCikeFM2MvrOzgVOEsIb3bS2IkB/A0iEr8H3Qb4+SOaEkNur6PxE8oU9QKsYbJpxxDmhyti1Cd1U7Y13NJ8+qXA8p/2Ha2e6T8qWDw5Kg9DCcGUPSvwDSnwn7aQN2qSZBedSttL4daE5G5HtasncZXZetWk2ryDjPtQTGto6Y+Or/5GtPrpOUr0f3Dki/xYkPxZENmKBZDSXaMHr0himKtgSxxnPwMpZdYDm1CoRRh9DcJ8fVa8xllogRL/cWKPXGX1W0oeE4mSoTKAYzh1Yt0EbNaSiDLrGc4rf2Ha6Czh/grv2zg2ymz/xvarshQaSYFAScX+NrsvBFtRZ7nFOtxa1dT849r6GXYNBrmIMGH52uKBlI3bbJCTe6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(3023799007)(4143699003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEFWTnExMHIrbi9Qdng1bU1PS0d0YkJscm9HSGZRb1lSTTB4bDRXM0JLVHo4?=
 =?utf-8?B?Uk94Ry9ENDhLMUtGUG1zMDNnRXd4RDN2VFlHMVRoaE1xK091Nll0SExnTXBX?=
 =?utf-8?B?OFZCWHVOeC82SlZDVmNPWEJFWCtSR25qOVhtK0tXMmVxS0h0dGQveGNCOTFE?=
 =?utf-8?B?ekVldzlwZ2JneGNFcU00Y2hZTklCbVZUNjNXQkh3Wk5PWG5Vak1sd1g2ZGpM?=
 =?utf-8?B?WjJzekhCNGNzK2RMaDl4clhJQmlFdW1PYndKRVlha29aR2ZMN3V3UFJ1ODZM?=
 =?utf-8?B?RFN2V2Z1c1hJNzNQbERNOXNQSk5IQW52V2NPM3lQbytKSFBla3hYUzVGay9m?=
 =?utf-8?B?M1dSc01TbVh5QlZueTVXbWhVZWk3MGlnelljOEFGTVNwWnZGUXNaUW4yVi9F?=
 =?utf-8?B?Q1RoZHNpU3NwU0V4azdwVGRSdGQvZDYyM29WQ0FLanNUNWY3dXpxbC9Ubncv?=
 =?utf-8?B?VUYzamFDYzB6WVZudk9NMkNhcitYYTNmTEdLbVRJNXBucnA1L1VFVGgrSzVB?=
 =?utf-8?B?TUFuQjZockN2bkppNVBadEgvdU9QZWNTNEFkbDNLaHMvcU13cjZ6LzFDNDVV?=
 =?utf-8?B?WEwwZFA1dnU4RFhWQld6SkpDc1NtMldibEt1RURyVisxZnJUZExGUlZCRFo3?=
 =?utf-8?B?L0g4N2FsbnJrZEN4a3VvaTRPYjJjdEFjaGdBMnc1R0pqcUczQ0c4NDZpckZp?=
 =?utf-8?B?K3ZuQnM3MVZqdHAxWFFUWGFHK0J1VFdwcXdHMVJodTM4M0NWSW1WNlFSTFkw?=
 =?utf-8?B?ajNzbHpKemd4VkMrWVlBSk5acVV3M1BEWHAwTlUrL3FVc0J0bHhodlFVMFlM?=
 =?utf-8?B?M05RNnk0NDFUWFJFZEJkVzRyWlJ3dHR2MXlqYkRRYkpjSnM5MDA4RlRiN05D?=
 =?utf-8?B?UWxDSXRxVi84YTMzQkpNTktBdk1sZVBoemFXbkJZTmRQMHNKVnZ0M0ZtT0xn?=
 =?utf-8?B?M2piNXkvOWtrZzVDcFpKZFdwdHQ3UWs1NVA2enFKT1ZtMk56QUNpRFVlcmpE?=
 =?utf-8?B?cnpHNGJBN0dRcFpDTlc2emFVWnpjcGNVOHhOS0VkNkU4cTBMZUZHNVNvZHFW?=
 =?utf-8?B?OGczdE9adjBZZ05JZ0JFaW1kREh0K0g5Zm9MdTNMRWk4TW52OFFRTnRtQTlu?=
 =?utf-8?B?MEg5aUZWaHFuWEpiWDlUY3IxMjlWVFZhV05vd083MFRpRnF1ODFMQmtqcW9k?=
 =?utf-8?B?VHk2c3h2TndQbm1DalJXdWMvY1kvSWVHcktsMDIvc08xd043RzFZNlUvVCs1?=
 =?utf-8?B?WUFXVEFXNFM4eHJXVk1jdFpXdENyWGpFZnVKZEFQdnNyYnRTVk1hN3JnSE1j?=
 =?utf-8?B?OGVTelJLMWdNeFNUWFRJVXZONGxDUmpCN1l5YStNMkxBRzhwTXQ3NWUzTnZH?=
 =?utf-8?B?ZXpqc3dXR3NsSm9qbFBrd3hZSmFIVHV6cGtNZXBqSHozNVduQUhrOHdrT0RM?=
 =?utf-8?B?MXRSMzJWWU1uMlNtaytKT1BWbjRRRXJVWk9jdFBBbmdhQk53aWNGdDc5RWZV?=
 =?utf-8?B?MU91eWp6c2dVOWsraUlKTkpaMkZMb0cvSnJqSzJVT29WUTF4Y0pnblV2WUFm?=
 =?utf-8?B?MWpGT2ZVWGJZYVVEeEZCWTdQTVdkaTJwZkJQTEhOcU1DWmxVaTB3RVR2TE1C?=
 =?utf-8?B?d3ZGU3RuU0QzMVhqUStndkhJVW9sb0pMQkRlZmJkVTN4eWd6RVdFUHJTRmVB?=
 =?utf-8?B?VTlTSUhUUDluem42ZnhYZlQvUUxLNEVwc0VRb29IVFJqWHVKdExVT3Q1Sm9i?=
 =?utf-8?B?YmNiQ3ZHYTlNQXlzNTFWSi9lOThZWnJZaENOSW5kVzlYaHdQUmdXeXg1MWcz?=
 =?utf-8?B?dnhQeXVjN1ZyS05ZMEk0M2hHeXZLTU5sTXRlV1MvTWkwbkNUU0tWWFhYakk2?=
 =?utf-8?B?cVhkMXZDMW0zcFVLQ2h3dFRGRGZ6ZXAwSFI4ZFNJVjljSzh5N2R4QUIwandE?=
 =?utf-8?B?VDUxV2Q4RzVJeFJMcmtnZzRFUTR6dHZYSDFiUCtza1BDVXRoNUtnVENmaU1H?=
 =?utf-8?B?S3RjZ3N6YUViNjFtVWZ5bjRXSkNuYVlOQXlhTTBIYmtuM3NMc1hGQzI1aVZB?=
 =?utf-8?B?Nk00Z1NpNi9HWG12ejhkc0hMWnd2RzhNOGlUWWk4SlJEOVR4elNicC9kazI5?=
 =?utf-8?B?NkMyYVRBOFlVcXAxcUhUUENJd21hTjFDRElvaEdiRGllcWxaVE9JZ1RjTEFC?=
 =?utf-8?B?Mzh4ZGM2NFFrWEpFYzd6YnNWa29TdkYvdzhtWVhyZGxSdFlUQWpOUGJOKzNw?=
 =?utf-8?B?aTk1aGE3dHZaZzc4TlRsVlplaUlhTW1sOXJpOE5DSWV1STNyQTV5dEhLMThx?=
 =?utf-8?B?SXJITnB3ZXc2K3dIWUhtWDVaQ1c3VHdlSEhDd2N6VzlMTUlTWFMzUT09?=
X-Exchange-RoutingPolicyChecked:
	CoC2L3i3h5ZwNRioBoi9WdPrksCJv9vWWTQN/t5qKz2v0dOx1EOhstJHAKekQTD6YRiFNonTlHW2LCRNeFN/4UoYU5iZIPXIlm4Fbm4ovCcE2k7QL89Ak2nOAmkeMeFlg/PEmugMmq0hVje5yu6Yt1apMs8QmEMbHEqW0TR6Mg31vWsqANpymf6CAV/bobqN6qS0/2Sv9FDDQ7PnsrSNjODA9kizN++GCkonHo5ksnOD6Q+EHHSLdA42Gyp+BYvoi3TUg7MqPLaoeRFsGqHWFPtiBiLV3+KBFncRgKDdoVBTU5CcTBod5Lcij+lA0zcccngSPlv6f8WBTICyYdzAzQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9w1q+rYXlDnLa7A81BD1yPydd1xwqS0XRh3lZiP1yjdMmHSf5KQkGWCwbdgY77OeHH5Xiemc0OLbVIcxsr/EFJJbxCFD23Yx1Y+Uxqx1M383LpCoLrlqNwDG6fRiFYuNMVVJyDNDKiJrYXjJYGxafo4kfDzX91mB8KGQ2FTeLcs3rkYH4dUxCYsF9lOZVEDpIz/VHviqACeqeqAmjw/59c/4Co1k04R5JuwPOTt/ogFoLCIL6OIO67+gzd6uQSU7o44tvGZzWO5oOs2ggdy9rJoJa/0ZmanZbxnhKJUayeT4L10krf++vrZXc1qa7pNNvsXywyl1VW0qSGtM9D9/LSIZ2B5aIyuEfEqFsdmpt1PnN0I2SeeDpWSbvkIEv+lNQf8gM4B7OpWYLMtS4ZgZMqG13yIZYzwaQ6umFrRi0KzvZ9PAozDOeq5H2YZqGuVfxg2xRJfXOYlmwP5pjnw/p8Z1FIroV9VqZn2nxyVeEeJXqceoQMVclMub7p5/NsCso9CSzWwvXnyNDByI7hMbUlJagOKyhFdpJwdcEVTZFlXVokzVN/YeVZd+t/hhGE2LryBrejy9NEnozekk/Y9bfZRv7qm/BfXdy6DlJXxB3VY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d85612-8827-4fff-3624-08debcbb59bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:16:38.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgUMqdXLw9Vtn4+lw41mKkhuGIWaRromm0alNpYH9ndNEJcd/DzmRAXli6+WvQiVUadXGKSTZMK4jg8h1R8ImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605280134
X-Authority-Analysis: v=2.4 cv=c4Obhx9l c=1 sm=1 tr=0 ts=6a18403a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=6P8EpRH5kqvOs-FEdYgA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13707
X-Proofpoint-GUID: khhox8WFUx00_Igz6mvbuKzKLPkcwX4i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzNCBTYWx0ZWRfXwQYHYd2j2WZc
 SlDSoH9D/d9bbujPtVaqQFLBqK5HW8ROaXSCsjS4o+NuIX5lKzc2QLJBoMWhtES9yc9VFu8c/rv
 c2i0piGP9v1sHonwftM8DCO/tdUvJqfe2XU6R90zQ+cgAD+DY+pOjEQkgGHMhuN4I+Wz08QiUGm
 n3tl5THnBAA9RB0QEAOU8FMzdTcRFxLB6AQu84ngiV3YxFLskT9CN64OWd30Wynxkb9w9Q6LkhU
 d91Zpjxo0G7ZZcPWB8Va4/i0AssscrzHWLSBDvNEbbYOZN9HAQV6QE0X3a9PnauEJkxvTDORzOV
 MTveGTBXAjQIciDkJgmf4ZwFFtdsLWgzXru5lwgFnPcVOuII/wC/CF7yFJQuQYeNGKZ86j/dtCa
 xrPMff91naz6P0MJ4hhY71epZSaeqSPGTRfI1VI7FmRMncXr9kASt2c3ynsqeRXUTeDrOXMpM4c
 bv1VOQr5DluUuV1QWcTegbYNxn8CmeZsHdjYnrdM=
X-Proofpoint-ORIG-GUID: khhox8WFUx00_Igz6mvbuKzKLPkcwX4i
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22034-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2ABC85F29F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 5:00 AM, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 09:58:11AM -0400, Chuck Lever wrote:
>> On 5/27/26 8:19 AM, Christoph Hellwig wrote:
>>> On Wed, May 27, 2026 at 12:06:08PM +0200, Vlastimil Babka (SUSE) wrote:
>>>>> alloc_pages_bulks can do partial allocations for some reasons, and
>>>>> users usually have a fallback by either looping and calling it again
>>>>> or falling back to single page allocations.  This sucks!  Why can't
>>>>> we get our usual try as hard as you can semantics, requiring
>>>>> GFP_NORETRY or similar to relax it?
>>>>
>>>> If we do that, do we keep the possibility of partial success, i.e. return
>>>> how many were allocated? Seems wasteful to suceed N-1 and then throw all
>>>> away, if the caller can use a fallback only for the last one.
>>>> Do some callers need all-or-nothing semantics? Should a flag indicate which
>>>> one to use?
>>>
>>> A lot of callers (but not all) need all or nothing semantics.  But
>>> freeing already allocated pages is the not a major problem - the caller
>>> just has to add a release_pages call if it didn't already have one
>>> for cleaning up later failures.
>>
>> What the svc/nfsd thread is trying to avoid is sleeping uninterruptibly
>> waiting for memory resources. That stalls server shutdown, among other
>> things.
> 
> I'm not fully understanding the sentence.  I guess you mean that
> you want svc_thread_should_stop to intercept some memory allocation
> waits?

That's the gist of it.


> I'm curious what you think about willy's comment, or if there is
> indeed a way to always use the pages from the beginning or end in
> sunrpc.

It is a ready supply of fresh pages, but it's not used as a simple
queue. Many places in sunrpc point to rq_pages and use it as an array.

struct xdr_buf uses this array as the middle payload section of an RPC
message:

struct xdr_buf {

        struct kvec     head[1],        /* RPC header + non-page data */

                        tail[1];        /* Appended after page data */



        struct bio_vec  *bvec;

        struct page **  pages;          /* Array of pages */

        unsigned int    page_base,      /* Start of page data */

                        page_len,       /* Length of page data */

                        flags;          /* Flags for data disposition */



        unsigned int    buflen,         /* Total length of storage
buffer */
                        len;            /* Length of XDR encoded message
*/
};

There's no actual array in struct xdr_buf: the "pages" fields points to
the rq_pages array that contains the RPC message being processed.

Today, pages are consumed from the beginning of rq_pages.


>>     svc_rqst_release_pages() NULLs only the range
>>
>>       [rq_respages, rq_next_page)
>>
>>     after each RPC, so only that range contains NULL entries. Limit the
>>     rq_respages fill in svc_alloc_arg() to that range instead of
>>     scanning the full array.
> 
> Does it NULL the entire range, or part of it?  Because if it is the
> entire above range, you don't really need the check for NULL behavior
> at all but just point the bulk allocation to this range.
It's two phase.

Phase A prepares the thread (svc_rqst) for the next RPC, and it's done
before an RPC is ready to be processed. alloc_bulk_pages refills the
NULL entries.

Phase B is done while the client is waiting for the server to send an
RPC reply, so it has to be low latency. This is where the pages are
"removed" from the array and the array pointers are set to NULL.


Note that as struct xdr_buf is transitioned from "struct page **" to a
bvec array, we indeed have good low-risk opportunities to restructure
this code and how it uses rq_pages.


-- 
Chuck Lever

