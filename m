Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C56951C4
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBMUXx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 15:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBMUXv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 15:23:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58EFC7
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 12:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BD3EB818FA
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 20:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E68EC433D2;
        Mon, 13 Feb 2023 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676319827;
        bh=ljJhE+Ys4b4z95EA9LmnwnWjIZt6+qnadHG5M7c/IGg=;
        h=From:To:Cc:Subject:Date:From;
        b=Y544i9molhtTjvi9hMmTe8RMaJlgf4KsBwRndTWlEhvpOkX91pKoCmicB2wUodZ9r
         4Fy9gwM6spF2E+F117RTcL/SblGRWNri/42vmZkXSJdjKmTad3DPAx3d6kuUFzWyPT
         KyU+Mg0WVkKmXjmNxQBu11xsyF8eHsYYoiuey675/5Mo0QTA/uypqKq9eaQNU6+pno
         A2D6LbFN2n5hYF+seWIz7BqmvqCtaxXHmFaql+AyNCUrFc0AHCgVSHjJuoHbMaT1dm
         Mnbwjm2b04xIO1hlyYebV1ZWfByQ60GjMljgl58SVmPDyUngwl5sKnmhtERHTcsmnl
         /95Jvei5TiClg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: allow reaping files that are still under writeback
Date:   Mon, 13 Feb 2023 15:23:46 -0500
Message-Id: <20230213202346.291008-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's no reason to delay reaping an nfsd_file just because its
underlying inode is still under writeback. nfsd just relies on client
activity or the local flusher threads to do writeback.

Holding the file open does nothing to facilitate that, nor does it help
with tracking errors. Just allow it to close and let the kernel do
writeback as it normally would.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e6617431df7c..3b9a10378c83 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -296,19 +296,6 @@ nfsd_file_free(struct nfsd_file *nf)
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
 }
 
-static bool
-nfsd_file_check_writeback(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-	struct address_space *mapping;
-
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return false;
-	mapping = file->f_mapping;
-	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
-		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
-}
-
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
@@ -438,15 +425,6 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	/* We should only be dealing with GC entries here */
 	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
 
-	/*
-	 * Don't throw out files that are still undergoing I/O or
-	 * that have uncleared errors pending.
-	 */
-	if (nfsd_file_check_writeback(nf)) {
-		trace_nfsd_file_gc_writeback(nf);
-		return LRU_SKIP;
-	}
-
 	/* If it was recently added to the list, skip it */
 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
 		trace_nfsd_file_gc_referenced(nf);
-- 
2.39.1

