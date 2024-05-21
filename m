Return-Path: <linux-nfs+bounces-3303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91B8CAE77
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9865C1C21470
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7976028;
	Tue, 21 May 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1K5icbY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1328E7;
	Tue, 21 May 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295392; cv=fail; b=Pp+CbzW7/7l/lQHH6xQSq2ajMQj/qAzzrMRGua4yqGgMjUOJuLTDNaMxmZuyHjQVRraTom0ZAJuzXxzU/SKYblZV1ynonLrHn29Gb6araH1URFYzZWvy9BJXmCEXT6IRjil+MsuuPskzPEVJfTQCmCqgLNKR7QVqLCQjfI/y71A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295392; c=relaxed/simple;
	bh=YR4doiISX260mWUdfV2X7bard3/pGQXp8zB+HpJXmQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQtFwLgPzNkj5sOFulS0hanJ04DNI2Z/Me471Hj51D2rNkoqVVzua4LSEha2QlpRxDfQ8XwjNjK3kaUZxKhp9kKaLc/96sAS4M/8lCBWm0EBNUvV/gujkRzcCBJuIOdxm+/+2dX/zsDW2ZXlkF+WxXR2omKlOB/CNv5HWVd6N1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1K5icbY; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWQL2YecG5ChW2MgO++uTVIIy34Tfzw2ZyDr55E1lXqkJ3GhTqJH0c0ZQE2vHeZSYz+FOGz1NFJVHyVPJXyqQUwC+S2k2rbK24clicye3Q2aCvUWJUUb/OdH3jgUFxckLWEqGidTw4fYUNS/7kfLDSWm4L36CHhNrQKtlNB6E/zT3lzggO9HyRsAgznWIx2PqSHY1FoqFmmloLmSf5SoBBVM+4jMu8BgSRzLDwvEee5piFPjWlrvWfgRfb+Se+VBo0C77NyuRWIG7UEIEGlWtQy6K6V+hq+rnQqfFGvTjofOPoqU3u4Tgp0BUJ7Uj4wyY2pxCZnv3IDG90ijn7jy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6SRl8gCFte3lI5WOMCNOjXDYWPjR47gEkdlhO9v9cU=;
 b=aDgmlxHrdyV6w1kFLiZXs1nZDup53XE1S5nU0ugr7xoWUZi7PBucZSrOtREV+jeoidqr4Q1zXv8Nu5UDOlf65xmanLr3ih6vb8yoQmcoz2wQl1+JA7tBhsztK7/HVgw0eQZ7bBhcbqN1ANDIGafOBzM7KNkw41IdENXf8xgme2fTdku81GpR9SCYi2G0wsMEgUUvqKkQtJgU6zPuNXynZwvXorRYIneypyloXBF17B8Tt9ahe0ve2rZLebM96BE/uVHaP1I6C8wStEjyyNlWwrCOT1KLo89TaJCkE0aI7VzzL25P8FWNZEXrp/vlMGh6IGoEKcG2eeG6tsqxza+eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6SRl8gCFte3lI5WOMCNOjXDYWPjR47gEkdlhO9v9cU=;
 b=H1K5icbYmIBMw/alglycm9z5tr1ji8wewr8ee/jLguHGtXnSThbUMmBzOMT2odlRr2xOtXvyI1t1r/QxQEtdK7iJI0It/IOlhl2/1ksjHGZouQKOtgmVq5iJBZzRYyGMji6N+FaZo4hh4LmRMH4Z2kJafpQcQMA53Gu/l0LUXlj+V11KwaPvJQBUohtOmLfQroGsE8koDZvjJv/ph8TrorxhAGA1l7ofX6NAPXdWd9abYUKwzSHrmbJlB2lSkFbEkVcVv40bRjhSNi75jNK0/+XbJLrmz3/+5OWRDAZwxQuNGV6090HahJt7mS7fP8M5h0oqAg0ouJ89R9MW7FI9xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:43:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 12:43:07 +0000
Date: Tue, 21 May 2024 09:43:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
Message-ID: <20240521124306.GE20229@nvidia.com>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 40358957-89ab-47c2-7186-08dc799390d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkjuWNRsVIRqWvao7h58v73ZdQjSka2NsEIvp8e54hS/+igKuP9PWSNwdDR0?=
 =?us-ascii?Q?q75JGVSE2N0DyGXot+GSx1dqgQuYvy3llCnTbyja8jGLMUmAe2yqm7KV220t?=
 =?us-ascii?Q?ceXZAEv8VvPlqQvptL6kmL0nFGgzpv09FZe2hvnBf640ANzTmfjZvDeUR4dN?=
 =?us-ascii?Q?HEhUXVdGpzZkjhF6IdqqUjUm91Dc+VbAlcw7Tejv9sY6yBJLhs8tPKFnA0cX?=
 =?us-ascii?Q?xUutIww1eqxfPYV/eike4iBmlSfj8+8qlAQXRmKRWc5mk0P4T7zFwUA8dK9J?=
 =?us-ascii?Q?yZ+nynQRkjWh59Yjq0rjTMpN8pJJx0QPO2bbbfYE6Ei5OudIS/zTLgGwcW1P?=
 =?us-ascii?Q?8JUeEwiwmelWP5Mvkhw6xxMbi7gnZzPgAt0I0hdGfrBWDa4rXZh24BA9yuP6?=
 =?us-ascii?Q?+JrVWnB60qbC/9LNZ0sDCqFDpM0DEQGOyJhvdCRbXNO2gjPJKo3zxewM4TIf?=
 =?us-ascii?Q?JeAzmxCwST/CWSgulg7Ghm8xlUF0ZW0mi9YmUe6Dyz0HOYzXQOH5KUnhs7DP?=
 =?us-ascii?Q?vXPnmCxDvctSunu3jgI/eGmp4KZDIkJhs0uS/thfYB7zRgs2Ais9vzMVgD8R?=
 =?us-ascii?Q?fIVV/qcTbx4UHvefHNIOIIlZjloBvZpTwhh1vgThBYmmLu3akPj1WQR8Tm+a?=
 =?us-ascii?Q?WKoApG2fxRBd++H69peoHF5o/8Mj0X4y9YjYsszm5dD3PSMVYF5Huua/Nt5q?=
 =?us-ascii?Q?LRlmpNKvhK6COX72/CNC9yrS2WFCKCet7wxWWddFGZ34wlsEngDIcOVDQ5au?=
 =?us-ascii?Q?7oRU5awW/z+O7WJR1+tGm81MWkgqiyiEi4j8Tvea/hQWuilMUzy4L2vDdv0i?=
 =?us-ascii?Q?h2BhnVfJj1KdKUTlyZeYeBQc+jbkxiznP06QKt0vyd0l7lqcvpYlllFajmwn?=
 =?us-ascii?Q?/mMyOl+a+SAeBtM3nh03rXwy5masxF6i22nwibMMU+qqt5N/6iJTWrXmGUoc?=
 =?us-ascii?Q?zskfCkP5BWYFrYDLeop5T7c3iPxGm3Wegi8fmb2BNp/Uj/HwSO76aBW0KhiR?=
 =?us-ascii?Q?33N1YBicO99VgeEeOhi8wYoAWDQvRLRAW+71Lhlk/60zGAvZ2HFspK/ZItP4?=
 =?us-ascii?Q?VQUBP6+TykwmXvbmRtWXoDxfzJ0Lvuxi1840Wsri9YC0cd+76HZTGVF2TiR4?=
 =?us-ascii?Q?caCD3IlgqkojGOPdP6LRq/xiSqAsgu1bbkO92PxGdEsHortmItGuniDo1dCI?=
 =?us-ascii?Q?1WsCAbZWPvWyivYy+sukAe6LAeERE+L7JGtLxEYJ7SIAJUWVYlbpAowlAzG8?=
 =?us-ascii?Q?PxI5P5jX8z4IdHayI5rGPLvyiwvexBGOSJgkapUuSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWkXBg5P6GCC29YJg5o8xT4medEjkxwmofAH9vZV7CMyEHwy0FZOaiORe4Qp?=
 =?us-ascii?Q?SrluLkdYx79ks6RNQhhMUJcvBc1QLTdFePMKZDxe8iDF/MtV184lCxjudTxd?=
 =?us-ascii?Q?me7dpbpQVUnyUDFkVfNP1qZ3Ozm4YeSp1nc+cKYc95EUvSbwDG6AIA1ZGXjs?=
 =?us-ascii?Q?OvRdb0WYchjlv4EKM7GIw2FPP1FpBR+vkLyZFyyst7TtIUVFQzTqucoWu5xB?=
 =?us-ascii?Q?FHxfoSRcYqh2Dbu/kbfqPXtxfYAIG9ZgrNUbfMrcmMr35sG0HwNgyBfKLVXb?=
 =?us-ascii?Q?5ADsZfYkrDvYDAjE81+nd+JH4TYaY/eLkXNm+vDVaz0zP0EByRGMMc8QGtkw?=
 =?us-ascii?Q?zt5OyGpIwPhiDbCdwAA8QHvH1yShfChWtx3zaaincFkJxQ6jeUsWSyn2hW0M?=
 =?us-ascii?Q?RVcmsFvLN3D7lR/PGq7YFoRINWy52ojVDwzD8wxsmZoYJcjGZmgVjjdTA6Cg?=
 =?us-ascii?Q?f9brzseVGampSvnqn2lRp8oIPUaog/JLVYtoI3fbQR0wUka4IIXAp3xUDHK4?=
 =?us-ascii?Q?Qs6P0JHJtquj3B+t8qKsBSFcIvwUboUJH7O4yPGTMFr+AOoo0xKgULaNcNZA?=
 =?us-ascii?Q?FWErgHjQx8vru+1ozW+Zxnv1AdouE8/jwKlgMpnPDObHRDL/EeBO+SgpeG9a?=
 =?us-ascii?Q?RsCjrFUE/VSSGcAQ5qfPop7xSDMn2FTyCE/x36EK77lJDNMrg63nNAl6M9bb?=
 =?us-ascii?Q?0SE9INl3DkJFv/Z+cWueJ09tVkpAVyHofCuZ9apqonPB79UOg5eKfDHqGppO?=
 =?us-ascii?Q?HL4Ipf8wAWZbpkqF0GlQ3MrUhWSsluvkduSXe3WVyLyfnkEs12fk8cxtAsGy?=
 =?us-ascii?Q?9Fp4h8o1MLzurm1b25pTOg6wbb6jcV3dCAM79f4nWEVOPUNtd4A1+zLbDbgG?=
 =?us-ascii?Q?no4Mi4G2Cw8H4GnIXYyYHV/weusmtLEHfIK/SEEL9TgOQ3EqwPcdWR0wlr/g?=
 =?us-ascii?Q?vpB2KxU4J+dLTLqzc6KhNpkB1rxAgC0aY/Bi6xfWMoPhoSi3qMX+TOHA9eb1?=
 =?us-ascii?Q?uyLRllSKHT0HHZzNekVhspQa/EO43NPG/DRJ3onAL1uibeIlM+ykul6N1CKU?=
 =?us-ascii?Q?El6otATLyY+CxMVtsjvEyZl8Dkce/ImVykxERGmlwBmIC7OAsE/yNtZT35vL?=
 =?us-ascii?Q?4eNdB3JjTSRGHWt7+XffKGioDtqvMGV+06INJot7MztSmZi/g68LonTor8X2?=
 =?us-ascii?Q?B2XsL7k/pqxis5OH5pPpmE4veCniAxgmjdhGgGYCr7JRdfRrWh6uWzeh+m0A?=
 =?us-ascii?Q?FkoSvEUc4ss5LjZUDtPCaaDpw83xiavSuFVay+dDlZz72rYPpiAUqdzNc4MD?=
 =?us-ascii?Q?+9cWdx2qkGSTWVMRyaqIEW4AWhZT/NVee4JxGai+9OGf5J/yU+9vFRkHpZGA?=
 =?us-ascii?Q?hye50KztFTB4O+AoU7mc9/1ZI9X8YyV424d4XIrPFSB+G8SLJQn/sEmFDlA7?=
 =?us-ascii?Q?dg9kpIED/VJFEq7tf72m/sp7LfLNLUWh6KZzkgHxjtOU4QnwV/zGXXRPGNTI?=
 =?us-ascii?Q?PsffKMx/dsEWJ5H6HMgIVWVG65ygvSSnwqYacl9Jr0gBIs+IfdC1LEUnpMdJ?=
 =?us-ascii?Q?bFC/NTubOklLnZtC7g8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40358957-89ab-47c2-7186-08dc799390d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:43:07.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDQsrwaZBh35wIhv0xpRmjDDf3tin7NMpmWprVuIY5o8y3AllE1cfxykjGktTZ3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

On Tue, May 21, 2024 at 12:04:02PM +0300, Sagi Grimberg wrote:
> 
> 
> On 20/05/2024 21:05, Chuck Lever III wrote:
> > Hi-
> > 
> > I've tested this with two kinds of systems:
> > 
> > 1. A system with no physical RDMA devices and no start-up
> >     scripts to load these modules
> > 
> > 2. A system with physical RDMA devices and with the start-up
> >     scripts that load xprtrdma/svcrdma
> > 
> > In both cases, after doing an "rmmod rpcrdma", I can mount
> > a "proto=rdma" mount or start the NFS server, and the module
> > gets reloaded automatically.
> > 
> > I therefore believe it is safe to delete the code in the
> > rdma-core start-up scripts that manually load RPC-related
> > RDMA support. Either the sunrpc.ko module does this, or NFS
> > user space handles it. There's no need for the rdma-core
> > scripting.
> 
> I didn't know that rdma-core does this... it really shouldn't, the
> mount should (and does) handle it.

This is new, it didn't used to do this

> I also see that srp(t) and iser(t) are loaded too.. IIRC these are
> loaded by their userspace counterparts as well (or at least they
> should).

And AFIAK, these don't have a way to autoload at all. autoload
requires the kernel to call request_module..

ipoib is also a problem, we don't have a way to autoload it either

Jason

