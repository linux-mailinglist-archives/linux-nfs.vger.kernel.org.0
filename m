Return-Path: <linux-nfs+bounces-12515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272E0ADC556
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 10:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C9F3A4492
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABDC28BAAA;
	Tue, 17 Jun 2025 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr3sPdLR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFAF28C036
	for <linux-nfs@vger.kernel.org>; Tue, 17 Jun 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150153; cv=fail; b=rIHiCuauyfnOFlsawfrTYnUo+bx0J4+NQHj54fjgCNeuzwF1j+sVfI1jqVwd7kMAOYR4yJwegzlXHse4flSTGDt9pX9VCWb5jdfn2xD8JI7skJycq6u2mz6MqP/4MfaQovK10whsPkP3/rdzR3aYHUbPmBhxYUX5N/WQrZUg944=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150153; c=relaxed/simple;
	bh=11yId32d4vKjoz2EpVmCbvcfEzaRAQ/r5FbQt8v07iU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mz4fYkxQDAq47+7RUPJ/pyRNpSXNOo29Nek9ctxgbX7I4mK2ruaxrrvcY51H5AqU9lGZ5z+GaGKnq3StuSCnlZjCA+ug6KV7F2cdHcO7HwvJiC76ZeOTcjgs31LP4U1c0XjzsdIyLc+ArNLs5Oo1kTatDTIkioU1l9HGb5cUS9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr3sPdLR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750150152; x=1781686152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=11yId32d4vKjoz2EpVmCbvcfEzaRAQ/r5FbQt8v07iU=;
  b=kr3sPdLRYhz5BGvJxThYtKXAlHBOyrse8FKP0CuFwNNyNqpsPwnfTbAs
   apYIj0kwe/BRAJurXhqOaeY/QIhX1U41xxKbAMuwX0Q+k6MwdcupgxtM4
   0Skj90do7BzNjcUlsmyKNJzIYYQ7HIVTbAkG3Tc3SOFfdJBNXiFskJyMQ
   BupPZMvY9SmoRJ2RTfFQ/Dc9QicGRHbLAdDOYGSE4XTxxELHw7/XQcty8
   AC1JlIgl0I8MaWQ9nPOCbg137981utTaYMYFoLA/SVu79ZHIQ+Bv6cR6/
   XHkyBlgIf2tXEA29U7mY/3m+LboEpz0IGZKjBt92Pr6HDk4n70iahu6t8
   A==;
X-CSE-ConnectionGUID: G354yBh7Q3eMCg2wjoanIA==
X-CSE-MsgGUID: +Tds7yKRR224Iue6tPNCEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="56125431"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="56125431"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 01:49:12 -0700
X-CSE-ConnectionGUID: pcd34T0gSkGNS7dZOMgvjA==
X-CSE-MsgGUID: FxFsHdu1RjCUtxi8jWItPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="171951528"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 01:49:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 01:49:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 01:49:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 01:49:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoVwCME3TcSfHGGhVX+ZYpnSj+c8KnYdaLKMuSZQaeVLIvbdgqetAoIfBE1a84b8xGp6I9wVIyxnKvMnhptSNCLtRTMyGJN3M9zWDD/5Y9ZGveUKw8iWfYo22HPwvHaMB9qfV4dWmjRDhVq3Zm2F8fSDFyL+J+d6IpR6uZzY6Qnep7yLam8/59MF+brCfxttD9pkvyEQGndDXq6zzpn82UpJMwa+O1rxztgYUxmYC2uooPyH6V15xFfxA8wp7eDA+sWoQfJEtFwY5DcNDdaF0LDQCIaVW1vAJcKtk9O3M0EXps3GDfgDEgp3Twos6Xn3267+rdJTzKUObBag0rPkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rntSPbWPjcXygAj2n3G36zVYqOcitXlz1vgeMynjbM=;
 b=zKNtTQKju8PGQxovygAR5aaREtgYpq9Dhc+mYMRoTlzXezpc4pvDD7mlOnZxBEzfgtys1bJeDMpIyDea4/mPkXrw5mKrC58DgUhgl8CtBU4zXzFMtR2sHCyPPJ3ZsCxZkKGAhhsWqNP9EsF+jXo/WHtcApQe9zXvKrzix2RpFalJB/jszS+Vl60/ipLOfshbQqh5ZWMqzIFd8Y8RpIKzbotSfs4XcCpH7q9HO3TRgYvVy946oZyh/u2uOv4dY81jNMlHySMjEXX5+IqRYntP9amlHoE+9CfQj/OEo/NidwgD7J2PufLrTj8SshylIPlm4FuetT1N3k5QkpDKnrOGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:48:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 17 Jun 2025
 08:48:32 +0000
Date: Tue, 17 Jun 2025 16:48:17 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Lance Shelton
	<lance.shelton@hammerspace.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, <linux-nfs@vger.kernel.org>, "Trond
 Myklebust" <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Jeff
 Layton <jlayton@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 2/3] nfs: Add timecreate to nfs inode
Message-ID: <aFEr0edl4bHYtY3u@xsang-OptiPlex-9020>
References: <202506121525.2eac47db-lkp@intel.com>
 <1877A633-7DCE-4598-BEE5-83E854F7DE61@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1877A633-7DCE-4598-BEE5-83E854F7DE61@redhat.com>
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d93968c-4672-45d8-dc0b-08ddad7bbd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p1YEzpGbCN0p5pBYTMrk3/NHBtu/wSQtyHiZCeLzAeLOsNCBvIJjav31xiRE?=
 =?us-ascii?Q?Dk+q3o3WKRR24fLhA73NFSqwltTRpCbiSywh5plXN180ZOXbIDJB88s39jiy?=
 =?us-ascii?Q?idooYjcdof1OwysRl5ozmTxzs4pj7TF9c2S8mHTWBnEzqCPYAqlIfsykwtBV?=
 =?us-ascii?Q?wuqgh/Q5Jop8lx7O+yApPO9SLiUDAXHojX8gTOJAy0EdrlhYwe6Ymt8uFS8J?=
 =?us-ascii?Q?2U3e/FFrosdYRzP+cWsWbGOEOtpRfcnh07BUtnSTr/VBszUQgXIcda+bwnru?=
 =?us-ascii?Q?1Qd2JgO/Tel81nYP5fAJS+2IVNsDiTw0SicuF/PAu/BqvR9tmWC9LeDlAGTP?=
 =?us-ascii?Q?gLQ+2tzMw22UaCcSMM5oNH2MWwej34NiL6f90oYG2XcBGf/tnygb+OxxdzPR?=
 =?us-ascii?Q?F0HBV/tLwe1/ixo2GW6DgIzEyMlKVbxN2DjbTqAvuCZ0jynlF4lNrlV4j19e?=
 =?us-ascii?Q?4R06GZr2C9hoYpEWUxxDFxcDXZltXgZF8aOcTZVwkKB+F4T20h74X9CgXwjQ?=
 =?us-ascii?Q?U2gwcT6Of03VTQ+1BcTL6nT8A1gEhpoqnggHClvUmUFJk26wkGLMwUvrVyYa?=
 =?us-ascii?Q?ljaO1fYinwBVtwMc1/I+KpVyskr1Ipf33w9+m4WZsjGpkpZ9txgYM04qrWU/?=
 =?us-ascii?Q?dwJ7GDNYIl13kNDKPXLJIq7H0TX0X4+EK/XRoma/0k4WM6cE1UxJnG/rgcg7?=
 =?us-ascii?Q?wwqCjOV+mdajFV8CK3QwymiDuJhm5QOWVjRbrmYKWUdw9gLC7rZ3KQPRDPqS?=
 =?us-ascii?Q?W/twiR9PJZzEoy0t0bJDYBaVdi7khS/qojFpDDbjiA816+HL7GWarPNB+KGh?=
 =?us-ascii?Q?ZPzPzcZlVt8bU7jWvmWHZv57A6iQzIepHgrUeySB4FSLZmcHinaLCDj+dAFe?=
 =?us-ascii?Q?MkAUGYRWHwANjgA1T69MveygLmFJfUWIZX2KWMQLVqSnad5BTF/F3h0dtdBp?=
 =?us-ascii?Q?WNgn8FR4Im6HaJTkSH9dAdHLzVuEWuIdDt66yHJ3+twzMEgqu/rFkxpobZsB?=
 =?us-ascii?Q?OGBnyi8iCqZxSnlrEkTMSfsrRCrMRkSx31+1sMHK5KQyGbNXaIdUkTq0GEB0?=
 =?us-ascii?Q?/m0tgTwlF5sGuwLlOZSA4acr0Pq93Uzg2iLs1iIeYjwdtFjmSUN1JbE+qSpf?=
 =?us-ascii?Q?3W8y7+Wm5hZym1puDAzGuoqAGVm//aPluYy0b0wvR6hlnyv3MD3w/cS/SqLp?=
 =?us-ascii?Q?rTQkNQ/rePwDBpgkNYXgAlK34lOoPPHVugsfszvASu0Tjx19FxmFaK2WRf1h?=
 =?us-ascii?Q?yPfgA0rQ2vUQYuDeJs7avTWT5tNIdyHaJ6/MYVTrrQgLlhW6ng0vYDUi7jfm?=
 =?us-ascii?Q?1gFmspFTt2xfGTmYtRCWN8SZQBG25/kw3gWnwVVS3Wpy9zCE7LyGgE3em1pf?=
 =?us-ascii?Q?Pd/Y9Tmw7nlnt1T7+wtG2FTG4fLVjPUEW1p0550cdj253qDdeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rp3vSCuA2Yl4ZQajm1eCVzk03tvgXGJ0fNQaRsZrkRahzJYlRTLK/7Ff/dGT?=
 =?us-ascii?Q?45c0d/mQ8DiDtaqhxv5HRm7RwPBbJBAyjVOux3hadp15LJkqt9QHbH1pJg4g?=
 =?us-ascii?Q?d4TCyw+i10a4Tsw+gTtCr42c8vWGZcXiwqLuohQaYKVYq3M+IHvkwRtrKzaX?=
 =?us-ascii?Q?3FT7UvzclmBhZ7hPZdvc02YKwE/pHo103IgCd0TNDW/wB03iaJEV2b4VZ4Zs?=
 =?us-ascii?Q?i61QY5W9DSNcriCYicOvvHMJPQHmcO9W0AnyTlS0FFbVQE69E87KW9zNnbGx?=
 =?us-ascii?Q?8Sw1NAtw1lDf5OTSorxw2qaifFD3hWTN36Mnka+RNoYoa0tv8w5hVUZJ1trX?=
 =?us-ascii?Q?+Zc+w3wErgor7LKCjVhjN6tf7/bWKfWBLdGbMjQ3fK1XYgegu1r0u/waLCU3?=
 =?us-ascii?Q?OV54r/JXeZwhe1vv5HrshCwZcwA5czc/baSZeqg8PUeXtiEXPzxA26xjAT8w?=
 =?us-ascii?Q?HymlGjj4X1DpxIhN/nMGy5NfUNrP+Bh2yzhZ4AzL6JcGkDNuVstjUgUhXBgz?=
 =?us-ascii?Q?rqn44Nx52oY/RFpgzuyVE7y4hSBQdvFmLAqf/7xPXAV2XMH4YVEhJnoXnCO6?=
 =?us-ascii?Q?1ojG9N8jj/IPHTVOFPBaFGSSkeA5Bx+FAlIehgvjicsT5D0kDgSTwnE9Ic/m?=
 =?us-ascii?Q?BYhzAGefFIIpdT6qxdSQqn/KfHuEXLf1e7fUiYQro+QjjrOKR3QfXU6M2thT?=
 =?us-ascii?Q?1L8nqWGcCEHovz9t6hCj/Arlw2c0pSbpJh8nQO3yZxX07OM2bw1YB2BVGnUu?=
 =?us-ascii?Q?+kSsNDWKXkvNOk92T0x9+Tb6Y0bFIAwqFQHIc/+UCBJYVhEad31kgzlBMSXW?=
 =?us-ascii?Q?BGrU9GrXUO5tmFi+NCGDbw8C7F35J7fO9tZUdLQbzqDTysWNQ+tvJUpNpYmY?=
 =?us-ascii?Q?H7A4j68jMdgj466fduC8LoMHHPnhhEFgprXD6ibZTJHUKkdKb8YvZQPWpSFP?=
 =?us-ascii?Q?a0cgYuURXJu+ZKQFK7b0VN3vdnBTNDX+b5dezLf+TcKMbd4K3BfYGjoG5NE9?=
 =?us-ascii?Q?mXZ+W3KmidM8eXQA5tikUDw8ppzIyDsh/aCm7Apl3heN0T88qryEHddz4E63?=
 =?us-ascii?Q?HrEMoqJNxh5JG+kth8tkzCOrac6rwZDxYWpCeqNVN7XO7gB5QaghbzhZdGxa?=
 =?us-ascii?Q?bcUG85RvU9zqmOmvKzKq5zou77XkrG0SkNwxXSUagCERD3+pO2LKNlRwtWy0?=
 =?us-ascii?Q?c9/1AYiWFuSXqA8IJGSkl4Viwfs7qkFNCKgkrCaVgcPyHt9dJbKAJgcXotk8?=
 =?us-ascii?Q?EeaHbUN7sOuAa4Zd4EydV+5UTfYPgNi+hnLMwhaOhmLpvzkHxMZ7NWGyv+iR?=
 =?us-ascii?Q?EHMN9D4gsoOPe3C77uQmOcYmlcZ9QrqE+E4NGqAbK1FcU0oWd0op9ZI4ZRZ0?=
 =?us-ascii?Q?0z0NWh2nKnAZlqFUmP1do0DEf7bi3xhkPKJ3hkNKC4c01ej/H5qASKBnGt3O?=
 =?us-ascii?Q?X22vomf3TZQpUZ1AKf2hj0XTUUryHLvdyULzZ7ueYLV3gGephM/qRPn0LV9E?=
 =?us-ascii?Q?aS7C+CD+gOV08TGX3D9NK9yzkLeO45UME3a3OruSZ8BWOGeC8+IXbXm9RUpR?=
 =?us-ascii?Q?VKkmuCzH6RseR7D3hMwrWfFgZLFCx4X9rpBTi91Gy4zWMpJ5lpAjf0/6jOIv?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d93968c-4672-45d8-dc0b-08ddad7bbd1e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:48:32.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrWZcR7OPDy1KRkXISXTB5liadqMi/QG1MIDcHyi5aPjhP/noXreIrWD1SasIxj2b8R26PDnleGJxFdt4ZxEYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

hi, Benjamin Coddington,

On Thu, Jun 12, 2025 at 11:32:05AM -0400, Benjamin Coddington wrote:
> On 12 Jun 2025, at 3:22, kernel test robot wrote:
> 
> > Hello,
> >
> > kernel test robot noticed a 41.2% regression of stress-ng.msg.ops_per_sec on:
> 
> Wow, this is really unexpected here - best I can think is that we're mucking
> up cachelines in a very problematic way, but then NFS would have to be
> involved in the test somehow and I don't see evidence of that.
> 
> LKP folks, is there some NFS on the test system that could be in play?  I
> see that you collect nfsstat output, but I don't see that output in the
> details.  Is it possible this report could be an anomaly?

sorry about this, seems this is a wrong report. there is no NFS involved in this
test, so there is no nfsstat monitor enabled while doing tests.

one possibility is fs/ is build earlier, which impacts the kernel image layout.
we observed the cases that stress-ng tests are sensitive to this kind of
alignment changes.

sorry for the wrong report.

> 
> Ben
> 

