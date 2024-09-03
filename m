Return-Path: <linux-nfs+bounces-6175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D096AA48
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7441C21377
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E11CCB3D;
	Tue,  3 Sep 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QgKkg4iM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C/BTFIHy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71601420DD;
	Tue,  3 Sep 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399406; cv=fail; b=hVa5PWn83W1pdRAtWMi2eO27dIJk5renBxbgcaVnR4Vj4IC4W753QMCa2nlfQoJ6E9TyGNUk3LtOvV/KqCNKryhLZqoSXgVzbJ2RXIt9GiyY6ypSEhAvGyFDwszgPI/uDQyGrynJmClQh7uV9XtL9Swf3ygHhxIAuHcgCbjhy+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399406; c=relaxed/simple;
	bh=YB+EhR8ASAowkyvLqUjqHm59imtPYFRaFshfAgoQSsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iFaOfd7dhgCpBWcABnFVO6b1plJkRPydWjKem5c5f4qzMz0B+vMSOqnk+SpTBhuA4d22SrA5cOkE3CVh7nexOv4ZEovLOlnWS4+9VAVD9qDhX6VsD7xHjNFrKHXzUg2xiLj+QlijJgH5zMh1EFlaxQlHl8KJmHdSzoGAFLMwoRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QgKkg4iM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C/BTFIHy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBW4Y020127;
	Tue, 3 Sep 2024 21:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=DHP/CIGTEYWrjIc
	Ig4no65BI5dWwPeyqPWAU3j7F+oI=; b=QgKkg4iMh62FBwjmD4xTIHZl7+K5fcB
	2mVPOo4UaTdWk1deRWYy67pJVqAftv5qBZAOYIHy4Rx6wtXF3sgkZpK92U9pQHci
	kTIuDfOwDdcedPGMfVD6bSAz40J/mHdij3p0BnEexQqKJ26C8lhg7Vr02YeXxCh4
	h6mB95WAxmKnBVvyMHV0OxUoA1LQUXEF9T5FfH2K2E7OA3XP+58IZkvpyncqyxrN
	XUk6JeOm1+1crosXrqgd22YZwkll3nZ0hxoYepob7um5/S2PrefqZh62+C1x4Lr+
	t+sMxzC1pKzEjSwBsNEAB8PYNcEE8TRbIRLkMpWZBmiAYsmqN1BbJSw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj23a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 21:35:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483LP626018372;
	Tue, 3 Sep 2024 21:35:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmf9m2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 21:35:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THdxg5LJAcsDPUWmRTGuZktO+jKDPLnFK3dLSx8dFaaPJHN8c+nJtT1sqeiocDJFK5cvHaTiq/A2641BUrlFFNmn1qDf4PZleEy1vjldR5qyBOgsMyBRJgZrhiRrloA71MkX543Wax2X0Txy+SRuGiXlwkELWK/Q8s4NTke6CseMn1CDV38vKf2zuSMNYpW9heK/yrCFwBJTqzM5MylGZeDGM1T2Hb/sWq0c4ajA8/KM7v/pG48i+45wee4DFk0YZgcpYyzxB18ca/f9kQ30NI6oEBl8AIbA83lgtXt0l2gbWwjhJ/NZ6t1499jz4H6RM/pGrDpi3uEOzTOlYFx20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHP/CIGTEYWrjIcIg4no65BI5dWwPeyqPWAU3j7F+oI=;
 b=x9pjVRhBsPab1cz6mVt6IXUcZcnrvsshx/TWskbXAVKD7CyRe1ZFslUugAUZ+25BDTd7O1kl8reym1rRsNcFeIt7EgUgWYp5Jnt7zLW1TolBpMPmNutSE9fV7MefKzqBkoiG3SiQVM7BfmKYN64EBLQ+sT8bHTRIOcGVa7i/AL12yZIeTuqb4AE8POpeCqXP7HZd76OO1CW2NUhx4v+F+kichDmA1BIrbogDgZ16Kp8s2yz3zbUh5l/NK8gJVf7XMX6JtwxMTnm8O/hpGodSsn+6+y1tIA5rmi2WrEZ7L2TfqX2YFqEswNtmWWoZTKQLA2YSA3bphcXpQgSDsPqoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHP/CIGTEYWrjIcIg4no65BI5dWwPeyqPWAU3j7F+oI=;
 b=C/BTFIHysJEZKLxKOap+/Wl0i378hf+hx74fF3Q+CDru1Xr4EXNwArMHvYjylKj38M9de3he8P9MIVwn9iKLiIFJxhcnAxqDRXsFuAMwyg8S9e35rsd4ZsRDdhGSH9uF3Re1ZOO3M+hGLlVHY3JyXJNp/NffptnYSxk5WhApxaI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6282.namprd10.prod.outlook.com (2603:10b6:510:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 21:35:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 21:35:09 +0000
Date: Tue, 3 Sep 2024 17:35:06 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
Message-ID: <ZteBCowxVXt7DLFF@tissot.1015granger.net>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903111446.659884-1-lilingfeng3@huawei.com>
X-ClientProxiedBy: CH2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:610:57::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ad12bf-ea60-43a9-b6ed-08dccc60492a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/X9im4A8TO7g0T8SqbveGzmWIGq6poUGNdMKNaxgJ8Un6YOYlc63cWdJu/h?=
 =?us-ascii?Q?kqnnD1CDkfBOobr3CCTXDuFuiOqmrLOJTy3X8vP7xe6trylEsx/FsPsOwQjD?=
 =?us-ascii?Q?+e4q4d67tIHc/FrWZKb7DI5qWntURgPjbUBVZC4wETEjsUPWQxJnMweZLHaF?=
 =?us-ascii?Q?KMX/l2LyZda4NjqvVmO1Q2j6XuBKJvbwhiTALtdxyAEiYYON4b0b7T4O4riH?=
 =?us-ascii?Q?jrjuQoECjnJJ1Jz/fnWbQVogUpNtWB6ygT2VWxA0mZHKs/SqcY97m/HmZv3Z?=
 =?us-ascii?Q?L720ByVtovd6bcs8Dkxe/k/S6tCTUScudbls4Kp4zOxBGx0QH2d6L23rlnx7?=
 =?us-ascii?Q?GUV1zhj3Oy0o8cEZTFITmmZ/HWn7rVz9/yMTjmjxZNE5vWCehwTm49qC+4yX?=
 =?us-ascii?Q?cebAxEH6jQOe5GEZlenzEYyEnvnpxGwOPAkxhJLR6UnLxwshLd0+yLfPjxtD?=
 =?us-ascii?Q?Qc6axqFafzpsI3qIIVa80ruPROrHbIAh3ne+pcYnlHxetJWaX/ORuuOolA3q?=
 =?us-ascii?Q?RfGzbms37+b/LrTBqSV3+FHZQtkwhvONG/9WJX9iL2LrnScGGMj3lbQyxRYC?=
 =?us-ascii?Q?AFQFcbPm/HBF+mNU2AFvNqAtA8vsXcRNuNEBCmXjG20aF1hFTDFgkzS7vrJH?=
 =?us-ascii?Q?y6uzsmkHA3mm9BX+Ysc3bLpJXeQ4dhSgtg9NHBMGEYea1E4rPr9t1WRQFsNq?=
 =?us-ascii?Q?/ptVuqoc+A45mEm3FtQyp2SDySsOxzRyUqg1zOGVOeoezg3JMl+IMwljhkoC?=
 =?us-ascii?Q?QPpZChk58bBbCAbwJNkfz3yCeKESWHgrk6sV3uvqPXx/0X9FrvPZzlCcNdY7?=
 =?us-ascii?Q?nHdS8h29VJ2Xvyv4hCCqBPTD5n8PHKsj/pOkkSIILH2PVk10FTT5qvdN7QXn?=
 =?us-ascii?Q?lm+JMJ80YwM+pcmwHUw7Y8xibj3xwZJ7AjjMElVpVhewNTcWPBBDjeJdTqYy?=
 =?us-ascii?Q?nLjg/nfNltor/gDw1iZzf4WaFTpwF8N2N2ivSYXA9ulJFO/N3y07OK3rwVvO?=
 =?us-ascii?Q?4Cuu6M9VEIKi7HuTmN9uE09eGkPdiB/aGa4j/gPtLDOhqQv78Rcea/BzKNwi?=
 =?us-ascii?Q?ATk32glEC8I2K2x85xBBFN0ScWi2BqG/gHYkvS4cft3mP4SM5kUFb3bgGn8k?=
 =?us-ascii?Q?eCGQiPBX9Gt4Eg1VB4oIZYo3HJeiLjUys8pBWgYsmQrP2bun3z7AjS9kkZEO?=
 =?us-ascii?Q?uIrmpzBLF7OqXnBmgBOaMcKlchKpJcLMO+L2yClJnqMDM84d3jYw6zV0+4gI?=
 =?us-ascii?Q?QzRHiXB72IMs+WlByybvSfckzBBzzLhVidJI+iMiZsTt+aHeGI1voqN1f3B1?=
 =?us-ascii?Q?C5snaEnW2SBl0e7E2QhJDrKwX0WEgADVkyX+7uhe4IxIHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y5fXvBz4P6KhUIY7kNW8aMjFHwBcor4EizyUjxudoHgSP8ECWrRMqgnCdmJQ?=
 =?us-ascii?Q?kcGycSncOhL1goF+Oml5N8373dD7C0680a0x3eSwrrUe+M/hQKhXJISh2/WO?=
 =?us-ascii?Q?7+mfxziQgWTqgZs5W+IGaNusJK93HZDzD6/gD8k9ZIG5TjvE5nI/FrToqLG1?=
 =?us-ascii?Q?TbBpKQxrrPiNlSIgMbJdio8O+BhzbesBQCRvXLUUpWAJ6pv0yQUTF29IBXM1?=
 =?us-ascii?Q?p3R466Vgwc4x2Qly90Flu4HWlyKo+w7KAUsdmTMOlt902JC79uvrayIxxNvW?=
 =?us-ascii?Q?0zFGCY3x2k6Tv6qYB7e2onqLIAbXrGyTrSY8ASj13eWHy7Kc7V4eDYFLZVf0?=
 =?us-ascii?Q?LEzlMa5+Q9LzKcUMOCVmn1v003hZras/lvjbZSTeQi29OAB4aYQD4w8Q0rDw?=
 =?us-ascii?Q?Edt8EXt9ROr2+eT0K+cKRSd3HE13wOMVbQ3syMB9bdvQhmFat+cw7axdxpF9?=
 =?us-ascii?Q?yMwWYkj1YukSJ49QWpUJRKtv6NkkFi8uClWmEZyU2zQVpp+ZRHKftoPYsV+o?=
 =?us-ascii?Q?oTiYWx/kjBvUDx5OHkWoE6o9/mEXjadLjcqHMz8wwcOQQdnwhaeUp0+5LbBT?=
 =?us-ascii?Q?TJNvNOrRSk2xOrm+edDbTnURW29jlckL5GKJCj1Gaf12jV06zce/pmwQnFvI?=
 =?us-ascii?Q?eGZYPC3VLAba6eDQiO4ESJqlcconm8PT4FWvIM/GN2egkyjXG2F8KsEv1KX6?=
 =?us-ascii?Q?UzNxbY/uaVvG6w11jqHf6T2X0RAXLFE64nZTqM2K9f2NEcPhNV6tWP4aPP7m?=
 =?us-ascii?Q?lNa31rBJyhLFp+o7wpiZkOEuF5PPd/6zWd8mIhVOiR0IQjAwz+9UWortbsyM?=
 =?us-ascii?Q?sZBvXW/1V7VsncXLYVLuWoJKZ/6jj5WyqVJdS2stT3aIak00nBTC3Z70Eths?=
 =?us-ascii?Q?Apy91hiaKQxLOLu6B1ilu642u18ZebexuDKkZDtApXrgpSai2SRdEsO/Aji1?=
 =?us-ascii?Q?aG1RlXdc7/UijzZfsU1fC4DOakWovXXTMGYdLCp+RcqUvXUZSiPeIFx+VPZe?=
 =?us-ascii?Q?eG6C7qRnR93q9GN77DwqJsLO5z9intqAaMfH2HD2Tl2AlZLS3U6vW0UOR0rc?=
 =?us-ascii?Q?NtzX2fXc/OxhpYVnXEdSWFKAINm4KDYB0P4w+E81LbpZA7+pq1jDhStc8lKm?=
 =?us-ascii?Q?YXAWlYq5/06GH6ru4+3gc2SCwP3wwiLiIctYtUi/8M6Uvh/l9ETyNSwdLW/n?=
 =?us-ascii?Q?aPMi7DywCG43kMX7SxS+VKLE5W1Hr11RHXsg0kx6xdweTGfZJTxk0dyfoCqO?=
 =?us-ascii?Q?N9+zWlbdwqV/cwAhznUTaszym5KIqtRUYccNDzrAJrvHi0CsxwRk3e+Ttob6?=
 =?us-ascii?Q?keDu6V7l7BMqQygQ5SIq1k5fAhUZHU7NmK6VJlqCybeLAoqEfk5RI8QWpPyc?=
 =?us-ascii?Q?w2Z1ic82lT7KaEAYw/LoGjdCFii17zJoEy80LIiCgDSLzd3RUApJysX9KdJx?=
 =?us-ascii?Q?4XpjpgBWrtHT7u2GUc8HEafaijQFBndgz10p0gICk31yurdv+mT8ZNyvY0wN?=
 =?us-ascii?Q?jT6faymT5JtPOFylLQs59r3HpWIUhXW4Rhn/t+EAaa7aict/0c0MCGCfQWiM?=
 =?us-ascii?Q?IrSSzn33Mn7TmDsMDEh2duJWeTWPB1vN+rDI+2qeAZTedVbYZ2dEa+pY7yHB?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NniQ2cqG95ZLBrqYSDKhg7fEjaT6LASSgAhCHrNnmAQ3j7ahjVM6ThTZvFA9sBNz6nNTn1tyATk9PU4BVKA47xP+/NrIosFE5em2i8kxWO2cotvgnyjA7Ea+EnP6iZA7tXdE82fhqK1QAH2yBBG1iqR+gSnRZU3MrUZ3i63Qxk7VRCmkh2n8FQEcBrHKDcRvvNRKvKThyD9L5okY5WP27f/p5SuBT0yidycworZ56AejpOoBhSr3X/aPdGnF7TMn6baUdSOupqU7hgPRTsZOgSCFta4LeynkyTjCzJfePJrgnNzQEo1uC4mIYVgPRSRKeKZaCuKdV8OECDm19OCi3mdPQQQKwm4BZH9tTnCO/3LASZD/2cg2GZNf+jGSfZIgDoVSgvDJmp/Cc/YdT3dtYjkXXp1MZgdq0qrc4MD6i2zu+ZfdPJsT+zNpS3S+F7qNbfCi29GD1Ow3UZiqj4CN1q/NnIAnbHFAvhQ/aRgZHkjjFGu8XODo+H2N8ooCPHrwEnK2CFjb2F9jAYt6TxIz40UqSjJnx0hJ9LI45ULiGQdni+d+jtwnbXYv/s0IdKpd6Nd7HKpTvdkchYzQKe8eIetJS+hzW1x4z9MgeaSDxDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ad12bf-ea60-43a9-b6ed-08dccc60492a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 21:35:09.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhK0ZjPv8v2U2h7B95Ion061TvaILI1ShmZiuYhSLri+i+C7TvYrmkvct4jgCcRDmR11tyAm+OCG4B3XmWc5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_08,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030169
X-Proofpoint-GUID: gy6YMzw6GaWxRG-QCHqgSxKr0BffcAZ5
X-Proofpoint-ORIG-GUID: gy6YMzw6GaWxRG-QCHqgSxKr0BffcAZ5

On Tue, 03 Sep 2024 19:14:46 +0800, Li Lingfeng wrote:
> When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> result in namelen being 0, which will cause memdup_user() to return
> ZERO_SIZE_PTR.
> When we access the name.data that has been assigned the value of
> ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> triggered.
> 
> [...]

Kept the new dprintk call sites since this is not a hot path and
there needs to be some observability here rather than a silent
failure. I'm not convinced the error text is especially clear, but
I don't have a better suggestion at the moment.

Applied to nfsd-next for v6.12, thanks!

[1/1] nfsd: return -EINVAL when namelen is 0
      commit: e492841732bbce2b2dd19cd285d5e7f61b1bdaee


-- 
Chuck Lever

