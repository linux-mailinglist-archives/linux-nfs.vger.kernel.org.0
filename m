Return-Path: <linux-nfs+bounces-4544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B292438C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80ACF2886F1
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898681BD4E9;
	Tue,  2 Jul 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umVTBfTO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D91BC06B
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937722; cv=none; b=Vki9iimNkEK0xVDv8tjfERUTAVMHpQe1UekeuCcjHqbTyKW9ganQrLfqmbaYXJGiYAFcBQKL3cqUZx7chGxrL62N6lgYbzFVicwHDNoidmDSLVwZtREz6TCbxMfaJSZ+I8s2aBy9ZTVfwysbBQ5+q46KUC2KNoONSQqI7cDNzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937722; c=relaxed/simple;
	bh=xRjEQ3v6vmZAymZdxAOjfELpOXnfOlAFwzBxrQ5OCYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVsqqzX76SXlGfd7EEs/OZcvDbCyjYAKhDHY+7xCzcvjGR3rN1+OR72DJldOPHpUJIO4pK2O4AqWaZiVF11cSDy7uTwpoygR/3mnmCW0l6W1GRL13PFCndsFv9NjyJIhamrb2t17K1BoPCVupI/yK8en5JWwhGS3rjUw5B+usis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umVTBfTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B2DC4AF0C;
	Tue,  2 Jul 2024 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937722;
	bh=xRjEQ3v6vmZAymZdxAOjfELpOXnfOlAFwzBxrQ5OCYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umVTBfTO5i8A2aG3/j+eWm+c9tRKCnmXyZ4h7yiDYjjfnHFt8ErDd7r2AwF1LncgW
	 NKyny9VHE37WfoOji9DzpxFF9zynzpnMnhF8+9l/mq4LJyOtzFJU22aoNnLw+ShCuK
	 SfMnjhb2r5e5HCqAC8U78sWOYDau0Tew1RpkfLQBfPJODQHI1s4Yv7wTBQ0fJo+0Cn
	 0duQorzMVQdSLz0RUDP/OCf6b9oSjIx1dvGcl0qouB3dyuBIB+E4b70sbc3uuMFJ1k
	 ky1bqFq8xilGhgbO81HGyaN2j/b2/DkvmAnWZlTZPQ8U2NACxMY5IkTBxIG4U1+OOk
	 hhIWqm1fGtRqQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 07/20] nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
Date: Tue,  2 Jul 2024 12:28:18 -0400
Message-ID: <20240702162831.91604-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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
 fs/nfsd/localio.c |  9 +++++----
 fs/nfsd/netns.h   |  8 +++++++-
 fs/nfsd/nfssvc.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 0f81c340acc5..2e609ada7e19 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -195,7 +195,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 	struct svc_rqst *rqstp;
 	struct svc_fh fh;
 	struct nfsd_file *nf;
-	struct svc_serv *serv;
 	__be32 beres;
 
 	if (nfs_fh->size > NFS4_FHSIZE)
@@ -207,8 +206,8 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 		return -ENXIO;
 	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
 
-	serv = READ_ONCE(nn->nfsd_serv);
-	if (unlikely(!serv)) {
+	/* The server may already be shutting down, disallow new localio */
+	if (unlikely(!nfsd_serv_try_get(nn))) {
 		status = -ENXIO;
 		goto out_net;
 	}
@@ -216,7 +215,8 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 	/* Save creds before calling into nfsd */
 	save_cred = get_current_cred();
 
-	rqstp = nfsd_local_fakerqst_create(cl_nfssvc_net, rpc_clnt, cred, serv);
+	rqstp = nfsd_local_fakerqst_create(cl_nfssvc_net, rpc_clnt,
+					   cred, nn->nfsd_serv);
 	if (IS_ERR(rqstp)) {
 		status = PTR_ERR(rqstp);
 		goto out_revertcred;
@@ -244,6 +244,7 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 	nfsd_local_fakerqst_destroy(rqstp);
 out_revertcred:
 	revert_creds(save_cred);
+	nfsd_serv_put(nn);
 out_net:
 	put_net(cl_nfssvc_net);
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
index 5c99ba9abb03..90922c0586d5 100644
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


