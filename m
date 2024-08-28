Return-Path: <linux-nfs+bounces-5861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8F96291E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C033B2124F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708E1CA94;
	Wed, 28 Aug 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RbPSGrOV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bph6c8Hk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743212628C
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852748; cv=fail; b=laRvmNBjuosieHfe3pK6Yd7tUPEEQqFO5v1+Qc/U2p+Dd+/BM/iaiavaMMsdRhKdMfXEVh5gnyTIMUOY1K6bf1ghbisjU9FBA1Rebc46kjfVIXTn9WTMPIxheUqrGtikXHYWii6cIf7LIuKh3oJ4b7N06qbPPTjceaSRa4WYvXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852748; c=relaxed/simple;
	bh=RopOyoXTXNnbMnSlvEcdSQ8C6/0c7R9pNtWLabkq6rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qKPavZRAbtQdGP6nml4vMy59YCVBkbPyCu5ekiBqUq+l4dj5FCCuo5JNV157zXSQsS3Mnej/BdPqhd06vioYUlld9II8uADLO8tYEUvTG7DQGzPafzMkpbCjIvS1tL1pzGW4VS5agvJajM5Afh7Y77WMQrqOhFatShoYBex659M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RbPSGrOV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bph6c8Hk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SCMXxM021319;
	Wed, 28 Aug 2024 13:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=JO9t/mOUKm4Z/Wf
	7QtAppwdXJL9cTCm0b+ra8d/qJuo=; b=RbPSGrOVBtJeAU5wcBNC9ehuUgu2bRd
	Q0zDTWjFUI5qD5ioOXH8fBMukqLibsuZYjVdO4OxcWwprJwr21sNlimnhvzUNF9Z
	TOf17h4dN3lUe820sWBncH5juaZtUMDJ0qC31JuFXgH8PjLqh8ZLDQmS/CxQ97eX
	Cay9np6O3zq6QSDkWtU0Ftw/W0myPo1jnTXeT4+wMcOp+PCYLzRGqWLAMay6e+t2
	mMD9M8OaZGdD2M3ice2wnSXzdwjvbGNr2wugSzE10owI/4p1IP5zX3QbM0q2Tk/H
	0yFB9x0a00uxNL2nst77sbMGo+liB5dOIFrYdDhy/okO+LnWqi4F6YQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pur9b41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 13:45:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SD1VA2010444;
	Wed, 28 Aug 2024 13:45:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894pc42g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 13:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXkCPOUiI4neR5ItZPVGNOjbK0qVZZhufC/MGC84MAK0//CoVZQXXtNY2vDmM+lSpvkaSbFLCcKfLGhclKE/dbCG2qNNJG2eokbLUe0cW91OGWwWvIz3Ruq8wBIrQ+AHvuNZm7aVKxQ12FSTB4VCuvE+rFZsU/xEkkO4Mudjj+kufQtxUTFqY10rJ8UODALVdmypy/h9KUZ0FDAd7cyJ7ZSeTFFx8BbFW65Uh+Ki8a9v4l2n6HANMPsMebjMVK9SnDSxZRh6bI4QP0vv2ivctJiEPcXYm/6qDXPnWDbT3hqDfdsukdLvAPsvZeSo+gxBBXG4OvIKR9Ky6wRncI+34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO9t/mOUKm4Z/Wf7QtAppwdXJL9cTCm0b+ra8d/qJuo=;
 b=DtqbsGHRzUftHQdybZ0AF1mAG5B75SQf6S3VETwjDS7ttkXk8MIuxbt4M39x4rIJu/gZtWIInNx2cGmFAbn6ZFX4AZdtfLrvN973igqtVuz5+6PsOXEJFDbt2WRQnNdvqLpxzCPxIaqqQKGazIAp15VzzuSf9eV6ByYUSpT+CfGz1N5RI74BrpjwNK1BZw3RJa8ROc2/24lUnit+vYGNJEces7Nu6mp0CCc7fLY1UMUzECfzzcsMnFzC/wy2q+S08pj86i7KG1FqMplg4Kzec3A0XaR6mujB/5Olb3sFAXz3rgf0Xhq+r6LRwlp+YTDHfZ9NK8DePx+vtvHrXyOBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO9t/mOUKm4Z/Wf7QtAppwdXJL9cTCm0b+ra8d/qJuo=;
 b=bph6c8HkoH3ixEMdoFFxkdCSiiKB4Gmg9D3RbJsraT0vovJd7cpIsLhg1I/VYc7Mjk3WfYLUbbaWvD+/s1b9Z1tLWktQzQyUiLMaFwI5bZKeDVDgsioknQhT5c0f1y7O3x/YXarW8/XCsBDr/ofhgufsajxjo3pee8PE8+rtsGY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 13:45:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 13:45:34 +0000
Date: Wed, 28 Aug 2024 09:45:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, Mike Snitzer <snitzer@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] NFSD: Avoid using rqstp->rq_vers in
 nfsd_set_fh_dentry()
Message-ID: <Zs8p+yuLeCZbQ8ht@tissot.1015granger.net>
References: <20240828004445.22634-1-cel@kernel.org>
 <20240828004445.22634-4-cel@kernel.org>
 <172482136244.4433.13629516052198910622@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172482136244.4433.13629516052198910622@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f97b8cc-1f6e-4ce2-1048-08dcc767b0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sP2XzWNMnQuZ+77SDlmD97bAxuzflra9GU+QLVswO4EhetovhjRdrHxFlib6?=
 =?us-ascii?Q?T2amFCgTo/4VOnwmOo69IFYGx7jjZh+58AJiRghYsRQf4Sa95wHCmtnEvb4c?=
 =?us-ascii?Q?y+2/YQhmKw2eaHknkCqsjUKpk+41GV4c91b8GGskN3yNXHs0cc/rTm4WwCuZ?=
 =?us-ascii?Q?QuhRtaS1Bc7hwB6p/PogJGoalydETqBvNWhW2lMXkDoztfKtLyGInEuQZUBP?=
 =?us-ascii?Q?Cng63cUSxsIObox0nF03deyzYmvlgfdNLJt5nfATiQvTGmXSZl+rjY1wy9df?=
 =?us-ascii?Q?LznXV0STQdxKyjJyXMzzAh95FKPjJHaoi4fQ3VYAu0jmvdz/HGOOyg+FtwXw?=
 =?us-ascii?Q?WTaNuuF3At7U/guLA3K5xuClj1Xp0ua2F8uocA2gr8ndnla/4huJmd48bKhN?=
 =?us-ascii?Q?5ZJwuJetcJsa6FEGorEOS261a68uI3KD9DsA58xDG4svSB3Ov0IwT9O7iqFq?=
 =?us-ascii?Q?2tLFl/c7/PlPhFgJl92rJpHrZaQDbORSN5DDP3YvtbnImZUABE93rc2lFkf5?=
 =?us-ascii?Q?V4QI4iIDLPVgBL7NxjE53hTxrFtS7jmkQFVwyPbklY/HW7UftGSRsnO6wNMm?=
 =?us-ascii?Q?LWj2rC+A2XZx9Z9u74OOWfva9rtCUOPyO8CjZPg2GvqKHpQoywfAwV7+6HxW?=
 =?us-ascii?Q?w0iGAz5dVM4iBKDDKqlHbcyO+d7jKL0/cfareHTqili7QNcdDSwHiqT38Cbj?=
 =?us-ascii?Q?yk653j2SOScl02up92mfCz2yBiZNM3aspnq9B0pfrCbX91/pPNf2sGmSGtUS?=
 =?us-ascii?Q?l9bXejRmzONKpAfyJC1kADhr7nSSPuNaRxP5uFYKtGt3pYgquHIhs86zasus?=
 =?us-ascii?Q?4yJFj6HyPGpjcTbGAnckiNMaUWw+4fA4P9cwG6nAOMS/XiSvUPl0bdGVf6jL?=
 =?us-ascii?Q?7N2FCZPzz1EXaeK8hqd0IWmLmiWTfqB2yn9eq4hDGYWL2hDsoXWOQ3CawNzA?=
 =?us-ascii?Q?l/OSPpymmoULlkrpRUGoBYxkyjYlDg2Y3WZN/mtnrig6GLpxbDbw1fbuOYUL?=
 =?us-ascii?Q?MIT33n4SMzO57RV4IvON/TXfitD9ytnx/g051AN0SuVS1ASLlTJCFzh9dFC0?=
 =?us-ascii?Q?iT8ycHIDkQWUHEM7zvy+w6QIcI/dIPjYUQy8efZ1liebFUtm4AIZs23yyJ/x?=
 =?us-ascii?Q?j43zUvMvjpiAVKUd5wsGxHlYNKm5o1BtFyforyAPpHEOW2Jo4z9I/YoUHggE?=
 =?us-ascii?Q?hkZa4qzIpnVqW+fVrwnXYOg6BbVWryn+DxmlglLM5CXeUDN9AeyZW+4dLJw1?=
 =?us-ascii?Q?guOUZUpJctOheOKk/ZrHjJvuDiU2E5No0HxxO9n3Vv/wL00O4BgKTmN+6EuW?=
 =?us-ascii?Q?g6mHFSG5vG3nr0R3vWg392G6OH+TqKLuNJXZRu3zyjtaGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HZCTJzued1w1gtO2uwXFX7K/pnp3QjNxqRvyX9QiLdhos3fxOzeMxjpjxp4z?=
 =?us-ascii?Q?IlX1cAE7BeTVP7+I0iGvGQOmWJ5vJ72MyFycV8e0jRrPWz6GpVsV8+wN7clH?=
 =?us-ascii?Q?ZlGan45uhPAdEDjsRT27Wrs7b3I2qsFtf+bxQzpvSXxA8w9cMoHEkoGMcomm?=
 =?us-ascii?Q?ahhaB6ZBFyEeaHHEbpqoHeF1fOJVvi1qEHC4/Pd2jZluBQmmmNzuXKnYRS9B?=
 =?us-ascii?Q?D6CYnz5BypM5bL9aIxe5dvgjto/WDjKlOvbduHabVMtIpexU7m3fb7IJGnpU?=
 =?us-ascii?Q?uOMXwaChaB0nQjrqRJNWP8ZHO/jO9Xs4ZEawA4o+wW/MZFR8uiauu6ncsTa8?=
 =?us-ascii?Q?AuSBKZMxSzc88ZewFsFiUPGeMN/V7r7GxhKuOT4YMvVONBDzVKc6z1H7iks5?=
 =?us-ascii?Q?9CiyOquk367XG90g6CDIkeAHMZq7VQ8BawzCHDBGFh0KP5VCnm0QNmOd1DuD?=
 =?us-ascii?Q?feN2cR8JWj7TC4m+sO6pEkBXyogjcaG6DsHAeGjQ5mVBNJEibwkM7Yf4UYuw?=
 =?us-ascii?Q?WPSKZ5oXjxzrs0SO4ZCZ79HoJldh/FXfE2HItIq2QShiyqZJHbUmXuAm3M1g?=
 =?us-ascii?Q?1sZERe3Qf6Lx9HBkQlCf8+AzWMsqppIyKjt4trd7K1USZ2t6f+6FQJxhXNnI?=
 =?us-ascii?Q?DyP67ThlHjxiBu21LxqsuWwQge9QG5mC5l4duVsPEGCjpD7q487y32f3QgRW?=
 =?us-ascii?Q?1DOzGToxuug+nSkMKTHkq3MrzXGCGpjAe8TH10boAEvVnmnaICU1VMNZiFEZ?=
 =?us-ascii?Q?pHhcWzfx0G7q/9CpgeUQo9bmhISbLBfjgkPgsJbobEhmRSjNox+Dte80/3kJ?=
 =?us-ascii?Q?HzzP/t4RdmXHj0u8gCZ1ZO2Ug529Fl8C9nbX/5UqvwbAtR4iirK/SX3lOcgt?=
 =?us-ascii?Q?pQOHXn3XeqZcOKj4PW30xF1bQPliUmPAQpr5SxFMmuiFeVbtxTaPpxGJGVKV?=
 =?us-ascii?Q?LkrS12dwAEfvIqmZMaK49b1TY2wupDjQBqKDKcYXQ5jTIT18EBdpo2vZEr8q?=
 =?us-ascii?Q?MlFI4fOnHGqyppwO725c9dEkY5xE/P4c1PB9mYr9b0dLjV2rEMcwsNY0xKgq?=
 =?us-ascii?Q?qM7l2+1Fvb0j4qKyv4QfIyOGkeh7o1lPHHabJk8ZlB72XckAwYpyAmVR7rDy?=
 =?us-ascii?Q?Wz1TcJAVwoxiphAKXTAGiXdYjIS41x4IcEoIF/42u+0WQ4W6odD1dy28fZNu?=
 =?us-ascii?Q?Ok/aEonzk8ZBcec+95lCeCDkfdAg27Bu81Ib/rpsbpEn5NiW87ltSahQ7xwr?=
 =?us-ascii?Q?Dqo3adnGrc2uEocTZWcWozHczWojI+LrtnVyGeKZHh7L65VtOA3h1HfMdHWX?=
 =?us-ascii?Q?LFp4aSOhRqytMzxFw0SgE7/GlGKyiTc7WZYLI3M+SrHZU4IVqXANentQ5OdK?=
 =?us-ascii?Q?71I334b38iIJhJH6zuzxkVbntsm7JkDbE6RjuKFVU6g+45Y9VzzOg3uWm6df?=
 =?us-ascii?Q?6zRygk2JIUIAwyWnTr6RsHSh61JDEdmU0cQNyC74trcxmm3++5fOsLV58r5n?=
 =?us-ascii?Q?V10Z2LElYmjWMJYNvCVHmt1ccO7yeJ0wrrtK9kKzLA6XUhyhjd6os625ewhs?=
 =?us-ascii?Q?Rcn7ZCpZPDQZlOB6SOz8z8HIyXrF9eSwSsHkhKJZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lf9fxdRp6Q/X5grSky1u37U68JIFNJVvPyuTNWSA62YXsJcN8ZvfhEvt3SEhvpwEk4KQo6b5YhHQJt1MHtoQxNCdK8GVRN+5CimJ+Uu6rpQtucTP4foCTnJAWNFXeIxKAfwQ3JBSvkuq8154LE/Yp+Ag80q1wdAxHFvu1HOLQNNimgHV9y4EAcDTXTaECrctzQFk8AzWaojFqJ+MIOK1huDWV23bTDqJOY32wOoRKzY9ryQLMTv5ESF6i4r+nZJ+F1il1i7UUgvGupEyQXGlUFgmmR/8NTrsVpExjEUx599AVl42dfE7iBhErHlLKCXPDhCJMRtWni5FocvO+uqnKjDEmIELBtCQLHfra5tHDaWSnrdNzNGaCRgKMI9yFUQCOwe7mglfjDx+0v56ua+shMd4yxuF0P1Jl0UcZUlVynlglfSRLdKawqTyF9cxnwM/Q98A9X7QSekHBPNBgS0sOIIjkA+Uox9SC05xg2TXwXaQqroRNWZXXSUeMgy27cBlkCQzcXYf2IbUu7BvyrIqmfhYwxEeEp849RX3FcWqXls3mXTFw0ksnSu20cLhS7I/KUnEGwOfEI3kaAHtrWvTrtHz5jz5kkx4vSKeRmaXzsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f97b8cc-1f6e-4ce2-1048-08dcc767b0f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:34.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEeS89qjgpu4PMeu43t5uhpejMCKr6k/yMF/yistAYq12N44qo51weKYD5b3mxL0qb/fy8GijuFSAzXJ2MQ7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280098
X-Proofpoint-ORIG-GUID: L1F9-YPtgYreafd-vW1o4BpyIrtJeIQq
X-Proofpoint-GUID: L1F9-YPtgYreafd-vW1o4BpyIrtJeIQq

On Wed, Aug 28, 2024 at 03:02:42PM +1000, NeilBrown wrote:
> On Wed, 28 Aug 2024, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Currently, fh_verify() makes some daring assumptions about which
> > version of file handle the caller wants, based on the things it can
> > find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
> > case sometimes has no svc_rqst context, so this logic won't work in
> > that case.
> > 
> > Instead, examine the passed-in file handle. It's .max_size field
> > should carry information to allow nfsd_set_fh_dentry() to initialize
> > the file handle appropriately.
> > 
> > lockd appears to be the only kernel consumer that does not set the
> > file handle .max_size when during initialization.
> > 
> > write_filehandle() is the other question mark, as it looks possible
> > to specify a maxsize between NFS_FHSIZE and NFS3_FHSIZE here.
> 
> The file handle used by lockd and the one created by write_filehandle
> never need any of the version-specific fields.
> Those fields affect things like write requests and getattr requests and
> pre/post attributes.

Then we could simply drop the "case 0:" arm and maybe the lockd hunk
from this patch.


> I wonder if the filehandle is really the best place of these flag.
> Having them in the file handle works really well for fh_fill_pre_attrs()
> and reasonably well in other places, But it makes nfsd_set_fh_dentry a
> little clumsy.

The file handle initialization code in here is indeed a bit awkward.
I didn't take it further in this patch set because I didn't have any
brilliant ideas, other than perhaps a version-specific
initialization call-out.

I don't think we need to go there to implement LOCALIO, but we could
save such a clean-up for another day.


> Maybe it would be better to moved them to
> rqstp->rq_flags.  Or possibly in the "Catering to nfsd" section of
> 'struct svc_rqst'.

Jeff and I have agreed to migrate NFS (or any upper layer protocol)
specifics out of the svc_rqst, where possible, simply to maintain
proper layering. I don't have any better ideas, though.


> NeilBrown
> 
> 
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/lockd.c |  6 ++++--
> >  fs/nfsd/nfsfh.c | 11 +++++++----
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > index 46a7f9b813e5..e636d2a1e664 100644
> > --- a/fs/nfsd/lockd.c
> > +++ b/fs/nfsd/lockd.c
> > @@ -32,8 +32,10 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
> >  	int		access;
> >  	struct svc_fh	fh;
> >  
> > -	/* must initialize before using! but maxsize doesn't matter */
> > -	fh_init(&fh,0);
> > +	if (rqstp->rq_vers == 4)
> > +		fh_init(&fh, NFS3_FHSIZE);
> > +	else
> > +		fh_init(&fh, NFS_FHSIZE);
> >  	fh.fh_handle.fh_size = f->size;
> >  	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> >  	fh.fh_export = NULL;
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 4b964a71a504..77acc26e8b02 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -267,25 +267,28 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
> >  	fhp->fh_dentry = dentry;
> >  	fhp->fh_export = exp;
> >  
> > -	switch (rqstp->rq_vers) {
> > -	case 4:
> > +	switch (fhp->fh_maxsize) {
> > +	case NFS4_FHSIZE:
> >  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
> >  			fhp->fh_no_atomic_attr = true;
> >  		fhp->fh_64bit_cookies = true;
> >  		break;
> > -	case 3:
> > +	case NFS3_FHSIZE:
> >  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
> >  			fhp->fh_no_wcc = true;
> >  		fhp->fh_64bit_cookies = true;
> >  		if (exp->ex_flags & NFSEXP_V4ROOT)
> >  			goto out;
> >  		break;
> > -	case 2:
> > +	case NFS_FHSIZE:
> >  		fhp->fh_no_wcc = true;
> >  		if (EX_WGATHER(exp))
> >  			fhp->fh_use_wgather = true;
> >  		if (exp->ex_flags & NFSEXP_V4ROOT)
> >  			goto out;
> > +		break;
> > +	case 0:
> > +		WARN_ONCE(1, "Uninitialized file handle");
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.45.2
> > 
> > 
> 

-- 
Chuck Lever

