Return-Path: <linux-nfs+bounces-5407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07E953F66
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 04:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13ECCB24E52
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDF26AC3;
	Fri, 16 Aug 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIG8yl73"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825611EA91;
	Fri, 16 Aug 2024 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774277; cv=fail; b=bACU9kzf2aUP4gJN0DYjFuLv0w9Lz8xJH1PebLwCBwZ3bg1AkTaEhueIRvrgjUIpJxiY3DwH4COFKQJ5RKGuYjtRAWzFMQpM3fzGwGQetsbDugW3PgEt8eNMdTJLiKizfcerfgq9nL7qa02T+yaHRFGbfMa1xHzhfq29q/fuhQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774277; c=relaxed/simple;
	bh=JREYQZizCo1J0xqSXgp/dnIn0puzRHxGdjFXmZA58B4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kH2E8AMmQM1m2Ek75s6iycWNpVFqCw9OQ2RH1k51Dk5ITAW1rRP1R0Fxp4NZ9CzOSwk9ZIpt9wgeZuBdKQXgfGluTnSQEC354FxamEr8MjFK6j4UgAqmDgREcWiftVEHyqumPJUEFBtIg3JWGr4NYJHJ/5jHwxBy51mBvBj0Q6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIG8yl73; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723774275; x=1755310275;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JREYQZizCo1J0xqSXgp/dnIn0puzRHxGdjFXmZA58B4=;
  b=oIG8yl73Qve4fzgF8EdgeCzypinjT91+hCz9EKMzdZpz+lRPhKEi3ls9
   xYvdDkzjJUa8qtE+sUJ8GZ0iaa5Q7y4VWrATqiMkBLedMn8B3r6dpV0Ms
   CZf+v8yVjmedjgVvS2/psMdLHe9Q2iEkQWfI5V2nCR2HxrmJd5Y7RQsCX
   DphbTkHgziPYBq4AHtKGhQSQLZuF95OvXjIkOLLzF7yGfjlTQiL1tP4aY
   vLxkU0Sh2uiEN8sNDv3nN8PzbKopPgp1asrihEKNzMM+lCbA6rVgKOd2C
   V37Dp+Aav2kHcoL6PF47lPZFbSK5RQBBwf7W+t5Yd2sDu19QvseEen6Dn
   w==;
X-CSE-ConnectionGUID: LExYAL16RxyCv8yNzDSYUw==
X-CSE-MsgGUID: pKuTpoaKSauVClz48yaPgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21938457"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21938457"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:11:14 -0700
X-CSE-ConnectionGUID: NvjMnbgkSmqObikLiVMB6w==
X-CSE-MsgGUID: ZaalWQeRTc6EX+xEnxeszQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="82737204"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 19:11:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:11:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:11:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4nU7Sbs8b7qladTyFov868atIhDld+5XiR2pW8UNUBJYvzi8KqYb4/3RtlZN+FzcbrmH5e8y6+HgZj8vgLQO6FLuMCL0OMxprLHadlSBx4WpB6rQnU3npPq6z+YaXzmgPoMyZDL0kxPDCXnVCUKBhlV0bUMCz25YCy5lqGYU2iHnsqSmUn90f/fzKL4+fFxzaKWZI3tFBbBgeL/xFueONvQ1q6Z9TuBhEaa/bF1p0MtXpoz8DYYP8o/1pMtF3CR6hKkfJxsViyY/vT8C8keFDsoTydrgmqHGsijXA895bFwet6NwmHccbAWsRi+GE398WDCzoh+FpxI/ZsDfOrKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZuftnxmCep9MGs75kOR+hBrqH8cDZ/4Grf+fI6A/Q4=;
 b=DockUaj7RJRZ1UlXBo0m4KgHJjMrHtVG2ge+TzlJI77b6tCOlq7JWlDBmaUWx9gFwMqffsXvYexv5vbFRDy5GXNwfP94YEpryuLwDN6NRG6KK/sdoN8wNuVhXjhec+CcQB+b9wcU8IZZoZVieg0NJW0/VMh6lMn0BQ1K4Tjy4OTI+6iZaumT+UlSMvTdwcBOPURh0LpAqCJA+2qPqlfZTqGXKeseZzNhC8Dc/Z5fjfTBWcMlxE/KCw0zKO7LXJUGu1VCI/OXjZNCJuadn0EcxjvwUXg0SepUBjEZwadkUKV6ceYkNSwsUUPkZR2CKo6UeRdjTo39N1rwf5J3h9CQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 02:11:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:11:11 +0000
Date: Fri, 16 Aug 2024 10:11:01 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s
 -85.6% regression
Message-ID: <Zr61Ndq8FFJ0/S8K@xsang-OptiPlex-9020>
References: <202408081514.106c770e-oliver.sang@intel.com>
 <20240812112145.GA15197@lst.de>
 <ZrsBlLtc5g4WbuP2@xsang-OptiPlex-9020>
 <20240813064955.GA14163@lst.de>
 <ZrsEaIEbjpT80P9/@xsang-OptiPlex-9020>
 <20240814130415.GA24468@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814130415.GA24468@lst.de>
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7083a3-7010-4337-ddab-08dcbd98b2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AChJOjkshj1WqH42mx0kZI2qoEBqr6Y+Gb4CxZZh0Q+aCRk6oe+cHwX14W?=
 =?iso-8859-1?Q?4cOlaQGA/JIrsM48GAdm6zymJr7Rkq3ZRmK0SXhy6KBuYus7ytnnDAfrQ8?=
 =?iso-8859-1?Q?GjFKG9ZfxfcLjma7BxHickrXLVAd+SqVcbTLBiNRPtH/FJUxfs5pKvY/x4?=
 =?iso-8859-1?Q?CAVCxgUljfPUp0riz1cM4piUm8DHKgGZ8PFhfyrYfSIwtXT3sYDO7XTWvy?=
 =?iso-8859-1?Q?WlpjO0TAAvJgltZnZ4I9sZO2lxA35pM3Jh8Dss85E1leUss8nww9rKCS0s?=
 =?iso-8859-1?Q?V4z6nvjYmcfDzws04bIBKYGR6y8LocmbltD1aZqKg4ybaxaGH23/RBLcjq?=
 =?iso-8859-1?Q?eZI17Jd427gWTFOEphnjGSAueAwxuYbYc4t/602J4FS7e9gvTWK994ecZh?=
 =?iso-8859-1?Q?BtXt9fO7heUMy5fJM5fQ4tQc8MQByirSCHMpj3C7IYUdcj8v0a0rjO8+bi?=
 =?iso-8859-1?Q?EOv9SYIuh71bOLG0wUan47V62EtrHM45BCH1+08/vTI0qrtsYG2+vn8pYP?=
 =?iso-8859-1?Q?a+KESYQBqxc5P1Hx4EHsIRJsVnZeO0v+X0euini8oCAt/fgI//N80YI3OS?=
 =?iso-8859-1?Q?0GyiO9HJ4NtdZQGn9jUA1ZFep+kqXpHDVrqvIqtiiBnRvfIRsNe73nxVby?=
 =?iso-8859-1?Q?ZJh6F1JSJ8G034tm3PUj4tH/HgLrxYTpX6qrEZWZJqW3PhtOacExJ/A3Sr?=
 =?iso-8859-1?Q?m/dvcnttQXjzay0bXZSRW+Jrg6HYPKZRqEhyJrX0V2mwErBEI5pXNukhmf?=
 =?iso-8859-1?Q?euZ7oSwRIo2VWSqFuemLY9WoISbcjA6d0NumD/vUn8ww3ivUKshhkRHQi4?=
 =?iso-8859-1?Q?96qHaThKqzgsJn6x+D45wRscnP5WDStw1rO8boFcEyxfeqto9y01Akec7r?=
 =?iso-8859-1?Q?q+JzT8+d2ILbjhcgHzEw/X1BmqqgzcK8MRoKKeRursDeUo6CquZ5Tlo260?=
 =?iso-8859-1?Q?Lx93M6A9QNUvNgJENn2HtSZRBntfBsXbAUVJQRC/wduwj79MgboExCf6pw?=
 =?iso-8859-1?Q?QlURQcMdHHlBakwkSqEhOBZAkaCVv3y3zous7QN3/FepkNPk2n6uDUXr5S?=
 =?iso-8859-1?Q?jdrkUcd04T9UXFgDlsq0SH2t+lMi7WAt0YPr0UXylo4pfdooWs/HxbNaQV?=
 =?iso-8859-1?Q?Ip5Cyvr1DHCML82koqjOnmfMf5gGl9b1HAtwBdDde1aVRA1ONqclKX582H?=
 =?iso-8859-1?Q?REzkqjeTJ3dW0zxXvyHOh9oqPSAl818Kh4Ody0ZPL0zWmvXcCGhn5T2y3d?=
 =?iso-8859-1?Q?7itBwWOz2QWJXPxe0ZMt17qiROV5NQ2SxpY23eWoUhaD5p5Wx7V6PrQ+Zm?=
 =?iso-8859-1?Q?XCeaLoHzDRDUM97hRnbPPFqIWouPG+sOOp3UUm83klH5L70=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UtA6mRbuIVqX/kyNKHnwWYoq6H1WMdyRz1FGROfm/wcFtiazwLjTNOdVS8?=
 =?iso-8859-1?Q?hUryPorw73lz4kQc5GWzhNWj6hL6ORPX5ES8tml+OHbaSRIkToXSNZWHUW?=
 =?iso-8859-1?Q?VaCr8oMlpyHD9uMPTKygNBm/kHanN1etnp8HNt0ErzjRPHAOUGNWWXytGO?=
 =?iso-8859-1?Q?AcQY+wO3Yv7dm+595UFAxPVXBitWnIVioFegYqp+MClxd4tL6teWPxLJJz?=
 =?iso-8859-1?Q?rUcBmG51leMjePwWGVJMeo2cXi+IxnkrEKcqyQJGwqy/rhRmn64Ux13Yzi?=
 =?iso-8859-1?Q?gdKqIGbuAfs5isq94hMJMm2hYPC1XwUZUcXmMB6Z3msEWLlKT09I/X6eCO?=
 =?iso-8859-1?Q?HtOffHaaJbnSY0iBNzS93qpN6irNtfGT8ouDJkaU5de9UCI501NPNOAwN9?=
 =?iso-8859-1?Q?Ykexoa/1x5855W28D6Jne2uml45jdt2zuLgHU/7bCRw5r8fMD+mpSYjbtx?=
 =?iso-8859-1?Q?Gmu3ZG/BT7IjQAs8aDc8VCKA2Nj5jQBZo+atTwgJOUMhy7FkUdwDvf7a3z?=
 =?iso-8859-1?Q?5fRFPeDaldVn+O88CvHY4ImV1K/8nrM9JTBpBFvkEnEbywzJWtuPbCIWEx?=
 =?iso-8859-1?Q?usYl9aqxhhfBZ56f7Md0S5Bmfj7nsXCIU5AfZl8NZFB9B0CnXwrAvIrELQ?=
 =?iso-8859-1?Q?VJWnNODHkIuek5qJyuteXZETRL5uNk4Sv+mcVMPPuS+z1pjG6B0gpeG+2+?=
 =?iso-8859-1?Q?xsrbYi549rOPpQroImy0G4VQeSDXQZ9wWzd96N8peIQ3B8d31Fnqh/dP1r?=
 =?iso-8859-1?Q?bvU7SOY8MoMhv7q2eZbEFnk8WeQfP++SrvuIB720Lpj6BUntNJIzGPHdfP?=
 =?iso-8859-1?Q?G0JCA6E8B6kTfNg1Wbz2+MEvbOQRDFUXhdwH5kQr9ajpKHW1R90xYkiOLT?=
 =?iso-8859-1?Q?FjOqSyZIvWHcOkQv9kcy5/bmQ9/8PfEGBvJZk5IvA08XPzhGH7wCXaQAw8?=
 =?iso-8859-1?Q?ouSd1skUchU8b6kv6pRmuBG5lQ48wgV2VeAxo9D71H/UhhY0YC0MFPK9y1?=
 =?iso-8859-1?Q?Z9NTlxK4Lss/D9j80J4rP5z97yJH3m7cQplM0+lKSS/DqZXZRf/js7GpsK?=
 =?iso-8859-1?Q?TG8Z/E2OYCq7kBZq7v57tejGVJTKtE0hucsd8nieyP2lzZmD+CUa9yT9oY?=
 =?iso-8859-1?Q?4C91hBzIZwlmwGKtNmHzAt3x8GA6bVEKU1LKOI3iRgM8TygTQxfyIFqSoz?=
 =?iso-8859-1?Q?cQ949eCD6WPZe13ZFWGGRocOAVZmyj6Yl5VsWA4/9dY4J9bfFWStlbdJsz?=
 =?iso-8859-1?Q?82kSn+A45PmBB7mWLIHyr5QCnX24l6Xcm/9LgW0Y7PvcbTGphh5eU2+FBh?=
 =?iso-8859-1?Q?7NQutVjfX1QyMkuJupvgg79junETyHLhXBJwZMdGDBsmSGo3en+VcEEBNs?=
 =?iso-8859-1?Q?nASBbR4/uGC40QrRR+yg5ijuxHBp6PB3sQZC+lByNn+we71IL6IgHnGx7c?=
 =?iso-8859-1?Q?lvZIRer/gtRWTah1xVTAQZL96zciXp+Jvl/m9oJikYYO0S8LOZfUJ3rz9q?=
 =?iso-8859-1?Q?2dtRhP0pfzCDP7vu0dtWvkO1DMNsFP/8WweBz4+QQLctIBEm3guEuBHfCM?=
 =?iso-8859-1?Q?GxLe7UZx8TvmDLxA5e1KVrmg4R82vt+WpHC5c0RLXM54XkYnr+BaXb+Qf/?=
 =?iso-8859-1?Q?55fC7J1P60hUepx10/btEa2G8TWl0OTJ+7EI3/iJMdV12QY6ckCLHYeA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7083a3-7010-4337-ddab-08dcbd98b2f7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:11:11.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAva8q8aly/FJSL6Zo6ItYKoRC2hrEAWeqwi3EJLh+FfOClzi1BrcEZJ+GfIkiIVRcqTVIVko3KAmvotxH7gDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com

hi, Christoph Hellwig,

On Wed, Aug 14, 2024 at 03:04:15PM +0200, Christoph Hellwig wrote:
> > sorry I don't have many details. not sure if https://github.com/filebench/filebench/wiki
> > is helpful for you?
> 
> Not too much.  Especially as I'm not sure what you are actually
> running.  If I run the workloads/randomrw.f from the filebench git
> repository, it fails to run due to a lack of a run statement, and it
> also hardcodes /tmp.  Can you share the actual randomrw.f used for the
> test?

please refer to
https://download.01.org/0day-ci/archive/20240808/202408081514.106c770e-oliver.sang@intel.com/repro-script
for our bot setup [1]

for the 'run statement' issue, you should append a such like
run 60
in workload file workloads/randomrw.f end part

(some workload files under https://github.com/filebench/filebench/blob/master/workloads/
have this, some don't)

[1]
dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda1
mkdir -p /fs/sda1
mount -t ext4 /dev/sda1 /fs/sda1
mkdir /export
mount -t tmpfs nfsv4_root_export /export
mkdir -p /export//fs/sda1
mount --bind /fs/sda1 /export//fs/sda1
echo '/export//fs/sda1 *(rw,no_subtree_check,no_root_squash)' >> /etc/exports
systemctl restart rpcbind
systemctl restart rpc-statd
systemctl restart nfs-idmapd
systemctl restart nfs-server
mkdir -p /nfs/sda1
timeout 5m mount -t nfs -o vers=4 localhost:/fs/sda1 /nfs/sda1
touch /nfs/sda1/wait_for_nfs_grace_period
sync
echo 3 > /proc/sys/vm/drop_caches

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

filebench -f /lkp/benchmarks/filebench/share/filebench/workloads/randomrw.f
sleep 100
rm -rf /nfs/sda1/largefile1 /nfs/sda1/lost+found /nfs/sda1/wait_for_nfs_grace_period



> 
> Also do you run this test on other local file systems exported by
> NFS, e.g. XFS and do you have numbers for that?
> 

we tested the xfs, seems no big diff between 9aac777aaf and 49b29a573d.
39c910a430 seems have a drop.

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/xfs/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomrw.f/filebench

<---- only change part is 'xfs'

commit:
  9aac777aaf ("filemap: Convert generic_perform_write() to support large folios")
  49b29a573d ("nfs: add support for large folios")
  39c910a430 ("nfs: do not extend writes to the entire folio")

9aac777aaf945978 49b29a573da83b65d5f4ecf2db6 39c910a430370fd25d5b5e4b2f4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     25513 ± 22%      +2.7%      26206 ± 22%     -19.2%      20609 ±  9%  filebench.sum_operations/s


but all above data is not stable. kernel test bot won't recognize performance
changes based on this kind of data.

below detail data just FYI.

for 9aac777aaf ("filemap: Convert generic_perform_write() to support large folios")
  "filebench.sum_operations/s": [
    24749.259,
    24963.29,
    39646.08,
    19061.09,
    21232.461,
    23361.606,
    24028.835,
    27065.077
  ],

for 49b29a573d ("nfs: add support for large folios")
  "filebench.sum_operations/s": [
    22241.08,
    23600.1,
    36988.03,
    23380.36,
    18751.434,
    25665.28,
    35146.827,
    23874.923
  ],

for 39c910a430 ("nfs: do not extend writes to the entire folio")
  "filebench.sum_operations/s": [
    22756.036,
    19669.426,
    22478.429,
    18800.486,
    22682.041,
    17167.844,
    19160.962,
    22163.603
  ],


