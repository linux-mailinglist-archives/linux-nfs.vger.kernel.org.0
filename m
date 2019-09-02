Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7862CA5BAB
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfIBRG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 13:06:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33599 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfIBRG1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Sep 2019 13:06:27 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so30391007iog.0
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2019 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GA75ufOJonbpqC5MlA/RQIRk67dy/HSW1IeiLuiWlEU=;
        b=Nydhj0TrOlJwcX3rxlcNq3daKdSdzfoBLzD5Ggy0apwcRIbWv0q9oLMIVuGeMAsSMG
         Rh+unLBc4cf9hlZ/q2wuEWJzhce9BN849EFxFFXPi8nP8+DMlWhHGwRzoMSava5fuUtX
         GJ8pd6ohZScX04GLk96hhSTcPhK4jf83sUn/xfRcsAa3s5ZjtvTQb/chZ4/OlHPMN7Yy
         Ws+YlOB+X8JEp/QxfbqK4oEDVdVpljIc02bNMXiHvIJmJe7qEAT7eQbWzPsin6CA1KjQ
         yzbOGUH8rpX2kKUJR30nar87XABZ+bj3nBeKkFzXYCp9XBA0Lf8zVrWQbU1j0ci23JFA
         bPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GA75ufOJonbpqC5MlA/RQIRk67dy/HSW1IeiLuiWlEU=;
        b=UwmyYZdEF08KYItUbg998KwIHAejc89ERD5+5w3/Qf0s6PDjLt6+CjzWh3beBysYAa
         hm5JVXmu5XN5YOUWjH+IRm/ZTEaq35/1CGgfk85DIQcj956hfWsYv/8zQzHjVAkZdDiC
         itYDyK0YALdBa9xlFnYLe6wQ2P3jKw6vqQ83NilMacfmxC543kn5EIbUbxrFZ6BdUFsI
         6iVI7a5sdjqCVJTHdeENUwr8o5IxcFkv24G8kj+v7qzFXkvsSEaSoXXCUqNwkRoIoMXy
         S3ZxxniQtMcg+lcyLFgpplvQ6tQpZRpU26vfLVBypmkbrb2S0S8ISxxoxC8z0+M/Wy+l
         5/hg==
X-Gm-Message-State: APjAAAVa2+85pdy3fPfnaLjMzW6dlhiitw/wZpIBUhAzTzj2/IUMzeRC
        yEiauFzDGKwCGClJm7tBvk7WUlgv+Q==
X-Google-Smtp-Source: APXvYqwhgOrXEKYr41FsXqz35/0cwABX4ZwOcJTzIdK5Z7siQBdvlrZ8p7txHWaCgxBRsL/Er5MMPg==
X-Received: by 2002:a02:ad0e:: with SMTP id s14mr12482179jan.97.1567443986264;
        Mon, 02 Sep 2019 10:06:26 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o3sm7655322iob.64.2019.09.02.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:06:25 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J.Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/4] nfsd: nfsd_file cache entries should be per net namespace
Date:   Mon,  2 Sep 2019 13:02:55 -0400
Message-Id: <20190902170258.92522-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
References: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we can safely clear out the file cache entries when the
nfs server is shut down on a container. Otherwise, the file cache
may end up pinning the mounts.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/export.c    |  2 +-
 fs/nfsd/filecache.c | 33 +++++++++++++++++++++------------
 fs/nfsd/filecache.h |  3 ++-
 fs/nfsd/nfssvc.c    |  1 +
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 052fac64b578..15422c951fd1 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -240,7 +240,7 @@ static void expkey_flush(void)
 	 * destroyed while we're in the middle of flushing.
 	 */
 	mutex_lock(&nfsd_mutex);
-	nfsd_file_cache_purge();
+	nfsd_file_cache_purge(current->nsproxy->net_ns);
 	mutex_unlock(&nfsd_mutex);
 }
 
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a2fcb251d2f6..d229fd3c825d 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -17,6 +17,7 @@
 #include "vfs.h"
 #include "nfsd.h"
 #include "nfsfh.h"
+#include "netns.h"
 #include "filecache.h"
 #include "trace.h"
 
@@ -168,7 +169,8 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 }
 
 static struct nfsd_file *
-nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval)
+nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval,
+		struct net *net)
 {
 	struct nfsd_file *nf;
 
@@ -178,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval)
 		INIT_LIST_HEAD(&nf->nf_lru);
 		nf->nf_file = NULL;
 		nf->nf_cred = get_current_cred();
+		nf->nf_net = net;
 		nf->nf_flags = 0;
 		nf->nf_inode = inode;
 		nf->nf_hashval = hashval;
@@ -608,10 +611,11 @@ nfsd_file_cache_init(void)
  * Note this can deadlock with nfsd_file_lru_cb.
  */
 void
-nfsd_file_cache_purge(void)
+nfsd_file_cache_purge(struct net *net)
 {
 	unsigned int		i;
 	struct nfsd_file	*nf;
+	struct hlist_node	*next;
 	LIST_HEAD(dispose);
 	bool del;
 
@@ -619,10 +623,12 @@ nfsd_file_cache_purge(void)
 		return;
 
 	for (i = 0; i < NFSD_FILE_HASH_SIZE; i++) {
-		spin_lock(&nfsd_file_hashtbl[i].nfb_lock);
-		while(!hlist_empty(&nfsd_file_hashtbl[i].nfb_head)) {
-			nf = hlist_entry(nfsd_file_hashtbl[i].nfb_head.first,
-					 struct nfsd_file, nf_node);
+		struct nfsd_fcache_bucket *nfb = &nfsd_file_hashtbl[i];
+
+		spin_lock(&nfb->nfb_lock);
+		hlist_for_each_entry_safe(nf, next, &nfb->nfb_head, nf_node) {
+			if (net && nf->nf_net != net)
+				continue;
 			del = nfsd_file_unhash_and_release_locked(nf, &dispose);
 
 			/*
@@ -631,7 +637,7 @@ nfsd_file_cache_purge(void)
 			 */
 			WARN_ON_ONCE(!del);
 		}
-		spin_unlock(&nfsd_file_hashtbl[i].nfb_lock);
+		spin_unlock(&nfb->nfb_lock);
 		nfsd_file_dispose_list(&dispose);
 	}
 }
@@ -650,7 +656,7 @@ nfsd_file_cache_shutdown(void)
 	 * calling nfsd_file_cache_purge
 	 */
 	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
-	nfsd_file_cache_purge();
+	nfsd_file_cache_purge(NULL);
 	list_lru_destroy(&nfsd_file_lru);
 	rcu_barrier();
 	fsnotify_put_group(nfsd_file_fsnotify_group);
@@ -686,7 +692,7 @@ nfsd_match_cred(const struct cred *c1, const struct cred *c2)
 
 static struct nfsd_file *
 nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
-			unsigned int hashval)
+			unsigned int hashval, struct net *net)
 {
 	struct nfsd_file *nf;
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
@@ -697,6 +703,8 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
 			continue;
 		if (nf->nf_inode != inode)
 			continue;
+		if (nf->nf_net != net)
+			continue;
 		if (!nfsd_match_cred(nf->nf_cred, current_cred()))
 			continue;
 		if (nfsd_file_get(nf) != NULL)
@@ -739,6 +747,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
 	__be32	status;
+	struct net *net = SVC_NET(rqstp);
 	struct nfsd_file *nf, *new;
 	struct inode *inode;
 	unsigned int hashval;
@@ -753,12 +762,12 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	hashval = (unsigned int)hash_long(inode->i_ino, NFSD_FILE_HASH_BITS);
 retry:
 	rcu_read_lock();
-	nf = nfsd_file_find_locked(inode, may_flags, hashval);
+	nf = nfsd_file_find_locked(inode, may_flags, hashval, net);
 	rcu_read_unlock();
 	if (nf)
 		goto wait_for_construction;
 
-	new = nfsd_file_alloc(inode, may_flags, hashval);
+	new = nfsd_file_alloc(inode, may_flags, hashval, net);
 	if (!new) {
 		trace_nfsd_file_acquire(rqstp, hashval, inode, may_flags,
 					NULL, nfserr_jukebox);
@@ -766,7 +775,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
-	nf = nfsd_file_find_locked(inode, may_flags, hashval);
+	nf = nfsd_file_find_locked(inode, may_flags, hashval, net);
 	if (nf == NULL)
 		goto open_file;
 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 0c0c67166b87..851d9abf54c2 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -34,6 +34,7 @@ struct nfsd_file {
 	struct rcu_head		nf_rcu;
 	struct file		*nf_file;
 	const struct cred	*nf_cred;
+	struct net		*nf_net;
 #define NFSD_FILE_HASHED	(0)
 #define NFSD_FILE_PENDING	(1)
 #define NFSD_FILE_BREAK_READ	(2)
@@ -48,7 +49,7 @@ struct nfsd_file {
 };
 
 int nfsd_file_cache_init(void);
-void nfsd_file_cache_purge(void);
+void nfsd_file_cache_purge(struct net *);
 void nfsd_file_cache_shutdown(void);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d02712ca2685..b944553c6927 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -387,6 +387,7 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_file_cache_purge(net);
 	nfs4_state_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
-- 
2.21.0

