Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9CB4244
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbfIPUqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34477 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733156AbfIPUqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:33 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so2391746ion.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyGDQpMVH1rTLSPHW8HYSc7W3EA/zyjV2dF3PYsHi3Q=;
        b=gMxS5jiUJ3WEa/Ytk9JtjYVsgPfWh0HSGOCijKwH0IaAPuPTmZbp2FDD4QdmMXTR4j
         gBxmEthqmKNDpF6RXpqa7G1oyWwPT89UGV0Xy+duoHF3Vndu04XMYFY7HGTwhtrJ5eKA
         /2Lyh7y/wTAk6kmVqL5gVPkMpaSk9IpbD4CCVtuqg5tkZgcHMJtO2gnhxyRYZ5NeaSaI
         +ldrC1552yXf/Atcz0sQxTCbYZI96rqxCwIxTXvS+oryD+YVnGvQvNRS2mUb7O9OO2pl
         Ijl8q3nUjsy5feaagYli9TFVRVDbx9HsHxqf8fqGWayMpIT7DKg4shJLlIASMz7CKqz7
         F/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyGDQpMVH1rTLSPHW8HYSc7W3EA/zyjV2dF3PYsHi3Q=;
        b=mPDUFFgAJfRH8UmI5oSt8NNbfueUAtZv8MoQmjWvvxjDgA3P4f93RQ0jTm26Sl/jW8
         9d4G5g6y8OwoH9Zpf/zKTZYOa6iRAy+aZW/xrpzvjrE6shNRXq/pA6jFV4HZ0aGySPp0
         aeRifUKpJ9Ykubm1KPtRWEFsep9c8rVFVLmYVk5FXKfmfGJjBqM7bb7PMUVNGvQn1BKC
         ifTEchEDPzfP80Y1dNnRPLu345szCVHZGvwshN0YTdFjP6BIo+2qAl2CGSLyonOyMi35
         3NP0aNA1GWEz0p9OY6BaH3s4VmgemerLsf10f2+F5+fFK822A5UBLiKmqQV25RUlHfqY
         Dfog==
X-Gm-Message-State: APjAAAVdWpQGau9j3KEeRc9gMgnI/dCSrU/rFlphINhHYOm6Yfve9ob4
        tdcdEDbDUGnl+F6OzxHGLQ==
X-Google-Smtp-Source: APXvYqzyacEanqFQQQ+vcwvNkDJwvu07G/fpB1SS9gohpiMss/vqRXqUxyO6k9j4a/b9Ri4nA/+mGg==
X-Received: by 2002:a6b:1787:: with SMTP id 129mr263688iox.140.1568666792487;
        Mon, 16 Sep 2019 13:46:32 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:31 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/9] pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state seqid
Date:   Mon, 16 Sep 2019 16:44:16 -0400
Message-Id: <20190916204419.21717-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-6-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
 <20190916204419.21717-4-trond.myklebust@hammerspace.com>
 <20190916204419.21717-5-trond.myklebust@hammerspace.com>
 <20190916204419.21717-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a LAYOUTRETURN receives a reply of NFS4ERR_OLD_STATEID then assume we've
missed an update, and just bump the stateid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  2 +-
 fs/nfs/pnfs.c     | 18 ++++++++++++++----
 fs/nfs/pnfs.h     |  4 ++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a5deb00b5ad1..cbaf6b7ac128 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9069,7 +9069,7 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	server = NFS_SERVER(lrp->args.inode);
 	switch (task->tk_status) {
 	case -NFS4ERR_OLD_STATEID:
-		if (nfs4_layoutreturn_refresh_stateid(&lrp->args.stateid,
+		if (nfs4_layout_refresh_old_stateid(&lrp->args.stateid,
 					&lrp->args.range,
 					lrp->args.inode))
 			goto out_restart;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index abc7188f1853..bb80034a7661 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -359,9 +359,10 @@ pnfs_clear_lseg_state(struct pnfs_layout_segment *lseg,
 }
 
 /*
- * Update the seqid of a layout stateid
+ * Update the seqid of a layout stateid after receiving
+ * NFS4ERR_OLD_STATEID
  */
-bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
+bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
 		struct inode *inode)
 {
@@ -377,7 +378,15 @@ bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
 
 	spin_lock(&inode->i_lock);
 	lo = NFS_I(inode)->layout;
-	if (lo && nfs4_stateid_match_other(dst, &lo->plh_stateid)) {
+	if (lo &&  pnfs_layout_is_valid(lo) &&
+	    nfs4_stateid_match_other(dst, &lo->plh_stateid)) {
+		/* Is our call using the most recent seqid? If so, bump it */
+		if (!nfs4_stateid_is_newer(&lo->plh_stateid, dst)) {
+			nfs4_stateid_seqid_inc(dst);
+			ret = true;
+			goto out;
+		}
+		/* Try to update the seqid to the most recent */
 		err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
 		if (err != -EBUSY) {
 			dst->seqid = lo->plh_stateid.seqid;
@@ -385,6 +394,7 @@ bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
 			ret = true;
 		}
 	}
+out:
 	spin_unlock(&inode->i_lock);
 	pnfs_free_lseg_list(&head);
 	return ret;
@@ -1475,7 +1485,7 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
 		return 0;
 	case -NFS4ERR_OLD_STATEID:
-		if (!nfs4_layoutreturn_refresh_stateid(&arg->stateid,
+		if (!nfs4_layout_refresh_old_stateid(&arg->stateid,
 					&arg->range, inode))
 			break;
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 3ef3756d437c..f8a38065c7e4 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -261,7 +261,7 @@ int pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
 		bool is_recall);
 int pnfs_destroy_layouts_byclid(struct nfs_client *clp,
 		bool is_recall);
-bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
+bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
 		struct inode *inode);
 void pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo);
@@ -798,7 +798,7 @@ static inline void nfs4_pnfs_v3_ds_connect_unload(void)
 {
 }
 
-static inline bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
+static inline bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
 		struct inode *inode)
 {
-- 
2.21.0

