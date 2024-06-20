Return-Path: <linux-nfs+bounces-4198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B79116B5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 01:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE40B21596
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF527763F2;
	Thu, 20 Jun 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTJ1m+Z0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vQ/NwPYS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFC43ABC
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926112; cv=fail; b=PuboLn+XaXUVS5i0dMjRFpDGimpLg/9QZYZATfrWHViGByCaRAXGTvMINrj5KJuS3LvnKqJpDVf4cLv80Xm/vxXa/bUk4nP2RIs1iDFzTzdzbcHjAqjEyLTKKQApfJKotlGsleqYiADyQ8aI/G5wGT8eh4LGZLp/24wfr6sgZ0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926112; c=relaxed/simple;
	bh=aCZMSfomdwPwCs1VqeFlJpfdqGNOyra4RArr/WV98+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPsd4jGv2Q+xcSSKvccBGGf5MSREjkBugBbXS+7XmCcu9M/oXfeuyetb01gI6BFsxGO0J2DVQ8/KJxvmnBbs/3nl08/P9SsmlD54kWxUHDhamm3ifWqOwdz0HU1mwXab/vL+kCeTMIgtC7t6pKFsaHIhHmqNwkf5aONSA9tPXR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MTJ1m+Z0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vQ/NwPYS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KKtqIx016594;
	Thu, 20 Jun 2024 23:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=JenBZAhe9jx1qJf
	1eizOIcWU6qq2pyiehvjV7O4n8V8=; b=MTJ1m+Z0P8+uzGRdoDk2ia1elnLJ6Fv
	gG3LBMbtXn1Ag8GJXGV2X95HWePoMObkVIX5oFM1DgxEXYmXf4YD+LU9BXeCG7gY
	lzgA9qn0nc3XSkYR/NySfIeMIAk5RYyXBHwYY5nt9Ink/3pWSqidVAiiW7RNenFO
	I/P0vGd6kf3bQbnsRHzgcxJAS79HtApRUcyozMMMN10xaQHiNPK1NTPF1ElJKWyq
	b8CNh0WXcccJAzkmN+AKeiWeeMHsMLziW+uUtoiXxsJCeMx+KKTZ+hmbVaIhuukL
	6u2tiXTLIGGHMD2QVMF98ZZJBIrJKBZFVpR0WSxZh0Rl5Cx03Woykbw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfrndn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 23:28:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KMFMIv023546;
	Thu, 20 Jun 2024 23:28:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn7wgs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 23:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhJfgPExvCRrcpuZFRjKYfE9QO99PEBdeSQuZR/Nb/747sBsjNnh7Keo5YJ7TpM/VCw7V9s46pyoLvINB7JBHpEqtmQ6voJrONgMbTywlNWvK3TIzf42IfY9VFKdZbGKaFVEtK2WdWVoWWtHjofF9Q+IbIub0xIf42YLHAAA9RuweIf91A7+uLKI1YoMQ6jgzeaEjb9v9IzhiD5g3PzYm8MYdnDialShAMKhDgQm7lvXw+Ym1g2i0q0c7YHh3OwBqFpCdsriET7RvrVwMyfpqpecOOTkbDjeai+4z9wct1gIv5q7uwImnK8kNL/tsDL9ViyQAM9Vt4KnjqT7vPmjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JenBZAhe9jx1qJf1eizOIcWU6qq2pyiehvjV7O4n8V8=;
 b=SzGMt1/OdSqkfHjuKC7Q5ym7KvLLX1CBaMyxqnZc1VzY0FDSyY0ajRlm1vChBIPT/TwrVwBoWBFSNVrrcvatnBEVaNekrFp1B5I+K9ITYPHd2sSqbUckbyWvxJNp9xPWiscqbsGKbkusy5p9xoBjJ2GF7HcAj7F3ZkCA3qnicCYt8wN0fF3fQoupco37dkjPBR5GOp8vh+0x0JguxRvx8x/qNx6WG4ee3V9wGFoh/TPvZlR1n10tAYoaoS6xX0QPSamZIUwJgqh0oWOLBBAglakV/ulNITGhevjk5nosMyE8jlRXWL0RJh3viJCw2WpyG9XD1X2BdnpGUiw6bVRjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JenBZAhe9jx1qJf1eizOIcWU6qq2pyiehvjV7O4n8V8=;
 b=vQ/NwPYSfbZKtrV2vwg0v71LVtVbzdsacK/hmtPGEgwcyj1/vgGv0NxPaz4WL0rWcGBhQTubNYlKTFUlTVTo0hoxnBY0j5UcKx5HrONe/Z/ONYgBFlmHoRf3GSfF1yKbgq+1OQ9FdvgTZZDbbUP0zQgkP9UEpwsJHyh+rNDM9xk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5029.namprd10.prod.outlook.com (2603:10b6:408:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 23:28:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 23:28:17 +0000
Date: Thu, 20 Jun 2024 19:28:14 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnS7DsnrW7OX0rJC@tissot.1015granger.net>
References: <>
 <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
 <171892157698.14261.16357981881792326304@noble.neil.brown.name>
 <ZnSuunNIgmhERwCm@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSuunNIgmhERwCm@kernel.org>
X-ClientProxiedBy: CH2PR14CA0045.namprd14.prod.outlook.com
 (2603:10b6:610:56::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: b32602ac-c14c-4f22-46cf-08dc9180aa32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aiv+t1a1obg2o3E8qjHf7YTbMHzLSrUWGAN8X96ff+Tc7ISXiAmNKzVIm5aj?=
 =?us-ascii?Q?1k5XA83ZZI1cio6Zy74K7uQcKGEfZb04heYJIuFDJ++mEWJKVqryrFHwNXvI?=
 =?us-ascii?Q?JADyod8dj3ZjXoOP2WmUQ8qufl77sOfxfDOlwvt2JjFfQnMe55ixlMBGE7uQ?=
 =?us-ascii?Q?Abh54Zt5JKGUfIhBRsYmCe4Iu14O2ujl9ofG5A/kDdqP0ldCY/Sh9glf/HY0?=
 =?us-ascii?Q?W4mTZtjvcFN2Y9rhNxBt6r6BRgiGuD0mQvbTBpenjYyn+AxUwqREB9ZvL44N?=
 =?us-ascii?Q?vkhxpugcWB98SMv5J8iTVo8M5DItKDRVSo2aPfpqc3KPW/ni5vtFlDq6MSZB?=
 =?us-ascii?Q?NBTk/ei39Z1VPQvff2N+Hu9m5OM8jjQIBXcC92uAU8jdk3cl9KTejfCQTYGS?=
 =?us-ascii?Q?FWPz9EMmbtzJaza2a0kK2fjPRVq8b9egXF80h0ejJ/c5Id8yVxT+6a8XdxVg?=
 =?us-ascii?Q?NT2b+0Zu3zd1ky4ZLHrxvY8TxmaY2tE95681JxA5Se03DRlSocuDBAZkXGQF?=
 =?us-ascii?Q?FpenrRgve73teC7GnwPf5uX2DPTGX1UCwR5nre719uvKuGusFX9KADWbA7NV?=
 =?us-ascii?Q?GCopxUlTe55fqX2UfN7aZ2GFh7Gku4zodIIoTxg4G2Y8RmfrzxuJ0EiYDvM4?=
 =?us-ascii?Q?XEdWCyebd2v/VEpGTMRm1OQZtNMFxMrCHcaCJps7JDvkwLnqRiQKMs4J7d98?=
 =?us-ascii?Q?SKB/ngNr3g8jhWdDnh5+frdWVIHsO95NGgDimeW0sqfn9o5F90T2t5LSaKb/?=
 =?us-ascii?Q?V/iWWSQzZiI+VzdBfMUqD2i4oy7uCdzL277Ooh62Or23bfuVbhC2+Q/3FT8p?=
 =?us-ascii?Q?eFwWx9ByAdsn3uck6k7dUOLuJz8USblws6mVUEUO42fFfvarZZbXrR8K3X1X?=
 =?us-ascii?Q?HAqRC+nV7u1qmDUthQJZGVLO7zTNwPJxAQIuzZgG9piMyKoEHbpt7tPGhRpP?=
 =?us-ascii?Q?SxwTnAoxH76u8r/N/Bbnew2iagjWAU7hEygOPn/ZDg4kr+KTCucGY4BGInVL?=
 =?us-ascii?Q?QS3xftiQH19PqIGBGUcSqvZwol9x78DL/uE9eepAYXRyYKyvg/4si8dkvSV4?=
 =?us-ascii?Q?SeVRB8T6sRFqcdtEoTA4zQsbKLhMPXTQOo1ssq5xrLIMy+x7jOAv4lDbLYz5?=
 =?us-ascii?Q?EU+Ok3B39oVtnS4pbTKLCI3h0RNKzbZsrTeV7U7lAMI1s0VPAamLt7rYFYF8?=
 =?us-ascii?Q?1hMQfN4v33xWP6y7W8Z9wPFJF1A0WWolx2cN/d/TfB5Kcz/3mc/lCZ+dy0R7?=
 =?us-ascii?Q?/huZdkp6ldivyNKg0ixBeJi+ugrfqiEjQ8KdgNn39c7X62INm7IVzxvqyds8?=
 =?us-ascii?Q?YWSci6lEspeybb/4Ux+721qv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?spILSZqCNzN+t3Om12GZTGPC4Bqo0I7vnQuCSkjKkCByyK1KsDGOXd8CbSpB?=
 =?us-ascii?Q?hN0OYkrNgzFfTVp68Perm3Xz+YaHByJCqdJgaJeWFIg91iWB0LC3aNK3mt3n?=
 =?us-ascii?Q?BzIiKn+w7iHB3CD9/UGonKWSdl8LiSCzmByVWxDHvSyM2dOQeIfTtOR+AJmG?=
 =?us-ascii?Q?AL4IMbJU0Sl2fNOQ1HZ4is8sm82n2ch5cZ+cowlLdzORBZJbRbpHsJ+YUYhu?=
 =?us-ascii?Q?qDzwTJprr/VmyqeFlU/Wi8u3CCUlqOp+AmPKewytjLEdjkXg4qH/9SD41m6T?=
 =?us-ascii?Q?wxI/wYhwPYu8+xB4wOMTBVTf/qEZZBdKZVImGsmJpoMSCEZIYYf4EMhDkofD?=
 =?us-ascii?Q?u6hngwIxf8oSG1QeWuoN/8A3Ka2IsA53w3jzJAZoSf/hkFLje/8W1+Bb2h/d?=
 =?us-ascii?Q?6Vxs9uNyTpHDglZhUqPbk5Ye0v5fGJMUaQMi2gRrHKPjcenr7SvNre+QwSrh?=
 =?us-ascii?Q?l6malZQ/nfrD1sBAIFme0HsjuZQncv0BhNQiDV9V6SfIGTfBpUSIfpbOZ30q?=
 =?us-ascii?Q?wqgkjd897i6I15dDsLb3eTmPCKfqKrKVQUq5SgDng7RYXP1H2neTU4Fvpd0g?=
 =?us-ascii?Q?pzT+ESHEmJRSWXrBOeQbGmPVAn9iSWFDDmpWmqAW7FHLW1H+5eQeSFTKDuBn?=
 =?us-ascii?Q?IYbNVyO88qcEvM8hQCyhtZ+Ho+E4r0MOszMnqJV/UiDE6F/bVIDgUBWku1v3?=
 =?us-ascii?Q?Cr7PXaVmmbktXYl2NIF7Qr+9EZ0fPOZSe97U0n78GjWFqaWecLilDCNTOdjS?=
 =?us-ascii?Q?u7uS2j0Dg2cqyIWSInWzIPjdLMfX2zqPKVwSkuJ8i57BnrDNdghNmWrJGIVT?=
 =?us-ascii?Q?Bmy70UvpyNtYbbxszHQiqd4RxwUWZ2r0dJiJs/oRv5LsEe7SOYWFhD1FvZ1H?=
 =?us-ascii?Q?2RjIA+A4H4tB3pnpHC34Yjep7S2swk+VVRcpNcOR1OrbNRE/X2enBDu9WxRB?=
 =?us-ascii?Q?svYS1aWtSJaL9kbJet092fziQSyESlsxf5AK9BlNW86Vv6x8NNYdDYT8TOyy?=
 =?us-ascii?Q?NgsqvxjZ4jumdUXsAySYzfTWYIGC54ne/mokcDssi9AY4F16b41QmDYmeq1z?=
 =?us-ascii?Q?uadWoQPUAB9wAdvRXKY6SnW00NJC1olCBQrqw1qtnXCm7bBD7SDld3R+WmBr?=
 =?us-ascii?Q?G2QMH1h4sUG3/PCsjKbV1R0rW47mLr/Kj2RjQcnM5PZoEGoE+LwWmjN0N5u5?=
 =?us-ascii?Q?VHGGIlGo/wI+C+RH5tKgPFqk4NJurTlXR2O11b6QyAA9vyKGMLZ1n/c/Y3xK?=
 =?us-ascii?Q?y0yjt10GY15r3gVP50z6ftnHmrTkosx7YsL06I3yuKC7dqyVed3gYHm3NEMA?=
 =?us-ascii?Q?3ITCxnqi498byDxDcYsXPHeC07N5WewOXTOnPYHplcsW93XZPpKU8o60EIcF?=
 =?us-ascii?Q?eoHUsQ5VTiYjvJnSQ77MaEdQjCodv/MNGAPhQ6vZ3IrhOU0dK9XKGw+rINnP?=
 =?us-ascii?Q?Yq/DYhSt17ld4BKNmw+3Z2oTxOqg/5v6tvbqBj+8pmG2Z/8YRTv/VpxYI3+q?=
 =?us-ascii?Q?sA5T8puxwdwYlSktDy7h+F4ueQliBCc3XxoQAJ7LHmzNv+RCK1Ugt4VPQjDP?=
 =?us-ascii?Q?lpVg0wAfSEFiPros8CVJBgQTqtc5ah5jwp9NLwP1FjeJSUtDAJkeI13uFy3t?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RszwsNKjMkOZCrO5MnyFHhgsLPOfbistNSNzrWERJ3LJHtp7HfNJhLhXhYW53ceUXv0RJbWLi8P2OcD4hnwnEjquKnjq0vQ//4/piPZNEHFgXNSI5vltkNv0axgonV8yMD1Ls2OQkx30eea6YTKHYUcJNPstnWr49cFPsvRi4IyQzV72S73iKL/4bPaP/suipbAhmbgEbd/JA3MLOjNzYowxX68NViR6iRANew8Je3/WSCZn7LNSbQbnKP78kUbdKWXVRZwrEdfmkuOJHkRE9m0neqhI6jQzyvPSO39nxdXz0RtzmMGdlHJqzzyo29RcVwQ9ZPTe6LJuP0v3asZc9Ci859fnZ11hn4jyi1C84ELWwznBTB8DWOnMHCqkFplxgbeAe0mh18A+udfIFGRSjN6OYkzrke91Ga3mVPzqp9TmnaspUGDlXV/21oWNLEB9WrkRo+Cj3FqLTRkZC9LuTax5OgVonRl7vPiHjOsS47NgcyyKEI1lYIqWAVoE6sqBXWHDnWxJuc+KXsckSy13+Po2PSrYeE9NhdIFkCMGy6icn2isyKWSKMnK67kBBE6BlyQnwm1+qb6nmQFRGTPwi5uIXb331Hx0+SaPBLXkPlo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32602ac-c14c-4f22-46cf-08dc9180aa32
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 23:28:17.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb5Cj4BiS8ombGnEjmw3rM1fFCZVOE/tWtJnQKY4S8JlwU9GP9o7yUneNp8VevC3WW3h4VL+ibnWN3K1a0U/yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=758 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406200171
X-Proofpoint-GUID: P-CLMIzHaIIiG1KduBXs1rHS6j8elqGp
X-Proofpoint-ORIG-GUID: P-CLMIzHaIIiG1KduBXs1rHS6j8elqGp

On Thu, Jun 20, 2024 at 06:35:38PM -0400, Mike Snitzer wrote:
> On Fri, Jun 21, 2024 at 08:12:56AM +1000, NeilBrown wrote:
> > On Thu, 20 Jun 2024, Chuck Lever wrote:
> > > On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > > > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > client and server to reliably handshake to determine if they are on the
> > > > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > > the same connection as NFS traffic, follows the pattern established by
> > > > the NFS ACL protocol extension.
> > > > 
> > > > The robust handshake between local client and server is just the
> > > > beginning, the ultimate usecase this locality makes possible is the
> > > > client is able to issue reads, writes and commits directly to the server
> > > > without having to go over the network.  This is particularly useful for
> > > > container usecases (e.g. kubernetes) where it is possible to run an IO
> > > > job local to the server.
> > > > 
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> > > >  include/linux/nfslocalio.h                |   2 +
> > > >  2 files changed, 150 insertions(+)
> > > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > > 
> > > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > > new file mode 100644
> > > > index 000000000000..a43c3dab2cab
> > > > --- /dev/null
> > > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > > @@ -0,0 +1,148 @@
> > > > +===========
> > > > +NFS localio
> > > > +===========
> > > > +
> > > > +This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > > +added to the Linux NFS client and server (both v3 and v4) to allow a
> > > > +client and server to reliably handshake to determine if they are on the
> > > > +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > > +the same connection as NFS traffic, follows the pattern established by
> > > > +the NFS ACL protocol extension.
> > > > +
> > > > +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> > > > +clients local to their servers.  Prior to this LOCALIO protocol a
> > > > +fragile sockaddr network address based match against all local network
> > > > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > > > +sockaddr-based matching didn't handle use of iptables or containers.
> > > > +
> > > > +The robust handshake between local client and server is just the
> > > > +beginning, the ultimate usecase this locality makes possible is the
> > > > +client is able to issue reads, writes and commits directly to the server
> > > > +without having to go over the network.  This is particularly useful for
> > > > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > > > +job local to the server.
> > > > +
> > > > +The performance advantage realized from localio's ability to bypass
> > > > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > > > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > > > +-  With localio:
> > > > +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > > > +-  Without localio:
> > > > +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > > > +
> > > > +RPC
> > > > +---
> > > > +
> > > > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> > > > +method that allows the Linux nfs client to retrieve a Linux nfs server's
> > > > +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> > > > +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> > > > +to an implementation detail.
> > > > +
> > > > +The GETUUID method encodes the server's uuid_t in terms of the fixed
> > > > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > > > +methods are used instead of the less efficient variable sized methods.
> > > > +
> > > > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> > > > +as 0x20000002 (but a request for a unique RPC program number assignment
> > > > +has been submitted to IANA.org).
> > > > +
> > > > +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> > > > +syntax:
> > > > +
> > > > +#define UUID_SIZE 16
> > > > +typedef u8 uuid_t<UUID_SIZE>;
> > > > +
> > > > +program NFS_LOCALIO_PROGRAM {
> > > > +     version NULLVERS {
> > > > +        void NULL(void) = 0;
> > > > +	} = 1;
> > > > +     version GETUUIDVERS {
> > > > +        uuid_t GETUUID(void) = 1;
> > > > +	} = 1;
> > > > +} = 0x20000002;
> > > > +
> > > > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > > > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > > > +is used to implement GETUUID.
> > > > +
> > > > +Here are the respective XDR results for nfsd and nfs:
> > > 
> > > Hi Mike!
> > > 
> > > A protocol spec describes the on-the-wire data formats, not the
> > > in-memory structure layouts. The below C structures are not
> > > relevant to this specification. This should be all you need here,
> > > if I understand your protocol correctly:
> > > 
> > > /* raw RFC 9562 UUID */
> > > #define UUID_SIZE 16
> > > typedef u8 uuid_t<UUID_SIZE>;
> > > 
> > > union GETUUID1res switch (uint32 status) {
> > 
> > I don't think we need a status in the protocol.  GETUUID always returns
> > a UUID.  There is no possible error condition.
> 
> By having localio use NFS's XDR we're able to piggyback on a status
> being returned by standard NFS RPC handling.
> 
> See:
> nfs3svc_encode_getuuidres and nfs4svc_encode_getuuidres.
> nfs3_xdr_dec_getuuidres and nfs4_xdr_dec_getuuidres (and note the
> FIXME comment about abusing nfs_opnum4).

No, let's not piggyback like that. Please make it a separate
XDR implementation just like NFSACL is. Again, LOCALIO is not
an extension of the NFS protocol. Making that claim confuses
people for whom the term "extension" has a very precise meaning.
If we were extending NFS, then yes, adding the new procedures
to the NFS XDR implementation is appropriate, but that's not
what you are doing: you are adding a new side-band protocol.

I have a long-term goal to ensure we can generate the source
code of the XDR layer of all the kernel RPC protocols via an
rpcgen like tool. A code generator can ensure that the
marshalling and unmarshalling code is memory-safe.

By piggybacking, you are building LOCALIO into another
protocol's XDR implementation, which makes it a special case,
and thus harder to implement via code that is generated
automatically from unmodified XDR language specs.

Maybe the client side maintainers don't care about that, but
please don't piggyback LOCALIO onto the NFSD's NFS XDR
implementation.

Then, if it's a separate implementation, you can remove the status
code. I was wondering why the server would reply with an error. If
LOCALIO/GETUUID is not supported, then an RPC level error occurs
anyway.

If you think you need an error like "Yes, I recognize that program
and procedure, but this file system doesn't allow local access
in any case" then that needs to be added to the protocol XDR
specification.


> Not sure how the reality of piggbacking on NFS XDR should be captured
> in the protocol spec here.

It's an implementation choice, so it doesn't belong in the protocol
spec that, again, lays out only on-the-wire behavior,.

Implementation specifics can be discussed in another section of the
document.


> > I don't think we need the NULL procedure either, but that is such a
> > deeply entrenched practice I won't argue the point.
> 
> The code required it be there, I unfortunately don't recall specifics
> on what failed if it wasn't there (may have been rpc_bind_new_program).

Please leave the NULL procedure where it is. Note that the NFS
program's NULL procedure is used in two rather significant ways:

 - As a carrier for GSSAPI messages
 - As a probe for the RPC-with-TLS capability

The latter might be significant if a client sends a LOCALIO
operation as the first RPC procedure when contacting an unfamiliar
server -- if it wants TLS protection for that procedure, then it
will need to send a NULL(RPC_AUTH_TLS) as the very first RPC
transaction.

Since LOCALIO/GETUUID is going over the network sometimes, it's
reasonable to expect that these security measures could be used.


> > > case 0:
> > >     uuid_t  uuid;
> > > default:
> > >     void;
> > > };
> > > 
> > > program NFS_LOCALIO_PROGRAM {
> > >     version LOCALIO_V1 {
> > >         void
> > >             NULL(void) = 0;
> > > 
> > >         GETUUID1res
> > >             GETUUID(void) = 1;
> > >     } = 1;
> > > } = 0x20000002;
> > > 
> > > Then you need to discuss transport considerations:
> > > 
> > > - Whether this protocol is registered with the server's rpcbind
> > >   service,
> > > - Which TCP/UDP port number does it use? Assuming 2049, and that
> > >   it will appear on the same transport connection as NFS traffic
> > >   (just like NFACL).
> > > 
> > > Should it be supported on port 20049 with RDMA as well?
> > 
> > I don't think we should be that explicit.  We should way that requests
> > are sent to the same destination as the associated NFS requests.  No
> > mention of transports or addresses or ports.
> 
> OK, I agree.


-- 
Chuck Lever

