Return-Path: <linux-nfs+bounces-9896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076CA2A1AE
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 08:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1C61887887
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F4158D8B;
	Thu,  6 Feb 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5tARfuV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BAFC0A;
	Thu,  6 Feb 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825317; cv=fail; b=TxonAfR4hjWkDVG49G6TldLty4N1mzR6/oU6fs5o47q5JwIgTHo85YHI+g6GQ5TBWJWG3NQgN0lRRwMJwV2K1KYWM52qV9l6uuA+kr5o7diraVJWxxOgprblBawrPLJthIuHu2hRAhuD/6wa5pZ8gbbbKMzu3lSf4GY6EHGug1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825317; c=relaxed/simple;
	bh=lR8DYQj26rw8cUCpxiB9jmIov7FaE6iz5nVRJztcp2Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cLaadsUqxxIxO+/GW/i5NXkP2wJrY9hLQhJfbi8X7PPu0vt0/sD+Qpdt5wS8hjwKKqbhfxUhhfXxDSmTcxvkJGwDp0vgx+zlUx14Tgm8Gw3Rg481tGREguxx/rCiywMJMLQn2eD+Q00si5P9G1ov4zvEq2krQ38oGxk4JvB8EtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5tARfuV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738825315; x=1770361315;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=lR8DYQj26rw8cUCpxiB9jmIov7FaE6iz5nVRJztcp2Y=;
  b=Q5tARfuVplo3qKJT64xtljKqzb+Y0HNjuiBPbYJSHgYUWdmegENFJw4i
   c1tM2MQIQ3VDlxwjVmNhiA5gjMtgHFJ21/zHucT4cTFvIy+yLVgAm1wJd
   /EMuYt2cuF9SwqtM3fDineMWUB/pRLaglm7kflMhosNOO7ZkCzFNhX+Yc
   8uvgUpguy1YnWifIl06iv8cLBFOZOvZsGjG5E+NVPyArfE+8YGe9RqHsB
   OCVmNPaCOsETZ3AsRzn8sKzXAemp1AnFFJfx+Rcky/8OgSYResPQZRLBa
   fjGPuRlfn0v+6itD5tVMyEk7em8O2P/0UpkSKHyKLiZUaNPYzy7fZG+ln
   A==;
X-CSE-ConnectionGUID: trH7TZ4fRUOk7mxnR/196Q==
X-CSE-MsgGUID: t5h38xgPSDOO5K/7JGzTJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56960871"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="56960871"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 23:01:38 -0800
X-CSE-ConnectionGUID: HIyoSMIYQW6NBq8Em0LGnA==
X-CSE-MsgGUID: z40CGdlqTWaGzmzAT7VpcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="111327537"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 23:01:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 23:01:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 23:01:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 23:01:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbaR6H6bxZtUF4ix16O2Ipqn/6rI82Pdtfg6S4HAe1dmWLAHcawKAvSRJuh9ujRUmoSR3mtpa+n0KWTEYYnYJmQJnjTNK9uBgXEcThO230lpeR0gc5HfGG70XU29tg8eb8U2ZdYgS4/zXAvMl81l1ttUkWa8yqJRFMvUfYoe5EXZliK3RQ3PypGUU3oCctQcOV1sua8RAXDgNCys5cq2GpCYGm933R0tE+y8ZoQa/WV7tt7e9FhdXKU119FAxELAdxX9pT8DOdaphOKRx5/4pJIP83vVBnVvtRn4XRuwNPShSKnfWIy9ZM6CJ+FRcCuIHZP6B7iO8MvGhYa8qzTDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48BMTmXxE5C8Ak3FabtWQFm6WY62d49LtAo87YlsBjs=;
 b=SlbMIn09lUiKhBiTOofB+KXpwCP4pZwriWkw2u8ZwSDarbugCVLvnsopXHVQwJ/lsywhYUlMo3azTHwRIMfAykdwMT41pas2NWiuTPNyvW7gfJAO0obM96EtpLG1PCJPkiZH2RERkrX9rnX+uhCf+/QZ91PVaJ7rXrWAJ0nPK6UbfU8kUQ8DibJ/AVWcFTZAMxc7d0sFp4p3PYE1L4S3DVV9K+bcNKN22HEjhtrNzN7GJW77lzz8yIM12bjiNCtUjocpTJIETNAcLKXEgGV5IT4ugjBhcxyrS7gcpbCZz9vF8AHmQ+oEezVy/QmX+CXsOzVTksGxt5SJnEYSsZ+dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 07:01:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 07:01:07 +0000
Date: Thu, 6 Feb 2025 15:00:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [nfsd]  7e13f4f8d2:  postmark.transactions 10.4%
 regression
Message-ID: <202502061435.62604a8d-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0076.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d34d4a-dee7-488b-928e-08dd467c0768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YgJbuw6mVA4los/H0aJnIO7AfIiq5rvAAKjqM30UZCzyRnKL7xoeOYLgYn?=
 =?iso-8859-1?Q?4BPu/uJ7tQgbFf5z6wa5tGXShxbm8tFmbStWuKDFbRLH8CAUvymj+l+sJo?=
 =?iso-8859-1?Q?H3O3/iVQu2CiMfi3A/Am3obrdHhEBODKdsU+BskFCnWBF93QxAOrCE3PsQ?=
 =?iso-8859-1?Q?eSDBgf83F9K5x7JqWqFO2r6vmNRM8diA64mhQ4AXoGeyenfIObi6WINsVb?=
 =?iso-8859-1?Q?1hUKPkmRcE5x9Nz5Ik4WRtBSZWct4/JO5bcfr0/ejv0NwuxjrvqJz3aWrA?=
 =?iso-8859-1?Q?z7NUdgDqLBrFdZUD8o+f6+3cVTy/6gSaGLo5gHSymL55l/dY05XvMfgSnk?=
 =?iso-8859-1?Q?1LgtpvpHT2KPFYZiR9+GKUWNV2SAbOtiNRXRCwmhPjWmlKP9VVl92vJsNJ?=
 =?iso-8859-1?Q?euVCLAi5uovAXxF1PiHFDWP0MiaJrdVzKfTHZOZERQ7i9yX2HRJYne/q0A?=
 =?iso-8859-1?Q?06NRl4zOMR+lmDZvC2E1KxEvPWce7LuV0zqmBQg5REgiGDY1IoHzSw0X2l?=
 =?iso-8859-1?Q?IZMhAW8fZ/aXxSuxDAmMM2uw9TmulTMnqnn9Z9qZuMHH07/mH/g07TsqCQ?=
 =?iso-8859-1?Q?mlTdQE3kBOYAxZ155AAldRLFx6nzuDZNq3rjWWrAPIHa/n6e8dy/PEUFTE?=
 =?iso-8859-1?Q?xIm9ywmVAXp+ekKv79BlTe4QEmNupcnWHgWXBGVcXBd9eu765BpBTehEsC?=
 =?iso-8859-1?Q?LduzpmtkRQE3p0cx968PLDRpOA3a4LkrlyIeqBxpYr4zH2KwpgWi1OxrKv?=
 =?iso-8859-1?Q?DbGjQkXyZkC2WXb1TBg/LJlN+5+O7ycMVbTFl2Tj8AoznDPPtaEC1Qy55q?=
 =?iso-8859-1?Q?2DDX3y3+n/GNgnn5G0ehSvjM8lyNV09RRVkKNG7HzjyeJqCGxE7RrAxI2r?=
 =?iso-8859-1?Q?og62jB+fH9GbBJY5LDK1sDxLc46rPhKPS0cMI4OlqLHuO+YlK6nFIoNy08?=
 =?iso-8859-1?Q?31SJ7rDQ5T9dWL5lJPVpJusKcCmh7vkYbc8P+AC//gmFpZzZYolfB4PxUd?=
 =?iso-8859-1?Q?xdGAie0awIPqxZLdTQ0rygO25qZF2dxuNzBOaVWiB6tLuiJS+L45PLuntS?=
 =?iso-8859-1?Q?mroTS23le1ov/hrPKyClSDTUlcuRkGRe5snv4rGgfW8RslYL+r62Zpk/eZ?=
 =?iso-8859-1?Q?hTR7JbEK70SLe4w77rFhdvMciuBxAlD+c/fQU7hsXDdK3o1GIaipXBP+vs?=
 =?iso-8859-1?Q?pZskiLdzQmX922Tp5UxOv8UrQEqNpZ1oc/sfb4f6dmPgFPajy+lthP6g89?=
 =?iso-8859-1?Q?v9tNkPTBx7aPr3hvsOrG60kSGR8IG/Ufta2YmnN1SVKTkQb+1d2b76FkT+?=
 =?iso-8859-1?Q?AAtZAMB2g0q2m4unuKTK1+DKnknHC/971B+J6WqsEL3aRnxwGJE61h0BcY?=
 =?iso-8859-1?Q?xyNCZOYrcH7TCsGLSdFqsu/8g7abknhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nfx9IUcedIEQPOo7GUoF8XzwgLVlI7NNaAZIcyIa8AmiyEU7lXzuniOzde?=
 =?iso-8859-1?Q?Nh5XqApeL0Hht/PngbU7DgVn55XsIlHrC0LtQI38KttXLVO7Mkg1cJkMi2?=
 =?iso-8859-1?Q?XugA7+qCD61a+HmL0KtIxuQDBAciDhlXfDZBYH5jygcTERYJ5lZF0ToRJY?=
 =?iso-8859-1?Q?I+23z0t3GyieweGk8jLPDf4QWzga25v91J6wH/BUjXM9pzEypAjSqiozzh?=
 =?iso-8859-1?Q?RgCQyK2w0Z7U6HL0L0+VD6FEXXjzSUqAHb+Svgq6fweqRxLDOuPEQv1b1y?=
 =?iso-8859-1?Q?v5k6AIMyMOyngmaAIFi4yT4XIU+4QEY1jYd0FJyYx4iqHNUEshGGLA2OSs?=
 =?iso-8859-1?Q?qaH1bpA22Pb7swux1a2Kahuh7Nhy/5HPPDy9C09G/RymNTdgU2K5gJY8ev?=
 =?iso-8859-1?Q?u1/Cknc+dwgF+rLiD+duzv5Z3Vkfk1MURfks1sahr1Deqg9RrS2wn8EmPV?=
 =?iso-8859-1?Q?igbgg8RCg1opG+AjCM5/cgl4n9f3ZT2iM1ATSA6xcncUtsf/NbWu4PViF7?=
 =?iso-8859-1?Q?tGUFvVo6qW7t8Qfui5Zr6Ws5X1GbRfNwfI7TtOLXt6aFgFa9VRCx1XwkGU?=
 =?iso-8859-1?Q?4QXgAI8LN3+GF/Y3N7rFodHAxCeNptrGBRDFpkKdw2+WdgpWGFOshBKW3x?=
 =?iso-8859-1?Q?Ey4oKNpdxDYczcI4Nnh8z8Lj7jjwbRsQAy9ca2vRKBxU4x4uGhv/RZ1hA3?=
 =?iso-8859-1?Q?oRo3Dii094BCPUYYaIvpZwAHTb5u1/LeP8l/nB8BFkbRov6bIq4lB2Ds5/?=
 =?iso-8859-1?Q?/D2VE7SZssNOC+diiE1QPAwiaFoBfwvU6Tk1vwY/l62zvtwJtquL2f4BEB?=
 =?iso-8859-1?Q?CoGMJhp4BpwHuPPwFTRCXux3d0E+cLyvGfVsEhi+PSuEJDy03fNy2f81el?=
 =?iso-8859-1?Q?5EPZpNlXXyjrSRGnzFBFyOkwrY8EazkQ4MVilmmmLNISx0PFlxbLIbSMHe?=
 =?iso-8859-1?Q?etMqhGfmTTswVJklZ9w7RaTohpbb1jvCsS5Iu+VM8Gd6gpVPluXMDbccwS?=
 =?iso-8859-1?Q?2vt49LYUMeNjG2BVUfRGTK2TQNrFnbporpl+DDnKedR5X8q+sdpQ7usw4h?=
 =?iso-8859-1?Q?+Img8BtHSP+iBL1OlDPXQqGO/ALj4ALveZXyeuE1XDnRV1MqAYKM3ie66v?=
 =?iso-8859-1?Q?6/dSqoB0mxoFnxbJjwXTv+HWK9kH3FEki9z8sANFIz8RP2LrpCgdXcngdI?=
 =?iso-8859-1?Q?eXQSjpf5Akz8ppYyKzZQyqeWygbQMGmirf8VbIpkifrlEPusItqAxdWOpI?=
 =?iso-8859-1?Q?O90bWEywKTVSiua7IepW/b5FsA4sVXAEzbcap2yF+wdoi01BGEKEU7XKDx?=
 =?iso-8859-1?Q?n8fydOMQumEsf4wt8yapiL4GDh96MOwcXkoz24Q7CxAU0OJl1OkA6w0uHl?=
 =?iso-8859-1?Q?KXAxm3x+q5suIX5xLfe5Hvdp6rkwbwZkDD+f1cqcdDNkZglQJSYjsDLWHy?=
 =?iso-8859-1?Q?noqthPdLYg5lSnZdkRGgL0cB/EG8efVgd4HsYhtksh+trkGXIsk67kSHV5?=
 =?iso-8859-1?Q?7O+AqlcBV/DRKSIrwvX+JsWBZydKAlOqh7bU0W8d8YC9eF/XeM0p9BkJut?=
 =?iso-8859-1?Q?Y8y3tVvEKtJkJAnYXeNdWQ2fMz00fNNiau7hghFm2aK82+eiUvB82yOm7V?=
 =?iso-8859-1?Q?b8GbZQ4GM3JgXAtSoy4fIrNo9lG/xAI1eIYyfdaDbSPQzCWmC+AkRn2g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d34d4a-dee7-488b-928e-08dd467c0768
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 07:01:07.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPwieJWVudADRo2NGF7eTL3gWoHSmntROFZWWFV29NtudVTMBixdY3xiDhoWxm075tXua+GFXEvuGVGDcPQnUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.4% regression of postmark.transactions on:


commit: 7e13f4f8d27dc02fb88666f603c53ca749d56f92 ("nfsd: handle delegated timestamps in SETATTR")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      bdd4f86c97e60b748027bdf6f6a3729c8a12da15]
[test failed on linux-next/master df4b2bbff898227db0c14264ac7edd634e79f755]

testcase: postmark
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
parameters:

	disk: 1HDD
	fs: xfs
	fs1: nfsv4
	number: 1000n
	trans: 30000s
	subdirs: 100d
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502061435.62604a8d-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250206/202502061435.62604a8d-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs1/fs/kconfig/number/rootfs/subdirs/tbox_group/testcase/trans:
  gcc-12/performance/1HDD/nfsv4/xfs/x86_64-rhel-9.4/1000n/debian-12-x86_64-20240206.cgz/100d/lkp-ivb-d04/postmark/30000s

commit: 
  6ae30d6eb2 ("nfsd: add support for delegated timestamps")
  7e13f4f8d2 ("nfsd: handle delegated timestamps in SETATTR")

6ae30d6eb26bce02 7e13f4f8d27dc02fb88666f603c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     16.93            -1.5       15.46        mpstat.cpu.all.iowait%
      3253           +13.8%       3702 ±  4%  uptime.idle
      0.70           -11.7%       0.62 ±  2%  vmstat.procs.b
      4265            -6.1%       4004 ±  3%  vmstat.system.cs
     80.56            +2.0%      82.16        iostat.cpu.idle
     16.90            -8.7%      15.43        iostat.cpu.iowait
      1.60            -4.1%       1.53 ±  2%  iostat.cpu.system
      8974            +5.0%       9424        proc-vmstat.nr_shmem
   1446157            +6.3%    1537480 ±  2%  proc-vmstat.numa_hit
   1446157            +6.3%    1537478 ±  2%  proc-vmstat.numa_local
   1736096            +5.6%    1834173 ±  2%  proc-vmstat.pgalloc_normal
   1429310           +11.5%    1594111 ±  3%  proc-vmstat.pgfault
   1834412            +5.2%    1929590 ±  2%  proc-vmstat.pgfree
    659217            +5.2%     693777        proc-vmstat.pgpgout
     74887           +12.5%      84235 ±  4%  proc-vmstat.pgreuse
      0.74 ± 10%     -23.7%       0.56 ± 17%  sched_debug.cfs_rq:/.h_nr_running.avg
    360.38 ±  5%      +9.0%     392.67 ±  4%  sched_debug.cfs_rq:/.load_avg.stddev
      0.48 ± 17%     -26.1%       0.36 ± 13%  sched_debug.cfs_rq:/.nr_running.avg
    417.13 ±  5%     -14.4%     356.95 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
    382.46 ±  6%     -15.4%     323.57 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
    499.84 ±  7%     +39.8%     698.95 ± 22%  sched_debug.cpu.clock_task.stddev
      0.73 ± 12%     -23.4%       0.56 ± 17%  sched_debug.cpu.nr_running.avg
      2791 ±  2%      -8.0%       2567 ±  4%  sched_debug.cpu.nr_uninterruptible.max
      0.02 ±  6%     +13.0%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      0.03 ± 10%     +36.0%       0.04 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 39%     -90.9%       0.00 ±173%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.05           -18.8%       0.04 ± 12%  perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.01 ± 61%     -93.6%       0.00 ±173%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    619.85 ±  4%     -10.2%     556.79 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      1642 ± 23%     +51.7%       2490 ± 19%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    619.83 ±  4%     -10.2%     556.76 ± 10%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.20 ±  4%     +10.4%       0.22 ±  6%  perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      1642 ± 23%     +51.7%       2490 ± 19%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     16.14           -10.4%      14.46        postmark.creation_mixed_trans
    256446           -10.8%     228826 ±  3%  postmark.data_read
    271043           -10.8%     241851 ±  3%  postmark.data_written
     16.30           -10.4%      14.61        postmark.deletion_mixed_trans
     16.03           -10.4%      14.36        postmark.files_appended
     16.34           -10.8%      14.58 ±  3%  postmark.files_created
     16.34           -10.8%      14.58 ±  3%  postmark.files_deleted
     16.28           -10.4%      14.58        postmark.files_read
    977.64           +12.2%       1096 ±  3%  postmark.time.elapsed_time
    977.64           +12.2%       1096 ±  3%  postmark.time.elapsed_time.max
     32.45           -10.4%      29.07        postmark.transactions
      9596 ±  3%     -51.9%       4617 ±  4%  nfsstat.Client.nfs.v4.delegreturn
     10.45           -49.4%       5.28        nfsstat.Client.nfs.v4.delegreturn.percent
      0.01 ±  3%     -13.8%       0.01 ±  3%  nfsstat.Client.nfs.v4.exchange_id.percent
      0.01 ±  3%     -13.8%       0.01 ±  3%  nfsstat.Client.nfs.v4.getattr.percent
      0.01 ±  3%     -13.8%       0.01 ±  3%  nfsstat.Client.nfs.v4.pathconf.percent
     76622 ±  3%     -10.5%      68577 ±  4%  nfsstat.Client.rpc.authrefrsh
     76621 ±  3%     -10.5%      68577 ±  4%  nfsstat.Client.rpc.calls
     76621 ±  3%     -10.5%      68576 ±  4%  nfsstat.Server.nfs.v4.compound
     76615 ±  3%     -10.5%      68570 ±  4%  nfsstat.Server.nfs.v4.operations.putfh
     76618 ±  3%     -10.5%      68573 ±  4%  nfsstat.Server.nfs.v4.operations.sequence
     76622 ±  3%     -10.5%      68577 ±  4%  nfsstat.Server.packet.packets
     76622 ±  3%     -10.5%      68577 ±  4%  nfsstat.Server.packet.tcp
     76622 ±  3%     -10.5%      68577 ±  4%  nfsstat.Server.reply.cache.nocache
     76622 ±  3%     -10.5%      68577 ±  4%  nfsstat.Server.rpc.calls
      7.92            +4.5%       8.28        perf-stat.i.MPKI
     11.06            +0.2       11.25        perf-stat.i.branch-miss-rate%
      9.69            +0.2        9.92        perf-stat.i.cache-miss-rate%
   7752348            -2.7%    7540156 ±  2%  perf-stat.i.cache-references
      4273            -6.2%       4010 ±  3%  perf-stat.i.context-switches
      3.20            +1.5%       3.25        perf-stat.i.cpi
    140.79            -6.5%     131.59 ±  3%  perf-stat.i.cpu-migrations
    454.52            -2.5%     443.37        perf-stat.i.cycles-between-cache-misses
      0.34            -1.6%       0.33        perf-stat.i.ipc
      0.78           -16.6%       0.65 ±  5%  perf-stat.i.metric.K/sec
      8.13            +0.1        8.26        perf-stat.overall.branch-miss-rate%
      9.46            +0.2        9.65        perf-stat.overall.cache-miss-rate%
    538.98            -3.7%     519.07        perf-stat.overall.cycles-between-cache-misses
   7744340            -2.7%    7533176 ±  2%  perf-stat.ps.cache-references
      4268            -6.2%       4006 ±  3%  perf-stat.ps.context-switches
    140.64            -6.5%     131.47 ±  3%  perf-stat.ps.cpu-migrations
      7.02 ±  6%      -1.8        5.26 ± 23%  perf-profile.calltrace.cycles-pp.nfsd.kthread.ret_from_fork.ret_from_fork_asm
      6.97 ±  5%      -1.7        5.24 ± 23%  perf-profile.calltrace.cycles-pp.svc_recv.nfsd.kthread.ret_from_fork.ret_from_fork_asm
      6.21 ±  7%      -1.7        4.49 ± 22%  perf-profile.calltrace.cycles-pp.svc_handle_xprt.svc_recv.nfsd.kthread.ret_from_fork
      4.18 ±  6%      -1.2        2.97 ± 25%  perf-profile.calltrace.cycles-pp.svc_process.svc_handle_xprt.svc_recv.nfsd.kthread
      4.17 ±  5%      -1.2        2.97 ± 25%  perf-profile.calltrace.cycles-pp.svc_process_common.svc_process.svc_handle_xprt.svc_recv.nfsd
      3.64 ±  5%      -1.0        2.66 ± 26%  perf-profile.calltrace.cycles-pp.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt
      1.06 ± 24%      -0.5        0.53 ± 61%  perf-profile.calltrace.cycles-pp.xfs_file_fsync.xfs_file_buffered_write.do_iter_readv_writev.vfs_iter_write.nfsd_vfs_write
     46.56 ±  2%      +2.0       48.60 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     53.42 ±  2%      +2.2       55.59 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     53.42 ±  2%      +2.2       55.60 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     53.34 ±  2%      +2.2       55.53 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     49.91 ±  2%      +2.3       52.24 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      7.02 ±  6%      -1.8        5.26 ± 23%  perf-profile.children.cycles-pp.nfsd
      6.97 ±  5%      -1.7        5.24 ± 23%  perf-profile.children.cycles-pp.svc_recv
      6.21 ±  7%      -1.7        4.49 ± 22%  perf-profile.children.cycles-pp.svc_handle_xprt
      4.18 ±  6%      -1.2        2.97 ± 25%  perf-profile.children.cycles-pp.svc_process
      4.17 ±  5%      -1.2        2.97 ± 25%  perf-profile.children.cycles-pp.svc_process_common
      3.64 ±  5%      -1.0        2.68 ± 25%  perf-profile.children.cycles-pp.nfsd4_proc_compound
      1.49 ± 15%      -0.6        0.88 ± 20%  perf-profile.children.cycles-pp.sched_balance_rq
      0.96 ±  7%      -0.4        0.52 ± 28%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      1.88 ± 14%      -0.4        1.45 ± 12%  perf-profile.children.cycles-pp.__pick_next_task
      1.06 ± 24%      -0.4        0.63 ± 28%  perf-profile.children.cycles-pp.xfs_file_fsync
      0.76 ± 32%      -0.4        0.36 ± 21%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.83 ± 14%      -0.4        0.45 ± 32%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.78 ± 24%      -0.3        0.50 ± 35%  perf-profile.children.cycles-pp.file_write_and_wait_range
      0.97 ±  6%      -0.3        0.70 ± 16%  perf-profile.children.cycles-pp.update_load_avg
      0.65 ± 23%      -0.2        0.40 ± 16%  perf-profile.children.cycles-pp.nfsd4_open
      0.81 ± 15%      -0.2        0.56 ± 33%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.81 ± 15%      -0.2        0.56 ± 33%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      0.50 ± 30%      -0.2        0.27 ± 45%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.78 ± 15%      -0.2        0.58 ± 31%  perf-profile.children.cycles-pp.do_writepages
      0.48 ± 14%      -0.2        0.29 ± 28%  perf-profile.children.cycles-pp.vfs_unlink
      0.34 ±  9%      -0.2        0.16 ± 44%  perf-profile.children.cycles-pp.nfs_file_release
      0.50 ± 14%      -0.2        0.34 ± 26%  perf-profile.children.cycles-pp.nfsd4_remove
      0.50 ± 14%      -0.2        0.34 ± 26%  perf-profile.children.cycles-pp.nfsd_unlink
      0.52 ±  9%      -0.2        0.36 ± 21%  perf-profile.children.cycles-pp.svc_tcp_recvfrom
      0.30 ± 18%      -0.2        0.15 ± 40%  perf-profile.children.cycles-pp.__put_nfs_open_context
      0.21 ± 19%      -0.2        0.06 ± 77%  perf-profile.children.cycles-pp.xfs_remove
      0.21 ± 19%      -0.2        0.06 ± 77%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.43 ± 26%      -0.1        0.29 ± 25%  perf-profile.children.cycles-pp.__common_interrupt
      0.18 ± 45%      -0.1        0.04 ±110%  perf-profile.children.cycles-pp.rpc_exit_task
      0.17 ± 38%      -0.1        0.03 ±105%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.28 ± 22%      -0.1        0.14 ± 39%  perf-profile.children.cycles-pp.nfs4_do_close
      0.27 ± 11%      -0.1        0.14 ± 58%  perf-profile.children.cycles-pp.xfs_generic_create
      0.17 ± 53%      -0.1        0.05 ±122%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.21 ± 39%      -0.1        0.09 ± 64%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.30 ± 10%      -0.1        0.18 ± 12%  perf-profile.children.cycles-pp.svc_tcp_read_marker
      0.32 ± 11%      -0.1        0.21 ± 22%  perf-profile.children.cycles-pp.svc_tcp_sock_recv_cmsg
      0.27 ± 11%      -0.1        0.15 ± 61%  perf-profile.children.cycles-pp.dentry_create
      0.21 ± 28%      -0.1        0.10 ± 74%  perf-profile.children.cycles-pp.nfsd4_encode_operation
      0.27 ± 11%      -0.1        0.15 ± 61%  perf-profile.children.cycles-pp.vfs_create
      0.18 ± 24%      -0.1        0.06 ± 59%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.30 ± 11%      -0.1        0.20 ± 23%  perf-profile.children.cycles-pp.task_contending
      0.17 ± 23%      -0.1        0.06 ± 59%  perf-profile.children.cycles-pp.wakeup_preempt
      0.14 ± 31%      -0.1        0.04 ±110%  perf-profile.children.cycles-pp.down_write
      0.19 ± 21%      -0.1        0.09 ± 63%  perf-profile.children.cycles-pp.call_decode
      0.14 ± 14%      -0.1        0.06 ±100%  perf-profile.children.cycles-pp.tick_program_event
      0.15 ± 22%      -0.1        0.08 ± 58%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.02 ±173%      +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.complete
      0.00            +0.1        0.08 ± 38%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.11 ± 15%      +0.1        0.20 ± 22%  perf-profile.children.cycles-pp.rpc_wake_up_queued_task
      0.02 ±173%      +0.1        0.13 ± 56%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.02 ±173%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.swake_up_one
      0.03 ±173%      +0.1        0.16 ± 30%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.13 ± 89%      +0.2        0.28 ± 30%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.21 ± 14%      +0.2        0.36 ± 24%  perf-profile.children.cycles-pp.__mmap_prepare
      0.04 ±100%      +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.05 ±103%      +0.2        0.21 ± 29%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.13 ± 25%      +0.2        0.30 ± 26%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
     53.42 ±  2%      +2.2       55.60 ±  2%  perf-profile.children.cycles-pp.start_secondary
      0.21 ± 39%      -0.1        0.09 ± 64%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.12 ± 23%      -0.1        0.04 ± 63%  perf-profile.self.cycles-pp.local_clock_noinstr
      0.21 ± 15%      -0.1        0.14 ± 26%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.08 ± 23%  perf-profile.self.cycles-pp.nfsd_setuser
      0.00            +0.1        0.08 ± 23%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.08 ± 61%      +0.1        0.16 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter
      0.02 ±173%      +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.tmigr_quick_check
      0.00            +0.1        0.10 ± 49%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.02 ±173%      +0.1        0.13 ± 56%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.07 ± 62%      +0.1        0.18 ± 39%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.15 ± 39%      +0.1        0.28 ± 22%  perf-profile.self.cycles-pp.sched_tick




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


