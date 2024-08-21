Return-Path: <linux-nfs+bounces-5512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBD95A0A4
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB912874B8
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D71B2528;
	Wed, 21 Aug 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNl45btV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB21D12EB;
	Wed, 21 Aug 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252205; cv=none; b=ZrI3CmerTiN9ZYc6OgS8Eb1/ancJYfYQ7l+2DELoRTg/K+QKuX36syeZnASz0rcJZf/Oenk22wWUaHwGyi6dre+yPalV+9dtLQaHS3jZdAv970dEk5HV67+oieSC8Bnyap0kgY24vSSKmjLGQ7g8R6dWfhxlOX1835Zlk2LVjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252205; c=relaxed/simple;
	bh=wKem2yUs0AoriM8D++AZ/JkvgHvFjBKZX/gEJHMq4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbHiD//4Suewz6EJRH0Hl3sV2lhe8XTztU1j0TA9z9p+fzdqPf35NSu0T1OcGWpCG2w72sGML6GKIt7zliVE1uYkBVONKNakhpmp5o4eYHWtGaZ07IjkBTWxSckUQucMSNjVDwwGgjReuM/BcSXI2/fYjmxhsLn3ZWZcZU1CEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNl45btV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E59FC32781;
	Wed, 21 Aug 2024 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252204;
	bh=wKem2yUs0AoriM8D++AZ/JkvgHvFjBKZX/gEJHMq4zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNl45btVv+buq+2whBCVZgHHOuc6v025ZgEMQqafhRJ1ukdDAEyWOLSJS8WoKEUCQ
	 Z5Ax7+dq/jgzed5ngdhbR2FxE7RzZwfjMKCEV3VmJ86DdMu3xHkFsEyAVbo9KD5/6l
	 ym+2WCLQVAqLCJ38MHNocDx3yvdMQU9vujFu+wp66ciKHVLMJtqT7c7cgBFME/0IMv
	 uTjQkRT+IDCXSWORLnrZuwL+i1R1uiqqiMtgnH+ajqn/gwttfxkKe6Iy2Frloqgqpd
	 ZRXo85Bk6R2aHmGpgzYdd+o89C+Jk1tfA1rOsOUFTdP1f9NZZdHE2nCTSo4sN+/z4a
	 WWpsAc6bKU2Qw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 10/18] nfsd: stop setting ->pg_stats for unused stats
Date: Wed, 21 Aug 2024 10:55:40 -0400
Message-ID: <20240821145548.25700-11-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
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
index 8fe143cad4a2..f00fff3633f6 100644
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
index a68e9904224a..8f1c8cbd1101 100644
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
2.45.2


