Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69AEB9D4
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfJaWnV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:21 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44317 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:21 -0400
Received: by mail-yw1-f65.google.com with SMTP id a83so1367842ywe.11
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P51JCY1PLmq4de1gWwd77QKvlBGJp+uxbI5eEyjCy3k=;
        b=PtmeXKAcgx2Slqs5sTD17PxRN/E9LyvEACvd9YNLYHgnzo50/ypkfVL/nkS45yS/hp
         LfSl1g4pBALviei29B6PtcLn7V4+Kytd8y50Ec93huidHybfkli5p8eGX46BlCiiS46s
         oVCNN+3RURNhma0JiYAlMQKdgwJlwIvEPwZ7f3qUA5iJ4Aad53RLrGKuXClsnseihGfO
         j3wiOZW3K2lfat0qslUMHzKp/niyzH+ceE7U416jZNZbsFHnWUQGSmNvKTed+Ky43xTp
         SbEeBy9c7VeyrFKCycJyFe8l+6lnEKeUVeha1b2zEd8bM4yv6a6XeSMGFNtmNBolJDYg
         crIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P51JCY1PLmq4de1gWwd77QKvlBGJp+uxbI5eEyjCy3k=;
        b=AM+hArrODQH2HRtkcvws/3xNE/rd1Re+5MFOxm6q/feqvW/MdIoI8S51zvUe8bu7PO
         hggtFWkTssUV/+Rz+NVtwZl/pXQEENyIu/i+urDNsd4i5Rr/6KkWcYXntNWhKn7Bo4x5
         ncRSyIF420kV4gpduh5NBMKZwpEpBi3ddzGSarNhyZblylHZc4D9UWl1efW/M643UDhd
         wu1h1hC/YzetgCUgewzcVIel24jj/TChQxMeWLzZUcfcNHNTih7nttl5WX/Oyy6EkTDo
         SuliPFKR9DNXamxkWkfz+94SaaoWB5IxcCfRv0afizVtgXQSH/pcMnVHytje8PN2oHRu
         3gBQ==
X-Gm-Message-State: APjAAAWoYeAtSp7ELLgLcMyzBI4IbEgP/aeTCIjRBGIdO9MLECOBkH+a
        AJ6TxZCRUZP0yHmRzqS423Cs1vc=
X-Google-Smtp-Source: APXvYqwWZnNIYk4ra7Qyw85/BrRhRwTc24CyU3giBpv80SlG0k9VKo6MVLUzZ4emTUprjtvbrW5qvQ==
X-Received: by 2002:a81:27cd:: with SMTP id n196mr6362657ywn.148.1572561799809;
        Thu, 31 Oct 2019 15:43:19 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:18 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/20] NFSv4: Revoke the delegation on success in nfs4_delegreturn_done()
Date:   Thu, 31 Oct 2019 18:40:43 -0400
Message-Id: <20191031224051.8923-13-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-12-trond.myklebust@hammerspace.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation was successfully returned, then mark it as revoked.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4proc.c   |  1 +
 3 files changed, 38 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index aff2416dc277..8c176c921554 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -806,6 +806,42 @@ void nfs_remove_bad_delegation(struct inode *inode,
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
+	if (stateid->seqid) {
+		/* If delegation->stateid is newer, dont mark as returned */
+		if (nfs4_stateid_is_newer(&delegation->stateid, stateid))
+			goto out_clear_returning;
+		if (delegation->stateid.seqid != stateid->seqid)
+			delegation->stateid.seqid = stateid->seqid;
+	}
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
index 74b7fb601365..15d3484be028 100644
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
index 217885e32852..a222122e7151 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6214,6 +6214,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		if (exception.retry)
 			goto out_restart;
 	}
+	nfs_delegation_mark_returned(data->inode, data->args.stateid);
 	data->rpc_status = task->tk_status;
 	return;
 out_restart:
-- 
2.23.0

