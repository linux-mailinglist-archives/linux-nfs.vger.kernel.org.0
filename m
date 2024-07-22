Return-Path: <linux-nfs+bounces-5007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE1939026
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CC11F21B48
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A416DC06;
	Mon, 22 Jul 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c55tojV/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K9jwjHJ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434F16D9C9;
	Mon, 22 Jul 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656299; cv=fail; b=j+xBVFCul9O13NM6svzJqawhHLOOSK3pupGm84S+c/W3WRAHwqcTqt0YBNeksx3s01uUCWJalpqmD6hDMRtLnZVBxSKs+rH9ZZDxZkbEjcGmLCWtW/jDKBQgAmYzt7/Y3iyjWm64XJ7djz2gfjE5FMAUd0q3ftYUnU+UevMwBSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656299; c=relaxed/simple;
	bh=k57p6vYLtvBlV44ULxCvDZS2y02cwMMlEvGkakXIczg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0Bh2c3up0tGu6foQD3ZLFWH1xAJWuggd0dg3716ATZo/UClb9rb1hDOQ0IgJBloBECnM9bfJttkkYlxshVyZH0fvRCblVaOoDGCKBh4XUTUMpmdde44Qw1biplrR8rDQbVrxz8YtKVUxjkJOGzq1lR5Juc+QcGIhj3E7BdACqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c55tojV/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K9jwjHJ5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCNUdJ016434;
	Mon, 22 Jul 2024 13:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=I0VUuHZIjya1TRA
	WZn7D8eWiIJfJk5v1VzmYPMND4Wg=; b=c55tojV/3DnWmwktITq6zxNrkgXmaZ4
	0AYQDwmdKTUnWXRajs/pSdJs2YlD6T+qPp9C6gg59I1aw6Gihk9ljVi9HvN9hgh6
	SiCyd5eZJmmV+nvT9/B1iqSW55Xi845Ftl1pgMufkTcdxuoPFYEDwvAp22p+O23Q
	NM53sm9F7zNXNmC186rqaXD/J35K8Lx5ndi+OpDXmT/mIIbOmge70F3P3nHHc2ZE
	Gn/CzNnxyqPoZQoBTe3JEbtIUy8aE7Z97MAe6fGOmCXrPkQF0QMBOfCQRHSua+6q
	waLpt5Yd3SDCnccL68/e9qUWn022W3vw4yB7g1xjswoFzkvokiGJMdg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10svar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 13:51:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MCkcN8018838;
	Mon, 22 Jul 2024 13:51:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27x75dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 13:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae1teaux4pDZ1/eGlg8cvB4Yg0GGxxUkaahLEIVJoBcEbUc3H+cP9WFTzdWqOXZCfdAgd0U7hVvv9gy12NdEZcp1yh48rla4JZ2uXTsrogvR/hBKOtAUSbuAs6wShC1dxMs/Qf5KXpUmvARRf0D4CgrQKqH6xAH5L5D3KN4en8NkQhd1Dukc1A33LvmB5YzDcyaIdTmtCEOoVcnei7IBWSRfcnz9BIJ3b5OfV8i6s6wStSrjAToCCUiaYguR2rpFJdWCuxKWrxid0rRCt8Vz5aeDfsILwBQSTBca1fgSO0Ln2TayA0MWjpY1447YE+U/DN4fPUUVBfc6rZQuL1P+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0VUuHZIjya1TRAWZn7D8eWiIJfJk5v1VzmYPMND4Wg=;
 b=bS7tEXTZJOxre+5NJpd+hgdS0dEeGztFiDStOHKhyJW82Lxc6obY4K5ZHpZbby66l+NExyv0Ni018tRtggraA+c+f+qU1wA6jGvmhC9ToWzjqNyNOuBoD35+7GiHYJHD1dk2YlJXbPYbH4hEEIAjycqijoiLQd3/o4dduknpHkLUtYIvklTRhsAapa36LxlsQDqpSFom006/KnOZA73wTGUIoW9d24MuaY75cKcbUz+5pGnuooRNCtiwTIH/s7vvvssX2x2r8NEpd0cx2pGdlB3XeGSBHscgKclMqPWxXbfshYSJrY45wDwpxULct3e2KEfyBbE17dY72ppyCIAU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0VUuHZIjya1TRAWZn7D8eWiIJfJk5v1VzmYPMND4Wg=;
 b=K9jwjHJ5eIz6IyVEf3AcHx+8r7NnNWTmUtO+xoCH5vbq4UwbS1GvUDawT4PmEGrxTasJIOsk67h372y7/+WLB9qbjOyVWY/QVqZnG3QPP4uuVNsEo8gkqM8ctvzFInztMxNTDALaZ/VC0WmG3WEj3IZVWQbjkREMj1HeaOsPuaw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7823.namprd10.prod.outlook.com (2603:10b6:408:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Mon, 22 Jul
 2024 13:51:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 13:51:24 +0000
Date: Mon, 22 Jul 2024 09:51:20 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH] nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd
 sockets
Message-ID: <Zp5j2DW+2BNaIPif@tissot.1015granger.net>
References: <20240719-nfsd-next-v1-1-b6a9a899a908@kernel.org>
 <Zpq4Ziq9YVuGqV7b@tissot.1015granger.net>
 <e2ed6feed0b494960d228c5166a8ec11fbf09b3b.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ed6feed0b494960d228c5166a8ec11fbf09b3b.camel@kernel.org>
X-ClientProxiedBy: CH0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 5921d4de-6136-42ef-954a-08dcaa556005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?atJGC46MH5/BrFtv6IKwZXvJgfZ6t95HXvv3j5UvmEOQNvgfJudTOwaNIKrO?=
 =?us-ascii?Q?ZfPbYKZ3mPsJByCQ6mSYPBtdhBm4D+D+ZAT/N7n2iPvKH41XMqkiVjKOCCsE?=
 =?us-ascii?Q?M5wjJGHB31SpgWoM9TR7IYGrSwueD/89S5xCzsNGpzu5khD6tMG9q4M0MVgx?=
 =?us-ascii?Q?EB5nyQSBot3gG5RvoG9H3ufkDXEDO68Z8Szu4I4xbGQxUFFAl7k6PRruahQ7?=
 =?us-ascii?Q?cWFBerCLCHRPN07IG4pMQkgjGPyO6Kn+P+6ZhCfxBUueW2rzCkvniJQp8x1e?=
 =?us-ascii?Q?o4s4LWkhmUsbzQy61hxeWEiOg6tpme25SUj6OtyJn6TrS0mbzIYXWWSYbFcW?=
 =?us-ascii?Q?VaFrOQ97HEXHuaQskfyZOD5Vbc/igB7+IO/g5xVxYIVew/UnWBYIxInYZ5k/?=
 =?us-ascii?Q?yzMDpQ78vRBunpHh6JBN3eH7Hyg7mx1Ynz88YNBPNPJ/E0JX/EaNyrYveEQh?=
 =?us-ascii?Q?us3O8A8pr/Nx0BnhADQm94L26DQeFZSvDOp34Fl6DyD+RqCxa5AUHvVrChmR?=
 =?us-ascii?Q?HXxgkH8Knm6KstkdyxLthKxjzQyZWTKkWECL0f0dHfSXuZs9qb0K7Ow18SLL?=
 =?us-ascii?Q?FHlGPhEOIQC9UW0NdQ58Lyv05Jll40FYD3AFOTZVNy+Olv0mlHgswaBGZjH0?=
 =?us-ascii?Q?SzbeEKyNY8MHGgRZTMt9HDoluxRD8Zk6XkIlMZc4Zxt5WKYIJMEhM1L0BuXa?=
 =?us-ascii?Q?7na19lLYT5sAAfEi7XZmLYM6eNUlRxazQCSXw2ZPHnxklydoy79m4C8S1nOL?=
 =?us-ascii?Q?rXwaiS5Ufn0kn9aq6Y8tvzaiSG6OH7zpuV2Nai76kLBq3GgCBXvFArC3DvsG?=
 =?us-ascii?Q?rX+u2WB9LXV3T+iRUoj1K56rH6JHmAkg53Os2MxcjJWxiBQQGISwYMUnNp12?=
 =?us-ascii?Q?DAZ6rY5QpfWknsj2rYdVKMUdhgyqVh1SQ8bwnn6vhE8Kn7acDgGBZJIQGZLG?=
 =?us-ascii?Q?2RxKUYsOyz/6zfu96RGpx3bjO1SFzDnRychICZ+j9b4NMRkqB+TILpydm11z?=
 =?us-ascii?Q?O1ITdj+ZgMjB+AGeaDvXjfbyVONqgb0d3wywMduvKsBwcAtYc+YYpjf2W7EX?=
 =?us-ascii?Q?+Z3pWa6UjX0bvoMdtT2wwGjP6djYL31jfjzk2iXcYsqM/Nq8JnoumPJW4Yfz?=
 =?us-ascii?Q?OO2P4dqzkWcYnTTzszpPYb+1sGuDOAVzNSc6Hnpecfy0yJIj/Jsk8e+Chz4t?=
 =?us-ascii?Q?Z29WoHjQ9qMHo3Iz7nZjwGbxA6ZhIx41uCm5MpUDcceS6+4T3lsfoU9BbCmy?=
 =?us-ascii?Q?KYrpxGmezFetkAJEn4u9qUJmavR0vgcyKMyknz01oZ52K4zHG5Lt3Zro+kLT?=
 =?us-ascii?Q?k+RRsUJvWkVK5rHTuCrukHnrKBI4XTyidzSsoUT9uGvq6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sBXixa+4HFfhqEWcDbrx9pzrQZlFkezriCYclfDwdB9QncYIzet5oTpVwlMU?=
 =?us-ascii?Q?47l6/kPeqTJPete2tSp8aSfsCsU+hNPT6uqj9rJkls7eELYxpsZuPfo1yLM/?=
 =?us-ascii?Q?PrjC/f3Vy8L55ZIjWZLcWNddkbsnobjX9KcGFIUiE3txKht/jzjoDAwIhjAS?=
 =?us-ascii?Q?cPK8UjP6j4gtAs4e55RJPl0VUB2r9JLyIqeeF/tq4brpNNVZA3Mzq5v8vHSf?=
 =?us-ascii?Q?QuZ2CEO5DV8hdEzfX3spAfN3uQW7gn/uXWSosWmEiKUycU6MjGulDmWFnXa7?=
 =?us-ascii?Q?NqfO6vLyK8f8s/pDoDrRJ+5QLXaP1sBlzWrezaqcGABw7xjYbZUOqpQTXRsv?=
 =?us-ascii?Q?7oOKSRyLV6xHtF3GKJVtb1hsKF8pE2vogh4jN5aBR7CU0OLb+AFnzxo05QuL?=
 =?us-ascii?Q?XvILWcyJAieeF8BtJPKfkQ5R4WLM2KMTSY6b7nK2MzYID0ElGWzKNmWinvKT?=
 =?us-ascii?Q?DOUNavHDgHOsaUlxBBOd+3EexJ8Z2Lz3m731ACzptWXuKJ/KU4APbTf5YYTk?=
 =?us-ascii?Q?ofNekOtUhauOERqOmbUfP0uP2Y/7JLs5hjtfWiXRt/HtFairAnd2xXdb3GmM?=
 =?us-ascii?Q?ETgkEbA06YeI6+5I3S9BfzmM1ff6u39mpMDqXawP2Wh1sFgQ0lO/6c48MvEX?=
 =?us-ascii?Q?gs5SqyimDKD6DKXzcJweQsJmn5Bun3avacc0GNDpIly24zQfPvPHm8DuTgLw?=
 =?us-ascii?Q?uPo4WeBoIKlmqJeDTMceKh5o9XJ/Lx0a8ToRPquf2VNv9o/5Immr19f5TMTz?=
 =?us-ascii?Q?yDci3qI5YTY4gaBlj05Lu4gYtpl5zfseD4O/+0Y2SxlRztK8VSF6G7p072T2?=
 =?us-ascii?Q?13KmHrA7a7ltrJIRNTQ2C38CoviCDMdXzTQ8Q0vIz1hSQY8YLidi2qctkmOh?=
 =?us-ascii?Q?CgAIpFSzrArks13zmmvZhWP+E4v+KGxsu/sbF3rujHzywHSR1W7H5Hl6Adw4?=
 =?us-ascii?Q?YPhSeVIwfl4canqOCgYcyatkHceeKpAksRyts3HTi/rtgrp9TYf9K59286Js?=
 =?us-ascii?Q?xRXoyTpDQebWqHLjI78OSbOhg4etJuJjWScpR3AQp4G4uRcmO0KnFQOH7r4r?=
 =?us-ascii?Q?6vDsXdEYsJZs5gip0oCYRBA5fU381kCHr0CzTFU3SzVV+o2MA9TAT1lAKNHK?=
 =?us-ascii?Q?IfLDz9CC4U8hy67LrQ566o/bsYvMwdaus8BCB1bi2ICtN4dOhsWrIryq11Nv?=
 =?us-ascii?Q?B2cMEm67acCI6a+oiWAPV9IaMw1+SUpfndlwEsROb70ftoMVP3rCxHg4fVcI?=
 =?us-ascii?Q?CR3a6cOfVVSPbLd0PeGj6cLlCm8tptLygszVYsDsK90aGjQWgRfQ/8ZF8Q2l?=
 =?us-ascii?Q?jMzyYC8v401MqqJF/r9ElhOJ4dlTp4UkVWOKHX/ybZ7pmlvANjWhxdawPX+X?=
 =?us-ascii?Q?1gM/djNzVPmhpjWbv+QobE4PHUpFnPTYbIGi6tx6Sha/O6oEJbis0Q9vxHmk?=
 =?us-ascii?Q?qhdj2yEHc4PUlDJt0wYS92dqbKocJ+Vc05V+wA9ceD1+g1kvG9Xw2H4OV8zX?=
 =?us-ascii?Q?GO90RfJq9f64lb+1DOGDDYOJjSxAIR7AbvvUAu5DSmVyL0Kl7T74+oATvSJJ?=
 =?us-ascii?Q?AYvEQqvXdJsVEljk4thgq95uTfTrSaj+FPBd65v+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Q1ADaQGpZwmzRm30kta15IfY5FgC1dfHJ2dS6UnJxbGY+4eyOuBEE5H5VjrCyfLN3ilhz4r+MhWO7i+AXfGVDEi+l4xnH1eqpzVm9zKcjFmga/8LvVr3iO4AJsX68nwMeazFLWVNTtlncC8o63lmC4P8OHXMirDc14e7i6Kw5i2wJ719drDYMqAwyZIEo+9/xvuwHz3o4NURHvyYzENrE/jugqPFR1em4UyCQDvRs3kWOjA9pn7WUQjI2g95Y4rvaH6zCYG7hOXEpu+1GxoiKIihkyenwmG9uBzlyIsrrFnyD0sD0dm8YNv/i2zuSTZOM0Eg7G8JZNbJuEmVCBLVD2ueUjqWBlq9hXVLMRmkCI3iWDOZXaloXmQ+14U6iOVhczluEPeUiZbCCazhmeF9+x6wT25c+jtKtbSCi85YJ3CAopQcCIoGd7Lhh4We0h6dvTPtwPB23DHxJPBo5cxA9Recl08xtFHgZCOWSM/3SFqNnMtFpit05FxZDEyzsZyX/NDh6a/sZODpjeZLd3T6uRbxayjhwe8Y4qfz3xZrnCFrPN+xgHFkUVij0r+vRmzA6Q0WllqxEo04Rdk7sF1MU9o/TnshY1MTHknLeVOqsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5921d4de-6136-42ef-954a-08dcaa556005
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 13:51:24.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x1zCEGA4GLOvjwCwxvvoy0fnSH8t1aRuToS7b2TS9xYMBNC6twCUrvHHiDtOd6KEzcY50rNf4kN6NsSCcubpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_09,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407220104
X-Proofpoint-ORIG-GUID: Yj7nEyCAByms2l5V-lXdjcCtJHOiblV6
X-Proofpoint-GUID: Yj7nEyCAByms2l5V-lXdjcCtJHOiblV6

On Mon, Jul 22, 2024 at 08:32:39AM -0400, Jeff Layton wrote:
> On Fri, 2024-07-19 at 15:03 -0400, Chuck Lever wrote:
> > On Fri, Jul 19, 2024 at 02:55:53PM -0400, Jeff Layton wrote:
> > > When creating nfsd sockets via the netlink interface, we do want to
> > > register with the portmapper. Don't set SVC_SOCK_ANONYMOUS.
> > 
> > NFSD's RDMA transports don't register with rpcbind, for example.
> > 
> 
> They still aren't registered with this patch either. After doing
> nfsdctl autostart:
> 
> [kdevops@kdevops-nfsd ~]$ rpcinfo -p
>    program vers proto   port  service
>     100000    4   tcp    111  portmapper
>     100000    3   tcp    111  portmapper
>     100000    2   tcp    111  portmapper
>     100000    4   udp    111  portmapper
>     100000    3   udp    111  portmapper
>     100000    2   udp    111  portmapper
>     100024    1   udp  42104  status
>     100024    1   tcp  40159  status
>     100003    3   udp   2049  nfs
>     100227    3   udp   2049  nfs_acl
>     100003    3   tcp   2049  nfs
>     100003    4   tcp   2049  nfs
>     100227    3   tcp   2049  nfs_acl
>     100021    1   udp  46387  nlockmgr
>     100021    3   udp  46387  nlockmgr
>     100021    4   udp  46387  nlockmgr
>     100021    1   tcp  36565  nlockmgr
>     100021    3   tcp  36565  nlockmgr
>     100021    4   tcp  36565  nlockmgr
> 
> I don't see a need to do anything else here.

Fair enough. Applied to nfsd-fixes (for v6.11-rc).

Not registering RDMA transports with rpcbind was done to mimic
Solaris behavior, IIRC. I don't remember any functional reason not
to register them.


> > > Fixes: 16a471177496 NFSD: add listener-{set,get} netlink command
> > > Reported-by: Steve Dickson <steved@redhat.com>
> > > Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfsctl.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 9e0ea6fc2aa3..34eb2c2cbcde 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -2069,8 +2069,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
> > >  			continue;
> > >  		}
> > >  
> > > -		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa,
> > > -					      SVC_SOCK_ANONYMOUS,
> > > +		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
> > >  					      get_current_cred());
> > >  		/* always save the latest error */
> > >  		if (ret < 0)
> > > 
> > > ---
> > > base-commit: 769d20028f45a4f442cfe558a32faba357a7f5e2
> > > change-id: 20240719-nfsd-next-d9582a2c50c2
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

