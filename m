Return-Path: <linux-nfs+bounces-13115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6443B07A85
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0951C1AA600C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0B2F4A1F;
	Wed, 16 Jul 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm4akiC+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA292F4A03
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681561; cv=none; b=qr+Dn1WmrlSJ95aWEdcAes9xMkcEYzLd0/qYxBrkr0Beg9lhTlAUMWmzQ40kaRaSzCgShlmNBhXUwMK8ZuzyxfEqdbI+C4V6O3NHgpp+JTsZJN3h7U+v0113x4ZHpOfdnn73/fuMlIyNhjfUn5o6Vy+TTNXzCGtYxHE6XSy+e8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681561; c=relaxed/simple;
	bh=1u8mDtfRHmADtKeF8+OnKfYT2uN7sSsYPpiueGzfcGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvpRzN7GhpYZClG5MJ+bkyweuz9RBV1iKDNz3G7cvLt5EtXIKZVp6/Wm+2wgpPJ8QXOgUx1nhbWEsazPG0BHz/MI6IM5FSExFR7aUFcD1zsoMHJItm7ZoSyg7O77iFhYu1YWNPaMulSmTHncCuJRtyajO9wefWDw69L8lV68CTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm4akiC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A71AC4CEF4;
	Wed, 16 Jul 2025 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681561;
	bh=1u8mDtfRHmADtKeF8+OnKfYT2uN7sSsYPpiueGzfcGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rm4akiC+QwqundOr2ftVHUvC0Ys1p/nvmhqYRcoPp8hGdKvW+kOwXmWZV2zeNKodQ
	 FUxfH8WMtKujJZ8U3A+F0Im8UTodI0IdEBnA7QIWCX1fZn+6Md4DRURYgao8TJ1nd0
	 yUnXe8aidr12nZgQZNznUH1HLo8eXQXNDFqu388gOz+R251u/h6v6LbGzUv3MVuzWg
	 aHA88L2cTFPjAC46MWvR+HrKmVS7YwPA4jPrNIOcwmV9SsUAgvTrkHVH9FzBEzK1OP
	 q0CZzsLr7NopkpzQMt0Ih1Q2pf7YjgCccrmKwZqCLEIzSMMJP44zfcY85F4ZNlAr9i
	 LE2nMEvTdC/wg==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
Date: Wed, 16 Jul 2025 08:59:17 -0700
Message-ID: <bc282e83fb26b42a25ed495cbb117a04e452d5e9.1752671200.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752671200.git.trond.myklebust@hammerspace.com>
References: <cover.1752671200.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order for the wait in nfs_uuid_put() to be safe, it is necessary to
ensure that nfs_uuid_add_file() doesn't add a new entry once the
nfs_uuid->net has been NULLed out.

Also fix up the wake_up_var_locked() / wait_var_event_spinlock() to both
use the nfs_uuid address, since nfl, and &nfl->uuid could be used elsewhere.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Link: https://lore.kernel.org/all/175262893035.2234665.1735173020338594784@noble.neil.brown.name/
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 64949c46c174..f1f1592ac134 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			/* nfs_close_local_fh() is doing the
 			 * close and we must wait. until it unlinks
 			 */
-			wait_var_event_spinlock(nfl,
+			wait_var_event_spinlock(nfs_uuid,
 						list_first_entry_or_null(
 							&nfs_uuid->files,
 							struct nfs_file_localio,
@@ -243,15 +243,20 @@ void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
 }
 EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
-static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
+static int nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
 {
+	int ret = 0;
+
 	/* Add nfl to nfs_uuid->files if it isn't already */
 	spin_lock(&nfs_uuid->lock);
-	if (list_empty(&nfl->list)) {
+	if (rcu_access_pointer(nfs_uuid->net) == NULL) {
+		ret = -ENXIO;
+	} else if (list_empty(&nfl->list)) {
 		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
 		list_add_tail(&nfl->list, &nfs_uuid->files);
 	}
 	spin_unlock(&nfs_uuid->lock);
+	return ret;
 }
 
 /*
@@ -285,11 +290,13 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	}
 	rcu_read_unlock();
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
-	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
-					     cred, nfs_fh, pnf, fmode);
+	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt, cred,
+					     nfs_fh, pnf, fmode);
+	if (!IS_ERR(localio) && nfs_uuid_add_file(uuid, nfl) < 0) {
+		/* Delete the cached file when racing with nfs_uuid_put() */
+		nfs_to_nfsd_file_put_local(pnf);
+	}
 	nfs_to_nfsd_net_put(net);
-	if (!IS_ERR(localio))
-		nfs_uuid_add_file(uuid, nfl);
 
 	return localio;
 }
@@ -338,7 +345,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	 */
 	spin_lock(&nfs_uuid->lock);
 	list_del_init(&nfl->list);
-	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+	wake_up_var_locked(nfs_uuid, &nfs_uuid->lock);
 	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
-- 
2.50.1


