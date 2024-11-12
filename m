Return-Path: <linux-nfs+bounces-7903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDE9C5A70
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCB1F22456
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B521FEFD6;
	Tue, 12 Nov 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yv88tm7/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qSbwgRs9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A01FCF79
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421928; cv=fail; b=guulEDa32GH/zEChPVm3UIcqovv+T8Sv/h1GATLm38FLsSCOajOjRW1/oL5/G0WYXHiDs/LrA6760Ge4IAee23Da2w2qRgVinF3s+faqGH7nszkSdyvPsKvLbnXYZg8ktufstq8hvcq2cAcGE4AInhRlNx/Lz4bq6MgQqNlpVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421928; c=relaxed/simple;
	bh=wk2DyapWE6X7pYfdIrwxuSUifrGKSQ/imlv86TQOoGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YZBNe8EM64vOqnMspFcbpc/mZhq3kib9VZiMpxT4iWOCw93gASXqN/DpZsxZXfFlfWkfKTv2ZUq/vJ9PjyxIT+qRgWxhomI1IEiIe8HDKuaUYjmvFzt1vo9CcKLglSpHiodDojnI7eWfm5OBHM8Fu1JZAwVPO3de8BJ6ElMPevM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yv88tm7/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qSbwgRs9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDBd3c017156;
	Tue, 12 Nov 2024 14:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LFIk1cprMEScAHvvf7
	iB48Z5N9Clx10yy4Zi7cpjICc=; b=Yv88tm7/N1tJUWTmsopFx5makZTv1eC+zX
	j5OvnUVOEJ1u2D+dsRNG+jcRGcMAvB6inxpjSxEPUohC3Z59oktqbJy+ecrGpKX9
	MZzVgtlzCqnhu0QmTZhAphBFTAtH0n4MeR0N5BzJaZLd8WgpostAICyJrnIqq5ru
	4lBJDvVEjtybAJ7aX6eio5cToRhtRBoXffhFNoFZtO03ZWWIEfEQITqWKmS707X0
	IM7MF6a+yto5Sazq4s4Q9lJE66EiHXRTSdYeMe+h+1DkHMqs6yeaIDkPfp/GGUrQ
	0TJXUfgB3SxfauO+kIeUQ1bt6TTF6ml79xCQ75E0T2t8QO1e1Acg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k24fex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:31:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEJvAE025897;
	Tue, 12 Nov 2024 14:31:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67y5g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:31:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQZhAC5GXFd5Ai6B6QsGzthp8gBKKfzbK/0DvXATljhKG953yFDufVNyd2Uleky8t70Re7m09BuS13jqdHCpEw/0rBhfD/mXjFu9GT4iVVJoRi5ki15LwzPJs0p9I+dfv8v/5/nUaF4R5ZXKQo/8bxuiO5pajpuLOPcQ4+tkzbzBTFwFK8oi/lf9KB8F0COABGRN8llwNZHJr/kSOQqdWe6FEQAHkaH5mNaOl1yqqSJhJTC/1rN8yNj7xSA7ZNH4xaPremkwaW+bvhvAujtB9O7gexzTwxCHB13M4Ta/oqCh/CzuKQjVL2dDBnFn5XzfMXO56irg6R3EqHS7xAgjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFIk1cprMEScAHvvf7iB48Z5N9Clx10yy4Zi7cpjICc=;
 b=g+zHXmIRZswU+zlrz87hljvFTTVlg3pS6PmYS1Amau82UCOQpPhqHAnsRc+4sG9JVokijezWL0uguycgg2kdyhduJqWp+8TA0+5sOP56tz9PxUX5uO/yNU6Zx3Nh8EOvbRMR/cslvHRQd+KlL4EtjKVNI2CI61Vot2MldrMsK3+1w474IPS1gBXJbDdRNvUygl8aDcaTGvSlO1Q24avG6KQ7r0A92powPTxc9vx/GhF4YkbxskUl/RTrolnOY0tfGC30SehvLOpJvnUTxywD9hR0+PwPASv55Ekbb4DdPbTh0sds5eFOGUAYTnjmErrg6BHt8ox3F1jL5AB0wM4c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFIk1cprMEScAHvvf7iB48Z5N9Clx10yy4Zi7cpjICc=;
 b=qSbwgRs9AgdiHzNbbP97YnD624Nl9dAoIbFJ72qEnFn7oEG3JENbP1VVlYJJUeCeTr30X7opCMNwtFNIZZJoqXLUP3J//jxei2tgykC4hyWYS2BtHVY15GzAmNVYSRO7MdsqyMwFB7NFlae2jmRENLzClw6xBpwGvOCz1GXP2HA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7908.namprd10.prod.outlook.com (2603:10b6:610:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 14:31:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:31:49 +0000
Date: Tue, 12 Nov 2024 09:31:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Subject: Re: [for-6.13 PATCH 07/19] nfs/localio: add direct IO enablement
 with sync and async IO support
Message-ID: <ZzNm0hekxOyAUhib@tissot.1015granger.net>
References: <20241108234002.16392-1-snitzer@kernel.org>
 <20241108234002.16392-8-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108234002.16392-8-snitzer@kernel.org>
X-ClientProxiedBy: CH5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e53cd5-873a-4bbe-cfad-08dd0326be4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m0gV1UcHsd6W8abdSZ62nGpKUvblGmlO5OEnPHfYUWtxW7O0if/zqyZNr6UQ?=
 =?us-ascii?Q?tLS1MOqK94wa+RGFBM9LFkLJsm09PQkmLgiucsc7MMCo9bNAMoyfQ9CDjQhj?=
 =?us-ascii?Q?fCHtfrwC9LM/mlTnTIBVfngajKJfIgBaPwLCbKoOMKGQQYdUDeu4ICJU3fdp?=
 =?us-ascii?Q?iIgflXMvy3w0qyTgqVlnU8cDBbvOXvHDGMduWLB9lXzG2vFZEv5mIhGgBDW8?=
 =?us-ascii?Q?1VGGryUdl4uowHblI/fiXmgKV/amaGpzfOBz95iMHp+0gbbj7Qh6cnCBjz8b?=
 =?us-ascii?Q?px9fY7T1Z224Kr+UXyi8Y0+zZvkTnmqnyKMGWvAqnauAgtESWdWwyiIa3TAm?=
 =?us-ascii?Q?GPAbFv0mzniNKuOAqJE3gpHfoBSghwfg3U2crCibEAhR0cvUB6VeUjbZaZtm?=
 =?us-ascii?Q?frC04r+QMpjfEXlI76AY8hMFng1Hu3tPjFwZ3GRkpb+RdCFfZhJ+GEoio5go?=
 =?us-ascii?Q?rcJvjZJy8DadjRU726PU1ok9/MrfeQRLdgauhxvt/k+jjT+fRSRn7An1FfrL?=
 =?us-ascii?Q?VCSo2nU+ye/gzAPmelmu4nj/GFoGXJ32JLEakUnKe0YKGyRa6xOfvaXz1uiV?=
 =?us-ascii?Q?qZX9X0KUtk2sa85qIsl/1GWdJwd4dKkvg/wLbTIwB88b/DNjQht2M9zLGhFN?=
 =?us-ascii?Q?GogoXW+PJL9OJGK8ScxA7L++GIF4voFVoaDd3INWWRstw2bhJbtFT+mRSTtc?=
 =?us-ascii?Q?LValnWofsOHNEnsCOFkFhZwY/0FTFrGxak2qvJ5xEoyAtnaI6dHCHty4lfpy?=
 =?us-ascii?Q?FaICLkmCuvBUX4EbW5uTMm2vQtYS1KBrJK6m4QWmEogq48Nlfn90+NAJYAv9?=
 =?us-ascii?Q?gkm5S1tz46Q3ZMe3bSLyCT79yH8h6MaypDtF0BNRmBMi+jQZ2CcWKqTZx6Jz?=
 =?us-ascii?Q?zUZy0jYXF3d72dqR9zzlUW3CBgnJSJL9UrongE+HXZh5LNzV8jwS9zIXl2SS?=
 =?us-ascii?Q?25zs7WPMpmbX8kufkxmJJO+MHYzBGqWdEYfaPLw8w16BdsB6nLD4aFR3vsGJ?=
 =?us-ascii?Q?xSWcQxe7JOFjXxnNOuUeYsNGrv8Ny9eI+/gnO/0PnbocVJAvSFmjI3Eyuk8v?=
 =?us-ascii?Q?FIciJtbOfdSe86ELCV26LcMSEeszPOSR5rC/0xkO2SPmAxfGgsR41ZLXz5uN?=
 =?us-ascii?Q?rSGySn+DplvyaaTNwqCitW1EQCwHEYH3dFMdzVB3tUpc74uWKMxxydJi6ySr?=
 =?us-ascii?Q?g9wPHOpnRaY1jGJ5IgjsqyZDMj2/AExcEhFDGuxFfqrhJq4qKxF5F5FMY2xh?=
 =?us-ascii?Q?6vMGKC/4a8uy14SgkZMS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H78SlvoUd77hsKIcNOJZfOw0LaqE2ZpyU/zGFCn3Cjt9vPFIsAF01D14WNQN?=
 =?us-ascii?Q?djUsuDdY8edEKItVGyjOe5jrqkygI05uQIXp0B6054Alzlga9pIjpVmGEG8o?=
 =?us-ascii?Q?jX4wG5WexO3LxGXt7ftAMamP0+lgAr3Hw9wZ8qdMN5OjWonv6Dc7VNtQmHpT?=
 =?us-ascii?Q?+O2yOi3z8okP8VqcYIXqW0SZsyktfkMhVsId0XxossNcvzjUPFOnpKhAaC2W?=
 =?us-ascii?Q?upqMy/dV/DCtqBxyJsl5Xr5CkTMGRy439bzF6J3eriQwxiaIdrYs86iqiy94?=
 =?us-ascii?Q?a0tTsIUHxvcYA1a148ixejaOW8L9uYnnAyNdFy0NJx4v4l4UBYWTWoSlPFrz?=
 =?us-ascii?Q?URsXgz7m9ZrWuscBUfPrz1BQbK2VWFFJoFWP6XcD7fCL7sxLvdvOebH01mbc?=
 =?us-ascii?Q?auSH+Ga6+mYwUK3dy8HF5SzsD0tA37vqz/mEfGmoGSMm+bExIyxsjzKxdOeF?=
 =?us-ascii?Q?AGrweHY6q4ekcfHA5IbN2ycNRTFXIym+xccURycF7Kw/9U0OYMqtUhgddFAW?=
 =?us-ascii?Q?U8cZkyvnEdXF18A3fddLUKIL/rAvNfCm/9xBqKMXecg6mqx5ld1lXpRmbMj4?=
 =?us-ascii?Q?1TkuBf6EO4g7xginVg5JuW/Dhq4vX6ypzHtMVJc7Ib20CuABrdPBM0FIIJya?=
 =?us-ascii?Q?z8saextCf+g7T2iaI5EWZ24rg+Zv0zFthHG9ThEbvP0EzwH+J2D3DjIMszm9?=
 =?us-ascii?Q?vCSpM7BHYvx5UvpF74uLyTUc6g4Y8jNyhXVOS6O7Uou8ws2mXhdtMgGZlAS6?=
 =?us-ascii?Q?6YPCO/TygltNf2G/ziDRmXL2FrS+JxLGAi9k5NlX8gYfSoyaLCypIbPjKKb6?=
 =?us-ascii?Q?DNEs25aocQt3wAlKFeYZC4Va1GnDfqiBOPdSTcghIiSWGkZSncnRR5IaZhcA?=
 =?us-ascii?Q?s6mrU9F25XKuRo/imBnFpU5aBqAX2x1XkyWxZ4J03p9+S12lci3L2d0qkk1Y?=
 =?us-ascii?Q?MwZ9lnxnUhUFZ06SpFumKEyZh9/euJO3LzaOlbasFCLPM1RCHhm6DHeIKYIr?=
 =?us-ascii?Q?Qff8xHTAe57FoR0KbHxFOdgV6Rqw2L1RrvOML+YkHyf1wmXSOaV+7SsPAH1B?=
 =?us-ascii?Q?IB+jIDfHIPhdlYhqPRRq7yIN0ze1xt47EV8ZRCWbCHeeU9pYnYz2Mr0d+bfE?=
 =?us-ascii?Q?u8qt/3PZbCOE78PgS2Sv/OcaTwbj245wMr+IGoEYGXibkKLQOflL6oHCSe8r?=
 =?us-ascii?Q?P4GUAkmd3tSVDX93+gIJg+J8jyJE3PXs1V8ug1kj10W3m4kfPHg19S5pInQK?=
 =?us-ascii?Q?XoF4hJvHQ4o3M6KA+1s+3dMNm50n33sVx9/uLrxoq4Ot+Vf6Q+/uVXuBAnNW?=
 =?us-ascii?Q?jOdfdojSc74VmlTp8s4NHlgulnm8u3nWC/6CMrHnzxjo2ari18lMDxMNmb1o?=
 =?us-ascii?Q?fHAzbO/MrqVDbDfJsyPeTrGRt0snXnLgDezk6u85yrxMJKCoZBeGe9fzAZT3?=
 =?us-ascii?Q?iFUfrtns6qU8OCkpmdstZoPyQXHqtINDGE0kZx+woeH65Uy8HPd94EGlEHJQ?=
 =?us-ascii?Q?4WJoHOS00imR5TUlYOE36JqWzH/zd+Gk8oxrOBVJyDCrltmG4lJz/xHiTvvP?=
 =?us-ascii?Q?49Yb4yD/UMCZ4/0bswXUNSuipyfOwFd/muftGXPBmmzR1IKMdw3Y0PjCXQ+L?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C5I4u78JRuNyuaNy5xe3n6Tf63xuStk8svoTiYEL3fgU7fftpNBieH3vWMoKHcQFwOgWJlCDmPsXcJXWkSUq2ME8g5ccQWfsTmOd+hwRXU9dHYU4ss9Sf3EDIKLqyK/a9P1l1afns8jrOIbREcUU6DtzFjOenl/hn4dmjzd3C1Ooh/ZxkOaZWiuUgmX4Fptzr2by+Ne/VAiEPV2xYZYL57e2oUB9lm4SjaSiDXlpqjPG+HeAV9G6BvjE0M47zq5mqs9z1icwjp/nX8mvV+RXOmldS43SWOhu52zD0hLak+5/zGz3HQJVQGLr5xh2YLO3M78GEsP7iOuZiJXQqZjN/jRguFyetBrdjxRTik1lWteIrQ7vb8YGpydbDGMN9VeEUpWBYUMHCUUW0uStsVYZC9764hItFkCkO3q4viZ+fLu0MTpBOqHN4gOu3UHFj2nWCwFRnmSD3S5iEASVw2QN8cs5ONyvhGFgcF1mNSvIq464UP/QpwgSg5vma4+SNAFURruexaLDrW5XxfFM/OUQ3TJSv/DvZsjLfS2Ex2NtvSQZPzGazmoJy3YfuRQpjmZo2S4uSORGrrpOoz0Aml3eopstqWCkCNuALvi/g5UyVIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e53cd5-873a-4bbe-cfad-08dd0326be4d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:31:49.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJj9absbsJx7c0I9q9rGNkHdf5Qqr1RJmX8kZqP8iJYuVY/9A4/JV2JBuIib4L9oZyPsduLLV345jZhCHjxZGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120117
X-Proofpoint-ORIG-GUID: hykSwxS74SR8lZRkeIKAFmqf87PZzGZY
X-Proofpoint-GUID: hykSwxS74SR8lZRkeIKAFmqf87PZzGZY

On Fri, Nov 08, 2024 at 06:39:50PM -0500, Mike Snitzer wrote:
> This commit simply adds the required O_DIRECT plumbing.  It doesn't
> address the fact that NFS doesn't ensure all writes are page aligned
> (nor device logical block size aligned as required by O_DIRECT).
> 
> Because NFS will read-modify-write for IO that isn't aligned, LOCALIO
> will not use O_DIRECT semantics by default if/when an application
> requests the use of O_DIRECT.  Allow the use of O_DIRECT semantics by:
> 1: Adding a flag to the nfs_pgio_header struct to allow the NFS
>    O_DIRECT layer to signal that O_DIRECT was used by the application
> 2: Adding a 'localio_O_DIRECT_semantics' NFS module parameter that
>    when enabled will cause LOCALIO to use O_DIRECT semantics (this may
>    cause IO to fail if applications do not properly align their IO).

I'm not clear why the module parameter is necessary. Applications
that use O_DIRECT, I think, assume there /are/ alignment
restrictions. Generally they are constructed to operate agnosticly
on both NFS and non-NFS file systems, so I'm not sure any such
applications expect or depend on NFS's looser I/O alignment.

If it turns out to be necessary, the module parameter should be
documented somewhere (maybe under Documentation/).


> Adding Direct IO support helps side-step the problem that LOCALIO
> currently double buffers buffered IO (by using page cache in both NFS
> and the underlying filesystem).  More care is needed to craft a proper
> solution for LOCALIO's redundant use of page cache for buffered IO,
> e.g.: https://marc.info/?l=linux-nfs&m=171996211625151&w=2

This last paragraph confused me initially. Above, the description
states that this change is to address support for applications using
O_DIRECT. But here, you mention a problem that appears to affect all
users of LOCALIO. I guess this paragraph is aspirational? I'm not
sure I would use direct I/O to address generic double-buffering --
not only does direct I/O have alignment constraints but it also
makes some assumptions about how the application is managing its I/O
buffer.

It would help me if this paragraph was dropped, since (IIUC) it
isn't directly related to the use of O_DIRECT by applications; and
perhaps add an initial paragraph that provides a problem statement.


> This commit is derived from code developed by Weston Andros Adamson.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/direct.c         |  1 +
>  fs/nfs/localio.c        | 92 ++++++++++++++++++++++++++++++++++++-----
>  include/linux/nfs_xdr.h |  1 +
>  3 files changed, 84 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 90079ca134dd..4b92493d6ff0 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -303,6 +303,7 @@ static void nfs_read_sync_pgio_error(struct list_head *head, int error)
>  static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
>  {
>  	get_dreq(hdr->dreq);
> +	set_bit(NFS_IOHDR_ODIRECT, &hdr->flags);
>  }
>  
>  static const struct nfs_pgio_completion_ops nfs_direct_read_completion_ops = {
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 4b8618cf114c..de0dcd76d84d 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -35,6 +35,7 @@ struct nfs_local_kiocb {
>  	struct bio_vec		*bvec;
>  	struct nfs_pgio_header	*hdr;
>  	struct work_struct	work;
> +	void (*aio_complete_work)(struct work_struct *);
>  	struct nfsd_file	*localio;
>  };
>  
> @@ -48,6 +49,10 @@ struct nfs_local_fsync_ctx {
>  static bool localio_enabled __read_mostly = true;
>  module_param(localio_enabled, bool, 0644);
>  
> +static bool localio_O_DIRECT_semantics __read_mostly = false;
> +module_param(localio_O_DIRECT_semantics, bool, 0644);
> +MODULE_PARM_DESC(localio_O_DIRECT_semantics, "Use O_DIRECT semantics");
> +
>  static inline bool nfs_client_is_local(const struct nfs_client *clp)
>  {
>  	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> @@ -285,10 +290,19 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  		kfree(iocb);
>  		return NULL;
>  	}
> -	init_sync_kiocb(&iocb->kiocb, file);
> +
> +	if (localio_O_DIRECT_semantics &&
> +	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
> +		iocb->kiocb.ki_filp = file;
> +		iocb->kiocb.ki_flags = IOCB_DIRECT;
> +	} else
> +		init_sync_kiocb(&iocb->kiocb, file);
> +
>  	iocb->kiocb.ki_pos = hdr->args.offset;
>  	iocb->hdr = hdr;
>  	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
> +	iocb->aio_complete_work = NULL;
> +
>  	return iocb;
>  }
>  
> @@ -343,6 +357,18 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
>  	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
>  }
>  
> +/*
> + * Complete the I/O from iocb->kiocb.ki_complete()
> + *
> + * Note that this function can be called from a bottom half context,
> + * hence we need to queue the rpc_call_done() etc to a workqueue
> + */
> +static inline void nfs_local_pgio_aio_complete(struct nfs_local_kiocb *iocb)
> +{
> +	INIT_WORK(&iocb->work, iocb->aio_complete_work);
> +	queue_work(nfsiod_workqueue, &iocb->work);
> +}
> +
>  static void
>  nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
>  {
> @@ -365,6 +391,23 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
>  			status > 0 ? status : 0, hdr->res.eof);
>  }
>  
> +static void nfs_local_read_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =
> +		container_of(work, struct nfs_local_kiocb, work);
> +
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =
> +		container_of(kiocb, struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_read_done(iocb, ret);
> +	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_work */
> +}
> +
>  static void nfs_local_call_read(struct work_struct *work)
>  {
>  	struct nfs_local_kiocb *iocb =
> @@ -379,10 +422,10 @@ static void nfs_local_call_read(struct work_struct *work)
>  	nfs_local_iter_init(&iter, iocb, READ);
>  
>  	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
> -	WARN_ON_ONCE(status == -EIOCBQUEUED);
> -
> -	nfs_local_read_done(iocb, status);
> -	nfs_local_pgio_release(iocb);
> +	if (status != -EIOCBQUEUED) {
> +		nfs_local_read_done(iocb, status);
> +		nfs_local_pgio_release(iocb);
> +	}
>  
>  	revert_creds(save_cred);
>  }
> @@ -410,6 +453,11 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
>  	nfs_local_pgio_init(hdr, call_ops);
>  	hdr->res.eof = false;
>  
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
> +		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
> +	}
> +
>  	INIT_WORK(&iocb->work, nfs_local_call_read);
>  	queue_work(nfslocaliod_workqueue, &iocb->work);
>  
> @@ -534,6 +582,24 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
>  	nfs_local_pgio_done(hdr, status);
>  }
>  
> +static void nfs_local_write_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =
> +		container_of(work, struct nfs_local_kiocb, work);
> +
> +	nfs_local_vfs_getattr(iocb);
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =
> +		container_of(kiocb, struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_write_done(iocb, ret);
> +	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
> +}
> +
>  static void nfs_local_call_write(struct work_struct *work)
>  {
>  	struct nfs_local_kiocb *iocb =
> @@ -552,11 +618,11 @@ static void nfs_local_call_write(struct work_struct *work)
>  	file_start_write(filp);
>  	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
>  	file_end_write(filp);
> -	WARN_ON_ONCE(status == -EIOCBQUEUED);
> -
> -	nfs_local_write_done(iocb, status);
> -	nfs_local_vfs_getattr(iocb);
> -	nfs_local_pgio_release(iocb);
> +	if (status != -EIOCBQUEUED) {
> +		nfs_local_write_done(iocb, status);
> +		nfs_local_vfs_getattr(iocb);
> +		nfs_local_pgio_release(iocb);
> +	}
>  
>  	revert_creds(save_cred);
>  	current->flags = old_flags;
> @@ -592,10 +658,16 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
>  	case NFS_FILE_SYNC:
>  		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
>  	}
> +
>  	nfs_local_pgio_init(hdr, call_ops);
>  
>  	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
>  
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
> +		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
> +	}
> +
>  	INIT_WORK(&iocb->work, nfs_local_call_write);
>  	queue_work(nfslocaliod_workqueue, &iocb->work);
>  
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index e0ae0a14257f..f30e94d105b7 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1632,6 +1632,7 @@ enum {
>  	NFS_IOHDR_RESEND_PNFS,
>  	NFS_IOHDR_RESEND_MDS,
>  	NFS_IOHDR_UNSTABLE_WRITES,
> +	NFS_IOHDR_ODIRECT,
>  };
>  
>  struct nfs_io_completion;
> -- 
> 2.44.0
> 

-- 
Chuck Lever

