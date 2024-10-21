Return-Path: <linux-nfs+bounces-7340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480369A70BD
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 19:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6092827AA
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CA91EBA05;
	Mon, 21 Oct 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LbQUwdK7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qLTIa524"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369351F12E2
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530792; cv=fail; b=QqtrdNoNlpjUDpJPU4Ji9504XRyKNpTh95/K2+WoQwmnkCbXxzj8Jukgw42JXbzY3ML9wuS4wZX3W0Zga9qegt5K+IjEfdThPTABlpIqUnxF91OCaixWURnNSv7JYhtMyka8zZNO6k+pbzMvUl38VyQ7wirPICOiNvNJuCS0Akc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530792; c=relaxed/simple;
	bh=5+pV6+UbsuI1/IC6MdjuCa4tz4tqGTGn0uaj85f/7ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jZAKXGFkRyT/Nj7eD4DL5V67xQErKDEBK2UVmAgXUx+SyTZxhKHDSAVLEucmuhnmWqfGHJHBNKTZW+/FAWXsdw5S54vmj7g3kInRNiAD5lzZXO467MjGDUGYZYEXwpy+FPWJroxtffEXC+HR3pueK7hz9Q/fnSWE23+sgietMbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LbQUwdK7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qLTIa524; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFtdqi025175;
	Mon, 21 Oct 2024 17:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1LzK/rKzn4/5t9fHEI
	GDe0la+3U7RzaC4vbZxuk5up8=; b=LbQUwdK73xgGXLk3XjRAi0PX0Jv0F1n+5L
	pT1mI2J/mHd+2vV76NJFIDiEzQr8bHSvn/aXIoF8OTufG950bIFWiCQniAAqtVWx
	Qjf8SQPzAR+JZ3/5AI4b1EUC01Hvu6hHUZtZfAv/8oPcf0UIaD/aySngI6lPWf1c
	VYlaBtwQjZ+AfpHIPqyW//p5JA0Z775zmWng1chzwxSN404t1myErSthNEuYsBs7
	By4vxtJah3FjJ+ZbMGnO6NLyM2gfcDwaw6bNg1EnqQrERM8FDFgJtmUjByf+/4he
	fIMjUe2E3375swG7c16YuBGYuucud8Kur96V0XaHs4SGKcINAIIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqtynd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:12:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGsSVK026236;
	Mon, 21 Oct 2024 17:12:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376kya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQtOOQwcvOlYfHoWNtgEmPHcd9zhY0hbhEj0tpIJAH0hGUWxerZmW4Z0hRJ0qUeDEiEGuX3cCqh4TzWcJKRPXdNeEl91wN9bqQ0Wb+qVLjB5Pse8vD3gYk4vnjVibvOfzkwln0YeQttGrldDIzGQN93hikKg1rMzSBZkPgszUvYXMDi4sjI0UqGwtqrEq0bQtgeIyy4Tc6jcsbutAtsHkdU7u38g51WWmXRMqIE6zjDHQWSl3vRLDl1PWyvbrKhmlwiPsusRwXY0J3tMbo8s3ZTwwGgT5sTYOKSCDtQIw/3yCiYQBQjPhCKHGAIC0gdnWBxPzwnM1wNDfnsahVJe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LzK/rKzn4/5t9fHEIGDe0la+3U7RzaC4vbZxuk5up8=;
 b=EfLC4rWKowbxY3jVWmbD/q5J1v93G1k/N/KrSg4VXl9BO4w+UkcNVmab+eXBsbt5pYphaGP9KRceGRBUbHSXZH15vhu8Njjfy00HdfZSHccFsLSYvDLDyqDL3FCN+EQwLUO9HzWfE/eN0ljMhvOyMH/NoXSGFO6nNzwDCyX3C8cDCP0kcjiHjkooDjlhaYerd/TR34BL6rNxnfnGfUMJetTvhpxCvsjoZ39YxqEanisoXFOi8G75BAX2CUxH+f6q6tzyGEllutrHOIG/fkuSl2LIoVhhWpsHE0NapHO2eTEcXwrXk4TaSj+BIX6CXf5XasvhTZg1apHOLVFLme4+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LzK/rKzn4/5t9fHEIGDe0la+3U7RzaC4vbZxuk5up8=;
 b=qLTIa524zCpnrwsgv69oT6pInOcLOXPkiZ3rMb32rJfGDJIIIxJfoF9aRxPhXLO3jyDcrkudPGqCW+yHTsh4zaT2CX3ZGOjR5OX7mrJ3Zflg7YvHz7to/tqZDkptur/TbGcFostn/8bLTQlnLuRJ2qGmkSnNAljvbkBWPPmjDHc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 17:12:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:12:44 +0000
Date: Mon, 21 Oct 2024 13:12:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH 3/3] nfsd: release svc_expkey/svc_export with rcu_work
Message-ID: <ZxaLhaEpa49lsvhw@tissot.1015granger.net>
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
 <20241021142343.3857891-4-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021142343.3857891-4-yangerkun@huaweicloud.com>
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 539aa64c-9701-4f2e-71f4-08dcf1f39439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dN5OmceNKy+CEFOrpUpEcVvwywsQacExGhMwL/VOrt//8+fzzQpEyvk3K/wP?=
 =?us-ascii?Q?y00hwUL/HRTRV1kd2I6yw5QyI6sRdQ4rB7F4AsXzAXc6b8SjaZ+yVbRI/Eo7?=
 =?us-ascii?Q?cgHlCGDC4PjiIkPQQ5SE7N+5rrJoWfrZojJVt/wnwsk/tuRP3jhqz+/Qns4n?=
 =?us-ascii?Q?CZv1EajNs8EtpzULpB/Y+3EAVIaZdnjO++Qz7ittUxn8asfn+L4d1lGy1bc5?=
 =?us-ascii?Q?/pj6lOih7isjbJOBvwVndf3ZPD0ePiOkD+X3MsSttR1rCBVkMUVErpI/aAUG?=
 =?us-ascii?Q?0pNapZi073gMOIUwAL3zrnHz203hDuII5mpsu0S/WfAJQDVCuPE3yMYPE9Ts?=
 =?us-ascii?Q?CYFfLJtbzdzYEDLn/lMK5UarKvxHlqidhlDcVpJvAGtWkD1NH3bn9hXqFpbH?=
 =?us-ascii?Q?QGYCwx/4FHka23EVIBmY2mfb61ZKLfmpL0SF+I/Tzk6JUzvYAS6rp7gHeRQI?=
 =?us-ascii?Q?dVfLv2NP/yVB5MkH7okK4fFhXnZGR1OT72n3oBrACK2yGNp3/XurJVAbLwfx?=
 =?us-ascii?Q?s0UXz7DbtitLsIAlGwXCHEFRNxZJpwn/Ly5KMCaandSSu24N1/GfqBsLxj70?=
 =?us-ascii?Q?nQ/h5JwmoUDdowC4zEqS0c6vI7n19PsYv/s4Osywg/loXrudLBD9NRdCR4MM?=
 =?us-ascii?Q?ISQU6HesV13hLXP0znU2Ab+Tisp3Zdqxh8s+zZSiRvTglkrhGllONHdrnQ/7?=
 =?us-ascii?Q?C7VksFcCwhMwVJ/c+jAIZTz3ppmuGdwXs1H5RjgOfjeP/idB5QQ0CgAiW/AJ?=
 =?us-ascii?Q?FeTmDCEj7UY8I66tJ+7N35c1FgOqqQikaB7scgUk0UjCgsq+xuetyeD/GWwe?=
 =?us-ascii?Q?sPmZhpDa9e6qpiyYLuXV6UT9aleOsYUe03HFuoHGmUSg8ACw8JRHShRkFVgH?=
 =?us-ascii?Q?P7yaY8d1U5B2PtrFr4Oj/AKm4ZzeTicoU8Wv96UdDlJIf9UFJRZ7HstdU1ZZ?=
 =?us-ascii?Q?Lgd1PlTZKiLGIqPjHSa/DyMo+ulmdeE3e6kyzN5VkK9Xgbiev8mtKO36GQf3?=
 =?us-ascii?Q?+HcyPI0eL9vOE312BPydapTGrvOPiDbF/nv7K+kSTLAYoUoE0kX0y1WCHWiH?=
 =?us-ascii?Q?zbzDa9ViCTwlS5C6ftKdpexWfQEgtRjeG9Hjb5b7a1/vKkfKK6mmA1d85oxQ?=
 =?us-ascii?Q?Il/FhtHe25l2vJ+aQ9ocH0L5C1CX05C605PPjt0Y723Zci5vQxubtkACxJl4?=
 =?us-ascii?Q?wmhLczbQNRjfusSM8GsS5Ww/NQOrrug/JL3hBLrYkY/kdmA8/8cjCKVhzgoU?=
 =?us-ascii?Q?Q6lWKX3ogta6qMj29rqj7ds4sGlTKJbEx1voNF4kfJjc86B1pOuFr0FYI0MQ?=
 =?us-ascii?Q?xOoIK1M2Ka3jDsUYjMY3JYKw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2oNvaNgFAsMoqkuciCEsKtAWZybDBoXOXU+bca7Ib0PBXayGPoPjaVE29M7V?=
 =?us-ascii?Q?SReGTnIKYrESHXQ3856ofIUhZa59EFEEsqIq1jAe42YqeifIKwqQ76Hkx9bh?=
 =?us-ascii?Q?QH+oVZD/3q7Vp9wXDX02wMjEZ2z+20Fr9HhsLKzMojOG8jUg2lJNeTor4EoK?=
 =?us-ascii?Q?YiZNk7Gtf1SWqVJon2z8fsD5QS05ylHWX+vvooBiKWBcPGM1KWzHhIVNOF6z?=
 =?us-ascii?Q?rkoTBOAKRC9FfQVlWkI6eT/Tq5zTyIQ5jXPrBY3qoTivVcSk/EOWfcHRhQfI?=
 =?us-ascii?Q?DMGah2Yxwljr1fO/OHKTbNOeTn8YQlX4YthXmxaVl95k5r+ZVZ9BnnsUPNyT?=
 =?us-ascii?Q?thvHK9ZxPeO00coE0jOVd0zqUc7mJ7gtR3I7V1b7+x2Bfpm/Ud9K+7A6yEOr?=
 =?us-ascii?Q?GL5xP5496irrNm4RX/1NsVredqMTQ+UBolqS94m6CP+yxaNdw2D1evSlBfrH?=
 =?us-ascii?Q?gdVxRPNC++vJsnsQ3U+IEaABHVI00062nrK3i9s0D9CcvsWRwqHZw5pjgymf?=
 =?us-ascii?Q?FyCC0QuZ+ZjCkoTotGnHHq1AppaQkFQPJUtntZNtBd6M4OimpmpMB97V4jgD?=
 =?us-ascii?Q?if/Y+PHBUC0CzlJJWK0laa9sviEB2cEV9onIQR/zgVZMU/dzHoeWW4nzaGsy?=
 =?us-ascii?Q?5GGGJv5DywnyiIUAZpAn0asDI+o/ZXxo0Zmyi0SPy+QUckPr5D+8UCB3IDQj?=
 =?us-ascii?Q?UYE3VRso8RVmyYJRiFJgRo/hHLIonVl/eHINbGZejClELTx9hML7mLDTYKYv?=
 =?us-ascii?Q?X+tdcnGSWBAVqShUkdkfeb7/lTVw/eKkfMqsCi4tRCNnN89kB3U8dEKsfAER?=
 =?us-ascii?Q?3EAuVhUlj/dVkd7027Ya78yOq2qV/fOeoStDzDQ6EIkSqwmlEp9DKCSwRFk8?=
 =?us-ascii?Q?O6jVKtfQ+/+fsgcURUgvSUyoweBd7c7M62HmviJsfKnBofpyMqlBVWD5dhov?=
 =?us-ascii?Q?YoPRTdEVVs0pB0p9X1Etf383F6pSTD7m3NPIewx3Cchqa9sAHWI8DbJS8Dy/?=
 =?us-ascii?Q?LQcVVLNakkQCw67vdDt1qgee5a7bDAn0J519QatAHL9IyOQekOo3nStOlxmO?=
 =?us-ascii?Q?Nb+4F6Z58SpKIM1Mc/HUAp6ais08Md9pV5AutjRCycfcHUn9s95okMcq9yK+?=
 =?us-ascii?Q?6g+RmFm/+CyLowxOpu5k0r0MbRctk0HDVwFjsx0C3MEB1+BDCaa1EJ1gJLYt?=
 =?us-ascii?Q?y3m0HDHdTwd7IK+NT1NPYiRqGI7k10QA0G8OVONLYCPQ0Q3J147iONCRIT7G?=
 =?us-ascii?Q?nwae+4PXmjWpXifvUWUrlWqua5yackw0j5Tykn67elU95+Arb6WQh5ShyBNU?=
 =?us-ascii?Q?wfprbZ+qxubo+KQXrMsV02nyNUepmvSyBb66rdK4c7A0HUaRSJ+uvfpT4Pom?=
 =?us-ascii?Q?EOEpiwPWwaQpBtApsmKK3MCU54wVYtk8fUY8ep5kRw60EpvVHBCeQ+rAnlya?=
 =?us-ascii?Q?sZE80Pp3AqKM5Tm3xJwElTeSXZue1dNx9r82hQAF0HEhDf7+5ObsLLFMr5Ji?=
 =?us-ascii?Q?63/dmTaqwmoOXcVZJWDW0PuWlWNPGff0jAoyEU5iGjXb+cHEZ5vZ7DpOfYKM?=
 =?us-ascii?Q?Uiw/qyNAHyPF0/B7pEUOKUc6CyvaHnawarqRC3wfqy8Zj8OEk6jhWEENAZRX?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kVB1AM7F3soXDsz82cxOUsVbLbs9Q3COta+udNNRMTEar+7dxtZQtVM/OrLKBIRhb/btJ0hD4ofUlOzT3qFIET2Ch9pRmA/uruPOyu6/My7LccVkQSQ3VBfWXIvhRLC8InNr4TAz6gGM0TYmvM4PY6ZlETQUHWWNbWgFvKLZLX7zCZnJ/1rbz4PmlD7PqXykLGS0994LgI8tcczdW8D8rqxGcFkCXodC/mf95Fg+SC3A+8Vtw1wo2bWutmDHcmI4zYWEQhxuHewAgLe6QyJc611rrNakNWaCQ5KFrRo4bn+eZcD6amgFRHevsJUZ6M80xICfj0RAwPA/nHjVwo3kY/v+6sSZyD8YoVLPS2auVYCDaFn4MfQSGzBls8h2SVzdvBrPjbvFaRO2jdETDAUzHD5AyPbBWDfG8J2CziBnT+jPYWq1d1z3ycpOgx7BVyDN9+L0tRl+zwaLu6tfQEDZej17VtMh4VHDGNZyScFMG86VlXvnXFBHqf+QJHrt69p7D3cPuUDi91CZHnfRvva63n0cbQ3dlPvmJ+7K+rfaAX6gqtqqY74CkDg3WCHOWgIAKJ9rVMon4F7b7PyEQvTmMOVH6E8AM0BnmzU5L18aFX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539aa64c-9701-4f2e-71f4-08dcf1f39439
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:12:44.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEuLekvVzmvjItneamhZs+W/1w6Z8FY/IRTnLCKC8VNcl606Lgn8IEb/5wEVnnbqsx1fNm1ezvb5TnYgafwOBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210123
X-Proofpoint-GUID: vSe5xsVNRI0RrXGxy_MLcWpE7RECW6bL
X-Proofpoint-ORIG-GUID: vSe5xsVNRI0RrXGxy_MLcWpE7RECW6bL

On Mon, Oct 21, 2024 at 10:23:43PM +0800, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> The last reference for `cache_head` can be reduced to zero in `c_show`
> and `e_show`(using `rcu_read_lock` and `rcu_read_unlock`). Consequently,
> `svc_export_put` and `expkey_put` will be invoked, leading to two
> issues:
> 
> 1. The `svc_export_put` will directly free ex_uuid. However,
>    `e_show`/`c_show` will access `ex_uuid` after `cache_put`, which can
>    trigger a use-after-free issue, shown below.
> 
>    ==================================================================
>    BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
>    Read of size 1 at addr ff11000010fdc120 by task cat/870
> 
>    CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    1.16.1-2.fc37 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x53/0x70
>     print_address_description.constprop.0+0x2c/0x3a0
>     print_report+0xb9/0x280
>     kasan_report+0xae/0xe0
>     svc_export_show+0x362/0x430 [nfsd]
>     c_show+0x161/0x390 [sunrpc]
>     seq_read_iter+0x589/0x770
>     seq_read+0x1e5/0x270
>     proc_reg_read+0xe1/0x140
>     vfs_read+0x125/0x530
>     ksys_read+0xc1/0x160
>     do_syscall_64+0x5f/0x170
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    Allocated by task 830:
>     kasan_save_stack+0x20/0x40
>     kasan_save_track+0x14/0x30
>     __kasan_kmalloc+0x8f/0xa0
>     __kmalloc_node_track_caller_noprof+0x1bc/0x400
>     kmemdup_noprof+0x22/0x50
>     svc_export_parse+0x8a9/0xb80 [nfsd]
>     cache_do_downcall+0x71/0xa0 [sunrpc]
>     cache_write_procfs+0x8e/0xd0 [sunrpc]
>     proc_reg_write+0xe1/0x140
>     vfs_write+0x1a5/0x6d0
>     ksys_write+0xc1/0x160
>     do_syscall_64+0x5f/0x170
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    Freed by task 868:
>     kasan_save_stack+0x20/0x40
>     kasan_save_track+0x14/0x30
>     kasan_save_free_info+0x3b/0x60
>     __kasan_slab_free+0x37/0x50
>     kfree+0xf3/0x3e0
>     svc_export_put+0x87/0xb0 [nfsd]
>     cache_purge+0x17f/0x1f0 [sunrpc]
>     nfsd_destroy_serv+0x226/0x2d0 [nfsd]
>     nfsd_svc+0x125/0x1e0 [nfsd]
>     write_threads+0x16a/0x2a0 [nfsd]
>     nfsctl_transaction_write+0x74/0xa0 [nfsd]
>     vfs_write+0x1a5/0x6d0
>     ksys_write+0xc1/0x160
>     do_syscall_64+0x5f/0x170
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 2. We cannot sleep while using `rcu_read_lock`/`rcu_read_unlock`.
>    However, `svc_export_put`/`expkey_put` will call path_put, which
>    subsequently triggers a sleeping operation due to the following
>    `dput`.
> 
>    =============================
>    WARNING: suspicious RCU usage
>    5.10.0-dirty #141 Not tainted
>    -----------------------------
>    ...
>    Call Trace:
>    dump_stack+0x9a/0xd0
>    ___might_sleep+0x231/0x240
>    dput+0x39/0x600
>    path_put+0x1b/0x30
>    svc_export_put+0x17/0x80
>    e_show+0x1c9/0x200
>    seq_read_iter+0x63f/0x7c0
>    seq_read+0x226/0x2d0
>    vfs_read+0x113/0x2c0
>    ksys_read+0xc9/0x170
>    do_syscall_64+0x33/0x40
>    entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Fix these issues by using `rcu_work` to help release
> `svc_expkey`/`svc_export`. This approach allows for an asynchronous
> context to invoke `path_put` and also facilitates the freeing of
> `uuid/exp/key` after an RCU grace period.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I'd go with:

Fixes: 9ceddd9da134 ("knfsd: Allow lockless lookups of the exports")

I plan to apply these three to nfsd-next (for v6.13).


> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfsd/export.c | 31 +++++++++++++++++++++++++------
>  fs/nfsd/export.h |  4 ++--
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 49aede376d86..6d0455973d64 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -40,15 +40,24 @@
>  #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
>  #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
>  
> -static void expkey_put(struct kref *ref)
> +static void expkey_put_work(struct work_struct *work)
>  {
> -	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
> +	struct svc_expkey *key =
> +		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
>  
>  	if (test_bit(CACHE_VALID, &key->h.flags) &&
>  	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>  		path_put(&key->ek_path);
>  	auth_domain_put(key->ek_client);
> -	kfree_rcu(key, ek_rcu);
> +	kfree(key);
> +}
> +
> +static void expkey_put(struct kref *ref)
> +{
> +	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
> +
> +	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
> +	queue_rcu_work(system_wq, &key->ek_rcu_work);
>  }
>  
>  static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
> @@ -355,16 +364,26 @@ static void export_stats_destroy(struct export_stats *stats)
>  					    EXP_STATS_COUNTERS_NUM);
>  }
>  
> -static void svc_export_put(struct kref *ref)
> +static void svc_export_put_work(struct work_struct *work)
>  {
> -	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
> +	struct svc_export *exp =
> +		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
> +
>  	path_put(&exp->ex_path);
>  	auth_domain_put(exp->ex_client);
>  	nfsd4_fslocs_free(&exp->ex_fslocs);
>  	export_stats_destroy(exp->ex_stats);
>  	kfree(exp->ex_stats);
>  	kfree(exp->ex_uuid);
> -	kfree_rcu(exp, ex_rcu);
> +	kfree(exp);
> +}
> +
> +static void svc_export_put(struct kref *ref)
> +{
> +	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
> +
> +	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
> +	queue_rcu_work(system_wq, &exp->ex_rcu_work);
>  }
>  
>  static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index 3794ae253a70..081afb68681e 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -75,7 +75,7 @@ struct svc_export {
>  	u32			ex_layout_types;
>  	struct nfsd4_deviceid_map *ex_devid_map;
>  	struct cache_detail	*cd;
> -	struct rcu_head		ex_rcu;
> +	struct rcu_work		ex_rcu_work;
>  	unsigned long		ex_xprtsec_modes;
>  	struct export_stats	*ex_stats;
>  };
> @@ -92,7 +92,7 @@ struct svc_expkey {
>  	u32			ek_fsid[6];
>  
>  	struct path		ek_path;
> -	struct rcu_head		ek_rcu;
> +	struct rcu_work		ek_rcu_work;
>  };
>  
>  #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
> -- 
> 2.39.2
> 

-- 
Chuck Lever

