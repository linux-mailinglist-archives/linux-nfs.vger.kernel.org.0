Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F048611A8B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJ1S5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1S5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BBA1D2B51
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3820562A26
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 18:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDB9C43470;
        Fri, 28 Oct 2022 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666983436;
        bh=NJmStmbj9UXmkjFc0+Ec0WT9PNFAnNPfSrmtnQZ5jFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9WAS2KgoswbDz16wXiy6IchkH7G5dDMRb7tmEfuQM+3T6RgJWjCJNVlp2YZeJunL
         9KlsbR201V04kYx+RHrQst72e+8JtqRIzbpdfM/ajUSHkdmtDDwmC6xSTRg5UYrzVn
         oHpVft1mqj3Twsx/5/71fp4++WHgTQCI7GC2pUEND0envsM3xMSMFvNLPa/a6bPn3i
         YHHuewirylsAOPukbRm4N3mnYNNljexJLqBnkKwZokDRQK2QlRe7llDA9RvdL6iCr2
         khCRwSq/r9HePS5hcetJJvA4wtpqptGvqapEEwB1dfjyBKxz6+FFHNklzvbQKqCy4H
         OQnUvJggP/Pvg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v3 3/4] nfsd: close race between unhashing and LRU addition
Date:   Fri, 28 Oct 2022 14:57:11 -0400
Message-Id: <20221028185712.79863-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028185712.79863-1-jlayton@kernel.org>
References: <20221028185712.79863-1-jlayton@kernel.org>
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

The list_lru_add and list_lru_del functions use list_empty checks to see
whether the object is already on the LRU. That's fine in most cases, but
we occasionally repurpose nf_lru after unhashing. It's possible for an
LRU removal to remove it from a different list altogether if we lose a
race.

Add a new NFSD_FILE_LRU flag, which indicates that the object actually
resides on the LRU and not some other list. Use that when adding and
removing it from the LRU instead of just relying on list_empty checks.

Add an extra HASHED check after adding the entry to the LRU. If it's now
clear, just remove it from the LRU again and put the reference if that
remove is successful.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 44 +++++++++++++++++++++++++++++---------------
 fs/nfsd/filecache.h |  1 +
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d928c5e38eeb..47cdc6129a7b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -403,18 +403,22 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
-		trace_nfsd_file_lru_add(nf);
-		return true;
+	if (!test_and_set_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
+		if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
+			trace_nfsd_file_lru_add(nf);
+			return true;
+		}
 	}
 	return false;
 }
 
 static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
-		trace_nfsd_file_lru_del(nf);
-		return true;
+	if (test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
+		if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
+			trace_nfsd_file_lru_del(nf);
+			return true;
+		}
 	}
 	return false;
 }
@@ -469,20 +473,30 @@ nfsd_file_put(struct nfsd_file *nf)
 {
 	trace_nfsd_file_put(nf);
 
-	/*
-	 * The HASHED check is racy. We may end up with the occasional
-	 * unhashed entry on the LRU, but they should get cleaned up
-	 * like any other.
-	 */
 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
 		/*
-		 * If this is the last reference (nf_ref == 1), then transfer
-		 * it to the LRU. If the add to the LRU fails, just put it as
-		 * usual.
+		 * If this is the last reference (nf_ref == 1), then try to
+		 * transfer it to the LRU.
 		 */
-		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
+		if (refcount_dec_not_one(&nf->nf_ref))
 			return;
+
+		/* Try to add it to the LRU.  If that fails, decrement. */
+		if (nfsd_file_lru_add(nf)) {
+			/* If it's still hashed, we're done */
+			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
+				return;
+
+			/*
+			 * We're racing with unhashing, so try to remove it from
+			 * the LRU. If removal fails, then someone else already
+			 * has our reference and we're done. If it succeeds,
+			 * fall through to decrement.
+			 */
+			if (!nfsd_file_lru_remove(nf))
+				return;
+		}
 	}
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b7efb2c3ddb1..e52ab7d5a44c 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -39,6 +39,7 @@ struct nfsd_file {
 #define NFSD_FILE_PENDING	(1)
 #define NFSD_FILE_REFERENCED	(2)
 #define NFSD_FILE_GC		(3)
+#define NFSD_FILE_LRU		(4)	/* file is on LRU */
 	unsigned long		nf_flags;
 	struct inode		*nf_inode;	/* don't deref */
 	refcount_t		nf_ref;
-- 
2.37.3

