Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D231737F8
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1NJj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:39 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35867 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgB1NJj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:39 -0500
Received: by mail-yw1-f68.google.com with SMTP id y72so3221063ywg.3
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mQDvmIQpdISPBTLKH7Zwt20QFU0Xr0bFsaEwty4sRlU=;
        b=FhsxDHbqA5CkSuHr1h3OgwK/xCZ2pp7KZDONzT5CT+0T1gulhWPBSgnn4rfCFhja0p
         mFlD92lbE88bwqhMUdkigK0EALEsuGLBVYjYCTvNECIMLuvyLkoT1QHetVgkSKXN3EzE
         sToCm2sx/41WRr6PTPh+Qq/waiETgSlHe+jIcWkGOsjeSiHFy9WKQtpXcJ815SLomE4J
         xiZqsYA7UDu1z/vUPyz3xZCy/QL6bOmLTKOZ4ZNZ1oVwqukYYqXAqEbmcXMJZdxGyFPZ
         QTdVtSs8oFlzrSC3hJuEGauBc7ffhAVNHw6zSDct4QFG7lvLjSp2Xmra6SnwG9g24ME+
         H8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQDvmIQpdISPBTLKH7Zwt20QFU0Xr0bFsaEwty4sRlU=;
        b=dtNCks40DaHhwuaP+V/un1VEajEES01/NS7vi1GEXCM3C8vrs/DdeA6VYDzaLS9NFL
         7aPSqHIWbgVXlVJxovSQxBSPEUmU+6DnPo3OW9VOw7j0CMk6FoWgzgnEyGtLB25riEhu
         DX3RjoqELHGejtWZLxNhHOLvZrv+g9TaSWJuE27m6GndiZKHyz/RNRpMJO28O2wWhtrQ
         UQOgU4e599H0wSsOajZdZ7I0ubuTvepDtC9yzKmZn03IDZFFrlHvB1aTAoHx9TOGmHNl
         YGdS+v86RQ8y92qbwBnqwVKtM6ics73cyZqQDJVt0tEsYiYzClOoYmdWopkguTuLxqdg
         HeQg==
X-Gm-Message-State: APjAAAUFosc8u0JxOPOttxq0/l2/1DOrOZv0uQyTBLJ978hf7TQpVfqL
        y2P7eFUlVl/mkxArcHAwoG6bt18hCg==
X-Google-Smtp-Source: APXvYqzNh6YC1beQR9NR7qZdmvQ8IjNC0Rc6N5I7s9OU1NeQ8G9KKyU8YArdpDx2IsH85R4bWSDuHQ==
X-Received: by 2002:a25:6ac1:: with SMTP id f184mr3408679ybc.469.1582895378330;
        Fri, 28 Feb 2020 05:09:38 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:37 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] NFSv4: Clean up nfs_delegation_reap_unclaimed()
Date:   Fri, 28 Feb 2020 08:07:23 -0500
Message-Id: <20200228130725.1330705-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228130725.1330705-4-trond.myklebust@hammerspace.com>
References: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-3-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert nfs_delegation_reap_unclaimed() to use nfs_client_for_each_server()
for efficiency.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 76 ++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 19f66d3e58e8..cb03ba99ae51 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1092,53 +1092,51 @@ void nfs_delegation_mark_reclaim(struct nfs_client *clp)
 	rcu_read_unlock();
 }
 
-/**
- * nfs_delegation_reap_unclaimed - reap unclaimed delegations after reboot recovery is done
- * @clp: nfs_client to process
- *
- */
-void nfs_delegation_reap_unclaimed(struct nfs_client *clp)
+static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
+		void __always_unused *data)
 {
 	struct nfs_delegation *delegation;
-	struct nfs_server *server;
 	struct inode *inode;
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
-			    test_bit(NFS_DELEGATION_NEED_RECLAIM,
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
-			delegation = nfs_start_delegation_return_locked(NFS_I(inode));
-			rcu_read_unlock();
-			if (delegation != NULL) {
-				if (nfs_detach_delegation(NFS_I(inode), delegation,
-							server) != NULL)
-					nfs_free_delegation(delegation);
-				/* Match nfs_start_delegation_return_locked */
-				nfs_put_delegation(delegation);
-			}
-			iput(inode);
-			nfs_sb_deactive(server->super);
-			cond_resched();
-			goto restart;
+restart_locked:
+	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
+		if (test_bit(NFS_DELEGATION_INODE_FREEING,
+					&delegation->flags) ||
+		    test_bit(NFS_DELEGATION_RETURNING,
+					&delegation->flags) ||
+		    test_bit(NFS_DELEGATION_NEED_RECLAIM,
+					&delegation->flags) == 0)
+			continue;
+		inode = nfs_delegation_grab_inode(delegation);
+		if (inode == NULL)
+			goto restart_locked;
+		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
+		rcu_read_unlock();
+		if (delegation != NULL) {
+			if (nfs_detach_delegation(NFS_I(inode), delegation,
+						server) != NULL)
+				nfs_free_delegation(delegation);
+			/* Match nfs_start_delegation_return_locked */
+			nfs_put_delegation(delegation);
 		}
+		iput(inode);
+		cond_resched();
+		goto restart;
 	}
 	rcu_read_unlock();
+	return 0;
+}
+
+/**
+ * nfs_delegation_reap_unclaimed - reap unclaimed delegations after reboot recovery is done
+ * @clp: nfs_client to process
+ *
+ */
+void nfs_delegation_reap_unclaimed(struct nfs_client *clp)
+{
+	nfs_client_for_each_server(clp, nfs_server_reap_unclaimed_delegations,
+			NULL);
 }
 
 static inline bool nfs4_server_rebooted(const struct nfs_client *clp)
-- 
2.24.1

