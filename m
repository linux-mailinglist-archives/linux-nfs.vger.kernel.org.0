Return-Path: <linux-nfs+bounces-7521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA79B28AC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 08:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CFE1F21393
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144918FDC9;
	Mon, 28 Oct 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYFRZtCv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F2154444;
	Mon, 28 Oct 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100256; cv=fail; b=U0sCu9Ox1+kFrRQ5ZIEwIYSAVmzgDXa9tyKuHcL9nltCYkHrK1rXVN2Z/BTjF8gbiFe2qUNomnMdY4mHhvdhzEl0gQbvTUOETEFDWZ/qmGmny0rqKH8Luqso5xplN1k5ejPbjbgyOUYZM+ea8uGKxQhqBb70nFVjcL+dEZm5Lk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100256; c=relaxed/simple;
	bh=H4Xxig7yE+OjB4dj6UIKeC8nI9JQ7uK1P+UrOt2nwvo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SDRuV/lZk1PoENR9a0HqUFKafWgtXZJ/pdKUMBwOFQ7fJyr3AkveUAtCJEZYrEa1UP7dXlNs3Rw0EAS8yWt+4eBZf377Ec+l+BQ8wQK7tl+bMlSc/EFtcQTIde+OZhxZPB/YPQ2lFBtaLA21za3yYaKXXuAbn7pRr1lyneGfZ6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYFRZtCv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730100254; x=1761636254;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=H4Xxig7yE+OjB4dj6UIKeC8nI9JQ7uK1P+UrOt2nwvo=;
  b=MYFRZtCv2GqhsMcLcDgTubUIBrXJCBWMEyzZqdO5CLZK2CXMMv0XEIWR
   B+COQFmeNSOSNu+QOY5EOGOMLwGXqZguyCUMT6W0X2HRwmSHAxOG1hz7X
   bLWxPIm9058DnaLvXhj+XFYT/YZTgUGLiCoCzpU+IWo68N2KaQzzzKh8N
   KfzwFE0ZOu3wzmZQBoxkkTn1lNddE/D3D31iTmpGEKMjHlvmj0OOtBxnN
   YsrNi1wklFgMPlbFE4KqKswJwCyZn2U7renm//iDZtiPC+GJvgw+tAOFV
   gjuqsdcMhDXJ1j+brqP8Ky3rGVKQHFIarWbrS9Ez/0NspG5DT0L1Q+KZT
   w==;
X-CSE-ConnectionGUID: huR6cUC2TvOT4fQ0jCoLKg==
X-CSE-MsgGUID: jnOmgThdTl+TlcLGxObANw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40307837"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40307837"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:24:13 -0700
X-CSE-ConnectionGUID: wQvBaIEBQwqo7kzXYnY11w==
X-CSE-MsgGUID: KlaZMbVGRlSNsoJFjJNfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86675614"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 00:24:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 00:24:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 00:24:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 00:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3nKFNDgUF+tFcZZqi7Kd0HfvPPCPZEFXknO7CalBLK+ot8lt09cjVmD990eGbimp2KDoMEy9L/OPG7SWNs+81BR8Y0cjpRQsYYtdSBLRfdmeTHbgsaM+tq7gu+fmDcF389KKn2W8o5eiT57IKOt5NCMXZflR+nZNsxkgrOuI260DOvCvqfd4FZvB4FEKxyPwKnJt26IgUCdrkc7dQ9OjRAuWP5PG8eTR6DLvmJRGr/uNgEOv43WP6BmjoB/yqxZACpEAq7tB3X6CXqvjHfMtgzW7meuv4zXpQcxEsTtxuzMcCGD+XtzqX99Hz/Ci/+kgMQ/tWbQQlqxMZGK7OvxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7AFd5EVXzR5ek8qSoXmHwTmHzrbtNhmc3m8PgefZkw=;
 b=ytF5BTdc56UA4w4fJuoY3hKJqTqPh70mPTlEmPPSRNYJoQsWXUtmkE4xlOJGT4ZG09+aeXI0nFBfcClKyW+5vU1IRK1MSuw5wlvO+qo42fx5TONx7C2da6yrGONGK22QZMik4COIA4x78sW3yJNte3FfbhpdKSDQI9A2HvK3rnHJj/oOSIDxe2/pkxXg+jaJSFv4yKjcyB3mJlmDmmPIgl9wXTJ4VD1ed8pcDlT5Ar3qQNPI0stLVl3TJeqhM44or2ObndVDbMCC0VnnT5czpi/N+ko9r9V/+uGiB53G+xLIDS/pVOt2Ji6/IdWZcMDSzO+qKUKtM7x+fgQVQ6FrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 07:24:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 07:24:10 +0000
Date: Mon, 28 Oct 2024 15:23:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Olga Kornievskaia
	<aglo@umich.edu>, <linux-nfs@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Chuck Lever
	<chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, <linux-kernel@vger.kernel.org>, Jeff Layton
	<jlayton@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/3] nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to
 writeable attrs
Message-ID: <202410281526.4971befc-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018-delstid-v1-1-c6021b75ff3e@kernel.org>
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b2d95c-7fbd-4a0e-e114-08dcf72183c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?VlzSmeXEvbofuMd6ahwwUmmO1dU8w37NUNYkSS+Fhqq3eaF9jYxXbVxwe3?=
 =?iso-8859-1?Q?u0hTo0+UNRjfNrykxslz3CiQ9U5wJLJAHUFmPVvopv+fGNdLHdWTtbfagi?=
 =?iso-8859-1?Q?KAeddlz1CYw6GeXgvLlrbJVUXXtKa36IIEGSdtmRnqMsE/BwlF4K2zS40c?=
 =?iso-8859-1?Q?EIHM7qChJlYjopXu6ECjQ0u4vlTFaHeL7v6yUSQebfeX+4Khatca2HyTsZ?=
 =?iso-8859-1?Q?ODQLgXLbaeGysIAhW7+rJ1zTo437uKow0/s1dlpDWj2/BI0gKz3flbG0un?=
 =?iso-8859-1?Q?vgGgff37QbgAHRcqKXeEKp0q5M6tZHTHkFQCfyLxHxGE5mtEVEq+PKxzcy?=
 =?iso-8859-1?Q?NQlSfMhiO88ZXVY26mhPwhurtLeT/hN7AHs+bovyU3l3JOgLmfTAAhSpC5?=
 =?iso-8859-1?Q?FKNcmuxE8NRLKf6TFiILkUJgxCik9Vc5DYC5ExfqiIrYVBshlQW2FHS0Gu?=
 =?iso-8859-1?Q?i44TBpXBUbx2+aANXZyJT2zDkLRputQBrTz/xopGXW+ODUF0aKZsvOssE1?=
 =?iso-8859-1?Q?pOFP4t3UBEzFZ2ZsqXCJ5XTKr5iqcz28fqeCbv3TOuvjw2wRufhyqHx/ci?=
 =?iso-8859-1?Q?ggSNtZ/GgI/gibajKSxiVdsSrVeyxJ8nwtB+Y2vQiCLanQj/jKvFAJXN8+?=
 =?iso-8859-1?Q?Ac084I1eN/zUK0380UTAJ9jqH/OIdSWvB36H1QWzDw63fws7AfW+FIz0U5?=
 =?iso-8859-1?Q?N/PPwzdPDLr0iIaazi7Vc79+s0QwKZITFNdL6Pdi2pNPR1/Xxe2xBN1rng?=
 =?iso-8859-1?Q?syANaOa99NTW2WLYWDFjmU6d+NJIDz+6vKzeNsuj4dKwsyGM6Pu6TNBbSh?=
 =?iso-8859-1?Q?tOp7PzPU7Rf+KH3V7MmxMluDuVDo+pppWMFu8hQojQb3Tvo4uNQw0rdfJ6?=
 =?iso-8859-1?Q?DvZaps1JHoeXUvkYfAEcOISJdt5GzmZr7L7dhcMDil2Pw6DJuAR9WFexQ6?=
 =?iso-8859-1?Q?Qwx186HFTOen7012MlafT4m/BSKZav1s9lqhXNFwynC3RrLc0sH8jeXT7c?=
 =?iso-8859-1?Q?14NqGQgJBdiCqZS22Iio+8XU3I4X9Uct2iAhQ21H/7lO3lqujYJQ7eFC7V?=
 =?iso-8859-1?Q?E1hwi7IwAnIIpsuueKoTkV161MP1bDoUtWxwseDhKsreVVE6g0b1lgjP1y?=
 =?iso-8859-1?Q?QlVTzAphu2Vtfna4hLqMgGQL9OS5KN+xnhfEN1qNA267weRMMr/AF0JCHx?=
 =?iso-8859-1?Q?2mCvH2/0qbusYRrPS6HAhe/S9Q3RJpfjDFRof1etZyZX910MNXE/oUZW3u?=
 =?iso-8859-1?Q?TQU96FJ8TsvS+1/8+ebH0oBWcwAgyqkh54u6YE1aoVE179es6yXF5OUnd0?=
 =?iso-8859-1?Q?aAQiGZsPBZYIcVKYRwXHK5iU+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yRdcNigwxisa0Tf2icy0V/Xp9bBiXhyXUifdL9vnmU11hgMK6+CaJ2rlKI?=
 =?iso-8859-1?Q?yw5p1nhS2tAf2Ep2TIn5JXy7xjvV3PHv9eXkBJGt6CY9WxK9rv0KrMVN3Z?=
 =?iso-8859-1?Q?hZCEXQsuZZJPEgne232zXUOaOJsGioDWXsmljVQ8jMOIGlDVO2JGqd49dn?=
 =?iso-8859-1?Q?HBrN1vUf26Bev/ymd6SaAmQcnvTGXWDWIdKQVa/RRSd7K1G1j/1rDhJ9er?=
 =?iso-8859-1?Q?4nPu4qcnIO4gMODpNs034jKv/qKivfbVDzwS8VwAokE7Jj59orCVsfe7EO?=
 =?iso-8859-1?Q?2n+VA28+gc5bjEiJs2bWBILpV3DtX2Yj6VorHQm/Psfo66J6KB6OkgJnbV?=
 =?iso-8859-1?Q?pSd+nx0jFnTGfdM74fhZ/FNkBlR1LJDP54cM/KF9nyAmfv7E8Dy1C5ohCV?=
 =?iso-8859-1?Q?UMTDe6PbTDDnPs9vF4v23z4LH9y9KtxBpqeMHNJQcuCoZ08lAKUbGv5vRU?=
 =?iso-8859-1?Q?g4+AhLY6tKPdh1x6sqO/8786rjMlntcFpWrO8arFrcsbYEPZzfQpR0deZC?=
 =?iso-8859-1?Q?Kr34KwGSPHT2N7CM9uGW8+EylkhhGFWpMJtKD9BIFmdOU4cMKTbOSwiM73?=
 =?iso-8859-1?Q?SCQX8ZrWfUO8HchicHylT/Af3tIa1E8UrK9Hjlrg/nawnMAwPpqF+D2lv4?=
 =?iso-8859-1?Q?PocJ2LYpD0DxFcMkb2nN60Sm8ogCxKRVGD4nRj/MT29dLmsdNGRwhdH0n9?=
 =?iso-8859-1?Q?Vf1hYKXY3LCtB2eJpfqPE047YdhLHAbi+/iR11iPlgqZntKqdYvVdKizSt?=
 =?iso-8859-1?Q?8IJXWI2lBm+jZfkQdKv2vpVPCMxo1ce/NKUSDi/wd6FGzUUWPGZ7etYJCq?=
 =?iso-8859-1?Q?Mp0XYleURGUb2DimxaPMhOXkr8AqVgSuo+OfPa/3RXHHK9Pqs5QdlyUjrY?=
 =?iso-8859-1?Q?z59bFpRgBR7XTWrXVNXsk27vFPTETNDnK5saci51EfKw5ZkaDFJ3DlnEro?=
 =?iso-8859-1?Q?As6dQ6jtxMrZQIfRigMgKceJJFjJgLCeAAlGQKbeC4sx7frXY+ubRCvdit?=
 =?iso-8859-1?Q?ab9KFw8eRYpUjsSsMfd9KU0JvBOkIGccxYSsINHgvJADqpPfRBINDfyN2D?=
 =?iso-8859-1?Q?W0LtgaUSHnAvV5J4QXldWZgOU6uthMWW0v6pDWR1MziBGjbjH+GlCBFs5/?=
 =?iso-8859-1?Q?tV9/R3taEu6ntBfclBrp4unDbrjl/jOByp5WwHxBgc1QB9SyvSy7WGvfCW?=
 =?iso-8859-1?Q?qvxJeyVLEWZZ1yHrukX1FbMS3QsCi7HaXDHLzJ6JI1Joo1wxcWg2KocnE7?=
 =?iso-8859-1?Q?3c5ASctXLZP+KHyyiHgmMaE2V6EAN5SxBbAyRYy5kNaQIqHrhvFHvIIKoY?=
 =?iso-8859-1?Q?yztLO55r/em3Nv31crVyqrsYLnC6GHPmnZ+uNGccDBs4aqORU7gphjleYg?=
 =?iso-8859-1?Q?TqaG/rqdaniv7+ozbpab6givYLcTkJatq7PdfKZPGwpuHNkhP42hKIyCfL?=
 =?iso-8859-1?Q?9+vkKzrDQQg4CK9aeEjjA+PFE1e7Lt8ygsI5rn8nO7RubENbRT6Vs5xZUT?=
 =?iso-8859-1?Q?cDndCviToWlUZEOTFLo4RMHHv1C9ssLtZL9y80dcn00tCmWRMVV3APhIGp?=
 =?iso-8859-1?Q?koccYxR45st5EBT2qHOF4H+I1gqT9fGtp0ep21RTvdsXYvFkcQ/X/nnNYa?=
 =?iso-8859-1?Q?P2HaHavGBJSCm703Gs24AxFUKz0lf+TfuGPRPCfXTekLJdwfmjI5Z1ig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2d95c-7fbd-4a0e-e114-08dcf72183c0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:24:09.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5+Cuo0Vu8XaRgiACYbxMvqYBiTx6jcl/xRt3idGnteB5njJVZxSEI3W7xXNXCf1AG8O89Be998YicC5RqgOGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 15.4% regression of filebench.sum_operations/s on:


commit: 7334c4df7a384b31f30a61adb60243a8614f8ff0 ("[PATCH 1/3] nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to writeable attrs")
url: https://github.com/intel-lab-lkp/linux/commits/Jeff-Layton/nfsd-add-TIME_DELEG_ACCESS-and-TIME_DELEG_MODIFY-to-writeable-attrs/20241019-024741
patch link: https://lore.kernel.org/all/20241018-delstid-v1-1-c6021b75ff3e@kernel.org/
patch subject: [PATCH 1/3] nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to writeable attrs

testcase: filebench
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: nfsv4
	test: webproxy.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410281526.4971befc-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241028/202410281526.4971befc-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webproxy.f/filebench

commit: 
  0f8b1a4184 ("lockd: Remove unneeded initialization of file_lock::c.flc_flags")
  7334c4df7a ("nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to writeable attrs")

0f8b1a41842544ec 7334c4df7a384b31f30a61adb60 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.19 ±181%     -83.9%       0.19 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2514 ± 95%     -88.8%     280.49 ±168%  sched_debug.cpu.max_idle_balance_cost.stddev
      2152            -3.4%       2080        vmstat.system.cs
      2189            +7.3%       2349        vmstat.system.in
     25682 ± 41%     +59.9%      41078 ±  4%  numa-meminfo.node0.Shmem
     20709 ± 91%     -82.5%       3615 ±111%  numa-meminfo.node1.Mapped
     46372 ± 22%     -29.8%      32541 ±  5%  numa-meminfo.node1.Shmem
      6419 ± 41%     +60.0%      10272 ±  4%  numa-vmstat.node0.nr_shmem
      5241 ± 90%     -81.1%     988.55 ±104%  numa-vmstat.node1.nr_mapped
     11592 ± 22%     -29.8%       8135 ±  5%  numa-vmstat.node1.nr_shmem
      0.70           -14.3%       0.60        filebench.sum_bytes_mb/s
      9121           -15.4%       7720        filebench.sum_operations
    152.01           -15.4%     128.66        filebench.sum_operations/s
     39.67           -16.0%      33.33        filebench.sum_reads/s
    620.37           +19.7%     742.65        filebench.sum_time_ms/op
      8.00           -12.5%       7.00        filebench.sum_writes/s
      1370            +6.3%       1456        filebench.time.elapsed_time
      1370            +6.3%       1456        filebench.time.elapsed_time.max
     42175            -2.1%      41280        filebench.time.voluntary_context_switches
  31030536            -1.2%   30643382        perf-stat.i.branch-instructions
      4.86            +0.1        4.96        perf-stat.i.branch-miss-rate%
   7534035            +4.1%    7839877        perf-stat.i.cache-references
      2139            -3.4%       2067        perf-stat.i.context-switches
 1.509e+08            -1.2%  1.491e+08        perf-stat.i.instructions
      1.33            +1.1%       1.35        perf-stat.overall.cpi
  30980974            -1.2%   30597842        perf-stat.ps.branch-instructions
   7527450            +4.1%    7833510        perf-stat.ps.cache-references
      2137            -3.3%       2066        perf-stat.ps.context-switches
 1.507e+08            -1.2%  1.489e+08        perf-stat.ps.instructions
 2.069e+11            +4.9%  2.171e+11        perf-stat.total.instructions
     27282 ±  2%      +8.6%      29623        proc-vmstat.nr_active_file
     79891            +2.6%      81962        proc-vmstat.nr_dirtied
     18010            +2.2%      18405        proc-vmstat.nr_shmem
     79856            +2.6%      81922        proc-vmstat.nr_written
     27282 ±  2%      +8.6%      29623        proc-vmstat.nr_zone_active_file
   2853705            +4.5%    2982082        proc-vmstat.numa_hit
   2721089            +4.7%    2849533        proc-vmstat.numa_local
   3437788            +3.8%    3567439        proc-vmstat.pgalloc_normal
   3344808            +5.8%    3540131        proc-vmstat.pgfault
   3343237            +3.7%    3466101        proc-vmstat.pgfree
    923426            +4.7%     966532        proc-vmstat.pgpgout
    156450            +5.7%     165442        proc-vmstat.pgreuse
      3.55 ±  7%      -0.6        2.96 ±  8%  perf-profile.children.cycles-pp.sched_balance_rq
      3.10 ±  9%      -0.5        2.64 ±  5%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.67 ± 34%      -0.4        0.26 ± 46%  perf-profile.children.cycles-pp.__wake_up_common
      1.20 ± 11%      -0.4        0.82 ±  9%  perf-profile.children.cycles-pp.copy_process
      0.57 ± 22%      -0.3        0.30 ± 21%  perf-profile.children.cycles-pp.dup_mm
      0.65 ± 28%      -0.2        0.41 ± 38%  perf-profile.children.cycles-pp.free_pgtables
      0.02 ±141%      +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.rpc_run_task
      0.02 ±223%      +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.security_cred_free
      0.02 ±141%      +0.1        0.16 ± 50%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.07 ± 93%      +0.2        0.23 ± 25%  perf-profile.children.cycles-pp.__evlist__disable
      0.34 ± 29%      +0.2        0.51 ± 13%  perf-profile.children.cycles-pp.ct_kernel_enter
      5.00 ±  9%      +0.7        5.73 ±  8%  perf-profile.children.cycles-pp.__irq_exit_rcu
      1.90 ±  8%      -0.3        1.61 ± 10%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.02 ±141%      +0.1        0.10 ± 46%  perf-profile.self.cycles-pp.__pte_offset_map
      0.22 ± 36%      +0.1        0.36 ± 19%  perf-profile.self.cycles-pp.ct_kernel_enter




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


