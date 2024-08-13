Return-Path: <linux-nfs+bounces-5342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EDA94FE2D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 09:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6E81C22A7E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 07:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAAB44375;
	Tue, 13 Aug 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSVA9SGl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52A3DBB7;
	Tue, 13 Aug 2024 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532409; cv=fail; b=YI/htE8jGe8/A6be8oUj6yhdXpH4r4fGRNk81pm58yvSvk8rA6XkPCna+GKL6j4uBXKEjMQH4uov5iLTxqhFXM10rpvwARnlooL9MD+AKerSmORYkYIaaL7ITIIpsY7U5Hc0b1Tps0BHLxWxugqTgAJ+QBV1adjFuxcuiLt3Jdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532409; c=relaxed/simple;
	bh=WaxGSjxT9KiF6Ha/oELM56WpPfAN9+1dqQvb5W/AFJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sBncJg5ERJl/qaR6PK18QLpA8Mj5W5UOLi7ZZlpwx7o0JxD2H9ugLxecgIf9Xu5DfLSh+bobT/1jsEzVtFckCGY4ia+kIjiWQV/xv5JPW/0E1y2b1H0t8IbfZtzcSk5l0gTjH/W/SB64E4r//+3XqFychjizdgWKQRjpXAZk1ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSVA9SGl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723532407; x=1755068407;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WaxGSjxT9KiF6Ha/oELM56WpPfAN9+1dqQvb5W/AFJ4=;
  b=eSVA9SGlUkZc7SBNH3EGknguK1mpwYqP34iyLFcIO+NW+NdWJvWJ2DPR
   FEm/EMMjHn2uNY2mgwVAjIkWSPVDNkGNRJgk/bh0PfavTXEXqzFleSpTt
   XW0rWJPf0hbQSwJUZozaKFHV3iggAHp+pwGaOLbuHIUE2JlGRopBTecOp
   +b9xKi6AbqwPggO/ssFVU1WxXZcc2ST7IGH8DyfHI86dZXBGaNeLPleQp
   Uvg7qu9JE5fuwCfZrPXVS9ks8hQ6XxuVFqd3IwV3qCn5t3Jj93EoOtPGT
   KDqBypprTvr4dtot/vn3MfqCg58x3P1LmnVYrHD6UiO5WijQvnQHO/CTj
   A==;
X-CSE-ConnectionGUID: vGV4P8tGQa22HopnewzZfQ==
X-CSE-MsgGUID: hKfaZ60+QAuYDgz/rNp9gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="47079046"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="47079046"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:00:06 -0700
X-CSE-ConnectionGUID: zROJhEQUQ4+b0W1G9lrCWg==
X-CSE-MsgGUID: MvmA9ZF4R5GOsMyJRqm5hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59302688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 00:00:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:00:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:00:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 00:00:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 00:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEpiEsEpL0B6IF1WbBnc64D4ogOAJnXK2Gtqgq0XLEVdC8fCkHca5qlANIE3d7SRQIihiw9f8H2e2QbOOJIShNo1ppXjjwRrc5D9s0pCHsS7BZ4M90t5ATWDRsd3/moWnj6M0NamL6ariFei8R0vcMWSKqxw+zGm2ZEqzTYakbfnTath9XUAIX7h/DcFkexzB/BQjdfbLxBHhtwtk/nC9OTCnqa9lU46jpGGAivVUdAY8XvClcNpdULbxLSQ7Tb/8IQa0Gho8tT4LK7InRHIYGHKxoEN2tLmitwXE6DKPr2tPEKXSEBjTpzIx8+D+jEmfDbYeVtsdYkh6+aG2Kyb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kF7zz10t2wYEXCN6ESrYlZNrkonSkNo83Du/CrqoGY=;
 b=xvpiAqu0LPrtJmIaAcCgZLD4Z86cq4ejsD0zHVdX2cwLJ6Fu3ZrEq1FF25k2lxgq0BrrmvhBYgzEZSZzoI75OC6plgDxNHuZqSwjleoJbQsG2+PhoALc43lH3iiQrfoT6JT47vBgP/tjfi7SYjETZdCZTNl21rKvndkPSkQtcgJXNQPcwq2fckrCBO00h0bhdNJ1TMaKMeHyuOleXgRSzt6yYvJCaQd6wzZxVgG0sxVdG5fHeuJglVViVd9DBgaIjsj60kGow8gq8WL4dk/Bwwn2TNUUoe5aUYS7y1kIVzRf6T7tIWlX4NYFrsFPFJitN/K1SQzJB9hgMGiW7R1jDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Tue, 13 Aug
 2024 07:00:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 07:00:02 +0000
Date: Tue, 13 Aug 2024 14:59:52 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s
 -85.6% regression
Message-ID: <ZrsEaIEbjpT80P9/@xsang-OptiPlex-9020>
References: <202408081514.106c770e-oliver.sang@intel.com>
 <20240812112145.GA15197@lst.de>
 <ZrsBlLtc5g4WbuP2@xsang-OptiPlex-9020>
 <20240813064955.GA14163@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813064955.GA14163@lst.de>
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 252f7fc6-e5f1-4dea-2d05-08dcbb658dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jh5Tae0+i5q5GzCgARlfx9BsOID3304FK3y8uBikDVjo70Y+g6eJKzKeO5eI?=
 =?us-ascii?Q?YG8sXsnXuTvIdByqMbKjpgacKvcF3bzUOQG7BxHCd32u7LUR2g/r1hysNJCR?=
 =?us-ascii?Q?4ZPArru1UnGEqP40YMEAY9rNzg7w/G8MqY6NSr3tHc29emO68ki6Q4/FA+Fv?=
 =?us-ascii?Q?xiDuc/qAPFfKe+0zvWMBpxh++myuzs11cNRDQSjnpnCg6vnNeUytUObNnjgB?=
 =?us-ascii?Q?4/rhscIVvJZALXTI2FpD+4HQkuq+ObsA8Y0mHO8dD0UrCz6BCcMWZpiasH+W?=
 =?us-ascii?Q?iDnmoHDB0HTweOipjHrhFJp2ABb9BohZYBoSTPVYAGnCnk9DDDs0XisHVjab?=
 =?us-ascii?Q?QZWFLVRSIABio45PJfeuBRz+IuD8gauukG3fLZ50Hb6vNuESH2pToB3aA/jp?=
 =?us-ascii?Q?5z3ttxKUmfpLY6PhxOT+6XKSCamSdp78GWol6uT7zZ3TK1lykExhvBKzZT9U?=
 =?us-ascii?Q?8qKK22fa8HD6p9U640ZFNJm9iTFC3qvIb1up/M+R5z8KEcyKzl86hpBK1cW/?=
 =?us-ascii?Q?fyZNexKtvQUU8HDO1PpRviMjxTi0M6RTyF8rqUnnd7b8TYs1mrfgdP6hXXiQ?=
 =?us-ascii?Q?BfSdY7O490mQ+Ltun6ZTnyn091mWEjSAS5dUwyoppRr+dF7ozhdEnX4M7v6a?=
 =?us-ascii?Q?YlG4tYrk77iJ8iSawFOA58SxVpoNaaHUveLzKDz5cMsczp2D4dru+AnZmo3a?=
 =?us-ascii?Q?hNL7yxyu75zQ8m0//BLYt3j5U2dWI/mjGg7b+ptY/s1O+zlLmPRF6JpUJvKj?=
 =?us-ascii?Q?T3GfRt6dsdDOnItlNkeo0SctpwCA6zDLGIofAZ0cTmXDFA1bH9c955JwuuuP?=
 =?us-ascii?Q?wKagOT37FgGuklDGfmFdrsVhXoC1TOocrTSF+IutPVnlyyNLJN3cilXX7aKT?=
 =?us-ascii?Q?gAiYZAJ7rJArX8mVx0W31rD9R4GZnBCZsDFJMgxYuFMzv6QKGKrLZax7FIZo?=
 =?us-ascii?Q?JkzQ1lySqYetlkcWV2472Vd+/4haURXP01YuZXMkgRMSRTVw8YU9KlwoYEOF?=
 =?us-ascii?Q?WOgF10aCPlnQalfA1FCj4UBEu5LaOc7Ahy4o+t5ZHxYJRL8aF8OrBgikmdM3?=
 =?us-ascii?Q?Eb3UsxGLBtKR4IJzReEQPVyTkSWnFpjCTjYq7hpyfxdc6Zs3H83cWbwhYiHd?=
 =?us-ascii?Q?N4x7EU2BKpdAd5QmJBp438tGD5WQge70NFnmeZ0B7TjBh5ZL64mmkVxR6lyG?=
 =?us-ascii?Q?7gnqcC7wndBQ402sdFazwE40Oao02GRBv08G7ggBtcLF6IskrJf9Rtz7vFHa?=
 =?us-ascii?Q?+X7MYQikFqOEoJBNornuQ0qtGzxtwWBA7rmfJ1+P7CTEXdTTok7B5P2t6YSW?=
 =?us-ascii?Q?CS4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7j/LZt1WohbJc1jki3ZGDko4yeOx3HsfvHpTAvVOmu1u3Wnd3mxA6xlL4Xqk?=
 =?us-ascii?Q?gEo7pj6DcO6GqNlHW8s5w4S0anxkm4KMZdoJokg67ClHv+J3/lTcPYfE58rk?=
 =?us-ascii?Q?nD6+KLD65sNJhulnZUcM1dcVeVcV/9naqneV9gLp82rV63j9kheaxO6RCENA?=
 =?us-ascii?Q?32JkRcMN7riTTesQhbQbIPyU/onfXh4j5w2VoXahxmuTDIJluFWOUCNEVKnk?=
 =?us-ascii?Q?jGUwJuFZDTFJvBKPNeJJTZwP/K+jB5gEgrku94H25SJuSQ8tGCfJjM5lN17J?=
 =?us-ascii?Q?j9o7BWi3AptyW6r6lP0GAJx2bR6DZ9Vrzc2MpufoJ2E+u4lN4G9RtLLFrpwj?=
 =?us-ascii?Q?6SqARv1jsap+DmGUEOG9UR5qotahU3PCi7bJi1+5cN92JM8btpfbg6GVpLdw?=
 =?us-ascii?Q?BOfYz1YNXJPHydToPkcyI4rS+ze0Oi3JZz+P/DqbUFrOOzcRrSwtomMjfRGW?=
 =?us-ascii?Q?8iJQdy6zR8BW01v9WKML3p7aIkSQyYzuCdDIxhNhsoZEcnO5RZxMhuD0Qv1j?=
 =?us-ascii?Q?MkZDyfBeOwhPgDqycq4h1JQjQslTFJ6e6AfcQeJxOPvBJbwQc+0mkwTfmw4T?=
 =?us-ascii?Q?oH+COZ60nhhzS39HMQvbPNJdEcxsDgGt+rUuZXPYrl4tSuAkig1X8roR8jep?=
 =?us-ascii?Q?PE2PV9EGcIQTzGW53w8y3KlUf59o6n9I/baVkwDuFPEGUGLZzhfq00gX1oV5?=
 =?us-ascii?Q?F6N7FhO0CIuV3E7HLSnc7N+lSABP2+v25YSBJYPoPoVCm6XxlMb5kHo9lYYS?=
 =?us-ascii?Q?4GjyYSBzg1Ccy0Vy9iIvoKbPPNbY5zpqhx0i0SnpR789MeoN8cV9J4+vxbGS?=
 =?us-ascii?Q?VJDrLOUrsCLw6UPPQczlVwR7KMDDL0DzGhG/ZJjOvpXxTcWpX2lh2Ckiu84D?=
 =?us-ascii?Q?91zxSm/8L0OcWOGki+O+XnUnrahTLdckKgTMGOr0iiZhTjyYMvHu6EMgDB8f?=
 =?us-ascii?Q?Ai2GIAgelQEOwnccYQA5n+dMwUlXRBGj38LS1PeldhggJhnceksBlSKFAK12?=
 =?us-ascii?Q?TIcWyhlx/33bRgRjzNWNezmjN3fEi8UWhGd3SILXuDnTcHDfO6j+p6TiJvkO?=
 =?us-ascii?Q?TubWSopDP6MjQLoFwWPZbZGMWW+vN61REh4xCG4LKqIpxx9fK56J8rzbAFWE?=
 =?us-ascii?Q?I3L3OqTnCiiKvOOosuR+bOBNuNkWB6LCz4hL6kPexZXaW4ZpHEFPVI9gfFZX?=
 =?us-ascii?Q?0tG7jH0SPhaBBH/zG55KuO4Ep4sGDEm589UIf0A5wNWhJWVt5ih7lB/HN8Su?=
 =?us-ascii?Q?V8D++j5d8VjBEyrTTy7DNnYG2qMg3EJpfNH9KocYWG2Njt01NHNyUIuTkMp0?=
 =?us-ascii?Q?wiwkPOH4oZ00Fr7DThx/M9MyP3AykcnWsnnACBX0fA2+Ar0wM/ljJZ0rGCcB?=
 =?us-ascii?Q?71O4NsZClTV41aSuPFQM2ss+I9jK4gN4VUatZjJgNY7LAKgN/XN3kgDDDSLB?=
 =?us-ascii?Q?5aZQ0enOiq9PImRPSYHeDorIJbhwrQovZja27DOE/O3pXba3arDM1p17CSjY?=
 =?us-ascii?Q?0EnCQSngRMAH84f2wpSMxfcwI2xS5Yct6yYzh+Dlc7JHDoHH8fui7MEXn/Hf?=
 =?us-ascii?Q?lE+qJ3CMDdcgEe5TbzA2232uZfzICRMJzDfISSsq3+nNzx0G/dsqFUhBrt78?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f7fc6-e5f1-4dea-2d05-08dcbb658dc4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 07:00:02.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++aBUYPUrM5d0xUAW4nP68fZXbSJi7ixpZ9kHJdv+qw93+dGsb30T7zA1pNbdQffqk037Ab6vjI5EkwrHQg3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com

hi,  Christoph Hellwig,

On Tue, Aug 13, 2024 at 08:49:55AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 13, 2024 at 02:47:48PM +0800, Oliver Sang wrote:
> > no in our tests, becomes even worse actually. detail data is in [1]
> 
> Thanks.  Do you have a good summary of what operations this counts?

sorry I don't have many details. not sure if https://github.com/filebench/filebench/wiki
is helpful for you?

and a raw data run by this test looks like below

2024-08-13 02:24:56 filebench -f /lkp/benchmarks/filebench/share/filebench/workloads/randomrw.f
Filebench Version 1.5-alpha3
0.000: Allocated 177MB of shared memory
0.001: Random RW Version 3.0 personality successfully loaded
0.001: Populating and pre-allocating filesets
0.001: Removing largefile1 tree (if exists)
0.002: Pre-allocating directories in largefile1 tree
0.119: Pre-allocating files in largefile1 tree
49.469: Waiting for pre-allocation to finish (in case of a parallel pre-allocation)
49.469: Population and pre-allocation of filesets completed
49.469: Starting 1 rand-rw instances
50.472: Running...
110.478: Run took 60 seconds...
110.478: Per-Operation Breakdown
rand-write1          11769ops      196ops/s   1.5mb/s    5.096ms/op [0.002ms - 1567.054ms]
rand-read1           49402ops      823ops/s   6.4mb/s    1.214ms/op [0.001ms - 1567.058ms]
110.478: IO Summary: 61171 ops 1019.414 ops/s 823/196 rd/wr   8.0mb/s 1.961ms/op
110.478: Shutting down processes
2024-08-13 02:26:48 sleep 100
/nfs/sdd1/largefile1
/nfs/sdd1/lost+found
/nfs/sdd1/wait_for_nfs_grace_period
2024-08-13 02:28:28 rm -rf /nfs/sdd1/largefile1 /nfs/sdd1/lost+found /nfs/sdd1/wait_for_nfs_grace_period


our bot parse it as:

{
  "filebench.sum_operations": [
    61171
  ],
  "filebench.sum_operations/s": [
    1019.414
  ],
  "filebench.sum_reads/s": [
    823
  ],
  "filebench.sum_writes/s": [
    196
  ],
  "filebench.sum_bytes_mb/s": [
    8.0
  ],
  "filebench.sum_time_ms/op": [
    1.961
  ]
}

