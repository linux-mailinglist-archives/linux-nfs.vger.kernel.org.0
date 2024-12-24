Return-Path: <linux-nfs+bounces-8763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B239FBF3C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9F1884DE0
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B2192B69;
	Tue, 24 Dec 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUt2sJP/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2591B87F5
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050965; cv=fail; b=WObuZfMXnoE7d1NIaQna1ypJTeSMBKuntel73uDG7/mVZ/ZS4PsGD85FLpk3sND6NI91g6rAODIaodHvHSpuh48sYmNw+Mllz6U7xh3/bHKezBn/dx/K/ivqBAGC8VHBvK/FIcVp13sRXFJSxVGdIF8iYq8ZwwIZGtP1bvUlpoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050965; c=relaxed/simple;
	bh=HVql2zP6fwNXtT/u8SqHLU0Yo3liK4rDkSi/gjqqKDo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aXIORocvkzUOmxY4puL7USUbu3FBcNkccznQW1RCtm0VOJQhxpWonys9KJfpxbdY1v0vIKeTSSC63UhFDiMLvaFrn51D4RqvQkvOBfYtpOuiDSaeF3CUxOhqDiR2H8EgcX6ZKGj4IKddZUf5g/DhULAyZF/D2g7CEEB7pfATjyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUt2sJP/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735050963; x=1766586963;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HVql2zP6fwNXtT/u8SqHLU0Yo3liK4rDkSi/gjqqKDo=;
  b=EUt2sJP/CKCEOhmBsz7/kHQqBng7FbsowmyZC4WfLQjLjFRMy45MLUkN
   a1FKEJRy/mT79+l6S51Hjy2ZK1V1XMWvse8VIIm/2gXpxGFQ70GYhY352
   m8GT9zUySrqr9zcA6wxfPY7Bz+XA4uvJJm3ZVypY664YuQsfPEl/p9Rcr
   XaU1b4eLufGBz752Oi2pI6EMruV0ITtv/abSp87DeIRlkaYWjkhiY/giU
   +8pJuzXFIlcd8Pql2T4I7Brsm5WDNWxh5DnXXVrNhRGmwpbtBluU4fedz
   Rgtg7mlEr6LQhOf3VHkjMRRmai4dZvf7r3sZzyxLEtxWhSEk6Ek9B/2oW
   Q==;
X-CSE-ConnectionGUID: eAKqsHT0Qe+8iExOYKFKAg==
X-CSE-MsgGUID: AEZQmQacR8iesITlfZj4pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="57984733"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="57984733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 06:36:02 -0800
X-CSE-ConnectionGUID: idkMFVYiTImvJTM/Z6M6Gg==
X-CSE-MsgGUID: u7rEaq5EQxqumHVb+EyDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99972507"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 06:36:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 06:36:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 06:36:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 06:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9lNHU1c+4Tp9pt4VxCWskGZcOBWESiH5+UTMTVEtE2wwVKVOpKijCLCx5eX293UOSYajcMYoKm61w67/sthwK3q1fVUh06Bcfslw/ORgUfbCnby3VuakEchLvKdzG9GWJwbgZkUo1tiA+HSjFqIj/nqyAhczXTDaO/iyhK7dHuQcy4VHRidDybfNE/BMQj7eeCdP1Ifzn05OYB6b4nXUEtmGkApu7H1hXTB1DpVKjsjPn/3qKor76TrhXDrrvm/WoKgXIrpOZsJ1z4Pi7bZEtp87Vsl9PTtUUc2t4UWyFnO9VMbVXtECiTNaRnkDmrMwKdDWhC6Tzz/axhPjZ9Nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1cn0TNQGcR8Kw0U8kWPzBQILgJPXPzqKD6XB5RKODU=;
 b=mO1+1duncgsvxCT/dAnVaKQf75eo6M+4yDPmLgU18gVy0s4Inu5hgGyoe4y8LdMARztlanfcHtDZah6JECE43rbUbZTt3wb7xgZ0tWuaCebkZlk8A1XjqJj82i2rFwb/ziE0Cl5+YQHiDUbb3xVvNh686+n2eLv3OzlSKrWHLC7qmXIpAvrbEpinHksVpXRjPEA8s6S5pvDi/vbEPYdNUvogbMsya4gjG+EOLI0LetcIEwU6oquCYF805SVxcmMPV/RvMyhebR/YAnf3ENROLwiE332xz2H6uPrjuRLIZLIEi/0A/775m/n3FG8aluvg24N9IP4pwwbgcQRTrIOfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 14:35:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 14:35:55 +0000
Date: Tue, 24 Dec 2024 22:35:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [jlayton:delstid] [nfsd]  48ff66155e:  fsmark.app_overhead 56.0%
 regression
Message-ID: <202412242245.dbf6ea4b-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f80e7b-eb92-48ea-abc5-08dd2428465b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?oVKA98fFkNDxj3O0xkPnSRmK6Nxss6GrR92kXs8R+lzo5JsRCi+UY9ksib?=
 =?iso-8859-1?Q?k4Ohf5iwQte7E0pt9sFZK4swHHuPYvVQGKflDVZMPrwn4xo33fW3vWMqZq?=
 =?iso-8859-1?Q?DZrzBlHFmmRD+Gpcmkz/0WP0rkIR9JGaC2YxVQCzJdvfrzT9FxocXh/FS5?=
 =?iso-8859-1?Q?Wui5Br4kxDj7LlyYvywg6wxeme0SyYENL9pk/CNeDDhOBUSVKSAV4dw/tW?=
 =?iso-8859-1?Q?YDhrPR4kHUK12upoqpArtcqq+4+OgDcXb1e7tJC+kv7Jke/10NHVb7AKMR?=
 =?iso-8859-1?Q?JkHE/RHt6ZuGQF7FCZ8hY1MI8Iy66xGuORTYCARUijXJzpt1yohehePvhE?=
 =?iso-8859-1?Q?1HcKs7EI6RH0ov5IboCbfe59DFtyXnV3lVlOR7ud08G/uOK0OAhgmFwL3t?=
 =?iso-8859-1?Q?/gA2lOukx7j+yF0hiETZz2sdhI/z8ZhMuJvjhsmj7sE1Fj4Fz1HradJdMz?=
 =?iso-8859-1?Q?8zQGUJgjMh1u7aCH6gZQRx/F8RV7bHgxdw4cBLzun8eeRmqctMO/tpmBGW?=
 =?iso-8859-1?Q?KA6s1GoNQ11ITpIozjkr7YDIvPHUgZENO8dvQm3/RPsuBlaMbOkp2s2RFG?=
 =?iso-8859-1?Q?UTjHCPYIDSDVUi2WYX5Bpbow6d0tcindTqVfjFW4XxEOHD7EiupKE6i155?=
 =?iso-8859-1?Q?SGlX/2U/HIlNvi2xqZbn/cTlOuz/VtSRahSsrfZdFDZdZA18inXyKRV9yC?=
 =?iso-8859-1?Q?FrXadpH1XA9fA324bIaUcJ3aoEm2u5arcnnwwhi0WYOwShRklt2c5WM+pR?=
 =?iso-8859-1?Q?yVpkkN83nNXKx9aUJaBq+shGx0H+LMrBnKmyrvZBO/a/V8qcDaRgMiIKB1?=
 =?iso-8859-1?Q?ffe3cGLUPRKg0FvBj+1uWzGdPcOde2S7wtRJluxCcZZXej6Ij0hxFBLphl?=
 =?iso-8859-1?Q?mkzmFDIzzgzAYh5PoRZ15RzZrzBqGzlF6OveX0rCwrt8SWAKEbgTqAkOrF?=
 =?iso-8859-1?Q?1o9ELDbeJrStrwtKOiRdvF99LSrZD1PXGSBJXI80t+W9hxkwowOZk+1xK9?=
 =?iso-8859-1?Q?+IRW7Fmr2vwhJ4Pdv4HxO8/Q3pCXYsBhkD+PQ7L86SVWLK5e10agoDwJ/2?=
 =?iso-8859-1?Q?93fYXKsC5qO01ZpA06l+8SX+M57SfxuH8QdKJb6argIxzZY/3WIFEut5/S?=
 =?iso-8859-1?Q?bksLi/vMg2OP5HFPDfaeNgqfdY1A/Vxg5m7kI+GREmpTzjASYUx0UeA1Cs?=
 =?iso-8859-1?Q?idPBbHDg+HtlXuoaE2nbdGzcVvM+8tQ0vxRE1QSqTsD303L4qCMzNyEGO1?=
 =?iso-8859-1?Q?oiDIdKlifiQIAHB85su9LNKtVEEnC1mjUzev2Cmi2Iwccs/tz6BTGYIHUG?=
 =?iso-8859-1?Q?3DADHsaq+4L47PZ3s124fFgWM1h2q0Jda/uTggKnd3cJDATGL01ZJTOl3d?=
 =?iso-8859-1?Q?xizb6q0fqUb3lLaFr4BXcR4cSDLlFChg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U42xCpdU22l++34XPsRzEV5CENZqYQAnfMd4twOb0pPjlaec3/NDgDPCaC?=
 =?iso-8859-1?Q?ENk/Kv5VKWwL0PD1bJXnGGykeKoWH6z7/dh389Fr3AJkniV7I8GYdATp7S?=
 =?iso-8859-1?Q?4cxpxKz9MmV/kfXYnhIfY41+OJC+XRM9xBfxX25ZWbV7eh8eiUjhrZf8Tq?=
 =?iso-8859-1?Q?E3wHMufaJViKepaSbqdVxXc+ya6Cm64vFZNJVk82jAT1i8DzEci5pXBXSl?=
 =?iso-8859-1?Q?tXwFgOTwx2byt+x7eL6+Apy6Xy105av3pBPuuPMfyIzeR7nfbVSOlzqpx+?=
 =?iso-8859-1?Q?qUai355VhZxyepaOE7VSvEwZqZ0TF49kNjRkOMjyCcCvJ8ZTNHrwCHvvWa?=
 =?iso-8859-1?Q?2qMY5o2WmkWYOuExwQeo00uzHaVjG4CAf1OihvlApGGQL0m7D+X6hc3fcL?=
 =?iso-8859-1?Q?1mI+95uApLstw39LLt35p8cLOpOKmxqJz9MDrjf+3IFqfOdAOH7hPkC1wF?=
 =?iso-8859-1?Q?wBxKH7vUGWhdkJAM0kHPn3QynGG4BymFHAjj/9wxUbgYRDbt17969I5ozO?=
 =?iso-8859-1?Q?e4X0HcQgU9z0ekfq7+O2WmkzpJxcMwol5LVCTD9HP9KGdS9xo6i+VV8E1W?=
 =?iso-8859-1?Q?s6QANQ6kqyTbcS2RTrFZ0TdCDZdTA72yzlv0bIeSF3by1Bt0F6mIzzdHVN?=
 =?iso-8859-1?Q?kosmYqx2lJWwMh2jixvYBn3Y9p9/wBTezewfl3nEHQ27gaNajCQO+nHnjC?=
 =?iso-8859-1?Q?T7ei5pEKpkSm3z3UTalwcW7BmE0SeMFw54gFCrg+xULdzAVz3yo+DKaDJK?=
 =?iso-8859-1?Q?GWiYbtMVtj2I8KWiyDSm5TsdLBwU6RpGj+/2+QWDKMFhkMZHzVLMRMB3Qf?=
 =?iso-8859-1?Q?ZMRkhlCV4xVTJ1s/DvnhRGI9pztz9TLFGIT4yux1+ejrOvDB8RYDb5u2O7?=
 =?iso-8859-1?Q?gZ9jtd7MuFmSewT78Vjs7dQ8Ow5RpxksXI8HLtMHeWPE1BT+lCIbuqvs17?=
 =?iso-8859-1?Q?h08TSO73/6zLuiUjQCDLx1rnYTdxHk143JUD7Vg1QAyZZYyLsvWLX/Tg8L?=
 =?iso-8859-1?Q?1Vz5aXSDKPWdsQf1qk3r0K3rOEV2bWXu7R6C6gOZeLsh2BJGvZpC5m+TZH?=
 =?iso-8859-1?Q?LUBOXuAa9gXHRFAPK2/H6Ae+A4Jr4b11pOtVdtWXUIZxm+iFuZ/G8E1GDb?=
 =?iso-8859-1?Q?WrswEeZQa82wzd935iLHw4wgHyi/ixLvciZ4YLQ5lUNO/e/uQ2nDXdsnF5?=
 =?iso-8859-1?Q?tsznXuUpkviT8V3qvjbopOwgmoDrm7B0CCs6wgdR/VsxvJcCJAVan8Tdwc?=
 =?iso-8859-1?Q?6GDE+Uk9KmizgncAch22GSxQb2M3zC5Suc/UUAJ2STOx5ab3c6gRocvxui?=
 =?iso-8859-1?Q?cp8BvWVjVjT/dJZpSp/R1wDLNLWd3nhI3eeY7ysPSNfrIW0yIP+CshkCAK?=
 =?iso-8859-1?Q?tm1l9ZETPy5p/Dw3RGoJcv4ZoF3f+qFNhvdsvBtJWPGSpy4pyDNYzJM8jy?=
 =?iso-8859-1?Q?GhgsxZHFMYZCvJenPj9orXKq2qaYUhhDpO5uARBgQBplFoi8oLMccZeHI6?=
 =?iso-8859-1?Q?lB8hui467AM8nAeakSWvWyAEFePz6CjCIrOe9XkISeefoIg0edcCEkoS75?=
 =?iso-8859-1?Q?QWALD+DXeXvPgwaBvhHtP+GpVZTmbKCJEiQmV998R0Gqlx38f2sySBmsjU?=
 =?iso-8859-1?Q?rMMOND4FVmwOb+4P1c1eT4ExsEbW/jzgaVMQn6JU5uIeslNWbj0sC6AA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f80e7b-eb92-48ea-abc5-08dd2428465b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 14:35:55.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWN4cfETa6E8ocF88+bpZwDJWUA9x1U5423qM9m22iqDDZDWCrzJ36qzR/JKe3XAQ7XYljOzhVDYGH7r1XqMQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 56.0% regression of fsmark.app_overhead on:
(but no obvious diff for fsmark.files_per_sec)

commit: 48ff66155e25a3db70cb44b340e1e990349825b8 ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git delstid

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-12
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


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.app_overhead 35.9% regression                                                   |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1SSD                                                                                      |
|                  | filesize=16MB                                                                                  |
|                  | fs2=nfsv4                                                                                      |
|                  | fs=ext4                                                                                        |
|                  | iterations=1x                                                                                  |
|                  | nr_directories=16d                                                                             |
|                  | nr_files_per_directory=256fpd                                                                  |
|                  | nr_threads=32t                                                                                 |
|                  | sync_method=fsyncBeforeClose                                                                   |
|                  | test_size=20G                                                                                  |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412242245.dbf6ea4b-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241224/202412242245.dbf6ea4b-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-9.4/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark

commit: 
  1436c81cbe ("nfsd: handle delegated timestamps in SETATTR")
  48ff66155e ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")

1436c81cbe9bef84 48ff66155e25a3db70cb44b340e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2837 ± 10%     +21.1%       3436 ±  9%  numa-meminfo.node1.PageTables
    709.56 ± 10%     +21.1%     859.52 ±  9%  numa-vmstat.node1.nr_page_table_pages
   1551575           +17.7%    1826031 ± 28%  proc-vmstat.pgfault
     33.29            +2.9%      34.26        boot-time.boot
     24.88            +2.0%      25.38        boot-time.dhcp
   3081774           +56.0%    4807945        fsmark.app_overhead
     18.53            +0.2%      18.57        fsmark.files_per_sec
     53434           -17.3%      44176        fsmark.time.voluntary_context_switches
      2827           -11.7%       2496 ± 10%  perf-stat.i.context-switches
      2822           -11.7%       2492 ± 10%  perf-stat.ps.context-switches
      2882           -12.0%       2537 ± 11%  vmstat.system.cs
      4080           -10.7%       3643 ± 13%  vmstat.system.in
      5.82 ±  4%      -0.5        5.30 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      6.83 ±  4%      -0.5        6.33 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.67 ± 10%      -0.4        1.28 ± 11%  perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread.kthread
      1.67 ± 10%      -0.4        1.28 ± 11%  perf-profile.calltrace.cycles-pp.rpc_async_schedule.process_one_work.worker_thread.kthread.ret_from_fork
      0.64 ±  4%      -0.4        0.28 ±100%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu
      1.16 ±  8%      -0.3        0.88 ± 18%  perf-profile.calltrace.cycles-pp.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.95 ±  9%      -0.2        0.70 ± 20%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.96 ±  9%      +0.1        1.09 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ±  9%      +0.2        1.09 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±  8%      +0.2        0.96 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.79 ±  8%      +0.2        0.96 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__vfork
      0.78 ±  6%      +0.2        0.95 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.92 ± 24%      -0.7        1.20 ± 32%  perf-profile.children.cycles-pp.do_softirq
      7.32 ±  5%      -0.5        6.82 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.85 ± 14%      -0.5        1.35 ± 18%  perf-profile.children.cycles-pp.ip6_xmit
      1.92 ± 12%      -0.5        1.44 ± 14%  perf-profile.children.cycles-pp.inet6_csk_xmit
      1.75 ± 14%      -0.5        1.28 ± 20%  perf-profile.children.cycles-pp.ip6_finish_output2
      2.64 ±  4%      -0.5        2.18        perf-profile.children.cycles-pp.__rpc_execute
      1.45 ± 12%      -0.4        1.00 ± 19%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      1.58 ± 14%      -0.4        1.16 ±  4%  perf-profile.children.cycles-pp.xprt_request_transmit
      1.59 ± 14%      -0.4        1.16 ±  4%  perf-profile.children.cycles-pp.xprt_transmit
      1.30 ± 15%      -0.4        0.88 ± 16%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      1.33 ± 14%      -0.4        0.92 ± 13%  perf-profile.children.cycles-pp.__napi_poll
      1.50 ± 11%      -0.4        1.09 ± 14%  perf-profile.children.cycles-pp.net_rx_action
      1.32 ± 14%      -0.4        0.92 ± 13%  perf-profile.children.cycles-pp.process_backlog
      1.19 ± 14%      -0.4        0.79 ± 13%  perf-profile.children.cycles-pp.ip6_input_finish
      1.18 ± 14%      -0.4        0.78 ± 13%  perf-profile.children.cycles-pp.ip6_protocol_deliver_rcu
      1.59 ± 13%      -0.4        1.20 ±  5%  perf-profile.children.cycles-pp.call_transmit
      1.54 ± 14%      -0.4        1.15 ±  4%  perf-profile.children.cycles-pp.xs_tcp_send_request
      1.67 ± 10%      -0.4        1.28 ± 11%  perf-profile.children.cycles-pp.rpc_async_schedule
      1.10 ± 15%      -0.4        0.74 ± 14%  perf-profile.children.cycles-pp.tcp_v6_rcv
      0.86 ± 22%      -0.3        0.54 ± 12%  perf-profile.children.cycles-pp.tcp_v6_do_rcv
      0.81 ± 26%      -0.3        0.52 ± 10%  perf-profile.children.cycles-pp.tcp_rcv_established
      0.42 ± 19%      -0.2        0.24 ± 17%  perf-profile.children.cycles-pp.___perf_sw_event
      0.20 ± 35%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.__put_nfs_open_context
      0.34 ± 12%      -0.1        0.23 ± 22%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.35 ± 10%      -0.1        0.24 ± 18%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.05 ± 76%      +0.1        0.13        perf-profile.children.cycles-pp.ct_nmi_enter
      0.12 ± 36%      +0.1        0.21 ± 28%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.78 ±  6%      +0.2        0.95 ± 13%  perf-profile.children.cycles-pp.__x64_sys_vfork
      1.08 ± 16%      +0.2        1.32 ± 10%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.09 ± 15%      +0.2        1.34 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      1.26 ± 12%      +0.3        1.53 ±  7%  perf-profile.children.cycles-pp.kernel_clone
      2.33 ±  8%      +0.3        2.66 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      2.30 ±  7%      +0.3        2.64 ±  7%  perf-profile.children.cycles-pp.path_openat
      0.30 ± 28%      -0.1        0.16 ± 46%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.12 ± 32%      +0.1        0.20 ± 26%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.05 ± 76%      +0.1        0.13        perf-profile.self.cycles-pp.ct_nmi_enter
      0.36 ± 33%      +0.2        0.54 ± 27%  perf-profile.self.cycles-pp.next_uptodate_folio


***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/16MB/nfsv4/ext4/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/20G/fsmark

commit: 
  1436c81cbe ("nfsd: handle delegated timestamps in SETATTR")
  48ff66155e ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")

1436c81cbe9bef84 48ff66155e25a3db70cb44b340e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.472e+08 ±  4%     +35.9%  3.361e+08 ±  4%  fsmark.app_overhead
     16.00            +0.0%      16.00        fsmark.files_per_sec
     65306 ±121%    +168.8%     175532 ±  4%  numa-meminfo.node1.AnonHugePages
    449.72 ±  8%     +24.4%     559.64 ± 16%  sched_debug.cpu.curr->pid.avg
      0.02 ± 37%     -75.3%       0.00 ±101%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.61 ± 47%     -69.2%       0.19 ± 52%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.57 ± 35%      -1.6        1.98 ± 24%  perf-profile.calltrace.cycles-pp.read
      3.35 ± 38%      -1.4        1.98 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.35 ± 38%      -1.4        1.98 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.10 ± 72%      +2.0        3.11 ± 14%  perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.37 ± 83%      +2.3        3.66 ± 38%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.57 ± 35%      -1.6        1.98 ± 24%  perf-profile.children.cycles-pp.read
      1.90 ± 60%      +2.4        4.28 ± 15%  perf-profile.children.cycles-pp.__mmap_region
      1.37 ± 83%      +2.5        3.92 ± 35%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.17 ± 57%      +2.7        4.84 ± 34%  perf-profile.children.cycles-pp.do_mmap
      2.17 ± 57%      +2.9        5.08 ± 33%  perf-profile.children.cycles-pp.vm_mmap_pgoff





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


