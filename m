Return-Path: <linux-nfs+bounces-7399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D099AD58F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 22:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AAD28473D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436BB1C9EAF;
	Wed, 23 Oct 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGa3gwzY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0975809
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715684; cv=none; b=cWuszIFtFXjEIH/A2M4YwDP9s4SGFeNogrpnPHXaBqEyEFCEw3t3/FUEU40t+1Ph8RW0vQpyjpozXLVyTAfGZN48LGryYKqXUu/oCXv5d9FNvhY0g9tC65178oF9HW1E8bZVaknhm3znllTTmuB5gfWiBOjhfT41ZAnJgopmahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715684; c=relaxed/simple;
	bh=uEpB9YB0HHTQR+OegmQLYn5DwzBkFN+T6UVcBmVqTKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BaV3IM9mQqUwHfFniicMfP20oasvnKzRYecUWe7L2TxjIrl3L0VPIrw0IUww7nYKs+PYftSANbftSJ6MM+0g+tU4hBjVID7G4rk/OLooguX9cWtlJpxRsZeUeMRIW5aX6oLrtdb/duMpeSeULQv2NXyr5LY/TUCe5IyEGanb3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGa3gwzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79921C4CEC6;
	Wed, 23 Oct 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715683;
	bh=uEpB9YB0HHTQR+OegmQLYn5DwzBkFN+T6UVcBmVqTKo=;
	h=From:To:Cc:Subject:Date:From;
	b=aGa3gwzYB9s+BnF3HSEK7bHqq+QY/KvSzlaGzYy4gVZwn0oYtScdX2vZuby8Ujv5l
	 ypHH5KsCrOeGucTg+TT+Hth/TeckTDoZrbVD5qFqaeRLHNztU53oxjQ25JqcGp4tvH
	 ThpfX3TPjsHBg3DOajPJl5A1qyafkYTFjjloq4jIGT6WTHa2Qi5Qqosk2X/LurtHyT
	 QMgmL478OOyt3KAzygTTErKwTWxViUSQhPx6GMj52nQB7z1jCpg/ipzjpOKb7NeP8v
	 t/N8sTrQj/2zCrXvfwXHjXLefecN/6OU/vhA/7NdHRJ2C5D5h+WUiA3TJYzlI9xsS9
	 l5MKO9iXgTVVA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] nfs_common: fix localio to cope with racing nfs_local_probe()
Date: Wed, 23 Oct 2024 16:34:42 -0400
Message-ID: <20241023203442.73903-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the possibility of racing nfs_local_probe() resulting in:
  list_add double add: new=ffff8b99707f9f58, prev=ffff8b99707f9f58, next=ffffffffc0f30000.
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:35!

Add nfs_uuid_init() to properly initialize all nfs_uuid_t members
(particularly its list_head).

Switch to returning bool from nfs_uuid_begin(), returns false if
nfs_uuid_t is already in-use (its list_head is on a list). Update
nfs_local_probe() to return early if the nfs_client's cl_uuid
(nfs_uuid_t) is in-use.

Also, switch nfs_uuid_begin() from using list_add_tail_rcu() to
list_add_tail() -- rculist was used in an earlier version of the
localio code that had a lockless nfs_uuid_lookup interface.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  3 +--
 fs/nfs/localio.c           |  3 ++-
 fs/nfs_common/nfslocalio.c | 25 +++++++++++++++++++------
 include/linux/nfslocalio.h |  3 ++-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 114282398716..03ecc7765615 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -181,8 +181,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
 	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
-	clp->cl_uuid.net = NULL;
-	clp->cl_uuid.dom = NULL;
+	nfs_uuid_init(&clp->cl_uuid);
 	spin_lock_init(&clp->cl_localio_lock);
 #endif /* CONFIG_NFS_LOCALIO */
 
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d0aa680ec816..8f0ce82a677e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -205,7 +205,8 @@ void nfs_local_probe(struct nfs_client *clp)
 		nfs_local_disable(clp);
 	}
 
-	nfs_uuid_begin(&clp->cl_uuid);
+	if (!nfs_uuid_begin(&clp->cl_uuid))
+		return;
 	if (nfs_server_uuid_is_local(clp))
 		nfs_local_enable(clp);
 	nfs_uuid_end(&clp->cl_uuid);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 5c8ce5066c16..09404d142d1a 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/rculist.h>
+#include <linux/list.h>
 #include <linux/nfslocalio.h>
 #include <net/netns/generic.h>
 
@@ -20,15 +20,27 @@ static DEFINE_SPINLOCK(nfs_uuid_lock);
  */
 static LIST_HEAD(nfs_uuids);
 
-void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
+void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 {
 	nfs_uuid->net = NULL;
 	nfs_uuid->dom = NULL;
+	INIT_LIST_HEAD(&nfs_uuid->list);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_init);
+
+bool nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
+{
+	spin_lock(&nfs_uuid_lock);
+	/* Is this nfs_uuid already in use? */
+	if (!list_empty(&nfs_uuid->list)) {
+		spin_unlock(&nfs_uuid_lock);
+		return false;
+	}
 	uuid_gen(&nfs_uuid->uuid);
-
-	spin_lock(&nfs_uuid_lock);
-	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
+	list_add_tail(&nfs_uuid->list, &nfs_uuids);
 	spin_unlock(&nfs_uuid_lock);
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_begin);
 
@@ -36,7 +48,8 @@ void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
 {
 	if (nfs_uuid->net == NULL) {
 		spin_lock(&nfs_uuid_lock);
-		list_del_init(&nfs_uuid->list);
+		if (nfs_uuid->net == NULL)
+			list_del_init(&nfs_uuid->list);
 		spin_unlock(&nfs_uuid_lock);
 	}
 }
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b0dd9b1eef4f..3982fea79919 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -32,7 +32,8 @@ typedef struct {
 	struct auth_domain *dom; /* auth_domain for localio */
 } nfs_uuid_t;
 
-void nfs_uuid_begin(nfs_uuid_t *);
+void nfs_uuid_init(nfs_uuid_t *);
+bool nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 		       struct net *, struct auth_domain *, struct module *);
-- 
2.44.0


