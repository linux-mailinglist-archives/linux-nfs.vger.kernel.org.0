Return-Path: <linux-nfs+bounces-10921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E2A72B96
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9EE178D80
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3442080D0;
	Thu, 27 Mar 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSUekB4d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543C207E1A
	for <linux-nfs@vger.kernel.org>; Thu, 27 Mar 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064530; cv=fail; b=NiB3dko0DoJsaKeX3CZfTywweopZu+LyNSpGQzwGTsWYoXrLgBlYL9ekCDv0LZ4QnaFcYlpXnx72Vw5vmDgE7Q0r5fmocuCnW7draUf120Is0wqMegHNK6h7UwQYYsjqJFKeFvOGFe1gInbiupdnuzuuu19j1814NNX1VXRRX+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064530; c=relaxed/simple;
	bh=AAPBVbi1y35TBjval3vannkKaPiiASh4Wtx7k55sgo8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VwBhhPUF212a3SZpgmj84h1JfjQLLdsPxSU1xHxopTlaNdv55aE3lf1dlPNDqkojjd1QtxB+NqFMPKrL9npxdCKzmY75s8OlxDMGz6XJnM0ASX30nj39m8lDA6iD84aKeleCFOXHH5vK7eHGwP9N8Fdi/wPuzsCgB7mbRzwPFyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSUekB4d; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743064529; x=1774600529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AAPBVbi1y35TBjval3vannkKaPiiASh4Wtx7k55sgo8=;
  b=LSUekB4dwmr+B4stE02wNC1SgasIsOYhBSjPcGUuyq7jgjCEE3IxP+7m
   zHMYejKdb4FMX+zEoSOdOZyTkjC6UxeCnF9b/5TAWFIiEKksfnCJrjGTu
   jEJlABDtsdXrgAhR5BIvNp4ILm2pH/npwEsUXJHz6K5I5zGNHuExHQxn9
   Zxr/HTIPrSVC9vGlUVe0lBx/1LoV5VKLeuFxKNoYTdmLfEm2taKI8DRUi
   on7faE0IGE3p8mpdcLnmvVHZL9/fPkHgm8u4BxUx2bjOvdXGHTb0U1EB/
   QH2JaNMMvTKOFNffxtyNT0MF+GbHo91sMvaFhOEB5EzcXcoslLaewFL92
   w==;
X-CSE-ConnectionGUID: 4jeGtRZjSQmBoBYR2TTUog==
X-CSE-MsgGUID: O923P03DS4iBtUrADdn40A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44486316"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44486316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:35:28 -0700
X-CSE-ConnectionGUID: 10GPwuiySjmQZcPdsK/cQw==
X-CSE-MsgGUID: K1XXIDS5Rry11LSa25fiAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="129223066"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 01:35:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 01:35:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 01:35:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 01:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTus4gD4ARrYEZB0cGXCgxvZ4DYJy+czgkVH19wzoFtaTSnpX4TV9UYIhuddJQ/WETn3p4r51VLeEXxU9dgGYRblZU7vFW9J8e2gepqlYC/+vxVSIWqIJ6Ve+HNjG6IqDCH2OxwuEKsmFrPH6xDElUE3G5sW9rqU1w2Nbd5b8A0J5bzNDffrXGRbzHqXWZ0iP78mRf00ygjSm/731d/Xx+uodwT2mQ6zjBJXYrXTp0PYG7U9s2xdmxx1KHBGiiOZOxd3jmKmz/Ry1xyFwiTmiExq5XADa3iBYUr1IVDetJZ5K4aP9s7+9reQoaU9vjwQwAKlfj4bYBckENwENhjkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDuKk8DhvDw+sVffD5n4e/jjTbO5Jc27sfPmMKrZAb4=;
 b=coafG4g8Rs7o7b2K2q8iKa0qSUtpeUSdXoQ+5ajHYI83mEUgyJi+2130tpkLaZ2jhIC1khqCn95uHgFr+u7ELJROk5WTm2qyltp0DGpDLn4hyhR8/49Y/djZClyN8t25GcLPIGMw9LPau0zkCMdP4X/LOBRZoc970xDc3/pesKHyWTeEk8xJuACHwJ6kes3a82f0IULWR4vHAHBwLwQuRz0o6HI2TeP9ipoG4abo9IlZkDu6sKG+M+YwUYLKOuJsA6RxAiOp1ilcmyp+vexqOhwuY+duOxBLKel/E1dXyHeR4YPT9+ptFNy32K840IuHn8Ybb+TTySBc7GGdRWCDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6906.namprd11.prod.outlook.com (2603:10b6:510:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:35:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:35:24 +0000
Date: Thu, 27 Mar 2025 16:35:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [jlayton:rpc-shutdown] [sunrpc]  59a0395397:
 WARNING:at_net/sunrpc/sunrpc_syms.c:#sunrpc_pre_exit_net
Message-ID: <202503271441.962cfd7a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f78ff0-ecc5-4583-3318-08dd6d0a518f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gnm1m0yxXIV2pQBEhXrpX843XSIQaU0LM7ksEpELqtuc9rTJ4HGuB5LS64vU?=
 =?us-ascii?Q?29nxDioVCkrn3UGZRyTqLELaJXTVG1qBmT+URDgDPK3O2A7Hfl2gr4DRM56m?=
 =?us-ascii?Q?6nC9V9OBkQdAugtRauFIANnhYmGK/xFPNZ+KBiA3skj2E0TNcoLiZbIut3vB?=
 =?us-ascii?Q?ORkOt8yHxrOAkdBE/MPokWKPYPQZXyQMr3STkuU5Nl0R9cPKMD8LcplBY9dm?=
 =?us-ascii?Q?QTXM0C4aKX4nlzBUHqLqJGrOANw2reSoDFD4A4qxTp2zMnJKNox7e07tDTtR?=
 =?us-ascii?Q?elcxqHRYwhrp/wb+99T8cYUhg4/Me3hICG/fiuYToiG6/VxItMmWOOK9wOXs?=
 =?us-ascii?Q?+AJpTGbLT1V69Vg+EUarFukK6l2GtizdUgmxjANipVszU0dkO9ClGnlARs5T?=
 =?us-ascii?Q?/vXHq8CAJe0jhlxkyRPvt+gn7faaMWauL/JR2dkDk6YdhNtTxvwV0Uh14upR?=
 =?us-ascii?Q?Ftb53J+KHI1DFbRMhUVMXnLi8a1VEiUhrSZ61UnZVZuomMLXxQGnOFkiTFWD?=
 =?us-ascii?Q?eb4zbvt3LkJXk9Pg7uitrhaTfvIW+au4f2vzRsU1jPPdJpMuCqtJ//jvOp/h?=
 =?us-ascii?Q?JFzG3e6Nv08veYJBLKdh4+Tu2fRzSZW3qBr7pmndXW4qK+IXzVJ/J7fbBBp+?=
 =?us-ascii?Q?hePIryRAeoJ4lrX4ll3H7QQWSyEfNkBr5B9fAK3wNO6D3C25m9rxKlGedrNU?=
 =?us-ascii?Q?kFGArT7CZWOZrzK23Kn+CHofc8WLAZOwQcu6b+6wMSCoQAP2Lt+DkAeTR0Xm?=
 =?us-ascii?Q?j2srjUuyc1U5BVpDN9sN3VtRRdNS/H0KNUxU/xG+YIeOIt4epMONMmPKt63e?=
 =?us-ascii?Q?4aChH30aFbjbj6AROquyjGmZO1NFr2kOgRjuo3LOqjiH4xSk89Kb99qoeuRC?=
 =?us-ascii?Q?/a4+C7CkK0AEOxqt2yI6k9ziclkaEdBRE3tzY8LsRHqEhitjqOGAf5/CTaCh?=
 =?us-ascii?Q?3u7wqH6rEHi6xBrh/rKJE/fNT7xUcZUDy1fFm7VuBDglgIwsDPuhyykUs8cI?=
 =?us-ascii?Q?zLOcLLtyIb3zrLOLpPv3shxDnOyQwJCdEVFn71A3EGqEGbi/kTWM7Fm3ePfa?=
 =?us-ascii?Q?606jbFzDpZGQ6t2CNhLvMxGFVUfUdPif9mVd9N/q1LTHIuqhawKNFhi6meP4?=
 =?us-ascii?Q?/dB7SaLXQvVADkiKufJvn2yTleisx80QjhwSoHMbumSR7UhVMHNUpR7SLh3M?=
 =?us-ascii?Q?AuFn/sXA9+m5YfMzb2h6xqbXK/MmKtxuhsq3nmxX+5qSSENxRlAbLaRPSg74?=
 =?us-ascii?Q?yrgeIY4AqK2uBPffbqQvmZhhYxmGpgkYeVjs/TGhXix+erAaJMDgF8QKDq+W?=
 =?us-ascii?Q?OvsVoZGfmHY9Y3SzGEbahgW59PlcJeDoSAv+NJhbyOyzDAkiO8EoJeGgJ55Y?=
 =?us-ascii?Q?zHo2Eku3mnBjYCCxwdT5rYP6Q+jz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AuYA2MT+AqwqOQDo8fP2axzUx7PtuUEizNcBjPcwksaq7OygCSIjmKtVc0sP?=
 =?us-ascii?Q?Lv8nrHpb+gKAAZqwwg3Nn3/TW/ubX4si9UtQ/Ez/Rnz7qIe3TyBOGfKZtUc9?=
 =?us-ascii?Q?MphE04mv3A+QS5LahP3RsAIOeceryZJKyvjy9yajjSlh1n0o+GwQ4sP251Mo?=
 =?us-ascii?Q?mTJxAeUb8bbChGP13L6vDsg2EXeh/cwU+o9b8lFtuZ+ufEe1lP+lcKjJNB1y?=
 =?us-ascii?Q?L6LpOYPpYagy8s1sdYW9iG7waJTsB3hUQ0y6bo/tikdNC3ocMHbELdQ2dSgb?=
 =?us-ascii?Q?1MS1vw7k+nTP4YdsRnF0B87xotNgtfB1skMM7dZ9a+iJOoOsXg/viDO7C2cu?=
 =?us-ascii?Q?KNNjWy60XLl97N6ADNDsqKvjzz2+ElNuM9jeJ97jmu1kPyqvP2Vm7wNZgUrx?=
 =?us-ascii?Q?vnW/wUkcdFKO2nMDkxz6Qt6bC7Mmalf5ojnjbGBS+v14g1oqmZIDwYbl69aR?=
 =?us-ascii?Q?2TkKukLzTNj4zeCfRCW9MZ/eUQU+LO32pklQ+/G2oaiJwxZVKnkKWcTg3pWD?=
 =?us-ascii?Q?MzNYvx8i7UiS/iZJXRQkQ6CdKmhvgs0jQT4iRLFhUYtiCZIRa9//AuBNG3aU?=
 =?us-ascii?Q?cK8ag/Mmd/ZYl6x0KLWBnaohjQ7/P7sdPKqnaszAFtsUhx3MFx1jfZDDdHjR?=
 =?us-ascii?Q?02noCSHQTqHk1agELWnYSizhLEz68b1qt5LMqeIbt4SSGWHVnXv16aZYXyuz?=
 =?us-ascii?Q?be6aiXdIwpnb6PFAmlFJndHdXT0p1hUhjXoGSrGm0WcdyqLBbYNECG87KrSP?=
 =?us-ascii?Q?qW0Sw6wQxzPwvUySENbVkJ3P1TQ/BwE2E9QYzNzG/n2q+tASWQSSZwXN1cEb?=
 =?us-ascii?Q?z8HiTtwBIxnd2Bg6OhRxvAFnBnEHzFy8LLkF1AChrRbCFgmaYRw5HQ1hba/x?=
 =?us-ascii?Q?v88kupTJFrTSPet1XkyWSSeiUBnxNQepvo90Kqqw7gT+QZpid2d8Ws24COlI?=
 =?us-ascii?Q?PFqSWzzonIp+vKJ8hxWMItE2AF/gE7OJlqJ0Wa67RRVNXWTncyb3s+RqeR1L?=
 =?us-ascii?Q?N1UY++aDd0drrUuC+SeF/Afk7mIyXByQRrH3DXmdI3fKP2CF7mnv5+2kFwJd?=
 =?us-ascii?Q?gxzk/f2PY1lg6ld5nDtK+DAhZA8pQSbR/whWJfjqFga3xkUclGso20Y6oeeU?=
 =?us-ascii?Q?/0NAaKt2BdUAu+c7dQKTreJM8AJ68Ls0IiKZ4cg7zryA4zAi/zOt3lC4eaN+?=
 =?us-ascii?Q?2I3RfrbbK35STqSwco9CFZ22tt+M076QiAB7/HqO7YcmmTlSt3gw16OE4208?=
 =?us-ascii?Q?adCK0XAyLeVniQk6Japnn1SfZtk76DePmW4ZWqrpHnNMgfnJI4iGOJpR04VZ?=
 =?us-ascii?Q?RMuO/3moc+8HroiytdK/JCplUlFC4MkFbzu/WygsSKrGwPfBoBQkr+bF2RD5?=
 =?us-ascii?Q?m3YKRlzbrXIAC9evvd65WKaLAJjvK8JcmE4QTg+N4Woauwa6fAS88jApaxoJ?=
 =?us-ascii?Q?jRa49iK2XQ1ie4B8VpXMjN6iOGsVsInHtZ1Wmo5f/R4Rvs2v+nqNHqm8kLpB?=
 =?us-ascii?Q?S194mE8TxyAa/GPxd/HjEqVnnwLPQjdtZYL4e/DwXlQtOvrGmtKQYKoUxGf8?=
 =?us-ascii?Q?BCTnvqVPn6NMBI+FBGWs7CapwmaQYJZt+3zidMrcB8rzAD5Wqvz9PjordHXJ?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f78ff0-ecc5-4583-3318-08dd6d0a518f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 08:35:24.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95rffSF+MNtPLmRmhNmf7AQmwT/HyRKr6uHZ8nLPqqAxv6ZuA1vg+3JgmH+UZUc5vqtTe8uFceN66VByEu8Eog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6906
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_net/sunrpc/sunrpc_syms.c:#sunrpc_pre_exit_net" on:

commit: 59a0395397f8ccf9987755bb42929d3e6eb81c87 ("sunrpc: don't hold a struct net reference in rpc_xprt")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git rpc-shutdown

in testcase: boot

config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------+------------+------------+
|                                                          | 00e89d2d41 | 59a0395397 |
+----------------------------------------------------------+------------+------------+
| WARNING:at_net/sunrpc/sunrpc_syms.c:#sunrpc_pre_exit_net | 0          | 12         |
| RIP:sunrpc_pre_exit_net                                  | 0          | 12         |
+----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503271441.962cfd7a-lkp@intel.com


[   42.506727][   T12] ------------[ cut here ]------------
[ 42.507690][ T12] WARNING: CPU: 0 PID: 12 at net/sunrpc/sunrpc_syms.c:84 sunrpc_pre_exit_net (net/sunrpc/sunrpc_syms.c:84 net/sunrpc/sunrpc_syms.c:104) 
[   42.509081][   T12] Modules linked in: i2c_piix4(+) parport_pc(+) i2c_smbus pcspkr drm_kms_helper(+) parport drm fuse ip_tables
[   42.510761][   T12] CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.14.0-rc6-00006-g59a0395397f8 #1
[   42.512482][   T12] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   42.512502][   T12] Workqueue: netns cleanup_net
[ 42.512522][ T12] RIP: 0010:sunrpc_pre_exit_net (net/sunrpc/sunrpc_syms.c:84 net/sunrpc/sunrpc_syms.c:104) 
[ 42.512537][ T12] Code: 8b 3c 24 4c 89 fe e8 f1 f7 65 fd e9 2b ff ff ff 49 8d bc 24 f0 00 00 00 be ff ff ff ff e8 ca da 1c 00 85 c0 0f 85 4e fe ff ff <0f> 0b e9 47 fe ff ff 48 89 eb e9 ac fe ff ff 48 c7 c7 b4 3a c8 b2
All code
========
   0:	8b 3c 24             	mov    (%rsp),%edi
   3:	4c 89 fe             	mov    %r15,%rsi
   6:	e8 f1 f7 65 fd       	call   0xfffffffffd65f7fc
   b:	e9 2b ff ff ff       	jmp    0xffffffffffffff3b
  10:	49 8d bc 24 f0 00 00 	lea    0xf0(%r12),%rdi
  17:	00 
  18:	be ff ff ff ff       	mov    $0xffffffff,%esi
  1d:	e8 ca da 1c 00       	call   0x1cdaec
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 4e fe ff ff    	jne    0xfffffffffffffe78
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 47 fe ff ff       	jmp    0xfffffffffffffe78
  31:	48 89 eb             	mov    %rbp,%rbx
  34:	e9 ac fe ff ff       	jmp    0xfffffffffffffee5
  39:	48 c7 c7 b4 3a c8 b2 	mov    $0xffffffffb2c83ab4,%rdi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 47 fe ff ff       	jmp    0xfffffffffffffe4e
   7:	48 89 eb             	mov    %rbp,%rbx
   a:	e9 ac fe ff ff       	jmp    0xfffffffffffffebb
   f:	48 c7 c7 b4 3a c8 b2 	mov    $0xffffffffb2c83ab4,%rdi
[   42.512544][   T12] RSP: 0018:ffffc900000cfab0 EFLAGS: 00210246
[   42.512553][   T12] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
[   42.512558][   T12] RDX: 0000000000000000 RSI: ffff88810d7d48f0 RDI: ffff8881008c5a40
[   42.512563][   T12] RBP: dffffc0000000000 R08: 0000000000000001 R09: fffffbfff658fe24
[   42.512569][   T12] R10: ffffffffb2c7f127 R11: ffffffffb40c5810 R12: ffff88810d7d4800
[   42.512574][   T12] R13: ffffc900000cfbe0 R14: ffffffffb2ba8738 R15: ffff88810d761c00
[   42.512579][   T12] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[   42.512589][   T12] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.512595][   T12] CR2: 00000000f652814c CR3: 000000017b800000 CR4: 00000000000406f0
[   42.512601][   T12] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.512605][   T12] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.512611][   T12] Call Trace:
[   42.512615][   T12]  <TASK>
[  OK  ] Started System Logging Service.
[ 42.512623][ T12] ? __warn (kernel/panic.c:748) 
[ 42.512633][ T12] ? sunrpc_pre_exit_net (net/sunrpc/sunrpc_syms.c:84 net/sunrpc/sunrpc_syms.c:104) 
[ 42.512648][ T12] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 42.512666][ T12] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 42.512678][ T12] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 42.512689][ T12] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:574) 
[ 42.512728][ T12] ? sunrpc_pre_exit_net (net/sunrpc/sunrpc_syms.c:84 net/sunrpc/sunrpc_syms.c:104) 
[ 42.512749][ T12] ? __pfx_sunrpc_pre_exit_net (net/sunrpc/sunrpc_syms.c:101) 
[ 42.512758][ T12] ? mark_lock (arch/x86/include/asm/bitops.h:227 (discriminator 3) arch/x86/include/asm/bitops.h:239 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:230 (discriminator 3) kernel/locking/lockdep.c:4729 (discriminator 3)) 
[ 42.512777][ T12] ? mark_held_locks (kernel/locking/lockdep.c:4323) 
[ 42.512802][ T12] cleanup_net (net/core/net_namespace.c:161 net/core/net_namespace.c:632) 
[ 42.512811][ T12] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5819) 
[ 42.512824][ T12] ? __pfx_cleanup_net (net/core/net_namespace.c:594) 
[ 42.512831][ T12] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116) 
[ 42.512840][ T12] ? lock_is_held_type (kernel/locking/lockdep.c:5592 kernel/locking/lockdep.c:5923) 
[ 42.512898][ T12] process_one_work (kernel/workqueue.c:3243) 
[ 42.512936][ T12] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5819) 
[ 42.512949][ T12] ? __pfx_process_one_work (kernel/workqueue.c:3140) 
[ 42.512973][ T12] ? assign_work (kernel/workqueue.c:1200) 
[ 42.512980][ T12] ? lock_is_held_type (kernel/locking/lockdep.c:5592 kernel/locking/lockdep.c:5923) 
[ 42.512997][ T12] worker_thread (kernel/workqueue.c:3313 kernel/workqueue.c:3400) 
[ 42.513029][ T12] ? __pfx_worker_thread (kernel/workqueue.c:3346) 
[ 42.513038][ T12] kthread (kernel/kthread.c:464) 
[ 42.513050][ T12] ? __pfx_kthread (kernel/kthread.c:413) 
[ 42.513069][ T12] ? __pfx_kthread (kernel/kthread.c:413) 
[ 42.513080][ T12] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 42.513092][ T12] ? __pfx_kthread (kernel/kthread.c:413) 
[ 42.513103][ T12] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   42.513148][   T12]  </TASK>
[   42.513154][   T12] irq event stamp: 12365
[ 42.513159][ T12] hardirqs last enabled at (12371): console_trylock_spinning (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 kernel/printk/printk.c:2043) 
[ 42.513170][ T12] hardirqs last disabled at (12376): console_trylock_spinning (kernel/printk/printk.c:2022 (discriminator 1)) 
[ 42.513178][ T12] softirqs last enabled at (12056): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:408 kernel/softirq.c:589) 
[ 42.513188][ T12] softirqs last disabled at (12041): __irq_exit_rcu (kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662) 
[   42.513196][   T12] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250327/202503271441.962cfd7a-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


