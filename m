Return-Path: <linux-nfs+bounces-17823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B39D1B994
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 23:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7732A300C36F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A183128D2;
	Tue, 13 Jan 2026 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bS3QksKX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020133.outbound.protection.outlook.com [52.101.85.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FB163
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343627; cv=fail; b=otaaqNR9nHhgJezP8AkEF7n1H8DiarK2/HM6rmh8ZX/xL076HZdNT1BCWmUGgyLmqCa3Plhg5W4Ad6yhMrCBP+sgK/XbPJRSybydS/KsbYTOU6mIT/qNcbxrIfyJ5W+OV1yrrbLdbc1F+25WaZhL0kmMa9VTbOdDz4mBXGPtMzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343627; c=relaxed/simple;
	bh=XNbtqySBw6gE7UEp7yLp/Fhld2Pf57qMqSd58ujSl20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pETd6FRWZc3qXi3Q31U3z5Ic9xcuQ+MknYrYY6aTzUhHjb62KzUtA4cwjcJ1+gSFn+ytq1YhzpZ+iEFUhzCUbf2vPPg5Cdhn0RiaIqX7xE/D9Ist06qgIJgWwEcj/ohd6j+d4dICxt07Kk+uGY7YrK7G2Hl6Ejrpvdmwwzw7PO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bS3QksKX; arc=fail smtp.client-ip=52.101.85.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKm2QmMSrCW935EIzcgaQWTbHSNeR0Su9ZFv0906QKc3DOdN2B1h+nR/hzpI58Ow1KM1rwgVlxyAcnjT63huPUU8dauOWKArvp84ZqHksPrinnOUDUotUlpOSYrQmuyvFCiDbN5LrmXplcEB03SMoLv+C1L93xKqKhqmrmR9UiUNPwfzW3eJUIzj5G2RGDeLovU1IwCtVLjzv+WgWNH+IOg+RmNQuKt4k+MhXTe2C92cEa7oJg2uuUCqOdjwAkHKaSWMSDtq/H7rP+GnYN775FZyv3a/SvxHvn7YdIj4PwI3THotf81AvviLZgNTsRvYbWary2PV6p7AGgg+wpmERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcCBHfY5SNaQ156jKjn4nAcNTmyXH5Yc8UV0j7Y3kLc=;
 b=FLj0Xzv0xAVdpfJY7foN7bwBNz3sCwC85fX/Bb2ix2TLnDi5xMp6HWdD9OVrz99ZoFYseGRg2S/dfYyZTOFKtuRcaGZwJu4g1tBBiq+hdVnD+p+PtdHQ2LNeqmzH0a4+/MeLlOcAVRx3AYcp37mWX0nNsdWHlyoM/CNvPUgz4YVh7j1GBjPNhNBpESPpY5JRGumu3rMdlkG3M6kNg5O+mNn346qyvZz5BlAkMzR5HvEViKGr4xddjbXCyY+0t4zhbnL9TwsejhvX7w+S7hFAA0y8IeNAaEgI1Lk39LSwrEittc3EjZmUqpu2dbKy8g8ZlFgcmBc+i293Le9i/IZA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcCBHfY5SNaQ156jKjn4nAcNTmyXH5Yc8UV0j7Y3kLc=;
 b=bS3QksKXGzQtXuNjXiHkUsU6uOHcSgDYJwSKN/GqUdlVb9xPuOw/a93dmhRWnIBhI1cqLFxhAW35u4rRj1u8euSZwi2UAZxJDKthvco0enU1CjvA2ZSdwDUFk+Q4im4iKHIITHSltg8idDmtdX12U06ZlmzzZ0UCSUpaA0o60Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY5PR13MB4488.namprd13.prod.outlook.com (2603:10b6:a03:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 22:33:43 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 22:33:42 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Tue, 13 Jan 2026 17:33:37 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <C79886E5-3064-4202-9813-0D79091F78DF@hammerspace.com>
In-Reply-To: <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
 <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
 <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0148.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::16) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY5PR13MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3d6338-b0a8-4856-9228-08de52f3ce11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzcEPZjVr6Xlrre1/e3yzpzkbxvO8jxAXZCltH/k7QQYMc5vhWGRgbfK595j?=
 =?us-ascii?Q?jmAF5bDcr+WgynpD4qMPm4j2Z8Ud0EvepC4BvD7b+eimIX5Pj3FJMbIYwtn6?=
 =?us-ascii?Q?RZyRD79fJpkOJW1HxikeMNQFzu3U89e06REyDv7Fjiu29cwIBoCbrSvgIZdh?=
 =?us-ascii?Q?XT5shO+N4kAQIuOGc0/n1DU9VP4WKLhqEXEjJ5hy8cbrGwtUH1io92XsLJX8?=
 =?us-ascii?Q?vwQ317CpGFSI+KM6G3SZReqoQHU/33SEdoaD/UExmhX1ZHLd8Z9iis7zQGpt?=
 =?us-ascii?Q?kGXynN+PvfOR2VJ/fcoibZf4L4FFbFj4QOxyw0vN3hB/paBW7w4H8s1vn5JG?=
 =?us-ascii?Q?jzsU4kkhg/pnX5yd9Ijae4pfLd0903/m1lpriTPT94g4tbPI8M7HYn4/K2XK?=
 =?us-ascii?Q?bQ5K6X9LusrmTWYBr3SEzINtj1+rMIzS56LwQSdFcstOgwjiAq2YvTJ3LvY9?=
 =?us-ascii?Q?Pz3gVPzhAnXLfNOZyCH4qNrIyXI/RxWjg9FkhOSs+cev7MM9XMJWGE4Ik/rB?=
 =?us-ascii?Q?rRJDxeChXi5ZlNFWjdHgXG89wh+rLIOuNzFwsvIzeeMrQRxJtngfT5qVpoAZ?=
 =?us-ascii?Q?ypIuHJcc/uvwMCIa/A//UT8KvplWeGHmKHzwHk282VrkgF2PPPxJnlR0iwsV?=
 =?us-ascii?Q?EL9TdQNQboRqnliYnoqZDN91hYfPOqId2shAwlXk39dtURlfapNAMc3Ma/A7?=
 =?us-ascii?Q?o6alCHHIRkV3y1umPq3id4INuDecB0a4b4da7+k30chdyC0b103O9piVoIo/?=
 =?us-ascii?Q?B+WCSVK15PDc938TrEGBUAsywTg3ePe7U+yw/pl8GmYLpxndGIz+g5ID97NY?=
 =?us-ascii?Q?+5geme1bSF8BGiHmJdcnaSVoBa+BZnwYf2v/CbetcT+EGF1h9WatcqhkVLFu?=
 =?us-ascii?Q?pQEUTAczNYUQbqW0Zpc3JJXE0eoKbSRXlatc+ws9W0QQuvddQBj1p5lLJ0kL?=
 =?us-ascii?Q?0Wdk1Y8hA7GPKshal2T86fSxzHUz6E7F3M1s/cz5JYD9X/zy1qKl6+A4VZs6?=
 =?us-ascii?Q?J10cDPk3BxO0nx4kw+vUoGu3CURzQzkuiPzMlXXAYK3jE66VMqL1QPWNlx/r?=
 =?us-ascii?Q?CcQNcQKLuLUym9XCwibuA291PHT5zI5FnflZmDBISqgPaJY/1evAQXBYY/r+?=
 =?us-ascii?Q?aojwrYfRZycxas8FJxb+mHmTskBPSDfsdTXr3GniaZJh3HCDnlakAM2kSvy4?=
 =?us-ascii?Q?qpTVmxihApHI91w+nAgoKN5QkHMmgb7WmrW5dDarc38ZrsZ3hrhk0IgdRZwv?=
 =?us-ascii?Q?FdRmY9GWzUpSFQBlJLXgbG5JhoWCTPnKbdp/IWujv24CqtLWc/Kznqc0ccJv?=
 =?us-ascii?Q?wWKhfDnFvIeuMHpK/3tFGMSwG2XeaeexymF1enlEC0vBYViVUjAK2Y7lbMme?=
 =?us-ascii?Q?lQsOuDQuDrUhpjau6Prc8zhDtFcRJGnRrVCOqjTJPg8T6pJutaQp61j0dWqh?=
 =?us-ascii?Q?un2SwZs8pkvtd+HaSPpiPdbVEXzzjAxK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ND7Nv8gEIjlDAxupavEvwAlLWoXgR5WIkv/52YDwBR7dN2nRbwdI6fqHZrKV?=
 =?us-ascii?Q?3d/f3tvTQqkgRjhUN8UNtAeLtJvVe/m7Bhc+5cwhHHydR/EPKcHAetm6f6Qz?=
 =?us-ascii?Q?nkGfd/SSC446C39Tvcnz6/QHxU3Udv0JYPKVcBi6iSlo9Pfa+1fxYxNB1A0q?=
 =?us-ascii?Q?WWVGpzU8QnKEL09ZfxlJrK3k1Uv0QW0EN7QTe4yRwZ4QU4cdqzrGLlZzPiau?=
 =?us-ascii?Q?h4s5n498mMmPBNfbKL0Xc3qHZOViREg2D4wYMY/k+nt3QLCQ4oIzdjPhdXxt?=
 =?us-ascii?Q?Yrjm3JIZmR5YB97hAW1W6vfWqI8HmuIkazRR8LT5uiKP4NjRMfPRphPhjX4Y?=
 =?us-ascii?Q?5cTrw7eXLyB0fGxoDLQ6n5VE6ZuRkbZz0iH3OyZr2grOfyJcXNTQj7C9+E+8?=
 =?us-ascii?Q?I/UtGBqnhvF6YzoPuUsp9Xg5+so32IJpHjgO1vDyRg+KeOgVkUdXt+/gIz2h?=
 =?us-ascii?Q?K/FTz2nLz98j+Rm7JpCIRktrJj1/NrL5Sh5lxHqJ/1MQwBXnRK+ozyec8Cqi?=
 =?us-ascii?Q?HTQCwz5b1BK5guX/4GnKZ3dY/bJIANnK8YMWXGzIr2lbT/q6aJLzhGnSjNUv?=
 =?us-ascii?Q?MToN2mm1XXwtmD+Hg106UR81ci72PbxxiX+ZDuubsbeBZHyVSL37oE/YS1lS?=
 =?us-ascii?Q?enE/XSC+4tseaGhwd5fJjre8QANT2o77jbUHgQQCOgIA9kjf7DpX5QSG7B7P?=
 =?us-ascii?Q?Mmaf3BzrdJSa+S3Z1VW4rfFdp+RYGpdb8MI9hrzahyMeA3v2UH2Nm2tNUYkI?=
 =?us-ascii?Q?zlZJ/2L/lpxkJzDbEC9Ev4Xc8UNgKMQQY+bL8aJ9CD6xQvci5HX6bquIIENa?=
 =?us-ascii?Q?TNC/K1Qk98/7IvpLTZPheKqKMjYxYbPUoEBMEtHTQ8BBlD4Ub8iNr5eKqIFD?=
 =?us-ascii?Q?Yw41JkOTWTm0kVF4MOqRYX0xwle3P08/Un1aolyxccZpPXfYkbWWApdQUL5R?=
 =?us-ascii?Q?4J2G9BcLwEmDg7m1yyJtQeusu7gAUf+XZ/f9QkA1Ns3/zb6FphS78b6pLe6o?=
 =?us-ascii?Q?nVjYzJvF+Ddk8KcDFwyroJbQpunigFL9Nhus0jF1tMGYt9C3K38J6ynQ8h4u?=
 =?us-ascii?Q?UfFUXAZ2345ZJZU3feiks095H+yskzkJCLH0cHVN/kg+QrQ+/NWQYRdHkeWB?=
 =?us-ascii?Q?S9/5SxVKjRwqzX1s6Bjt233MnmzyUGmlGCFrI1y/L2hO4qajvbsfpNz44Te0?=
 =?us-ascii?Q?Fvl4dWRy5dWWZMW09fpMgAPawAGjdaR/ijJoqSIZhtlkbk9bXZISCqSbuWDd?=
 =?us-ascii?Q?trjs+jz2LgevMCEI3V5tUk4btSnPss57GxcXDsq3CTowethLdDqluxHcH8jR?=
 =?us-ascii?Q?xZ/rS2Jgzj8xVzM3Xve6sPjxr7lrnSPYCy+tB0nYb8gF5ZYHlZKDaqOwCsq7?=
 =?us-ascii?Q?x647NJOzjIDiRvwwtxGW+PnVGO6XZvZ5upKeYaGtAejTHMfikQUxqmUZLs5p?=
 =?us-ascii?Q?Tz7kt1tMYGMIm5K5KRZvWfLCOaXncaPhXExIORHaUux7aSWsrgkI6GtdwEk4?=
 =?us-ascii?Q?DdDszf3PuSHwNlloOLCTpt8lUNBTsWwVomEQeC2jN3f9VRC2t38t1urkFjNu?=
 =?us-ascii?Q?rnYOJHNACu5WEB0VUqJqMFGUfJzqqEfYH3vyygsB/JjnelLbm92szIp5v94L?=
 =?us-ascii?Q?qutvqBG5CLeH+xPuMHwgKq5FiXHVaUU9uA1y+3dCj5h7PkNg2ge4yCgNCYfQ?=
 =?us-ascii?Q?ruqncNd36UrotHejnqSuIm05efoJc9ZLXKzSY0ErweWQOuonNUm6RI/f+g7J?=
 =?us-ascii?Q?7f5jsCgpYi3JkNscbHK93XBk77o/aEM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3d6338-b0a8-4856-9228-08de52f3ce11
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:33:42.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yykHy1XVHxvN2Q7eUIXrzCjdp0f+46sgSkt6axIsOQ5d5e5CnzXT5RQmzgIxjSXGarKau/UBFdj/sCEW+6aHsRhf3OH0XzcHULfFkjMAEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4488

On 13 Jan 2026, at 16:02, Chuck Lever wrote:

> On Tue, Jan 13, 2026, at 2:54 PM, Benjamin Coddington wrote:
>> On 13 Jan 2026, at 13:53, Chuck Lever wrote:
>>
>>> On 1/13/26 12:02 PM, Benjamin Coddington wrote:
>
>>> But let's do some homework first. What exactly are you trying to protect
>>> against? Let's hear some specific examples so we are all on the same
>>> page.
>>
>> OK - I feel like I've done a lot of explaining already in my responses, but
>> here goes I'll try again here and I think maybe I'll get better at this with
>> repetition.
>
> Can you provide some specific examples when you repost?

Yes, I can.

> For instance, give a particular file system implementation and explain
> exactly how a plaintext filehandle generated by the filesystem can be
> used to game the server into accessing a file?

Ok.

>>> I'm asking because the folks on this mailing list you are presenting
>>> this to for review were not present for the in-person discussion, or
>>> more pertinently, might not know or care to know how NFS file handles
>>> are utilized.
>>
>> Roger.  Do you want me doing that here or in a v2 (no linux-crypto here)..
>> It seems like you have a pretty good idea of what I'm trying to accomplish,
>> so maybe you can just give me a hint so I can start all this over in the
>> right direction.  Discussion might be better on a fresh posting, I have
>> fixed the nits in the RFC..
>
> Let's reset and start over with a v2, and broaden the Cc's.

Thanks - yes I will do.
>
>
>>> Is the issue an artifact of the design of the NFS protocol?
>>
>> No, it's in the nature of a filehandle.
>>
>> As you know, a client that has a filehandle can access a file without
>> needing to walk the directory tree to the file's location.  That walk might
>> have permissions set on parent directories above the file that restrict the
>> walk to the file from that user.  We'd normally expect those permissions to
>> keep those files from being accessed or looked up, but when filehandles are
>> not completely opaque - its trivial to guess them and bypass the security
>> that might exist on a directory walk to the file.
>
> Then the answer is YES, it's in the nature of the NFS protocol and
> how NFS LOOKUP works.

Er -- ok.. was that a trap?  I think as you say open_by_handle() has the
same problem, and there's no NFS involved, so maybe no one can be right on
this point?  It doesn't matter.  :)

> And I think that means that every NFS server implementation out there
> has the same exposure. And wouldn't open_by_filehandle() have the
> same exposure?

Ok yes - but also no - depending on how filehandles are implemented.  Maybe
other implementations already hash/encrypt/cache-by-key their filehandles?

Yes open_by_handle() on a local system is exposed as well, but I think it
can only be fixed by fd_to_handle()/path_to_handle() and friends.  NFS
server is a bit more exposed than the local system, but indeed it leads to
another question:  can't we fix this globally in exportfs?  Yes.  But what
of exportfs users (fuse, open_by_handle userspace apps) that want
different filehandle types?  Then the need to plumb in the configs in nfsd
anyway so that the exports that want encrypted filehandles pass a flag to
expfs to get the encrypted filehandle result.  So I think its OK to work to
solve this problem in the NFS server, and then it may be possible to
generalize the work for all users of exportfs later.

> I guess this hasn't been a problem until now because the Hammerspace
> pNFS Flexfile implementation has not been in the picture? What will
> HS do for customers that use non-Linux NFS servers, in particular if
> those server implementations are no longer being updated?

I think it's always been a problem, just ignored/overlooked.  I'm unable to
foresee what HS might do in the future.

>>> Is it a problem specific to certain export options? (I think I heard a
>>> yes in there somewhere)
>>
>> Yes - specifically its a problem when a server exports the same filesystem
>> to different clients using root_squash for some, and then those clients are
>> arranged in a way that one of the clients acts as a broker to "hand out"
>> filehandles to authorized non-root-squash clients.  This is the flexfiles
>> scenario that I am interested in.  I am happy to go into much more detail
>> about this.
>
> We need you to do that, please. I'm still finding your answers a bit
> too hand-wavy (that's intended only as polite feedback).

Roger.  I get it - a major mistake to not be as clear as possible.

> The mention of pNFS Flexfiles here suggests that this issue is really
> /only/ a problem for the way Hammerspace uses it's DSes in this strange
> root_squash arrangement. It would help if we could identify a second
> frequently-deployed case that would be improved by filehandle encryption.
>
> Is this only an issue when root_squash is in use?

No - imagine, for example, a single NFS client that cannot walk down a
directory tree due to permissions, but can instead just guess at the
filehandles of the files below that directory.

>>> Why precisely do you believe obscuring file handle information is more
>>> beneficial than simply signing it?
>>
>>  - the client doesn't need the Message (M in MAC), so it doesn't need to
>>    verify the message or decode it - which is the normal use case for a MAC.
>
> True, the client doesn't use the content of filehandles at all. It's
> the server that needs the M -- "does this file handle belong to me?" --
> when the client presents a filehandle to it.
>
>
>>    Adding 8 bytes to every filehandle may be an unnecessary overhead on a
>>    wire protocol.  Balance this with the fact that using AES-CBC will need
>>    to pad out a filehandle to 16 byte boundary.  With all the different fsid
>>    and filed lengths, depending on the filesystem, I think this argument is
>>    a wash really.
>>
>>  - If using a MAC, the more filehandles a client has, the easier it may be
>>    to guess the secret.  Of course, that can still be practically
>>    impossible, but the scale of work to break a completely encrypted
>>    filehandle is far higher since the client does not have the original data
>>    used to create the hash.
>
> Someone (ie, a cryptographer) needs to do the math on this one.

For free!  :P  I have beer.

> - Filehandles are public and live as long as a file on a filesystem instance.
>   This means (I /think/) that the signing/encryption key cannot be rotated.

Right!  Key cannot (should not) be changed for the purposes of this intial
implementation - /but/ in theory it should be possible for multiple keys to
be valid, and the server could learn to be switched between permissive and
enforcing modes of accepting filehandles.  You could "drain" the clients of
filehandles with one key while "filling" clients with new filehandles hashed
with a new key.  Let's ignore for now the problems with root filehandles..
just saying that the filehandle hash/encryption space can support multiple
keys theoretically.

> - Individual filehandles are small, on the order of 32- or 64-bytes
>
> - But there are a lot of filehandles, perhaps billions, that would
>   be encrypted or signed by the same key
>
> - The filehandle plaintext is predictable

Mostly, yes.  I think a strength of the AES-CBC implementation is that each
16-byte block is hashed with the results of the previous block.  So, by
starting with the fileid (unique per-file) and then proceeding to the less
unique block (fsid + fileid again), the total entropy for each encrypted
filehandle is increased.

>>  - A non-obscured filehandle can still reveal information about the
>>    filesystem that the NFS server does not intend.  NFS doesn't control the
>>    data in the filehandle.  This information is probably better kept
>>    unrevealed to a client, as the information itself is outside the control
>>    of kNFSD.
>
> Here's where I would love to see a specific example based on one
> or more of the file system implementations in the Linux kernel.

Ok - but also keep in mind that we cannot predict what future filesystems
might decide to use for a filehandle.

>>> Why do you want to protect file handles, in specific, without using in-
>>> transit transport encryption like krb5p or TLS, or without protecting
>>> other XDR data elements?
>>
>> Because I can have different non-root users on the same client that share a
>> krb5p or TLS wire encryption transport, but not want those users to use
>
> Each RPC message protected by krb5p is wrapped by a specific user's
> Kerberos credentials, so generally speaking another user cannot
> decrypt that message.

It doesn't matter, because the users on the client can just use
open_by_handle() on NFS and guess filehandles.

> Multiple users can share a single TLS session, but generally one
> session is considered to be a security domain that should be
> shared only by users that are mutually trustworthy. You can open
> multiple TLS sessions, one for each such domain.

I don't think we have a way to separate users on NFS by TLS session.  Also,
open_by_handle().

> So far it still feels like either krb5p or TLS could be used to
> effectively address the filehandle exposure.

I can't see how krb5p or TLS can be used to prevent this.

>> open-by-filehandle to attack an export and gain access to files below a
>> directory they are not actually allowed to walk into.
>>
>>> How much work do you think an attacker might be willing to do to
>>> crack this protection? This goes to selection of algorithm and key
>>> size, and decisions about whether one key protects all of a server's
>>> exports, or each export gets its own key.
>>
>> It depends on how valuable the data might be to the attacker.  I hope we're
>> making products that banks and governments and nations can depend on.
>
> Usually this requirement is specified by resources at hand and how
> much time is needed to crack the encryption/hash.

Yes, agree.

> The US government will require FIPS 140-3 compliance.

Maybe we'll even know when they want it!

>>> What are your performance goals and how do you plan to measure them?
>>
>> I need the feature to not significantly slow down operations at
>> datacenter latencies.  I'm expecting a small performance hit, but I
>> really don't want to wait for things like memory reclaim.
>
> There are plenty of other kmalloc / alloc_page call sites in the
> request path, and the server is designed around permitting synchronous
> waits for memory allocated with GFP_KERNEL. If you don't want to wait
> for memory reclaim, use GFP_NOFS or even GFP_ATOMIC but for such small
> allocations, it's highly unlikely that an allocation request will fail.

I'm ok doing the allocation dance for every filehandle, but I think its an
easy optimization to keep the buffers around if you know you're going to be
using them - same way we do for RPC buffers.

> So in a buffer-per-svc thread design, the buffer is passed from user to
> user as a thread handles each RPC request. Using a kmalloc/kfree_sensitive
> pair is the best way to ensure that the buffer content is not leaked
> between buffer uses.

The implementation requires we zero the buffers on each use, so it does.
Buffer content leak isn't a huge concern on the server itself.

>> Chuck - I hope you can simply tell me to use MAC or AES on v2, and we can
>> shoot it full of holes on the next posting.  Can we do that on fresh version
>> -- can you pick a direction you'd like to go?
>
> I'm taking a stab: If you want to prototype something quickly, please
> use siphash for v2. We need to understand if signing is enough, if
> encryption is actually required, or if even that isn't sufficient.

Ok, will do - thanks for your time and engagement on this so far.

Ben

