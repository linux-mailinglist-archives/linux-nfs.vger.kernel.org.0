Return-Path: <linux-nfs+bounces-8076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A77A9D1A75
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F1A1F22215
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495161C1F1F;
	Mon, 18 Nov 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw+ZlJyk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C801C1AD0;
	Mon, 18 Nov 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964849; cv=none; b=bjiAmIX7SAOoxCC0ntPXsUH8UNcWjlSW30EUhVm91atOu35wQfL0MhSOLACIDDbPUzXS1WfKrmnbxhTws7mg3FCeGQMddn2TDUCmHGiIPzQEpeNo2rJxoGmJQmzLVCXuhW7/eg7lE2cFFRL2NGQlDXB4Cgn8WFXb044KOnn2ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964849; c=relaxed/simple;
	bh=wKem2yUs0AoriM8D++AZ/JkvgHvFjBKZX/gEJHMq4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBr7RmRzJZp+3Wio6zXyJJVwveCFRwlRsBs/ICAfwqbl/IiBFfuk52G9HJvJu/HF6lbqPZpeLYJIWHejF9LUDeaB0sAOuMJ6spBT4duzUG1ttlFnBXG7tCof/bbEDKat+ZAI+yGqkVZZhAysj1ihmUUXMBmCqNNerJjOklYtWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw+ZlJyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924B3C4CED6;
	Mon, 18 Nov 2024 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964849;
	bh=wKem2yUs0AoriM8D++AZ/JkvgHvFjBKZX/gEJHMq4zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sw+ZlJykL1wf6p2+QkyD5wfwJ2Sr8UuVx1JN3iGc/MHxyf6DDCRPBfkD7IRxjKDAK
	 qj7JgAe47ayoetravbTVlYAIO27+AWFvkTi8ffiRHzbIgNwFsKfFIyb/AQCedhAb6K
	 20kuv9s/BkXDYco2gasY6/UWTfMBYRswcr8FPLw5Awsn+VWnwCZlQSQhK48euIlee4
	 gXGTXZwkhtDhvfKZeRvCJxRZ+GNvUn12vUS3Pay5QXJSQa2XsjceaOLOTdgLaxRvFy
	 rRWIsIG+lLJSHHkZGToCSsLqKXd1ZQY2H4+2AOKyPouA84T9fiEH34W/jhaTsv0jym
	 ekGX6OCX4zX/g==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 5.15.y 10/18] nfsd: stop setting ->pg_stats for unused stats
Date: Mon, 18 Nov 2024 16:20:27 -0500
Message-ID: <20241118212035.3848-16-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
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


