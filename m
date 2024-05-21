Return-Path: <linux-nfs+bounces-3318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ECB8CB122
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 17:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44CD1F24815
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF8144317;
	Tue, 21 May 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dvOGPgs1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A87143C7D;
	Tue, 21 May 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305011; cv=fail; b=o93jHf7ULiwgGgcQwgaSOX1pHgWQUk0L+RUg9PtACbyyFzoUlcDekAMaKImn9TyEEBtaaJEErlADoqLZokFGbNgEA9TBvRX0I+VzbALvVvyLPSa0Vs0VMcbhU3+QY6EYZHBjLDosD0qezFIgVV1jDT8D3OIK3IyT+C3RaDAPy6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305011; c=relaxed/simple;
	bh=X5Zr07N2wTkRae1dwvSIpaZLoVi/U7CluuOiYBf1KvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VpDVslf2pXSiRIy+2rRuqa0So4zjcG5ycG8HUiXHO4sbeCxYKknEwwNphlR0FcE5G4rVysvOttK22uLIA/1K9rtmyLYkn1T2qlXHqtNLxII+iSq/M1qEEaQvJqu9dZJEDD7y55xXqBLPFTlAKu4hEJKxK60+I8xatc+Vhc9vl+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dvOGPgs1; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvJwQzckt8KnHzZCDSOcoseeZOa9pvo6TVakE0ZbJ9eHjISHZDNoCdjIO1Cp3ToMcRToEcIgVUva0+oylNkofnhFfKhn+wZ4hdx/QhWPhTUR9ttbiT24c7HYvLQEHbMemNACCH76VNhLkTFCKDNlQlF3xsHDUoL+87GoEzTYGteOPhylsl0J3YWCgusY1x1m9EqQACn2lbPhlylyng3D3RnPWBwCSLgUiupcBI3yssyqYMgDlf6X2LwmsCscGulmaVWgX0r/zycVmwM1pj3j9pWJJEnr9QSIvDgFWusNkNMgpxuchA5l/ZNvskbjgUrlD4M/xEsBgoLFOUOw8ivjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7PrUtGT5kWm6Ttl4rXwwTKTgNsD7UuVglHbsNJMed4=;
 b=cMcPNjtRRoJZI6R59q2gIr/YqUlnINlTqRV6mUG00xSqpu8ipPKl/7qPVTT8eW88pcQGk9SD0C/S82nKufcfYhnWBNr1a9wb0yAGRdaK1x7fQnHxoY/1HMgMLGgPiDNFQprIxQBKFbBeiE0PyKidU+pMEZWbJc9xjW3XitcsiP72RrEiAT0o/Fm5Vdasb9sOVHRtvS4swFI7YLmGS5MPYDRv8IQ3CdHLQkZg3CGsove8H4KpHvNR9J6cjGcR1t2Z4B5Zq/fJexmaxkn8y49pP5SBviPUnPrRqL5WsFFeeLVDQ1Mfad7YaS2nPiCYQt4RmGqRBdFBDPkGENWc1Ft/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7PrUtGT5kWm6Ttl4rXwwTKTgNsD7UuVglHbsNJMed4=;
 b=dvOGPgs1bng8j2N4+47Fmnn8IGsmZJlChIJ0I7QwCBW937BcCzgOx2jE2MqeuQohTRjXXupjt3mqE2XI3iAvVxGIrAKjW9kOby1Ouhm00NpKsVkv/MJ/aMvcBDsGB30gJiGn+jdFa+xFNL1g37CUwD3csjZ9ZPME8+XWSrX8gtMjizoQEb1tjYi2YoRvyL+XTdI14SBLAySVCg7E0Cq6j+mj2PwsLep1r4lCKMe9vgwRPFP3kAKIzFv28J9y6m84YLxmHiAGBpri4I9HRcS2JJC2y7kYzDlnKJdrIveWIt+IvypkjUAE5boiGZAQA7rH9e0ms2oULqLufTj9+nPgZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 15:23:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 15:23:26 +0000
Date: Tue, 21 May 2024 12:23:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
Message-ID: <20240521152325.GG20229@nvidia.com>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
X-ClientProxiedBy: YT4PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0b30c9-ba38-4807-05e2-08dc79a9f608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQkfg27R8/G5j06E1980fI5WJuEAC3U7GciwirZisSteTEIVE0FR213dA3oc?=
 =?us-ascii?Q?8l9Wu1EswoHqMZFP1YWsGjQ3UncCu27rsrgYpxdZCOc0jboAM2D1g/8IIwI/?=
 =?us-ascii?Q?IA2yBlqNRTtPnZBCW/x2rW3tCK3wSsRvyab6gFtaeVjR+zgw2PwBcMpU6f/q?=
 =?us-ascii?Q?JO9RIZdMe53zEWxbJ3EbhTv1AdMa/vhQe0CvD92lhFyNxEkb9IFEH2//8qDy?=
 =?us-ascii?Q?VNSn8QxPvlPxzTsT7TQU6lLjpCpzLc1N0KZ1VGmN7P2445ic54j7AN4a7sLt?=
 =?us-ascii?Q?bZN7W1HHrLOXm77DF4tiDww5Nic/Udt6uhqzzDSsVJKgJee28Bya1kDZhcDI?=
 =?us-ascii?Q?G42b0ykJAtdN5tFLN6mzDkkcoKsetkrOnTyfCiq/zitjNDjPZ3xadqshNNvU?=
 =?us-ascii?Q?yjuliiAazdXmQFFHB88jmd9XFulkzZ5DxsKTHUA49Cm8yBQtdjcFWLM3H6hB?=
 =?us-ascii?Q?DxB/Ij70zCWL+4gPfQlNuer65Wt68UPHLl0Hon6EKtHF8xUIeSKwGgV1F/6X?=
 =?us-ascii?Q?RyTwYBbAg/Osm5p5TNtnIrXOuGOW5ZlJz1VZqSoMFr0UnPcf9hmx3WzArNTa?=
 =?us-ascii?Q?Zkiz9gvSa5jLTRcg5s2jTRVLPxXWJFS6DFZnO1l7lZvegd9z2TyaZkYujjP3?=
 =?us-ascii?Q?xartmQDP8YzTOxkgPz4MgKXDnwMCjUS2RqGlOPOfUxgECuERmKO9Fql5EQ+z?=
 =?us-ascii?Q?mhMU7xmX8SfuLBpOKZcdUAs61aD9nuXRF/2sc8J+PO9CyXkx6eH+2Eg8mMPu?=
 =?us-ascii?Q?kcVkjpu0S0zkVaIoT91IZTALWQqjdSk2K9mi1oMV4LIw09nmTSO8HOZVYHOK?=
 =?us-ascii?Q?fsGYRe4eVR+D5hZUOKVSG3QbJZpBmhGXmrR6VUstAGIPTaGltBlyFGVLcStY?=
 =?us-ascii?Q?Phnt/Vf/iZsNVoDCP6dNtnqtJQzOB0GupxYboTkrWfPS9xQu/5ukF7yeuDOg?=
 =?us-ascii?Q?x4mZJN7S6pSNuV3ShV0Hx6wIFBQEoLejnktR+Ux9S4K3kJyEvrAFeJZnXGfC?=
 =?us-ascii?Q?n7LBEp4Zex98UO93jJsd2iXGX0X4Rdapc4bqAWwqdGv6YmLX41XfCO8RHAP+?=
 =?us-ascii?Q?vSPeBNr3Tvl8VxfknGDyAkXM5i4XqBl4GFbxC5Su9wVUYcDR6UGubwNAgAHM?=
 =?us-ascii?Q?7bMaGkymdoS1Cq345jRNyHk7HoDyGziwYy/Sgb0BsNo6in6xjqsLXhkQTub0?=
 =?us-ascii?Q?aJ+EMrxOt/bo5qhdfCJisH0dlaeu3+578WBuApvgGDec0tH8lAzvDWXW4EL4?=
 =?us-ascii?Q?YhqH/0SWGPWGkraNFyDd8UwYlcajc8+IYwmNkQQRQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ek9HwB4XnLtEWEt7b+BXRivPsm98a0nyeFajix66bAK0yHY0+S3SWV8OdWDl?=
 =?us-ascii?Q?CWwhR3bOfrCuD3K0iZ+uHBkU5ZAoTHjU+RJEF6B+MbaXTsnUeDqKuk4+Pdvb?=
 =?us-ascii?Q?r1O8NEqE6NPbb2AA0Ay4jhystY7ec88O8aVNrD9mQmqglf+pkmj6mJb0VSJr?=
 =?us-ascii?Q?Gh8NFI+b+z4DQZcQQIe2Xq67BCiKH2yeghgRGC3t3BjMOr9xyA/nvx2VNhL3?=
 =?us-ascii?Q?J6LkVTjQXLVUaafaD5+56S+mjN9lKB7lTg2p4/vhpCnr6lbN2a8gZ1S8UM88?=
 =?us-ascii?Q?nVb1wlfcGEDWuPaBg2iA0rSgeN24KnrDoaM8qCbBiwXGOqtRcUV6WlbM+SAh?=
 =?us-ascii?Q?OllNtsS89Qt6zXXDsYpgKnfX+eeFxHILOHsnxDwVlN4Zj6dJNcRdhvEtxO25?=
 =?us-ascii?Q?oBUbgu9FnZmsps6CEOUBjKSjew1c8Dt7C4ybipNpcDAWH/S/UftPNu31cyEf?=
 =?us-ascii?Q?ueE3vSSrpGNviGBZHBzdwp7+l7jQvtZm8ozcjJrn28U2zN8O+1rvkKqnPcNA?=
 =?us-ascii?Q?V6DZnHJhbOiVpfEL50HiAyUktVmqdbQZY89cIHhWpu5wwap55+RNGnPYyIUX?=
 =?us-ascii?Q?qWbVILl+X9VGIfN+PX9qqycX4dQvoaY04BiaUOdGPpEG0cjz/ShgHgtTJv78?=
 =?us-ascii?Q?BY1E3KIKtPL6VTHOQpSjW5W7eG0Yqo+OvAEHikuR8D4AuaRlf7i+nfbpphyo?=
 =?us-ascii?Q?7CTVzKfWnRbFxT0J2Vbg2q5ZwtNX/r4QcDCwLdeD1q2+Yt220wtaLJeRrR4Y?=
 =?us-ascii?Q?DgLMpq/1mMsJgP4Wva9FYfgeXFOKum2i64cIvNzM0KLasNISsx1II3XTueWT?=
 =?us-ascii?Q?EyyDM46OnWoulN3KprFBHXz5muzzPXeRpJqrJGjkuJt0vSOR6jM9vchVWnNf?=
 =?us-ascii?Q?sKHsgcMT2mVsAd2GsxzoYVymMR+2uaSFmzpv2dA0KiGDEP8VU5qLDESD8UpU?=
 =?us-ascii?Q?XyZdNJVhQHfYm20/qiW0MQjAJY/YSPieuKeQDb4hNYErCvXfQuIHILprmWF8?=
 =?us-ascii?Q?Su2AVCqmmGS2AjJ5BlUhq9bXH8LonGHEuLKu3/NvWG4XcRdAWjn8DypQk+iH?=
 =?us-ascii?Q?7InQhk95UktFiYaW/40ELwe0oOhW/HpJ43Q4g5eHQcaHa5SSH6DHqAg94F6I?=
 =?us-ascii?Q?2NbNQCzi27+ZrzVoh/w7FoyNFZ4L00Bej8Ubms9S9bOtQnus8F+iauoElifX?=
 =?us-ascii?Q?H41BsS1wtzHj6fx8TTFw2BD+mZNdl3MmuoxNzQOvDrVUhGh7pn079CkhOyt9?=
 =?us-ascii?Q?wMftuPocem60pFRVSayM35yhbI2j/EaFkANMRCSFB6iUgzxVbBjV6NjbroYK?=
 =?us-ascii?Q?/DPe7J25ZmQk9DOQ4z8XyCjeRZnmF0gMYXISX6GBjEGKv+dYM1yGBBCrVfcN?=
 =?us-ascii?Q?KXgN10vT6rE51I0Wm4QWmbpEtxqCIk753hXBuqtQ3Uua8JZXyY9CTyBSrKZF?=
 =?us-ascii?Q?G/VqWmAolT1luYF+JlfcGydd1Unn8BAKuONC3AKrj4Fz1GLVpePpLp5uBScr?=
 =?us-ascii?Q?BeDt3LuE4RPYUmBx0Gv9OBgfNJBU2QdDd/M9Se2QZV57w2uKGnbkUycqqlUx?=
 =?us-ascii?Q?7uRywxaDP+bz3xDX7prCrhLKvYmuQIH6rUM/SKQM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0b30c9-ba38-4807-05e2-08dc79a9f608
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:23:26.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpVCD8GPzrA7m1MUiU+kEDNlj25k+C5Ah6OGE0WzYK55aEjITdfLT8YHgDxJuy2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

On Tue, May 21, 2024 at 05:12:23PM +0300, Sagi Grimberg wrote:
> > > > > I also see that srp(t) and iser(t) are loaded too.. IIRC these are
> > > > > loaded by their userspace counterparts as well (or at least they
> > > > > should).
> > > > And AFIAK, these don't have a way to autoload at all. autoload
> > > > requires the kernel to call request_module..
> > > nvme/nvmet/isert are requested by the kernel.
> > How? What is the interface to trigger request_module?
> 
> On the host, writing to the nvme-fabrics misc device a comma-separated
> connection string
> contains a transport string, which triggers the corresponding module to be
> requested.

But how did nvme-fabrics even get loaded to write to it's config fs in
the first place?

Jason

