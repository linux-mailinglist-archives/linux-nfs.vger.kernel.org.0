Return-Path: <linux-nfs+bounces-4398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C423691C7E3
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1239DB20EC6
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F980034;
	Fri, 28 Jun 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHH3HehY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF580023
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609088; cv=none; b=C0V96gBJBSqKTLRycH3z0T3OMrSp6/EFQ/1AoXSG7OZ7DS7JIfyG9AhsEmVo204Jn2P82PdhxknFrdrGz919Pfw8p0G+9hF/yuBQlv56DnoSNZpZ9haf9pYnWte1pyk0RlnhpyA0QjrKBh6lKhQfadSgjnGJZhRVxQMxWPj5L6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609088; c=relaxed/simple;
	bh=huZGOAd3AXlJYXZtkxsoJrXg/Qh/M3EMjLpZp7vMdVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyLP3+4jkxLkRItI79RkPU/xH/VCeRm7sz2pM5phtbelqbSMtHcBYjUHFGfEEhRNBnf1lrh9VWDwEG28bJBNzMhEbRh4xkoLt+5xOPoPgA/HT2MXQxl7xxCHj+pB3VqL1rMhOwomif8GIvtetbbjycjvB6rfdkjNcIdvCAa+PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHH3HehY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED604C116B1;
	Fri, 28 Jun 2024 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609088;
	bh=huZGOAd3AXlJYXZtkxsoJrXg/Qh/M3EMjLpZp7vMdVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHH3HehYfEkSWD/l811wAjWJfRdHfOJhzKDaiHEoC8F2a1oqeRGgprJyFAP0VrYNF
	 bIfaivwIDLeuZIieb/xm2Eu+/whFmmsPaylcDw/VVGz33UYMnu+KnqzNzotPGBqbOR
	 IjJ5krF0jVo7UsYIZhe19zyferGFE90lGJPACQru4fAVFXuxkRpUk+DBav7tYg6Ygo
	 fX1OYWTmzZSRMeWoSzi6EJny6mSir3ryLusQC8RSgL4+4mvNwuycp76BE84Kxf7uDc
	 Pr83Eyrrj1/ajZjM7gyr4l3UF7LT/0wcrOXi3LLttJV1rV0vb498+/KKrtoOb6Vh6K
	 sxd1UauSn9WyQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 15/19] nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
Date: Fri, 28 Jun 2024 17:11:01 -0400
Message-ID: <20240628211105.54736-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
client initiated localio calls to nfsd (that are _not_ in the context
of nfsd) are complete.

nfsd_open_local_fh is updated to nfsd_serv_try_get before opening its
file handle and then drop the reference using nfsd_serv_put at the end
of nfsd_open_local_fh.

This "interlock" working relies heavily on nfsd_open_local_fh()'s
maybe_get_net() safely dealing with the possibility that the struct
net (and nfsd_net by association) may have been destroyed by
nfsd_destroy_serv() via nfsd_shutdown_net().

Verified to fix an easy to hit crash that would occur if an nfsd
instance running in a container, with a localio client mounted, is
shutdown. Upon restart of the container and associated nfsd the client
would go on to crash due to NULL pointer dereference that occuured due
to the nfs client's localio attempting to nfsd_open_local_fh(), using
nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c |  8 ++++----
 fs/nfsd/netns.h   |  8 +++++++-
 fs/nfsd/nfssvc.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 8799ad3ac536..ef8467056827 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -186,7 +186,6 @@ int nfsd_open_local_fh(struct net *net,
 	struct nfsd_file *nf;
 	int status = 0;
 	int mayflags = NFSD_MAY_LOCALIO;
-	struct svc_serv *serv;
 	__be32 beres;
 
 	if (nfs_fh->size > NFS4_FHSIZE)
@@ -198,8 +197,8 @@ int nfsd_open_local_fh(struct net *net,
 		return -ENXIO;
 	nn = net_generic(net, nfsd_net_id);
 
-	serv = READ_ONCE(nn->nfsd_serv);
-	if (unlikely(!serv)) {
+	/* The server may already be shutting down, disallow new localio */
+	if (unlikely(!nfsd_serv_try_get(nn))) {
 		status = -ENXIO;
 		goto out_net;
 	}
@@ -207,7 +206,7 @@ int nfsd_open_local_fh(struct net *net,
 	/* Save creds before calling into nfsd */
 	save_cred = get_current_cred();
 
-	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred, serv);
+	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred, nn->nfsd_serv);
 	if (IS_ERR(rqstp)) {
 		status = PTR_ERR(rqstp);
 		goto out_revertcred;
@@ -235,6 +234,7 @@ int nfsd_open_local_fh(struct net *net,
 	nfsd_local_fakerqst_destroy(rqstp);
 out_revertcred:
 	revert_creds(save_cred);
+	nfsd_serv_put(nn);
 out_net:
 	put_net(net);
 	return status;
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0c5a1d97e4ac..443b003fd2ec 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/nfslocalio.h>
@@ -140,7 +141,9 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
-
+	struct percpu_ref nfsd_serv_ref;
+	struct completion nfsd_serv_confirm_done;
+	struct completion nfsd_serv_free_done;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -225,6 +228,9 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern void nfsd_netns_free_versions(struct nfsd_net *nn);
 
+bool nfsd_serv_try_get(struct nfsd_net *nn);
+void nfsd_serv_put(struct nfsd_net *nn);
+
 extern unsigned int nfsd_net_id;
 
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a477d2c5088a..11fb209b46bf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -258,6 +258,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
+bool nfsd_serv_try_get(struct nfsd_net *nn)
+{
+	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
+}
+
+void nfsd_serv_put(struct nfsd_net *nn)
+{
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
@@ -462,6 +486,7 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+	percpu_ref_exit(&nn->nfsd_serv_ref);
 #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
 	list_del_rcu(&nn->nfsd_uuid.list);
 #endif
@@ -544,6 +569,13 @@ void nfsd_destroy_serv(struct net *net)
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
@@ -666,6 +698,13 @@ int nfsd_create_serv(struct net *net)
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


