Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98841737F7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgB1NJj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:39 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37986 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1NJj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:39 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so3209325ywv.5
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HQkTkYY4F8CDCMmaswKDG75K6tbTxn9bHXmgJuOl0wQ=;
        b=uJFSHV+IxCpTrZaoaQpeJRDy4o/0r7AZPr+9PgVT7ud1cvpGTgMnxBvXlHIGvjaAKD
         aNvuxgv6N8HvIXDOjyfeYdL6FjGCVfMGeY/rguWUQuowmpva7oTpwu2jn6UJV+uw4p7O
         fDHYpdoCM+UrJQi2e9pAxMStUIShO2lTNONsiWpZrNT9WafIwroXINZ6pB741Kiizkni
         LGJtztkan8qfF5s+AHc4utYrP0zwfLKPsQ6Fs3FndrTGKi5wi+gC27hXblm2VFuvpDIw
         2vpkorQDYmBIUIgdZqgyc7nKzwi+xHM6WLxdnEPUdAPiXRdgq2M2QaA8kKUjf42tc1VT
         MuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQkTkYY4F8CDCMmaswKDG75K6tbTxn9bHXmgJuOl0wQ=;
        b=bHXeFjcw+RdP8AGGZHpEHqSAzQHc4+XZuP6fLRS62lH7VjKvjBAJeRXDjw035GEPca
         suUlOCASVqFihCD0qpT7TC5s2m1mgNLXUI2ejCCUr9ivmEHM4cYhIkHfgad+n/IWDRlu
         GnvCPiUgJdViLUJf6tcHbVi2pp3n5VeSdxXH/ixMlIqOAx/hDd16Au3OJuv6wDiDIzci
         qWW6rDXAv28V8gGKUhNAhFLqBooQCsU2fdmXyPfMcxpv5gcraNt8ER0cwP+QUHf59tCx
         neQRrOTxfq0NyAcgae0nWaBGYiqRJ7DJUhvmZqjG+p698E1FhlRnY/jpQ5DblKnd2vlf
         0KdA==
X-Gm-Message-State: APjAAAVw6/e0WCdwMlR1cBDEfgJ3fShdbelee83ZxZ3fl2QHheT8l3Kf
        YIG/6ALQjZjD6ITDPsYacUG+bTFriw==
X-Google-Smtp-Source: APXvYqwKPYHVFUUiDmmhVkAzpD0zKdZEDl7ZYVktC2rhuebuJENdc1lYpgdYZ6peMtFDuPcAstwikg==
X-Received: by 2002:a25:3d44:: with SMTP id k65mr3350589yba.390.1582895377368;
        Fri, 28 Feb 2020 05:09:37 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:36 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] NFSv4: Clean up nfs_client_return_marked_delegations()
Date:   Fri, 28 Feb 2020 08:07:22 -0500
Message-Id: <20200228130725.1330705-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228130725.1330705-3-trond.myklebust@hammerspace.com>
References: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert it to use the nfs_client_for_each_server() helper, and
make it more efficient by skipping delegations for inodes we
know are in the process of being freed. Also improve the efficiency
of the cursor by skipping delegations that are being freed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 129 +++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 69 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 509b7235b132..19f66d3e58e8 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -563,21 +563,11 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 	return ret;
 }
 
-/**
- * nfs_client_return_marked_delegations - return previously marked delegations
- * @clp: nfs_client to process
- *
- * Note that this function is designed to be called by the state
- * manager thread. For this reason, it cannot flush the dirty data,
- * since that could deadlock in case of a state recovery error.
- *
- * Returns zero on success, or a negative errno value.
- */
-int nfs_client_return_marked_delegations(struct nfs_client *clp)
+static int nfs_server_return_marked_delegations(struct nfs_server *server,
+		void __always_unused *data)
 {
 	struct nfs_delegation *delegation;
 	struct nfs_delegation *prev;
-	struct nfs_server *server;
 	struct inode *inode;
 	struct inode *place_holder = NULL;
 	struct nfs_delegation *place_holder_deleg = NULL;
@@ -587,78 +577,79 @@ int nfs_client_return_marked_delegations(struct nfs_client *clp)
 	/*
 	 * To avoid quadratic looping we hold a reference
 	 * to an inode place_holder.  Each time we restart, we
-	 * list nfs_servers from the server of that inode, and
-	 * delegation in the server from the delegations of that
-	 * inode.
+	 * list delegation in the server from the delegations
+	 * of that inode.
 	 * prev is an RCU-protected pointer to a delegation which
 	 * wasn't marked for return and might be a good choice for
 	 * the next place_holder.
 	 */
-	rcu_read_lock();
 	prev = NULL;
+	delegation = NULL;
+	rcu_read_lock();
 	if (place_holder)
-		server = NFS_SERVER(place_holder);
-	else
-		server = list_entry_rcu(clp->cl_superblocks.next,
-					struct nfs_server, client_link);
-	list_for_each_entry_from_rcu(server, &clp->cl_superblocks, client_link) {
-		delegation = NULL;
-		if (place_holder && server == NFS_SERVER(place_holder))
-			delegation = rcu_dereference(NFS_I(place_holder)->delegation);
-		if (!delegation || delegation != place_holder_deleg)
-			delegation = list_entry_rcu(server->delegations.next,
-						    struct nfs_delegation, super_list);
-		list_for_each_entry_from_rcu(delegation, &server->delegations, super_list) {
-			struct inode *to_put = NULL;
-
-			if (!nfs_delegation_need_return(delegation)) {
+		delegation = rcu_dereference(NFS_I(place_holder)->delegation);
+	if (!delegation || delegation != place_holder_deleg)
+		delegation = list_entry_rcu(server->delegations.next,
+					    struct nfs_delegation, super_list);
+	list_for_each_entry_from_rcu(delegation, &server->delegations, super_list) {
+		struct inode *to_put = NULL;
+
+		if (test_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags))
+			continue;
+		if (!nfs_delegation_need_return(delegation)) {
+			if (nfs4_is_valid_delegation(delegation, 0))
 				prev = delegation;
-				continue;
-			}
-			if (!nfs_sb_active(server->super))
-				break; /* continue in outer loop */
-
-			if (prev) {
-				struct inode *tmp;
+			continue;
+		}
 
-				tmp = nfs_delegation_grab_inode(prev);
-				if (tmp) {
-					to_put = place_holder;
-					place_holder = tmp;
-					place_holder_deleg = prev;
-				}
+		if (prev) {
+			struct inode *tmp = nfs_delegation_grab_inode(prev);
+			if (tmp) {
+				to_put = place_holder;
+				place_holder = tmp;
+				place_holder_deleg = prev;
 			}
+		}
 
-			inode = nfs_delegation_grab_inode(delegation);
-			if (inode == NULL) {
-				rcu_read_unlock();
-				if (to_put)
-					iput(to_put);
-				nfs_sb_deactive(server->super);
-				goto restart;
-			}
-			delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		inode = nfs_delegation_grab_inode(delegation);
+		if (inode == NULL) {
 			rcu_read_unlock();
+			iput(to_put);
+			goto restart;
+		}
+		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		rcu_read_unlock();
 
-			if (to_put)
-				iput(to_put);
+		iput(to_put);
 
-			err = nfs_end_delegation_return(inode, delegation, 0);
-			iput(inode);
-			nfs_sb_deactive(server->super);
-			cond_resched();
-			if (!err)
-				goto restart;
-			set_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state);
-			if (place_holder)
-				iput(place_holder);
-			return err;
-		}
+		err = nfs_end_delegation_return(inode, delegation, 0);
+		iput(inode);
+		cond_resched();
+		if (!err)
+			goto restart;
+		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
+		goto out;
 	}
 	rcu_read_unlock();
-	if (place_holder)
-		iput(place_holder);
-	return 0;
+out:
+	iput(place_holder);
+	return err;
+}
+
+/**
+ * nfs_client_return_marked_delegations - return previously marked delegations
+ * @clp: nfs_client to process
+ *
+ * Note that this function is designed to be called by the state
+ * manager thread. For this reason, it cannot flush the dirty data,
+ * since that could deadlock in case of a state recovery error.
+ *
+ * Returns zero on success, or a negative errno value.
+ */
+int nfs_client_return_marked_delegations(struct nfs_client *clp)
+{
+	return nfs_client_for_each_server(clp,
+			nfs_server_return_marked_delegations, NULL);
 }
 
 /**
-- 
2.24.1

