Return-Path: <linux-nfs+bounces-5632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247A95D3AC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638351C20E78
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2DA18A6C7;
	Fri, 23 Aug 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASfwDdNv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HwTz1WMI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBB187FFC;
	Fri, 23 Aug 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431257; cv=fail; b=lsHEe1o7t4O6FdTEy/iOqN4HaCYZSomRAL+2f1+CFAXxBqILmAIevr3CZHv5s7Es0MyvokXdM1oSSRUEls8FUf6o8IzvtZPwXh7uezWYIUns8bprwDpqEHCaxFu0oSv7GBQFsDMu18rEd2zVcMgzYZJxc0nZ5+5Vd81VjarX6sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431257; c=relaxed/simple;
	bh=loVEZJBMwWST2EN2EPrdKWAl/KqZ8iKx6mpC5slO7H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tArk21QcyMJUzYYeWY5JBYD0W4vJMwkoEVvKUJrJ0npJkuIBRWpClpFdA34DYuVICH7WyJcVXiJMa8yGkBNbkqF7h+wOVdUdVLoAROMocB25A+fJC8qsnMhHYllGpfmztzGjOQMJQeDYybFsNG5W1Y6ggig/z8+MDn0cAVlLkbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASfwDdNv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HwTz1WMI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NFMUej010015;
	Fri, 23 Aug 2024 16:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zln5S3CQyabH7ev
	vEg5Z/zjZEPcvLGFY+XiPjAIuEq8=; b=ASfwDdNviSUMaunTBSf7eYyORcbwxSA
	gHUvFGOyJ1fWYXBkzgifArpVtf8rnDNAMqprg7F6HPBMZQGeCrbHL6KxOJ/CrVFq
	8g3UQSja47BzJdnuAgVSmhs1fzJQjFXKNciHBZiNOCDQCXUpWiVFxNDH6+tY8P9S
	D6T8xEXcTorbVFc3jK98PiJmTtT7by0LSgmwmLiI2/HcDGIubexmwZL81Pgx5Qdi
	ejVo+PZ8mjy4SUnqmDukqUyzGbQ5z18iKpvb5m1vzW0LeyNAFKC0BNlnQ2XS5PbW
	3cHDpkuq3Xa66/rZ1DSsz9Bnl8smX+BdLw9DhKXfD+0+Z0i9DwTRH+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67mm6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 16:40:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NFT7o3011111;
	Fri, 23 Aug 2024 16:39:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416w3wtu2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 16:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smbw+zC2VzzML/0bO92WqTB5A4k6pbmtvEFhkHjqfYo53i/FFhnumuC8bTau9V0BYr74zJ4TjkkeQQ7y6KtcuCjZqrkUFZxC7S47JroN0HUMmvFBtolHjUgHlEtHloUMEf/dIz2pMd4D/6xfEFzVNh94C805tGwKH0lPUAqFxblusW+l3iFxBoWxRp//fFEcXD5wqOz6fqrZG0Ian4+m/JDuZHN8F93EvM1wIABf8oSWTI0qonOqDwZYtK9M+myMRXnSxrjoQHF0W0ceYsv9t4mezWgIs1ViDu2wkIQ+vR+yK+CuAnjgRKjpAlNKhiv39jcUJxQekDCcf58Wb9O1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zln5S3CQyabH7evvEg5Z/zjZEPcvLGFY+XiPjAIuEq8=;
 b=NqQT1aK0t8O6eckz6Q6poH28e1QnW4WZHQVhsHz3yL/RF0ElpQasXFY9RncbKLpAc7zo9hafmxabUn/t5m/be2Np66zuNtd1FlYBARR0or/VHgWQIUspwt/2w17Wp8U2zBCdJv2nb+uIXgSo8Kx4tbSRwCEdnQhQ8sSi2j8ROD/WSmEo15zJ23rel1dhzlu2eCuB4qfLfGhkDSpgPKSlMwHXvSZV/uGJhneN//9cFCbQTlix7qOwGl79XPdc4LJ2otCbIQtVcbi/KFriyquad48APcj2w0En35JtT0UmmOha9v66P5+alT3QokbNeQhkOGDIJZL7TPlp+02ERmh68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zln5S3CQyabH7evvEg5Z/zjZEPcvLGFY+XiPjAIuEq8=;
 b=HwTz1WMIxwsMXH/ehYh47zSXP91Ir5kY57HRedNmGRnbfF9yiqfiCwMs0+ZjfErCDLzaWYqBVW776FzFCFZuhCzgOhNR7UAa8FKAwC0Fu5L61at85N6wCVskeV+pEEA+FFRT9q/I3sEwFBqbRuHN+7mzxAWa+KQOhZBXeoMZzSw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4993.namprd10.prod.outlook.com (2603:10b6:208:334::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:39:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 16:39:40 +0000
Date: Fri, 23 Aug 2024 12:39:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH 4/4] nfsd: remove unused parameter of
 nfsd_file_mark_find_or_create
Message-ID: <Zsi7SdpLsqtIUkx9@tissot.1015granger.net>
References: <20240823070049.3499625-1-lilingfeng3@huawei.com>
 <20240823070049.3499625-5-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070049.3499625-5-lilingfeng3@huawei.com>
X-ClientProxiedBy: CH2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:610:53::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d3b69d-67eb-4240-0ec5-08dcc3922f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m57kjKH5o+KjGCe9dF8Hd3UsIWDv8+H73hA9s3tLbbZlW4EeQDhWzAommlXr?=
 =?us-ascii?Q?jUYUIBgnXJOn9TJjJKVXlewqTst08nz8Wo42S/7bT5h4uFnENxJAr3WzlgKo?=
 =?us-ascii?Q?umc+h3+5pYeI2yKoGeRtrR1h0Y4jm2jiPVOT1EQIUJhV/b6056hCdiXX3752?=
 =?us-ascii?Q?10MGFcxBkcHqR+fOs5iYbNs3Qm6IqfWqtStyGs6D1lJ3mBmiV1AC0MSinfQ6?=
 =?us-ascii?Q?LUfAC4wKbTYWmKfD8ogTxleD3KTpbj7KGwBLFP7xfzAzrsE5KgPez4tBfjZY?=
 =?us-ascii?Q?y23euKSd9g9DNWcDyImHlrgDx/Q6N8xHJ0CbI5lCeO34DRSbtVomHHei8sX+?=
 =?us-ascii?Q?mhKMkUBhn/tyrhN4WZrLb81JObOV1ooE0ac3t85bV8SKoCf05p5XhlO2mJmB?=
 =?us-ascii?Q?vXCxJzQx3exmNSqrGrvUerZN/Dny9AJxje8umixPgyFC9q573whMuSfNvBvW?=
 =?us-ascii?Q?gGFdnuxxkZUcqd1LRrYsr0Uz1u/FjVng9rPaanF91vx1NAQms8ghoI2ePML+?=
 =?us-ascii?Q?yIde1CQe7VZ3ZSD4QTjqgneWLvgCPsE8golqqVfVbtt/ykSn1l9Y1SrKWMPW?=
 =?us-ascii?Q?yN2spfQwGlkBSH48P1WhfjB6p1dlCyxokQJ9VSeqJaJJLL3YweSIqdWKFoVN?=
 =?us-ascii?Q?ifqQmpGjErqJSXYmnmVxKuJ83BrjwprlIftghM2MKmpMFF6wnz1e94CcUE8Q?=
 =?us-ascii?Q?R1QUjDXJdJWTL2fF/pj3ZYCbBCSafyRHHRE+jZ5522FfDkvS26jcyTzIlJ43?=
 =?us-ascii?Q?pUgfDDyLyweGzzTJ5Mz1E/vL9UCFO0Ce5uyG65rqmBygYojHS8r42wTNXjRr?=
 =?us-ascii?Q?qwgqYGZpEL2ryosTWBHuTepAHOXroMtwd5Gp8kVgdjQSsSaUzLZOYJez7lKd?=
 =?us-ascii?Q?2XLrzgC/M3FoZGO+t8ipnHpuBf6LNhN48fRUwBwe+rtLP1zQ+pXyGRCQr1E0?=
 =?us-ascii?Q?uFuyZ5oD+a9lpL2yDr0xlfz8a4tm/LjDmsZrglRhGNOkr3+Aq2kaftpbq1J6?=
 =?us-ascii?Q?gKrT7b2FTjneJu6UyASNc3l3G4S69MHml9VxVJxVCgYzYCk7e5tIx9BKWsGo?=
 =?us-ascii?Q?2lq7B5i5DVmefsW9sOu6xEng539SEEt0ahAfNUfK3a/chNMm6auRq8vTNXr4?=
 =?us-ascii?Q?pzwWl3FZKuOVLKy4kPBPZb+Dx9urrfJzGzuwQ99T/8UWowhKUGp6VnZ4UnJH?=
 =?us-ascii?Q?0dfxeOlJoqd3fON6qRcYvaMKMvRdFpRXqXH1RkKB1vJRTKdsqEQXBWV3cM4N?=
 =?us-ascii?Q?grSDoM6qp2E3xmFNZwFRAhdCk2YeCbH0esMIX3ACYY2C3x3B205SAQernFTJ?=
 =?us-ascii?Q?vs4nYAy9ksJ6Mr/KRXmV5mASAxIOs7Cj6ExR7TC7wycBkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sstMqZcmqegAo5gWna4LBfOe0XjO5U5+jJ/pwsN41H7GPKB8uBlvtO4gkmUJ?=
 =?us-ascii?Q?0jL3g85tjD+AXekQA4FygQ01WBJam29LL3pTxp9kPu+n5pWkGGfXIlIZF1SZ?=
 =?us-ascii?Q?iqqTucOp5T/dNpDVAlhHchDpSkMGSvk56hnRSdOywwQhyR7KB3qS+n5d2SdM?=
 =?us-ascii?Q?rJTrbjW0f10hSRsqnMRSfWj9iGaDeVGVZDPEw+hYZehWDfHo+tEiZcNTfWXn?=
 =?us-ascii?Q?chbwKDeTNR5Eyg+6ecBg16D5/55KOALu/0PTlYtc9skhR2p1tJGwUZ1pUOub?=
 =?us-ascii?Q?oJm/m8MAowScRpE1/shu7+wGxHB9iQqjh6bXnAaZz/Z6FtFzGSOmATLXocEN?=
 =?us-ascii?Q?0QW23T8UUq+lPYBPBMZ6G1AfcT2j14sZhKmQWBmJaGxY3VDzKLZpO6+8+zky?=
 =?us-ascii?Q?uxZVtHiIUz1kJ6BCWA6xp7BBjvi6KkChMH5kQuQAQWNYc4zfyu609688DBpD?=
 =?us-ascii?Q?slQXAN0pmwr3DYiyNNfwjbPDph5oKUCt3SCJwHUCQ4/maiuuRZ1Me6xS0+AO?=
 =?us-ascii?Q?QlExsEhG8eisu7ypOskAf9ErSJ/ODMiDZFM0axtnmGZ+fr1WanOYZMMDQ7ym?=
 =?us-ascii?Q?ndiK1olIIUp/1wb0VT0AsPpsgff7YZEbMbOeRvJn86y77guthbkVrbVFhs7X?=
 =?us-ascii?Q?EfNAxPtRKpvKnf2FoBxCf7QngzStUtGTPy/Eo6IgsrK6dIqgci08HY3Ywb4o?=
 =?us-ascii?Q?Kkx3tfnoF7qN0GTgvA+MMD0mv0lJJlFd9LCHiG1Uemk+3xxXuVaS+WX3Pz35?=
 =?us-ascii?Q?QPuJ1b6OI0s/bBI82ZHbYisAH1ITlsuX+8JPNkm68a9KA1zMqUDZPp+46Jos?=
 =?us-ascii?Q?SVaq1YXoe25U/5jla8moUgwnhyVh96ognf4Ai78PFER1gWT3qXWAd+Ixlg8+?=
 =?us-ascii?Q?eWtr61EeUSinpm9ocusgowA8erZKz1LDs4c8EYn9SmykTudcNleZPO8FLWgU?=
 =?us-ascii?Q?fQbFlBvXXvrIihK8zuo5Ggotkvc/xHTp+W0+81gzAUi54OQGoCi69W6pF/zq?=
 =?us-ascii?Q?IjA/gybpMHUYZ4lqsb79e/4YgjdjRkN9dvQwIXQcoWhZgV48i6iU+idNj8hq?=
 =?us-ascii?Q?KeqKLsl5TL7ZY3CvCTU8riMRl5FGm2B7JOzwGhrFL6LkTZUdbO20xGHtaKsZ?=
 =?us-ascii?Q?evZG8T6Vo99otPih+SFo7L2NvaDlR6BwBEecWOB8k8yFXMyqt5cBD0yK63aW?=
 =?us-ascii?Q?6Yi8+41XdevJzHvifPriyFqUNmPdXTXKWhlDN8XQV6vg8SLqXrTVitj3yXjp?=
 =?us-ascii?Q?g0yKA/hMt8vJVOTZd4T3ctTaVUBucHTn3YV13tOEGdrO/73SUVm85uNwhGXJ?=
 =?us-ascii?Q?f/nhJXsR6tDwH893YVSSUi+R7BlQjuMSVEAghQ3HsHEqKZdeU9tRTjPvlSmQ?=
 =?us-ascii?Q?1ODHGVQGNSV6mpPVhmQcLB0Q+kRuq3V78yV94FLN42hU2oPfiitRkgVSY/6f?=
 =?us-ascii?Q?Z9HBLUFpaYah4ZWlcaVeV0jwWB9dbismd0LdfkZ0FBhFeA5mXTRVAzms6z3G?=
 =?us-ascii?Q?BGcNkUtdCCj2SfCkGYvpSnPbQrHEbBqMxVbDeM7IZdZOnRIUt/YcLxiW4SEn?=
 =?us-ascii?Q?n1ed+h20BQoCsr+iTFZtk1f4xPv1pJKK75kGTbpO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5yuBc1yriQ1DJLtJ9MldJyYu8tLjYlJU/egqO4+r3z2sRj2MCYsJVVaFopy3Lk/EE5GMT2mJKVzHWUFT5p3IxdtTlBheR5uSoga8jD9pg2f2G1ltUjO6amMMy41j6o0ItHBjP2ZEl8TARb3lenbp1yNJ5ry4dqbovueUTwLTG5l4CcZnx9oMBz1970TtIHm5jK58oCRSf7/gi1lUKK2Nm4nZEaWkySb2T/j5hC1XlPHT2BzctF3pWPl93pHjP0YwW7Hxu03INDTk936yI1sPhtKouaRLIrvS0x8KHVnYcBS+ps5wFP6jPV8lvEOXcNxw9RQsIDd9jYrxTixytYV7G0oisfY68Qnh2ZbbDHH8K/ShgAhrMU5/vQo3EnCboAoAhzbnDlDxQaAxRRSNr0BC5usVRICuNd5oE/Asyyc2+kk8gbM29FL110U+K2psWB1Hs4CRYzemnY1v/lxB44dT4MgBl0olvwJw5Ov7ONoMNIy9fZWYOipjjyFbCcMwSvtD7qJB9icIEsE104YjoyidVYB0sPcO9lo87+CVF/brbaCSBXy5XQbU4d5nVKc56MkKjOqf9DY2fSn0iUJwD5p3J0108mWxAsLKHAKZ9rw2ocA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d3b69d-67eb-4240-0ec5-08dcc3922f6c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:39:40.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj4FeU75FONefkxeq+zawlzgE7Bl0Drty60i0J4AIuQ5w6Ac1Wg7UbdXgUOC66LzXuOmdAA0WZXEBBE91AHBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_13,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=972
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230123
X-Proofpoint-ORIG-GUID: XjafXaStSDjhruwiNeBNwNCRuJSF28nU
X-Proofpoint-GUID: XjafXaStSDjhruwiNeBNwNCRuJSF28nU

On Fri, Aug 23, 2024 at 03:00:49PM +0800, Li Lingfeng wrote:
> Commit 427f5f83a319 ("NFSD: Ensure nf_inode is never dereferenced") passes
> inode directly to nfsd_file_mark_find_or_create instead of getting it from
> nf, so there is no need to pass nf.
> 
> [...]

Applied to nfsd-next for v6.12, thanks!

[4/4] nfsd: remove unused parameter of nfsd_file_mark_find_or_create
      commit: c78a662dfe4ea208e05c7ba78949a239e31c360d

-- 
Chuck Lever

