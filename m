Return-Path: <linux-nfs+bounces-8108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12849D1D56
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 02:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCB2B2372D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0634CC4;
	Tue, 19 Nov 2024 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMGjCLY3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g/lBV9f6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C42745C;
	Tue, 19 Nov 2024 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979882; cv=fail; b=TdTPgW9Wl5kRVEJE1Lx4wTYjfLvLnNYGAXORnNdHSVFkGGtzmjVaynfsCNv5l5pQeRmcwhKigcoF356vwiKhHa4KvfEn/OBO+pzEKrWKN+PzwkKWlZmcLZf/+J0po/E7gQU2MPv6IBZHga2Lfyjt04QIeCS5y+uAcuKqlLZkCd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979882; c=relaxed/simple;
	bh=LD1uvacHrJFA+YtHqVWCOZlI3DQHhkr/BuZO4f6ospM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UwswywmgIc/yfwJuXqpQlRTxMhG0rRU4X6tdt3MsNbJKj10TEGTdTHYOW73V9Zt0V6i3GEnQIPSsLWfSy9yjscgQ/th7IUqgkN7s3h5OWoadK6gyN31uj/UDcKBHyRNm2gicMZ0WR7rPjXfM26Ic8y+Yj270BulZ/Ab4FRgcLGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lMGjCLY3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g/lBV9f6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ1MdAs019698;
	Tue, 19 Nov 2024 01:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CJQZIfnLx7yIUSDi5S
	OJqtov9iEEVML0+Y/ulKh/OPI=; b=lMGjCLY3Taalf+rLqoMfuXAvpNNeL6osuS
	ip/Z9vK4y/O1CQaOqTYVZyhIfcHHGIPMmrviqm0vvb+dPpO8NtvkYGXC6h3rLVGB
	KBBIkFbRM0MU3w+pKlOAVTaCr0uDWte00VbLwH4I0K/1XhVQGIi3EY6yDivg0jqY
	Ch+XIVhF13BpANDqoq6FAtQkFDRTuR/msJ9Y0ano5dxjItBcWjIb7nnPwKJrZnjh
	LVeWoJNXqixzNcJlfT5RiPosaqWV69jt8vRbVJOKyeJAuAL0xUqwcRL50bMdm+Xl
	ZxuFr5PvSq909eEfYXlMJBw90n76LtF3F5MahOZHb/vaKM5KD5LA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa40qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:31:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0en6c023213;
	Tue, 19 Nov 2024 01:31:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu892kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvCywQwcm4d8LuTglYoZ3XKQnX4R5Kp4YHtTBF6RD00b+W4ffEDrmInjPkSfMKz7IIG4TbWXWv5b0lbpggpY8nHxLLwCHsV2yhSAmXm6MeuMutSMRZTMeyhV4ljBXKevvitjadCouYjvB7uZEZzpjk0Rh51qXqtgOqGffYu8lY2ZSbj3iJOCkti2BWeHCO1dJaV5fP6MpUIi9A7eVJt6n09k3WkKqIE6tEzdzffo57dzm6Gg0MaBtLxnynTkBK9iYPexogTUjCucJ/o+inxHDx0HeZ9R8bn7kfxpQxobnHNb2+H2keFVS9tQJfzYusmMsDBCer1mrk0EK9m2jcNRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJQZIfnLx7yIUSDi5SOJqtov9iEEVML0+Y/ulKh/OPI=;
 b=sQirfh92yx3Ru84lsvC4gNCNeSEwr4F13GJA34elc0tWpTS2QZVISfzxgfaW89gE/wiCs5ba9p6wLSuJ35G5E8Q19o9iVq8bYDweIqKsoAnvBfm7KD0IFoQc3mYr5hwbChnxUS1DI+/vZwz9s7d6sNcZdlDUkn3h3+lOI/BrO2V0K/dKe8Xc8MBsfY2idRGoy8Un3XpLehwDolKcXkcbFPchKT4UDqBcBOxcECS9LgNtnZ8d4995CNbEwQaRNQ3+DgtyQKoK3ihc72qm3sgLWYuWyTZrgyPXeq061G39VNJiA5ktBHj241/dRttB7f+OtKRDA/iXqRyZ9t3SLdzlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJQZIfnLx7yIUSDi5SOJqtov9iEEVML0+Y/ulKh/OPI=;
 b=g/lBV9f6Bx5lmvSMG/Qj/+C062xJ4I+QDcH4OEcGVylwEBxbpuEYOyPMcGMTZGmfTMjy/y+8KO9n94Ul3X5pk2KQkoxDhpxO+weSw3xPnWSoBS9wkc5kje70Xl99jia/PqvWL9HJBHya6NSwHPJ2+cMLFiEqK8yKyHqXhhW2TCg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 01:31:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 01:31:03 +0000
Date: Mon, 18 Nov 2024 20:31:00 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Thomas Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] nfsd: add support for delegated timestamps
Message-ID: <ZzvqVF5nN1w9CObZ@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
 <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
 <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b80a04f-2cd5-4de1-7881-08dd0839d4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7adFc/WJYDt6BifRnu3+ZnyVPNPIi3holOW1PQcG6Q6Prv74ujxQonCC5E1S?=
 =?us-ascii?Q?OR2tfbKZXJarvI515UK30QGYzgvLGj2A+okUOXRzpJDyRlC4VUlbacXMumb6?=
 =?us-ascii?Q?PrdKeUUcD6ZvlwXrX3iyxgv0+33th62z+ZHNT42RORHbyvogn53Mmw2eClve?=
 =?us-ascii?Q?39f8ogmOQEo+yPCC9eOd5pJYKyVPKO0lNQBhHdEDmE1UBlz7BOLydxGOiXnY?=
 =?us-ascii?Q?ffz3pVXim+DbYLNZnly9P3VWjbv35WW+brJimzIkIf3XeOZivzHHYsRD4uWL?=
 =?us-ascii?Q?OQgaDq3Tm//hUQpub0yTcKNTIGe1qbXr8wa//QhcRkuWvC2mImb6n+M6Cp79?=
 =?us-ascii?Q?ofLEKbQXocxOxvQ9mIhOla3SStwJjx4ow6a165nVyh8v+agpX+mUWUpPBHNN?=
 =?us-ascii?Q?Y/QOdJI4spFtfGVx/jnnWo3IiRDI448E+qVvA29+5t6eX4pNXpdTWtOAdLl5?=
 =?us-ascii?Q?TPwoD6gCFyvDIpWmKzwmwLAfngx7qGNNoS1EmIpUON4+CfVCQLYjl0DrN1YM?=
 =?us-ascii?Q?G1CvYWtWQO81I0cQm3tEEm3VRR3iJxx4J38uz7Xzzs8uCEIPxsbxdjowPxti?=
 =?us-ascii?Q?pLb765/LSZRAGesRc5p66lkJUlKn4gaIzDpvtxo19MZwzn3IAjjLAz3GwL5l?=
 =?us-ascii?Q?g4l3mgDuyHSi8RWsd4XU/ouxx06aVa27kf/BaB1WR+Wb1nQt9hQ3E5dxgDFQ?=
 =?us-ascii?Q?3MK4JVPs9k/SDh3YyXPXQokz0pdB/3hyCS2Y6Dy6o92+CSdkkoYEpS+N3/ZC?=
 =?us-ascii?Q?HluIRQF6vyht5zzZVoWREimHgbguoB1S+Aj/PyNaQKYtDgny5co0Cn19ckXZ?=
 =?us-ascii?Q?XuRRYt8LnE92o9Jprjp4zgis+mwBFloeDN+eHo3Oy8Tw4w58l4yEWVZ1qszP?=
 =?us-ascii?Q?bF5ucA/4/FGNtZf9YqKKnPChbgJ4bNk4nJklC+qiNINDa9LWw1EKuPqtBSVf?=
 =?us-ascii?Q?m2r+Its8mXbnYk/25N4wArf20c92cdLdjpKO6wJ2U3EGVVdrzvdzn3Hm6qfp?=
 =?us-ascii?Q?pDZL2PECPwl7NI3s90ug6zen2yeUMyncgSr0hJ7hFpQDq/laYf8Vq9ej8ipN?=
 =?us-ascii?Q?aTIC3Ci0TYZoEsTeXeKkuszB4yVi1qTDNISCz1EyV4M5Lf4dO+reoKt8NI3z?=
 =?us-ascii?Q?J4KVLniBknSdGmBuRFOjycjpQ+Qt0j26ebNQ8p+TlWsTupkGk7o19vKuUrt8?=
 =?us-ascii?Q?AmfjehcMv09muqfAW+eCYgxuiYc2qPbxwiyXd9E+d7nMLQK5Jx/gEekWiMPE?=
 =?us-ascii?Q?DXeCzYKmQTI5hjDIBH4Ir/99cweeZgpkX98W1ZCfZM9PAb4kc0orsC8jnQfW?=
 =?us-ascii?Q?aBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w7lpRJr2gvABR1gYJF3S6GaR7u+7JRspuGxpWOIXmfBtIRinJuMACAixFmYz?=
 =?us-ascii?Q?efhx6ED3voBra3X6kBrEN3nRVcEA/npmKnNr2u93cyXmZtxryR7gZtHDSO2Q?=
 =?us-ascii?Q?4cNNpSnMwDtJgX2lwgOAwUTS8pxXGTo7RtvNqW0tjhD04nG0Qu3EERy4GzgT?=
 =?us-ascii?Q?SFO4WPadDn43q9kRjX1Zx5GhKQpe9/ZaqJ5/KJAPxWgjkFD6iBIzC7QNuHA/?=
 =?us-ascii?Q?x5AFUzj8t2W9L/zi/lugAfvKiNBU0yeWaWPgjbrkfiKtSiVEv8FCtNZRVsN4?=
 =?us-ascii?Q?gGV1bVGj4Zdq89kk6azV9jWwYO6wLC35NAHfw8nqhn3rBh4xsKoCB4FhSJD1?=
 =?us-ascii?Q?C8GRrBm/wi4oiqiayX/O+DKF8LS5hB9qjq4mvpMdNwq1MnEaxdbxglF9s6pI?=
 =?us-ascii?Q?HdEgguNUKe7HZ3OIeCruOUJvelD6ocDtAAC4dCti5fRFGlOGsMuGKUpBtB9+?=
 =?us-ascii?Q?zat2WXlpnshcf49jCTWleasxHAA83MB67U5vMbiRRpGwasWAM0bD9LOxOw1l?=
 =?us-ascii?Q?QT/wZAbj63wGObnDNg9lM58Xih7CJlzao+wl4QGa5VTwF/sLbL9DVkFKz8y7?=
 =?us-ascii?Q?6TarlLf0aQ0BDoM+UHhj5xtVvZC0TXAl86OTXY1rDRtODmyntJfUViMerD0b?=
 =?us-ascii?Q?kyU2PQ5wkyVGnYgDTJwLQbNcKdCt3HdnBZpAWWonGNaxcL2qvVAt/bL47/qE?=
 =?us-ascii?Q?5FHZAIKDxXSjabH+LpT5AvPkLhfJtQeKyPhHSR7lADUPO39J2hfEbxtTAfAU?=
 =?us-ascii?Q?3Ghn8XJMfsXeH/c3CYG4gh6dtVapyn3W4vsiQGm0h+sh+mFr39RzAi+L2fqV?=
 =?us-ascii?Q?3ijO6Xv99TDnDta69JwgfdVkPQ/E4Dw1YC0I0ZDTwtGr7ysso3MUmGEOcXsJ?=
 =?us-ascii?Q?8nq3GG7mx7Gy6Jnr41KKKGRFKWwb1ZTi1R387SrKDMf+lHz2ppGZmzIbXhWp?=
 =?us-ascii?Q?pPyDVZp3eUHMz11UkGxSn1sq9xG9/GIB6NzFaVTiALblLyTnEnUOYruBfY5O?=
 =?us-ascii?Q?Ylt712CZhP/f9+BzZWRjbWMrmFJIfzTq3QfzRf/MV5N6ofGyUCI0BvMPWPlx?=
 =?us-ascii?Q?Awr2QjNzAtkGv/t4pq1G1uKaV30siSQrQ/ApnxWwCJV+BpfuAkvM62vmI5D1?=
 =?us-ascii?Q?kJfjGLMUkVkwZr57C2hOsPzq6CgH8aTeg6+WKqfXfNYt0ANYcbnjGIW795ks?=
 =?us-ascii?Q?WCFHmaCF/uboIVf1ObbPlR7JsSE3PVBufCwztO5UI6370Tr8MWxV8ZSudS/T?=
 =?us-ascii?Q?xUm4jE6rFQXk6wPNthgYoef6xG0igGN7EVSS69aP9u//J23dcDLxpqk0KZI0?=
 =?us-ascii?Q?4mSV6CWAXFjKcpE4NE19u/xPKVWFugsWwB9V1bfTDFRjPoWKNrWOc3TkBLqn?=
 =?us-ascii?Q?AhJjmrTWuqkkQkdtdewExBpP6y2sqvcVsIqjGgkKDCgU1DGPqeY2nARA7Ohn?=
 =?us-ascii?Q?CompnH/ExaT+TI3kqMNyGzOyMcWVXG2Xs2abPmSUYSPYsceO2H7wYHBpX0j7?=
 =?us-ascii?Q?UFFpDXoARTJi1KcfRjVX5WS57+hUZQDNRY122U4lMKo2UVjq+GGH4NN9eBNz?=
 =?us-ascii?Q?vrWoeZ9O9s9iTvRMKFVY4tbgUMpQY7L/QUiSxXXn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EvS8nnb9L6MQI+RdUp0ELeV4ztpuEsSpGXYqEUmBPf/CY4M3SJ+OhqdZf2ChgoVw1J2uppbDRWtZqMEyd9/1LlWf0glOsdzafP5Kk5kSwNeFOVaCnyb5TiG1WW6K7A4Rqrh8n5JzJajYF7d2Of2YyNaooGMw1qkL99E+Q+lsbXZ+ACHY02iiPRYgkWSXSyd7vpi/AejGXXp1w3k4AGLU2p/1jh9wGtcsiqJ4hHQOvEYF2XCwdfw6c8OarfYGSJ4ghePJxbZDf//PXM/QnW1whuxOO0u9OSDz4PMuvuc6oDZE0Wq4innbAitMFCW5O2veL/rHINEq575FLEJxgW6zSmY2ttvTHFmvOeFswO26Pq7glfQxBgeOjcE6LxaSP0jWXmxpRLRpV+N9g3Xi4C+9r9u7mWrGk9s/yW1xgf0EmjelWTtLnmRIYkS2jfH8SXiKl6qogrA0nbjd7Gwi5WswSoXK+dqGD+Xewpat0BcKeD6O/9UZeE9Q3T2nwkBcmfjncEBISuCfBGTEKcuUbprCqu85C0UtJp47huei2uYSlJ/I2abYNrdV5Ix470arDjFgKIMlP212NFlEbuVdux4k0jLvsHM0ipdKyTALOInGEU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b80a04f-2cd5-4de1-7881-08dd0839d4b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:31:03.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAhHFo9CVIdxaBk8aTrWiMOHu8wIC1vG/glyiunYe/J3SUWgdVJAhX1liGln5hv+Q+ZZ+RpTv+cXIHWBZVSUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190011
X-Proofpoint-ORIG-GUID: nndqrXx0F0KB0SilZ-BwbzI_Hvwa75nO
X-Proofpoint-GUID: nndqrXx0F0KB0SilZ-BwbzI_Hvwa75nO

On Tue, Nov 19, 2024 at 12:01:33PM +1100, NeilBrown wrote:
> On Tue, 15 Oct 2024, Jeff Layton wrote:
> > Add support for the delegated timestamps on write delegations. This
> > allows the server to proxy timestamps from the delegation holder to
> > other clients that are doing GETATTRs vs. the same inode.
> > 
> > When OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bit is set in the OPEN
> > call, set the dl_type to the *_ATTRS_DELEG flavor of delegation.
> > 
> > Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
> > those. Vet those timestamps according to the delstid spec and update
> > the inode attrs if necessary.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
> >  fs/nfsd/nfs4state.c    | 99 +++++++++++++++++++++++++++++++++++++++++++-------
> >  fs/nfsd/nfs4xdr.c      | 13 ++++++-
> >  fs/nfsd/nfsd.h         |  2 +
> >  fs/nfsd/state.h        |  2 +
> >  fs/nfsd/xdr4cb.h       | 10 +++--
> >  include/linux/time64.h |  5 +++
> >  7 files changed, 151 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 776838bb83e6b707a4df76326cdc68f32daf1755..08245596289a960eb8b2e78df276544e7d3f4ff8 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -42,6 +42,7 @@
> >  #include "trace.h"
> >  #include "xdr4cb.h"
> >  #include "xdr4.h"
> > +#include "nfs4xdr_gen.h"
> >  
> >  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> >  
> > @@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
> >  {
> >  	fattr->ncf_cb_change = 0;
> >  	fattr->ncf_cb_fsize = 0;
> > +	fattr->ncf_cb_atime.tv_sec = 0;
> > +	fattr->ncf_cb_atime.tv_nsec = 0;
> > +	fattr->ncf_cb_mtime.tv_sec = 0;
> > +	fattr->ncf_cb_mtime.tv_nsec = 0;
> > +
> >  	if (bitmap[0] & FATTR4_WORD0_CHANGE)
> >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
> >  			return -NFSERR_BAD_XDR;
> >  	if (bitmap[0] & FATTR4_WORD0_SIZE)
> >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
> >  			return -NFSERR_BAD_XDR;
> > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> > +		fattr4_time_deleg_access access;
> > +
> > +		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
> > +			return -NFSERR_BAD_XDR;
> > +		fattr->ncf_cb_atime.tv_sec = access.seconds;
> > +		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
> > +
> > +	}
> > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> > +		fattr4_time_deleg_modify modify;
> > +
> > +		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
> > +			return -NFSERR_BAD_XDR;
> > +		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
> > +		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
> > +
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> >  	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
> >  	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
> >  	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
> > -	u32 bmap[1];
> > +	u32 bmap_size = 1;
> > +	u32 bmap[3];
> >  
> >  	bmap[0] = FATTR4_WORD0_SIZE;
> >  	if (!ncf->ncf_file_modified)
> >  		bmap[0] |= FATTR4_WORD0_CHANGE;
> >  
> > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > +		bmap[1] = 0;
> > +		bmap[2] = FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY;
> > +		bmap_size = 3;
> > +	}
> >  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
> >  	encode_nfs_fh4(xdr, fh);
> > -	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
> > +	encode_bitmap4(xdr, bmap, bmap_size);
> >  	hdr->nops++;
> >  }
> >  
> > @@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> >  	struct nfs4_cb_compound_hdr hdr;
> >  	int status;
> >  	u32 bitmap[3] = {0};
> > -	u32 attrlen;
> > +	u32 attrlen, maxlen;
> >  	struct nfs4_cb_fattr *ncf =
> >  		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> >  
> > @@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> >  		return -NFSERR_BAD_XDR;
> >  	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
> >  		return -NFSERR_BAD_XDR;
> > -	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
> > +	maxlen = sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
> > +	if (bitmap[2] != 0)
> > +		maxlen += (sizeof(ncf->ncf_cb_mtime.tv_sec) +
> > +			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
> > +	if (attrlen > maxlen)
> >  		return -NFSERR_BAD_XDR;
> >  	status = decode_cb_fattr4(xdr, bitmap, ncf);
> >  	return status;
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6..2c8d2bb5261ad189c6dfb1c4050c23d8cf061325 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5803,13 +5803,14 @@ static struct nfs4_delegation *
> >  nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  		    struct svc_fh *parent)
> >  {
> > -	int status = 0;
> > +	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> >  	struct nfs4_client *clp = stp->st_stid.sc_client;
> >  	struct nfs4_file *fp = stp->st_stid.sc_file;
> >  	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
> >  	struct nfs4_delegation *dp;
> >  	struct nfsd_file *nf = NULL;
> >  	struct file_lease *fl;
> > +	int status = 0;
> >  	u32 dl_type;
> >  
> >  	/*
> > @@ -5834,7 +5835,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	 */
> >  	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
> >  		nf = find_rw_file(fp);
> > -		dl_type = OPEN_DELEGATE_WRITE;
> > +		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
> >  	}
> >  
> >  	/*
> > @@ -5843,7 +5844,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	 */
> >  	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> >  		nf = find_readable_file(fp);
> > -		dl_type = OPEN_DELEGATE_READ;
> > +		dl_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
> >  	}
> >  
> >  	if (!nf)
> > @@ -6001,13 +6002,14 @@ static void
> >  nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  		     struct svc_fh *currentfh)
> >  {
> > -	struct nfs4_delegation *dp;
> > +	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> >  	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
> >  	struct nfs4_client *clp = stp->st_stid.sc_client;
> >  	struct svc_fh *parent = NULL;
> > -	int cb_up;
> > -	int status = 0;
> > +	struct nfs4_delegation *dp;
> >  	struct kstat stat;
> > +	int status = 0;
> > +	int cb_up;
> >  
> >  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
> >  	open->op_recall = false;
> > @@ -6048,12 +6050,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  			destroy_delegation(dp);
> >  			goto out_no_deleg;
> >  		}
> > -		open->op_delegate_type = OPEN_DELEGATE_WRITE;
> > +		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
> > +						    OPEN_DELEGATE_WRITE;
> >  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> >  		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
> >  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >  	} else {
> > -		open->op_delegate_type = OPEN_DELEGATE_READ;
> > +		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
> > +						    OPEN_DELEGATE_READ;
> >  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> >  	}
> >  	nfs4_put_stid(&dp->dl_stid);
> > @@ -8887,6 +8891,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> >  	get_stateid(cstate, &u->write.wr_stateid);
> >  }
> >  
> > +/**
> > + * set_cb_time - vet and set the timespec for a cb_getattr update
> > + * @cb: timestamp from the CB_GETATTR response
> > + * @orig: original timestamp in the inode
> > + * @now: current time
> > + *
> > + * Given a timestamp in a CB_GETATTR response, check it against the
> > + * current timestamp in the inode and the current time. Returns true
> > + * if the inode's timestamp needs to be updated, and false otherwise.
> > + * @cb may also be changed if the timestamp needs to be clamped.
> > + */
> > +static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
> > +			const struct timespec64 *now)
> > +{
> > +
> > +	/*
> > +	 * "When the time presented is before the original time, then the
> > +	 *  update is ignored." Also no need to update if there is no change.
> > +	 */
> > +	if (timespec64_compare(cb, orig) <= 0)
> > +		return false;
> > +
> > +	/*
> > +	 * "When the time presented is in the future, the server can either
> > +	 *  clamp the new time to the current time, or it may
> > +	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
> > +	 */
> > +	if (timespec64_compare(cb, now) > 0) {
> > +		/* clamp it */
> > +		*cb = *now;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
> > +{
> > +	struct inode *inode = d_inode(dentry);
> > +	struct timespec64 now = current_time(inode);
> > +	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
> > +	struct iattr attrs = { };
> > +	int ret;
> > +
> > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > +		struct timespec64 atime = inode_get_atime(inode);
> > +		struct timespec64 mtime = inode_get_mtime(inode);
> > +
> > +		attrs.ia_atime = ncf->ncf_cb_atime;
> > +		attrs.ia_mtime = ncf->ncf_cb_mtime;
> > +
> > +		if (set_cb_time(&attrs.ia_atime, &atime, &now))
> > +			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
> > +
> > +		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> > +			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> > +			attrs.ia_ctime = attrs.ia_mtime;
> > +		}
> > +	} else {
> > +		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
> > +		attrs.ia_mtime = attrs.ia_ctime = now;
> > +	}
> > +
> > +	if (!attrs.ia_valid)
> > +		return 0;
> > +
> > +	attrs.ia_valid |= ATTR_DELEG;
> > +	inode_lock(inode);
> > +	ret = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > +	inode_unlock(inode);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> >   * @rqstp: RPC transaction context
> > @@ -8913,7 +8989,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
> >  	struct file_lock_context *ctx;
> >  	struct nfs4_delegation *dp = NULL;
> >  	struct file_lease *fl;
> > -	struct iattr attrs;
> >  	struct nfs4_cb_fattr *ncf;
> >  	struct inode *inode = d_inode(dentry);
> >  
> > @@ -8975,11 +9050,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
> >  		 * not update the file's metadata with the client's
> >  		 * modified size
> >  		 */
> > -		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
> > -		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > -		inode_lock(inode);
> > -		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > -		inode_unlock(inode);
> > +		err = cb_getattr_update_times(dentry, dp);
> >  		if (err) {
> >  			status = nfserrno(err);
> >  			goto out_status;
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 1c9d9349e4447c0078c7de0d533cf6278941679d..0e9f59f6be015bfa37893973f38fec880ff4c0b1 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
> >  #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
> >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
> >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
> > +					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
> >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
> >  
> >  #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
> > @@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> >  		if (status)
> >  			goto out;
> >  	}
> > -	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > +	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
> > +			    FATTR4_WORD0_SIZE)) ||
> > +	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
> > +			    FATTR4_WORD1_TIME_MODIFY |
> > +			    FATTR4_WORD1_TIME_METADATA))) {
> >  		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
> >  		if (status)
> >  			goto out;
> > @@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> >  		if (ncf->ncf_file_modified) {
> >  			++ncf->ncf_initial_cinfo;
> >  			args.stat.size = ncf->ncf_cur_fsize;
> > +			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
> > +				args.stat.mtime = ncf->ncf_cb_mtime;
> >  		}
> >  		args.change_attr = ncf->ncf_initial_cinfo;
> > +
> > +		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
> > +			args.stat.atime = ncf->ncf_cb_atime;
> > +
> >  		nfs4_put_stid(&dp->dl_stid);
> >  	} else {
> >  		args.change_attr = nfsd4_change_attribute(&args.stat);
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f52a4c986e3a668a48cb 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -459,6 +459,8 @@ enum {
> >  	FATTR4_WORD2_MODE_UMASK | \
> >  	NFSD4_2_SECURITY_ATTRS | \
> >  	FATTR4_WORD2_XATTR_SUPPORT | \
> > +	FATTR4_WORD2_TIME_DELEG_ACCESS | \
> > +	FATTR4_WORD2_TIME_DELEG_MODIFY | \
> 
> This breaks 4.2 mounts for me (in latest nfsd-nexT).  OPEN fails.
> 
> By setting these bits we tell the client that we support timestamp
> delegation, but you haven't updated nfsd4_decode_share_access() to
> understand NFS4_SHARE_WANT_DELEG_TIMESTAMPS in the 'share' flags for an
> OPEN request.  So the server responds with BADXDR to OPEN requests now.
> 
> Mounting with v4.1 still works.

I've pushed a version of nfsd-next that doesn't have the delstid
patch series in it. My CI facilities are running other tests over
night, so this has been compile-tested only, until tomorrow
(US/Eastern).


> NeilBrown
> 
> 
> >  	FATTR4_WORD2_OPEN_ARGUMENTS)
> >  
> >  extern const u32 nfsd_suppattrs[3][3];
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652..6351e6eca7cc63ccf82a3a081cef39042d52f4e9 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
> >  	/* from CB_GETATTR reply */
> >  	u64 ncf_cb_change;
> >  	u64 ncf_cb_fsize;
> > +	struct timespec64 ncf_cb_mtime;
> > +	struct timespec64 ncf_cb_atime;
> >  
> >  	unsigned long ncf_cb_flags;
> >  	bool ncf_file_modified;
> > diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> > index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52702ae7b5c93d51ddf82 100644
> > --- a/fs/nfsd/xdr4cb.h
> > +++ b/fs/nfsd/xdr4cb.h
> > @@ -59,16 +59,20 @@
> >   * 1: CB_GETATTR opcode (32-bit)
> >   * N: file_handle
> >   * 1: number of entry in attribute array (32-bit)
> > - * 1: entry 0 in attribute array (32-bit)
> > + * 3: entry 0-2 in attribute array (32-bit * 3)
> >   */
> >  #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
> >  					cb_sequence_enc_sz +            \
> > -					1 + enc_nfs4_fh_sz + 1 + 1)
> > +					1 + enc_nfs4_fh_sz + 1 + 3)
> >  /*
> >   * 4: fattr_bitmap_maxsz
> >   * 1: attribute array len
> >   * 2: change attr (64-bit)
> >   * 2: size (64-bit)
> > + * 2: atime.seconds (64-bit)
> > + * 1: atime.nanoseconds (32-bit)
> > + * 2: mtime.seconds (64-bit)
> > + * 1: mtime.nanoseconds (32-bit)
> >   */
> >  #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
> > -			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
> > +			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)
> > diff --git a/include/linux/time64.h b/include/linux/time64.h
> > index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7aec0494ac2f5e72977e 100644
> > --- a/include/linux/time64.h
> > +++ b/include/linux/time64.h
> > @@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct timespec64 *a,
> >  	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
> >  }
> >  
> > +static inline bool timespec64_is_epoch(const struct timespec64 *ts)
> > +{
> > +	return ts->tv_sec == 0 && ts->tv_nsec == 0;
> > +}
> > +
> >  /*
> >   * lhs < rhs:  return <0
> >   * lhs == rhs: return 0
> > 
> > -- 
> > 2.47.0
> > 
> > 
> > 
> 

-- 
Chuck Lever

