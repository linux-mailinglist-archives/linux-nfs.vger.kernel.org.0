Return-Path: <linux-nfs+bounces-4864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FD92FB92
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 15:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264EFB21AA6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78FC16F27E;
	Fri, 12 Jul 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PnKywHtB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fX8l/mgX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19733158DC1;
	Fri, 12 Jul 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791586; cv=fail; b=rjrEHbIHjJZ8rLaUHn++7glSVL33ZP00XbliayecjPNtYwECO6JABGI3CFzhB1d9UHPKCv1TphWKv5LgvG8ZJrct+G9+Hy5VDKAU3lPxLrSY5dxmllNkyHV/Qd5wVzvyCDy6Wv13picMdfUTSYYmSN/NuuW2Nnz82kgQnBYtOo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791586; c=relaxed/simple;
	bh=EFfU1iPJDvl5SrTNx/MJ2Jyuh6WDIVbXz7lxZdIjNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ncWwl8lgNWCHlRinoe0PAjvC8hNfJ1FgRbdRDcr+Mh3dD9oZTatnTRS0j4vLq5IV+OyNb5/So54/M0BRbaJAFy/1lCC+eQWvJQKFme4Vo9opYJmfKWTNMwaAIf2ejwao00wmttRS4BPg3tbt1GWyQEZF6xpQ/SFI7fE9JL/FhHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PnKywHtB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fX8l/mgX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIhdP023482;
	Fri, 12 Jul 2024 13:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4a4zkXe8eotKjUe
	bNW3zkh6+ShZM0FdxbQVJUujHgvE=; b=PnKywHtBFY5cpkqTI7fjz/YhWrhnD2N
	dW7FKAC9UA8arfPWwwMI8EJo+jUsQkVge1Y8NgjRwPMILLH+cYuVhz50BgL8TeGm
	i3p+cVfws+H4tTg8xMDGJif/YzayBRegpobONe/BwRxHzFuzuDbef8/SYdWxm6Lj
	J5RZ1gXxqxk7lNW71N9vmK9DPCDwIsziKvNxCV9nyzi/gDEh6V9FlvgkI9KV7SV8
	2JUvjkAzrzREhy5fjHLS5Oh3+t3/HOMprZhPY1SVYRXtXNKiQcj7MUK0Btbddeb6
	lJyd/DM8/KuHdp5F/a1NA0x/TuTWVFaNZzn95GrSKlpvqPYn1L4ht8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq4067-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:39:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CDVgMh008720;
	Fri, 12 Jul 2024 13:39:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5ynmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoGxghrSYC7paGQz+a4q65d8VbOGy61Ph4pL4ZWv5QeywjTmT7DisEN0z5FNVDP226f/XqNfKKmzqkkBM5nIJxPZMbMROOMmhG336c5AFY1aQf6CBYoOO++kwUhObmpshszbEf750HvxOtYfMKGwkbgzSVjwyp5UYr9p1cYrjAf2NjWMTL93gybnvMi4nTPu6pxRjjbFVIbqKm1WgrlPbji5WXm6BHQtQjskVWBlMtuljwTFsHDbM9MF/JAnm/3qROtISY+mVQrJimLuh7x0fMz4Vc1+m4QSRatEVhSp4JvgVvzGQkCKyMu1deEdDUS9IwHIydAFfcQ8BbxkdgqZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a4zkXe8eotKjUebNW3zkh6+ShZM0FdxbQVJUujHgvE=;
 b=wnGPVOVg/XbA1OK3YviGGFWww1bqTvFmCV7JgKaixvp09zbjpnJ3LfgdRf35/7HaNArYh29fD5Q/vmMwMKuZ0P6q90dhJw+lq5dWiEq8s8BkdhP1Z1gWxYwsNQmJi3fwDjw2gTwMAaBNm6ubCkWx/ApAQsoWisvBBo0SXz7FERx6FUR4DYnrwSCW4gXcNLbpf7teeiAl1yHokg0lz9TiPKhDwD0q5AIghNM6YdpFYzx0Q7svZ9hR0qJMCoYcw55FoD7sUy+EeI+t+8TfiCoAZJUKiqGtj9vjRc/udKs+Oqyct3lTMDUbyX7DOmrL8TSP2Pbw/WZQip45cXfgTRlKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a4zkXe8eotKjUebNW3zkh6+ShZM0FdxbQVJUujHgvE=;
 b=fX8l/mgXJGZY6QUs9GOyqF421d/N+K1VW1q2eq3uW6iSA2WM3RXNMJ6ijE3MS1hnGGfUw3tbZ7GgSMf5/+bJjmG5GN6trj5iXzrG3EFcu9UNRDpppo927LCkHe+fr95KK3u550GqiBxSD+/Ir+9KCVL9Zrmrm6hM1ZkwKeqBw6Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7734.namprd10.prod.outlook.com (2603:10b6:a03:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 13:39:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.024; Fri, 12 Jul 2024
 13:39:11 +0000
Date: Fri, 12 Jul 2024 09:39:08 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
Message-ID: <ZpEx/Jejy/CiXE5Z@tissot.1015granger.net>
References: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
X-ClientProxiedBy: CH2PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:610:5b::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9d74ee-78c9-4b53-dfc9-08dca278034c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OiON0tvsax4q3nWuf98RixXEbNBeCZ9zr0ycvPYSFR/eIZUAgF0Kch9zgnA/?=
 =?us-ascii?Q?0CV9jsUnjICW33ZJktOjvjVBSowpLf+BjJedLS571nHteezRQBHcSdEYn7WT?=
 =?us-ascii?Q?d8F4py5TfbJYEFkGraJcyySKWE8N7FMAlU1QixM8wXp/f9J6PdAAwVVrnELD?=
 =?us-ascii?Q?s6AehZPsN9lVgIzsFkJqIhDu0Q+u8IZfrhc8o2XVhjwq87tCPp7CiDjDrXoX?=
 =?us-ascii?Q?kVVxD2HiX1xKpmSc19AYj3A9PVV6EuGUhAUnsBBDK3YBJZ0twJfdAumVmdxg?=
 =?us-ascii?Q?b4ry684d2ArjY4BNmkWhbkqT9O5NnQ72GJ/dBRSle78akedL5r3cTKLwMHaM?=
 =?us-ascii?Q?kGR0lDor4s38sH5VkO6dCHzyTAZ62asUDF7miAi3j52f+QHAr7nMGJPGu0qT?=
 =?us-ascii?Q?zGDYXMkwQWlpRfpnPY05yqQ0uWwkh8sf/W/1X76bLW+wqAXviZAPlDYG5kc0?=
 =?us-ascii?Q?35JGAjmIECWQsSKjNLM/bPAoJ3yS2q9vYLJ1VXPfchoTa8KmWK1u2xWlhmy2?=
 =?us-ascii?Q?TIUGhTv9VuDrWUHYDxbToPyeRZp0k/tBqIv/HvjTuHPVwRbUocJulglBJExe?=
 =?us-ascii?Q?FpPVXhGzvenaqPhvSv55pvtlZEC2KiLI6FUhjp7eablHi3OpK6BaF13vpqHf?=
 =?us-ascii?Q?tO9CiDzfWf8UR9JWeOoJSK4ek/ygEXd+EfIIPavPzaG6QDgm86XNcVTJ7X5D?=
 =?us-ascii?Q?8YMEyEAU7ELNOyOJD50G7ILlVBLhHz8yfdEVTc40U3Nk+DrRrFCsQgTSI9Vq?=
 =?us-ascii?Q?Q1afrq6L/kvd+StVdp+syD7ZwVFQ39VcM4Tp7DGwNhtxms/WL4OOxnG9YChZ?=
 =?us-ascii?Q?M5vBWcq7hGY3ZXrMHzWpeTapjH5ubCUh5k1xw2PBdLrb0Tr2scJ+aHGoWMst?=
 =?us-ascii?Q?8rKDHJfmbRMi6ay8DzlKyAhyaW5qDbZ9c+YHqYp+Y6eZHo9LdpX/Bkd+ez0V?=
 =?us-ascii?Q?Z2QeEe9LQ4TMg9NmEqMh63OTwEygYy9cUAAkDc5zo4N5hEto9t5RQD5nb+mz?=
 =?us-ascii?Q?w3sixpq1GtOM2+bwBsir18oWn0h+rbxu5geBbis7uUpcc21wbGZ8HBxCFEYg?=
 =?us-ascii?Q?AaU5uuGP8hwX1Sm/GClPzwGzVUTBkIjhsigLPJqP1/ks2U66oF828XPr2zJx?=
 =?us-ascii?Q?ejoO6Bi+b8BD860ieQiYLFBN4W7wCXpntbaHRDkEJvESOalEb60yIiyCL7CQ?=
 =?us-ascii?Q?unsgd0KwC72GU71S9DzQO9PFx/pDxh1XTiBgtOyeyfRWW3qynPXzNl6bETwX?=
 =?us-ascii?Q?Lmg4d8BpqMfmgmDWur0Ux7YVaAW8QeniN8F1G/KxtpCgtkp0cgLiJBU8w4N2?=
 =?us-ascii?Q?TEd/J0GZRdN0ckzlAnOCXxXtKJydFqpqRtBSCFCTeN8opg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OLVje7zRxdvYw2in5pfiTSo6pOnK3AxqxvGhFHrTsyLvaG8+ph49pY0qSw1x?=
 =?us-ascii?Q?9N5oNj9khrrlr8LaE1G+LbvsJVER38nJQoC7NNvKwFCFq7s6eektJG+PvTrB?=
 =?us-ascii?Q?oE75d6w4iw7e6of4MZbpOEFSUf0f4ksHokJu6uWmsZr2nZ7dwIiuR3D8+gfy?=
 =?us-ascii?Q?qjvqTAgLMFoWO0lavI3++8aZi/Nkytp4zrvCVs/aTi3ktDn3zw3hcDC56h4I?=
 =?us-ascii?Q?x8p2llhksrxDmsaT9cNXASjg/LYhyS8OgcqclYU1Nxx84fptt62yaeFqV/3M?=
 =?us-ascii?Q?GhGfpcP+EUTxZtwhxxs8brA+Kk2pwaDIdiiftO/AGROeTE0R3TLvUp4McAOI?=
 =?us-ascii?Q?zD1DZhhyz+D0d9eSKBfvGghzqoEQAXaa6rW1sqVqcxle7pBhL2ws6hFaL/We?=
 =?us-ascii?Q?73dwB+2uKBNoBpj+v/r+R6xBFKEElg+wVY6zX2D7EwQKj7qmhUUsCXAf7gzu?=
 =?us-ascii?Q?ul2xGKfOe+c/zzYTx5JD+vt+DrroWzD4LW6nqUf6Ht1eUMNtrY5UUj96v/ve?=
 =?us-ascii?Q?1pCnYdURXGCVW06d62VibumW0Z7HszV1y21on3KKO5aOzAb29PXSQu9IFCRD?=
 =?us-ascii?Q?XnwAblfFct4n/giQhWZMHztU17BXYJce4cl0hV2TZdGlDCmFeweV1Cm+9pCZ?=
 =?us-ascii?Q?OXxIBi725hSHPJvvE1WGSO4f0fvVzpzBLkjHS8nouXvOZ00WK4IdWVKIaeJj?=
 =?us-ascii?Q?MSUF1tPli5GSCby79Nc/GhdVy8MRpn53O6k3P6VvWbltlIVLJmYEyE2eIWVL?=
 =?us-ascii?Q?8zPpkPqmQgxE7lMasqQtqfdYMgWp/lRstNzeX0pVQFhnZa3/sg+vl0MkVeIc?=
 =?us-ascii?Q?Zx7tVasmqnBOqQuGjPegiac5BdUvLv7hbxjkqMAgONHVhiJA2TTbzLr2xCkg?=
 =?us-ascii?Q?p3mM67DJ75uFchQZiI6uecbkSDYykkmSAbNzyHi0UYLBbTIkAhCHCeZo2eRL?=
 =?us-ascii?Q?ojK8Tt0pF9z2i+kXZR9O08Jm2MZnL97pgyoqe7d1KExgiFv5rQ9thufdUVjI?=
 =?us-ascii?Q?2ZESofDxbM6uUwkyEYxvKMucucbQhKaJTECv8IUzGPnDgJ2VTpcOWMYSP32i?=
 =?us-ascii?Q?CLdR45bqp/Kyr48aOb6D8DAmoGJvKrbBDF/C5dZNfqRss99noqJsAVOlPKaJ?=
 =?us-ascii?Q?mojsNPMSsnBKbjDS4e0vKoz4J7g9NNU5TtK7TrjgM6k7zcjZv0JA53do7NkT?=
 =?us-ascii?Q?XqwYmmlx4ID8M4PoWewoO1bUw8jsFBV9tqsHJ3p1gLchJ9KzIuH+ARVEhFHp?=
 =?us-ascii?Q?CLW4fyl13Ot2uPWnUo34ZSqbhtsZQKyhz416eaQD3JmSjQrHJTGQFO0OOkNY?=
 =?us-ascii?Q?r5NOoXPJtRAPQ2k7BdYW+yFgsnv0pNUmBUnQH5FYRPVBmsr8zpFYaxiRZrxa?=
 =?us-ascii?Q?hM7fjGEMDt3L/5IRkczBbdJ2d//wz6IxZxYbHYD+e7zAlepu3GrrWIb0ZDeQ?=
 =?us-ascii?Q?fAwqSWk7UdZAxpaScBqekVDrnj9DQIRgfm/i4XBI3abNf1VaFxo8TVdMM5sT?=
 =?us-ascii?Q?eLlM1NxR2L2C/Ah4PiZyCuLQPW1ZzMOA2O/DknZaQF97e+8EM5yLV/WSu45U?=
 =?us-ascii?Q?w8hCOJz29ZBQvIQVeWf/HJwmpiN2c4KgtQy3ZX5WlsFiexYYJhmIGMRCSsO+?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uo/5qguvAcLl0hZAoKG5T5TBY2Xn/mwsl+6pivLbbYUKiSIlPJ4Yp8MbC+RZxJP8oMIbFKyv0+K6Su0M9Z0Mnvnzj972odQShkpsmE7r+kgFW16W5ZMB/vstuBKy6/OWC0KzW3fqF2YaAtuXPXLAEB2+F7k8AB4C4JuvlcPow6soUCMIyYFGDGPHBmvxV2G4xVBsrC9a5cpujHzMI9aPtiXAb0rp0uRnEyeB5PUQ7vmJ7KvaGrTZI8B9QO8U7nKeeYEp/U9LqmlaMjryUsAOOR1hlF4BBVsUeg/IB/fdkyjuMPXvz6zPiKle4S2OwtbY8b7DYe0e+/E7PgAaeIEh0wkfrjCC2paetFwJbRkKn8nyb4pAD+82gCKZd2ZMs18P8v7EtxSL44mz2Kbe8N5dN/QVfrfSSMZOYGU1FCekMB/AErUAWRReERFx06xBHj1tZC9gfjC9ZGoAvFO17KTvEaglwW440ytbCjtd2WgmNrqdUa10mJmHV75E2pqnueo4ZBAdSm3gs97D1dqLBa6mmSc9MFkwkXs4Nhf0w66WbxmQhvKuJqI4qvC+NcWo+7unYJ7bGtO9KF0rJ1MWqumb1/tWjiRsNYBXSaN2iqBH2os=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9d74ee-78c9-4b53-dfc9-08dca278034c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 13:39:11.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8B6JCo+kedBSCamCjzMoz3XAbzAbDMxxL4LC1A+YaExE9gwczRGx1SjLuaGMaR8d8hzY0wpVQMKKsypz8qPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120091
X-Proofpoint-ORIG-GUID: USFZbqF0CVP64nsZcVFJ8PLIIJWQdUDs
X-Proofpoint-GUID: USFZbqF0CVP64nsZcVFJ8PLIIJWQdUDs

On Fri, Jul 12, 2024 at 03:24:23PM +0800, Gaosheng Cui wrote:
> Refactor the code in krb5_DK to return PTR_ERR when an error occurs.

My understanding of the current code is that if either
crypto_alloc_sync_skcipher() or crypto_sync_skcipher_blocksize()
fails, then krb5_DK() returns -EINVAL. At the only call site for
krb5_DK(), that return code is unconditionally discarded. Thus I
don't see that the proposed change is necessary or improves
anything.


> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2: Update IS_ERR to PTR_ERR, thanks very much!
>  net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
> index 4eb19c3a54c7..5ac8d06ab2c0 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>  		goto err_return;
>  
>  	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
> -	if (IS_ERR(cipher))
> +	if (IS_ERR(cipher)) {
> +		ret = PTR_ERR(cipher);
>  		goto err_return;
> +	}
> +
>  	blocksize = crypto_sync_skcipher_blocksize(cipher);
> -	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> +	ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
> +	if (ret)
>  		goto err_free_cipher;
>  
>  	ret = -ENOMEM;
> -- 
> 2.25.1
> 

-- 
Chuck Lever

