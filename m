Return-Path: <linux-nfs+bounces-4147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1731C9107A2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375321C20825
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFA8175E;
	Thu, 20 Jun 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jh1DAQXR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1sFqdXS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67714F211
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892697; cv=fail; b=UA7UTsb/KSEuI2cEPAi6s+YV0WP7gRHICBSsfyUmuigzGfhF4s4Kv4ORU08zq/i7mw1f2FSxnYVXq9zUrYGcidKnEzdat0YUZdLFDAkyekpz00KJpWuANVgPy9f9NGIYmQLZiV+E12nDG05vYi8D56nzT2LjiZ95KnRL82wawvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892697; c=relaxed/simple;
	bh=sXx+AxczsJT82ikkkojuHsW3aLpusfqQRRKODQOYJIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xxq+A9x2FykC1NZjgfwljxojQMDo7RH3oCmbBTYh+T8lX9p6OrdWjN1WgB3c7UKdD4Y6zRlRJYDZi7Inw2zqdaepF1Q/pkpwq2QlSyCVtHuvHlYhebE8gISc7idGA93BcVx3m0EJqRxZMRwf40kFG6sVffSY9jQf6p7uZV8MlXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jh1DAQXR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1sFqdXS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FUha005046;
	Thu, 20 Jun 2024 14:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8EQOIcUxOsByWyY
	iUUEW3HN3W9AEQ8lYcqGugxq9oyA=; b=jh1DAQXRK6Ug7G/4w0USSXawXCkxLsy
	HYPoP7r8rRvGHN1pS5teJK27kAeD+NrTcmMma4ibJSEahRD+gmzRC0TPqb6hzczW
	HjGPkyza1QMpaLmgBuyCaJUI0gS95pd1yfdj7CRi6pUUbh9LHqa/3qXneacYgA0T
	+co0+IufK1wOf4dRweyId+OKzxfQIkYkHPHqdKkplbFyThippPBusnbE3bmN2UfE
	lPwEL6NGDZvT7busfkQIPKjquu2TMzoY7L7qUKyPoPZDwQR9FZyZZej31rFg4mjo
	iXe3thKoZD7k9dWvUmhfdl3rmCSe4t2TmgSUKOXl9+IyxiFX/aw0sjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9ju979-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:11:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KDVLB1034471;
	Thu, 20 Jun 2024 14:11:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dh3fk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li7UARD8LLGzzUkOCDox9/VZXpm4rO/LsVQ0nTlMeT2/dJqcWGDx+BcMZLPmse91qdNaUb5uCrYCRvBdUH+0o1EyzaFJSVMPoPjgDjWgYbz26sQcW82D+TpDLCpcY2v27L8367jjRFWN3lfN3hopdHv2rtz2LaWz2RG9YMdOS5nVk4PDC62euIqty8KdPMLtYpFpJ5Ywr08rN+PJGBkgWXjN66kHRRdnmbXgmBp5ATmEmIwSkae7eFnBHIE1JCgDzA5LXX1+lsLqCjGkq1GSmKyRoEFscshzV8ldgviBzT00FrMGXz6tS/5ogvaz/iapZItWgRH9spXSbXeC6qcKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EQOIcUxOsByWyYiUUEW3HN3W9AEQ8lYcqGugxq9oyA=;
 b=g1/JL0igN7XV12FAB0HyjlRJHDZ37A23aCecSJyW2FAs5IHzs/4gbfs1nxG3w4SpHN5xGR5qxt5pNd0F4fSm6UzLzi64O7wVSgQ5zXywjy/8eGhRRvDJkTDc6dLWLZ3E8sVhyhOqZpidBMOb7CzkV99OtMPr+N2fjacz0C4aF1TtLCevBqPIffbw5SLP7P3pdsP9iEKJRs1kNHd/dfsAvFuxDGn+lgKEf5cvuUMLW6sNXi+j+9dFG8QlEAA6880+CO3vMViBubMWF6KCK/eweXIKHPdJKJyspAK/HC9ODAuF6rzOGrVrkWWZboMleIaxleHJK2Z3Oq0DwIXEne0X/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EQOIcUxOsByWyYiUUEW3HN3W9AEQ8lYcqGugxq9oyA=;
 b=f1sFqdXSKFqQoyIT/rWOOVM5OhDzgIHt7AgVh2JA2E/WNlnl2VUgxsubz1SqJI2rcNAfdwlH0TyfuWkgFbJb0e/Am1CeOrj8O5wY+CxprM+GB28k/XJ/e/L99dgsMkaich8cqVdf8LbnUrgWc9lFb7cko77IFKuuvBDPd4o8RWs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6247.namprd10.prod.outlook.com (2603:10b6:8:d1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 14:11:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:11:20 +0000
Date: Thu, 20 Jun 2024 10:11:17 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Fix backchannel reply, again
Message-ID: <ZnQ4hdpNFRijTkF1@tissot.1015granger.net>
References: <20240619135107.176384-2-cel@kernel.org>
 <A10796EF-12E0-4F35-880B-24B5346916D2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A10796EF-12E0-4F35-880B-24B5346916D2@redhat.com>
X-ClientProxiedBy: CH2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:610:58::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 08136ac9-ff61-44be-7074-08dc9132dbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oAG256uTaCip5nrxqxIcRsREQB2ZVWHCW/QYF/IVMVtqgheyH7B344jrSfA4?=
 =?us-ascii?Q?/S1Djut+YleeRmF0erxTBZ5DjwRhZvMLY0iFToF3X3p1PltFshgpLRWZ0O4Y?=
 =?us-ascii?Q?QvDml37Oct84XyOUNfofLGLT9GBe2rVOopq31VR83IN0O9wJugfgCU/grUQE?=
 =?us-ascii?Q?WU0vxk8tqWuyyt3Pg1DViLUcRM4nxI3i9c2mKrF98b7Zv1RV6xVTKx5Nurzj?=
 =?us-ascii?Q?S2OQdSVFa1Lv1NCc8nwBeYrth6MqC66Zllnnfr4Y0FewdoaB4E5jRv8m7rWg?=
 =?us-ascii?Q?b3vpmQsgOvNygSw02pHzFQ2gYwOL7dcITFIlux39jtgbd42hjUG1kx6W30QA?=
 =?us-ascii?Q?PwvcG3dhhIWc43XnbMsO5N2sBlhN5gnG9mzPFBqn+fNj+l1RzrJThAGwqVSi?=
 =?us-ascii?Q?YVQJLm/o9PkVOXIdm0KPairA0IMGOsm9ISavSvVlY1c99mgFxnD2/E51ZifF?=
 =?us-ascii?Q?mhlyCyrATTzDe68xm5GZKXd2apJxpAerAl3OkeWToTPKtXbsHGptpm413R/x?=
 =?us-ascii?Q?S7kMGaLOEwU2hI/Bils5TsNmF1q5Ggp03X9dWiLhA4Frl+CmirePIZKHrapj?=
 =?us-ascii?Q?JxjkacVl8KLtGGpUb1pOzPw7EZ0hcCFF6RXdHMlIBaaMAAnMqdzbjKHsYkjE?=
 =?us-ascii?Q?KoFfRypJSAiiz2uKT4JMWDNHLnV7yJyPYfFXARIlvQfYVVHogQPJvlguios+?=
 =?us-ascii?Q?FvCwepyNzDNh9P1AlaqtESHStyapS1pT7tSr9fGbMdCSEvOR6qnBDRkhkoQL?=
 =?us-ascii?Q?x7ZNbla7e10tQ9/P46xJDIcJ/FxTgKUnaYxJU5cZcZfRuKKaHsu+E0GuG8To?=
 =?us-ascii?Q?kSsZRrwdbNaqN8o0C0m4pe5Cmp0HhkepTJBpPT9JnZObNZsI4zmvxhlVhYlf?=
 =?us-ascii?Q?UWuhbtjw7qoyN1BqH2tlqOf/6Ou3m37aNalCYRMfeFn8MBWT70bQF99HwGsi?=
 =?us-ascii?Q?Jz+bsbw/+H7qj85t9EWcB7msqADnm32OylHFt7IlJcGkU8rsTCZBg6jN4WOr?=
 =?us-ascii?Q?wQXzc4x6FkInAY9MeoGDIUftVPPkiqynbDeoO4yaIriQGyKPQgeKs8WHiAzP?=
 =?us-ascii?Q?f74zFZo5xraZrGFt1O/XZzl+9giMF5QOmrDkYqYEm+49AmzMxIDxLpgB4aoW?=
 =?us-ascii?Q?ziDIaPQT/3lUGZKrjXmaKqaa1Ow0O2uWq/lw7DhedbCvMJHQtSxPR9BTUqGe?=
 =?us-ascii?Q?yNPKmS7wVn2mFVe85sMChXY/SOzdEiGWvKmaVzSW9ddSnkK0fMzxuW6xSJeb?=
 =?us-ascii?Q?zSupnnxViPPpyx9GLrgtNh5PkX00S0+NUKMnZM+QTsUbwVBBj2tCs0YLlhOg?=
 =?us-ascii?Q?dA+nQ1mt2Mem62oXekQ12nzy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NV3orKlfla+ciFUGTbuPHOIhdLHZs2wtHNombrJFhAUfN+7g9u6Z13C1apoH?=
 =?us-ascii?Q?ZKkzZ9/zPn5uEFRo6b0GUoheYhyXMQLqbR9YEYZDNVmY/jeHsJpCrm2BkGsU?=
 =?us-ascii?Q?vp+ekkZQzuGDS3TcaXZiYUJ1RR7f5lDGsNZK6GmtTDvd9Ecw207L57iu7Dgt?=
 =?us-ascii?Q?KUVmnfHz6VwHT5BLVwpmkx3r9sWjHduirmEae9G0V2kydzqLw7YBpnfvX1ms?=
 =?us-ascii?Q?BG36YH3uoQmEE6ADOgmZoyAIubNzcFUW9tvofd+tJ7ruhUeYF0PxdZACBmH4?=
 =?us-ascii?Q?1eJKO0s5xXdOA2rVIuEEHH/QBXd/eUMqTUyWEYyhy71eYhxEUlPHrLNdS6ZI?=
 =?us-ascii?Q?uTQCJGZGXNIL/3RXT5N8wENhFx4jC+a7fnpkNFMzeBO6oCXjlykQ0oWJvVOV?=
 =?us-ascii?Q?Dw9miLTkLkyOOxXICqeDh5Modp83TgGAo5uy97wSs8xkZ0qz5xnnmz0WjBgk?=
 =?us-ascii?Q?bK0VSRo8Rj+iM/FnfJyefZY7kM909iNszpx2p1BViFKDmulMTk9eFxjgGv7r?=
 =?us-ascii?Q?9d2V6A/m77KjK/mtHOFlEhx/1OfGYVmgpU4IX7BJw5YMj7j1lmD18U1cXKmQ?=
 =?us-ascii?Q?LXyOqzEQUF+5jtDw9YsezKQFKLUOOO3aITLm+GSQ6OmkJhfJx8oKgf1DIyaw?=
 =?us-ascii?Q?jk3RzAkqQMicsJD6PIR+ZycHDhs+PuudRkkS/+S9X3fxRoK8lVON3RCrnNIp?=
 =?us-ascii?Q?CKAYUpeq8Wf4Q4aaBeq20j72Od1Xo4HW+Oj88dYKNI2q3qRR8Ud4JV3TUQL7?=
 =?us-ascii?Q?JZy3DxMLIphnNSj5rgmf/SBRNuJIqHSCDJyKa+GLRN/tcg9clYNm4GXLTfbK?=
 =?us-ascii?Q?6fduIUk5bU4mKHeIKDpE3smd+g/DiBUSkBLrU87ljBPWShKcNmMcvZFMKup0?=
 =?us-ascii?Q?3gj/0hLRhZc2XYlIVxCFPrV39+IeqbBz60B5AfpQotXebpUPey08kvnknxZv?=
 =?us-ascii?Q?WylvCe/B98+xCS+WA54R5iC7o4w5Jd/Ag5t2iDH7UWBH6FmZa+Ol0kSgazBo?=
 =?us-ascii?Q?gJeCZ8wHhVhWJAHLzRoVtfV5I250+kIcw9AX70tP28bUbytS0/tE/F1xu0ar?=
 =?us-ascii?Q?c87Ae3jnBJd8u/7YBfT/+I5JR+bb5J878XGnsM2WN3DEEZ/ux+D9iFVE5AoB?=
 =?us-ascii?Q?PY+V9RbOD//PpbGneBmf5E9ChOZ7VzIyu7c9e8W60ktBiRwabizlVcq92dVO?=
 =?us-ascii?Q?TruGgUNH8Fm+ivCZ2P4ZkIT1I/tiXX4cdctFg7xULNUzK+tfPH8eqsNT2LDH?=
 =?us-ascii?Q?XSFZvwjzRT5CG/v9W+ifCMcpu/74/3x0Qfy0aeYwSlh1JK5OyvXhgm+5TxLs?=
 =?us-ascii?Q?AhJquDzYM0eIlxoVB8aIe37dnMoyQcn0wuGJK9f86Q1bFORmWDCSOr8uA/ZA?=
 =?us-ascii?Q?PvBQYnLplx+c0tLj623HqAaxkH2CK120fQ5LDQrSmZcIsjJfB/IHllhm4tUc?=
 =?us-ascii?Q?na4yjSdgFyynCdzP2SvNAeHTX28ny6dLHISowtu4uhUP/QxHr0e7IH8cs1Yp?=
 =?us-ascii?Q?7P2czju8ssr3r/tMKv8NcKF6lNUK0Xr92gw8YkiNLwNvN13P0PfE0kYOyV9d?=
 =?us-ascii?Q?PfNhISP6fzlsSCCqSbgwoKXLiQ3sX8VLRJS1HjsV6hhyg1NXL5Tm8K8Y0/s+?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FVUKpIXG99Ibiz1lsKEGLuPged8OGRWzr4jp5FxReT485GTp2wtFjTnQsFWxg24fmzVCqxDAFbK1o0COGdBIQGSov5qpKLjPjVAluF2hdzykgefkhw7sj92eNm/f5eG4z2LozqMIUXk0kxf3UysUhh8I4Zp9xYNJZFfTH+HTaQqAOUIr8INUhdhe0nHEspBPNoaBsHSPJWolOu6tB3uwb9TBcFlPOt5YLsHGwwW1HS2mC8oVsg/hrMxpzHZ6KQFSkshc2zBXOU5oa8lIhfPrtSCXVWPnBXbli5Xd+ICFQ3RZOWRWuE2LxzlXZioaBjhngE6Zs/l7EH4LCSBmtjeEMb/kyUqPUFqZzBwO5gSlZOMLCl/rYPBHey2//4wt1/qUupl2hi+kgMv83MOIinteLG17/uY2k/xogn2RhNnDPy51F26UGREMFjSvXUWUgekMr5hyAP86rLrhCehBs+o8CawfdZBZfsoiDLkNjlIM//ntCLQTOaVwwurocR6a6mxozPPawrNV8s5QZ5U10sxRPoZqwbbIzeyaiATJVpAZ40JVfzKSSle8CyPPm+M+4TLpURqJf7Hcl6k40R0y8QLMDUJbtNwGiTsKByd8k2qRbQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08136ac9-ff61-44be-7074-08dc9132dbd7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:11:20.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGesOa9rvvWyvVb/T/+CI8QhRXqzMRhleg8GFy520+Z1J+IgLxMAa+Cngcm2vGX/ZgNxNq19jasjrL+1UVd22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200101
X-Proofpoint-ORIG-GUID: k7zpikGjjtS-OVRDWTHXY6Kbf3Kvt5Nk
X-Proofpoint-GUID: k7zpikGjjtS-OVRDWTHXY6Kbf3Kvt5Nk

On Thu, Jun 20, 2024 at 07:41:21AM -0400, Benjamin Coddington wrote:
> On 19 Jun 2024, at 9:51, cel@kernel.org wrote:
> 
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > I still see "RPC: Could not send backchannel reply error: -110"
> > quite often, along with slow-running tests. Debugging shows that the
> > backchannel is still stumbling when it has to queue a callback reply
> > on a busy transport.
> >
> > Note that every one of these timeouts causes a connection loss by
> > virtue of the xprt_conditional_disconnect() call in that arm of
> > call_cb_transmit_status().
> >
> > I found that setting to_maxval is necessary to get the RPC timeout
> > logic to behave whenever to_exponential is not set.
> >
> > Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> That makes sense - I guess we were getting some random stack value in there?

Hi Ben-

On my systems it was always zero (which is why v1 of this patch did
not clear the other fields in @timeout before using it).

A zero to_maxval value results in the same timeout-on-sleep behavior
as you saw before 57331a59ac0d was applied.

A random non-zero value will behave correctly as long as the transport
is making forward progress, so we never noticed a problem.


> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> 
> Ben
> 
> > ---
> >  net/sunrpc/svc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 965a27806bfd..e03f14024e47 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1588,9 +1588,11 @@ void svc_process(struct svc_rqst *rqstp)
> >   */
> >  void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
> >  {
> > +	struct rpc_timeout timeout = {
> > +		.to_increment		= 0,
> > +	};
> >  	struct rpc_task *task;
> >  	int proc_error;
> > -	struct rpc_timeout timeout;
> >
> >  	/* Build the svc_rqst used by the common processing routine */
> >  	rqstp->rq_xid = req->rq_xid;
> > @@ -1643,6 +1645,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
> >  		timeout.to_initval = req->rq_xprt->timeout->to_initval;
> >  		timeout.to_retries = req->rq_xprt->timeout->to_retries;
> >  	}
> > +	timeout.to_maxval = timeout.to_initval;
> >  	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
> >  	task = rpc_run_bc_task(req, &timeout);
> >
> > -- 
> > 2.45.1
> 

-- 
Chuck Lever

