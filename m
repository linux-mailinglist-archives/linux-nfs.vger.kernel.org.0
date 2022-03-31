Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFEC4EDB05
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiCaOCi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCaOCh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 10:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D431706C
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 07:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F6461972
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 14:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C254C340EE;
        Thu, 31 Mar 2022 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648735249;
        bh=dlXH7egcJq8kRwW0gwMkgwIuzQoc62E7Ck/glxNP4SI=;
        h=From:To:Cc:Subject:Date:From;
        b=qXvjYtWe+mUvIMkCqy2IUU4DAYNM3ofTR+A6txMWGeznVomvcPV8mdDbw9JL+8DMi
         UySOC0UlGsur7j+UTajczwkgqKOPjaVz8V/tw+YV30a6EIR/nM68+vin1CEmyd/NcE
         /ilYOD671Q7YXQfWB2ymw98hLTDd1cu7Xda5GaTbQGlZqh6oiSlKeslMwCEp0eykya
         OMgrWwk24i6G1sc5+rsy0iotlvmPGfTvkvrmpwgevES79fKhKX85lQ+hEfKp3YYSQp
         qbPsmBkwM5/sDa3tOh2qyACqSBtW7pBYrW8YQEOq6qrrOe6IrpL2haxD2wLADE6qFm
         asP/meA5S1W6A==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: Fix a write performance regression
Date:   Thu, 31 Mar 2022 09:54:01 -0400
Message-Id: <20220331135402.7187-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The call to filemap_flush() in nfsd_file_put() is there to ensure that
we clear out any writes belonging to a NFSv3 client relatively quickly
and avoid situations where the file can't be evicted by the garbage
collector. It also ensures that we detect write errors quickly.

The problem is this causes a regression in performance for some
workloads.

So try to improve matters by deferring writeback until we're ready to
close the file, and need to detect errors so that we can force the
client to resend.

Tested-by: Jan Kara <jack@suse.cz>
Fixes: b6669305d35a ("nfsd: Reduce the number of calls to nfsd_file_gc()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8bc807c5fea4..9578a6317709 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -235,6 +235,13 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
 }
 
+static void
+nfsd_file_flush(struct nfsd_file *nf)
+{
+	if (nf->nf_file && vfs_fsync(nf->nf_file, 1) != 0)
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
+}
+
 static void
 nfsd_file_do_unhash(struct nfsd_file *nf)
 {
@@ -302,11 +309,14 @@ nfsd_file_put(struct nfsd_file *nf)
 		return;
 	}
 
-	filemap_flush(nf->nf_file->f_mapping);
 	is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
-	nfsd_file_put_noref(nf);
-	if (is_hashed)
+	if (!is_hashed) {
+		nfsd_file_flush(nf);
+		nfsd_file_put_noref(nf);
+	} else {
+		nfsd_file_put_noref(nf);
 		nfsd_file_schedule_laundrette();
+	}
 	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
 		nfsd_file_gc();
 }
@@ -327,6 +337,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del(&nf->nf_lru);
+		nfsd_file_flush(nf);
 		nfsd_file_put_noref(nf);
 	}
 }
@@ -340,6 +351,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del(&nf->nf_lru);
+		nfsd_file_flush(nf);
 		if (!refcount_dec_and_test(&nf->nf_ref))
 			continue;
 		if (nfsd_file_free(nf))
-- 
2.35.1

