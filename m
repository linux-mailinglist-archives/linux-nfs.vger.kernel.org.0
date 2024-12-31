Return-Path: <linux-nfs+bounces-8857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDDA9FEC70
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 03:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487C2161443
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5215E97;
	Tue, 31 Dec 2024 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOL/1qz5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1A1BF37
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735613531; cv=fail; b=WeRccClgCWcUm9FOIIyNqOqweJS8IUmKpX+d5TIpSClOae6GU05d/ZX7RRJ6WxAxNl4MAOs76KU0kjNB2PKu2dmv5/7RflSS6+TRsKJ1O7EBukuH0/EckxBuv+aQJ0De6YFYA83k+PAc+1kcolZ2QEH4ApfMd67ZphcNkRvshQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735613531; c=relaxed/simple;
	bh=HyKruaZRXKx6NT91QQ0zZPtUQcVQZapUyWn4H7p42AU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lnZxUikG4cJ+tcEq6kdb6l056+aEZfdSt80+f97DHPD9x0E5WliWLix/euY/tlKjuXNttXWWxh5tYoXyDc+keKoadpoFW4BnRpjGq3RwRF5lQH615rBehwbtVshsXu1wPMjWXltoIu3ZwzKsOwlJNKQuP5bqM0+ikFAH57l/OhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOL/1qz5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735613529; x=1767149529;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HyKruaZRXKx6NT91QQ0zZPtUQcVQZapUyWn4H7p42AU=;
  b=QOL/1qz57k3V4yU/bNCF1XVeHzSyYwiam+HdQ5DDrr33lTyaL5xzltM4
   +O58OUivrs4DyGyZnu7jEmbMfLW2tPJNGNgCaZWNLa3K/UxwU8aMpt6ZR
   5ZAkRs32fFM5c1ljSDHarF1f47s7ZLVPwlbLSLY7kHwSkDs0jAcaXXFWE
   VMcFXCqBEF63YTHpr2h4mTAU+K8hN9efr4zxVXuDUAVej3bgFJ3PZv01k
   6Vw2Ysq5VaroShBTNcDwKo+TVN53vTxNRVLi2Opofv15X54Dnasl20gY/
   YowR6R/jBmWRz0nkHlwgbrlqQtJh71LnN0Ea0ceHRyMZCrOd59G0UuL9z
   Q==;
X-CSE-ConnectionGUID: OjK1mqmFSU2EKNqDpXmpTA==
X-CSE-MsgGUID: pOsUfjCfTaCb8DpZY5fEbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="36056784"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="36056784"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 18:52:05 -0800
X-CSE-ConnectionGUID: n05yKaByS6e18E3Cb9Gj8g==
X-CSE-MsgGUID: GESo9ZYfRFOW7nCFM25qpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105562600"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Dec 2024 18:51:37 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 30 Dec 2024 18:51:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 30 Dec 2024 18:51:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 30 Dec 2024 18:51:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAPe/7sB5vvc5fhhAaWujWeqTvp6BZWVTgHdu3FneC4GrIP6GmyMHCSMIhHQ4m0E0xmfQALkS/NoMql8xYfFI76v/AGmJcBVPnxrj7hiCHEGVI31YtnV5NpwzHEyn/6PulpRsZGIj7KwNW1KtzJp0s9QMjT9Gpmk9nVMA/U0Gvqbv0lFn17NoOPx5h0N30ocupuKI8UzisulfAdpcYBbuNftRnEGvomnC4iklvCmIpWC/UlC5FjKqZNCsB2Qc71sywsrqbAL97lX8yeG5YsT0EGGiOTNzmtXIj9LMwuTvh8ZDv0zgZeqwvzcJS7Kz8/J8M/qZhkL+x9IxPhZdnSTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOY29f19pJZ1S+tZunmQ6OQDp5V4aylKqju64DlnXWk=;
 b=yoxe3cB6u1aVdozfI3kiA0UJoeT4IX68RoPQRe0/Lh4uAYtvBYWyQuId2ljERToO0cHiVxemlMw7QHGpaiUl23bLSB5wEBvdDFUeZeVbjhQhG0iCj46HKa3W1E6UbaXz/m9ZeTLdYK4KDpKGUuKNkkvT89dD5JOkmOClixHHHoImE81RQeYKp3psrZ2VVhocF1ctnlStAxuBlSu1j3mFHfCFhXJThUbskifDixh7Lu9xX8hgR1+3z8wpMnl/kP+Tz5d0FZZQ4ZyfWt9grVU0zjSi7/8TUcdzGLHwXOY8uy32oJcEYJSfhoaVIIzRx11x8E1pj+NNP/1g1+9nH0rfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Tue, 31 Dec
 2024 02:51:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 02:51:03 +0000
Date: Tue, 31 Dec 2024 10:50:54 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: NeilBrown <neilb@suse.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	"Jeff Layton" <jlayton@kernel.org>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [cel:nfsd-testing] [nfsd] ab62726202: fsmark.app_overhead 186.4%
 regression
Message-ID: <Z3NcDsti9+zpfPT+@xsang-OptiPlex-9020>
References: <202412271641.cfba5666-lkp@intel.com>
 <eafd5b52-694c-4abb-8c2d-84094def4751@oracle.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eafd5b52-694c-4abb-8c2d-84094def4751@oracle.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a1b943-09fe-4623-065e-08dd2945f70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?NccVcvbqIr7Y1zC2hvTlTL9C+MnFzjtGgLT08q86mj8C/Os6lCW5De5rWM?=
 =?iso-8859-1?Q?vXImDjJsdq7ofqL9iMp+7mnfrTB/5gzTvX0GucBzEHCrDWjqYK6xRMHPB4?=
 =?iso-8859-1?Q?jtC/6M/dJ9cu3+TlkVvBgVrTEurCPWxl5hl5cKDOpQuqvOj8ehzaQzVXyV?=
 =?iso-8859-1?Q?T4KGepSV2gtc2dKmXYCn3uqbyBe3ceju+SCTpg+OzIDhndL4kyr8kWNbMZ?=
 =?iso-8859-1?Q?kbqqa66kea/H4jE65NZBoAD+m7foxG6bHDdRDP0oIpoo0RBAeZrGPGIKGj?=
 =?iso-8859-1?Q?XqVFfQwA5CDyERfrXcsT+td4kFdXiVuLOOnQs4LJq8UxXMJEDYhnjNh/MN?=
 =?iso-8859-1?Q?v+VajixEI/6f7+3TKippEhNn/+vQIHTLCswrVGfSrcHDJV0e9P9ozfJaK1?=
 =?iso-8859-1?Q?X4diXzfOnQEI8wyYvEKv/jNoqXb4HYTlrNloUT4YG4kxxyL1639gR2EvtV?=
 =?iso-8859-1?Q?2x3deRHCU/Ad45qAuUTaKHdV8PzSK+/Y0TTmKFH32k3omtQA/hdpXoPKWK?=
 =?iso-8859-1?Q?8wtyUZQxdXlYVq+ecC82Ike4iKmpkjTROYc47AT0FZmaW+N1n8US6FbtcG?=
 =?iso-8859-1?Q?b8VYB9dT4TaLHzryou8uf3+ajmy0om/Fj5+U3osDIHMqOb3pS5Cb7z/vuk?=
 =?iso-8859-1?Q?Zl/v7+qKhVq2DnH54URhOheAqYVWoXBf9hwSTfW7IhR3Op+MXj/KejtG+x?=
 =?iso-8859-1?Q?dQJKPZDESm8oKxk941ae/5yeVOS9/rXWBLot+E6x2y8nv3Ab92YBQRNx7/?=
 =?iso-8859-1?Q?92B8HINUjc1P/s9DCozUzIyPofBEgzdSefVI0SxOmfLqGWOV1tXq7dVWIZ?=
 =?iso-8859-1?Q?3XZNR+YSFjIFfTSpIsSu1RcLNrdxRR5bC0wFoLj1Om48iM4gbZbmokBaY7?=
 =?iso-8859-1?Q?ZKel+SA9x59g5XJ6VlC9l07eHJQMJC08wKzZ/o1oeo9GRrOEgbLGuqcLXy?=
 =?iso-8859-1?Q?XFbHey88ab+Ko9xxUJ4GNyWiul9fscyRFj+nBueWqatVqzp+ItEv9gtSZk?=
 =?iso-8859-1?Q?/gtvW5mJnq7GMY1UkOtfiiqXHfn5UwKyDp9+qLqjbnhjruu5AAmPf5Scbx?=
 =?iso-8859-1?Q?ygjrCeUeZj6h38iB9r2+hfmep6rwYXAsxgLKO+1r2j4RdAsxWugMXMKHtU?=
 =?iso-8859-1?Q?JRAIp6jm/WCujTFC6nUX9BUvlMcX4uqI6eOGote0LDOce7ALy1LK6nfXBr?=
 =?iso-8859-1?Q?rYAI6ZzCcCEwxVVm6uPbXBHhUhJui1U5vZgdxvgIyqP+BPF4sJb/OlrjUS?=
 =?iso-8859-1?Q?+Jp1TnDM3JKLoenwJ0lKT6k6L4seAPiqoaJcqZ+WA4jPNYe585YzxoyUVO?=
 =?iso-8859-1?Q?HzbMJ7S/aUz/Kejv+4qP5PO39i21J22b5dfDC9sjt6fDRR2PjXs5yBRbf+?=
 =?iso-8859-1?Q?tSyrsJmagxvzPR2mRguINzNOgSxuTPFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g0xzQoueSp9Ta8VsGNMM/BDO6s+9YdgBve9TlxvvT9gYOu+OB7LuuOsJt/?=
 =?iso-8859-1?Q?ssXtD9mrFQ3l5I3g4l0/yK+FZ7X+BRCWl3hIICL2i4Z7bbCw9clUq4ruxn?=
 =?iso-8859-1?Q?lCg3UOIIMyUlJx+vy7iZji6FAW2pBXks/SmjWR9Mu6ij2dmEumTI4r41DE?=
 =?iso-8859-1?Q?Lg1q8E+pzaoVSR2ayddtD48RZEcFMeaddrUvRAYlCUQhqyQ84HWjl66XWr?=
 =?iso-8859-1?Q?7proAkCufY/sehpo1cHhgrm7XsbnfXJlhn4PJpanKChF+F3uOFQMZC6kw6?=
 =?iso-8859-1?Q?+dByuZzpbMwMKTdNyAaQDj4aLn1sIGR25vaXBLmG9PkRa/kSmSQJWxyxtC?=
 =?iso-8859-1?Q?GW+31N9FiVQbTO4Eo0A+Pfn1nfusfAFqUi4dNWpm4vL1GE6ZtZxQco6cli?=
 =?iso-8859-1?Q?/BzRAqDIooXCxaXsOvuq/hXThMLP/un9MMPHDxCdYhH+JxCQgRpLFPz73+?=
 =?iso-8859-1?Q?AQSX/8wkQeNfh6wP1urG+kw6m6mwLoSAjxE8il8CcNviQeZNhDgZwIvLX2?=
 =?iso-8859-1?Q?WLKHpedyML+nk4AfiXPKZEVvBmX9J6xSVLXT+r3DODT7lxpTCMx5GWKHD6?=
 =?iso-8859-1?Q?2x23AE59uzUiSCrFd89f/+ZLzk4+R8LofRdZmYU+xYaHptl0MpzXhzym1d?=
 =?iso-8859-1?Q?5ZLSWDDax352yXp92uw2eQERrleNf+sh/1uwvXs1ECwRjsbCgfA7iNhfcZ?=
 =?iso-8859-1?Q?gVkwMEjZ+RgwSlRPj84NSmh2a7cyC2SvewBKh1ViNPYMoUAKYc/0E2AtN/?=
 =?iso-8859-1?Q?dy+thaacwf3HN85wboJuAZzl284ab8clqbxvIof4/jocxSFaYDAofCrNd6?=
 =?iso-8859-1?Q?U6USisiBmESRhaipXcP1Hc6IxicAhk1ChonqsZfX26KfJuWs4RJVfMQmTG?=
 =?iso-8859-1?Q?IWutuXVwytjwXGEjm7fzCDTwVXPup1pTA1FHdeSxqmXRfgKIbKymBG29lN?=
 =?iso-8859-1?Q?/NI3FrCynVHq6hUPlL7Oyqbrj6sQxzjTsOUpU9RwahmrqDe1WScllqVbCw?=
 =?iso-8859-1?Q?UMveHQmw/N2BoNUfYaeb5UHdQkJlzr/JWb8DF19LchU98KgYQyQExzAjrG?=
 =?iso-8859-1?Q?EblTQmedaRIFT6czoMsNkNjTo+FwQp/CCiyV+N673OCI3lNDTYFXRRWkli?=
 =?iso-8859-1?Q?TwZ3dR+aRmtfEHb/iEMHDBnuVuDk2FOZwJNyyTl7F9wAD/FQqYQxT0vWMk?=
 =?iso-8859-1?Q?AQupP+9AFPTFxgaAO/LFM48CSOMJGBqmJIpsdMCBFjMM5KAbFgWVNND9vL?=
 =?iso-8859-1?Q?6lm65swnyzgjGHImI9Bgp3zrEZDcDo5COmnIFElBcvVdfH8rb2Km3j19dd?=
 =?iso-8859-1?Q?VM5VR7mn3LOQL8LpHEQldaiuSeCWq7ku+CfYrj+bkac6gsvJfv/W+gs+hq?=
 =?iso-8859-1?Q?hCMdgTgWokwk5jJG4zaqJ5pqi87UV/FEzOrGgLCPJeHp2NCJVtUZVEsc+0?=
 =?iso-8859-1?Q?CGUAlMSW25cUlA0P8x4/iv6mQMBWMw8UuPXjUWF+FK2tiRYdr75O5S6LiA?=
 =?iso-8859-1?Q?FvMRw4+s7LEy/31kzCldOuc3FkbE93CyrK+5vsrSiKimdyMYWAIUererQN?=
 =?iso-8859-1?Q?vzPjZ+OD25mdQBI890i/0beag6+T0ljV11MgcFKxx4245xBLFZlMK2r3E6?=
 =?iso-8859-1?Q?Igwn1g9vYCiVvVe+oujAxqKZmo0SPJ3wqossH1zu7XeJxqOY/R+oDWSQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a1b943-09fe-4623-065e-08dd2945f70d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 02:51:03.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpBbumqsMKNDqlwmcPJ2TJ2XwerJOLgCgV8RtOJwwRIrlFiueN4i3NyXvIMcS5vdew9xmVCO5YjAK2qRmuyP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com

hi, Chuck Lever,

On Sat, Dec 28, 2024 at 12:32:55PM -0500, Chuck Lever wrote:
> On 12/27/24 4:13 AM, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 186.4% regression of fsmark.app_overhead on:
> > (but no diff for fsmark.files_per_sec as below (a))
> 
> Hello Oliver -
> 
> I have questions about this test result.
> 
> Is this https://github.com/josefbacik/fs_mark ?

yes, we use fsmark test suite from this url.

> 
> I don't understand what "app_overhead" is measuring. Is this "think
> time"?

sorry, we just follow the guidance to enable the test.

as in https://download.01.org/0day-ci/archive/20241227/202412271641.cfba5666-lkp@intel.com/repro-script
we run the test by:

fs_mark -d /nfs/sdb1/1 -d /nfs/sdb1/2 -d /nfs/sdb1/3 -d /nfs/sdb1/4 -d /nfs/sdb1/5 -d /nfs/sdb1/6 -d /nfs/sdb1/7 -d /nfs/sdb1/8 -d /nfs/sdb1/9 -d /nfs/sdb1/10 -d /nfs/sdb1/11 -d /nfs/sdb1/12 -d /nfs/sdb1/13 -d /nfs/sdb1/14 -d /nfs/sdb1/15 -d /nfs/sdb1/16 -d /nfs/sdb1/17 -d /nfs/sdb1/18 -d /nfs/sdb1/19 -d /nfs/sdb1/20 -d /nfs/sdb1/21 -d /nfs/sdb1/22 -d /nfs/sdb1/23 -d /nfs/sdb1/24 -d /nfs/sdb1/25 -d /nfs/sdb1/26 -d /nfs/sdb1/27 -d /nfs/sdb1/28 -d /nfs/sdb1/29 -d /nfs/sdb1/30 -d /nfs/sdb1/31 -d /nfs/sdb1/32 -D 16 -N 256 -n 30 -L 1 -S 0 -s 16777216



below is an example of output (there is oneline to explain App overhead (1)):

2024-12-27 00:12:33 fs_mark -d /nfs/sdb1/1 -d /nfs/sdb1/2 -d /nfs/sdb1/3 -d /nfs/sdb1/4 -d /nfs/sdb1/5 -d /nfs/sdb1/6 -d /nfs/sdb1/7 -d /nfs/sdb1/8 -d /nfs/sdb1/9 -d /nfs/sdb1/10 -d /nfs/sdb1/11 -d /nfs/sdb1/12 -d /nfs/sdb1/13 -d /nfs/sdb1/14 -d /nfs/sdb1/15 -d /nfs/sdb1/16 -d /nfs/sdb1/17 -d /nfs/sdb1/18 -d /nfs/sdb1/19 -d /nfs/sdb1/20 -d /nfs/sdb1/21 -d /nfs/sdb1/22 -d /nfs/sdb1/23 -d /nfs/sdb1/24 -d /nfs/sdb1/25 -d /nfs/sdb1/26 -d /nfs/sdb1/27 -d /nfs/sdb1/28 -d /nfs/sdb1/29 -d /nfs/sdb1/30 -d /nfs/sdb1/31 -d /nfs/sdb1/32 -D 16 -N 256 -n 30 -L 1 -S 0 -s 16777216

#  fs_mark  -d  /nfs/sdb1/1  -d  /nfs/sdb1/2  -d  /nfs/sdb1/3  -d  /nfs/sdb1/4  -d  /nfs/sdb1/5  -d  /nfs/sdb1/6  -d  /nfs/sdb1/7  -d  /nfs/sdb1/8  -d  /nfs/sdb1/9  -d  /nfs/sdb1/10  -d  /nfs/sdb1/11  -d  /nfs/sdb1/12  -d  /nfs/sdb1/13  -d  /nfs/sdb1/14  -d  /nfs/sdb1/15  -d  /nfs/sdb1/16  -d  /nfs/sdb1/17  -d  /nfs/sdb1/18  -d  /nfs/sdb1/19  -d  /nfs/sdb1/20  -d  /nfs/sdb1/21  -d  /nfs/sdb1/22  -d  /nfs/sdb1/23  -d  /nfs/sdb1/24  -d  /nfs/sdb1/25  -d  /nfs/sdb1/26  -d  /nfs/sdb1/27  -d  /nfs/sdb1/28  -d  /nfs/sdb1/29  -d  /nfs/sdb1/30  -d  /nfs/sdb1/31  -d  /nfs/sdb1/32  -D  16  -N  256  -n  30  -L  1  -S  0  -s  16777216
#       Version 3.3, 32 thread(s) starting at Fri Dec 27 00:12:33 2024
#       Sync method: NO SYNC: Test does not issue sync() or fsync() calls.
#       Directories:  Round Robin between directories across 16 subdirectories with 256 files per subdirectory.
#       File names: 40 bytes long, (16 initial bytes of time stamp with 24 random bytes at end of name)
#       Files info: size 16777216 bytes, written with an IO size of 16384 bytes per write
#       App overhead is time in microseconds spent in the test not doing file writing related system calls.   <---- (1)

FSUse%        Count         Size    Files/sec     App Overhead
     7          960     16777216          6.4        920331167
Average Files/sec:          6.0
p50 Files/sec: 6
p90 Files/sec: 6
p99 Files/sec: 6


> 
> A more concerning regression might be:
> 
>        13.03 ±170%    +566.0%      86.78 ± 77%
> 
> perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_tcp_sendto
> 
> But these metrics look like they improved:
> 
>         0.03 ± 56%     -73.4%       0.01 ±149%
> perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
>         0.05 ± 60%     -72.1%       0.02 ±165%
> perf-sched.sch_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
> 
> This is a quite mixed result, IMO -- I'm not convinced it's actionable.
> Can someone help explain/analyze the metrics?
> 
> 
> > commit: ab627262022ed8c6a68e619ed03a14e47acf2e39 ("nfsd: allocate new session-based DRC slots on demand.")
> > https://git.kernel.org/cgit/linux/kernel/git/cel/linux nfsd-testing
> > 
> > testcase: fsmark
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> > 
> > 	iterations: 1x
> > 	nr_threads: 32t
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	fs2: nfsv4
> > 	filesize: 16MB
> > 	test_size: 15G
> > 	sync_method: NoSync
> > 	nr_directories: 16d
> > 	nr_files_per_directory: 256fpd
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202412271641.cfba5666-lkp@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241227/202412271641.cfba5666-lkp@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
> >    gcc-12/performance/1HDD/16MB/nfsv4/btrfs/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/NoSync/lkp-icl-2sp7/15G/fsmark
> > 
> > commit:
> >    ccd01c7601 ("nfsd: add session slot count to /proc/fs/nfsd/clients/*/info")
> >    ab62726202 ("nfsd: allocate new session-based DRC slots on demand.")
> > 
> > ccd01c76017847d1 ab627262022ed8c6a68e619ed03
> > ---------------- ---------------------------
> >           %stddev     %change         %stddev
> >               \          |                \
> >        5.48 ±  9%     +24.9%       6.85 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
> >       12489           +11.1%      13876        uptime.idle
> >   3.393e+08 ± 16%    +186.4%  9.717e+08 ±  9%  fsmark.app_overhead
> >        6.40            +0.0%       6.40        fsmark.files_per_sec     <-------- (a)
> >        6.00           +27.8%       7.67 ±  6%  fsmark.time.percent_of_cpu_this_job_got
> >       72.33           +15.8%      83.79        iostat.cpu.idle
> >       25.91 ±  3%     -44.3%      14.42 ± 11%  iostat.cpu.iowait
> >       72.08           +11.6       83.64        mpstat.cpu.all.idle%
> >       26.18 ±  3%     -11.6       14.58 ± 11%  mpstat.cpu.all.iowait%
> >      153772 ±  5%     +19.1%     183126 ±  8%  meminfo.DirectMap4k
> >      156099           +19.5%     186594        meminfo.Dirty
> >      467358           -12.9%     406910 ±  2%  meminfo.Writeback
> >       72.35           +15.8%      83.79        vmstat.cpu.id
> >       25.90 ±  3%     -44.3%      14.41 ± 11%  vmstat.cpu.wa
> >       17.61 ±  3%     -45.8%       9.55 ± 10%  vmstat.procs.b
> >        5909 ±  2%      -6.2%       5545        vmstat.system.in
> >        0.03 ± 56%     -73.4%       0.01 ±149%  perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
> >        0.05 ± 60%     -72.1%       0.02 ±165%  perf-sched.sch_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
> >        0.07 ± 41%     +36.1%       0.10 ±  8%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
> >       13.03 ±170%    +566.0%      86.78 ± 77%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_tcp_sendto
> >      206.83 ± 14%     -31.5%     141.67 ±  6%  perf-sched.wait_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
> >        0.30 ± 62%     -82.1%       0.05 ±110%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_check_data_free_space
> >        7.37 ±  4%     -15.8%       6.20 ±  4%  perf-stat.i.MPKI
> >       44.13 ±  2%      -2.9       41.25 ±  2%  perf-stat.i.cache-miss-rate%
> >      103.65 ±  2%     +17.9%     122.17 ±  8%  perf-stat.i.cpu-migrations
> >      627.67 ±  3%     +25.4%     787.18 ±  6%  perf-stat.i.cycles-between-cache-misses
> >        0.67            +3.7%       0.70        perf-stat.i.ipc
> >        1.35            +2.2%       1.38        perf-stat.overall.cpi
> >      373.39            +4.1%     388.79        perf-stat.overall.cycles-between-cache-misses
> >        0.74            -2.1%       0.73        perf-stat.overall.ipc
> >      102.89 ±  2%     +17.9%     121.32 ±  8%  perf-stat.ps.cpu-migrations
> >       39054           +19.0%      46460 ±  2%  proc-vmstat.nr_dirty
> >       15139            +2.2%      15476        proc-vmstat.nr_kernel_stack
> >       45710            +1.9%      46570        proc-vmstat.nr_slab_unreclaimable
> >      116900           -13.5%     101162        proc-vmstat.nr_writeback
> >       87038           -18.2%      71185 ±  2%  proc-vmstat.nr_zone_write_pending
> >     6949807            -3.8%    6688660        proc-vmstat.numa_hit
> >     6882153            -3.8%    6622312        proc-vmstat.numa_local
> >    13471776            -2.0%   13204489        proc-vmstat.pgalloc_normal
> >      584292            +3.8%     606391 ±  3%  proc-vmstat.pgfault
> >       25859            +9.8%      28392 ±  9%  proc-vmstat.pgreuse
> >        2.02 ±  8%      -0.3        1.71 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
> >        1.86 ±  8%      -0.3        1.58 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
> >        3.42 ±  5%      -0.6        2.87 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
> >        2.96 ±  4%      -0.4        2.55 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
> >        0.35 ± 45%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.khugepaged
> >        0.34 ± 46%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
> >        0.34 ± 46%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
> >        0.34 ± 47%      -0.2        0.14 ± 72%  perf-profile.children.cycles-pp.collapse_huge_page
> >        1.21 ± 10%      -0.2        1.01 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
> >        0.82 ±  9%      -0.1        0.68 ± 10%  perf-profile.children.cycles-pp.update_process_times
> >        0.41 ±  8%      -0.1        0.29 ± 22%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
> >        0.21 ±  7%      -0.1        0.11 ± 73%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
> >        0.55 ± 11%      -0.1        0.46 ± 14%  perf-profile.children.cycles-pp.__set_extent_bit
> >        0.33 ±  9%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.nfs_request_add_commit_list
> >        0.17 ±  9%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.readn
> >        0.08 ± 13%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.load_elf_interp
> >        1.00 ± 16%      +1.2        2.18 ± 53%  perf-profile.children.cycles-pp.folio_batch_move_lru
> >        0.21 ±  8%      -0.1        0.11 ± 73%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
> >        0.05 ± 49%      +0.1        0.15 ± 61%  perf-profile.self.cycles-pp.nfs_update_folio
> >        0.94 ±  5%      +0.2        1.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
> >        0.25 ± 17%      +0.4        0.63 ± 61%  perf-profile.self.cycles-pp.nfs_page_async_flush
> > 
> > 
> > 
> > 
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> > 
> > 
> 
> 
> -- 
> Chuck Lever

