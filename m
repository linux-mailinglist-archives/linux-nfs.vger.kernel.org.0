Return-Path: <linux-nfs+bounces-5320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A794EFFE
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C380280C2E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258451898FF;
	Mon, 12 Aug 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pvjna2tH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JS7YvM9T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C754189526
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473748; cv=fail; b=J211iL7PTcQsHmwMMCjdHnzmJYkvNTEAuvG1DCxr9xrrqBOmBFAkpVz1N4GlY/Nu4RoWaefKsPKiQV+XovsVP0opGeHpVssZ7MT4oljwAmY79M69smAp971Ysph2GicCBYU+NIf6BODMp64cfNSHlpzPXVTaMdsanRHMFT40sY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473748; c=relaxed/simple;
	bh=h3Xi4xfP53jXlD9eLKBW5ogW6TLZSQ3q4ZYiw1Qro5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mELlK6STO7lqRsY1npE6VJJB6eL0xhQEzSIpurGlZ/loxcs8yXyTj6aXpy2j/KbELlOV/yc6AjPJUeV2wjBeXWEg9sBDLEjEhlG1EZeK0b2KqDksfgpATSWS/UBTou9aAyh2KoqjT38k/FVgKcKjTbEsgYhIs9i0Esakkb0KAaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pvjna2tH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JS7YvM9T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C8wlaZ022878;
	Mon, 12 Aug 2024 14:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Up0TB0xAzKnY5YL
	VUqPiNMnko1LVo3gg4SpPvA50tVY=; b=Pvjna2tH5KqItzT3dXiaoha2vt300EE
	6Ycg4eqsgwaBB7e5yY8PoGauj1mFUzhWAL8DUi5Nin0f47ilyUpn21rpnldzftki
	XsO1PaN3Q4HPdMmwqxY3ZhpzOtDDBONkH78qKl/0qUq3DWUs1BPCdrMPFSp57tjG
	NmmzkYoHfAC/S3g3NCXECskLhW/DM9XBO9u0UuuNSkd//2oFgtHNAP8meC2OyMML
	S0ZAzz7o8jbMRaijv3HDXYDBgIW9zuM2dZDTpXihFnUlEGNqQD60JfjWsnCuHQ2C
	8IK/IFxb6O9MrudLiuGs47kOPAUSXknIeyRl90o223pquMlQQwUfNWw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtjrem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:42:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CDb7l4003771;
	Mon, 12 Aug 2024 14:42:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn87q8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI75ty306MG4YbpdZ5GfvivyxCzIxwmEoR74/AOpiy3HVFtgzZGERMo70TMFJGzCrrMq0qFXADR148OqcfxQZ1QFTlICzLLNOFq+m/emyyV5WsTX4RDQM9+63rVa7SIV0VCM5M+BB7MSMDNGEFIffjcvlpZn1WSwaqa92Z8O+1HY1Px6QRvdm/YX4xx5v0lp57vL/a/wvv6JxzgAb1S9gY5d48p5/IDeEK4XLrcN7H2i/sEvkwPHA5aJOUtFxh3jf3cppr4STcrTK/GFos2dPtOm+wQSevJL0wFRUWzeRwpQ+nPw1Eg/T1Id8hoy722MeI6tTE0QcK1A6nUvCoXQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up0TB0xAzKnY5YLVUqPiNMnko1LVo3gg4SpPvA50tVY=;
 b=U/U6WeAx7lRAyo/FnEht0iUKtnNx2isfEIEFEy1YbwvOhx+FWsBlKpGeUgRlJXYSbWXwmp6smcPfIXxtWvYFT1cgJ/i3Bp+AUx8VKCu5gnl+CzAmyvzpYEA0WfQLsJy33VFUU8fGIfOrw/VInvk66VbjB4on4utjLcgPee1hN7/3aplPcl1XPeAj514sSF+jF/KHZ8TDHnsZdAtaZLYLQebFhkyEw4mrXtLnVHiqiU7jBTvmf9Oy4zm1VXwlAuTi6tVbrtUzTc4yHvlthHoynxxqwhsoh4huWI3d4QgvFgFgX82RpDv3atijRfeiZ2txADDJS8t/mW718m2S8DM2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up0TB0xAzKnY5YLVUqPiNMnko1LVo3gg4SpPvA50tVY=;
 b=JS7YvM9TFePTjQUnNG9zVxT8lrGz7Z4wICxvzfj2fmfZRemS8Mg87aguz6LGyYMXjWMTXl09Lc+Jy78Lgo7hO6SORUlDa7cqTiR1YL9//6CXjMbS3FCO4WK936AncJXKV5c7pTAxtMfsY6i0spPLTIHOBOAeYN65kEuy2lVl2sU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5902.namprd10.prod.outlook.com (2603:10b6:8:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.15; Mon, 12 Aug 2024 14:42:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7875.015; Mon, 12 Aug 2024
 14:42:16 +0000
Date: Mon, 12 Aug 2024 10:42:12 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SQUASH: nfsd: move error choice for incorrect object
 types to version-specific code.
Message-ID: <ZrofRICmD8kDFP7X@tissot.1015granger.net>
References: <172343558582.6062.9756574878881138559@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172343558582.6062.9756574878881138559@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:610:b1::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 415bbe27-2819-4b95-cea3-08dcbadcf5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3N7086uCQMA1X+ILbxWezskXYDhtcy7N0sKXfgrQOHZEAUEKQ1NGdRXq2iRs?=
 =?us-ascii?Q?Upl0SeIajZERg011tnz6GfAZ/uajZ0xyJvwcT/6pVb3mrk8VvvwK+UfjTElq?=
 =?us-ascii?Q?hmyvt+uzaVgHlVKJQd1skow/kKpDlcCUcQu50DjME7ffA/pb+0tXer6xplrO?=
 =?us-ascii?Q?GmRpN3refGuKN8O1VxEvtQdYlBsE0Q5Zjl9hT8ND9273YcDVnKVjD+UpYDIG?=
 =?us-ascii?Q?41RqRHeOkzH9PfSPvAPwec5JY9/uT3Vlv633+DUqPvbInkj473nDkdOelRSL?=
 =?us-ascii?Q?KGGYu5hEz6YXpp4VjtaQOdAuOAcGb/sQnbf17cFktYnUEw1T8o9z2O0MzrSp?=
 =?us-ascii?Q?zr1+ZeUaKwQm5zEp8p2DP6wFrbxZyRX2yLbS4SO8PPQ13ntW+gBHLwNoBtSo?=
 =?us-ascii?Q?oQfkugLTLk21wzDn5opYwqFRD55ZDB4W5vv3Ie4CtjcHjRuabOD7v5RCRIpv?=
 =?us-ascii?Q?J2MCCIQTf4TBO/yqXGdS5McQxsWVyVtmWKwmG0c69wKzKLQDmSXcDYebBh58?=
 =?us-ascii?Q?hml5my6FaqJiL4GV5eUU7Q/+yLnuIe3k8v2K7K7yxi/WR3ieM8/kTARtPGnh?=
 =?us-ascii?Q?4PWtziJZA1JOUh3eCDT01R/UJqeKUMaGuWd8Ad7N/105mb+cnJvIuwhYmV2i?=
 =?us-ascii?Q?idonSA6DQmv4rqFgwEGHEWSK6Vakuby+KvWp9HrhZBtO6MXBNeGsEvZcK3JB?=
 =?us-ascii?Q?9/AyTX+wcD2xc5TTjLnj5rKEr1fEnsieg4AHnP5FQVNjoOA905CGSQE5Soq6?=
 =?us-ascii?Q?PwNYt27avph53X/6JDEVja32EYFxmal3vD8o7i0YgJ5xlovkRE6QQRIZxRIk?=
 =?us-ascii?Q?H/Z074sVw6Wnt/srjz3GzIZ1EeGiQeDBSeIqY92cTxbMeGEmpi1XGuGYGbpx?=
 =?us-ascii?Q?ZurgylQ9hPqAwTxVxslPm51t6fv/ETUBq0BK188OKgTIF3U11aXhNSTeAcvU?=
 =?us-ascii?Q?lKoxbp3IY6ZFs9gdrk/ZYdqWaqrYlxx9NdTZBr0vhwluPK8bjfuhMadr1Q2X?=
 =?us-ascii?Q?J7ee15AjB6Uw20JPi2Z0bnrPjeMXWKxgJrOJ3eS5mEaORWWPXTo32c69dpoa?=
 =?us-ascii?Q?+6I3gGTv9CFcf6PKr0vpiNjYLbXGxk75m94s8MEDplU4bsgtZA8Mm8Zug0HE?=
 =?us-ascii?Q?DHoPYCpIYxjlrwc9Aquygwt6v9jp1UB0CBrutQNAmvLlrgbybSHOjSuJahUb?=
 =?us-ascii?Q?9K+6zRizJ79UT8QpKmitj0KspFLTHw0vzv8z+NC7FKH7fFlw7b+a0Isr9G+f?=
 =?us-ascii?Q?UdjUsUcXJZjQJzk0sMQfc5ZN8UqYV+IoS8gCPJDbmZ1ZwMyL4IJ732GlFmmQ?=
 =?us-ascii?Q?iVdXFR6idSqGkHZbXrOUw0Ba0RTjnv3a/vpLgiu/Dgxxjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miSbXJW9Imy+8k9j5dAZk1KzEezJyC7eHGmPIyCwovWm9Ub4rR3tFIsW8UZZ?=
 =?us-ascii?Q?8qCPjjE63Wxp0WSCnhAC6bitpiahwQmW2y+dCOsgfIJRZdXV3TQq/lfU8X3Y?=
 =?us-ascii?Q?t3u0BzkCBU7jtpWImNJgUIrkdYOsouqie6BsZtGwyKQ3SRIFbJgzDQSoRltc?=
 =?us-ascii?Q?YZYJYEMfMpth4RO1nHPD3fOl5WeP929q3oC1GFxfRsabRtMy2sU2duEJBlD/?=
 =?us-ascii?Q?NFGQ54vTWXBwYhfsvXa8f/gOCbc1S8WTRu4M60bLKBENEmTATnNx0vQG35g7?=
 =?us-ascii?Q?jvX2k6MZWQ5Nj6K3YgENPXqrRrLU79+cugLQM7x1l1s5mqcBLu78O7XSo4zx?=
 =?us-ascii?Q?zbGsoEVDFW6QNgwG4/RL2cBHNL4qdXWwh/r4ZYZz+KAMCOXs+m9g2ZS248xB?=
 =?us-ascii?Q?jokweCyWc0tGc0gOyJ0Wv2wxG1lLeOGr9HRJqwhQoeZS0nAlpfrFDjEXByL5?=
 =?us-ascii?Q?mGyswNLzwpoR12VMM3Ef81SEhcOW2Kx8KcB3uxypFOQiObUnn+47uppOyUib?=
 =?us-ascii?Q?7mU8sP1O/YZ1Qt+4RHCDGPj3qTswxHyw2ebV+7KkahFLSypRHpGioFOO32oX?=
 =?us-ascii?Q?bKkHopKIq/uqN/VYFMwcYMdYXqcOwbMHoJRRkFBVjCfVbnY/L9HK5HMyd3Jk?=
 =?us-ascii?Q?MTOXkU0cBPoqfB/WNNxTMZgElDvdibBZhIcjx4QBq7Hoh3Kn0wvDy2SzMi5g?=
 =?us-ascii?Q?dL+ttTzeyY5rG4ZfVGVNGKmQANvBM5hXiTgqIW6HRn8Nw6eYSk5+j5cosBeI?=
 =?us-ascii?Q?PiCZBHgmV01TvC59tMoex/vSFvosAWXTe4DysBs+nigiasUhR4/BFP2OwMjM?=
 =?us-ascii?Q?i4/XSMdCrQ+tKJQKLBeolQACC3GjM6/hzKG5gxxfltGwNrkYRoiQ917R+ZFQ?=
 =?us-ascii?Q?HwhRr3gpwl6wmxccFKvXuo95KmAJiwwKe0PzxynOt9fA755n6Fxg4ULrvleM?=
 =?us-ascii?Q?zq7EdYbK0AplJ8xkjHxRlofezZpCR7oLVSOsgGFL9CSQ1j8rEeGIpRQXopu8?=
 =?us-ascii?Q?VrzwgM3nJtyAvrk/XJFzcnFgsxpS+6DMFfi2GzdXmReShsRCENz66T4O2BuJ?=
 =?us-ascii?Q?TTGKt3GspQD2/HDeBcSdeW32skRCwvD/qLVbYnTkOLus2pQpe0s1FoJ64+zo?=
 =?us-ascii?Q?3XO22KbktBIuFSP21a3fvBuYPlyEDqYqMCKlCqxW0MLgtPdXWRaT/WJ8KPEL?=
 =?us-ascii?Q?x2Pt3ZW7QML+aZx4NQMC2dEBiBGD9DXQocJxuSbCkB/afshrdnlz5g6tHwme?=
 =?us-ascii?Q?lpBFUOz7QGaY5uL/n9OHXSleCvVceqB5m0g9Y9NF42wfo237sVaBXbqHHpBp?=
 =?us-ascii?Q?XfhV3S94YJh8dUPBQos7rrf8s8qIP7q14cGfEj/skHbK+OFuAyvE+fnV+mA+?=
 =?us-ascii?Q?fV/0YIUPwV8jSmRIsm5EMtNh69RLvigEYV4XgWqTdfUD4LmVEJC8PULO/5oA?=
 =?us-ascii?Q?+ianOKB1aeJWD3TCy2xpGjex9VHzOVEl7sAlhrcO7gaz8gyeQ7IB6Md3RfGB?=
 =?us-ascii?Q?bP2bsSWdnMyxCMOmqaiS+UVi/TwSS8vOWlhvG7+69otT24WDIVaM3Jj+wBOf?=
 =?us-ascii?Q?OnKsKk9HuStr7RRaiVmJ3K0t3vhykcVFg2mi/PjD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dAS7qrtQ8gj7BFHrLGYH6S7tgGdEPlPAlQ7cNo2hXBcUODPeBRfShFWdKXBJkFP2hVOR6aDXQ/8Odvyth62widYoyNwREUCtR6dSroEdedpb4qnbQOKbgquaaapbBf/wqtJoiBfvIEjp2X9g8AsyZJG03Pa0UAeifksJiz9Z33JPK71FDUN2ALE1ZMSxdIhHWnGBDkIrWPMgyQU2dKjWsTFXPX3kWVY28fwPWD/xIZlyIXye6RhmKJYkuWh6O6ocxwSn8qdNegiy5uMVVh9ZxsURIX2DiRZZ7MhiUEXOYalrVrPlQZlUhMOHcsqMjB5sXfPdbqYL2xVBvcT+q9pp9yBM+tUykV/XdL1d4igVd3adNkzEpkb7yUduvv0FWPbHuA/DQj8O5XmuW9DDvMa2jo/51LU1q7eDvQrYepVEtKoPB99ShYMMr+dQV5O1f2wtse7XLTzfLNPjEpVnCynaaMOPb8TA1JxknQajUkuA8No0vvKYjH57FTNkcuGVOVCFK6pj218VcWMU6Zw+sL8acTdrbSNElxrsMd0yyJ9SKWKTNXsGW+Rb++pYpoK4JVhTjCsZq1YuKw5co6lEem5Dt8UojrRJht/YCFzdL9LNMS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415bbe27-2819-4b95-cea3-08dcbadcf5c5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:42:16.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZULL2XnvIQY8ox69TG7wfqsgfzSUsbDPES/szHdtW/OFlLSF8BlgglXMSr0XfhTK/FKR9FxhqW3FVtcc0jUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120108
X-Proofpoint-ORIG-GUID: J-JeN7rv997V93zI_hRIByoQlGqrrEPU
X-Proofpoint-GUID: J-JeN7rv997V93zI_hRIByoQlGqrrEPU

On Mon, Aug 12, 2024 at 02:06:25PM +1000, NeilBrown wrote:
> 
> [This should be squashed into the existing patch for the same name,
> with this commit message used instead of the current one.  It addresses
> the pynfs failures that Jeff found]
> 
> If an NFS operation expects a particular sort of object (file, dir, link,
> etc) but gets a file handle for a different sort of object, it must
> return an error.  The actual error varies among NFS version in non-trivial
> ways.
> 
> For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
> INVAL is suitable.
> 
> For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
> was found when not expected.  This take precedence over NOTDIR.
> 
> For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> preference to EINVAL when none of the specific error codes apply.
> 
> When nfsd_mode_check() finds a symlink where it expected a directory it
> needs to return an error code that can be converted to NOTDIR for v2 or
> v3 but will be SYMLINK for v4.  It must be different from the error
> code returns when it finds a symlink but expects a regular file - that
> must be converted to EINVAL or SYMLINK.
> 
> So we introduce an internal error code nfserr_symlink_not_dir which each
> version converts as appropriate.
> 
> nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
> only used by NFSv4 and only for OPEN.  NFSERR_INVAL is never a suitable
> error if the object is the wrong time.  For v4.0 we use nfserr_symlink
> for non-dirs even if not a symlink.  For v4.1 we have nfserr_wrong_type.
> To handle this difference we introduce an internal status code
> nfserr_wrong_type_open.
> 
> As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> arg any more.
> 
> Note that NFSv4 operations are actually performed in the xdr code(!!!)
> so to the only place that we can map the status code successfully is in
> nfsd4_encode_operation().

Thanks for noting the RFC sections in the comments, that will be
very helpful for us forgetful old farts.

nfsd_check_obj_isreg's only caller is do_open_lookup, and the minor
version number is available there, via nfsd4_compound_state. If the
minor version is passed to nfsd_check_obj_isreg, it can correctly
choose to return nfserr_symlink or nfserr_wrong_type, yes? That
would eliminate the need for nfserr_wrong_type_open, perhaps.

What were the other error code leaks you found?


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4proc.c | 21 +--------------------
>  fs/nfsd/nfs4xdr.c  | 26 ++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h     |  6 ++++++
>  3 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2e355085e443..e010d627d545 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -168,7 +168,7 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
>  		return nfserr_isdir;
>  	if (S_ISLNK(mode))
>  		return nfserr_symlink;
> -	return nfserr_wrong_type;
> +	return nfserr_wrong_type_open;
>  }
>  
>  static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> @@ -179,23 +179,6 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate
>  			&resfh->fh_handle);
>  }
>  
> -static __be32 nfsd4_map_status(__be32 status, u32 minor)
> -{
> -	switch (status) {
> -	case nfs_ok:
> -		break;
> -	case nfserr_wrong_type:
> -		/* RFC 8881 - 15.1.2.9 */
> -		if (minor == 0)
> -			status = nfserr_inval;
> -		break;
> -	case nfserr_symlink_not_dir:
> -		status = nfserr_symlink;
> -		break;
> -	}
> -	return status;
> -}
> -
>  static inline bool nfsd4_create_is_exclusive(int createmode)
>  {
>  	return createmode == NFS4_CREATE_EXCLUSIVE ||
> @@ -2815,8 +2798,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			nfsd4_encode_replay(resp->xdr, op);
>  			status = op->status = op->replay->rp_status;
>  		} else {
> -			op->status = nfsd4_map_status(op->status,
> -						      cstate->minorversion);
>  			nfsd4_encode_operation(resp, op);
>  			status = op->status;
>  		}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 42b41d55d4ed..a0c1fc19aea4 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5729,6 +5729,30 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *resp, u32 respsize)
>  	return nfserr_rep_too_big;
>  }
>  
> +static __be32 nfsd4_map_status(__be32 status, u32 minor)
> +{
> +	switch (status) {
> +	case nfs_ok:
> +		break;
> +	case nfserr_wrong_type:
> +		/* RFC 8881 - 15.1.2.9 */
> +		if (minor == 0)
> +			status = nfserr_inval;
> +		break;
> +	case nfserr_wrong_type_open:
> +		/* RFC 7530 - 16.16.6 */
> +		if (minor == 0)
> +			status = nfserr_symlink;
> +		else
> +			status = nfserr_wrong_type;
> +		break;
> +	case nfserr_symlink_not_dir:
> +		status = nfserr_symlink;
> +		break;
> +	}
> +	return status;
> +}
> +
>  void
>  nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  {
> @@ -5796,6 +5820,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  						so->so_replay.rp_buf, len);
>  	}
>  status:
> +	op->status = nfsd4_map_status(op->status,
> +				      resp->cstate.minorversion);
>  	*p = op->status;
>  release:
>  	if (opdesc && opdesc->op_release)
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4ccbf014a2c7..b4503e698ffd 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -359,6 +359,12 @@ enum {
>   */
>  	NFSERR_SYMLINK_NOT_DIR,
>  #define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
> +
> +/* non-{reg,dir,symlink} found by open - handled differently
> + * in v4.0 than v4.1.
> + */
> +	NFSERR_WRONG_TYPE_OPEN,
> +#define	nfserr_wrong_type_open	cpu_to_be32(NFSERR_WRONG_TYPE_OPEN)
>  };
>  
>  /* Check for dir entries '.' and '..' */
> -- 
> 2.44.0
> 

-- 
Chuck Lever

