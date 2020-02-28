Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D1B1737F9
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1NJl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:41 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33481 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NJl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:41 -0500
Received: by mail-yw1-f67.google.com with SMTP id j186so3243436ywe.0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cqZyln7uV8TFcW9bdiJi2KV/o+kRCqQ/8cTYkZ0Z8tU=;
        b=tt+/yDMfHaR7GjaB9VV58+ni6ImtTpzDYd4cSKKJXgGJ6e3r9M2jUVfVx3Ug4F05UH
         /rltE5Ejuy4l0t+1NOT0cRQg5ysZavgxuMGEaeaBtqdS2AuRKPe/atQ5y60f/SPL31Uq
         SX+XJ5+UejqcbSOblQakNAGZyVWcjrU7AaYT/AhKJD03HyhZ4MIevu7H/MpfUdlSZPEK
         J7PjyNs4SucZZLH2SIYD23qqHXhltEqyIcNmB7VNo3R+QFc500MTv12HbXcwt7UTO7Co
         xW7a5zduC04EnSUxuXSHInr9sE1H5ruL/eSnqZFh8iUki7vxMeIajip3fJFJDzIUEKTl
         YjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqZyln7uV8TFcW9bdiJi2KV/o+kRCqQ/8cTYkZ0Z8tU=;
        b=swOJ+9gZe/c5a/FwHaPFFsUCd/6UZGdF9LtEn89N39MkZ5KbFfI/umf69mk4CBPH+I
         o8Bcx87I8LdYY/J9t69khF0fYG4SAD3SM04UYIEswzhfqWqTYnYhIQ7B7iYJLJQ4SgUO
         91YHDUyJE74+jjj6ezf6uOFjuEvGIIlzspOe28dILi2uT2u99qPja839fy+oQS8/grr0
         9GYO9l5JjHMT8KWaf43UqCaUWFduQJOjJ1apC3URYNDDIazziSbyWZ3Oi2KS5CpuxJtJ
         sa1WubVIRfqJqm30CSZTLaledHLY72JflART6Jxy/5rxtiGPlcEWmBOM0cKMqrQTwLWF
         18CA==
X-Gm-Message-State: APjAAAXoTNjQ2UxWPViK+PaQuwTqYQll90u33ZRP/LX+oUYvq+DzGdXz
        49x9ZvHVWdGFBLZgVh7hdac664JmSw==
X-Google-Smtp-Source: APXvYqykT7C1rDTkz+frNo5VwyFvEzNnXc0EJFKnpVt/d8E7HXX7oZk0qKagRnm2vQ9RWMZDBB9mHA==
X-Received: by 2002:a25:d20f:: with SMTP id j15mr3678135ybg.74.1582895379332;
        Fri, 28 Feb 2020 05:09:39 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:38 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] NFSv4: Clean up nfs_delegation_reap_expired()
Date:   Fri, 28 Feb 2020 08:07:24 -0500
Message-Id: <20200228130725.1330705-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228130725.1330705-5-trond.myklebust@hammerspace.com>
References: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-3-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-4-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert to use nfs_client_for_each_server() for efficiency.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 83 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cb03ba99ae51..01974f17afc9 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1222,62 +1222,59 @@ nfs_delegation_test_free_expired(struct inode *inode,
 		nfs_remove_bad_delegation(inode, stateid);
 }
 
-/**
- * nfs_reap_expired_delegations - reap expired delegations
- * @clp: nfs_client to process
- *
- * Iterates through all the delegations associated with this server and
- * checks if they have may have been revoked. This function is usually
- * expected to be called in cases where the server may have lost its
- * lease.
- */
-void nfs_reap_expired_delegations(struct nfs_client *clp)
+static int nfs_server_reap_expired_delegations(struct nfs_server *server,
+		void __always_unused *data)
 {
 	struct nfs_delegation *delegation;
-	struct nfs_server *server;
 	struct inode *inode;
 	const struct cred *cred;
 	nfs4_stateid stateid;
-
 restart:
 	rcu_read_lock();
-	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
-		list_for_each_entry_rcu(delegation, &server->delegations,
-								super_list) {
-			if (test_bit(NFS_DELEGATION_INODE_FREEING,
-						&delegation->flags) ||
-			    test_bit(NFS_DELEGATION_RETURNING,
-						&delegation->flags) ||
-			    test_bit(NFS_DELEGATION_TEST_EXPIRED,
-						&delegation->flags) == 0)
-				continue;
-			if (!nfs_sb_active(server->super))
-				break; /* continue in outer loop */
-			inode = nfs_delegation_grab_inode(delegation);
-			if (inode == NULL) {
-				rcu_read_unlock();
-				nfs_sb_deactive(server->super);
-				goto restart;
-			}
-			cred = get_cred_rcu(delegation->cred);
-			nfs4_stateid_copy(&stateid, &delegation->stateid);
-			clear_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
-			rcu_read_unlock();
-			nfs_delegation_test_free_expired(inode, &stateid, cred);
-			put_cred(cred);
-			if (nfs4_server_rebooted(clp)) {
-				nfs_inode_mark_test_expired_delegation(server,inode);
-				iput(inode);
-				nfs_sb_deactive(server->super);
-				return;
-			}
+restart_locked:
+	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
+		if (test_bit(NFS_DELEGATION_INODE_FREEING,
+					&delegation->flags) ||
+		    test_bit(NFS_DELEGATION_RETURNING,
+					&delegation->flags) ||
+		    test_bit(NFS_DELEGATION_TEST_EXPIRED,
+					&delegation->flags) == 0)
+			continue;
+		inode = nfs_delegation_grab_inode(delegation);
+		if (inode == NULL)
+			goto restart_locked;
+		cred = get_cred_rcu(delegation->cred);
+		nfs4_stateid_copy(&stateid, &delegation->stateid);
+		clear_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
+		rcu_read_unlock();
+		nfs_delegation_test_free_expired(inode, &stateid, cred);
+		put_cred(cred);
+		if (!nfs4_server_rebooted(server->nfs_client)) {
 			iput(inode);
-			nfs_sb_deactive(server->super);
 			cond_resched();
 			goto restart;
 		}
+		nfs_inode_mark_test_expired_delegation(server,inode);
+		iput(inode);
+		return -EAGAIN;
 	}
 	rcu_read_unlock();
+	return 0;
+}
+
+/**
+ * nfs_reap_expired_delegations - reap expired delegations
+ * @clp: nfs_client to process
+ *
+ * Iterates through all the delegations associated with this server and
+ * checks if they have may have been revoked. This function is usually
+ * expected to be called in cases where the server may have lost its
+ * lease.
+ */
+void nfs_reap_expired_delegations(struct nfs_client *clp)
+{
+	nfs_client_for_each_server(clp, nfs_server_reap_expired_delegations,
+			NULL);
 }
 
 void nfs_inode_find_delegation_state_and_recover(struct inode *inode,
-- 
2.24.1

