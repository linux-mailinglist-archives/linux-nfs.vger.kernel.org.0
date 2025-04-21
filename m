Return-Path: <linux-nfs+bounces-11196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3056A94C35
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 07:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB031890F50
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53DD1D7989;
	Mon, 21 Apr 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsKwvbrs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A21E885A;
	Mon, 21 Apr 2025 05:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214316; cv=fail; b=FFiSMHScViIUmq78NelQLMg80+rg+4ciJr7xYNHaWEe1pHArLmYCByfcZ7M2IDZmE9WdcOc0XXXajAGGDAhjJ/Be0i/BT9Vqk/1agWrrOwZ6dJFrKnU6mrcPOjjURkvpPu6mNKgRDJ1DJs+WrKEkIfFRUUEwAm83x2TzUGu6/ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214316; c=relaxed/simple;
	bh=VZoBGtBatv7zQtZHWsu4dfiOvdrxfqN2thZQBTLZwqI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oU6NI7uQB7zk5hquTluWnBeeVPzkaQ1W5xyLUQBjex0ala6jObwxfL3Bmie9hBCcmdHlAh7wTyH7mK6Htx8ug33RGs/Sh5XlHOq6FuD3bL/RW1auUG5+vOHrx2Rpurgp2aDqYf3OSR6coPcyX+mwpsuNGx4Iw2bueWr63uAJr0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsKwvbrs; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745214313; x=1776750313;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=VZoBGtBatv7zQtZHWsu4dfiOvdrxfqN2thZQBTLZwqI=;
  b=YsKwvbrst93f/wStA0yVLrmGjOsdO5j6Vft8muKS5x+ZJ73Ve4QyuLrR
   CEztNQHkYedk4/jpY6zpf0oHIOQpXUhd+TwrwhDlMUANoRzSL+ki/OCF6
   WEEEoukz73A5NXFethGJOmV2dCnw92VcCyZ+Wv/ysZz+2Nx8VhDheRToF
   DsrrVythYJlgJQ1Cn2FHZvfRg1evgGJL7fwfknbXvsIq3Ih42bqMkZEf/
   IuSQ43bUjRmjHBQxgfPiOm/+nZv2mXo+N5vz7YqBYegx5/XZRiZDb3MlU
   bkyloVHsMgaA4KGzxm7jsHKGBGi6xQv3w9EXf6Py/s7GCboHzjwmET8My
   g==;
X-CSE-ConnectionGUID: AE7rDQcqTPOE3z6zYr+4aw==
X-CSE-MsgGUID: MDkYsj1xTzKRYRg2COey/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46862725"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="46862725"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 22:45:12 -0700
X-CSE-ConnectionGUID: YUtvwAvITOisfqxACNRS/A==
X-CSE-MsgGUID: ZbTmRVSsS9eoD64gtBad6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="162585839"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 22:45:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 22:45:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 22:45:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 22:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL579+rIf/fQZYASulCZw48OOVniPGWeyMmUFVLA1HxT9LwHlmX1kiixABb5cTIOYQszsbS8p3VCWB+hMXkcdiRJFJKxDYpzIpc4m9lCTAZ1RH1WEoo3A3QcK7vJHVkNj2Bpty+Fc0dW4cW/yCDfqXst53nP3C9K/Ua1sKP2E12zTLiAyAfW6uhi7VrXz/VdAkrggMDxTjY7B8cmtG83/QNL7fNWxIxZK+KUDauDZlI/q9GTeMXlH2BlD8kr6NJFuZr9IqdEJvwVh008ofMEGibVMAO8h7rAyWsbtyFzEWqZXYYWyZQaxJj1c90RuILZLb2OThALN0sXwiwr9S5x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifQaA1vh67IHMbBNoFs1yRh5ESURBsdztmPSV1tQ5jc=;
 b=MfftyAwy85QSUFQ8Vy2WIAOPpqGFa7G+0hA6Md+bhIcRo89l6khVOnlA33ULkGJ/jh3OCzRV3Fb1twHTCMg0mD66BPlP30e0XAOPiZkrKaYp3eyhovqdTyKiIa2axpSilCnhYjBGRIe42XqmTNUMbBOQNsQrMIrS4AIhFZ5HH93PZAt/n3CBic4ttaDJb8IaS2XH2mwX45iMMmPyJaPPWT9s2Wp9MlnHugVkeUpjCt5T3D2C+hwTKn9p4FkFyqmD0k/O+VBucMIiW8Qo1MFdi+inSEsLZ2VNRofC99Im6Skmou6+q6218PVhb0y/NcqjXSE4dVrWelgJsRdo9vo4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Mon, 21 Apr
 2025 05:44:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 05:44:27 +0000
Date: Mon, 21 Apr 2025 13:44:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [nfsd]  eccbbc7c00:  dbench.max_latency 99.9%
 improvement
Message-ID: <202504211304.eb2ca0c2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0100.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: b3868266-3539-40bf-8645-08dd80979434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WTRzC67ElS/QP+Zoye+CD1K0KeuDr1jcx8e8/fge6+zen733kiRChH7Lc0?=
 =?iso-8859-1?Q?S1JoH/CreSXQyeE8+TdSJ5wO+h/2tp1LuEhXax1H28Pd1Ne2T4sVjQo5QN?=
 =?iso-8859-1?Q?YyytPkwoB/ewQhbxev/oYUFhrSSypimNwuFXXaruMVHIvpADne6Up8Lh08?=
 =?iso-8859-1?Q?3HSL/ALtV1TD9U4RQcM8dwXk+Of3BHar0aFPxBRIVu1q4PCKXUDouzFc+I?=
 =?iso-8859-1?Q?AwRht9YTzhMtH46b9X4G3Qhvu4PeCUWo92Z9OGg1bAbgV27F9DxQSdyU+K?=
 =?iso-8859-1?Q?3xtZW+ytMBRTOko6/5RkYknYevncMJiAeRf2pz6df+gGwUMqAeONlTP3AT?=
 =?iso-8859-1?Q?aWsQLVhwz4Adjw24XjxTY60SU1dibStBOarcfWfbwmHh9HRbH2JImBPJVZ?=
 =?iso-8859-1?Q?rcXrm1dLBV9FbvVatdgAF7RIJLQ/uj7tzlbSXwQ8Ipee34sMOn7bW1/Iaz?=
 =?iso-8859-1?Q?teWw682PJ2xg85f7n88hKMfAdrMDSqlF/OEQ72+10AHf9woZ+gmdAFgcck?=
 =?iso-8859-1?Q?XH658l6rF25LlDGgbuDjJVETnAC22Uk6IJ8yPc9yPR5lxVDIAreLxdRdZ5?=
 =?iso-8859-1?Q?Lp6BvzObmYqqz3hNsDzivQsqhd3T6TATJsA2GPBvBsVDlBRjb/4QeOOu1p?=
 =?iso-8859-1?Q?xIf5EBfzX7eFZAGWl7o+YzHTRTdECl0qzLRzHt6usUCpzRoh0elIx0eYd+?=
 =?iso-8859-1?Q?LVe8oVxPuq0vU2XjAX9dM9swVa8P7T14QreaBhcjnLOzmdTCrSBh9tdp1O?=
 =?iso-8859-1?Q?kAbhkRqdFyVPIyuQFBjUjDzQv23IMe4N4qBfLzjHSyAvH3ej4D5HeocCpe?=
 =?iso-8859-1?Q?W4AEb6ZEs8PTWmGXGVoVi746ojfRmun7APHw/oBVA9x4L6Mb8tIY9pVtx9?=
 =?iso-8859-1?Q?0XHeiaIt+NUL/2Wcc9ZX5M2ut/G0p6PPoLq+nhKvjYExXt8YwLLIHsyCPQ?=
 =?iso-8859-1?Q?0YM3UcaKfydY/F6Eqi6bf9QDqj4IwuAqNKohRYl1gjbg+61HS5A3gTlCWz?=
 =?iso-8859-1?Q?X9Fu55i28kofqtpsQQdMZi3e1Jo25lOvK+E3E+VXNz9Bk55SpvhEDP++oN?=
 =?iso-8859-1?Q?5y5IwJqGo9lb18oa0DDWt472ybko1fwnYy9joWtHWQ0UdJSNtOcrmdx3d2?=
 =?iso-8859-1?Q?1loOFxD9yRit1K0lLMOn+aPPraz1uG8q67KS+G+sC2yDobXW2L27jz7fbc?=
 =?iso-8859-1?Q?HasIa4IYF/wUc3F3unNQ8KjwTGhsUNBwpk/SsBb1lYceKgwc687cLq5FcZ?=
 =?iso-8859-1?Q?hgEfdakxIBe/TPZBRYjfZXPxX/hPZnSp6Ahb1NotGMuIzJAGpiXK4cQ8gx?=
 =?iso-8859-1?Q?rQvL8qkdk21SwcZ9IfaryLkZlz192oST2d42fr37TuejXw+l0IrlRbIoDi?=
 =?iso-8859-1?Q?Gbh1jHr8T3q+MmCJVNAL4L7x+5m2vKLMyH7KCflrIzj/7sICZa3mFNN0gU?=
 =?iso-8859-1?Q?ecWc1ZurFxwuDKTo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kDj92lMb2/qcmX5WrVbAvuWx06MXOoa7POh7s7Mx5b3wua/rc1qFKrrFNy?=
 =?iso-8859-1?Q?g1EwB9O/Mj72Qod1ph5utGFfQbnAt8p5gp5U7abe3Qn4easxL7pheaM1DN?=
 =?iso-8859-1?Q?IJNhB589G2eFNAU0dCu2Jn2D965QZkEGIxRcQKhjQyAv6reInKsur4VXPY?=
 =?iso-8859-1?Q?9Qq1SVO3n1z+2IsNCSYq7ghU0XcLRWUQWX0fONO7tYiajvHvsi4LOBhlyJ?=
 =?iso-8859-1?Q?el8DcQ3uZnfvhaZQ9OOp7K5aRiPq8MpJgqxSR+aMDurLjXYliLLvrBBFVW?=
 =?iso-8859-1?Q?rfSwLdkP74Q1cWhb2wSDtSTZneNfFRmX/D71fmpmA4HxtgpOF6xI+Pjv8d?=
 =?iso-8859-1?Q?zl4zEzP5buGwMcoTFV+MiepHCFtYFAPlFchKKozUwN8fhrQg2NAenHFWWi?=
 =?iso-8859-1?Q?0VnZTTl7g/37HTc7x9Ppm0ZayY52X4/zp3p1Z5UsJ8zZ2tixYuEJCisFFO?=
 =?iso-8859-1?Q?ytaEuGau8I0NIcVEJ6qT2Zcy2LAoM6LCbQ5m2ZVRA9M1vzIbwLIasou5v3?=
 =?iso-8859-1?Q?GrHeFTN7OJ+XXLIIj0yBTEjvw+EYyNuw6LtGdpDgawRpZtvs/zXZJRv5Nd?=
 =?iso-8859-1?Q?+s+u+m0r/vktmbnKx0d60n54XvZf/I//QZq6NJpBorGoTY1dVxR7tRqHv8?=
 =?iso-8859-1?Q?P0glHaAg/quhByVp1JL+DVsGBYQS8zk1e0f6LsWHm/X0c9SXrKM5e8aoYy?=
 =?iso-8859-1?Q?zUwioKiAjlISL1Rs/8B95aXoyQkfGd8xJ9JH02mZa/dMC6E6JEkcKWhQez?=
 =?iso-8859-1?Q?ocsuhobKghsyjHCQKX1dGbjaWKECkhEG6h2mY74FQggq2E3DXm6UY4wRvn?=
 =?iso-8859-1?Q?C2raQD1FfB0+KxVHEY/4OIegqIHi0bfmkMaxsyFDfJkOJjgVRQlSA71Z4S?=
 =?iso-8859-1?Q?lF/mtCWmhfRpZ96FwmX2rAXWHsXJE7moTS75pBf5x0b/U6/uCN1LKmpnKr?=
 =?iso-8859-1?Q?jXQfEWx6CxIklflhJMm1qaugoAanR6HdhKrsMPFs9bWHivWOxrws7IqghK?=
 =?iso-8859-1?Q?yllOd7MXT+4L/zzOchCYU8hEx9eqoMImBysM76/M8TTI+lf00BgTB3klo5?=
 =?iso-8859-1?Q?s+BNbZXhejmIuGGzhkEDi/z6kjowtII4WDlBpel2TvXp/NIFs/O+ZzE3t6?=
 =?iso-8859-1?Q?PiMV5A61N5XpsmKIl+lhQygChWYjddQucmVF9kxkvL45l2mz/W+v3sCaHu?=
 =?iso-8859-1?Q?yVd1KkULfqb5Dh63Gk+YNKetkgan9pPke4DMup0uSjt96zqo3zbguW3xAe?=
 =?iso-8859-1?Q?mD3qx63A6i5xCPnKVwtnuA1AikrMad324A9s5uwYVDOmclVcFDYUmwpjs6?=
 =?iso-8859-1?Q?lPdPLPLndpVIjXLSXy3/uJWfleA/W7vy32Jj1oyOTUthSTV5SrLcSi52T2?=
 =?iso-8859-1?Q?Lu2dnTD14cZKJjfBmtf4xowXRI9ORwr7qkn2XLD6fW7S3V1ygYEaEUt4Hy?=
 =?iso-8859-1?Q?29ad2Ml/7jLqV4qq2LGraVevQArnhj4ZBE0HxN324eTyCoXWNGEtjo3YiQ?=
 =?iso-8859-1?Q?4VvQKUJfgpgSMiFSm9Cf7odfMNtI6XuQKuc529K8/ZLj8v+Mk6KSIZiKii?=
 =?iso-8859-1?Q?m+KuOwDyk3MyNkcFQkbAi9WjL9GM5U+HyD8n+hloIHmT2lUB621vWOXrMJ?=
 =?iso-8859-1?Q?FN/4ScdaivSyO9Ol9vLLOk8w5gB3ZjxVIhnmWn+CZrdOnV/1YnwSPuUQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3868266-3539-40bf-8645-08dd80979434
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:44:27.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ICy1PWm8Hb+sVssKiG3c1Itlfx5DBoWp0/r6u3EiaH/RaBRb3k2yddHLYk0n3Co7+16z9gAGAK0zmq0+CWgEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 99.9% improvement of dbench.max_latency on:


commit: eccbbc7c00a5aae5e704d4002adfaf4c3fa4b30d ("nfsd: don't use sv_nrthreads in connection limiting calculations.")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: dbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_threads: 100%
	cpufreq_governor: performance
	disk: 1HDD
	fs: btrfs
	fs2: nfs



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250421/202504211304.eb2ca0c2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/1HDD/nfs/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/dbench

commit: 
  de71d4e211 ("nfsd: fix legacy client tracking initialization")
  eccbbc7c00 ("nfsd: don't use sv_nrthreads in connection limiting calculations.")

de71d4e211eddb67 eccbbc7c00a5aae5e704d4002ad 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
         10:10        -100%            :10    stderr.has_stderr
         10:10        -100%            :10    stderr.nfsproc3_create_3_failed_in_nfsio_create
         %stddev     %change         %stddev
             \          |                \  
     71006           -99.9%      35.66 ±  7%  dbench.max_latency
     71006           -99.9%      35.66 ±  7%  dbench.max_latency_harmonic_mean
      1.11            +0.1        1.16        perf-stat.i.branch-miss-rate%
  80903221            +6.3%   86014278 ±  2%  perf-stat.i.branch-misses
      1.10            +0.1        1.16        perf-stat.overall.branch-miss-rate%
  79601951            +6.3%   84615085 ±  2%  perf-stat.ps.branch-misses




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


