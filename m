Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21AA5F56CE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJEOz4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJEOzy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 10:55:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C85722C
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 07:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D39B81DED
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A973DC433C1
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:55:49 +0000 (UTC)
Subject: [PATCH RFC 2/9] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 05 Oct 2022 10:55:48 -0400
Message-ID: <166498174879.1527.18235050678404528153.stgit@manet.1015granger.net>
In-Reply-To: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
to get a reference after finding it in the hash. Take the
rcu_read_lock() and call rhashtable_lookup directly.

Switch to using rhashtable_lookup_insert_key as well, and use the usual
retry mechanism if we hit an -EEXIST. Rename the "retry" bool to
open_retry, and eliminiate the insert_err goto target.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   52 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 844c41832d50..a2adfc247648 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1042,9 +1042,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.need	= may_flags & NFSD_FILE_MAY_MASK,
 		.net	= SVC_NET(rqstp),
 	};
-	struct nfsd_file *nf, *new;
-	bool retry = true;
+	bool open_retry = true;
+	struct nfsd_file *nf;
 	__be32 status;
+	int ret;
 
 	status = fh_verify(rqstp, fhp, S_IFREG,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
@@ -1054,35 +1055,33 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	key.cred = get_current_cred();
 
 retry:
-	/* Avoid allocation if the item is already in cache */
-	nf = rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
-				    nfsd_file_rhash_params);
+	rcu_read_lock();
+	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
+			       nfsd_file_rhash_params);
 	if (nf)
 		nf = nfsd_file_get(nf);
+	rcu_read_unlock();
 	if (nf)
 		goto wait_for_construction;
 
-	new = nfsd_file_alloc(&key, may_flags);
-	if (!new) {
+	nf = nfsd_file_alloc(&key, may_flags);
+	if (!nf) {
 		status = nfserr_jukebox;
 		goto out_status;
 	}
 
-	nf = rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
-					      &key, &new->nf_rhash,
-					      nfsd_file_rhash_params);
-	if (!nf) {
-		nf = new;
-		goto open_file;
-	}
-	if (IS_ERR(nf))
-		goto insert_err;
-	nf = nfsd_file_get(nf);
-	if (nf == NULL) {
-		nf = new;
+	ret = rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
+					   &key, &nf->nf_rhash,
+					   nfsd_file_rhash_params);
+	if (likely(ret == 0))
 		goto open_file;
-	}
-	nfsd_file_slab_free(&new->nf_rcu);
+
+	nfsd_file_slab_free(&nf->nf_rcu);
+	if (ret == -EEXIST)
+		goto retry;
+	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
+	status = nfserr_jukebox;
+	goto out_status;
 
 wait_for_construction:
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
@@ -1090,11 +1089,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	/* Did construction of this file fail? */
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
 		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
-		if (!retry) {
+		if (!open_retry) {
 			status = nfserr_jukebox;
 			goto out;
 		}
-		retry = false;
+		open_retry = false;
 		nfsd_file_put_noref(nf);
 		goto retry;
 	}
@@ -1142,13 +1141,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	smp_mb__after_atomic();
 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
 	goto out;
-
-insert_err:
-	nfsd_file_slab_free(&new->nf_rcu);
-	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
-	nf = NULL;
-	status = nfserr_jukebox;
-	goto out_status;
 }
 
 /**


