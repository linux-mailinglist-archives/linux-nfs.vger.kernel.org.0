Return-Path: <linux-nfs+bounces-4334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A453918E55
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274B51F2768F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF75190670;
	Wed, 26 Jun 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crr2l9SU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29A19066F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426291; cv=none; b=ELREQyKEXGXiWr8en5jkqNq1HmoE4JS9RTzX61vzGnTYIG12ed7NftoxvzMJtT7Hd32gzrEFm0UnST7UdOV9UII5976XHdPRqmcfzDQ4L3chJj7y6hdmVRYeecuEBJfKW1udSQ6T0lvujq7ruSbp8VXgV39eGAesZ+bvcg572eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426291; c=relaxed/simple;
	bh=74Y600Ny9kRMpYsN90fR1ognxOUqG27HEiiQ2YGOElI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdHTaou7cMZe3Tn5kzpEXkIafg+lqz3lJB6l/El0KQNyZ2YCoXQFrcEWh0YW2d1w8VfC3Xm+DdT3AKIXjgAofXAEKpLWZdsc7wv0ORxlVLu/V6WyNcjZDCnYPprOdjEdHbbfyuRJeq/yx7gkXiCFhx8JMzeLIJ9/QbmSyADkat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crr2l9SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B818C116B1;
	Wed, 26 Jun 2024 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426291;
	bh=74Y600Ny9kRMpYsN90fR1ognxOUqG27HEiiQ2YGOElI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crr2l9SUwbP87fVhjP5JtkH0xdUNZyR/pqUQHoHul331cnADyNFk/fqJ+g46Qwy19
	 QpVn6l6eQmqeo4lxX/0FwJCMCoNZVmirwA3WoeSU8MSzutYHfJEZoca6wfiLxE2Lrp
	 BjUlKmjOelbXwGyNup5ZGPajIkZlT1uZYY69tTwwydl+MxmMl8etveL+hgLcv4sPA5
	 McW0qiX1heaVJISuIMO20l5O+4tJ6UFqDTqeks+bBQrUzsKnG08nGlxRqw/eyFG6LR
	 oC/fbsHrins1i4lq5Tm3tq/h+ilYDWSFYIaDw2KYRIzRid/gNP681YPH4n82//cTUO
	 /Py6huUBv+XEA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 09/18] nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
Date: Wed, 26 Jun 2024 14:24:29 -0400
Message-ID: <20240626182438.69539-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nfsd_serv_get and nfsd_serv_put and update the nfsd code to
prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
client initiated localio calls to nfsd (that are _not_ in the context
of nfsd) are complete.

nfsd_open_local_fh is updated to nfsd_serv_get before opening its file
handle and then drop the reference using nfsd_serv_put at the end of
nfsd_open_local_fh.

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
 fs/nfsd/localio.c |  2 ++
 fs/nfsd/netns.h   |  8 +++++++-
 fs/nfsd/nfssvc.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 48118db801b5..819589ae2008 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -204,6 +204,7 @@ int nfsd_open_local_fh(struct net *net,
 	}
 	nn = net_generic(net, nfsd_net_id);
 
+	nfsd_serv_get(nn);
 	serv = READ_ONCE(nn->nfsd_serv);
 	if (unlikely(!serv)) {
 		dprintk("%s: localio denied. Server not running\n", __func__);
@@ -244,6 +245,7 @@ int nfsd_open_local_fh(struct net *net,
 out_revertcred:
 	revert_creds(save_cred);
 out_net:
+	nfsd_serv_put(nn);
 	put_net(net);
 	return status;
 }
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0c5a1d97e4ac..17a73c780ca1 100644
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
 
+void nfsd_serv_get(struct nfsd_net *nn);
+void nfsd_serv_put(struct nfsd_net *nn);
+
 extern unsigned int nfsd_net_id;
 
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a477d2c5088a..be5acb7a4057 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -258,6 +258,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
+void nfsd_serv_get(struct nfsd_net *nn)
+{
+	percpu_ref_get(&nn->nfsd_serv_ref);
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


