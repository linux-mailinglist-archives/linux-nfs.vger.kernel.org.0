Return-Path: <linux-nfs+bounces-5186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC13940094
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7925283071
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B415ECD0;
	Mon, 29 Jul 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J19mciat";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E6eZiSyF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8178C98
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289658; cv=fail; b=oKfcKhgh8bOHkzrWaAI0rkefuF9SqjtfN4pQ7sVkwq+i2JfKonriIFoUGIWpGuU3V2CWxhtyBPslJrq9nZRNbSwGZl72I3FoKwXKTaZSi1dc6soy1aGY26qGcKjkjbCSaOKNrH/UwmMTsttFb8BeCjSv9s4ISiy2Wo3mwdnwAS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289658; c=relaxed/simple;
	bh=Mx3KLa1zpPXs06NqM57qwo1Umv5MYupXkiSmGZ4Im2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jb74mSjC1e51IjPLt+MDF1dH+k2raPFF62v92mBwR7rJMzhYF9So76UZ1N2nzob3d7wacxtKOsfRJorv/ZMaQTuERKrVzYdsZXdlmZFD4B2sYvjgPGB/08Zgzw9BHOI8sfJKOa9wZ93LkHkWZAgg+elqCKS9WABeIBI3XeJfbqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J19mciat; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E6eZiSyF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TKtWRN008113;
	Mon, 29 Jul 2024 21:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=AGuze2oab/nwbL1
	lxA0vbyo5q6XvDoILKtOj78mXqHk=; b=J19mciatkfR8bU8+J0cApOw9lTi4KJU
	7DCDZV/5wBAxJANmyfZVpCIEupo06Ob9isjByvUSNah0BijDCJKLFTwNej01i8qS
	OsJU0YchGRz+JlX2oD4f8cltNpjOf6yNbDBxpjD/LkueRHQHRrIMZTCleI2Lw85q
	n4KG0AhOi9VgR9nZCNmaRnCfwF1Ql/+iazq0ETti6YbVoXWZ6TpYOeDYw62sErKG
	Mz9GFaAOh4Uccg+iC/XK2DBraQuCOLGGNRU/+/ypSg+qk5KTvIBcdRp7vVIMJnBG
	2ARr0mdAetedGfTogrbVHpBFfjBRIiGKw0eTNpmlbHwhZlFUns8/A3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqackqdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 21:47:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TKvg8f013030;
	Mon, 29 Jul 2024 21:47:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nkh5s8uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 21:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeREssfGU2asDy7aiPgC1CXPaIIZQy2WCnXK0wWta6fPGxz61AINX9XbXmu+NgiAlscajaXvuteHLLdcu4njrYICuCETdlouE8ILfpaqeYoQfPSzpNsI0HBBVqPruDcYwXtOzfz1c1ybajoMHHZaNvpAzocuf2fg8Fc13tIVO5klQ8ogTC/TVgkG5rXg2RsjDdn3QCH0X4B15o6JzU7Fm2mhK9yqI7uyv2fmUxO/pXQqEdS48h0OMGdG0+DVxwZ22NwmH4Id68TmzhaK1IGB31a+dBpMOjU0WnH4BmNEIet32NbrOTi5009MkM36PI7UqQ/4q94nQ0gGdRugJZzCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGuze2oab/nwbL1lxA0vbyo5q6XvDoILKtOj78mXqHk=;
 b=fVYZnLu6tpY8ZZi8leERuZpntghlqmFd58WAEN3XvNv3S5rGs79tEyFSGO3Lqh0E4J5Yt/0ViwKNZdUw1GiprHFtammhzwG+Hm8Z5jigd3at+4HSnVk4arM/78ZwqimPWK/79RM54NNEa0wsS29XOdYe963xnh5KvpXrvH0/pCoQhva+lfD2UJ8HBwAqF7SYkW7Fmf+5DRTcILSpMUJfoHJDMUbB4207U7jpz+07ropObkdah7ZXll/TnadEPzsFa1lYHu/QubcaXvVM3hlj7gxMiSrW1rVVLpXvkfsMrX3/Fz/8j+FiQr8DZ60R1mLzADMm/7QpGkjapeSKiI5tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGuze2oab/nwbL1lxA0vbyo5q6XvDoILKtOj78mXqHk=;
 b=E6eZiSyFbfOsSb8bwJMjv3iJgVDSVIPP2h4Ep/gEuvajZ5Q4aOEFSG/KanaEtuuBoA4rG8/UhUAKso986NSA93zeHf52q0Glfk7kOsOTXa5QLwdFMvW2GaDjOhCaPw3WqXh9Jv1Vgj0vwZ1kboKmIx3vVhMMPbIPGsZHrFf3b10=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 21:47:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 21:47:22 +0000
Date: Mon, 29 Jul 2024 17:47:19 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2 v2] nfsd: fix handling of error from
 unshare_fs_struct()
Message-ID: <ZqgN5+kl4U40veEo@tissot.1015granger.net>
References: <20240729212217.30747-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729212217.30747-1-neilb@suse.de>
X-ClientProxiedBy: CH2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:610:20::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc640e9-2102-4858-b4bc-08dcb01806e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QAND40OFUVAsf9URzsfY+a6Viyt2A8YDf4JwGoZRZvvP7eusYazhnFM+0ab?=
 =?us-ascii?Q?mzM4G/YUPFC9fVTVIg6exRiSSeQy/YmG/kq/FRzCspvlR7R5dMWqt+edLQzJ?=
 =?us-ascii?Q?lMNXtQpca0aBLkYXi9Ho23txYe+OJmrnH67BVX4mqvVzKY3E3WtsYTDSP8A5?=
 =?us-ascii?Q?D7TwQe5OdxUu6lrBpgzt+oz/4pwRTTG4c4/fWZ8XnIS7vay5oShLBWjtiPBp?=
 =?us-ascii?Q?MRwY0WZ0YhjRwLQ0HZAdWwhsZjuEMkYHD8beS5dCFtfsHbXBP3K4shCxhvQy?=
 =?us-ascii?Q?c9JdLvvtESVG/nI27PD9pbpAezsTgJQmRo550Y2G/tGIwLAKfs9qrLJ+BKm7?=
 =?us-ascii?Q?Qn5ivaovZ+dphDhndXWvyvmUMzCszCggMSMuh5uZkdRoelcwI3pJ3Q2iox9C?=
 =?us-ascii?Q?tJ31004sgULdQxzu0N8NwNU1QngZL4rK1OKFomz2LhrnXH3bcS7H6x5nY2Hr?=
 =?us-ascii?Q?ADAsg56wFE4NvRg12X+85ZpILayufQ71WnlAmB9clisqMhhMJxG8XJGh/3/S?=
 =?us-ascii?Q?O4d2wjLCghbNqyPka/gpRP1mLdv+9oq8y+Xc5KSEGfwXA8vTsJiF9VmQ4sWa?=
 =?us-ascii?Q?42RirLPCd4o158RyVtFUPInP9AtnUQpM/uKGr2nzb4XJgFAHwa/XHRS33ZEo?=
 =?us-ascii?Q?dKrCJg1V/29lhbli7+u0NxzWGWDyfQLhcqzhB7vgD0kGgLPsW7+666hLl6X8?=
 =?us-ascii?Q?EEoGmZ6HlDfVFxNxWb3SIuLwnEPW3UYtdy6+LMz5XeizESEsFYfQZfj8CxFg?=
 =?us-ascii?Q?V+k5izJWEByezyVpK+lj1fQbn16ybne+qnWE3YjyzrLSvitPSK59NmnX2NO6?=
 =?us-ascii?Q?7GdQwhSDHwUP+kU2mQcxMkXUpZh4t5aS1hF+l3XvmNnDs19mwbaYs8Evu4t0?=
 =?us-ascii?Q?OlVhzo8TOdzxp2zUhRedEl8HDTnChsFpfG0kyxKtFBmSwYvm8um7uiRrdeaL?=
 =?us-ascii?Q?HsS+XnDSnxc4X35KfRW/VPEE2n8mO8+wQK1RkmKRrpkoQioEZP2+6RRTv8QY?=
 =?us-ascii?Q?18ve6QuvI297cB3Y0Y+C71IBgPGQZEyo4Lc8DtzCX5g2r9WIjR9SwXEDZKbe?=
 =?us-ascii?Q?MsSx+2AN42PjKH8PmaEQ0N3OgLhtVDSDXc9ATSH3ALHsnsCurmAqcrPQcloY?=
 =?us-ascii?Q?ZEHq7nPUqew7cm1qDDJ3OqAkAOg5rNMWYEEcgaU1KzCQfHA3cOlUmQq/OBcx?=
 =?us-ascii?Q?VjmE+bL6m7RmxCaGOcRrgmGPxKEtVA8UEf2OOispCWNvvTvxdHUFgm8FUV0d?=
 =?us-ascii?Q?vF3aA4b26jE6wlx6TrkcgWZnG2UJLF/OBmD27EiJh0rXOpGyWd0fRGQ3babs?=
 =?us-ascii?Q?A1SV1pFTaQxBEUpro/jLNDWy2nKOvKOkkThGL7mBx3DbWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xT9h0d/Vb0TTFkjkmUjVf80nW09tHwTKM5q+qZhWiuGSigPmX3PiQbu9zfv8?=
 =?us-ascii?Q?gVMTUXd2JJRmOqBetlfNIvrQFTCw2RAuHl/SVAXA3am8jwgp0e05/Iv07Iqq?=
 =?us-ascii?Q?8QLjnQpmg7VonbUeEw7IfXJmlbUbxufv2CAq6MtuGQOKQxffsa1ihHVfMi36?=
 =?us-ascii?Q?LWVrmyCOzCike/lH6TShb3zz05iQST/rktO/czN5PHmkzg9LXG2lg+6bjWH6?=
 =?us-ascii?Q?burqvMyLd988/DIpj47I/I3FMvCily77AbuSrN3/xmlYOy0SwFYjNdO7tx2b?=
 =?us-ascii?Q?SorSrF7SmaepXAHGMA1I7jfoJuxVjVnJbbr/JjUsUJw9L60znMAdeazl+Dc0?=
 =?us-ascii?Q?9p2UloA8v9/HYwrn2G8B/fa7ohMtOWugI7KJc7Xl2sjJEAgtGHZgWp5yPQP4?=
 =?us-ascii?Q?idIUJHjZL0e2B/wtBFu5BuOOXRbIFxz/ZQrCGhIuvvD4rqktXkfYOlkeE1DR?=
 =?us-ascii?Q?SrbRAlp/fD/yEffTR0cn5yb8l+GEENUwJxqORBZFFcVI5dqRE403fpX8lgf7?=
 =?us-ascii?Q?37ElGIxX7CBzIo3yP9W6j3TLJLNmf902GLlt6l79EIN+h/3fKZe20n2Qrbr6?=
 =?us-ascii?Q?FmjzghD+WPitlIA52MM29Pehe0T6yqpdWM/oR24Fpc99yEj5D27uAadJ+j5z?=
 =?us-ascii?Q?Ozq6OYUmOeZcdWv0uhwS8uYeWe+SwnMOsklMIhjTaiIMb8gRVRUFr9VG/GXL?=
 =?us-ascii?Q?9Km4PYz0IcxXo+lNBBA5NAW+BAkwnjP2I13xUnGbtzGh7TkRtRUi6X+hUKpw?=
 =?us-ascii?Q?t2dWHPab717H/nHMTgIjjoDIJ/1TvfcQUFdrfBwfwEtFkhns7HJ4bSZf40Rp?=
 =?us-ascii?Q?hpSCuZfCuGtgVQfdPKe3isbke2WAwXwpIk349lCjWMnXLCPUrhWbv0kWs1V9?=
 =?us-ascii?Q?CL53j5XAG1YqfsA8m4Bj1aCL4vmV5GCcGiD6ms3bNIHDo/K7EheH+HMt4sNj?=
 =?us-ascii?Q?iWVF380Tew9WLTcoJ9YMR0aywiYgeyEHStWIr6qFzUOoOXp6eOMkrRNqPVCD?=
 =?us-ascii?Q?NtEMI3HA/m0eOmd5mmHyq5OWoc9qMZzCkTmIwWVLqaCGB4fb6qcVW7E70gG9?=
 =?us-ascii?Q?OEnsrpsiTFTltoV9rD7+nYK7ZQ55WoYvik1M0N9gcvbJ8lwXD9lMHF3wr/hi?=
 =?us-ascii?Q?yfCXfiqWFLITEgx3BF3ug4gjn19fl3Mo/HELd91ypTym49UXaGRZug1818yo?=
 =?us-ascii?Q?SKRHAVMJZFmlLlVxa24bBvvU1AfX2lmqjVubr9WM6oa1iGFksS7YYaiexkSX?=
 =?us-ascii?Q?a0oFKoPBSv+dnDxWN7QbuYSXC6nMH81mNvxVv7l4Qikj/Oui3a4wci2K4P3v?=
 =?us-ascii?Q?ZxlKGt263XN+UHcthH9+GNPE/wSFRPWILODwExU94nr0L1TGKJUt96G6zH61?=
 =?us-ascii?Q?sxQ2/Mq8u8CTirCCTkHSuvsMCLNNY+Wgm0cXpVRhyqdcP2kn0udOzPGZpauY?=
 =?us-ascii?Q?Sm1dkTgdhWJOuMlP+oli3WMPLMdJxbzJmE24eWLLcFgP4gpF/qvneE6WZnUi?=
 =?us-ascii?Q?QkEZqRn5H9Eyt6phzrAvWKzZHO2AMoErBYAIb3XW3Ta55QK1smjYA2Tah+rL?=
 =?us-ascii?Q?I6dRjKqvgooCnY6n2XklL/UvcN7ltRfWGXkh3Y5f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Or3xLmB+UMh0oZ6DAiPUZS0aWHRhcrQCRbwBjf7g/t9dgt4ZxIMNcS7JWRJbaMIQWSL+2HqlKH7qcaMfy6BLiRqSuvDHP69f7B92YRVRSZcqSO6yESw8MpagrCb0Rsn4xSIc3khQnB8WnakL1nWXBAG8ZqCYSLnancY2YVTKebMhRtF8SPFRMDjaSnU6Uky60nmUW27MwmvKZQwiSay5ucFxWUfwuIhLJmA02AD8BKYT0cVdB4tRMr3dbnayJ0bjGnyKROoO4sUVagOT6YxZTOWmdtIWpX0U8G16Cl8cuzGiMzzxxrzi6o3qKudIKrSuM9l3WNPKNjD7rzgl2TY+JYuUmNYHX16RlJgf4EBEysCaWJSXc7sebV3izI6p3D9dcIQ8/wUZ6r/fMrYXmt/s08/Q11ZjlbG9eOdnOeTFnOldZUZVmheMGFHwVa75wrB+H7Xiz/leKvHW0faLWkp6AX7iV6CK3OtR5PHGgqWLE6RTY+zcmkYxz3OZwfyfiSPc5FW+0uoDp7DdrsjwJyTPhzdEgb2mF1tKaDNY5hZofLhxiCl2GnvIldcRCHdBzQz+7h2TJpkeMxXAQgf8mQkLU1XD0Uq1U1HYzqnO/RviG4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc640e9-2102-4858-b4bc-08dcb01806e1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 21:47:22.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUyLLxLhDib+2xOZ4cf166ZFyQ/8/86lVGJTeIBw1IV5o++noTf5b4LMVgz8mY3nOP8QW9IEvbEYpwxVrXVEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=627 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290148
X-Proofpoint-ORIG-GUID: EJ1sauwEMUxHORfCXD6qhyRXbFcV2R4p
X-Proofpoint-GUID: EJ1sauwEMUxHORfCXD6qhyRXbFcV2R4p

On Tue, Jul 30, 2024 at 07:19:40AM +1000, NeilBrown wrote:
> This v2 applies correctly to  git/cel/linux#master.
> 
> These two patches replace my previous patch:
>  [PATCH 07/14] Change unshare_fs_struct() to never fail.
> 
> I had explored ways to change kthread_create() to avoid the need for
> GFP_NOFAIL and concluded that we can do everything we need in the sunrpc
> layer.  So the first patch here is a simple cleanup, and the second adds
> simple infrastructure for an svc thread to confirm that it has started
> up and to report if it was successful in that.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
>  [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly

Applied to nfsd-next (for 6.12) and pushed. Thanks!

-- 
Chuck Lever

