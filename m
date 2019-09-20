Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB2B8EF8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438185AbfITL0L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:26:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35940 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438179AbfITL0K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:26:10 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so15345663iof.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyGDQpMVH1rTLSPHW8HYSc7W3EA/zyjV2dF3PYsHi3Q=;
        b=fykzTfTBwzW0DpPmM96O/2thXkpM/se4o/onSzRCCJwaboA9Yf76Rzuag5hwT51BJo
         +jKsTbsUaPnJOxVkP+orhbkgcyM9n6S6WsKkIyXIENNGhdiwTRipk92fVmOS6Qz08M0j
         Mv64YCbEC8hKBhbYYu71RApH8peACTNRWanc3CQ2aa1etQB5aacZPi3mhgoO9nah03hZ
         ikFBVC66PvjSZzNX2zvQglqqVQDe9/4QuJMPrIpoFMHRA/BApcEK3Gdam035MK8+ETuH
         vcZnHXYAVgMj1ZII9cG+2AGb8m9G5E552O2SKMlhDwLK7RcM1hqCdSXB51ZGzn2KklfT
         RuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyGDQpMVH1rTLSPHW8HYSc7W3EA/zyjV2dF3PYsHi3Q=;
        b=uglINGAU+42xS+573Ad/SyosQlxHqlKghhXZ0PS9a54ZKjlfPjBuaulsA0Z6FYGOpN
         IuSU01edbf3UzqWGyRD0+wv81G19a2mAo1Ocmw0flG9rAiHChYdqulJliAFR7hkawqjJ
         aLy+BsS4BYd7qCFw2c0MxWZBrukC7xxXCLKltbpft9hpSTKGxAgPtS/OhuQAui7AQlIa
         QExNvhMSV5YgJ6157Wtqe3StmcLgl5W3u19bnKAu8dxhf4Rw7FmLMyQ9T3FAWsdRWD6f
         kQQL+S1WJ9nIQ3Yn2V+heCqfXvGVQ6z75ZuqiBU3mQ34i9UJLRNzZC6y1YiqDo7gRT8Y
         /lfQ==
X-Gm-Message-State: APjAAAW/yx+iNi9ASLcAdQgz+58Vzyd2Lc3Wmk1ji5H8MOcMZDkI0Pm4
        W0jY+1Eyt0GAezPuC94rPA==
X-Google-Smtp-Source: APXvYqybyROkKS23j6MnSgBivnuTOcBOaFIQUqQs6GsXD49JmRnkhp3UJK9BJYAYxAPKut9iOoEDIw==
X-Received: by 2002:a02:b782:: with SMTP id f2mr19267984jam.48.1568978769264;
        Fri, 20 Sep 2019 04:26:09 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:26:08 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 6/9] pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state seqid
Date:   Fri, 20 Sep 2019 07:23:45 -0400
Message-Id: <20190920112348.69496-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-6-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
 <20190920112348.69496-2-trond.myklebust@hammerspace.com>
 <20190920112348.69496-3-trond.myklebust@hammerspace.com>
 <20190920112348.69496-4-trond.myklebust@hammerspace.com>
 <20190920112348.69496-5-trond.myklebust@hammerspace.com>
 <20190920112348.69496-6-trond.myklebust@hammerspace.com>
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

