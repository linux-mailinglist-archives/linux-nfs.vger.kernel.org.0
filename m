Return-Path: <linux-nfs+bounces-5691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF695DF48
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 19:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C091F212D9
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357641A84;
	Sat, 24 Aug 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IUoiloVl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNTlzu9o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969443987D;
	Sat, 24 Aug 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522261; cv=fail; b=Nk1oh6shA1Q9K8gfwvYyOZC603qKiJSnfrP5OuwnkIWaLZKG98Hbf1w7IqXni9HwZnZZgehvasy8EMA8s9J4mHhhpO5E9Ejx2MAACuVGBUE+LRT6Xx/QskhGlWZQaTzbhJzVBkl04yDmIm/Zys0Uj5m6KEokhH8g9/dbLJYcXFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522261; c=relaxed/simple;
	bh=f3oLNgdWr49fVGRRHAdBgRp6Pj68td58TI3iMFKA/y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TGr+FPUPdLWDdPChKwtkOmAFyA5r6AXNO+NSYbLFwaYGQYCOkhGaqGm7CiSW/7zaw3oVQWEnxehllbpaouMZErAspDidfwYjNqphvFAj9LS/Ve2JnvZYMpqbYuq7k32hNBGDWxvyT/PXGdWg3GKzHzJSqCm8C5nxPqqHIJi5yZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IUoiloVl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNTlzu9o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OFCetF001258;
	Sat, 24 Aug 2024 17:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+M4VuFuSO2JXOXu
	m+ek4wcTxRyBg/aO4+/xbqgnc08E=; b=IUoiloVlZ8mkjivJ/cHBpGiWNBrXt95
	2j9SGbKkOVoJwFwpwblUcot8KwZcvNVtjYxeUqfe5ygJTCqb95qBCGPHkO1XODmV
	Hxi7dcKQUVqma1d9DfRfUdRNlo230x/FI6bb8tskgkoiUBlw7qJO7PJdytCA7O6D
	EV22l03fEiPoQFeqM9rklYfcvk10zCIfyQDLP3PoD1FVw2sq2x1t7nQshelJesnx
	ptXDV3sQO/wiV83o87WtSI1Ggtj/SyyX5AAkj3sePk33gkxeQDVL68CigZC9f9P1
	gtbtWEnoyY3fdBw8v0DYaheVbONEQMRUq7cjtTJJQg3MW1hjgN8luow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177ksrh9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 17:57:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OHXg9D002615;
	Sat, 24 Aug 2024 17:57:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417m11gbj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 17:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2cbfq5676oIsjkLUfkA34crSRIMhOtV5/ko1FUtQTE0clJlPlrL9IaI3I8HT4WesD/v7KYMwPdXSJw/j8afdEX2KJKDCaPkgfBeeSCZhyENsY/t1foNVboaUqJPZpjJHhi0ayazQ//UrOcGCcZ69pk2SZEJQ0rjXuOKjSG0z/SNWp9yak22i2rilWUeKJTdtDRJhJ+6fkLtHfTVLQTuSkFilj20bmVeV5TfjcZBAf+umTOHMTAC0jde3XjAmkjF1mkYQ4dMLR1nPNuGPPy6h3mW2oeU3r7GP6YuZ4o4pk40t9MpCDMDb34+JrNA/mXc8q5iAJ/keprI31QhZ09NYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M4VuFuSO2JXOXum+ek4wcTxRyBg/aO4+/xbqgnc08E=;
 b=RgfIpR4UZ1D+nOiB5nJCwCjhdZtyeI81wcYASBfyWQwOr19FWeoNXrf9Q/YiCcrSBTuKRgTmq20dYDHdQr62lUx+pQ0TrpHOFK2aXk/5ZQjkCtQ4zx+q/Dyja/44H4OyI3gipma7xIOYaV+8WQ5cUe4lzdLDt/bqR8/NPGwEXaBsE1zDWgT51mW5BWSlijumpX5AclAomV/cVaLeSNm2O125+DMQB1AZlvaw+Yd6TW4o06jaZlD5VEsp/n4NpSYCPN9pRzKWhaJx1CG47ip1qngP0qIN32hEUwmuzlZ/xFUIh1nhr7EvUcWpmTcR4ywSqkfk2nHSC+ZGguW/NslvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M4VuFuSO2JXOXum+ek4wcTxRyBg/aO4+/xbqgnc08E=;
 b=tNTlzu9otg59B1Vn9P5Njo+JRHmHEAe4vWORI8Qqm/7yI8iZvJV0IavWJs0kbimqbl1JIKV1G8mMxHN3UyOMqC85wcEGILEu+0QA928wls99mw3niKSUclVFe+VLLs5CFPrQJSx0t2m1Qa7+G3xV6ZYb15ASwXKWk1pXmVA0Fsc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7185.namprd10.prod.outlook.com (2603:10b6:610:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.13; Sat, 24 Aug
 2024 17:57:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 17:57:19 +0000
Date: Sat, 24 Aug 2024 13:57:16 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd: CB_GETATTR fixes
Message-ID: <Zsoe/D24xvLfKClT@tissot.1015granger.net>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
X-ClientProxiedBy: CH2PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:610:50::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c35f329-c943-4b6f-9bcb-08dcc466328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xj7bEIiYr9in/d5iteDuJ6a9oK8fT1WyJwrCyEYe4c4mLFz5JQ3XOHYM1SID?=
 =?us-ascii?Q?F87iaNuZX23kBnoAGMtoEFuWAfWUeG+J12TlIZCajoSPw/P8rPv8ffwwVBna?=
 =?us-ascii?Q?bSmRzybHLBMlPWbuNDoVaf2Mk+XOgLAk6oLqD05TPIAB/oW+3ONZt+XuHGGl?=
 =?us-ascii?Q?T+duXZwiZVcocqS7A7ZJMBy9EK9Gyh9Tbm/3QpXIEv/UaNo+cX4PUHTQwqKD?=
 =?us-ascii?Q?9tXu3pGu0uFNgXtl7cGzPukwvqX20kAfn60ZLn2Qm1oDCnMU6S+fzVAa7gAm?=
 =?us-ascii?Q?mzK8S8vIjjedpzdl0QAqb7dkDS11VJrtULI6eWn4IC1o7jINUbPr5Hsl5PH5?=
 =?us-ascii?Q?2AujoV3lo7DWQWbo7Paz0YEtLkBy+/dFuk31ei2kCPUDyVy/Aer6MWIDVL/+?=
 =?us-ascii?Q?84I/ZFtTDey2FHs1UE1at+YansK57NBkM6uS/lfIMrjlW9xfOFtzGffIIVe3?=
 =?us-ascii?Q?qwJ7dLg83Pbe67tYyPS/qkO70g3cdnpUbrYs/+fQ5axh4MzTj7rtNB35ugye?=
 =?us-ascii?Q?icA1gSX3HDGpUsE0jOTDJt3CNpW/QbOpdJSYMPo/rQWhZsXRwYrwKAQKFAsR?=
 =?us-ascii?Q?buyBZIXFh10ZVt5tGly067t0ZSrto7GHZ/jYyBau8ZIoGjITiIujUbOkxPdg?=
 =?us-ascii?Q?BlzuJOFO1+vd+0FCenTcDZggVIxHoqbIUnL/r5E4QfrS2qfa8YB5Lg31pMph?=
 =?us-ascii?Q?JnS4VnrFbYpnc1XChd/ZscRFBoR9fUeOAKUoTXRLsd5KsGA9FwZFqTWES0FR?=
 =?us-ascii?Q?EdQsxGc4lEknB6tH6b8KgTnibZ3SxsULFNMgQ3UCy+VyRMRHw7mON6qz6f/k?=
 =?us-ascii?Q?HQ+l9qzQRx/zlikro2bxuKrT8icW/81O8f8t240qmmXxSVXRFD3VdFtlfbah?=
 =?us-ascii?Q?q2p6cI5YiiDEsFaiBd9y1cJriULfd0KCgq6UvYP9+KLbNjJublKe3vgIUjnc?=
 =?us-ascii?Q?Rh0PFpLS6ATV9gYtjBlmvd273RmkEUrFo+gew9kR0gBTZMKtliNPhr8/CBdK?=
 =?us-ascii?Q?ra/9+/DNSYk648Mvzu7piUxTRyHoQxFujv2Nu4CzY3uVRubGJMuC+KoWWN97?=
 =?us-ascii?Q?GxGj+5VyFjjA0/ceFbkLhOipSJOx7ketcjB4IklTYe38NC2lxouXlrSfPHCJ?=
 =?us-ascii?Q?bpavwqf9p+zYA1nKWpbwMQlx/nKQsLmjMCJhjYTbxGANdsu+lWB5fw/wkQk5?=
 =?us-ascii?Q?DS95y/K4m3TytmTkKxdRD29RQpvPQW0lyZCyEaC/Sat+F/o4S24jtkfZ24Nx?=
 =?us-ascii?Q?J6Jm4IYT1zEDNnS6EjjRTAiwOrkYGhQRTlZB8hwiZ+eZoC6l2DAmjNIFHTOZ?=
 =?us-ascii?Q?cl99AxIrjGLboC7ROImCYRfYvZuHrYm7sCi2THTEoR9Vbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66zRA+Z5IgqRUcNuhdai6F892X9qAxCek88bzcQm8Yf217oEgZWDbVJHyFl9?=
 =?us-ascii?Q?NjHpuayIdgVBXZ9mdK0l2RPBhDwrL/YFYwfUeFZPUZH4zBuQcImYPg/5Xb/q?=
 =?us-ascii?Q?XF7gLzZnbRKtfW0cMOi+s9HtIdF+1R5bQsTSt/Q2UjDfYw8ImTBfiSTSmIMi?=
 =?us-ascii?Q?TxcUXUp7/YcsJykzBd7tCKJhHI+tvwjxEPj90laDa377NZ3afiweW24cEhq8?=
 =?us-ascii?Q?MdBy2h9rFesezBdQIyuR+GlUXJPc4HxEKBM0LhoOnPhRpSS9oon7zCyUCMqn?=
 =?us-ascii?Q?1JvpoKXKKYTfNje03OZMZ+Ol3UwWkG8fyC1lwm0gHZOMNtwRHQ6G6dZcIFTS?=
 =?us-ascii?Q?DQYphpfSYh2A1jX57r6aknTOspa25HXNhFO9Q2xMeXv6DeaLxGzq77Bhi75W?=
 =?us-ascii?Q?+NwIxxv5mJY6b+5eT9svHIBSHjgMFxtl4rjTp7p1i4JOdQ4cq66A/S0IkVZ+?=
 =?us-ascii?Q?ly6Ok4qsVTb5YrSsSgi6YLGOZeBv5swjqYSzM6eWj1BXxuRVmhbGgsNFgjSF?=
 =?us-ascii?Q?EPX0nU6PjguLiWcu+17cTPskcsSyvJYnTFq3DYM0WzTHDtp+M2WHaE2MHtaI?=
 =?us-ascii?Q?rmMiaKUNOcBfuF7vuRUTKHR8v6gwST026bPnliKglYIonfAQHXnv00FXSUbV?=
 =?us-ascii?Q?paEwKN0C98UZiiBXdpPTwu6OtQNLztpGSkOYUZHpr3eBVJ6tjnfFxv/+oIkx?=
 =?us-ascii?Q?f3PK+wsDPeIiLmQvNFG0+lzwnbGw/i/xXojHgr6lN8usggGesotNJ+TFbEC1?=
 =?us-ascii?Q?YjjvuKf1TwQdt/xDzeeAE/mTvT5XWmEN6L67LWdJoVJcwlqeeUJXG/+KlDUi?=
 =?us-ascii?Q?NfNxJK8fBY+oeKeRsnuEreywLSXdUwUIphdkw4H+C8ogMc5vSQLTzbgdNoms?=
 =?us-ascii?Q?nOzh+mgH95/51Z7yUHSYgV7mPEjofr68DMA1bFYkW6roxhR2VGmJfAaoAiP2?=
 =?us-ascii?Q?0O1D72NXxfFD+QJZPnF9WflFL8Vv8um3EakHPhSF5R0TF332CFGvpNfW+0b/?=
 =?us-ascii?Q?IPAdMRK/MFxL1J6Cal4ZcS2odoMnu3yj6OgDVVac2F1TZAIS72iU552vVAU8?=
 =?us-ascii?Q?O8vPOD78Zp5wZKXadDUt0zWqP0tQYk3Q1tkcMpaGiGTnZa6jCx0Vo1/6vKAb?=
 =?us-ascii?Q?QfX9cBdXgWJYDZm2e2Z0AGeUO/gZzZE/xEI/3w7y8KCD+7mJ2pQRxRkT6oC8?=
 =?us-ascii?Q?Dj1/RXzrFL/ePUknfvbRyD9DwtwRSLHCaWXIA48hooYcbxCX3qkGn5YZfcxb?=
 =?us-ascii?Q?6XtK5df629iEyx5JcyAutBSswJnnPeapZlfyJ6NBlIumXD0BEJnckVLjAOrW?=
 =?us-ascii?Q?nuIXC3JlLqsqqIEyPHrmgAM9taTRQHjGiIOcU/XArtAtQX1MfrHC0dPcBHZ6?=
 =?us-ascii?Q?crKeb94KPm7joPytAlMRXxM0A2a5Ht+Jlbvo1T9CzMiBI/ouNm5tLYneg1DH?=
 =?us-ascii?Q?rTXHtI3aiWk0su6i7x3R+qNxFsQD17r9N3xCIpMfxZXSUJ4JySGliucmihTd?=
 =?us-ascii?Q?im3AQgqRhjFRi/ZPV1LPsxfhwMdSXm7Fdspwp6Dc4CWDHIyGODR6y3N0LOau?=
 =?us-ascii?Q?FRy00CQyMjgQTbHnUGBGpa6QJmE8aFaB63YYsfgH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G2f6cL/woODyxOOrzgQ1FDYMEHb7iu6zRS4P2vGqD6IzKZRhGRb7ZDzH+RUIwnzvWiGU+4UjkKMrG1gWW73boYdSlrNoS/p5bVPEP6N0c2UAHCuMYnYNmX7tALSgeMEmGN4buWc2wwboBpQoDX5eDAAIep2OgtGnrRqUHN/RJeNJ1UfSZxpJEgIZL187ovHN3BL3gkAc6lT/5Dpu1PaV0zbVOyG7q4hcjppefzQ5hvtl7Xz4no9gmOKbidR1vICFWsgolzoKG6rTQ5erXpFXlUtT4w++aowmTdqQcL6KSHt2i4/m5pKZKTFZfP9a7IcCdX63u0ORNzx++qu2Nq23aEsFFFIhqQvf24Z68FJ00UmncN3AMDHKLfxR/rQECKMvMJfLD6UwC61eIFdD8QcfVwyMH0moDToDk0RVbK1HxPkXYVa9DDcdo1Dz9QSwSpF9RdGL2KSbv0LbFzRmaPsP3j3VL0mqb1m8S25v74CBQ2Nui4aKHtz2mOtFv1gH5ZmDtKszY5knw4ZUXEbB3RYduBf3Wv6bBh4qdk52SMX49GHg6EVx/EiM9IoWhEndwhIAsNUxsYz0e7/cLqv7PelwEbXZXhi60F1xNcDIue+VGKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c35f329-c943-4b6f-9bcb-08dcc466328b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 17:57:19.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLGzpApNI3pzPAhfaQbm5ZPU7Aevj7/JyFfJRAvctXc1vvU1wmH/Wq4kzx3U0/1no2BibLb61/Nt3/DN0pa4dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=743
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408240116
X-Proofpoint-ORIG-GUID: jwShd1UJSwbNPUJ8Jt_7RHTwHGBATsdp
X-Proofpoint-GUID: jwShd1UJSwbNPUJ8Jt_7RHTwHGBATsdp

On Fri, Aug 23, 2024 at 06:27:37PM -0400, Jeff Layton wrote:
> Fixes for a couple of CB_GETATTR bugs I found while working on the
> delstid set. Mostly this just ensures that we hold references to the
> delegation while working with it.
> 
> 

Applied to nfsd-fixes for v6.11-rc, thanks!

[1/2] nfsd: hold reference to delegation when updating it for cb_getattr
      commit: 8fceb5f6636bbbf803fe29fff59f138206559964
[2/2] nfsd: fix potential UAF in nfsd4_cb_getattr_release
      commit: 8bc97f9b84c8852fcc56be2382f5115c518de785

-- 
Chuck Lever

