Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8576D806C4
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfHCOmw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 10:42:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40840 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCOmv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 10:42:51 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so33438945iom.7
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHGZ5aw+4+wgRUA6E1X3IkDMOnky9ntKx7kgAAVYXxQ=;
        b=FMGrcC0DbydhU6rAYnWgKIgC+zmsF1I1/kPduRZttNuEoZViUDOyLETzpHrZ5/aWS4
         26yKiCndYoIqGNe0ObdrcPdfLS5v0EDrk6ht8x6dJltupQQFXml64y3zuo+sSIum4+UA
         P+3et4MQX4m2u4gk1nLIyDpgH/Zmofoo6CciRcyUm0OVuIr3cR7UnpqHNfsaMOR9BOAJ
         XhBjgwvqjHgA/i6jwEkIufYKH4n2qw48xEsaMwBIofoZNYyrvY+TkpGmgjyT7XbOLICS
         QTFXz8BEy2eOPyA6f8tAlW6vlf/GRgVkpvecfc9qsJ/BsPC4USDjKfNmg5GdI6EO4krw
         wxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHGZ5aw+4+wgRUA6E1X3IkDMOnky9ntKx7kgAAVYXxQ=;
        b=gT8jgtUDCBwpE8WzLhwar2Jyy2oZ4tC1ZHIOfou0IWBwQO07aSiQsxcbkyhmEM85Y3
         S32HKobb/gmmFuIcNN29SXEaEuJGi1TQxNYjOsI+RxnWxfHNlZ5gGtqt8KbFbgeqCEpE
         Qtyl35hCQaKdEXiuLHAPNR9PuDvTH3vgRC+heSVHB+LbVA4kZlBoua+/IAZUeOVULI6I
         IAXadCEV4c898n9VQXAQyI2WDnxZU9LJ458LsM574bPAOwZYXzv0GbTWXoYyKGyvL0CA
         PNfxNiCEEKnA5ITTj84wnJWm9oLt4NJnmg6rPsuOfCo4mDL9AtyKhQZYPQiLXPBw87/A
         THjg==
X-Gm-Message-State: APjAAAU9TGhN4rrjfk4iNUY8DMOMZrW7WxVcXLapN9lHGX9ZjpTnmawU
        JdEmDaEsg7n8mqsCw3zH0iwcnw4=
X-Google-Smtp-Source: APXvYqyyJCudIyZUcq+JIIX86Mmg/FSdJvwyIhQ5GWwqkOE726pQsrYSPSWMY76dF32B8BykckYB4A==
X-Received: by 2002:a6b:f216:: with SMTP id q22mr89894898ioh.65.1564843370290;
        Sat, 03 Aug 2019 07:42:50 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n2sm81404760ioa.27.2019.08.03.07.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 07:42:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix a potential sleep while atomic in nfs4_do_reclaim()
Date:   Sat,  3 Aug 2019 10:40:42 -0400
Message-Id: <20190803144042.15187-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

John Hubbard reports seeing the following stack trace:

nfs4_do_reclaim
   rcu_read_lock /* we are now in_atomic() and must not sleep */
       nfs4_purge_state_owners
           nfs4_free_state_owner
               nfs4_destroy_seqid_counter
                   rpc_destroy_wait_queue
                       cancel_delayed_work_sync
                           __cancel_work_timer
                               __flush_work
                                   start_flush_work
                                       might_sleep:
                                        (kernel/workqueue.c:2975: BUG)

The solution is to separate out the freeing of the state owners
from nfs4_purge_state_owners(), and perform that outside the atomic
context.

Reported-by: John Hubbard <jhubbard@nvidia.com>
Fixes: 0aaaf5c424c7f ("NFS: Cache state owners after files are closed")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h    |  3 ++-
 fs/nfs/nfs4client.c |  5 ++++-
 fs/nfs/nfs4state.c  | 27 ++++++++++++++++++++++-----
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index d778dad9a75e..3564da1ba8a1 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -465,7 +465,8 @@ static inline void nfs4_schedule_session_recovery(struct nfs4_session *session,
 
 extern struct nfs4_state_owner *nfs4_get_state_owner(struct nfs_server *, const struct cred *, gfp_t);
 extern void nfs4_put_state_owner(struct nfs4_state_owner *);
-extern void nfs4_purge_state_owners(struct nfs_server *);
+extern void nfs4_purge_state_owners(struct nfs_server *, struct list_head *);
+extern void nfs4_free_state_owners(struct list_head *head);
 extern struct nfs4_state * nfs4_get_open_state(struct inode *, struct nfs4_state_owner *);
 extern void nfs4_put_open_state(struct nfs4_state *);
 extern void nfs4_close_state(struct nfs4_state *, fmode_t);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 616393a01c06..da6204025a2d 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -758,9 +758,12 @@ int nfs41_walk_client_list(struct nfs_client *new,
 
 static void nfs4_destroy_server(struct nfs_server *server)
 {
+	LIST_HEAD(freeme);
+
 	nfs_server_return_all_delegations(server);
 	unset_pnfs_layoutdriver(server);
-	nfs4_purge_state_owners(server);
+	nfs4_purge_state_owners(server, &freeme);
+	nfs4_free_state_owners(&freeme);
 }
 
 /*
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index d03b9cf42bd0..a4e866b2b43b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -624,24 +624,39 @@ void nfs4_put_state_owner(struct nfs4_state_owner *sp)
 /**
  * nfs4_purge_state_owners - Release all cached state owners
  * @server: nfs_server with cached state owners to release
+ * @head: resulting list of state owners
  *
  * Called at umount time.  Remaining state owners will be on
  * the LRU with ref count of zero.
+ * Note that the state owners are not freed, but are added
+ * to the list @head, which can later be used as an argument
+ * to nfs4_free_state_owners.
  */
-void nfs4_purge_state_owners(struct nfs_server *server)
+void nfs4_purge_state_owners(struct nfs_server *server, struct list_head *head)
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_state_owner *sp, *tmp;
-	LIST_HEAD(doomed);
 
 	spin_lock(&clp->cl_lock);
 	list_for_each_entry_safe(sp, tmp, &server->state_owners_lru, so_lru) {
-		list_move(&sp->so_lru, &doomed);
+		list_move(&sp->so_lru, head);
 		nfs4_remove_state_owner_locked(sp);
 	}
 	spin_unlock(&clp->cl_lock);
+}
 
-	list_for_each_entry_safe(sp, tmp, &doomed, so_lru) {
+/**
+ * nfs4_purge_state_owners - Release all cached state owners
+ * @head: resulting list of state owners
+ *
+ * Frees a list of state owners that was generated by
+ * nfs4_purge_state_owners
+ */
+void nfs4_free_state_owners(struct list_head *head)
+{
+	struct nfs4_state_owner *sp, *tmp;
+
+	list_for_each_entry_safe(sp, tmp, head, so_lru) {
 		list_del(&sp->so_lru);
 		nfs4_free_state_owner(sp);
 	}
@@ -1865,12 +1880,13 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 	struct nfs4_state_owner *sp;
 	struct nfs_server *server;
 	struct rb_node *pos;
+	LIST_HEAD(freeme);
 	int status = 0;
 
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
-		nfs4_purge_state_owners(server);
+		nfs4_purge_state_owners(server, &freeme);
 		spin_lock(&clp->cl_lock);
 		for (pos = rb_first(&server->state_owners);
 		     pos != NULL;
@@ -1899,6 +1915,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 		spin_unlock(&clp->cl_lock);
 	}
 	rcu_read_unlock();
+	nfs4_free_state_owners(&freeme);
 	return 0;
 }
 
-- 
2.21.0

