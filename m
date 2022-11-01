Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C81614D03
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiKAOq5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiKAOqz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 10:46:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145B1BEA4
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 07:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B881B81DED
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8A4C433C1;
        Tue,  1 Nov 2022 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667314012;
        bh=o6UOuYz2auietgT4/1S7eiLYAmRw6I4SWm3wNjnuvMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjJVHWfH33pALEtWoSd/2BnCr9sB5dcWzgY/PusUk9btiwIzIVBloc1mj9quGrLgh
         khfHs1NQUWwS5LQSRKreBRxKeQSM7QqhpA2TlhYyO/Kp4kVESIVlyUdBS2HAzBnk3Y
         h0hMGl5uwZhYuwCPn/Pij7Y6hgLoM/nbn3qPR1iT3zUzNFmkT1FIrtDUk64/tS4R9h
         RwJW7arEqLCn/JoUPqXhQGiHQlG63G5pHbwlkbLlT74DmpeIWDD9EVgH3ztvmBxgm3
         R4fnSMNoz1NIcuaPZlFuzB5LzpZrnI3CiJINwDSpDRQtPa4WsEhDUGlYPGnq/TMIeH
         eIOqMzrHwyPgQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v5 4/5] nfsd: close race between unhashing and LRU addition
Date:   Tue,  1 Nov 2022 10:46:46 -0400
Message-Id: <20221101144647.136696-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101144647.136696-1-jlayton@kernel.org>
References: <20221101144647.136696-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/nfsd/filecache.c | 50 ++++++++++++++++++++++++++++++---------------
 fs/nfsd/filecache.h |  1 +
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e67297ad12bf..bcea201d79c3 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -409,18 +409,22 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
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
@@ -476,21 +480,31 @@ nfsd_file_put(struct nfsd_file *nf)
 	might_sleep();
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
-		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
-			nfsd_file_schedule_laundrette();
+		if (refcount_dec_not_one(&nf->nf_ref))
 			return;
+
+		/* Try to add it to the LRU.  If that fails, decrement. */
+		if (nfsd_file_lru_add(nf)) {
+			/* If it's still hashed, we're done */
+			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+				nfsd_file_schedule_laundrette();
+				return;
+			}
+
+			/*
+			 * We're racing with unhashing, so try to remove it from
+			 * the LRU. If removal fails, then someone else already
+			 * has our reference and we're done. If it succeeds,
+			 * fall through to decrement.
+			 */
+			if (!nfsd_file_lru_remove(nf))
+				return;
 		}
 	}
 	if (refcount_dec_and_test(&nf->nf_ref))
@@ -594,6 +608,10 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 		return LRU_ROTATE;
 	}
 
+	/* Make sure we're not racing with another removal. */
+	if (!test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags))
+		return LRU_SKIP;
+
 	/*
 	 * Put the reference held on behalf of the LRU. If it wasn't the last
 	 * one, then just remove it from the LRU and ignore it.
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

