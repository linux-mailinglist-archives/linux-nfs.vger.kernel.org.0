Return-Path: <linux-nfs+bounces-7566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAFF9B5BCA
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 07:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E6F1C20AFF
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACF563CB;
	Wed, 30 Oct 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVorCdfN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F81991DF
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270168; cv=fail; b=hgREy+r+Xd9W9HberOt4ek9AROgcCMXzGXzwLQZOrgl2y3IPK8kuX2WYpEaiM7JGAPaC9A+p1vXN01qNBqcpzekdxYqN/qSdkYRbPG4PCQgZvmAAWa+jdJ78gnzfZ6TG6827LTEkqtxNgqh1hn2cvsmXKEDFcCYVqjQq6aFBR0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270168; c=relaxed/simple;
	bh=D33Pz425kfBwZTtIIjxW8WXsqGWALJDBjdrsZ7ss3q4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCLWXUgyZ0w2O03lEhXcAMv+MRbew5nth7rXECpXBu2WP9FzF+509fMqavMhXLj7Awoh4xwY/QrWNGtHU/hxo/EVRPh54QtAPboPUbmFummzUF3h+e9abUg/B8tvLul3mLJ2Y8uKjuM2o/3/twVvxnPD7mBdYdwfwFsxfuObsD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVorCdfN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730270164; x=1761806164;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=D33Pz425kfBwZTtIIjxW8WXsqGWALJDBjdrsZ7ss3q4=;
  b=ZVorCdfNR2g6y2Iw5IICMCBuoR2h47pKHFBgYa6gUQxOTeHWS9djWds5
   Y/XSYc1VBlT9lLKDhSFajudYuJsdYz7BGnHcexEQW0sInznGvh2fk+fNC
   lcXRPizYWD59PmmszW+MTuSDphiJ+5njI7Mm90sGDyqJFH4L4mXsmdAZq
   xFU2k4T3HxRMDLTeUKZzvTGTTovIT8tXfOpg8OgrJ77dhBxGQarSggFz6
   PzVerCpiIp5cqgL+asVIUiKxjP26q2ErKx/jIuF/n6AhZe27BBPwXxw5x
   PLqK+flu6eBPWyfG+3XhXaoiW5gMvBNV7G920KHVVwJFtoLi27P7YZrog
   A==;
X-CSE-ConnectionGUID: X9nGbYEQTcCECVwCKjb8/w==
X-CSE-MsgGUID: yjUDhwFnQzGiDRM/GlbgDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30100635"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30100635"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:36:04 -0700
X-CSE-ConnectionGUID: PsEivnIWRLqN6fCmx788JA==
X-CSE-MsgGUID: WAhTS7UkQeiRBo1fpTkh/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="86767549"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 23:36:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 23:36:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 23:36:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 23:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2KZPPvcAJ5w9yZ+cFdYNKyZKjQs/SYlxPbnv6WAHWnkB5LT3qRivsibdo3HFH2Dq/TTqW5SWwakbFHjwhjLAe+SY8ortEZEIa9d2vmAVrk5rKhqOJzponaXEjoZ/UNhwsaiTi6fMEubWtphqFlTq0J6AfPOL7EsSxELDbewGonA4t1kCNDAdpMIVTjDTVmGpqoOo8QTBJ6enHBrd9oS/grDCSH1FPDaIZBx77e823YRaJOMi4sF1J0jKgqXRj/5m4Zjmd/KsVwKlGlgB+6Bh1FZnGQ1tNVg6ggZA/bvEO5fIv8Rg26q6sw3k6eI9rQg3UsRJ0EwP0HBSjQ6r1jQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s05DeJz3qulFqvWx2rNxNFgCFBxsxA1WFPXoRu3emI=;
 b=m8oll1BI0VMYoRny7LfZKi3ceSKu5l7uUiCQwzPfpy1g2L8pIg6iJRAIybkdz3icmCfPcP2znAm8BLv1TvyVArmE3fDefCVw1RGIcZG1P7fqcWGlAC8g27e2py0zW5vOpfN3kyv8itrmR7RfyaoP+a4y4i+tkWK3YLUIV3e6m8WuIRFeWzlUrcG0c6V6rWKF+js3oJ7dBF8yv3NZgVK4C92zMnddH4Pc43qHkuG9aadtAreI+aZmuAGhD26CA+Q7gSv6mzaD6C907I/hymTMiS0d9mndaDZ3tmE8532C629/XrDYy80UG0F0xJub3cHLcTGvHWMO/jRpJ8WgtiTmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:35:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 06:35:31 +0000
Date: Wed, 30 Oct 2024 14:35:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	"Chuck Lever" <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	"Olga Kornievskaia" <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 6/6] sunrpc: introduce possibility that requested number
 of threads is different from actual
Message-ID: <202410301321.d8aebe67-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023024222.691745-7-neilb@suse.de>
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: bc251be7-9b63-4b3a-9619-08dcf8ad0cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zgcrLnjTv+jbYnD2X5cnLKYUoSv6IkZQrNjXuwoysVFlECM8SYIXNsfoVz?=
 =?iso-8859-1?Q?+jQsvQCjOpPV5LXqmafPm8lJcivSDF/DS8ikPGbbJBtWHLmo0OhKpThTRR?=
 =?iso-8859-1?Q?ntiq30FFtuSolUjnxfjuQz2KH5MUdfV5mNYRuWI6+3fcDxD0sUU3QXj5Nj?=
 =?iso-8859-1?Q?nhTkmVqmDYN9GBHqzzoS5L0Yk4qrVqKTDRBoY2d1Qr4JyS97oU14Kkd0Oy?=
 =?iso-8859-1?Q?TWel3+YtnuYlIINDeFaY13Xu5Vbn35N0F6VMaz4k+qKkdi2+uYXsoAhaBc?=
 =?iso-8859-1?Q?ScD61mqO/Ph1w784Cep0MS26LIKyXb3Mwuah/EBA7AOtu6Wfs30TPwN8eq?=
 =?iso-8859-1?Q?GvRRzKnAXCUaGtssnb0nmM0RD9Z8cW9bWa0By/E4EmdOH7KNuzCMOi2H1D?=
 =?iso-8859-1?Q?+9lDxnKttCZb/KQDqEZSVN90Ik6Zbg+1eLL7DWLBTQjRRj1YU1OU1K8iLS?=
 =?iso-8859-1?Q?FIrdsr7MVHv/GH4SxFeoXEPlkZnH+d7FW62qnA863ETyIEwF98Ltzh+Cd7?=
 =?iso-8859-1?Q?oowQQa6h1x6ovUlyna5tOYwxjr0AAkPZM+X0+kezo1gBVpxPawLIpZNw3u?=
 =?iso-8859-1?Q?QliGkgV7v+OKt05bAzy4f9MOiYHHUWKqMEU8W4boRfq6cnRkQo/e9tvrKX?=
 =?iso-8859-1?Q?9cC6fGHybBmpIdmJfkVW6ujTFJMUVULIe+XZOw0D6xPku1Cxlo8mdaH3GE?=
 =?iso-8859-1?Q?ZUt4n9B98bvN8HMUlHhJc35iLWlbYTvrzpbEeXYiY1g6/5PmktqmXCx1LX?=
 =?iso-8859-1?Q?hCUxajnVYjK3CUnguwqiAKWEqAMag8GrH09Kdo1u/uoSMDbmFQOQFMwwa0?=
 =?iso-8859-1?Q?2YPK2fnkvj/S6GooRBqxWF2mEgQYBt3PXnklY8dH6wCZEfFdT/cA1twS6g?=
 =?iso-8859-1?Q?WFyFr62/FKyAG02ADDWssbC/og5wVUaF5e9/PK5t/39Gt+4iGhWGU6wRSG?=
 =?iso-8859-1?Q?xaAcLSpzs6x1AG4Iv7Vf4Vol1A+WeX7bFCPtGNQcqhB7VSJJGPalr2ybq3?=
 =?iso-8859-1?Q?mygBFD6Gj78P44CcwF63OI13HpXhV3bJxCZM69pTOIbFtFzX9p0OerthgP?=
 =?iso-8859-1?Q?Tv7BznGeX/Qr+Jf+IbWaE+f66aPQ9X/2c7yskoRzHQsh9+qMERr4iAgxeH?=
 =?iso-8859-1?Q?vS6nNJt67JmnEl4+irwJr2gpmEW2haYZrv/a/HUxvecJZTlapsWmHtl8ea?=
 =?iso-8859-1?Q?l/3n/EemZ6VyXD1xl4z5C8BqEpfOOea5ptZnKlARwMey3zET0uL40Od9f2?=
 =?iso-8859-1?Q?wl0EJjmLWiq36UDssB+dgp+n+Xvc1P7iHtXUPI4JMAaHvllqsB6Y8zFCi2?=
 =?iso-8859-1?Q?vZQqSOC3x7c3PC9lOo/9Ho8UJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MxvDb8rpvM5D1SLgBRQLQrimHCplrK/gr3YmDhMgTaPUUlxDYnaUyMyeX1?=
 =?iso-8859-1?Q?S2Qh+oyFuMHmJ9H+h9BLiyX3Nwr8ZMrwCL3d/PJx+WDy3gwQAsemjUE2J6?=
 =?iso-8859-1?Q?7PM/EL5/EqBOm3HztYSGjgBrFyC26GpHaNBWroSaX/wdk9vB4vsFw33Kxq?=
 =?iso-8859-1?Q?92viirI/JnfzWcpk/eeWncALA0Oo/wF2Wd1m1tVaitmF32xjVdnc7VrhJW?=
 =?iso-8859-1?Q?E+6MnInd00bP0FslzY9YV8rAlrVx7dHcveFdDggEy9yfDPVuj5eJ3arKQk?=
 =?iso-8859-1?Q?b5lvL1g892BXD2GvFebrwWYu3TVGSfWu0ujS23Ail4HFU6oEQE99so/ljv?=
 =?iso-8859-1?Q?yj0h6ScaItwcrQZTxs1/BTcZ9GZoSrxZ5jDc81J/H5p/Go+HrGd40XVK1o?=
 =?iso-8859-1?Q?WNwllCzZhHgYVO8EIxTQpHteIlBDZ/6oThHp2TzQNoM6K0M9fiklF6jvdN?=
 =?iso-8859-1?Q?32FZrbdAgoKFpFPLoLwnD1oCgf2FVDsl1HV80CPypd3O0rqp2k0vpSVMH4?=
 =?iso-8859-1?Q?JKFRaIRW5ev1/ooTyJOKz6Ei+7tqPBh1dqaA5tlENgt3KNx1NBs6givCQj?=
 =?iso-8859-1?Q?3YoKRb9sXBq47xSjlXbJJJvOf4Y5NfdcyKvKwVwBTuFWLInrglBoJyIQ20?=
 =?iso-8859-1?Q?P52npJbCCYxRp/4ZtsK/Dmo2cFYGsJd0EykZZ3oYcrlXH8+P6e8K2Y/vMy?=
 =?iso-8859-1?Q?DMB0TAGSE5fz1+JjQY9vmOtjgrsvsqLt7rsDr4qze45waMosdpS3G61Pbx?=
 =?iso-8859-1?Q?uqtlg6pN59Zk5SMqq5WM5uTiN46WwE+lu0MvItVJswZqlVjgDkdIKUpxU9?=
 =?iso-8859-1?Q?qNvungWAmrfVOk6rLNxNj0cSL77fmB5mPKUkuaLc7OfTXzJ9Hle+DK6a9A?=
 =?iso-8859-1?Q?zRFVC7A7jdlhpBp9wC/xHHFdsUWxTMZwLxXXyx+6QJK/TXh04g9KRr2LeE?=
 =?iso-8859-1?Q?YyPp8woCBHNJT2NQM/fgQLMDCfTIb0qMBbUAFAYE5gh1E05/d0zhuPlB3u?=
 =?iso-8859-1?Q?6VoZjRMqpWfagjN6yIV3HhWSNpGF0ejY+yZlGNXWX58PJ4+iXTPxdrqEK7?=
 =?iso-8859-1?Q?QTlRp33TgQoEPOILVMRozFUzAyBAuDq74s2zE49E+t1fmrORbbWx3pAdug?=
 =?iso-8859-1?Q?mwNVP7dVcw2cgJqrCp8NFYNabc7xCnp+bdNjUi/Fpty4OOQgfTHG3RZv0J?=
 =?iso-8859-1?Q?6+WZS4K0uxegP+AxTetOC1psZX2qZvIigv4SokyHA4nNyV/TsqF2Z+3enz?=
 =?iso-8859-1?Q?s/HH6UT/hFhmKrbuwMMu72w+ll6L/2BJcTnUyTZ04TrO2wzig/HO5SyeOh?=
 =?iso-8859-1?Q?lQXhbBmgBvQc0vLYlswU2uYZ+0+uXhCe6CCgMNv0p9J8jmQLowBaK49mse?=
 =?iso-8859-1?Q?rwlHQ0rprL61Mfv6kk6n5nYSC7XkCJSwbg0B3e+15Rr7o15InAn/QjvwqE?=
 =?iso-8859-1?Q?KiafU9bckzZiEIUkwH1pQEUQlhzsPa/v6JxCwjisebyNW12lX/kzUxjYwf?=
 =?iso-8859-1?Q?f9MqxaQ6Y0ZQTaapm7GmZBTC8GtaPFKZzgtIE84otISHiSoNycaP0VeaML?=
 =?iso-8859-1?Q?r6EubiYvkEPCbS4T67cIjy4zRzu30m0HNne1w+5zBSjEMWUHq7pFOjazhN?=
 =?iso-8859-1?Q?EvekrtUxkNrR9FhJkbdYOa7x2exIUw80XXKx+9nQy8JSg1RaICjSNEBw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc251be7-9b63-4b3a-9619-08dcf8ad0cbc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:35:31.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMkLGKUD5F2Mx4xCvVrnTSDmCfWtmsKO1oijaJZ0JjMyPx3DL47Pfgjsla3ntaOdNHfTV8VKSGpzba6SwzvSKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.2% regression of fsmark.files_per_sec on:


commit: d7f6562adeebe62458eb11437b260d3f470849cd ("[PATCH 6/6] sunrpc: introduce possibility that requested number of threads is different from actual")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/SUNRPC-move-nrthreads-counting-to-start-stop-threads/20241023-104539
base: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link: https://lore.kernel.org/all/20241023024222.691745-7-neilb@suse.de/
patch subject: [PATCH 6/6] sunrpc: introduce possibility that requested number of threads is different from actual

testcase: fsmark
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	iterations: 1x
	nr_threads: 32t
	disk: 1SSD
	fs: btrfs
	fs2: nfsv4
	filesize: 8K
	test_size: 400M
	sync_method: fsyncBeforeClose
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 10.2% regression                                                  |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1SSD                                                                                      |
|                  | filesize=9B                                                                                    |
|                  | fs2=nfsv4                                                                                      |
|                  | fs=btrfs                                                                                       |
|                  | iterations=1x                                                                                  |
|                  | nr_directories=16d                                                                             |
|                  | nr_files_per_directory=256fpd                                                                  |
|                  | nr_threads=32t                                                                                 |
|                  | sync_method=fsyncBeforeClose                                                                   |
|                  | test_size=400M                                                                                 |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410301321.d8aebe67-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241030/202410301321.d8aebe67-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/8K/nfsv4/btrfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/400M/fsmark

commit: 
  4e9c43765c ("sunrpc: remove all connection limit configuration")
  d7f6562ade ("sunrpc: introduce possibility that requested number of threads is different from actual")

4e9c43765c3fd361 d7f6562adeebe62458eb11437b2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.09 ± 78%    +173.9%       0.24 ± 29%  perf-stat.i.major-faults
      0.07 ± 66%     -61.1%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 88%   +1806.2%       0.46 ±196%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    -17.50           -31.4%     -12.00        sched_debug.cpu.nr_uninterruptible.min
      5.32 ± 10%     -11.9%       4.69 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
  76584407 ±  5%     +40.6%  1.077e+08 ±  4%  fsmark.app_overhead
      3016 ±  2%     -10.2%       2707        fsmark.files_per_sec
     36.83            -7.7%      34.00        fsmark.time.percent_of_cpu_this_job_got
    285398 ±  4%     +10.5%     315320        meminfo.Active
    282671 ±  4%     +10.6%     312596        meminfo.Active(file)
     15709 ± 11%     -28.8%      11189 ±  2%  meminfo.Dirty
     70764 ±  4%     +10.6%      78241        proc-vmstat.nr_active_file
    468998            +5.4%     494463        proc-vmstat.nr_dirtied
      3931 ± 11%     -28.8%       2797 ±  2%  proc-vmstat.nr_dirty
    462247            +6.7%     493402        proc-vmstat.nr_written
     70764 ±  4%     +10.6%      78241        proc-vmstat.nr_zone_active_file
      3620 ± 10%     -30.7%       2507 ±  5%  proc-vmstat.nr_zone_write_pending
   1135721            +2.6%    1165013        proc-vmstat.numa_hit
   1086049            +2.7%    1115353        proc-vmstat.numa_local
     56063 ±  2%     +18.0%      66177        proc-vmstat.pgactivate
   1521044            +2.3%    1555275        proc-vmstat.pgalloc_normal
   2522626           +10.2%    2778923        proc-vmstat.pgpgout
      3.75 ± 26%      -1.9        1.80 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.75 ± 26%      -1.9        1.80 ±  7%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.54 ± 39%      -1.7        0.89 ±100%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
      2.54 ± 39%      -1.7        0.89 ±100%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.51 ±141%      +1.6        2.09 ± 29%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record.run_builtin
      0.81 ±100%      +2.2        3.01 ± 44%  perf-profile.calltrace.cycles-pp.__evlist__disable.__cmd_record.cmd_record.run_builtin.handle_internal_command
      3.11 ± 27%      +2.6        5.74 ± 24%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.handle_internal_command.main
      3.11 ± 27%      +2.6        5.74 ± 24%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.handle_internal_command.main
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.children.cycles-pp.generic_perform_write
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.children.cycles-pp.ksys_write
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.61 ±141%      +1.5        2.08 ± 25%  perf-profile.children.cycles-pp.vfs_write
      0.81 ±100%      +2.2        3.01 ± 44%  perf-profile.children.cycles-pp.__evlist__disable


***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/9B/nfsv4/btrfs/1x/x86_64-rhel-8.3/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/400M/fsmark

commit: 
  4e9c43765c ("sunrpc: remove all connection limit configuration")
  d7f6562ade ("sunrpc: introduce possibility that requested number of threads is different from actual")

4e9c43765c3fd361 d7f6562adeebe62458eb11437b2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.35            -2.0%       2.30        iostat.cpu.user
    137839 ± 27%     +41.1%     194529 ± 17%  numa-meminfo.node0.Active
    136284 ± 27%     +41.7%     193101 ± 17%  numa-meminfo.node0.Active(file)
      2.80 ± 32%      -1.6        1.16 ± 46%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.80 ± 32%      -1.6        1.16 ± 46%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
 1.397e+08 ±  2%     +14.5%  1.599e+08        fsmark.app_overhead
      4135           -10.2%       3712        fsmark.files_per_sec
     48.67            -8.2%      44.67        fsmark.time.percent_of_cpu_this_job_got
     34164 ± 27%     +41.6%      48381 ± 17%  numa-vmstat.node0.nr_active_file
    276516 ± 17%     +26.7%     350296 ± 10%  numa-vmstat.node0.nr_dirtied
    276215 ± 17%     +26.5%     349400 ± 10%  numa-vmstat.node0.nr_written
     34164 ± 27%     +41.6%      48381 ± 17%  numa-vmstat.node0.nr_zone_active_file
     80.71 ± 30%     +38.5%     111.75 ± 20%  sched_debug.cfs_rq:/.removed.load_avg.avg
    270.60 ± 12%     +16.0%     313.94 ±  9%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     23.59 ± 44%     +49.9%      35.35 ± 24%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     23.58 ± 44%     +49.8%      35.33 ± 24%  sched_debug.cfs_rq:/.removed.util_avg.avg
      3281 ± 11%   +1047.0%      37635 ±193%  sched_debug.cpu.avg_idle.min
    598666            +7.0%     640842        proc-vmstat.nr_dirtied
   1074454            +1.1%    1086656        proc-vmstat.nr_file_pages
    197321            +3.7%     204605        proc-vmstat.nr_inactive_file
    598082            +6.8%     638786        proc-vmstat.nr_written
    197321            +3.7%     204605        proc-vmstat.nr_zone_inactive_file
   1716397            +2.3%    1755672        proc-vmstat.numa_hit
   1666723            +2.4%    1705951        proc-vmstat.numa_local
    145474            +7.4%     156311        proc-vmstat.pgactivate
   2183965            +2.0%    2226921        proc-vmstat.pgalloc_normal
   3250818           +10.5%    3591588        proc-vmstat.pgpgout
      0.00 ±223%    +633.3%       0.02 ± 53%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±223%    +729.3%       0.06 ± 29%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±223%    +466.7%       0.03 ± 22%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00 ±223%    +973.3%       0.03 ± 61%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ±223%    +480.6%       0.09 ± 25%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.67 ±223%    +506.5%       4.04        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      3.74 ± 52%    +190.1%      10.85 ± 36%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.68 ±223%    +526.0%       4.25 ±  8%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     18.67 ±173%    +375.2%      88.72 ± 23%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±143%    +212.5%       0.03 ± 47%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.66 ±223%    +504.3%       3.99        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      3.69 ± 53%    +192.6%      10.79 ± 36%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.67 ±223%    +525.6%       4.17 ±  8%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     18.65 ±173%    +375.4%      88.66 ± 23%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


