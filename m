Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EEFEB9DB
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJaWna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34747 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfJaWn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id z144so1171198ywd.1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0w1x19jgGRQLmFP5d0KNhM8Dd0dSbZyA49/LiXX5964=;
        b=Y1kWcyG/vHBOnOcTUrM0lq15Pv86FnZZL1sEVRRm/KQzo5lG4t7HaBk6H8yP/FMAqY
         ElQE9yho2qwDjXf/bgmSPc33yBk1uWMyCIs5mjp1spQ9cfM5Olp1yvuwgXLLk9rlUCl/
         rGKo6qdcXUWwfj26wbZSVz6cX6lkpWqSuUIqq/oPva8Tx6GfKAofavvUvz46gFejxOH5
         elkiUaSBYb6FKdF0LcECMkUPLx5vX0wV0vtX2jO7p3hqtFgPWdnegrxZaQTnRVAlvtqS
         NqaQAVDMCmRfKKMmURgfLVZHPyrmtw7Qa6LTIERLaC7tP6p2wHzKU8L5b34JkjEUVsRz
         PhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0w1x19jgGRQLmFP5d0KNhM8Dd0dSbZyA49/LiXX5964=;
        b=BN4octkSzetnRZrEYFUiH8Ud1EJRa0k7L+Fm26jrsiMhO+b74phfGGXvaCQKL7mBpP
         ULR779IJubAOnqnnEWxL/4SA0ufSpkjnatus/nPSygHEK/u5d4eM0Tv8h96MJRvSoK0u
         AKw7kooHgZJ6Apa9td/XPiVWxe95J7TKyCNavuGmsigf2eFaW7nINILjTKZ8Ustcja2D
         ruqYL5yS4xG7BASK2ZrFWeDtScQ0TlDOkfDMJ+MXObNgjS45u8lImYZxml7jgpfbcpBN
         ahwDCzt/YE65cdJkPzAXoc5QCJix7wK0/1zWG7+ObYvFOH2UxdQ44Lv1UvwG9hMTefKV
         //yQ==
X-Gm-Message-State: APjAAAUx+KAZngRMg5l052BWHg8rERPW7aiU4NhhMNZn3oE5+sTYm41w
        Ais1gAmUx55qRAn8gQgVunxn+Ds=
X-Google-Smtp-Source: APXvYqypPeIcROQh49Q2lkbScU2+Rvs0Dde3VZsbwMQbsKLrZLfYpYQC68tTanOs+DHtVHT5IGBovw==
X-Received: by 2002:a81:49c1:: with SMTP id w184mr6285788ywa.264.1572561808172;
        Thu, 31 Oct 2019 15:43:28 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:27 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 18/20] NFSv4: Fix races between open and delegreturn
Date:   Thu, 31 Oct 2019 18:40:49 -0400
Message-Id: <20191031224051.8923-19-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-18-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
 <20191031224051.8923-15-trond.myklebust@hammerspace.com>
 <20191031224051.8923-16-trond.myklebust@hammerspace.com>
 <20191031224051.8923-17-trond.myklebust@hammerspace.com>
 <20191031224051.8923-18-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server returns the same delegation in an open that we just used
in a delegreturn, we need to ensure we don't apply that stateid if
the delegreturn has freed it on the server.
To do so, we ensure that we do not free the storage for the delegation
until either it is replaced by a new one, or we throw the inode out of
cache.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 64 ++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 902baea1ecc6..48f3c6c9672f 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -229,7 +229,6 @@ static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *
 				delegation->cred,
 				&delegation->stateid,
 				issync);
-	nfs_free_delegation(delegation);
 	return res;
 }
 
@@ -302,7 +301,6 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		spin_unlock(&delegation->lock);
 		return NULL;
 	}
-	set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	list_del_rcu(&delegation->super_list);
 	delegation->inode = NULL;
 	rcu_assign_pointer(nfsi->delegation, NULL);
@@ -329,10 +327,12 @@ nfs_inode_detach_delegation(struct inode *inode)
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_delegation *delegation;
 
-	delegation = nfs_start_delegation_return(nfsi);
-	if (delegation == NULL)
-		return NULL;
-	return nfs_detach_delegation(nfsi, delegation, server);
+	rcu_read_lock();
+	delegation = rcu_dereference(nfsi->delegation);
+	if (delegation != NULL)
+		delegation = nfs_detach_delegation(nfsi, delegation, server);
+	rcu_read_unlock();
+	return delegation;
 }
 
 static void
@@ -384,16 +384,18 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	spin_lock(&clp->cl_lock);
 	old_delegation = rcu_dereference_protected(nfsi->delegation,
 					lockdep_is_held(&clp->cl_lock));
-	if (old_delegation != NULL) {
-		/* Is this an update of the existing delegation? */
-		if (nfs4_stateid_match_other(&old_delegation->stateid,
-					&delegation->stateid)) {
-			spin_lock(&old_delegation->lock);
-			nfs_update_inplace_delegation(old_delegation,
-					delegation);
-			spin_unlock(&old_delegation->lock);
-			goto out;
-		}
+	if (old_delegation == NULL)
+		goto add_new;
+	/* Is this an update of the existing delegation? */
+	if (nfs4_stateid_match_other(&old_delegation->stateid,
+				&delegation->stateid)) {
+		spin_lock(&old_delegation->lock);
+		nfs_update_inplace_delegation(old_delegation,
+				delegation);
+		spin_unlock(&old_delegation->lock);
+		goto out;
+	}
+	if (!test_bit(NFS_DELEGATION_REVOKED, &old_delegation->flags)) {
 		/*
 		 * Deal with broken servers that hand out two
 		 * delegations for the same file.
@@ -412,11 +414,11 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 		if (test_and_set_bit(NFS_DELEGATION_RETURNING,
 					&old_delegation->flags))
 			goto out;
-		freeme = nfs_detach_delegation_locked(nfsi,
-				old_delegation, clp);
-		if (freeme == NULL)
-			goto out;
 	}
+	freeme = nfs_detach_delegation_locked(nfsi, old_delegation, clp);
+	if (freeme == NULL)
+		goto out;
+add_new:
 	list_add_tail_rcu(&delegation->super_list, &server->delegations);
 	rcu_assign_pointer(nfsi->delegation, delegation);
 	delegation = NULL;
@@ -431,8 +433,10 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
 		nfs_free_delegation(delegation);
-	if (freeme != NULL)
+	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
+		nfs_free_delegation(freeme);
+	}
 	return status;
 }
 
@@ -442,7 +446,6 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation *delegation, int issync)
 {
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
-	struct nfs_inode *nfsi = NFS_I(inode);
 	int err = 0;
 
 	if (delegation == NULL)
@@ -464,8 +467,6 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 		nfs_abort_delegation_return(delegation, clp);
 		goto out;
 	}
-	if (!nfs_detach_delegation(nfsi, delegation, NFS_SERVER(inode)))
-		goto out;
 
 	err = nfs_do_return_delegation(inode, delegation, issync);
 out:
@@ -608,6 +609,7 @@ void nfs_inode_evict_delegation(struct inode *inode)
 	if (delegation != NULL) {
 		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 		nfs_do_return_delegation(inode, delegation, 1);
+		nfs_free_delegation(delegation);
 	}
 }
 
@@ -763,10 +765,9 @@ static void nfs_mark_delegation_revoked(struct nfs_server *server,
 {
 	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
 	delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
-	nfs_mark_return_delegation(server, delegation);
 }
 
-static bool nfs_revoke_delegation(struct inode *inode,
+static void nfs_revoke_delegation(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
 	struct nfs_delegation *delegation;
@@ -799,19 +800,12 @@ static bool nfs_revoke_delegation(struct inode *inode,
 	rcu_read_unlock();
 	if (ret)
 		nfs_inode_find_state_and_recover(inode, stateid);
-	return ret;
 }
 
 void nfs_remove_bad_delegation(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
-	struct nfs_delegation *delegation;
-
-	if (!nfs_revoke_delegation(inode, stateid))
-		return;
-	delegation = nfs_inode_detach_delegation(inode);
-	if (delegation)
-		nfs_free_delegation(delegation);
+	nfs_revoke_delegation(inode, stateid);
 }
 EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
 
@@ -839,7 +833,7 @@ void nfs_delegation_mark_returned(struct inode *inode,
 			delegation->stateid.seqid = stateid->seqid;
 	}
 
-	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
+	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.23.0

