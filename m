Return-Path: <linux-nfs+bounces-5592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053295BF76
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F7A1F2446D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13A91CE716;
	Thu, 22 Aug 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzPCTtUk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF815099E;
	Thu, 22 Aug 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358031; cv=fail; b=cUxSsVDmrdmYSqPwiNltKUwmE6dUmJvX48H6CGAMCO1Hr4EEAjsv9yMFx50ZKgHAyznJRUg6zQ5ufuN7Baxeus4rbHmg3QoX08evvYzJt8qDA6RWvsIurYxkRYoSCCTMT8C+jCv+T6dLrDB9rBrFQL+gLDTjTvYP04A6bs3PaWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358031; c=relaxed/simple;
	bh=NaTFvITZcfTUCW+G4lc2WtUtuhXcqeaH1ElEbz6cQHI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gl8GTRj+R8bzbbvL+NoQE5PdGqwMedPWUrWbniTsyOPrbdJn32eRD+QJdDZSCs70i9ViyPL4eLij9DNnHMpmzAncjC0e0qPxRE/KjIA+sLdO/227be/pyGzz9mTEQpNLVCAWwyXi1FcpZl4EUpAOWtUInM/9ZV5ck/OckqFo6nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzPCTtUk; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724358030; x=1755894030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NaTFvITZcfTUCW+G4lc2WtUtuhXcqeaH1ElEbz6cQHI=;
  b=IzPCTtUkXjFZiZlce2/AT1iLxxFyw1VmRKO8V+C90kxfBLrc20t5IfHB
   wW7UBcnm3FKBLv/FMyxwJwCif21wQFtxU4Oqb4FJ0wqQco8TYuDl7hQ2O
   lQygMM2Zlyj5KFuRRpT/5f0rdoBNCjmmNwSaQls7oLDCTJ7d2JmlCWIR7
   lPUyf0Fw9G0nLR+agVlT46PNP1R0v4fQsb2YxjvByJFaImQ2ahzjH8aiT
   Ryc5a0yXW1RWN80wFdzja7usHy9wOC4m1EGP8Z2QLTCZ6kgeGpKDkZMeU
   Vbw0yEeTA4IVHdjNo61MjPvX++z5/bbtP2cFt5ssij0Tkx3ELU4qZlX1W
   w==;
X-CSE-ConnectionGUID: ysjUFjboQnC4gDn2Oq+6dA==
X-CSE-MsgGUID: aBZk6YAbTtS+FggjRusXkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25698791"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="25698791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 13:20:28 -0700
X-CSE-ConnectionGUID: owOLVu9ySkqvxhR42Af0Bw==
X-CSE-MsgGUID: EyKJ/13fRB6pN/URUSf0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="99090332"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 13:20:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 13:20:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 13:20:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 13:20:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 13:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9d2DpHU4DCzjmyRYGhwSurFoWv1681AZBkKRD3qoF9jUS2hKXiVI+3APVzHQGZAnPZNtwDLbAMdU48wBl/5CTOIBWlUVr99JfkqKVCwzhQXSe/HNO//uA6w1XKFoPnISnNh7TXstO7BigpONVY6u1l+7kfqUJB0co7mVHimBQfJoPBVcy2jMFIeioODJqRA4D/mrBFzjlBUmp/oOEgJssyJ+/2Af52WmBcyB1uUWv3aBHQltJto0Z/41BcO4ch5u2/tKVxdOfq/yEAb6i41EL6PEb8PUNo0yDCzp0/eyIwCi5EMXYBEFRanw9agT9Vgea65RB5M4ZiKsJd8CBsofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRt1QVH0VUP63VuTaG29IOD9njjbjERwJtbJfWQF6OI=;
 b=Pcoz5Q+QB2ABKOkqaDLFCgOivLXnsc1B9nVUs5zMyfw5wDyu329KD0sx7BWnNZUHdWTew+luJHD8N1MQqEIwB0jU7WzidAuZ2FZiQeOjhwiHClhAcjnx6a5nd4LOrJ0tuzqtVuzWdQj62fuM8YdNF3adHTSqpmenaNvK6OulAR5DXy7ZXvV9rMKAEs4+Fssapr62JE/s4XIZNWZENbiEp8cdEfuI2hac5u1bm4KP9xbQ/95y7Cgzs0f2BW/Jt5sFZ+oa2idnFPDX9Sw73VxuWI3ADio6wI0aFFWkWJCvlZCZRdbx4o43JBLWtSObZ9o+Ts6InNgXxd1WK/OBEIGWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Thu, 22 Aug
 2024 20:20:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 20:20:21 +0000
Message-ID: <469c7954-9a50-4822-a862-21decb1e8850@intel.com>
Date: Thu, 22 Aug 2024 13:20:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] atm: use min() to simplify the code
To: Li Zetao <lizetao1@huawei.com>, "Dr. David Alan Gilbert"
	<linux@treblig.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
	<luiz.dentz@gmail.com>, <idryomov@gmail.com>, <xiubli@redhat.com>,
	<dsahern@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<jmaloy@redhat.com>, <ying.xue@windriver.com>, <willemb@google.com>,
	<kuniyu@amazon.com>, <wuyun.abel@bytedance.com>, <quic_abchauha@quicinc.com>,
	<gouhao@uniontech.com>, <netdev@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-2-lizetao1@huawei.com> <Zsc_hiWX9uvg_Oep@gallifrey>
 <01f3dd36-e4b6-4769-ba10-cdd0856a1076@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <01f3dd36-e4b6-4769-ba10-cdd0856a1076@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: ce51ac1f-0568-48f4-b9d0-08dcc2e7d907
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3g1d29IdzVleThVWWVmU0RtaG1vTHF0VlQrajZUM0xBZVllSXJOTThTeC90?=
 =?utf-8?B?UUVJWGU1OVIvdjJhVXdPNmQ4NCtzb1d4aDNKT3QzM3VoUXNpWHBxMTJRZ3pW?=
 =?utf-8?B?U2lBdVRaZU0yV0hBZEpZSXlnb04wS0pKU2oyRFRQQmQrMVh3d09VYUtJT0JP?=
 =?utf-8?B?ZGMveW9hYTc2WkRWV2VJeml6dEsrdEsrQ3VsbTlOOEFoNHlEczN5T1F5azdh?=
 =?utf-8?B?T1pKR3BXKzhUc08zaDRqNXVqdE9haVBTNHRCK1crTFFuNlMrZ1ZZQytYWGkv?=
 =?utf-8?B?VEFMWGFyN2c1MVFhNllMUzQ0Ry9ObVFtOUlITzR0bUFDdWdEZjczV01OV0dK?=
 =?utf-8?B?VHlCTTZiczBsK2tOdEQ0czdEUWNkLzczZGZaQ3I1VEJEWkU2YVYrTE05TndB?=
 =?utf-8?B?YWJyUW5KMHU3SHdVbHBTSU85dXNSVkdlUXc0c3R4SFk2RTZvdWZ3N05VeXpZ?=
 =?utf-8?B?Z3FibjVPQmFpZ29qZzZnY0ZDUVpoN0ZBME14MGpzSmRkaVA4U2tCRjV1czZW?=
 =?utf-8?B?alg5Qi9DMjNienhVMU1Td2Fmczh5blQ3MzUyS0dNMldkdzlpSUFpUkwvWlBl?=
 =?utf-8?B?SWFIWUFPNExLT0Q0bGh2M3RIOXppNjBpTTgwMXlaZHd2VlBlNTk5aHIxb214?=
 =?utf-8?B?Q0VqUmp1WFNzU1JIOXM1aFJCV2c2U3g2TzBzSXFtL0VzNDJOOHU4LytQMy9m?=
 =?utf-8?B?NjVQSDVZcjE2U2hLTGJCL1krbEJZcExINDMwcHZHQ1R0cUtwSm90Nng3VUkz?=
 =?utf-8?B?SFBuTEFoa1ZTb2Jrbmh4MnRPRkd1U0wzd1pXSWhTODI1TlpOMlJjbmw4MEZx?=
 =?utf-8?B?eG4vbzlrWmlvSXhUYWJ5T295ZHVYTTE0OFhQcDFZK2dYdXdibm1jYnNKS29L?=
 =?utf-8?B?Q0FQK3l6U0g4bnI0Sk9waW80SlM1TUhTb0tCTFFOdmg3UlNwTzdhQVJwUDJJ?=
 =?utf-8?B?c1VsRW14WWdldmNQTXJRTXlOb0pKR0s0cEUxdzdsUWhOOXA4UlptZlJtZXVN?=
 =?utf-8?B?QS9kdUdLWEdBb05CUjNCUktwU0x0YUgyYk54eWpEZTJWUjBPeS90ZlNBWXN5?=
 =?utf-8?B?M3ZTQ2Z1S0o5K2ZCc3F6UTg4WUhzRENzS3dOdVFEeTJNei85WndNKzBXL0hS?=
 =?utf-8?B?djYyQlQvSWxPdUUvWlJQT0xOd2tiNlVabVFGTVE1R0hqbmZXZy84Ull1NHla?=
 =?utf-8?B?WC8rb0Zpdk5XSjJhRDVXcmxpU3FCa0FFNEppblk2bDVZelIvMWMvOG9aSmha?=
 =?utf-8?B?eDVZNmdFVlJST3FBdG9BZUM3VjlOZkhYRlpRbFlpMkIzWVNoTUhWYmM0YzVM?=
 =?utf-8?B?eUVqK1M1bXhUWElSb3FnUHBsNHdpemdaWjFLWGxUTUlla25veHhJZHVvOUlv?=
 =?utf-8?B?dFhoQUsvZUZIb0RENUZYS256M2ZKOTd6MmlwSGJST1F0ZmI5VWR5NExid3lG?=
 =?utf-8?B?eFhuUk9hZ0VRRUR6ZTB3TTY5Zy9kWGUvV1QzR2VxVUFCaUFzMi8ySFVWNkhN?=
 =?utf-8?B?Zi9BVEFVYTcwN1NDSlZ2NFNjcDJYemVVRHJrUjVpNEI2aS9XNFJRRk5vaHAv?=
 =?utf-8?B?amZnMHVBdFlycFc0aFVPU0lXMWdKTjdLd0FNUWozd0lGSGxHTitSOEdjM2Fn?=
 =?utf-8?B?T2lkU0tPckpNdkxGTmZ5L3FRTlVZd3RkUG11VmNkaStCSnVTQTJvYURrdFo0?=
 =?utf-8?B?KzNsK3hTbmdrTXp2UkFKQWFHMkE4Yk1McG9mSElIYTc2M1AyUlZCTnMvOWZ0?=
 =?utf-8?B?V1ZPRlhtZFF3YVJqc2wyeWRnT1AwclhhSXNVTzcxdENVR1plNFY3YlhGVEFv?=
 =?utf-8?B?ZjJmZlBHZWc5QUxBVFl5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRnS1NydjdGT2tPeWN1NVVWbnhubUVMeXgvbWlsMGtFblhZMWU4eXNSY1lp?=
 =?utf-8?B?eXFka1ZLcnN0R2pwM2pUYitzZytjcndqMWVXNWdzL1FTUGRDY0hyNmpnaXg1?=
 =?utf-8?B?YzB5ZnRvT1BmaitPRG5MVEhtWnlZMXdyVCtLVkVNdXF2UVVpMENHd1VsR3Q3?=
 =?utf-8?B?UnBSbTFpanVqMG1Tc05RRzdDbjNWdkpBY3gwM0FHVlBKbmNwaytsaktYVDJw?=
 =?utf-8?B?cDJQdXZzdEZsbGxHUFZIU0pXa1ZqeUJmV0xjMTMycHJleWFTa3FYY1laZlNm?=
 =?utf-8?B?YndEaDFUZ1BoaHUxZS9wSFdzWklCamU0T3FqVlFvbVl5SFVxVCtPZ2VVOEdy?=
 =?utf-8?B?NHlibzk4SkJMdUpCYSsxZUU3WjJDU3VPL2NVa0NDRDhLQmhGQndETk1oaUR2?=
 =?utf-8?B?ZGRDMWZNc29zVGhMV2ZaQ3BpUEgwQmJDZkdJT2ZhM0lwYU9DTEZwZzRnenlE?=
 =?utf-8?B?M2NjdlZYb1ljWE5OR2hJclM2dXdkU0ZmdVhsYkVMZ0JYR3ZpcEM3ZFRBK1ds?=
 =?utf-8?B?RlNKQkdGWEdMSFQwbC9mMC9UZmVobmdGWW1MYXpoUkwyQWdFcVJUVW1kcmVx?=
 =?utf-8?B?WEZjL3pMd21mNFkxeGxMcVc5dTFnRjVnMjJId2ltNllJMzJkekhSSW5jRW82?=
 =?utf-8?B?RjYvUE1laDlLcGlXMVhIcnc4ZDVVSG1ucy9mREhRWWxnck1sbEZMR1IxM2w5?=
 =?utf-8?B?M2RxckNYUmJkaHBLQXNac0F5Wm1NZFYwQ2pyb3lnaDZ3OGtYNTAweFVrZXdN?=
 =?utf-8?B?a1d0cHByeS9XbnNxVVZBcEZkTEtUWkFjWkw2Q3ZQMzNWMEpuT0dET2FmUmdU?=
 =?utf-8?B?VE02TkZVTXRqS2JWU2hVRmRhTVBTRWdlM3pVTEhkbmxDZVUxb2V4eWRUL01z?=
 =?utf-8?B?eXhWeUk4VjlzQlJVMit4RkRic3lPb3g3MUx5TXU2RXMxV2x3ZXFtNS9zNS9n?=
 =?utf-8?B?c0thaW9vaUVTQ2U5Q2JxazlkVlB0cVVXVjB5NlVodFN5UURSVTBLWkZ5c1ZH?=
 =?utf-8?B?K1RpckNGTExlbUI0dFFBQ0htdGU3bWQxdXhHck5ldjZ4WGhqU3FyWngvTGRl?=
 =?utf-8?B?Q09Cd3VxS3hqZm9teXE5R1EyQkNWVnBqcjA1azFwR1pueHd5RDFEME5sd3Q4?=
 =?utf-8?B?Z3lxVHkrWDdKZFZEWmM0RFg4ZFpyM2k0NHFwbmR3dUVrcU1EclVWT1hVSkUw?=
 =?utf-8?B?dDNoWUxhdUo0WFlTV2Q1cDF4dXRsaStuUlFvWXdXSWZlTXJ3TjhxVCtleGpo?=
 =?utf-8?B?OGQxNXFrR1M3NnAwV0hnMW5ZSmUzNXJyRTZ1Vnl3eVJIdkFKdjd4M3c0VHpN?=
 =?utf-8?B?T0Q2eUE4YlJNWjFLU1VSRGRiQXBVOGtFSUxjYWVkRFQ5dE5wVm1wSnJ6Zkt6?=
 =?utf-8?B?VUIzVUsvMC9XbXhwZVdaNVZUTVJYWjB5V01tL1lQd2dDRWFJZlNQWmFLZ0hw?=
 =?utf-8?B?REdXSXNEQ2ZSMER4UkpxK3FIZk1jRzVHaEg0cExHN2NXMXh5Q043ZjRZMDBK?=
 =?utf-8?B?Zy90RTB4SU4vTVR3YjFBSzBMRldTZFhFTUU4a09ySXNtSGt1YUYrc1E5UWhI?=
 =?utf-8?B?bXZDMHk5bG4rYi9mLzFtZFpyb1VwajdFSEVoaE54SWJUeHVQYkN2Z1FUZWtL?=
 =?utf-8?B?dkVBNmxULzNqaTg3TWpSVlFVM0FnNVJqeGRlMUptcktKdGo1VUV5TkZLcXJB?=
 =?utf-8?B?RnppYkFNWWVqNEtoMG5FRXRsb3REYzBDTFJYa2VSTVBiMnhxRDd3cEhnejBn?=
 =?utf-8?B?UFQyZUJXR0pmTkRxekxEanBsVytFSnVTR3VRYnN2aDJPVThDV1A1c2w3VTl2?=
 =?utf-8?B?VmxDZ2hYMjlPV3BrSTRha1Y3TGhHL3VjNHFWQ3hmNTB6aUg0Z3FSTlpRMnpj?=
 =?utf-8?B?VW9pQm9GSC9WUis5eGQ0eDJtMUxIbG83YVlFdmdmWitoME1BMWdCWkFHeTVs?=
 =?utf-8?B?MVhBeDlYODFscGlGYnNOckNkM2tLYlA2UFBwM2o2azhJUFdCRVRjVG0yYUN6?=
 =?utf-8?B?cnY3MGhWMjJBR1NOWDZyQlFtSWtOY2lhbCtJSmNTZUF0TmpUbHRpandRVW1u?=
 =?utf-8?B?V2hnWkM3Q2plZHhHQ0dPdkJMakw3QlFmUjZ1QWQzMnBiUVFKcVh3b3prSXZX?=
 =?utf-8?B?V0FKOGNEUms2VmZpeGZRaGRVeHVyMFAzNGdITGFDbFJ1RUNsT2lmZXJvWkgr?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce51ac1f-0568-48f4-b9d0-08dcc2e7d907
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:20:21.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/tzFyNjSVieuMrNkSygbO9XXIHja69nf8AY8ZDO7q/hvUmabaXE0fjlJkmXp1hJUQVbF/7KCb5asCr/2FhLBxVvz57lLRuohO4RJPiTb+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com



On 8/22/2024 6:50 AM, Li Zetao wrote:
> Hi,
> 
> 在 2024/8/22 21:39, Dr. David Alan Gilbert 写道:
>> * Li Zetao (lizetao1@huawei.com) wrote:
>>> When copying data to user, it needs to determine the copy length.
>>> It is easier to understand using min() here.
>>>
>>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>>> ---
>>>   net/atm/addr.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/atm/addr.c b/net/atm/addr.c
>>> index 0530b63f509a..6c4c942b2cb9 100644
>>> --- a/net/atm/addr.c
>>> +++ b/net/atm/addr.c
>>> @@ -136,7 +136,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
>>>   	unsigned long flags;
>>>   	struct atm_dev_addr *this;
>>>   	struct list_head *head;
>>> -	int total = 0, error;
>>> +	size_t total = 0, error;
>>
>> Aren't you accidentally changing the type of 'error' there, and the function
>> returns 'int'.
> This is intentionally modified because the input parameter size is of 
> type size_t. If total is of type int, the compiler will report an error 
> when the min() is called.
>>

Yea, but what you're missing is that error was an int before and is now
a size_t which can't be negative.

I think this either needs to be:

size_t total = 0;
int error

or better yet....

>> Dav
>>
>>
>>>   	struct sockaddr_atmsvc *tmp_buf, *tmp_bufp;
>>>   
>>>   	spin_lock_irqsave(&dev->lock, flags);
>>> @@ -155,7 +155,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
>>>   	    memcpy(tmp_bufp++, &this->addr, sizeof(struct sockaddr_atmsvc));
>>>   	spin_unlock_irqrestore(&dev->lock, flags);
>>>   	error = total > size ? -E2BIG : total;
>>> -	if (copy_to_user(buf, tmp_buf, total < size ? total : size))
>>> +	if (copy_to_user(buf, tmp_buf, min(total, size)))
>>>   		error = -EFAULT;


Couldn't you just use min_t here instead of changing the variable sizes?

Thanks,
Jake

