Return-Path: <linux-nfs+bounces-11967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF9AC776B
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 07:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA287AC6B5
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 05:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4686252910;
	Thu, 29 May 2025 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOYYp6wP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CE374D1;
	Thu, 29 May 2025 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495195; cv=fail; b=PA/6XkdYlwXreOUbNr8V8Iq8B316glluRQgUg2AXLXT1Axq5TbhSTPhlTlCjdrAy5Og9XLApqTJfbaJsM+iQlrifum0VfyDycBi1jL+tdR+1CWApMtk7CpzmXpI5iNPLchAddbMDS/JcqzJtOQGhHBDrAYunBjrveyvN/J6G3kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495195; c=relaxed/simple;
	bh=XX0Asu5/Y1W8Frf4o2k+VZaG5Vs77Bhn7ymLBnGVlv8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HuiimI0m/K5gmHx96VFHn0bcO2MVOEiC8VMVq8Qnqfcl+sxrpzkKyIdUjtMU/oQgOlEQBcMn1Zl/zh/9b9dOeTp06qAf3p0J7L9WMGbiMjb8dfJcmkRUI/cFILIhQQt3YKhSc61VGyFkvjIUf0Wo66CiCg3AKl9FvAq1tBDOPC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOYYp6wP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748495194; x=1780031194;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=XX0Asu5/Y1W8Frf4o2k+VZaG5Vs77Bhn7ymLBnGVlv8=;
  b=bOYYp6wPtNyYRRWEuermz66btTeHxhwpRbnjIt56pV2ZsgV3OJ2iRiJV
   te6WtP1oH2qZI9nryzIAzD911uooFBXS5DAP1RjGqLVfsISw1luB2S6Px
   9Z8ayas6RsM1InSVewMNX2BhrmHnaPwhcrWoXBNQn/IPNcSkK2OSIqwnL
   G44S6IO95tUeZXQ1JvF2nddGnrlXPViYpw403l9BhVTbeg62Mcsj1yswl
   kA59ToP5lxJIPVN568O1YFoYYpUwlRgZdAc/3A6gBHm3xbg4jPdtfSftT
   agCm5iFd7SaL/96FwLB7SYZGW1g0ZwfAnzObzZgq8xUrZkcSE9nVkgT0x
   Q==;
X-CSE-ConnectionGUID: QIE47ZPXRdOoDQwLKpUrWA==
X-CSE-MsgGUID: MOBwNWduSI+LRh7WI4Tteg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54205659"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="54205659"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:06:34 -0700
X-CSE-ConnectionGUID: OP1QvEV4TqSeIbxKPvFZGg==
X-CSE-MsgGUID: tQ5hRxXBQIyQq6dmVhdpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143350995"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:06:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 22:06:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 22:06:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.41)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 22:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXKK73d26dBhA/rO/hN2kJiMzBcKZJVzrnTYu4NshT3In4OqjfUvnWJbqYmIVFir6Nam115NO4MZtbD4okki9SorL0AHXdjvkHdAtnwmGHfGbNJlqHPZlhbGsN/3STvyYcY5GuGI5wlUBkczTQUiQSbjx5ktDuOnWtFLS351DBpaSCTms24Up7xUAV6rSvmHjQgZO2hkfdU8VYG9T2fJiqi0AT8UeohCTdBuFXAQwY33BetaaBRcmTKgT/R6NXwyJ2ZU4V+/wMs09jlEwVtyDFHshwdpCedT0vLZnjFRqjacvo85GKuaomvDryVEE8W6t688EcGIy912sOuUHTvN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmjR9MzhmwRRUBFFmWk9uXEYtfP/GwGKz0fr2/VigiI=;
 b=B2uTpoB/pHJedIsXiUDZ+IhoswmHOH06268HEZb4ywamhQt7d5t9zg2ToR4DhVzW4+Qej5YdOSW2986ChlqcrEGrJOBB6upREDCUrYQK5S230VBDSQB5sbSs445ZFCJFKe+F1Hp9SP+MqkrTyVZLVJOnTqraDTpvCZ8wEgmQkUBZWU0WCtLz51bfCKdfaY+maq3h5tMiDeM1o69AU8sBPmH4Zu1CMtHRsW11FZ3USxcj7ss8ZehuGsJcJQZx150s55xIG/eOl7KUXW9dzNrGsluQKKqXFF4S3E7n9Q2ns/kkKMO7c+tQlEOPVEsap2/DenCl4YxQRFfiA3guNUY0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 05:06:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 05:06:30 +0000
Date: Thu, 29 May 2025 13:06:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [NFSD]  26a8076215:  filebench.sum_operations/s 16.6%
 improvement
Message-ID: <202505291023.d4c802b1-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 72651f43-0eb2-4fee-ce6d-08dd9e6e92e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+NSto+92car0U+SGToy2dw5QdOYAMA75fzrXcRAdpK81gqbLf6JWFWbWfN?=
 =?iso-8859-1?Q?mEFtQ8qTR/epTplH0A6F+kOvYge0izleQ587pWvIMemqjCBN//CpD5R3sY?=
 =?iso-8859-1?Q?CaF3EGduk2mZPOZRn+G0kHYK8FP8lmWHVc/UUA2QN4py0HwuOHVexY8N3V?=
 =?iso-8859-1?Q?HnRHpzzdGa5kD8X2/9z0I9gQFgwRGkls99FJwjVS7cIrKgAcVdPbymIwYL?=
 =?iso-8859-1?Q?bXNDo0vN9GpNFEYMjl0sr7L26B37N1SvXcAzvjv5me3XtgBeWQUiqTg2bC?=
 =?iso-8859-1?Q?I6TWBex4UBe5Y0LlByQCl38npNU/g7B3zd+ACJImPywXlm84V3nhAEjp2c?=
 =?iso-8859-1?Q?awAsEgas7exBZ1aKDF8hrAehpzpjQDC91mzCJ0yR/sQX6S1ftGr5ALB92x?=
 =?iso-8859-1?Q?KHigNrctKfis6Xx4owzBQwQ/JxgZ1knTUirVGuHvduE4n8cH+EWM2HpM0G?=
 =?iso-8859-1?Q?nkB4JGXv9BnTGo8DG7xm+uMwg9CA9gqt937K6IogbdYfoDRM7LNXY+FZPW?=
 =?iso-8859-1?Q?KOX7/F/BkdeZqKzssF9SF0WatoBJMIoYZtMeLGKD+iASPhS4kN5IUVpDZU?=
 =?iso-8859-1?Q?j3JrJpudf+J1Ezy7QL9BcAHMFbAHW7AQkZKD6Y8qAaHK7fRHOyV9tf/mFq?=
 =?iso-8859-1?Q?wrsm0YfVoE1QBOBrIwbW89wUbb9jtx6sZHXpx6E6Ofik2lw6FKiBOVO2VI?=
 =?iso-8859-1?Q?mbjvIJhnd7NaBuCRi9MFVipP5z+ECcsfBaWq85bLAysFni09kJgWpRqN2m?=
 =?iso-8859-1?Q?x3FY7qqXgl0aCngp75Bf/QCiO+H66w8A6mQmZ+zmJLaUjQbltxlAcBNHbz?=
 =?iso-8859-1?Q?KHjw96TBM79H5N2oHANifhJTvsuT40p5NIDwMpXJzos9M9LV3mjQWoMenQ?=
 =?iso-8859-1?Q?rxRtEIbq+pe5q9UCTggvh2icNMVdfE81ToEnJz8V2P9YszSdZh5eF5zsuN?=
 =?iso-8859-1?Q?B82fdCrEy8vIQL+3bLVxuuqqqL3VxARJ37WAVJ4xgyVo8tqF6nKojifzil?=
 =?iso-8859-1?Q?jGKvbMpTq5CJVPIrEGMy82I7rSUj7HSL5YRcUXZQaq5R63zlO9OOIECIcx?=
 =?iso-8859-1?Q?nGsBCW3fgwod/eunZ2GcBg9QhrI1wRYblif+HP85evjMQxhuo1ZXjTmu+M?=
 =?iso-8859-1?Q?uQuhLSZiAQ/7TcxAmyqUjlP+4KF3r0REotjcIhwKdkjMsPSASaUH6tKCnJ?=
 =?iso-8859-1?Q?8XCnUy2eB/aRjNEbYk6HSB15RE+dFLNWGJ0HEZ+fdEAxUpPOMJtXaszSwW?=
 =?iso-8859-1?Q?2hhqzsiLS5J5IlW7KHxTxq8wLJP4qKV8WqTqzRWQ9l17KsO0q8Hpf2Qm/9?=
 =?iso-8859-1?Q?UNAhKuMESftOFzqpMKYTW164eh7THKN8RZT90YGDLMVdMCxr+wO4+18xou?=
 =?iso-8859-1?Q?/Unes3qkhJDkQRvOXlCH53nWlBm7jS1s86YA7OoFZ4yyupTZCWud3RIfV5?=
 =?iso-8859-1?Q?Spud1FuuFgJIk9E+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MXK8OYgilidlMMuUafYMs4o8fNart0xvwIU12L+8+iEE0/Qqdpnj5o47iU?=
 =?iso-8859-1?Q?scb9dA6YOcwQjl3+qxSH4IZjTLzqyo3V19Sd7dAn23BiFS0eilYMgxV/wJ?=
 =?iso-8859-1?Q?UjjW0yT2H233+iMwxMcyHzYS/BdoaCySYXWGaMeBy98l5ZQoXEVdNMCfXC?=
 =?iso-8859-1?Q?S+Z6nqRwJS1m6LbPf1jaa1I3nfKYrL5zV1BlhNxSJoQ9s2evMclDmMT9Yo?=
 =?iso-8859-1?Q?Qq038bGRDk+7VA1WDaaLAUJqYgkSgXI4/SdR5ruHiB2SzF0bzZj0pBZ7S2?=
 =?iso-8859-1?Q?4WVLg0YnZBNXZC/T263iTU74KHOezqWvOgmfvZl1Cq/yZWfLxbTINMmLAT?=
 =?iso-8859-1?Q?AR3+IX2m9c0TAgMVJWMRfy1ujaVk0+SLA3qpa5+nNyywq2rUtztAKqQL7/?=
 =?iso-8859-1?Q?4iKRvmftv4QyXhAQ+UgPoPCgOsgq24wXd7YCdIW9y8mZCQSt1qMd73xB8j?=
 =?iso-8859-1?Q?rN6+wUdKcKfQA4z/GheywJSkJYLtW9WP2vsRrAUHqUoWO7npGrhbmtfLFm?=
 =?iso-8859-1?Q?9dhJLqHd80NRq0jk7mBjfRYHwdAMHT2C7QTJ6IpD4N7tWvZvvl08m+AdiN?=
 =?iso-8859-1?Q?T9AoVlq7qTCAkTuh/CWjHURl1etgJCVmXqmqi9T4OISb2mv2O2YAt3OlQ1?=
 =?iso-8859-1?Q?KCEq/gCETnFBmGR0u81E6rNWW2zi1ZZFyicMKhkYP9DQXHHExYl89H3zLK?=
 =?iso-8859-1?Q?QGkDzE+UxAMpR2nUrCzSI3XGegm8PRMDIzMmGkyuSAfJLe06dSlia2leTO?=
 =?iso-8859-1?Q?dIoqGIML5/E2GJinT8CD0FTbTItIbA2Ful8uvdSSrHqffrMbKWb6/GI8Tu?=
 =?iso-8859-1?Q?iGN7hu5Nk3ybKQx0LtgkZy6EJB9hSb0mCJMkvIorcGAGiOUN2HKPWkcsA/?=
 =?iso-8859-1?Q?xhenb4XLlSHXakiUc5kxnRMkCE5+BagXsNwu31VCD3HNIldseHQSDOGItq?=
 =?iso-8859-1?Q?w16KdSs1ANc8xzcXb1hicXFjL4XkgnbdPTKHaYeN/F453W/8yjYEiRq+1H?=
 =?iso-8859-1?Q?zDxOkPfwC2jEiMU3pF2O9VLp65CQMQMjelBDGSWZrzu6vItzytbH3a6Hzd?=
 =?iso-8859-1?Q?D6RT56tlucapT2KUUklDgA8hEeUn4hQ65hyiNOh9wfWQPNehxiPt5AbpjX?=
 =?iso-8859-1?Q?1Fj47SaLTmtTpYvy7WM2nUqpSMC83hqzoF0JmE9FLqmJksNYgwGVIe5fvd?=
 =?iso-8859-1?Q?P7xZV+OMDuTlUjSU6iTJyEintYfFpZqdS7NdPns4Ze2Z9WValhmURl73Ax?=
 =?iso-8859-1?Q?BY8PJN4nitHdpryLjZoJVVM3N69aKWx2iYCGan7hCiCTskTglQhAgi29GG?=
 =?iso-8859-1?Q?VwqVc3hD6uxnzJwDzPNVKh7kkOMzh1KhpoLbkC4PKIaQ6wYdu3HnSDY7dN?=
 =?iso-8859-1?Q?n6Ih3dOnCA7nl4a03nsHgNt16RcD0neYzlfrirQ9hdPahHsn0yDnQ16QzS?=
 =?iso-8859-1?Q?qBqOhyF8Wo0SPBsT4+NQ7uuJjcLiHhnevhTrnpWDERXWzTC1IyffDsN1w4?=
 =?iso-8859-1?Q?o6cR2A/lVvujMtU/W3EXKtpHoHTiZGGqgciuJ1IPQ33t5B53rBZ2jyA2yx?=
 =?iso-8859-1?Q?fzMUxXpH8zFiwBqinMG+d9FzjtwMhrFyF38zP1a+KMaOJUZSg/zbfeBup0?=
 =?iso-8859-1?Q?ZoHZOofeImcXf+hMerrOuZQZeAnLYvVvggc/UZbumqOxwHCXjk//1J0g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72651f43-0eb2-4fee-ce6d-08dd9e6e92e1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:06:30.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLU+UsOLA23TI+sDDA7mi/tavKZUfxmgMDQs2QJjCH1TPB6CfKTS7/RyvKGh/YfwD4OMg1CZ7NkhzcOSttGxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 16.6% improvement of filebench.sum_operations/s on:


commit: 26a80762153ba0dc98258b5e6d2e9741178c5114 ("NFSD: Add a Kconfig setting to enable delegated timestamps")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: filebench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: nfsv4
	test: webproxy.f
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250529/202505291023.d4c802b1-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/ext4/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webproxy.f/filebench

commit: 
  87480a8ce5 ("sysctl: Fixes nsm_local_state bounds")
  26a8076215 ("NFSD: Add a Kconfig setting to enable delegated timestamps")

87480a8ce567340a 26a80762153ba0dc98258b5e6d2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   5114423           -11.9%    4505604        cpuidle..usage
    212.82 ±  7%     -12.6%     186.03 ±  3%  sched_debug.cpu.curr->pid.avg
      2922            -7.5%       2703        vmstat.system.in
    184.48 ±  9%     -17.4%     152.45 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    184.41 ±  9%     -17.4%     152.39 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.60           +16.7%       0.70        filebench.sum_bytes_mb/s
      7676           +16.6%       8950        filebench.sum_operations
    127.92           +16.6%     149.15        filebench.sum_operations/s
     33.00           +18.7%      39.17        filebench.sum_reads/s
    745.09           -15.3%     630.77        filebench.sum_time_ms/op
      7.00           +14.3%       8.00        filebench.sum_writes/s
      1465            -6.5%       1370        filebench.time.elapsed_time
      1465            -6.5%       1370        filebench.time.elapsed_time.max
     41322            +2.3%      42260        filebench.time.voluntary_context_switches
     73915            -1.2%      73000        proc-vmstat.nr_dirtied
     68893            -4.8%      65555 ±  2%  proc-vmstat.nr_inactive_file
     21211            -3.3%      20518        proc-vmstat.nr_shmem
     73782            -1.5%      72646        proc-vmstat.nr_written
     68893            -4.8%      65555 ±  2%  proc-vmstat.nr_zone_inactive_file
   3148302            -5.2%    2985206        proc-vmstat.numa_hit
   3015702            -5.4%    2852716        proc-vmstat.numa_local
   3697834            -4.5%    3531265        proc-vmstat.pgalloc_normal
   3722673            -6.0%    3499153        proc-vmstat.pgfault
   3588865            -4.4%    3429561        proc-vmstat.pgfree
    940490            -4.3%     899874        proc-vmstat.pgpgout
    162192            -5.9%     152665        proc-vmstat.pgreuse
      5.37            -0.1        5.25        perf-stat.i.branch-miss-rate%
   1681345            -1.1%    1662216        perf-stat.i.branch-misses
  11085725            -5.0%   10535577        perf-stat.i.cache-references
      2.25            -1.6%       2.21        perf-stat.i.cpi
 2.976e+08            -1.8%  2.922e+08        perf-stat.i.cpu-cycles
      0.46            +1.6%       0.47        perf-stat.i.ipc
      5.18            -0.1        5.08        perf-stat.overall.branch-miss-rate%
      1.87            -2.6%       1.82        perf-stat.overall.cpi
      0.54            +2.6%       0.55        perf-stat.overall.ipc
   1678730            -1.1%    1659448        perf-stat.ps.branch-misses
  11076863            -5.0%   10526572        perf-stat.ps.cache-references
 2.972e+08            -1.8%  2.919e+08        perf-stat.ps.cpu-cycles
 2.334e+11            -5.8%  2.198e+11        perf-stat.total.instructions
      6.43 ±  5%      -0.4        6.01 ±  3%  perf-profile.children.cycles-pp.__schedule
      1.11 ± 11%      -0.2        0.87 ± 13%  perf-profile.children.cycles-pp.try_to_block_task
      0.94 ±  7%      -0.2        0.76 ±  9%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.18 ± 14%      +0.1        0.27 ± 26%  perf-profile.children.cycles-pp.set_pte_range
      0.04 ±100%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.xprt_sock_sendmsg
      0.13 ± 28%      +0.1        0.25 ± 25%  perf-profile.children.cycles-pp.devkmsg_read
      0.38 ± 14%      +0.1        0.50 ±  9%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.03 ±145%      +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.scnprintf
      0.12 ± 27%      +0.1        0.24 ± 26%  perf-profile.children.cycles-pp.printk_get_next_message
      1.45 ±  8%      +0.2        1.63 ±  5%  perf-profile.children.cycles-pp.copy_process
      0.93 ±  6%      -0.2        0.74 ± 10%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.21 ± 27%      -0.1        0.11 ± 32%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.38 ± 14%      +0.1        0.50 ±  9%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.21 ± 20%      +0.1        0.34 ± 19%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


