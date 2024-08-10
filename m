Return-Path: <linux-nfs+bounces-5290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B570594DE67
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1252B21B6E
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1E1311A3;
	Sat, 10 Aug 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiAqZbSX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B29125BA;
	Sat, 10 Aug 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320067; cv=none; b=MB802JsJamSAsIaQwbdHbFUbRZPHXkfPz5Rd1B5wGgHaSrm/mfYiPIMTUH1tMWkzYHXX7O1FLJNXkNpi3AftPU92ZxNxcfpun8pJOCfwzfVWtA+/Q5HQJsQfrvCRPxvCXGvllghBmwtorS0b7MYxYicgTLwXQVmWXm6Jysm0CeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320067; c=relaxed/simple;
	bh=PFewNhQnZnXKm9Uk0EgVe+M22AM5wLpxzYx2pA/xbLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ5OUU95aD1ZrLvlTez4QtD440E2af2lDYojdnvoY66xx/6CBgzPuBe4m9zcC846UPGAS5Ry+RqPVJxnBpECJ+AlhySEAX1fj4QE3g2A7H0Aw278iW4xbbwOVZBA/vSC79zuon6POlxq23+bjAbb5lFob3g5j94A1Hx5uiRSBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiAqZbSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BC3C32781;
	Sat, 10 Aug 2024 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320067;
	bh=PFewNhQnZnXKm9Uk0EgVe+M22AM5wLpxzYx2pA/xbLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiAqZbSX9AYgbbI8irjg+cJVV2As8YXa2xAHZxrAhu8cdzvpF3RGJk3CYpXnESwJp
	 WmxIUC4ok7wv9JOvGslBlH2wKfBKQJqtMUjfAcW5NFOdAC+q/tu1aKsNCHyS577/2s
	 2rBBsYXWgOUymfh+2HnoEK2ZVpLp0NpXLfE8aA93zeuYk0FU5UJAE9P4+9BpPka45s
	 BUQYaN5A3GKt7n230SuHafIcxMujsxk9a3SJ4zGSKWTuV2jttJryGWDnwY8h/Vswta
	 j40FY00TYVaLQVp2C3NTESpCIvNTHLrnfBCuosNoZL6JAcUXLl2IBDMdkAQQpw6qkV
	 Vx/FV5x19RgoA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 10/18] nfsd: stop setting ->pg_stats for unused stats
Date: Sat, 10 Aug 2024 16:00:01 -0400
Message-ID: <20240810200009.9882-11-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
index 5579e67da17d..c33f78513f00 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -759,8 +759,6 @@ static const struct svc_version *nlmsvc_version[] = {
 #endif
 };
 
-static struct svc_stat		nlmsvc_stats;
-
 #define NLM_NRVERS	ARRAY_SIZE(nlmsvc_version)
 static struct svc_program	nlmsvc_program = {
 	.pg_prog		= NLM_PROGRAM,		/* program number */
@@ -768,7 +766,6 @@ static struct svc_program	nlmsvc_program = {
 	.pg_vers		= nlmsvc_version,	/* version table */
 	.pg_name		= "lockd",		/* service name */
 	.pg_class		= "nfsd",		/* share authentication with nfsd */
-	.pg_stats		= &nlmsvc_stats,	/* stats table */
 	.pg_authenticate	= &lockd_authenticate,	/* export authentication */
 	.pg_init_request	= svc_generic_init_request,
 	.pg_rpcbind_set		= svc_generic_rpcbind_set,
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 46a0a2d6962e..e6445b556ce1 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -407,15 +407,12 @@ static const struct svc_version *nfs4_callback_version[] = {
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
index d07ee284100f..e1a07cfdab23 100644
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


