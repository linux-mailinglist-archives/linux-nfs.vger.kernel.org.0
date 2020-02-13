Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BCE15CB68
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgBMTxR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 14:53:17 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35746 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBMTxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Feb 2020 14:53:17 -0500
Received: by mail-yw1-f66.google.com with SMTP id i190so3190680ywc.2
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2020 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Uic0+Y/Fg4Emt4J492WVq2j2sQLwlRpRdl1kkKwkUM=;
        b=LEkLRP7DttQacJnamqXFrv/N4H0OGW/Pa5OdCD1EBRoZOoDQnYl4oXrXW4XPbq7G5B
         hYFgv1IHiOxYKCk66sIn1YoSxH0YD0R7gRT6IzYFy1JO7k8J3FWHaxGD0FQDdXBtTHFw
         xMsCbVVxZR6A2z3DYCaTSKOcYpwGsiUNJNbwgO9h+97T4tlNyQO3BAlNFuPH7L0j82cn
         hfECZf4nyl5nnpvA/fw5xo+m2zO/Z5DROgvhZkrUgHqrfKfRYgryeQpnnN3bC5QNe0Tn
         QDXYyeeVef2BAuiokJd9Efn4JQxgEF4gvCWgz+cosGgkqF1yNnCFJKrsQO1JXl4285Kc
         evcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Uic0+Y/Fg4Emt4J492WVq2j2sQLwlRpRdl1kkKwkUM=;
        b=n2abT2s8uUuIYg3yATfNlk0/0/WcvfUjZnr8BUqa7bHGNOvzb0E2L5TU3O0ShnPNmV
         Z/zx30O29ZJIy/n9zO/tT+Lrf4TrRj9eArLaPg+Gx63CD4NkgnrJVM7Q5SAtjde6RT7F
         vsx1gU6XdubaCEY+g+TelCxVzdDC571P5KhicOqW9A1TBse9OnkQpuOkldxeSbRhJ1I3
         jqlWBWpFPryCBdB/Z8RkFVBsXcFgUPjBc68NbKChJJ1Y4LXspWCaiKxb6mh7s1/aBFbQ
         mauO7oICBhNeeHl0GZ79mddiESisrE+HoZESvcNRrUtNDfsczjg8Vxk4xsyROTfRDyHO
         Ellg==
X-Gm-Message-State: APjAAAXiD4AhIxrGGLfUy0Xo2r8fN8Jtk1OUkra/HfZtwr6IGpK8P7oY
        fTbdU3zxHZDiOlFcDJyF5bcceSqvmg==
X-Google-Smtp-Source: APXvYqzlwlD2DetSnTg6DkRwRzmdBcIcv84htfDNIH6vejGO5o6kKechtW/abJ6OYpIUKM8VWsyOvA==
X-Received: by 2002:a0d:e102:: with SMTP id k2mr4776108ywe.163.1581623596442;
        Thu, 13 Feb 2020 11:53:16 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l202sm1560717ywb.89.2020.02.13.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 11:53:16 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Ensure the delegation is pinned in nfs_do_return_delegation()
Date:   Thu, 13 Feb 2020 14:51:06 -0500
Message-Id: <20200213195107.10095-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The call to nfs_do_return_delegation() needs to be taken without
any RCU locks. Add a refcount to make sure the delegation remains
pinned in memory until we're done.

Fixes: ee05f456772d ("NFSv4: Fix races between open and delegreturn")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 33 ++++++++++++++++++++++++++-------
 fs/nfs/delegation.h |  1 +
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d856326836a2..c17ff826e7e9 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -47,10 +47,22 @@ static void nfs_mark_delegation_revoked(struct nfs_delegation *delegation)
 	}
 }
 
+static struct nfs_delegation *nfs_get_delegation(struct nfs_delegation *delegation)
+{
+	refcount_inc(&delegation->refcount);
+	return delegation;
+}
+
+static void nfs_put_delegation(struct nfs_delegation *delegation)
+{
+	if (refcount_dec_and_test(&delegation->refcount))
+		__nfs_free_delegation(delegation);
+}
+
 static void nfs_free_delegation(struct nfs_delegation *delegation)
 {
 	nfs_mark_delegation_revoked(delegation);
-	__nfs_free_delegation(delegation);
+	nfs_put_delegation(delegation);
 }
 
 /**
@@ -275,8 +287,10 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	if (delegation == NULL)
 		goto out;
 	spin_lock(&delegation->lock);
-	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
-		ret = delegation;
+	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+		/* Refcount matched in nfs_end_delegation_return() */
+		ret = nfs_get_delegation(delegation);
+	}
 	spin_unlock(&delegation->lock);
 	if (ret)
 		nfs_clear_verifier_delegated(&nfsi->vfs_inode);
@@ -397,6 +411,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	if (delegation == NULL)
 		return -ENOMEM;
 	nfs4_stateid_copy(&delegation->stateid, stateid);
+	refcount_set(&delegation->refcount, 1);
 	delegation->type = type;
 	delegation->pagemod_limit = pagemod_limit;
 	delegation->change_attr = inode_peek_iversion_raw(inode);
@@ -496,6 +511,8 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 
 	err = nfs_do_return_delegation(inode, delegation, issync);
 out:
+	/* Refcount matched in nfs_start_delegation_return_locked() */
+	nfs_put_delegation(delegation);
 	return err;
 }
 
@@ -690,7 +707,8 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
 		    list_empty(&NFS_I(inode)->open_files) &&
 		    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 			clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
-			ret = delegation;
+			/* Refcount matched in nfs_end_delegation_return() */
+			ret = nfs_get_delegation(delegation);
 		}
 		spin_unlock(&delegation->lock);
 		if (ret)
@@ -1094,10 +1112,11 @@ void nfs_delegation_reap_unclaimed(struct nfs_client *clp)
 			delegation = nfs_start_delegation_return_locked(NFS_I(inode));
 			rcu_read_unlock();
 			if (delegation != NULL) {
-				delegation = nfs_detach_delegation(NFS_I(inode),
-					delegation, server);
-				if (delegation != NULL)
+				if (nfs_detach_delegation(NFS_I(inode), delegation,
+							server) != NULL)
 					nfs_free_delegation(delegation);
+				/* Match nfs_start_delegation_return_locked */
+				nfs_put_delegation(delegation);
 			}
 			iput(inode);
 			nfs_sb_deactive(server->super);
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 31b84604d383..9b00a0b7f832 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -22,6 +22,7 @@ struct nfs_delegation {
 	unsigned long pagemod_limit;
 	__u64 change_attr;
 	unsigned long flags;
+	refcount_t refcount;
 	spinlock_t lock;
 	struct rcu_head rcu;
 };
-- 
2.24.1

