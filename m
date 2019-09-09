Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F5ADAAB
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405127AbfIIODU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40335 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405124AbfIIODT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:19 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so28855110iof.7
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyGDQpMVH1rTLSPHW8HYSc7W3EA/zyjV2dF3PYsHi3Q=;
        b=lWL9zRREs4pLUigibgs5ZhvSqdkP/8q+dlfV6lbUY8ccn+bzbF9K8kukrUnMYXU9Eh
         Xt5hi+dBXiJAUgmWWPyjtBRku+ZBv3c+ZA1o35QM7mIp2HeqMsytsd/Kb1U9lYopJNMb
         Bg6GF8OOx3tS2YKASY2o1qYzeAn/WERt+QEx4EAqyuetHqdUOjrouWuNZ3rQNK7RSB+R
         qzCVH0hjNosmBiqNT0SIZB//3fP8jY1Or/UgK6hWHmio3ayMqTcnqtsIljb5gQCd4fh4
         eeHAKiMJlEXTb6TFvKtxQVf6pJMH2PMsdeoKDM7aMZm32rsEEyb4ysmLIPVFBl2rdfKi
         j3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyGDQpMVH1rTLSPHW8HYSc7W3EA/zyjV2dF3PYsHi3Q=;
        b=EgLihgJPFbV/Votl++N+1JyLWj+hKj1QVAaf74RU53hNoE/XOd+jqGBQwmZN29DrgG
         2p5BQu43kCzyLze6U++gU13DkVle7KU9GxtkSyi5n/XmQ0LuhT3I5Y3k5wi+q39ENC/F
         6tO92F0XPwyE4ma3B2bQvgBZsoebE15HiSLqCtRLTgevg4AAXhtJsL9Kui9VXQ43oKr7
         YY95wMcwxuwDClnk40FRn+YUb5LX3I8v7svJ3APjkuwCxhB/4TvuSaXQkxw5qUZQhqH3
         skM+OO+0fwC0Lmr3FwCSJqeOAlhSaHlIOuRuclUr9ikCuZZ3hFqbjQi8IOMzst2BdQ3a
         S+ng==
X-Gm-Message-State: APjAAAUNHvAu6OvX9B++F6H/Z8lsani0idP21/71rtDF4gNLgV3GIMun
        diY90p97L482IKr/fQCuptaFwo290w==
X-Google-Smtp-Source: APXvYqzBwueqneJEthfGaYdeAWdqKbKHhyVoC2WL3R7OiRwrBoeikgurNjtaw8Rz7Sq2z5090miKog==
X-Received: by 2002:a05:6638:155:: with SMTP id y21mr25985045jao.112.1568037798786;
        Mon, 09 Sep 2019 07:03:18 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:18 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/9] pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state seqid
Date:   Mon,  9 Sep 2019 10:01:01 -0400
Message-Id: <20190909140104.78818-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-5-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
 <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com>
 <20190909140104.78818-5-trond.myklebust@hammerspace.com>
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

