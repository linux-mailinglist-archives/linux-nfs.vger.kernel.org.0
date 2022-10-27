Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C36104C9
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiJ0VwX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiJ0VwT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876AA8322E
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 14:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24C576252A
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 21:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27534C433D6;
        Thu, 27 Oct 2022 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907537;
        bh=8hkqMYu2KRLgjE6okpS7rry0RIl22pxOqew2mFBieSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhRBnoinKiWELLmHY/OjZD39f8YVRXmkzIJl8wLsfM3M0Q14jiGriSqUGCqMrcK2k
         YhZoVYl730vcJcTqbSqdAQey/SQLNN4b6BAPMq9O+Azv+hOiFyHpvCAAcok7FELCyY
         pZjCzZg+qf6YE2nK9bp6LULZM1lHDjITN5lKc49vv8c1s3fnLop0P+jbP+BPOQbZ73
         t5qxaznhcBPbn/fsHC3v86oHsx/RK1x1J2v2x7wTQgxCfgvmdbAHLhJ2BkHMgzSXfy
         0GZVjLZA9tBvm2ErQQ7W3dnBrCzebVFrQzUoySblw61LJ6Yi0wKM44nnvsTqDjpyqJ
         Zylqy+32m81aw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding nfsd_file to the LRU
Date:   Thu, 27 Oct 2022 17:52:13 -0400
Message-Id: <20221027215213.138304-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027215213.138304-1-jlayton@kernel.org>
References: <20221027215213.138304-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
so that we can be ready to close it out when the time comes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d2bbded805d4..491d3d9a1870 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 }
 
 static void
-nfsd_file_flush(struct nfsd_file *nf)
+nfsd_file_fsync(struct nfsd_file *nf)
 {
 	struct file *file = nf->nf_file;
 
@@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
 
+static void
+nfsd_file_flush(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+	unsigned long nrpages;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return;
+
+	nrpages = file->f_mapping->nrpages;
+	if (nrpages) {
+		this_cpu_add(nfsd_file_pages_flushed, nrpages);
+		filemap_flush(file->f_mapping);
+	}
+}
+
 static void
 nfsd_file_free(struct nfsd_file *nf)
 {
@@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
 	this_cpu_inc(nfsd_file_releases);
 	this_cpu_add(nfsd_file_total_age, age);
 
-	nfsd_file_flush(nf);
+	nfsd_file_fsync(nf);
 
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
@@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
 
 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
 		/*
-		 * If this is the last reference (nf_ref == 1), then transfer
-		 * it to the LRU. If the add to the LRU fails, just put it as
-		 * usual.
+		 * If this is the last reference (nf_ref == 1), then try
+		 * to transfer it to the LRU.
+		 */
+		if (refcount_dec_not_one(&nf->nf_ref))
+			return;
+
+		/*
+		 * If the add to the list succeeds, try to kick off SYNC_NONE
+		 * writeback. If the add fails, then just fall through to
+		 * decrement as usual.
 		 */
-		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
+		if (nfsd_file_lru_add(nf)) {
+			nfsd_file_flush(nf);
 			return;
+		}
 	}
 	__nfsd_file_put(nf);
 }
-- 
2.37.3

