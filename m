Return-Path: <linux-nfs+bounces-14978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98583BB8B03
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31E844E14CB
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB7242D7B;
	Sat,  4 Oct 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lG+2ezEr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3913A3ED;
	Sat,  4 Oct 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759563777; cv=fail; b=j8Inja7WZA+8LwGzVUaDJaTAW/C53xjcEWa8aGrQNwqiQ+cNC5YCxfw/rkyJrLHZGvQE19Lh1/TIYqjMVSUS6Hk6V+yHX8UKdgc0harhMlXSmC+DpokpSzuyklKB3ETxnf3fjHCJq7PGHo5f5qD/cJEjeyFfQCd1FSIMTEL9LBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759563777; c=relaxed/simple;
	bh=881Z5Dfq4nE+/hqSGOCaJoOMH2X/H7JVOP/gTKzjdao=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fux04H9Egjn4PCQ3Eo1bGMWGAF6rp+e2vfYoyCWViWPqrR1iq/8uz7OqT90Ll3bAf4nT/CfyTssvosStCQI1Z07RyB33ZQYit5qI3OqoiG2AEWZahA94SCdNNiusOw2UUchblv8+5YHW2dnd9TzKK0AkLQKcJ+5w/GYrcpdG/Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lG+2ezEr; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759563773; x=1791099773;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=881Z5Dfq4nE+/hqSGOCaJoOMH2X/H7JVOP/gTKzjdao=;
  b=lG+2ezErLLItqIXCYoH4h96+Z1g1YoUqGui7WjClf6s4iWvpQA11ci9s
   S5Q9sTEBTvWuyb5tu/qEgaezhPiXsZSM86T37Mx8frB3NrJLUFiXaRLBu
   bswjMWoDZL9zn9uYqKnFCRwo3C7gYJ8lSCsWwtn8p5Q/O4+imTV78zRST
   c91TCypD4RuKVZAHUyPn0phZ7ITdr6ppYfaVczUuJkjkGzoJ9JOQ9j0WP
   pBBIbdrMBuxA+sDtm7UQJSve4aeWJocOGh5FAEZ4CxF3F9atBmkvoLkrB
   ca6Y9XWES8ikJNNaRoStFtdHWrZH0Ruqhyuuwd3xtGe9o4b3lRBz356Kn
   w==;
X-CSE-ConnectionGUID: fDhwmeaNQq6X9d2YkEelJg==
X-CSE-MsgGUID: LlHWmkEfQVubrGh9y6mAWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65658989"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65658989"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2025 00:42:52 -0700
X-CSE-ConnectionGUID: rB9qQ+lTQ2GqlqGSYDv7aw==
X-CSE-MsgGUID: /RKQQdN8SQCltOXW0Tdllg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="183743090"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2025 00:42:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 4 Oct 2025 00:42:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 4 Oct 2025 00:42:51 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 4 Oct 2025 00:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBJ3e7PiBIM6KrAOaHIQGraVASyAs/QBHwJOOs9yC00pAtdWDSzL4ho3tgzyRLRcWxhLKeKMTvTRoxTADQm3jldBqxOjLlngVo25bkKOBQV1PO4XJmxKlZcsOoYHDSlbW1UC8m78wcaPEKuoDkR+zXu4FHCQGpLi5Sugo6z54fYD/CzxfJEM2040y3HTgy0j6dkCOyQjGSwrJOjZQ0ZPAYvT8XORub3mluAclpvLPO+esk1dANX3rXEG1NTkr16ovHNTHL/LeEC33DhRAOpgemeexbsvlVvrwDRy0/L/D6+/5DRIfR8hdlvmffLUwFylSJukwxU/hRzpv3v/eDF2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajxJVpas+9HzXqWKAp72UOVP5V0lnRuIcNpAu8jTB40=;
 b=xDSqEti8yktiOKFZd3xQLxQl2bydFhMp99Ob04+2qlsfubdlQY6NOG0HfjnRr6YTiwqW5+6EVJiMsQaE8GYOSdoZHHgJZzyDnPaZjZMUqC2rEdOogyzVSQNsRWXEThZLh4HBWdN+2m/DHKyfI6kzoRvv5+cpe5+r2axLoBgnUDJh8I4dPT3Bk06PwW3osBTuj5V0cyVRGEkonn8HanJJjIG+2ZVJ27Q12HfDSdi7faiYmqjnGEkMMLSUyoBWOQZG05rHUuLVumGxLzKBkVNT9TpmZrukROu+kLZIfil+owx9TmsxAx8ZxIEf4VN4ieydlAzQ2pAVE+jQG48ToP3UWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Sat, 4 Oct
 2025 07:42:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 07:42:42 +0000
Date: Sat, 4 Oct 2025 15:42:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna Schumaker <anna.schumaker@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [SUNRPC]  d57e43b72b:  fsmark.files_per_sec 36.2%
 improvement
Message-ID: <202510041557.169ee76e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0082.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: fca33417-5eef-4b52-baf1-08de031999b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6pyBfgxtnnhDbSWflSMqnVZ0QYMLAHNbeyaapj6m+Ibtte6Fzjpd0aOx+x?=
 =?iso-8859-1?Q?zrxUdRkLt6F5MW+Ie2MmwnP6x1A58fHDWeZgy9CUPzlx2JZu5/0ydx3/G3?=
 =?iso-8859-1?Q?kPLbNpQbMQw9LFAJYR2eViX2e9EiH3xdEnIFkOVSiaWaAPzEt3uYiSTltG?=
 =?iso-8859-1?Q?DBmVfVSch5IzuKMw+g4nJONScdh2SsR8chRfC22Mk1tLiWESanHnAb0Bi/?=
 =?iso-8859-1?Q?u5+GuPOCy1clJQqTZeVnu0dM3CgfGqGHU+W5mfCYW39O41H6vl890Sylyy?=
 =?iso-8859-1?Q?OTUeKNdTMEd/PRrGliK9VBy2PyovzyjK2Ux5MW8FzG1DCVTfNOUTrUhp7r?=
 =?iso-8859-1?Q?ZQsj3wwkkRIP4zzmC6ZbBBkl1Kyo2jeB/SkmJxsMQBVflsaXXy8Rx0DTgN?=
 =?iso-8859-1?Q?RUUNwivFL8pPd7V6znZKT99PlbmxrLzvwJoyvf20FrVtYDuC95SojjXiI2?=
 =?iso-8859-1?Q?eAPM1i8rkZ0ZotxTy+LOvPixgF9m/uYsPW++j1gw1vOgPvkK6QwgfhYoKb?=
 =?iso-8859-1?Q?Y1fMc60P7MVXDVrA/mOkN71mECLSs4XW7U4JzADOWHtopZa9TVqnfvPyKn?=
 =?iso-8859-1?Q?yv1Y23tPufL6wYDzpRg39GilytZaoiJxFB2GsEJeRp0uu7wjMdomyxbKXZ?=
 =?iso-8859-1?Q?3VHKGa4k/tHQNn3jSc8a/q+C46XdVmgMTh21VokpgVaLSZWGhfFLpCBIgQ?=
 =?iso-8859-1?Q?UZ1YAsvhhjT4/fr24OI/Z4hi/H2GSBi1V4Dr3U928vn2yH+KBo0PUVkSr4?=
 =?iso-8859-1?Q?lhVjvbiZxNboW2tFzEdmgE6mAdWFEjKniRUNHKTINjLeaTS+LelMvI7nJ2?=
 =?iso-8859-1?Q?WXF9d2xlScimv5V2stlvpbGMb+7gGsELMIgELlNIE384iHXn4m7Jb0jttr?=
 =?iso-8859-1?Q?88NobkJpf6HUXjEIbVVrtzS+nbCIa5rNsIZrA7q1mRclFa28G87daH1din?=
 =?iso-8859-1?Q?yDWH76vZPiBAIFSYxrMd6WZ+J0LlQPyYEVFRdMB1ltlHnPAGBSq+5AjI5G?=
 =?iso-8859-1?Q?RK51hbZNiM4WmUuE2a8fa29dKauN7REldK5rgqfR8E9XFOmjOucbtgqP6a?=
 =?iso-8859-1?Q?U363FQOut6WKqhmVP1MFgBKsfoDgVgLb4yhNKo+JITq89ROkBSU8RCyPbS?=
 =?iso-8859-1?Q?jB5GBjfOkGlthriQNmVJD+W48JrKZ9EslDO5I89zD+Zslfj+lvr3pTMXB3?=
 =?iso-8859-1?Q?yOey43NBi5DwVROH/Odtx4s8bVTcRtO+mJMj74viYXvmBzXlGIe3AbFvhV?=
 =?iso-8859-1?Q?s+qXz+i1xtRNBW4Znva/CUX4lLED+FcIwG/VonNeSxk9OALzKYDVxIrlEf?=
 =?iso-8859-1?Q?ou/OF9CQEQus7p1s/Vkxxcgzfcbkny7NxACMQGSv3jPjV2m39oQzo6514s?=
 =?iso-8859-1?Q?4fhnk5g/b+8quq/K0jbmpxnJPQbqVUC/87BvxUhnhzkBm9VvK/dFN2b4QF?=
 =?iso-8859-1?Q?M9auVqe0sRjTvT7TntZzftF5WMnqhC6Y8bTXxTC88/ba19FRyllq4rAdLC?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?buI5LoSfJdqcI+4VSqAtbOQFyE2czOCl/fY3/7A9aYME/jckgPTSGLrpOB?=
 =?iso-8859-1?Q?OwrQq/atPl19UHBvIrofKaxL+6mLQRF60Cws8T3GKdwKRPdoUw45+FT2I0?=
 =?iso-8859-1?Q?vi20G//L55XcB7KBRGWk4WTmzZFuEmUgzZSGvRtQT5Oo62Oyjh1ubAMdap?=
 =?iso-8859-1?Q?/FPVIyfEnjU3goghyumXas1G3xzzKwMA07u72JqXDt2mMsEEl7S3bDVA3/?=
 =?iso-8859-1?Q?OrchUP76pQOggJTrgw4ORoSqoxvRYEWMGi5qay9fiOgPsU1SgM4DBvvswi?=
 =?iso-8859-1?Q?eXebCIAxT0YCsX972y2NFAlzuIUewJXAZwSwvh2Hwly0mM04HsmRVeDfq2?=
 =?iso-8859-1?Q?wrNuhIMnnkHO81JYYBEP1qqDX6whTCHRY+UDaktLHV30oSP6VkcUJ0GeIC?=
 =?iso-8859-1?Q?xp2k6Ou0VyupT/01MZngkTIX4i0157+jAzNwOKXCejiQNp6Meb9R0VNTTA?=
 =?iso-8859-1?Q?PeE2M+gSxCbPK3Ex4YhtrO0e0LoXqsj8x/GTz7+AZHut1x7BN47TCq+KAI?=
 =?iso-8859-1?Q?ur0sfB/44uhYB4enOWPdd/dad+dzQXByFOWj5fSjHetb5LQWSlpDGGSnXn?=
 =?iso-8859-1?Q?VUOezQo0+/1+uP4k15paPkw5EBcW1DKf9kT+QMARlnlOWM/QlHors9/puZ?=
 =?iso-8859-1?Q?4qVMF0N1zDgCRAajJ9jab++OFfX055lQNTjpK6Aglxt8vGVBNWxf5rdV4R?=
 =?iso-8859-1?Q?AmoOOMR4strnPMX7HQqaBuhvYy384dlD5VJwE2MjZ/iCRNnBJLo1zRfnZo?=
 =?iso-8859-1?Q?MX0KzAPPOiAS9S7DqCZ9qWIDrFMMPAw8BmWBuGgojg4msuo09wNUgyktDu?=
 =?iso-8859-1?Q?73XzAcspVYTF2SEBd8ZyjHhD2r0XzXvu3wP8OFd5jG0HW1st6eHcjhypfS?=
 =?iso-8859-1?Q?VwBdvqSnaoqAHFulFaNrc31aLvuIlTph+h23ceLzfblMz1ltQjwKnX4fKt?=
 =?iso-8859-1?Q?WD1DXZJprFhgSgHql4eJuEkA2gl/joBBXPWp66Hobz8WpG7n/2XWwDSl72?=
 =?iso-8859-1?Q?H8z4FjaJORMMesaDt4coLPfSAkntI7aFTANyc/nR7/nZf+WvXvGtCvfgg0?=
 =?iso-8859-1?Q?0VfjsIpkAfnKPyvo2ara7rcrQ1C89IgQQop3xc2QalVSRcLxkXmhoOd9eI?=
 =?iso-8859-1?Q?OHvchrPQKHCnENnbvb3BTJ1wh6w4fqmgJfCiNYAsHLNYsGaRiRtsAYJMJY?=
 =?iso-8859-1?Q?hjcJFelUEZZy9R3UvZYSUe410F8El6c/3AUQz8dDXt6IaJQdcl9kSWKnRX?=
 =?iso-8859-1?Q?LjjEQc+L2oPiVI+IZwXtfu+flBtgYWof19dHi1aSk52HefQPzt1yLWrrNr?=
 =?iso-8859-1?Q?PN2y3/tvP5LpBIfGVJE69ix6S20nBqbaQGtm0wPed0S2Y4XqnTqp1IDUwA?=
 =?iso-8859-1?Q?ZEifLIkJWDJpFdAL7+K8hcS1pFmIKGS5nEROMTW9E9xVGZjroiu/eDpkQl?=
 =?iso-8859-1?Q?pmDY8UlTfrZZBBHvqgqCdDNz+7+mKHYLRCu3019mURfKPTl3bPzKNDSOqe?=
 =?iso-8859-1?Q?Rsp1qqt5mTUrAVBqRuFI8J+wUnzm6O3hP3+7rX+wdRapilWFU2ZVwMZ6ce?=
 =?iso-8859-1?Q?HnzjM/E5QpCDYGoo27sd0qzYlbsn/ng101E9JxLunyxRuSgEDcftpUthtp?=
 =?iso-8859-1?Q?rhVvJHwW6YjY06CSiHDHIRV5ULh0MqYvTbQg69Knh9yTTYFg2cbzMPcg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fca33417-5eef-4b52-baf1-08de031999b9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 07:42:42.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZETZN+uoYPS/pHEVfRJyO9RAsgiQKRbTNHsQoY3YBV/QRhuGn2aqJIe9ObFf/lD4zmVid9kwuIGtZPxkIljhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7648
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 36.2% improvement of fsmark.files_per_sec on:


commit: d57e43b72bf2071caac90da323849c3983a695f0 ("SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
parameters:

	disk: 1BRD_48G
	iterations: 4
	nr_threads: 10%
	fs: btrfs
	fs2: nfsv4
	filesize: 9B
	test_size: 16G
	sync_method: NoSync
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251004/202510041557.169ee76e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-14/performance/1BRD_48G/9B/nfsv4/btrfs/4/x86_64-rhel-9.4/16d/256fpd/10%/debian-13-x86_64-20250902.cgz/NoSync/lkp-csl-2sp10/16G/fsmark

commit: 
  4b7c3b4c67 ("NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()")
  d57e43b72b ("SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()")

4b7c3b4c673d40e4 d57e43b72bf2071caac90da3238 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 6.945e+10           -25.6%  5.167e+10        cpuidle..time
 1.946e+08           -13.2%  1.689e+08        cpuidle..usage
      4.13            -7.9%       3.80        iostat.cpu.iowait
      4.40            +7.0%       4.70        iostat.cpu.system
  16849269 ±  3%     -88.1%    2000061 ± 42%  numa-numastat.node2.local_node
  16926645 ±  3%     -87.7%    2083234 ± 40%  numa-numastat.node2.numa_hit
    438.07           -21.8%     342.71        uptime.boot
     76707           -21.8%      59987        uptime.idle
    127372 ±  2%     +33.1%     169486 ±  3%  meminfo.Mapped
   1432954           +12.2%    1607700 ±  2%  meminfo.Shmem
     14697 ±  6%     -31.0%      10137 ± 21%  meminfo.Writeback
      0.79 ±  4%      +0.3        1.06 ±  8%  mpstat.cpu.all.irq%
      0.39            -0.1        0.32 ±  3%  mpstat.cpu.all.soft%
      0.13 ±  2%      +0.0        0.18 ±  2%  mpstat.cpu.all.usr%
     10589 ± 10%     -24.8%       7967 ±  8%  perf-c2c.DRAM.remote
      7384 ± 12%     +40.3%      10362 ±  7%  perf-c2c.HITM.local
      6213 ± 10%     -23.5%       4751 ±  8%  perf-c2c.HITM.remote
 4.426e+08           -20.8%  3.505e+08        fsmark.app_overhead
     11622           +36.2%      15834        fsmark.files_per_sec
    378.75           -25.3%     282.92        fsmark.time.elapsed_time
    378.75           -25.3%     282.92        fsmark.time.elapsed_time.max
     15259            -9.2%      13858        fsmark.time.minor_page_faults
     77.00           +39.2%     107.20 ±  2%  fsmark.time.percent_of_cpu_this_job_got
  17765439            +1.7%   18070052        fsmark.time.voluntary_context_switches
      0.00           -25.0%       0.00        perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.00           -25.0%       0.00        perf-sched.total_sch_delay.average.ms
      1.71 ±  2%     -23.5%       1.31 ±  5%  perf-sched.total_wait_and_delay.average.ms
   1424280           +19.6%    1703120 ±  2%  perf-sched.total_wait_and_delay.count.ms
      1.71 ±  2%     -23.5%       1.31 ±  5%  perf-sched.total_wait_time.average.ms
      1.71 ±  2%     -23.5%       1.31 ±  5%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
   1424280           +19.6%    1703120 ±  2%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      1.71 ±  2%     -23.5%       1.31 ±  5%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      2930            -7.3%       2716        turbostat.Bzy_MHz
      5.79            +0.4        6.23        turbostat.C1%
     16.07            -1.6       14.46 ±  2%  turbostat.C1E%
      3.76          +140.3%       9.04 ± 25%  turbostat.CPU%c6
      0.19           +25.3%       0.24        turbostat.IPC
  82120292           -20.6%   65176235        turbostat.IRQ
      3.54 ±  6%    +126.5%       8.01 ± 42%  turbostat.Pkg%pc2
      0.02 ± 20%     +50.0%       0.04 ± 13%  turbostat.Pkg%pc6
     26594 ± 24%    -100.0%       0.01        numa-meminfo.node2.Dirty
   5105923 ±  7%     -71.9%    1434924 ± 50%  numa-meminfo.node2.FilePages
   4925988 ±  6%     -72.7%    1344001 ± 56%  numa-meminfo.node2.Inactive
   4925988 ±  6%     -72.7%    1344001 ± 56%  numa-meminfo.node2.Inactive(file)
   1491274 ±  2%     -67.1%     490462 ± 53%  numa-meminfo.node2.KReclaimable
  24084826 ±  2%     +25.6%   30247955 ±  3%  numa-meminfo.node2.MemFree
   8933397 ±  6%     -69.0%    2770268 ± 43%  numa-meminfo.node2.MemUsed
   1491274 ±  2%     -67.1%     490462 ± 53%  numa-meminfo.node2.SReclaimable
    459543 ±  4%     -67.9%     147298 ± 25%  numa-meminfo.node2.SUnreclaim
   1950817 ±  3%     -67.3%     637761 ± 47%  numa-meminfo.node2.Slab
      8435 ±  4%     +10.4%       9315 ±  3%  numa-meminfo.node3.KernelStack
     51709 ±  8%    +105.2%     106087 ± 17%  numa-meminfo.node3.Mapped
   6539678 ± 20%     -88.4%     755958 ± 58%  numa-vmstat.node2.nr_dirtied
      6656 ± 25%    -100.0%       0.00 ± 81%  numa-vmstat.node2.nr_dirty
   1276655 ±  7%     -71.9%     358644 ± 50%  numa-vmstat.node2.nr_file_pages
   6020865 ±  2%     +25.6%    7562172 ±  3%  numa-vmstat.node2.nr_free_pages
   5992794 ±  2%     +25.9%    7542064 ±  3%  numa-vmstat.node2.nr_free_pages_blocks
   1231668 ±  6%     -72.7%     335913 ± 56%  numa-vmstat.node2.nr_inactive_file
    372832 ±  2%     -67.1%     122578 ± 53%  numa-vmstat.node2.nr_slab_reclaimable
    114932 ±  4%     -68.0%      36802 ± 25%  numa-vmstat.node2.nr_slab_unreclaimable
    916.39 ±  4%     -41.7%     534.11 ± 49%  numa-vmstat.node2.nr_writeback
   6528726 ± 20%     -88.4%     755958 ± 58%  numa-vmstat.node2.nr_written
   1231666 ±  6%     -72.7%     335913 ± 56%  numa-vmstat.node2.nr_zone_inactive_file
      7586 ± 22%     -93.0%     534.21 ± 49%  numa-vmstat.node2.nr_zone_write_pending
  16925710 ±  3%     -87.7%    2082626 ± 41%  numa-vmstat.node2.numa_hit
  16848334 ±  3%     -88.1%    1999454 ± 42%  numa-vmstat.node2.numa_local
      8436 ±  4%     +10.4%       9317 ±  3%  numa-vmstat.node3.nr_kernel_stack
     12317 ±  7%    +111.9%      26103 ± 17%  numa-vmstat.node3.nr_mapped
    965.04 ±  3%     -24.4%     729.32 ± 39%  numa-vmstat.node3.nr_writeback
    786938            +4.9%     825548        proc-vmstat.nr_active_anon
    429635            -1.2%     424542        proc-vmstat.nr_anon_pages
  25754345            +9.4%   28187855        proc-vmstat.nr_dirtied
   6213498            +1.5%    6309388        proc-vmstat.nr_file_pages
     32196 ±  2%     +33.0%      42817 ±  3%  proc-vmstat.nr_mapped
    106.03          -100.0%       0.00        proc-vmstat.nr_mlock
    358198           +12.2%     401894 ±  2%  proc-vmstat.nr_shmem
    467675            -2.7%     454902        proc-vmstat.nr_slab_unreclaimable
      3700 ±  4%     -37.0%       2331 ± 14%  proc-vmstat.nr_writeback
  25714031            +9.5%   28148311        proc-vmstat.nr_written
    786938            +4.9%     825548        proc-vmstat.nr_zone_active_anon
  68359692            +3.9%   71001927        proc-vmstat.numa_hit
  68059961            +3.9%   70699728        proc-vmstat.numa_local
     71247 ± 18%     -59.9%      28579 ± 40%  proc-vmstat.numa_pages_migrated
   2003325 ±  2%      -3.7%    1929203 ±  2%  proc-vmstat.numa_pte_updates
  86997496            +3.0%   89591861        proc-vmstat.pgalloc_normal
   1554962           -19.7%    1248156        proc-vmstat.pgfault
  78041322            +3.3%   80619407        proc-vmstat.pgfree
     71247 ± 18%     -59.9%      28579 ± 40%  proc-vmstat.pgmigrate_success
 1.422e+08           +14.2%  1.624e+08        proc-vmstat.pgpgout
     60029 ±  2%     -16.5%      50154 ±  5%  proc-vmstat.pgreuse
      3634 ± 17%     -80.6%     704.23 ± 36%  sched_debug.cfs_rq:/.avg_vruntime.min
     14.00 ± 99%    +372.4%      66.13 ± 67%  sched_debug.cfs_rq:/.left_deadline.avg
     13.99 ± 99%    +372.7%      66.12 ± 67%  sched_debug.cfs_rq:/.left_vruntime.avg
      3634 ± 17%     -80.6%     704.23 ± 36%  sched_debug.cfs_rq:/.min_vruntime.min
     13.99 ± 99%    +372.7%      66.12 ± 67%  sched_debug.cfs_rq:/.right_vruntime.avg
     63.38 ±  9%     +21.5%      77.02 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
     63.18 ±  9%     +21.7%      76.88 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      9.57 ± 18%     +26.4%      12.10 ±  8%  sched_debug.cfs_rq:/.util_est.avg
    384.35 ±  5%     +19.0%     457.34 ±  7%  sched_debug.cfs_rq:/.util_est.max
   1796330 ±  4%     -30.0%    1258198 ±  8%  sched_debug.cpu.avg_idle.avg
     15616 ± 20%     -53.8%       7212 ± 16%  sched_debug.cpu.avg_idle.min
   1079516 ±  6%     -19.8%     865265 ±  3%  sched_debug.cpu.avg_idle.stddev
    220712 ±  7%     -21.6%     173130 ±  7%  sched_debug.cpu.clock.avg
    220724 ±  7%     -21.6%     173142 ±  7%  sched_debug.cpu.clock.max
    220699 ±  7%     -21.6%     173118 ±  7%  sched_debug.cpu.clock.min
    218768 ±  7%     -21.6%     171523 ±  7%  sched_debug.cpu.clock_task.avg
    219345 ±  7%     -21.5%     172206 ±  7%  sched_debug.cpu.clock_task.max
    207096 ±  8%     -22.8%     159836 ±  7%  sched_debug.cpu.clock_task.min
    888.16           +12.1%     995.46 ±  4%  sched_debug.cpu.clock_task.stddev
   1296629           -28.1%     932903 ±  3%  sched_debug.cpu.max_idle_balance_cost.avg
    761006 ±  6%     -34.3%     500000        sched_debug.cpu.max_idle_balance_cost.min
    170092 ±  6%     +92.5%     327366 ±  3%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  5%     +19.3%       0.00 ±  8%  sched_debug.cpu.next_balance.stddev
      0.04 ± 10%     +23.6%       0.05 ± 12%  sched_debug.cpu.nr_running.avg
   1014038 ±  6%     +53.9%    1560386 ±  6%  sched_debug.cpu.nr_switches.max
    213084 ± 10%     -99.6%     935.08 ± 19%  sched_debug.cpu.nr_switches.min
    157890 ±  8%    +207.0%     484721 ±  4%  sched_debug.cpu.nr_switches.stddev
      0.11 ±  6%     -13.8%       0.10 ±  7%  sched_debug.cpu.nr_uninterruptible.avg
    -23.76           +72.4%     -40.96        sched_debug.cpu.nr_uninterruptible.min
    220700 ±  7%     -21.6%     173118 ±  7%  sched_debug.cpu_clk
    219704 ±  7%     -21.7%     172123 ±  7%  sched_debug.ktime
    221494 ±  7%     -21.5%     173915 ±  7%  sched_debug.sched_clk
      6.75           -36.5%       4.29 ±  2%  perf-stat.i.MPKI
 2.403e+09           +27.9%  3.072e+09        perf-stat.i.branch-instructions
      1.60            +0.1        1.65        perf-stat.i.branch-miss-rate%
  38302708           +28.9%   49375400 ±  3%  perf-stat.i.branch-misses
     31.02           -12.7       18.28 ±  4%  perf-stat.i.cache-miss-rate%
  76745919           -21.4%   60353502        perf-stat.i.cache-misses
  2.45e+08           +35.0%  3.306e+08 ±  3%  perf-stat.i.cache-references
    680480           +27.0%     863979        perf-stat.i.context-switches
      2.59           -18.0%       2.13        perf-stat.i.cpi
  2.95e+10            +3.8%  3.063e+10        perf-stat.i.cpu-cycles
    412.88            +8.2%     446.85        perf-stat.i.cpu-migrations
    387.19           +30.7%     506.22        perf-stat.i.cycles-between-cache-misses
 1.176e+10           +28.8%  1.514e+10        perf-stat.i.instructions
      0.40           +22.8%       0.49        perf-stat.i.ipc
      3.54           +27.0%       4.50        perf-stat.i.metric.K/sec
      3818            +5.9%       4043        perf-stat.i.minor-faults
      3818            +5.9%       4043        perf-stat.i.page-faults
      6.53           -38.9%       3.99 ±  2%  perf-stat.overall.MPKI
     31.32           -13.0       18.28 ±  4%  perf-stat.overall.cache-miss-rate%
      2.51           -19.3%       2.02        perf-stat.overall.cpi
    384.52           +32.1%     507.83        perf-stat.overall.cycles-between-cache-misses
      0.40           +24.0%       0.49        perf-stat.overall.ipc
 2.397e+09           +27.8%  3.063e+09        perf-stat.ps.branch-instructions
  38196493           +28.7%   49171844 ±  3%  perf-stat.ps.branch-misses
  76539162           -21.4%   60154737        perf-stat.ps.cache-misses
 2.444e+08           +34.9%  3.296e+08 ±  3%  perf-stat.ps.cache-references
    678678           +26.9%     861321        perf-stat.ps.context-switches
 2.943e+10            +3.8%  3.054e+10        perf-stat.ps.cpu-cycles
    412.00            +8.2%     445.68        perf-stat.ps.cpu-migrations
 1.173e+10           +28.7%  1.509e+10        perf-stat.ps.instructions
      3803            +5.7%       4021        perf-stat.ps.minor-faults
      3803            +5.7%       4021        perf-stat.ps.page-faults
 4.453e+12            -3.8%  4.284e+12        perf-stat.total.instructions
     26.16            -4.1       22.01 ±  5%  perf-profile.calltrace.cycles-pp.nfsd.kthread.ret_from_fork.ret_from_fork_asm
     25.54            -4.1       21.39 ±  5%  perf-profile.calltrace.cycles-pp.svc_handle_xprt.svc_recv.nfsd.kthread.ret_from_fork
     26.13            -4.1       21.99 ±  5%  perf-profile.calltrace.cycles-pp.svc_recv.nfsd.kthread.ret_from_fork.ret_from_fork_asm
     39.65            -3.1       36.56 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     15.22 ±  2%      -2.3       12.95 ±  5%  perf-profile.calltrace.cycles-pp.svc_process_common.svc_process.svc_handle_xprt.svc_recv.nfsd
     15.24 ±  2%      -2.3       12.98 ±  5%  perf-profile.calltrace.cycles-pp.svc_process.svc_handle_xprt.svc_recv.nfsd.kthread
     14.64 ±  2%      -2.2       12.44 ±  5%  perf-profile.calltrace.cycles-pp.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt.svc_recv
     14.26 ±  2%      -2.2       12.10 ±  5%  perf-profile.calltrace.cycles-pp.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt
     37.60            -1.7       35.91        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     37.60            -1.7       35.91        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     37.60            -1.7       35.91        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      8.41 ±  2%      -1.4        6.99 ±  7%  perf-profile.calltrace.cycles-pp.svc_send.svc_handle_xprt.svc_recv.nfsd.kthread
      8.38 ±  2%      -1.4        6.98 ±  7%  perf-profile.calltrace.cycles-pp.svc_tcp_sendto.svc_send.svc_handle_xprt.svc_recv.nfsd
      1.84 ±  5%      -1.3        0.56 ± 92%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      8.95            -1.2        7.73 ±  5%  perf-profile.calltrace.cycles-pp.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
      8.28 ±  2%      -1.2        7.08 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.btrfs_do_write_iter.vfs_iocb_iter_write.nfsd_vfs_write.nfsd4_write
      8.84 ±  2%      -1.2        7.65 ±  5%  perf-profile.calltrace.cycles-pp.vfs_iocb_iter_write.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch
      8.86            -1.2        7.67 ±  5%  perf-profile.calltrace.cycles-pp.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
      8.83 ±  2%      -1.2        7.64 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_iocb_iter_write.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound
      4.97 ±  2%      -1.0        3.93 ± 10%  perf-profile.calltrace.cycles-pp.__mutex_lock.svc_tcp_sendto.svc_send.svc_handle_xprt.svc_recv
      1.91 ±  5%      -1.0        0.90 ± 36%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.16 ±  2%      -1.0        2.19 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_do_write_iter
      3.75 ±  2%      -0.9        2.89 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_do_write_iter.vfs_iocb_iter_write.nfsd_vfs_write
      3.73 ±  2%      -0.9        2.88 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_do_write_iter.vfs_iocb_iter_write
      3.05 ±  2%      -0.8        2.22 ± 16%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.svc_tcp_sendto.svc_send.svc_handle_xprt
      4.54 ±  5%      -0.6        3.91 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.52 ±  3%      -0.6        0.90 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_run_delalloc_range.writepage_delalloc.extent_writepage.extent_write_cache_pages.btrfs_writepages
      1.51 ±  3%      -0.6        0.89 ±  8%  perf-profile.calltrace.cycles-pp.cow_file_range.btrfs_run_delalloc_range.writepage_delalloc.extent_writepage.extent_write_cache_pages
      1.51 ±  3%      -0.6        0.89 ±  7%  perf-profile.calltrace.cycles-pp.cow_file_range_inline.cow_file_range.btrfs_run_delalloc_range.writepage_delalloc.extent_writepage
      4.72 ±  4%      -0.6        4.10 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.64 ±  3%      -0.6        1.04 ±  7%  perf-profile.calltrace.cycles-pp.writepage_delalloc.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages
      1.32 ±  3%      -0.6        0.73 ±  8%  perf-profile.calltrace.cycles-pp.__cow_file_range_inline.cow_file_range_inline.cow_file_range.btrfs_run_delalloc_range.writepage_delalloc
      1.65 ±  2%      -0.6        1.06 ±  6%  perf-profile.calltrace.cycles-pp.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
      1.72 ±  3%      -0.6        1.14 ±  6%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file.btrfs_do_write_iter
      1.70 ±  3%      -0.6        1.12 ±  6%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops
      1.69 ±  3%      -0.6        1.11 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range
      1.68 ±  3%      -0.6        1.11 ±  6%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      1.71 ±  3%      -0.6        1.13 ±  6%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file
      1.72 ±  3%      -0.6        1.14 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file.btrfs_do_write_iter.vfs_iocb_iter_write
      1.73 ±  3%      -0.6        1.15 ±  6%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.btrfs_do_write_iter.vfs_iocb_iter_write.nfsd_vfs_write
      2.73 ±  2%      -0.6        2.18 ±  4%  perf-profile.calltrace.cycles-pp.nfsd4_open.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
      1.61 ±  4%      -0.5        1.06 ±  5%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.55 ±  4%      -0.5        1.00 ±  4%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.21 ±  2%      -0.5        1.71 ±  5%  perf-profile.calltrace.cycles-pp.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      2.33 ±  2%      -0.5        1.85 ±  5%  perf-profile.calltrace.cycles-pp.do_open_lookup.nfsd4_open.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
      2.26 ±  2%      -0.5        1.78 ±  5%  perf-profile.calltrace.cycles-pp.nfsd4_create_file.do_open_lookup.nfsd4_open.nfsd4_proc_compound.nfsd_dispatch
      1.60 ±  3%      -0.4        1.17 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_create_common.vfs_create.dentry_create.nfsd4_create_file.do_open_lookup
      1.69 ±  2%      -0.4        1.26 ±  5%  perf-profile.calltrace.cycles-pp.svc_tcp_recvfrom.svc_handle_xprt.svc_recv.nfsd.kthread
      1.70 ±  3%      -0.4        1.28 ±  5%  perf-profile.calltrace.cycles-pp.vfs_create.dentry_create.nfsd4_create_file.do_open_lookup.nfsd4_open
      1.73 ±  3%      -0.4        1.33 ±  5%  perf-profile.calltrace.cycles-pp.dentry_create.nfsd4_create_file.do_open_lookup.nfsd4_open.nfsd4_proc_compound
      1.39 ±  3%      -0.4        1.01 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.vfs_create.dentry_create.nfsd4_create_file
      0.98 ±  7%      -0.4        0.62 ±  7%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq
      0.99 ±  7%      -0.4        0.63 ±  7%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state
      0.79 ±  2%      -0.3        0.45 ± 50%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.vfs_create.dentry_create
      1.37 ±  6%      -0.3        1.03 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
      0.73 ±  2%      -0.3        0.42 ± 50%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.vfs_create
      1.67 ±  2%      -0.3        1.38 ±  4%  perf-profile.calltrace.cycles-pp.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
      0.69 ±  2%      -0.3        0.43 ± 50%  perf-profile.calltrace.cycles-pp.nfsd_set_fh_dentry.__fh_verify.fh_verify.nfsd4_putfh.nfsd4_proc_compound
      3.21            -0.3        2.96 ±  3%  perf-profile.calltrace.cycles-pp.svc_tcp_sendmsg.svc_tcp_sendto.svc_send.svc_handle_xprt.svc_recv
      3.14            -0.2        2.90 ±  3%  perf-profile.calltrace.cycles-pp.sock_sendmsg.svc_tcp_sendmsg.svc_tcp_sendto.svc_send.svc_handle_xprt
      3.10            -0.2        2.87 ±  3%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.svc_tcp_sendmsg.svc_tcp_sendto.svc_send
      1.33 ±  3%      -0.2        1.10 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent
      1.28 ±  3%      -0.2        1.07 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log.btrfs_log_inode
      0.90 ±  3%      -0.2        0.71 ±  4%  perf-profile.calltrace.cycles-pp.nfsd4_putfh.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
      0.88 ±  3%      -0.2        0.69 ±  4%  perf-profile.calltrace.cycles-pp.__fh_verify.fh_verify.nfsd4_putfh.nfsd4_proc_compound.nfsd_dispatch
      0.85 ±  2%      -0.2        0.66 ±  6%  perf-profile.calltrace.cycles-pp.svc_tcp_read_marker.svc_tcp_recvfrom.svc_handle_xprt.svc_recv.nfsd
      0.88 ±  3%      -0.2        0.70 ±  4%  perf-profile.calltrace.cycles-pp.fh_verify.nfsd4_putfh.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
      0.82            -0.2        0.64 ±  7%  perf-profile.calltrace.cycles-pp.sock_recvmsg.svc_tcp_sock_recvmsg.svc_tcp_read_marker.svc_tcp_recvfrom.svc_handle_xprt
      0.81 ±  2%      -0.2        0.64 ±  7%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.svc_tcp_sock_recvmsg.svc_tcp_read_marker.svc_tcp_recvfrom
      0.82            -0.2        0.65 ±  7%  perf-profile.calltrace.cycles-pp.svc_tcp_sock_recvmsg.svc_tcp_read_marker.svc_tcp_recvfrom.svc_handle_xprt.svc_recv
      0.80            -0.2        0.64 ±  7%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.svc_tcp_sock_recvmsg.svc_tcp_read_marker
      1.75 ±  2%      -0.1        1.62 ±  3%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.svc_tcp_sendto.svc_send.svc_handle_xprt
      0.84 ±  3%      +0.1        0.90        perf-profile.calltrace.cycles-pp.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish.ip6_input.__netif_receive_skb_one_core
      0.87 ±  3%      +0.1        0.93        perf-profile.calltrace.cycles-pp.ip6_input.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.86 ±  3%      +0.1        0.92        perf-profile.calltrace.cycles-pp.ip6_protocol_deliver_rcu.ip6_input_finish.ip6_input.__netif_receive_skb_one_core.process_backlog
      0.86 ±  3%      +0.1        0.92        perf-profile.calltrace.cycles-pp.ip6_input_finish.ip6_input.__netif_receive_skb_one_core.process_backlog.__napi_poll
      1.38            +0.1        1.45 ±  2%  perf-profile.calltrace.cycles-pp.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb
      1.13 ±  3%      +0.1        1.19 ±  2%  perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.58 ±  3%      +0.1        0.65 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      1.44 ±  2%      +0.1        1.51 ±  2%  perf-profile.calltrace.cycles-pp.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      0.93 ±  3%      +0.1        0.99        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      0.91 ±  3%      +0.1        0.98        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      0.64 ±  2%      +0.1        0.71 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.93 ±  3%      +0.1        1.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      1.48 ±  2%      +0.1        1.56 ±  2%  perf-profile.calltrace.cycles-pp.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      0.85 ±  2%      +0.1        0.93 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.91            +0.1        1.00 ±  3%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.15            +0.1        1.24 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.56            +0.1        1.67 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.71            +0.2        0.87 ±  8%  perf-profile.calltrace.cycles-pp.xprt_request_transmit.xprt_transmit.call_transmit.__rpc_execute.rpc_execute
      0.55 ±  4%      +0.2        0.72 ±  3%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.xs_sock_recvmsg.xs_read_xdr_buf.xs_read_stream_request
      0.54 ±  4%      +0.2        0.72 ±  3%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.xs_sock_recvmsg.xs_read_xdr_buf
      0.55 ±  5%      +0.2        0.73 ±  3%  perf-profile.calltrace.cycles-pp.sock_recvmsg.xs_sock_recvmsg.xs_read_xdr_buf.xs_read_stream_request.xs_read_stream
      0.55 ±  5%      +0.2        0.73 ±  3%  perf-profile.calltrace.cycles-pp.xs_sock_recvmsg.xs_read_xdr_buf.xs_read_stream_request.xs_read_stream.xs_stream_data_receive_workfn
      0.56 ±  4%      +0.2        0.74 ±  3%  perf-profile.calltrace.cycles-pp.xs_read_xdr_buf.xs_read_stream_request.xs_read_stream.xs_stream_data_receive_workfn.process_one_work
      0.76            +0.2        0.94 ±  7%  perf-profile.calltrace.cycles-pp.xprt_transmit.call_transmit.__rpc_execute.rpc_execute.rpc_run_task
      0.57 ±  2%      +0.2        0.76 ±  6%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio
      0.57 ±  2%      +0.2        0.76 ±  6%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      0.58 ±  4%      +0.2        0.77 ±  3%  perf-profile.calltrace.cycles-pp.xs_read_stream_request.xs_read_stream.xs_stream_data_receive_workfn.process_one_work.worker_thread
      0.59            +0.2        0.79 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages
      0.65            +0.2        0.85 ±  6%  perf-profile.calltrace.cycles-pp._nfs4_open_and_get_state._nfs4_do_open.nfs4_do_open.nfs4_atomic_open.nfs_atomic_open
      0.80            +0.2        1.00 ±  6%  perf-profile.calltrace.cycles-pp.call_transmit.__rpc_execute.rpc_execute.rpc_run_task.nfs4_do_call_sync
      0.77 ±  5%      +0.2        1.00        perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.xs_sock_recvmsg.xs_read_stream.xs_stream_data_receive_workfn
      0.76 ±  5%      +0.2        0.99 ±  2%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.xs_sock_recvmsg.xs_read_stream
      0.77 ±  5%      +0.2        1.00 ±  2%  perf-profile.calltrace.cycles-pp.sock_recvmsg.xs_sock_recvmsg.xs_read_stream.xs_stream_data_receive_workfn.process_one_work
      0.73            +0.2        0.97 ±  5%  perf-profile.calltrace.cycles-pp._nfs4_do_open.nfs4_do_open.nfs4_atomic_open.nfs_atomic_open.lookup_open
      0.73            +0.2        0.97 ±  5%  perf-profile.calltrace.cycles-pp.nfs4_do_open.nfs4_atomic_open.nfs_atomic_open.lookup_open.open_last_lookups
      0.77 ±  5%      +0.2        1.01 ±  2%  perf-profile.calltrace.cycles-pp.xs_sock_recvmsg.xs_read_stream.xs_stream_data_receive_workfn.process_one_work.worker_thread
      0.73            +0.2        0.97 ±  5%  perf-profile.calltrace.cycles-pp.nfs4_atomic_open.nfs_atomic_open.lookup_open.open_last_lookups.path_openat
      0.80            +0.2        1.04 ±  5%  perf-profile.calltrace.cycles-pp.nfs_atomic_open.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.86 ±  2%      +0.3        1.12 ±  5%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.89 ±  2%      +0.3        1.16 ±  5%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.45 ± 50%      +0.3        0.75 ± 10%  perf-profile.calltrace.cycles-pp.rpc_release_task.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread
      1.96 ±  6%      +0.3        2.26 ±  6%  perf-profile.calltrace.cycles-pp.xprt_request_transmit.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule
      1.05            +0.3        1.36 ±  6%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04            +0.3        1.35 ±  6%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.08            +0.3        1.39 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ± 81%      +0.3        0.64 ± 12%  perf-profile.calltrace.cycles-pp.start_log_trans.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_do_write_iter
      1.07            +0.3        1.39 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00 ±  3%      +0.3        1.33 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ± 81%      +0.4        0.68 ±  7%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.05 ±  6%      +0.4        2.42 ±  6%  perf-profile.calltrace.cycles-pp.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work
      0.21 ±122%      +0.4        0.63 ± 12%  perf-profile.calltrace.cycles-pp.__mutex_lock.start_log_trans.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      2.16 ±  5%      +0.4        2.59 ±  6%  perf-profile.calltrace.cycles-pp.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread
      1.08 ±  2%      +0.5        1.55 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
      1.08 ±  2%      +0.5        1.55 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_submit_bbio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      0.11 ±200%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.xprt_sock_sendmsg.xs_tcp_send_request.xprt_request_transmit
      0.11 ±200%      +0.5        0.60 ±  6%  perf-profile.calltrace.cycles-pp.sock_sendmsg.xprt_sock_sendmsg.xs_tcp_send_request.xprt_request_transmit.xprt_transmit
      0.11 ±200%      +0.5        0.61 ±  6%  perf-profile.calltrace.cycles-pp.xprt_sock_sendmsg.xs_tcp_send_request.xprt_request_transmit.xprt_transmit.call_transmit
      1.30 ±  2%      +0.5        1.82 ±  6%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
      1.30 ±  2%      +0.5        1.82 ±  6%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
      1.31 ±  2%      +0.5        1.83 ±  6%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.btrfs_do_write_iter
      1.31 ±  2%      +0.5        1.83 ±  6%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
      1.32 ±  2%      +0.5        1.85 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.btrfs_do_write_iter.vfs_iocb_iter_write
      0.00            +0.5        0.54 ±  8%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +0.6        0.56 ±  7%  perf-profile.calltrace.cycles-pp.__put_nfs_open_context.nfs_file_release.__fput.__x64_sys_close.do_syscall_64
      0.00            +0.6        0.57 ±  7%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.filemap_write_and_wait_range.nfs_wb_all.nfs4_file_flush.filp_flush.__x64_sys_close
      0.00            +0.6        0.61 ±  7%  perf-profile.calltrace.cycles-pp.nfs_file_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.61 ±  8%  perf-profile.calltrace.cycles-pp.nfs_wb_all.nfs4_file_flush.filp_flush.__x64_sys_close.do_syscall_64
      1.95 ±  2%      +0.6        2.57 ±  6%  perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_execute.rpc_run_task.nfs4_do_call_sync._nfs4_proc_lookup
      1.96 ±  3%      +0.6        2.58 ±  6%  perf-profile.calltrace.cycles-pp.rpc_execute.rpc_run_task.nfs4_do_call_sync._nfs4_proc_lookup.nfs4_proc_lookup_common
      0.00            +0.6        0.62 ±  8%  perf-profile.calltrace.cycles-pp.nfs4_file_flush.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.01 ±  2%      +0.6        2.66 ±  6%  perf-profile.calltrace.cycles-pp.rpc_run_task.nfs4_do_call_sync._nfs4_proc_lookup.nfs4_proc_lookup_common.nfs4_proc_lookup
      2.02 ±  2%      +0.6        2.67 ±  6%  perf-profile.calltrace.cycles-pp._nfs4_proc_lookup.nfs4_proc_lookup_common.nfs4_proc_lookup.nfs_lookup_revalidate_dentry.lookup_dcache
      2.02 ±  2%      +0.6        2.67 ±  6%  perf-profile.calltrace.cycles-pp.nfs4_do_call_sync._nfs4_proc_lookup.nfs4_proc_lookup_common.nfs4_proc_lookup.nfs_lookup_revalidate_dentry
      2.03 ±  2%      +0.6        2.68 ±  6%  perf-profile.calltrace.cycles-pp.nfs4_proc_lookup_common.nfs4_proc_lookup.nfs_lookup_revalidate_dentry.lookup_dcache.lookup_one_qstr_excl
      2.03 ±  2%      +0.6        2.68 ±  6%  perf-profile.calltrace.cycles-pp.nfs4_proc_lookup.nfs_lookup_revalidate_dentry.lookup_dcache.lookup_one_qstr_excl.filename_create
      0.00            +0.6        0.65 ±  8%  perf-profile.calltrace.cycles-pp.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.11 ±  2%      +0.7        2.77 ±  5%  perf-profile.calltrace.cycles-pp.lookup_one_qstr_excl.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      2.09 ±  2%      +0.7        2.75 ±  6%  perf-profile.calltrace.cycles-pp.nfs_lookup_revalidate_dentry.lookup_dcache.lookup_one_qstr_excl.filename_create.do_mkdirat
      2.10 ±  2%      +0.7        2.77 ±  5%  perf-profile.calltrace.cycles-pp.lookup_dcache.lookup_one_qstr_excl.filename_create.do_mkdirat.__x64_sys_mkdir
      2.22 ±  2%      +0.7        2.92 ±  5%  perf-profile.calltrace.cycles-pp.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.22 ±  2%      +0.7        2.93 ±  5%  perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      2.25 ±  3%      +0.7        2.95 ±  5%  perf-profile.calltrace.cycles-pp.xs_stream_data_receive_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      2.24 ±  2%      +0.7        2.95 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      2.27 ±  2%      +0.7        2.98 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      2.27 ±  2%      +0.7        2.98 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdir
      0.00            +0.7        0.72 ±  6%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages
      2.20 ±  3%      +0.7        2.92 ±  5%  perf-profile.calltrace.cycles-pp.xs_read_stream.xs_stream_data_receive_workfn.process_one_work.worker_thread.kthread
      2.30 ±  2%      +0.7        3.03 ±  5%  perf-profile.calltrace.cycles-pp.mkdir
      3.68 ±  7%      +0.9        4.53 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.68 ±  7%      +0.9        4.53 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.17 ±  2%      +1.1        4.25 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      5.38 ±  2%      +1.6        6.95 ±  9%  perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread.kthread
      5.38 ±  2%      +1.6        6.96 ±  9%  perf-profile.calltrace.cycles-pp.rpc_async_schedule.process_one_work.worker_thread.kthread.ret_from_fork
      4.95 ±  2%      +2.4        7.31 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.30 ±  2%      +2.5       12.75 ±  6%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     10.98 ±  2%      +2.6       13.57 ±  5%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     26.16            -4.1       22.02 ±  5%  perf-profile.children.cycles-pp.nfsd
     25.54            -4.1       21.39 ±  5%  perf-profile.children.cycles-pp.svc_handle_xprt
     26.13            -4.1       21.99 ±  5%  perf-profile.children.cycles-pp.svc_recv
     39.78            -2.9       36.85 ±  2%  perf-profile.children.cycles-pp.intel_idle
     15.22 ±  2%      -2.3       12.95 ±  5%  perf-profile.children.cycles-pp.svc_process_common
     15.24 ±  2%      -2.3       12.98 ±  5%  perf-profile.children.cycles-pp.svc_process
     14.64 ±  2%      -2.2       12.45 ±  5%  perf-profile.children.cycles-pp.nfsd_dispatch
     14.27 ±  2%      -2.2       12.10 ±  5%  perf-profile.children.cycles-pp.nfsd4_proc_compound
      4.62 ±  3%      -1.7        2.93 ±  5%  perf-profile.children.cycles-pp.btrfs_search_slot
     37.60            -1.7       35.91        perf-profile.children.cycles-pp.ret_from_fork
     37.60            -1.7       35.91        perf-profile.children.cycles-pp.ret_from_fork_asm
     37.60            -1.7       35.91        perf-profile.children.cycles-pp.kthread
      8.41 ±  2%      -1.4        6.99 ±  7%  perf-profile.children.cycles-pp.svc_send
      8.38 ±  2%      -1.4        6.98 ±  7%  perf-profile.children.cycles-pp.svc_tcp_sendto
      5.35 ±  3%      -1.4        4.00 ±  5%  perf-profile.children.cycles-pp.handle_softirqs
      4.14 ±  2%      -1.3        2.81 ± 16%  perf-profile.children.cycles-pp.osq_lock
      2.90 ±  5%      -1.3        1.64 ±  9%  perf-profile.children.cycles-pp.rcu_core
      2.82 ±  5%      -1.2        1.57 ± 10%  perf-profile.children.cycles-pp.rcu_do_batch
      6.56 ±  4%      -1.2        5.34 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      8.95            -1.2        7.73 ±  5%  perf-profile.children.cycles-pp.nfsd4_write
      8.28 ±  2%      -1.2        7.08 ±  5%  perf-profile.children.cycles-pp.btrfs_sync_file
      8.84 ±  2%      -1.2        7.65 ±  5%  perf-profile.children.cycles-pp.vfs_iocb_iter_write
      8.86            -1.2        7.67 ±  5%  perf-profile.children.cycles-pp.nfsd_vfs_write
      8.83 ±  2%      -1.2        7.64 ±  5%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      6.03 ±  2%      -1.2        4.84 ± 10%  perf-profile.children.cycles-pp.__mutex_lock
      2.38 ±  5%      -1.2        1.23 ± 12%  perf-profile.children.cycles-pp.put_cred_rcu
      3.04 ±  5%      -1.1        1.91 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      3.16 ±  2%      -1.0        2.19 ±  5%  perf-profile.children.cycles-pp.btrfs_log_inode
      3.75 ±  2%      -0.9        2.89 ±  6%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
      3.73 ±  2%      -0.9        2.88 ±  6%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
      1.14 ±  3%      -0.6        0.51 ± 15%  perf-profile.children.cycles-pp.btrfs_tree_lock_nested
      1.16 ±  3%      -0.6        0.52 ± 15%  perf-profile.children.cycles-pp.down_write
      1.09 ±  3%      -0.6        0.47 ± 16%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.52 ±  3%      -0.6        0.90 ±  7%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
      1.51 ±  3%      -0.6        0.89 ±  8%  perf-profile.children.cycles-pp.cow_file_range
      2.47 ±  3%      -0.6        1.85 ±  4%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      1.51 ±  3%      -0.6        0.89 ±  7%  perf-profile.children.cycles-pp.cow_file_range_inline
      1.64 ±  3%      -0.6        1.04 ±  7%  perf-profile.children.cycles-pp.writepage_delalloc
      1.32 ±  3%      -0.6        0.73 ±  8%  perf-profile.children.cycles-pp.__cow_file_range_inline
      1.65 ±  2%      -0.6        1.06 ±  6%  perf-profile.children.cycles-pp.extent_writepage
      1.69 ±  3%      -0.6        1.11 ±  6%  perf-profile.children.cycles-pp.btrfs_writepages
      1.68 ±  3%      -0.6        1.11 ±  6%  perf-profile.children.cycles-pp.extent_write_cache_pages
      1.72 ±  3%      -0.6        1.15 ±  6%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
      1.73 ±  3%      -0.6        1.15 ±  6%  perf-profile.children.cycles-pp.start_ordered_ops
      2.73 ±  2%      -0.6        2.18 ±  4%  perf-profile.children.cycles-pp.nfsd4_open
      1.02 ±  3%      -0.5        0.48 ± 10%  perf-profile.children.cycles-pp.btrfs_drop_extents
      7.69 ±  3%      -0.5        7.19 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.86 ±  4%      -0.5        0.36 ± 12%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      2.21 ±  2%      -0.5        1.71 ±  5%  perf-profile.children.cycles-pp.copy_inode_items_to_log
      2.33 ±  2%      -0.5        1.85 ±  5%  perf-profile.children.cycles-pp.do_open_lookup
      2.26 ±  2%      -0.5        1.78 ±  5%  perf-profile.children.cycles-pp.nfsd4_create_file
      1.60 ±  3%      -0.4        1.17 ±  5%  perf-profile.children.cycles-pp.btrfs_create_common
      1.69 ±  2%      -0.4        1.26 ±  5%  perf-profile.children.cycles-pp.svc_tcp_recvfrom
      1.70 ±  3%      -0.4        1.28 ±  5%  perf-profile.children.cycles-pp.vfs_create
      1.73 ±  3%      -0.4        1.33 ±  5%  perf-profile.children.cycles-pp.dentry_create
      1.39 ±  3%      -0.4        1.01 ±  5%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      0.72 ± 11%      -0.4        0.34 ±  3%  perf-profile.children.cycles-pp.btrfs_work_helper
      0.72 ± 11%      -0.4        0.34 ±  3%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      0.57 ±  5%      -0.4        0.19 ± 22%  perf-profile.children.cycles-pp.btrfs_lock_root_node
      0.96 ±  6%      -0.4        0.59 ± 17%  perf-profile.children.cycles-pp.refcount_dec_and_lock_irqsave
      0.96 ±  6%      -0.4        0.59 ± 17%  perf-profile.children.cycles-pp.free_uid
      0.64 ±  2%      -0.4        0.28 ± 18%  perf-profile.children.cycles-pp.wait_log_commit
      0.76 ±  6%      -0.3        0.45 ±  7%  perf-profile.children.cycles-pp.read_block_for_search
      1.42 ±  2%      -0.3        1.13 ±  4%  perf-profile.children.cycles-pp.__fh_verify
      1.67 ±  2%      -0.3        1.38 ±  4%  perf-profile.children.cycles-pp.copy_items
      1.44 ±  2%      -0.3        1.14 ±  4%  perf-profile.children.cycles-pp.fh_verify
      0.44 ±  3%      -0.3        0.18 ±  9%  perf-profile.children.cycles-pp.put_ucounts
      3.21            -0.3        2.96 ±  3%  perf-profile.children.cycles-pp.svc_tcp_sendmsg
      0.62 ±  5%      -0.2        0.38 ±  7%  perf-profile.children.cycles-pp.find_extent_buffer
      0.79 ±  2%      -0.2        0.55 ±  5%  perf-profile.children.cycles-pp.btrfs_add_link
      0.46 ±  3%      -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.down_read
      0.46 ±  3%      -0.2        0.22 ±  5%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_nested
      0.37 ± 12%      -0.2        0.16 ±  6%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.73 ±  3%      -0.2        0.51 ±  5%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      0.45 ±  3%      -0.2        0.24 ±  8%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.48 ±  3%      -0.2        0.29 ±  4%  perf-profile.children.cycles-pp.btrfs_bin_search
      1.06            -0.2        0.86 ±  5%  perf-profile.children.cycles-pp.svc_tcp_sock_recvmsg
      0.38 ±  6%      -0.2        0.19 ± 11%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.34 ±  3%      -0.2        0.15 ±  7%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.90 ±  3%      -0.2        0.71 ±  4%  perf-profile.children.cycles-pp.nfsd4_putfh
      0.85 ±  2%      -0.2        0.66 ±  6%  perf-profile.children.cycles-pp.svc_tcp_read_marker
      0.34 ±  2%      -0.2        0.16 ± 10%  perf-profile.children.cycles-pp.btrfs_search_forward
      0.44 ±  3%      -0.2        0.27 ±  6%  perf-profile.children.cycles-pp.svc_xprt_received
      0.57 ±  2%      -0.2        0.40 ±  6%  perf-profile.children.cycles-pp.insert_with_overflow
      0.69 ±  2%      -0.2        0.53 ±  4%  perf-profile.children.cycles-pp.nfsd_set_fh_dentry
      0.26 ± 13%      -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      0.25 ±  2%      -0.2        0.10 ±  8%  perf-profile.children.cycles-pp.btrfs_log_holes
      0.26 ±  3%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.rwsem_wake
      0.33 ±  4%      -0.2        0.18 ±  8%  perf-profile.children.cycles-pp.inode_logged
      0.38 ±  5%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.btrfs_release_path
      0.28 ±  6%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.btrfs_log_all_xattrs
      0.30 ±  3%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.up_write
      0.43 ±  4%      -0.1        0.29 ± 14%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.41 ±  3%      -0.1        0.27 ± 15%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.23 ±  3%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.wake_up_q
      0.33 ±  3%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.svc_pool_wake_idle_thread
      0.23 ±  6%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.up_read
      0.46 ±  3%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.setup_items_for_insert
      0.41 ±  2%      -0.1        0.30 ±  7%  perf-profile.children.cycles-pp.nfsd4_close
      0.22 ± 11%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.btrfs_insert_delayed_item
      0.85 ±  2%      -0.1        0.76 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.21 ±  4%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.free_extent_buffer
      0.18 ±  7%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__memmove
      0.37 ±  6%      -0.1        0.28 ±  6%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.27 ±  6%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.nfsd4_sequence
      0.50 ±  4%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.copy_extent_buffer_full
      0.22 ±  5%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.start_transaction
      0.34 ±  2%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.exportfs_decode_fh_raw
      0.47 ±  3%      -0.1        0.39 ±  7%  perf-profile.children.cycles-pp.prepare_creds
      1.90            -0.1        1.82        perf-profile.children.cycles-pp.try_to_wake_up
      0.18 ±  8%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.btrfs_root_node
      0.29 ±  3%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.svcauth_unix_set_client
      0.41 ±  6%      -0.1        0.33 ±  9%  perf-profile.children.cycles-pp.sched_balance_domains
      0.27            -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.btrfs_get_dentry
      0.17 ±  8%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.nfsd4_sequence_done
      0.18 ±  8%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.nfs4svc_encode_compoundres
      0.18 ±  5%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.46 ±  2%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.14 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.27 ±  5%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.nfs4_put_stid
      0.22 ±  5%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.sunrpc_cache_lookup_rcu
      0.25 ±  3%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      0.34 ±  3%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      0.25 ±  3%      -0.1        0.19 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup
      0.88            -0.1        0.82 ±  2%  perf-profile.children.cycles-pp.__wake_up
      0.31 ±  2%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.__lookup_slow
      0.16 ±  6%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.mutex_lock
      0.22 ±  4%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.nfs4_free_ol_stateid
      0.25 ±  5%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.clone_leaf
      0.24 ±  3%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.nfsd4_getattr
      0.74            -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.21 ±  4%      -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.release_all_access
      0.18 ±  2%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.btrfs_get_root_ref
      0.17 ±  4%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.51 ±  4%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.nfsd_setuser
      0.23 ±  6%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.split_leaf
      0.19 ±  3%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.nfsd_file_free
      0.36 ±  7%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.17 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__reserve_bytes
      0.11 ±  5%      -0.0        0.06 ± 18%  perf-profile.children.cycles-pp.btrfs_read_node_slot
      0.14 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.unlock_up
      0.29 ±  2%      -0.0        0.25 ±  6%  perf-profile.children.cycles-pp.svc_tcp_read_msg
      0.13 ±  7%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.btrfs_setup_item_for_insert
      0.31 ±  2%      -0.0        0.27 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.26 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.nfsd4_process_open2
      0.20 ±  3%      -0.0        0.16 ±  9%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.39 ±  4%      -0.0        0.35 ±  4%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.10 ± 16%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.19 ±  2%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.sk_reset_timer
      0.51 ±  2%      -0.0        0.47        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.09 ±  8%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.read_tree_block
      0.07 ±  9%      -0.0        0.03 ± 82%  perf-profile.children.cycles-pp.svc_xprt_enqueue
      0.18 ±  2%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.__mod_timer
      0.07 ±  5%      -0.0        0.03 ± 82%  perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
      0.10 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.nfsd4_process_open1
      0.10 ±  7%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.16 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.nfsd_file_acquire_opened
      0.16 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.nfsd_file_do_acquire
      0.19 ±  4%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.perf_tp_event
      0.16 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.rqst_exp_find
      0.08 ±  6%      -0.0        0.04 ± 51%  perf-profile.children.cycles-pp.svc_authorise
      0.06 ±  6%      -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.need_preemptive_reclaim
      0.06 ±  6%      -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.svc_thread_should_sleep
      0.09 ±  9%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.find_stateid_by_type
      0.07            -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.exp_get_by_name
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.exp_find
      0.08 ± 17%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.xas_start
      0.10 ±  9%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.unix_gid_find
      0.07            -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.09 ±  9%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.nfsd4_lookup_stateid
      0.08 ±  9%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.alloc_conn
      0.07 ±  7%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.find_inode
      0.16 ±  4%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.17 ±  4%      -0.0        0.15        perf-profile.children.cycles-pp.nfs4_get_vfs_file
      0.30            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      0.10 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.fh_put
      0.08 ±  9%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.nfs4_preprocess_stateid_op
      0.08 ±  4%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.10 ±  7%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__process_folios_contig
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.mutex_unlock
      0.09 ±  5%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.cpuacct_charge
      0.08 ±  6%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.insert_inline_extent
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.push_leaf_right
      0.07 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.__push_leaf_right
      0.07 ±  5%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.folio_alloc_noprof
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      0.07 ± 14%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.rpc_malloc
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.update_entity_lag
      0.06 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__alloc_skb
      0.07 ± 11%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.allocate_slab
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.06 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.nfs4_xdr_dec_write
      0.14 ±  4%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.wake_affine
      0.07 ±  6%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.__free_frozen_pages
      0.05 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.nfs_update_inode
      0.07 ±  9%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.nfs_do_access
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.09 ±  7%      +0.0        0.11        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.15 ±  5%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.___slab_alloc
      0.10 ±  9%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.10 ±  8%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.10 ±  4%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.xdr_inline_decode
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.nfs_fattr_map_and_free_names
      0.08 ±  7%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.unx_lookup_cred
      0.06            +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.write_bytes_to_xdr_buf
      0.12 ±  8%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.btrfs_orig_write_end_io
      0.09 ±  8%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.21 ±  4%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.12 ±  6%      +0.0        0.15 ±  9%  perf-profile.children.cycles-pp.nfs41_call_sync_done
      0.06 ± 12%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.nfs_access_get_cached
      0.10 ±  7%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.nfs_update_folio
      0.09 ± 10%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.nfs_writepage_setup
      0.07 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.rpc_wake_up_first_on_wq
      0.08 ±  9%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.07 ±  6%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.08 ± 13%      +0.0        0.10        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.09 ±  8%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.decode_sequence
      0.27 ±  2%      +0.0        0.30 ±  5%  perf-profile.children.cycles-pp.nfsd4_encode_getattr
      0.12 ±  6%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.10 ±  4%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.chksum_update
      0.09 ±  7%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.04 ± 50%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__d_alloc
      0.04 ± 50%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.writeback_iter
      0.08 ±  7%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__folio_batch_release
      0.08 ±  9%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.10 ±  7%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.__filename_parentat
      0.07 ±  7%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.__rpc_do_sleep_on_priority
      0.10 ±  8%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.folio_wake_bit
      0.10 ±  6%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.nfs_permission
      0.09 ±  5%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.place_entity
      0.09 ±  5%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.rpcauth_bindcred
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      0.10 ±  7%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.svcauth_unix_accept
      0.08 ±  6%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.nfs4_free_closedata
      0.08 ±  9%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.zero_user_segments
      0.06 ±  8%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__task_rq_lock
      0.09 ± 10%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.12 ±  6%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.alloc_inode
      0.11 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.attach_eb_folio_to_filemap
      0.05 ±  7%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.12 ±  5%      +0.0        0.15 ± 11%  perf-profile.children.cycles-pp.crc32c_arch
      0.10 ±  7%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.nfs4_write_done
      0.09 ±  8%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.unx_marshal
      0.07 ± 10%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.io_schedule
      0.07 ± 10%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.svc_alloc_arg
      0.24 ±  5%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.btrfs_init_new_buffer
      0.14 ±  8%      +0.0        0.17 ± 10%  perf-profile.children.cycles-pp.inode_permission
      0.14 ±  5%      +0.0        0.17 ± 12%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.20 ±  6%      +0.0        0.24 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.04 ± 50%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp._copy_from_iter
      0.13 ±  4%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.filemap_add_folio
      0.11 ±  4%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.iget5_locked
      0.06 ±  7%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.pwq_tryinc_nr_active
      0.23 ±  6%      +0.0        0.26 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.10 ±  3%      +0.0        0.14 ± 12%  perf-profile.children.cycles-pp.csum_tree_block
      0.10 ±  7%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.rpcauth_refreshcred
      0.22 ±  4%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.read_tsc
      0.11 ±  3%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.set_next_entity
      0.11 ±  4%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  5%      +0.0        0.17 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.10            +0.0        0.14 ± 15%  perf-profile.children.cycles-pp.nfs4_close_prepare
      0.37 ±  3%      +0.0        0.41 ±  3%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      0.17 ±  2%      +0.0        0.21 ±  6%  perf-profile.children.cycles-pp.prepare_task_switch
      0.16 ±  6%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.02 ±122%      +0.0        0.06 ± 12%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.23 ±  3%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.18 ±  6%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.nfsd4_decode_compound
      0.11 ±  5%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.xdr_reserve_space
      0.15 ±  8%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.nfs4_close_done
      0.10 ±  8%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.rpc_task_release_client
      0.13 ±  5%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.nfs_fhget
      0.02 ±122%      +0.0        0.06 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.02 ±122%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.writeback_get_folio
      0.17 ±  5%      +0.0        0.21 ±  8%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.06 ± 12%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.nfs41_release_slot
      0.10 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.nfs4_xdr_dec_open
      0.13 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.nfs_write_end
      0.13 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.decode_getfattr_attrs
      0.13 ±  3%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.nfs_initiate_pgio
      0.19 ±  4%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.prepare_one_folio
      0.13 ±  3%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.set_next_task_fair
      0.11 ±  4%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.11 ±  4%      +0.0        0.15 ± 12%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.01 ±200%      +0.0        0.06 ± 12%  perf-profile.children.cycles-pp.nfs_do_writepage
      0.15 ±  4%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.decode_getfattr_generic
      0.14 ±  5%      +0.0        0.19 ±  9%  perf-profile.children.cycles-pp.nfs_writeback_done
      0.01 ±200%      +0.0        0.06        perf-profile.children.cycles-pp.cred_fscmp
      0.14 ±  7%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.nfs_pgio_result
      0.17 ±  4%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      0.12 ±  6%      +0.1        0.17 ± 10%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.19 ±  6%      +0.1        0.25 ± 12%  perf-profile.children.cycles-pp.nfs4_sequence_done
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__rpc_sleep_on_priority_timeout
      0.17 ±  6%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.write_one_eb
      0.02 ±122%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.check_inode_item
      0.03 ± 82%      +0.1        0.09 ± 16%  perf-profile.children.cycles-pp.xprt_request_init
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.inode_init_always_gfp
      0.15 ± 11%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.wake_up_bit
      0.20 ±  4%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.29 ±  4%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.folio_end_writeback
      0.13 ±  5%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.36 ±  3%      +0.1        0.42 ± 10%  perf-profile.children.cycles-pp.nfs41_sequence_process
      0.18 ±  2%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.nfs_generic_pg_pgios
      0.18 ±  2%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.nfs_pageio_doio
      0.19 ±  3%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp._nfs4_opendata_to_nfs4_state
      0.18 ±  2%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.nfs_pageio_complete
      0.13 ±  7%      +0.1        0.19 ± 15%  perf-profile.children.cycles-pp.tick_irq_enter
      0.25 ±  3%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp.rpc_xdr_encode
      0.28 ±  2%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.24            +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.generic_perform_write
      0.13 ±  5%      +0.1        0.20 ± 16%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.39 ±  3%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.nfsd4_encode_operation
      0.14 ±  3%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.37 ±  3%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.26 ±  3%      +0.1        0.32 ±  8%  perf-profile.children.cycles-pp.nfs4_run_open_task
      0.27 ±  2%      +0.1        0.34 ±  7%  perf-profile.children.cycles-pp.nfs_file_write
      0.04 ± 53%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
      0.14 ±  7%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.xprt_free_slot
      0.30 ±  5%      +0.1        0.37 ±  6%  perf-profile.children.cycles-pp.nfs_write_completion
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.check_extent_data_item
      0.30 ±  6%      +0.1        0.38 ±  5%  perf-profile.children.cycles-pp.rpc_async_release
      0.63 ±  2%      +0.1        0.71 ±  3%  perf-profile.children.cycles-pp.enqueue_task
      0.94 ±  4%      +0.1        1.02 ±  4%  perf-profile.children.cycles-pp.__lock_sock
      0.27 ±  7%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.wake_bit_function
      0.15 ±  6%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.15 ±  3%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.__btrfs_check_node
      0.15 ±  3%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.btrfs_check_node
      0.22 ±  2%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.91            +0.1        1.00 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.58            +0.1        0.67 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      0.69 ±  2%      +0.1        0.78 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.34 ±  5%      +0.1        0.43 ±  4%  perf-profile.children.cycles-pp.rpc_wake_up_queued_task
      0.28 ±  3%      +0.1        0.38 ±  7%  perf-profile.children.cycles-pp.nfs_writepages
      0.30 ±  4%      +0.1        0.40 ± 14%  perf-profile.children.cycles-pp.nfs4_setup_sequence
      0.23 ±  3%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.rpc_wait_bit_killable
      0.17 ±  5%      +0.1        0.27 ± 15%  perf-profile.children.cycles-pp.xprt_alloc_slot
      0.64 ±  2%      +0.1        0.74 ±  4%  perf-profile.children.cycles-pp.dequeue_entities
      0.39 ±  5%      +0.1        0.49 ±  5%  perf-profile.children.cycles-pp.rpc_free_task
      0.06 ± 12%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.steal_from_bitmap
      0.34            +0.1        0.44 ±  6%  perf-profile.children.cycles-pp._nfs4_proc_open
      0.67 ±  2%      +0.1        0.78 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.06 ± 12%      +0.1        0.16 ± 19%  perf-profile.children.cycles-pp.__btrfs_add_free_space
      0.06 ± 12%      +0.1        0.16 ± 19%  perf-profile.children.cycles-pp.unpin_extent_range
      0.03 ± 82%      +0.1        0.13 ± 21%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.06 ± 18%      +0.1        0.16 ± 18%  perf-profile.children.cycles-pp.btrfs_finish_extent_commit
      0.12 ±  8%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.check_leaf_item
      0.70 ±  2%      +0.1        0.80 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      0.49 ±  2%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.19 ±  3%      +0.1        0.29 ± 14%  perf-profile.children.cycles-pp.xprt_reserve
      0.00            +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.btrfs_preempt_reclaim_metadata_space
      0.00            +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.flush_space
      0.42 ±  3%      +0.1        0.53 ±  5%  perf-profile.children.cycles-pp.kick_pool
      0.58 ±  2%      +0.1        0.70 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.24            +0.1        1.36 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.38 ±  3%      +0.1        0.51 ±  8%  perf-profile.children.cycles-pp.nfs4_do_close
      0.20 ±  2%      +0.1        0.32 ± 17%  perf-profile.children.cycles-pp.xprt_request_wait_receive
      0.42 ±  2%      +0.1        0.55 ±  4%  perf-profile.children.cycles-pp.call_decode
      1.05 ±  2%      +0.1        1.18 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.58 ±  3%      +0.1        0.72 ±  8%  perf-profile.children.cycles-pp.rpc_exit_task
      0.38 ± 14%      +0.1        0.52 ± 11%  perf-profile.children.cycles-pp.rpc_release_resources_task
      0.50 ±  8%      +0.1        0.64 ± 12%  perf-profile.children.cycles-pp.start_log_trans
      0.43 ±  4%      +0.1        0.56 ±  7%  perf-profile.children.cycles-pp.__put_nfs_open_context
      0.65 ±  5%      +0.1        0.79 ±  7%  perf-profile.children.cycles-pp.queue_work_on
      0.23 ±  4%      +0.1        0.37 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.70 ±  2%      +0.1        0.85 ±  5%  perf-profile.children.cycles-pp.__pick_next_task
      0.61 ±  4%      +0.1        0.76 ±  6%  perf-profile.children.cycles-pp.__queue_work
      0.35 ±  2%      +0.1        0.50 ±  9%  perf-profile.children.cycles-pp.__wait_on_bit
      0.18 ±  5%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.rpc_wake_up_queued_task_set_status
      0.46 ±  3%      +0.2        0.61 ±  4%  perf-profile.children.cycles-pp.its_return_thunk
      0.35 ±  2%      +0.2        0.50 ±  9%  perf-profile.children.cycles-pp.out_of_line_wait_on_bit
      1.68            +0.2        1.83 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.46 ±  4%      +0.2        0.61 ±  7%  perf-profile.children.cycles-pp.nfs_file_release
      1.53 ±  2%      +0.2        1.68 ±  3%  perf-profile.children.cycles-pp.lock_sock_nested
      0.43 ±  3%      +0.2        0.59 ±  7%  perf-profile.children.cycles-pp.filemap_write_and_wait_range
      0.45 ±  3%      +0.2        0.61 ±  7%  perf-profile.children.cycles-pp.nfs_wb_all
      0.55 ±  4%      +0.2        0.71 ±  7%  perf-profile.children.cycles-pp.__fput
      0.13 ± 16%      +0.2        0.30 ± 16%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.45 ±  4%      +0.2        0.62 ±  8%  perf-profile.children.cycles-pp.nfs4_file_flush
      0.48 ±  3%      +0.2        0.65 ±  8%  perf-profile.children.cycles-pp.filp_flush
      0.56 ±  4%      +0.2        0.74 ±  3%  perf-profile.children.cycles-pp.xs_read_xdr_buf
      0.23 ±  6%      +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      0.23 ±  6%      +0.2        0.41 ±  4%  perf-profile.children.cycles-pp.btrfs_check_leaf
      0.64 ±  7%      +0.2        0.83 ±  6%  perf-profile.children.cycles-pp.xprt_sock_sendmsg
      0.58 ±  4%      +0.2        0.77 ±  3%  perf-profile.children.cycles-pp.xs_read_stream_request
      0.65            +0.2        0.85 ±  6%  perf-profile.children.cycles-pp._nfs4_open_and_get_state
      2.36 ±  2%      +0.2        2.57 ±  2%  perf-profile.children.cycles-pp.inet6_recvmsg
      2.38 ±  2%      +0.2        2.59 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      2.35 ±  2%      +0.2        2.56 ±  2%  perf-profile.children.cycles-pp.tcp_recvmsg
      0.60            +0.2        0.81 ±  6%  perf-profile.children.cycles-pp.__submit_bio
      0.60            +0.2        0.81 ±  6%  perf-profile.children.cycles-pp.__submit_bio_noacct
      0.27 ±  4%      +0.2        0.48 ± 19%  perf-profile.children.cycles-pp.xprt_request_enqueue_transmit
      0.68 ±  8%      +0.2        0.90 ± 10%  perf-profile.children.cycles-pp.rpc_release_task
      0.60            +0.2        0.82 ±  6%  perf-profile.children.cycles-pp.btrfs_submit_bio
      0.73            +0.2        0.97 ±  5%  perf-profile.children.cycles-pp._nfs4_do_open
      0.73            +0.2        0.97 ±  5%  perf-profile.children.cycles-pp.nfs4_do_open
      0.73            +0.2        0.97 ±  5%  perf-profile.children.cycles-pp.nfs4_atomic_open
      0.80            +0.2        1.04 ±  5%  perf-profile.children.cycles-pp.nfs_atomic_open
      1.81 ±  2%      +0.3        2.07 ±  3%  perf-profile.children.cycles-pp.schedule
      0.86 ±  2%      +0.3        1.12 ±  5%  perf-profile.children.cycles-pp.lookup_open
      0.90 ±  2%      +0.3        1.16 ±  5%  perf-profile.children.cycles-pp.open_last_lookups
      0.49 ±  3%      +0.3        0.79 ±  5%  perf-profile.children.cycles-pp.btree_csum_one_bio
      1.04            +0.3        1.35 ±  6%  perf-profile.children.cycles-pp.path_openat
      1.05            +0.3        1.37 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      1.08            +0.3        1.39 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      1.08            +0.3        1.40 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.00 ±  3%      +0.3        1.33 ±  7%  perf-profile.children.cycles-pp.__x64_sys_close
      2.57            +0.3        2.91 ±  3%  perf-profile.children.cycles-pp.__schedule
      1.33 ±  5%      +0.4        1.74        perf-profile.children.cycles-pp.xs_sock_recvmsg
      2.67 ±  4%      +0.5        3.13 ±  4%  perf-profile.children.cycles-pp.xprt_request_transmit
      1.13 ±  2%      +0.5        1.65 ±  5%  perf-profile.children.cycles-pp.btrfs_submit_bbio
      1.13 ±  2%      +0.5        1.65 ±  5%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      2.82 ±  4%      +0.5        3.36 ±  4%  perf-profile.children.cycles-pp.xprt_transmit
      1.35 ±  2%      +0.6        1.93 ±  5%  perf-profile.children.cycles-pp.btree_write_cache_pages
      1.37 ±  2%      +0.6        1.96 ±  6%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
      2.96 ±  3%      +0.6        3.59 ±  4%  perf-profile.children.cycles-pp.call_transmit
      1.76 ±  3%      +0.6        2.40 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.02 ±  2%      +0.6        2.67 ±  6%  perf-profile.children.cycles-pp._nfs4_proc_lookup
      2.02 ±  2%      +0.6        2.67 ±  6%  perf-profile.children.cycles-pp.nfs4_do_call_sync
      2.03 ±  2%      +0.6        2.68 ±  6%  perf-profile.children.cycles-pp.nfs4_proc_lookup_common
      2.03 ±  2%      +0.6        2.68 ±  6%  perf-profile.children.cycles-pp.nfs4_proc_lookup
      2.09 ±  3%      +0.7        2.75 ±  6%  perf-profile.children.cycles-pp.nfs_lookup_revalidate_dentry
      2.11 ±  2%      +0.7        2.77 ±  5%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      2.13 ±  2%      +0.7        2.80 ±  5%  perf-profile.children.cycles-pp.lookup_dcache
      2.18 ±  2%      +0.7        2.86 ±  5%  perf-profile.children.cycles-pp.rpc_execute
      2.22 ±  2%      +0.7        2.92 ±  5%  perf-profile.children.cycles-pp.filename_create
      2.23 ±  2%      +0.7        2.93 ±  5%  perf-profile.children.cycles-pp.do_mkdirat
      2.24 ±  2%      +0.7        2.95 ±  5%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      2.25 ±  3%      +0.7        2.96 ±  4%  perf-profile.children.cycles-pp.xs_stream_data_receive_workfn
      2.20 ±  3%      +0.7        2.93 ±  5%  perf-profile.children.cycles-pp.xs_read_stream
      2.30 ±  2%      +0.7        3.03 ±  5%  perf-profile.children.cycles-pp.mkdir
      2.40 ±  2%      +0.7        3.15 ±  6%  perf-profile.children.cycles-pp.rpc_run_task
      3.75 ±  2%      +0.9        4.65 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      6.03 ±  4%      +1.6        7.60 ±  7%  perf-profile.children.cycles-pp.do_syscall_64
      6.04 ±  4%      +1.6        7.61 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.38 ±  2%      +1.6        6.96 ±  9%  perf-profile.children.cycles-pp.rpc_async_schedule
      7.34            +2.2        9.53 ±  7%  perf-profile.children.cycles-pp.__rpc_execute
     10.30 ±  2%      +2.5       12.75 ±  6%  perf-profile.children.cycles-pp.process_one_work
     10.99 ±  2%      +2.6       13.58 ±  5%  perf-profile.children.cycles-pp.worker_thread
      5.92 ±  2%      +3.2        9.08 ±  8%  perf-profile.children.cycles-pp.intel_idle_irq
     39.78            -2.9       36.85 ±  2%  perf-profile.self.cycles-pp.intel_idle
      4.05 ±  2%      -1.3        2.77 ± 16%  perf-profile.self.cycles-pp.osq_lock
      0.98 ±  4%      -0.5        0.45 ±  8%  perf-profile.self.cycles-pp.put_cred_rcu
      0.95 ±  6%      -0.4        0.59 ± 17%  perf-profile.self.cycles-pp.refcount_dec_and_lock_irqsave
      0.44 ±  4%      -0.3        0.18 ±  9%  perf-profile.self.cycles-pp.put_ucounts
      0.37 ±  6%      -0.2        0.18 ± 11%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.40 ±  4%      -0.2        0.21 ±  8%  perf-profile.self.cycles-pp.find_extent_buffer
      0.47 ±  3%      -0.2        0.29 ±  4%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.16 ±  6%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.free_extent_buffer
      0.20 ±  5%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.up_read
      0.23 ±  9%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.22 ± 10%      -0.1        0.13 ±  7%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.18 ±  4%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__memmove
      0.38 ±  3%      -0.1        0.31 ±  6%  perf-profile.self.cycles-pp.prepare_creds
      0.18 ±  7%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.btrfs_root_node
      0.23 ±  8%      -0.1        0.16 ± 21%  perf-profile.self.cycles-pp.sched_balance_domains
      0.77 ±  2%      -0.1        0.71 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.14 ±  8%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.mutex_lock
      0.12 ±  6%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__mutex_lock
      0.11 ±  9%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.down_read
      0.35 ±  6%      -0.0        0.31 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.08 ± 15%      -0.0        0.04 ± 50%  perf-profile.self.cycles-pp.xas_start
      0.28 ±  6%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.13 ±  3%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.13 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.enqueue_task
      0.13 ±  5%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.svc_handle_xprt
      0.09 ±  8%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.svc_recv
      0.30 ±  2%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.llist_reverse_order
      0.08 ±  9%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.btrfs_get_root_ref
      0.15 ±  6%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.10 ±  7%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.mutex_unlock
      0.15 ±  5%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.perf_tp_event
      0.10 ±  9%      -0.0        0.08        perf-profile.self.cycles-pp.sunrpc_cache_lookup_rcu
      0.10 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__fh_verify
      0.13 ±  8%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.check_heap_object
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.svc_tcp_recvfrom
      0.07 ± 10%      -0.0        0.06 ± 16%  perf-profile.self.cycles-pp.refcount_dec_and_lock
      0.09            -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.cpuacct_charge
      0.05 ±  9%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.finish_task_switch
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rb_insert_color
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.08 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.unx_marshal
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.do_idle
      0.06            +0.0        0.08 ± 13%  perf-profile.self.cycles-pp.___perf_sw_event
      0.06            +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.nfsd4_proc_compound
      0.07 ±  6%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.place_entity
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.xdr_inline_decode
      0.08 ±  4%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.decode_sequence
      0.06 ± 12%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.15 ±  2%      +0.0        0.18 ±  9%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.04 ± 51%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.10 ±  8%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.06 ±  7%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__wait_on_bit
      0.09 ±  8%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.alloc_pages_bulk_noprof
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.09 ±  5%      +0.0        0.12 ± 11%  perf-profile.self.cycles-pp.random
      0.10 ±  9%      +0.0        0.13 ±  7%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.04 ± 50%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.xprt_release
      0.33 ±  2%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.07 ±  7%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.__rpc_do_sleep_on_priority
      0.07 ±  6%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.process_one_work
      0.08 ±  5%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.rpc_task_release_client
      0.20 ±  5%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.06 ±  7%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.pwq_tryinc_nr_active
      0.12 ±  6%      +0.0        0.16 ±  8%  perf-profile.self.cycles-pp.__switch_to
      0.07            +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.decode_getfattr_attrs
      0.11            +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.21 ±  3%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.read_tsc
      0.10 ±  6%      +0.0        0.14 ±  8%  perf-profile.self.cycles-pp.xdr_reserve_space
      0.18 ±  4%      +0.0        0.22 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.03 ± 81%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.01 ±200%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.cred_fscmp
      0.07 ±  5%      +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.xprt_request_enqueue_transmit
      0.00            +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.kick_pool
      1.05 ±  3%      +0.1        1.11 ±  4%  perf-profile.self.cycles-pp.memcpy_orig
      0.13 ±  6%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.__rpc_execute
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.xs_read_stream
      0.49            +0.1        0.57 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.22 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.03 ± 82%      +0.1        0.13 ± 18%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.37 ±  2%      +0.1        0.48 ±  4%  perf-profile.self.cycles-pp.its_return_thunk
      2.74            +0.3        3.02 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      1.74 ±  3%      +0.6        2.38 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.46 ±  3%      +3.4        7.90 ±  9%  perf-profile.self.cycles-pp.intel_idle_irq




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


