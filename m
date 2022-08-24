Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB97D5A031C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 23:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiHXVDV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiHXVDT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 17:03:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2394726A0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 14:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2396B8268D
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 21:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702EC433C1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 21:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661374995;
        bh=c6mkTXsNw3u7HD3wmRWDoIcMEewEimLFOqY+0amyw5Q=;
        h=From:To:Subject:Date:From;
        b=GzEhi/DuB69/7U78iUAsNQzNImxkCJTeZg9mc44I98BsXGnW1Mh8Ym4ys6TAgik4o
         16bGvWg9w6oCmUv3dO3CkLQtyzHoFrED9kvXSDQ2nYiboPVuob3lIrDdBhBFF3U/6+
         wzUE62GbFfxsXfku0JlgHkMgejeZHNoF6/1aDEgEs5yXrE0WkMJGLakUGRn8ukGbCF
         bcP/CJXKSUC1hQpCtb/8jIfKZtIxtj0YdfG+V8zGU0ZwEkl6ws68CuBBXnc4st9K+K
         Nr0D0Mg/bQ+hQAP2FmYPiL4AaQNR3ejp8GvbtlT74+LKoWPKW6NJHAVoPNmFzzmZaI
         jGaO1OQRrOGyw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4/pNFS: Always return layout stats on layout return for flexfiles
Date:   Wed, 24 Aug 2022 16:56:48 -0400
Message-Id: <20220824205648.21345-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We want to ensure that the server never misses the layout stats when
we're closing the file, so that it knows whether or not to update its
internal state. Otherwise, if we were racing with a layout stat, we
might cause the server to invalidate its layout before the layout stat
got processed.

Fixes: 06946c6a3d8b ("pNFS/flexfiles: Only send layoutstats updates for mirrors that were updated")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 5d909dec880a..1ec79ccf89ad 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -30,14 +30,20 @@
 #define FF_LAYOUT_POLL_RETRY_MAX     (15*HZ)
 #define FF_LAYOUTRETURN_MAXERR 20
 
+enum nfs4_ff_op_type {
+	NFS4_FF_OP_LAYOUTSTATS,
+	NFS4_FF_OP_LAYOUTRETURN,
+};
+
 static unsigned short io_maxretrans;
 
 static const struct pnfs_commit_ops ff_layout_commit_ops;
 static void ff_layout_read_record_layoutstats_done(struct rpc_task *task,
 		struct nfs_pgio_header *hdr);
-static int ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
+static int
+ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 			       struct nfs42_layoutstat_devinfo *devinfo,
-			       int dev_limit);
+			       int dev_limit, enum nfs4_ff_op_type type);
 static void ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
 			      const struct nfs42_layoutstat_devinfo *devinfo,
 			      struct nfs4_ff_layout_mirror *mirror);
@@ -2238,8 +2244,9 @@ ff_layout_prepare_layoutreturn(struct nfs4_layoutreturn_args *args)
 			FF_LAYOUTRETURN_MAXERR);
 
 	spin_lock(&args->inode->i_lock);
-	ff_args->num_dev = ff_layout_mirror_prepare_stats(&ff_layout->generic_hdr,
-			&ff_args->devinfo[0], ARRAY_SIZE(ff_args->devinfo));
+	ff_args->num_dev = ff_layout_mirror_prepare_stats(
+		&ff_layout->generic_hdr, &ff_args->devinfo[0],
+		ARRAY_SIZE(ff_args->devinfo), NFS4_FF_OP_LAYOUTRETURN);
 	spin_unlock(&args->inode->i_lock);
 
 	args->ld_private->ops = &layoutreturn_ops;
@@ -2473,7 +2480,7 @@ static const struct nfs4_xdr_opaque_ops layoutstat_ops = {
 static int
 ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 			       struct nfs42_layoutstat_devinfo *devinfo,
-			       int dev_limit)
+			       int dev_limit, enum nfs4_ff_op_type type)
 {
 	struct nfs4_flexfile_layout *ff_layout = FF_LAYOUT_FROM_HDR(lo);
 	struct nfs4_ff_layout_mirror *mirror;
@@ -2485,7 +2492,9 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 			break;
 		if (IS_ERR_OR_NULL(mirror->mirror_ds))
 			continue;
-		if (!test_and_clear_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags))
+		if (!test_and_clear_bit(NFS4_FF_MIRROR_STAT_AVAIL,
+					&mirror->flags) &&
+		    type != NFS4_FF_OP_LAYOUTRETURN)
 			continue;
 		/* mirror refcount put in cleanup_layoutstats */
 		if (!refcount_inc_not_zero(&mirror->ref))
@@ -2525,7 +2534,9 @@ ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 	spin_lock(&args->inode->i_lock);
 	ff_layout = FF_LAYOUT_FROM_HDR(NFS_I(args->inode)->layout);
 	args->num_dev = ff_layout_mirror_prepare_stats(&ff_layout->generic_hdr,
-			&args->devinfo[0], dev_count);
+						       &args->devinfo[0],
+						       dev_count,
+						       NFS4_FF_OP_LAYOUTSTATS);
 	spin_unlock(&args->inode->i_lock);
 	if (!args->num_dev) {
 		kfree(args->devinfo);
-- 
2.37.2

