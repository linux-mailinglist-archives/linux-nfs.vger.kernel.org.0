Return-Path: <linux-nfs+bounces-8777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E49FC5BE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 15:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3CE163664
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF21DDE9;
	Wed, 25 Dec 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J09wE4jZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E132C6A3
	for <linux-nfs@vger.kernel.org>; Wed, 25 Dec 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136120; cv=fail; b=kc5DqMogc5SwNmAcf0ZjqlkrnzVcgHlUVFhYAu+IdQj1ils/QfablIUBGKwosnJNjppseM9hHo9mBeI8+kV3wvEviFc9SdV2uSqg/+Fm9yW8To5gYu33f6MAUWInShOnuSdj3RoFqeauzkBrYFKFoKPhWwWhup0gvBy5oraQcwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136120; c=relaxed/simple;
	bh=H93wGOBhl6unhvpTkqAwL/LWNtmO+e88ms+ir0XsYjA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DfOqJS9eEba4umdGWaXnXl4jBOlkZnDXLLcFm8L7vgtolp8oK3Z7qFMOGPrykSig19DY8s1OXdVBrjMDtNEcolPoesFEDGzRgQDsSjOSL6zGa9/tT0dOQWmXdQGXR3kr642HnTfM4UayLE1kdAXVLXTxxI7ZJLzC8iKsrfhEfmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J09wE4jZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735136119; x=1766672119;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=H93wGOBhl6unhvpTkqAwL/LWNtmO+e88ms+ir0XsYjA=;
  b=J09wE4jZjXg6hPXk0D9gT5eRGzoPLSWd94K5J2j+IieyBaf6q92U4a8i
   VEqjqu11+RC6geM4X1jHAA4wCquy5Jg44KDVUR9M5bgs0CTmn2D8vZHPB
   njT5U0HYag5VUixv6Ty9e4gJDI2IUC3Moxqoqgft8zWKBbumTQvrKtUhw
   +LhE3volYv+ef0MEI7tgWAm9fhVHGEO3yeZfD4774/qlZSqWnYSkkKGVW
   96KMi1Nw+iqmSlgJ7/huQ9QL69oIabHS7Ihf3UCT19V483O/vGn3UnXzu
   GrhWtWBwgAiSeDA5poum5KJ9LCJV1jcKU2z+5LLZqJI5dHePb2kHuGl4U
   g==;
X-CSE-ConnectionGUID: ehS+ltTLQZaXt1wzLWIu/w==
X-CSE-MsgGUID: wTmYs+GsSDmT6n7MpfN7ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="53110567"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="53110567"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 06:15:18 -0800
X-CSE-ConnectionGUID: m+AD+VQFTpm8zw/bUWvayQ==
X-CSE-MsgGUID: 0xgJUtb+RsqtStYwK39Zng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103807679"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2024 06:15:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 25 Dec 2024 06:15:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 25 Dec 2024 06:15:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 25 Dec 2024 06:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRuArINLqiY3sbdcsgSneb/aMVaZ7sUUht+1jnYo+/XDipP9Iw1FM773brepGUsjpbtLlDyS5I8T5k9Y6X36tjjKisaJWVcc5w4yO66lgn91ING21UpybEe6XhLeMbDmJiaZ/riq8KuZFLIFPvKVnhsmE8EHvovDXlcyxBbvtFfP6xd0Nqh1zP+ou8R54hbyDUf6NOM3y3t4kGBE5r/fy24kStofAJR9ND3sSPs007MuwEWfjB7V6GEzCG6wrPmR/vJ/tqkMa0XeB+WXMflz5hC37cfxbBMfvsud6YUJtdmVri8r/vz2MCpLWkfNg1EC1XLd9mCetkxFWWSCp6Y8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AupNqRJpvOTGMFcAVzpAvbeiqaaodduAfyuD/dgwVYE=;
 b=RDQc2I/yI0Jm12GQaRwAQ/102pJELmHP9ZqLbu2kUcAfeV3KdKS3UtoBCY4or6F3WtAnZSfPjqZl090/qVS3+ZUFrWwhgSCR68ZOBaFkbYIti0s4bCAMiDSmJc4+FQ+K7kWIRRSHKBn4vlGT/bhaVP/TkylEIQnO2kKuZEThskMUcD1XJKaapoWZ2ylK8qTq0hAS42GOHeO48ShK43CH1TWvzk4O6U/6OoPxTtNhY4x/phj3HF1auWTYvMjIdykb05oD5t+MJ+P6qOs2J5oxMK1WpBHwvZ8/0Gj+UbcBaYMJEOaZjbh1YGJ4PYT73D9wX/PJJ28vNsV+T9DUV8J3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 14:14:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 14:14:58 +0000
Date: Wed, 25 Dec 2024 22:14:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [jlayton:delstid] [nfsd]  1436c81cbe:  filebench.sum_operations/s
 15.7% regression
Message-ID: <202412252119.8934ca82-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 74da2d6c-f158-4ff1-4552-08dd24ee836b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5bzG2ZyvOZOdZYd7RarxAF8KQJ/fXphnAeiwICvCK3rjL5/e5iwXt4oLCA?=
 =?iso-8859-1?Q?PP43vvb6ZoViQTlNW9Vpd2VPI/i7xJEM7ZTmYkqO1D1IRG8AUL8Rg0vxI+?=
 =?iso-8859-1?Q?BvnlJi2C4YQlVMYwKglLIAsO+MDPWbv7tH37gE2gQ5HtaaWchyeJhOv7uT?=
 =?iso-8859-1?Q?2wY894o++/eMG/IgH8xdtax27SrdXz67rnEKqX9i9VRtW5t5iuAWE2toxM?=
 =?iso-8859-1?Q?B/sigr+YKcmBrq41rz+FzLc9hHL7G5GVFwaPzcSLq9rQ1gsUspzFkhKSqM?=
 =?iso-8859-1?Q?URMSMaU0hycEJYfNfHy3/T2yG+9KoUKMWGUr5fE1VV6UVevzilynmUwIQj?=
 =?iso-8859-1?Q?bmH3nxqlZZohaSk6T3iosZCy+0TZuPkItwEHlWqF8++35BH/GOQmWF0XiF?=
 =?iso-8859-1?Q?ODKhp8Af3u5jJHCOYDhtVOPJuE5vlqMGcG7UWItpGa8OVzRd1fVaMpW36N?=
 =?iso-8859-1?Q?CrRs2FRF5hmou6ssdBly5hk2hcDP6quKCa3qbR040pnBuJgv+V5aiMI3vk?=
 =?iso-8859-1?Q?kddJ9zt1njE99O8KGE4Ty3HnpDjVAeYLkSjD5gUD9cchinvPbOMp3rY3G2?=
 =?iso-8859-1?Q?OaXz9mSWA9fvtF/FfFIERNB4wKVkkkW34OI+qGzzLX2rNZ0oNv5uc3E+zI?=
 =?iso-8859-1?Q?vCH1QlDcBO/UBC1Lz/zgVmsjfeTbjd7UqIsprSmHIoZ111YVGkUnWFNlWX?=
 =?iso-8859-1?Q?fDGYtX32MP2zhirJ8Q0oWk2T/WX+tZHRfX7xxgtXbD5Vtq6icj/shitUkj?=
 =?iso-8859-1?Q?q0NjmYhSOBWFp6/mULiUGPbi15LzJdyW7SNe+VTphKdbtq8Si1w+th/W+A?=
 =?iso-8859-1?Q?5U7Bf4wIJzcj0R+xDVDvYGrh+aJr47Uw5Xd9d2dU1hY7VnfkxC7Omw5j1G?=
 =?iso-8859-1?Q?jb3f3nUIlMRhUu2/APiw6KjmFOPJUqimNZd3bv2/HIT+YIH2T90kFeKwRe?=
 =?iso-8859-1?Q?jN3v3v8ouHSZQNzCdDNmIUjvfXJeqIsixxaeR+P2dIOB4o18x3BLa1TH3c?=
 =?iso-8859-1?Q?WUvxpguA12IoZbYTf+BvgXb1Qaxj2OUBkYu8MBd82cEi373BN4XKR7WhoD?=
 =?iso-8859-1?Q?aXNbyKKoJUrlxkdqFRdkj4BSG5NoadPQYIzLvybLy5Z9sU6qs8hC+3/5Rl?=
 =?iso-8859-1?Q?4O2YYGa25TyQufxD7uH1+dnkvSI7Za6j9owd15hTeP8kahGa+RCl91XzVW?=
 =?iso-8859-1?Q?DlMvaK7pBBn6V9DkQ+Byd2N+uxUw66aUUqjZ/UyJtACOBtFuNbxkIFTJPV?=
 =?iso-8859-1?Q?x4QQceZxI2hdPcFFiS57vYEQL1U0iCdmrbar9ECXaXptJ2aMPd/HTJbnFQ?=
 =?iso-8859-1?Q?nItkG8GDA8eeha4ehGeZNt+Ek6QaucvfWU/Qseq5QD0zX3xret2Hbh2ln6?=
 =?iso-8859-1?Q?a+ioAUZY/dBAVJ/A3hakMCasbjdCLEQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ETFyaFckbCenrIXnZsJk5Revpvr7HmGdYd1Dtto3B5mKMCotuCmyQGUnqO?=
 =?iso-8859-1?Q?096fahu1kmi7WATQ+ZKK/tuypN+WjftmC5VNrvlO6DCA0eKhRE/TQRiWz8?=
 =?iso-8859-1?Q?R7KJ/1Zr07BJbMdpoNh1AHSsIlVUCBj70DSav8RZv+cMuDZhFBlN3QVmZD?=
 =?iso-8859-1?Q?AbVmD+zDhfVF43l/3g5LFhTU6ZWrddl2hmbCN6aYspJyBcv9vQuqI5JKpP?=
 =?iso-8859-1?Q?P23cT0g3NN2v65b9tMRncw4WhKz/XC51fN8O9jMYItHCaxfqfuKGNNxKzI?=
 =?iso-8859-1?Q?zR2YFacKJa9yHvk4t94OToF78HBks6pVNKL6UJ1RH9osWr99fBbHYyuBxO?=
 =?iso-8859-1?Q?rIraQwYG0CsnFG0crHJrsIRPpuEp+YPzdLeN47A0q7jOls/BXu5gwJKQIw?=
 =?iso-8859-1?Q?u63XxoPrWMr4NKPhsHS8wCin9IvGM82UGTgVSJ54RqOO34Mq8X1wDON5Tb?=
 =?iso-8859-1?Q?XiiS5IgbyeTub9kg0bTUEFyNx9y6XtZM0crVcC2i10+YAPVA07P6M5oVqm?=
 =?iso-8859-1?Q?HRuGc8D0pfn1IF35MR1b9Q/W2yNIZJAyh5ulDh+RKpjh+PWxtomAEuv7LH?=
 =?iso-8859-1?Q?ECrBTrbbJtLUlJLpFznRibClefYL5RZTAh5byFweGmd4oo5x0PISD3KDn6?=
 =?iso-8859-1?Q?+oUIxbkAn1y4aqiFzMVhsMnBJ829HWYTHzsXdRnYzkRo9sIJUQMa1/HRLL?=
 =?iso-8859-1?Q?7Zi0AN7LHM2+bLCyjy/blXCsqQJJDKXPZo2k6xPkeYJy5sIRH6CV8xsd0L?=
 =?iso-8859-1?Q?rsreALHiGUPfFF7kbkqZH+Y/10EOCXmGnBqBFqoba6Qh8/dlfAB9wdOD+C?=
 =?iso-8859-1?Q?bCFDOY7rDo10zPgH80O5/GRhRBiXHBvjVzhfiAa3iWaPrpjmpqBjN3YF4X?=
 =?iso-8859-1?Q?jwuY4+4f67unHcJoSVpjCRHkOxVwx9Jj1fZOM1r8EjvxFiFUhw5/oPM0z2?=
 =?iso-8859-1?Q?Rw9cOB2IgRnjCfaMjp8JF4DOa9Nq8vTMiGJv3VYghxECsAQ7+c1602rClm?=
 =?iso-8859-1?Q?JUMoHAemqzSMa/23PGe+9OMfmbpDSNqy7GYyXvyNuOLJjkRuHTGUlmMQR2?=
 =?iso-8859-1?Q?IwKZSwe5XzYnhx/qG3/75sJKqThfnc1+LjUc98cB/nkPcAZ3QTBany8yTa?=
 =?iso-8859-1?Q?F9klhQxz6nn77APTMEaETOsfNQFV+ABFgnURnv1B4IMj0l2tJy/5vNcemR?=
 =?iso-8859-1?Q?gM94DV6fxZwRWZC13wRcKcdgNw1ClWEfd2gA7L1ajPnvRVNY3kq5LkGkCw?=
 =?iso-8859-1?Q?60ignOZ3PJw8LlWEOAVBPgeInZq0/Nixf65PQiUm8kpiIeAkst5pDbihX8?=
 =?iso-8859-1?Q?N4hSsNSyXusbpbvJACqtjvuMa/Nf8wjjvT/QBkQvb4ECigcZ02aQcgQoWc?=
 =?iso-8859-1?Q?uZlhQgKxt3SBCWAPBpL6S6ur8f9Qrr9Tggwglcy/qgHszVv1c9cjJ5XrT5?=
 =?iso-8859-1?Q?VLcLWp7kjhVtnJyySOtxlb3v6SCDBoyh3/y4mhBxnjJyogl1YBJ/NqBh/p?=
 =?iso-8859-1?Q?pzBunRJxccd+GdBAyPnjRFs9YgaV8Ba4o5o8X5MC8y1XG30gfsFOWu1Rip?=
 =?iso-8859-1?Q?KvafEag7pYEGF8jPIbQfUl2xNgdD/FfGWS+fndYXt0hrqsOEOKAbsj2LKW?=
 =?iso-8859-1?Q?qvkY9cRpGtYKYp1Ll0YwGYQVRN8cv+44wDkAQPgi8gUkFJPZytKTAAlw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da2d6c-f158-4ff1-4552-08dd24ee836b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 14:14:58.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBjDWxHGkwF8mZjobLi1Hz4StvMoQxVGa5xANagTAwqJpUjokIoCY2/jJPYqSfmSo545X4yuwGsuD3TpOqroow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 15.7% regression of filebench.sum_operations/s on:


commit: 1436c81cbe9bef840cccc8a921948238e281442b ("nfsd: handle delegated timestamps in SETATTR")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git delstid

testcase: filebench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: nfsv4
	test: fileserver.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412252119.8934ca82-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241225/202412252119.8934ca82-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/nfsv4/ext4/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/fileserver.f/filebench

commit: 
  e42e5990ce ("nfsd: add support for delegated timestamps")
  1436c81cbe ("nfsd: handle delegated timestamps in SETATTR")

e42e5990ceb8ddbb 1436c81cbe9bef840cccc8a9219 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   5176774           +10.1%    5700789        cpuidle..usage
     81.80 ± 16%     +37.1%     112.11 ± 21%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      1467            -5.2%       1390        vmstat.io.bo
      2162            -4.1%       2073        vmstat.system.cs
      2962            +6.0%       3138        vmstat.system.in
    613132            -1.5%     604009        proc-vmstat.nr_dirtied
     20689            +3.2%      21341        proc-vmstat.nr_shmem
    613062            -1.5%     603944        proc-vmstat.nr_written
   3388546            +3.8%    3516202        proc-vmstat.numa_hit
   3255944            +3.9%    3383613        proc-vmstat.numa_local
   4280567            +3.1%    4415074        proc-vmstat.pgalloc_normal
   3620218            +5.9%    3833758        proc-vmstat.pgfault
   4169646            +3.0%    4296404        proc-vmstat.pgfree
    158758            +5.9%     168050        proc-vmstat.pgreuse
      4.87           -16.1%       4.08        filebench.sum_bytes_mb/s
     12799           -15.7%      10791        filebench.sum_operations
    213.31           -15.7%     179.83        filebench.sum_operations/s
     19.00           -15.8%      16.00        filebench.sum_reads/s
    232.79           +18.3%     275.40        filebench.sum_time_ms/op
     39.00           -15.4%      33.00        filebench.sum_writes/s
      1427            +5.6%       1507        filebench.time.elapsed_time
      1427            +5.6%       1507        filebench.time.elapsed_time.max
   2377240            -2.1%    2328234        filebench.time.file_system_outputs
     58841            -4.9%      55954        filebench.time.voluntary_context_switches
      2.70 ± 10%      -0.4        2.30 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.36 ± 22%      -0.2        0.16 ± 34%  perf-profile.children.cycles-pp.irqentry_enter
      0.29 ± 25%      -0.1        0.14 ± 37%  perf-profile.children.cycles-pp.kfree
      0.39 ± 10%      -0.1        0.31 ± 15%  perf-profile.children.cycles-pp.wait4
      0.02 ±223%      +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.43 ± 13%      -0.2        0.25 ± 15%  perf-profile.self.cycles-pp.kmem_cache_free
      0.18 ± 23%      -0.1        0.06 ± 80%  perf-profile.self.cycles-pp.irqentry_enter
      0.23 ± 29%      -0.1        0.11 ± 54%  perf-profile.self.cycles-pp.kfree
      0.10 ± 57%      +0.1        0.19 ± 17%  perf-profile.self.cycles-pp.__block_commit_write
      0.01 ±223%      +0.1        0.11 ± 32%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.09 ± 53%      +0.1        0.19 ± 24%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
  32545397            -1.4%   32080624        perf-stat.i.branch-instructions
      5.56            +0.1        5.69        perf-stat.i.branch-miss-rate%
  11214449            +4.0%   11660477        perf-stat.i.cache-references
      2150            -4.2%       2059        perf-stat.i.context-switches
      2.25            +1.3%       2.28        perf-stat.i.cpi
 1.585e+08            -1.4%  1.563e+08        perf-stat.i.instructions
      0.46            -1.2%       0.45        perf-stat.i.ipc
      5.32            +0.1        5.44        perf-stat.overall.branch-miss-rate%
      1.87            +1.9%       1.90        perf-stat.overall.cpi
      0.54            -1.9%       0.53        perf-stat.overall.ipc
  32487857            -1.4%   32026463        perf-stat.ps.branch-instructions
  11205362            +4.0%   11651731        perf-stat.ps.cache-references
      2148            -4.2%       2058        perf-stat.ps.context-switches
 1.583e+08            -1.4%   1.56e+08        perf-stat.ps.instructions
 2.261e+11            +4.9%  2.371e+11        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


