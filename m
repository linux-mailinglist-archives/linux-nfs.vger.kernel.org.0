Return-Path: <linux-nfs+bounces-17326-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27671CE0006
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E359F3028FCC
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970E8834;
	Sat, 27 Dec 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Uk9ylBp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022078.outbound.protection.outlook.com [40.107.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3532572C
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855110; cv=fail; b=Uaa7GBIbVDH3mQHrdGiPm1xYxO1rAO4HVX7whPH9gT2jFKZ4DVvH8QnnnHxi6ZhAmCFvfuhi8CHL5IdeJ/JeVVvDNTf2cxk3aQpVzA7sdKzlGxCfcY7au1l+yGYF29paJzaA3hDq26h+xlzgdiWOqkW4jHFv9vT38TE0Axe83w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855110; c=relaxed/simple;
	bh=ThoHRZlORJyiQzN/7BCpnhgqGxtstm3aBD/otrxHxV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJnV7373FcJFrBLhtY3yYFbhAZfBbV6ilTL5A3f7zkvR7Ai5KU2HHrX6O5jOiaRcdkU3up1c55NKy/svzNeYx0qT41B4GKU3MU6RS2GWkCT15RVnf7JzSRi45GfaN/3h8wwwHjnkxzAOgy9Iiu+0Ve/peeL60HDlfMc4/0Qx0Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Uk9ylBp1; arc=fail smtp.client-ip=40.107.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUYOhzlZw9j+opNSeLPckunJw2ynWbH8ImmpzULonLBkJ5HDsehxTZhsrgOFVP33RNyP/IGEknhIkxwhiTsIm85qLpB0D3AZv15sY81B1tyPlw+yxEQhujQRzMNPO09LD+gX7O/Ha1HZ9jNaQg0efZstWATIvMG6uu3LQzLEw46dzhj+NeLMa4y+HK34UwB9cQkTq72waKRrZ0JFx6YIKdbc1+a2R9Dw+6vdrx6nwd9TAQ+CZ8bfeyIc6cOS+dmXaGeQD8gML3jcDK4TD3bPzx+p0xkQqH5ihVm4ZkRYqBm0M8t5f9DkN+nKOjyiyzyEW22uKXc36R+lVpSdEX2+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hbwRqRX0SOY/hdQvqY4vSwOnFA1jdb2caXTtT+RiNc=;
 b=m6mSfK2v8w/d1jJ2Yc2wVkHirtbYJy3z43/aHhy0a46ULoWTu4r0barTuFvWXZ9rDJ7B2c6Mk18RTjuw0c5vYVQw6iBgpcdiqTrxD7zMzis9xsm06TaS9ju0EAvwAYTNRR489ipAxA6x7u3TZ0z7SoAFrEOCgRDZmgLAaqyvIbLmWzqR0ePkJ5dLdXUUq5y/yh9sTNVvndBUYJW8pWnCnXl7rIFwiMsh38Y7R/B5DZ3PojVJx0Jt9r2qVwW9dz+2Q2WsDCPYJ/JQWLXrGTioMg9zrieWUIXW5iOOPoTpQ2t7b3ajCjGGBAib7fFgcbKkRFkqPVqMX4qKiGxCjp3Taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hbwRqRX0SOY/hdQvqY4vSwOnFA1jdb2caXTtT+RiNc=;
 b=Uk9ylBp12uRfbXTUOsmskaJtXxH/soE5p3vxZXXRF/7bm6Zd7J0KMgB9it50mRtYfVMKUk6TwjzWAHZu/cyhn8WVLWwCxOT/TzktfG1KXnrAkmSnKm+asnX3KBSCjS7osPBZNR4CrreGh2hqLZ727O19LBUMHg3+Qqr78/tkSUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:05:02 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:05:02 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 4/7] NFSD: Add a per-knfsd reusable encfh_buf
Date: Sat, 27 Dec 2025 12:04:52 -0500
Message-ID: <5b7bf494b1ec816111ab34416dcde85c0bc01a0a.1766848778.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1766848778.git.bcodding@hammerspace.com>
References: <cover.1766848778.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: f858ca19-3177-4a8c-f4f1-08de456a132a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fEO6bjjhF5eetHyX+FNBbwHS69Iv7/GGcCkpWOavTTeTJVPEgM7Es/xsIHqr?=
 =?us-ascii?Q?xSRsKshm3/ZrYQ9x0kz0fNp3OiXlgsBH+oodTdLYDVZBTqEXkLywCqMKwclm?=
 =?us-ascii?Q?bolICUPLXx+VbdmfgnZjmjJokqKPwKyF31KEoaEMxWvWx/RGs+3/XEL1kedI?=
 =?us-ascii?Q?CwGK1DmqZef7GQGsxtLdvm0nr3naKe6S7D8bWAztIPQgqsEaVn49Ul0VjnT5?=
 =?us-ascii?Q?ERLvE0eaLoGjscZbJx4YFFoMKfIwAzoFWhhInmhQKMK9v+I0d278TZfpVtAs?=
 =?us-ascii?Q?+JBZr4VM+0ZDI5sYpZZMij1/FVFf5PFGej9nudwD5ftqCg+eKO9Po8qbU3FZ?=
 =?us-ascii?Q?TPAsG/kJVwRD2wgSZLXt5d/y3r20+VIXPykfV+4NFOuKRSJ5b2apegpsLios?=
 =?us-ascii?Q?Svtzpli4XKQbSW2m73FcrIo98wyhjma4OxYuvp2k1oJgQMACVagElnknJeuh?=
 =?us-ascii?Q?4jWTaL0Vwe4Ue5gphwOvGygHEEeXN7sFc72erj/EBeSD8+bAyiUl1RDhdvzk?=
 =?us-ascii?Q?xy6pS0Rj07uygYTN4JnIQGzYjObNgo5TOaLVafEF2aWRGO5hSafXDduyooZB?=
 =?us-ascii?Q?kU7JrkXFWdJg8mpgKgi9yzPM5CFL39EWg3AsM8IcPOt86iNEjcehZnmjrtqN?=
 =?us-ascii?Q?Jj7pr3AdT7IVnTY1yZbuHdUcZsetXw2dmzzT9IjOq9LhvchZiSLSOd7D2Bt6?=
 =?us-ascii?Q?FwFsZNpL0+YLrnBohhTfQOL5H3iIihNZl/h+EBP7RoaSwnczblPBj9QfD6b0?=
 =?us-ascii?Q?J7NTEW2/AkOLpKKxG5MvFSoSQO62L5yOzCLEb9wEbc9oyqe4FJQ9eE+AuLq6?=
 =?us-ascii?Q?8ksbL5AxP68jrkMLZsr0Uutv2ZVEhRxbJp4Zdfy/NNLpa7xiui1wqO+4K/SU?=
 =?us-ascii?Q?E0WVRvtTaqsRlzyODOZ2LWU8CBmb4CSwsd3kUTglXPukkPUcQUX7OuUAgBV9?=
 =?us-ascii?Q?CVHGEinm+KGZ5YszhQkIN43UfNMtlyYZZzYg471e3jH9hHdu3KOQAWaJeR0N?=
 =?us-ascii?Q?ip7XC18LXj9aE+2e5sIysI+nq2GeaUEY1zQ5ru0j0lk0A3jIhngr7hWbdvLx?=
 =?us-ascii?Q?wmdLyHdmifMsCC5sDYPtdg4CPXeEjn1ivspiIYjwNCHU6UNqOv/EypmTQwSB?=
 =?us-ascii?Q?2AO7pbGEqolAnod63XqdeP7cob+pYWqFF0bKpn8Piq/fdfr6WlWW8pbpAT3r?=
 =?us-ascii?Q?Vu8bueEFOI5FR0KaQ3p6Yfpy5O7ZnBc6mgRY3OnmQanDiXgoJPf1O8gsFPoz?=
 =?us-ascii?Q?hAlE20fNuKrZhWvswSQ5QF2thOn3gbX4U8bae+jXzZL/RAr28z70ORZRsNAJ?=
 =?us-ascii?Q?tG2GRAeRR6e65J0rdlaF7jpl7tReZWmeivNq5tHK0+hqMiZMphrtV5k+jvum?=
 =?us-ascii?Q?5rMFSKTaqzXiWVw2QNJ3TEVv8cx/qefoVlPeVajboNlXlVdyQOt2/EeGcRTd?=
 =?us-ascii?Q?QVw9My4qDAKWN/WcMufObUxgyKMi3AjE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YL3OMIecfMmfbZ4KgNw9pXC2xIxV/Fli7EkCGQYivLwlAeKuOVOZ+9vhCSkC?=
 =?us-ascii?Q?PcaiqkOghRQ2fiGlo+C6ySbQb09R+UnauIa/lolooUJ0FdndBsubI4W3q3Sd?=
 =?us-ascii?Q?L3HgLV3fXjKFvPxWJCEl0OVCNgVe8Q5Jl+ZU3Thwqui6uQ38K63m8LYFTzhi?=
 =?us-ascii?Q?nxycZuMYnM2DDckY/YYgovkVHLeEZlBsuZ3wOIMTgy7n4IIQq6emfrIXapNZ?=
 =?us-ascii?Q?lVyIu4c6GENjCJDg2V3W4zyfXYLxWx4P5bC3Qoa2+DpRQjHGzFMAfATTYrrn?=
 =?us-ascii?Q?UJugPdH5j6txMWRBfIcwOK+4QJ2+xaBoPWW317EXfeWgtHgwOfHbsTBV8k7h?=
 =?us-ascii?Q?lxFciJBF0666y+Pbrso+otaD1r1cRdu5ly3qxfAi+p27GmHp6mPECCgbNgJx?=
 =?us-ascii?Q?P5X4mdfLYxR3hbOyHU0zJ1bIZMuiN3lu7XRbD3YAXlT2kg0+nfcZdYxCMc56?=
 =?us-ascii?Q?wPgLU01CshuRkzbb0tZqWsCSEcultdibQfeQ9iZ4T3dGFEQseUNEewj06VLt?=
 =?us-ascii?Q?K49SSGLyseB91APz8TU+B7P0rojr+8hgtuR2oeuBNL1nBemGdziMbamlgWAZ?=
 =?us-ascii?Q?REqeCtibFSPlw0Zbz7HZvRUN0w9qa1boKMzvhH6a+CtuUUPW92zTUr/WHqNC?=
 =?us-ascii?Q?yw/X5i4tI9AALIgMmBTgVYt8zjbcrOEyrwUtiu9BxOMgaklM5xXNSUDGioDz?=
 =?us-ascii?Q?fJL2qUeBvNZt/orbD3doDrUtO+9kfdHMczLKt0zX6/crzMJhLectKYrth6RT?=
 =?us-ascii?Q?D6K78LJ+79uACRZzVUIdLyzXHdfdMhn8HR/A36I5dqgl7ZiLVwwDtszfEXzY?=
 =?us-ascii?Q?t2qowANR9Ha62f0qSzZxWmwknMZPbMEfXuRxG/VQ2upoTL7fMMKCubRSTWuJ?=
 =?us-ascii?Q?9VT3QxSDICGphdhLfTEjFMx5EDxSNQ+YW7a4yK/V690o/cBi/l6XF3L1wNnN?=
 =?us-ascii?Q?eWuwbw6JqbbaSyZVErBo8QfWRYCY2MLiaAQwQmXZWZ6938EjiQEg3GQP4sO+?=
 =?us-ascii?Q?UgZXsVme73KtPkn47zKXacRGe8FcR6f0GlC6GDjz5e3R+MbSYobMaYfc/vEG?=
 =?us-ascii?Q?axPPl7TpVp/eGRB7RA212P5BIn0uyhxJu49jBmULdiguQj4Ij3hUrY2V15PT?=
 =?us-ascii?Q?9Q54p3dNbqmcjnIIaOz/2MaFvsvcg9Xa6i2Owk9fbiBBEMb1q8am7Oq3OuQN?=
 =?us-ascii?Q?MIWkjfAeecqrcLwNuz8N6z03FPZYXnU4g3y1fDHoczyc95JWqGs5FPinjh9o?=
 =?us-ascii?Q?chHNqDvw8Od1bAZPdPT1xyaytGcihUIHUxD2HO3ch8taSiFIKPUTssLIBN0g?=
 =?us-ascii?Q?CtNOjZoINiNY4orNZY9zuvLEHnLvQp4DoIyvl2QpomiF3hl13C0fqHnB+OmR?=
 =?us-ascii?Q?CqBM+m12wYY5yLbfCOUAVUAYyECkEqb33O8Y+MrMvGlXowBCqrPeShTGvElx?=
 =?us-ascii?Q?g51BsasHf1j8ZKFJfPuY/kp86yEM6kCMN413t2QM1NISSQ3FJ/Hri1l3610M?=
 =?us-ascii?Q?xP5Jfkx/d9GHfseTO5T2Hb6Yr0qEOzj06mDLAVcvI3epiQ53eqMFzQBpNVOo?=
 =?us-ascii?Q?S5kn2+OyYqS1mFNxl9BdM8UNYwdSxSrK0D4/6CgY6oUmE7PoXXrdfcsJUMED?=
 =?us-ascii?Q?uygCXl++ujhNtsvIpAikKwldIi/RvsqFwYd03Dp9ChZWSpXVvplw2tWeplEv?=
 =?us-ascii?Q?OQHMTpbKKOqDDtAdhRDyqSPdos3cvJwSb/jzg7SzXNQOIAIxqYRFZNstkXSX?=
 =?us-ascii?Q?ExnOKXJELT39ABCbzUYDdgbstHfi5Uc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f858ca19-3177-4a8c-f4f1-08de456a132a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:05:02.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK6vqbV3iZwesQCP3Fotew1YP8VvA5/GhmNvm9ibZoevCFr/wv61EF9kKk+u+o4bS4LMAdlzoZh004777EP/Nn03wTuUZQjVHn5ZUjoWTsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

The encfh_buf contains two NFS4_FHSIZE buffers, used interchangeably as
source or destination during filehandle encryption.  It also holds a
reusable skcipher_request.

Assign a pointer to this buffer into filehandles when calling fh_init().
Once allocated, nfsd can access the per-knfsd encfh_buf via the filehandle
itself.

Note - there's probably another approach: rather than assigning the buffer
pointer during fh_init(), it is probably just as easy to plumb ths svc_rqst
into the call paths for filehandle encryption/decryption.  I will probably
refactor this work in that direction.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/export.c           |  2 +-
 fs/nfsd/localio.c          |  2 +-
 fs/nfsd/lockd.c            |  2 +-
 fs/nfsd/nfs3proc.c         | 10 +++++-----
 fs/nfsd/nfs3xdr.c          |  4 ++--
 fs/nfsd/nfs4proc.c         | 10 +++++-----
 fs/nfsd/nfs4xdr.c          |  2 +-
 fs/nfsd/nfsfh.h            | 12 +++++++++++-
 fs/nfsd/nfsproc.c          |  8 ++++----
 include/linux/sunrpc/svc.h |  3 +++
 10 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9d55512d0cc9..5a53e1af88d2 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1050,7 +1050,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 	/*
 	 * fh must be initialized before calling fh_compose
 	 */
-	fh_init(&fh, maxsize);
+	fh_init(&fh, maxsize, NULL);
 	if (fh_compose(&fh, exp, path.dentry, NULL))
 		err = -EINVAL;
 	else
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index be710d809a3b..6e1a0e5e96c4 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -68,7 +68,7 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		return localio;
 
 	/* nfs_fh -> svc_fh */
-	fh_init(&fh, NFS4_FHSIZE);
+	fh_init(&fh, NFS4_FHSIZE, NULL);
 	fh.fh_handle.fh_size = nfs_fh->size;
 	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
 
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index c774ce9aa296..e6f1c4be5cdb 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -33,7 +33,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	struct svc_fh	fh;
 
 	/* must initialize before using! but maxsize doesn't matter */
-	fh_init(&fh,0);
+	fh_init(&fh, 0, NULL);
 	fh.fh_handle.fh_size = f->size;
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export = NULL;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..3cdeb9e1bb20 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -123,7 +123,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 				argp->name);
 
 	fh_copy(&resp->dirfh, &argp->fh);
-	fh_init(&resp->fh, NFS3_FHSIZE);
+	fh_init(&resp->fh, NFS3_FHSIZE, rqstp);
 
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
@@ -378,7 +378,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	svc_fh *dirfhp, *newfhp;
 
 	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
-	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
+	newfhp = fh_init(&resp->fh, NFS3_FHSIZE, rqstp);
 
 	resp->status = nfsd3_create_file(rqstp, dirfhp, newfhp, argp);
 	resp->status = nfsd3_map_status(resp->status);
@@ -399,7 +399,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
-	fh_init(&resp->fh, NFS3_FHSIZE);
+	fh_init(&resp->fh, NFS3_FHSIZE, rqstp);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
 	resp->status = nfsd3_map_status(resp->status);
@@ -433,7 +433,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 	}
 
 	fh_copy(&resp->dirfh, &argp->ffh);
-	fh_init(&resp->fh, NFS3_FHSIZE);
+	fh_init(&resp->fh, NFS3_FHSIZE, rqstp);
 	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
 				    argp->flen, argp->tname, &attrs, &resp->fh);
 	kfree(argp->tname);
@@ -457,7 +457,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	dev_t	rdev = 0;
 
 	fh_copy(&resp->dirfh, &argp->fh);
-	fh_init(&resp->fh, NFS3_FHSIZE);
+	fh_init(&resp->fh, NFS3_FHSIZE, rqstp);
 
 	if (argp->ftype == NF3CHR || argp->ftype == NF3BLK) {
 		rdev = MKDEV(argp->major, argp->minor);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ef4971d71ac4..854ee536e338 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -90,7 +90,7 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 	p = xdr_inline_decode(xdr, size);
 	if (!p)
 		return false;
-	fh_init(fhp, NFS3_FHSIZE);
+	fh_init(fhp, NFS3_FHSIZE, ARGSTRM_RQST(xdr));
 	fhp->fh_handle.fh_size = size;
 	memcpy(&fhp->fh_handle.fh_raw, p, size);
 
@@ -1111,7 +1111,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *resp, const char *name,
 	bool result;
 
 	result = false;
-	fh_init(fhp, NFS3_FHSIZE);
+	fh_init(fhp, NFS3_FHSIZE, resp->rqstp);
 	if (compose_entry_fh(resp, fhp, name, namlen, ino) != nfs_ok)
 		goto out_noattrs;
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b74800917583..18526542b542 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -425,7 +425,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	*resfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
 	if (!*resfh)
 		return nfserr_jukebox;
-	fh_init(*resfh, NFS4_FHSIZE);
+	fh_init(*resfh, NFS4_FHSIZE, rqstp);
 	open->op_truncate = false;
 
 	if (open->op_create) {
@@ -785,7 +785,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	dev_t rdev;
 
-	fh_init(&resfh, NFS4_FHSIZE);
+	fh_init(&resfh, NFS4_FHSIZE, rqstp);
 
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
 	if (status)
@@ -910,7 +910,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	struct svc_fh tmp_fh;
 	__be32 ret;
 
-	fh_init(&tmp_fh, NFS4_FHSIZE);
+	fh_init(&tmp_fh, NFS4_FHSIZE, rqstp);
 	ret = exp_pseudoroot(rqstp, &tmp_fh);
 	if (ret)
 		return ret;
@@ -2883,8 +2883,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	resp->tag = args->tag;
 	resp->rqstp = rqstp;
 	cstate->minorversion = args->minorversion;
-	fh_init(current_fh, NFS4_FHSIZE);
-	fh_init(save_fh, NFS4_FHSIZE);
+	fh_init(current_fh, NFS4_FHSIZE, rqstp);
+	fh_init(save_fh, NFS4_FHSIZE, rqstp);
 	/*
 	 * Don't use the deferral mechanism for NFSv4; compounds make it
 	 * too hard to avoid non-idempotency problems.
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 30ce5851fe4c..a45ab840ecd4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3675,7 +3675,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		status = nfserr_jukebox;
 		if (!tempfh)
 			goto out;
-		fh_init(tempfh, NFS4_FHSIZE);
+		fh_init(tempfh, NFS4_FHSIZE, rqstp);
 		status = fh_compose(tempfh, exp, dentry, NULL);
 		if (status)
 			goto out;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..f29bb09af242 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -13,6 +13,7 @@
 #include <linux/iversion.h>
 #include <linux/exportfs.h>
 #include <linux/nfs4.h>
+#include <crypto/skcipher.h>
 
 #include "export.h"
 
@@ -74,6 +75,13 @@ static inline ino_t u32_to_ino_t(__u32 uino)
 	return (ino_t) uino;
 }
 
+/* filehandle crypto buckets allocated per-knfsd */
+struct encfh_buf {
+	u8 a_buf[NFS4_FHSIZE];
+	u8 b_buf[NFS4_FHSIZE];
+	struct skcipher_request req;
+};
+
 /*
  * This is the internal representation of an NFS handle used in knfsd.
  * pre_mtime/post_version will be used to support wcc_attr's in NFSv3.
@@ -83,6 +91,7 @@ typedef struct svc_fh {
 	int			fh_maxsize;	/* max size for fh_handle */
 	struct dentry *		fh_dentry;	/* validated dentry */
 	struct svc_export *	fh_export;	/* export pointer */
+	struct svc_rqst	*	fh_rqstp;	/* access per-knfsd buffer for encfh_buf */
 
 	bool			fh_want_write;	/* remount protection taken */
 	bool			fh_no_wcc;	/* no wcc data needed */
@@ -244,10 +253,11 @@ fh_copy_shallow(struct knfsd_fh *dst, const struct knfsd_fh *src)
 }
 
 static __inline__ struct svc_fh *
-fh_init(struct svc_fh *fhp, int maxsize)
+fh_init(struct svc_fh *fhp, int maxsize, struct svc_rqst *rqstp)
 {
 	memset(fhp, 0, sizeof(*fhp));
 	fhp->fh_maxsize = maxsize;
+	fhp->fh_rqstp = rqstp;
 	return fhp;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 481e789a7697..83e1bb2a9a7e 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -162,7 +162,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 	dprintk("nfsd: LOOKUP   %s %.*s\n",
 		SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
-	fh_init(&resp->fh, NFS_FHSIZE);
+	fh_init(&resp->fh, NFS_FHSIZE, rqstp);
 	resp->status = nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
 				   &resp->fh);
 	fh_put(&argp->fh);
@@ -312,7 +312,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		resp->status = nfserrno(PTR_ERR(dchild));
 		goto out_write;
 	}
-	fh_init(newfhp, NFS_FHSIZE);
+	fh_init(newfhp, NFS_FHSIZE, rqstp);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
@@ -502,7 +502,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	fh_init(&newfh, NFS_FHSIZE);
+	fh_init(&newfh, NFS_FHSIZE, rqstp);
 	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
 				    argp->tname, &attrs, &newfh);
 
@@ -533,7 +533,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 	}
 
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
-	fh_init(&resp->fh, NFS_FHSIZE);
+	fh_init(&resp->fh, NFS_FHSIZE, rqstp);
 	resp->status = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
 	fh_put(&argp->fh);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 479a52a755af..109840dda93c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -264,6 +264,9 @@ enum {
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
+#define ARGSTRM_RQST(xdr_stream) (container_of(xdr_stream, struct svc_rqst, rq_arg_stream))
+#define RESSTRM_RQST(xdr_stream) (container_of(xdr_stream, struct svc_rqst, rq_res_stream))
+
 /*
  * Rigorous type checking on sockaddr type conversions
  */
-- 
2.50.1


