Return-Path: <linux-nfs+bounces-6536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635797B74B
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 07:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F41B1C2161E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 05:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433394D8CE;
	Wed, 18 Sep 2024 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pr+yhv+s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF913792B
	for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635615; cv=fail; b=ATgVERlrAHLQRO5klUWRw6PivBcEP52aIxk7ETHP5pFwOMn3Lhsg3dQBAPRZeTzg1E1guBN6YMb49Lg/N+5y0hXiWybOoEt+70VoG4x70WK8ROMOc+A8W/h6kshXytjEUa6egqE390GIsxVFrvRNL0MLYT6VpXeS8Ze8GTShPqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635615; c=relaxed/simple;
	bh=YQq7YYs9Rl/7T6DPQRESx011bcw5LjUOF4muSzODGbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYdkgMIzB//3CkX7Pt/jwIepIelcxP/B2ibl5TFLxE6B6Egh7JnEykKMC5jkzizD4NbJOXcCAgCFkH1EGe5MWgBxs2tlvmI+80hOu2Vxb4QMoPsg1nuB+LfPm9pe7UEHqNyDMdDik6qFcIwjfICMTUZf9XLCpfsMhn0kaZPp15M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pr+yhv+s; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726635614; x=1758171614;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YQq7YYs9Rl/7T6DPQRESx011bcw5LjUOF4muSzODGbk=;
  b=Pr+yhv+sozju694DMFtibhuNMrOD2Oan+AWabEbHZx4RpjXeIX6YcynG
   DecpnX726s91W6GWmXcE7MiB11rNLqS3c6fcj1N8sqd34oP/Iyb7A36sc
   t6jGhrc+V+Vc2AuqK+bs+B9Wl2teYHVpjo8eSpR3+PGJp8NJ3BpGvyKNP
   RRsHD6SLQBA4EGDUPnlNL8laKSyjwDfQ8XaNDU9jlJRsV4fz/hgYclW/V
   UWjzLfuEXOXpW4RMFn3gPTinHUI6RxObCSaZteQjyhZAHFqhLl4Jl6qRK
   3QVG0MmtEgFhm55dh/FC70V3tAsdIf3U35vs1cBB45qLNOPGIMzdl669Z
   A==;
X-CSE-ConnectionGUID: 9BqjZfn7RBeU2Df6opDfFA==
X-CSE-MsgGUID: USpgJa6uSwq0P8CUx/66/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29313033"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="29313033"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 21:59:57 -0700
X-CSE-ConnectionGUID: xt+9uPd8R9iA7CU/wKYI7w==
X-CSE-MsgGUID: wxzuarm4RIOVkYZuoa54zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69510867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 21:59:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 21:59:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 21:59:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 21:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTc761qVOVKuvPvBusfBk+CBd7nYTf0lSz1DdXUqGBh+PLrD0T6ULk8lOnDahJ+1dwnoKpms5y/8CIjgseHnAX0uDse/wTyYqA1TefnR5BzaCwHW3mCBxbyn40nTA+BZkYK/5/ejWQrM9xuQIbAq4CIjCwrA88R4TyUZwQST46gTZaUohQCspeDrJjuXmRgDTS09i4Tdf9fST3E0NpHNDryZ2NFRnjI+bp5SC4KVpvkafMgDxoho+b/0eRRRfxKQnDX6veqC8VHAjEUzFDZoY/LZh3DtoVFYWPR66D/3CWTXDp4mI03gdAtvnXKatUFaI0abKbRdro3sXwPmqoDh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRooJkOc578FoGL0Nmxctw/Bgdx5u3cpsTaPHryAjf4=;
 b=TtOfzbzyjKFz4wMLALgBXu84vpM2w6e9Z6qa3ydmU1bI+pWLgsCiX2RLqMW3QbNHPvPGcv4g3vT9K4QVKyZQXe3H+tJG058Eit8oGGauCo0Q+2IRgd9XF+2sorq1pHJgdqO1ttlvpaBqAGdgTWOR381m+KtUJCjC9Ho0Jh3Or3OMUZMSphCKYSrtj4qwwcuHj+uzev3y+5qyLJcW93rBAzIHfSZfchr4SX0RGUuh8BPw1PT6XFjAqsBeSkyhHYpk2aDDWOab5eUE3SHSPyk951Sr167kFxrRH8PaM5J9W/WHn4dnO8DwDcDN3uCRoG6Am7pFmk7X3laWQALhUjbR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 04:59:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 04:59:46 +0000
Date: Wed, 18 Sep 2024 12:59:37 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [nfsd]  8cb33389f6:  fsmark.app_overhead
 81.6% regression
Message-ID: <ZupeOQCdVG1vEf/Y@xsang-OptiPlex-9020>
References: <202409161645.d44bced5-oliver.sang@intel.com>
 <Zujs7yk7zbENaZON@tissot.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zujs7yk7zbENaZON@tissot.1015granger.net>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d78cb25-8084-47e6-be74-08dcd79eb7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84drascgnUU9omrfrlV8I03XspuD/OW+abAFwup1Xkq3RjXxwbPpRvVkewmE?=
 =?us-ascii?Q?fPS6PcdUkiVFdH2C5B81wbrm0aF4gv1D9+m00mclf8lq1BuOi/bPey0vtQwW?=
 =?us-ascii?Q?YrtBbaEN8McWwZKHCgSDNBatSQ/VRCsHVg6KCHVvHiJveIMms+EYp2v0HXu9?=
 =?us-ascii?Q?RGx/6tLzDoC5s49I95/NR64OiY4Jp6lRgWSvLNbTRKMI5F7BA1UX+NTqaaXl?=
 =?us-ascii?Q?rw7Lqiwnl8WWv5ltP72dwoihy6TRqQ4mfbnI5bGtXKHmu5DsgCkc2sprZcY4?=
 =?us-ascii?Q?zOGsYh5QS+qhSoORS7+sJn/v64L13RPu/ttzf9ftZD3YXQkzHd2ikFsUOSb8?=
 =?us-ascii?Q?w6B1tHNvYTkjwRP4iZQcTHspgQ1CX8hPveRZyZZzWkaXpkVo7IztUu4McH69?=
 =?us-ascii?Q?WJ26O8teH+Spe4oB35S9qRat/V0rGP0KJtvEuJni/Ub9xkews9P6uGPzHfJ9?=
 =?us-ascii?Q?Nn57au39B+4WbBoIGmU+HGFdg4AEKjxN4n2faWeTJUZJjUjDAfVgZdLbSZ2W?=
 =?us-ascii?Q?mHeQf2ReLb5BXgHUEOt0G4ZG+MbJAin7MRq1oiQ4ruHuwBpGq5DcxoucMKfE?=
 =?us-ascii?Q?cO+fM5FumIkRJCy0J6LNvKV9voPd6Hf8EjMjaGxe70CJFWmzPlzrjciq1O9W?=
 =?us-ascii?Q?F6+70CcdVlWJbmXPY7RyjJ+IV3Zwf0rAQVKKTrSIllmLlaGzM8aIArYtUyTy?=
 =?us-ascii?Q?GAfV6ignyn6IhGDTM5Q1KMzTzEjH6uuh2DRQeufeZOXDoKX3iYmoSJdqaBaU?=
 =?us-ascii?Q?LRlT2v4DQarBLSNc2HD2LyUZYKywddHGANijjeNuspAlQODq41GUEJPy/prZ?=
 =?us-ascii?Q?tpt3r0/6lzjcgmkbKtAnyz6artmLeahuU3fcc9+Im3dDhFjHjDjExfv07fzG?=
 =?us-ascii?Q?n4+sjcDdMYCQzhwoDdzdgeJkF9jpgckIlbzkvOXBi1AxrnIhb/a7HO0PV2vs?=
 =?us-ascii?Q?YaE4S4oHFa/4d+SzRG1St6JzTQ1wUZzTjo7ioyyvFvjNQZ2StFOYmPafKDL0?=
 =?us-ascii?Q?jtGdUcGFkmd28CdxUfJfnO3i8/OGbAulnf9iv074sqoQ2/znQgvpmN992TZZ?=
 =?us-ascii?Q?yteT8zkQTu28m2HBmHF7tZFm5UjMOIh1llSMq6VMl0oJpZ7rPpfRdpJcZJhS?=
 =?us-ascii?Q?UBcFu4Mf2oodZyAAN2t6XSNk7aIiYxlXMpnpwldyL5h3unrcboJ8zquYzpS9?=
 =?us-ascii?Q?MNHmASmA9E/lWZngs96OQ6Swb+GhDYCG8UUbIac0HuhEAT6Gw+z+pMw3vRP6?=
 =?us-ascii?Q?4XZ1BA6Itg02P4LBfzdDCVNcDS3xaTKDAP/2aHIiK6TK7hnH2woZ7NTGhNvy?=
 =?us-ascii?Q?z9swcGy6/SNzjVaBw9e0NtxBPpI2pmptItFsjaJEk8M9YQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSPy8FgxK8//ryTlz0DmQWbXJe6fayzjelzrzIeQFxgKCuEfFOJnr9jVw1BM?=
 =?us-ascii?Q?fKQhmRmUHAJ/sNxKp3mY7vHdYUxAntUHRH96beRV0vRrLTpN6QjiuZ5bkJKL?=
 =?us-ascii?Q?8+VH3naHqHpH7Cwb0eoVlKhcRZZyPIWfSJfhGK0XzC+upmPlkZVYteHDB+U3?=
 =?us-ascii?Q?2b2JkmRBoP61RK/DCsMv9OFvJfutXozw5Fd0NUtLB5M9yTolv92GGrZZGdEd?=
 =?us-ascii?Q?BK51vIbJZYTXggkz6mXNBS0YrkPTjG1bcDqokWjVgJDa6AN/fGZ/cGlCepOy?=
 =?us-ascii?Q?x/25SMI6dZo9AlLvADGYa4oRaM52fom2Qqau8iMJpy4B61SOCwDsShpCxCCU?=
 =?us-ascii?Q?gKDGIAYDMp6ErBLrTwUJUu5S6n0kcso9L68T4NtuJ9KAH+gl9EjDUQ4yXYkM?=
 =?us-ascii?Q?o2XCObIJC90D2Jej5wiDz2wmvsCW5bVfIvWtOy/iL1z2YOhgFJvrvDvR/yAc?=
 =?us-ascii?Q?iacKR/jo8yRYR1N2ACQbxtujq4M54QQhp7XvO8U9Pw9kyMKOdU1kwvBKskC2?=
 =?us-ascii?Q?Kf8UcBy/he+x6gYM/bQdm3TBjqLQUbM4Jol36ASg1uWDDvcno+h5Uneq5dYj?=
 =?us-ascii?Q?LdH+MTJZvgPmpDabyMyyZwAtiCcIWwVeTG6T8WLdxBqqouJU3bZBK51HlZ8T?=
 =?us-ascii?Q?nBR8DKU1Y55UI6X7Z0EKgw65divUJp33y4ar6Z8DDFCnD+qg6Yrya27hXX7q?=
 =?us-ascii?Q?zHOtsrE7CKoMVdNlvjmEGnB8KQVYB9Ffokuky+P9lj9nwF3qU4iwPG/em2m7?=
 =?us-ascii?Q?V6Gk8m0oRc07Tfj1qXRj/fCdL9UqVIxlg+siYfiRt6Q7Ag4DRlkjXpfUPEEL?=
 =?us-ascii?Q?9qfgXC4vAYmRal2gASVfLyGlHXMBL+5j7c7pr17LOqxOHAHui2OcAOBgbtE1?=
 =?us-ascii?Q?C6KoAt6Ru+ZZwZAYoXWc++08hKC6jUyv55HxVCM/mKWD55x2XPwKr5EeQy4G?=
 =?us-ascii?Q?DaEgyr3SWvD634Qt3HCLtgaJ49N0zkBBaHwth2BYD06u1P0Gl+hyqBZuDmHZ?=
 =?us-ascii?Q?9QNNP0nsaSvfxYQiwUP/8H2qu6REdR3pWGP20lwWQuUwZ/CSxw39XNya5SCL?=
 =?us-ascii?Q?P+E6iW3z5RvBC1itNn81eesVZ2Zu06P8E9+u8KZloBEVFxFSDTwuOSI6MAmm?=
 =?us-ascii?Q?89QXdAo2sY9bGik1IfZrqMDEdNJd4RX8P17O0QqFv2YHb01EpWITLfyVkp8m?=
 =?us-ascii?Q?iQRRd4i4O5eFIACDd4zF+6ybMxcb7IBnvRJzTvfMGoq4yuLEgQEzM+peiADA?=
 =?us-ascii?Q?v9n/4ztYz58WfXp/YdQhDj5KDZ67WsTDnLY/TQcYOM4gb/BqZkemmPA3vqFF?=
 =?us-ascii?Q?Sj0txkooV7BnhmrqFYYexDLfVWrQrSK4CDIYwk+3PpncLuI6meAjV+uKwcUn?=
 =?us-ascii?Q?9XQs1Ipv3g85CpXg3cyyVg1++f5MHa3i0yqqzetLZLzZsdajZQrbs0ag+LBN?=
 =?us-ascii?Q?kuyI9xyDtzatszOHNlk8KuoIsY4TPXmu5mWx8kg0OyU4qyClSgRsy6L61N4H?=
 =?us-ascii?Q?ZmcAWTxnXSzTBF+ZFKxIzqcN6oSjkYngwVjtsL4YoINQAKhjWBxNQ7AME9GB?=
 =?us-ascii?Q?fgV+xb9Sege+L7MKOqo9Rz8DKUs6+aTj7+B9S5DU+dDX4Blxp2GSz8fovqvw?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d78cb25-8084-47e6-be74-08dcd79eb7c8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 04:59:46.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J53lQcHeA5cGD+oU5Xdeg1hww9fOQ+4/xPIDGO9IXUnaZ3rXExLIYjG9u0zK/xDfP029Bak6VCflrrKdgS+ENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com

hi, Chuck Lever,

On Mon, Sep 16, 2024 at 10:43:59PM -0400, Chuck Lever wrote:

[...]

> 
> Hi Oliver, thank you for the report.
> 
> Jeff and I discussed this regression earlier today, and we have
> decided to drop this patch for the v6.12 merge window. It's a new
> feature, so it can wait for v6.13.

thanks a lot for information!

> 
> 
> -- 
> Chuck Lever

