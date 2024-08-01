Return-Path: <linux-nfs+bounces-5209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52158944684
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2024 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753D81C20434
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2024 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8CD13CA8E;
	Thu,  1 Aug 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOIdDd7n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1C13D60B
	for <linux-nfs@vger.kernel.org>; Thu,  1 Aug 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500708; cv=fail; b=D/noPoyvEp4iICIcZQ3oC+Z6Y3wtLKKRIacTejcVVXzdW1Rq2FhJcRhcM46dSaWCKl2fzG74KRhoqSu27XwmS/16CKkSlhJvLIyK41s050+a6NIvQJzCIpDUJvva9zTHXaK0JX9PkApnYNPufzcXDRk4idooX7Z9ba8aVOMeiXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500708; c=relaxed/simple;
	bh=VqpzRzDZNXV6j4vxRobxo54U0P8S9u6fumCbACENw1E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nnYHeKmXU2TTdldBlzHkh5xZcJQSKLKB9uw8JvcSOsWLI1iWHjYIbEIp3ffASkAGU4/ixtk9dcDNxk/Ugw7MZwP2svtY4GJq86pLKKhtrkWXCQT7WZESPXlyFrI9wQ4dBE1g1ebx14hr5e88/LAHB+8za5PFGngzt8ANdM9z9gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOIdDd7n; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722500706; x=1754036706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VqpzRzDZNXV6j4vxRobxo54U0P8S9u6fumCbACENw1E=;
  b=GOIdDd7nwI6t7mDmDEPcZtEMar+znfl3Ty+wSD3vtiYPyTJucu697JNK
   AmdkeAVulJmkjlNzXgn9YDjc2WNxoSL4MNpEtWlzP4YkVIvFogh/K9kSt
   Xb65x8+1rpLoq0iQArlbzCBw4bzRaN4sOMQEbc5iG7rS38QcScxvmpkfJ
   TuI1IfUpQqjOO9V+wLQ5Y8GYgzty+NOzEFWOw6sK1ZtYdEBN2xYETsJvx
   P5PmhZnhRNJYCtM1B8+4Ihso3M4Atc+n6VXyumt6MNALOddjq7RsmZD/J
   DCk8FNpGICchMzVV66rHqsjLkd6QagsM1PaI5OHOcKTSWAL6KUOQWvUYz
   Q==;
X-CSE-ConnectionGUID: v0SHe7mrRs2XnP3iyKzl0Q==
X-CSE-MsgGUID: t7SF+YMFRTSKqfGMjMMmyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20597516"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="20597516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 01:25:03 -0700
X-CSE-ConnectionGUID: gN5SJqcHQkS1mojcMyJWuA==
X-CSE-MsgGUID: HGhWXBm6Reiyldku7/wkzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59987267"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 01:25:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 01:25:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 01:25:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 01:25:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 01:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ya+VpDY3zFJv4k+Hy3awDyxEJRz7fnq7QNbau5ArrqR6BAA/KsOeyMxUFIP/f34ca9V62yPUSQIlWXF6KlmRu0RkP57PW6ZiT7YAqlkAZoGfIz1zqQ38X6QumlvCqZXj5Wf4jS6zzcR1CKiPsHwOaqVnmQoAfBPrnd1ovGnP5BhRHs3QjLE42yzRb9wSJImf+W6Z2AYmN83T0hGCUqCv2PEr01a2xIxdz2ZvkqOrXm0E9kPewYsqJW8SceaLHoclF5vElKERnoh8VoItq5OnEKgnxhcbPny+phfLZn5XnQQNt3JVLpG4i6WXU28cf2ZENqpacBxqygNhmckOGVZ8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q/nWRTK34QkKwuhDpSVtD1Vj2s8MD7OISjVCt6I62Q=;
 b=gYZO5S4LH0ZB8cjs200buHEEfrBB/ZWQzHCU2oy0l1A17gqUMzWFcfpcKmTACbX25d2tdmaVkkPc4XR0IFqsnJP6yYVK4pSwWYl7bZ+t8KKXh7K+UCGgUba/K/Pn7WhBTHoBKx6AI0uoQ3uvSty0jESSaSPYtnHxEDtEh3bamlSz2DdtHQR0UWb45/7NACeRRshy1tMtrx9yjN1Mo9fufalxgiqhSYn0leJ+nXnmoV2Uy5yi9KfZ4juwm6xxQ4ThPTuEwFnufgN0g9Ep20KbDQPh/ZjH2/z0tJBKwmRH329Rhhjwa0ooEIMhqi+1GlBywz7nEys3zdwkYfJgHjsz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 08:24:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 08:24:57 +0000
Date: Thu, 1 Aug 2024 16:24:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Chuck Lever <chuck.lever@oracle.com>,
	<linux-nfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [nfsd]  48d45b8a92:
 UBSAN:array-index-out-of-bounds_in_fs/nfsd/nfssvc.c
Message-ID: <202408011636.9b233ef3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: f8672677-cf01-4c38-1945-08dcb2036db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RiHHfYQHh770sQ+S3cQV8JLMVbnTIby0Ud4BEvQCfv+N2b/r69Jj62mId3vY?=
 =?us-ascii?Q?DSZ0OSOcCj3HAbWnp9keMSsEp1u1NB7nW+6grOOsjD87g9oDdrlhWqa5yLC9?=
 =?us-ascii?Q?kfD9utHXnm1A41p2JnP+lr8IeeV2A+jatvn5eRjqeWhfnNg0QPK8isgl4w8l?=
 =?us-ascii?Q?4N98Qmx2jbACRreMiYxqLGhl7+GhGotNe4REBA0yVx22hsjsgxfiwRMkC2gw?=
 =?us-ascii?Q?9y5fRa6l3bd2HzyfxIPK120lacwtF4Rc7qnq9qiTsUV7I5cadHZj4OwwgW5D?=
 =?us-ascii?Q?VMj8cTE1T6Mmd2UMys3wkBpuJF8D0wjr0VS7zMpcACgHfKVFRhBywwV3rHTP?=
 =?us-ascii?Q?hNUEhCXwAuKEE577jTh/SULH/4gqh5a++FVBAkDUgJPsKwrcFUGNWc14+CQk?=
 =?us-ascii?Q?IC4lM3Cnx/09n8n2+iAD9i3A5mry+mMmmSezTyCqtLCHR/fXlAnHXMSsUtDt?=
 =?us-ascii?Q?EJ6VwG4YTo0LQBvQgkpiMM85d203HdqIAmTVxOHibpSV/cu5PwLLFDmixmza?=
 =?us-ascii?Q?AOloaG79BKa2s6t/Ct2GiK2sM1UHoL41pV2oe1xj+4flld7BuBIckH0cCTGH?=
 =?us-ascii?Q?gM8DSO/XerFB2P3F513c/02hbl+LENqTv09gBakgjxKh/HgGa8dGjw5ua3mT?=
 =?us-ascii?Q?ZuIKAbFkE5BhJ+D9LoQFpOGli1gd8Z2nJJ2ESjKg1CQLq2B34rtTNSMnxlqD?=
 =?us-ascii?Q?Pb8AKJWn0b7FrA/17oYm5YzNgl9dN9LuoHE2MWdkMc/d59ri/kOxg4jkF7+j?=
 =?us-ascii?Q?rR61odD6xPwXVAPekfBKK4iyBCpI7plhSbUJ1MRSyh0F26eYAtje6Oy5EFER?=
 =?us-ascii?Q?uv0Bc8Q9MgWNQ84kT0G3RDroWdBviXtc9+eiIoHHLMrmxQ9elszTyzRvAFY6?=
 =?us-ascii?Q?nxm8xN6k8KRTbkVSlg/P2OzY8Z6hAIr3iA1o6/Bn4AvJNcaeE83tTaDA8pzx?=
 =?us-ascii?Q?MmJeE2MZtgrV81lmaYVCwA/lG69maTn0HreNKgiOqbO5MMTpVqKGwhNb+XcY?=
 =?us-ascii?Q?IFZKKE4ItwYVT7/MKeMmeEVBrULIoKf9Kh5aFvr/T0m/hRnfOw/Sv5kim3uf?=
 =?us-ascii?Q?YovwWY0FORiJU5P//PWLiuF6ejvynt5ucgXtD1d/zkYDfNR91KgASAyJmD/k?=
 =?us-ascii?Q?z+ZGvKhCQytNRrnzKZmYPhVe0E+Ssbp/Mw1XW+77IOLW98gknBKRVjmWDI3q?=
 =?us-ascii?Q?4P+kSJrMq2/hCMzvMfTzwqwVSIUxFFLCmFu3dgVMdow7egZLGropR7UPy+xr?=
 =?us-ascii?Q?42WVaBRIvBHE0MzvavsucZ0rUSWdV/I3JlChvyqJB26pf3SWmv4geuYmDNre?=
 =?us-ascii?Q?VzzQpy8S1618SlvtMq5nEhlx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+q2jbjCfbsKMYnYBkA+/Jl46PbVEuqZZNeBaiZwxsFzqEhyQ0iehKCh+7i8Q?=
 =?us-ascii?Q?f2a1fyo1FGgzmxDlMZJ6Rbum3AwWtPc8RvCc3Uotcy5coiL51CYucA7AdvpN?=
 =?us-ascii?Q?CAjt4AtqfzusEtriS/sbZE/SZCdfZOLRPSfWesX35nkS2bxbHgcChAbdB/Ah?=
 =?us-ascii?Q?pnpOwWWgA7diWYRWvvpcpou92YHjLyXymBeFPuGYAUEd5E6mAAH7DgS9p6N2?=
 =?us-ascii?Q?VmqlO8kGwoRhvpsbfuPOq2noiWcV53uD9oC6ye39wJbT2RLsFc0S3zzBJsBT?=
 =?us-ascii?Q?3OwVgzTgC8ZuqV73069PPohqYXr5goJi8kX+Hyg5kFWbAF28E7nZnOyyvqGE?=
 =?us-ascii?Q?SJl/aLjF1UPz/pZYin7uZefi/or673K93Hmd1VBhFJZPBZcRyUZC7bNDmG9m?=
 =?us-ascii?Q?ekKxHKo6FqRKolEXBBkzNuubAloqUHdiTn0SmHYAJYR8TFshMvv2hXofzDZv?=
 =?us-ascii?Q?mdw+G2it7lA9UIP0r3ufIjZCuAnMRy3l3R5lBuAFE1b0bDVTqBOMiZCyZpmS?=
 =?us-ascii?Q?/YWEHynNzLxxNa4tl1BxWsv0WItYoAPKBE6eacHQFHGxLlhSVdCb6w4WF/pC?=
 =?us-ascii?Q?Yt5xQP3J5mO0O+JeG7eWByX/57Ij98gty54vSDqNuYa8ytqy+6AXCEvvsIe1?=
 =?us-ascii?Q?3T0NrEdU84lHWwnMFQQP4SL6mTsIf9kKnWHB2jLsUnnYurGmwFR/ls1S6x0w?=
 =?us-ascii?Q?7FndBwa1l049i7tUzvL5TMn2gPhBUCTPqrF/8E01r50BHsEPXyP4IyeKTOvx?=
 =?us-ascii?Q?9Zg8xj+C0JEpIEqIClF/5FqiGeezc6rhxJ7kBtgI31Z0ADZLWGtQZCDHBgKe?=
 =?us-ascii?Q?OR6LV2K77o8CLfXjKfmBiqGoL46r5iV5geEHsxIzZLC2Exe/e8GtmIsUQMV4?=
 =?us-ascii?Q?8yd0C6IZsgGQn49D73D47ikaNLCA6yK7U3dqczux2Cjh2NP5bfWi9dHYT0ff?=
 =?us-ascii?Q?Gbr4UXSGMDtFcyEtt+F/1rScY5W6nQ0GiMHn3eFnDchsEFcb0P0jTffZqunx?=
 =?us-ascii?Q?evP8qmdVcBRGBf5Fmz3Z0+Floq5uteNyY7Z3h7PVw39y4euuaUEseqP98yii?=
 =?us-ascii?Q?MMxjMTVYqs35F++5QtOLL+CtwLlrSC7/8vgRBKzt0MSjvNnPerW+PnKl6xjc?=
 =?us-ascii?Q?dOITRCjuLb3m/Mz1peSrk4dw1UN4OpHns2sVE5qtr9jN/GOP2hy4gsfQ312s?=
 =?us-ascii?Q?rTU/kPUJ0spVoFOGMdJJlOxn+WRJWa6zkpDmcaWhmFVmrqTJ9iQvU36S61RN?=
 =?us-ascii?Q?P/vjOcEOYqhGVPL6PYTHpztruSdlToTV5C2ByHT6loBRcnQM8XKEC6PF93gv?=
 =?us-ascii?Q?FpCJNZ7TUNXH1B07wXLna86YEjiIJySuMeMzm/za8/FAWCu8xL7VW3UDRhZ8?=
 =?us-ascii?Q?ojGXLrQW6tn5vS0ZvK/R3/wSUBlfuPzFXUcnEgQNL1xcDoDda/VaBWqXWp+g?=
 =?us-ascii?Q?At6N6h1WkjS757ldFj6PHhMZlrIvVNzSUOwZsuOBK9I4TqhrSNQYB94NtyYd?=
 =?us-ascii?Q?m/usniHKHycdV9lLPnYUZgONDhsV5eraeSeH5o/ZS9lTvrwliE/aWdiC9t1t?=
 =?us-ascii?Q?bXJVoEw9d2hoCTMsokT8fKINFTGxdphx1gNZEq6uj37DHUv+BmnkDW3Ot9D+?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8672677-cf01-4c38-1945-08dcb2036db1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:24:57.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNUzOuPh/TF7Df1h4kR+c79iMOcfD430H8N2kU5wrUyRr6JnaPIJXJhe0VL78f0nOnAciQAj6ErSf2Kk7mS1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_fs/nfsd/nfssvc.c" on:

commit: 48d45b8a92098fd0ace1915e822b6a911d68e9f0 ("nfsd: don't allocate the versions array.")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master cd19ac2f903276b820f5d0d89de0c896c27036ed]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | 380cca57af | 48d45b8a92 |
+-----------------------------------------------------+------------+------------+
| UBSAN:array-index-out-of-bounds_in_fs/nfsd/nfssvc.c | 0          | 12         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408011636.9b233ef3-lkp@intel.com


[    4.884788][    T1] ------------[ cut here ]------------
[    4.886401][    T1] UBSAN: array-index-out-of-bounds in fs/nfsd/nfssvc.c:136:22
[    4.888944][    T1] index 4 is out of range for type 'svc_version *[4]'
[    4.890804][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc1-00011-g48d45b8a9209 #1 49a9f3c8c569f643764c5d3c5c4fd0ac6de5811a
[    4.894224][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.894294][    T1] Call Trace:
[ 4.894294][ T1] dump_stack_lvl (lib/dump_stack.c:122) 
[ 4.894294][ T1] dump_stack (lib/dump_stack.c:129) 
[ 4.894294][ T1] __ubsan_handle_out_of_bounds (lib/ubsan.c:232 (discriminator 1) lib/ubsan.c:429 (discriminator 1)) 
[ 4.894294][ T1] nfsd_support_version (fs/nfsd/nfssvc.c:136) 
[ 4.894294][ T1] nfsd_net_init (fs/nfsd/nfsctl.c:2252 (discriminator 2)) 
[ 4.894294][ T1] ops_init (net/core/net_namespace.c:139) 
[ 4.894294][ T1] register_pernet_operations (net/core/net_namespace.c:1252 net/core/net_namespace.c:1325) 
[ 4.894294][ T1] ? down_write (arch/x86/include/asm/preempt.h:79 (discriminator 10) kernel/locking/rwsem.c:1304 (discriminator 10) kernel/locking/rwsem.c:1315 (discriminator 10) kernel/locking/rwsem.c:1580 (discriminator 10)) 
[ 4.894294][ T1] register_pernet_subsys (net/core/net_namespace.c:1366) 
[ 4.894294][ T1] init_nfsd (fs/nfsd/nfsctl.c:2311) 
[ 4.894294][ T1] ? nfs4flexfilelayout_init (fs/nfsd/nfsctl.c:2295) 
[ 4.894294][ T1] do_one_initcall (init/main.c:1267) 
[ 4.894294][ T1] do_initcalls (init/main.c:1328 (discriminator 1) init/main.c:1345 (discriminator 1)) 
[ 4.894294][ T1] ? rest_init (init/main.c:1459) 
[ 4.894294][ T1] kernel_init_freeable (init/main.c:1582) 
[ 4.894294][ T1] kernel_init (init/main.c:1469) 
[ 4.894294][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.894294][ T1] ? rest_init (init/main.c:1459) 
[ 4.894294][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 4.894294][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    4.924077][    T1] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240801/202408011636.9b233ef3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


