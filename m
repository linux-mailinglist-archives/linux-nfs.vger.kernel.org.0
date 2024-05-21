Return-Path: <linux-nfs+bounces-3307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA498CAF7B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2F21F2344E
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B77CF39;
	Tue, 21 May 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZuUbbZd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2887EEED;
	Tue, 21 May 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298654; cv=fail; b=LtDyNMCph8W+CENCdVMeLeDOEDEBGO3E/WwKA0tuR0hyGg6CldiVH9dSFVNuUWCfSatzAE1LZNn08C/UROa8+vZ6BzSQkwyFCIK2qqCVE8KWKLMbGFiMACK9vlls3ncN7Bmz1KBMFBrsFE3KxRLgtkcqaDcI1JlPQVacU0FcPDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298654; c=relaxed/simple;
	bh=1VzW7NB2Dp5CMJhrw0i7iEXoIj9Sln6OqRivt+1hh3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ckh4d8SMXiEStOO6kW8S9/Qn1WyhrOUuRxL6sOsQ28lWQJA4uxChdjHtmmMmtZlQX0346t9km+nRkCnKQOOUtMA8q62z7/DybcVt7tTVaVbfD1uiPnlMAoQ6e90eR7Dy1huLmBdwQMsVXW5Ou1BDgc7WI87fwCigI1obVgJjimY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZuUbbZd; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=freeHOurK6zqMdXbHt4IbJoQ+ksSe0kCoKx/STE9C/tBnayg4oeuBUQtbmNh4zhsZZOgMPTipUjJ6H2umq1yTsMkgmWGUnWwRYgp3sW7PLJJnowgbxrQ1mGYMikFVMRD3fM0fxece++vgmDE+zxyFCuQf0Ozbu6YroQcjMUX0bWQX1Zu3VK8Wcw2J0QMaLkGvNICeq31gSAImuutcFNSLisgNhTPessiHkjPqySbL570AGPUUp4hIIxjJPHvTVgtl7p3q9ZDhWVB4RDevWJdnOYST9Tx34kkbPWy6AwochVzov8yjyDF4fxgrNCNttsYD56GHM2KZW1vSEib1AO86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0piSYvW37PtMTDZo0m/CANeSMtkIVZGfuasOiowU0tQ=;
 b=dg5f5DOC1nCxUy8wiciGzdznFenoNP2pP8mWTrg0BHPmb0c71oXgbC0ctflr3UiGVn2wKFJOi0Q746tian489xB+sx4AzqUec40z/zq7qQOiEDXdA+GnYE9HGKs9Y8Vl3Hz1wR4P0oSLrk15SH9OBG7n4/OtpkzJRDAv1ZcB9zBnbkQ9xf/UJczSVFHWq1BDL3Ftoy1FPnPpTnuHJZF1q1TakwWNRMQfsdrP1+OZAyPOwDGjxQ+H0HFg1O2qSBdF0WpF5YABo9jvGWV+w+7JbGzSjZYiUKUncmYwTeBEyx5ci5itftgqC0y7a9QnPKhLupsI94ji98zYEjWciCykAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0piSYvW37PtMTDZo0m/CANeSMtkIVZGfuasOiowU0tQ=;
 b=JZuUbbZd/EN4XfbIjeXpGtxk0tx+57CVsTr1zUH0Ahup4kYERAhKEjFKr1Je2SwUITwyj/7zwltAaH5yZJXhI7a0LaKnM5y/nUkTuLjBiYt4YgDHi0b3o53/RW/uDIzxek565PZK+boKR+x73rwoJ92fvIy4XHLfSp2zeo//jgHsOW3xmi94ZnuYMPPLnoL/Soutl1qMIAEZci6KZwhr4bx836Yfreb0NxPG9ANClPcgJgwywGDLF/KL473p4GCyutjFjwbeMtvFoA9iGsnByIQQnIVNtuPqRRnh2d0bvPkHAfJhjjUxpSL04j9lWBlCB/GcTEvpFxoXT4eXuYB9+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:37:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:37:29 +0000
Date: Tue, 21 May 2024 10:37:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
Message-ID: <20240521133727.GF20229@nvidia.com>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
X-ClientProxiedBy: BLAPR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:208:329::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e4a7aa-a729-4a5a-e2ef-08dc799b28ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sn5DnvXcJD/MFC0jqYES2wAjovbQEQsACfYzrXLqYokoMN/FPbp92FIVHaCK?=
 =?us-ascii?Q?0/Un1KYSCAW3jhnL/oBkSYX2naRL83HfgxrLE7+Nv/YkHaXtiJJrxfQJX74s?=
 =?us-ascii?Q?PGMelQD1R5WV/FT2DTYaM6km5hGYmvs7MND9JYjn6twrYgqA46HYNmpMg4U3?=
 =?us-ascii?Q?yEqQsovmKl4tAXHTlAmVwmsqrBIka9xikaZQw0aILyVaY8WbuGOhyvwlrAoS?=
 =?us-ascii?Q?8oVOulD3ItGQBPg70RToDliRbdeuNadO95bZr2JRWKMzcV66Q9GrGhgTsnKv?=
 =?us-ascii?Q?VkFsScCEPMFwmSSwUu/CYL5eYXlJ4TXF5yKdye/z1hYfAKYdesiZwT4a6ARK?=
 =?us-ascii?Q?FR2WjeuvGQVWiby982hZuK+YuZDeu1fzbAWxjRmBecm8sVCE6FpcnmJN0meK?=
 =?us-ascii?Q?WwWl+IkoX9VnYWp/d5/zrB5EfHqLbEoxdzqMGOF1lXIG4NjIe7UZZoYLbJdf?=
 =?us-ascii?Q?wbF0TqlyHhu8f0/F3kxK0T/bbWPHURJTZoUzdBiwW5pdyOdZZKHmys4j5d1v?=
 =?us-ascii?Q?3XuYwWgvLs0Bcph8kAZoAok/P1QZ6U+kBDHzuoJYf/BTdOuhQBFQuay2mU3y?=
 =?us-ascii?Q?u5OgBjTlctgw++Kqz5SVHcJm6jVkuM25UwuGHMCKqs17Znusotu7cd/1gTCM?=
 =?us-ascii?Q?YjYxFI8C++YJbYANg23Vjli8WufPdG1L8ESGR3J1UQcdUg8uj1h8YRQ66cJp?=
 =?us-ascii?Q?KlDOrS9r+MqONFuPjOa2lf6UvRIWBO4oEK8SL7mQogWBndVDiVopH1KLTflX?=
 =?us-ascii?Q?4VTIjHeKLyH6yV9qGQuxOp+mVcnNt5Yq/F/z7ISfkvGgR+yALXit0Povg/WT?=
 =?us-ascii?Q?mEj83/d3fxeqBSO6mkVe91PXk8Sa3iznDDUPP9ZX6s6BXr/RMcWyeLK/dIm2?=
 =?us-ascii?Q?eAIDZ2AWTyUkOlM061Ix1062TVElCEh2aQ7kjZ9nwtqki7qbmTrQ9JAhVTcc?=
 =?us-ascii?Q?O1blP4rurHvMLOVnhQHyKakbhdhSAT81wLs/AXhbNEotYy65ELvww+LKmtIQ?=
 =?us-ascii?Q?mhBt1E8P4aUUbI6j5qCbPQtUdfxKUb4okR5WcpejfWtLond7EqkxFeyH3vO7?=
 =?us-ascii?Q?E8CIA+LEgZOTa9aUsX1Wn3UNbossE2nadl/C+lRX9H3NGeviBQb0hA3zuOqh?=
 =?us-ascii?Q?WNoVT+K24rkFgq7J56gytAwRTU/o2gJ6gfJjq9TUKgNE5gSpHzk5AcJE581+?=
 =?us-ascii?Q?myg4WE00zeSCABg7yzSpGLwNn+k0VjQp3peOdN+dKqkVXKv02WWFNCNb2VaH?=
 =?us-ascii?Q?Qa2mRSMiTRPjGgCP1yAlI7E4QuS+OzZ4qYPW+WiWqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?damMdoJ3T9wKReKnhJ3ONiS4LNU9cBxTupkG+ffWO5M8rcn6inFIx85JRuoP?=
 =?us-ascii?Q?MG7VpZ4r1gMpqduBCz58wPIFi87jQGK08uQu62pbp51+hDrcFPTGVH+DxCsk?=
 =?us-ascii?Q?dZD4WlNV84zvtNpW03Ci2TE2U++uVgkTlZBR8gXnmbg845HmQ9LLRVGwElv/?=
 =?us-ascii?Q?apRg4XTdZL3lgIJ1V57E+ZpaLGTlieeoZfYx5PE3iOBXXP4vJWTJPuRU2cHs?=
 =?us-ascii?Q?nchee78bkGaoGO+wAyypb/KNhvgEAtL3271AQkdKiDWR9xfDcTdooDgNOSud?=
 =?us-ascii?Q?aREa+drLMO5Aqdyxf7t68f8L3ipRJqitV4oweW1fgTajFR8aT+d0o0B3azZV?=
 =?us-ascii?Q?XzR4hjpaVuS/5D5smsXfPrsASiItXXt/zaRjSoaF3LUXhIjw7bINZlNYmnWG?=
 =?us-ascii?Q?P5128ApP+qH0fO0oRZVSZbHxaCwzJnS33+EVuwrN9jITdT9VIx76TCxOdTE3?=
 =?us-ascii?Q?Za0i6g77N5bgJ7T3MmuqP5V7wtQ9HPljR4DFk8Rdf7FYyB5f63hFDgYIc5pp?=
 =?us-ascii?Q?8p2NrIvMJAFcoexT0Yn6dkQ/qOyqT/8zyCYag2s2M51mP5OoIecgZw88zJX+?=
 =?us-ascii?Q?NY5/f5SOkhlRnLSGLejLX/v3FKgAPF8UHZ/7Rm5uWnp1PWdIv+HCHXXmbiwT?=
 =?us-ascii?Q?352aM5V/sJIl/YwqWZYAudlXrlJnChmhRIkeW+gIt6JCxGMZOJWdlsWr/Oxe?=
 =?us-ascii?Q?i96KuwuBdAFs6WdbFjhZBtSebGCJQ6PalqQvLqlKitMzXSerwRLeDUNPBppw?=
 =?us-ascii?Q?yLdRisFQl2G+QXYM4fj0xVXCLDxtWyMAQr1I/zuaydeW1uWLQhVBrZQgx5Jf?=
 =?us-ascii?Q?baeEX/TF/XhxqzlZBmqFPhvGb3uLVFgDx3RX1LcT05g+9aDo5ZEgp1RPWchR?=
 =?us-ascii?Q?ddOCJaFME6AvlU4Wab4aqV4rjoSXP7OsGim3kwvfceLySErmOXROFJn4tKpz?=
 =?us-ascii?Q?VirGfa7zSI7qCgBpgpFDkbYMR3YuBp0GfkKzSCkXXMqMZor7A+Tl2mGnf5Ef?=
 =?us-ascii?Q?/DXSp25MnehjKINuTMDjLnV83sMc08qA8GWzWQ3ttjAwZ9yYNqvqNpf75rXg?=
 =?us-ascii?Q?DVnAWEyhQc1UDgXTlb2qS0BdGSGaqvBIyJBh0daA8jTGG37Si93jgBv2Y4KP?=
 =?us-ascii?Q?7kXa4k+aVzKpzSLh9cKYncWFufkprazBT3C2WbrWRvLcWpthQ8ixvLQgNj8r?=
 =?us-ascii?Q?ZuGy/S6Iqyx8b4LSj6YuloqlblXn8LtOFuZE1922b9Oy7FfztOTkvzH5f7ta?=
 =?us-ascii?Q?XcxyO3ysr2XSHgdov7jwOVUvZ5QAM2YnED1+kHs/bEFRdClFfOhWPYgxSJS7?=
 =?us-ascii?Q?dxpNE+NZswibqYjCWPj+8YKhYNL5hfCNwRdpcU4r+soLU3lmS3LNy9Tcr5u6?=
 =?us-ascii?Q?vlLze7WKrbf5sjozXICQntB0T/IAYXp8oZrCd7ixGAoqUOmkmBECNlPQG+mq?=
 =?us-ascii?Q?tvbEWckmim6xqWTkZfQ8yDYXuAMCtE1JO8DxS+S9Da1a5ETJ6V5PlylMLK4H?=
 =?us-ascii?Q?fcstjldwdRO4TX0xpi9NDvfWtN/kpJyZlZTMJp4qkovg6bhLYeHcX1RU8s5e?=
 =?us-ascii?Q?QuzHq1zEzNM5TYRdj7A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e4a7aa-a729-4a5a-e2ef-08dc799b28ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 13:37:29.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScURJqsEuJMBaQnD7DCAIqPYcF+RIVgg/WBoBUoRLeHKO/TSs/WknNmhqMOPgf2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477

On Tue, May 21, 2024 at 04:05:05PM +0300, Sagi Grimberg wrote:
> 
> 
> On 21/05/2024 15:43, Jason Gunthorpe wrote:
> > On Tue, May 21, 2024 at 12:04:02PM +0300, Sagi Grimberg wrote:
> > > 
> > > On 20/05/2024 21:05, Chuck Lever III wrote:
> > > > Hi-
> > > > 
> > > > I've tested this with two kinds of systems:
> > > > 
> > > > 1. A system with no physical RDMA devices and no start-up
> > > >      scripts to load these modules
> > > > 
> > > > 2. A system with physical RDMA devices and with the start-up
> > > >      scripts that load xprtrdma/svcrdma
> > > > 
> > > > In both cases, after doing an "rmmod rpcrdma", I can mount
> > > > a "proto=rdma" mount or start the NFS server, and the module
> > > > gets reloaded automatically.
> > > > 
> > > > I therefore believe it is safe to delete the code in the
> > > > rdma-core start-up scripts that manually load RPC-related
> > > > RDMA support. Either the sunrpc.ko module does this, or NFS
> > > > user space handles it. There's no need for the rdma-core
> > > > scripting.
> > > I didn't know that rdma-core does this... it really shouldn't, the
> > > mount should (and does) handle it.
> > This is new, it didn't used to do this
> > 
> > > I also see that srp(t) and iser(t) are loaded too.. IIRC these are
> > > loaded by their userspace counterparts as well (or at least they
> > > should).
> > And AFIAK, these don't have a way to autoload at all. autoload
> > requires the kernel to call request_module..
> 
> nvme/nvmet/isert are requested by the kernel. 

How? What is the interface to trigger request_module?

> iser is loaded by iscsiadm.

Yuk :\

> IIRC srp had a userspace daemon loading it.

srp-daemon requires it already loaded AFAIK

Jason

