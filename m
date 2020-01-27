Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16514A6B9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgA0PAe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:00:34 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40547 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgA0PAd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:00:33 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so4828325ywe.7
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 07:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCP7XDbwqynjsMWfGGEVx8n6y4Sbr/5RTCXLxam2NFw=;
        b=ORV6J7YZs4kFr2STL8OHs7qRchkdN4A/BOSJcFnFAcVZHTUVcyDk/TXm2o3tzDf8Tr
         NNky3kUXm+6EUecSl3PVQHj1BVBUnC8Y3MPyQ5/vCkSsRjJf9oVPQ9eYZH0JuaAizOoh
         2l+fpGcebznabty90nuOyVtYY0XdVETtqPtmWPQp5vEY38xQgaRfl0ZPowFFpofER3DG
         9GjbHbn+LbioVnRPI8eoQdEUnSAC7xnEWL8oB9ay7Vnh1MNmGiezuPlfWhIzTBjMi5A6
         tcYnvevPQoFwqN/B2iKcMC0I8OFp9Y0xxsGAXO916UTlNaq1Llm2JxVCNIPuh09mtZ3U
         XnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCP7XDbwqynjsMWfGGEVx8n6y4Sbr/5RTCXLxam2NFw=;
        b=XdjVUclagiPs5XOnE/UFOW8hSxj+h6mI54nREfJmGIDH/cQy3AYZAa0G6sPadUjLaA
         TZfXLgiLZLcUx4hrQY6UKNuLbOyrOzT2uTTikSDRWDFw4/TofCsIz++IxQa8xCffNOLr
         ZbKOF1tM6s9RqaxaRjLmGlOLciEZXOgY5+ofZR5n3GDiWLLTgwfQRr3VKe2YOmqofYO6
         sEYHVjWDv/HUcLMYZX3fOAXnriDBqwAAz1LsB3H68IZWJAAZofiDVy0TSyy1P9JU0zSp
         eWb0TKclyUvDZF7QIauTjylq49VU970T8ItQbqxG+bY2SB1wG6Lfh5kQQ/FX1uvsXhuY
         2WlA==
X-Gm-Message-State: APjAAAURBksCqdRngFLUpUaA1Z1OT0VSgjDzoB35+lJtlZQwc8wdCIUq
        0CPD+V3eJn6NHZDrRUhqInrBBnaq6w==
X-Google-Smtp-Source: APXvYqztY34f0SpXByhmZVcRk5UjZ6iPgSQFV1VPCtNsxUBqN0p8LXorGnaWCtP36L7nVfTwGB0jag==
X-Received: by 2002:a81:5dc1:: with SMTP id r184mr13157421ywb.433.1580137232840;
        Mon, 27 Jan 2020 07:00:32 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d186sm6809096ywe.0.2020.01.27.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:32 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFSv4: Add accounting for the number of active delegations held
Date:   Mon, 27 Jan 2020 09:58:18 -0500
Message-Id: <20200127145819.350982-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127145819.350982-4-trond.myklebust@hammerspace.com>
References: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
 <20200127145819.350982-2-trond.myklebust@hammerspace.com>
 <20200127145819.350982-3-trond.myklebust@hammerspace.com>
 <20200127145819.350982-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In order to better manage our delegation caching, add a counter
to track the number of active delegations.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 90e50f32f3e0..a777b3d0e720 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -25,13 +25,29 @@
 #include "internal.h"
 #include "nfs4trace.h"
 
-static void nfs_free_delegation(struct nfs_delegation *delegation)
+static atomic_long_t nfs_active_delegations;
+
+static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
 	put_cred(delegation->cred);
 	delegation->cred = NULL;
 	kfree_rcu(delegation, rcu);
 }
 
+static void nfs_mark_delegation_revoked(struct nfs_delegation *delegation)
+{
+	if (!test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
+		delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
+		atomic_long_dec(&nfs_active_delegations);
+	}
+}
+
+static void nfs_free_delegation(struct nfs_delegation *delegation)
+{
+	nfs_mark_delegation_revoked(delegation);
+	__nfs_free_delegation(delegation);
+}
+
 /**
  * nfs_mark_delegation_referenced - set delegation's REFERENCED flag
  * @delegation: delegation to process
@@ -343,7 +359,8 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 		delegation->stateid.seqid = update->stateid.seqid;
 		smp_wmb();
 		delegation->type = update->type;
-		clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
+		if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+			atomic_long_inc(&nfs_active_delegations);
 	}
 }
 
@@ -423,6 +440,8 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	rcu_assign_pointer(nfsi->delegation, delegation);
 	delegation = NULL;
 
+	atomic_long_inc(&nfs_active_delegations);
+
 	trace_nfs4_set_delegation(inode, type);
 
 	spin_lock(&inode->i_lock);
@@ -432,7 +451,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 out:
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
-		nfs_free_delegation(delegation);
+		__nfs_free_delegation(delegation);
 	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
 		nfs_free_delegation(freeme);
@@ -796,13 +815,6 @@ static void nfs_client_mark_return_unused_delegation_types(struct nfs_client *cl
 	rcu_read_unlock();
 }
 
-static void nfs_mark_delegation_revoked(struct nfs_server *server,
-		struct nfs_delegation *delegation)
-{
-	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
-	delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
-}
-
 static void nfs_revoke_delegation(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
@@ -830,7 +842,7 @@ static void nfs_revoke_delegation(struct inode *inode,
 		}
 		spin_unlock(&delegation->lock);
 	}
-	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
+	nfs_mark_delegation_revoked(delegation);
 	ret = true;
 out:
 	rcu_read_unlock();
@@ -869,7 +881,7 @@ void nfs_delegation_mark_returned(struct inode *inode,
 			delegation->stateid.seqid = stateid->seqid;
 	}
 
-	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
+	nfs_mark_delegation_revoked(delegation);
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.24.1

