Return-Path: <linux-nfs+bounces-8806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28B9FD279
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9757818832E3
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E2C135A63;
	Fri, 27 Dec 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt/hVnxD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD9155741
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735290818; cv=fail; b=baoW3mLwmBSCMDsb6WB0O2i6e16h/q1F/rVAGWC7pcjNUsaEh7XQwxj7qJi0a4pIs46bPlsvQV8oL+VeqeEj2LSw73QYJJXEd9xd2zyJbVf75VpStcGzHIM5MmqAnr8DAxLR8OfQM4kXsjaSYy5l6sFHK6n7cDwFxiSInTnLrWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735290818; c=relaxed/simple;
	bh=TXhOLoN6f61xVUoHVMGv+iE0ZH9pFVK47UU01TtG9Pc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hgQrg5cD4xQzWVWNqjB1HfD5wjBinkYByyBMQmWEykLJov68kHwnjq1kTsZZt73wvcJCvvQTOYHMoR1KMFHx5t8H1fwjpG8EFo8lBKFb40P5D+K07LL7eSFTwdNQUw6ajOLHnqPaF68BbgHebl9BUT8tphsnLTGGA3r3MsMH1CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt/hVnxD; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735290815; x=1766826815;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=TXhOLoN6f61xVUoHVMGv+iE0ZH9pFVK47UU01TtG9Pc=;
  b=dt/hVnxDCAEorrOplyDtYq1JPqdZxyj10vPSEUCaMQNC1G+9SmnBLqvI
   6LSQSgTDBN4FniKgKrqN74vaNA2EDyJ0sPbqYCANaFkiJztkxR6Xtt9md
   jIOColO0OXK7519lrAPYf81wSeBwOvTz3tkQqOX+gP7EeyqGoM+DkGBOg
   If7MTaox9FJLUg3oMJayZW27hOkNso0r6bonI3StQHiElgybyDynDG9rK
   DM3ycnqK8CDb+5eURQ/HyiZawIADhxFw/luQ8E0kFvlTNl7pgh4aOU6gr
   lZmOWJWlbAE1cAQ3plE3nRfpl2F3KMqEcYg6FVoP5K8IyySKCYwjg1guB
   A==;
X-CSE-ConnectionGUID: yunQPSWeTke5Upecub+OCQ==
X-CSE-MsgGUID: F87f/HTVS5SbDb3b4BRxgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="35722881"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="35722881"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 01:13:35 -0800
X-CSE-ConnectionGUID: g2M7hWJfRGaMsHf4glHyGw==
X-CSE-MsgGUID: NdmYf9VTTaK/u2bct8o6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105208547"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2024 01:13:35 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 27 Dec 2024 01:13:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 27 Dec 2024 01:13:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 27 Dec 2024 01:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sG/P4Pkl1p3QczrSm5UmPs1N2GLm2YGUuGwyBAJo4LMZkSmSxR5UhL8Eo4X3T9bqksk4UddDcxYP05bfstyykFe/WwGVkvN1OQhuxRlDH52WWm0a0kMW7TXf0atJyT7Z6W3MveSNRINglzG5WlH+5AT2yrarp5+7CJS8jyg9Skh76rfER+6gZRw+5WwxJ/wQYP3Kaf30B7opHiGnn+v8kEGLMKn7+M1tt+t+bs51LAuuSTnW4e7p7HuCgZGbMNQ3cylEpBONpo74GKcIrElifH/+FuBNm8tqeF6set4zPQp/c6P2yoQZbYw/REIuDDE7M0EY9JK9AoSq/M1pvPpAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Lsn+bM21sEos66W/cuWIwFaav8/0YlRVs5jRCFaqU=;
 b=PMYMxFMhuvc7sas0PM31kS6W5Fq0c3w8Z4fNL1fvXtsPb5wcgOofWzID5EvxLkQ+i3CJYF3O13qRuAJrJPmjjjNSvhYPxUWbiSI9EwYRVFjd6yD2NHAXq8D5mwQGzCBN8HO4ByoEpwxhLOxmLaeQahz09cBAUxkIXZJcp6sdjafwYS27+KKr98UPAGvwj1MbDL4Wb1YjuXDBYA49Ijy7y8LTWYMHynRiRg5Jk1y65jNr+oiCrz3klMhkuqJewPqQQ9m4Ub1ylefCcZAHpUQ2181gKV2zNncm8GyJA8zByi6TsdiSb/t56UMmH2YSaILiFxUHOESHi5SazPDftcCHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Fri, 27 Dec
 2024 09:13:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 09:13:27 +0000
Date: Fri, 27 Dec 2024 17:13:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chuck Lever
	<chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [cel:nfsd-testing] [nfsd]  ab62726202:  fsmark.app_overhead 186.4%
 regression
Message-ID: <202412271641.cfba5666-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: e7411f1a-acc8-428f-45cb-08dd2656b975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4w52vcYNKDDDprVMFsQ2XEVu6c6M5RxkciCYs2d9Hn6GRmgnuUAvduYzFv?=
 =?iso-8859-1?Q?iXa1lxjUVEcRyoA0NqfBERCTcl1yHluP8s+dGZv9Hckt+aYvC0X0W6Qea7?=
 =?iso-8859-1?Q?VIgAveXtoCSoqRuBcIhdnFsJ4S6OMWYholObqNxkvWYAnZkKlA6J/xesWr?=
 =?iso-8859-1?Q?oli4UlL8hi+T9w7lmBO1s4wSDFookCi75qGVFKpmSFSsORR7qCVVYNnDHj?=
 =?iso-8859-1?Q?AP51U/v+4XFupDaXQhySk5XUCm95B2nO9Hu6jdEoDjXp8aQo8IFq4FvWf4?=
 =?iso-8859-1?Q?TPNksRhYXdGBLqVfEaef1ZX0vDWXEhrZfCbbYUJGRy5LI7Pkqir0mI7x+B?=
 =?iso-8859-1?Q?0IwopRbTZKBgp9Mec3IWL9DSkUM4tyifIaCW75K4Yh6Wbk6DdFcf4o3Grb?=
 =?iso-8859-1?Q?mkkUPwCoEsiRzHyWozvqa/Vmfq8xubL4Xf9K5ZCXPpPcI3TjPhaf/VOv2g?=
 =?iso-8859-1?Q?mHHJ243X1OQbJgma9tKMbyha/AuEkC2FOQjITGX0eq9+xtHL6f3GxFxZq9?=
 =?iso-8859-1?Q?nK2mz7HH9rwGDYNX72HDMR2BCYG4zRZFexNqrEQRGzYrj53Ul8kjRLhHx7?=
 =?iso-8859-1?Q?CLgW4lF9zB6pCRnRPreKNbXAYgo8mqKtjF1j4jIhSzEITGcJu46x/DQGy7?=
 =?iso-8859-1?Q?9ikwkFXRpd7NKiQPwZUiKLdH1OS4AdqAnfBHFm9LdavxBHDHEbWsAovGvR?=
 =?iso-8859-1?Q?0wsYlxG6Cnb3wXi6RQHvB1ovDhYW+f5hlOxAMBklO9K+GG7SzrlEM4RIZZ?=
 =?iso-8859-1?Q?9DGpriUaftqnvSoow+zR6Vj6ghGnlQYECujYTVataKSFLtWUaPPcRfb38G?=
 =?iso-8859-1?Q?qi8Lb5DXehep7y2zutrnl6YHCR8HXjoW4BJFSn8btfnA3TejTaNzr7YN16?=
 =?iso-8859-1?Q?GdCcdELNaBWjNSVlnQSmoLreY8/hUMt0LVTD7wSQ5zIzn/WtE9PgIiMEJa?=
 =?iso-8859-1?Q?yH5W6SOtQUai2w+9b0YScNofwDIjDrujrXoflcalbjkGldho4T2hXXoyYl?=
 =?iso-8859-1?Q?Yitf8yPR2fAniloPU69lBQDR+WO+6dGKmuUxD32DwOILPn27gBanNT3yab?=
 =?iso-8859-1?Q?6D1hSCxm4EDG+03r+tOTkBojZPWONiCTNijWcubriZNV9m9nOJr922n6y/?=
 =?iso-8859-1?Q?747xHrSFSd44/CS4+t3RcCCtoVgxIn5raHL8hux2lK0R1hY8RZWkELOKmp?=
 =?iso-8859-1?Q?GejgKgZiZwUBbn4+9izCJ2C7l7YOntaHTiG7KnkfT22mbH5MFcVgu+Fwxi?=
 =?iso-8859-1?Q?kkX5hvoZzwnGKLGAaqd3SzKAL7x6QX0Epmm+ETcYrfNdB18q/b95SzMtkm?=
 =?iso-8859-1?Q?GMtUUJv54vKwVsM4Alk5Qqky+BF/aIFZ3jXwhR52AI0NNHlTi/rGNmaxL/?=
 =?iso-8859-1?Q?MK4OjXzUT8+0UpYgggi61xUMOGMuEwxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h26mR4RaYDyB++vYmV+LKhQ8NOJHmL7H+hyf8DgGrJGEdrivpUj8UAbmCJ?=
 =?iso-8859-1?Q?d7ZfDXXsZS3zkc7oiPeOcmWHBhDaxZKHVfwyzk9fi/oBbbsDkGRaQ57CeA?=
 =?iso-8859-1?Q?2WEwmWFlVPOXpzOKCFCQ+1OBh6jJrDg+Oy1cU2PYhigQXm1TrpoZZryDYG?=
 =?iso-8859-1?Q?7hjdnTzUox1c23TAUvcWj1R6LWadTUslr+++CPKethXtebyu0m+s6FQ5ho?=
 =?iso-8859-1?Q?ivgEmV//SFZb9AQx688NPy3q1NjKg4shc1TA94IvnavLJ8u2dp4lebFvP+?=
 =?iso-8859-1?Q?599PrKy/RAbUjM4yUFGVkUhHx1o/ImXi0HuNxk6Wqihst6doDOmublIYM/?=
 =?iso-8859-1?Q?4T/y/mA5y9134d+CWXAlspdGD0vkQ5uQUx7klxXIoMwvHuU7aSGzpEtoo3?=
 =?iso-8859-1?Q?EW5ASFA4Hczh7kTkwwLqKD0xu7Tk7EaSuy5U+bCUmmLmDSVpwFIaXokfsW?=
 =?iso-8859-1?Q?DvtI9avVGJXD298NX/4DMTV9fhK2fG28ojRbMiygIpJVgHtaY2TI2za3hq?=
 =?iso-8859-1?Q?NrrS53WFpQtbUVySn7wtwLkw2y/6YqxgEnwb0Vh/Uyvj1g8dLrWwUi8fN+?=
 =?iso-8859-1?Q?+QBHm2kRVp9xgxqH0f0HnP0gPt26Bi9LaIgp8mYU92GfywJLzs6vj+uM+N?=
 =?iso-8859-1?Q?9MUyVzAmymE4Mfi1gY1n0LcwKd2MyZIPrLXMiDk+lezzX/rOEg7xbi91sO?=
 =?iso-8859-1?Q?pQzK2YcaDT2yFOtXqOgNKTJop/cME3NH9NqcsM0CcNKiD1cTbbXBVDpnxR?=
 =?iso-8859-1?Q?ZJeHSSMKWpAMB3CnH0MZbKcq+cxGMYq6Vq6pBaafeKm2JHQ70mU4MIYnrS?=
 =?iso-8859-1?Q?UCsduu4IA4wZWqygfMl8tWRzAJB05ZxCsbtxDkRCqMH5uwVya/3LtqCV7U?=
 =?iso-8859-1?Q?ENNsk6DjaHG2bMDDWlpyFvSlTLs8stQRPyDtNp2P2ubW/zI2VbNFj1Ll1O?=
 =?iso-8859-1?Q?pYcAdM+Wmo22cHAyAe1/CZDbsCIXr/i2UqE+ZHvTRUurSBxLy+v2kw7Vdj?=
 =?iso-8859-1?Q?O0+ViCo286MMUiQwuMbmutT9EvZS1A+sek9ejViI+FB3CJ4FOMTTBoXlK/?=
 =?iso-8859-1?Q?cio1EIIxITqgs/FjISjVhWlCI4ntiT/VkQExIcUwb9HjVMq8+edOz7L0WT?=
 =?iso-8859-1?Q?Cayk2k+8EhDeiIJXXdcuJd/qOP+HpAtvd1o5rHG7VGl10KtlDEfddNS3IM?=
 =?iso-8859-1?Q?7AwzZVAXYgcqTCFrknwtbcZqiypBOO8RC8CpV8eHWvnux44reGKl3pcaf5?=
 =?iso-8859-1?Q?6Rznor+5eaAmRx1loneCL8s9GzK3H67v5PVXRZ7xJp2N2yWif54apH4Wvb?=
 =?iso-8859-1?Q?BKRzeUxFCjKAJLuyQ4Zt4dg25mD0gjjMZtuWmaUu/9ElSKrkRoic3SLWNL?=
 =?iso-8859-1?Q?qXUwnUoArOuQlI/rp4MoP5j5xKKDJD0jGT/SXnFeHi+LBnFPag/cpXA44f?=
 =?iso-8859-1?Q?nupxX++tRgtzCD7WagXJjFbHF9pvgXayAmZ6RWeRxwldx8Hf9C7saI6zon?=
 =?iso-8859-1?Q?1I3ipuhGRqn591R45dRmOrRnrvNeWQC6N9uKUIQ/u2YWi1zBzGEGulOJcM?=
 =?iso-8859-1?Q?NGajuq7lCdQOpn1kIbeoxsk8l8A9QBOwmGKYBcA+tDDRY9pfahtduX+3cl?=
 =?iso-8859-1?Q?JpSJUH1tl5Ok2P7nJeXfLtFPByWggWlPk6/GUFg8s+agjwksQFUQGY9Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7411f1a-acc8-428f-45cb-08dd2656b975
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 09:13:27.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qvfdb4WOd/M7cKRiq2Y7oYovjZ8xFnoGW6i65c4tUI8GYdWO2Vjy2z9lDGnKYWN8BraEIiwUoHOur8n6+58UVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 186.4% regression of fsmark.app_overhead on:
(but no diff for fsmark.files_per_sec as below (a))


commit: ab627262022ed8c6a68e619ed03a14e47acf2e39 ("nfsd: allocate new session-based DRC slots on demand.")
https://git.kernel.org/cgit/linux/kernel/git/cel/linux nfsd-testing

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	iterations: 1x
	nr_threads: 32t
	disk: 1HDD
	fs: btrfs
	fs2: nfsv4
	filesize: 16MB
	test_size: 15G
	sync_method: NoSync
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412271641.cfba5666-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241227/202412271641.cfba5666-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1HDD/16MB/nfsv4/btrfs/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/NoSync/lkp-icl-2sp7/15G/fsmark

commit: 
  ccd01c7601 ("nfsd: add session slot count to /proc/fs/nfsd/clients/*/info")
  ab62726202 ("nfsd: allocate new session-based DRC slots on demand.")

ccd01c76017847d1 ab627262022ed8c6a68e619ed03 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5.48 ±  9%     +24.9%       6.85 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
     12489           +11.1%      13876        uptime.idle
 3.393e+08 ± 16%    +186.4%  9.717e+08 ±  9%  fsmark.app_overhead
      6.40            +0.0%       6.40        fsmark.files_per_sec     <-------- (a)
      6.00           +27.8%       7.67 ±  6%  fsmark.time.percent_of_cpu_this_job_got
     72.33           +15.8%      83.79        iostat.cpu.idle
     25.91 ±  3%     -44.3%      14.42 ± 11%  iostat.cpu.iowait
     72.08           +11.6       83.64        mpstat.cpu.all.idle%
     26.18 ±  3%     -11.6       14.58 ± 11%  mpstat.cpu.all.iowait%
    153772 ±  5%     +19.1%     183126 ±  8%  meminfo.DirectMap4k
    156099           +19.5%     186594        meminfo.Dirty
    467358           -12.9%     406910 ±  2%  meminfo.Writeback
     72.35           +15.8%      83.79        vmstat.cpu.id
     25.90 ±  3%     -44.3%      14.41 ± 11%  vmstat.cpu.wa
     17.61 ±  3%     -45.8%       9.55 ± 10%  vmstat.procs.b
      5909 ±  2%      -6.2%       5545        vmstat.system.in
      0.03 ± 56%     -73.4%       0.01 ±149%  perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
      0.05 ± 60%     -72.1%       0.02 ±165%  perf-sched.sch_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
      0.07 ± 41%     +36.1%       0.10 ±  8%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
     13.03 ±170%    +566.0%      86.78 ± 77%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_tcp_sendto
    206.83 ± 14%     -31.5%     141.67 ±  6%  perf-sched.wait_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.30 ± 62%     -82.1%       0.05 ±110%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_check_data_free_space
      7.37 ±  4%     -15.8%       6.20 ±  4%  perf-stat.i.MPKI
     44.13 ±  2%      -2.9       41.25 ±  2%  perf-stat.i.cache-miss-rate%
    103.65 ±  2%     +17.9%     122.17 ±  8%  perf-stat.i.cpu-migrations
    627.67 ±  3%     +25.4%     787.18 ±  6%  perf-stat.i.cycles-between-cache-misses
      0.67            +3.7%       0.70        perf-stat.i.ipc
      1.35            +2.2%       1.38        perf-stat.overall.cpi
    373.39            +4.1%     388.79        perf-stat.overall.cycles-between-cache-misses
      0.74            -2.1%       0.73        perf-stat.overall.ipc
    102.89 ±  2%     +17.9%     121.32 ±  8%  perf-stat.ps.cpu-migrations
     39054           +19.0%      46460 ±  2%  proc-vmstat.nr_dirty
     15139            +2.2%      15476        proc-vmstat.nr_kernel_stack
     45710            +1.9%      46570        proc-vmstat.nr_slab_unreclaimable
    116900           -13.5%     101162        proc-vmstat.nr_writeback
     87038           -18.2%      71185 ±  2%  proc-vmstat.nr_zone_write_pending
   6949807            -3.8%    6688660        proc-vmstat.numa_hit
   6882153            -3.8%    6622312        proc-vmstat.numa_local
  13471776            -2.0%   13204489        proc-vmstat.pgalloc_normal
    584292            +3.8%     606391 ±  3%  proc-vmstat.pgfault
     25859            +9.8%      28392 ±  9%  proc-vmstat.pgreuse
      2.02 ±  8%      -0.3        1.71 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.86 ±  8%      -0.3        1.58 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.42 ±  5%      -0.6        2.87 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.96 ±  4%      -0.4        2.55 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.35 ± 45%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.khugepaged
      0.34 ± 46%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.34 ± 46%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.34 ± 47%      -0.2        0.14 ± 72%  perf-profile.children.cycles-pp.collapse_huge_page
      1.21 ± 10%      -0.2        1.01 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.82 ±  9%      -0.1        0.68 ± 10%  perf-profile.children.cycles-pp.update_process_times
      0.41 ±  8%      -0.1        0.29 ± 22%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.21 ±  7%      -0.1        0.11 ± 73%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.55 ± 11%      -0.1        0.46 ± 14%  perf-profile.children.cycles-pp.__set_extent_bit
      0.33 ±  9%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.nfs_request_add_commit_list
      0.17 ±  9%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.readn
      0.08 ± 13%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.load_elf_interp
      1.00 ± 16%      +1.2        2.18 ± 53%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.21 ±  8%      -0.1        0.11 ± 73%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.05 ± 49%      +0.1        0.15 ± 61%  perf-profile.self.cycles-pp.nfs_update_folio
      0.94 ±  5%      +0.2        1.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.25 ± 17%      +0.4        0.63 ± 61%  perf-profile.self.cycles-pp.nfs_page_async_flush




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


