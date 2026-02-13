Return-Path: <linux-nfs+bounces-18910-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LoxEr6GjmlfCwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18910-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 03:04:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8D13259F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 03:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054193066E64
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 02:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B7EADC;
	Fri, 13 Feb 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1+AFSAe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D71DDC1B
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770948264; cv=fail; b=qa0bcSd1b7hh1YkzbGDZZaNCALpYXKrsLBeKjjGOf7Ac1U/syG2AGgGPkNGLsmwzZvTcgau/4yd++iYpYOshdVXdcvHIjB4KTMqHMgwYQ/9fdodSVvTo9pMgGBz2LHLeH5yir3FYDSJAqR1g4uyJgPBSKJt1zzKrPUp1mamXbb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770948264; c=relaxed/simple;
	bh=HHZ2P/URLzwLJOIHcSiipTaouOWwRkScLxWgiocFB4M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Af80myU2cAGAOQuLrL35amg5/cPTZ9N9ZQ2ToO+V938+Wzs3fFoGjxzkGPd5uFcMuTO+tUPrpbBq019Qbls4F7Driz4EhkDlDfSE/fYgaLh2YNGKqg05JPrtDKjsYlyZDsSTczHAbdZW5Re/76CmyFHoCHx2Rw21P7jGcagmNNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1+AFSAe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770948262; x=1802484262;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HHZ2P/URLzwLJOIHcSiipTaouOWwRkScLxWgiocFB4M=;
  b=R1+AFSAegbgtoLPi+v4HgG2mwIglYWKwZarGvD4TLZkeghIX+/by5iLd
   Eyp70HjgHnAcU5kWMRRXMsrFiGJ9kxWG9juqsqNBV2JCZNVBmHDvC5vBi
   NP+VOv94JxY22gUFtuEqZTAUMsLpmXlB/8lDWkvh69QhEAYtA8Ni/PUYt
   JW0W90as//1MS3LR3pJZF8A2I3kARNhqcvXDnktMgBzNImSx+iMeNmgwW
   bsww+pcr3R6BlFRaaIvSX3Maqx+ly/jUGioKh0YHrpE6CQHEfzkWumYQ/
   rzDCupRVnIeWOwjy+C2ehF3hvsqE1q4HI3mxmlVXQ4qdbYBOl7elZM0gi
   g==;
X-CSE-ConnectionGUID: YK5nDhp8RbKpPkiOCGpSTA==
X-CSE-MsgGUID: dsEODlXZSnaMaE1Ky+eKSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="59704373"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="59704373"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 18:04:21 -0800
X-CSE-ConnectionGUID: FHlyyugaSLC7B7EEh+PbCA==
X-CSE-MsgGUID: paohkmHSSpmX5WRNYF5Wtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="212623610"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 18:04:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 18:04:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 18:04:20 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 18:04:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuzJFgR54JEnn9FELliL/saSjPQEtTL8zOLBVaOT6ZiVdpcKoZlUR/6Hz9i7NAFIt88YjfOElDe0zwOAa2q3jNNoWzAYGrm31/b36+2jwvI1kKXPAerJanTVl4+9hya+Os7H7VXKW7ZsUOfV59VtSkgoUm2zTrHn2m+wHEVyDjNZxcgTEbzgVhkLH8ky7CxqfRFRSAgiz6URtAEgGlf0B5slzCFLGEIDmnGaC2ichJvJa2KPE0SsTF5wCqr2aC8IAtHLGW3MNoOUWZrnWsKeHwRcIavBSe0/MbXaK8mHdS82t+wYLgIfjE0rui8gqS5RDvAF8ZGdJUHfVawRJngGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O8OfnSfv6FNPGcE/aexZ6JwOPXXYb+jRvzcMLUnThc=;
 b=fBRzR2mOP9CNJGFapaoDi0Nff9jEZM5dIqjX3N+iilT2FiXN2DGizneKNSVgNkMB1/4KN/zmFBJapgPREK9HBaz0fU7SaKv8WCMeYfKKqSqicrz1t4frkGAalBBNLlmQiIwzfO8NmPPTTWJKqYuXKy9a10MaREDVd2lqubEByzRJTTBHoazYM4IZTDIp9UND40cInUuL9/vFH0dqyxaGkWM2Nryy7uLDbcW8lYDfJxJJGWrmugIrXwSP2as2WLHPeZOA40M7HhGvrmSZ8DCR4OgC0QQLcAeR7kjyIRd4uV51E45C9aZ6mN9BDaHWuZnGUM2Td34c4cxIOvoNqS+2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 02:04:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 02:04:18 +0000
Date: Fri, 13 Feb 2026 10:04:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chuck Lever
	<chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [cel:nfsd-testing] [nfsd]  e491b8e430: postmark.transactions 15.2%
 regression
Message-ID: <202602130940.4cf74a62-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: MEWPR01CA0143.ausprd01.prod.outlook.com
 (2603:10c6:220:1d2::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: b7664815-0762-47d9-bab0-08de6aa431fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AHs5gqCvgLDhZRKM55Hj1k6twCXHTWpB737OC3/eU4lkYqYURD24KzpOCQ?=
 =?iso-8859-1?Q?dXlREKr9S8hECZwle7BXT13ga9UN9O88Bh2iVc/bjEWF7QiKEabsv+RIre?=
 =?iso-8859-1?Q?wmgYjQTawF1Zj0CxWX37d4cu/QRPcsdHn5sMMIZF6i+FWo5GjfuTye5xzQ?=
 =?iso-8859-1?Q?DHwE5pf8q1zoqTJ2TmjKgEwXV70nztH7huGecl+RuIAeHLbsJccDH6m2Sz?=
 =?iso-8859-1?Q?KlLsZGMu++/EH7+lF0IqpZ7gAQij5PKd3UjpZS6yfmwjJ/NQCY69CR75GD?=
 =?iso-8859-1?Q?iVWxV9iUHiFuROiEVkkCHE1XtUAHpEyNgNmF3ajbnTSgDqyaMNI0XCPEKb?=
 =?iso-8859-1?Q?bq3k+Ipmq9jqK63GmVp4x3Z+kFusqOnNKQ7N8FTE3vlWwYvPrF7IdfhQjm?=
 =?iso-8859-1?Q?J7xhFttZ7P2vy/gtrSuWQfOVYwpzq6y4sE16OGj2kcYHCRol12ykjh11Tb?=
 =?iso-8859-1?Q?hZ5hVwTXHqKJ0h/c7Vw2HboD2C8U9UFcTe7lbC1SGMgChN3wRTYXeJHenb?=
 =?iso-8859-1?Q?6hESw9e7uDOwhpYhPNp8KMCVx/EQcV+kojrWsQKw+RjUsE7JB6pYxysjXl?=
 =?iso-8859-1?Q?txzUFct+Fb4LA0pJ78wEYXuEshTejTEn+pWZTgtR8Z+UpptbKMztVyI6w7?=
 =?iso-8859-1?Q?0qufiGq/Dd8aglzRdK9k0uVW+5UKhR1jCGtuuWVXKGXmF0Ybuw5fXtBczl?=
 =?iso-8859-1?Q?Uej5r1Y55HX0GVw+hgtctT4DQvDkgvHYBXt2+zsIE/wIgdE+WcBoCHTbQO?=
 =?iso-8859-1?Q?yjA+p501umQuzoY2pXR9fpGd/CV+XAzMLGxoxd14ikKA+YyBbal/hN4mpx?=
 =?iso-8859-1?Q?ZzAnzU+lIFD3RfZOp9LqpTSbSfJ36hMVO36+KdhjURpGqbU5t8n7/5NVSO?=
 =?iso-8859-1?Q?nGIPJWUQqvQuxbHtRupLztuxcyjTQ2OOBJoqMMuvcBXziMngvY5gP659Wb?=
 =?iso-8859-1?Q?tfmxaTIwIUc0iygBPNypF9/wkVDhg8neKTnxD8JSnKCnsrkTTdgE52Wm/L?=
 =?iso-8859-1?Q?tPUir07lKAbKMI0QJLYevJ9NMi3+SkcYQZgjewuzStfzqBq6oL3WCZBWW1?=
 =?iso-8859-1?Q?xqr/rTPU1uzxuphMaX2mR31IOO0ZbJzMDmaEp8EF4hr4alb1TUEUk+iFH+?=
 =?iso-8859-1?Q?fX7Ymr194ocKd1M73r7bUTojxaLCiSo8SLt7ZrQ5O5TkWR+Ue++wFj7gzB?=
 =?iso-8859-1?Q?UVOO/akuFK66X65wSg1MESqPVr2QFgNICvov4aFIXeWE4SdVSCAfUJEB+N?=
 =?iso-8859-1?Q?Z0WCLyZcWFiLNAXHnsMP1TTLXq74ME7heTV3JAG76Z90b96QLacJjEnjCc?=
 =?iso-8859-1?Q?WZp6b6e/yq+wcbUHdy8SK9ZCJXXVLWWA3TdgD0+DuhZL4yggt8g3/XdI8N?=
 =?iso-8859-1?Q?JD306CNdpTVXxo5lwK17s7QoVNMtjPTVG7fX+WRyJ31l3+t8lhii/ABfSC?=
 =?iso-8859-1?Q?9FCFFiuvM77TxGRmwlNfaLDDqM/0Ud98nRqDBsWtEYnJeRuXQn78YbBbIi?=
 =?iso-8859-1?Q?dEFVACV8MwPym5PsRzNgcDhqyk1AMftchM4x9vdot+v25CAKrcs4JmWudp?=
 =?iso-8859-1?Q?2z/QJzaWcFLw8Y8ZBZXFdJtxUyLJaospy+LxRUe34wWAwXFZ3Sx1V1hxC3?=
 =?iso-8859-1?Q?+vwkxO9zrW7KLulxgx7BCXKv/RMrWdEdLf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fG3iTUw8nVZBpC15EEyiyG8WwJfhAfL6dImimY8bPNEjl6baQm1jEo/rwb?=
 =?iso-8859-1?Q?xxCLoXQXR7qwVpmn22OsWysxXiSA0OD0ZXLGs9cfHl8xdXxLUyxrnLXh/C?=
 =?iso-8859-1?Q?9QNez5wYw4b5gqqTL1ppvINWBnMvJ+RGaUAfJeyU2o3wskm3RYQH19MbhG?=
 =?iso-8859-1?Q?8oPD3TrP7z9ca1uPycCQ7mreAsbjwY9wOaixe7ExGVjIZEhZgvJdz4dPXK?=
 =?iso-8859-1?Q?SxaDM0GKiSpiib/5cT3EDDNCcq3Ls5XZAHGpw4TuHsfqskf0OfdeTPGfCv?=
 =?iso-8859-1?Q?xvvrX0d1fEv4J/j1mwzSqUuHBNbvzJlIrNhgHx5WRQReqUiclbUQgpCSoM?=
 =?iso-8859-1?Q?wUHMdsaNdV8hHFq6UxlvfEU3v87c++zZv+IBqBF/8jfs6ByfrHiCmAwZgU?=
 =?iso-8859-1?Q?/YEI4xyHrsDAvKs5z4KkLlNV0zWlvGuyx8EvTol16LoMR9/5ecVWQ0m1q3?=
 =?iso-8859-1?Q?kkLZeRszkE1ndIBgaWNZKpm4FO6IxQumtsT/cLb4GY+kXKfoEwL9aFLMNb?=
 =?iso-8859-1?Q?uTxn7b0ah3l7LkQR1T9yfZwXBGQEHeHR6zLpdewKzlcrbPl0WCRvH76AHw?=
 =?iso-8859-1?Q?RaH+UE0fVJ5Kln/Y79tZ3vzWgUXDQ7LQeR+g3YYHQBeRWM3HlMRXCZxDv8?=
 =?iso-8859-1?Q?oR623RCvijazBYcvU+RY+gT74QmbHET/rWR8+wdEnB0dsepVMbluDncNGm?=
 =?iso-8859-1?Q?on4hGSD0qGVyOtLYi2yDWbZzRsk3yHNg1Bs9IVAHztgTiMzKr7x9mWEzX6?=
 =?iso-8859-1?Q?IXLf8FPv7bqmWJbh0m75Ji9gnESKBofI3OEfy9bF5pnaGNF5u30jeEnpD4?=
 =?iso-8859-1?Q?juENvjh6f/bGL26zKumZPlb/7e7xBtDHSfeFpEkgPcewFWwkkCge/TqXqH?=
 =?iso-8859-1?Q?7YrrJY1okkJYhpABRdkPNAp8hRsH/Sa9RQUibzTSnkcBNfPepJymgMz9Dl?=
 =?iso-8859-1?Q?uxoUOYRQICpLYavjdL2pAkUKnc88U3PxFY44fq6AIPC2g78VVHBbNaXs8i?=
 =?iso-8859-1?Q?4q1imDq3+bzo7ft1w+3luduuwqUsz/2hhQcwCB99f73Az7jbX2I1zPsK32?=
 =?iso-8859-1?Q?YmecvcqNd4BGwV3lhEd1gvPFR4I/oa3oSUOxyn6+7qMalkxNJStd5yd5Jf?=
 =?iso-8859-1?Q?2nwYzqkvNZ/zN0bXeW9ABE89LMiAfy4Lc5mjVzplsacejzd2fj07VvUCGX?=
 =?iso-8859-1?Q?RFgMAj/Vs/AYqOqcb7Opj7zJhBnfOpRDGvKxCsnmrHlks6Y3G/jw2IZzlE?=
 =?iso-8859-1?Q?t4dNIs4+JXNJXHJ+oy6wCpaUWmQ0wdP4fPym0bDeRbkZbETQkwwBP3hxzD?=
 =?iso-8859-1?Q?Z08CPKGgnN1CHLvv78NoBwHj5n0spyzn0kg05zdQ06JhStaj3Rsnsz5S6s?=
 =?iso-8859-1?Q?qpLnlUETxzrMqwEGbzwGcjinbDk824pKr6otLfNkZejGFANcp8jT9isLbg?=
 =?iso-8859-1?Q?4SOsgWTnP+0Fhj+TlLkhBr4zEIX3kj6Ly4P+8DQUirhsTCcYUBg3Ug3Dxr?=
 =?iso-8859-1?Q?746L58TUbUd9gq2bYlbO6d5Yhr3IkGQY45ociC6XNbFWcUNW3/bjzuIETm?=
 =?iso-8859-1?Q?dwMPWhD6yJmZeTda/IvCVLzUVVks6ZXmM9UGyLiNJCuNycCnkXZ4TwIY/s?=
 =?iso-8859-1?Q?curOUDrp4E+e2uIcLmv0Lrjxd2MTLYrsWDDpLErCCgCZViX5E/iHqM1Lpq?=
 =?iso-8859-1?Q?OT8Fr4E9Lte/7iFwSpxggBmi5oUFZX06bBayifV27rOkQIO4isAc05pY9J?=
 =?iso-8859-1?Q?yUK++8jsrNWw1QjuNFRqXi78YFJj4izV6or0O9USxrBOU+N/fvNhYHmVTV?=
 =?iso-8859-1?Q?ko45KQ/rPg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7664815-0762-47d9-bab0-08de6aa431fd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 02:04:18.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgTAVKPtciB7IddcdwRGhIBB6nPPWV7VDbdCo+fsRmvfzauG/dPyNKI05YIATnmERdu8fSTV83UXAudLCu4OrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_SEVEN(0.00)[10];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18910-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 6FB8D13259F
X-Rspamd-Action: no action



Hello,

kernel test robot noticed a 15.2% regression of postmark.transactions on:


commit: e491b8e4300585da77a96251f77577ebcaa7c5fc ("nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option")
https://git.kernel.org/cgit/linux/kernel/git/cel/linux nfsd-testing

testcase: postmark
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs1: nfsv4
	number: 1000n
	trans: 10000s
	subdirs: 100d
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602130940.4cf74a62-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260213/202602130940.4cf74a62-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs1/fs/kconfig/number/rootfs/subdirs/tbox_group/testcase/trans:
  gcc-14/performance/1HDD/nfsv4/ext4/x86_64-rhel-9.4/1000n/debian-13-x86_64-20250902.cgz/100d/lkp-cpl-4sp2/postmark/10000s

commit: 
  49b14981e9 ("nfsd: add a runtime switch for disabling delegated timestamps")
  e491b8e430 ("nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option")

49b14981e913ca6a e491b8e4300585da77a96251f77 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.00            -0.0        0.00 ±  2%  mpstat.cpu.all.usr%
    115863            -7.5%     107174 ±  6%  numa-numastat.node0.other_node
 2.657e+08           +17.2%  3.114e+08        turbostat.IRQ
    102394           +15.4%     118164        vmstat.memory.buff
 2.634e+11           +17.2%  3.088e+11        cpuidle..time
 2.652e+08           +17.2%  3.108e+08        cpuidle..usage
      1291           +15.7%       1494        uptime.boot
    284803           +15.8%     329732        uptime.idle
    102296           +15.5%     118107        meminfo.Buffers
    177444            +8.3%     192096        meminfo.Inactive
    177444            +8.3%     192096        meminfo.Inactive(file)
      2980            -1.3%       2940        perf-stat.i.context-switches
    234.45            -1.2%     231.74        perf-stat.i.cpu-migrations
      2977            -1.3%       2938        perf-stat.ps.context-switches
    234.25            -1.1%     231.57        perf-stat.ps.cpu-migrations
 1.508e+12           +16.6%  1.759e+12        perf-stat.total.instructions
     14498 ± 95%   +2523.2%     380328 ±110%  numa-vmstat.node0.nr_file_pages
      2.11 ± 83%  +3.4e+05%       7159 ±120%  numa-vmstat.node0.nr_mapped
      7603 ±  8%     +89.3%      14395 ± 30%  numa-vmstat.node0.nr_slab_reclaimable
    115863            -7.5%     107174 ±  6%  numa-vmstat.node0.numa_other
    881153           -77.8%     195595 ±167%  numa-vmstat.node1.nr_file_pages
    493.21 ± 22%     -28.2%     354.06 ± 20%  numa-vmstat.node1.nr_page_table_pages
     18656 ± 11%     -51.0%       9134 ± 56%  numa-vmstat.node1.nr_slab_reclaimable
    859699           -79.3%     177669 ±189%  numa-vmstat.node1.nr_unevictable
    859699           -79.3%     177669 ±189%  numa-vmstat.node1.nr_zone_unevictable
     28413 ±130%    +136.9%      67303 ± 45%  numa-vmstat.node2.nr_anon_pages
     57993 ± 95%   +2523.3%    1521337 ±110%  numa-meminfo.node0.FilePages
     30413 ±  8%     +89.3%      57581 ± 30%  numa-meminfo.node0.KReclaimable
      8.46 ± 83%  +3.4e+05%      28639 ±120%  numa-meminfo.node0.Mapped
     30413 ±  8%     +89.3%      57581 ± 30%  numa-meminfo.node0.SReclaimable
    142923 ±  4%     +23.1%     175930 ±  9%  numa-meminfo.node0.Slab
   3524608           -77.8%     782383 ±167%  numa-meminfo.node1.FilePages
     74624 ± 11%     -51.0%      36538 ± 56%  numa-meminfo.node1.KReclaimable
      1968 ± 22%     -28.0%       1417 ± 20%  numa-meminfo.node1.PageTables
     74624 ± 11%     -51.0%      36538 ± 56%  numa-meminfo.node1.SReclaimable
   3438799           -79.3%     710678 ±189%  numa-meminfo.node1.Unevictable
    113654 ±130%    +136.9%     269213 ± 45%  numa-meminfo.node2.AnonPages
    623405 ±  5%    +231.4%    2066089 ± 81%  numa-meminfo.node2.MemUsed
     75814            +2.9%      78028        proc-vmstat.nr_dirtied
     44356            +8.3%      48032        proc-vmstat.nr_inactive_file
     40258            +1.1%      40713        proc-vmstat.nr_slab_reclaimable
     75355            +3.0%      77604        proc-vmstat.nr_written
     44356            +8.3%      48032        proc-vmstat.nr_zone_inactive_file
   3089765           +12.8%    3486001        proc-vmstat.numa_hit
   2741896           +14.5%    3138225        proc-vmstat.numa_local
   3492032           +12.2%    3917120        proc-vmstat.pgalloc_normal
   3585459           +16.3%    4168177        proc-vmstat.pgfault
   3358355           +12.4%    3774423        proc-vmstat.pgfree
    778674            +9.6%     853071        proc-vmstat.pgpgout
    150505           +16.4%     175141        proc-vmstat.pgreuse
      4.85           -15.3%       4.11        postmark.creation_mixed_trans
     71148           -14.9%      60564        postmark.data_read
     84089           -14.9%      71580        postmark.data_written
     19.53           -30.9%      13.50        postmark.deletion_alone
      4.98           -15.2%       4.22        postmark.deletion_mixed_trans
      4.87           -15.4%       4.12        postmark.files_appended
      5.10           -14.9%       4.34        postmark.files_created
      5.10           -14.9%       4.34        postmark.files_deleted
      4.94           -15.3%       4.18        postmark.files_read
      1174           +17.3%       1377        postmark.time.elapsed_time
      1174           +17.3%       1377        postmark.time.elapsed_time.max
     43653            -1.7%      42917        postmark.time.voluntary_context_switches
      9.83           -15.2%       8.33        postmark.transactions
      1.76            -0.1        1.68        perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      1.89            -0.1        1.82 ±  2%  perf-profile.calltrace.cycles-pp.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.22 ±  2%      -0.1        1.16        perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu
      1.12            -0.0        1.08        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains.handle_softirqs
      1.89            -0.1        1.80        perf-profile.children.cycles-pp.sched_balance_rq
      1.35 ±  2%      -0.1        1.28        perf-profile.children.cycles-pp.sched_balance_find_src_group
      1.91 ±  2%      -0.1        1.84 ±  2%  perf-profile.children.cycles-pp.sched_balance_domains
      1.25            -0.1        1.19        perf-profile.children.cycles-pp.update_sd_lb_stats
      0.36 ±  3%      -0.1        0.30 ±  8%  perf-profile.children.cycles-pp.ksys_read
      0.95 ±  3%      -0.0        0.90        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.08 ± 10%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.filemap_map_pages
      0.08 ± 11%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.do_read_fault
      0.27 ±  6%      +0.0        0.30 ±  9%  perf-profile.children.cycles-pp.timerqueue_del
      0.42 ±  2%      +0.1        0.50 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.19 ±  5%      -0.0        0.14 ± 15%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.08 ± 17%      -0.0        0.05 ± 55%  perf-profile.self.cycles-pp.invoke_rcu_core
      0.09 ± 14%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.27 ±  7%      +0.0        0.32 ±  6%  perf-profile.self.cycles-pp.acpi_idle_enter
      2.38 ± 67%     -62.1%       0.90 ± 42%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      2.38 ± 67%     -62.1%       0.90 ± 42%  sched_debug.cfs_rq:/.removed.util_avg.avg
    685672           +13.2%     775891        sched_debug.cpu.clock.avg
    685684           +13.2%     775903        sched_debug.cpu.clock.max
    685660           +13.2%     775880        sched_debug.cpu.clock.min
    681754           +13.1%     771301        sched_debug.cpu.clock_task.avg
    682275           +13.1%     771929        sched_debug.cpu.clock_task.max
    668165           +13.4%     757950        sched_debug.cpu.clock_task.min
    142.32 ±  4%     +13.6%     161.75        sched_debug.cpu.curr->pid.avg
     28132           +10.8%      31168        sched_debug.cpu.curr->pid.max
      1934           +11.2%       2151        sched_debug.cpu.curr->pid.stddev
      0.01 ±  4%      +8.8%       0.01 ±  6%  sched_debug.cpu.nr_running.avg
      8672           +13.0%       9796        sched_debug.cpu.nr_switches.avg
      2248           +14.2%       2566        sched_debug.cpu.nr_switches.min
     19783 ± 10%     +20.7%      23875 ± 10%  sched_debug.cpu.nr_switches.stddev
      5.44 ±  6%     +13.9%       6.19 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
    685660           +13.2%     775880        sched_debug.cpu_clk
    684805           +13.2%     775024        sched_debug.ktime
    686649           +13.1%     776915        sched_debug.sched_clk
      0.89           -11.1%       0.79        nfsstat.Client.nfs.v4.access.percent
      4.36 ±  2%      -7.6%       4.03 ±  2%  nfsstat.Client.nfs.v4.close.percent
      1.32           -12.3%       1.16        nfsstat.Client.nfs.v4.create.percent
      0.01           -14.7%       0.01        nfsstat.Client.nfs.v4.create_session.percent
      3655           +11.0%       4058        nfsstat.Client.nfs.v4.delegreturn
     15.03            +8.7%      16.33        nfsstat.Client.nfs.v4.delegreturn.percent
      0.02           -14.5%       0.02        nfsstat.Client.nfs.v4.exchange_id.percent
      0.02           -14.5%       0.02        nfsstat.Client.nfs.v4.fsinfo.percent
     10.49            -5.6%       9.90        nfsstat.Client.nfs.v4.getattr.percent
      0.04           -14.7%       0.03        nfsstat.Client.nfs.v4.lookup.percent
      0.01           -14.7%       0.01        nfsstat.Client.nfs.v4.lookup_root.percent
      0.01           -14.7%       0.01        nfsstat.Client.nfs.v4.null.percent
      1417           +21.0%       1714        nfsstat.Client.nfs.v4.open_noat
      5.88           +14.9%       6.76        nfsstat.Client.nfs.v4.open_noat.percent
      0.02           -14.5%       0.02        nfsstat.Client.nfs.v4.pathconf.percent
      0.01           -14.7%       0.01        nfsstat.Client.nfs.v4.reclaim_comp.percent
      0.01           -14.7%       0.01        nfsstat.Client.nfs.v4.secinfo_no.percent
      0.05           -14.6%       0.05        nfsstat.Client.nfs.v4.server_caps.percent
      0.01           -14.7%       0.01        nfsstat.Client.nfs.v4.setattr.percent
      0.01           -14.7%       0.01        nfsstat.Server.nfs.v4.null.percent
      4809            +7.5%       5172        nfsstat.Server.nfs.v4.operations.access
      0.66 ±  2%     -12.6%       0.57 ±  3%  nfsstat.Server.nfs.v4.operations.close.percent
      0.20           -14.6%       0.17        nfsstat.Server.nfs.v4.operations.create.percent
      0.00           -14.7%       0.00        nfsstat.Server.nfs.v4.operations.create_ses.percent
      3656           +11.0%       4057        nfsstat.Server.nfs.v4.operations.delegreturn
      3.54            +4.3%       3.69        nfsstat.Server.nfs.v4.operations.delegreturn.percent
      0.00           -14.7%       0.00        nfsstat.Server.nfs.v4.operations.exchange_id.percent
     11939            +5.6%      12607        nfsstat.Server.nfs.v4.operations.getattr
      4.77           -10.5%       4.27        nfsstat.Server.nfs.v4.operations.getfh.percent
      0.01           -14.7%       0.01        nfsstat.Server.nfs.v4.operations.lookup.percent
      4708            +7.7%       5070        nfsstat.Server.nfs.v4.operations.open
      0.00           -14.7%       0.00        nfsstat.Server.nfs.v4.operations.putrootfh.percent
      0.00           -14.7%       0.00        nfsstat.Server.nfs.v4.operations.reclaim_comp.percent
      0.00           -14.7%       0.00        nfsstat.Server.nfs.v4.operations.secinfononam.percent
      1.00        +3.4e+05%       3381        nfsstat.Server.nfs.v4.operations.setattr
      0.00        +1.8e+05%       3.09        nfsstat.Server.nfs.v4.operations.setattr.percent
      6.87            -8.8%       6.27        nfsstat.Server.nfs.v4.operations.write.percent




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


