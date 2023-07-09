Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6EE74C64D
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGIPpX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjGIPpV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 11:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B25DD
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 08:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C16160B51
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 15:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC4FC433C8;
        Sun,  9 Jul 2023 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688917517;
        bh=pYf5asTRGr2IDTPpTpJhoJJ+Yd0bIv82qRcBFrTMalw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M8xLBEqD58eVaqf826hbk2iKQ5ZWAQWQ/Nnk2oowyaiokWd/d2bB5aCbiBSE15VfE
         BXveRQZhTZtkvpNMmuICG0OJjcF9woBz7/qGBz1ZlWEpbuYUdHfj+W7WEMtCb3Mq/S
         9I2/A7dPVpG6UJv7fnr2bddkuv77ap3vEFAIhWhw8n96Eaf5lfPkvd5lkQ8Tu6cait
         E++3m2CetuT2+qfvj4sJRG5PMztqOxQXZr9HycYb6UqmLDXdx+Z5yR8R7BNfdWVanE
         Vv+A+z4THRRbHYvi5lo4OVTPpJO9KNAHwhq0zM4KWKooE9OZcS3KpqsKeXJEipq8na
         RZbuqBmPW/XDw==
Subject: [PATCH v1 1/6] NFSD: Refactor nfsd_reply_cache_free_locked()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Sun, 09 Jul 2023 11:45:16 -0400
Message-ID: <168891751661.3964.5239269567232450425.stgit@manet.1015granger.net>
In-Reply-To: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

To reduce contention on the bucket locks, we must avoid calling
kfree() while each bucket lock is held.

Start by refactoring nfsd_reply_cache_free_locked() into a helper
that removes an entry from the bucket (and must therefore run under
the lock) and a second helper that frees the entry (which does not
need to hold the lock).

For readability, rename the helpers nfsd_cacherep_<verb>.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index a8eda1c85829..601298b7f75f 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -110,21 +110,32 @@ nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
 	return rp;
 }
 
+static void nfsd_cacherep_free(struct svc_cacherep *rp)
+{
+	kfree(rp->c_replvec.iov_base);
+	kmem_cache_free(drc_slab, rp);
+}
+
 static void
-nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
-				struct nfsd_net *nn)
+nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
+			    struct svc_cacherep *rp)
 {
-	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
+	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base)
 		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
-		kfree(rp->c_replvec.iov_base);
-	}
 	if (rp->c_state != RC_UNUSED) {
 		rb_erase(&rp->c_node, &b->rb_head);
 		list_del(&rp->c_lru);
 		atomic_dec(&nn->num_drc_entries);
 		nfsd_stats_drc_mem_usage_sub(nn, sizeof(*rp));
 	}
-	kmem_cache_free(drc_slab, rp);
+}
+
+static void
+nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+				struct nfsd_net *nn)
+{
+	nfsd_cacherep_unlink_locked(nn, b, rp);
+	nfsd_cacherep_free(rp);
 }
 
 static void
@@ -132,8 +143,9 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 			struct nfsd_net *nn)
 {
 	spin_lock(&b->cache_lock);
-	nfsd_reply_cache_free_locked(b, rp, nn);
+	nfsd_cacherep_unlink_locked(nn, b, rp);
 	spin_unlock(&b->cache_lock);
+	nfsd_cacherep_free(rp);
 }
 
 int nfsd_drc_slab_create(void)


