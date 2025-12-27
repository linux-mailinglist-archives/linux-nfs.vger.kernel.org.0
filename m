Return-Path: <linux-nfs+bounces-17333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E2CE0306
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 00:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64850300FFB3
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC81224AE0;
	Sat, 27 Dec 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EuiAxomj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022102.outbound.protection.outlook.com [52.101.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF5128816
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766878016; cv=fail; b=TVAXT5E2EfpLQrtMw1Kcf0221HITj6RrysQUGHApcSLfRrsfKJN2/E04fy9FrqDrmy5r9wYGaXg73xTTuHgk/QxjA/vofsb9sdmJ81wJc0m1HRCGenlNYQskjcZyj5HW0tlzZq1wleNiXBaA8r8Mu3hl2smFpvOmySxIS/YSvZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766878016; c=relaxed/simple;
	bh=N6iejyxjUIG6lsWCBpd5YNs+RmG8cx7hHzoz7so+Dgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=st9/DA8UH8EQYuzwNrmTh30mQuZ9ji5oAQz29DKZQFjad+D69MeHUTa4OCYPChi9qh7RjIJ5KqRIKr2oi+8oW0NF/97IXVxtjK60rYB0R84RHinQpu8o3JvNl7SeqSZ8kEi8qPr6uguvlZrlUkiAGb2XFmGDyW/UTHPoSvx+GDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EuiAxomj; arc=fail smtp.client-ip=52.101.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPjVZHPK3xR39jjlXvz5ESXUGH6Vqe+KxeAwy3Tq/19/9E9hV1n2geqDtmIdXYK7Z2kT2pZKvc+1No+SSCj17U3d0PaL3r+cOQBvaSxu80KB2kB0C5bOuGxNEBeXzMJESSdJyEBG6bisEVibCe+yPiiMLSDxSK3ahbSaEHujnmeEAqpNtAFSX6/PWjjoiHdz7TJ9inpzUSfvo8vCNtkRP1GplPVxkaCj6SY+B6B38Q4cEqz6hqzqnAw4mKlAHM8Mtl9iTcp8jaYOFMb52c3995sxTbVRQ1jDgKh4vB/rhHiMgWZ1lYX/hupAZXxlwN19446rhYpQdjGxV577k/vFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNawXjJlvgtVfcUusQznKfwx1Hnbu6DtqOvdlUlin3o=;
 b=u6Y5XB40ccm/eoCgRPn58qp9XsWEMF8xKRTQJLSw5lNbR902+pEIrBsGZZU/G6QfDEFk3EHKimjvu6vJeOpOlM7ThKFk8SQuzno3Htq9EXd6LtQ+gSgUrhv5dIz3szdQh91tav2TzU50qi58QEcCBzzdVgfbWZhdFknj1Y12qXzjgCkz/5XdM/rbiTM4Bqn4tJbWT57c0nB0pnLj9ziyoIV1Q1tNtj7UaqWAraTkN3ia5gZyyTUiB3T/4TwIROYPN68lskH/N8v2hgUmujzgbhR3wtTivteXiclgIQYJi28gNgs9hB+kdzcgEpsghfqQ5wXA3R7JsSVjWgk7usNouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNawXjJlvgtVfcUusQznKfwx1Hnbu6DtqOvdlUlin3o=;
 b=EuiAxomjjLR83sovb4vAewcOlT6PUEvZppwq5tACtiejorH4WHF6hLWI8HT0wauJTKSVBEfV0W4kwswnw9KMgGFM4HJMylqZwltQ3EqKqlmKMSk1Nq6YQkwJqV4MAhNLYbqeeT9AjyBD0jGdv8YGc2pDvJVEHURYyQPGTCZY99M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SN4PR13MB5360.namprd13.prod.outlook.com (2603:10b6:806:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 23:26:52 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 23:26:52 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Sat, 27 Dec 2025 18:26:49 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <A70E7B41-A5C0-443C-BD16-00E40F145FD2@hammerspace.com>
In-Reply-To: <176687677481.16766.96858908648989415@noble.neil.brown.name>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <176687677481.16766.96858908648989415@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0111.namprd07.prod.outlook.com
 (2603:10b6:510:4::26) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SN4PR13MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a06de9-06fc-43de-2c88-08de459f6a7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysnPt/cv04nKFCJ21oifhhew2CTNY4pdlfmMWuQO8vbXcU9ypoCvIg7IOSVQ?=
 =?us-ascii?Q?BZWsFPwcOqEeZ0Y0bx9KhMEey7FmIizBlNOy3j7qRAB2CGo1dVE93gPfoRpG?=
 =?us-ascii?Q?C5+YmboA8A0lRpa9K+l9VH/GZfCoJMX0osCQ17FGjVvOi3TXbzKI6RNliDQo?=
 =?us-ascii?Q?OUbeEBSwPYNhq4SnaNYmWmWb9RygYJDemt4RkgzOT0FRLtOHzstydvjcLq6L?=
 =?us-ascii?Q?UtC9/RR8llTK5W9XVN/Yv9kPrMmHk+wNnM7f/ejWOZuRX4libyejIWpSEYYu?=
 =?us-ascii?Q?bSXnwQQDOLAUbCE+87QMrVuniAwF6r8RFa2QJQar09So25k8YQixiKmLOSM2?=
 =?us-ascii?Q?E1/KYwBvpEFpwVWGaVQ1EP8qee6AQw0pDVu43QFypq1B4TOEDhjyx1+SX9dX?=
 =?us-ascii?Q?kc5F6xHat8VQQtE6ju3zF2cikGxbKqa3szwrf+5CVA3i0NoBrelDVaGcPgOc?=
 =?us-ascii?Q?3+kLLs2oNzu1I9pr4QqAq7IOYKqdVfBCWCyYf+Yzn8fdk8OiyIVqKj0MMvGt?=
 =?us-ascii?Q?3Af7qebt+gFXnjP5KbVVp97zI+w86Lodt82H4Agk4OQDkdBOjULIn6Q1Uorm?=
 =?us-ascii?Q?3SGmNxn4MfTrNuLEAw/aAJqTYPNqi78LKrI9Uw977Ps7L7fp4xE8zVmPhEcR?=
 =?us-ascii?Q?FPNhIONSoGT10IMhkxMNmLKy2hic21P6wxkp84in74qelzRZC9UjscVTYbjG?=
 =?us-ascii?Q?YmP3a1dsRFOl4pwbq3zsDXeXmuUyHG9e3qt1mMh0oS/0X3jkUz6xMASPFE11?=
 =?us-ascii?Q?9lCPj0OOlskKqOP+e4Ow0iGCBlpjFWT4/qMfTUxnMPRo+4yZE2Y6RYhsQqri?=
 =?us-ascii?Q?yiqS4IpPlsyQHReO07Wp1+qHwhzIW2Gd142EfWTGVDw97RO/gHT2uHBLlF9y?=
 =?us-ascii?Q?GXVt9DAgzeSNxM0vE2RTprHos+7mk9BNBkXJbjHLsc/9OH0G/2n52Fdxd5LO?=
 =?us-ascii?Q?HW++CGiJlzNoCU1vssttk8RC7CKLn/UUOBoKRpBel5dUGVQHs4/OavVxinkd?=
 =?us-ascii?Q?dHowA5KMA+N0jZNtYSqSwOxhcBilOqLc2bUHJWkQY/Pp3hwV5tA3P9DHzlf/?=
 =?us-ascii?Q?aKcNcrxhsXm/anErgs16BgMiZSkMh9ImGU3+kFmxyQQcQq+X2Zl4AUvC9YgS?=
 =?us-ascii?Q?v7NPJ52xp8gImm2HIrZke6/NkCHuMaWmLM0IZ31dWMWfZOZ0jY+7EZtO/72O?=
 =?us-ascii?Q?pvpJz4ZKYl4BrxCflJBPBA6iqtdShvHGOd/7nBywTwyH5oxvyfjV3s0dkKv8?=
 =?us-ascii?Q?jE1B6AcxaY29o8rRKJPBXk1g35eW4vlbR+AHTAU1u0mapPoVNI9E1nvEWo7B?=
 =?us-ascii?Q?LhQtx2pjBXHiffIjIwLLMr5aQMOI9MtGWxhH3vMOkFECv2cDTiOxsNkshcli?=
 =?us-ascii?Q?AcZ9phYnUEjPTumOpM77USQv3rbXGbhVGVt2RLgVzD9VgDpdvxJMhAFVpdJ3?=
 =?us-ascii?Q?+UkYH5Uj15NYrkC4vRkgpl6gJAQWtNHO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmFjdmAvIGNaXl5mq6foTbXExzTCIzFY1vX4W5yLz7iYhKC9i35wBNfuoNBL?=
 =?us-ascii?Q?Do8yjX1rfdrqBim84VNHdJ3PBAmJFfs9P22uPp9XkmCUFYx7sNsLb347DYdk?=
 =?us-ascii?Q?t2HbG5AitpeTZ4OC3ncfl3b2WpsECZjL+fmSPU61NrewT+VQgOZ37/GZEU1c?=
 =?us-ascii?Q?CkaXKr8Z+c+AOqQ7kyYO1ZnT/dMoo9cL2PfozszJToQgq0CuggL5hBo+E2Q5?=
 =?us-ascii?Q?sUnEu6AI/GO7NdGuVsqnxADs5KQFC5VDtJ/iqrSt54TYn4B1SnixCevrmd1t?=
 =?us-ascii?Q?b5zlGhg5EMLKw7o948Jwe7aZ2UvLk7mQonoeZ5WwK0p0HSOH4fXQ2S8hezca?=
 =?us-ascii?Q?vxlYNdOYR6AG7t32r5U3wOmK5NrYkXjDDlbNC8OIXHpYNsbl4yu2i0ZcFB+8?=
 =?us-ascii?Q?IF4wW9iZIJbsA95aSVtp35Dohg7RqVNT1NHtyMiIExRs2y5XjTM+FwV0JI3b?=
 =?us-ascii?Q?EAFFXuyPOLkkWB0siEq2WzFZmXeD/HHEtTX687kN2noHE4Y6QzCBferOvOVx?=
 =?us-ascii?Q?hFxGsrVytPWJCec0PlZnDS9PdKXlUIKPkw3FPko2U8KFMfmpQHI9BQQvfgsY?=
 =?us-ascii?Q?YizhAlOt29dpc7VI5OECph/KRfNL63iPjQzC5MAjy9Gl/8DVGx73wZ/HuO3/?=
 =?us-ascii?Q?Qju8eijV3MAB24nwVPrHXfhWamDG+jfYV5+kw+zvPnesjo7UPnnbcZ22Zf5b?=
 =?us-ascii?Q?el5MpSXF1+OqnkDqbFBjU5GUFVh/r4oeOteKAc+krqdgX4M4NHPW5KXTSOVL?=
 =?us-ascii?Q?j1bnTF62FyIxJQV0uyxzdtYQja5rq735YSrSSjQdsgVRD1XMp8tTYvJUXVnW?=
 =?us-ascii?Q?pWTlCG3qN0gS1Jj0hrzADFH26qcPQyoNwTIo54qW+dFn7WJUYwSWilHb1RLq?=
 =?us-ascii?Q?aE3UFlmTT0UZQtxlgjqf6BzJakC66L7xdYoKlwjlC8zPMtr/ka3MyKHzs7LR?=
 =?us-ascii?Q?VzG24Rnr6Fbx1ar/jiF1toDwnu0FC255HLYq1X/5txWa8gPDB6s2+8LQhmDb?=
 =?us-ascii?Q?1hZqG0lCWIHVRtVDSWkkE4kOPkFmiHr43WrPB0LShrNqzlaXvwpZuTvUGSTY?=
 =?us-ascii?Q?EB0qzXHHGV1YccYIAe2RoQr0DjTTycB/i7uQhjqXQI5hk3SSHqA1Wr+Ph9M1?=
 =?us-ascii?Q?c/5JtkaK5mmu0ZzZ6eq7yXCjNn926fbWnBTDgL7beYLjsREsHuL9+9lavKid?=
 =?us-ascii?Q?mOGUkTtp7+w/RpXv12WcACWN+43dJawgn3wyPzzLilGhtskU5hcQdxTqsfsd?=
 =?us-ascii?Q?+GpVHBtcdKL37QHMc3Cgmfid7SKc7pYZXwXy3unn0Evq7D3Js+ViCEFNcRLQ?=
 =?us-ascii?Q?SAc+BA2kQPHi1wNv/zo77Mj/PKmIq8pdLAkqIADZ0Z/6uc2xS+bdid4HQfaN?=
 =?us-ascii?Q?MUvoNFaYdzDHgx6GKdM1vqBAH2MDHQKBLwjflJwHV7gqW9OA9hkJaf4P+A9I?=
 =?us-ascii?Q?1/Q+VZY5dS8h4RMDeL6kaoYm9ODfoizqEUgOT3jk3a4rkOCV2OTnU4FnzIuP?=
 =?us-ascii?Q?XoB2Glkik0wtdz0RJMyJNFfBMshtdTykSN2xu1l4iGaEbFT8iMEp8bU4sBjI?=
 =?us-ascii?Q?uBv/IwCCY+xaCagN69VVQYm7c6MrRjF9xSP4e8VgAVJ4z+6V4CTipD4FPPlp?=
 =?us-ascii?Q?+K9RERSUJRq51Ggyc1rR5jTW2+whLVZRI6NgNTvT16hJdPLwnyV/H/rJmQ2D?=
 =?us-ascii?Q?UvPkzTJFcPzSEXMFdYRFFLvQLw+oeyVl7MGWEq/DEOctAGm6wn2uCDzUXC3i?=
 =?us-ascii?Q?2fq5+ENBXRdaczpyWPbrmCn75Oohc7s=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a06de9-06fc-43de-2c88-08de459f6a7d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 23:26:52.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS/yU5Igt4FzvLAzCecgUVdhEvh5rUrq42ZUKfRXvPS2LWzDPKkMV4MCdumL2jCNOkwNWSJqNdUn6gb1PyniDecTgsIfLwS5szpW6MU90aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5360

On 27 Dec 2025, at 18:06, NeilBrown wrote:

> On Sun, 28 Dec 2025, Benjamin Coddington wrote:
>> In order to harden kNFSD against various filehandle manipulation techniques
>> the following patches implement a method of reversibly encrypting filehandle
>> contents.
>>
>> Using the kernel's skcipher AES-CBC, filehandles are encrypted by firstly
>> hashing the fileid using the fsid as a salt, then using the hashed fileid as
>> the first block to finally hash the fsid.
>>
>> The first attempts at this used stack-allocated buffers, but I ran into many
>> memory alignment problems on my arm64 machine that sent me back to using
>> GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:210).  In
>> order to avoid constant allocation/freeing, the buffers are allocated once
>> for every knfsd thread.  If anyone has suggestions for reducing the number
>> of buffers required and their memcpy() operations, I am all ears.
>>
>> Currently the code overloads filehandle's auth_type byte.  This seems
>> appropriate for this purpose, but this implementation does not actually
>> reject unencrypted filehandles on an export that is giving out encrypted
>> ones.  I expect we'll want to tighten this up in a future version.
>>
>> Comments and critique welcome.
>
> Can you say more about the threat-model you are trying to address?
>
> I never pursued this idea (despite adding the auth_type byte to the
> filehandle) because I couldn't think of a scenario where it made a
> useful difference.
>
> If an attacker can inject arbitrary RPC packets into the network in a
> way that the server will trust them, then it is very likely to be able
> to snoop filehandles and do a similar amount of damage...  though I'm
> having trouble remembering that damage that would be?

Filehandles are usually pretty easy to reverse engineer.  Once you've seen a
few, the number of bits you need to manipulate to find new things on the
filesystem is pretty small.  That means that (forget about MITM - though
that is still a real threat) even a trusted client might be able to access
objects outside the export root on the same filesystem.

This problem is further exacerbated when using kNFSD as a DS for a flexfiles
setup - the MDS may be performing access checks for objects that the DS does
not.  Manipulating filehandles to a DS can circumvent those access checks.

I can absolutely add more information on this for subsequent postings.

Ben

