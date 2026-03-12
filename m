Return-Path: <linux-nfs+bounces-20113-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E9pK/U5s2ntSwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20113-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:11:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C827ADC2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 220BE30EDBFC
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B23876CA;
	Thu, 12 Mar 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbVZDVx2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98935AC1E
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352887; cv=fail; b=bhcK7Y7my45XGCBN4uPdGmJ9TRbqr2azKPf/84dFP/Cn+zCjFaztSAht9MyOGbbaJUj1n/e6noj///Xi9M6qmbdBW1Yef92cDB8Ry2gbM8LNcLv8a7stxX/VoK6YxHkHlNpT+KL/fvt8mfCZJmF3KnL5Fy/YE4q/JkEPKmdCxzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352887; c=relaxed/simple;
	bh=tbRL2q0HCBzzfRPWucDv+9oWijyCLAENrQSW1gV0YfM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ovXFzqvZz9hN845dFaxtarbQa2yIj6FHsYSwNBnwq/lt5Mlbz7VFpHT7YDPhYb51DQV/mhIdB5KsffbB4+hDCJnRLRHKhBEIaewswIphqyJ/818Sa4RP61f2Zu9jvT5VJ3lPtobI1vL1Um4+HUr8JhaayoREQ7QpLtUdZPX4mZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbVZDVx2; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773352884; x=1804888884;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tbRL2q0HCBzzfRPWucDv+9oWijyCLAENrQSW1gV0YfM=;
  b=UbVZDVx2bQZ5F3q2HcQ7ARxSZmV2jOMYyHvFUYfadG44eAVncto/PFP/
   kBgZR3H1sWkAHZgWfkfbM2g32ITRdE78pVRlaor7Bx0lOnxExRcZQ/7Sx
   HtWBRnpjq2qF73a61BCJ+HKB9kompE4B/gyJe5yp9MtftbAVvzOMBC1e+
   3RwXNv3vooROZ+8hoJoDYTQG8/tjLiTjUV2EN3kV5aicz59rbEE8PTyti
   +LwownoKIFe/JfWRNcA3vzgKuPhdRnCjirS8DSopmU3tBSPlzu1p3ViWw
   ISo6IGzT0J7H8Yq5Xpfe/PMf2YQEWRp5Kdxnx6lSU1qRJld71eWP4ihNK
   Q==;
X-CSE-ConnectionGUID: GIsotd7iQK2VrIXWr0kryw==
X-CSE-MsgGUID: gs+9OhOYTnGfw/Uot0XapQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74352773"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="74352773"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 15:01:22 -0700
X-CSE-ConnectionGUID: 6r51hUZJRHu9MrZQj352CA==
X-CSE-MsgGUID: QDFRYjoxSEyhYYdVNCB0Jw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 15:01:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 15:01:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 15:01:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 15:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iri+xd91SeQ+3oxxkNt5SEUJnUag2fJ2Gat4Hk1yUK3D4CzigxWuqBpUmKZH7JcpJViuYf3pqv2hP8VQM9xAEw2Y/jAhOwu21ZD9ldgdgV115Q3Y1/9Vp7eC85HxGQVciK+hnKtbdOAcd70QYVIf2xlNG4o9ld0t9euFhs64Jirj4+kam412EeUQMvYpcivrNrAS6xoZzZgqeX6NK0TUsbfSJy68wqagPjyysyxIOhqgVNFGQkD2Q/vygrklq6LxhejXaihG1rkxwqqHaXer70gRgG+2VXNetcUBxx+5F21rpKwkmVd3TJYXdNtAFB8q6DqFeaZcZsRL3JyqzZ5Maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/UmtMu42mTd3rhtew2csa3QvvLaneikpYASW/HXsx0=;
 b=SOkzQuyn3TjnN8Ywl3tXcDFrpRXKKj3vKt1yWeWNUNS2oq+1FSnoKb9x1X4E+Hzp77+qAZ6BBx4pU6spdB1GpgyClupxR2ERuTy4fFE36ULlRajIjAX7VG/y42JD5wyfOuGpm/+olpkIY+s7+q7T2rR+1LqU5WtBIcvKduhoVBqh2lkaubsMU+sA18dui9GQOnXIn2mot8MLJ9HelGUmqeQ97o1Qq7s0LwtChEcKbxs9xk8HunFazHlsK9LddNJYVfTOl8NoWJSDUEkL0vptzIPiReVaQit93ETWTeWWlkVfwjXgxnvs4klq8hjsME47Nh/7smnfaKloV2pEI7c1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7422.namprd11.prod.outlook.com (2603:10b6:510:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 22:01:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 22:01:17 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2026 15:01:16 -0700
To: Anna Schumaker <anna@kernel.org>, <linux-nfs@vger.kernel.org>,
	<trond.myklebust@hammerspace.com>
CC: <anna@kernel.org>
Message-ID: <69b337ac4589_2132100e7@dwillia2-mobl4.notmuch>
In-Reply-To: <20260227204231.769675-1-anna@kernel.org>
References: <20260227204231.769675-1-anna@kernel.org>
Subject: Re: [PATCH] NFS: Fix NFS KConfig typos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: f81562d6-d30a-4073-f91c-08de8082e2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KvRHJ05unxMNQsAd6IkTovRSWZgosB8ZF83AHZZWbNHa3emH4tyLJg0O75mnb4h0ezjhtd7DefSRy5lmd1E6sHmwqghTMfY1vwbLZS2WP9zQk12ro2CqKNdF1wYAPaM9ST1Lb/mholZ3rTEEzraOMyNLuaSCH7UuNvJbSi4M68+EJbzVyuO37BcvLVBRrYc0fQBEbescGsbJhRF6eyEoZFH3r+tDa8UfauOh24SpsyyFNz+sXGuT+OJFXk7RD90xUV7zy8DV6s6KbKJEPrN1X/XWr44m/0loO7FpoR7uvY3SqxJaZCGPQmyodZ3ZcHay29FQzIfFH+FKYRbXB4rtJc86bKY1gsnXI7ROVWWMk2YvyRtirL/lxq2S8VzxuKyPoEcw5GuoJRcjVLTn3rzqol3ZGBB3A4yLgwYjDoWSHa5bTCw/HkJ2k8vybG/2z3c9lCB8oVTyJbDDuMoBFMUX1M9uC9CPmjfEPcBVHajiIw2xXvSax9bI141tQCqg7WZAOWg0SNisheD5H37A7KLtqgDELAfIRIv7A8/p27nRDp0kPOMs5cTdTpscUiZF3MDDSNy94+SV4aT/y+nu0OW6w+ycWaonoLzyNPNiF2wASMfU43l51ib8jWa537rUy4J7yF2/Bw1uH9DDpCeLxLkNv4ZBcX4FyD8JLkSGaIkEyxzw+NnSXsma6zu0RjHZLCgAilG6LKOB0Z4Jh1zRwLNliXz2fvVhmEVWJiMdJp+thrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZwcjlqb3FwTXAxckdDeGZqcFpuRWlXNi9BWkNpcC9sSlJqSDQvRUVyWUFk?=
 =?utf-8?B?MGN5QUR2cmtzTjE3ZTR3SnJzMWJIQVl5aHRMNjBvM2F3K29oaVpEUFlDSlZ2?=
 =?utf-8?B?aGJ2YUpmZ09OL1lJdWxTaVF0UjIwcDY3NEZOYitjYU1hdUI3N0xtanhkVTFl?=
 =?utf-8?B?dVp3NVdOWXhlNFliRUJjbVdMM0l2R2h6WHJmVGVSSWRlWmJZbjVSbVRYTzlX?=
 =?utf-8?B?VURJN1doTDBRdkh5a1MrTHJpT2h2dHNkSlZid3QrVi94NGMzUmRpRkhyU1Nk?=
 =?utf-8?B?anh3ZEhicGNtQVl5MmdsS2UrNnYzSjA4VmdSTVVsR2lrdXlodVk0OS9hWE9Y?=
 =?utf-8?B?ZEJSS1c3QWtWdjlZUVZSM21zTnNIYXdvMmpTZjhnd2JZVkMzaGFsNjNscmZK?=
 =?utf-8?B?N2FMTFZxalJpQjkrYnQ3S2t1N1RoZ2FZTXp1ekNTY3hERG4xUnQ3dENMQVVG?=
 =?utf-8?B?Mkg4N2h5dThXUDFQRFY2aGpwRnE1RFJndTlmb2YyVkNtSU51ZldMeFBFWFd1?=
 =?utf-8?B?T2pROSt0MTFaK1dJQjRBK09wSmVHRkRld1luelRVRTNQM1ZqWnlXc0JsZ0NO?=
 =?utf-8?B?Wi9qZ0tvNnZSWVkwZVdCSVpmaTQ5Uk0wZzZMRWhXdjJUQ1d3S0xUa3FTS2FN?=
 =?utf-8?B?MGJpdHhscWFSdnIwdVJaOFJnakdSQ0FrRWNJd1p5VituQVFpaVRyc0tTeTNk?=
 =?utf-8?B?dkdTWkg2aGtPMStWRGRZQmxURUxYNzA3NU03SVV3NktaVU1hWjlVZy9YcHJD?=
 =?utf-8?B?RjJJZkRYMFVXaVZDcVI0K0ZjSDhTT210UTRRaXMvcE53ZzFoVXdvc0J1TFBZ?=
 =?utf-8?B?TUpUa1ZHenk4aHlHdU9hVSs2WFMxNnVFZXlsVXZoSWtZWnFMbTRCSVlZb0lK?=
 =?utf-8?B?TWVtSmJvSzM3dFBBUnlXRjJSaUVvb2toRUlPaEI0RDlxY1BsdDB4ZFJqUFFT?=
 =?utf-8?B?UVpGam9wb0tUMVhrZGFWcW5ZT0dJMjRyK0JCMjlFSGJ2QitnbGxDUjFaRlRJ?=
 =?utf-8?B?clZ1blJFSGRKMU9pd1lSMG43SkplSEhlY29kTW91OE5wRnRrbzVNdFd1cDc1?=
 =?utf-8?B?SHorZ0h5WVZYNGs2Y05VNmdUMk9MQThtY1NJcTI3Ly82VTRKMCtmWnIzYXQ5?=
 =?utf-8?B?SWNsdFVLMlM2dHRBZ0Q1VTlqUmhLbWo0M29rSWc1TnBVMjlqckdaMkV5UTJt?=
 =?utf-8?B?ays4LzJreG8wcTdtMGNIMEtRdVZYQmdqaldOT0p2RDdrQ3ZJOEUwa2dRN29y?=
 =?utf-8?B?YU1iL3V6b3dOaFlHMVlKVk5kYit1ci9iekVTMXFlZzI0cjJzV2s3SHJvMVdt?=
 =?utf-8?B?bkZjNm9JUlBOcGNhV3pvMmNEMVhjOFB2K1czMDAyKzA3V08wV2I5cWRqV3RB?=
 =?utf-8?B?RklhTE80a3hvOHNBZnRKZHBDaG9ZY3FORE9qMytqamtCV1ZQc1cvaDdWdGhx?=
 =?utf-8?B?T3J1ZUNEUzVJOVJUMUxxcWdxQkF6V0NKVURlZU9rQkJiQjZ6ckdNOTkzenh4?=
 =?utf-8?B?VnFIdjRQa2Eyc2JlM1BZZ1pBQjlHdGxMem5tQ2lQbWNkaHNOMkdMbmV6d0Nz?=
 =?utf-8?B?RU1IVmRqWnR3emRNb0FVQUZkMUdOeDdOVFdRbUpMK2tKY2FXS0pRNGtQTkM5?=
 =?utf-8?B?MjJlWndRWEZNSG52eGx6OGRBa0FmVTd1YkcrSHVYL1ZIeUJWeHZUZnNZYzBH?=
 =?utf-8?B?SGl1UlVpQWV6MjFKL0VQamwvNDk0RGFxU3JTajdGeC9iYldWNTE2QnFtVzhI?=
 =?utf-8?B?WHp2am40cVQrV2lyMzc3WG1Sd3kxZGNoMWordzZ5azY0ekprN1RZeWJXRzc3?=
 =?utf-8?B?V2kzOTRKY0JrOXgzKys3VEpMZUx4TjVicXRwMTlDSms5N1VycDJlczhFMklz?=
 =?utf-8?B?d0hlenIwTlRjSGpVT3FLQkhjdTZYc3FwRVZYZ2RsU0NCNmovSWlBTktFRVhs?=
 =?utf-8?B?RXUzZTVoK255Q0wrMFJSb2pGK3RHZlAzcEl2Sm50a0x2eEF3WkJCemRsUFVX?=
 =?utf-8?B?dVN1bEhaTHA4ZjMxd3ZVQ0g0Y1dGOVk5NzBBVGVUNGk0NFdRNUFZbUlQczBK?=
 =?utf-8?B?cHoreVRBMTlVRW9UOVFsQTlXeFBuNkNnck5rTDR6aVFuNTl5R1hyRU5BQVJO?=
 =?utf-8?B?UHVzcW9zV1N6YVRtWVZLVzVEMlUyTlZTZE80NFR1azVRK3hDQ29qSGlVSW90?=
 =?utf-8?B?TWNKLzdXbHdiOFp0NHdQNmtpaEpoSVR3Y3BKcHpsNC9PeG5OUWwxd2RYNHhN?=
 =?utf-8?B?eXJ2cUo4anZqTVl6VlVQZnV4TDM0bDhVNGRLQnBzV1l2Tmd1VkhyUVMwRW9t?=
 =?utf-8?B?dDZJMnVlSGhVWXVrN0FaUndhR2Erd2hFY2poeEFud0dzQS9Mb2tYMW9oN0k1?=
 =?utf-8?Q?xQ3Vldem3c3/JZwg=3D?=
X-Exchange-RoutingPolicyChecked: kcHaymsriK+uc2BEc2qxHVAmCIcdqBV6wxkQTFh0Fu1FtHlCRVKsjciSMiiP1Qyz5EaYG6Yo6ESHBkwdlytnb26WlESMQAy9HK1Cm4azBiuJiI5jIlx4BJhy4pCqSCFBdgwa+Bo6Us/uxZHanDybF11VxpdYep9coyAcG0lu1uPvOvk8rmjB7TERumrKk2xaob1r4cv1nFCjtk+o+ymGx4quVCq76+EFi9l7xu6yDoxKdmQATMJeGshEHaGd5anIsAUdJkY5LzANg19skXBIXiUrKlotGOOk/iyuOn71Iq5XeeLGXIvNwmFxQjFhmj0iJbVachD6Pwxl3lhfManZuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f81562d6-d30a-4073-f91c-08de8082e2d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 22:01:17.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHaV4wk00KLVN/SfLJL29yMjtYK1nAOPLnXuEzMiJwx+WZ49gmenjJ7m/yMtVUufNiO1Jb3B6WsZg+zryqkts6OssX6avac+PLR5LmJTxdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7422
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20113-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 442C827ADC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> Two issues were noticed after the NFS v4.0 KConfig changes were merged
> upstream. First, the text of CONFIG_NFS_V4 should not encourage people
> to select it if they are unsure. Second, the new CONFIG_NFS_V4_0 option
> should default to "on" instead of "off" to avoid breaking people's
> setups if they are using NFS v4.0.
> 
> Reported-by: Niklas Cassel <cassel@kernel.org>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: 4e0269352534 ("NFS: Add a way to disable NFS v4.0 via KConfig")
> Fixes: 7537db24806f ("NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4")

Can confirm that this commit, 7537db24806f, regressed my long standing
NFS boot configuration.

Can also confirm that had this proposed fix been in the tree before I
did my first post v7.0-rc1 build it would have saved me a bisect.

Unfortunately, anyone like me that did a post v7.0-rc1 build with "make
olddefconfig" will not enjoy any relief until they clean out the errant:

# CONFIG_NFS_V4_0 is not set

...so that the default can be applied.

Not sure of any good way to address that problem, but for this patch:

Tested-by: Dan Williams <dan.j.williams@intel.com>

BTW, I had to lookup this thread the old fashioned way, a
patches.msgid.link tag would have saved a few moments. No worries if
this is not standard NFS subsystem policy.

