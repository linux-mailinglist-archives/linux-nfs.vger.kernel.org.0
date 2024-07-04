Return-Path: <linux-nfs+bounces-4623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087F927289
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0458328D7E2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEE1AAE38;
	Thu,  4 Jul 2024 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbZZwI/J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7211ACE8D
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083534; cv=fail; b=NbKSJIpmyNdNhSZVfxqEiLkESSQJrH0idWoW7UcZyfUbW0T7dZFNMQnB4CqBWIf0hexGVQVGby1Q0qdQod+zZfyGWB75WOCnxP5CGsDMG/5n5FOVV4SnZZhUTbM50GD29WJtzjXr0Prl1in18dmJFuhpY6gn1gE50dwUfYMHMDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083534; c=relaxed/simple;
	bh=FVF1hJij4ZTygAM+vWabwO5JqDz9bsgr73IGHCMcAZE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EF4foq+XK78SZ9WL1MUc+IVi77tnsDDFenWgfAXblu8rf6G5dusyFRdX7iYusRsj3xjVQkQulQF3GUgu8jVZ8hgUh/Pwk3tS7WxAqlHFTZZN6WMafsbNF4ngM68rgc8skptPEwdpaRBhYvDJNN/I4IJjgmeWEzZzdwDpyCnwZpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbZZwI/J; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083533; x=1751619533;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=FVF1hJij4ZTygAM+vWabwO5JqDz9bsgr73IGHCMcAZE=;
  b=IbZZwI/JaTf0src1+K0tWGKCJLws3RQh8hAWFMF+bwDS7vHYsDvxxPYQ
   /1M84Ty8AMl0drydxTsua74rglUavQJ/t+1OHBJ0Lxr+RdcHn1xpE7wAu
   um6qTzYu2SvzsVI/VecQEKPDaOL17T1HhkkSPlrTDMzmpsQv5oA1YIRT9
   JFZ0XiHaXDqcm6FLeMoC+zS0S1HaKeO2CW95q4cqG4569y3YUZfJf6CDO
   1ms/fpRwN97ExShfJWfrEM4V1PdodkwrFc8I/Q9VANkaCEjiF65dU7WKr
   MKwubXH7qCJcwDh5FfZo5sTtUdPHv09qLmXPnpfmjvXTjchUXMmgkFDoS
   A==;
X-CSE-ConnectionGUID: bOmQSNWUQHa2AoC+6ACZlQ==
X-CSE-MsgGUID: 5MrPj1IJScy8yJpexRGq3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21158948"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21158948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:58:53 -0700
X-CSE-ConnectionGUID: WY8Tf/LDR/2f8t9crBT3gQ==
X-CSE-MsgGUID: gVS4nxSuQ/utMvBKcdJXoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51393705"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 01:58:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 01:58:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 01:58:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 01:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYNR8GlKmW5iaOTgD5jjGiTnq9bOq32sUEcgawcFoDeb9MT16VOHKe/NjQnSbyRGmtyYDaKzqUAQIhNNHZmTGV1BOPLjwt3SYF/dZS5wWja6NCyhzKRvW0NzBgr729Z5LCWX34+UG/0v7ANBeHX362ic7tB09wVBaznaTgZdVDBtHd0uoUEnWmHiwDZGZMiWUKXMazJiktUWTubH0WIgebhjbsBWLnTOQc485cyJLzjFSb37G6BZ4ka2mKuHxw04SrLy9ijzt6fZUUmdazWMlhSumihIND9eewCu5P7hHrMWlubVmiwU9rrs87Ly345i57DlzlidOzI0xjOPzeWxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqMIcQzodF62EMNmegyT8lYgxZEQsDSZuGjjrTECDUk=;
 b=aFtc7icpFvp5LjlZQlbiqdraihSR+sKHAaZpVwS5naE+TL2z1M3Mdk4UmmjnQIrUBsa4rC3fJk975bmytBfYBm/wd/mLsA4Ks1f7kB8Dl5/9qBVor5OhSxKO6h3D4WaRsFjuR3HiG4mdB7Jo9KHj1d22CppwP8XAELyVhkZpUTkm1t/41bkxjyNCHYABTEJWklqr9DuZFIr4EszR1DUTWxzBpyETJlEYm5jJEEurH2I+hV1UYxpnsw0b0Qv8GT9EXTsro+agoKArERorzztbw9ykDxrMqvEVflyLsOlXSNHCv6tmENbDcpXJfSWpjlVZdkGHW2ajyNkKL5gZy29Mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 08:58:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 08:58:48 +0000
Date: Thu, 4 Jul 2024 16:58:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, "Olga
 Kornievskaia" <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 6/6] nfsd: add nfsd_file_acquire_local().
Message-ID: <202407041659.c2371438-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701025802.22985-7-neilb@suse.de>
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc29c5a-087d-4372-1fd8-08dc9c078487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PHhb7lmlrokDwCKcwQLZXwUZqYXebNmiT+nq125RogxDygedJa282gc15P0e?=
 =?us-ascii?Q?51LklTquIgsGCbM3pEgm5CjJxBNnJwnTG8Gx7cpe+13d2pBy/YgpDqSX8g6V?=
 =?us-ascii?Q?Jg5tKXlOeIAuL0IahkImMF0yu9wlQWW36lio80cjS1+C4rCkUdFt15U2bZr4?=
 =?us-ascii?Q?Idlfr4zKKxlSqFgIU+FEnqPdhCGR51WwlLV1WiubYIESGPNYZI73SlPtArR7?=
 =?us-ascii?Q?zlwp3GI2z9QX8BF9sJgSGpObdBqQAYVVqi5VI6xgcqMcF4BoZpEDEJGZtpcD?=
 =?us-ascii?Q?+XpT+ceALJD7Ay7DCbZ6wQaTjeLXIwvteax1JmVreQqTzM+mqz35DBmGn5m+?=
 =?us-ascii?Q?RVl6vWW7A88fzoKqZwZc0vhGRxxpKkieQvZiu+Zj5TKC/CfcCOsA9TuwM68d?=
 =?us-ascii?Q?4FiiPk/MaYnu9UHV6VDHE7bj9aiDsGx9YAqn19MJiVwjiUnWnN12ID3sjkSC?=
 =?us-ascii?Q?PdvkKCSf/5b4LsP4WLgnp/b5Aa/D3i3wYQkYT/jxv4OwP4+503mm4Fhkrmy7?=
 =?us-ascii?Q?9nFCdg92ZclNi0yAgM2nQQ/5UVgW5amFT1IcvafbeFAS1762jK3OjVvGSVnX?=
 =?us-ascii?Q?HWLazSFJgpZoSNITOE8mORr7Nz8smcjgRLmtTs6Lvl9ZoVZaWdVE860zZAQ9?=
 =?us-ascii?Q?sk0BLKYoOKUTrmJR95O6BKV3l0qKtD6BZG5agHnp0zvfiZNBLN7jHmNB37gi?=
 =?us-ascii?Q?3L7nbqbDeBIglHZZi6c60FhMF0fBLBlaGntE3D8eLhZ3ji5/KCPIPjOaTjDn?=
 =?us-ascii?Q?8TScpKQvUiSILpklF+AMsZBUA9Q2/fwUJ25eXmTDlgcgfMuiR3vTW9g305eN?=
 =?us-ascii?Q?HJevy/50d5mOfPJRa0i4gRH7Ld1eaepTK2Tmpm+7Jx8vU0/Nd0sw9oi05Jw4?=
 =?us-ascii?Q?OdTw5+0SFCM/piKZII7ElRw0DxpO0XA2zji3Zt7/Nl682JZt41bNhyxupR0C?=
 =?us-ascii?Q?yoBvP7IxNaWqu5wTeFJQcwoev0732WQIABXRxqs4KUBziophXdZ9OeZsRNjp?=
 =?us-ascii?Q?h2LY5sBpf1LhFuc2QcSynkNZDtk4ev+gEGQbhIxyi6Mbj2ptaAopqZnJBXxW?=
 =?us-ascii?Q?GwZ9DzZapYy/NiL/2nzA52cKxAZjdAJzwyIbfouR9xenzKgspIeS20V6Ab+N?=
 =?us-ascii?Q?dmOrE4oBFHe2dLOUa/T64BJPk/7FN9lO6Vs0r39JPe0s8Viu5NX0Ubz5CBfu?=
 =?us-ascii?Q?BND+aOIsnCN3IbCX29gDMpqrQsjw3zeA50+79X5rcVfHKGsqBYvKCGJIVo4X?=
 =?us-ascii?Q?qn3L2GS4MGHoUhO+70ncGm4LXcq936w1TcIST3BW+8ggwXML0gVXDfzvjRGI?=
 =?us-ascii?Q?QqQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhQgx7/iZmez6xvQTOWvof7QAVdq8zjzlgMCJtKpKsL3UxAOfPBUwPppqBzp?=
 =?us-ascii?Q?fNOCxGe82+f098SuswsJ9Yu1iTdOuMYHCQFB3aB3vZZszbFnAxQQY8YGvBP+?=
 =?us-ascii?Q?+mz04ZnxE+IGwgMcNo8txsv4s/P62Qsp5Eb02P4l6wP58CS2Fzzqaei8Dl3I?=
 =?us-ascii?Q?CwOJJzdsFvXGQd5JdDuRcY6mhte9atTbsofEkquo1b3nVGSHpbLL1PPD3sAh?=
 =?us-ascii?Q?eulX9Fv8QhsfaWPf6BeKIA53QbrfxDRUj9ntGPfzsBmroahTDvwNIJdBML4w?=
 =?us-ascii?Q?LQhZ9ZtgsrmbBoh7+/r/8jAMrDiVuG8KmmAjH/8lOMfETKJCz6VbLMOe9gHn?=
 =?us-ascii?Q?Z1j0EEbAW+ygoKCpsxGBWOu3x72WfngRQoGiL3CYBryZ7dGrNAfde82y1Wj0?=
 =?us-ascii?Q?lCZc/zBejmQLdEuOMsCgnx+St2/putNA2Vq4ZUtbpf+I1mN3ZQZ02bVLAKCU?=
 =?us-ascii?Q?IPFTxFmoC8mJFWx+YvmIrUAIgsohEOzJ+xJ0/bse4z7JDtH0RME1LgCLCMtb?=
 =?us-ascii?Q?DVh4W+ZTqw/8/bfapRhiENGakOJthTFMJs/Qrea96K6j5a/Z7ic7Si7+xW8z?=
 =?us-ascii?Q?aCEkhyFQJiVT3pHWWMUUhv0qCg7i/NEUqWbGa2z8C8MIqlLxN9otnC4oIcl5?=
 =?us-ascii?Q?ktXbepM+gI3nyYK1rnYjpCS3NInJd8uL5ifrBVqhLZkvYf/jfOvgMUFtfA4U?=
 =?us-ascii?Q?20wDF9oy1q3TV3Msqz8CA1Hx9SJvcV8FzNKpvg8J1yg/9NKhY/T8WvvNyKdW?=
 =?us-ascii?Q?dvdLvWu0c0qpuSbRBSDUbKasdvUDZExkPdB07wu2VZgPfGEEvuxThkJoHMqk?=
 =?us-ascii?Q?kwdqBJObtdoxMfGpR+yB2oV7+kFyx37jx1vUGqA8Gbi/wklcglaNZ7rXz+/3?=
 =?us-ascii?Q?FAizR36crs0dUIfSJ0W6SDnu03o6IIjig9+faSuFQgpYm4XnRXapz2pXS5hn?=
 =?us-ascii?Q?JprDWRvryvAiV1UUDOXHWu1bo/6GDlXkG8mVRQ8qEi3WRVvskxnZWMnGjwkx?=
 =?us-ascii?Q?WOmdJmvvyXrcfpZoeRixczaDWQ8ABpaxUDZicR68gome1sVV1MqYMANE8U8z?=
 =?us-ascii?Q?TPj7QCC/SDjDcE8UprcP0RXttsJ1sCZgAs0VNutKFYOe+TS+mur4CUxEnVBH?=
 =?us-ascii?Q?eqAo8T5McMDgAXuqELF8j5XsQHTTx2JfV7wCx1mr3kLW23V+5tW4sIWEbDGg?=
 =?us-ascii?Q?Gj0A6ndopbq1BxGKWk3nluciZrpW9Eg4dAts4cabi4Ei7ziMRv7pcgeV34GI?=
 =?us-ascii?Q?Magn8SllRTRtzxB6ShrUur9h9pbTvKu2FuOxsWabZ9bad3lTYy+MmSJAi15h?=
 =?us-ascii?Q?qwRDZVfHftR2CI6Q8X6VzIY+aASO1XppQ2yytjQtbEcxKlCC/NcbU8BP1tzS?=
 =?us-ascii?Q?I3XZ3UaBmS54Ks98UaC6V8T8Dhu6Us0suD+gIcFlGh8D16QTm+DcL/xaq/7E?=
 =?us-ascii?Q?N0NOskn2Z4VpE+6j98z9Mz+roH9KWJPTnf6eXgFESimqme1AO7yVRkjacYeq?=
 =?us-ascii?Q?tWpjkaS1xG7mCCB0cqBqAnJsZTq84Yfjl4XxsJE7zpFiMuZK+sIIjd0KBaDq?=
 =?us-ascii?Q?O0hFzfgR4oszoKaNsNcCzGY9mIME4mYdYpdYmxnHqHalmH9xecE43uHopnIa?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc29c5a-087d-4372-1fd8-08dc9c078487
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:58:48.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVFnVjAR3JQ2b3IFsXL4XluHFYYiU9cufD5Hyt98yCoXY6OQ+jmHPn0wama+4gKVeJcyCgvlpHQwdO7hqLf/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 23fc4a797ca65dbe32393093e546c23c0cf278c1 ("[PATCH 6/6] nfsd: add nfsd_file_acquire_local().")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-introduce-__fh_verify-which-takes-explicit-nfsd_net-arg/20240701-122856
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 22a40d14b572deb80c0648557f4bd502d7e83826
patch link: https://lore.kernel.org/all/20240701025802.22985-7-neilb@suse.de/
patch subject: [PATCH 6/6] nfsd: add nfsd_file_acquire_local().

in testcase: filebench
version: filebench-x86_64-22620e6-1_20240224
with following parameters:

	disk: 1HDD
	fs: btrfs
	fs2: nfsv4
	test: singlestreamwritedirect.f
	cpufreq_governor: performance



compiler: gcc-13
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407041659.c2371438-oliver.sang@intel.com


[   35.440736][ T2585] BUG: kernel NULL pointer dereference, address: 0000000000000010
[   35.449115][ T2585] #PF: supervisor read access in kernel mode
[   35.455679][ T2585] #PF: error_code(0x0000) - not-present page
[   35.461966][ T2585] PGD 0
[   35.465163][ T2585] Oops: Oops: 0000 [#1] SMP NOPTI
[   35.470524][ T2585] CPU: 40 PID: 2585 Comm: nfsd Tainted: G S                 6.10.0-rc6-00006-g23fc4a797ca6 #1
[   35.481056][ T2585] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[ 35.493034][ T2585] RIP: 0010:nfsexp_flags (fs/nfsd/auth.c:14) nfsd
[ 35.499118][ T2585] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 8b 56 78 48 8d 46 7c 48 8d 14 d0 48 39 d0 73 1a <8b> 4f 10 eb 09 48 83 c0 08 48 39 d0 73 0c 39 08 75 f3 8b 40 04 c3
All code
========
   0:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	66 0f 1f 00          	nopw   (%rax)
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	8b 56 78             	mov    0x78(%rsi),%edx
  1d:	48 8d 46 7c          	lea    0x7c(%rsi),%rax
  21:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
  25:	48 39 d0             	cmp    %rdx,%rax
  28:	73 1a                	jae    0x44
  2a:*	8b 4f 10             	mov    0x10(%rdi),%ecx		<-- trapping instruction
  2d:	eb 09                	jmp    0x38
  2f:	48 83 c0 08          	add    $0x8,%rax
  33:	48 39 d0             	cmp    %rdx,%rax
  36:	73 0c                	jae    0x44
  38:	39 08                	cmp    %ecx,(%rax)
  3a:	75 f3                	jne    0x2f
  3c:	8b 40 04             	mov    0x4(%rax),%eax
  3f:	c3                   	retq   

Code starting with the faulting instruction
===========================================
   0:	8b 4f 10             	mov    0x10(%rdi),%ecx
   3:	eb 09                	jmp    0xe
   5:	48 83 c0 08          	add    $0x8,%rax
   9:	48 39 d0             	cmp    %rdx,%rax
   c:	73 0c                	jae    0x1a
   e:	39 08                	cmp    %ecx,(%rax)
  10:	75 f3                	jne    0x5
  12:	8b 40 04             	mov    0x4(%rax),%eax
  15:	c3                   	retq   
[   35.519118][ T2585] RSP: 0018:ffa000000b48fb18 EFLAGS: 00010283
[   35.525649][ T2585] RAX: ff11001086c8d47c RBX: 0000000000000000 RCX: 0000000000000000
[   35.534071][ T2585] RDX: ff11001086c8d484 RSI: ff11001086c8d400 RDI: 0000000000000000
[   35.542422][ T2585] RBP: ff11001086c8d400 R08: 0000000000000000 R09: ff11000128adb500
[   35.550760][ T2585] R10: ffa000000b48fc00 R11: ff11000154660160 R12: ff11000154660000
[   35.559184][ T2585] R13: ff11001086c8d400 R14: ff11001086cb7800 R15: 0000000000008000
[   35.567487][ T2585] FS:  0000000000000000(0000) GS:ff11002000200000(0000) knlGS:0000000000000000
[   35.576800][ T2585] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.583895][ T2585] CR2: 0000000000000010 CR3: 000000207de1c002 CR4: 0000000000771ef0
[   35.592300][ T2585] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   35.600610][ T2585] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   35.609052][ T2585] PKRU: 55555554
[   35.612962][ T2585] Call Trace:
[   35.616640][ T2585]  <TASK>
[ 35.620001][ T2585] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 35.624224][ T2585] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 35.629458][ T2585] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 35.634666][ T2585] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 35.640019][ T2585] ? nfsexp_flags (fs/nfsd/auth.c:14) nfsd
[ 35.645521][ T2585] nfsd_setuser_and_check_port (fs/nfsd/nfsfh.c:109) nfsd
[ 35.652274][ T2585] __fh_verify (fs/nfsd/nfsfh.c:372) nfsd
[ 35.657656][ T2585] nfsd_file_do_acquire (fs/nfsd/filecache.c:997) nfsd
[ 35.663821][ T2585] nfsd_file_acquire_opened (fs/nfsd/filecache.c:1235 (discriminator 1)) nfsd
[ 35.670245][ T2585] nfs4_get_vfs_file (fs/nfsd/nfs4state.c:5557) nfsd
[ 35.676256][ T2585] nfsd4_process_open2 (fs/nfsd/nfs4state.c:6098) nfsd
[ 35.682411][ T2585] nfsd4_open (fs/nfsd/nfs4proc.c:624) nfsd
[ 35.687758][ T2585] nfsd4_proc_compound (fs/nfsd/nfs4proc.c:2776) nfsd
[ 35.693946][ T2585] nfsd_dispatch (fs/nfsd/nfssvc.c:1004) nfsd
[ 35.699460][ T2585] svc_process_common (net/sunrpc/svc.c:1391) 
[ 35.704884][ T2585] ? __pfx_nfsd_dispatch (fs/nfsd/nfssvc.c:961) nfsd
[ 35.711172][ T2585] svc_process (net/sunrpc/svc.c:1537 (discriminator 1)) 
[ 35.715880][ T2585] svc_handle_xprt (net/sunrpc/svc_xprt.c:831) 
[ 35.721128][ T2585] svc_recv (include/linux/sunrpc/bc_xprt.h:40 net/sunrpc/svc_xprt.c:892) 
[ 35.725731][ T2585] ? __pfx_nfsd (fs/nfsd/nfssvc.c:910) nfsd
[ 35.731143][ T2585] nfsd (fs/nfsd/nfssvc.c:939) nfsd
[ 35.735821][ T2585] kthread (kernel/kthread.c:389) 
[ 35.740131][ T2585] ? __pfx_kthread (kernel/kthread.c:342) 
[ 35.745176][ T2585] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 35.750004][ T2585] ? __pfx_kthread (kernel/kthread.c:342) 
[ 35.754945][ T2585] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   35.760136][ T2585]  </TASK>
[   35.763428][ T2585] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss device_dax(+) nd_pmem nd_btt dax_pmem btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp sd_mod coretemp t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ahci ast libahci acpi_power_meter intel_cstate ipmi_ssif mei_me drm_shmem_helper intel_th_gth intel_th_pci ioatdma i2c_i801 intel_uncore dax_hmem libata drm_kms_helper ipmi_si acpi_ipmi mei i2c_smbus intel_pch_thermal intel_th wmi dca nfit ipmi_devintf libnvdimm ipmi_msghandler acpi_pad joydev binfmt_misc drm fuse loop dm_mod ip_tables
[   35.830582][ T2585] CR2: 0000000000000010
[   35.835241][ T2585] ---[ end trace 0000000000000000 ]---
[   35.849208][ T2585] pstore: backend (erst) writing error (-28)
[ 35.855581][ T2585] RIP: 0010:nfsexp_flags (fs/nfsd/auth.c:14) nfsd
[ 35.861704][ T2585] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 8b 56 78 48 8d 46 7c 48 8d 14 d0 48 39 d0 73 1a <8b> 4f 10 eb 09 48 83 c0 08 48 39 d0 73 0c 39 08 75 f3 8b 40 04 c3
All code
========
   0:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	66 0f 1f 00          	nopw   (%rax)
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	8b 56 78             	mov    0x78(%rsi),%edx
  1d:	48 8d 46 7c          	lea    0x7c(%rsi),%rax
  21:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
  25:	48 39 d0             	cmp    %rdx,%rax
  28:	73 1a                	jae    0x44
  2a:*	8b 4f 10             	mov    0x10(%rdi),%ecx		<-- trapping instruction
  2d:	eb 09                	jmp    0x38
  2f:	48 83 c0 08          	add    $0x8,%rax
  33:	48 39 d0             	cmp    %rdx,%rax
  36:	73 0c                	jae    0x44
  38:	39 08                	cmp    %ecx,(%rax)
  3a:	75 f3                	jne    0x2f
  3c:	8b 40 04             	mov    0x4(%rax),%eax
  3f:	c3                   	retq   

Code starting with the faulting instruction
===========================================
   0:	8b 4f 10             	mov    0x10(%rdi),%ecx
   3:	eb 09                	jmp    0xe
   5:	48 83 c0 08          	add    $0x8,%rax
   9:	48 39 d0             	cmp    %rdx,%rax
   c:	73 0c                	jae    0x1a
   e:	39 08                	cmp    %ecx,(%rax)
  10:	75 f3                	jne    0x5
  12:	8b 40 04             	mov    0x4(%rax),%eax
  15:	c3                   	retq   


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240704/202407041659.c2371438-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


