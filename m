Return-Path: <linux-nfs+bounces-4922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E393165F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB81F2117A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437518E752;
	Mon, 15 Jul 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CmU0VpFA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fk7VoQrr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13D433B3;
	Mon, 15 Jul 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052388; cv=fail; b=NXIqP3CY1s0z0fSoZPEfeR9KMeP/WmkiYrin1jYrLdsbscKMz4chJ5tsZCnj0dIXcMDmCUtMhZDsR/DJh1UnahzKyMdBqKnj2As6qQq5AMfNmQQkP8GM6XWvB55ekB1y5vQaGWgwlWPKqMmtDqCmmMTj9fDnoLVUeMtcrgjHuF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052388; c=relaxed/simple;
	bh=9XsVL047+Uixo5L8ti5o2gmwouL7MExckVn8cOx5z+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rwGiy6d0sDQN4p7YfyICiwVupx2WpWwAQnSHkUob8pVfcngCAzZjkNxDPkIuk5aEwo+K307E/GsENxqjSMpVJIuIsSG3F7AuOFQ8liVSxjJy7G2HmDdcJZ6act3ZAkGc30wvFxEpew7Xkpac8v1xs1DgqAr201F3UBUQmDgsvaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CmU0VpFA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fk7VoQrr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FCtUnQ006418;
	Mon, 15 Jul 2024 14:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=847ia16E14Q1PEr
	keCXVMwODeE4slE6utr+oV4CY5dg=; b=CmU0VpFAqJvWp72uHg8gSosMVe8ldeV
	yHFm8zNB/Pq55tVeVTB7HKRajiESalbB074UQEMhMbVEgg//z+NGR/V3KQ17GiQF
	nGs/Ikt0T4ue11TV1bsva+Q0ED4ah8kl3ICpo6Duk4HXUMXJatylGwI2I1Amrq8O
	EVQL4Ac7gUkUKd67NCGEKZcAoXXxffcfhiIaUWUFmqX6gyDeV+dAAS4hQuyAkw7u
	dwjyzWmPrHFne7cClRt+hBveVEWhM5IX+GtWEw4on34POqxfc0y8Alv/vVubnwBa
	ilAzQcXRSO4WAUQkyILEqQ88LoGP/0rZUFNR1N49A/Br9/icnd+2NMg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bh6sudjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:06:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDP6vv010570;
	Mon, 15 Jul 2024 14:06:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17p742-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnfT3kMxRcHWAoo9l84C3ylwhJ7Y0paQK63iCE+ZE+CGXs457hw2nJQO36wRW5Uu1ZfeIMv7Px3b5v1lS5Bb2YTlgVmHuaW2xW56ay3YCCPUhTxYVCUH2EQ9mIjoU6o/8QvVN3cace89v1edR6GaqCtCZ/8Nw9pGvvOblJfnxVlWR4t4oXXVncDTxi6JMAJllA4iv2I9o8x+ZQyNHrc/XxMgRJOeXQTMy1mwqpRWKMejtwkcQmhPUXlyoce3T029YLQA6y79Wx4fYWUfObpEJdQbLxtUZASh4Z+9/P7oz3icZL8nuBD/7wsuoraFz9IaZU4eDIFcT9T/ljMKrOdOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=847ia16E14Q1PErkeCXVMwODeE4slE6utr+oV4CY5dg=;
 b=pZGzok4D3ylno7VFWWaPmHnTOam3We9hrdopS30xBN0F1DIlgqFfvRE4IhHgmsU9sMcS8UxAk8Ntl5EgB1sdWRyA4MS9Z/dMiINHuoftxk4KEtepAaJP7ojoiWA08fgcY0Gvyke64OtCOQwj5WZ0d7hekiJh1e3WayVkyqmkH4IMKwQzsblRkWLEdkfU0ieqji57RcLujpbQnGmuJADmA9K09r78gMJP0XZ/R4zGSNUdBaBqkV6k/uCb+IYVt83fISeRMmpaAVK1FFSB9tlC079quwCMKGg7rObPCqApD5j8wvg06LLvSqzzISAvv2FVDXP03wjpb6oKmxzQZSQ/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=847ia16E14Q1PErkeCXVMwODeE4slE6utr+oV4CY5dg=;
 b=fk7VoQrr3klRMvc+zk9xU05O1OTIexuolIXfzVdZnYK+V4nzawn2+my6bFBK+UXHlCmowgIZlc8pOFjioed9AKGdXn0SjJQ6wUR2rM87/DoNkP/82ISpb+K8LRGgPboky/BlQ8jSxW4uxClvf+9kGKI1D6iNI01flTZRVid7K+I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7555.namprd10.prod.outlook.com (2603:10b6:806:378::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 14:06:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:06:10 +0000
Date: Mon, 15 Jul 2024 10:06:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Youzhong Yang <youzhong@gmail.com>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in
 nfsd_do_file_acquire
Message-ID: <ZpUsz61KzRosNNtm@tissot.1015granger.net>
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
 <172100324023.15471.746980048334211968@noble.neil.brown.name>
 <85dcb63bd31b962039269bef6e3791c82cef9ecb.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85dcb63bd31b962039269bef6e3791c82cef9ecb.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef261ed-fc43-4d8f-437c-08dca4d74781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AxlOy2iLVPu7Au3Jslhw3+xTXNyHq0wwFgV0vCkGcs879aIrPwIqRpJzA9zJ?=
 =?us-ascii?Q?9gO0PStdGZ71mqnSX7AZFsXv6/RPBJtW+QqvKcJ4vch6bfbJ0wivqtnARgSS?=
 =?us-ascii?Q?9xjqo+DuPfNBpz/cCZ9run8OQJeuKzObKwohAFIHt/9RXMBg6z7jb5ZyovOT?=
 =?us-ascii?Q?CZ8vyqzfgOCTzdQH4xFr27IFQEKg/qQi5essIou5skyVtSmps3x2RoqbLZhA?=
 =?us-ascii?Q?KQvxhs0bDdsQ5rycAihJBEeCiXTbTEVsPY4O2NctLAFjXaiBoK8Lhripqh5n?=
 =?us-ascii?Q?7u/mupStkv2gdEAiDiCfq7Q2d9KGMNINXP1z/YLIP1btUY/SxqwSRnSZZh8C?=
 =?us-ascii?Q?uBCtKp5AfYD9ZFTdzwP0xzvldsbSG90w3rhwko5dFJnLmOQEzBTEOHkq9d+q?=
 =?us-ascii?Q?dHT6+NgWXl2ZuDGVdynvzqQXkaqOkr2qW4ar+a3AYzMqJ68d9e9BcVY7dz93?=
 =?us-ascii?Q?Kggd5DrCRd47qgF9TQ5b1NMdipf5zhuHZPmhyuxxtkR7shXs/pHFj3FqZDWr?=
 =?us-ascii?Q?kzVGXcHb58Flr9g9pGuAmxgHwZ0g5M2fyLtMbPkMeBppeBBWTEm/lNCLnPch?=
 =?us-ascii?Q?wHUsNUR1CCH3R6Y+TXV3UUL+y6JEyb3c4pkOgmvDVV8PoW8j0+bq9Ug38VaZ?=
 =?us-ascii?Q?okalqWaaRScEriF+BCMnDSPdWbmT5iAc35FZhssyDxHaJU142ea71POTQb8Z?=
 =?us-ascii?Q?MgHEo4jdCwTcnopwaIBJ2VeH9kuUaXOCScEYbpXxPZRqEtVtm6+DX59v1QDI?=
 =?us-ascii?Q?O+6Ff0ibG9xXCQ6HMxI03PRYegyYKkm1HGDhUb9tc7d3vI/L97NVTDAcBa7d?=
 =?us-ascii?Q?4pwplUnxlMIzIGWn9J/aRtWg/mFOuT0wRoJwKy7HjG9Anp0nJ7rIjb2YFjvE?=
 =?us-ascii?Q?MIUULZK4WgJxvRGJo+UkRpuqhRPjYJCmebuttEcyBMgcSbF2UKaGMUolv0xm?=
 =?us-ascii?Q?A6WPX6rpIHutmVahRiVjlTVuxc9xrZTAjKXaxfnlZ0G/JE3zl0XLIsrNiLRz?=
 =?us-ascii?Q?KRG19JG4PwSqc3ulBs2l7rBdmUt7Z+X7NM8ZzuNexTK6pBs5cwsmIh7lKRt6?=
 =?us-ascii?Q?0UYVsD5tyNS20XX37hj20VvwzphtXm5wec25AgVuxboDwN8vV+PI5DYm3YEJ?=
 =?us-ascii?Q?NWxPtJy5lxTpP2cLdJQO5vVGFog5Ujy3SahWvas84oUwsjljW8kinVev1XMO?=
 =?us-ascii?Q?q5KZ9ab3viqjEnUFJmBVWYiUTFevEkzVG/d/3Oiqxf01O4DFE84ELXDTXh3I?=
 =?us-ascii?Q?e/C/CML1H8y3r+ATimt7yMu5kgiGKfrjJ/DOifDdHy1YTcSiQyIqxKxDKSAx?=
 =?us-ascii?Q?zkfUmAAxIzM6HcPdQlmfbVHyladKdv+mZND0+nkQQ7wkWg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YgS3DfhYjnXrMxgDVKHk/3FV4NJABWxcxiDcvr4MT/EgNEHRES4623mqRiNX?=
 =?us-ascii?Q?8gbXBQKNlmQu7wOG/QrRWDBbomt5OX6Xd9AdPmq4ZBGZPs5JufBDIcTW8/nq?=
 =?us-ascii?Q?pIIm1Jeyi6AncdlPLJ8MZ5IBYu/4kNJFqlbq5ZnufYvzlf39e7J2UKjzOYY6?=
 =?us-ascii?Q?KWHM5jnLJv06b0QUySoqZnnh0JY9nD0aEKr8aaEGDwwcU6A7Acn7lTSoTlfX?=
 =?us-ascii?Q?hKVIvIbNL0L9uJ0uJ1VlZ+/CSdXS5zNrHS2YfOsfAbXmcrMu+y6qQdhkoCNY?=
 =?us-ascii?Q?AJFxPBnQh/igBHSK87gShSxv2Lacd7xur2zWtHl+V6yOy7v+OfWWpp1glRP7?=
 =?us-ascii?Q?9CalpTHISeN/VDXZNNlFtD4KlRXs+hOUFXvC5T94Xn5zD+n2aiYnlf+5enl/?=
 =?us-ascii?Q?41lxRAHgag5O5FjbtgTYm9gJhmtGnFQllQ21ujzO+xAKgDaqaq6MKGt+PyOy?=
 =?us-ascii?Q?WtkoH74HB2MEUXdjf75wf1abQzvNBr2j3S3cJpriFr2oDTR+TJ1fqgheuV+a?=
 =?us-ascii?Q?hqaKF0n9BuLGil1jJS8+fro4EVQGZfQ+eOYt7VMypv5wEacmDeO9FnWjp8uc?=
 =?us-ascii?Q?zu52TNXnaZJGvKW/TzyvmYel70RXQfdGmvlYPD5cHaGQnXGIwGRgk1RhAckK?=
 =?us-ascii?Q?PXz53gSSk4OMbp4/yj3IKRTzkQ7rFFQbcJoOQD9JldYm6fB6IsX5GKVTKAWM?=
 =?us-ascii?Q?yk8Q0SeJ4YIAZ+46AaDYy0VolmHLHjUfog5nCE9EmrhFW5UcmKhFh3OlMSfb?=
 =?us-ascii?Q?Rc825iU3/enfybVi+x7Bza9Bd5Cs55ZGBglaSlSIMfq9SJUS2iU6+z3ajxh4?=
 =?us-ascii?Q?4tcs1mwYmzq/95/nqCV3o6tyNaSBz/be6OZd8spRzCVjDgVVV0xcVRXnf3C8?=
 =?us-ascii?Q?xrVtHgQl3zayb/kZ5MMznNtt7ul9XS/TL/8PZG3ha8Vb7a+VqgF8bdtKCKLF?=
 =?us-ascii?Q?JkqBYq3UBDx6YV1Jb39btwc0tyDWWcDSP76k3XmQW5HQKbakdjIeypLCoLyv?=
 =?us-ascii?Q?DSbnUkIsMw++FfQZnUOIEmtDFV4JZFk89q0b/qPVyx7A6dS7Ma22JMVqdujk?=
 =?us-ascii?Q?HAbYF1Bk3qtlBWEd9A7C/Y/RrHJz4BnrPxggkHFq8e+90Pj4QrCMVjHBH7Gi?=
 =?us-ascii?Q?RIECHFprmLQOEZSlJoZXEIsQPtzls+huweMyfm553wyIPj/05ONWvN6KJ6Ls?=
 =?us-ascii?Q?R0i3Hf2TOJ7B+19dyM+Hm6CWw5APvCv3zK0K0Qj9q8fpSuXxFlqykw3/NNOt?=
 =?us-ascii?Q?WqQ/2ftp5ZxD+4q7d+QHIjwmS7YSno1u6+cKWZ/eJB29lAheopF4Pq3HIiDb?=
 =?us-ascii?Q?8Cmk3m8q/9NOJkeaPgnYZ9U6uOFQHMqtypKJWdaBfYeNXdEytEWxbKejApVa?=
 =?us-ascii?Q?edqrkGH4xTaKiU6DV3y5CLdJs/xVd57z3CPskSEWmF1tZ1mnBNifmueRcuHo?=
 =?us-ascii?Q?UoxBU+sapLy5H5bjYriorrEvFEANmJgCnPQLzVz4TI96uHTzXe8ECBhuxs+P?=
 =?us-ascii?Q?0HLDCw5yoa9HjVT5ORNh5A0ZZG94mG6V6q500sWe5kTVvxnqFrzCooAHWRhP?=
 =?us-ascii?Q?VOgLFqq7Cy7YG76h+WDdRNniWjMVx7bFzW+JyD2x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6aa0lX36F60+/6XiYc1YnoRUGUSpsCTd5NcYLPUcFfL6i/K1mX8tvMqbyNbGEr6eyt71FY3/Sg19gSRF6CzLyoezJHm+qf36gd2ZLJZC7JWctSbxqEa49JO7lRKARIikWdfQ5BlOoxKe/0CsMv1qgoMhtaR+Jinv7Y3t0YJlVxajE6vy6cQ9Nnm008cOlJoRAafYvq2aIVrys72LD7hgWeCrHgQhsfh+PMGGO8FXOraCIrWUR+8X5SuUgptxHvxqXlmzH2U6/6DlQNGfjKw16o7tWsy1l34MMkh67panj49HqQvyv1ZChiaSqD8v3X+o1EeXmvbD49xsAqSVLR6e6T/pPltOGGX5eNhTCZTCWZ3LfVGbuvEENwzcwjy2p2LuV/LHnPHcGJItcwCC+K8sp7t//5lG/tAVH2/wYfdf0fJPGT07PTGpmdRgnmoBvW0B9y5oISlIwwSHY86LR6/Hd9O4VQI2h64BTf1V2KZIfc409/X/H4m069Ott9JFhswxgO9RDzslwPrpclZRjj8TdvRkC72a5aWsSNPpbAtOO3CRB/wjI8jFoQ8gofNMSC9wmfmHT5QSpLDlGyrS1ym+6X4CFFMMvDSXjvF+C8BUp1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef261ed-fc43-4d8f-437c-08dca4d74781
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:06:10.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4rKQutxDYM8IVlqz6E9B0q+rlVW5sA0QDAoKUmIwUe9rv/Q8FHBeVdMo/5uvKir8iHkQArumjz5idjRkoAwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150111
X-Proofpoint-GUID: 5LAkYxth0eFpmM1hQ9Oa_Jo9iMcXYh4n
X-Proofpoint-ORIG-GUID: 5LAkYxth0eFpmM1hQ9Oa_Jo9iMcXYh4n

On Mon, Jul 15, 2024 at 08:25:53AM -0400, Jeff Layton wrote:
> On Mon, 2024-07-15 at 10:27 +1000, NeilBrown wrote:
> > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > Given that we do the search and insertion while holding the i_lock, I
> > > don't think it's possible for us to get EEXIST here. Remove this case.
> > 
> > I was going to comment that as rhltable_insert() cannot return -EEXIST
> > that is an extra reason to discard the check.  But then I looked at the
> > code an I cannot convince myself that it cannot.
> > If __rhashtable_insert_fast() finds that tbl->future_tbl is not NULL it
> > calls rhashtable_insert_slow(), and that seems to fail if the key
> > already exists.  But it shouldn't for an rhltable, it should just add
> > the new item to the linked list for that key.
> > 
> > It looks like this has always been broken: adding to an rhltable during
> > a resize event can cause EEXIST....
> > 
> > Would anyone like to check my work?  I'm surprise that hasn't been
> > noticed if it is really the case.
> > 
> > 
> 
> I don't know this code well at all, but it looks correct to me:
> 
> static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>                                    struct rhash_head *obj)
> {
>         struct bucket_table *new_tbl;
>         struct bucket_table *tbl;
>         struct rhash_lock_head __rcu **bkt;
>         unsigned long flags;
>         unsigned int hash;
>         void *data;
> 
>         new_tbl = rcu_dereference(ht->tbl);
> 
>         do {
>                 tbl = new_tbl;
>                 hash = rht_head_hashfn(ht, tbl, obj, ht->p);
>                 if (rcu_access_pointer(tbl->future_tbl))
>                         /* Failure is OK */
>                         bkt = rht_bucket_var(tbl, hash);
>                 else
>                         bkt = rht_bucket_insert(ht, tbl, hash);
>                 if (bkt == NULL) {
>                         new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
>                         data = ERR_PTR(-EAGAIN);
>                 } else {
>                         flags = rht_lock(tbl, bkt);
>                         data = rhashtable_lookup_one(ht, bkt, tbl,
>                                                      hash, key, obj);
>                         new_tbl = rhashtable_insert_one(ht, bkt, tbl,
>                                                         hash, obj, data);
>                         if (PTR_ERR(new_tbl) != -EEXIST)
>                                 data = ERR_CAST(new_tbl);
> 
>                         rht_unlock(tbl, bkt, flags);
>                 }
>         } while (!IS_ERR_OR_NULL(new_tbl));
> 
>         if (PTR_ERR(data) == -EAGAIN)
>                 data = ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
>                                -EAGAIN);
> 
>         return data;
> }
> 
> I'm assuming the part we need to worry about is where
> rhashtable_insert_one returns -EEXIST.
> 
> It holds the rht_lock across the lookup and insert though. So if
> rhashtable_insert_one returns -EEXIST, then "data" must be something
> valid. In that case, "data" won't be overwritten and it will fall
> through and return the pointer to the entry already there.
> 
> That said, this logic is really convoluted, so I may have missed
> something too.

This is the issue I was concerned about after my review: it's
obvious that the rhtable API can return -EEXIST, but it's just
really hard to tell whether the rh/l/table API will ever return
-EEXIST.

As Neil says, the rhtable "hash table full" case should not happen
with rhltable. But can we prove that?

If we are not yet confident, then maybe PATCH 1/3 should replace
the "if (ret == -EEXIST)" with "WARN_ON(ret == -EEXIST)"...? It's
also possible to ask the human(s) who constructed the rhltable
code. :-)


> > > Cc: Youzhong Yang <youzhong@gmail.com>
> > > Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break error")
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > This is replacement for PATCH 1/3 in the series I sent yesterday. I
> > > think it makes sense to just eliminate this case.
> > > ---
> > >  fs/nfsd/filecache.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index f84913691b78..b9dc7c22242c 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  	if (likely(ret == 0))
> > >  		goto open_file;
> > >  
> > > -	if (ret == -EEXIST)
> > > -		goto retry;
> > >  	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
> > >  	status = nfserr_jukebox;
> > >  	goto construction_err;
> > > 
> > > ---
> > > base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> > > change-id: 20240711-nfsd-next-c9d17f66e2bd
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

