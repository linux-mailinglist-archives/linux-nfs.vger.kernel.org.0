Return-Path: <linux-nfs+bounces-2742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB0A89FBE0
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBBC1F20F28
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBF16EC1C;
	Wed, 10 Apr 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMi+XUev";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r7JpEFAp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B091E878;
	Wed, 10 Apr 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763719; cv=fail; b=ONkxvSpjiMwVZdOcC5eM133Pei49iGyyNwxbHmbcS7thu31wKdtBkn/R3Z8fDuMJbkD3bJwlNlvUYDheURKURtx0sm5hkrhWTugpkceMxPVxaiEodJ10tbbpdshmrKTec8vTZcnI7ZSKhsnMmmeGP8jep58NqeJ9vx6bBc8sWmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763719; c=relaxed/simple;
	bh=hy9xLJCQOUi2chQPoywiO17DCGGssOgeWdHhz8TJV/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LjvaE9y5aYpFJR3TlDOiErKGxH9orxxE+Es/NKkQI/oreW+CVH3Sr70P+w+XHuVwY/tYv/GvEvkDBo9/ezo0BME3HQaZYs1pYtlNtgOafimrt7JNkSRPjS6ldv+f7PN+U47DNTi0pLLfCcaUuDquScraFI9masbxus39LFphn6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AMi+XUev; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r7JpEFAp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AFD83B012700;
	Wed, 10 Apr 2024 15:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=SfF+fIg4jHj7ATRN+iMhcc+g337etoLymmk/LAPnT4E=;
 b=AMi+XUevMNmQGrTq13HL91r9PmIeTjvnn5xRpMqQHWctYwXJ1Diy3rv1uq3aiMaZahEC
 Yi9GCD2LIP5xcJ7qw3GnoJGJqk/CM9No0Tdg4bftELYp08HZZ71eBQ39o13w/lFAh4Y4
 9Ycc0BWR7N/mnEUUITZwYxt88CGHN2erHwk8LNX6+RpnKMMhwdesHNZLwRQv/y4lUDSS
 xbzWncZqbxZIaRrkR+6czPC/AnRyp0QJOeMoJhoZtP30Juv9F0M1Y6kyb4uVNIoSL2uZ
 OsvbKrdiyKgB4TPcuaEu8Oj1YlTJCJMQd61WSK/cuOQp4vu49i4FerlfH5Vy8Pw8/XkH 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0uqn6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 15:41:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AF2w6o026448;
	Wed, 10 Apr 2024 15:41:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsrd1we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 15:41:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzLkmAf0lFngTHIMZ0wkF8AVrEJVCqiu+AAy2AtXyjjMtGgRfQGuJhDJLT2WEN/zghj4L0RILY0mwAjQA11BBoRhwmlt8s834wBrDKpPU/99AbfCST5fPRxHYob8RWQgesHWFFYCcuJ2bxa3eaAwe2iB9yeRoABgUo/Q/fNUvAlXEIBxVc1k76zhV55OlSPNvlbOUldewmWhkI3Gw561DI1JmINBOtH8cakCPLbLJYVEBoD6QmpEkj0+1XRmY4zqHtzbTSo4fdE3oI7nGxNx1zGPlAtIaS3XPIs8GVqO6SWW8G1fenNV5sdx/fq23XYrqru+yeOBK7IgIwt8eA9ZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfF+fIg4jHj7ATRN+iMhcc+g337etoLymmk/LAPnT4E=;
 b=YZikBkeVntPRl8k+ye4miSyxVdwF7y/bFaWn63ufAv/6kQAkgv0rwGAPQJrah5s/3+Ldxo9lYLnkgcLWgmUpY9F5Arf0mns7Y7VGQ5L96WKYCYFxhK05+9BCOhiSFW8BsFrBxPf/B2LYqiTL0gcvb+YI2CLXA4XhMxyvmj3sMnbvO3uQN/Aae/bkLITmfNUxVwQSDLwF514pBmenb8ySspzgZ9wzB4/K1cAa9+JA+o3X9kJYY5N/zbaMl82DJB1yKmaKWGj5Mw9ksFWQIY5y5o5TNNuuvi3XSSJb4ve6XyiNericdm5ElhvgNAhC2TEp7lKuFlEthBCmU8ki6jlKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfF+fIg4jHj7ATRN+iMhcc+g337etoLymmk/LAPnT4E=;
 b=r7JpEFApL0NKmczCj7R6KBCEobaTCoZyt3+FaSGidjThOf1/yQyoBVJdL+jj9Wy78O5ZRntDIAqv9ZAQpdmnx1mbFv0wF6aGI0Al2TEqOScCDXTzAXidN14mxrZ0KRRbwJBVOqzGn7KTrK7+1ne9Q7F7u5zbS6TZKxrMHOUJ2hE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4709.namprd10.prod.outlook.com (2603:10b6:510:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 15:41:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 15:41:22 +0000
Date: Wed, 10 Apr 2024 11:41:18 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] trace: events: cleanup deprecated strncpy uses
Message-ID: <ZhazHrz4SxBs+BFD@tissot.1015granger.net>
References: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
 <20240410113614.39b61b0d@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410113614.39b61b0d@gandalf.local.home>
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
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4709:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YjqA9oFPl7fjnBOlqMszpHCn+vbSZujqYNgxhKiYuuBWpVuIZDtaWEf2Vo3qR1yD2pvt36aAIa2DlKTZG711HF/qEM5VmdRfc5iqeOA70X0FXvY1zwg0BLghzp2Vd60M6LrsKVFTBh4ebcsWYMCmuYXs2sAzf7N/iDHlCaypT24sov7JRjaVXEIPFhI7de0tsjVlIls4139AI0RDhYFAD2AGxX7OgSqq0dCDIHyIVQ9WhykXb5bX/Rwf/UJNByFhZd1V4mMj1oIyXKpLG+WwFHzwh+rIVGojOFeKLKvn+H+ebc03tSJgJuE6JElNwkLNUzZSN77b1dSIIYkDgKWumjnnPhO/PsIXv1AddiNA6Ppqle3qTgRRdiquLPQ2TqHRG9XHfkv43odiH2RAkexF6hvr+twBwRVhFlr3BuHHaH+dO9sgPlTojfG/TltRZ6UMSC1qSHV6jicgOMN0UKG20XmCAOZ7E70qgHI0pMBrq8PNiTg8tMaxK0vKeWYp4FxIWvQ2sguQDaEbqsCqMcYroQt6ubc2avecBDTDRfH30nS1rjsoqU1VYDlAKRZx60yQ6wKdFr0MGzoaByeigIqfACI0+Yz+vVg7hR0gvRFGHJjOTlD5JxTJUGdnJwwTOxI3n/dLFTxR9n/6Ix/fZpSBaiGKLePQg+6ZA5dnNJzinNI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+HxlQiuvGaKtde7yq1JJVtxQuu43qPzL+R0OaPa08lnPnkTYv5Q5elB/bm2h?=
 =?us-ascii?Q?zQcucD30deVLYL7/ZsT93q9c6U4EW9O12EAhs4Sln5QIBF67NjzmUZMiCura?=
 =?us-ascii?Q?obLoylwzT0F3Es+7X8cy8QJj9U6WAHmmm11GnTRR4MrI1fG5BEb2borccrAw?=
 =?us-ascii?Q?XUmfvAp0NGbaD4AbQmGL6o8FB4O926gPGDEszFZuJoA8U35weRDN1nOlkSD4?=
 =?us-ascii?Q?8MjY02rEXdFKFmOhDxEt+m1QH9Si0Qmf6o71xLFJNBpGeSklRf1awydj8cM8?=
 =?us-ascii?Q?iWOkkq0zIzfZ6r6AGxWSdzeu3Q1DkRz9zWvSHV3fdYOgoNNZ4A811DOruXWX?=
 =?us-ascii?Q?bQIScGsXHeXvIQ/OQy9crAlOaWJ8dLYGfGCnLPL22COzGTfrKIGldOjVz/tc?=
 =?us-ascii?Q?IQRU4xgFZkVI33TVORlG39tUBeHdke8l7F/96Z86YZaYCBHoyE/+FgDMYQc2?=
 =?us-ascii?Q?gMJJAa0HArNrpCLywnZ8Ocua1UvXsIvyiubi92CwMV8k7YRyIgglshVjZ2MG?=
 =?us-ascii?Q?ACDQ2vQV7oT7ASnndf6L/7NAOpGv+zNbr7y3zNd4tj7DuRZOnSbiI6YaxMuJ?=
 =?us-ascii?Q?GINxFIbGLM6vJI0ykb+HoDTjIQKV/GDK9okFadIC4J/CE1MOt94e4JfRKJjM?=
 =?us-ascii?Q?tKQjPkT/l9xmYdorHlorpQmfrTOPSbTZGNpHgYeblQpnIgeF+mBkcGCqOp9/?=
 =?us-ascii?Q?SDz9Zfu2JaUJj95bP6MivZJh30ZWMQ82NsZ29DAkx1iW9rrXaBm+KGZoQaRQ?=
 =?us-ascii?Q?2ZL4AmplYScXDnkhEobk5Y1FK8eFkNsYzBluKwLZNq5Vbh5P8iRknK9qsGI8?=
 =?us-ascii?Q?WNq9AI83+rxW6P6d11lPzOIlrDzAwyAbzwuPrDnfozOQnd//wV44rNMKZPvL?=
 =?us-ascii?Q?dUovaRnynDtGGx7m1lncGFkKhWXEDPOl4oduG+w8g1qqvwiAUdNVLoRkDaYc?=
 =?us-ascii?Q?bYHgQBEVSURNSwYdOZHtNnH1cAazn5TNNmqzHylsCQnn7ZvTubvIsym7wWD6?=
 =?us-ascii?Q?+85EwdUItUpkLmTD3cUbpow1mqf7Ii8D7v/P3loSe4047lvmOWlQFm0oggTo?=
 =?us-ascii?Q?yUmZyeCQ8mv0Ls27w/N6mKcphDZxpZxTyMogUJp5JKUSGlAK5/XWYcVJsWsI?=
 =?us-ascii?Q?MMF5EiG+WQw/Qa2g+PUvohLSRklmAoLkGzPRgCMldYnHjCDxcT0U1K55ddZ8?=
 =?us-ascii?Q?9eTWx3mDDwYW5Ihw0mRaUUB9K6zW2baAfOWY3xWKrYuDJk9g44s7yjITmCaF?=
 =?us-ascii?Q?/1LL61nN3xV5GT9RPMAfW76hNDlzFyouxIf7KV35NlbIYd6ab6HkXJq64TmT?=
 =?us-ascii?Q?ldW+NGPkfOHQGdpO3tAW01/Q5ud7ewIovlSX9r6L1Pb80Ruix28eL8UdbQBc?=
 =?us-ascii?Q?2d00IFw/0QwblBh80yNGqoAV3hpZZxQmpD62NJemwfH0PTCTX58WVObqnoWf?=
 =?us-ascii?Q?n4mAINgHNjaKni/FA7/qRzGVyNdYqmDFWpPnIyjsqeMi+rapxeh38x+X1Cys?=
 =?us-ascii?Q?G7jUSP/nHdCCun3P6OLTGZ0PXv2iixIQ8Ykkmpds9HWHVUo01aIMg8SpefeK?=
 =?us-ascii?Q?E8j80tIa0PWkhOKkKTM+JpJ3ZgDLkZtzzpjD7lsCxiOM7pvEgzaqgn6XkhY/?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	juELbf0R+gjJHB6pRHNYpRUzR++yURXYP84hsE7KUWe+zGljK6a8YTZN/YfxfgVnV+RQpQq9gmT50D8Hsgqaz5tOIpQqKiFY/80JPypu6Jm1aEcgJU7Nfjr+XRf5urlofxXp2RmtSLo7IyKyud5GEim6cwd4I6SgJwgoBGCAv1Qe0Q/QVo0qWfZ3UcYOX2iQOZnX1FhKLd2ww5npuv742OqDySF0PddSd5qqzKeQfvXYgadrBZR7nsTpb6AOt8Mj5v3fwhcem7nOLjK4QCbjPjvsL+V2uFTrNrx8xwW3XEAyPARAnY3tFAOKH0e27UTqrUZP6gcjkdF/E1LrHtmvHwOjyQUU/GSwYQQsTfRvgBd8wbVrdsvXTKUZVzyGbxIhc9T6arRQK+llB396oxGHWHk5Gtv/+ZnasvgPVttMWXJCa7hG8kNgTHADVj8PFO9UuqPRt5hQsT3gjf6gBJ6AbMiDcG/HagNW3t/o/jAEdEY4Ro9YbpIlPemJ9cTPFnkfq/3ZLUkDBP+M7zRAfRRT2AZSHaVYVKvedleRTGkYK4w/JqmSIvQb5tJlaiKM1kkk2oY/FoRV8IjVrxx6DWi6z1qZ89fCSplqhiQgYrEk39U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7768daf5-ba1f-40d0-4cf6-08dc5974abad
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 15:41:22.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDu+Rpo3cQh8/uqft770gVjXP6ET2QZWUUsggpw16ALYSAne2ym+P79OM/vIHZSWymt+sxo+9IFQd+RGX7enjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100114
X-Proofpoint-GUID: DC8y-Z9N4BiXGJ-z__Jb2IpokFtmM6fg
X-Proofpoint-ORIG-GUID: DC8y-Z9N4BiXGJ-z__Jb2IpokFtmM6fg

On Wed, Apr 10, 2024 at 11:36:14AM -0400, Steven Rostedt wrote:
> On Mon, 01 Apr 2024 23:48:52 +0000
> Justin Stitt <justinstitt@google.com> wrote:
> 
> > diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
> > index ba2d96a1bc2f..274c297f1b15 100644
> > --- a/include/trace/events/rpcgss.h
> > +++ b/include/trace/events/rpcgss.h
> > @@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
> >  		__entry->timeout = timeout;
> >  		__entry->window_size = window_size;
> >  		__entry->len = len;
> > -		strncpy(__get_str(acceptor), data, len);
> > +		memcpy(__get_str(acceptor), data, len);
> >  	),
> >  
> >  	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
> 
> WTF, that code is just buggy. Looking at the rpcgss_context event we have:
> 
> > TRACE_EVENT(rpcgss_context,
> >         TP_PROTO(
> >                 u32 window_size,
> >                 unsigned long expiry,
> >                 unsigned long now,
> >                 unsigned int timeout,
> >                 unsigned int len,
> >                 const u8 *data
> >         ),
> > 
> >         TP_ARGS(window_size, expiry, now, timeout, len, data),
> > 
> >         TP_STRUCT__entry(
> >                 __field(unsigned long, expiry)
> >                 __field(unsigned long, now)
> >                 __field(unsigned int, timeout)
> >                 __field(u32, window_size)
> >                 __field(int, len)
> >                 __string(acceptor, data)
> 
> The __string() macro expects "data" to be a string and does *not* check
> length when copying.
> 
> If anything, it needs to be:
> 
> 		__string_len(acceptor, data, len)
> 
> as the macro code has changed recently, and the current code will crash!

A general question:

Is there a test suite we should run regularly to build some
confidence in the kernel's observability apparatus? We're building
a menagerie of tests around kdevops, and one area where we know
there is a testing gap is the tracepoints in NFSD and SunRPC.


> >         ),
> > 
> >         TP_fast_assign(
> >                 __entry->expiry = expiry;
> >                 __entry->now = now;
> >                 __entry->timeout = timeout;
> >                 __entry->window_size = window_size;
> >                 __entry->len = len;
> >                 strncpy(__get_str(acceptor), data, len);
> 
> Then this needs to be:
> 
> 		__assign_str(acceptor, data);
> 
> Note, the length is now saved via __string_len() and not needed here.
> 
> I'll go send a patch to fix this.
> 
> -- Steve
> 
> 
> >         ),

-- 
Chuck Lever

