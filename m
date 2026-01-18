Return-Path: <linux-nfs+bounces-18083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DDD39832
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 17:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60CA330012F3
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B819CCF5;
	Sun, 18 Jan 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CbNJYSe1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021104.outbound.protection.outlook.com [40.107.208.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41317A2F0
	for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755588; cv=fail; b=rqFNrRVA0ui2UUwt3+S773F+Vo6GXRZfVqC0269W9q2R09lOLsid8MTe0fQoecpvaGGBQW6DlA36cGsMmWAfhr1pOO1PFqcM2LCueYuuBBCTfGYJneKctNx3+zunNNsAGURd+w9PMGYaCHjIDfOht3MceXnfkd4aHNaQyAqv83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755588; c=relaxed/simple;
	bh=KmUnXoAAe9a9P5gCfzVwOb9YW9IgG7U7vSb6W/dPOkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZjwnIqMQOqAQUcwuuQ45/iFP6kvIFfpllymhPsLe2pfE2az+x0FmMYGgoNQQLHu+bs5B9K6rhQLezwm1hmiPWsWUzuwtOXUiqzYpzx03pnu3E4CBf3xHpRtuEGeHA/IBs0dvglKCiN+lRo7mpwfBU/0+H82kWJSUi77EGDwcNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CbNJYSe1; arc=fail smtp.client-ip=40.107.208.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmKhlCYkPPuQKGdEOmB+XOFuKuRfLM3rzAwNQi5O1RnbWulzWSYhcVsCYBs1uSv4QvE4cVOqQeNGu2+lJbb99VnGuKh41tY1ZUo6kxXCQ9jaE3rHxysteFX945dw80Qp1i8sbWfiOgvC3beyyuZ3BXvgjyQE3S4NlllQTzft6d81Z6Bi04ZtyTAkf7imuUZVfH+oCznQTHLw3R5ksO+Nf6F1Yw5YFZyQooUFGNwMMEEiXDEVR5TBbmIHZZnp9kAsTJUUAwLCyAjd5XoznDPO3C891UVuRnszdK9XrYYqUyhVuYrqbxeMSWLYr2usz6zB/8E0rCrFWr/QDkW3r4TeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kf9QW5CM1ex0c4UEyhvoRNC0/vTKEQ5xXXpt6IF5SQ=;
 b=uq+76YExkfD+ApndTZLVCPeQjDxGHWEZkxg2E1eL5DdWDU7PK+D7dB71rA8iiUC+ZdrxKVIarI6F2UD2IlMkGNelsy5VqySTVvlra0KqoF706ZlSFJpOR3o7LB2skhce12WePie5ZDAe3e4MtFk+aqZ2kvijSaKoNSZDWbctZJd8ZqGQIb6QGFyHI3ouoWkLEW52yy2YYeU9LjO7zUPB4YSdJCD7D/vywm6SpMkBalhRmN+5KYq6kYiAVUO8RAxzDZq0RNG6zvDLVK1fKLyzxxNeTY67z8xBBOJJXp+7U+Phar1WFQGFBLtvCTjHRbA+EeG0MXINwEOBiSIj7sbP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kf9QW5CM1ex0c4UEyhvoRNC0/vTKEQ5xXXpt6IF5SQ=;
 b=CbNJYSe1JcZ+LHjUdgFcLCTd5/9KfBgpbu5lce0PyuWJXfNvnlccJUfXrhSBHteGUrcPGiNnyut2P4Gx8IpCGRf9wcC4b6uW9KzjsMuRZIszPSrUATdKEM1N/TnLw8G6iyvHQkkrO69x5PSu7r+T75xWNfqcPPWqtNtr5JgguB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MN0PR13MB6640.namprd13.prod.outlook.com (2603:10b6:208:4bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 16:59:44 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 16:59:43 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Sun, 18 Jan 2026 11:59:41 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
In-Reply-To: <176868679725.16766.14739276568986177664@noble.neil.brown.name>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::30) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MN0PR13MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f9c655-1785-4ba1-2f8d-08de56b2fa31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14pPjfOOblEHQ8m4NxKfB1u6t3RHLzxBLuwCCPP0S1PeRA+Vi3qsday2DGf3?=
 =?us-ascii?Q?Qr/Tqyi+1d074jhUqc71m4ZWYanmPm7IKQ8rnS8Zx9LmM+aB/P0o7Yi6zMCd?=
 =?us-ascii?Q?3fdt74GNZLSDaVxaDA8gbqKsOdz7NaU8w6pzor8PrW20y3kr1RrDqIZed2M2?=
 =?us-ascii?Q?woKSc7Ph/3jKovQGAGX/iHeeO91w/eyAj6EU1Eq6QCW42aUi3Uz8w9Cr63A6?=
 =?us-ascii?Q?1nFy/ixLOtxoqYfSHZvl6llpdNHhIHwX89Yvs0IkqCp81r0wH3Zn1Pqt7WZW?=
 =?us-ascii?Q?jRQQENvhV60S7WDOjkCauOkX4zZ5aYWSZDjP8dx0nA4ZF6znkswDR/CQ0+Tb?=
 =?us-ascii?Q?RuRRpwaeQ1EJOdnebUIcDYvs9fPq/4TPLiuWkT022y4QYA3zkCAfsAqp5M3z?=
 =?us-ascii?Q?YXFUNkFyFJ3fH//MFvQ8KZGPzwbky3ajA+xDii30NQjj9DoOmaFTXJtVGsVl?=
 =?us-ascii?Q?UsZObL0T9w/bzV1KDA8cOBTR5TAvGnMsrYGM+7/L9Eubgx9mulFaUWwD7FdO?=
 =?us-ascii?Q?yJPaJVpE1VrMTo4HCocfQfkuh/cPyGxGTfStMxDHSWcs9xlhC5M+5L/McxYH?=
 =?us-ascii?Q?E9E13e6/+ZC++F3ysN1es0atZDamIrsFquEt/FJK0QrwyBcv7jAv5XgE3rzd?=
 =?us-ascii?Q?6kk8Ksyuy7w58CY/hEjUWC/JyIbIkYFW2/n3Ry0IokIUbg5obUlY/v3Yj5hF?=
 =?us-ascii?Q?bksegMhk63oCt2vvE8oZFfvpcKFu/0gI0brIZCj20CIillEhWjkYt/mKcxQk?=
 =?us-ascii?Q?uVrlHf+5/2kntXmMv+aC67K+m57V+91oBAzxWNhQBXDP0xyv7nP3zYqZUm/3?=
 =?us-ascii?Q?43VgAAQ8oYDPKmRnkgXtCNnououYJq0XXeEKhFTa0Bgo1Ryr01HilM7tSsN6?=
 =?us-ascii?Q?AtJ/JoxsMFNYF5joIVAoIvO3cmquZYhkvsWglx3NRLfCr7dn9Hfr2DGpwF5t?=
 =?us-ascii?Q?kcsRvLHP3TjJOqIS5ja3jJ1scx2b0d3cY1EveQ2QFeW//0jjsEdsheU7+XLA?=
 =?us-ascii?Q?szsCl8l4lE1Ien5vWaiWmQbdvgmwnxu750a3qZpD0ucuHY56Y0HAmml65gTz?=
 =?us-ascii?Q?zcrK4y9JQyDwN2cOQ16vDFXTyIi1INQd83/IgtyH3dtFSp2kuPvdELFaMlII?=
 =?us-ascii?Q?yYfLanPyRNHFWFZ5ZVy12JiAOvIuylgYmceibJkfj1V0ukxCk2MA84paB2fy?=
 =?us-ascii?Q?1S7gXDsV6f9lQf9i/4cp07Aew8QFX/gwJsMR9qG50WLEW7Ks1wle/QFKKpXf?=
 =?us-ascii?Q?cBZ5W+78HmIJOmBPiLlkWkVjAb7SAZ8LTe0eHg5sN95oUrOWjEjDOETAOUIy?=
 =?us-ascii?Q?hR5ij81cWET702jZ+6TRovOmr3cyEc8FP+ggMEuGhZQWBAhjwCtL5NTHcMcz?=
 =?us-ascii?Q?y/QMcmcT54h7RKMJS66ghB5cH9L5OvSZmAxoOyzreyekHylmIkaxQ/HVdpiV?=
 =?us-ascii?Q?nNtRtWbBLeql8+nE0UNEqSje2yCoopzluW9lJAec1km/LYhnbLnhDNjNJllD?=
 =?us-ascii?Q?OaWDZBAmjbElEWgKFSwjHsAU2ekbN7+vNfZVTeNrZ/5PXD2RsVa4O/fX+DBp?=
 =?us-ascii?Q?ZTDOziFV0RxMpLEDBm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJ+UM1Ycy33fCzuwjGYlkPGrtvDkmBZRZIhUJxztfRjd+xQD6gWmy8eaFV1L?=
 =?us-ascii?Q?/yhQlEmIzKqfNVvVPTEMHyU+0CmDhsF8WpPFM49ArormEY0QdOtcFETfAQwj?=
 =?us-ascii?Q?yDiWKyDO4yFgoVIHg1W5OlSGamrcyITphaLZVYRLc9kG1T5lrX+vhOf/h8s0?=
 =?us-ascii?Q?+Tt49BwW3ErKRFWHCLKlVce01/ewZ68vccxjeUeWTegK32p/ZZiKPZFYQlAZ?=
 =?us-ascii?Q?IO3ZdNTEOY/2bVDddmw5aDrQXEMcjQOLPDu7UWvvfZTywpp7WO5Yw/NjYo0j?=
 =?us-ascii?Q?x2RBnSEKCINLTkfSXpnVDow9br23KAIvCN0ZuRca3lSYufP3Qh/ik67MW9Ya?=
 =?us-ascii?Q?QtatupaJYyE9BtyBa77THMs7N2r2tA/T5oh5xww+8ERngC/V6TC15QYvLqb0?=
 =?us-ascii?Q?4CZgoHsAX9CqdRA2JyvJa8/YDOsfgOU87086LiYWRDfJ2zvGiFV86b+/JSDL?=
 =?us-ascii?Q?Sz4bvvipeirzK3vVnJyF+0sGAStDXb3vNY4C/59No4APLb/DYS/3uMljGR0j?=
 =?us-ascii?Q?GJGiUESpxIjzxx6rH05SSmdKCJUOCDIQbeuOh5n8/vDgquPChYJ25Jg+IpFv?=
 =?us-ascii?Q?0g6wcdU5evmGDtJXP3CvU/0HzC3bPEGC8qPz7dIuHqJR+3lpJEf8sVIeMROl?=
 =?us-ascii?Q?jVbkKCbfRg97jn5M0xeq/4ncq3hgePftbRGQtFppBJLF1IEIskkLazAd3cMc?=
 =?us-ascii?Q?4YJcA69WUxX1rkBkpW1upb/ad9eWMze9n65Uku4ugB4juNjks+OeGQA2J0Rn?=
 =?us-ascii?Q?emnHIIawwaJZxPHkEjWmNuS2EyPe2HHEIhMYa1LO4twq8iCFJuuJH9HgpIC+?=
 =?us-ascii?Q?+Hyh738b/V2db4VyHENeNavzl3Y7Xa3+uvpdOh+rp+qWtKnDsm7dnkbUtDo1?=
 =?us-ascii?Q?kLRqKL/43FRBfeNkgxLZ/+AZP6FmPyUL9Su6Dw63kE4mJECP6UIEd36RUoOW?=
 =?us-ascii?Q?v3QV5qWY+6vzfoTNKBKvV6nLXqKLoweoQ2MArJXt9LNtaCwycDaTNEIvC+ap?=
 =?us-ascii?Q?REKAXg34zdqA81X6npXXwEKe1m2d0G7vc2GTsrItkhKj2q5IDPFZXb+gIKOC?=
 =?us-ascii?Q?s7t3GU8Dm495jFgIHXAcU0WueykCzpVFTGGzdtiUFhJ9MnmHDXyQLInPNaqb?=
 =?us-ascii?Q?COOrsKHA2LgT5o05lKVkoLzgmpbceWz1OsS9iTNYSz3d8GslScNWAqTDmg/r?=
 =?us-ascii?Q?3ItkN4KSaNNEW9PoJ3w8ntJYuAh0jbkVQuMByay39qPPq6b9B389aSiyibYa?=
 =?us-ascii?Q?ttgqJkRH6Q6M3MMWUh0LjsvQqv7TYZim7hdpmVN0bGZnH5LpI9k/xE/qzweS?=
 =?us-ascii?Q?oGMa6em3tOND4xHiJ3VsJAtLn2DpgRGaKaw0taJM47T/6U8zE72qTj/4B71G?=
 =?us-ascii?Q?jQE561MKgH+dZaHyBL1QQ/989uKSaLJyLJjSkv0IAKwcKI6OI69unMkwA2UU?=
 =?us-ascii?Q?t1VbqE/tEVzBImgJCk+V0kjD18EaXzjGWRn6PZ2qFdAxICjzcafxtiyep3i6?=
 =?us-ascii?Q?N9GgGv9Xe6R45ck/mkqVBjDeBg1bjK8QKcSrh1xlX8tqw4Jh3xtnpwjaUm/C?=
 =?us-ascii?Q?1ng7sX/EdeNY8dJUFLuW23kfb9c2FqekEcUxiZwF5Sabx+xEmZQxYjEbUnGE?=
 =?us-ascii?Q?sCZF+hgtF8eETpkbWrW7FfMcdvIuUmGn3nw4oHxcQ7AIz3PM63KUZKpSsAQz?=
 =?us-ascii?Q?LIei5b0xoNSPe8Kgwb87O6bAq4ibksue+qCTJQ07l5zD3o9Uzsf6JR7QQKfM?=
 =?us-ascii?Q?habZQ5IhxD6Wkm7BTiIuGUXuGBu8594=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f9c655-1785-4ba1-2f8d-08de56b2fa31
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 16:59:43.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y81veAagE0Icnxjf8n99+fUnc0Z8KOow7JuENKYwSK/o5pnQmkXt4JaLW6j2P7dRtD+YQ1HD8NcbEkaLnoiJ/YBoBvqgr5WSSVFAuHFGUsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6640

On 17 Jan 2026, at 16:53, NeilBrown wrote:

> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>> If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
>
> ... is set in THE NFSD SECTION OF nfs.conf
>
>
>> will hash the contents of the file with libuuid's uuid_generate_sha1 and
>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
>
> This patch adds no code that uses uuid_generate_sha1(), and doesn't
> provide any code for hash_fh_key_file()...

I forgot to add the hash function after moving it into libnfs to make it
available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:

diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
new file mode 100644
index 000000000000..350d36bf8649
--- /dev/null
+++ b/support/nfs/fh_key_file.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <uuid/uuid.h>
+
+#include "nfslib.h"
+
+#define HASH_BLOCKSIZE  256
+int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
+{
+	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
+	FILE *sfile = NULL;
+	char *buf = malloc(HASH_BLOCKSIZE);
+	size_t pos;
+	int ret = 0;
+
+	if (!buf)
+		goto out;
+
+	sfile = fopen(fh_key_file, "r");
+	if (!sfile) {
+		ret = errno;
+		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
+		goto out;
+	}
+
+	uuid_parse(seed_s, uuid);
+	while (1) {
+		size_t sread;
+		pos = 0;
+
+		while (1) {
+			if (feof(sfile))
+				goto finish_block;
+
+			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
+			pos += sread;
+
+			if (pos == HASH_BLOCKSIZE)
+				break;
+
+			if (sread == 0) {
+				if (ferror(sfile))
+					goto out;
+				goto finish_block;
+			}
+		}
+		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
+	}
+finish_block:
+	if (pos)
+		uuid_generate_sha1(uuid, uuid, buf, pos);
+out:
+	if (sfile)
+		fclose(sfile);
+	free(buf);
+	return ret;
+}

