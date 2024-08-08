Return-Path: <linux-nfs+bounces-5258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD294B7F4
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6453C1F23D19
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E19185628;
	Thu,  8 Aug 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQmpL70r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC2187322;
	Thu,  8 Aug 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102546; cv=fail; b=LgAY1AwoA65e5HshDsP3lWvXjw495YLyScNzYeeHazTm7irFw7sOxuriUTKHpZevpOu4vElcRI/7haGU8hQK03lbqHqs/JZZrv0iGGRK8MhfzaL0CbwTPLICG7ec1GVC9Tq3unaLxDPwRlb6OnQzkC/PzkFE30qGQsMO/VtNn2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102546; c=relaxed/simple;
	bh=CQoH8UtkZSloYajyc6Ulnt1iKESjaP+je4AdkAeWpBs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GXG7pQvyqfIcXf4L4i5qe5gLO6WAEauJHbsdq6nr8wndGREbxHQxKVNp5IKJvUq7l/9sKZKj0mwNZvqKIwaNLeF3y9Jwk6juPWKjTa7oF//ypNiQSN6ry9RO2wWkZM1UQquJ2ZR+XhCcx+rMCKG9aIx40BK+EY99KW7cFRmA/RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQmpL70r; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723102542; x=1754638542;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=CQoH8UtkZSloYajyc6Ulnt1iKESjaP+je4AdkAeWpBs=;
  b=FQmpL70rCdxDUNUx8w03ENxUAanhJEzcv+uiXotXZEiCnxPMYfczD3vz
   ss6QZ7Rt00BkKfSHutU3s9Go8sfZzzuYVJquY5oWGnsunKkp7RssZqYgO
   1oI74FmVdumrUeE6fmGJmvUc3BlT+RfbVSJbf0KSD6X+EBNLFmDLYXRux
   jU0P5YTaw1TfLtnkg3dgWwWHl7lAoloc1pTS/nDwy0P7diKu+snJluPfm
   6KfnldGCSI9kquh2CLMJlwOO4ua3XBc7qybsO+LDSJhiJRuwLBfUqrdSS
   lBFkEKgejEdrWcDvpca8rGsfumMlF4K6mnssFpWjXdHh5OxC/6H36qRhJ
   A==;
X-CSE-ConnectionGUID: HLS/IBP4RlaWH1h+VAwa6g==
X-CSE-MsgGUID: gDtKuZsuRfqXfY5BJ4vi3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21332277"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21332277"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:35:41 -0700
X-CSE-ConnectionGUID: PJKa1y6+QLejCAj1gqb0Og==
X-CSE-MsgGUID: 0oqxGSsaTNOcFld7cSZ4og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="56985167"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 00:35:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 00:35:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 00:35:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 00:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgOXgkNyNoEVKAM6NyQv125bA5LlTSk5K/qp8/K+CnRThW+2WRcVq9LkXW8sloLqmMoxy5tU/6JIKn+YpuObzbW5mvRFXx3kCLS31/AbmRMAOh8mmlukYpaP0QwP9kA5NtVrpL/w+tgXqVxkNU/mu+QPyixkTPy5s8jbNScCW3sj/8J4bQ8aFDO+h+06NTeLCJlv2rEDNCKJQDDSZKMDAX1JuPujsE/9wTdx7Akn2ig8TfxX7OF79ESQX4DoWTqA+0mBgJal9dcbTtFo+YVjaYzNWzTsUze/gazSryxuiYuhtFF+B3Uwgk1r0jmRRh3PneF62zIlKctzrw8vcr3npA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSbOC2u6fGqWzjJntXu3BMdGqJiOrvd9VUjC1vIEG28=;
 b=Ko9ASwillmrXqHMnibwhzRMZ+KYDMHmSWBS8qtHhSpwzDcEryJf+UfAhS2qrB+B87/WSw74qqIqiawLG3hQ6vYs+RhwUIXmJm0W3YnX4QJhJftbDMChAgVlIvS7y4nUmsXChFo9TvKeQmLKKXxI383S5OgvYmz1ICPVMz6lK77NBWYQ/bG5crMafHbwQRkOsk5VfeL9hBJ4ZwHT9myY2AaQObUeAsMXcLSNVmGgNkkEZ2JW2GTo/fQ0naWTBoJQr5LYI6ip0mei8SCnEVbT8FLC8kDv1JmqvdTyw/qnztcQAcx5nqkfSVjevZQ5wIBeBAD9+ZXqHl6uXWNtvGRo2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 07:35:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 07:35:31 +0000
Date: Thu, 8 Aug 2024 15:35:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s -85.6%
 regression
Message-ID: <202408081514.106c770e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca2c1f8-ca6b-4361-1f1a-08dcb77cae80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7ENGtVrZhGri5i7kKh+HPX0d3cZZV50exiYBYjlCaK97+bMmfyk/FmmfHK?=
 =?iso-8859-1?Q?pGgPBMH7zob73IM3Vha205oZ3kv6fbAT3kJHxdBoP/9LZ9GpnZou1zR+v3?=
 =?iso-8859-1?Q?mZ7YgWvTAYeieIVkPclR06Yvk4/yfGg4DNfN0Sz8R7tHNkGRS9S3qVpqho?=
 =?iso-8859-1?Q?hT08j9OQOZCbv42OMyvva56TpXtEz6UO0PiDfQBJlsLrYwhcfCslztV/f2?=
 =?iso-8859-1?Q?aaLa3pWP+bCmT7PeBgvfskn97GG09+d9P47q/Z1njyYOJ9Xaon44kuXA6s?=
 =?iso-8859-1?Q?pPaVTjbddx7x9catQ8m6cF9URID/NB4cmCEcLu3nQ+9k0bAbMw3zAtXNsK?=
 =?iso-8859-1?Q?vKMeYfa3qw/CzW5gpH/eKyaclB2W4MN7ZxyodHQmz+N9u5Fouyx09TD1ae?=
 =?iso-8859-1?Q?ikqzLshebQG9r0AquHyqYG7kqrPq6zSetEWmJKrgJFfUU8BYpwaKzZlcXm?=
 =?iso-8859-1?Q?pqLIIIhZjFqV2hbU9GI8uaYeoNPUJLXVnV898COECXagQXCfIdY9cHwHYe?=
 =?iso-8859-1?Q?g2IBkDEpFQlQn+ZXPGCXJJGz6HqK5aqqu8e6gU3XW6xXy8HOR3qvjZMyme?=
 =?iso-8859-1?Q?pGIJeVTre+Ei0j/zYVxlq2aEJO+3rXjSh4OFJuKNJcK42vBUaZvjjyKDrg?=
 =?iso-8859-1?Q?fBSEPA9EyrlZ/bhiakZuP6oc5PYJPiBStnhsAp8zyoklEmFHNx4ZIFSzpN?=
 =?iso-8859-1?Q?LaW6R9fKyqGcJJOqWjj+eBWAHVcILRmp4/YtjAkoLBtFKiw0FEKsbW7S/c?=
 =?iso-8859-1?Q?oZPnKprCJgzKTHkUkNY7IxRx3/8CF7BhArZLA5OZaegIi1MIUlcIJ0L+M+?=
 =?iso-8859-1?Q?omD96j29V0w7+M84hJCID7/HsMCJHQssMgXPRWJfb5DOMV4HFIFshOGS0x?=
 =?iso-8859-1?Q?Lb84nAOYIJ0csJ2GAXBIPBw9S72ppulwmxKDUIgfmCxu1QNbtl1e+J6Rhj?=
 =?iso-8859-1?Q?gAwc3Szu0ATTr8q4XclN9Se4wwvSJGxfl0lQJrr8HvjgKrIf1JDHrJ9vp7?=
 =?iso-8859-1?Q?xHHq7tuOJdlRysVsVsDZRHe39xvLxZAgGe0t7ZAEMPcDLigZzaUKbiOCqa?=
 =?iso-8859-1?Q?Xh3EM5XW/Xt0wrMM83nfW4TWhC4pBZQ9EUGOE0pvZGLv/7IRQkmWQL2X1+?=
 =?iso-8859-1?Q?SBEnsRerjaoHyacBPAmJ7fg1UvAJn6x1M4KVIZRaeNpCUe2ITq5r4gaAiJ?=
 =?iso-8859-1?Q?kyzWfYfLB7qNHPwPHt+oppxYwHm/JUACiw89Ss8ahJkKhsvO7q9W+H2XRg?=
 =?iso-8859-1?Q?RgSTMpTM37YiTSzXVKzgjn9kcqjXsqJYKn8xHg/Cmv0PW2uUlD+JcWu0bC?=
 =?iso-8859-1?Q?iboWT08er7veU41v18hxllyfe9PA+043R56AGEa9Ii0BgcFZ8BMfXkbRNx?=
 =?iso-8859-1?Q?BnqF2Trepp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yjfrwJ0rqBS5IsScepooquVVNGBNxUZKkjCyrM8j9IynYQwifUyxzJTzaV?=
 =?iso-8859-1?Q?ryX7qxXki+ngoW75CVrngy4s4HUIBvZid+14uf4Kby9aezczRFu3ZuMXnE?=
 =?iso-8859-1?Q?9BDshbksAstnudFTomuPPM3L5njhCkBs1ffnEjOiALfdkV/vlEpRYfvKr+?=
 =?iso-8859-1?Q?y31HqZyOfqQdcZCPrXx6iNpfSzSQKCZFGzOpn+JeeX0GT0vUpKVShWOgMB?=
 =?iso-8859-1?Q?gPuOkbYd6D4283DayvVJJbMLPzxZEG7KUs/JkLxQPj/WWwUXDIb/tnEJuL?=
 =?iso-8859-1?Q?VyGby34xc3Iq0RW5R2O5rXY+o8PlX+ZoYjy7bp0ZQXGealU59PHtWdoROY?=
 =?iso-8859-1?Q?4J91mVgxc9+jYxrrtDtohuacptF4XVxR4Wvl/SPDJaZsux2f5z+CMLnejT?=
 =?iso-8859-1?Q?Db8qO+mKM8LZ3syQiP3bkzJABIF+3P//3/pgzke5OJAIu2mZuHDWxoQBV+?=
 =?iso-8859-1?Q?5/XxCqdQ2cE9mGxwN4hhucCCKNOjZuLQ1dVfubEKSL2LVbxmjgrex++V/H?=
 =?iso-8859-1?Q?PKt4X5qX21Hg1Mwtpk6ywqzntiMyoJTGUzFuxT9SW5xIe7Q+i0TsMCvsUX?=
 =?iso-8859-1?Q?i4xtZ+LFLVbcoYQwS1kDIEST3TYZSe1m13PNOj9aLgSKnkb8Zuu8KQidDZ?=
 =?iso-8859-1?Q?VeItSa6/e01WbreXOSyBLqdQsQVSuiEVDz24DmK0SC1c9XFqeIWE/3FrXX?=
 =?iso-8859-1?Q?hKHkZFMvmhtp79MeLSnUyhpHY9EHQOWYvDnsyPt6N1e09rImAeQEtcBcIL?=
 =?iso-8859-1?Q?bS3we4XLvztkJ+LvyYGuWkt37f/1nyb+ddzPRKIPFX5BYxrW1vLaaDvWfa?=
 =?iso-8859-1?Q?GCQtg0JRyelvtyZQOoUPBIW+EV9+da0dn3Hw9vcn2SRoeZQMbRpxY3cxhm?=
 =?iso-8859-1?Q?lAd2P8j0y13AYNGfPUec0UmH7Lv3QuzIZTwabyr9oXnHH0HtDAH1pDSNKY?=
 =?iso-8859-1?Q?pRVgW7rYqpFLpBZoBDCBDJYR1O6n7qiXTxpfRGt7bRBIgbNaaAxeK0zEvK?=
 =?iso-8859-1?Q?29Q/XpE6bw3evXA7ddIi3tj9EBQZEYQLKZdzkm4ck7TloqbZh8+OjPaocL?=
 =?iso-8859-1?Q?AEBarLStY8apmTkfOOymjG5EdEyFF6ASQ4jUa+2e3lNg2p98HcY2OQhMT+?=
 =?iso-8859-1?Q?8RdZc03kVRvabfHdk6nawHbuaiyKpUgfe/n1zj7n8900f/yV1aw152TQwy?=
 =?iso-8859-1?Q?tNDoSKuoQzbXnp4OsQsZFLD/1DrfoYzv0bp4tg885FIfM796LLJWs2DPq/?=
 =?iso-8859-1?Q?Damdqx15ZnFUBfpVXYOjd23Ak9R3PNYAjOmnRGJQzqOGSoP5Gl9peOClF0?=
 =?iso-8859-1?Q?C1e7GMzX7z/zEP+po/RCHwpdzgKyz7PPvRA8y6kcNYxfcVXCYqVtHsoNpY?=
 =?iso-8859-1?Q?tgLPbiVrLUIoz1AqzaxEzapcg4v6Z9Q3taw1e8h6T7gertNgsoGxCRtZJ+?=
 =?iso-8859-1?Q?EeWMslx/4+rjFnKEDxE05CoAzv/+dN0gCKg7y5To9RnE4qvJLmDlBUnBcz?=
 =?iso-8859-1?Q?ZPlPT+TtmK97j8UzrVPwV+ahxrRsAei3y1M0lLY+nfDMnKaHFwyfFx+VwN?=
 =?iso-8859-1?Q?r1FJsYBpo1wlJXFz96WNZSnZI1oQmUL3mHz8Zo+Zt7q1sz4cYlylgG7GEV?=
 =?iso-8859-1?Q?0eLQPb6xJCe0blnrYe+WBiKP40u5/rY0VeB9o2nJHQRgaz04LsyuQdeA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca2c1f8-ca6b-4361-1f1a-08dcb77cae80
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:35:31.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mIVAzswDplqZkX5JquuuuLTubkRMvXsP59GDVY6vl7xHsOcNXhDOZLq+3rhtFUPj58B7YtasVEAgupPg9ad9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -85.6% regression of filebench.sum_operations/s on:


commit: 49b29a573da83b65d5f4ecf2db6619bab7aa910c ("nfs: add support for large folios")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: filebench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: nfsv4
	test: randomrw.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408081514.106c770e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408081514.106c770e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1HDD/nfsv4/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomrw.f/filebench

commit: 
  9aac777aaf ("filemap: Convert generic_perform_write() to support large folios")
  49b29a573d ("nfs: add support for large folios")

9aac777aaf945978 49b29a573da83b65d5f4ecf2db6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     98.36            -1.0%      97.34        iostat.cpu.idle
      1.28 ± 21%     +89.3%       2.42 ± 10%  iostat.cpu.iowait
    203868 ±  9%     -25.7%     151373 ± 17%  numa-meminfo.node0.SUnreclaim
   1026057 ± 40%     -76.5%     241071 ± 70%  numa-meminfo.node1.Dirty
   1693537 ± 24%     -74.2%     437697 ± 27%  sched_debug.cpu.nr_switches.max
    191731 ± 18%     -61.9%      73070 ± 25%  sched_debug.cpu.nr_switches.stddev
   1849853 ± 66%    +175.6%    5097620 ± 32%  numa-vmstat.node0.nr_dirtied
     50982 ±  9%     -25.8%      37842 ± 17%  numa-vmstat.node0.nr_slab_unreclaimable
   1849844 ± 66%    +175.6%    5097604 ± 32%  numa-vmstat.node0.nr_written
    256902 ± 40%     -76.9%      59457 ± 71%  numa-vmstat.node1.nr_dirty
     43810           +35.9%      59529 ±  5%  vmstat.io.bo
      1.65 ± 22%     +93.6%       3.19 ±  9%  vmstat.procs.b
      1.54 ±  3%     -11.2%       1.37        vmstat.procs.r
      4341 ±  3%     -18.4%       3543 ±  4%  vmstat.system.in
   3713739 ±  3%     +10.7%    4110439 ±  3%  meminfo.Active
   3688730 ±  2%     +10.7%    4085171 ±  3%  meminfo.Active(file)
   1631748 ±  3%     -63.1%     602285 ± 12%  meminfo.Dirty
    398961           -23.8%     304003        meminfo.SUnreclaim
    655165           -16.2%     549118        meminfo.Slab
   1411642 ±  3%     +56.0%    2202614 ±  5%  meminfo.Writeback
      1.29 ± 21%      +1.2        2.44 ± 10%  mpstat.cpu.all.iowait%
      0.02 ±  2%      +0.0        0.02 ±  5%  mpstat.cpu.all.soft%
      0.28 ±  5%      -0.1        0.15 ±  6%  mpstat.cpu.all.sys%
      0.05 ±  2%      -0.0        0.04 ±  6%  mpstat.cpu.all.usr%
     22.67 ±184%     -86.8%       3.00        mpstat.max_utilization.seconds
      7.61 ±  9%     -12.7%       6.65        mpstat.max_utilization_pct
    919.42 ± 16%     -85.6%     132.50 ± 34%  filebench.sum_bytes_mb/s
   7061641 ± 16%     -85.6%    1017633 ± 34%  filebench.sum_operations
    117684 ± 16%     -85.6%      16959 ± 34%  filebench.sum_operations/s
     59443 ± 16%     -85.7%       8524 ± 34%  filebench.sum_reads/s
      0.02 ± 13%    +611.2%       0.12 ± 31%  filebench.sum_time_ms/op
     58241 ± 16%     -85.5%       8435 ± 34%  filebench.sum_writes/s
  21810424           +37.4%   29966336 ± 11%  filebench.time.file_system_outputs
     14251            -5.6%      13458 ±  2%  filebench.time.minor_page_faults
     17.67 ±  5%     -90.6%       1.67 ± 66%  filebench.time.percent_of_cpu_this_job_got
     41.30 ±  5%     -88.1%       4.90 ± 43%  filebench.time.system_time
   3582819 ± 16%     -85.8%     509229 ± 33%  filebench.time.voluntary_context_switches
    921497 ±  2%     +11.0%    1022743 ±  3%  proc-vmstat.nr_active_file
   5452715           +37.4%    7491524 ± 11%  proc-vmstat.nr_dirtied
    407500 ±  2%     -62.8%     151456 ± 13%  proc-vmstat.nr_dirty
   1653629            -5.4%    1564747 ±  2%  proc-vmstat.nr_inactive_file
     64005            -4.2%      61291        proc-vmstat.nr_slab_reclaimable
     99730           -23.8%      75999        proc-vmstat.nr_slab_unreclaimable
    352757 ±  3%     +55.8%     549420 ±  5%  proc-vmstat.nr_writeback
   5452662           +37.4%    7491481 ± 11%  proc-vmstat.nr_written
    921497 ±  2%     +11.0%    1022743 ±  3%  proc-vmstat.nr_zone_active_file
   1653629            -5.4%    1564747 ±  2%  proc-vmstat.nr_zone_inactive_file
      1655 ± 15%     -42.7%     947.83 ± 33%  proc-vmstat.numa_hint_faults
      1546 ± 16%     -53.2%     723.33 ± 38%  proc-vmstat.numa_hint_faults_local
   4381534 ±  6%     -25.2%    3276231 ± 16%  proc-vmstat.numa_hit
   4248725 ±  6%     -26.0%    3143651 ± 17%  proc-vmstat.numa_local
     10725 ± 54%     -57.7%       4532 ± 35%  proc-vmstat.numa_pte_updates
   1271493 ±  2%      +3.6%    1317523        proc-vmstat.pgactivate
  10906410           +37.4%   14983963 ± 11%  proc-vmstat.pgpgout
 1.982e+08 ±  5%     -35.7%  1.274e+08 ±  3%  perf-stat.i.branch-instructions
      7.83 ±  3%      -1.4        6.40 ±  7%  perf-stat.i.cache-miss-rate%
   5551160 ±  7%     -48.1%    2879590 ±  5%  perf-stat.i.cache-misses
  25389854 ±  6%     -30.6%   17609995 ±  2%  perf-stat.i.cache-references
      1.92            +3.1%       1.98        perf-stat.i.cpi
 1.685e+09 ±  4%     -35.6%  1.086e+09 ±  5%  perf-stat.i.cpu-cycles
    175.05 ±  3%     -15.6%     147.75 ±  2%  perf-stat.i.cpu-migrations
      1277 ±  3%     +27.3%       1625 ±  8%  perf-stat.i.cycles-between-cache-misses
 8.992e+08 ±  5%     -32.6%  6.062e+08 ±  3%  perf-stat.i.instructions
      0.57            -3.2%       0.55        perf-stat.i.ipc
      0.24 ± 14%     -27.6%       0.17 ± 23%  perf-stat.i.metric.K/sec
      6.17 ±  2%     -22.8%       4.76 ±  3%  perf-stat.overall.MPKI
      1.95 ±  4%      +0.8        2.76 ±  4%  perf-stat.overall.branch-miss-rate%
     21.85 ±  2%      -5.5       16.37 ±  4%  perf-stat.overall.cache-miss-rate%
    304.50 ±  4%     +23.8%     377.10 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.53 ±  2%      +4.7%       0.56 ±  4%  perf-stat.overall.ipc
 1.975e+08 ±  5%     -35.7%   1.27e+08 ±  3%  perf-stat.ps.branch-instructions
   3849663            -8.9%    3506691 ±  4%  perf-stat.ps.branch-misses
   5532498 ±  7%     -48.0%    2879018 ±  5%  perf-stat.ps.cache-misses
  25301762 ±  6%     -30.5%   17579581        perf-stat.ps.cache-references
  1.68e+09 ±  4%     -35.4%  1.084e+09 ±  5%  perf-stat.ps.cpu-cycles
    174.27 ±  3%     -15.6%     147.10 ±  2%  perf-stat.ps.cpu-migrations
 8.961e+08 ±  5%     -32.5%  6.045e+08 ±  3%  perf-stat.ps.instructions
 2.211e+11 ±  4%     -32.0%  1.504e+11 ±  6%  perf-stat.total.instructions
     52.52 ± 12%     -45.4        7.08 ± 20%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     51.90 ± 12%     -45.0        6.86 ± 20%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     79.10 ±  9%     -43.9       35.15 ± 29%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     79.10 ±  9%     -43.9       35.15 ± 29%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     79.10 ±  9%     -43.9       35.15 ± 29%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     42.11 ± 12%     -42.1        0.00        perf-profile.calltrace.cycles-pp.rpc_async_release.process_one_work.worker_thread.kthread.ret_from_fork
     42.11 ± 12%     -42.1        0.00        perf-profile.calltrace.cycles-pp.rpc_free_task.rpc_async_release.process_one_work.worker_thread.kthread
     28.67 ± 19%     -28.7        0.00        perf-profile.calltrace.cycles-pp.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work.worker_thread
     16.89 ± 31%     -16.9        0.00        perf-profile.calltrace.cycles-pp.nfs_page_end_writeback.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work
     16.28 ± 32%     -16.3        0.00        perf-profile.calltrace.cycles-pp.folio_end_writeback.nfs_page_end_writeback.nfs_write_completion.rpc_free_task.rpc_async_release
     15.82 ± 32%     -15.8        0.00        perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.nfs_page_end_writeback.nfs_write_completion.rpc_free_task
     13.99 ± 35%     -14.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__folio_end_writeback.folio_end_writeback.nfs_page_end_writeback.nfs_write_completion
     13.55 ± 35%     -13.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__folio_end_writeback.folio_end_writeback.nfs_page_end_writeback
     13.42 ± 15%     -13.4        0.00        perf-profile.calltrace.cycles-pp.nfs_commit_release.rpc_free_task.rpc_async_release.process_one_work.worker_thread
     13.42 ± 15%     -13.4        0.00        perf-profile.calltrace.cycles-pp.nfs_commit_release_pages.nfs_commit_release.rpc_free_task.rpc_async_release.process_one_work
     10.58 ± 16%     -10.6        0.00        perf-profile.calltrace.cycles-pp.nfs_request_add_commit_list.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work
     10.48 ± 15%     -10.5        0.00        perf-profile.calltrace.cycles-pp.nfs_inode_remove_request.nfs_commit_release_pages.nfs_commit_release.rpc_free_task.rpc_async_release
      8.89 ± 17%      -8.9        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.nfs_inode_remove_request.nfs_commit_release_pages.nfs_commit_release.rpc_free_task
      8.19 ± 17%      -8.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.nfs_inode_remove_request.nfs_commit_release_pages.nfs_commit_release
      7.56 ± 24%      -7.6        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.nfs_request_add_commit_list.nfs_write_completion.rpc_free_task.rpc_async_release
      6.57 ± 27%      -6.6        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.nfs_request_add_commit_list.nfs_write_completion.rpc_free_task
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file.nfsd_commit.nfsd4_commit
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file.nfsd_commit
      4.45 ± 19%      -2.1        2.31 ± 25%  perf-profile.calltrace.cycles-pp.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      4.05 ± 13%      -1.3        2.74 ± 21%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.20 ±141%      +0.6        0.75 ± 16%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.20 ±141%      +0.6        0.75 ± 16%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      0.20 ±141%      +0.6        0.75 ± 16%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.20 ±141%      +0.6        0.75 ± 16%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.20 ±141%      +0.6        0.75 ± 16%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      0.20 ±141%      +0.6        0.75 ± 16%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.00            +0.6        0.59 ± 14%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.1        1.12 ± 34%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +1.2        1.16 ± 32%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      0.31 ±102%      +1.4        1.68 ± 15%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.22 ±141%      +1.4        1.62 ± 15%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.6        1.60 ± 25%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.12 ±223%      +2.4        2.50 ± 23%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.23 ±146%      +3.1        3.36 ± 23%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.1        3.13 ± 95%  perf-profile.calltrace.cycles-pp.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range.ext4_sync_file
      0.00            +3.8        3.77 ± 94%  perf-profile.calltrace.cycles-pp.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range.ext4_sync_file.nfsd_commit
      1.51 ± 30%      +4.3        5.78 ± 48%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +4.5        4.53 ± 94%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.file_write_and_wait_range.ext4_sync_file.nfsd_commit.nfsd4_commit
      0.71 ± 24%     +10.0       10.76 ± 40%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.00 ± 10%     +12.6       22.59 ± 13%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      8.46 ± 10%     +12.7       21.13 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.27 ± 11%     +13.2       21.46 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     12.87 ± 10%     +18.6       31.52 ± 18%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     12.89 ± 10%     +18.7       31.56 ± 18%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     12.90 ± 10%     +18.7       31.60 ± 18%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     13.40 ± 10%     +19.0       32.35 ± 17%  perf-profile.calltrace.cycles-pp.common_startup_64
     52.52 ± 12%     -45.4        7.08 ± 20%  perf-profile.children.cycles-pp.worker_thread
     51.90 ± 12%     -45.0        6.86 ± 20%  perf-profile.children.cycles-pp.process_one_work
     79.10 ±  9%     -43.9       35.15 ± 29%  perf-profile.children.cycles-pp.kthread
     79.12 ±  9%     -43.9       35.18 ± 29%  perf-profile.children.cycles-pp.ret_from_fork
     79.12 ±  9%     -43.9       35.18 ± 29%  perf-profile.children.cycles-pp.ret_from_fork_asm
     42.11 ± 12%     -42.0        0.08 ± 19%  perf-profile.children.cycles-pp.rpc_async_release
     42.11 ± 12%     -42.0        0.08 ± 19%  perf-profile.children.cycles-pp.rpc_free_task
     28.68 ± 19%     -28.6        0.06 ± 19%  perf-profile.children.cycles-pp.nfs_write_completion
     23.08 ± 18%     -21.5        1.54 ±113%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     16.89 ± 31%     -16.9        0.00        perf-profile.children.cycles-pp.nfs_page_end_writeback
     16.54 ± 31%     -15.9        0.62 ± 42%  perf-profile.children.cycles-pp.__folio_end_writeback
     17.05 ± 31%     -14.9        2.20 ± 93%  perf-profile.children.cycles-pp.folio_end_writeback
     15.65 ± 32%     -14.4        1.30 ± 49%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     13.42 ± 15%     -13.4        0.00        perf-profile.children.cycles-pp.nfs_commit_release
     13.42 ± 15%     -13.4        0.00        perf-profile.children.cycles-pp.nfs_commit_release_pages
     10.58 ± 16%     -10.6        0.00        perf-profile.children.cycles-pp.nfs_request_add_commit_list
     10.48 ± 15%     -10.5        0.00        perf-profile.children.cycles-pp.nfs_inode_remove_request
      9.54 ± 16%      -7.8        1.70 ± 31%  perf-profile.children.cycles-pp._raw_spin_lock
      7.59 ± 24%      -7.6        0.00        perf-profile.children.cycles-pp.__mutex_lock
      7.33 ± 14%      -4.7        2.62 ± 24%  perf-profile.children.cycles-pp.do_writepages
      2.73 ± 25%      -2.5        0.18 ± 47%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      2.73 ± 25%      -2.5        0.18 ± 47%  perf-profile.children.cycles-pp.__writeback_single_inode
      2.73 ± 25%      -2.5        0.18 ± 47%  perf-profile.children.cycles-pp.nfs_writepages
      2.73 ± 25%      -2.5        0.18 ± 47%  perf-profile.children.cycles-pp.wb_do_writeback
      2.73 ± 25%      -2.5        0.18 ± 47%  perf-profile.children.cycles-pp.wb_writeback
      2.73 ± 25%      -2.5        0.18 ± 48%  perf-profile.children.cycles-pp.write_cache_pages
      2.73 ± 25%      -2.5        0.18 ± 47%  perf-profile.children.cycles-pp.writeback_sb_inodes
      2.73 ± 25%      -2.5        0.18 ± 48%  perf-profile.children.cycles-pp.wb_workfn
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.children.cycles-pp.ext4_do_writepages
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.children.cycles-pp.ext4_writepages
      4.60 ± 18%      -2.2        2.44 ± 25%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      4.46 ± 19%      -2.1        2.32 ± 25%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      2.27 ± 28%      -2.1        0.16 ± 46%  perf-profile.children.cycles-pp.nfs_writepages_callback
      2.20 ± 29%      -2.0        0.16 ± 46%  perf-profile.children.cycles-pp.nfs_page_async_flush
      4.16 ± 12%      -1.2        2.94 ± 21%  perf-profile.children.cycles-pp.intel_idle
      1.48 ± 28%      -0.8        0.68 ± 22%  perf-profile.children.cycles-pp.__folio_start_writeback
      1.30 ± 14%      -0.7        0.58 ± 19%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.85 ± 29%      -0.7        0.15 ± 37%  perf-profile.children.cycles-pp.kmem_cache_free
      1.44 ± 13%      -0.7        0.77 ± 19%  perf-profile.children.cycles-pp.sched_balance_rq
      1.31 ± 13%      -0.7        0.65 ± 18%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      1.30 ± 14%      -0.6        0.64 ± 17%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.16 ± 13%      -0.6        0.57 ± 19%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.79 ± 22%      -0.6        0.22 ±121%  perf-profile.children.cycles-pp.nfs_folio_find_private_request
      1.25 ± 13%      -0.5        0.77 ± 22%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.55 ± 20%      -0.3        0.22 ± 39%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.56 ± 20%      -0.3        0.23 ± 37%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.34 ± 29%      -0.3        0.05 ± 76%  perf-profile.children.cycles-pp.__slab_free
      0.68 ± 21%      -0.3        0.40 ± 24%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.34 ± 25%      -0.3        0.08 ± 27%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.54 ± 10%      -0.2        0.30 ± 17%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.22 ± 15%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.seq_read
      0.38 ± 11%      -0.2        0.20 ± 12%  perf-profile.children.cycles-pp.seq_read_iter
      0.21 ± 15%      -0.2        0.04 ±102%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
      0.62 ±  8%      -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.ksys_read
      0.24 ± 12%      -0.2        0.07 ± 55%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.23 ± 12%      -0.2        0.07 ± 55%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.25 ± 22%      -0.2        0.10 ± 25%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.22 ± 15%      -0.2        0.07 ± 55%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.66 ±  8%      -0.1        0.51 ±  9%  perf-profile.children.cycles-pp.read
      0.24 ± 25%      -0.1        0.10 ± 26%  perf-profile.children.cycles-pp.__submit_bio
      0.24 ± 25%      -0.1        0.10 ± 26%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.21 ± 19%      -0.1        0.07 ± 31%  perf-profile.children.cycles-pp.__common_interrupt
      0.19 ± 21%      -0.1        0.05 ± 50%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.21 ± 20%      -0.1        0.07 ± 28%  perf-profile.children.cycles-pp.handle_edge_irq
      0.20 ± 21%      -0.1        0.06 ± 53%  perf-profile.children.cycles-pp.handle_irq_event
      0.18 ± 22%      -0.1        0.05 ± 50%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      0.24 ± 33%      -0.1        0.10 ± 13%  perf-profile.children.cycles-pp.idle_cpu
      0.24 ± 18%      -0.1        0.12 ± 30%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.28 ± 17%      -0.1        0.16 ± 26%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.16 ± 26%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.ahci_handle_port_intr
      0.28 ± 22%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.svc_send
      0.28 ± 24%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.svc_tcp_sendto
      0.23 ± 19%      -0.1        0.12 ± 19%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.16 ± 11%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.27 ± 10%      -0.1        0.17 ± 30%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.14 ± 17%      -0.1        0.04 ±112%  perf-profile.children.cycles-pp.nfs_unlock_and_release_request
      0.16 ± 13%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.16 ± 22%      -0.1        0.06 ± 50%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.25 ± 26%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.svc_tcp_sendmsg
      0.19 ± 24%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.16 ± 20%      -0.1        0.06 ± 50%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.21 ± 13%      -0.1        0.13 ± 33%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.18 ± 25%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.xas_start
      0.11 ± 38%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.inode_to_bdi
      0.14 ± 23%      -0.1        0.07 ± 52%  perf-profile.children.cycles-pp.kick_pool
      0.16 ± 27%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.xs_stream_data_receive_workfn
      0.19 ± 18%      -0.1        0.12 ± 23%  perf-profile.children.cycles-pp.__queue_work
      0.10 ± 10%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp._find_next_and_bit
      0.09 ± 11%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.17 ± 17%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.09 ± 18%      -0.1        0.04 ±105%  perf-profile.children.cycles-pp.__lock_sock
      0.12 ± 10%      -0.1        0.06 ± 45%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.12 ± 19%      -0.0        0.07 ± 34%  perf-profile.children.cycles-pp.lock_sock_nested
      0.04 ± 73%      +0.0        0.09 ± 28%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.07 ± 14%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.01 ±223%      +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.08 ± 20%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.03 ±143%      +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__dequeue_entity
      0.02 ±141%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.10 ± 17%      +0.1        0.17 ± 18%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.12 ± 19%      +0.1        0.19 ± 17%  perf-profile.children.cycles-pp.update_curr
      0.12 ± 15%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.read_tsc
      0.02 ±142%      +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.call_cpuidle
      0.01 ±223%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.avg_vruntime
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.place_entity
      0.02 ±142%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.06 ± 63%      +0.1        0.17 ± 37%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.12 ± 14%      +0.1        0.23 ± 12%  perf-profile.children.cycles-pp.___perf_sw_event
      0.02 ±144%      +0.1        0.16 ± 69%  perf-profile.children.cycles-pp.llist_add_batch
      0.08 ± 64%      +0.2        0.23 ± 17%  perf-profile.children.cycles-pp.set_next_entity
      0.02 ±223%      +0.2        0.18 ± 24%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.04 ±101%      +0.2        0.22 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.13 ± 20%      +0.2        0.33 ± 15%  perf-profile.children.cycles-pp.prepare_task_switch
      0.15 ± 15%      +0.2        0.35 ± 20%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.11 ± 10%      +0.2        0.30 ± 16%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.40 ± 11%      +0.2        0.62 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.09 ± 23%      +0.2        0.32 ± 21%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.07 ± 50%      +0.2        0.31 ± 21%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.11 ± 24%      +0.2        0.35 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.15 ± 23%      +0.2        0.39 ± 48%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.50 ± 15%      +0.2        0.75 ± 16%  perf-profile.children.cycles-pp.rest_init
      0.50 ± 15%      +0.2        0.75 ± 16%  perf-profile.children.cycles-pp.start_kernel
      0.50 ± 15%      +0.2        0.75 ± 16%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.50 ± 15%      +0.2        0.75 ± 16%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.09 ± 28%      +0.3        0.35 ± 18%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.10 ± 81%      +0.3        0.36 ± 36%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.08 ± 32%      +0.3        0.36 ± 46%  perf-profile.children.cycles-pp.wake_affine
      0.08 ± 33%      +0.3        0.40 ± 44%  perf-profile.children.cycles-pp.available_idle_cpu
      0.22 ± 22%      +0.4        0.60 ± 16%  perf-profile.children.cycles-pp.dequeue_entity
      0.21 ± 21%      +0.4        0.61 ± 31%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.12 ± 30%      +0.4        0.52 ± 10%  perf-profile.children.cycles-pp.__switch_to
      0.26 ± 17%      +0.4        0.67 ± 16%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.22 ± 32%      +0.5        0.68 ± 18%  perf-profile.children.cycles-pp.update_load_avg
      0.17 ± 44%      +0.5        0.66 ± 19%  perf-profile.children.cycles-pp.sched_clock
      0.14 ± 25%      +0.5        0.62 ± 18%  perf-profile.children.cycles-pp.update_rq_clock
      1.82 ±  9%      +0.5        2.35 ± 12%  perf-profile.children.cycles-pp.schedule
      0.10 ± 50%      +0.6        0.70 ± 20%  perf-profile.children.cycles-pp.llist_reverse_order
      0.22 ± 31%      +0.6        0.83 ± 11%  perf-profile.children.cycles-pp.native_sched_clock
      0.19 ± 41%      +0.6        0.83 ± 19%  perf-profile.children.cycles-pp.select_task_rq
      0.11 ± 30%      +0.7        0.82 ± 40%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.24 ± 31%      +0.8        1.01 ± 32%  perf-profile.children.cycles-pp.enqueue_entity
      0.15 ± 29%      +0.8        1.00 ± 42%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.29 ± 26%      +0.9        1.19 ± 31%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.31 ± 23%      +0.9        1.24 ± 30%  perf-profile.children.cycles-pp.activate_task
      0.18 ± 30%      +1.0        1.16 ± 40%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.21 ± 26%      +1.1        1.32 ±130%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.58 ± 17%      +1.1        1.73 ± 14%  perf-profile.children.cycles-pp.schedule_idle
      0.35 ± 24%      +1.3        1.66 ± 24%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.40 ±  8%      +1.6        3.98 ±  9%  perf-profile.children.cycles-pp.__schedule
      0.76 ± 14%      +1.7        2.45 ± 30%  perf-profile.children.cycles-pp.try_to_wake_up
      0.43 ± 33%      +2.1        2.53 ± 22%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.10 ± 19%      +2.3        3.37 ± 85%  perf-profile.children.cycles-pp.folio_wait_bit_common
      4.11 ± 24%      +2.7        6.81 ± 14%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.56 ± 32%      +2.8        3.40 ± 22%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.93 ±159%      +3.6        4.53 ± 89%  perf-profile.children.cycles-pp.intel_idle_irq
      0.00            +3.8        3.78 ± 94%  perf-profile.children.cycles-pp.folio_wait_writeback
      1.51 ± 30%      +4.3        5.79 ± 48%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +4.5        4.54 ± 94%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.72 ± 24%     +10.0       10.77 ± 40%  perf-profile.children.cycles-pp.poll_idle
     10.42 ±  9%     +12.8       23.27 ± 13%  perf-profile.children.cycles-pp.cpuidle_idle_call
      8.76 ± 10%     +12.9       21.66 ± 14%  perf-profile.children.cycles-pp.cpuidle_enter_state
      8.81 ± 10%     +12.9       21.73 ± 14%  perf-profile.children.cycles-pp.cpuidle_enter
     12.90 ± 10%     +18.7       31.60 ± 18%  perf-profile.children.cycles-pp.start_secondary
     13.38 ± 10%     +18.9       32.30 ± 17%  perf-profile.children.cycles-pp.do_idle
     13.40 ± 10%     +19.0       32.35 ± 17%  perf-profile.children.cycles-pp.common_startup_64
     13.40 ± 10%     +19.0       32.35 ± 17%  perf-profile.children.cycles-pp.cpu_startup_entry
     23.04 ± 18%     -21.5        1.54 ±112%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.16 ± 12%      -1.2        2.94 ± 21%  perf-profile.self.cycles-pp.intel_idle
      1.38 ± 16%      -1.2        0.17 ± 70%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.70 ± 22%      -0.6        0.08 ± 84%  perf-profile.self.cycles-pp.nfs_folio_find_private_request
      0.87 ± 15%      -0.4        0.44 ± 19%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.50 ± 21%      -0.4        0.10 ±105%  perf-profile.self.cycles-pp.folio_end_writeback
      0.37 ± 29%      -0.3        0.04 ±105%  perf-profile.self.cycles-pp.kmem_cache_free
      0.33 ± 30%      -0.3        0.04 ±102%  perf-profile.self.cycles-pp.__slab_free
      0.49 ± 11%      -0.2        0.26 ± 17%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.26 ± 32%      -0.2        0.10 ± 34%  perf-profile.self.cycles-pp.mpage_prepare_extent_to_map
      0.30 ± 26%      -0.1        0.17 ± 33%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.20 ± 20%      -0.1        0.10 ± 14%  perf-profile.self.cycles-pp.idle_cpu
      0.18 ± 24%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.20 ± 22%      -0.1        0.11 ± 25%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.09 ± 17%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp._find_next_and_bit
      0.04 ± 73%      +0.0        0.09 ± 28%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.12 ± 16%      +0.1        0.20 ± 15%  perf-profile.self.cycles-pp.read_tsc
      0.02 ±141%      +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.02 ±141%      +0.1        0.09 ± 35%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.01 ±223%      +0.1        0.08 ± 25%  perf-profile.self.cycles-pp.schedule
      0.01 ±223%      +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.03 ±101%      +0.1        0.12 ± 20%  perf-profile.self.cycles-pp.dequeue_entity
      0.09 ± 26%      +0.1        0.18 ± 16%  perf-profile.self.cycles-pp.___perf_sw_event
      0.01 ±223%      +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.avg_vruntime
      0.02 ±141%      +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.05 ± 88%      +0.1        0.15 ± 36%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.02 ±141%      +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.06 ± 52%      +0.1        0.17 ± 77%  perf-profile.self.cycles-pp.ext4_finish_bio
      0.02 ±142%      +0.1        0.12 ± 36%  perf-profile.self.cycles-pp.prepare_task_switch
      0.02 ±141%      +0.1        0.13 ± 27%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.02 ±141%      +0.1        0.13 ± 41%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.05 ± 79%      +0.1        0.16 ± 20%  perf-profile.self.cycles-pp.generic_perform_write
      0.07 ± 15%      +0.1        0.19 ± 24%  perf-profile.self.cycles-pp.update_load_avg
      0.09 ± 14%      +0.1        0.22 ± 21%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.04 ± 73%      +0.1        0.18 ± 45%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.02 ±144%      +0.1        0.16 ± 71%  perf-profile.self.cycles-pp.llist_add_batch
      0.01 ±223%      +0.2        0.17 ± 47%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.02 ±223%      +0.2        0.18 ± 24%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.05 ± 46%      +0.2        0.23 ± 28%  perf-profile.self.cycles-pp.enqueue_entity
      0.05 ± 74%      +0.2        0.26 ± 23%  perf-profile.self.cycles-pp.do_idle
      0.10 ± 23%      +0.2        0.34 ±  8%  perf-profile.self.cycles-pp.__switch_to_asm
      0.07 ± 50%      +0.2        0.31 ± 21%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.09 ± 28%      +0.2        0.34 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.11 ± 26%      +0.2        0.36 ± 54%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.03 ±163%      +0.3        0.30 ± 35%  perf-profile.self.cycles-pp.select_task_rq
      0.07 ± 50%      +0.3        0.36 ± 91%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.3        0.29 ± 98%  perf-profile.self.cycles-pp.__filemap_fdatawait_range
      0.08 ± 33%      +0.3        0.39 ± 45%  perf-profile.self.cycles-pp.available_idle_cpu
      0.02 ±141%      +0.3        0.34 ± 27%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.06 ± 57%      +0.4        0.42 ± 18%  perf-profile.self.cycles-pp.update_rq_clock
      0.14 ± 22%      +0.4        0.50 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.12 ± 33%      +0.4        0.50 ± 11%  perf-profile.self.cycles-pp.__switch_to
      0.01 ±223%      +0.4        0.41 ± 55%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.22 ± 28%      +0.6        0.80 ± 11%  perf-profile.self.cycles-pp.native_sched_clock
      0.10 ± 50%      +0.6        0.70 ± 20%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.6        0.62 ± 89%  perf-profile.self.cycles-pp.folio_wait_writeback
      0.11 ± 30%      +0.7        0.82 ± 41%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.20 ± 20%      +1.1        1.27 ± 73%  perf-profile.self.cycles-pp.folio_wait_bit_common
      0.91 ±163%      +3.6        4.50 ± 89%  perf-profile.self.cycles-pp.intel_idle_irq
      0.71 ± 25%      +9.9       10.64 ± 40%  perf-profile.self.cycles-pp.poll_idle




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


