Return-Path: <linux-nfs+bounces-3322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A88CB24F
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980382830FB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28960282EE;
	Tue, 21 May 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uX6r3hHA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6B1CA80;
	Tue, 21 May 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309443; cv=fail; b=BUv/XB/agQMsF7xjAHE/0beGt8Os6AUDtHFx8svn0UQLgM4kS1HcT9DFpsltDMgpy4rInWt8dRqRbBQgJHaxQzarhugbdQJwsyCS5oAo63G4B/dGwZQXYCxAU7sOAjJsR3aymEqd08IbH2UFT1RPe0RzSc0fZhPbNepie2ZsbgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309443; c=relaxed/simple;
	bh=RdVxb/9tlzAkQ2Rn9IscqcS7iRdI0Iy4KsNzNIit1Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQI8zBUxdJcDi9GmvLpf5mLeVUT2resWE01y85GwInScoV34dyaeRWvy5axytbc12IMEVspfRzMX5rNqqa89QwtX+NjWbP4cIstjP+g8OCaitnMbTcashNZ7toxbQLNC/1EJ6NOaihDoHW5HV6pb270JE0wfltZHhWgvO+403o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uX6r3hHA; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyGFNTMxyRQA4mKAUtu/eWaZF5La4liJy7ypm5GgGFNhOjbRkP3cJ7eL1tOh+KKZo7UiOWvZjgonjwQPovOA7rVGMzpyguh4fAcZhtsJBPzHQ2zBq+vJ/VBEpHOTLX+uX/CRxRdtQXbpHrZx/yYPqhQ8fLosEKSngDaIORZ05TUtEPWF9m3Q46pw2vrFvyOb02gXl/KyoH01frHkxNJzh+2jGhVe+4OdXHiVgpXTVSo0A/TYaPGBEty4NxW8wnsZridS3mK3aXYZRNY3uZDKvwLKpWON2Wo1Epkqo0YAoh4FhVqGyQ2qe7BkcZFgXnKtUh/ICt8OeaH7fMoEERaWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+DcbfYbAp6T6Xz31521lKfmHWJgj02X6idx0kuG4bQ=;
 b=fjv1HajzIBkjoRfRhgPNkxaD2+Y2d50J1rtiM20ZXjcxEGlXGP4MJLfKCUzpQ6tU4cGxU37sxAt/i5F8C7q0NipbPyJmIb5mUMAywR/U0fqQRnktjOkBcA8NhgrnjYLebPjaR3wjPmnHLgz3zX55xSDbokew6evWs2mlzD/14xfMYHTDsi7BPRCv6sUWj9ujGgFHzUggweuox7aFQf4XvynddRgpKplc+UUG3Tc0PKvrtE0SgPhfKVThGqU6u7WXjVHZKR5K+LdfHh/2K3iq8gIPPDZfdBBZIIYmToOw76PshTTXM0qrr1LJhKxbB3F5Qu9v9pGsJhUwFVcwJW64VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+DcbfYbAp6T6Xz31521lKfmHWJgj02X6idx0kuG4bQ=;
 b=uX6r3hHAbuS3ojGx15dLSL6d4hTEmzuhs/81BQCYQug8+Zme3ReRkmnNH8MqffNiGD4D6ZeZKNSgqeL9N6fTSRl/ktXubeSJDAxJZH33+CUAbB/pQuavuTItF6t4NezQVvujHskVHoNMQGjHBs57aiqJyx7EEau3iVNegt1HeWddHKzevaz6VJUoJFgJzheZhtJQHIwe7MFsvEb6QwfNSbWdasTJjXjVqW+RUfyRnpA7r9xByKv5H5u0QsOqyo30h9ZBZ8M83/d7QBPYpzOMN975HcUb2AJR+H2bd9JP4WY6AzVD70IwjCzHCzBI/fKzwfmz8b2i9pPOUO2Ngb72NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 16:37:15 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:37:15 +0000
Date: Tue, 21 May 2024 13:37:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
Message-ID: <20240521163713.GL20229@nvidia.com>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
 <20240521152325.GG20229@nvidia.com>
 <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
X-ClientProxiedBy: YT4PR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: b274f356-c61c-45b4-48eb-08dc79b445ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VtqmYKKVVmC06aC5sDpOyB/BSJVdQvehv5db8k9FFukHRb7kcQ0zGMoQXJ1n?=
 =?us-ascii?Q?slDSr7YTtou9Q6inbUr3ED8yfy+sfJkQkRPJEOeVoGoFjUI4I3PIuzO9OIQL?=
 =?us-ascii?Q?lywo/QbhV+6TUfsOJM4JpfDLot6USHZYfG0TO1K4Bs8r39kJyRnYBmBuXZnq?=
 =?us-ascii?Q?Vi51pH8q7z22jFtZox+voH3wnBdsEjG3EI7h2ZxAbbVi/K7zwG9G3arpTM20?=
 =?us-ascii?Q?cdArDppx4egIdCZXOAyzDngBtSJZcXey8yM9u8fg08ban+gssPllt0hE8AbA?=
 =?us-ascii?Q?Q1GBs5OmyIitETh/CRF2ATq6tlPH1/inpLvnRVv51xPHvH6vso1zvQ9tpSe/?=
 =?us-ascii?Q?kQTpUKNaQ6Vxb7+puOsE2Ce6tfMULRJRa+3+HY/xg3nK7i9rVIs63ju8v2/N?=
 =?us-ascii?Q?eoLfx0nSULTlKZWPpnwTAJ8LZhui3JoS1ghs18DjQasbbZRgdD3phwNXp/bt?=
 =?us-ascii?Q?3MeIJ2WCkaf0isxjGPGs0Rd7ODVYq8OT11BuxkJ4wi255Kj8QKZ4Kgkudza6?=
 =?us-ascii?Q?h9mGPn3TyvgL5ba1Hqd1g7J+AqSK3lXyX60Y58cGXGtZC0sxizAShaM5kWzE?=
 =?us-ascii?Q?TlT0C4zqvapuKI0600lfBNF1/MaxmAZ3CTWQoPFrbAXdadRgbeCchiaifkhH?=
 =?us-ascii?Q?t/9bb1Gb+Dw8LLXHjf8AeeXzca+3USHqyyjphAFKrYVsTI6nY/nxGUhAozh4?=
 =?us-ascii?Q?zUexYQXjaoztd9FlazS6X3u15DYJukUD2GFbZtqAzl/8cFucufSIokAYevzf?=
 =?us-ascii?Q?jYsmTK3Oub/w6eedEKsMb+Esacqb29u1JByhcC8nCoISYOCfClwq157jRWmv?=
 =?us-ascii?Q?/0cb9Ho7cf5Vvoi44Dj+yzK59efvbcJTIGsdU/87D9kjep8QLKWjiMWW8Y5Q?=
 =?us-ascii?Q?3CCXJRQlQ4ijOtfIhd5O2jQd92DrzObvt5ABlPNTK3JR6X2t6lOAUQSXJjPi?=
 =?us-ascii?Q?GHkWb7Itj1TVojE+dc0j87iBPmqwS5qUHZR8b77JjvIA7HBdOOt7H7ESK/v0?=
 =?us-ascii?Q?1XWeGgABW4+NyTdLbq5yBvly5oLGUr1ou8zUSfoZpaHHczito+Lg62lFboJ0?=
 =?us-ascii?Q?a0+mgTI+2qBddfvULJmKiGvP0zcc4mEwyKcwHpWz/UcHCVsjjziM2EWeuPfQ?=
 =?us-ascii?Q?cnnz6rViEIiofJAMoFlxSI4QkX/WH3pWs357rmAPnRtl9lo8xqntrPuUAObn?=
 =?us-ascii?Q?Zp49KDCxlEh3PRxfKipo70nf8hunUF0SE19+pzbuXISNX3o9Y4UoNDlBzAD0?=
 =?us-ascii?Q?pxXmW+nCpZLzaXSeeO7dTpvHIiNqmNOUjgMo2xussg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJGMmpcMw6ASEAr0QnIS0kcaozn3EC+Pctpr2j77EU+wJaGneAm7c3bCq6h8?=
 =?us-ascii?Q?a58c6x+Ot8iRMkKcjzScXNGFono8UReerDY4SmQ9eqoe4MbzFGoU5Y03jV6h?=
 =?us-ascii?Q?nsbquEqwGOPwfXvpbjuwm8Yi8Km9fYnbM6tPklYRktqTVmoyZwflu5zXnqHH?=
 =?us-ascii?Q?C3gMghAhZRs/LIVAgusc6vB01XBphh2ndRen3AWslIU/hJ8jtvxzwuXBI4iR?=
 =?us-ascii?Q?zdyUI9t0R27SQnyHRxZYoP8oM0MC68z0zKmSXCOA2DRabvH+gB1PSvpJE1E1?=
 =?us-ascii?Q?KGRJZWCk2/QaU4HUYviOnemEOKpDXVTeOT0kQHijjvLla6SFlixcO+sx7Zxg?=
 =?us-ascii?Q?pLc1V8uUqrU7Uq7DSsRkd6iqZ3+3SXSaxjAsF3dynpezmfXst2Cixf9lD0mI?=
 =?us-ascii?Q?0h+H8JvreGIVLk8i5KOxXMDkxHgoeS8s3C8oM5UCyXGD5Ih0okpmacpL7Ayb?=
 =?us-ascii?Q?KqJU/dxIX6cTgrgofuiSuepNCzVEWh62hYcp3UiRD0WpK7z3E9Ey3YddsMai?=
 =?us-ascii?Q?MScY65GZfhiYOovVZC1wLi77G8ryxtI39pC04rCijZx15S6yvoo/yTzSV45y?=
 =?us-ascii?Q?1bMqN+XEPEghERGlkskb9By9a5pNGopQ6X0MrPnkgZ8obJPBMLvz8nIaBXnX?=
 =?us-ascii?Q?bVRcq/W8icSxu58Zysf9XD2kp5Vl71s53IZ38z86lkGZTgxU7Zs+4WiwMvRd?=
 =?us-ascii?Q?s/r1pYcrFlkrs6nkLSi3n5XxSluC/SWFo8Ow9OlmKRISpolWZ7XrVIbqcuNh?=
 =?us-ascii?Q?UBU5RjGTKAGVYckLmX90aBYZLmG+ATcijTxBA4Ys0TQaxwJQNsP71+meJU1v?=
 =?us-ascii?Q?X3XPLJNMXH6iPYSyGu2kn8COIatUM9LeGWjQE+g4apMl5EdP7KHDpeQOqkG6?=
 =?us-ascii?Q?6YW481M8jI0xLdgpvzhJMn1Ah1/kCZLm4Ou3b8kvodYVKkrmOR43VSshboLT?=
 =?us-ascii?Q?idKUSjBKvhOErN/Baw+VNDwaAndqfG3eGgtjNyWre9QXe1yb5htHCUw/by/B?=
 =?us-ascii?Q?QyWR9wmP6zYor3KXo/U5bwPotf6PsPf5sOW9PqK0pbPzmRhBRkeP4r1tIOub?=
 =?us-ascii?Q?F0jANKR8RU37BlJD5GXWuaA5Sk6HI2lpYbqYCnqvPsHSt314f+4PEP1QHIAI?=
 =?us-ascii?Q?AinSYue2X/ImeM0PLpZh6iuk83NccmHptXeimFyZbNddXIF4HyOYUSZ3ymcx?=
 =?us-ascii?Q?ZgcIsBqsB9GXJP88YHLsY8ewcvQJNpVtBv9em7OShmh0CmqWeKfTVMV2EdYa?=
 =?us-ascii?Q?OHSktfhx6P4wmb9UJ5b6qtNTgbon27vvluTinhB6gB4eeb0kFOyvSvswpsQv?=
 =?us-ascii?Q?mj1NwO6FNmfmTAZ9qB7gkeBCs/3aXBxvBdDAF1tpjQbbb3qnKov8bLRphRke?=
 =?us-ascii?Q?Zs1MqUjeN2vi5/HkiPr55nandUrl2qYSWTgbbYnNiLNVV86Nu3rhVcS8M/JE?=
 =?us-ascii?Q?tzhbJSneWo16s1FENUlDkYyek1YA32F76cltDKPAFJzKGjIRvW5xjqucr2W3?=
 =?us-ascii?Q?8MtGx7+WAqFh3ajDQtiKnqUj3PLCIc/lLYf8AlMA0pSJh4nBCYB+RkXsFRu+?=
 =?us-ascii?Q?Cn8hD/3Q0cyBief3jgtY0CEU22DamWmGG4DTJtqr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b274f356-c61c-45b4-48eb-08dc79b445ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:37:15.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tZKiETloT+koYAAgWpFsHBLMw/N7ajH3q2kioBwazHnU63tZyYEFmDRmu5p14s0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786

On Tue, May 21, 2024 at 07:10:53PM +0300, Sagi Grimberg wrote:
> 
> 
> On 21/05/2024 18:23, Jason Gunthorpe wrote:
> > On Tue, May 21, 2024 at 05:12:23PM +0300, Sagi Grimberg wrote:
> > > > > > > I also see that srp(t) and iser(t) are loaded too.. IIRC these are
> > > > > > > loaded by their userspace counterparts as well (or at least they
> > > > > > > should).
> > > > > > And AFIAK, these don't have a way to autoload at all. autoload
> > > > > > requires the kernel to call request_module..
> > > > > nvme/nvmet/isert are requested by the kernel.
> > > > How? What is the interface to trigger request_module?
> > > On the host, writing to the nvme-fabrics misc device a comma-separated
> > > connection string
> > > contains a transport string, which triggers the corresponding module to be
> > > requested.
> > But how did nvme-fabrics even get loaded to write to it's config fs in
> > the first place?
> 
> Something (/etc/modules-load?) loaded it intentionally.
> That something knows about a concrete intention to use nvme though...

This mechanism we are talking about is an add-on to /etc/modules-load
that only executes if rdma HW is present.

This is why it is a good place to load nvme-fabrics stuff, if you
don't have rdma HW then you know you don't need it.

Autoloading is the version where you do 'mount -tnfs -o=rdma' and the
kernel automatically request_module's nfs and then nfs-rdma based only
on the command line options.

I'm not sure this is even possible with configfs as the directories
you need to write into don't even exist until the module(s) are
loaded, right?

Jason 

