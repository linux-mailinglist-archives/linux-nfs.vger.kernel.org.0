Return-Path: <linux-nfs+bounces-16465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89337C65D83
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39120356707
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5034167B;
	Mon, 17 Nov 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b="Jnr3Y6qb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020128.outbound.protection.outlook.com [52.101.46.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C033C529;
	Mon, 17 Nov 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405835; cv=fail; b=JAeZ8/r3m3wXxN0uqCgjlrVViapEGGhxFauCyya3bJ/PunfIY2qQiX7IktZb7qUuUQZrv+uCC+NBsyqUgpfNm9OFnjyFFfOj+Sx44mStM7N8vcHX8k3twRQgSL3YT839mYFhYkCLI5sfmIbp0ODwyCZXy7wDWMaz5O+hgDK2+cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405835; c=relaxed/simple;
	bh=3siQkUBV3JvlgdAVy++bKwHLiRZ4+cGgQecUFTAUcCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S9EvXDqEanBxFJ39Ej3n1HDyQYspwwui+uzyvL0lSrJuhaGS2a1jzx+yqoMpGQPdG6rbPdKlrcio4sm7dvw+0WmPkrLCZKC5+21lZsb4c/STaTyn5YMcLKSmRntAqyzYipG80OVNAaLx0tb0+syjFVTQRp2zXLhAX7634PG1tzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gatech.edu; spf=pass smtp.mailfrom=gatech.edu; dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b=Jnr3Y6qb; arc=fail smtp.client-ip=52.101.46.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gatech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gatech.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjZV0jjMPeW73FwrNiXkPXi25DdYjBbuGPcOefcw0b/28YcLGVT5k3taB86lNXPYqzhm4QQ5gvw8AOtxhbqxAJjq1h3b+JMkdjpmtYWVPp2oOAF1v4nh2l0HE5IGTkP32MEnKlWZu8EA16CHKY5+ONU2LRkH8EfQB4okY472suWmFAhX0XkKlC+eUlk6+4cs/BnuXOd+ezfPKoaeR7dQeCLdM5VXQ87ag03or4FZu83nudnL4Om7PPZIZPhv7UaENglfXpD7uZSBh5m2A2/WX/AaOjY6/mvzSpjz6X+AS967hqJq5bwNWkauceJSunXE+x9D/zxMrFULCi2SAdT/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCb8qxCNyRQ9JMFOy/pE5uhaaHd8Aud0DpAScqAF7Wo=;
 b=ALifrl89CdCwlk5W58qmLMBVT+7M/iRvwdi2qQ8glWTeAK1urtfev1cd4KjwIZPSXGHDMeP1Bma76cZl4r9B46Q/fzxwIF9kum0Bq9N8iZgAlJKI6ZIG7Z325REiccnSfENy6i9HftTu7yOKsMXydGv1S94R/H2kGppBGjdf+A1Qk6apTrIFj96+c5Ykum1z0dinItWC+KVzs0b6mhVphgDp4CN5uyvIVrpSB5+QkLwu4EeBeafXY2Uvd7+tIyoYpXGlfYzNpr/9kicopIdC5MWzcPfsmoyjDrvG4+M2a4QeJtm++t2cr3ed85XfbDbxOpmeG0oxOsu1l8m4QRQUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCb8qxCNyRQ9JMFOy/pE5uhaaHd8Aud0DpAScqAF7Wo=;
 b=Jnr3Y6qbkPBVOQ6GxmNJLzpcV1VFekfK7uxLl1fyMXnd/s2qx+TcemGmxHDlnkNPnP67wj2SGGFG3hufi9EKkXEWlQwpOSKS2FHIfxf+KTd1051NvL8/evwPMYpN6XQIe8ttwpx7EUyhxg18FGGxsB95KHDeIi0WUfoTDI5qYWCU+1uHeWuPlQxWbP2CYyjEZ25n6lBNX8PVosWyDoVstbhUX0sUZ1QkpQmykwlTLlrYUw9X1vl2XXUahC/3Mo7H+xhi29Ho6oYskymqGKxrmBNMbd1DvCRkcslmkjJ9D7FeftjdmMUsamYWaILedmt26g435qhDR+ULmR2ebHybyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
Received: from LV8PR07MB9999.namprd07.prod.outlook.com (2603:10b6:408:1e6::7)
 by MWHPR07MB10833.namprd07.prod.outlook.com (2603:10b6:303:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 18:57:11 +0000
Received: from LV8PR07MB9999.namprd07.prod.outlook.com
 ([fe80::75de:dea2:92ed:dc7b]) by LV8PR07MB9999.namprd07.prod.outlook.com
 ([fe80::75de:dea2:92ed:dc7b%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:57:11 +0000
Date: Mon, 17 Nov 2025 13:57:03 -0500
From: Aiden Lambert <alambert48@gatech.edu>
To: Trond Myklebust <trondmy@kernel.org>
Cc: anna@kernel.org, chuck.lever@oracle.org, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: ensure nfs_safe_remove() atomic nlink drop
Message-ID: <q43d4llud37qniopiaejx5p6hyjhaubvwchnekhekzfbgtbybg@zhunmybqs3dr>
References: <qqu6ndrq6ytkt7rfe7hw62iu34fkt6eckixjgx7bkhqgvzvcm6@h4tj3bkvvidi>
 <3fa28515be621f91f237d323ff4b97430e73b032.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa28515be621f91f237d323ff4b97430e73b032.camel@kernel.org>
X-ClientProxiedBy: MN2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:208:23b::23) To LV8PR07MB9999.namprd07.prod.outlook.com
 (2603:10b6:408:1e6::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR07MB9999:EE_|MWHPR07MB10833:EE_
X-MS-Office365-Filtering-Correlation-Id: 27184628-cde7-4a88-4a3e-08de260b1d89
X-GT-Tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrYpdifYLOdwdFfopSfJ8eYCvaR1alj3kCTwJ7b0eLF8P1/1Oenao5A3y0Tw?=
 =?us-ascii?Q?naNMIH3D5ZZ4e1UjS81Jn9s7ZElKQJfCtJU88pgLSPUb6KYZCh8jmMkarrSR?=
 =?us-ascii?Q?4h9V2795jyRMByTjTvPAM8gDp6x169qPwTM1liXVgCJEoxJtHli3D6ravCqY?=
 =?us-ascii?Q?ggeoUwCSlphgjsqvGZw+3UNxIzLhLUacXLTB2ZqeWUcoGrA6Z7coDB20iVVb?=
 =?us-ascii?Q?ZzvJN+ljPsDe/5pFVk5VOvpED5mrntx8nWqAWEHQ6+rNEQwFeCTJvMmbwfI3?=
 =?us-ascii?Q?CHRIGgShifu0lzUHgF/5WvsfcEPJEWqXu9r3t1Mtj5mH7zN7IpNh/lENULY4?=
 =?us-ascii?Q?BvxSdC0lDucB/rjI560dmYs6l84TSX22YHg5hgqsrpslBXO1u6UZpComIqH7?=
 =?us-ascii?Q?m286Nr88f7XFQ8oAprkzG8i6TJsniPw0qJOwVGPWTOmSNJR+3Ol+VM8az3E7?=
 =?us-ascii?Q?1LW20yVUmay7DX5oXFJA7eYDYkOGhQRQ7bpRvJHQvUpWALbnGR8mfgPsuJ1o?=
 =?us-ascii?Q?oUo6rpO7c0owrO99lm2mFIy9W7r0K3086dxDSOdoXBQxUvVdPNH23p4IRcrw?=
 =?us-ascii?Q?+Wv7v/sPSMkgWt+igiXzFKvnxWpfWgHIvUfuap4yIOqGLJOwpjdsUlJyMYN0?=
 =?us-ascii?Q?Je5ssPcoqKTBfYOW41eh2TH6PDHL8Hofs8/c4SUTEJfFp4BVYvbK6IA/mG4g?=
 =?us-ascii?Q?E6YXxZhfFxV9lWlKjSsDCjHQZdC1st32++TG1uY5GMz2MgNPVNik5M/241XR?=
 =?us-ascii?Q?/Z9gPSHRXA9vK70PQjdgSyoKuJ5czg/i0F0vtVZARPWTG/sSs3x2DCjGJI7k?=
 =?us-ascii?Q?Zx9hwLYHVngctLbImy4XKdubExfqv5a/Rc1FLDc7uRMYVHqelNYl6DvIVRar?=
 =?us-ascii?Q?LOBsL9cjQU0im59oyCEH127mx70w1vWTesvI/YJFMmjUgCynhwNQpYUOvxfT?=
 =?us-ascii?Q?p2JvPNOgMg3zeIulWpEcEUZCxGoi8OgIq19+CD1NLmvLqTvCsCuf2XvCwb7D?=
 =?us-ascii?Q?WsCPk5KbEfbiCn0WbhKBfawJN5onmNaOVy5d7YN5YJBwIdKIgupM/4ABLB5D?=
 =?us-ascii?Q?Wfddw2RZKfF4Wdv26UqaPrt4Pt5+0o3paYURdmuA0zssnpK8aN1cfX84/3b1?=
 =?us-ascii?Q?KdXwhuc03ATYM20DkkI/yK6iKzFn0JD+3W/sIM4J2bfj7DlIh3L8339wHYeu?=
 =?us-ascii?Q?/0ZLhjpE+3sAf94wvdxpf+h/FdIUyvRQ2jKdTFpLtFAqiKRZUHX9FbawTcZq?=
 =?us-ascii?Q?VUHqR71i5tbUUz3W0JusjH6pwewaa3Vo7DPpyzABmYad406EjkaZNSfu9Sh7?=
 =?us-ascii?Q?lk34ZXzKOAtOYapySsWKjcC0CxGxUzA+lWeHuLgqE5appCPIglkYIxpl95bM?=
 =?us-ascii?Q?386grUuQGEfAB0OotqYswF90/Sl/md+5qnoZbfj03dOvkqGBwAI4fsAzDNm2?=
 =?us-ascii?Q?KBNJqmZ7flgiwqyqY0jldLQiXjwqRmPc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR07MB9999.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1FOjcGI6VxNi2kFVGbNgqDLfWyaPW+0Gb5IbPcy3r2HTJQ3lTwPgLmxx+DAZ?=
 =?us-ascii?Q?Sxq8E1CZMihEUspu8ZFxTjBJO4bO4gbnf4gdyYNYAXzjH5dK+Ghof2vnNPiL?=
 =?us-ascii?Q?zY515Rknh1MMd9FV0s7Fd9EKThV5kGOn/auubgMg+69Ml08uvVV/2ZyhiQom?=
 =?us-ascii?Q?FSsq1rUlnj7gtT5mYblECPHw6vaG70elxEowR8wReIQfCNmJu1gqMRbhdAr8?=
 =?us-ascii?Q?G4BQZtlz+8WT+Q48bDbwUH911cJe3debR7dIrAtyDmtqwq4B/QLI8blZ/823?=
 =?us-ascii?Q?K+WXGMwVLy6xuNcHfUQrjDN+Lm71qieRxjI6vAtCHHN9uPE8bGkFfGipBI+v?=
 =?us-ascii?Q?r8GUMTp9U0fHgY8fW3l3aqg62b21Fu7el6stjUXS6iByv1hJvXr2NjmaPGDz?=
 =?us-ascii?Q?sEodNxLRSWjQBAEuorqqS8v7XkKrgzfJPfDuEYLc9UD9AuHfJTYNoy/G7Jg5?=
 =?us-ascii?Q?x/sKIsk4JsSJ+0enZVf1zGjuoPuB+QWuaoDVPgOdT8aGjuPlsRYPT+DZotbd?=
 =?us-ascii?Q?eu/ppxJaeq0Ej8kpAd2rj9BkyoddObK6nsEa51h5t2dhMTiRJP5VxH4g2vHz?=
 =?us-ascii?Q?/FhZeqRGGdwIFE43nMouFNBvDEp5tvtk4ocdW9gIQnd233nD2YOarQaDjnEj?=
 =?us-ascii?Q?dushWbkI7Jknzh5cmlX80Xfdv7C6cGwkhIWewkGZs44Sh9ocm4DWuIAT2nYb?=
 =?us-ascii?Q?EHKTL4Nee8ToswL6glvSyLH+SHVGRqTobi1ATG4o2f1uk0a3FfUX732VaDqo?=
 =?us-ascii?Q?3cU/w3l+pKAQ0ZkDJ0R0p4kAOy8GF3fjcJwYj+twV8T8JRKM5w7JCVWdX3l6?=
 =?us-ascii?Q?eIch4Xv2XilZNmgHNuRa12DfbeY9fWCOp6NEc4At1qQn8omaQvi350wu34vw?=
 =?us-ascii?Q?1ZmDhQ3LFfYexIpQAZ7WQMheAE61/3GzYf6cPxgPkjnJMtJZtcrOtiPBKb7V?=
 =?us-ascii?Q?S2Hoz54g3o8Bt205VRGBRWPADdtkku/0bCcQnINuQ9Ir1C2RijaQuZBfoWQP?=
 =?us-ascii?Q?/23B5Lwmqm+JSmavgZmLJfVI1Dwv8hMcoWLj9y9ZbQaIfwpcTUZgoIHS1C9Y?=
 =?us-ascii?Q?n+VX8YCuTrXaP5oQ0Ug6TYP1YgOT90lL3Vd63j4z1VP5GJRZC42FC183tZc5?=
 =?us-ascii?Q?t3tykFbQ0u36obMQ0Yqev4cyFIGFhlPGaoDHbPxYQA/t5H0PY/qd5UxnF/L1?=
 =?us-ascii?Q?sadIKJsHnr1zSev6HaHpDKbspjKbxkSlh4Cc13QvjJUjnp/PIlQx7p3xyrjU?=
 =?us-ascii?Q?o7Ri7uaQcGGS3zYjcuYTSSf4KBB7kBlkh1cMV4X+TAd45krznJSYlilWfDa3?=
 =?us-ascii?Q?4OCaLBd4IHKqgSsruqTeeVt9p1h8acX+1yEBY7yXS2A9spOPC3MbDNpeEWg1?=
 =?us-ascii?Q?MKltg0SdZlg/XWYpLUoLnjKtsqZblqpqAQuXaRISf138wPpTJCikvfben4UK?=
 =?us-ascii?Q?W07s9poh2d5a8RaoMalfnAYY3UbLgrbD/9D/WITKUJtyoqXarHI/gd/FB/rt?=
 =?us-ascii?Q?HzNVljTdcTdgLNGo7MDzXuiNSCxmOZNvAOAmF1sS6odQd1E+dePRMbndv51b?=
 =?us-ascii?Q?mPo4LUVoCqILHR7Hy30RdpSrIG2y6UkNYK+YDXhcNC751l3jc0rwcvjPxWeb?=
 =?us-ascii?Q?4BBvNv4i8CpQIZtLHENixtCoBWeiB8f+zFHq2yHfkcAy?=
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27184628-cde7-4a88-4a3e-08de260b1d89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR07MB9999.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:57:11.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lpgl/4Lwd69AD/Ln0lQokfiQb0hDFPf/ACzaaVHso6aKGerLCDQelrNP7cM0FCmML2N7ma0cneLYYuSZLd5UCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB10833

On Mon, Nov 17, 2025 at 01:24:54PM -0500, Trond Myklebust wrote:
> On Mon, 2025-11-17 at 13:03 -0500, Aiden Lambert wrote:
> > A race condition occurs when both unlink() and link() are running
> > concurrently on the same inode, and the nlink count from the nfs
> > server
> > received in link()->nfs_do_access() clobbers the nlink count of the
> > inode in nfs_safe_remove() after the "remove" RPC is made to the
> > server
> > but before we decrement the link count. If the nlink value from
> > nfs_do_access() reflects the decremented nlink of the "remove" RPC, a
> > double decrement occurs, which can lead to the dropping of the client
> > side inode, causing the link call to return ENOENT. To fix this, we
> > record an expected nlink value before the "remove" RPC and compare it
> > with the value afterwards---if these two are the same, the drop is
> > performed. Note that this does not take into account nlink values
> > that
> > are a result of multi-client (un)link operations as these are not
> > guaranteed to be atomic by the NFS spec.
> 
> 
> Why do we end up running nfs_do_access() at all in the above test? That
> sounds like a bug. We shouldn't ever need to validate if we can create
> or delete things using ACCESS. That just ends up producing an
> unnecessary TOCTOU race.
> 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

It seems that the call chain is
1. vfs_link()
2. may_create()
3. inode_permission()/nfs_permission() which fails to get a cached value as the cache is
invalidated by the (un)link operations
4. nfs_do_access()

My initial thought for the fix was to elevate the inode rwsem to
exclusive write access in nfs_do_access if the thread does not already
have it, but I figured this design of not locking was a conscious one.

A second thought was to add a new lock around all operations talking to
nfsd and their corresponding client side metadata updates, but that may
not be the way to go.

I have a proof of concept script that catches the symptoms of this race
if you would like me to upload it.

