Return-Path: <linux-nfs+bounces-17325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FACDFFFA
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F6DD3012949
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E23126C8;
	Sat, 27 Dec 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cdhGKGsN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020092.outbound.protection.outlook.com [52.101.193.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBE3168F1
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855110; cv=fail; b=AkB1i5SXCZICM6QQmTnmbLQUQVk/IgQnW5GqaDpzXM8x3GdeSuYsa4mGOlFUriNkMQfgo2nOeMidQ94wiOiCkqfySn72fp5aNkxXWByDTE8Rn++KnUeh6/jm10g8yiP08wLSOqyu9c8tQxEB+n8W0tR5vIWfJFvR6bJFfWmOfSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855110; c=relaxed/simple;
	bh=foutVDuj9HK1aTdP6oLD4KKhOwnRzwgPIIoV51KhpQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HBIMhkeSVsBoTUg9XIXsPhFg1C3dJLpD1XdUziXgwQkroNejBmsULnV06gqQwOz1srOIuDX2Kb2vUUh9tRtg6i9TCxMFcXkeMocWRutPwpjQ8ONHnMO1PGidKY3M/ZirODutQDd5I9glPTyXcjHWlCvLxAXsZqGtg4bCX0JcTEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cdhGKGsN; arc=fail smtp.client-ip=52.101.193.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2cyPR0g+tzMlUV3Jj+Ze+nJPE/XgA9sZSwgnwezHPP817GvFn5kVlX2QaXl6ffAFoWI3s964rzxyxE1lvAWgtEdJ+ogo1N9QCx4gJqzSgLMAS+YzYa1IIunFZgzU7BJSbXPpjCB/WGIoTazxXjuMHnj98aAoq1Gb/QXL9UZ33Kt+fo0OC/NyQcNm8f4cJZ2KrElEqDKvFnc7fb8qyt6VZZptIUo2IymiJLv8fpdEAXd5jWNtNgI28X62S8sFJ7mEXOSrq8tHe2QD+CMdXZDqd7w2cAGCXY3u1PgRBacZivt+XAnIx3CnLfEAM5+dv19ACf0VjGA4cXw657pHQbTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc2ajM8gonvs/dzz+LdmwoHs1kIJ1u7SQaG3P4BuDFI=;
 b=MYyvP+XmJJsiWDXpAcAksGxXecnmSkG0eA1BgD/mApIoq1DEa1l6OESAE7mXHhLiQOIYWqXV/xsqm37hFJTdxYLpv6dyGz+jjwumwWKW5DvG3P61ulPiyrIXOk1RBhDDqW+SyNxZL0Y/Eh26BmOuAuklaYmpCxmwj3A/JD4+gpWvcSwI17MGiSIZac881oi8tvrD3ilCgaM1xzDSPH0iG+uxIpHTsYfB2s6Za4fIShSWcWYUBNXVukCFBynkggbhXjwW4e8Ty1x9ZsOJcRieL1ViMG49Udmprk6eMtEFJWukvJDe+47vQ6mkb8x7wp6qFE5U+OKP37mDWCkd6ofM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc2ajM8gonvs/dzz+LdmwoHs1kIJ1u7SQaG3P4BuDFI=;
 b=cdhGKGsNKkf9wiepWAqi/zPcNUBwf1xLuDAIMJ0byXvdNVIrnas56x0xQYcYD3sulHZW/iYcdI3lMVDnkHOwzwhYSzyEcRm7/z3uqqCtJLU7phViWR1dLzBW0FAhOgtBKYWErAxvLf98sJ+a+Znmmt/IgPKzWp0Q+0wc2b3lE6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:05:01 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:05:01 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 3/7] nfsd/sunrpc: add per-thread crypto context pointer
Date: Sat, 27 Dec 2025 12:04:51 -0500
Message-ID: <531eb4d2ba409f85599ac74369d2788634b7bfb9.1766848778.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75a36340-2b67-42d9-5d1c-08de456a127b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKZMZIC34m4zpsDhIYBUIdzNYdSe/2FhXJFgExb+wgcCbv4rka7PE9Xba0Cs?=
 =?us-ascii?Q?3bxLQURErpMwvyivmqYC7/cfsOzngzmWUkixk79/Mz+dYVyZPiSGoxO9Oa9u?=
 =?us-ascii?Q?pD+5y1VWf0hvPG9UpWCjmDmnG3YidAvxHMr4Oi8OoH8fkFTMIzWPlz5Cutyy?=
 =?us-ascii?Q?T+KoM0eehip0pamVwrsauYRSDE9BYWBFiIT2S8PqnkMKyk/NXp3VhWi+KKZX?=
 =?us-ascii?Q?hPezFt5BAijfWtyqmDJSczCCmoEG44qqJR0UniMNS9bWtGajyywmZ5abQddD?=
 =?us-ascii?Q?oKc55W7mrlGZUtXYFupzbgfHW6glHPteuxbBD0mSmnKQzk097KAYMVEm7sTP?=
 =?us-ascii?Q?V/JyoWj8y/XLtKhZqScCx4WifQ7CGaIxNeUplwXuwAyhIUWaY1v+cIh4mC4R?=
 =?us-ascii?Q?JwygJIbWzIOaW0zYHJI2wM9b8Ic10zC4z5a8f+EbstbvYcVgOZCpXVpRr2fq?=
 =?us-ascii?Q?jeMtRht0GAvelE3QSobuRrIf08GdehS21qeTHnj1ZyiEJFie53ax3+7k4Uy7?=
 =?us-ascii?Q?aSKuhsKIVWD6hHmwwQM5m4Kq1eLwXmLionhvRCyP0e78QR2mBJXtNQ2gvmIA?=
 =?us-ascii?Q?SHD2k2gMWs1WvQ9RmN4NB/NPvPfljSFkws31Mg4NoQhdvM7yCey4gVE4vxK/?=
 =?us-ascii?Q?ovUFx+Hb9iS71ZVQLfBdutBm0VP6uQDS0ZMQ+OhGe0qpbngb+j6u2yzM+hq4?=
 =?us-ascii?Q?q5oto19AM0ELR7Dr7/HpRuJodljTNAaNXsQ+v92iWGmk4WjVVfN88Sj6fXMY?=
 =?us-ascii?Q?d/m92XARTPUxSKMGQK4pDXIFYwzgB0bBIzpbBRsSmGGIFYgEODD6nxdbLLl5?=
 =?us-ascii?Q?y174lMv+mgjneP6qfjhU48BcPmn3iVNVAOuvUMnEn2+243lclvkNhF5yVXB/?=
 =?us-ascii?Q?IUmG+jT2V0ZdAsXivAWtsX/RSUPP+/wvUIjSZnmjSVIxSZoVmVkG86bbgfY8?=
 =?us-ascii?Q?03pyVs+X1pKRBQJkg+N9oUFScnTF1uySOodGZs4VD4b3mafbzu+mGlSRE8PH?=
 =?us-ascii?Q?QCdEC8j0zCW9h4rVR8Gl73WJnavmLp5dC/rOK4szygY+2G41FiX1avoTWFCw?=
 =?us-ascii?Q?1+PgiVbqdaWaXOCGFdQh6r5SMewhl+qbVPI+yZMjQbZakL8bw0fs1A+LLmqU?=
 =?us-ascii?Q?ak70KYwnoWome9M3JkKCe2XsIRjWs82qBknkocJNqG3ZxuWK3x+gFnW3mZHh?=
 =?us-ascii?Q?Qb9u498ok3nQKBgcQMy87KWhjKNugXhbkTITjH9NLbxGeYSXB1DR71H3xvfx?=
 =?us-ascii?Q?4em8BHVPkMvDpmmhOxYqS8Tf90sz+l2qZ25lxfeRoyNhHaoHWRBW3WqmxXcg?=
 =?us-ascii?Q?1Ma4wWSXwyBoS1ry++EezCsvjPvtV/4hZNmRiSIN4hpZqjbUkQAIN7GQ1TZe?=
 =?us-ascii?Q?eLoVHY/0k6c9QbGifFekuHppnxIBLlFT8rV7p9qkBAVMoEWNeQKpsuhaL9Go?=
 =?us-ascii?Q?Uc57VIs+/xzjYOqblCit572pEcX+c5Il?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+qCVQhFZt+p5Hg4KBycwRAGhedYUS7Jdn/q/lNZPHwfXzyXYIQ9JFVHwUjp?=
 =?us-ascii?Q?NuHHEOMDWGX/ntK5ql2E0NTOCWPlxwxXZ6km1NKr4SXOLp2DgGL/wS8TnsDX?=
 =?us-ascii?Q?8Tvz5Ujotaah3m9h0n8RDOjLAHRhwfDDGtUi8/e1qBK1i/yUZYlNrh7cDoWg?=
 =?us-ascii?Q?2g1kqDpXckR1eylsGYsdZlU8u5SLbGjjyE9OD9VdwuxdVfdxVIaZiRnBasSp?=
 =?us-ascii?Q?SCO6of26A7zPu6JDYxZCIjhGcvE8MoGg4hNQ65W9L16E3vIk7gLRMQuIqJmm?=
 =?us-ascii?Q?QBmw4ZENSGAZn6FhlTA1qqvAzeamvd0x5DbtHt2DxHtkwFbUJM8t1GH2Jaoh?=
 =?us-ascii?Q?eMdx7JHIghnV0DJoapYy/yMCa8WFYblTjntDrpFLafV+2T27/OVB+Yn3NPCh?=
 =?us-ascii?Q?MyZFavuMktQ8hEo9rVCAFR2U3CUOlsqA3sUNaR229obIn4cTQ/MG3se80udF?=
 =?us-ascii?Q?mTiALn+BTdtPCDyZSX8LUfY9qb2Z02UPurzSL9iDV7X2ahAE1tL35bxzAQ2n?=
 =?us-ascii?Q?rjFe5L2kylBTRzDJwJFdfP7lCnejFk8a+AVMfULieGqQ9+uvc/NbpIwQl7s7?=
 =?us-ascii?Q?A5n3ywJG/YmIauLUwIuNvrLv/5wKGJ4XKvlfMNub2XSIBTtkNQbgRwuo4v2O?=
 =?us-ascii?Q?0za+dk0HisoKVyFGRc5iND5ZipGCxO9yNcSSBYk/Z+9yHxWQaQeeF+vDdcWU?=
 =?us-ascii?Q?rI3IhXzhX9dTzc0sqSd43PwS8wk6hWAK9wQKsSSlajIvcWd7BwEBvNKKTqsh?=
 =?us-ascii?Q?ZL7Nr1GXFqkpMD02BN2KIc/0d2QKcwWhg6RalVPvEXxd/Ra1EulEyy7L3Dq+?=
 =?us-ascii?Q?JXvwvoTXwSRbUBAIfqlvrSXkCoobpisN5KUeQCMdIHCq1GDt8silDbPY8TL2?=
 =?us-ascii?Q?vZO2QF+NrNnYoO4s49JEeeHmoVL8LAsrl2ur+FCTfzMDt8pGs8A78/ORSgZS?=
 =?us-ascii?Q?bAYEuel8qZJETmCHl5CwQmdu4xGAIb7g06UXMTLNbHjzR3Oddx9yWIOzG3ji?=
 =?us-ascii?Q?ljVVQVxkpPcetq7BoFGnPXrd7AkTTve3O2w5wFNKqFj9OFo/BUHL/aeYbU9Q?=
 =?us-ascii?Q?kYX76+bFXHpJvpaK6pzF/y9FyG9FvGFPl+koy4imd8ap3JdGejKWK7ppQn4W?=
 =?us-ascii?Q?i9yoH17DuwUGjRsXXtApMUlSm0ZoJXpx5+p2XRdkC/BlG3rj7NTF8afWqyJ8?=
 =?us-ascii?Q?73e8mlQ7H3QQ58gDT5SVLhQsk3551sAnQpGKrvPMJ7ot9go4Ds46wEAa3ci2?=
 =?us-ascii?Q?LyJozI1eU2p9k4OSAn0D/3X2cwEeFAGRlbA54G+Ti9UyPn2+dWFw54G3pWrR?=
 =?us-ascii?Q?WBWsYmE8HBI2le0ZJA8gTs8yiKm7vlTMu5ZjvJ0khTzKybVb73+GU8IPt4d1?=
 =?us-ascii?Q?LlLOCopXOG9sSxdfcEFFvgbaS5/H6L+JFjkadHU0P2+fCEGTlCaEvXvBHxZb?=
 =?us-ascii?Q?OyQup4M2rkG1Cub5idv9C5ltWTDhFIXPAYLypHiAKtk3LsVXaJxbf2ffwnpR?=
 =?us-ascii?Q?HB9kD6ubNKVr6a6FrhnroRrgJshb9KME8lqynuEuG2uKFyO/dpM1yagUVL+2?=
 =?us-ascii?Q?DvKrqtcIbhRGTMe1xBga29ZbUb1xj4qcFjFA0sxzSGAG4QKKH6iXfSCt2PL2?=
 =?us-ascii?Q?usldYwRDViajxfy8hjMUzzRY4UhjUp1RuS9w+CQtKCaqVzmSOj9wKWwzcSVX?=
 =?us-ascii?Q?bd6icCWYflO3eQEppRsjs5+tJnNHd0r5HnDPe9Fop9ikBG2DrKl9rTJf4Erx?=
 =?us-ascii?Q?W0NxBWtOkWyol8h+wFkDW+n+8WTAIqI=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a36340-2b67-42d9-5d1c-08de456a127b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:05:01.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIF5dsCM1+E9ELyYr1921R/47LYRemMxPrdvLKqbXiJAn6W4e4WrACgLlHjIW1UzluT/SgwrrOTOV4TxygBKTQc2aOxGMYhKjaPPHlkECfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

Move rq_err up to fill a 4-byte hole (arm64), and add a pointer to store
per-thread encryption objects for encrypting filehandles.  This allows nfsd
to only perform the memory allocations and skcipher request setup once
per-knfsd thread rather than using stack memory or doing multiple
allocations for every encrypt/decrypt cycle.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 include/linux/sunrpc/svc.h | 9 +++++----
 net/sunrpc/svc.c           | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5506d20857c3..479a52a755af 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -228,6 +228,10 @@ struct svc_rqst {
 	int			rq_reserved;	/* space on socket outq
 						 * reserved for this request
 						 */
+	int			rq_err;		/* Thread sets this to inidicate
+						 * initialisation success.
+						 */
+
 	ktime_t			rq_stime;	/* start time */
 
 	struct cache_req	rq_chandle;	/* handle passed to caches for 
@@ -241,14 +245,11 @@ struct svc_rqst {
 						 * net namespace
 						 */
 
-	int			rq_err;		/* Thread sets this to inidicate
-						 * initialisation success.
-						 */
-
 	unsigned long		bc_to_initval;
 	unsigned int		bc_to_retries;
 	unsigned int		rq_status_counter; /* RPC processing counter */
 	void			**rq_lease_breaker; /* The v4 client breaking a lease */
+	void *			rq_crypto; /* handle for per-thread cryptography context */
 };
 
 /* bits for rq_flags */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4704dce7284e..eade597c9aae 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -674,6 +674,7 @@ svc_rqst_free(struct svc_rqst *rqstp)
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
+	kfree(rqstp->rq_crypto);
 	kfree_rcu(rqstp, rq_rcu_head);
 }
 
-- 
2.50.1


