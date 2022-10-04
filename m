Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7AE5F49CA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJDTlP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDTlO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 15:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9CD5C9D9
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 12:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 078A961504
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 19:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02070C433D6;
        Tue,  4 Oct 2022 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664912472;
        bh=kBS+gCGIPOGuzlTDrwtTuD0DOFgFkBJdJnt9Dy7vHvg=;
        h=From:To:Cc:Subject:Date:From;
        b=CvQH8ezDFYoSYmOLLwAYKHZfpcP9rY2oaLz7NY6ZOJzXhB03o8vNSSnS/N4OeQi/4
         3mJdIHLJQMbnTq7WA1wEVUbhRbgs7vklD2pzDZWhm7yYUNAHFDJZfEEtH7ujzn02RX
         Ok3GG6cCWFUUabKz0O9sk18BFWvRMoAZn03U2PrXYJ9fYQW+KSCXTBwdpprcnjRT1h
         /RROewy160QpuNcYL8wtX+wkc7hXSEncVrAocccsNBWwbzAjk4R5WdzvEHCba9oyyw
         1rojCQtz8b4ewRfK4X+dB2iOMFItnpOKBka0EZrQk9nVS33sf0mmGGMV4sYflphY25
         0h/p1dB9jjfOg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v4] nfsd: rework hashtable handling in nfsd_do_file_acquire
Date:   Tue,  4 Oct 2022 15:41:10 -0400
Message-Id: <20221004194110.120599-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
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

nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
to get a reference after finding it in the hash. Take the
rcu_read_lock() and call rhashtable_lookup directly.

Switch to using rhashtable_lookup_insert_key as well, and use the usual
retry mechanism if we hit an -EEXIST. Rename the "retry" bool to
open_retry, and eliminiate the insert_err goto target.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 52 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

v4: fix sign on -EEXIST comparison
    don't clear the retry flag on an insertion race

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index be152e3e3a80..5399d8b44c45 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.need	= may_flags & NFSD_FILE_MAY_MASK,
 		.net	= SVC_NET(rqstp),
 	};
-	struct nfsd_file *nf, *new;
-	bool retry = true;
+	struct nfsd_file *nf;
+	bool open_retry = true;
 	__be32 status;
+	int ret;
 
 	status = fh_verify(rqstp, fhp, S_IFREG,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
@@ -1055,35 +1056,33 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1091,11 +1090,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1143,13 +1142,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
-- 
2.37.3

