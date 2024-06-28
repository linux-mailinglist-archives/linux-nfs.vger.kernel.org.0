Return-Path: <linux-nfs+bounces-4378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4691B5F3
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 07:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315161F22EC5
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 05:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06424B2A;
	Fri, 28 Jun 2024 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpVGOqMT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7D2F50A;
	Fri, 28 Jun 2024 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719551628; cv=fail; b=aKpXXJMICM4eVgwt7POUepnuhuhAGewMvSHJNkLh4pZMiF1FyieNnRJGkfIwfcNuZmznRG9DhWEvAnasbwfMMiwVurQDkkDTEq21ceew6JUXIm6w8PFQ4FfGP9TcFku4SmibbHTPcWDtOBfEuxRtstcJypTZbUxUG0Kn7wM+hqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719551628; c=relaxed/simple;
	bh=Vo3tF5MI7ziIbOJPIrxIU7fKZ7Mw+KCVi79C43dSvTU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=guBa5kjbGpdfudU78l9Rjyyt43jmOBBMuLv3o0z9DVnX9YNxg87GaqIMXCrf1bLx/9RpdVppcQfM4MDjFtpuYFQPkoqHFu1CN6DsfxiLUS2CphJNfduiEBsiHHoPGSdH1fg/UD6zRztWwKITAoa40YhHHztlZ1ZFNj5fMg8/H2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpVGOqMT; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719551626; x=1751087626;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Vo3tF5MI7ziIbOJPIrxIU7fKZ7Mw+KCVi79C43dSvTU=;
  b=XpVGOqMTZYhUFC1E2CAPoMrdFx76q5GPKswgLkUSxR7ZFKp0cUlmUDsm
   diRrxTVVLJJqBqbWDSsEz7K7AUEkOc5xu0R1MZLkdAeuowcB+BK62aHci
   yLzlpJ4lWwKofOP3xeiDp2FGVIeDCc0/5wvn0jXfosWb5gAEfc4wTUjKU
   tyufPRXQe9+LyVCKj5lTt2Ra+yFRlAQ1FFliSrypXyIiPhymJIjV/EAW9
   nQdpVXimu/ycd5Y9rWHHZAOxk662i0aQUaoQ9d4soqKJKgECDY8a35r+k
   FsOFDH+JNtncUnoW/0Y8m/hFhH0oGWNQb8m8c+0Y9ur6FutfpfO0SHhvq
   Q==;
X-CSE-ConnectionGUID: nefqBqRbQc6dWA2EPDy5PA==
X-CSE-MsgGUID: QSfHLEVmSQW2b+IXPSAX8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16600239"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16600239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 22:13:45 -0700
X-CSE-ConnectionGUID: IeNgGYY3QvaFWMilFelMAQ==
X-CSE-MsgGUID: nsqiGv++RJ2NDE53olxKvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44714278"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 22:13:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 22:13:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 22:13:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 22:13:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 22:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN1mf2SO83OHjrnLsWCBUJ7fK3PfWUgFzsQqNeexGvxLuXVYaRD2KjrMMQvJ1RTeM1M+sWgERpLy0ifqFAU9qCr0twwkWvFLDunXCWmEEvgk3yRhqBKB2LW2KariKRGzoar4Jaytak9QtNCl7hIv6PkJGYdvrXpXewog6iPiyM5tA7Q0g7rEc53wUDq/YJHhO1Lk38makhNBB37DXsnrWxq6qT33kbVz4xkpr7SvXmRmO8hXhPB9eL6PTOCN5SPUmIO1R68LK0eolEXQeuDUIdTV5zFbW7gUPhgrpzfM0gqQxfOoTFc9n6/GqBzx2+8n9if4KxZB5ZD4Dn3kON0/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz3DMGJI2W2dP6T9GxymTneksnTlVsgv9/azU90/C/I=;
 b=l5FjDTtfU0D0D64GfluajkJSywy42fNfPlHYC6uM/qjAOR3hSJKMUwbzLsaQPuswJNO9GgXekybe5ZaU780WpXCIie9PG8QjgoGE+2WL3/6ppDO8Px/hB8hGOhTRQwNx1EkRPLaooUFm6+0apVaBpang3s6LTEnlCH+qB1dKkY+PE4/2qOiS97V2u6KmZzddFXjNz9zXS1OK2kHXtjILu9MJc6s0x5FXeFz59rnB3KeCjJwLzfi9I0rdjutxIMM1gVKZw1DmWVj/NymjDigRI3wgf/O5cJ/+bennt2WBLwwsrbGi4djbXbzm9K+pEtOhGtEElbw+tYSmLcXo5IWZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 05:13:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 05:13:36 +0000
Date: Fri, 28 Jun 2024 13:13:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [nfs]  a527c3ba41:  filebench.sum_operations/s 180.4%
 improvement
Message-ID: <202406281308.6137dbb1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c5bef9-90ef-466d-158a-08dc97311074
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mnSBGNIwp2c/6ZjjVyAHEWIKgog0/EXwQGO0/j/tacaQ3h7hjlKOYl2nBJ?=
 =?iso-8859-1?Q?NdQO3a5lArs/40zhKnrC7sxSyzgZqYs/OaKA9nWtAZICuLQQnyf4dNGSQ/?=
 =?iso-8859-1?Q?9HowhoY39bRGWpNF91thLuKkQ8smBO0OLLojvx707kjruNK6Vxxb/tAsc+?=
 =?iso-8859-1?Q?PlJPIFxT5ZKAzRERgIzLd8XwufNmcLJFZEHywztzEoaunWR0WmCSBKIJgN?=
 =?iso-8859-1?Q?f8MzdCOZ2jVydgmKauvtqorLnmQ/mcN/VxjWS96Fjshnnh1YRyB3F+gAF3?=
 =?iso-8859-1?Q?VJlQxHHHBSDu7wOCEpO7/I786RQ6zkEzB4qGtNXOBvWn9KmpEJyT7m84kF?=
 =?iso-8859-1?Q?vgpAJ2zixnC/yOElFzxaCZA5htCYUn1blMXCJFYv7rzMn6Q6BBCLi9ysmu?=
 =?iso-8859-1?Q?W1gCYAYDU4dd9SlM9MDM6H/jwZpFH83MRF+b75k98XLdgMNCg9Vivz/Kmv?=
 =?iso-8859-1?Q?qbeeRZUEF6/hZmgH1U7y4plo5AR6C2HIxPwinkxSQ5aJco2Un3V65SGRN/?=
 =?iso-8859-1?Q?HkJJmhaV3xOwVn00hYdX09/M7z9RchElNZK/yGDbDDjig0BtKsSTPlj/vQ?=
 =?iso-8859-1?Q?qjrse4aJ3Zutojy1ZOuXQQr69lD6pBoqZyYyhfRGHLqZtvxx7zAvoYQqOy?=
 =?iso-8859-1?Q?rIeLbOtAPdqe+DDlW8MJ2PHWR2dWOyO41I0Bh/IG7FBujzfG8mHqrETrq+?=
 =?iso-8859-1?Q?TWS40t22Rh9ZVaAdm0PUyZAQI/j6PKCi6f4uKVUzVePNjl2umhmPgfa5f2?=
 =?iso-8859-1?Q?UXwZ+inD4ZETvWnTYVxyluVGW2RM3XXP3vzGrhFEVHPOnU7tcRW0a3THd5?=
 =?iso-8859-1?Q?cLu3iiP977e4/brLgfJUTUEDkzUUv5hz/BndKFewIg1Igz5tT8vdYAN/I0?=
 =?iso-8859-1?Q?N+29kPwQzyH/fOnulswzLi4OefDfTqU+iBpF26IC3rYqF/dUvI6jPE5P9W?=
 =?iso-8859-1?Q?qGX5sxqioOnirdTCG8pxRHjbZI4eF+PlJbRdAZp5vuK5m1Qb8yMk78VNFS?=
 =?iso-8859-1?Q?XzPPNMbnZdPKnskD4BNWn8a/iTMoDFGzPbPqJS+bjpLCptZyivDlmbIMWa?=
 =?iso-8859-1?Q?iXdLEElKL5/9J8AvrO64ZjNqsTeXKxBytoLFGURaOY23ltV5TfAuTRNkoI?=
 =?iso-8859-1?Q?U45ygEqYQyPj2oyMR1uNxOxr+NjZXEOVO+p5wIa6TyZnrVRVJ+W34hqnRs?=
 =?iso-8859-1?Q?v0HOBiPAx3c77chsN9NP5StaNo666Ky62pBKby7oEtVm8lLonYImBUsg9l?=
 =?iso-8859-1?Q?7GKxXpUnYeHxj8FxREE2GQ0PTDRMGpMH5sIf+GlieDYKH9YchFVhDUoocp?=
 =?iso-8859-1?Q?KUEjnyZrm7eTsiVg8yBL9vUj7NpkphMrvy1c5ztWk+CnYnX5EqGk3jSZtG?=
 =?iso-8859-1?Q?icfXXarF9O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zZeOjV5zbcoT4X1LVv4pZnpuMUQVFmL+5SIJXOg0mVGz+lBhDjnC23UXzJ?=
 =?iso-8859-1?Q?G7kbvb8auk2q4cR0frfB6U0ggaRU8anpZSWYdRIx2/2aqYDrwg8OEQLUut?=
 =?iso-8859-1?Q?l3TiOb3//1ETQ6TF6T9F4YYFbRGHZftUjHnuebBQV3vJppSwyYg+rZ66Sg?=
 =?iso-8859-1?Q?mzRsa/8SfGSj8eFqFXILeDDzogGVSU0qbzHcPNACzfC3aR7iab48OExDGV?=
 =?iso-8859-1?Q?LlEKLWc9VR4CFIVwhO3EqvqtPuzgLKzjaOScwceVoJ6TGG3sjST1hj3CMm?=
 =?iso-8859-1?Q?nclnwcLJO6bujufOuckXrEDJOuEgSVshRldrhixbyvSA763HnfnpdicxAa?=
 =?iso-8859-1?Q?AljtDUT+d6K2jXQPgeR70YHcZsp+q3cLDilGFtmxr4WgBYG6SJa/W2jcBu?=
 =?iso-8859-1?Q?Dpa3sQ8iJ0AluWN9gMG7eEHfv5pDk4FPif1hiBQEH8Jf4+42PIPlnCUo90?=
 =?iso-8859-1?Q?gZzFBSH/q88x+N5+s81293t68eMQwASj5ximZI7mW8yIPYjlPGOiFkTKQZ?=
 =?iso-8859-1?Q?+1w8Xzxn3DSPm+n4cDF8zqaxdOatk5yQ/p9FeUusk7lR5hLYddXUMBVdqK?=
 =?iso-8859-1?Q?y26X09yvfmJZEN7CTtreaRfdBj/1d/Frp9jRcfpfn23/sa7+8fCJC8Z6ZQ?=
 =?iso-8859-1?Q?ATzXy03FQ8r5p22cohC5QNhUluSQ7aoapO6pbnRlETw4OF4NxZV31wQoTv?=
 =?iso-8859-1?Q?mNckSNJ0HcxdkVX6d69tHJ8GcklTFfkJny8BKW//ibNPVkWAugxd2uoiAf?=
 =?iso-8859-1?Q?0iE6+0HOY7FbiJLR827Y1NGOqiCJdQzSBXEe5VNM5rXmKvbhvQc9GG0ggJ?=
 =?iso-8859-1?Q?G6kzsONzH3sv+aiBj2W9iC6WnVJtSrnmnGkDpLf4a8vSn16GvQRyJ3Hfm6?=
 =?iso-8859-1?Q?XBPQgJSkGnK7WED+szTkuv0zQcvZ8ufNcrwf4O2OgVgHHxpgmwqHBI/YZl?=
 =?iso-8859-1?Q?ENbz3BinhJvBo984Sz5qVMFxDhD4zy8XHASxIgFmW9SDYWRdVGjMuGowvr?=
 =?iso-8859-1?Q?0T4z46rYnxMRPAuvMiRJyNZX5n4KJ0e0fU8vTY0zzc25+JeNvlaKzDAqKJ?=
 =?iso-8859-1?Q?tENga9IbM4q/D/XZstVrtk2UwbziUsxnB234CjRlv2PJwk5EOFYjDKSUH6?=
 =?iso-8859-1?Q?a10pKABwUrFqfsPrL2zNa0rYF4RMOBjd0eP2dh+9FQlRg93RGGG0soM5j8?=
 =?iso-8859-1?Q?Wx7eEEyZPlJS/kXz+ibaxOj4rtJS2bkiz9VmJuVddX4ln4TtIzF54mcG5X?=
 =?iso-8859-1?Q?zPbdCQ8FTHnJCCFe98Zcj0POwvC168+Wr+or9Aa8UZlyLq6oh4IAMkzvH2?=
 =?iso-8859-1?Q?0IePpF5BK7T8fAPcH+N+GWwHAXIpRehy2uJaU25GJ42uUPMpERn4eIhcHY?=
 =?iso-8859-1?Q?eQ228pzXfH3Xs8WWLSv4bM8gi+HG0pegXURuje6J4lRH34zKDIpvSgDSj6?=
 =?iso-8859-1?Q?LvkzooFDji9SL1K1UxJNPCWQ/eoTJapoq7XiP97nAUgBNMBq2iFglK+lG1?=
 =?iso-8859-1?Q?dLoT0/3LA82Zbw0nCAxEraQYpdefJ5CZpLhf67ezMRPqC/bm0nhPwZhu/Q?=
 =?iso-8859-1?Q?5/30tSwdw8rH7vlvM2MS6rwR9ctZrKnSmKYo1CbuJu8mcOA7gzjnd7eMOo?=
 =?iso-8859-1?Q?Lye2GKpIVyzGnegy2VAe5nRc48NjCUMXr1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c5bef9-90ef-466d-158a-08dc97311074
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 05:13:36.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AX4+S0xDKhRSNA+d4n3b2k6e0j2MCtFr5sbFCBmvfdqwfAqjIhCiMl2vXQhb3iYs40ofmLcp4OJ0tuiuCpd/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 180.4% improvement of filebench.sum_operations/s on:


commit: a527c3ba41c4c61e2069bfce4091e5515f06a8dd ("nfs: Avoid flushing many pages with NFS_FILE_SYNC")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: filebench
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: btrfs
	fs2: nfsv4
	test: filemicro_rwritefsync.f
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240628/202406281308.6137dbb1-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1HDD/nfsv4/btrfs/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-csl-2sp3/filemicro_rwritefsync.f/filebench

commit: 
  134d0b3f24 ("nfs: propagate readlink errors in nfs_symlink_filler")
  a527c3ba41 ("nfs: Avoid flushing many pages with NFS_FILE_SYNC")

134d0b3f2440cddd a527c3ba41c4c61e2069bfce409 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.06           -32.0%       1.40 ±  3%  iostat.cpu.iowait
  7.17e+10 ±  3%     -62.2%  2.708e+10 ±  2%  cpuidle..time
   3361646           -40.5%    2001605        cpuidle..usage
    797.57 ±  3%     -58.3%     332.24 ±  2%  uptime.boot
     74461 ±  3%     -58.5%      30930 ±  2%  uptime.idle
    986.05 ± 52%    -100.0%       0.00        numa-meminfo.node0.Mlocked
     41610 ± 32%     -59.2%      16976 ± 79%  numa-meminfo.node0.Shmem
     64815 ±  3%     -17.0%      53823 ±  2%  numa-meminfo.node1.Active(anon)
    989020 ± 10%     -49.7%     497288 ± 49%  numa-numastat.node0.local_node
   1031591 ± 10%     -46.8%     549069 ± 43%  numa-numastat.node0.numa_hit
   1104745 ± 11%     -29.8%     775663 ± 28%  numa-numastat.node1.local_node
   1161905 ±  9%     -29.1%     823337 ± 26%  numa-numastat.node1.numa_hit
      2170 ±  3%     +91.4%       4154 ±  2%  vmstat.io.bo
      1.99           -32.0%       1.35 ±  3%  vmstat.procs.b
      2060           +23.5%       2543 ±  2%  vmstat.system.cs
      4540 ±  2%     +80.5%       8197 ±  2%  vmstat.system.in
      2.07            -0.7        1.41 ±  3%  mpstat.cpu.all.iowait%
      0.06 ±  3%      +0.1        0.15 ±  3%  mpstat.cpu.all.irq%
      0.01 ±  2%      +0.0        0.02 ±  2%  mpstat.cpu.all.soft%
      0.05 ±  6%      +0.0        0.07 ±  5%  mpstat.cpu.all.sys%
      0.05 ±  2%      +0.1        0.12 ±  2%  mpstat.cpu.all.usr%
      0.37 ± 10%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.15 ± 16%      -0.0        0.11 ± 17%  perf-profile.children.cycles-pp.rcu_core
      0.16 ± 13%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.24 ± 12%      -0.1        0.19 ± 11%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.14 ± 15%      +0.0        0.19 ± 10%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      2.10          +184.9%       5.98 ±  6%  filebench.sum_bytes_mb/s
    273.04          +180.4%     765.61 ±  6%  filebench.sum_operations/s
      0.00 ± 10%  +27680.8%       1.20 ±  7%  filebench.sum_time_ms/op
    273.00          +180.4%     765.50 ±  6%  filebench.sum_writes/s
    746.84 ±  3%     -62.3%     281.62 ±  2%  filebench.time.elapsed_time
    746.84 ±  3%     -62.3%     281.62 ±  2%  filebench.time.elapsed_time.max
    246.64 ± 52%    -100.0%       0.00        numa-vmstat.node0.nr_mlock
     10402 ± 32%     -59.2%       4243 ± 79%  numa-vmstat.node0.nr_shmem
   1031364 ± 10%     -46.8%     548226 ± 43%  numa-vmstat.node0.numa_hit
    988793 ± 10%     -49.8%     496445 ± 49%  numa-vmstat.node0.numa_local
     16202 ±  3%     -17.0%      13454 ±  2%  numa-vmstat.node1.nr_active_anon
     16202 ±  3%     -17.0%      13454 ±  2%  numa-vmstat.node1.nr_zone_active_anon
   1161422 ±  9%     -29.2%     822014 ± 26%  numa-vmstat.node1.numa_hit
   1104280 ± 11%     -29.9%     774340 ± 28%  numa-vmstat.node1.numa_local
    169724           -34.1%     111875        meminfo.Active
     71034           -19.6%      57108        meminfo.Active(anon)
     98690           -44.5%      54766 ±  2%  meminfo.Active(file)
    386512 ± 18%     -46.6%     206514 ± 22%  meminfo.AnonHugePages
    100539 ±  4%    +163.6%     264992 ±  2%  meminfo.Dirty
     67198           -12.6%      58722        meminfo.Mapped
      1426 ±  2%    -100.0%       0.00        meminfo.Mlocked
    113320           -20.9%      89605        meminfo.Shmem
    295425 ±  4%    +125.3%     665456        meminfo.Writeback
     17758           -19.6%      14279        proc-vmstat.nr_active_anon
     24673           -44.5%      13701        proc-vmstat.nr_active_file
    165207            -2.3%     161474        proc-vmstat.nr_anon_pages
    188.72 ± 18%     -46.6%     100.85 ± 22%  proc-vmstat.nr_anon_transparent_hugepages
    641612            -8.4%     587844        proc-vmstat.nr_dirtied
     25122 ±  4%    +163.5%      66189 ±  2%  proc-vmstat.nr_dirty
   1359330            -2.5%    1325284        proc-vmstat.nr_file_pages
    174858            -3.5%     168725        proc-vmstat.nr_inactive_anon
    523188            -3.3%     506043        proc-vmstat.nr_inactive_file
     18536            +3.8%      19247        proc-vmstat.nr_kernel_stack
     17058           -12.4%      14939        proc-vmstat.nr_mapped
    356.48 ±  2%    -100.0%       0.00        proc-vmstat.nr_mlock
     28336           -20.9%      22408        proc-vmstat.nr_shmem
     73898 ±  4%    +125.0%     166281        proc-vmstat.nr_writeback
    640947            -8.4%     587183        proc-vmstat.nr_written
     17758           -19.6%      14279        proc-vmstat.nr_zone_active_anon
     24673           -44.5%      13701        proc-vmstat.nr_zone_active_file
    174858            -3.5%     168725        proc-vmstat.nr_zone_inactive_anon
    523188            -3.3%     506043        proc-vmstat.nr_zone_inactive_file
     41988 ±  3%    +100.4%      84132 ±  2%  proc-vmstat.nr_zone_write_pending
   2195708 ±  5%     -37.4%    1375336 ±  6%  proc-vmstat.numa_hit
   2095965 ±  5%     -39.2%    1274986 ±  7%  proc-vmstat.numa_local
     46641           -13.7%      40252        proc-vmstat.pgactivate
   2637615 ±  4%     -32.5%    1780826 ±  5%  proc-vmstat.pgalloc_normal
   1924711 ±  3%     -56.3%     841690 ±  3%  proc-vmstat.pgfault
   2504198 ±  7%     -32.5%    1691266 ± 13%  proc-vmstat.pgfree
   1624850           -27.2%    1182486        proc-vmstat.pgpgout
     89895 ±  2%     -55.4%      40062 ±  5%  proc-vmstat.pgreuse
      2.43            +7.0%       2.60 ±  3%  perf-stat.i.MPKI
  67435645 ±  2%    +112.8%  1.435e+08 ±  2%  perf-stat.i.branch-instructions
      4.56            -0.1        4.44        perf-stat.i.branch-miss-rate%
   3862446 ±  2%    +125.0%    8689890 ±  3%  perf-stat.i.branch-misses
      4.97            +2.4        7.33 ±  2%  perf-stat.i.cache-miss-rate%
    540701 ±  3%     +86.6%    1009040 ±  2%  perf-stat.i.cache-misses
   7966602           +24.1%    9887537        perf-stat.i.cache-references
      2039           +22.7%       2502 ±  2%  perf-stat.i.context-switches
  4.97e+08 ±  2%     +91.0%  9.495e+08 ±  3%  perf-stat.i.cpu-cycles
    101.96            +4.2%     106.25        perf-stat.i.cpu-migrations
      1037           +10.6%       1147 ±  3%  perf-stat.i.cycles-between-cache-misses
 3.314e+08 ±  2%    +112.2%  7.033e+08 ±  2%  perf-stat.i.instructions
      0.50           +11.5%       0.56        perf-stat.i.ipc
      2.11           -99.2%       0.02 ±  9%  perf-stat.i.metric.K/sec
      2466           +12.6%       2776 ±  2%  perf-stat.i.minor-faults
      2466           +12.6%       2776 ±  2%  perf-stat.i.page-faults
      1.63 ±  3%     -12.0%       1.43 ±  3%  perf-stat.overall.MPKI
      5.73            +0.3        6.05        perf-stat.overall.branch-miss-rate%
      6.79 ±  3%      +3.4       10.21 ±  2%  perf-stat.overall.cache-miss-rate%
      1.50           -10.0%       1.35        perf-stat.overall.cpi
      0.67           +11.1%       0.74        perf-stat.overall.ipc
  67362570 ±  2%    +112.3%   1.43e+08 ±  2%  perf-stat.ps.branch-instructions
   3858126 ±  2%    +124.5%    8659606 ±  3%  perf-stat.ps.branch-misses
    539904 ±  3%     +86.2%    1005142 ±  2%  perf-stat.ps.cache-misses
   7952547           +23.8%    9844369        perf-stat.ps.cache-references
      2036           +22.5%       2494 ±  2%  perf-stat.ps.context-switches
 4.966e+08 ±  2%     +90.7%  9.468e+08 ±  3%  perf-stat.ps.cpu-cycles
    101.81            +4.0%     105.85        perf-stat.ps.cpu-migrations
 3.311e+08 ±  2%    +111.7%   7.01e+08 ±  2%  perf-stat.ps.instructions
      2461           +12.2%       2762 ±  2%  perf-stat.ps.minor-faults
      2461           +12.2%       2762 ±  2%  perf-stat.ps.page-faults
 2.475e+11           -20.0%   1.98e+11        perf-stat.total.instructions
      0.04 ±  4%     +31.6%       0.05 ±  8%  sched_debug.cfs_rq:/.h_nr_running.avg
     20.10 ± 14%     +60.4%      32.25 ± 20%  sched_debug.cfs_rq:/.load_avg.avg
      0.04 ±  3%     +31.7%       0.05 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
      7.67 ± 37%    +146.1%      18.87 ± 29%  sched_debug.cfs_rq:/.removed.load_avg.avg
      3.51 ± 42%    +138.3%       8.37 ± 29%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      3.51 ± 42%    +138.3%       8.37 ± 29%  sched_debug.cfs_rq:/.removed.util_avg.avg
     38.15 ±  6%    +101.4%      76.85 ±  8%  sched_debug.cfs_rq:/.runnable_avg.avg
     98.16 ±  5%     +39.5%     136.95 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
     37.92 ±  6%    +101.5%      76.42 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
    656.80 ±  4%     +18.8%     780.15 ± 15%  sched_debug.cfs_rq:/.util_avg.max
     97.57 ±  5%     +39.9%     136.52 ± 11%  sched_debug.cfs_rq:/.util_avg.stddev
      3.28 ± 25%     +98.3%       6.50 ± 40%  sched_debug.cfs_rq:/.util_est.avg
    123.73 ± 11%     +45.4%     179.95 ± 12%  sched_debug.cfs_rq:/.util_est.max
     17.32 ± 11%     +68.8%      29.24 ± 22%  sched_debug.cfs_rq:/.util_est.stddev
    389566 ±  7%     -57.8%     164509 ±  7%  sched_debug.cpu.clock.avg
    389580 ±  7%     -57.8%     164520 ±  7%  sched_debug.cpu.clock.max
    389555 ±  7%     -57.8%     164499 ±  7%  sched_debug.cpu.clock.min
      8.38 ± 16%     -27.1%       6.11 ± 12%  sched_debug.cpu.clock.stddev
    388964 ±  7%     -57.8%     164063 ±  7%  sched_debug.cpu.clock_task.avg
    389309 ±  7%     -57.8%     164329 ±  7%  sched_debug.cpu.clock_task.max
    381467 ±  7%     -58.9%     156750 ±  7%  sched_debug.cpu.clock_task.min
     12392 ±  5%     -46.0%       6695 ±  4%  sched_debug.cpu.curr->pid.max
      1368 ±  6%     -36.2%     872.62 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.03 ± 10%     +52.8%       0.04 ± 10%  sched_debug.cpu.nr_running.avg
      0.15 ±  7%     +16.5%       0.17 ±  5%  sched_debug.cpu.nr_running.stddev
      9004 ±  5%     -47.9%       4694 ±  6%  sched_debug.cpu.nr_switches.avg
     77261 ± 22%     -40.5%      46007 ±  9%  sched_debug.cpu.nr_switches.max
      1542 ±  6%     -54.4%     702.61 ±  8%  sched_debug.cpu.nr_switches.min
     10459 ± 10%     -40.6%       6217 ±  6%  sched_debug.cpu.nr_switches.stddev
      0.07 ±  5%     -73.2%       0.02 ± 17%  sched_debug.cpu.nr_uninterruptible.avg
    389570 ±  7%     -57.8%     164510 ±  7%  sched_debug.cpu_clk
    388998 ±  7%     -57.9%     163938 ±  7%  sched_debug.ktime
    390127 ±  7%     -57.7%     165072 ±  7%  sched_debug.sched_clk




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


