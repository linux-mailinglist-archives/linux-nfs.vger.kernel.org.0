Return-Path: <linux-nfs+bounces-5330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B4994F9A3
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE7CB20F30
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93A196D98;
	Mon, 12 Aug 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0me3M/h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428A15C12D;
	Mon, 12 Aug 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502211; cv=none; b=raDSYOs6CCEPJyyLjgfMiGrltnAzEZRMNcRmRNIyQHN5StR/BpU0rowyT/2/j0mW3zJzrM4xdtEJbJgd33mvP9/C6FCuSp1EBVGn4sW4CtxLYeamtbaK3emqsOMcO2nLdTuX4naBxIXEDtCMRAjeRYs7DnpuvcX85qqUVJyfCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502211; c=relaxed/simple;
	bh=G9Msut34DqAAazda0rdR5nN26BB3XPcxOexuyYlfea0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJBS/mGksjQFJbdu/ZulbQ9ws2v3Kfn8YMGEHySkILbF0rtbfKaEpXLRw8D9q7LWyE9mTLSzr5+Uug+Oehh2z/a/eYs9WqbtQn2zQPubyyYzflO/9XgXlYcvdiTmlV/JUGafxPMxq7PYfFOSJTWqo/tGDOFXOBab1myxTnE7Kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0me3M/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD0C4AF0D;
	Mon, 12 Aug 2024 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502211;
	bh=G9Msut34DqAAazda0rdR5nN26BB3XPcxOexuyYlfea0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0me3M/hgasgRwjiCnWF4AwP4j60T3fLnmrh4B+jaTboGcRyN2a57ZJ2/T+GG9b2w
	 aaK3pwvCsBUVKDmd1BgjnKoKQ8Hk+lLwxeH/qhgdEQb2dBc1M4m/9z1+YvQFF5e2u0
	 EMMzhokLUNW20XijKq4asSxnuyu+SQQcDmTkCBKZDRoJ/ZtcqCHwy5PkTmsmWw36zs
	 dxUXl7LxIdsTMELcvUYtrSZBFn4TNCz8fSzVIamZNa9FdnnKhT00BwU3CxCb85dUA6
	 t9Vva31clYs8mCibbQXTdKRbAz8YQ00incffVDHmZN9ez5wmPU6e9yu6K66qWax0pJ
	 F7pdjDH+PVbmg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 04/12] nfsd: stop setting ->pg_stats for unused stats
Date: Mon, 12 Aug 2024 18:35:56 -0400
Message-ID: <20240812223604.32592-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a2214ed588fb3c5b9824a21cff870482510372bb ]

A lot of places are setting a blank svc_stats in ->pg_stats and never
utilizing these stats.  Remove all of these extra structs as we're not
reporting these stats anywhere.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c    | 3 ---
 fs/nfs/callback.c | 3 ---
 fs/nfsd/nfssvc.c  | 5 -----
 3 files changed, 11 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 6579948070a4..a62331487ebf 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -712,8 +712,6 @@ static const struct svc_version *nlmsvc_version[] = {
 #endif
 };
 
-static struct svc_stat		nlmsvc_stats;
-
 #define NLM_NRVERS	ARRAY_SIZE(nlmsvc_version)
 static struct svc_program	nlmsvc_program = {
 	.pg_prog		= NLM_PROGRAM,		/* program number */
@@ -721,7 +719,6 @@ static struct svc_program	nlmsvc_program = {
 	.pg_vers		= nlmsvc_version,	/* version table */
 	.pg_name		= "lockd",		/* service name */
 	.pg_class		= "nfsd",		/* share authentication with nfsd */
-	.pg_stats		= &nlmsvc_stats,	/* stats table */
 	.pg_authenticate	= &lockd_authenticate,	/* export authentication */
 	.pg_init_request	= svc_generic_init_request,
 	.pg_rpcbind_set		= svc_generic_rpcbind_set,
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 466ebf1d41b2..869c88978899 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -399,15 +399,12 @@ static const struct svc_version *nfs4_callback_version[] = {
 	[4] = &nfs4_callback_version4,
 };
 
-static struct svc_stat nfs4_callback_stats;
-
 static struct svc_program nfs4_callback_program = {
 	.pg_prog = NFS4_CALLBACK,			/* RPC service number */
 	.pg_nvers = ARRAY_SIZE(nfs4_callback_version),	/* Number of entries */
 	.pg_vers = nfs4_callback_version,		/* version table */
 	.pg_name = "NFSv4 callback",			/* service name */
 	.pg_class = "nfs",				/* authentication class */
-	.pg_stats = &nfs4_callback_stats,
 	.pg_authenticate = nfs_callback_authenticate,
 	.pg_init_request = svc_generic_init_request,
 	.pg_rpcbind_set	= svc_generic_rpcbind_set,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7ef6af908faa..1c5bdcdcd239 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -89,7 +89,6 @@ unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-static struct svc_stat	nfsd_acl_svcstats;
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
 	[2] = &nfsd_acl_version2,
@@ -108,15 +107,11 @@ static struct svc_program	nfsd_acl_program = {
 	.pg_vers		= nfsd_acl_version,
 	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
-	.pg_stats		= &nfsd_acl_svcstats,
 	.pg_authenticate	= &svc_set_client,
 	.pg_init_request	= nfsd_acl_init_request,
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 };
 
-static struct svc_stat	nfsd_acl_svcstats = {
-	.program	= &nfsd_acl_program,
-};
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {
-- 
2.45.1


