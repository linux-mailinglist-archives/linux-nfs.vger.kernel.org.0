Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE8613499
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 12:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJaLhv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJaLht (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 07:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B540E0A1
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 04:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272C360FD6
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F48C43470;
        Mon, 31 Oct 2022 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216267;
        bh=boC0H5xYDS03ppWxRULLr7R418rWldngmyeD+hzlI+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBWTFeML+FYyLPghoU4xx4xB9qzxUUlt4YCvtQFfW5GwL1qELsHI1TLsvxMAEVQc6
         hBHwz0nXhhFss6o/M0ECkDwDrSkrfOUQb5hKovx0spPNpF0tHtJL6HUmZrouuE3FOr
         CW1i5ylbJKgoYae8er7P0IERyqbKvIgFG5olsdwTj1SjXhBZtIW1HJTAXNwND6fhVS
         mAZYlQFTQAKn7WwihbolmQHz0G3P/yB8o2SPDHmVmX3CGoJ1dMvA9IGC8+cXKQdE+i
         yasJxx3MMF/eycrKrQaNd9YDyaJ5sihnvmXfHWrbd2ZT77A6c3wVSf4PfG8hDcNzL3
         vmEsexLE+V7mA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v4 5/5] nfsd: start non-blocking writeback after adding nfsd_file to the LRU
Date:   Mon, 31 Oct 2022 07:37:42 -0400
Message-Id: <20221031113742.26480-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031113742.26480-1-jlayton@kernel.org>
References: <20221031113742.26480-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
so that we can be ready to close it when the time comes. This should
help minimize delays when freeing objects reaped from the LRU.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 47cdc6129a7b..c43b6cff03e2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -325,6 +325,20 @@ nfsd_file_fsync(struct nfsd_file *nf)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
 
+static void
+nfsd_file_flush(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+	struct address_space *mapping;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return;
+
+	mapping = file->f_mapping;
+	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		filemap_flush(mapping);
+}
+
 static int
 nfsd_file_check_write_error(struct nfsd_file *nf)
 {
@@ -484,9 +498,14 @@ nfsd_file_put(struct nfsd_file *nf)
 
 		/* Try to add it to the LRU.  If that fails, decrement. */
 		if (nfsd_file_lru_add(nf)) {
-			/* If it's still hashed, we're done */
-			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
+			/*
+			 * If it's still hashed, we can just return now,
+			 * after kicking off SYNC_NONE writeback.
+			 */
+			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+				nfsd_file_flush(nf);
 				return;
+			}
 
 			/*
 			 * We're racing with unhashing, so try to remove it from
-- 
2.38.1

