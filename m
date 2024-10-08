Return-Path: <linux-nfs+bounces-6919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96099422E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D811C20A8E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77DB175D32;
	Tue,  8 Oct 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gflpx0KJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847C1EF090
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374616; cv=fail; b=QSD7wXGWqDf+FY8pgnjVnpw6HyndRYt4j6FOTijrpZj7gsDv39wBRxJuRThtXh41IeKAenr87/OZ16j8dbkKeLnwO6/U0l2JqeeqXXzXPaciTDpso4B8rNuHnFRetouDg5QONxa18mv/Zf964N/WFXbI9m3OasoSHlrWWnKEyA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374616; c=relaxed/simple;
	bh=IHhZJjsmW50fPe0VW7dhLzZok4S3qCyeH9PBHkY5vXI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=esavWc1jb7TuwTYj3zil0WEZIrnJXtxVjQje+oNymKHhcvpA0omdLBMWQ1m1kE7RPr7Y8+TqZUKgiI+B3w4d9S6DpCure0PFo5/BIPTqH/iBBrjSkNJri05eYHrsKDSfgEIyLLS2d16hq2eph71OEVPiFH4qisrwcWvN4CoxfWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gflpx0KJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728374614; x=1759910614;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IHhZJjsmW50fPe0VW7dhLzZok4S3qCyeH9PBHkY5vXI=;
  b=gflpx0KJMWpB2Pzckunw3oYmFqNqN5i3FCdmYwRJg7Mv+hvxCulTlzhj
   7Vrz4zHghB09w7m8PppVKIY3GnV+vib+Pt007xZHE2MXrT/Ug1V0NLSiz
   SDQcWSKeCzuHTgQ6cccf0mrzCB01RbAjSts/ZPI/MlkPP49/XsVzFNrEW
   Tq92fsFmHPQpwXS2eDF8hzHcO08hNBjIhRnN3/ZMzwU2EHGv6qjPMTh9o
   kSzDvg2BXfRS97tRWbjYpa6yYCkvGDTCs5IroZVSWnJJv+yEZVcqRFpt3
   VeAfDa8SN2D4lcuAh9sxURWThaDv4mTkwDoTUVacebGaYy8C1/p/77/Uv
   Q==;
X-CSE-ConnectionGUID: JgKQ0FqzT0yeOmhzU9i/Yw==
X-CSE-MsgGUID: y40rH8HSRKu4qXd+3Aop5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38942409"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="38942409"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 01:03:26 -0700
X-CSE-ConnectionGUID: sG7X5capQZ+/Y0Vy3klTVA==
X-CSE-MsgGUID: 72CWuAC8RrmkS3ifRlSBqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="80170267"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 01:01:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 01:01:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 01:01:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 01:01:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 01:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPBWimY873T3WxhSJiWhzM6SZOtB7To68T27imvry9t6bpsMj96eFZeuz/rEz8Ocwqa4wZvOW2YoCbitnl8qoAZERsfxRkUephw3SWAE3dmTuyW0wdNSfCQulNfc/sZLiGA8IghzIxnbc8Cnbu7eXn1QBwAOsvE2KpNxCMbvfIx5eLRT7gKJ9iIiEgPKVzyTNk1c2TA4fUQ5n1qDJ/I18I2mnqIFS5KU716z+vI8+55o4wI8/Our/ysfbje2JtEUJKXue3QEoX7w03kW7ziQ1rTYXhqZeZfiORo+19I/wvLsMFTtIpBvtBs/SszVYMpQKUsX3yGw7nz6Ocy6ou5PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjvtEPQotadLfAop1EjpnQEEbBpyTlm3XNcLRGKOGE0=;
 b=aTTQgi3JuubCrwn1Di3aOfSFj/zrYHTXDkr73KJ5x5zyRVrYXjyJKpwfxi6bgpI87Rc/IgbWbxkJLh+QkVGLx3aZ2R12KyT+RotMwIv3Wp1QhrBJEJThqsk5Tnc2StSmtFlbs/A+ueyd2O6W1xtoBdeOvPb22mIBKMgmeMjxLrIghhhSBpjjHEuS7JCtEUKxlU4R5gmCVnffCW0wd1Uj3g+KQ1M8vUxUp/BUyqkW7MB+GC/PY5AvMXq0IFhAmA09z1Wl6/Q2Tb29zZbpCgbP8yy8Ndc4i3yXVJi6CkBcHYgjIML/zvhqWCYPRCMCpIr/7MDi4FyQwGcqPy91NQYHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:01:50 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:01:50 +0000
Date: Tue, 8 Oct 2024 16:01:37 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Chuck Lever <chuck.lever@oracle.com>,
	<linux-nfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [nfsd]  8cb33389f6:  fsmark.app_overhead
 81.6% regression
Message-ID: <ZwTm4e5JxOOJc7JC@xsang-OptiPlex-9020>
References: <202409161645.d44bced5-oliver.sang@intel.com>
 <70ce1781c9fb39d974d38b7426194ead97926ed3.camel@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70ce1781c9fb39d974d38b7426194ead97926ed3.camel@kernel.org>
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 395c2f2f-72d1-49e2-2efc-08dce76f772f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?KkytKH0Rv19bswReeyy+aRYXFEXZw0fjo0JxojtEOOgpBY5inznAPTUn/x?=
 =?iso-8859-1?Q?qG/vEIP6dnTzF8pYZ6kyHoKVpoq94mxPH7zbMGQpEhZmGDM8Sd/mY10BPo?=
 =?iso-8859-1?Q?MNVNNmuH6G1ClbTdK+QLj9dJvFzxamOZD/acj5Q8M54fDS4ke300/dge4+?=
 =?iso-8859-1?Q?7UckffYHwIFEzDLH57KRaCs+ulvbJIh4I9f0DZOn2MQQOjRFI76rqOBlvi?=
 =?iso-8859-1?Q?cerv/hMl/xji6Li/2j3/nFqseMQ6V4YFprvEWMRTwvwzX9bK5DOyWoTblx?=
 =?iso-8859-1?Q?iOF1XRdrNCfFgBq9X6+9A2b217NeMicR42w+/J7JtWP24F+DCkZ1w2otDU?=
 =?iso-8859-1?Q?zM5ROMlXxEc+mKddRJg5qN3Dd/UDL13qnMNu+vYldHxSfEKh41o2OHwtEZ?=
 =?iso-8859-1?Q?OXgQ8cfAMOIjM78e7vwZCVrbBJb0jfYFMiwWtUfpwfCzYjvz3SpwI7O7dX?=
 =?iso-8859-1?Q?1AKVriEz/7fzqe4537veoPHOg4gW6pMjKPlEqXKEUUBL/I6x27+RNPP98u?=
 =?iso-8859-1?Q?PWwLjRSXjIypYtuE6JQrR1rHllNYC+5wIpX/+l6zhCMpD1XAAgEY3HIni3?=
 =?iso-8859-1?Q?9+JMmfpQO4GRxZeJtJ5oAyybLDYMBzt5JEl7g9Da2DBlDBnE8ReDKhglfx?=
 =?iso-8859-1?Q?B5Eor+AzLSVFNKN2oZtHjcSPIN2OfkInWX39CbrJb2jSx8rShTFnzaNEEC?=
 =?iso-8859-1?Q?KDt1+2uobtifTPzCxCiLG5JfkIgT4SsDZUFC11s12t8o7xx74osDPvHhoR?=
 =?iso-8859-1?Q?ePhIlfEBM8uuUZxtEPsU6L+mMYP9Dt9zN9Sn4xGspEG8PkMM4jYWF6R9xG?=
 =?iso-8859-1?Q?c7sz1yunhdUppiBdmNc4TdbmGbBOHoV5AMAzdqyvas2IuOaV+6tKRsdgns?=
 =?iso-8859-1?Q?JfwL+clD7NIN0+LoqGIOeQTW/QwiZflBZ//Q4SMD69InX2uaoGx2iBT4qN?=
 =?iso-8859-1?Q?0OlfV6UlmTfCA7Iwg2voqLwhE9DSxT/vhAckA4doAqr4tgd337hdXnoI6y?=
 =?iso-8859-1?Q?gtNBS99OP5RJnkrhmgm+J//rBaS/gejeYg24Ap87yAhcbSZDijhm90LS6/?=
 =?iso-8859-1?Q?GyFdtujoZYAeIMwiTtzClV+A6Ikb3RfcWBQLOhM1H15GIcFRyEIsAzHVqy?=
 =?iso-8859-1?Q?2gt4Dv70wYXt7A5X/OTGwXZTmyF6oaNTLCQ1S8P4NAxCoijYyzJ3gUVPbz?=
 =?iso-8859-1?Q?/iBjwVuKSD4Cfx3mEhd/lgadLnVo07zsGQhoV0TiiSkwVAMl+2eMh2VKSC?=
 =?iso-8859-1?Q?5/zSpAKVuPAj0f+fy+plZVjxC+J8carXYXSTtVeK8hwRc/gU7ja1lLv05s?=
 =?iso-8859-1?Q?psHsInmzE8n815uqgocG3xDW3d916+JMIv0eJ7JDmvAcSD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BymWKu6dVMr1bQ9swkso+4Gg0o1ZM8ZMoALm44hiDnP3XhI6AvvlWprQA6?=
 =?iso-8859-1?Q?IG5quR2cfM1oitlW5qNUBE/8QuT0iGyciylfJy2f6WgfDi3DU7K3K3cbmD?=
 =?iso-8859-1?Q?OtMxMCMTm8ZAOMDacwyxf26ZJ7qpP+wdw77CY/kmxnaTfBgok/gCFz470f?=
 =?iso-8859-1?Q?sA62l2jDauHWNT/GKKJMo8ugGLxG3uUpwK0GRgG1UhYfG/XeoKVtp8/1zw?=
 =?iso-8859-1?Q?Kls0Z4GrIINcOb3xnS/Q9c6SnIugqC/GRewQLujroL6XHtoat2uom9K9G4?=
 =?iso-8859-1?Q?wEzXo8U84Jhfw3hsEUgOG0ACRu/SFTjUQ1vil+ZdtPg0AQRo4lbbTvBUdx?=
 =?iso-8859-1?Q?6yBH+NrBiNdxInIFkKPUIm7qZNNN4O1I7w/t9mtLnI5cR2Kj3huBf0wyr2?=
 =?iso-8859-1?Q?gQGztBD38giyEUevjUKdtaB2i4ii+9/1LOJR23oI3e1vjc5WyoSlDFOJS+?=
 =?iso-8859-1?Q?83z2eVcBcTI0WcLnVAvzmdf5VYu+EK5IGIjy3T5k5FjL9+8kXgJaMaLWZT?=
 =?iso-8859-1?Q?g2qY+phdTM3pAVXZX6Cl7Ua+uZbpeHunDlsbAXDN7oQmPLUDWm2P6+XGoJ?=
 =?iso-8859-1?Q?DxpnQw4tj7XMseD9pAh3tW2I38FqMG22khQsitW2qZEhvPr0keJ8Efl4hU?=
 =?iso-8859-1?Q?cYdQkWRAIpq4ss/w354ReQK3wRoRratZWoIp1qyv0QeOkBqCX0mSCFINWB?=
 =?iso-8859-1?Q?r08ZO79foYkSARxOgNeaycNfVOB/v1zJSpRTlsJP95sFrUiO9fi/WtwAym?=
 =?iso-8859-1?Q?5BjoofJKYP8iHfJNSU1lPElLMqOEQqkZRcPfWINgdGmU3eUysAp3nrT7cz?=
 =?iso-8859-1?Q?7TIESVwVmmDAeSaES+TZAY+wUjrtibO4rQCQ4lKPNS/yxES8LExvfVeYbU?=
 =?iso-8859-1?Q?ET4JCu2d3QnLnqKAQkBtCDZLm7+HmknfhA8WJjaBLNVSn/T2KF5hEKvd/p?=
 =?iso-8859-1?Q?rPLCoZMxDB/Fc7COSyHImdY7/QhC+soU+BCOpI7QiY/v68zPFiYPwTGrgH?=
 =?iso-8859-1?Q?iQVJ9wZKbHzjPpGshwBMQJUluck60Tevxcs+w1+AJoW2GEb+swIRRcKkjg?=
 =?iso-8859-1?Q?qlw51tLPBCmBvZsHAJ12KGSTqZdFOEMgYyPLaQIdatvhPeV/YEU9DqRo6q?=
 =?iso-8859-1?Q?f9PhlO5Liro/X7/QKE4gIBPNFVnP4vLHqosylnUCv4HaBUXy9LZS52qeAM?=
 =?iso-8859-1?Q?MiWm/m6+TytH4RJHmAWguH03Hi32tOa12A3wdXkmyp8l5Le+/grX5rySVR?=
 =?iso-8859-1?Q?aIJ1dUEbRzcB+Xc2yd+qjFLCQYdhRugKdFWX/dhk8XqWrlNRnQYJufwIrh?=
 =?iso-8859-1?Q?lzF9zsXlHsV4W8YfUi6QaaNXLsorUKze0ACjAyfz+jDcpyr/Zuj3nFaJTT?=
 =?iso-8859-1?Q?HkkVdvyjowH2S6e64zMXxECBREG8gaSiMDGsIU4iis6LIcqECBwqqSkO+g?=
 =?iso-8859-1?Q?fQyQpxzUA+lXUTYDOtEgjp0wubyRfs/V9c0nGdq2D4JAHy4VyhuWzlNe4Z?=
 =?iso-8859-1?Q?U+gK2DVd+L9Su/13cKZznpnqEJucVAnPIFxRGMq3vAVIzG+moMRtl/2ovE?=
 =?iso-8859-1?Q?RHIR9jh+IOATCsgckl0s7dj+4fVTZNeXgm8kbT9PNO6T00qwg5VXJ6VbSE?=
 =?iso-8859-1?Q?g/2EFGPhZI4iQKTGvqzhicUtnNY0TyX+OMKYBh5JOaCt11RkM+BtFgig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395c2f2f-72d1-49e2-2efc-08dce76f772f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:01:50.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yINH0dx8I1JgFjmbngw/xWK8JI/I5j7GuLmwtLWfGXMq7yQH3bSSjQb6t9gSC6/WX5aIHEVVWysI+k1N3r+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com

hi, Jeff Layton,

On Tue, Oct 01, 2024 at 08:44:43AM -0400, Jeff Layton wrote:
> On Mon, 2024-09-16 at 16:41 +0800, kernel test robot wrote:
> > 
> > Hello,
> > 
> > kernel test robot noticed a 81.6% regression of fsmark.app_overhead on:
> > 
> > 
> > commit: 8cb33389f66441dc4e54b28fe0d9bd4bcd9b796d ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > testcase: fsmark
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > parameters:
> > 
> > 	iterations: 1x
> > 	nr_threads: 1t
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	fs2: nfsv4
> > 	filesize: 4K
> > 	test_size: 40M
> > 	sync_method: fsyncBeforeClose
> > 	nr_files_per_directory: 1fpd
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.sang@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240916/202409161645.d44bced5-oliver.sang@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
> >   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
> > 
> > commit: 
> >   e29c78a693 ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
> >   8cb33389f6 ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> > 
> > e29c78a6936e7422 8cb33389f66441dc4e54b28fe0d 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >      24388 ± 20%     -32.8%      16400 ± 18%  numa-vmstat.node0.nr_slab_reclaimable
> >      61.50 ±  4%     -10.6%      55.00 ±  6%  perf-c2c.HITM.local
> >       0.20 ±  3%     +23.0%       0.24 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
> >       2977            -6.1%       2796        vmstat.system.cs
> >    2132466 ±  2%     +81.6%    3871852        fsmark.app_overhead
> 
> I have been unable to reproduce this result with fs_mark. I've run a
> number of repeated tests, and I can create files just as fast with or
> without this patch (roughly ~46 files/s on my test machine).
> 
> I'm particularly suspicious of the fsmark.app_overhead value above. The
> fsmark output says:
> 
> #       App overhead is time in microseconds spent in the test not doing file writing related system calls.
> 
> That seems outside the purview of anything we're altering here, so I
> have to wonder if something else is going on. Oliver, can you rerun
> this test and see if this regression is reproducible?

we rebuild kernel and rerun tests for both parent and this commit, the data
is stable and the regression is still reproducible.

but one thing I want to mention is there is no diff for "fsmark.files_per_sec"

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark

e29c78a6936e7422 8cb33389f66441dc4e54b28fe0d
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   2080540 ±  2%     +86.6%    3881862        fsmark.app_overhead
     18.56            +0.0%      18.56        fsmark.files_per_sec


we happen to report another report which has similar behavior that big changes
of fsmark.app_overhead, but little difference for fsmark.files_per_sec
https://lore.kernel.org/all/202410072214.11d18a3c-oliver.sang@intel.com/

Christian Loehle <christian.loehle@arm.com> shared some information in
https://lore.kernel.org/all/01c3073b-84d0-4986-b6d5-a8877ae8a046@arm.com/

"App overhead is time in microseconds spent in the test not doing file writing related system calls."
So the loop is:
	/*
	 * MAIN FILE WRITE LOOP:
	 * This loop measures the specific steps in creating files:
	 *      Step 1: Make up a file name
	 *      Step 2: Creat(file_name);
	 *      Step 3: write file data
	 *      Step 4: fsync() file data (optional)
	 *      Step 5: close() file descriptor
	 */

And it gets the timestamps before and after each syscall.
It then subtracts all those times (spent in syscalls) from the total time.


not sure if this information is helpful to you?

> 
> Thanks,
> 
> >      53442           -17.3%      44172        fsmark.time.voluntary_context_switches
> >       2907            -5.7%       2742        perf-stat.i.context-switches
> >       2902            -5.7%       2737        perf-stat.ps.context-switches
> >    1724787            -1.0%    1706808        proc-vmstat.numa_hit
> >    1592345            -1.1%    1574310        proc-vmstat.numa_local
> >      24.87 ± 33%     -38.9%      15.20 ± 12%  sched_debug.cpu.nr_uninterruptible.max
> >       4.36 ±  9%     -17.1%       3.61 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
> >      97541 ± 20%     -32.7%      65610 ± 18%  numa-meminfo.node0.KReclaimable
> >      97541 ± 20%     -32.7%      65610 ± 18%  numa-meminfo.node0.SReclaimable
> >     256796 ±  9%     -18.7%     208805 ± 13%  numa-meminfo.node0.Slab
> >    2307911 ± 52%     +68.5%    3888971 ±  5%  numa-meminfo.node1.MemUsed
> >     193326 ± 12%     +24.7%     241049 ± 12%  numa-meminfo.node1.Slab
> >       0.90 ± 27%      -0.5        0.36 ±103%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
> >       0.36 ± 70%      +0.2        0.58 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.btrfs_sync_file.btrfs_do_write_iter.do_iter_readv_writev.vfs_iter_write
> >       0.52 ± 47%      +0.3        0.78 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
> >       1.62 ± 12%      +0.3        1.93 ±  9%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
> >       1.22 ± 21%      -0.3        0.89 ± 10%  perf-profile.children.cycles-pp.readn
> >       0.46 ± 32%      -0.2        0.24 ± 34%  perf-profile.children.cycles-pp.__close
> >       0.45 ± 32%      -0.2        0.22 ± 15%  perf-profile.children.cycles-pp.__x64_sys_close
> >       0.40 ± 29%      -0.2        0.18 ± 38%  perf-profile.children.cycles-pp.__fput
> >       0.31 ± 23%      -0.2        0.16 ± 33%  perf-profile.children.cycles-pp.irq_work_tick
> >       0.17 ± 51%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.nfs_file_release
> >       0.16 ± 43%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.__put_nfs_open_context
> >       0.26 ± 18%      -0.1        0.15 ± 34%  perf-profile.children.cycles-pp.perf_event_task_tick
> >       0.15 ± 41%      -0.1        0.03 ±108%  perf-profile.children.cycles-pp.get_free_pages_noprof
> >       0.18 ± 55%      -0.1        0.06 ± 32%  perf-profile.children.cycles-pp.native_apic_mem_eoi
> >       0.18 ± 32%      -0.1        0.07 ± 81%  perf-profile.children.cycles-pp.flush_end_io
> >       0.17 ± 41%      -0.1        0.07 ± 93%  perf-profile.children.cycles-pp.mas_store_gfp
> >       0.52 ±  5%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.btrfs_commit_transaction
> >       0.02 ±141%      +0.1        0.08 ± 42%  perf-profile.children.cycles-pp.uptime_proc_show
> >       0.02 ±141%      +0.1        0.08 ± 44%  perf-profile.children.cycles-pp.get_zeroed_page_noprof
> >       0.02 ±141%      +0.1        0.09 ± 35%  perf-profile.children.cycles-pp.__rmqueue_pcplist
> >       0.14 ± 12%      +0.1        0.28 ± 29%  perf-profile.children.cycles-pp.hrtimer_next_event_without
> >       0.47 ± 27%      +0.2        0.67 ± 19%  perf-profile.children.cycles-pp.__mmap
> >       0.70 ± 21%      +0.2        0.91 ±  7%  perf-profile.children.cycles-pp.vfs_write
> >       0.74 ± 20%      +0.2        0.96 ±  9%  perf-profile.children.cycles-pp.ksys_write
> >       0.73 ± 21%      +0.3        1.00 ±  7%  perf-profile.children.cycles-pp.copy_process
> >       1.05 ± 13%      +0.3        1.38 ± 10%  perf-profile.children.cycles-pp.kernel_clone
> >       0.28 ± 22%      -0.1        0.13 ± 35%  perf-profile.self.cycles-pp.irq_work_tick
> >       0.18 ± 55%      -0.1        0.06 ± 32%  perf-profile.self.cycles-pp.native_apic_mem_eoi
> > 
> > 
> > 
> > 
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

