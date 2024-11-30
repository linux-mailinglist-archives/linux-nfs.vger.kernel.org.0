Return-Path: <linux-nfs+bounces-8269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCF9DEFF9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363E41635C0
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31F156F30;
	Sat, 30 Nov 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa9Hv37E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003115539F
	for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732963474; cv=fail; b=jupghEAtlY7fmPZqA4r196FCmlbPhzvfSDANTg5gqNhyX/VJ//YhH71mh0AyWb6A9hLPDTFml8wIKP9X4ljteqQ/T+CMzJehXIwnOD6Mt1I/ovC72mKY6nglx53WOeyHFe02dTH66Q0lWm25EohC5EnruWTjZqd49TWaElJ0ywo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732963474; c=relaxed/simple;
	bh=j+VxmUz7GV1tblNYm+xpUCC7hTvPfhXiNr8d/+ONoMc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Fvfu7TUmyo0GfVsfAdiL50YeVJ1qIVE1scH7+C10j/Ts1yiaayXqayX1uFelDyorsjmXDWtNTOIUk+ugxBmQDIB5NhcQM6BGHjvYQFKyPQQQzbfLso2gqj94TSRvVbktZVzwyvDqK4+JASeeizWhx3Ih+sI9A/YDbUVf1cFlMpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa9Hv37E; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732963470; x=1764499470;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=j+VxmUz7GV1tblNYm+xpUCC7hTvPfhXiNr8d/+ONoMc=;
  b=Xa9Hv37En98uCg4/k2lG7WXRjpv/8ZDctNsGn4R76RMxmNIuu/0J+i2m
   +5EVY5r6bHa8Z/bZaVk+dgWmw7yUt1NZWYixugzUzUrhGnKdvzbW8vdmI
   4TklZjw4dv+2au0cL5gPCuk2SR9qw24hdf2z0TGwOhcwfszgRBlnMhP7A
   hrjktTGz+V8HLiziDN4mk217d6UXIYq1u+nko1J9u4gmtvP/7WiUa4J4U
   2Cu1GEwfwAzFitnmStym7yFQ73ooCytEZkP8neQ2/hwesZMqo+NBtYC8o
   prUq4Et6uJ53gJiTu5DZ5PqcE18XDjQUOleoATHOKO4cnFUtsteQF0qQp
   Q==;
X-CSE-ConnectionGUID: cfuMJ8s8SFKhG20p1OZUYA==
X-CSE-MsgGUID: sGGlTCDkR/ehFL9VlPNs8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="50579611"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="50579611"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 02:44:29 -0800
X-CSE-ConnectionGUID: OUtYUaQ1RWCkHBKjmJLKrA==
X-CSE-MsgGUID: xwPDXXM5RIC7jYe9giv20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97704719"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2024 02:44:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 30 Nov 2024 02:44:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 30 Nov 2024 02:44:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 30 Nov 2024 02:44:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA2kLObFzfGHZrueNzcdmWU0kjilD/ZhdhXtfp08vB02YlDsYOCORXyOGnHSQc7pfNMKqqXRJDUvfUUHSQQwAlIuAHxSftFvjekkQn2g1aCM3cao1q0bhl4E5tuVpU/AlPliocS7awdZiOBIrsd4cv+ayYxxO1jgn0ta/m13JbVfK5hHgXdpg8zwlE9H+OLmAn+I/Tr8nfarZNUAR+bvGRYnN33+lkyFaBEciJe7LBo3a/8RO1cZ68cmQRKh7d8NP3+32uLFaECEMEKa9Cu6k/TrgY5S08f5QWREtyxMt2V4yiHEz7ghpAbd2ZGZ46AV9Q519O36KVuf8dWiafDIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8OLWbUxMZiM5VQ709MwvT1ajZbKbvszN5m8KYaobDg=;
 b=xF1FX6YTz5fO4vHPryX+I7YBVu4ajTIfpihxHVqJdKKVIQGY54yqOIXWyvcVtGHWo+9c3zQMRQ+ffZrcjXhvxycxkqKM0jzb6nPsqtN7t4Gpzo42u20+bbNncxkV5YrP/sLBkGG1U6zcH+1K58GNgqeT/elJwPo0x7KYfzFIc4zKbQxEsm8OZpi2/+xL1F2oo8vJw99A1DgMejr2KF/mHNMZynZFaFiLIiG2HPtM1CnZrdYLwi7x54nf9oM52ppyMsnmm1jC004oTiFKzvvEj981CRUXsu4A9HTffXeGBoDX7NxxpE6tKvpLkGqO1AI0/re4G8aMwb384nyX2pb9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Sat, 30 Nov
 2024 10:44:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 10:44:24 +0000
Date: Sat, 30 Nov 2024 18:44:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [nfs]  b6dea6c7fe:  fsmark.files_per_sec 17.6%
 regression
Message-ID: <202411301633.3ed8df2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: abefe153-c141-4831-4ad3-08dd112bf4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qrAM7e01/S7JcnTtNNA/Rb7LvN/Bj3MxWHBUoRSSoYRl4NVZXUk2yahmJJ?=
 =?iso-8859-1?Q?3hWOt+3RI2BJONe/IhbEVPZXFipOBK/vDZhiYjHR0HIjvfTUmDi0f9b0GR?=
 =?iso-8859-1?Q?f6jtk5ac+u8z0YkMP2OGEXbz5Yi7KMWYcTOwLnSJTZOQmU3ibOyC2uc2Qg?=
 =?iso-8859-1?Q?HuC3S7veC3HcTWbldw8CzMLYQfWXK13ZQw3x0jFiHNkesOCj28//6weqC9?=
 =?iso-8859-1?Q?O6vHq6QQ2rhsZjdCxZH+t1vg6eGVXIIfJzUvwFDFOfglhEGxKhXNR80sqe?=
 =?iso-8859-1?Q?VzPlfgkpRIO4V7M1plQaeCaW25LMEKJ9rb/75dUlTUrBwbAIu9uRQK9Ufa?=
 =?iso-8859-1?Q?dWMbGXwt9EdBv0tOdKkRa7180eGYlZhUFecZxPBvJyG+zjCOtJ2Us8xfEa?=
 =?iso-8859-1?Q?19+96fkGdB8j/aVpPePwvMAA/ywAz3qO1wpP7X7EBUmGTiYW2Cl7PI5kSa?=
 =?iso-8859-1?Q?VknOtZxkyrdIoGaZc9+TGUhOumDFZJfFO+iW2Nb/AHwpSz2WDF8Gax8lNU?=
 =?iso-8859-1?Q?IW+4fmDM7qeacrZ53vMEIg4qT3gQyXl/Ep3GkxIsOVD/8XCG8DvXGByBgm?=
 =?iso-8859-1?Q?/ptz0bz0yMtpIzM/sKV7OdYKE0q9eif+/kYg7bx4cwVJXKRQjhxb0CwzD6?=
 =?iso-8859-1?Q?skJyeKvxE534Xnzr6SjAjvvKQEYJ0kLNqwOx9ISpU7eC4mMyWditxsmRSL?=
 =?iso-8859-1?Q?DgOAIWOL78XCFUauCjILdBKao5K7+2fdV7g5GvLZFKR1rI9xINJrDSOkMt?=
 =?iso-8859-1?Q?3wZfi0RC0FQJWQgqVQFtkaDI5veHf5Xydl0aZxj1w3O1g0TmlJ2Q31sV1u?=
 =?iso-8859-1?Q?aqZAHGAR6uF7sx6GaZfBOWsuge+4QthJLJ7AoBKM53jSU0EDENmthA1F5d?=
 =?iso-8859-1?Q?21Emv8vFbRxXVCEQydJsf3uNnoYoQHxu041bClJG/pBCRFCj24O9SeA5zZ?=
 =?iso-8859-1?Q?akYTdi5UHjCU4IHmIyFg0AtvfeCdbDdx3lwTaxEZ9ToaQUhgRgcoQUwnyi?=
 =?iso-8859-1?Q?XYB6Ehr6Fcimi4dXs8b4YVncXYBVf5grR/iNxoqk2GIGy8/VJeZMsO3nj2?=
 =?iso-8859-1?Q?RIOhyLDNJxiJef3QlnlsDODU2hgNx/LuIXDoBoeoBrn3MejMjoblm/oF6t?=
 =?iso-8859-1?Q?Npdv99bjduNnP82zc9KRV61lNeecF8wi/7Yv+9rCDvluBSc+QTClb1pbR+?=
 =?iso-8859-1?Q?CYrfwz9lOzr39M8UvPeVpSA1e9jo9KZUe2L5DnrFxoa+dlCSWPbTVHVBg9?=
 =?iso-8859-1?Q?mT8RF718iYwfJ6XXDj6x8sjeEdv/Q6m5iNQXYDXDJqvnoy/fTXffDDwaJn?=
 =?iso-8859-1?Q?4Kiw8q6MKsJQs0lq+coTtX1jrN7RYLx2iT0V3LGN2AuhdCHzRD1Isr5UwC?=
 =?iso-8859-1?Q?P77ooi6kjY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tCEUj2ZReQdp9KuSKpXieRxchfggUYAcR9HldSHybhUH1KNRCNIwmoZESW?=
 =?iso-8859-1?Q?d6gVrSFztAufM+UQ4BA3ubjOjnXAPdic/euk6nJnokssYPLAlwPz3PN48o?=
 =?iso-8859-1?Q?1qk8jqGHzBICHUVJWL47V7IYh8NEAwwem+aF9xbnV19Yifty1CSBaRSECp?=
 =?iso-8859-1?Q?el3M1mZ7KtCX4Fw7qlMXSr6JvJAtJlfOuuJbrRGlcdIgV77XRmu123knGa?=
 =?iso-8859-1?Q?70fOeniqLQmPbMWDbOtR+o9BRwHpF1Ue7eCLRjPOcgzY046VW8/+f3gF01?=
 =?iso-8859-1?Q?XYpUXHv7CbctpHxXRUCtqXSUnn0pBF3ESvBdbISSFcC7Q79d9OCj8AvsvN?=
 =?iso-8859-1?Q?KwOuDJGqe1hKXaFBzPXeS9ONCiZPelmYgnszaxBYoSwjasz+vNYaP/MXq6?=
 =?iso-8859-1?Q?DNk2grxyDZ1fAvIbTYAhAhofy+XHg4Q7NEWNJ4MD9Sio+/eknWmt/uMPRt?=
 =?iso-8859-1?Q?RvvL6i38PU9zXpCE/ALbjI08aeBB2NLsQcJKAfbitecJPNsLYemTPRZbF3?=
 =?iso-8859-1?Q?pfbP0mONf6Eu2Lj9edXp21yYB3PypEFxv8gUEdNZqMvxppzLjfIoezqpK+?=
 =?iso-8859-1?Q?bRLeu9i1AUcY+ru90qTrFHXAxEjr6BUYMR8U21Tx2gaZFVJQOUPfskDCcK?=
 =?iso-8859-1?Q?HfLefy8yZxMAh2sP42KFlbV56Rso94eXGrcdDFU1G7Xk43umDT2Ty3XjUC?=
 =?iso-8859-1?Q?AoBW68QCd0OHYYdx0ie0SlhMvrCn80yNAC4m5M4MjhLRdIN3jd3aFEUUYZ?=
 =?iso-8859-1?Q?KzGKSxjUcVW7k4Iks+k4ynz7hgsajgfueJeMWV+My/EHswWZ+5ggrWKk8v?=
 =?iso-8859-1?Q?sYV0j4BxPPCmKFCAcgm1zHHghWpDNqFVEKMC++ontAS32FNfa6gQ/fXBsj?=
 =?iso-8859-1?Q?BjKOCsycYAPMtTJqvnI7Tn9+gflrW+jTZTao8SEhYw5JIl2xpkXshkg+ao?=
 =?iso-8859-1?Q?hsT1TVSIxqFfa4/1gL0oifk4cirfYk9S0G6EM6S7PlMcQlAjZqPkb9MKDv?=
 =?iso-8859-1?Q?rH1Zs7MIKueF/lh1WDCkA4mq5eS09WPhFavNvShDBG/upF8tBkEnmqXoGs?=
 =?iso-8859-1?Q?Oo7V6bHZZ3U+Jgm62C5rgr58WATrNYwk5hxqLY88WjIQfQylqaCY0eBKj8?=
 =?iso-8859-1?Q?G4cdtFs3TecTRNlk+N7SSsBNRpWTPZWX/O3vgsDz+E84WrXEGTCS9W+U2k?=
 =?iso-8859-1?Q?gBN4osOzEQgvztTfhwpWfFAJAK+VhWV64dGktxTr5ySsXDEof6b8s+Pt3a?=
 =?iso-8859-1?Q?K49fyFfB9SPoo9BXI8s2tMhGov0uz3kmwGXNx3lyW73BsPsACDlP9w3K/j?=
 =?iso-8859-1?Q?Gur3dEBoBn60Mmig1UfUA7t4iRZ7eH+GfRGPCvr9Q6iyoUdIn/vOaM05+Z?=
 =?iso-8859-1?Q?RCf/S+7I3AYiLEJbZxd9aFEYkMxQrF9QfkYYwh7t2bZ/bXnezJtMlHGEhJ?=
 =?iso-8859-1?Q?/f4oVQ7kWa5JbVO4QcOTNQA4CytyBsmY9FOAbUZ24umh46E1FZy7Hru9V2?=
 =?iso-8859-1?Q?pzmmVc6wfR+SbZQKzaVUVce+OxEJvd/17ISht41WY5PdRPSJoHObOaijKC?=
 =?iso-8859-1?Q?UF5k4R+1e07U0nYLc6tWl8w2nWVFeAPjzippCu8k50X7SG/aN+1pRuvEPI?=
 =?iso-8859-1?Q?hwMhrjIa5cAToI9M8AHSAxigwxrWP802sNzoDmVYNvG7AgbE8T3+0Prg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abefe153-c141-4831-4ad3-08dd112bf4b6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 10:44:24.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv79jPfidCBoSFoHmOAIGcoy8SDdz24A7NKunx9iMbDmRCPY5DZklrTuyuFLATaAXLryKDMFlNxudjp8a/SyHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 17.6% regression of fsmark.files_per_sec on:


commit: b6dea6c7fe2d8187050f882fe6f872d30e495ffe ("nfs: pass flags to second superblock")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba133d341]

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	iterations: 1x
	nr_threads: 32t
	disk: 1SSD
	fs: xfs
	fs2: nfsv4
	filesize: 8K
	test_size: 400M
	sync_method: fsyncBeforeClose
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec  9.4% regression                                                  |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1SSD                                                                                      |
|                  | filesize=9B                                                                                    |
|                  | fs2=nfsv4                                                                                      |
|                  | fs=ext4                                                                                        |
|                  | iterations=1x                                                                                  |
|                  | nr_directories=16d                                                                             |
|                  | nr_files_per_directory=256fpd                                                                  |
|                  | nr_threads=32t                                                                                 |
|                  | sync_method=fsyncBeforeClose                                                                   |
|                  | test_size=400M                                                                                 |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec  15.9% regression                                                 |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1SSD                                                                                      |
|                  | filesize=9B                                                                                    |
|                  | fs2=nfsv4                                                                                      |
|                  | fs=btrfs                                                                                       |
|                  | iterations=1x                                                                                  |
|                  | nr_directories=16d                                                                             |
|                  | nr_files_per_directory=256fpd                                                                  |
|                  | nr_threads=32t                                                                                 |
|                  | sync_method=fsyncBeforeClose                                                                   |
|                  | test_size=400M                                                                                 |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411301633.3ed8df2-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241130/202411301633.3ed8df2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/8K/nfsv4/xfs/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/400M/fsmark

commit: 
  66f9dac907 ("Revert "nfs: don't reuse partially completed requests in nfs_lock_and_join_requests"")
  b6dea6c7fe ("nfs: pass flags to second superblock")

66f9dac9077c9c06 b6dea6c7fe2d8187050f882fe6f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.937e+08 ±  2%     +12.7%   6.69e+08        cpuidle..time
   2360703           +75.8%    4150723        cpuidle..usage
    381905 ±  4%     +70.8%     652235 ±  2%  numa-numastat.node0.local_node
    410324           +65.9%     680670 ±  3%  numa-numastat.node0.numa_hit
      0.48 ±223%      +2.8        3.27 ± 55%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.48 ±223%      +2.8        3.27 ± 55%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     75.28            +5.2%      79.20        iostat.cpu.idle
     16.87           -36.2%      10.76        iostat.cpu.iowait
      5.30 ±  2%     +42.1%       7.52 ±  2%  iostat.cpu.system
     19.34            -7.3       12.07        mpstat.cpu.all.iowait%
      0.65 ±  3%      +0.3        0.94 ±  2%  mpstat.cpu.all.soft%
      4.88 ±  3%      +2.1        7.00 ±  3%  mpstat.cpu.all.sys%
     11.82 ±  3%     +20.4%      14.24        mpstat.max_utilization_pct
  72239710 ±  2%     +55.2%  1.121e+08        fsmark.app_overhead
      4389 ±  2%     -17.6%       3614        fsmark.files_per_sec
     54.67 ±  2%    +106.1%     112.67        fsmark.time.percent_of_cpu_this_job_got
      5.94          +160.1%      15.45        fsmark.time.system_time
    285139          +307.7%    1162591        fsmark.time.voluntary_context_switches
    368790           -47.8%     192655 ±  2%  meminfo.Inactive
    368790           -47.8%     192655 ±  2%  meminfo.Inactive(file)
    173587           -23.0%     133612        meminfo.KReclaimable
    173587           -23.0%     133612        meminfo.SReclaimable
    317373           -13.0%     276190        meminfo.Slab
     16.92           -36.4%      10.76        vmstat.cpu.wa
     58264 ±  3%     -11.4%      51622 ±  2%  vmstat.io.bo
      8.45 ±  7%     -37.6%       5.27 ±  7%  vmstat.procs.b
    269409 ±  2%     +66.6%     448791 ±  3%  vmstat.system.cs
     61548           +16.2%      71538        vmstat.system.in
     53681           -19.8%      43073 ±  8%  numa-vmstat.node0.nr_inactive_file
     53681           -19.8%      43073 ±  8%  numa-vmstat.node0.nr_zone_inactive_file
    410388           +66.1%     681472 ±  3%  numa-vmstat.node0.numa_hit
    381970 ±  4%     +71.0%     653038 ±  2%  numa-vmstat.node0.numa_local
     60942 ± 22%     -48.1%      31659 ± 28%  numa-vmstat.node1.nr_file_pages
     38775 ±  5%     -87.9%       4703 ± 62%  numa-vmstat.node1.nr_inactive_file
     12374 ±  5%     -60.4%       4902 ± 17%  numa-vmstat.node1.nr_slab_reclaimable
     38775 ±  5%     -87.9%       4703 ± 62%  numa-vmstat.node1.nr_zone_inactive_file
    998853            -4.5%     954271        proc-vmstat.nr_file_pages
     92299 ±  2%     -48.3%      47689 ±  2%  proc-vmstat.nr_inactive_file
     43433           -23.4%      33269        proc-vmstat.nr_slab_reclaimable
     92299 ±  2%     -48.3%      47689 ±  2%  proc-vmstat.nr_zone_inactive_file
    646052           +46.8%     948130        proc-vmstat.numa_hit
    596308           +50.7%     898452        proc-vmstat.numa_local
   1067778           +28.3%    1369682        proc-vmstat.pgalloc_normal
    791047 ±  7%     +39.5%    1103617 ±  2%  proc-vmstat.pgfree
    214306           -19.8%     171874 ±  8%  numa-meminfo.node0.Inactive
    214306           -19.8%     171874 ±  8%  numa-meminfo.node0.Inactive(file)
    243433 ± 22%     -48.0%     126616 ± 28%  numa-meminfo.node1.FilePages
    154772 ±  5%     -87.9%      18798 ± 62%  numa-meminfo.node1.Inactive
    154772 ±  5%     -87.9%      18798 ± 62%  numa-meminfo.node1.Inactive(file)
     49305 ±  5%     -60.2%      19601 ± 17%  numa-meminfo.node1.KReclaimable
   1226203 ± 10%     -21.5%     962004 ±  4%  numa-meminfo.node1.MemUsed
     49305 ±  5%     -60.2%      19601 ± 17%  numa-meminfo.node1.SReclaimable
    113120 ±  4%     -30.5%      78616 ±  6%  numa-meminfo.node1.Slab
      1.09 ±  2%     +17.2%       1.28 ±  2%  perf-stat.i.MPKI
 2.083e+09           +19.9%  2.496e+09        perf-stat.i.branch-instructions
      5.09            -0.6        4.46        perf-stat.i.branch-miss-rate%
 1.047e+08            +6.2%  1.112e+08        perf-stat.i.branch-misses
  10791820 ±  2%     +39.9%   15097313        perf-stat.i.cache-misses
 2.272e+08           +34.6%  3.058e+08        perf-stat.i.cache-references
    326576 ±  2%     +60.3%     523588        perf-stat.i.context-switches
      1.62            +8.2%       1.75        perf-stat.i.cpi
 1.584e+10           +30.3%  2.063e+10        perf-stat.i.cpu-cycles
      2314 ±  5%     +68.5%       3899 ±  2%  perf-stat.i.cpu-migrations
      1484            -7.9%       1366        perf-stat.i.cycles-between-cache-misses
 1.002e+10           +18.8%  1.191e+10        perf-stat.i.instructions
      0.64            -7.8%       0.59        perf-stat.i.ipc
      6.98 ±  2%     +58.4%      11.06        perf-stat.i.metric.K/sec
      9083 ±  4%     -12.8%       7919 ±  5%  perf-stat.i.minor-faults
      9084 ±  4%     -12.8%       7919 ±  5%  perf-stat.i.page-faults
      1.08 ±  2%     +17.7%       1.27        perf-stat.overall.MPKI
      5.03            -0.6        4.46        perf-stat.overall.branch-miss-rate%
      4.75            +0.2        4.94        perf-stat.overall.cache-miss-rate%
      1.58            +9.6%       1.73        perf-stat.overall.cpi
      1468            -6.9%       1366        perf-stat.overall.cycles-between-cache-misses
      0.63            -8.8%       0.58        perf-stat.overall.ipc
 1.923e+09           +21.2%   2.33e+09        perf-stat.ps.branch-instructions
  96657387            +7.4%  1.038e+08        perf-stat.ps.branch-misses
   9961712 ±  2%     +41.5%   14091659        perf-stat.ps.cache-misses
 2.097e+08           +36.1%  2.854e+08        perf-stat.ps.cache-references
    301501 ±  2%     +62.1%     488770        perf-stat.ps.context-switches
     44319            +1.1%      44810        perf-stat.ps.cpu-clock
 1.462e+10           +31.7%  1.926e+10        perf-stat.ps.cpu-cycles
      2137 ±  5%     +70.3%       3640 ±  2%  perf-stat.ps.cpu-migrations
  9.25e+09           +20.2%  1.112e+10        perf-stat.ps.instructions
     44319            +1.1%      44810        perf-stat.ps.task-clock
 1.206e+11           +38.7%  1.673e+11        perf-stat.total.instructions


***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/9B/nfsv4/ext4/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/400M/fsmark

commit: 
  66f9dac907 ("Revert "nfs: don't reuse partially completed requests in nfs_lock_and_join_requests"")
  b6dea6c7fe ("nfs: pass flags to second superblock")

66f9dac9077c9c06 b6dea6c7fe2d8187050f882fe6f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   5106420           +67.0%    8530260        cpuidle..usage
     -7.83           +34.0%     -10.50        sched_debug.cpu.nr_uninterruptible.min
     74.15            +4.5%      77.46        iostat.cpu.idle
     18.76           -31.4%      12.87        iostat.cpu.iowait
      4.63           +49.8%       6.94        iostat.cpu.system
      2.46 ±  2%     +10.9%       2.73        iostat.cpu.user
    693560 ± 10%     +42.7%     989531 ± 10%  numa-numastat.node0.local_node
    707512 ±  9%     +42.3%    1007109 ±  9%  numa-numastat.node0.numa_hit
    506340 ± 12%     +85.9%     941327 ± 10%  numa-numastat.node1.local_node
    542074 ± 11%     +79.6%     973549 ±  9%  numa-numastat.node1.numa_hit
 2.236e+08           +34.9%  3.016e+08        fsmark.app_overhead
      2969            -9.4%       2692        fsmark.files_per_sec
     40.17          +138.2%      95.67        fsmark.time.percent_of_cpu_this_job_got
     12.75          +176.3%      35.23        fsmark.time.system_time
    568715          +308.9%    2325201        fsmark.time.voluntary_context_switches
     19.76            -6.3       13.49        mpstat.cpu.all.iowait%
      0.59            +0.3        0.88        mpstat.cpu.all.soft%
      3.90            +2.1        5.99        mpstat.cpu.all.sys%
      2.38 ±  2%      +0.3        2.71        mpstat.cpu.all.usr%
      2.00         +1783.3%      37.67        mpstat.max_utilization.seconds
     10.03           +37.5%      13.79        mpstat.max_utilization_pct
     18.74           -31.0%      12.92        vmstat.cpu.wa
    107144            -5.5%     101202        vmstat.io.bo
      9.71 ±  3%     -35.7%       6.24 ± 10%  vmstat.procs.b
      4.53 ±  5%     +27.6%       5.78 ±  6%  vmstat.procs.r
    197002           +79.6%     353838        vmstat.system.cs
     58233           +13.7%      66197        vmstat.system.in
    853950           +11.7%     954196        meminfo.Active
    853950           +11.7%     954196        meminfo.Active(anon)
    215530           +11.0%     239344        meminfo.Buffers
    625583           -28.1%     449956        meminfo.Inactive
    625583           -28.1%     449956        meminfo.Inactive(file)
    241001           -27.6%     174436        meminfo.KReclaimable
    106011 ±  8%     +49.3%     158268 ± 10%  meminfo.Mapped
    241001           -27.6%     174436        meminfo.SReclaimable
     46597 ± 21%    +201.0%     140273 ±  8%  meminfo.Shmem
    388729           -19.3%     313805        meminfo.Slab
     82817 ± 40%     +45.7%     120654 ±  7%  numa-vmstat.node0.nr_active_anon
     76526 ± 43%     +41.7%     108400 ±  2%  numa-vmstat.node0.nr_anon_pages
    951.19 ± 20%     -22.7%     735.13 ±  7%  numa-vmstat.node0.nr_dirty
     80529 ± 21%     -37.8%      50085 ± 10%  numa-vmstat.node0.nr_inactive_file
     21948 ±  8%     +24.0%      27212 ± 10%  numa-vmstat.node0.nr_mapped
     39688 ±  5%     -25.1%      29725 ±  4%  numa-vmstat.node0.nr_slab_reclaimable
     21176 ±  2%      -8.3%      19425 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
     82817 ± 40%     +45.7%     120653 ±  7%  numa-vmstat.node0.nr_zone_active_anon
     80529 ± 21%     -37.8%      50085 ± 10%  numa-vmstat.node0.nr_zone_inactive_file
    707539 ±  9%     +42.5%    1008378 ±  9%  numa-vmstat.node0.numa_hit
    693587 ± 10%     +42.9%     990800 ± 10%  numa-vmstat.node0.numa_local
      5107 ± 58%    +162.7%      13416 ± 30%  numa-vmstat.node1.nr_mapped
      5650 ± 24%    +315.7%      23492 ± 41%  numa-vmstat.node1.nr_shmem
     20564 ± 10%     -32.2%      13935 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
    541047 ± 11%     +80.2%     974981 ±  9%  numa-vmstat.node1.numa_hit
    505313 ± 13%     +86.6%     942759 ± 10%  numa-vmstat.node1.numa_local
      6.38 ± 46%      -3.5        2.85 ±141%  perf-profile.calltrace.cycles-pp.__cmd_record
      6.38 ± 46%      -3.5        2.85 ±141%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      6.38 ± 46%      -3.5        2.85 ±141%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      6.38 ± 46%      -3.5        2.85 ±141%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      5.88 ± 35%      -3.4        2.47 ±142%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      5.88 ± 35%      -3.4        2.47 ±142%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      4.37 ± 56%      -1.5        2.85 ±141%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      7.90 ± 12%      -5.0        2.85 ±141%  perf-profile.children.cycles-pp.perf_session__process_events
      7.90 ± 12%      -5.0        2.85 ±141%  perf-profile.children.cycles-pp.reader__read_event
      7.90 ± 12%      -5.0        2.85 ±141%  perf-profile.children.cycles-pp.record__finish_output
      5.88 ± 35%      -3.4        2.47 ±142%  perf-profile.children.cycles-pp.ordered_events__queue
      5.88 ± 35%      -3.4        2.47 ±142%  perf-profile.children.cycles-pp.queue_event
      5.88 ± 35%      -3.0        2.85 ±141%  perf-profile.children.cycles-pp.process_simple
      5.74 ± 74%      +5.4       11.18 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     31.02 ± 11%     +10.6       41.66 ± 12%  perf-profile.children.cycles-pp.do_syscall_64
     31.29 ± 11%     +10.7       42.01 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.47 ± 35%      -3.3        2.14 ±141%  perf-profile.self.cycles-pp.queue_event
    331331 ± 40%     +45.4%     481839 ±  6%  numa-meminfo.node0.Active
    331331 ± 40%     +45.4%     481839 ±  6%  numa-meminfo.node0.Active(anon)
     36095 ± 34%    +185.6%     103075 ± 61%  numa-meminfo.node0.AnonHugePages
    306688 ± 43%     +41.3%     433493 ±  2%  numa-meminfo.node0.AnonPages
    352666 ± 34%     +39.9%     493368 ±  2%  numa-meminfo.node0.AnonPages.max
      3781 ± 20%     -22.7%       2921 ±  7%  numa-meminfo.node0.Dirty
    321823 ± 21%     -37.9%     199875 ± 10%  numa-meminfo.node0.Inactive
    321823 ± 21%     -37.9%     199875 ± 10%  numa-meminfo.node0.Inactive(file)
    158690 ±  5%     -25.1%     118818 ±  4%  numa-meminfo.node0.KReclaimable
     86534 ±  7%     +23.8%     107125 ± 10%  numa-meminfo.node0.Mapped
    158690 ±  5%     -25.1%     118818 ±  4%  numa-meminfo.node0.SReclaimable
     84681 ±  2%      -8.2%      77738 ±  3%  numa-meminfo.node0.SUnreclaim
    243372 ±  3%     -19.2%     196556 ±  3%  numa-meminfo.node0.Slab
    546078 ± 22%     -22.0%     425684 ±  3%  numa-meminfo.node1.AnonPages.max
     82272 ± 10%     -32.3%      55659 ±  9%  numa-meminfo.node1.KReclaimable
     19884 ± 58%    +162.6%      52218 ± 29%  numa-meminfo.node1.Mapped
     82272 ± 10%     -32.3%      55659 ±  9%  numa-meminfo.node1.SReclaimable
     22229 ± 25%    +316.9%      92680 ± 41%  numa-meminfo.node1.Shmem
    145380 ±  5%     -19.3%     117350 ±  5%  numa-meminfo.node1.Slab
    213612           +11.8%     238855        proc-vmstat.nr_active_anon
   1073968            -1.9%    1053722        proc-vmstat.nr_file_pages
    156460           -28.0%     112595        proc-vmstat.nr_inactive_file
     26834 ±  8%     +49.6%      40137 ± 10%  proc-vmstat.nr_mapped
     11754 ± 21%    +200.7%      35348 ±  8%  proc-vmstat.nr_shmem
     60226           -27.6%      43625        proc-vmstat.nr_slab_reclaimable
     36950            -5.6%      34868        proc-vmstat.nr_slab_unreclaimable
    212974            -1.3%     210204        proc-vmstat.nr_written
    213612           +11.8%     238855        proc-vmstat.nr_zone_active_anon
    156460           -28.0%     112595        proc-vmstat.nr_zone_inactive_file
      1933 ±131%   +2667.4%      53507 ± 10%  proc-vmstat.numa_hint_faults
      1881 ±136%   +1483.1%      29778 ± 17%  proc-vmstat.numa_hint_faults_local
   1251477           +58.6%    1984851        proc-vmstat.numa_hit
   1201787           +60.9%    1933842        proc-vmstat.numa_local
     44.50 ± 97%  +17611.6%       7881 ± 45%  proc-vmstat.numa_pages_migrated
    104657 ± 37%    +114.9%     224925 ± 28%  proc-vmstat.numa_pte_updates
   1702749           +43.7%    2446144        proc-vmstat.pgalloc_normal
    296195 ±  2%     +22.1%     361669 ±  2%  proc-vmstat.pgfault
   1182870 ±  5%     +53.0%    1809606        proc-vmstat.pgfree
     44.50 ± 97%  +17611.6%       7881 ± 45%  proc-vmstat.pgmigrate_success
   4105642            +2.2%    4195938        proc-vmstat.pgpgout
      1.28 ±  4%     +11.1%       1.43        perf-stat.i.MPKI
 1.739e+09           +34.1%  2.331e+09        perf-stat.i.branch-instructions
      6.12            -1.1        5.00        perf-stat.i.branch-miss-rate%
 1.039e+08            +9.3%  1.136e+08        perf-stat.i.branch-misses
  10490708 ±  4%     +46.2%   15335649        perf-stat.i.cache-misses
 1.682e+08           +46.6%  2.467e+08        perf-stat.i.cache-references
    212706           +77.6%     377834        perf-stat.i.context-switches
      1.61            +6.3%       1.71        perf-stat.i.cpi
 1.309e+10           +40.3%  1.836e+10        perf-stat.i.cpu-cycles
      2446 ± 11%     +59.1%       3891 ±  3%  perf-stat.i.cpu-migrations
      1267 ±  4%      -5.2%       1201        perf-stat.i.cycles-between-cache-misses
 8.326e+09           +32.8%  1.106e+10        perf-stat.i.instructions
      0.63            -5.3%       0.60        perf-stat.i.ipc
      4.47           +77.3%       7.93        perf-stat.i.metric.K/sec
      5993 ±  3%     +21.2%       7266 ±  3%  perf-stat.i.minor-faults
      5994 ±  3%     +21.2%       7266 ±  3%  perf-stat.i.page-faults
      1.26 ±  4%     +10.1%       1.39        perf-stat.overall.MPKI
      5.98            -1.1        4.87        perf-stat.overall.branch-miss-rate%
      1.57            +5.6%       1.66        perf-stat.overall.cpi
      1249 ±  4%      -4.2%       1197        perf-stat.overall.cycles-between-cache-misses
      0.64            -5.3%       0.60        perf-stat.overall.ipc
  1.69e+09           +34.4%  2.271e+09        perf-stat.ps.branch-instructions
  1.01e+08            +9.5%  1.106e+08        perf-stat.ps.branch-misses
  10198918 ±  4%     +46.5%   14941127        perf-stat.ps.cache-misses
 1.636e+08           +47.0%  2.404e+08        perf-stat.ps.cache-references
    206791           +78.0%     368107        perf-stat.ps.context-switches
 1.272e+10           +40.6%  1.788e+10        perf-stat.ps.cpu-cycles
      2378 ± 11%     +59.4%       3791 ±  3%  perf-stat.ps.cpu-migrations
 8.094e+09           +33.1%  1.077e+10        perf-stat.ps.instructions
      5824 ±  3%     +21.5%       7077 ±  3%  perf-stat.ps.minor-faults
      5824 ±  3%     +21.5%       7077 ±  3%  perf-stat.ps.page-faults
 2.924e+11 ±  2%     +43.5%  4.197e+11        perf-stat.total.instructions
      0.00 ±223%   +1020.0%       0.01 ± 59%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.00 ±223%    +560.0%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.jbd2_log_wait_commit.ext4_sync_file.ext4_buffered_write_iter.do_iter_readv_writev
      0.01 ±  7%     -26.4%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01           -20.0%       0.00        perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.01           -20.0%       0.00        perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.01           -30.0%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.xs_tcp_send_request
      0.01           -11.1%       0.01        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.01 ± 74%     +84.8%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.02 ± 39%     +78.6%       0.03 ± 34%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.01 ±  5%     -30.2%       0.01        perf-sched.sch_delay.avg.ms.jbd2_log_wait_commit.ext4_nfs_commit_metadata.nfsd_create_setattr.nfsd4_create_file
      0.01           -22.2%       0.01        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.01           -12.5%       0.01        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.01 ±  4%     -20.3%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.01 ± 10%     -44.6%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_tcp_sendto
      0.01 ± 14%     -22.4%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±  5%     -50.0%       0.01        perf-sched.sch_delay.avg.ms.svc_recv.nfsd.kthread.ret_from_fork
      0.01 ±117%    +245.2%       0.02 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
      0.00 ±223%    +710.3%       0.04 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.__rpc_execute.rpc_execute.rpc_run_task.nfs4_call_sync_sequence
      0.00 ±223%   +1520.0%       0.01 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.00 ±223%    +600.0%       0.01 ± 26%  perf-sched.sch_delay.max.ms.__cond_resched.jbd2_log_wait_commit.ext4_sync_file.ext4_buffered_write_iter.do_iter_readv_writev
      0.00 ±126%    +359.1%       0.02 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.sock_sendmsg.svc_tcp_sendmsg
      0.00 ±169%    +769.2%       0.02 ± 80%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.svc_tcp_sendto.svc_send.svc_handle_xprt
      0.01 ± 85%    +186.7%       0.03 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.xs_stream_data_receive_workfn.process_one_work.worker_thread.kthread
      0.06 ± 34%     -33.1%       0.04 ± 32%  perf-sched.sch_delay.max.ms.jbd2_log_wait_commit.ext4_nfs_commit_metadata.nfsd_create_setattr.nfsd_create_locked
      3.59 ± 11%     -52.9%       1.69 ± 75%  perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.09 ± 34%   +3544.0%       3.30 ± 42%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      0.01 ± 25%     +50.0%       0.01 ± 14%  perf-sched.sch_delay.max.ms.start_this_handle.jbd2_journal_start_reserved.__ext4_journal_start_reserved.ext4_convert_unwritten_io_end_vec
      0.02 ± 51%     +89.1%       0.03 ± 21%  perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      0.01 ±  5%     -16.3%       0.01        perf-sched.total_sch_delay.average.ms
      2.35 ±  4%     -40.7%       1.39        perf-sched.total_wait_and_delay.average.ms
    473705 ±  6%     +83.6%     869820        perf-sched.total_wait_and_delay.count.ms
      2.34 ±  4%     -40.8%       1.39        perf-sched.total_wait_time.average.ms
     14.98 ±  6%      -6.8%      13.95        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.14 ±  3%     -48.0%       0.07 ±  2%  perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.11 ±  5%     -53.7%       0.05 ±  3%  perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.16 ±  4%     -55.2%       0.07 ± 40%  perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.xs_tcp_send_request
     21.65 ± 14%     +50.9%      32.67        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.74 ±  2%     -36.1%       1.11        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.22 ±  3%     -20.6%       0.18 ±  2%  perf-sched.wait_and_delay.avg.ms.jbd2_log_wait_commit.ext4_nfs_commit_metadata.nfsd_create_setattr.nfsd4_create_file
      1.00           -58.9%       0.41        perf-sched.wait_and_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      3.31 ±  2%     -33.1%       2.22        perf-sched.wait_and_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      1.99 ±  2%     -53.0%       0.94        perf-sched.wait_and_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
     91.01 ± 16%     -50.9%      44.65        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    246.90 ±  5%     -39.0%     150.63 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.42 ±  3%     -60.8%       0.16 ±  2%  perf-sched.wait_and_delay.avg.ms.svc_recv.nfsd.kthread.ret_from_fork
      0.83 ±107%    +340.0%       3.67 ± 46%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.srcu_gp_end.process_srcu.process_one_work
     24.83 ± 19%     +59.1%      39.50 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     62182 ±  7%    +156.7%     159647        perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      3956 ±  7%    +206.9%      12142 ±  2%  perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      8707 ±  6%    +320.1%      36582 ±  2%  perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_sock_set_cork.xs_tcp_send_request
     26809 ±  6%      -9.6%      24244        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     26615 ±  7%     -12.6%      23273        perf-sched.wait_and_delay.count.jbd2_log_wait_commit.ext4_nfs_commit_metadata.nfsd_create_setattr.nfsd4_create_file
     26752 ±  6%     -11.5%      23677        perf-sched.wait_and_delay.count.jbd2_log_wait_commit.ext4_sync_file.ext4_buffered_write_iter.do_iter_readv_writev
     30657 ±  7%    +600.8%     214838        perf-sched.wait_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
     13405 ±  6%      -9.6%      12116        perf-sched.wait_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
     13399 ±  6%      -9.5%      12122        perf-sched.wait_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
    207.17 ±  5%     +74.8%     362.17        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1532 ±  6%     +88.8%       2892 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     34990 ±  7%    +154.4%      89028 ±  2%  perf-sched.wait_and_delay.count.svc_recv.nfsd.kthread.ret_from_fork
    192563 ±  6%     +15.3%     222007        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     27.54 ±107%   +2216.5%     638.01 ±179%  perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.xs_tcp_send_request
     60.18 ±105%     -91.6%       5.05        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3455 ± 22%     -48.1%       1792 ± 25%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    203.43 ± 94%     -95.2%       9.74 ±  7%  perf-sched.wait_and_delay.max.ms.svc_recv.nfsd.kthread.ret_from_fork
     14.95 ±  6%      -6.8%      13.93        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +46408.3%       0.93 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.30 ±  2%     -16.0%       0.25        perf-sched.wait_time.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.01 ±223%   +1045.5%       0.15 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.jbd2_log_wait_commit.ext4_sync_file.ext4_buffered_write_iter.do_iter_readv_writev
      0.01 ± 23%     +52.4%       0.02 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.xs_stream_data_receive_workfn.process_one_work.worker_thread.kthread
      0.14 ±  3%     -49.1%       0.07 ±  2%  perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.11 ±  6%     -55.1%       0.05 ±  4%  perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.15 ±  4%     -56.1%       0.07 ± 43%  perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.xs_tcp_send_request
     21.65 ± 14%     +50.9%      32.67        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.73 ±  2%     -36.2%       1.11        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.20 ±  3%     +17.3%       0.24 ±  3%  perf-sched.wait_time.avg.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
      0.22 ±  3%     -20.5%       0.17 ±  2%  perf-sched.wait_time.avg.ms.jbd2_log_wait_commit.ext4_nfs_commit_metadata.nfsd_create_setattr.nfsd4_create_file
      0.19 ±  5%     -19.3%       0.16 ± 13%  perf-sched.wait_time.avg.ms.jbd2_log_wait_commit.ext4_nfs_commit_metadata.nfsd_create_setattr.nfsd_create_locked
      0.99 ±  2%     -59.2%       0.40        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      3.30 ±  2%     -33.1%       2.21        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      1.98 ±  2%     -53.2%       0.93        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
     91.01 ± 16%     -50.9%      44.65        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    246.89 ±  5%     -39.0%     150.61 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.41 ±  3%     -61.1%       0.16 ±  2%  perf-sched.wait_time.avg.ms.svc_recv.nfsd.kthread.ret_from_fork
      3.64 ± 10%     -65.9%       1.24 ±103%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.nfs_get_lock_context.nfs_page_create_from_folio.nfs_writepage_setup
      0.02 ±126%   +1465.3%       0.26 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
      0.30 ± 95%    +190.8%       0.88 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      0.31 ±223%    +557.0%       2.06 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__rpc_execute.rpc_execute.rpc_run_task.nfs4_call_sync_sequence
      0.00 ±223%  +54158.3%       1.09 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.01 ±223%   +1262.3%       0.17 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.jbd2_log_wait_commit.ext4_sync_file.ext4_buffered_write_iter.do_iter_readv_writev
      0.11 ±203%    +600.3%       0.78 ± 41%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.nfsd_setuser.nfsd_setuser_and_check_port
      0.02 ± 73%   +2366.0%       0.44 ±161%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet6_recvmsg.sock_recvmsg
      0.11 ±213%    +698.2%       0.88 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.sock_sendmsg.svc_tcp_sendmsg
      0.01 ± 33%    +451.2%       0.08 ± 74%  perf-sched.wait_time.max.ms.__cond_resched.xs_stream_data_receive_workfn.process_one_work.worker_thread.kthread
     27.53 ±107%   +2217.8%     638.00 ±179%  perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.xs_tcp_send_request
      0.46 ± 10%    +218.9%       1.48 ± 71%  perf-sched.wait_time.max.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
      2.69           +11.4%       2.99 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     60.15 ±105%     -91.7%       5.02        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3455 ± 22%     -48.1%       1792 ± 25%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    203.35 ± 94%     -95.2%       9.67 ±  7%  perf-sched.wait_time.max.ms.svc_recv.nfsd.kthread.ret_from_fork



***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/9B/nfsv4/btrfs/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-ivb-2ep2/400M/fsmark

commit: 
  66f9dac907 ("Revert "nfs: don't reuse partially completed requests in nfs_lock_and_join_requests"")
  b6dea6c7fe ("nfs: pass flags to second superblock")

66f9dac9077c9c06 b6dea6c7fe2d8187050f882fe6f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.188e+09           +11.3%  1.322e+09        cpuidle..time
   3929892           +91.6%    7529218        cpuidle..usage
     69.88            +7.4%      75.03        iostat.cpu.idle
     22.22           -34.0%      14.67        iostat.cpu.iowait
      5.52 ±  3%     +43.8%       7.94        iostat.cpu.system
    786761 ±  9%     +24.2%     977255 ±  8%  numa-numastat.node0.local_node
    804849 ±  9%     +23.7%     995380 ±  7%  numa-numastat.node0.numa_hit
    916826 ±  8%     +55.5%    1425647 ±  5%  numa-numastat.node1.local_node
    948417 ±  8%     +53.7%    1457243 ±  4%  numa-numastat.node1.numa_hit
     23.86            -8.3       15.58        mpstat.cpu.all.iowait%
      0.30            +0.0        0.33        mpstat.cpu.all.irq%
      0.58            +0.3        0.93        mpstat.cpu.all.soft%
      4.95 ±  3%      +2.2        7.10        mpstat.cpu.all.sys%
     11.40 ±  2%     +23.4%      14.06 ±  2%  mpstat.max_utilization_pct
 1.358e+08 ±  2%     +73.7%  2.359e+08        fsmark.app_overhead
      4107           -15.9%       3456        fsmark.files_per_sec
      6386 ±  9%      -9.9%       5754        fsmark.time.maximum_resident_set_size
     49.17          +128.5%     112.33        fsmark.time.percent_of_cpu_this_job_got
     11.25          +185.3%      32.10        fsmark.time.system_time
    575615          +300.3%    2304344        fsmark.time.voluntary_context_switches
     13811 ±  2%     -17.8%      11354        meminfo.Dirty
   1073015           -12.6%     938340        meminfo.Inactive
   1073015           -12.6%     938340        meminfo.Inactive(file)
    219309           -30.5%     152451        meminfo.KReclaimable
    219309           -30.5%     152451        meminfo.SReclaimable
    387968           -19.8%     311283        meminfo.Slab
     69.89            +7.4%      75.05        vmstat.cpu.id
     22.21           -33.6%      14.75        vmstat.cpu.wa
     12.73 ±  4%     -39.9%       7.65 ±  6%  vmstat.procs.b
      4.99 ± 10%     +21.9%       6.08 ±  5%  vmstat.procs.r
    216786           +92.3%     416945        vmstat.system.cs
     53985           +16.2%      62753        vmstat.system.in
      5358 ± 13%     -19.4%       4316 ±  7%  numa-meminfo.node0.Dirty
    463057 ±  9%     -25.2%     346146 ±  9%  numa-meminfo.node0.Inactive
    463057 ±  9%     -25.2%     346146 ±  9%  numa-meminfo.node0.Inactive(file)
      8474 ±  8%     -16.8%       7049 ±  6%  numa-meminfo.node1.Dirty
     90297 ± 23%     -37.0%      56862 ±  7%  numa-meminfo.node1.KReclaimable
     90297 ± 23%     -37.0%      56862 ±  7%  numa-meminfo.node1.SReclaimable
    169041 ± 12%     -21.1%     133345 ±  2%  numa-meminfo.node1.Slab
      1339 ± 12%     -19.4%       1079 ±  7%  numa-vmstat.node0.nr_dirty
    115964 ±  9%     -25.6%      86318 ±  9%  numa-vmstat.node0.nr_inactive_file
    115964 ±  9%     -25.6%      86318 ±  9%  numa-vmstat.node0.nr_zone_inactive_file
      1192 ± 12%     -28.5%     852.16 ± 10%  numa-vmstat.node0.nr_zone_write_pending
    804755 ±  9%     +23.5%     994145 ±  7%  numa-vmstat.node0.numa_hit
    786667 ±  9%     +24.1%     976013 ±  8%  numa-vmstat.node0.numa_local
    338555 ±  7%     +15.7%     391647 ±  5%  numa-vmstat.node1.nr_dirtied
      2120 ±  8%     -16.7%       1766 ±  6%  numa-vmstat.node1.nr_dirty
     22647 ± 23%     -37.3%      14193 ±  8%  numa-vmstat.node1.nr_slab_reclaimable
    338299 ±  8%     +15.3%     390105 ±  5%  numa-vmstat.node1.nr_written
      2027 ± 10%     -19.4%       1634 ±  8%  numa-vmstat.node1.nr_zone_write_pending
    947862 ±  8%     +53.5%    1454904 ±  4%  numa-vmstat.node1.numa_hit
    916271 ±  8%     +55.3%    1423309 ±  5%  numa-vmstat.node1.numa_local
    600332            +9.7%     658719        proc-vmstat.nr_dirtied
      3457           -17.7%       2844 ±  2%  proc-vmstat.nr_dirty
   1175196            -2.8%    1141722        proc-vmstat.nr_file_pages
    268553           -12.5%     234871        proc-vmstat.nr_inactive_file
     54906           -30.5%      38145        proc-vmstat.nr_slab_reclaimable
     42192            -5.9%      39710        proc-vmstat.nr_slab_unreclaimable
    599793            +9.4%     656108        proc-vmstat.nr_written
    268553           -12.5%     234871        proc-vmstat.nr_zone_inactive_file
      3187 ±  3%     -23.3%       2444 ±  5%  proc-vmstat.nr_zone_write_pending
   1754966           +39.9%    2454658        proc-vmstat.numa_hit
   1709407           +41.7%    2421514        proc-vmstat.numa_local
   2209705           +31.8%    2912839        proc-vmstat.pgalloc_normal
   1655605 ±  3%     +39.7%    2312933        proc-vmstat.pgfree
   3264798           +14.5%    3739381        proc-vmstat.pgpgout
      0.02 ± 97%    +118.2%       0.04 ± 31%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.40 ±192%     -98.4%       0.04 ±144%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ± 20%     -64.1%       0.04 ± 91%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±223%    +588.9%       0.05 ± 36%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.03 ± 88%    +232.1%       0.10 ± 36%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     96.58 ± 63%    +711.2%     783.54 ± 44%  perf-sched.total_wait_and_delay.max.ms
     62.71 ± 53%   +1124.4%     767.88 ± 44%  perf-sched.total_wait_time.max.ms
      0.95 ± 60%    +370.2%       4.47 ± 35%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      6.05 ± 77%     -96.3%       0.22 ±223%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.87 ± 40%     -82.8%       0.15 ±141%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.67 ± 43%     -90.2%       0.16 ±102%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.38 ± 13%    +174.6%       9.29 ± 32%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      8.07 ±109%   +1338.7%     116.15 ± 23%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.33 ± 52%     -92.3%       0.33 ±223%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.17 ±104%    +957.1%      12.33 ± 57%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     94.18 ± 68%    +533.2%     596.36 ± 43%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     15.07 ±103%     -97.1%       0.43 ±223%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      6.60 ± 99%     -93.2%       0.45 ±141%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.18 ±  8%   +5513.8%     234.70 ± 49%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     61.50 ± 50%    +957.2%     650.14 ± 46%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.48 ± 60%    +777.3%       4.17 ± 35%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.61 ± 44%     -82.4%       0.28 ± 17%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.02 ± 18%    +206.6%       9.26 ± 32%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.94 ±112%   +1360.8%     116.00 ± 23%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     47.09 ± 68%   +1166.4%     596.35 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ±105%   +3091.2%       0.90 ±126%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      4.16 ±  8%   +5536.1%     234.65 ± 49%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     61.02 ± 51%    +937.2%     632.92 ± 45%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.32           +19.1%       1.57        perf-stat.i.MPKI
 1.869e+09           +22.9%  2.298e+09        perf-stat.i.branch-instructions
      5.44            -0.7        4.74        perf-stat.i.branch-miss-rate%
 1.006e+08            +7.9%  1.086e+08        perf-stat.i.branch-misses
  11843942 ±  2%     +46.2%   17314122        perf-stat.i.cache-misses
 1.886e+08           +46.1%  2.755e+08        perf-stat.i.cache-references
    239152           +87.2%     447643        perf-stat.i.context-switches
      1.58           +10.8%       1.75        perf-stat.i.cpi
 1.418e+10           +35.9%  1.927e+10        perf-stat.i.cpu-cycles
      1842 ±  2%     +73.5%       3195        perf-stat.i.cpu-migrations
      1202 ±  2%      -7.5%       1112        perf-stat.i.cycles-between-cache-misses
 9.107e+09           +21.9%   1.11e+10        perf-stat.i.instructions
      0.65            -9.8%       0.58        perf-stat.i.ipc
      5.03           +86.7%       9.40        perf-stat.i.metric.K/sec
      5735 ±  4%     -10.8%       5115 ±  3%  perf-stat.i.minor-faults
      5735 ±  4%     -10.8%       5116 ±  3%  perf-stat.i.page-faults
      1.30           +19.9%       1.56        perf-stat.overall.MPKI
      5.38            -0.7        4.73        perf-stat.overall.branch-miss-rate%
      1.56           +11.5%       1.74        perf-stat.overall.cpi
      1197            -7.1%       1113        perf-stat.overall.cycles-between-cache-misses
      0.64           -10.3%       0.58        perf-stat.overall.ipc
 1.799e+09           +23.6%  2.223e+09        perf-stat.ps.branch-instructions
  96805423            +8.5%  1.051e+08        perf-stat.ps.branch-misses
  11396718 ±  2%     +47.0%   16750043        perf-stat.ps.cache-misses
 1.815e+08           +46.9%  2.665e+08        perf-stat.ps.cache-references
    230141           +88.2%     433076        perf-stat.ps.context-switches
 1.364e+10           +36.6%  1.864e+10        perf-stat.ps.cpu-cycles
      1772 ±  2%     +74.4%       3091        perf-stat.ps.cpu-migrations
 8.763e+09           +22.6%  1.074e+10        perf-stat.ps.instructions
      5514 ±  4%     -10.3%       4945 ±  3%  perf-stat.ps.minor-faults
      5514 ±  4%     -10.3%       4945 ±  3%  perf-stat.ps.page-faults
  2.33e+11           +41.9%  3.305e+11        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


