Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998CE7AD90F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjIYN2E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjIYN17 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:27:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5328410C
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:27:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB691C433C7;
        Mon, 25 Sep 2023 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648472;
        bh=1k80C0uIrVKZKcMe5vFSypyJGsRR0SMMKu9LX5+FOXg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kVXlJLQvX4Wd1sojMDnEPVrjeXGtWO+u28udnVuB3pA0ktTLoGTk/dskq9wZapC64
         GERKlPeo958Axcu9OaScDkKK1fesIwG8GgFnukeQt5wITmFo2OhvnAwdSd5QLfQkbM
         jb4sxbOQdnjP/ANrU1slhTDn0aW2FfSwyOHI94VRs0JLbJerAj+HrFm4o2BFoXWDnf
         vah1azc/MQr86fkPy18zeEY+EC/HvkHgQGHLcgc123ZXfqyEP3ddT5+v3UCKGenyoR
         jaGE9hFoC0mOWcT5Zub3Agmykfha8bqbHqXfgXfBlh8ReWwtC/uo1ibc1W3GJY7Tzz
         c9A9xlKBFlbJw==
Subject: [PATCH v1 3/8] NFSD: Make @lgp parameter of ->encode_layoutget a
 const pointer
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:27:51 -0400
Message-ID: <169564847171.6013.1770752570260963034.stgit@klimt.1015granger.net>
In-Reply-To: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
References: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This enables callers to be passed const pointer parameters.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayoutxdr.c    |    4 ++--
 fs/nfsd/blocklayoutxdr.h    |    2 +-
 fs/nfsd/flexfilelayoutxdr.c |    4 ++--
 fs/nfsd/flexfilelayoutxdr.h |    2 +-
 fs/nfsd/pnfs.h              |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 1ed2f691ebb9..f8469348e06e 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -16,9 +16,9 @@
 
 __be32
 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
-		struct nfsd4_layoutget *lgp)
+		const struct nfsd4_layoutget *lgp)
 {
-	struct pnfs_block_extent *b = lgp->lg_content;
+	const struct pnfs_block_extent *b = lgp->lg_content;
 	int len = sizeof(__be32) + 5 * sizeof(__be64) + sizeof(__be32);
 	__be32 *p;
 
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index bc5166bfe46b..5f88539e81a1 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -53,7 +53,7 @@ struct pnfs_block_deviceaddr {
 __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
-		struct nfsd4_layoutget *lgp);
+		const struct nfsd4_layoutget *lgp);
 int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 		u32 block_size);
 int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index bb205328e043..5319cb97d8a7 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -17,9 +17,9 @@ struct ff_idmap {
 
 __be32
 nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
-		struct nfsd4_layoutget *lgp)
+		const struct nfsd4_layoutget *lgp)
 {
-	struct pnfs_ff_layout *fl = lgp->lg_content;
+	const struct pnfs_ff_layout *fl = lgp->lg_content;
 	int len, mirror_len, ds_len, fh_len;
 	__be32 *p;
 
diff --git a/fs/nfsd/flexfilelayoutxdr.h b/fs/nfsd/flexfilelayoutxdr.h
index 8e195aeca023..a447efb7759b 100644
--- a/fs/nfsd/flexfilelayoutxdr.h
+++ b/fs/nfsd/flexfilelayoutxdr.h
@@ -45,6 +45,6 @@ struct pnfs_ff_layout {
 __be32 nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
 		struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
-		struct nfsd4_layoutget *lgp);
+		const struct nfsd4_layoutget *lgp);
 
 #endif /* _NFSD_FLEXFILELAYOUTXDR_H */
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index 4f4282d4eeca..d8e1a333fa0a 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -31,8 +31,8 @@ struct nfsd4_layout_ops {
 
 	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
 			struct nfsd4_layoutget *lgp);
-	__be32 (*encode_layoutget)(struct xdr_stream *,
-			struct nfsd4_layoutget *lgp);
+	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
+			const struct nfsd4_layoutget *lgp);
 
 	__be32 (*proc_layoutcommit)(struct inode *inode,
 			struct nfsd4_layoutcommit *lcp);


