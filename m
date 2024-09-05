Return-Path: <linux-nfs+bounces-6269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2DE96E2D0
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7D8B25BD2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58918FDBB;
	Thu,  5 Sep 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KobVZP3S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994618FC92
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563427; cv=none; b=aTVeduMY2haGs2gHYjMFfZzUFLPGfrTTEUH0cI2M+wdTdIKYrvNVKb0sXXxsm9zmA2WeVG2ylWUGtXQCmQ4RTkGqWIe63tR0zRptajPBVrhvVlnR7j3eGmDfmkP/im58xVOmrrkKO7f2MJhY7a+GQASjUaHuNtGqpoMgrub8H7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563427; c=relaxed/simple;
	bh=LA7D+XOiklPnq57sHCti3uXZmp8Q0wMRkn8X3Mkwo7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1nzuYaFvGju3/vWnDrgp0H8KV9/PGsy8utppxju1NX5ROeKL114Ury03sTSN169DimwXaPLncR1mjMmZIrGLfugsVUy7rjAJoXTSmW4rySsfmMieTpbcW4QWCT4PNceP/2pry+e6N/e4koswCKL9ROdphZTRIyXZ1Y0ctme6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KobVZP3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A8C4CEC3;
	Thu,  5 Sep 2024 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563426;
	bh=LA7D+XOiklPnq57sHCti3uXZmp8Q0wMRkn8X3Mkwo7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KobVZP3SlqvRu0oBPRdUVdTxgKTJaQOCPwSLWUOqPhSzfFCW6y7Sc0D9cOtgJ5ln+
	 NxZTEzO/0spr8ieL2G1ipJRiSmqWxDqEwJklgDo3L/UuKzHF4qAE5FU+hismlZwR/V
	 iPfVYN+afOFJ6+a8NBSKat0VrrfU+mftopRz/bX5Tqnsjftu35SeLUAH1ZIwAbDwhI
	 Fk8c1u3ucXoLL2ArEFbhLAdjZUlQ623r10a3z4mwBIsYapERH/rLH2X8R4FGO1nEzt
	 F37qGAldjWrJJCoi3vR6VdFPg0NbdBUF+ErCga2sYL4gaY173dXN+9QThMN4onTozw
	 +61gB1f2tlP3Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 10/26] nfsd: add nfsd_serv_try_get and nfsd_serv_put
Date: Thu,  5 Sep 2024 15:09:44 -0400
Message-ID: <20240905191011.41650-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
caller of nfsd_serv_try_get releases their reference using nfsd_serv_put.

A percpu_ref is used to implement the interlock between
nfsd_destroy_serv and any caller of nfsd_serv_try_get.

This interlock is needed to properly wait for the completion of client
initiated localio calls to nfsd (that are _not_ in the context of nfsd).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h  |  8 +++++++-
 fs/nfsd/nfssvc.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 238fc4e56e53..1b9da8f183e3 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
 
@@ -139,7 +140,9 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
-
+	struct percpu_ref nfsd_serv_ref;
+	struct completion nfsd_serv_confirm_done;
+	struct completion nfsd_serv_free_done;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -221,6 +224,9 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern unsigned int nfsd_net_id;
 
+bool nfsd_serv_try_get(struct net *net);
+void nfsd_serv_put(struct net *net);
+
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
 void nfsd_reset_write_verifier(struct nfsd_net *nn);
 #endif /* __NFSD_NETNS_H__ */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index defc430f912f..307e365798f5 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -193,6 +193,34 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
+bool nfsd_serv_try_get(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	return (nn && percpu_ref_tryget_live(&nn->nfsd_serv_ref));
+}
+
+void nfsd_serv_put(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	percpu_ref_put(&nn->nfsd_serv_ref);
+}
+
+static void nfsd_serv_done(struct percpu_ref *ref)
+{
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+
+	complete(&nn->nfsd_serv_confirm_done);
+}
+
+static void nfsd_serv_free(struct percpu_ref *ref)
+{
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+
+	complete(&nn->nfsd_serv_free_done);
+}
+
 /*
  * Maximum number of nfsd processes
  */
@@ -392,6 +420,7 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+	percpu_ref_exit(&nn->nfsd_serv_ref);
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -471,6 +500,13 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
+	lockdep_assert_held(&nfsd_mutex);
+
+	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
+	wait_for_completion(&nn->nfsd_serv_confirm_done);
+	wait_for_completion(&nn->nfsd_serv_free_done);
+	/* percpu_ref_exit is called in nfsd_shutdown_net */
+
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
 	spin_unlock(&nfsd_notifier_lock);
@@ -595,6 +631,13 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
+	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
+				0, GFP_KERNEL);
+	if (error)
+		return error;
+	init_completion(&nn->nfsd_serv_free_done);
+	init_completion(&nn->nfsd_serv_confirm_done);
+
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-- 
2.44.0


