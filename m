Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23414A6B8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgA0PAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:00:33 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46137 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgA0PAd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:00:33 -0500
Received: by mail-yb1-f196.google.com with SMTP id p129so4997679ybc.13
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6B3yGDOcSaTD9sQQXvABaRU4hdv2XxmWkW+LyfP79EU=;
        b=S6txtl/dEEooNQpTtI9LONvOprXrh9udxqgQLeXxjYKSvZLcP/zdrjQ8ytIo5bjKl5
         40iXvJJD+9XHNIzhuolFLhNg7E+ev6AAUHOssXMUz9g506l6rXvP72lWbEJx4ZcTh6D3
         Lr1yyllnLBF6ZCe0n1kgMTElt9Cporzr1oO8f5E1wz2HZWVzUwGBoUaZ+HU94+aUH/0s
         NvCpewmt8+Di86JNdbQMETX2tWy+To3jNFvLXZ+nkdNE9DNZUzupsQr51X9MBN+K6rDT
         xqT7ZWlhqM51ASB+nuLyCntkj2kWqksdOChprZ617wwgCZwP+HMQiZGpJATjoR6YU7rd
         e6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6B3yGDOcSaTD9sQQXvABaRU4hdv2XxmWkW+LyfP79EU=;
        b=NsmOe1kgtRg+O2Hh2a5vCYdZiwPvlK3RqrXYrn53saF83R55OfzxeFxotSMC81gfj/
         fZ9620Jk4Qio1dNJD3mBk1msEaJGI3UAYX97I+j/nssc1Y3sRMZDNKhdH0M0DbIu1CZU
         z1idICcHeSYzU3Vo9k9FfF9N9XFen9DCXfFtflia9SKRrCoplrxalMdvPj4vfV0HInEV
         lhIyfHYY/cLQVuTar74MvTtwXb2Ai+uLeVJc89AhsHc0h3Jpbg1yv4zDem0CEnYqL1+k
         /vCJWnO1s+HUogmO1r+0ThOzXmxhpDEAPj4dPUd2/xkRc422FfSHp/PFv1uQFLmLKmQ+
         vgSg==
X-Gm-Message-State: APjAAAUKngvMPMj54sBQwvdCBGdHXyf7/o+YeEuEftES+gXxgFWvm4Vp
        M3pYPT+kr2PbTN+h/KC/Z0O0mtsw+g==
X-Google-Smtp-Source: APXvYqwd4RUDxRRSGXxZlwJ1O1wdPlEx8PxMg+hOZgsOrwgDhp2JSmYnNvRIXIdabHkDRqUC2xuM/g==
X-Received: by 2002:a25:cf49:: with SMTP id f70mr13693495ybg.11.1580137231727;
        Mon, 27 Jan 2020 07:00:31 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d186sm6809096ywe.0.2020.01.27.07.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:31 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFSv4: Try to return the delegation immediately when marked for return on close
Date:   Mon, 27 Jan 2020 09:58:17 -0500
Message-Id: <20200127145819.350982-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127145819.350982-3-trond.myklebust@hammerspace.com>
References: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
 <20200127145819.350982-2-trond.myklebust@hammerspace.com>
 <20200127145819.350982-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a routine to return the delegation immediately upon close of the
file if it was marked for return-on-close.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 33 +++++++++++++++++++++++++++++++++
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4state.c  |  1 +
 3 files changed, 35 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index b5b14618b73e..90e50f32f3e0 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -639,6 +639,39 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	return err;
 }
 
+/**
+ * nfs_inode_return_delegation_on_close - asynchronously return a delegation
+ * @inode: inode to process
+ *
+ * This routine is called on file close in order to determine if the
+ * inode delegation needs to be returned immediately.
+ */
+void nfs4_inode_return_delegation_on_close(struct inode *inode)
+{
+	struct nfs_delegation *delegation;
+	struct nfs_delegation *ret = NULL;
+
+	if (!inode)
+		return;
+	rcu_read_lock();
+	delegation = nfs4_get_valid_delegation(inode);
+	if (!delegation)
+		goto out;
+	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
+		spin_lock(&delegation->lock);
+		if (delegation->inode &&
+		    list_empty(&NFS_I(inode)->open_files) &&
+		    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+			clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+			ret = delegation;
+		}
+		spin_unlock(&delegation->lock);
+	}
+out:
+	rcu_read_unlock();
+	nfs_end_delegation_return(inode, ret, 0);
+}
+
 /**
  * nfs4_inode_make_writeable
  * @inode: pointer to inode
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 15d3484be028..31b84604d383 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -42,6 +42,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
 int nfs4_inode_return_delegation(struct inode *inode);
+void nfs4_inode_return_delegation_on_close(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
 void nfs_inode_evict_delegation(struct inode *inode);
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 34552329233d..958ed4e4cde2 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -766,6 +766,7 @@ void nfs4_put_open_state(struct nfs4_state *state)
 	list_del(&state->open_states);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&owner->so_lock);
+	nfs4_inode_return_delegation_on_close(inode);
 	iput(inode);
 	nfs4_free_open_state(state);
 	nfs4_put_state_owner(owner);
-- 
2.24.1

