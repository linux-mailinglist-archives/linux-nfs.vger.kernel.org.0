Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0423CE273E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406310AbfJWX6T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32917 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406360AbfJWX6S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:18 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so27283285ior.0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zVqTmIUAXC7dPNeIDF1vIwLG+V39yijm9mkc4U7mxII=;
        b=BAqj9nqSnSg8+cP/uaHM3TVJeHsFoH43baHKQmmTVdHmxaDWamJ4lFtuJh/Z0Anl0q
         /WlpgTRMiL1ej8UfaI6Sn7yVR1et0xTela2869M094SOYT1xWTHcmqqVZypcGZUjc7rI
         iTIQ5zsAXvQUQlKuDQO64aqEgHoF3koaJYhTndsEpEnRnTjGItPjfAiJ5McdYQO3AtKn
         FBD7Bea5zgZ2hdrgecYWMQ9AF9krh6+4uwlXbSN87vPHsz8gi5e78h7wYdOLXVcR+98J
         YLjS4TvXan7DN3sAsutATw20MQM+vs4nh74bnADOiA5mPcNWgcqUNWRIu5g5Evl+NvLd
         cT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVqTmIUAXC7dPNeIDF1vIwLG+V39yijm9mkc4U7mxII=;
        b=WAY/8Awm9nL/fbn6bMcrOldBy+T7WRfAp7SzA7UJJB/Mer6y6EaSExjoRYJam4shtG
         1BKLtr4AewGO+SjHEmrj/0hN/1VtcTV4LxgLtJaB3QGWCO6Pb1rpfA2adIqPJYYALXQF
         ADBBIffpg+74UltWFU40T44s6zW3dvtXJwAEhMp1yWbFIQcnwAF+rGDpWU6CXUHdz2ES
         QTv12AdpaVemeCUe2/2IQ5bEcjRNDVR48NRFwPe6uWGTJSoZOswMM1EW2frU/NUR6gPN
         C0MhkpSJP0lNe2i/KEvu4Pc4NUKl1O9hgumqe9BegEsXxGy6QiYUtl+og4jMTMB2l5op
         H0IA==
X-Gm-Message-State: APjAAAXBRlis4zdhiXnXFpWHFETe59TRsvNCj6nGTJFxlmAvFmg1e5LG
        1ag9UjsSMXflkmoNXO1EWP2I428=
X-Google-Smtp-Source: APXvYqzglbUMbA4hTm6D7fx/O18oAE0zuF4gSs5wexOgna6rxOaERnG2x0y1iSlPxIVHyKdDhF1uvA==
X-Received: by 2002:a6b:37c6:: with SMTP id e189mr6062695ioa.122.1571875097473;
        Wed, 23 Oct 2019 16:58:17 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:16 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/14] NFSv4: Revoke the delegation on success in nfs4_delegreturn_done()
Date:   Wed, 23 Oct 2019 19:55:57 -0400
Message-Id: <20191023235600.10880-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-11-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <20191023235600.10880-2-trond.myklebust@hammerspace.com>
 <20191023235600.10880-3-trond.myklebust@hammerspace.com>
 <20191023235600.10880-4-trond.myklebust@hammerspace.com>
 <20191023235600.10880-5-trond.myklebust@hammerspace.com>
 <20191023235600.10880-6-trond.myklebust@hammerspace.com>
 <20191023235600.10880-7-trond.myklebust@hammerspace.com>
 <20191023235600.10880-8-trond.myklebust@hammerspace.com>
 <20191023235600.10880-9-trond.myklebust@hammerspace.com>
 <20191023235600.10880-10-trond.myklebust@hammerspace.com>
 <20191023235600.10880-11-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation was successfully returned, then mark it as revoked.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 32 ++++++++++++++++++++++++++++++++
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4proc.c   |  1 +
 3 files changed, 34 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5a87d32a8d7c..b214b88b35b5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -795,6 +795,38 @@ void nfs_remove_bad_delegation(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
 
+void nfs_delegation_mark_returned(struct inode *inode,
+		const nfs4_stateid *stateid)
+{
+	struct nfs_delegation *delegation;
+
+	if (!inode)
+		return;
+
+	rcu_read_lock();
+	delegation = rcu_dereference(NFS_I(inode)->delegation);
+	if (!delegation)
+		goto out_rcu_unlock;
+
+	spin_lock(&delegation->lock);
+	if (!nfs4_stateid_match_other(stateid, &delegation->stateid))
+		goto out_spin_unlock;
+	if (stateid->seqid &&
+	    nfs4_stateid_is_newer(&delegation->stateid, stateid))
+		goto out_clear_returning;
+
+	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
+
+out_clear_returning:
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+out_spin_unlock:
+	spin_unlock(&delegation->lock);
+out_rcu_unlock:
+	rcu_read_unlock();
+
+	nfs_inode_find_state_and_recover(inode, stateid);
+}
+
 /**
  * nfs_expire_unused_delegation_types
  * @clp: client to process
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 9a14a7ca1df9..7f0151c40d2f 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -53,6 +53,7 @@ void nfs_expire_unreferenced_delegations(struct nfs_client *clp);
 int nfs_client_return_marked_delegations(struct nfs_client *clp);
 int nfs_delegations_present(struct nfs_client *clp);
 void nfs_remove_bad_delegation(struct inode *inode, const nfs4_stateid *stateid);
+void nfs_delegation_mark_returned(struct inode *inode, const nfs4_stateid *stateid);
 
 void nfs_delegation_mark_reclaim(struct nfs_client *clp);
 void nfs_delegation_reap_unclaimed(struct nfs_client *clp);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c407e2eed3d5..4375b07ede25 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6211,6 +6211,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		if (exception.retry)
 			goto out_restart;
 	}
+	nfs_delegation_mark_returned(data->inode, data->args.stateid);
 	data->rpc_status = task->tk_status;
 	return;
 out_restart:
-- 
2.21.0

