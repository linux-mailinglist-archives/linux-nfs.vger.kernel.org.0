Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB66CA128
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Mar 2023 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjC0KVo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjC0KVm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 06:21:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1449EC
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 03:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8957AB80762
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 10:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9269C433EF;
        Mon, 27 Mar 2023 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679912499;
        bh=QEgTDHYxEvqld0eRCHZso2KpeWl69CoDFl1L5CO+ujI=;
        h=From:To:Cc:Subject:Date:From;
        b=JF0bgYUhLDGJDt06P0Q79Sb85S6sl1WsTc3m6F9k0uJQkoUAKuLZpZYHZWGzF7gE2
         9eWUX4WfX+a262eHipS8HoM/FHc2FQIPhO0f0niQE+HBblDDtGTpKVvTOY0PB0VlOd
         NDDrhrV+PgZC0Rcqb+h+wnxIIFQ8IKdeGDIRR0nzRbYXiZWHGmOsJDfILEW0rSz0+p
         NLSgpBGdxVdyq84lwXvEctnSCCDcUfVqo/Oma7Gt4eM0vwfVwsiMd9hUYig1oeZEWp
         MYREMF6FYBakQ0OnRH4Z0z7gmtouDGkVZQjoh69yjfJiLphb32Dkr8o69Ikno26YbQ
         xYfq6Mw0wZt0g==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Zhi Li <yieli@redhat.com>
Subject: [PATCH] nfsd: call op_release, even when op_func returns an error
Date:   Mon, 27 Mar 2023 06:21:37 -0400
Message-Id: <20230327102137.15412-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For ops with "trivial" replies, nfsd4_encode_operation will shortcut
most of the encoding work and skip to just marshalling up the status.
One of the things it skips is calling op_release. This could cause a
memory leak in the layoutget codepath if there is an error at an
inopportune time.

Have the compound processing engine always call op_release, even when
op_func sets an error in op->status. With this change, we also need
nfsd4_block_get_device_info_scsi to set the gd_device pointer to NULL
on error to avoid a double free.

Reported-by: Zhi Li <yieli@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2181403
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/blocklayout.c |  1 +
 fs/nfsd/nfs4xdr.c     | 13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 04697f8dc37d..01d7fd108cf3 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -297,6 +297,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 
 out_free_dev:
 	kfree(dev);
+	gdp->gd_device = NULL;
 	return ret;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e12e5a4ad502..6b675fbdabd0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5402,7 +5402,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	p = xdr_reserve_space(xdr, 8);
 	if (!p) {
 		WARN_ON_ONCE(1);
-		return;
+		goto release;
 	}
 	*p++ = cpu_to_be32(op->opnum);
 	post_err_offset = xdr->buf->len;
@@ -5418,8 +5418,6 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	op->status = encoder(resp, op->status, &op->u);
 	if (op->status)
 		trace_nfsd_compound_encode_err(rqstp, op->opnum, op->status);
-	if (opdesc && opdesc->op_release)
-		opdesc->op_release(&op->u);
 	xdr_commit_encode(xdr);
 
 	/* nfsd4_check_resp_size guarantees enough room for error status */
@@ -5460,11 +5458,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	}
 status:
 	*p = op->status;
+release:
+	if (opdesc && opdesc->op_release)
+		opdesc->op_release(&op->u);
 }
 
-/* 
- * Encode the reply stored in the stateowner reply cache 
- * 
+/*
+ * Encode the reply stored in the stateowner reply cache
+ *
  * XDR note: do not encode rp->rp_buflen: the buffer contains the
  * previously sent already encoded operation.
  */
-- 
2.39.2

