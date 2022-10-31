Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462E461349A
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 12:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJaLhv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJaLhu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 07:37:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E74E0A1
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 04:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B9D9B815DD
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D54AC433C1;
        Mon, 31 Oct 2022 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216266;
        bh=Iml/vUpDlB7CVZpz1m+kdPEVQKBVEJtoxjiDirNvJbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5FV4s8bbkSae/t5Iq4Qkya6agOZKLQo42AVDsvQbrZdLTHozZoSwoUYrXQmYIIxy
         orMantk1bBEDlic0vt6b1yIPBN6Eky7h59WdZ2gyzrN+cqPctZAqzJghFunsCxChB6
         xcIdQXl77CfvsSewSGeisO80OPRF601H9WTx+w/Pvu1REiF29Chq+qTRHcC03gPfF9
         4BPO/5CcEk98jKCm6uy5ClzGmZelQHt7L5tj1hqv9YvH65Lo2G43KHKR4K9RDK82q1
         6/+kB/Ant971JfKN7av9Nexbr9E4KgUv51WCqjmbXTG2R1FuXUap4q3p7mmhI0h/Nf
         LbjKeVeL2JA8Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/5] nfsd: close race between unhashing and LRU addition
Date:   Mon, 31 Oct 2022 07:37:41 -0400
Message-Id: <20221031113742.26480-5-jlayton@kernel.org>
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
2.38.1

