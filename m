Return-Path: <linux-nfs+bounces-11968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84EAC788F
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 08:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0FD4E205D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972EE24A04D;
	Thu, 29 May 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8f///0E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A9156CA
	for <linux-nfs@vger.kernel.org>; Thu, 29 May 2025 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499031; cv=fail; b=Em8juWW8KvYdk6tMt75/CtRsdXKtdC3gmRbI/zpY4Nk74UWi/Nlyh/BqqWEuEHxUqzrem4wA8SZfBCh0Nx+YFOqD94NNfVfw6GX69j0t+89FN5xZuu/EZwWbn/6kkYtAF+udcQmAfM6r57QDWFnSSEXUTJhBmF4N485Vk7u/4i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499031; c=relaxed/simple;
	bh=9yGeIgiQsgp5bbh0iTM3nTBcxQyFYpzeqSZuFWtwJOE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=j38tY6XU0oLZVcivb3dTWEAdUaapL1D30RBPRGlx5NypWvUUO8KUBENFxjq9u7wipJy4bPz9v7jcvOkw4fu1IxBYG4h4f5iIkKceIGcR5pQ6lKrjE5qgXeprOviRJMS8UuLhMQ1saG7Tcd9rP3iMAIULGgedrbTacffeQJQXyVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8f///0E; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748499029; x=1780035029;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9yGeIgiQsgp5bbh0iTM3nTBcxQyFYpzeqSZuFWtwJOE=;
  b=V8f///0E5L7iUBS9TZESAPzH2XYsNCiD9fvZ50yRCkSnUGp/StdYwM7M
   ZBXgAD1FmOue8E+dGcx5N5U6np6KXzW0k5tcrUpy7liLqP5YWD1NMBG/F
   nV5O/56XhKK4CkPQbbo2I73QRdC42try7aWKrSnSGL5bW/Q2mP1caC6TX
   /2YjSeuVRc3CMUFZHY0cy9Io+1DgOaNR3UtPhmML06kKR/WB1SoqirddN
   S6HcM8jDl+99++8qzcN3N208b4ys1PaUkvZ/JuPrl6O3QGp7PbCnlJX36
   V96j1seXSWBVCQ/nqB8pwl+Bc8vVVpOLm87i4ciCGqzFisveWnpL9UW4q
   g==;
X-CSE-ConnectionGUID: y3IIHpsSQmSmVjUdby5dBg==
X-CSE-MsgGUID: M+gm78P5R464JKcHTKDM4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49662514"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="49662514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:10:28 -0700
X-CSE-ConnectionGUID: OjTnkEowTw2v/DuBm06gnA==
X-CSE-MsgGUID: AL9bfSkGSwSLJ1msLf0P5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143935926"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:10:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 23:10:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 23:10:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 23:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+AtnI7oELk4eERulf5SN6de7HvACujoKOysAvfuLfroSDxKjMLx9YD6dll8HYMlbPJd0C00WomqTM7eoqG/1q/0wtKvqYnQpJwj7dfUuKXTfpAyUix6WvKxpR4i6Zbghj/yzT4HN8/p850235TeeiriQ8qItlzE48rDBLjws/MYKlwbZD2IZ9VlWp40xb4SeLWFh3hBNYF4dvNGr9JFK4P0veLdhAQzvPYBL2y1iEADvasgmRldVeLot6+Hf9LfaeopIK3N2tNrcuwxNnbcpTxh3vDvY4IRuz5L5uZIXdfTWetX9ORKcgoP+s+eBdoiT/3myAKQv3pcE2zSyXZKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmbKWGRAjmg2NXLU/mbMB7GpJQ32/0xV1WpBQPkZjVE=;
 b=CxpEaMZEqWpHctaPVLetkORO/CbGrHvVMVNoTQF0kL8wfRBB4n9zz3VXNA6Cn0VI8kb8jtHIgjJ2z5hl53MKsArFYecT67k3++qNYfCu7NUrsO9OUM6GG91+YWCqqw+OvEKpMW3Z9jmtCWyDFxQJ9X2IaNu8Q8H5QRl3ggZfM6Ua6NxDUxgEwPxr5/Sa/9b//35gndS23/B1ZdQ7MDDWW3HNtWaZ71c27vpeHXzBBCmNDOQhueNNXNBaaXjRamEc5P2QCadyWv5qEMLVNXaL9vNu7F0GUwY989v3yZVBavWW04wU2ukUioK6cqlWDxazptD7zYvlBfskOLQm5OBbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 06:10:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 06:10:25 +0000
Date: Thu, 29 May 2025 14:10:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [jlayton:kdevops] [nfs]  6f1433fc8d:
 WARNING:at_fs/nfsd/nfs4state.c:#nfs4_free_deleg[nfsd]
Message-ID: <202505291332.f6944aed-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:820::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: 31298ce0-7466-4cee-b400-08dd9e7780f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UXE7FTz+N7xLhKvOhr+dFUTaLWojQMA7T+PD2UEnVC1ZnlwBfb0On5Y+PlNx?=
 =?us-ascii?Q?gf1+G87VNuVybRs+KLs00Yjhkv07sCynGx2SMia84WEXIchGZV/fImJTcCKH?=
 =?us-ascii?Q?3ek8EpXRk/wk3UhxkVWn+DtgZNfCWAPp2uLtAE6qsKOtQAkn6VZbUddNxagd?=
 =?us-ascii?Q?qYbxO0df0QL/i/EcG+BYujYi5SKZ3xOLFByK5fBOsmJBcVK899nWgNtcUUx1?=
 =?us-ascii?Q?a+MNJvTNQbHiZFZsXw5S+B02XaL8/B86obfgFuCKxNeeb9etLyDknFgjk5fv?=
 =?us-ascii?Q?kNZA5vBthrRCsDTE/LPQB/KBf1QmFj+hW3b4CIjZp0PgF4LR3DHhJKx2CEIO?=
 =?us-ascii?Q?JjcnXM8PltGSWWhfmmeXu0KBqG9QAOA7T/zozL9A+B+uH9nJvQHXkkwIGxdC?=
 =?us-ascii?Q?DO51ZjSA4F33c0WWRRxK360R3+5AnuEP/mm/L38ueax9b3eldSTWzgWx0yhZ?=
 =?us-ascii?Q?wH066ev8X5wRrmkkbXG4mdglGcC+Mzt/lhyxi2zzVZeda4scns1vXEFU5BOh?=
 =?us-ascii?Q?W2zyVN8b04Nnx2YBOpJ6e0WSDVmBr8k3fRtimkbtQKTtkIf+FkSKkrLj58W4?=
 =?us-ascii?Q?wPV+ZUcYCtT8Olbq6d3mVXgHpe38hu4msv1pxUmzdXMzZMZF9ZGVmSr+QsG5?=
 =?us-ascii?Q?P8CqGdl0BrApHnut+7VTQFzPUHJZ2S4MtARxLxeLgV8pKx0CPinsd1uEc+qa?=
 =?us-ascii?Q?aeWOUZ7V3d9VsWUK3OwC3f+TVGdKnEO8GImRRqP0jfwZn/5rwSa6wEmVwbBU?=
 =?us-ascii?Q?KV1Vw4qqHMeu1X+BGKnmBvkKC+yWS0w1hhXEot+LOQ98VEbSAADdDvFYeeri?=
 =?us-ascii?Q?FJH71/iIcmjYKmBkVgM/QYAxa+NY3QmY49Abb5i8+oTT4KMOOhRBV7CKrio/?=
 =?us-ascii?Q?YtuXFEuWDcKn+1PiFSPsnfYYeGAI0K9fMRmtEeobCHCGCRpt2a5Rv8guoxw5?=
 =?us-ascii?Q?9HEjWLZ3e0sf5SNk9aVAiEwOCkArkd4tccrzw86Ntq5w7UkdePOIvpDS1ZvF?=
 =?us-ascii?Q?A/psiiL4laelibQENPLhaAiDh4pF5gZYzQ5OCruwZAvv5bM/hwIhOT+qdKU8?=
 =?us-ascii?Q?9NdBYnOmwxuIUqhwGtcu9IwROVMP9lDiukToP4sRSNXj+5mGw0sM+SjWA753?=
 =?us-ascii?Q?mOd28AwoAgUuo5xgTUPwW00SoG5i/veJEGlXDiGT1Tr34qjwurQk1YWWzYzM?=
 =?us-ascii?Q?vvIYeyWLP8DWSHelAbb4PJqhJH81sNbN7cY6CAFGw8mHEwd6Br76Xnn94avi?=
 =?us-ascii?Q?FxAOkf6ohZL+6ljI49OXsRDo1GkmtG5VZUeAGKQj+vjmgHJtNO74sKtXBYlU?=
 =?us-ascii?Q?wHxexBC391uXoQKmcFeozgrD8ctTT+3M9uz+aHE8kOrUDelakOhTWZ6N/kc0?=
 =?us-ascii?Q?j8J0oEIbkka4LIPSP74DX4iMYhVy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pTh7WPCy4y5yIfCYg10VZIzRqxyop/NmffMVk2WeSduv1f44zYdXewlFwUsT?=
 =?us-ascii?Q?Jf/9rE3VBFkwT4yz7uT/68e5pMzRSC4K0xbt4euYXT/wg4ViR+l24Akc16iN?=
 =?us-ascii?Q?XBtmvszvdnHRFNT6Ce5OgHoLsH/75d1l3PuaywoXS4+48juTiC05E1DgGhdk?=
 =?us-ascii?Q?dM4bAIEp2F7YRhMjca9+sv2Cr3LLlw/bf7Ig0lhiRPjp+6GAN7al34e9DQUQ?=
 =?us-ascii?Q?aI2xofecdPbiZfsgYImetmfjDiAEcRNiw0AQbtgxlGbi5zZdf+Efvu5lO1Tv?=
 =?us-ascii?Q?XpmyLfo5JdXG1vEVvPXvBhuMcxNXQiqQH+YiWJgyVjD/paN/RkFCsX+GAUTt?=
 =?us-ascii?Q?T8TCQCMK9D/zOG/WRPF5R5qTwH9Dy5SnqwukZizv0ZctgCI7taSfi4LoQL5N?=
 =?us-ascii?Q?K+B7KDxk9QRNgYRaFodn/dLo7QM1OZ5LexMsu/DbJ+5ONViUWrtk+CVIWKsc?=
 =?us-ascii?Q?uKqfxOIbCgUu+8xpA7EXGijaqss3oXwe7qC/prssl7FaiXunQIgOpYBEPxnc?=
 =?us-ascii?Q?neHI1ifOkZjcP0AkpVKiIW4l/wXtEzlRS7vFqDgB3gcFx8jY/+I19ks8xZCZ?=
 =?us-ascii?Q?sO/YenJEUJO4E3gvNsvIOEZSFxI2iRUq7VWp7H62XpI70fq4VZ6TW2QgJX7F?=
 =?us-ascii?Q?diwWT+RPLsWxCW5XtF7egFOtgaHqEi/tVbWZ8VXBaTzP/7nrU3CkXWSy0LTi?=
 =?us-ascii?Q?YZk/z8BwezAQmBWsu7UVW9SrMapyS0XhCwt4tNoGfqJlFTwasgU/WpLsXXRF?=
 =?us-ascii?Q?BA3ji2zv3D9rSjRv7WRWHIIHgoZ1sqSS61xWmwc6pLmuslgYleOAAd9uczg5?=
 =?us-ascii?Q?UdOHDsWXHxVxf+E7hi4UAFIZHwtd/j/VSuQiYDrYkCo/pSuvcDjHSb0IHQyY?=
 =?us-ascii?Q?bAB+PCE6xp5l+qgxRZQ88R5OBtjh5g1+3EP0WL6+5DbOIopNG5DqnXFzuswg?=
 =?us-ascii?Q?WYp6iI2DF/wdrIRg5pCb0YfqE3CIEhvob2QYkDGdUIs2hAgCOKBuZojg2HoP?=
 =?us-ascii?Q?kAVBTsdbbjjY7GkpTkK2zIWSOw83dARsg9WNjz838ZaAqQ25yBWQFfyeZ0pV?=
 =?us-ascii?Q?zxu864d/zSXfBRJzY7G+uaaSZXJkMG0dR/BiVn7/Z3HB9XEbYmwcVPZfx4PI?=
 =?us-ascii?Q?spg5IQoZYnr+F25jdqsX4FrmP+vP9mihdpna3nEqUkV+krho186zgjFiuKsg?=
 =?us-ascii?Q?kKQvbXQxco3NZSuUapsai5lL7ce/LDQ3KZ2l5fDIlIqSzml6oyk3IQ8yOSNV?=
 =?us-ascii?Q?8xNjBSCiwJlYACSURQ0/RpStD/pQh/oZejZHVndyk0sBMPkc40Rr6L9mzY7T?=
 =?us-ascii?Q?EqAu3HseGE4xxLY1tSOEDRIOvrTK7SLwUAr+FJkHjg8wq+AYJpYyq+iBUUyq?=
 =?us-ascii?Q?/BpiVBODag0MGoQT7y3Ofsj05v6cA/c24wf28kKaI46NHxGwMhU4cSzhkcpJ?=
 =?us-ascii?Q?Ss+Y5dW60Fz95Ain2LfMXX7DHPqohVhQ5HC7tIfadNVfpPm7ijJG++vIHEw3?=
 =?us-ascii?Q?q21jRPOKdj8GJcp+KLTpNQGmT0/w9sitvvqbFOZ7bnV/sk6d1xJCmgK6QVZw?=
 =?us-ascii?Q?uEWE6wwNb8K9xe1EF4BPxtIsp9FV7WgwmOpAE6ErO3XICr2ZYOW5P8GiXhsq?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31298ce0-7466-4cee-b400-08dd9e7780f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:10:25.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG/sVeVZfMbL9RkkhiX5lIHNX+PJykM0Oo09Ob9SY5/5cl2V3/f8/U8FuvHvD8ghy4/wcElfYd2I/418hiSihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/nfsd/nfs4state.c:#nfs4_free_deleg[nfsd]" on:

commit: 6f1433fc8dc25b1007e349200da374ccd81793aa ("nfs: allow client to request NOTIFY4_REMOVE_ENTRY")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git kdevops

in testcase: filebench
version: filebench-x86_64-22620e6-1_20241103
with following parameters:

	disk: 1HDD
	fs: xfs
	fs2: nfsv4
	test: cvar_example.f
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505291332.f6944aed-lkp@intel.com


[  202.803913][  T801] ------------[ cut here ]------------
[  202.809599][  T801] refcount_t: underflow; use-after-free.
[ 202.815386][ T801] WARNING: CPU: 30 PID: 801 at lib/refcount.c:87 refcount_dec_and_lock (lib/refcount.c:87 lib/refcount.c:146) 
[  202.824562][  T801] Modules linked in: kmem rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss xfs intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common device_dax nd_pmem nd_btt dax_pmem i10nm_edac skx_edac_common x86_pkg_temp_thermal intel_powerclamp btrfs blake2b_generic coretemp xor raid6_pq sd_mod kvm_intel sg kvm snd_pcm irqbypass ghash_clmulni_intel snd_timer ahci dax_hmem rapl ast snd cxl_acpi libahci ipmi_ssif intel_cstate acpi_power_meter drm_client_lib cxl_port cxl_core intel_th_gth drm_shmem_helper mei_me soundcore isst_if_mmio isst_if_mbox_pci intel_uncore ipmi_si i2c_i801 ioatdma acpi_ipmi libata intel_th_pci einj pcspkr drm_kms_helper mei isst_if_common i2c_smbus intel_pch_thermal intel_th intel_vsec nfit wmi dca ipmi_devintf libnvdimm ipmi_msghandler acpi_pad joydev binfmt_misc drm fuse dm_mod loop ip_tables
[  202.828256][  T815] ------------[ cut here ]------------
[  202.900301][  T801] CPU: 30 UID: 0 PID: 801 Comm: kworker/u513:4 Not tainted 6.15.0-rc7-00105-g6f1433fc8dc2 #1 VOLUNTARY
[ 202.905608][ T815] WARNING: CPU: 70 PID: 815 at fs/nfsd/nfs4state.c:1047 nfs4_free_deleg (fs/nfsd/nfs4state.c:1047 (discriminator 1)) nfsd 
[  202.916555][  T801] Workqueue: rpciod rpc_async_schedule
[  202.926199][  T815] Modules linked in: kmem rpcsec_gss_krb5 nfsv4 dns_resolver nfsd
[  202.931511][  T801]
[ 202.931512][ T801] RIP: 0010:refcount_dec_and_lock (lib/refcount.c:87 lib/refcount.c:146) 
[  202.932691][  T815]  auth_rpcgss xfs
[ 202.940344][ T801] Code: 55 1e 9d 01 01 e8 82 fd 94 ff 0f 0b eb c8 80 3d 42 1e 9d 01 00 75 9c 48 c7 c7 30 d8 ac 82 c6 05 32 1e 9d 01 01 e8 62 fd 94 ff <0f> 0b eb 85 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90
All code
========
   0:	55                   	push   %rbp
   1:	1e                   	(bad)
   2:	9d                   	popf
   3:	01 01                	add    %eax,(%rcx)
   5:	e8 82 fd 94 ff       	call   0xffffffffff94fd8c
   a:	0f 0b                	ud2
   c:	eb c8                	jmp    0xffffffffffffffd6
   e:	80 3d 42 1e 9d 01 00 	cmpb   $0x0,0x19d1e42(%rip)        # 0x19d1e57
  15:	75 9c                	jne    0xffffffffffffffb3
  17:	48 c7 c7 30 d8 ac 82 	mov    $0xffffffff82acd830,%rdi
  1e:	c6 05 32 1e 9d 01 01 	movb   $0x1,0x19d1e32(%rip)        # 0x19d1e57
  25:	e8 62 fd 94 ff       	call   0xffffffffff94fd8c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb 85                	jmp    0xffffffffffffffb3
  2e:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  35:	00 00 00 
  38:	0f 1f 40 00          	nopl   0x0(%rax)
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb 85                	jmp    0xffffffffffffff89
   4:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   b:	00 00 00 
   e:	0f 1f 40 00          	nopl   0x0(%rax)
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[  202.942535][  T815]  intel_rapl_msr intel_rapl_common intel_uncore_frequency
[  202.948281][  T801] RSP: 0018:ffa0000008987d90 EFLAGS: 00010282
[  202.949557][ T1502] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-icl-2sp6/filebench-performance-1HDD-xfs-nfsv4-cvar_example.f-debian-12-x86_64-20240206.cgz-6f1433fc8dc2-20250528-100439-vlpvt2-0.yaml&job_state=post_run -O /dev/null
[  202.949560][ T1502]
[  202.951860][  T815]  intel_uncore_frequency_common device_dax nd_pmem
[  202.971301][  T801]
[  202.978343][  T815]  nd_btt dax_pmem i10nm_edac
[  202.984263][  T801] RAX: 0000000000000000 RBX: ff110002564719d0 RCX: 0000000000000000
[  203.014960][  T815]  skx_edac_common x86_pkg_temp_thermal intel_powerclamp btrfs blake2b_generic coretemp
[  203.017153][  T801] RDX: ff1100103f9a9f40 RSI: ff1100103f99bd80 RDI: ff1100103f99bd80
[  203.017154][  T801] RBP: ff1100109035a330 R08: 0000000000000000 R09: 0000000000000003
[  203.023593][  T815]  xor raid6_pq sd_mod kvm_intel sg
[  203.025784][  T801] R10: ffa0000008987c30 R11: ffffffff831e50c8 R12: ff11001090359fb0
[  203.030308][  T815]  kvm snd_pcm irqbypass ghash_clmulni_intel
[  203.038136][  T801] R13: ff110002566d9728 R14: 0000000000000001 R15: 0000000004248060
[  203.047695][  T815]  snd_timer ahci dax_hmem rapl
[  203.055520][  T801] FS:  0000000000000000(0000) GS:ff110010bbb55000(0000) knlGS:0000000000000000
[  203.063348][  T815]  ast snd cxl_acpi
[  203.068400][  T801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  203.076223][  T815]  libahci ipmi_ssif intel_cstate acpi_power_meter drm_client_lib
[  203.082056][  T801] CR2: 00005555555733c0 CR3: 000000207de24002 CR4: 0000000000773ef0
[  203.089881][  T815]  cxl_port cxl_core intel_th_gth
[  203.094581][  T801] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  203.103361][  T815]  drm_shmem_helper
[  203.107026][  T801] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  203.113464][  T815]  mei_me soundcore isst_if_mmio
[  203.121118][  T801] PKRU: 55555554
[  203.128942][  T815]  isst_if_mbox_pci intel_uncore ipmi_si i2c_i801 ioatdma
[  203.133822][  T801] Call Trace:
[  203.141649][  T815]  acpi_ipmi libata intel_th_pci
[  203.145314][  T801]  <TASK>
[  203.153138][  T815]  einj pcspkr drm_kms_helper mei isst_if_common i2c_smbus
[ 203.157935][ T801] nfs4_put_stid (fs/nfsd/nfs4state.c:1264) nfsd 
[  203.161338][  T815]  intel_pch_thermal intel_th intel_vsec nfit
[ 203.168299][ T801] nfsd41_destroy_cb (fs/nfsd/nfs4callback.c:1167 fs/nfsd/nfs4callback.c:1403) nfsd 
[  203.171442][  T815]  wmi dca ipmi_devintf libnvdimm
[ 203.176239][ T801] rpc_free_task (net/sunrpc/sched.c:1190) 
[  203.179037][  T815]  ipmi_msghandler acpi_pad joydev
[ 203.186082][ T801] __rpc_execute (include/linux/sched.h:1842 net/sunrpc/sched.c:1005) 
[  203.190962][  T815]  binfmt_misc
[ 203.196882][ T801] rpc_async_schedule (include/linux/sched/mm.h:339 include/linux/sched/mm.h:399 net/sunrpc/sched.c:1035) 
[  203.202192][  T815]  drm fuse dm_mod loop ip_tables
[ 203.207073][ T801] process_one_work (kernel/workqueue.c:3243) 
[  203.211343][  T815] CPU: 70 UID: 0 PID: 815 Comm: kworker/u513:15 Not tainted 6.15.0-rc7-00105-g6f1433fc8dc2 #1 VOLUNTARY
[ 203.216311][ T801] worker_thread (kernel/workqueue.c:3313 kernel/workqueue.c:3400) 
[  203.220758][  T815] Workqueue: rpciod rpc_async_schedule
[ 203.223990][ T801] ? __pfx_worker_thread (kernel/workqueue.c:3346) 
[  203.228696][  T815]
[ 203.228698][ T815] RIP: 0010:nfs4_free_deleg (fs/nfsd/nfs4state.c:1047 (discriminator 1)) nfsd 
[ 203.233576][ T801] kthread (kernel/kthread.c:464) 
[ 203.238279][ T815] Code: 75 46 48 8b 3d c9 50 1e 00 e8 b4 33 0b c0 f0 48 ff 0d a4 50 1e 00 c3 cc cc cc cc 0f 0b 48 8b 56 48 48 8d 46 48 48 39 c2 74 be <0f> 0b 48 8b 56 58 48 8d 46 58 48 39 c2 74 bc 0f 0b 48 8b 56 68 48
All code
========
   0:	75 46                	jne    0x48
   2:	48 8b 3d c9 50 1e 00 	mov    0x1e50c9(%rip),%rdi        # 0x1e50d2
   9:	e8 b4 33 0b c0       	call   0xffffffffc00b33c2
   e:	f0 48 ff 0d a4 50 1e 	lock decq 0x1e50a4(%rip)        # 0x1e50ba
  15:	00 
  16:	c3                   	ret
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	0f 0b                	ud2
  1d:	48 8b 56 48          	mov    0x48(%rsi),%rdx
  21:	48 8d 46 48          	lea    0x48(%rsi),%rax
  25:	48 39 c2             	cmp    %rax,%rdx
  28:	74 be                	je     0xffffffffffffffe8
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 8b 56 58          	mov    0x58(%rsi),%rdx
  30:	48 8d 46 58          	lea    0x58(%rsi),%rax
  34:	48 39 c2             	cmp    %rax,%rdx
  37:	74 bc                	je     0xfffffffffffffff5
  39:	0f 0b                	ud2
  3b:	48 8b 56 68          	mov    0x68(%rsi),%rdx
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 8b 56 58          	mov    0x58(%rsi),%rdx
   6:	48 8d 46 58          	lea    0x58(%rsi),%rax
   a:	48 39 c2             	cmp    %rax,%rdx
   d:	74 bc                	je     0xffffffffffffffcb
   f:	0f 0b                	ud2
  11:	48 8b 56 68          	mov    0x68(%rsi),%rdx
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250529/202505291332.f6944aed-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


