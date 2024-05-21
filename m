Return-Path: <linux-nfs+bounces-3327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFB8CB651
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 01:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186C61C20C3A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 23:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FD8148822;
	Tue, 21 May 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A/DWt0H7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B236134;
	Tue, 21 May 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334154; cv=fail; b=ax4XyBXcJca7yBZMV8nBP4GJMcIjf5OQqJPb9I0aNwf0pXjWNe3h1iChK14pLEakE7ArpXGdm6/9c1IPKyuXeL9WcvVl5tA6O3Ef/dlH9hMUpoAMx5LIZmd87DclA2O4jBFlGDBA2Xj+OTUjOjlMMDGGTG1rqVW0ne3eYBzgRj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334154; c=relaxed/simple;
	bh=s94r+PaiwdQyyNE59tKpe169KFptDkR2j1AXb5FSC+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5m1DbGYnGChb3p3aZWKPGz32ZEABn7oNqB2/sXdjk9aJyHvH5Am6jIr9fZZCcENZi5vKl0GJFGe7UJEsPML8LYdsJyLzvl6TFHEY5jdF/cJ4osm09wDKXyOXZppRApWuU691A7X1cbcugDDzxwn0iQFLSs1oXrsyNlulHtpPq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A/DWt0H7; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJyWAP0CbPfb4NbMlCoEh8IVUwN6ICn1nl5SdOcA7qgTm3tx47iLCOwLO2WdWbywWj3Tj9snHukF7sCvtui/+BCYPeN+MFzU9L9IxHZLGhA8DrZFhSCXusHAIPcRRYdRxLbQKF+eMRcg7+moXYaHHgM9hZjeTnJ/IkhaULHdlL7tGbaqPMtAlIInEyqKdQbgMF0L6mUnX2/PRZQKf8SVaQEMYxA3d38oIvNq7m3CAdtGY3VyhciGzzRMBG2zvRfRga/9EjGio/4E3wxT7kfkRWeHvVJK1NJoGNsQjANUohttl+A8bt5/HlpH/UA+mr+dkuSvmEFP3C+bwqm2HH2eKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s94r+PaiwdQyyNE59tKpe169KFptDkR2j1AXb5FSC+w=;
 b=I7KStIrcug1YQtX/Okbf/GxqNE59bsd0nkJo+ZlSDI+cmq5tNTBiNr9IfSfAgGw/2CEN03D8lBK9IjxAJrZ8+HE+7O8nXWZFMCA7yP7DUGVPCJOxQmXxcTieVJtuR8ibIePNhcFagIwhlsZg63E++9Fsv/HG6Fv3hsrsctW0EYKCljvZai3uMuAPnrvLsDnxBiCPJc1rM7cy1XQOv6vZlTKYpg3vZkLWKhSgXjPRN3r9xxK5Bem6KYchLrPBUXtO5Vh+VHxFFBKDTNmSOgPnKYiEJCFAhLhk73fMUTjX0iquV3l/xMw0RwKIuGILRduxfJxYdYGdVnLLrSfR0jcz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s94r+PaiwdQyyNE59tKpe169KFptDkR2j1AXb5FSC+w=;
 b=A/DWt0H7w/b71g0In/UGoHBfB+x1hbqqVxQTzntzX4seZhaMbjhWEys3fpqocTRLYDL3mfGyiwTM46uG10WZirfY99C9CwlFsvACfNtCYZcRG04MJBUdsR/LZrxRmVkTFV0BpwN/Mm0Ei5BB4RlNi7hbDJkIMizgB7AJGjPZQcxvNpNVRmNt/cQyhgE7EGafQuf2Pe+DM4TstmTbXN0lPcy6OCf53TBbwDLFykHrW8j9Lnf5XnCRPWCQ+X/uolBR97hz0+NnWc0blyInG9m24kIAnO0LMFACeU4EWK+qr37lFAljIHCZQlLVzhr5jUaPcYV9Ll+cgBLJ4je8xDG4fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 23:29:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 23:29:07 +0000
Date: Tue, 21 May 2024 20:29:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
Message-ID: <20240521232905.GQ20229@nvidia.com>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
 <20240521152325.GG20229@nvidia.com>
 <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
 <20240521163713.GL20229@nvidia.com>
 <0f9ddfe5-67ff-470b-8901-d513dceb757e@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f9ddfe5-67ff-470b-8901-d513dceb757e@grimberg.me>
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: ed307bb9-d1dd-4c39-fe0a-08dc79edcf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydP8CSRiOETNae3dai5qrXkcaLVR5NILGWc1NqIXEYfak6X/+otQDBB+XyQu?=
 =?us-ascii?Q?3/ixpM8CGVrcGXEKuxfZ7iXtqIN5NixytTDW6JscLS6ce/wnskv4jQGj/EVs?=
 =?us-ascii?Q?U+zrO4P76hf4VNi83gLFB3eVaTq2tRj4pSbXBBVGu+5dASKMsW6ZbzwGcBrb?=
 =?us-ascii?Q?+knrSMpeVCXEpAH53xmxsMtiYa57Pp1Bg7bmeFs8t+dMoAXs5qSs3/ifmDnS?=
 =?us-ascii?Q?SjU4Fc3OO28JboQr1vqr+b09/wj6pt28AQRZt7Gqbo1eIWg3LqP7Cx+b84vz?=
 =?us-ascii?Q?MXePZG2wiWs+pHjWnSzsa2EjHjJk8TINPa1BdNeVJfq1IKt4xrDj2UxtP9U1?=
 =?us-ascii?Q?rLkMUOfKuJLp561dv8cMHydyW9P3tpcX0LeaHghApMJbbPeFTTKfz1c/DhYs?=
 =?us-ascii?Q?NHKjVEIGcDwpMEPlLsxJif1QQ7hd+XJ4tSoIRReWqBPbjbKNJd1nt86vxv+w?=
 =?us-ascii?Q?t+FPqXGQrnU27Wt7qQh9OJmhCZGPW5MgKvuiV5NEng4h3cZI2umPQBkoTw2J?=
 =?us-ascii?Q?2joULA8n4cXly9Lrih3LlVH40PKdq0RfTax+9wu9euC+1kStKeSHDbk/V+uY?=
 =?us-ascii?Q?WFi3eLeOhwndUQdm0Npey5PE1yP9rZ3jz6mwfiB2RclgnV94Oogrv8LXVsB7?=
 =?us-ascii?Q?J92wqQl5fawfp+H0N/M/MFziaDIL2HrD2xlYyaBjsruixrhSB6GKXajHzj7B?=
 =?us-ascii?Q?lXypdm3GGSyxBfi9e3noXRGya5YoLLlrUjZIg0ze2ALccOZaqtT/KW1QJ1oO?=
 =?us-ascii?Q?HtnQYxHeHHrc3UWtSGrf3ej/CA4fmeUJfHOb8WQ9TFqLGKVMbVjnzfD1aA1K?=
 =?us-ascii?Q?ZxMwj5AdB0/kYVevTZniOvL0/61esKxeXmnuTI+nzs4a1/Oczd7cRWi9p/Rg?=
 =?us-ascii?Q?H5JFw4GTzRwAcSdrgXrN5iMEcjyenYcX/YHa1KC+XiLbQKdOTyefynjs7FkL?=
 =?us-ascii?Q?YQQqIfQPrPAL895yZob68BGEeebWZQ9bQW6GlfFt7EN9Ft8VQNia8CqaIXMb?=
 =?us-ascii?Q?GsqOkNc4QTiCWGFQJCni0aRkdu3sD047xt0vGSR9KtvRR/KMhLIkctgJSGJm?=
 =?us-ascii?Q?RPLP2pOj/SQRaYs5c6VF9MmW2S7a+GCCrjX1Y6IysrMoA38Hwrdpc5YBkCrM?=
 =?us-ascii?Q?Et1T/CpXkGZszQ4mGblXqwb4wTIMisup+qlgCEohu5iCBkX+nqf5gE0QcjBP?=
 =?us-ascii?Q?opsrrSra0iKokFQmRfA4N4MNOj4wHUqd4dhfJRiE/j4PkQ0CMCZBiHYNevFH?=
 =?us-ascii?Q?39nwWP6rYATwqZl98vtbPO1neq5YgnjCqhsOuotxWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Szf82EuDgh1HAKKVfZgZlzsW5K/M/Prl/6wBIHYQuw15oWP2X1WbqcEeHiVS?=
 =?us-ascii?Q?VQZYHxxhGZKhfQCMv35YAW7JRcMoJaiKIAUrBi8N8JQLwLSzDS1KgqkZw65M?=
 =?us-ascii?Q?uKLOLgb+vpWZ9eSi/KZRh6bpIZ121W2+m4lg6An640dNZsZZP/Dz8bq54J3k?=
 =?us-ascii?Q?UY+ZJQjF9/c/OediRBjancpXSjerhwVETY1EYQh+4BZJ7O3MbZ8kL37MLj1A?=
 =?us-ascii?Q?3pfAAoy70DeFNqPm6Q7rFUPItHyGqvrzMmC72Vhki6Rl+9xPrHL4Csk87+RP?=
 =?us-ascii?Q?Fr7yWx/t29kf5h3J11aJT2FcDiA2/+0ZOKcf188FhoKsb0RwUvP6gVvUshYG?=
 =?us-ascii?Q?3EZvjQBRKZOKY6GFu+BH78++vGr+k0Q6usUZKp4Hkf0Sr26Ipalb8SxfIgEJ?=
 =?us-ascii?Q?V6Y5SBiXtEremfPmJo7LvBWvOE4WVdFQhwSPImwVZMYjUpBv+QQg/M4vQ+JI?=
 =?us-ascii?Q?RyEgxDram1VUqBuNVFqa/VqWFM2GYQhwf99Xb76d76CmV5Bf63KU49AjXeZ0?=
 =?us-ascii?Q?zBkaFvb/rMWxfpKL5LArnBACIixN5eZZNH8yrwz12fpPAnnRcPokf4M1Cuck?=
 =?us-ascii?Q?uMrL8zfq4XylNgWsPMPJIiQvKfv9t9xrCsdkcLdwSBaQJ5+joINCFviZEzL9?=
 =?us-ascii?Q?YVGBR3w1P9XKMZqm/pYr4jdbyf/bfNWTb0J03gX0EWR3GS5HvV0d0p11SQ2L?=
 =?us-ascii?Q?u1Ywymv/ccaVXco4fhqaeuvm0+6JzsEyxWeiHlaP30z0GMPB9POWrZLEnKyq?=
 =?us-ascii?Q?zl9LKQtmDP87P8JJjPp+zXh0oVDRRJw6ln1Lqx25Mr/dl2uGj+2gXOqWsWzm?=
 =?us-ascii?Q?p25A80Wtj2VZLRCsTgxAPXRnzzZYjaFeVdZmR/eRGy6CjM52AcvvaqxTgaaS?=
 =?us-ascii?Q?62L2E+ROjXLkYmymPOZT/D2mP5bgeEI+unjTKPcAmr5t8OpUbmdCzPjX0BG7?=
 =?us-ascii?Q?TRkh5Z4CJZ13TE/DUk0VwPnBV3ldzQ6EXBHoXLMt/vfsERV4mX2Hsxk3tqks?=
 =?us-ascii?Q?am+WvzoSzMRtwLEkE25iDaBETGsJX+ppDIeCJCQCeI9W02fNUlfQ5Pi3n+D/?=
 =?us-ascii?Q?vrgRaPlJDEOdpz+FQyl5XrLoZ4oOwg8wIcZsc3mDA5klvC3nACAv7pUoxZrJ?=
 =?us-ascii?Q?kJEObXRQCy4rnxP/ImSRoOOMZ73Z0Zfv47Is61f2MP5dOgQMS+FyNNEYOSbz?=
 =?us-ascii?Q?hgP4Fi44xsIQOv3XQwdXAxkLiOvZeEO0+RICzCj3ijKKy1FhSShSyFj0LM13?=
 =?us-ascii?Q?pst8wn3fQiBY1LM0u22/Y/nhigqXaKigQyr3tAOn7hR7GlV0vhdbA45tqPTx?=
 =?us-ascii?Q?zK4Ki/sWaHUHBwZSG7U+Gt60UwrXqVIQ18S+UJh9b+81WQv8akx15f4NnaMd?=
 =?us-ascii?Q?cVMnMAW48DS3F2o99Pen0H22ypYR4B+SVoT0VYmv2rrJmc3KWOFwiGob+Csc?=
 =?us-ascii?Q?qUqcx7PwtEXHdrsF9Mk346tRiKW8SHrFoout5WPT3mztJANYtB17L85w9hkl?=
 =?us-ascii?Q?hiGUb/EoB4ZVV6TRSbRQEb4GwTFn44D3G6ux/EbbZFAuc3aTr8ZQ25YMMWvy?=
 =?us-ascii?Q?Bxx+u3CTZvtOE4cpr4Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed307bb9-d1dd-4c39-fe0a-08dc79edcf7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 23:29:07.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7sxRtew7tGR8OCQ5JO7VBwqdgSFr3hrSYv4YRBeHP5406Q4UzYVJXyYUa+4d7QE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156

On Tue, May 21, 2024 at 11:30:00PM +0300, Sagi Grimberg wrote:

> I just don't see why the presence of an rdma device dictates that
> all the ulps autoload. Does rxe/siw count as rdma HW?

It doesn't do all of them, just the ones the distro decides it wants
to do, usually for boot volumes. It is a weird historical thing :|

Jason

