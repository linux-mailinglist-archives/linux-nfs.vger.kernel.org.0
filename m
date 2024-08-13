Return-Path: <linux-nfs+bounces-5340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0294FE0F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 08:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214CC1F23E7C
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958639FF2;
	Tue, 13 Aug 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtCdoXa5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7280B;
	Tue, 13 Aug 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531703; cv=fail; b=n1UuxKGHXI6/VdcpiQlMbfiFgDQI4TwNWUiF8FyVQB57W+EJCTzHPWOb4mFyz+mJgZV8Npo0QZUN4eGjCpr4VQsxWyc391795a5qJoPamJS/Cr6NiVOe3JRWoKamIlKYcbLpDxhrRofSFKDx4OciQi2cXvZrGlqIJnwoFqf3hsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531703; c=relaxed/simple;
	bh=+g/ZiEbW9oaejM7YsO6Um2Oohe+IfSopajXKR9FynI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RcZ/Qg1UUk+wP3fkexR2Z//+m/U3Qixm9DHcQGQA3vouurnjv+/kyNLDtHxf+xiRC2wzNGiBNKCEbismQwlyWTPottE4CCRqDm7yforNcHZbzOeeisxjufSE7Vk+u9FSHl88FvfgPjkoDWpqNc6bC41dxPsl4Mr7/F/WSvSjcz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtCdoXa5; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723531699; x=1755067699;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+g/ZiEbW9oaejM7YsO6Um2Oohe+IfSopajXKR9FynI4=;
  b=BtCdoXa53N7TzIdDli+jicc9zLEedykwvrlbNxNYNCxG/SjMWnUsagdl
   jbMb83/jTzxaCFTmPC0frINu0C2HO1YjcQJdTxAtZmzl9PSDDIH6XRMhV
   UK8xZEUDco5bAHEHNJ++d87sikfyzkO9n9lvt2CZIdKvaZZ6s2MC/iCQG
   FgfDQ8+nNJ1LOyMX/h5UKYZsNlUhHw7EkjF8dVREpBGKAJ03WtdTheu3g
   OKdBmXgqRhQiZnTM2DQNVrpfOrSSPxobXNxrzbb2gggb+LIf3a1NOJQhi
   ucJpEaCKjBrG9ObkKWlJa+VQXenAxasjcdgUqOIaAaGsYLL9tdGG3UtSD
   w==;
X-CSE-ConnectionGUID: NsYxpCGxRT2D/UUZyN6xog==
X-CSE-MsgGUID: ay3zej3pQ42Aiqv7w+HwOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25538193"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="25538193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:48:06 -0700
X-CSE-ConnectionGUID: /Cd+BnoSQ8SLwd9iOBR5vg==
X-CSE-MsgGUID: JnvRVUqsSVifJSlbW69Xaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63423196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 23:48:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 23:48:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 23:48:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 23:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2aEhvxSxPewjwzGEMJKHDtysM4Ij8051CBTuzXru0GTfS5gq2si42MMFJdozmbctSHNntz9q0gC7FAC44zDyIb7gm0NdOmAnOaL6eI+Kcs0dIOR6IAp/Wxc8iINFMRvT9X1ZMvwrYJKog0Ipnc5sEyREJ9tqp0+NdqwyvyNshduJIXiKHwp93i/h3trjyMC31KTDYQ2VENYYhvJe5COP/fz16ujx+jW3Scc79goElO7xowxCetRkgfkM48EZ2a7ufe5BtIPMLEWl6BJyEHiD1341s6fRp16Rl/Jwd5UebcxGXcbO+bD/sqGutmmcCDUeJl30cnBb+MYugqbEoWWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzZLVMsTTu99dS0BCK/O59TEoQdJw6KtgSgPxqR97k4=;
 b=oDXDnHqkrMPCSw66pjmS09t9o5eUwi/HEJRiI2NK/XdKaYGE6URY8s14ygdoLN4rL3k/W48T2C1cAbG1OGuuM1cApkjL6cab/kcr0KT4N0QM2lR/tL79RwHKeVtv6q1Ns3f31CmlDouGUVOWfxrFnyvGDTBv/yI2n74abtddOyl6SBJaIeexFVdynZ2lZJdyrTunCs9uJWPTO+ETHNiw97ohseRiKfqeyXfiFNfr01kbFEnIOhXJWcG9fru7G9QHM7A/gOdWQ6zAgj9NkXoj/8wFpcV840lm9I5LVY9sy/s9OJd5aedfW4rk8OcMqI7rkrbblZaGiGErBmZpFoqi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 06:47:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 06:47:59 +0000
Date: Tue, 13 Aug 2024 14:47:48 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s
 -85.6% regression
Message-ID: <ZrsBlLtc5g4WbuP2@xsang-OptiPlex-9020>
References: <202408081514.106c770e-oliver.sang@intel.com>
 <20240812112145.GA15197@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812112145.GA15197@lst.de>
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: d198f116-72a7-4d6e-0c62-08dcbb63de94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?unWs2uMfdHRJghu3e3yFSn4Grls8xP49n3nvEwjg5RQB6ZjcKLQL5BG4Vn?=
 =?iso-8859-1?Q?wuih3jzcDmJmUNZZsKxmHN/o67WD9nsJBIu6R6LpQGmdI1GK6yVdAtSVrL?=
 =?iso-8859-1?Q?no7XyUFm6480nm6Rl1DkuHnXcscCuG8WUSFz2vuyaP5vKOD+obUOLQGBOn?=
 =?iso-8859-1?Q?JyzMM1nWoHHiH0Wtk3SM619cgm17Bp9E6PnlTO2NRlSHqQNA15OoZDS6GG?=
 =?iso-8859-1?Q?tDDJduPVoDjGmyL/OAn1XQbdArhg99OtktUHORXgMJdxd98wXh+a83dm9B?=
 =?iso-8859-1?Q?sJJHv90ueYoDPnqCekgnSs3AWWJ3ajnNnOcczv+OsU+XuUdCIscT/5MWNE?=
 =?iso-8859-1?Q?tvRDOvqnHwbl0oTMypKEy7kvHjUh/Sm+d2w21PEB51UXBoVKjZeJOexj7k?=
 =?iso-8859-1?Q?C2fhMciiuyJiFtHPiC4/1Ke1wpCO1sP+dvnrpitnvrTKXiUr8/arFwJmyi?=
 =?iso-8859-1?Q?cp7Z5uvS7abhQCg3N4/f7vtkiVmlud/7wumU5UHXQNrsy1yD4vXPetW1KF?=
 =?iso-8859-1?Q?qNjMq8+2YM20LMfFrkz0kRJr+7nJJaOR2e9LJtGXjLQHg/2oocrJVdVjjq?=
 =?iso-8859-1?Q?xuahJYZVKQeROwdhHnQHfk+FWKECff0SGcv8tIFDaJ98sWMbCIpA73waai?=
 =?iso-8859-1?Q?4QZd+t6alJKZa1V5vTUVlXpvsFiVHbagXXoOBpklnDk9l2DaVXIxOYyNCS?=
 =?iso-8859-1?Q?ClRIUDwedpeDCVtRuUAUTxf02pVv/7sAQOfu49Oyeh1DAds62IZ5brCW9A?=
 =?iso-8859-1?Q?roLCJA9jdpfi/JUXCWIPDHwrgxyfHJjk4704Xmq9KjZYbADFYCoMMFrUir?=
 =?iso-8859-1?Q?ieI26V0gn65A/sbKCXiL0Ji4nVeIqTvjdMAyAekkIwz6at2B27USAB1nAt?=
 =?iso-8859-1?Q?TN1DR7H6npBKz7CVz3m7I5tzjlBDn+D6Pd1JQP5nSvlD12kZ2mxZlq2PpG?=
 =?iso-8859-1?Q?pLdLvUWWzs+WB1j8tTDy7V4EY2SsdoMiz6A/zkzNxm5KPcTkQB6aTFYsET?=
 =?iso-8859-1?Q?4hM0k6H6PQOTyUjdfTgq0I4UQkTHXtclrloFeLbAudMwXr+UE3Q4SDVSla?=
 =?iso-8859-1?Q?b8AKDzDIRnbBFVOUV+var3V7ukzqwql4ev0xYrqx8wHef1Gn9C5doFYayI?=
 =?iso-8859-1?Q?47izSRtIJwC7jl0aM6/vHPs7lootCe0cV3uMDyido9fFiVVlkPCC9mrpO/?=
 =?iso-8859-1?Q?wIWFgPzBG4l3GqkG35e1G0CzDfKL9Ni/DClSOuEp2tdrEkPyYwJJjjYtvp?=
 =?iso-8859-1?Q?ljbl6b58mBxZXqe5Z5zUDdTnsjpJ1foJEFmNDKedd+DwA/vV2R0I52e6UK?=
 =?iso-8859-1?Q?Eml9layNTVQNmivwEP/0+42OqP5PzsqVT9QUegkWIU3v2eUcShqvzyVgDn?=
 =?iso-8859-1?Q?/iDSePM4mwtx3ZQKogeefiMhfIaP9TDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mLd7gf5SCu9q2B7N3Xrlph2awkXadZjR0YRaGOXg/KBVXLisM6IZfB4x6a?=
 =?iso-8859-1?Q?hzaYZWWval+Ij9WpoV8+7/TK8eXQq6fUplfGRSMBzt7S3GBTpSbYPohwPV?=
 =?iso-8859-1?Q?xEvEx6agVrJ6BqMaXdmx4cEnQmhfLmzBEbWUyLi5qKKuKiubssUVcF4UXl?=
 =?iso-8859-1?Q?22tXupOwOL9896MVz5vOeZf6eJahWfk0Hx3jlvBXtMPX5jUC2/X1KZ/o2u?=
 =?iso-8859-1?Q?p75kGbwKiTGF0y4d3IaHJqMBn9EhmLE2Qh/VCjfAHP5ybLLHgZ9aw2eENB?=
 =?iso-8859-1?Q?T0+2O/WdGFVDrqDsrSuJx5ZJGXL+UGQ9w6n5lt8pk9xTL3iGx20L5FeMz+?=
 =?iso-8859-1?Q?A8/Oj/THILdrPY/GeWATEUQxe3P+4V0y4PnFznEHwKgdFgZF3tb83OJWmm?=
 =?iso-8859-1?Q?vyeYw3FUbPVZgaoB7hMl3fsFN8fIuaAwa3usNhRGbX3D3EI7XjsCwo53JX?=
 =?iso-8859-1?Q?U6B70vI0tk+N7WnXYbsMvpnVliIp+6HB027q3DaJOKjkvirFtw1KwqwMO+?=
 =?iso-8859-1?Q?8bXUseBXwIFyRNX96+lAYs4ZkHQ9SGXzC+gYzX/F1yiFNHlwwO46fcm4ym?=
 =?iso-8859-1?Q?m+jQupdYd//5UCp1D+BtdRd0JyVZ089Ph8iSuaFzq7vU7ygJ/1M36sImHE?=
 =?iso-8859-1?Q?IhqQa1tNYSdCR7OEkXh19yIdeKoeQS8sJVwWrvnzGlmKeiZsBXEU3bRXCt?=
 =?iso-8859-1?Q?sBaLSIuO4VWKGFANYnJu6a/lMHtn88mnZWr1VCplk3mHSccDn11Ll4IazA?=
 =?iso-8859-1?Q?y71ssTXsUSfb3KOwSE5slYmErBIQrKiMNWcNVmmiKrFP8mJ6G+IPV62pq1?=
 =?iso-8859-1?Q?tRXrntnW4Qtb9mtwA0DTwUyYOPqracxmC3ZgUUeRphsQ79Dkilq/BVTxKV?=
 =?iso-8859-1?Q?0m8KvKPzEuiPemsgbb1JYzBiYEdxewInWZX2fLTIQhE2/UgV9ZESX62MEI?=
 =?iso-8859-1?Q?JC1O7gQXYNDIgjlO47DDPsYZX/Eri9jD6nlBW0GFgjYb5wfGrSYVTwWdzw?=
 =?iso-8859-1?Q?QGbX5uXfWGc9VsumrLm2ltf6wcHCvu0LBVNhV2ByxC/u4NqvdkFpInFJ8l?=
 =?iso-8859-1?Q?/wa/k20UA9poLWc+D0G8S8RSoe1JMSnj8SmstJGn1VdOTc9xdVf0unjPID?=
 =?iso-8859-1?Q?1C50uyDuF2P78ApOZjEchwBTMxDGjkvtc5soAIxX+LzmP6dAPTzI9eOcvl?=
 =?iso-8859-1?Q?wRaXL4YPv6c4AqVVevwFSBdB+PkXfmi+Boobh5xjpBqA3bDm9sOYaK5ax8?=
 =?iso-8859-1?Q?o7g2BYkAj9l7DVbcdTM1RoOFm94irnHzteh1UljxSLRHXSsB3kVh5KFr8+?=
 =?iso-8859-1?Q?wht06eY+8fKa5ZCNMe5Dv4AvNLqcg5W2GQIyGu+CwagY59McTEQ9ItU7q1?=
 =?iso-8859-1?Q?UC3RwCsZTCEx2ATRLqqyHLBua73JJNsxl2BodWji+v6P8uDiUzJQgEcYHI?=
 =?iso-8859-1?Q?YTD+OBvf3IKFujone2aqdh3oafIskyMxw7h/nJMzDKvrWgoX3ghP4Sm1Z4?=
 =?iso-8859-1?Q?ech5wFejzctg4YVSdfXoZm1VMrxOfNF0ffF/VAL/fFpE+ybbzrgEYUuo/E?=
 =?iso-8859-1?Q?e5brKtnXmOQd5BooDCJu6lej/oa99LJnXmiZ+29TW+MFqOtq3z8B8qMwN7?=
 =?iso-8859-1?Q?sViAe5q0j6ewAiaX/IMWNBZ7LEBNhiCoDKbI+t/8WqD7ppdOLhptlVFg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d198f116-72a7-4d6e-0c62-08dcbb63de94
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 06:47:59.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkZpQj2uN7atihtsmOQbRBUBVgLxb/cDI/5JJ74qYphCYoLboLkLWMUKr38OS2YOVzIUFdMUx7JL8vmISzdPgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com

hi, Christoph Hellwig,

On Mon, Aug 12, 2024 at 01:21:45PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 08, 2024 at 03:35:20PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -85.6% regression of filebench.sum_operations/s on:
> 
> I'm not sure what operations this measures.  But if it is what I think it
> might be, does this regression go away with the following commit (which
> already is in mainline)?
> 
> commit 39c910a430370fd25d5b5e4b2f4b24581a705499
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Jul 5 07:42:51 2024 +0200
> 
>     nfs: do not extend writes to the entire folio
> 

no in our tests, becomes even worse actually. detail data is in [1]

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomrw.f/filebench

commit:
  9aac777aaf ("filemap: Convert generic_perform_write() to support large folios")
  49b29a573d ("nfs: add support for large folios")
  39c910a430 ("nfs: do not extend writes to the entire folio")

9aac777aaf945978 49b29a573da83b65d5f4ecf2db6 39c910a430370fd25d5b5e4b2f4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    100309 ± 35%     -81.7%      18307 ±120%     -98.9%       1107 ±  9%  filebench.sum_operations/s


since recently we convert to use gcc-12, above data for 9aac777aaf 49b29a573d
are different with those in our original report after rerun. but trend is
similar.

and data seem not very stable (though still distinct enough to each other among
different commits), so I list detail data here.

for 9aac777aaf

  "filebench.sum_operations/s": [
    71903.725,
    107727.523,
    145913.915,
    145871.645,
    15254.195,
    110211.721,
    103905.218,
    105653.318,
    105911.477,
    90742.831
  ],

for 49b29a573d

  "filebench.sum_operations/s": [
    10868.825,
    11376.494,
    21319.105,
    9556.2,
    8885.713,
    83420.582,
    12523.666,
    10912.477,
    9162.987,
    5051.223
  ],

for 39c910a430

  "filebench.sum_operations/s": [
    1019.414,
    1016.246,
    1116.425,
    973.664,
    1128.914,
    1089.307,
    1362.736,
    1099.302,
    1157.4,
    1114.701
  ],


[1]
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomrw.f/filebench

commit:
  9aac777aaf ("filemap: Convert generic_perform_write() to support large folios")
  49b29a573d ("nfs: add support for large folios")
  39c910a430 ("nfs: do not extend writes to the entire folio")

9aac777aaf945978 49b29a573da83b65d5f4ecf2db6 39c910a430370fd25d5b5e4b2f4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     27254 ± 22%      -7.2%      25291 ± 22%     -30.2%      19036 ±  5%  numa-meminfo.node1.Active(anon)
    400.70 ±108%     -29.8%     281.30 ±152%     -93.9%      24.60 ± 27%  perf-c2c.DRAM.local
    319.17            +2.7%     327.76 ±  2%      -9.2%     289.89        uptime.boot
  3.11e+10            +3.8%  3.228e+10 ±  3%     -11.9%  2.741e+10        cpuidle..time
   4984791 ± 28%      -8.4%    4565787 ± 28%     -82.2%     887365        cpuidle..usage
     98.10            -0.8%      97.34            +1.2%      99.24        iostat.cpu.idle
      1.56 ± 23%     +55.3%       2.42 ±  8%     -63.0%       0.58        iostat.cpu.iowait
      6810 ± 22%      -7.2%       6321 ± 22%     -30.1%       4759 ±  5%  numa-vmstat.node1.nr_active_anon
      6810 ± 22%      -7.2%       6321 ± 22%     -30.1%       4759 ±  5%  numa-vmstat.node1.nr_zone_active_anon
     29209 ± 21%      -5.9%      27485 ± 19%     -28.0%      21029 ±  4%  meminfo.Active(anon)
   1488681 ± 15%     -57.5%     632263 ± 38%     -50.0%     744602 ±  6%  meminfo.Dirty
    393102           -20.6%     312102 ±  5%     -23.4%     301066        meminfo.SUnreclaim
     66112 ±  9%      -1.6%      65039 ±  7%     -16.2%      55394        meminfo.Shmem
    648778           -13.8%     559100 ±  3%     -15.8%     546419        meminfo.Slab
      1.57 ± 23%      +0.9        2.43 ±  8%      -1.0        0.58        mpstat.cpu.all.iowait%
      0.02 ± 15%      +0.0        0.02 ±  5%      -0.0        0.01 ±  4%  mpstat.cpu.all.soft%
      0.26 ± 14%      -0.1        0.16 ± 16%      -0.2        0.10 ±  2%  mpstat.cpu.all.sys%
      0.05 ±  8%      -0.0        0.04 ±  4%      -0.0        0.04        mpstat.cpu.all.usr%
      4.00           -25.0%       3.00           -25.0%       3.00        mpstat.max_utilization.seconds
     42296 ±  7%     +32.4%      55991 ± 18%     -41.5%      24748        vmstat.io.bo
      2.02 ± 24%     +54.7%       3.13 ±  8%     -63.4%       0.74 ±  6%  vmstat.procs.b
      1.54 ±  4%      -9.7%       1.39 ±  3%     -11.7%       1.36 ±  4%  vmstat.procs.r
     36557 ± 29%     -12.8%      31886 ± 32%     -91.5%       3124 ±  3%  vmstat.system.cs
      4732 ± 15%     -17.2%       3917 ± 29%     -23.4%       3622 ±  2%  vmstat.system.in
    242.09            +3.6%     250.91 ±  3%     -12.1%     212.83        time.elapsed_time
    242.09            +3.6%     250.91 ±  3%     -12.1%     212.83        time.elapsed_time.max
  20761124 ±  8%     +37.8%   28604910 ± 20%     +62.0%   33640448 ±  6%  time.file_system_outputs
     89.80 ± 42%     -84.0%      14.40 ± 31%     -92.9%       6.40 ± 32%  time.involuntary_context_switches
     14207            -5.3%      13450 ±  2%     -10.5%      12715        time.minor_page_faults
     15.30 ± 34%     -87.6%       1.90 ±129%    -100.0%       0.00        time.percent_of_cpu_this_job_got
     34.90 ± 32%     -83.5%       5.75 ±101%     -97.0%       1.04 ±  4%  time.system_time
      3.19 ± 40%     -85.6%       0.46 ± 94%     -97.7%       0.08 ± 12%  time.user_time
   3230390 ± 31%     -78.5%     693676 ±130%     -99.1%      28507 ±  7%  time.voluntary_context_switches
    783.66 ± 35%     -81.7%     143.04 ±120%     -98.9%       8.64 ±  9%  filebench.sum_bytes_mb/s
   6019202 ± 35%     -81.7%    1098559 ±120%     -98.9%      66474 ±  9%  filebench.sum_operations
    100309 ± 35%     -81.7%      18307 ±120%     -98.9%       1107 ±  9%  filebench.sum_operations/s
     52305 ± 33%     -79.6%      10648 ±127%     -98.2%     918.80 ± 10%  filebench.sum_reads/s
      0.03 ±110%    +457.7%       0.16 ± 43%   +6256.3%       1.82 ±  8%  filebench.sum_time_ms/op
     48003 ± 38%     -84.0%       7659 ±114%     -99.6%     188.70 ±  9%  filebench.sum_writes/s
    242.09            +3.6%     250.91 ±  3%     -12.1%     212.83        filebench.time.elapsed_time
    242.09            +3.6%     250.91 ±  3%     -12.1%     212.83        filebench.time.elapsed_time.max
  20761124 ±  8%     +37.8%   28604910 ± 20%     +62.0%   33640448 ±  6%  filebench.time.file_system_outputs
     14207            -5.3%      13450 ±  2%     -10.5%      12715        filebench.time.minor_page_faults
     15.30 ± 34%     -87.6%       1.90 ±129%    -100.0%       0.00        filebench.time.percent_of_cpu_this_job_got
     34.90 ± 32%     -83.5%       5.75 ±101%     -97.0%       1.04 ±  4%  filebench.time.system_time
   3230390 ± 31%     -78.5%     693676 ±130%     -99.1%      28507 ±  7%  filebench.time.voluntary_context_switches
      5353 ±  9%     -20.2%       4270 ± 12%     -16.2%       4485 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.avg
      5353 ±  9%     -20.2%       4270 ± 12%     -16.2%       4485 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
    180949 ±  7%      -0.2%     180620 ± 11%     -13.2%     157009 ±  8%  sched_debug.cpu.clock.avg
    180963 ±  7%      -0.2%     180632 ± 11%     -13.2%     157021 ±  8%  sched_debug.cpu.clock.max
    180930 ±  7%      -0.2%     180600 ± 11%     -13.2%     156990 ±  8%  sched_debug.cpu.clock.min
    180778 ±  7%      -0.2%     180445 ± 11%     -13.2%     156850 ±  8%  sched_debug.cpu.clock_task.avg
    180934 ±  7%      -0.2%     180601 ± 11%     -13.2%     156995 ±  8%  sched_debug.cpu.clock_task.max
    172070 ±  8%      -0.1%     171841 ± 11%     -13.8%     148376 ±  8%  sched_debug.cpu.clock_task.min
      0.00 ± 23%     -41.8%       0.00 ± 45%     +17.4%       0.00 ± 63%  sched_debug.cpu.next_balance.stddev
     43241 ± 34%     -21.6%      33913 ± 38%     -90.6%       4053 ±  8%  sched_debug.cpu.nr_switches.avg
   1467016 ± 34%     -69.4%     449490 ± 66%     -97.8%      32538 ± 24%  sched_debug.cpu.nr_switches.max
    631.54 ± 11%      +2.6%     647.79 ± 21%     -16.9%     524.85 ± 11%  sched_debug.cpu.nr_switches.min
    164469 ± 29%     -55.5%      73162 ± 41%     -97.0%       4919 ± 10%  sched_debug.cpu.nr_switches.stddev
    180950 ±  7%      -0.2%     180619 ± 11%     -13.2%     157008 ±  8%  sched_debug.cpu_clk
    180224 ±  7%      -0.2%     179894 ± 11%     -13.3%     156282 ±  8%  sched_debug.ktime
    181759 ±  7%      -0.2%     181428 ± 10%     -13.2%     157819 ±  8%  sched_debug.sched_clk
      7299 ± 21%      -5.9%       6871 ± 19%     -28.0%       5256 ±  4%  proc-vmstat.nr_active_anon
    372843 ± 15%     -57.5%     158372 ± 38%     -50.0%     186326 ±  6%  proc-vmstat.nr_dirty
     13951            +0.9%      14083            -3.9%      13402        proc-vmstat.nr_mapped
     16536 ±  9%      -1.7%      16261 ±  7%     -16.1%      13866        proc-vmstat.nr_shmem
     63932            -3.4%      61741            -4.0%      61376        proc-vmstat.nr_slab_reclaimable
     98280           -20.6%      78021 ±  5%     -23.4%      75267        proc-vmstat.nr_slab_unreclaimable
      7299 ± 21%      -5.9%       6871 ± 19%     -28.0%       5256 ±  4%  proc-vmstat.nr_zone_active_anon
    386619 ± 13%      -4.7%     368327 ± 17%     -49.3%     196170 ±  5%  proc-vmstat.nr_zone_write_pending
      2042 ± 61%     -57.5%     867.90 ± 29%     -92.2%     159.80 ± 30%  proc-vmstat.numa_hint_faults
      1503 ± 17%     -56.3%     657.60 ± 30%     -96.9%      45.90 ±102%  proc-vmstat.numa_hint_faults_local
   5231737 ± 35%     -19.4%    4217786 ± 37%     -55.8%    2311589        proc-vmstat.numa_hit
   5099157 ± 36%     -19.9%    4085262 ± 38%     -57.3%    2179161        proc-vmstat.numa_local
     16280 ±124%     -74.2%       4194 ± 33%     -96.0%     655.70 ± 47%  proc-vmstat.numa_pte_updates
   1160800 ± 27%      +7.3%    1245889 ± 15%     +13.4%    1315967        proc-vmstat.pgactivate
   7695175 ± 24%     +15.6%    8896125 ± 13%     -36.3%    4899322        proc-vmstat.pgalloc_normal
    750565            +2.6%     770119 ±  2%      -9.3%     681069        proc-vmstat.pgfault
   7645166 ± 24%      -1.3%    7543115 ± 16%     -53.5%    3557195        proc-vmstat.pgfree
  10381756 ±  8%     +37.8%   14303106 ± 20%     -48.5%    5347677        proc-vmstat.pgpgout
     36983            +2.6%      37938 ±  2%      -8.4%      33875        proc-vmstat.pgreuse
      2.71 ± 14%      +8.7%       2.94 ± 16%     -29.6%       1.91 ±  3%  perf-stat.i.MPKI
 1.967e+08 ± 11%     -30.7%  1.363e+08 ± 20%     -51.4%   95541508        perf-stat.i.branch-instructions
      3.27 ±  5%      -0.1        3.19 ±  5%      +0.9        4.17        perf-stat.i.branch-miss-rate%
   3983754 ±  4%      -9.1%    3620399 ± 10%      -4.8%    3791850        perf-stat.i.branch-misses
      7.17 ± 16%      -0.7        6.45 ± 13%      -3.8        3.39 ±  3%  perf-stat.i.cache-miss-rate%
   5001882 ± 21%     -41.6%    2921780 ± 17%     -76.1%    1193694 ±  2%  perf-stat.i.cache-misses
  25150802 ± 10%     -25.8%   18654089 ± 17%     -48.8%   12876923        perf-stat.i.cache-references
     36959 ± 29%     -12.9%      32206 ± 32%     -91.7%       3055 ±  3%  perf-stat.i.context-switches
      1.91 ±  2%      +4.2%       1.99 ±  3%      +5.1%       2.01 ±  2%  perf-stat.i.cpi
  1.61e+09 ± 12%     -28.4%  1.152e+09 ± 14%     -57.7%  6.811e+08        perf-stat.i.cpu-cycles
    184.09 ±  6%     -16.1%     154.40 ± 13%     -23.2%     141.33        perf-stat.i.cpu-migrations
 9.054e+08 ± 11%     -27.9%  6.526e+08 ± 19%     -48.2%  4.688e+08        perf-stat.i.instructions
      0.57 ±  2%      -3.8%       0.55 ±  2%      -3.7%       0.55        perf-stat.i.ipc
      0.25 ± 37%     -24.6%       0.19 ± 45%    -100.0%       0.00        perf-stat.i.metric.K/sec
      5.50 ± 18%     -17.4%       4.54 ± 11%     -53.4%       2.56 ±  2%  perf-stat.overall.MPKI
      2.06 ± 15%      +0.6        2.70 ±  8%      +1.9        3.96        perf-stat.overall.branch-miss-rate%
     19.72 ± 17%      -4.0       15.76 ±  8%     -10.4        9.31 ±  2%  perf-stat.overall.cache-miss-rate%
      1.78 ±  7%      +0.2%       1.78 ±  5%     -18.2%       1.46        perf-stat.overall.cpi
    333.30 ± 16%     +19.0%     396.63 ±  9%     +70.8%     569.21 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.57 ±  7%      -0.4%       0.56 ±  5%     +21.6%       0.69        perf-stat.overall.ipc
  1.96e+08 ± 11%     -30.6%  1.359e+08 ± 19%     -51.4%   95209820        perf-stat.ps.branch-instructions
   3964680 ±  4%      -9.1%    3604521 ± 10%      -4.9%    3770958        perf-stat.ps.branch-misses
   4984920 ± 21%     -41.4%    2920752 ± 17%     -76.0%    1195796 ±  2%  perf-stat.ps.cache-misses
  25058655 ± 10%     -25.7%   18617868 ± 17%     -48.7%   12845143        perf-stat.ps.cache-references
     36798 ± 29%     -12.8%      32082 ± 32%     -91.7%       3044 ±  3%  perf-stat.ps.context-switches
 1.604e+09 ± 12%     -28.3%   1.15e+09 ± 14%     -57.6%  6.802e+08        perf-stat.ps.cpu-cycles
    183.26 ±  6%     -16.1%     153.73 ± 13%     -23.3%     140.64        perf-stat.ps.cpu-migrations
 9.019e+08 ± 11%     -27.8%  6.509e+08 ± 19%     -48.2%  4.672e+08        perf-stat.ps.instructions
 2.196e+11 ± 12%     -25.5%  1.636e+11 ± 18%     -54.5%  9.985e+10        perf-stat.total.instructions
     45.60 ± 18%     -33.1       12.53 ± 83%     -29.8       15.77 ± 21%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     44.60 ± 20%     -32.7       11.92 ± 82%     -30.5       14.13 ± 25%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     33.44 ± 30%     -30.7        2.79 ±237%     -33.3        0.17 ±154%  perf-profile.calltrace.cycles-pp.rpc_async_release.process_one_work.worker_thread.kthread.ret_from_fork
     33.44 ± 30%     -30.6        2.79 ±238%     -33.3        0.17 ±154%  perf-profile.calltrace.cycles-pp.rpc_free_task.rpc_async_release.process_one_work.worker_thread.kthread
     68.48 ± 14%     -30.1       38.35 ± 30%     -42.6       25.89 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     68.48 ± 14%     -30.1       38.35 ± 30%     -42.6       25.89 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     68.48 ± 14%     -30.1       38.35 ± 30%     -42.6       25.89 ± 11%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     23.26 ± 33%     -21.3        1.96 ±241%     -23.2        0.06 ±299%  perf-profile.calltrace.cycles-pp.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work.worker_thread
     12.96 ± 45%     -12.0        0.92 ±274%     -13.0        0.00        perf-profile.calltrace.cycles-pp.nfs_page_end_writeback.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work
     12.46 ± 46%     -11.6        0.87 ±276%     -12.5        0.00        perf-profile.calltrace.cycles-pp.folio_end_writeback.nfs_page_end_writeback.nfs_write_completion.rpc_free_task.rpc_async_release
     12.14 ± 47%     -11.3        0.84 ±277%     -12.1        0.00        perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.nfs_page_end_writeback.nfs_write_completion.rpc_free_task
     10.63 ± 51%     -10.0        0.68 ±300%     -10.6        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__folio_end_writeback.folio_end_writeback.nfs_page_end_writeback.nfs_write_completion
     10.28 ± 51%      -9.6        0.66 ±300%     -10.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__folio_end_writeback.folio_end_writeback.nfs_page_end_writeback
     10.17 ± 30%      -9.4        0.82 ±230%     -10.2        0.00        perf-profile.calltrace.cycles-pp.nfs_commit_release.rpc_free_task.rpc_async_release.process_one_work.worker_thread
     10.16 ± 30%      -9.3        0.82 ±230%     -10.2        0.00        perf-profile.calltrace.cycles-pp.nfs_commit_release_pages.nfs_commit_release.rpc_free_task.rpc_async_release.process_one_work
      9.26 ± 34%      -8.4        0.91 ±223%      -9.3        0.00        perf-profile.calltrace.cycles-pp.nfs_request_add_commit_list.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work
      8.16 ± 32%      -7.5        0.61 ±238%      -8.2        0.00        perf-profile.calltrace.cycles-pp.nfs_inode_remove_request.nfs_commit_release_pages.nfs_commit_release.rpc_free_task.rpc_async_release
      6.91 ± 33%      -6.4        0.51 ±244%      -6.9        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.nfs_inode_remove_request.nfs_commit_release_pages.nfs_commit_release.rpc_free_task
      6.83 ± 39%      -6.2        0.67 ±223%      -6.8        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.nfs_request_add_commit_list.nfs_write_completion.rpc_free_task.rpc_async_release
      6.37 ± 33%      -5.9        0.47 ±246%      -6.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.nfs_inode_remove_request.nfs_commit_release_pages.nfs_commit_release
      6.01 ± 41%      -5.4        0.59 ±225%      -6.0        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.nfs_request_add_commit_list.nfs_write_completion.rpc_free_task
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.63 ± 12%  perf-profile.calltrace.cycles-pp.nfs_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.63 ± 11%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.63 ± 12%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn.process_one_work
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.63 ± 12%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.63 ± 12%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.64 ± 12%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_do_writeback.wb_workfn.process_one_work.worker_thread
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.64 ± 12%  perf-profile.calltrace.cycles-pp.wb_do_writeback.wb_workfn.process_one_work.worker_thread.kthread
      3.19 ± 21%      -2.6        0.55 ±225%      -2.6        0.64 ± 12%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      3.18 ± 21%      -2.6        0.55 ±225%      -2.6        0.56 ± 35%  perf-profile.calltrace.cycles-pp.write_cache_pages.nfs_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file.nfsd_commit.nfsd4_commit
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.90 ± 13%  perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file.nfsd_commit
      5.42 ± 13%      -2.4        2.97 ± 44%      -3.8        1.58 ±  9%  perf-profile.calltrace.cycles-pp.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      2.60 ± 23%      -2.2        0.43 ±226%      -2.1        0.48 ± 51%  perf-profile.calltrace.cycles-pp.nfs_writepages_callback.write_cache_pages.nfs_writepages.do_writepages.__writeback_single_inode
      5.85 ± 58%      -1.9        3.91 ± 80%     +12.1       17.92 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.48 ± 23%      -1.2        0.32 ±201%      -1.2        0.33 ±100%  perf-profile.calltrace.cycles-pp.folio_wait_bit_common.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages
      2.49 ± 13%      -0.6        1.91 ± 24%      -1.8        0.65 ± 19%  perf-profile.calltrace.cycles-pp.mpage_process_page_bufs.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages
      0.61 ± 11%      -0.5        0.12 ±200%      +1.1        1.69 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.61 ± 11%      -0.5        0.12 ±200%      +1.1        1.69 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.62 ± 12%      -0.4        0.17 ±153%      +1.2        1.77 ± 10%  perf-profile.calltrace.cycles-pp.read
      0.54 ± 35%      -0.4        0.11 ±200%      +1.0        1.57 ± 10%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.54 ± 35%      -0.4        0.11 ±200%      +1.1        1.61 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.75 ± 15%      -0.2        1.51 ± 25%      -1.3        0.43 ± 68%  perf-profile.calltrace.cycles-pp.mpage_submit_folio.mpage_process_page_bufs.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages
      0.63 ± 35%      -0.2        0.40 ± 84%      +3.7        4.34 ± 12%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.47 ± 50%      -0.2        0.26 ±123%      +3.2        3.69 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.60 ± 15%      -0.2        0.39 ± 83%      +2.1        2.68 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.60 ± 15%      -0.2        0.39 ± 83%      +2.1        2.69 ± 15%  perf-profile.calltrace.cycles-pp.execve
      0.60 ± 15%      -0.2        0.39 ± 83%      +2.1        2.69 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.60 ± 15%      -0.2        0.39 ± 83%      +2.1        2.69 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      2.07 ± 16%      -0.2        1.89 ± 23%      +9.6       11.68 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.86 ± 13%      -0.2        0.68 ± 41%      +4.6        5.43 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.94 ± 14%      -0.2        1.78 ± 24%      +8.6       10.49 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.55 ± 36%      -0.2        0.39 ± 83%      +2.1        2.66 ± 15%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.87 ± 22%      -0.1        0.73 ± 17%      +2.7        3.56 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.87 ± 22%      -0.1        0.74 ± 18%      +2.7        3.58 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.88 ± 13%      -0.1        0.75 ± 24%      +4.7        5.57 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.97 ± 42%      -0.1        0.85 ± 33%      +2.0        2.93 ± 14%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.96 ± 13%      -0.1        4.85 ± 15%      -3.4        1.61 ± 14%  perf-profile.calltrace.cycles-pp.xs_tcp_send_request.xprt_request_transmit.xprt_transmit.call_transmit.__rpc_execute
      4.47 ± 18%      -0.1        4.36 ± 18%      -3.8        0.69 ± 18%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xprt_sock_sendmsg.xs_tcp_send_request
      0.11 ±200%      -0.1        0.00            +1.5        1.56 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      5.84 ± 19%      -0.1        5.74 ± 34%      -1.7        4.10 ± 10%  perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread.kthread
      4.83 ± 16%      -0.1        4.73 ± 17%      -3.9        0.90 ± 18%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.xprt_sock_sendmsg.xs_tcp_send_request.xprt_request_transmit
      4.84 ± 16%      -0.1        4.74 ± 17%      -3.9        0.94 ± 17%  perf-profile.calltrace.cycles-pp.sock_sendmsg.xprt_sock_sendmsg.xs_tcp_send_request.xprt_request_transmit.xprt_transmit
      4.85 ± 16%      -0.1        4.75 ± 17%      -3.9        0.95 ± 17%  perf-profile.calltrace.cycles-pp.xprt_sock_sendmsg.xs_tcp_send_request.xprt_request_transmit.xprt_transmit.call_transmit
      5.09 ± 11%      -0.1        4.99 ± 15%      -3.1        2.00 ± 12%  perf-profile.calltrace.cycles-pp.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread
      2.85 ± 13%      -0.1        2.76 ± 21%      -2.0        0.85 ± 17%  perf-profile.calltrace.cycles-pp.svc_tcp_recvfrom.svc_handle_xprt.svc_recv.nfsd.kthread
      5.85 ± 19%      -0.1        5.75 ± 34%      -1.7        4.13 ± 10%  perf-profile.calltrace.cycles-pp.rpc_async_schedule.process_one_work.worker_thread.kthread.ret_from_fork
      5.05 ± 12%      -0.1        4.96 ± 15%      -3.2        1.88 ± 12%  perf-profile.calltrace.cycles-pp.xprt_request_transmit.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule
      5.06 ± 11%      -0.1        4.97 ± 15%      -3.1        1.94 ± 12%  perf-profile.calltrace.cycles-pp.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work
      0.05 ±300%      -0.1        0.00            +1.5        1.50 ± 16%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.05 ±300%      -0.1        0.00            +1.5        1.51 ± 16%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.05 ±299%      -0.1        0.00            +1.4        1.45 ± 16%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.69 ± 42%      -0.0        0.66 ± 46%      +2.2        2.92 ± 15%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.08 ±300%      -0.0        0.06 ±300%      +1.0        1.10 ± 16%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.0        0.00            +0.7        0.65 ± 16%  perf-profile.calltrace.cycles-pp.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.0        0.00            +0.7        0.65 ± 15%  perf-profile.calltrace.cycles-pp.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.0        0.00            +0.7        0.66 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.0        0.00            +0.7        0.66 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__vfork
      0.00            +0.0        0.00            +0.7        0.72 ± 13%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00            +0.0        0.00            +0.7        0.74 ± 13%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.7        0.74 ± 13%  perf-profile.calltrace.cycles-pp.__vfork
      0.00            +0.0        0.00            +0.8        0.85 ±  9%  perf-profile.calltrace.cycles-pp.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.9        0.88 ± 11%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.9        0.88 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.9        0.92 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      0.00            +0.0        0.00            +0.9        0.92 ± 16%  perf-profile.calltrace.cycles-pp.setlocale
      0.00            +0.0        0.00            +0.9        0.92 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      0.00            +0.0        0.00            +0.9        0.94 ± 19%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair
      0.00            +0.0        0.00            +0.9        0.95 ± 19%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule
      0.00            +0.0        0.00            +1.0        0.96 ± 21%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +1.0        0.96 ± 21%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +1.0        0.96 ± 21%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +1.0        0.99 ± 19%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      0.00            +0.0        0.00            +1.0        0.99 ± 20%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule.schedule
      0.00            +0.0        0.00            +1.1        1.06 ± 19%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +0.0        0.00            +1.1        1.06 ± 19%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.balance_fair.__schedule.schedule.smpboot_thread_fn
      0.00            +0.0        0.00            +1.1        1.06 ± 21%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.0        0.00            +1.1        1.12 ± 21%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.0        0.00            +1.1        1.15 ± 11%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.0        0.00            +1.2        1.19 ± 18%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +0.0        0.00            +1.2        1.19 ± 12%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.0        0.00            +1.2        1.20 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.0        0.00            +1.3        1.28 ± 16%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +0.0        0.00            +1.3        1.28 ± 17%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.0        0.00            +1.3        1.32 ±  9%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.0        0.00            +1.3        1.34 ±  9%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.06 ±300%      +0.0        0.06 ±299%      +1.7        1.78 ± 12%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ±200%      +0.0        0.11 ±200%      +2.6        2.70 ± 11%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.06 ±300%      +0.0        0.08 ±299%      +0.7        0.73 ± 22%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.72 ± 42%      +0.0        0.74 ± 32%      +2.4        3.13 ± 15%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.09 ±299%      +0.0        0.12 ±300%      +0.9        0.96 ± 25%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.process_one_work.worker_thread.kthread
      0.10 ±299%      +0.0        0.14 ±299%      +0.9        1.05 ± 24%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.process_one_work.worker_thread.kthread.ret_from_fork
      0.06 ±300%      +0.2        0.31 ±101%      +1.6        1.66 ± 15%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.56 ± 19%      +0.3        4.87 ± 31%      -4.2        0.40 ± 83%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.do_iter_readv_writev.vfs_iter_write.nfsd_vfs_write
      0.45 ± 72%      +0.7        1.13 ± 48%      +0.9        1.30 ± 16%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      0.45 ± 72%      +0.7        1.13 ± 48%      +0.8        1.30 ± 16%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.45 ± 72%      +0.7        1.13 ± 48%      +0.8        1.30 ± 16%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.45 ± 72%      +0.7        1.13 ± 48%      +0.8        1.30 ± 16%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.45 ± 72%      +0.7        1.13 ± 48%      +0.8        1.30 ± 16%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      0.45 ± 72%      +0.7        1.13 ± 48%      +0.8        1.30 ± 16%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.05 ±300%      +0.8        0.81 ± 52%      +0.8        0.86 ± 22%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.11 ±200%      +0.8        0.94 ± 39%      +0.9        1.05 ± 17%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.21 ±154%      +1.2        1.42 ± 46%      +0.5        0.66 ± 36%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      7.98 ± 70%      +1.2        9.23 ± 79%      -8.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.ext4_buffered_write_iter.do_iter_readv_writev
      8.00 ± 70%      +1.2        9.24 ± 79%      -8.0        0.00        perf-profile.calltrace.cycles-pp.down_write.ext4_buffered_write_iter.do_iter_readv_writev.vfs_iter_write.nfsd_vfs_write
      7.99 ± 70%      +1.2        9.24 ± 79%      -8.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.ext4_buffered_write_iter.do_iter_readv_writev.vfs_iter_write
      5.57 ± 13%      +1.3        6.89 ± 39%      -3.6        1.98 ± 13%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.ext4_sync_file.nfsd_commit.nfsd4_commit.nfsd4_proc_compound
      5.57 ± 13%      +1.3        6.90 ± 39%      -3.5        2.04 ± 13%  perf-profile.calltrace.cycles-pp.ext4_sync_file.nfsd_commit.nfsd4_commit.nfsd4_proc_compound.nfsd_dispatch
      5.57 ± 13%      +1.3        6.90 ± 39%      -3.5        2.04 ± 13%  perf-profile.calltrace.cycles-pp.nfsd_commit.nfsd4_commit.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
      5.58 ± 13%      +1.3        6.90 ± 39%      -3.4        2.14 ± 12%  perf-profile.calltrace.cycles-pp.nfsd4_commit.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
     12.70 ± 49%      +1.6       14.28 ± 60%     -11.7        0.98 ± 23%  perf-profile.calltrace.cycles-pp.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
     12.64 ± 49%      +1.6       14.25 ± 61%     -11.8        0.88 ± 25%  perf-profile.calltrace.cycles-pp.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
     12.61 ± 49%      +1.6       14.22 ± 61%     -11.8        0.85 ± 27%  perf-profile.calltrace.cycles-pp.vfs_iter_write.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch
     12.60 ± 49%      +1.6       14.21 ± 61%     -11.8        0.82 ± 26%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.do_iter_readv_writev.vfs_iter_write.nfsd_vfs_write.nfsd4_write
     12.60 ± 49%      +1.6       14.22 ± 61%     -11.8        0.82 ± 27%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.vfs_iter_write.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound
      0.53 ± 74%      +1.7        2.20 ± 39%      +0.5        1.06 ± 20%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.82 ± 51%      +2.1        2.88 ± 37%      +0.5        1.32 ± 16%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     22.26 ± 25%      +2.9       25.13 ± 38%     -15.5        6.73 ± 10%  perf-profile.calltrace.cycles-pp.nfsd.kthread.ret_from_fork.ret_from_fork_asm
     22.24 ± 25%      +2.9       25.12 ± 38%     -15.5        6.72 ± 10%  perf-profile.calltrace.cycles-pp.svc_recv.nfsd.kthread.ret_from_fork.ret_from_fork_asm
     22.07 ± 25%      +2.9       24.98 ± 38%     -15.6        6.42 ± 11%  perf-profile.calltrace.cycles-pp.svc_handle_xprt.svc_recv.nfsd.kthread.ret_from_fork
     18.49 ± 32%      +2.9       21.44 ± 45%     -14.8        3.73 ± 14%  perf-profile.calltrace.cycles-pp.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt
     18.59 ± 32%      +2.9       21.53 ± 44%     -14.7        3.88 ± 14%  perf-profile.calltrace.cycles-pp.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt.svc_recv
     18.68 ± 32%      +3.0       21.63 ± 44%     -14.6        4.06 ± 13%  perf-profile.calltrace.cycles-pp.svc_process.svc_handle_xprt.svc_recv.nfsd.kthread
     18.67 ± 32%      +3.0       21.63 ± 44%     -14.6        4.06 ± 13%  perf-profile.calltrace.cycles-pp.svc_process_common.svc_process.svc_handle_xprt.svc_recv.nfsd
      1.77 ± 72%      +3.0        4.76 ± 46%      +0.5        2.22 ± 20%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.86 ± 44%      +7.5        8.36 ± 61%      +2.3        3.20 ± 15%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     15.15 ± 42%      +8.5       23.68 ± 18%     +27.5       42.63 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     13.02 ± 41%      +9.0       22.02 ± 18%     +24.6       37.65 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     12.84 ± 40%      +9.8       22.60 ± 18%     +24.7       37.57 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     19.12 ± 44%     +12.3       31.47 ± 14%     +29.8       48.88 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     19.15 ± 44%     +12.4       31.50 ± 14%     +29.8       48.92 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     19.16 ± 44%     +12.4       31.53 ± 14%     +29.8       48.92 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     19.74 ± 43%     +12.9       32.66 ± 14%     +30.5       50.23 ±  6%  perf-profile.calltrace.cycles-pp.common_startup_64
     45.60 ± 18%     -33.1       12.54 ± 83%     -29.8       15.77 ± 21%  perf-profile.children.cycles-pp.worker_thread
     44.60 ± 20%     -32.7       11.92 ± 82%     -30.5       14.14 ± 25%  perf-profile.children.cycles-pp.process_one_work
     33.44 ± 30%     -30.6        2.83 ±234%     -33.0        0.47 ± 17%  perf-profile.children.cycles-pp.rpc_async_release
     33.44 ± 30%     -30.6        2.83 ±234%     -33.0        0.47 ± 17%  perf-profile.children.cycles-pp.rpc_free_task
     68.51 ± 14%     -30.1       38.38 ± 30%     -42.5       26.01 ± 11%  perf-profile.children.cycles-pp.ret_from_fork_asm
     68.48 ± 14%     -30.1       38.35 ± 30%     -42.6       25.89 ± 11%  perf-profile.children.cycles-pp.kthread
     68.50 ± 14%     -30.1       38.37 ± 30%     -42.5       26.00 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
     23.26 ± 33%     -21.3        1.98 ±239%     -22.9        0.39 ± 19%  perf-profile.children.cycles-pp.nfs_write_completion
     18.49 ± 33%     -15.3        3.15 ±105%     -15.3        3.22 ± 19%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.97 ± 45%     -12.0        0.92 ±273%     -12.8        0.16 ± 39%  perf-profile.children.cycles-pp.nfs_page_end_writeback
     12.93 ± 44%     -11.5        1.46 ±162%     -12.6        0.31 ± 29%  perf-profile.children.cycles-pp.__folio_end_writeback
     13.28 ± 43%     -10.6        2.68 ± 88%     -12.9        0.36 ± 25%  perf-profile.children.cycles-pp.folio_end_writeback
     12.41 ± 43%     -10.3        2.06 ±108%     -11.4        0.99 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     10.17 ± 30%      -9.4        0.82 ±230%     -10.1        0.07 ± 41%  perf-profile.children.cycles-pp.nfs_commit_release
     10.17 ± 30%      -9.4        0.82 ±230%     -10.1        0.07 ± 41%  perf-profile.children.cycles-pp.nfs_commit_release_pages
      9.27 ± 34%      -8.4        0.91 ±223%      -9.2        0.08 ± 67%  perf-profile.children.cycles-pp.nfs_request_add_commit_list
      8.16 ± 32%      -7.5        0.61 ±238%      -8.1        0.01 ±203%  perf-profile.children.cycles-pp.nfs_inode_remove_request
      6.92 ± 38%      -6.1        0.77 ±205%      -6.6        0.33 ± 35%  perf-profile.children.cycles-pp.__mutex_lock
      8.24 ± 20%      -5.6        2.68 ± 58%      -4.8        3.41 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      8.76 ± 11%      -5.0        3.80 ± 62%      -6.2        2.54 ± 12%  perf-profile.children.cycles-pp.do_writepages
     11.18 ± 47%      -4.5        6.63 ± 80%     -11.1        0.10 ± 49%  perf-profile.children.cycles-pp.osq_lock
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.63 ± 12%  perf-profile.children.cycles-pp.nfs_writepages
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.63 ± 12%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.63 ± 12%  perf-profile.children.cycles-pp.__writeback_single_inode
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.63 ± 12%  perf-profile.children.cycles-pp.writeback_sb_inodes
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.64 ± 12%  perf-profile.children.cycles-pp.wb_writeback
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.64 ± 12%  perf-profile.children.cycles-pp.wb_do_writeback
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.64 ± 12%  perf-profile.children.cycles-pp.wb_workfn
      3.19 ± 21%      -2.5        0.70 ±169%      -2.6        0.61 ± 12%  perf-profile.children.cycles-pp.write_cache_pages
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.90 ± 13%  perf-profile.children.cycles-pp.ext4_do_writepages
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.children.cycles-pp.ext4_writepages
      5.57 ± 13%      -2.5        3.10 ± 43%      -3.7        1.91 ± 13%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      5.43 ± 13%      -2.5        2.98 ± 44%      -3.9        1.58 ±  9%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      2.61 ± 23%      -2.0        0.57 ±163%      -2.0        0.57 ± 15%  perf-profile.children.cycles-pp.nfs_writepages_callback
      2.46 ± 28%      -2.0        0.48 ±169%      -2.3        0.15 ± 46%  perf-profile.children.cycles-pp.nfs_page_async_flush
      6.00 ± 56%      -1.9        4.12 ± 77%     +12.2       18.16 ±  6%  perf-profile.children.cycles-pp.intel_idle
      1.44 ± 29%      -1.3        0.16 ±221%      -1.3        0.13 ± 40%  perf-profile.children.cycles-pp.mutex_lock
      1.59 ± 29%      -0.8        0.80 ± 37%      -1.5        0.13 ± 52%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.72 ± 19%      -0.6        0.13 ±215%      -0.5        0.22 ± 50%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      2.50 ± 12%      -0.6        1.92 ± 24%      -1.9        0.65 ± 19%  perf-profile.children.cycles-pp.mpage_process_page_bufs
      0.59 ± 19%      -0.5        0.06 ±210%      -0.5        0.12 ± 49%  perf-profile.children.cycles-pp.__nfs_commit_inode
      0.59 ± 19%      -0.5        0.07 ±205%      -0.6        0.03 ±103%  perf-profile.children.cycles-pp.nfs_io_completion_put
      0.74 ± 12%      -0.3        0.41 ± 18%      -0.5        0.22 ± 22%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.28 ± 35%      -0.3        0.99 ± 38%      -0.7        0.63 ± 14%  perf-profile.children.cycles-pp.io_schedule
      0.77 ± 13%      -0.2        0.52 ± 23%      +1.5        2.26 ±  5%  perf-profile.children.cycles-pp.ksys_read
      0.83 ± 12%      -0.2        0.59 ± 23%      +1.8        2.58 ±  5%  perf-profile.children.cycles-pp.read
      0.58 ±  5%      -0.2        0.33 ± 34%      -0.4        0.21 ± 23%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      1.76 ± 15%      -0.2        1.51 ± 25%      -1.2        0.55 ± 24%  perf-profile.children.cycles-pp.mpage_submit_folio
      1.37 ± 19%      -0.2        1.14 ± 30%      -0.9        0.49 ± 26%  perf-profile.children.cycles-pp.ext4_bio_write_folio
      0.63 ± 13%      -0.2        0.41 ± 30%      -0.5        0.08 ± 80%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.34 ± 14%      -0.2        0.13 ± 71%      -0.3        0.07 ± 71%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.87 ± 28%      -0.2        0.66 ± 26%      -0.6        0.32 ± 35%  perf-profile.children.cycles-pp.xas_load
      0.46 ± 11%      -0.2        0.27 ± 34%      +0.6        1.04 ±  9%  perf-profile.children.cycles-pp.seq_read_iter
      0.21 ± 15%      -0.2        0.04 ±213%      -0.1        0.07 ± 62%  perf-profile.children.cycles-pp.get_slabinfo
      0.21 ± 15%      -0.2        0.04 ±213%      -0.2        0.03 ±106%  perf-profile.children.cycles-pp.count_partial_free_approx
      1.18 ± 11%      -0.2        1.02 ± 20%      +4.8        5.96 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.67 ± 12%      -0.2        2.51 ± 19%      +9.7       12.36 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.39 ± 45%      -0.2        0.23 ± 65%      +0.8        1.15 ± 18%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.16 ± 11%      -0.2        1.01 ± 20%      +4.7        5.83 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.31 ± 12%      -0.1        0.16 ± 31%      -0.1        0.17 ± 32%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      2.44 ± 11%      -0.1        2.29 ± 20%      +8.9       11.37 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.94 ± 11%      -0.1        0.80 ± 21%      +3.7        4.65 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.02 ± 42%      -0.1        0.90 ± 30%      +2.0        3.02 ± 14%  perf-profile.children.cycles-pp.menu_select
      0.24 ± 18%      -0.1        0.13 ± 21%      -0.2        0.09 ± 49%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.25 ± 25%      -0.1        0.14 ± 43%      -0.2        0.08 ± 47%  perf-profile.children.cycles-pp.nfs_pageio_add_request
      4.96 ± 13%      -0.1        4.86 ± 15%      -3.4        1.61 ± 14%  perf-profile.children.cycles-pp.xs_tcp_send_request
      2.94 ± 11%      -0.1        2.84 ± 22%      -1.8        1.17 ± 17%  perf-profile.children.cycles-pp.sock_recvmsg
      2.93 ± 11%      -0.1        2.82 ± 22%      -1.8        1.11 ± 16%  perf-profile.children.cycles-pp.inet6_recvmsg
      0.64 ± 13%      -0.1        0.54 ± 21%      +2.3        2.97 ±  9%  perf-profile.children.cycles-pp.update_process_times
      0.80 ± 11%      -0.1        0.70 ± 21%      +3.2        3.98 ± 10%  perf-profile.children.cycles-pp.tick_nohz_handler
      2.92 ± 10%      -0.1        2.82 ± 22%      -1.8        1.11 ± 16%  perf-profile.children.cycles-pp.tcp_recvmsg
      5.85 ± 19%      -0.1        5.75 ± 34%      -1.7        4.13 ± 10%  perf-profile.children.cycles-pp.rpc_async_schedule
      2.85 ± 13%      -0.1        2.76 ± 21%      -2.0        0.85 ± 16%  perf-profile.children.cycles-pp.svc_tcp_recvfrom
      4.85 ± 16%      -0.1        4.75 ± 17%      -3.9        0.95 ± 17%  perf-profile.children.cycles-pp.xprt_sock_sendmsg
      0.26 ± 50%      -0.1        0.17 ± 66%      +0.6        0.84 ± 22%  perf-profile.children.cycles-pp.tick_nohz_next_event
      5.09 ± 11%      -0.1        5.00 ± 15%      -3.1        2.00 ± 12%  perf-profile.children.cycles-pp.call_transmit
      5.05 ± 12%      -0.1        4.96 ± 15%      -3.2        1.88 ± 12%  perf-profile.children.cycles-pp.xprt_request_transmit
      0.20 ± 17%      -0.1        0.11 ± 20%      -0.1        0.08 ± 62%  perf-profile.children.cycles-pp.__mod_node_page_state
      5.06 ± 11%      -0.1        4.98 ± 15%      -3.1        1.94 ± 12%  perf-profile.children.cycles-pp.xprt_transmit
      5.84 ± 19%      -0.1        5.75 ± 34%      -1.7        4.11 ± 10%  perf-profile.children.cycles-pp.__rpc_execute
      0.22 ± 26%      -0.1        0.14 ± 43%      -0.1        0.08 ± 47%  perf-profile.children.cycles-pp.__nfs_pageio_add_request
      0.25 ± 36%      -0.1        0.17 ± 52%      +0.5        0.72 ± 18%  perf-profile.children.cycles-pp.clockevents_program_event
      5.22 ± 11%      -0.1        5.14 ± 15%      -3.3        1.90 ± 10%  perf-profile.children.cycles-pp.tcp_sendmsg
      5.24 ± 11%      -0.1        5.16 ± 15%      -3.3        1.96 ±  9%  perf-profile.children.cycles-pp.sock_sendmsg
      2.69 ± 14%      -0.1        2.61 ± 22%      -2.0        0.68 ± 16%  perf-profile.children.cycles-pp.svc_tcp_sock_recv_cmsg
      4.78 ± 12%      -0.1        4.71 ± 13%      -3.2        1.55 ± 13%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
      0.22 ± 19%      -0.1        0.16 ± 41%      +0.4        0.61 ± 28%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.12 ± 24%      -0.1        0.06 ± 61%      -0.1        0.04 ±111%  perf-profile.children.cycles-pp.xas_clear_mark
      2.59 ± 20%      -0.1        2.53 ± 26%      -2.2        0.37 ± 23%  perf-profile.children.cycles-pp.svc_tcp_read_msg
      0.15 ± 51%      -0.1        0.09 ± 78%      +0.2        0.37 ± 27%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.27 ± 20%      -0.1        0.21 ± 23%      +0.8        1.10 ± 23%  perf-profile.children.cycles-pp.__mmput
      0.09 ± 49%      -0.1        0.03 ±106%      +0.2        0.29 ± 30%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.08 ± 64%      -0.1        0.03 ±157%      +0.2        0.31 ± 15%  perf-profile.children.cycles-pp.timerqueue_del
      0.26 ± 21%      -0.1        0.21 ± 23%      +0.8        1.08 ± 23%  perf-profile.children.cycles-pp.exit_mmap
      0.12 ± 42%      -0.1        0.06 ± 67%      +0.2        0.30 ± 41%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.24 ± 21%      -0.1        0.19 ± 28%      +0.2        0.45 ± 21%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ± 12%      -0.1        0.08 ± 27%      -0.0        0.10 ± 73%  perf-profile.children.cycles-pp.tag_pages_for_writeback
      0.15 ± 34%      -0.0        0.10 ± 83%      +0.4        0.53 ± 15%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.41 ± 17%      -0.0        0.36 ± 28%      +1.4        1.80 ± 12%  perf-profile.children.cycles-pp.bprm_execve
      0.58 ± 19%      -0.0        0.53 ± 17%      +1.8        2.38 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.31 ± 14%      -0.0        0.26 ± 27%      +1.0        1.29 ± 10%  perf-profile.children.cycles-pp.sched_tick
      0.58 ± 20%      -0.0        0.53 ± 21%      +1.9        2.51 ± 11%  perf-profile.children.cycles-pp.cmd_stat
      0.58 ± 20%      -0.0        0.53 ± 21%      +1.9        2.51 ± 11%  perf-profile.children.cycles-pp.dispatch_events
      0.28 ± 28%      -0.0        0.23 ± 18%      +0.9        1.14 ± 20%  perf-profile.children.cycles-pp.do_exit
      0.24 ± 29%      -0.0        0.19 ± 18%      +0.8        1.02 ± 19%  perf-profile.children.cycles-pp.do_group_exit
      0.58 ± 21%      -0.0        0.53 ± 21%      +1.9        2.50 ± 11%  perf-profile.children.cycles-pp.process_interval
      0.07 ± 61%      -0.0        0.02 ±162%      +0.1        0.19 ± 26%  perf-profile.children.cycles-pp.tmigr_update_events
      0.17 ± 38%      -0.0        0.12 ± 21%      +0.5        0.64 ± 16%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.24 ± 29%      -0.0        0.19 ± 19%      +0.8        1.02 ± 19%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.07 ± 45%      -0.0        0.02 ±165%      +0.2        0.23 ± 49%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.33 ± 20%      -0.0        0.29 ± 28%      +1.1        1.45 ± 16%  perf-profile.children.cycles-pp.load_elf_binary
      0.34 ± 20%      -0.0        0.30 ± 30%      +1.2        1.50 ± 16%  perf-profile.children.cycles-pp.search_binary_handler
      0.35 ± 20%      -0.0        0.30 ± 30%      +1.2        1.52 ± 16%  perf-profile.children.cycles-pp.exec_binprm
      0.25 ± 16%      -0.0        0.21 ± 17%      -0.2        0.06 ± 61%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.56 ± 20%      -0.0        0.52 ± 21%      +1.9        2.43 ± 11%  perf-profile.children.cycles-pp.read_counters
      0.15 ± 41%      -0.0        0.11 ± 19%      +0.4        0.58 ± 19%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.11 ±  9%      -0.0        0.07 ± 62%      +0.3        0.45 ± 20%  perf-profile.children.cycles-pp.begin_new_exec
      0.08 ± 29%      -0.0        0.04 ± 90%      +0.2        0.26 ± 31%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.12 ± 38%      -0.0        0.08 ± 77%      +0.3        0.41 ± 24%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.23 ± 28%      -0.0        0.19 ± 20%      +0.8        0.99 ± 16%  perf-profile.children.cycles-pp.kernel_clone
      0.05 ± 69%      -0.0        0.01 ±300%      +0.2        0.21 ± 48%  perf-profile.children.cycles-pp.__vm_munmap
      0.21 ± 15%      -0.0        0.17 ± 29%      +0.6        0.82 ± 25%  perf-profile.children.cycles-pp.readn
      0.60 ± 15%      -0.0        0.56 ± 22%      +2.1        2.67 ± 15%  perf-profile.children.cycles-pp.do_execveat_common
      0.60 ± 15%      -0.0        0.56 ± 22%      +2.1        2.69 ± 15%  perf-profile.children.cycles-pp.execve
      0.31 ± 27%      -0.0        0.27 ± 22%      +1.0        1.30 ± 10%  perf-profile.children.cycles-pp.do_mmap
      0.48 ± 18%      -0.0        0.44 ± 17%      +1.5        2.01 ±  9%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.60 ± 15%      -0.0        0.56 ± 22%      +2.1        2.69 ± 14%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.29 ± 22%      -0.0        0.25 ± 44%      +1.0        1.27 ± 19%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.32 ± 27%      -0.0        0.29 ± 21%      +1.0        1.37 ± 10%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.18 ± 16%      -0.0        0.15 ± 22%      -0.2        0.04 ±122%  perf-profile.children.cycles-pp.folio_unlock
      0.07 ± 81%      -0.0        0.03 ±146%      +0.2        0.29 ± 19%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.49 ± 18%      -0.0        0.45 ± 16%      +1.5        2.03 ±  8%  perf-profile.children.cycles-pp.exc_page_fault
      0.20 ± 22%      -0.0        0.17 ± 22%      +0.6        0.84 ± 24%  perf-profile.children.cycles-pp.exit_mm
      0.24 ± 29%      -0.0        0.20 ± 24%      +0.7        0.94 ± 14%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.05 ± 78%      -0.0        0.02 ±154%      +0.2        0.21 ± 36%  perf-profile.children.cycles-pp.rb_next
      0.04 ± 71%      -0.0        0.01 ±300%      +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.__run_timers
      0.28 ± 22%      -0.0        0.25 ± 43%      +1.0        1.23 ± 19%  perf-profile.children.cycles-pp.tick_irq_enter
      0.05 ± 85%      -0.0        0.02 ±156%      +0.2        0.23 ± 30%  perf-profile.children.cycles-pp.sync_regs
      0.19 ± 43%      -0.0        0.16 ± 60%      +0.4        0.64 ± 26%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.11 ± 27%      -0.0        0.08 ± 33%      +0.3        0.45 ± 39%  perf-profile.children.cycles-pp.zap_pte_range
      0.11 ± 28%      -0.0        0.08 ± 36%      +0.4        0.46 ± 37%  perf-profile.children.cycles-pp.zap_pmd_range
      0.17 ± 28%      -0.0        0.14 ± 25%      -0.1        0.06 ± 90%  perf-profile.children.cycles-pp.xas_start
      0.12 ± 29%      -0.0        0.09 ± 35%      +0.4        0.48 ± 34%  perf-profile.children.cycles-pp.unmap_page_range
      0.12 ± 30%      -0.0        0.09 ± 36%      +0.4        0.53 ± 34%  perf-profile.children.cycles-pp.unmap_vmas
      0.07 ± 38%      -0.0        0.04 ± 88%      +0.2        0.26 ± 28%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.03 ±100%      -0.0        0.00            +0.2        0.20 ± 24%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.08 ± 28%      -0.0        0.05 ± 36%      +0.2        0.29 ± 23%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.09 ± 35%      -0.0        0.06 ± 58%      +0.3        0.35 ± 29%  perf-profile.children.cycles-pp.pipe_read
      0.35 ± 22%      -0.0        0.32 ± 19%      +1.2        1.51 ± 10%  perf-profile.children.cycles-pp.do_sys_openat2
      0.07 ± 45%      -0.0        0.04 ± 68%      +0.2        0.22 ± 21%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.03 ±125%      -0.0        0.00            +0.1        0.13 ± 33%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.08 ± 19%      -0.0        0.05 ± 71%      +0.3        0.36 ± 24%  perf-profile.children.cycles-pp.exec_mmap
      0.45 ± 17%      -0.0        0.42 ± 18%      +1.5        1.98 ± 10%  perf-profile.children.cycles-pp.handle_mm_fault
      0.21 ± 16%      -0.0        0.18 ± 15%      +0.6        0.83 ± 12%  perf-profile.children.cycles-pp.link_path_walk
      0.08 ± 36%      -0.0        0.06 ± 54%      +0.4        0.45 ± 23%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.03 ±101%      -0.0        0.01 ±299%      +0.2        0.20 ± 25%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.08 ± 22%      -0.0        0.06 ± 58%      +0.2        0.29 ± 28%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.34 ± 22%      -0.0        0.31 ± 18%      +1.1        1.48 ± 11%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.04 ±106%      -0.0        0.02 ±154%      +0.1        0.16 ± 36%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.08 ± 49%      -0.0        0.05 ± 69%      +0.6        0.66 ± 21%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.03 ±102%      -0.0        0.01 ±300%      +0.1        0.17 ± 35%  perf-profile.children.cycles-pp.unmap_region
      0.03 ±102%      -0.0        0.01 ±300%      +0.2        0.19 ± 37%  perf-profile.children.cycles-pp.vsnprintf
      0.05 ± 58%      -0.0        0.03 ± 82%      +0.2        0.27 ± 37%  perf-profile.children.cycles-pp.wake_up_new_task
      0.05 ± 70%      -0.0        0.03 ±100%      +0.2        0.22 ± 14%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.05 ± 70%      -0.0        0.03 ±100%      +0.2        0.22 ± 15%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.14 ± 20%      -0.0        0.11 ± 16%      +0.5        0.66 ± 15%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.16 ± 19%      -0.0        0.14 ± 18%      +0.6        0.74 ± 13%  perf-profile.children.cycles-pp.__vfork
      2.54 ± 16%      -0.0        2.52 ± 23%      -1.8        0.70 ± 14%  perf-profile.children.cycles-pp.tcp_recvmsg_locked
      3.70 ± 22%      -0.0        3.68 ± 24%      -3.3        0.39 ± 17%  perf-profile.children.cycles-pp._copy_from_iter
      0.11 ± 22%      -0.0        0.09 ± 37%      +0.3        0.43 ± 25%  perf-profile.children.cycles-pp.perf_read
      0.28 ± 27%      -0.0        0.25 ± 22%      +0.9        1.18 ± 10%  perf-profile.children.cycles-pp.mmap_region
      0.09 ± 50%      -0.0        0.07 ± 39%      +0.3        0.37 ± 28%  perf-profile.children.cycles-pp.__split_vma
      0.14 ± 29%      -0.0        0.12 ± 27%      +0.5        0.68 ± 18%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.42 ± 18%      -0.0        0.40 ± 19%      +1.5        1.88 ± 12%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.09 ± 62%      -0.0        0.07 ± 43%      +0.2        0.34 ± 30%  perf-profile.children.cycles-pp.__do_sys_clone
      0.05 ± 54%      -0.0        0.03 ±101%      +0.3        0.31 ± 37%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.10 ± 25%      -0.0        0.08 ± 23%      +0.3        0.39 ± 28%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.03 ±107%      -0.0        0.01 ±209%      +0.2        0.24 ± 19%  perf-profile.children.cycles-pp.__wait_for_common
      0.07 ± 43%      -0.0        0.05 ± 75%      +0.3        0.36 ± 24%  perf-profile.children.cycles-pp.affine_move_task
      0.17 ± 27%      -0.0        0.15 ± 24%      +0.6        0.77 ± 21%  perf-profile.children.cycles-pp.__sched_setaffinity
      2.36 ± 19%      -0.0        2.34 ± 26%      -2.0        0.35 ± 25%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.03 ±102%      -0.0        0.01 ±201%      +0.2        0.18 ± 24%  perf-profile.children.cycles-pp.perf_event_read
      0.04 ± 84%      -0.0        0.02 ±154%      +0.1        0.16 ± 33%  perf-profile.children.cycles-pp.dev_attr_show
      0.02 ±156%      -0.0        0.00            +0.1        0.14 ± 41%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.04 ± 84%      -0.0        0.02 ±154%      +0.1        0.16 ± 31%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.03 ±103%      -0.0        0.01 ±203%      +0.1        0.18 ± 25%  perf-profile.children.cycles-pp.smp_call_function_single
      0.04 ± 68%      -0.0        0.02 ±129%      +0.2        0.27 ± 29%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.41 ± 25%      -0.0        0.40 ± 22%      +1.5        1.92 ± 17%  perf-profile.children.cycles-pp.sched_setaffinity
      3.72 ± 22%      -0.0        3.71 ± 23%      -3.3        0.40 ± 17%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      2.36 ± 19%      -0.0        2.34 ± 26%      -2.0        0.36 ± 24%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.05 ± 52%      -0.0        0.04 ± 83%      +0.2        0.25 ± 19%  perf-profile.children.cycles-pp.dup_task_struct
      0.02 ±123%      -0.0        0.01 ±300%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.mprotect_fixup
      0.04 ± 71%      -0.0        0.03 ±127%      +0.2        0.22 ± 27%  perf-profile.children.cycles-pp.free_pgtables
      0.14 ± 20%      -0.0        0.13 ± 24%      +0.5        0.62 ± 29%  perf-profile.children.cycles-pp.evsel__read_counter
      0.63 ± 15%      -0.0        0.62 ± 16%      -0.4        0.18 ± 31%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.03 ±100%      -0.0        0.01 ±200%      +0.2        0.27 ± 31%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
      0.16 ± 30%      -0.0        0.14 ± 20%      +0.5        0.66 ± 15%  perf-profile.children.cycles-pp.copy_process
      0.03 ±128%      -0.0        0.01 ±200%      +0.2        0.19 ± 45%  perf-profile.children.cycles-pp.mod_objcg_state
      0.10 ± 22%      -0.0        0.08 ± 26%      +0.3        0.44 ± 33%  perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.03 ±109%      -0.0        0.02 ±152%      +0.1        0.16 ± 33%  perf-profile.children.cycles-pp.dup_mm
      0.10 ± 50%      -0.0        0.09 ± 28%      +0.3        0.41 ± 21%  perf-profile.children.cycles-pp._Fork
      0.13 ± 34%      -0.0        0.12 ± 22%      +0.4        0.54 ± 19%  perf-profile.children.cycles-pp.__open64_nocancel
      0.06 ± 77%      -0.0        0.04 ±110%      +0.1        0.16 ± 42%  perf-profile.children.cycles-pp._find_next_bit
      0.05 ± 69%      -0.0        0.04 ±104%      +0.2        0.30 ± 27%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.04 ± 86%      -0.0        0.02 ±123%      +0.2        0.19 ± 21%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.04 ± 86%      -0.0        0.02 ±123%      +0.2        0.19 ± 21%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.08 ± 23%      -0.0        0.07 ± 43%      +0.3        0.42 ± 34%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.11 ± 25%      -0.0        0.09 ± 30%      +0.3        0.43 ± 25%  perf-profile.children.cycles-pp.perf_evsel__read
      0.18 ± 25%      -0.0        0.17 ± 22%      +0.7        0.86 ± 19%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.06 ± 60%      -0.0        0.04 ± 82%      +0.2        0.23 ± 36%  perf-profile.children.cycles-pp.pipe_write
      0.02 ±154%      -0.0        0.01 ±299%      +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.08 ± 42%      -0.0        0.06 ± 57%      +0.2        0.27 ± 24%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.06 ± 57%      -0.0        0.04 ± 83%      +0.5        0.53 ± 16%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.32 ± 23%      -0.0        0.31 ± 19%      +1.1        1.38 ± 11%  perf-profile.children.cycles-pp.path_openat
      0.33 ± 23%      -0.0        0.31 ± 20%      +1.1        1.41 ± 12%  perf-profile.children.cycles-pp.do_filp_open
      0.03 ±106%      -0.0        0.02 ±154%      +0.2        0.26 ± 31%  perf-profile.children.cycles-pp.irqentry_enter
      0.02 ±154%      -0.0        0.01 ±300%      +0.1        0.15 ± 23%  perf-profile.children.cycles-pp.__perf_event_read
      0.02 ±153%      -0.0        0.01 ±300%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.02 ±220%      -0.0        0.01 ±299%      +0.1        0.16 ± 40%  perf-profile.children.cycles-pp.vma_complete
      0.02 ±210%      -0.0        0.01 ±299%      +0.2        0.19 ± 33%  perf-profile.children.cycles-pp.do_open
      0.08 ± 23%      -0.0        0.06 ± 36%      +0.3        0.34 ± 19%  perf-profile.children.cycles-pp.d_alloc
      0.04 ±103%      -0.0        0.03 ±132%      +0.3        0.33 ± 26%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.01 ±201%      -0.0        0.00            +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.__fdget_pos
      0.03 ± 82%      -0.0        0.02 ±153%      +0.2        0.22 ± 39%  perf-profile.children.cycles-pp.sched_exec
      0.06 ± 56%      -0.0        0.05 ± 68%      +0.2        0.25 ± 24%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.08 ± 49%      -0.0        0.07 ± 48%      +0.2        0.28 ± 30%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.24 ± 82%      -0.0        0.23 ±122%      +0.6        0.82 ± 21%  perf-profile.children.cycles-pp.rcu_core
      0.02 ±152%      -0.0        0.01 ±299%      +0.1        0.11 ± 42%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.02 ±123%      -0.0        0.01 ±201%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.error_entry
      0.01 ±200%      -0.0        0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.01 ±200%      -0.0        0.00            +0.1        0.16 ± 27%  perf-profile.children.cycles-pp._IO_fwrite
      0.02 ±216%      -0.0        0.01 ±300%      +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.leave_mm
      0.02 ±153%      -0.0        0.01 ±300%      +0.2        0.20 ± 41%  perf-profile.children.cycles-pp.call_timer_fn
      0.04 ± 70%      -0.0        0.03 ± 82%      +0.1        0.15 ± 26%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.06 ± 55%      -0.0        0.05 ± 55%      +0.2        0.27 ± 32%  perf-profile.children.cycles-pp.wp_page_copy
      0.09 ± 26%      -0.0        0.08 ± 27%      +0.3        0.43 ± 32%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.07 ±205%      -0.0        0.06 ±299%      +0.5        0.59 ± 21%  perf-profile.children.cycles-pp.tcp_sock_set_cork
      0.03 ±125%      -0.0        0.02 ±153%      +0.2        0.21 ± 34%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.02 ±152%      -0.0        0.01 ±300%      +0.1        0.11 ± 51%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.03 ±102%      -0.0        0.02 ±124%      +0.2        0.24 ± 26%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.01 ±300%      -0.0        0.00            +0.1        0.15 ± 47%  perf-profile.children.cycles-pp.vfs_open
      0.06 ± 54%      -0.0        0.05 ± 69%      +0.2        0.23 ± 25%  perf-profile.children.cycles-pp.move_queued_task
      0.10 ± 58%      -0.0        0.09 ± 61%      +0.2        0.34 ± 30%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.02 ±156%      -0.0        0.01 ±201%      +0.3        0.29 ± 29%  perf-profile.children.cycles-pp.force_qs_rnp
      0.03 ±104%      -0.0        0.03 ±100%      +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.get_jiffies_update
      0.08 ± 36%      -0.0        0.07 ± 42%      +0.2        0.30 ± 40%  perf-profile.children.cycles-pp.copy_strings
      0.09 ± 31%      -0.0        0.08 ± 41%      +0.3        0.43 ± 30%  perf-profile.children.cycles-pp.do_anonymous_page
      0.21 ± 20%      -0.0        0.20 ± 26%      +0.8        0.98 ± 15%  perf-profile.children.cycles-pp.do_fault
      0.05 ± 57%      -0.0        0.04 ± 68%      +0.2        0.23 ± 21%  perf-profile.children.cycles-pp.__cmd_record
      0.05 ± 57%      -0.0        0.04 ± 68%      +0.2        0.23 ± 21%  perf-profile.children.cycles-pp.cmd_record
      0.13 ± 15%      -0.0        0.12 ± 26%      +0.2        0.34 ± 23%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.11 ± 19%      -0.0        0.10 ± 20%      +0.4        0.46 ± 18%  perf-profile.children.cycles-pp.__lookup_slow
      0.01 ±200%      -0.0        0.01 ±300%      +0.1        0.15 ± 47%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.01 ±300%      -0.0        0.00            +0.1        0.15 ± 47%  perf-profile.children.cycles-pp.do_dentry_open
      0.12 ± 31%      -0.0        0.11 ± 31%      +0.4        0.52 ± 25%  perf-profile.children.cycles-pp.elf_load
      0.12 ± 24%      -0.0        0.12 ± 26%      +0.2        0.33 ± 21%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.22 ± 28%      -0.0        0.22 ± 28%      +0.7        0.92 ± 16%  perf-profile.children.cycles-pp.setlocale
      0.01 ±300%      -0.0        0.00            +0.3        0.26 ± 22%  perf-profile.children.cycles-pp.schedule_timeout
      0.01 ±201%      -0.0        0.01 ±299%      +0.1        0.15 ± 46%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.03 ±103%      -0.0        0.02 ±123%      +0.2        0.25 ± 33%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.09 ± 61%      -0.0        0.08 ± 60%      +0.2        0.32 ± 30%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.05 ± 67%      -0.0        0.05 ± 51%      +0.2        0.23 ± 30%  perf-profile.children.cycles-pp.show_stat
      0.02 ±152%      -0.0        0.01 ±200%      +0.2        0.18 ± 32%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.01 ±299%      -0.0        0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.sclhi
      0.09 ± 35%      -0.0        0.08 ± 36%      +0.3        0.35 ± 31%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.02 ±213%      -0.0        0.01 ±201%      +0.1        0.15 ± 29%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.06 ± 36%      -0.0        0.05 ± 37%      +0.2        0.23 ± 24%  perf-profile.children.cycles-pp.vmstat_start
      0.09 ± 31%      -0.0        0.08 ± 29%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.__mmap
      0.08 ± 24%      -0.0        0.07 ± 47%      +0.3        0.36 ± 21%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.16 ± 16%      -0.0        0.15 ± 17%      +0.5        0.61 ± 15%  perf-profile.children.cycles-pp.walk_component
      0.28 ± 26%      -0.0        0.28 ± 24%      +1.0        1.26 ± 17%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.01 ±206%      -0.0        0.01 ±200%      +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.02 ±156%      -0.0        0.02 ±153%      +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.dup_mmap
      0.04 ± 84%      -0.0        0.04 ± 84%      +0.2        0.22 ± 16%  perf-profile.children.cycles-pp.try_address
      0.25 ± 13%      -0.0        0.25 ± 32%      +0.8        1.07 ± 19%  perf-profile.children.cycles-pp.balance_fair
      0.02 ±123%      -0.0        0.02 ±124%      +0.2        0.18 ± 18%  perf-profile.children.cycles-pp.i2c_outb
      0.04 ± 84%      -0.0        0.03 ±102%      +0.1        0.17 ± 20%  perf-profile.children.cycles-pp.step_into
      0.08 ± 25%      -0.0        0.08 ± 18%      +0.3        0.39 ± 16%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.03 ±124%      -0.0        0.03 ±100%      +0.1        0.17 ± 37%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.01 ±200%      -0.0        0.01 ±300%      +0.2        0.21 ± 30%  perf-profile.children.cycles-pp.timekeeping_update
      0.01 ±300%      -0.0        0.01 ±299%      +0.2        0.20 ± 24%  perf-profile.children.cycles-pp.dyntick_save_progress_counter
      0.09 ± 26%      -0.0        0.08 ± 30%      +0.2        0.24 ± 34%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.0        0.00            +0.1        0.09 ± 27%  perf-profile.children.cycles-pp.seq_printf
      0.00            +0.0        0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.task_tick_mm_cid
      0.00            +0.0        0.00            +0.1        0.10 ± 40%  perf-profile.children.cycles-pp.notifier_call_chain
      0.00            +0.0        0.00            +0.1        0.11 ± 52%  perf-profile.children.cycles-pp.part_in_flight
      0.00            +0.0        0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.blk_mq_run_hw_queues
      0.00            +0.0        0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.blk_mq_requeue_work
      0.01 ±299%      +0.0        0.01 ±300%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.record__pushfn
      0.01 ±299%      +0.0        0.01 ±300%      +0.1        0.12 ± 56%  perf-profile.children.cycles-pp.vma_prepare
      0.01 ±299%      +0.0        0.01 ±300%      +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.writen
      0.01 ±299%      +0.0        0.01 ±300%      +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.01 ±206%      +0.0        0.01 ±200%      +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.mas_walk
      0.00            +0.0        0.00            +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.open64
      0.00            +0.0        0.00            +0.2        0.16 ± 38%  perf-profile.children.cycles-pp.nfs_wb_folio
      0.00            +0.0        0.00            +0.2        0.16 ± 56%  perf-profile.children.cycles-pp.irq_work_tick
      0.01 ±200%      +0.0        0.01 ±203%      +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.setup_arg_pages
      0.00            +0.0        0.00            +0.2        0.18 ± 35%  perf-profile.children.cycles-pp.journal_submit_commit_record
      0.00            +0.0        0.00            +0.2        0.18 ± 38%  perf-profile.children.cycles-pp.blk_finish_plug
      0.00            +0.0        0.00            +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.jbd2_journal_get_descriptor_buffer
      0.00            +0.0        0.00            +0.2        0.21 ± 34%  perf-profile.children.cycles-pp.check_cpu_stall
      0.03 ±102%      +0.0        0.03 ±100%      +0.3        0.36 ± 23%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.0        0.00            +0.6        0.59 ± 22%  perf-profile.children.cycles-pp.jbd2_journal_commit_transaction
      0.00            +0.0        0.00            +0.6        0.61 ± 20%  perf-profile.children.cycles-pp.kjournald2
      0.01 ±300%      +0.0        0.01 ±300%      +0.1        0.14 ± 41%  perf-profile.children.cycles-pp.clear_page_erms
      0.01 ±300%      +0.0        0.01 ±300%      +0.1        0.15 ± 30%  perf-profile.children.cycles-pp.shift_arg_pages
      0.03 ±132%      +0.0        0.03 ±127%      +0.2        0.18 ± 37%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.01 ±201%      +0.0        0.01 ±200%      +0.2        0.17 ± 28%  perf-profile.children.cycles-pp.mas_find
      0.02 ±300%      +0.0        0.02 ±300%      +0.2        0.19 ± 37%  perf-profile.children.cycles-pp.nfs4_proc_pgio_rpc_prepare
      0.16 ± 15%      +0.0        0.16 ± 29%      +0.6        0.76 ± 16%  perf-profile.children.cycles-pp.filemap_map_pages
      0.01 ±299%      +0.0        0.01 ±300%      +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.__dentry_kill
      0.08 ± 37%      +0.0        0.08 ± 17%      +0.3        0.34 ± 21%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.18 ± 34%      +0.0        0.19 ± 18%      +0.4        0.57 ± 34%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.52 ± 16%      +0.0        0.53 ± 33%      -0.3        0.23 ± 51%  perf-profile.children.cycles-pp.filemap_get_folios_tag
      0.01 ±200%      +0.0        0.01 ±200%      +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.__i2c_transfer
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.bit_xfer
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.i2c_transfer
      0.04 ± 85%      +0.0        0.04 ± 71%      +0.2        0.23 ± 15%  perf-profile.children.cycles-pp.output_poll_execute
      0.04 ± 84%      +0.0        0.04 ± 82%      +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.get_arg_page
      0.14 ± 45%      +0.0        0.14 ± 46%      +0.1        0.28 ± 31%  perf-profile.children.cycles-pp.__check_object_size
      0.01 ±299%      +0.0        0.01 ±201%      +0.2        0.16 ± 48%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.01 ±300%      +0.0        0.01 ±200%      +0.2        0.16 ± 35%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.02 ±123%      +0.0        0.02 ±125%      +0.2        0.19 ± 36%  perf-profile.children.cycles-pp.__get_user_pages
      0.38 ± 29%      +0.0        0.38 ± 39%      -0.2        0.13 ± 39%  perf-profile.children.cycles-pp.__release_sock
      0.02 ±123%      +0.0        0.03 ±124%      +0.2        0.22 ± 39%  perf-profile.children.cycles-pp.getname_flags
      0.01 ±300%      +0.0        0.01 ±201%      +0.1        0.15 ± 32%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.0        0.01 ±299%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.simple_lookup
      0.01 ±299%      +0.0        0.01 ±200%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.perf_mmap__push
      0.01 ±299%      +0.0        0.01 ±200%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.11 ± 39%      +0.0        0.11 ± 31%      +0.2        0.29 ± 39%  perf-profile.children.cycles-pp.get_cpu_device
      0.07 ± 26%      +0.0        0.08 ± 27%      +0.4        0.51 ± 20%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.17 ± 15%      +0.0        0.18 ± 29%      +0.7        0.83 ± 16%  perf-profile.children.cycles-pp.do_read_fault
      0.02 ±123%      +0.0        0.03 ±103%      +0.2        0.20 ± 37%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.02 ±154%      +0.0        0.03 ±127%      +0.1        0.15 ± 55%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.02 ±155%      +0.0        0.03 ±100%      +0.2        0.18 ± 34%  perf-profile.children.cycles-pp.__d_alloc
      0.02 ±154%      +0.0        0.03 ±129%      +0.1        0.16 ± 54%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.01 ±299%      +0.0        0.02 ±204%      +0.1        0.14 ± 47%  perf-profile.children.cycles-pp.check_tsc_unstable
      0.01 ±300%      +0.0        0.02 ±153%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.x64_sys_call
      0.02 ±153%      +0.0        0.03 ±125%      +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.wait4
      0.00            +0.0        0.01 ±201%      +0.1        0.11 ± 36%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.00            +0.0        0.01 ±201%      +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.03 ±102%      +0.0        0.04 ± 87%      +0.2        0.27 ± 32%  perf-profile.children.cycles-pp.alloc_empty_file
      0.04 ± 85%      +0.0        0.06 ± 65%      +0.4        0.40 ± 31%  perf-profile.children.cycles-pp.timekeeping_advance
      0.01 ±300%      +0.0        0.02 ±154%      +0.2        0.16 ± 38%  perf-profile.children.cycles-pp.copy_string_kernel
      0.04 ± 85%      +0.0        0.06 ± 65%      +0.4        0.40 ± 31%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.0        0.02 ±204%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.ext4_io_submit
      0.03 ±101%      +0.0        0.04 ± 69%      +0.1        0.16 ± 38%  perf-profile.children.cycles-pp.lookup_fast
      0.02 ±165%      +0.0        0.04 ± 71%      +0.2        0.21 ± 20%  perf-profile.children.cycles-pp.__mmdrop
      0.02 ±154%      +0.0        0.03 ±106%      +0.2        0.26 ± 27%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.02 ±126%      +0.0        0.04 ± 88%      +0.2        0.27 ± 28%  perf-profile.children.cycles-pp.perf_event_mmap
      0.01 ±206%      +0.0        0.03 ±124%      +0.2        0.22 ± 18%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.00            +0.0        0.02 ±155%      +0.2        0.18 ± 38%  perf-profile.children.cycles-pp.set_pte_range
      0.06 ± 44%      +0.0        0.08 ± 26%      +0.3        0.38 ± 36%  perf-profile.children.cycles-pp.alloc_bprm
      0.08 ± 71%      +0.0        0.10 ± 23%      +0.1        0.22 ± 27%  perf-profile.children.cycles-pp.menu_reflect
      0.54 ± 19%      +0.0        0.56 ± 22%      -0.4        0.16 ± 20%  perf-profile.children.cycles-pp.ext4_da_write_begin
      0.04 ±211%      +0.0        0.06 ±182%      +0.4        0.45 ± 17%  perf-profile.children.cycles-pp.rpc_execute
      0.10 ± 83%      +0.0        0.13 ± 59%      +0.3        0.43 ± 47%  perf-profile.children.cycles-pp.delay_tsc
      0.21 ± 29%      +0.0        0.24 ± 42%      +0.4        0.62 ± 43%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.22 ± 31%      +0.0        0.25 ± 39%      +0.5        0.68 ± 38%  perf-profile.children.cycles-pp.tmigr_handle_remote
      0.14 ± 41%      +0.0        0.17 ± 20%      +0.4        0.51 ± 24%  perf-profile.children.cycles-pp.ct_idle_exit
      0.41 ± 44%      +0.0        0.45 ± 31%      +0.6        0.98 ± 19%  perf-profile.children.cycles-pp.ktime_get
      0.05 ±226%      +0.0        0.09 ±116%      +0.4        0.48 ± 12%  perf-profile.children.cycles-pp.nfs_initiate_pgio
      0.10 ± 40%      +0.0        0.14 ± 19%      +0.3        0.40 ± 26%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.04 ±220%      +0.0        0.09 ±153%      +0.5        0.51 ± 16%  perf-profile.children.cycles-pp.rpc_run_task
      0.02 ±154%      +0.1        0.07 ± 54%      +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.02 ±156%      +0.1        0.08 ± 51%      +0.2        0.18 ± 33%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.04 ± 85%      +0.1        0.10 ± 21%      +0.2        0.19 ± 26%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.09 ± 35%      +0.1        0.15 ± 45%      +0.1        0.22 ± 28%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.13 ± 29%      +0.1        0.19 ± 19%      +0.2        0.35 ± 25%  perf-profile.children.cycles-pp.update_curr
      0.14 ± 40%      +0.1        0.20 ± 27%      +0.2        0.29 ± 24%  perf-profile.children.cycles-pp.set_next_entity
      0.32 ± 16%      +0.1        0.39 ± 13%      +0.8        1.11 ±  7%  perf-profile.children.cycles-pp.sched_balance_domains
      0.14 ± 38%      +0.1        0.22 ± 22%      +0.3        0.46 ± 21%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.41 ± 19%      +0.1        0.49 ± 28%      +1.3        1.66 ± 15%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.75 ± 36%      +0.1        1.84 ± 55%      +2.1        3.89 ± 14%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.06 ± 70%      +0.1        0.16 ± 22%      -0.0        0.04 ± 92%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.33 ± 27%      +0.1        0.44 ± 21%      +0.6        0.90 ± 22%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.08 ± 50%      +0.1        0.19 ± 19%      +0.0        0.13 ± 38%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.19 ± 31%      +0.1        0.32 ± 21%      +0.3        0.51 ± 18%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.15 ± 51%      +0.1        0.29 ± 28%      +0.2        0.40 ± 16%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.86 ± 18%      +0.2        2.02 ± 34%      -1.6        0.24 ± 36%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.20 ± 30%      +0.2        0.36 ± 28%      +0.5        0.66 ± 21%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.14 ± 55%      +0.2        0.32 ± 27%      +0.3        0.39 ± 31%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.12 ± 44%      +0.2        0.30 ± 29%      +0.2        0.27 ± 32%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.29 ± 38%      +0.2        0.48 ± 35%      +0.4        0.74 ± 18%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.11 ± 67%      +0.2        0.31 ± 46%      +0.0        0.16 ± 26%  perf-profile.children.cycles-pp.available_idle_cpu
      0.32 ± 38%      +0.2        0.52 ± 19%      +0.4        0.76 ± 21%  perf-profile.children.cycles-pp.dequeue_entity
      0.44 ± 35%      +0.2        0.64 ± 37%      -0.3        0.17 ± 30%  perf-profile.children.cycles-pp.filemap_get_entry
      2.26 ± 19%      +0.2        2.48 ± 34%      -2.0        0.27 ± 37%  perf-profile.children.cycles-pp.__block_commit_write
      0.56 ± 30%      +0.2        0.78 ± 35%      -0.3        0.29 ± 26%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.38 ± 35%      +0.2        0.62 ± 19%      +0.5        0.88 ± 22%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.47 ± 20%      +0.3        2.76 ± 35%      -2.2        0.29 ± 36%  perf-profile.children.cycles-pp.block_write_end
      0.32 ± 42%      +0.3        0.67 ± 30%      +0.1        0.41 ± 15%  perf-profile.children.cycles-pp.select_task_rq
      2.58 ± 20%      +0.4        2.93 ± 35%      -2.3        0.31 ± 34%  perf-profile.children.cycles-pp.ext4_da_write_end
      1.05 ± 18%      +0.4        1.43 ± 65%      -0.8        0.22 ± 29%  perf-profile.children.cycles-pp.folio_wake_bit
      0.24 ± 27%      +0.4        0.62 ± 28%      +0.2        0.46 ± 13%  perf-profile.children.cycles-pp.sched_clock
      0.19 ± 35%      +0.4        0.59 ± 32%      +0.2        0.42 ± 28%  perf-profile.children.cycles-pp.update_rq_clock
      0.18 ± 61%      +0.4        0.58 ± 29%      +0.1        0.25 ± 17%  perf-profile.children.cycles-pp.llist_reverse_order
      0.29 ± 26%      +0.4        0.71 ± 23%      +0.4        0.65 ± 11%  perf-profile.children.cycles-pp.native_sched_clock
      0.21 ± 63%      +0.5        0.68 ± 49%      +0.1        0.30 ± 32%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.53 ± 20%      +0.5        1.00 ± 71%      -0.4        0.13 ± 36%  perf-profile.children.cycles-pp.wake_page_function
      0.42 ± 34%      +0.5        0.91 ± 51%      +0.3        0.69 ± 16%  perf-profile.children.cycles-pp.enqueue_entity
      0.30 ± 64%      +0.5        0.83 ± 46%      +0.1        0.41 ± 29%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.59 ± 28%      +0.5        1.13 ± 48%      +0.7        1.30 ± 16%  perf-profile.children.cycles-pp.rest_init
      0.59 ± 28%      +0.5        1.13 ± 48%      +0.7        1.30 ± 16%  perf-profile.children.cycles-pp.start_kernel
      0.59 ± 28%      +0.5        1.13 ± 48%      +0.7        1.30 ± 16%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.59 ± 28%      +0.5        1.13 ± 48%      +0.7        1.30 ± 16%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.49 ± 35%      +0.6        1.04 ± 54%      +0.4        0.85 ± 13%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.52 ± 33%      +0.6        1.09 ± 52%      +0.4        0.92 ± 12%  perf-profile.children.cycles-pp.activate_task
      0.36 ± 46%      +0.6        0.99 ± 43%      +0.1        0.42 ± 20%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.12 ± 23%      +0.8        0.93 ± 49%      +3.0        3.09 ± 58%  perf-profile.children.cycles-pp.write
      0.11 ± 23%      +0.8        0.91 ± 50%      +2.9        3.03 ± 59%  perf-profile.children.cycles-pp.ksys_write
      1.49 ± 29%      +0.9        2.35 ± 56%      -0.6        0.94 ± 18%  perf-profile.children.cycles-pp.blk_complete_reqs
      0.59 ± 36%      +0.9        1.51 ± 43%      +0.4        0.96 ± 16%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.36 ± 25%      +0.9        2.30 ± 57%      -0.6        0.77 ± 17%  perf-profile.children.cycles-pp.scsi_io_completion
      1.36 ± 25%      +0.9        2.30 ± 57%      -0.6        0.76 ± 17%  perf-profile.children.cycles-pp.scsi_end_request
      1.16 ± 16%      +1.0        2.16 ± 63%      -0.7        0.45 ± 23%  perf-profile.children.cycles-pp.blk_update_request
      1.05 ± 15%      +1.0        2.08 ± 67%      -0.8        0.27 ± 23%  perf-profile.children.cycles-pp.ext4_end_bio
      0.50 ± 85%      +1.0        1.53 ± 81%      +1.3        1.82 ± 22%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.03 ± 15%      +1.0        2.08 ± 68%      -0.8        0.24 ± 24%  perf-profile.children.cycles-pp.ext4_finish_bio
      5.57 ± 13%      +1.3        6.89 ± 39%      -3.6        1.98 ± 13%  perf-profile.children.cycles-pp.file_write_and_wait_range
      5.57 ± 13%      +1.3        6.90 ± 39%      -3.5        2.04 ± 13%  perf-profile.children.cycles-pp.ext4_sync_file
      5.57 ± 13%      +1.3        6.90 ± 39%      -3.5        2.04 ± 13%  perf-profile.children.cycles-pp.nfsd_commit
      5.58 ± 13%      +1.3        6.90 ± 39%      -3.4        2.14 ± 12%  perf-profile.children.cycles-pp.nfsd4_commit
      0.73 ± 37%      +1.6        2.28 ± 39%      +0.4        1.14 ± 19%  perf-profile.children.cycles-pp.sched_ttwu_pending
     12.70 ± 49%      +1.6       14.28 ± 60%     -11.7        0.98 ± 22%  perf-profile.children.cycles-pp.nfsd4_write
     12.64 ± 49%      +1.6       14.25 ± 61%     -11.8        0.88 ± 25%  perf-profile.children.cycles-pp.nfsd_vfs_write
     12.61 ± 49%      +1.6       14.22 ± 61%     -11.8        0.85 ± 27%  perf-profile.children.cycles-pp.vfs_iter_write
     12.60 ± 49%      +1.6       14.21 ± 61%     -11.8        0.82 ± 26%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
     12.60 ± 49%      +1.6       14.22 ± 61%     -11.8        0.82 ± 27%  perf-profile.children.cycles-pp.do_iter_readv_writev
      1.48 ± 23%      +1.7        3.13 ± 65%      -0.9        0.58 ± 21%  perf-profile.children.cycles-pp.folio_wait_bit_common
      1.78 ± 27%      +1.8        3.54 ± 40%      -1.5        0.26 ± 21%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.98 ± 40%      +2.0        3.02 ± 37%      +0.5        1.45 ± 15%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.58 ± 35%      +2.6        6.16 ± 35%      -3.3        0.26 ± 26%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      6.38 ± 20%      +2.7        9.07 ± 26%      -5.1        1.30 ± 12%  perf-profile.children.cycles-pp.generic_perform_write
     22.26 ± 25%      +2.9       25.13 ± 38%     -15.5        6.73 ± 10%  perf-profile.children.cycles-pp.nfsd
     22.24 ± 25%      +2.9       25.12 ± 38%     -15.5        6.72 ± 10%  perf-profile.children.cycles-pp.svc_recv
     22.07 ± 25%      +2.9       24.98 ± 38%     -15.6        6.43 ± 11%  perf-profile.children.cycles-pp.svc_handle_xprt
     18.49 ± 32%      +2.9       21.44 ± 45%     -14.8        3.73 ± 14%  perf-profile.children.cycles-pp.nfsd4_proc_compound
     18.59 ± 32%      +2.9       21.53 ± 44%     -14.7        3.88 ± 14%  perf-profile.children.cycles-pp.nfsd_dispatch
     18.68 ± 32%      +3.0       21.63 ± 44%     -14.6        4.06 ± 13%  perf-profile.children.cycles-pp.svc_process
     18.67 ± 32%      +3.0       21.63 ± 44%     -14.6        4.06 ± 13%  perf-profile.children.cycles-pp.svc_process_common
      1.83 ± 67%      +3.0        4.84 ± 47%      +0.4        2.24 ± 19%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.91 ± 31%      +7.5        8.37 ± 61%      +2.3        3.21 ± 15%  perf-profile.children.cycles-pp.poll_idle
     10.41 ± 53%      +8.4       18.84 ± 41%      -9.7        0.73 ± 25%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     10.44 ± 52%      +8.5       18.90 ± 41%      -9.6        0.88 ± 25%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     10.47 ± 52%      +8.5       18.96 ± 41%      -9.5        0.98 ± 22%  perf-profile.children.cycles-pp.down_write
     15.61 ± 40%      +9.0       24.65 ± 17%     +28.1       43.73 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
     13.36 ± 39%      +9.4       22.80 ± 18%     +24.9       38.30 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     13.41 ± 39%      +9.5       22.88 ± 18%     +25.1       38.51 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     19.16 ± 44%     +12.4       31.53 ± 14%     +29.8       48.92 ±  7%  perf-profile.children.cycles-pp.start_secondary
     19.72 ± 43%     +12.9       32.63 ± 14%     +30.5       50.20 ±  6%  perf-profile.children.cycles-pp.do_idle
     19.74 ± 43%     +12.9       32.66 ± 14%     +30.5       50.23 ±  6%  perf-profile.children.cycles-pp.common_startup_64
     19.74 ± 43%     +12.9       32.66 ± 14%     +30.5       50.23 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
      9.76 ± 46%     +15.3       25.03 ± 46%      +8.8       18.57 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
      9.78 ± 45%     +15.3       25.10 ± 46%      +8.8       18.62 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     18.46 ± 33%     -15.3        3.14 ±106%     -15.2        3.22 ± 20%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     11.13 ± 47%      -4.5        6.61 ± 80%     -11.0        0.10 ± 49%  perf-profile.self.cycles-pp.osq_lock
      6.00 ± 56%      -1.9        4.12 ± 77%     +12.2       18.16 ±  6%  perf-profile.self.cycles-pp.intel_idle
      1.42 ± 30%      -1.3        0.15 ±222%      -1.3        0.11 ± 57%  perf-profile.self.cycles-pp.mutex_lock
      1.05 ± 25%      -0.8        0.24 ± 87%      -1.0        0.02 ±125%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.72 ± 19%      -0.6        0.13 ±215%      -0.5        0.22 ± 50%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.51 ±  6%      -0.2        0.29 ± 37%      -0.3        0.18 ± 24%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.34 ± 15%      -0.2        0.14 ± 73%      -0.3        0.04 ±112%  perf-profile.self.cycles-pp.mpage_prepare_extent_to_map
      0.70 ± 30%      -0.2        0.52 ± 35%      -0.4        0.25 ± 35%  perf-profile.self.cycles-pp.xas_load
      0.23 ± 14%      -0.1        0.12 ± 37%      -0.1        0.13 ± 32%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.29 ± 12%      -0.1        0.20 ± 34%      -0.3        0.03 ±102%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
      0.19 ± 17%      -0.1        0.10 ± 21%      -0.1        0.06 ± 64%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.21 ± 24%      -0.1        0.14 ± 32%      -0.2        0.05 ± 87%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.12 ± 26%      -0.1        0.05 ± 76%      -0.1        0.04 ±111%  perf-profile.self.cycles-pp.xas_clear_mark
      0.14 ± 53%      -0.1        0.09 ± 78%      +0.2        0.37 ± 27%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.15 ± 35%      -0.0        0.10 ± 83%      +0.4        0.53 ± 15%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.07 ± 49%      -0.0        0.02 ±124%      +0.2        0.25 ± 30%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.18 ± 21%      -0.0        0.14 ± 23%      -0.1        0.03 ±112%  perf-profile.self.cycles-pp.folio_unlock
      0.05 ± 95%      -0.0        0.01 ±200%      +0.1        0.18 ± 45%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.06 ± 61%      -0.0        0.02 ±124%      +0.1        0.17 ± 35%  perf-profile.self.cycles-pp.__get_next_timer_interrupt
      0.08 ± 42%      -0.0        0.04 ± 90%      +0.2        0.25 ± 32%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.08 ± 22%      -0.0        0.04 ± 84%      +0.2        0.28 ± 31%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.16 ± 29%      -0.0        0.12 ± 31%      -0.1        0.06 ± 90%  perf-profile.self.cycles-pp.xas_start
      0.05 ± 85%      -0.0        0.02 ±156%      +0.2        0.23 ± 30%  perf-profile.self.cycles-pp.sync_regs
      0.07 ± 38%      -0.0        0.04 ± 88%      +0.2        0.26 ± 28%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.04 ± 86%      -0.0        0.01 ±300%      +0.2        0.19 ± 34%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.04 ± 97%      -0.0        0.02 ±154%      +0.2        0.19 ± 35%  perf-profile.self.cycles-pp.rb_next
      0.08 ± 48%      -0.0        0.05 ± 88%      +0.2        0.27 ± 42%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      3.68 ± 22%      -0.0        3.66 ± 24%      -3.3        0.36 ± 21%  perf-profile.self.cycles-pp._copy_from_iter
      0.02 ±126%      -0.0        0.00            +0.2        0.20 ± 29%  perf-profile.self.cycles-pp.update_process_times
      0.04 ±110%      -0.0        0.02 ±154%      +0.1        0.14 ± 38%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.05 ± 76%      -0.0        0.03 ±127%      +0.1        0.15 ± 46%  perf-profile.self.cycles-pp._find_next_bit
      0.04 ± 68%      -0.0        0.02 ±129%      +0.2        0.27 ± 29%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.03 ± 82%      -0.0        0.02 ±153%      +0.1        0.18 ± 31%  perf-profile.self.cycles-pp.sched_tick
      0.02 ±153%      -0.0        0.00            +0.1        0.12 ± 33%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.07 ± 17%      -0.0        0.05 ± 74%      +0.2        0.30 ± 25%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.07 ± 41%      -0.0        0.06 ± 69%      +0.3        0.40 ± 35%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.06 ± 81%      -0.0        0.04 ± 91%      +0.1        0.18 ± 32%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.01 ±203%      -0.0        0.00            +0.1        0.11 ± 39%  perf-profile.self.cycles-pp.irqentry_enter
      0.01 ±203%      -0.0        0.00            +0.1        0.12 ± 34%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.04 ±103%      -0.0        0.03 ±132%      +0.3        0.32 ± 28%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.02 ±153%      -0.0        0.01 ±300%      +0.2        0.24 ± 34%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.02 ±123%      -0.0        0.01 ±201%      +0.1        0.14 ± 40%  perf-profile.self.cycles-pp.error_entry
      0.01 ±200%      -0.0        0.00            +0.2        0.25 ± 28%  perf-profile.self.cycles-pp.tmigr_requires_handle_remote
      0.03 ±103%      -0.0        0.02 ±123%      +0.2        0.26 ± 25%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.22 ± 34%      -0.0        0.22 ± 32%      +0.3        0.55 ± 24%  perf-profile.self.cycles-pp.ktime_get
      0.03 ±125%      -0.0        0.02 ±153%      +0.2        0.21 ± 34%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.01 ±200%      -0.0        0.01 ±299%      +0.1        0.12 ± 46%  perf-profile.self.cycles-pp.tmigr_quick_check
      0.01 ±206%      -0.0        0.01 ±299%      +0.1        0.14 ± 37%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.03 ±104%      -0.0        0.03 ±100%      +0.2        0.21 ± 31%  perf-profile.self.cycles-pp.get_jiffies_update
      0.01 ±300%      -0.0        0.00            +0.1        0.12 ± 40%  perf-profile.self.cycles-pp.__fdget_pos
      0.01 ±299%      -0.0        0.00            +0.1        0.13 ± 74%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.01 ±299%      -0.0        0.00            +0.1        0.14 ± 25%  perf-profile.self.cycles-pp._IO_fwrite
      0.01 ±299%      -0.0        0.00            +0.2        0.16 ± 43%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.04 ± 66%      -0.0        0.04 ±103%      +0.2        0.19 ± 34%  perf-profile.self.cycles-pp.sched_balance_domains
      0.01 ±300%      -0.0        0.01 ±299%      +0.2        0.20 ± 24%  perf-profile.self.cycles-pp.dyntick_save_progress_counter
      0.00            +0.0        0.00            +0.1        0.10 ± 35%  perf-profile.self.cycles-pp.task_tick_mm_cid
      0.01 ±299%      +0.0        0.01 ±300%      +0.1        0.11 ± 38%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.0        0.00            +0.1        0.11 ± 46%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.01 ±206%      +0.0        0.01 ±200%      +0.1        0.14 ± 29%  perf-profile.self.cycles-pp.mas_walk
      0.00            +0.0        0.00            +0.1        0.14 ± 60%  perf-profile.self.cycles-pp.irq_work_tick
      0.00            +0.0        0.00            +0.2        0.21 ± 34%  perf-profile.self.cycles-pp.check_cpu_stall
      0.01 ±200%      +0.0        0.01 ±200%      +0.2        0.17 ± 37%  perf-profile.self.cycles-pp.tick_irq_enter
      0.11 ± 37%      +0.0        0.11 ± 34%      +0.2        0.29 ± 39%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.0        0.01 ±300%      +0.1        0.13 ± 42%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.01 ±299%      +0.0        0.01 ±200%      +0.1        0.14 ± 37%  perf-profile.self.cycles-pp.rcu_pending
      0.32 ± 57%      +0.0        0.32 ± 28%      +0.9        1.20 ± 22%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.01 ±299%      +0.0        0.01 ±206%      +0.1        0.13 ± 45%  perf-profile.self.cycles-pp.check_tsc_unstable
      0.02 ±220%      +0.0        0.03 ±127%      +0.1        0.13 ± 33%  perf-profile.self.cycles-pp.memset_orig
      0.07 ± 29%      +0.0        0.08 ± 34%      +0.1        0.19 ± 24%  perf-profile.self.cycles-pp.update_curr
      0.02 ±123%      +0.0        0.04 ± 83%      +0.1        0.10 ± 31%  perf-profile.self.cycles-pp.set_next_entity
      0.02 ±124%      +0.0        0.04 ± 86%      +0.2        0.22 ± 44%  perf-profile.self.cycles-pp.filemap_map_pages
      0.01 ±206%      +0.0        0.03 ±124%      +0.2        0.22 ± 18%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.05 ± 54%      +0.0        0.07 ± 57%      +0.1        0.20 ± 39%  perf-profile.self.cycles-pp.cpuidle_enter
      0.06 ± 62%      +0.0        0.08 ± 20%      +0.2        0.27 ± 29%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.10 ± 83%      +0.0        0.13 ± 59%      +0.3        0.43 ± 47%  perf-profile.self.cycles-pp.delay_tsc
      0.43 ± 47%      +0.0        0.46 ± 26%      +0.8        1.25 ± 14%  perf-profile.self.cycles-pp.menu_select
      0.02 ±129%      +0.0        0.06 ± 47%      +0.1        0.12 ± 55%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.05 ± 69%      +0.0        0.10 ± 46%      +0.1        0.11 ± 40%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.02 ±154%      +0.1        0.07 ± 55%      +0.1        0.10 ± 41%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.01 ±202%      +0.1        0.07 ± 62%      +0.2        0.18 ± 35%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.10 ± 35%      +0.1        0.16 ± 30%      +0.1        0.22 ± 28%  perf-profile.self.cycles-pp.update_load_avg
      0.13 ± 27%      +0.1        0.19 ± 13%      +0.1        0.28 ± 32%  perf-profile.self.cycles-pp.___perf_sw_event
      0.09 ± 33%      +0.1        0.15 ± 45%      +0.1        0.21 ± 27%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.03 ±125%      +0.1        0.10 ± 20%      +0.2        0.18 ± 28%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.12 ± 40%      +0.1        0.21 ± 24%      +0.2        0.36 ± 31%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.06 ± 70%      +0.1        0.16 ± 22%      -0.0        0.04 ± 94%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.10 ± 58%      +0.1        0.23 ± 23%      +0.1        0.18 ± 28%  perf-profile.self.cycles-pp.do_idle
      1.24 ± 20%      +0.2        1.39 ± 43%      -1.1        0.10 ± 67%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.11 ± 44%      +0.2        0.30 ± 30%      +0.2        0.27 ± 32%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.14 ± 34%      +0.2        0.32 ± 35%      +0.3        0.42 ± 22%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.19 ± 32%      +0.2        0.39 ± 44%      -0.1        0.10 ± 32%  perf-profile.self.cycles-pp.filemap_get_entry
      0.10 ± 70%      +0.2        0.30 ± 47%      +0.0        0.16 ± 26%  perf-profile.self.cycles-pp.available_idle_cpu
      0.10 ± 35%      +0.3        0.39 ± 41%      +0.1        0.23 ± 50%  perf-profile.self.cycles-pp.update_rq_clock
      0.02 ±154%      +0.3        0.35 ± 46%      +0.0        0.06 ± 74%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.18 ± 62%      +0.4        0.58 ± 29%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.llist_reverse_order
      0.28 ± 26%      +0.4        0.69 ± 23%      +0.4        0.63 ± 12%  perf-profile.self.cycles-pp.native_sched_clock
      0.21 ± 62%      +0.5        0.68 ± 49%      +0.1        0.29 ± 33%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      3.13 ± 39%      +1.3        4.38 ± 40%      -3.0        0.14 ± 29%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.75 ± 29%      +1.9        2.68 ± 47%      -0.5        0.23 ± 27%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.89 ± 30%      +7.4        8.29 ± 61%      +2.3        3.18 ± 14%  perf-profile.self.cycles-pp.poll_idle



