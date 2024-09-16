Return-Path: <linux-nfs+bounces-6504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1386979D0F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A3D1C22BD0
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160695336B;
	Mon, 16 Sep 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AG4QBRe7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C153487A7
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476111; cv=fail; b=LFM+vxtcw6tgDQRdp32h7pUSCqpDxVjnseiDOvctVeP53BYW9ZTANnOZCK9DaeYzlGSK1Rpj7z4fqfYn6d+dk6lYi4acs84azpscotY2HgmDXcq3vj0zn2YkdGdx3uztXU9CnhD26bh0xiQDXVgnwnm6EViONnXmwcEHhiaOSOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476111; c=relaxed/simple;
	bh=lmaFNeNV0oXZgpZQvgPfVrD3y44w1Pv0tRXxDVueGsA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Q95Lf7ymxkFeXjwCd364ycp9LACjdRL+uNJ5z8MuZM4JrTQlDSvl1xMZ5RH3L5RSST2xY7SNmB+IHyHmWmrgmdfKYlCJyZoQ57651b17j5C121EozeP+tGt1NruEo9kEcCl8i6HoHfp+wloqj495dpyJIULqT71fnMyI6/zr3do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AG4QBRe7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726476109; x=1758012109;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=lmaFNeNV0oXZgpZQvgPfVrD3y44w1Pv0tRXxDVueGsA=;
  b=AG4QBRe7V3aONTpkcq1Y4duV+kIC5jhyF0fYYbOGuqTwzuGnBTEd2N8u
   3nM+A6Wz7UB2DlIsgFyeJ7u4a4lfR6CV8+EoWYC5ZpjOUdXsOYE5LYHOW
   xpOkmr9eK3weyIwZ6U9cAhQ0U9pX6RiBo63FA2L5A/eRQyJ5aU2AY+0j0
   Apys0Fhr4eytGQU+Ea9JC+TRV2r3GLZSSHgOZDG9vTkgoeAHwGqF8YhfX
   P30dFdvGYA1jcbbS92yQmrpXJNr8tGZ7nc23yCYdYyLEerZoYpklnULiI
   dyQwmTU80Cp45Tnx2V5ZtSNMtLYwKh9xaYukuYWWt/9E48mdBHYZnF0wb
   Q==;
X-CSE-ConnectionGUID: FukVQicxSnGDhTmyEguW1A==
X-CSE-MsgGUID: pMc93hbdQdiQrDNlqBdnsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="50710172"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="50710172"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:41:48 -0700
X-CSE-ConnectionGUID: QnmbtahdS6KogmZ63p9Fbw==
X-CSE-MsgGUID: uQbvLk0dQCmkQ85IbgSQPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="69051607"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 01:41:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 01:41:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 01:41:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 01:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMBugFXQMSev+awggS8DLmIsTNSPr6W0HMZHnn9G6pr0trdl6tB5gAingltLuyqP/IzA902woPfHtCXfaOL0tmx+IOK5Nj2iAcXjm6zKsiYQjgdb9Yz0wjJ5b6MvFw/OM75tvbPKkcO1chFswTXOJxz3jekqVNNTWAsmDVo3P+tPueb7R/SzjARfCM/cV7DiQJOsAStf+MZ2rEljdJxdJ4NLteWxQjk8weIlC0AblQ/Sj2LEDLlO+HQMURl+XMj7rfxOS3YiD7KT4gF0BLb+2mLTaU6cR+NDFhL0A/drnCl0AmwWfYMi969zHA1IiVgGdQTvGEjXLqqMlrfe7LxVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bNy4gLw86kGvoef5uX+m7dL2IksaFuj3bhFJEbYWdM=;
 b=aHEPxB8xhaGVrkRMA09wA+Fg7jtciI3p9IB/E69HpJlx1GacIegzYk2gc2b2iPWncWGsMQ5xli5huPJ7iQDrcpDgXOK3ixZPRpVhJo2IRlyPVVH3XGGdMU0JlTb6Y4uGwkk4rvJ9g4rYrwfGM+XEsS6JRz2qoVVViYJg83iiGryAWiDZi8oRzl5bkGgH2jRMuvUMlMcdQXWoNROcNEt+BhvqvEJ0Jkt9QCBMgTdCZq+EYzDhTRTzhIOqXL9N12pq8DjGe6FYxNPtCb3QoYzyu0xeGO2efHNCpUBSUJbyLwTdmgvjIx37cUC0xdT+OT0LSXS2ZGleHcCOOro1ym9cPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8721.namprd11.prod.outlook.com (2603:10b6:408:203::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 08:41:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:41:45 +0000
Date: Mon, 16 Sep 2024 16:41:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Chuck Lever <chuck.lever@oracle.com>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [nfsd]  8cb33389f6:  fsmark.app_overhead 81.6%
 regression
Message-ID: <202409161645.d44bced5-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 049ce292-6045-417b-6ff8-08dcd62b653a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mUbAGqWNQA/kD78wbl9mc9TA141TYL6ZGhJ8BtfwhuE769wYFCDsms2hYu?=
 =?iso-8859-1?Q?R6TSadLsRu6t1Tb9uTpYS2irnpbk1ImrT9W1+TMKHbXXiMGMYeqFovjnqA?=
 =?iso-8859-1?Q?EwgMcgqvbinP6Fse2ieMB7EjNvR+80IRr7VPMB9GSQSdR107XcnciDWp86?=
 =?iso-8859-1?Q?KMahO8j6nG8KxKSBUWtXSZSKPHm8vTX0qBqUPdYhIQyp72N5X9X/DZywOd?=
 =?iso-8859-1?Q?M3eaBPHbNObFEBvy2lRLogJ+x3zLYx5SjmhlTBAYu5rkbRokXGI5sHYeoc?=
 =?iso-8859-1?Q?Mp6hTKIEd69ygEHEC5eCyKqpSYsmYhrlRoyHlmNY4yYMgvtdXAEW/SuGuy?=
 =?iso-8859-1?Q?OMXnhLvsNhhiFWg8FgjLqpceWjbvYq7YGxy9gcyBaw503cgI7kOeLUOmAB?=
 =?iso-8859-1?Q?tN/+GSm3Fko4HtjoYf4gnuBznrt1Hi1Vr3iI+hWjLypI3gYRlqV6/XZVfD?=
 =?iso-8859-1?Q?JbnKnE7Jb1GjPJ4GUvw0o7KXpYerrSKVgbeEUy7C3fBGIY5HWYgQBWN0LH?=
 =?iso-8859-1?Q?VhUnZMsH1zU1x1uC6MvWx3NCNxggk0G5IHVkxIfhwMwZ7od9GkyO+L45z+?=
 =?iso-8859-1?Q?lvGCEdBHknw/6sewnup78ADUcEVJaoKWydnOw2jvZFLZd5tiiQmAw10Szi?=
 =?iso-8859-1?Q?ytaXcS/pmXbSztHsWYWpYO4KpLtCgg16RwF2tWba09psgFLU/358mBxDyX?=
 =?iso-8859-1?Q?zkRqpnXmbz89nzPXn39xc5ejTgZJ0Id6tIW/E//oA24NISRLwN3yRbPt0V?=
 =?iso-8859-1?Q?r7Plh2y351JAOhyQc9Bhx/MeaBKqALT3cFezMod0ImlUmCLTKGrNMpvvdP?=
 =?iso-8859-1?Q?Lc7NVYCOHdGBVgN2Uxq5D4EmqXEeOWngfS3RDMQedxanqV5/foEv93BpzF?=
 =?iso-8859-1?Q?zJK4Jr//IOQkmGb2Q/qjoMwwhzZE33t/v8An0AQmy5v4uIhJVzWge4riB7?=
 =?iso-8859-1?Q?JATeJ7RQYlBi7Dvaawi3Yw6Uw9klK/PD8XksDh8FTyKqk6IHZ1UJm2ozf3?=
 =?iso-8859-1?Q?mJxTXmsUFEPcXJIVej6JwhPcEW6YiVsqNyP4yk/efn8sjeA8qO4YcUdJMj?=
 =?iso-8859-1?Q?mNDyXtTmnHaFRZUCdz1yur6JfLOpzcZofnxrRneXIQEmChGa5XYkx5KI17?=
 =?iso-8859-1?Q?008S4sumaTwDkq5TcvLCIhe0pougx2RW0eIQCDJ4iaKE+55VEWGhW0OY0Q?=
 =?iso-8859-1?Q?WL/nzgBb2I/Xn3XmPrNuEFW1K28vNhO+Jyl8KnW5WuurYESVFT3AE05FQw?=
 =?iso-8859-1?Q?iL/RVNguOiZ52oaZvLL2R0nl3g5HQXybAD8AQZ8G7Xg9j3rnl3+7NTjYWW?=
 =?iso-8859-1?Q?CyCrXpDWlwQVE9y9CM7kV8hQURirIT+ZEk1kWYQ1lcwuHd2LRndcLvUJNe?=
 =?iso-8859-1?Q?EAo7bIStYussxVMlejCTw8GC8QbzYabox57x6jLR2zLIK/r/ObCVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RbrQ2LSRAR5CHI5o9Pg6Izpelxf+/UIhxd/PNcK8h1TvMCftKbGbjdktFw?=
 =?iso-8859-1?Q?nkZol9IZIAnAeRV9ZiKokFbILxdW6Qg79hUr2fWLG9UXlqivFeiZGs/2ML?=
 =?iso-8859-1?Q?YuzZQcRzV3ufkBGfOAN4gjdinNmYREilsNL4L5Anmn7EePgmqoOxF5jH8K?=
 =?iso-8859-1?Q?fIW/Y5Bm4wNt25x4/aGoG/mWkhceIWH1CuULepAdFsE4vWCiOB3gyjRwdS?=
 =?iso-8859-1?Q?pMIYSBCBdSu/AVM2bmzxBPdwIuTnmYPyaidBf35yVBqkenhxBD1Hfgh1Aa?=
 =?iso-8859-1?Q?AT851DDCWmfAS+L1rnUo6KoJ8heN8VfxTfi1Pu/tFF/iYcCwZaBaC11+T+?=
 =?iso-8859-1?Q?7zlkuH2Lr4/srD8GmckdpugH8dwvx+eKYrnwhwunt2+mqdcLaTEJvrk0gn?=
 =?iso-8859-1?Q?vARGVnlG0FTStvK0Gl4seaVUbw1AqBS4DtaLN22aCVPUMVgOs6Hci5Oh0a?=
 =?iso-8859-1?Q?V6nfTiWvQLRSHttvliGekeM8q1Ht9IS2FZaB2SMWwtHVyBGF63LBLShYix?=
 =?iso-8859-1?Q?//Jl08gMq2q/Z5Hl6W4NtxqXZBdS6tL9D9uwLiPtlV4qpj4IqpOHfXeiVr?=
 =?iso-8859-1?Q?rjSGE/ZveS5PFlV74YFgccv+uRbDZIhlkc4fPmrHBPEqX4+oBqyj1dKDgw?=
 =?iso-8859-1?Q?x1MaK5lhvnK7Uy4Huxegp1YIswNlkGOXH+kVjNqu456ZplowSaa+YCzody?=
 =?iso-8859-1?Q?wYz7WbKd54tOhBa1+Ehoh7osTTrn+z0txH7/wWAN7EGpsphCmwlHd4D9cH?=
 =?iso-8859-1?Q?Mbsol1fehY9uz4lqslGZmJzPJl0qwLIhSLHWAdBr63+2DImo+LDyGCvO8T?=
 =?iso-8859-1?Q?Zay3Gufacu4VpSeu/+JNPQTaaLoEjnpZ7MsynNNun9KnWksMWellrjob/3?=
 =?iso-8859-1?Q?2sYxAmrD6JFVp1qqLxnUc5P/wzsVZ4rs7dx6XFrOz2Qm08QSpPh3ELAC+j?=
 =?iso-8859-1?Q?NvAgRJELht95QKL69zl8xAuVft43ztyWVWlh2VQkwh20mFTRmQOlAaKy6J?=
 =?iso-8859-1?Q?ZxEKKl8nwIkGi8i+M+usOg4O3K0xb5tcrxeqMw2nWGz3ksbi187wErf7lm?=
 =?iso-8859-1?Q?qbhF1KIB0lq33egTVtXmGU/iGCbFW6pCdN1RJPPFZLJQ8ADelFGn0/322A?=
 =?iso-8859-1?Q?Ywbs8W7gsFx9+dAdq+i6eLIKEvwnbCwVF38nbhxS+Sdk7+dEFiSh37g/Jn?=
 =?iso-8859-1?Q?FfntU03DzqkWwmdSEQmDT8eYIXP4N2AbEB+dzdeD/xZk6tnZ4zlOOYwYn/?=
 =?iso-8859-1?Q?0H2ifzDjgT3yt+4fMx1k28cDO2uOXiG+nW8R0eVi2Kb/hsY1vlHHrcM6z/?=
 =?iso-8859-1?Q?gaU8cmuBJ4bChNRn/IwfU3HUNl7xc+IwnAl8dCbkl2jQO0BOAf32KUHlr8?=
 =?iso-8859-1?Q?i7B+1qcAPBCxoumxEv1BH5NRCPxvQaTjO1FcBhlU9nQGfl6tWRusNCe0i1?=
 =?iso-8859-1?Q?nbKfGWGnUnRZa0S9QAvdbFLMl9DBOaLYoHinVE3sCw54Je8ZSgm23+Atzh?=
 =?iso-8859-1?Q?MdcXTaY8O8HhYrd2CHQRqk2bh6tEQ542b535HsyYSqO5e7yXCQXSncx1JH?=
 =?iso-8859-1?Q?CLweFWTYls7GC7ofSxaT2Qmmh9fvaqYobgESCdVq3aZWKYTRyWhg4iLOzp?=
 =?iso-8859-1?Q?1dyDghC++rTMCJDwSo+n3Nw4JH/xYG+foiiydE3wfJbRmiEsIJrSIRrw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 049ce292-6045-417b-6ff8-08dcd62b653a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:41:45.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx6w8mhDEsn6cNY6EX4M58mAIGjpwr6dow7SFY8AjZd+e+Z66RSj+2P8l5e8LPaypxA1bECISgXoRUauYuG5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8721
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 81.6% regression of fsmark.app_overhead on:


commit: 8cb33389f66441dc4e54b28fe0d9bd4bcd9b796d ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: fsmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1HDD
	fs: btrfs
	fs2: nfsv4
	filesize: 4K
	test_size: 40M
	sync_method: fsyncBeforeClose
	nr_files_per_directory: 1fpd
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240916/202409161645.d44bced5-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark

commit: 
  e29c78a693 ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
  8cb33389f6 ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")

e29c78a6936e7422 8cb33389f66441dc4e54b28fe0d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     24388 ± 20%     -32.8%      16400 ± 18%  numa-vmstat.node0.nr_slab_reclaimable
     61.50 ±  4%     -10.6%      55.00 ±  6%  perf-c2c.HITM.local
      0.20 ±  3%     +23.0%       0.24 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2977            -6.1%       2796        vmstat.system.cs
   2132466 ±  2%     +81.6%    3871852        fsmark.app_overhead
     53442           -17.3%      44172        fsmark.time.voluntary_context_switches
      2907            -5.7%       2742        perf-stat.i.context-switches
      2902            -5.7%       2737        perf-stat.ps.context-switches
   1724787            -1.0%    1706808        proc-vmstat.numa_hit
   1592345            -1.1%    1574310        proc-vmstat.numa_local
     24.87 ± 33%     -38.9%      15.20 ± 12%  sched_debug.cpu.nr_uninterruptible.max
      4.36 ±  9%     -17.1%       3.61 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     97541 ± 20%     -32.7%      65610 ± 18%  numa-meminfo.node0.KReclaimable
     97541 ± 20%     -32.7%      65610 ± 18%  numa-meminfo.node0.SReclaimable
    256796 ±  9%     -18.7%     208805 ± 13%  numa-meminfo.node0.Slab
   2307911 ± 52%     +68.5%    3888971 ±  5%  numa-meminfo.node1.MemUsed
    193326 ± 12%     +24.7%     241049 ± 12%  numa-meminfo.node1.Slab
      0.90 ± 27%      -0.5        0.36 ±103%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.36 ± 70%      +0.2        0.58 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.btrfs_sync_file.btrfs_do_write_iter.do_iter_readv_writev.vfs_iter_write
      0.52 ± 47%      +0.3        0.78 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.62 ± 12%      +0.3        1.93 ±  9%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.22 ± 21%      -0.3        0.89 ± 10%  perf-profile.children.cycles-pp.readn
      0.46 ± 32%      -0.2        0.24 ± 34%  perf-profile.children.cycles-pp.__close
      0.45 ± 32%      -0.2        0.22 ± 15%  perf-profile.children.cycles-pp.__x64_sys_close
      0.40 ± 29%      -0.2        0.18 ± 38%  perf-profile.children.cycles-pp.__fput
      0.31 ± 23%      -0.2        0.16 ± 33%  perf-profile.children.cycles-pp.irq_work_tick
      0.17 ± 51%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.nfs_file_release
      0.16 ± 43%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.__put_nfs_open_context
      0.26 ± 18%      -0.1        0.15 ± 34%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.15 ± 41%      -0.1        0.03 ±108%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.18 ± 55%      -0.1        0.06 ± 32%  perf-profile.children.cycles-pp.native_apic_mem_eoi
      0.18 ± 32%      -0.1        0.07 ± 81%  perf-profile.children.cycles-pp.flush_end_io
      0.17 ± 41%      -0.1        0.07 ± 93%  perf-profile.children.cycles-pp.mas_store_gfp
      0.52 ±  5%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.02 ±141%      +0.1        0.08 ± 42%  perf-profile.children.cycles-pp.uptime_proc_show
      0.02 ±141%      +0.1        0.08 ± 44%  perf-profile.children.cycles-pp.get_zeroed_page_noprof
      0.02 ±141%      +0.1        0.09 ± 35%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.14 ± 12%      +0.1        0.28 ± 29%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.47 ± 27%      +0.2        0.67 ± 19%  perf-profile.children.cycles-pp.__mmap
      0.70 ± 21%      +0.2        0.91 ±  7%  perf-profile.children.cycles-pp.vfs_write
      0.74 ± 20%      +0.2        0.96 ±  9%  perf-profile.children.cycles-pp.ksys_write
      0.73 ± 21%      +0.3        1.00 ±  7%  perf-profile.children.cycles-pp.copy_process
      1.05 ± 13%      +0.3        1.38 ± 10%  perf-profile.children.cycles-pp.kernel_clone
      0.28 ± 22%      -0.1        0.13 ± 35%  perf-profile.self.cycles-pp.irq_work_tick
      0.18 ± 55%      -0.1        0.06 ± 32%  perf-profile.self.cycles-pp.native_apic_mem_eoi




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


