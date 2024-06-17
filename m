Return-Path: <linux-nfs+bounces-3905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EA90B36D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD587284C8E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEEE14EC7C;
	Mon, 17 Jun 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kM76+m1T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N5Ec5aE3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5814EC7D;
	Mon, 17 Jun 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634117; cv=fail; b=iIKR6iXaqhTST9GZpy5sD5wTIVb9en/Riour2X33ga/C7BgQ69LyH8kqxVbg/79u7BAqM+DeTXKrtHPPZL1qwC5/0C4VSFrGcUK9bS7zhzpc1cdrlpbfMjHm/bqa2ZD/S6gZZnGZNhRkaVpsOO622defEef9Y903aQFJ9WFmOHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634117; c=relaxed/simple;
	bh=9T2KOJsA4/SDbdLqWD6X4MVLYi7iM5zmloJUSfQ1Uz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPLmZ8moSy6ZEmQ7FkZssXq2Edq6TN/D8m3eIvosRPr353yhO6Wiu9z6fKXAitkxbu4Txud5gQp5H4mu8CijycWbdeA1PKs4uWoOrxaMyxK0CHZUU7YwES7EK5Ulpa8d6ATWE82y4nTSd1rWVd66eO+SKyy+Wvxrkvdha0pfTFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kM76+m1T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N5Ec5aE3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBVj0031164;
	Mon, 17 Jun 2024 14:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Zggd8L1YY5fRNLK
	F1mlBBat+c2WdWYVnjmSzbvkQH0k=; b=kM76+m1TSsWUVNj4J7gRuFQZb50nIfK
	ZoEs75g2WdpDKgENVwsV5ifkOQHOiIWV/bbXj1LttG+7D2Dj1g1ClGIMRDvkZPHM
	3Dw7RkPvVxym72mKYOsSFJ+WBV5WXmPPtbsm/VTZpUuQUUliqcNWV4aCCsXjfE5h
	On2F9PZzman3abQXWeE1Dp1EM+2f1gkmfEieAP3csb7QrZM02MzplNysZhSihE4V
	WOzn8BSefALLVecx0HRH5JvnqnNaFpdQC0HusUXFm/s+ztYv4AzDQehCbnzOFAyq
	IjIUsNMBen0SRQZK0CW4M2M6jiTqGlzEVHotf9T59jcHEAh9lWZiY6w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js2rx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:21:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HDgSoe014875;
	Mon, 17 Jun 2024 14:21:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dcssc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewF2RTXHhaV4L51MUfBub1Xm+CapPPk7s2DAuTviXAfN9LdF6CkROSiVFl4y8HuHiC0MjfSEQLcgKLCXoT1nH2VJHtm/UXa5oNsKjf5C63wy60hFRXkC5Tzvu+elz0PzDTcVR3JHdlZvSzCZQ5KgM7y72sNvdJidlng5SL0/UEM24r5Q0+cdycO34eupzw37Hbtj88rkCOaaqcjH9zCtK31fazlEniY6k6eqSUY8S1k2JfNFVCqlj8ier4Cf7/rmwHTbqy8Ronzn3wx3ciCf8PKbmZyNT3qWnN4AzSGogQ+tSiQ63ohiFIjPSasezi4kXA4GaqYqyNSLJf8m7FUMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zggd8L1YY5fRNLKF1mlBBat+c2WdWYVnjmSzbvkQH0k=;
 b=E1u6VqAjN/TcUlL3Kep2COUljs+YIuAJKTnKlhs4PgU5Fi/wILwCROnyV54q3i58wNH3EHuflSXM7n6EkT6Q4MNcAnuGcKvkCElSvUNHsOGgWLkMeE0ZvLOtPVLe3hfjdUUHjkbVT6ed5XZFn4f7lR1DhFopR3SzXEbKbf49XzR2mumWQ9djW6t4eL0uCP5wrhBxq5WcXnw5UhAEYaX6kW1myYq9Wde4UhFf+D7vMU3wf1VztfsDcCJsJl8n0Bb1uQkHTX4fPCKUUG9lLexHLf5l/F+G+MekusnM7Ijj8jQFb4tVFz44z+mnZxxqq1HXqeEuwErCWiY5A/GX366Kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zggd8L1YY5fRNLKF1mlBBat+c2WdWYVnjmSzbvkQH0k=;
 b=N5Ec5aE3xiX5kXwHCmx6jcORCzXrNbjtuPjVzowaqPyJDmVEhBqlDIfDbibKOkhKYne3+LfzSXtTx6K87spfRmuE0fXhnPJRBr+FXBU3zW+PwDsVcXv9HgIVEYDa86XRHdjHt4te6xfleORX1BAFWdALtlppe6mRacVPZ41ALtY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6686.namprd10.prod.outlook.com (2603:10b6:208:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:21:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:21:38 +0000
Date: Mon, 17 Jun 2024 10:21:34 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix oops when reading pool_stats before server is
 started
Message-ID: <ZnBGbmIQy52IDC9L@tissot.1015granger.net>
References: <20240617-nfsd-next-v1-1-5833b297015a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-nfsd-next-v1-1-5833b297015a@kernel.org>
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 239754dc-6f8c-4796-3c8f-08dc8ed8ccd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YYuKGhGydeMiqd/s2JF7u+0cwNHCjrEtB11yrDHhGFtXT3UippHkCUkHc0Yl?=
 =?us-ascii?Q?9g7XPJECFLJuu3dan64eqG62L1JISyqQOP0Dbsg6W5Idc9PfgihB9O5WChpJ?=
 =?us-ascii?Q?qRBhc7pFfcZUSn6sTGOwtOMTe6cdVFT+91BC1790bm1SSdujttFDHWZ6Bf78?=
 =?us-ascii?Q?dY+lOcFzJQ4atmVeGxvwlCikSuWItu1HWkAd9h5f4ct6dKi4nVChuzZW+Mi1?=
 =?us-ascii?Q?0xk6SMGeSAkFf/091uf5oTXBJTewE1hGi+yrCO/EzrNooRxd3aWIVSM4YXIN?=
 =?us-ascii?Q?v6znskIj6EDhOGgbkF9tMQcfeovItSjt2AVZ9NqfKG0MLZrPhDDBWKp+dhQY?=
 =?us-ascii?Q?ignSm/hPCK82kTQKP8oA+y2sBc43jNwLMIs8bJ1Fc1ajiDYiORsfOCL2LdlX?=
 =?us-ascii?Q?i4oSwwf3Q9bCF3NOHK+w3BLWu0zmO06QZLcuFazOhFDC+wgvNgFs/ssD458D?=
 =?us-ascii?Q?SGfLfCCawB88GF51s4XRdOHP5d625C96zI9olD99NJkpFF6UefH0WDau5n6x?=
 =?us-ascii?Q?2CVYry/TdfbqwzSOpiY8GdocKSvn5SAwemuRpvPOvhfliEKFI6Wy7yeDdAOw?=
 =?us-ascii?Q?lsnH7vAUkEhDPfHwO9I5OJWwuoVR+pJ8Rfp+MHEVdxadJq4LC+d2GUxEnPwl?=
 =?us-ascii?Q?1bcv/Rh2fhZELPFtVK5Jn8ipRU+RGka+m8HMoI2PE9KeoVyfDlw/BRXa/W/P?=
 =?us-ascii?Q?ieYPkzjb1FYocBjWkXOqXGyJmFFRdoZdJz/j3hO7+16fPttp9AW51x4WFa7C?=
 =?us-ascii?Q?QfYk2bHAH8VWDyB20nXBnXSWMtYhZkpPbLqx19mKQzEw9vKlLmJYcHoW+ydG?=
 =?us-ascii?Q?kGzKMhD6uhTZfwFGbQQYxguCARjJeHLyw1MDP2LKKHQU0ADZLCj8U39WPT0K?=
 =?us-ascii?Q?6QikcnWq19ELpi25/04U4nbwQ3pG66yye3DRUID8S1UKttuc+RdAQDejSV5d?=
 =?us-ascii?Q?2RTYPiRDzpVcTJCa8Y6eJhG06gWrMel69hk/cfkUs+pN5pkgAQj07Fu3r+E5?=
 =?us-ascii?Q?evWwkFnvUr6KXGBl5nE1X7CQbxGuqV5PPsBksWKIx/BjeezJEHTIFJOYRxWa?=
 =?us-ascii?Q?ktPmD0wzd9MlHJ6A7wb/qvQoNnX4LPjCzWjMCVGnnX6OLuoHnfg/xFNgMXp/?=
 =?us-ascii?Q?kE3WRkFyv0LAJWQvc0wBm/uoQ1/LesBCNX+Ku9bMTNdlJWsEA2bVBdz2+9d3?=
 =?us-ascii?Q?20C5y5y7maac//wClC3fCudH/KzyDZ1Q/PgTFU2hxmfczqDmvelrXdpV/4rp?=
 =?us-ascii?Q?ajWzGtYBMYbEKiR9rJeg2V9tfilEX2G94Iu0KXseiqg/4wSD8lSfdQBgKff6?=
 =?us-ascii?Q?DltCJab/O8hk18EmLrOKlFlF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CpxmV2V1TftGgJqMiX2D2Q0VSYNcieEKxNj5VhgJjAGnbF+cUsPMnNlzXDuE?=
 =?us-ascii?Q?No8f9A+EucqGR9xoPfTElgVwSHCjdUdTmmu26CYUvjrTUNiXy+fkgiFUoMQK?=
 =?us-ascii?Q?KRrYvWqXptSdLaThOqyhV1DPY2ubODhv4V+4+brqfB5pvC/srQBcwXXm0PVx?=
 =?us-ascii?Q?e8pItDqbjGYVHC85MkbmebgXamLavNk8NXW5DqhutVut7SiCNe9g3UKXBSxa?=
 =?us-ascii?Q?z5C43zyDfakQGnkkpP7BHbIBFFLHunG6v9wsE5BIjHQHMmGvESfe5XEPoLXj?=
 =?us-ascii?Q?+CBgGB1uU9447Fj4+FMMalCDZ9mwDmEpiKisNns5tW46Fh8FiimPc5GpWGZp?=
 =?us-ascii?Q?VhYszLKV/yMnwCD8zmtaqOsiXxJ5cIIJ7KF+WOxU4CAOqW0OCg3TQblxsOHw?=
 =?us-ascii?Q?WSQQj8nfnmQKL5G+SBT7jud4krCG+SAl34M8irVs0ALxBGMgqp40vBvaiZsW?=
 =?us-ascii?Q?zyBs+VQBHl/F9bb+S3UQ9ah441mVvOGzRMDz5Ps6hBoN72KPHL4jA6IU5inU?=
 =?us-ascii?Q?eFp61ePcbzEbWoHnopS9EeTBG2u8BckENXlT6oPcNfnPzjCb6ETxf9CDYIXg?=
 =?us-ascii?Q?j+t25I5mpFkbJDOp8oEm9NteTkOZ0YrqTg//weXeBhk+ZluGsNopYK2E04f3?=
 =?us-ascii?Q?/ATO/6J0y9VhoFDWzviRtG9TU8ePHNJtCqYDgphbbQc3KiwRC9oJ28+4rbgg?=
 =?us-ascii?Q?pUn2W9evIiDsPi1gNvM29VnAr2MflzIZEbF/MfiiININwamN06MKXQkYElnT?=
 =?us-ascii?Q?ZP8aqiq1RVcGvLSyuDNU4EaDmEZLk39WuWmszzfDViB8g5vZ5jYP3qq44lPr?=
 =?us-ascii?Q?BftlPACzMrIsOHs/kOC8oYYFEEjslGV0FcHLuYofeORmSHSoK7uzdveSdqI/?=
 =?us-ascii?Q?tL8vxfmhnJgqMeaX5eJBAayhdc/EQN+e6r+9KaYeJOtsAj0dewiKR8ZEV3sZ?=
 =?us-ascii?Q?4L67FwhvmKCpcb8tSNIxtrqL+O5UQ0W4XMLc7OkckzBqUr+hQ/yylfpePbTv?=
 =?us-ascii?Q?0woe92Pr7DMK/Tg0+g90GPGJPrnXn5e08/arg2CCK0VauwE0bcCqoEK3D58R?=
 =?us-ascii?Q?/vDxd2KLbCogXwFYHKEbQygy9djYdu1c3pY48DH695Q8HSP4FjmvXn/ugJoT?=
 =?us-ascii?Q?IXjvHfoOujh2egO99ZAx8yBK9kMTFJ1EW+04qgCe8NwEV6XKplrw3kA0n53N?=
 =?us-ascii?Q?M0oHGybEgKvIf4nSCKL8ANmhKAYLyHYMGSIM1YFJEMrm2H9uaQ7WT9Bjdglw?=
 =?us-ascii?Q?py13YddUwc2g/rOZXIHHR/lza6z9Abo02t+VTTcn7giyX7OAPoWlO4cVbwtN?=
 =?us-ascii?Q?SzmdDm8vqdE+o68GXn/UKgQ1fsbdIMUYgZia9Sef7Du2/cox52loTTDvRjRJ?=
 =?us-ascii?Q?D/z9uGkn7rfVKNHncUesl54MGeTBkBUUCtS7HJRA3sSaMKCZizZtK0tTBTEl?=
 =?us-ascii?Q?pnrlg0LGM2ni/F9z/Zn1FaOv3wSdxV91XIuXphxavCvHrxN1zU/9nqD7687t?=
 =?us-ascii?Q?qiPd3Flbx+4nEBDrQKSDFbD5rc0QqeFQwVXzQnvlx+QhS7Rvx/J4K2TB9goU?=
 =?us-ascii?Q?6rhi6ESg2HpnTaUDBaiGOYiI3GIsdd2tbSjTJTu5QWGJqNc5qG0myN24Rx2R?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vc5daqMa8W36pf0FRMWOiVQFdXHi5IftvOR6YdRyxv4ZoYMugUwICPpxh2QT+24XSPGq1ZtxMNt5FIDvxsRtfhGvaTJGNo+L3eZ2+gPU5s5yMaYDcTsZVLyLo3GATkUGDrUrtCwRKtYrlfh0HE8vL1+R1Zb7qdJlIJgxhdBmi8bdy6qJAutquR9cYpj89JtuypTDfZuohuebxoRv0qIga/ei37fvoyISydWYyiHOegf8nkeqCN9wN1j+Guyf6WObrvs7q4HAHgJJ6qr7qlc6WI43VIAvT/DtFv/vkSCbml1BTXfdLMOywwGRRqomgSEeU97arg+DiWiG2ySXsLCAiK5qRwR7KtiFyPnlvWKra0PkqF+sulJfPWhb5+wTCVQ4CEDvAtWd66LGFEr6LZXIayGgKi5iJfxuK8IZ984bCd3o+ONvVJTdl8cSF45gr4HC3/KafTitkNjYSACvGhdgUEypD26iTTS9cc9CzS1+bKqc+3tz2rteB8yCq7dADOzdS/4/2NfVp791QTWU9EADGc10Ykp9uCJfVtjg72H4vwwIFULkxP0nUWMSSQOs9P8zjsyU5ZtRTqzktT6dVQHLeup9MtyHUO56+eKFKg3FQqg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239754dc-6f8c-4796-3c8f-08dc8ed8ccd2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:21:38.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3mwBtReZC9wzX8PN5YO4DJFEBRA/BX1NZY6kmtv4iBxPwMFOh6Rn14cigp0RmInRugcNDpd9EwZVUDh/fYU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170111
X-Proofpoint-ORIG-GUID: mvc4qNaOrlSnFxhc7-GtZryQTGSPv7HB
X-Proofpoint-GUID: mvc4qNaOrlSnFxhc7-GtZryQTGSPv7HB

On Mon, Jun 17, 2024 at 07:54:08AM -0400, Jeff Layton wrote:
> Sourbh reported an oops that is triggerable by trying to read the
> pool_stats procfile before nfsd had been started. Move the check for a
> NULL serv in svc_pool_stats_start above the mutex acquisition, and fix
> the stop routine not to unlock the mutex if there is no serv yet.
> 
> Fixes: 7b207ccd9833 ("svc: don't hold reference for poolstats, only mutex.")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied to nfsd-fixes (for 6.10-rc). Thanks!


> ---
>  net/sunrpc/svc_xprt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index d3735ab3e6d1..b757a8891813 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1422,12 +1422,13 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
>  
>  	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
>  
> +	if (!si->serv)
> +		return NULL;
> +
>  	mutex_lock(si->mutex);
>  
>  	if (!pidx)
>  		return SEQ_START_TOKEN;
> -	if (!si->serv)
> -		return NULL;
>  	return pidx > si->serv->sv_nrpools ? NULL
>  		: &si->serv->sv_pools[pidx - 1];
>  }
> @@ -1459,7 +1460,8 @@ static void svc_pool_stats_stop(struct seq_file *m, void *p)
>  {
>  	struct svc_info *si = m->private;
>  
> -	mutex_unlock(si->mutex);
> +	if (si->serv)
> +		mutex_unlock(si->mutex);
>  }
>  
>  static int svc_pool_stats_show(struct seq_file *m, void *p)
> 
> ---
> base-commit: 4ddfda417a50309f17aeb85f8d1a9a9efbc7d81c
> change-id: 20240617-nfsd-next-8593f73544f5
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

