Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D635F2FB9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 13:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJCLem (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJCLel (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 07:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC542BF8
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 04:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 084F261024
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 11:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDD1C433C1;
        Mon,  3 Oct 2022 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796878;
        bh=Y+LCQgVMDYPe77WM8W2OBUvmI2nata6OGrJH3BbAlTk=;
        h=From:To:Cc:Subject:Date:From;
        b=rU6zaEDcgsINeasGpfiFhkmdmyBVRKUKEgP/gnubTP76jcZiRC4K8UsnD8c4YF2eh
         5FJ+LDgf/SRb05LcVVS2xOVL2xD9OLgX6r0TAhmKJN/HjIk2ekhxO/soHj8vzLS9Ph
         I/fslX+26uefXjbPBcBHr4M1uk6oo53OnmlbWQvDYN2fBQHQDvIQ0Zax5VRNO1O4CX
         /jVfE8tr/ZYAFxiHVkIlOIKB6Yhc92oUqSsNrxBU3IJsmHa3A6L//ZsSW7jHkM4g2h
         spGYGo8TpFxwa5r2ivmkqm3/wvq9Pw4ke/G/fm36TdlF/NEzaWe+LL7WUV6uSwKi1x
         dlFbLLUJItSDA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v3] nfsd: rework hashtable handling in nfsd_do_file_acquire
Date:   Mon,  3 Oct 2022 07:34:36 -0400
Message-Id: <20221003113436.24161-1-jlayton@kernel.org>
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
retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
target as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 46 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index be152e3e3a80..63955f3353ed 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.need	= may_flags & NFSD_FILE_MAY_MASK,
 		.net	= SVC_NET(rqstp),
 	};
-	struct nfsd_file *nf, *new;
+	struct nfsd_file *nf;
 	bool retry = true;
 	__be32 status;
+	int ret;
 
 	status = fh_verify(rqstp, fhp, S_IFREG,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
@@ -1055,35 +1056,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+	if (ret == 0)
 		goto open_file;
+
+	nfsd_file_slab_free(&nf->nf_rcu);
+	if (retry && ret == EEXIST) {
+		retry = false;
+		goto retry;
 	}
-	nfsd_file_slab_free(&new->nf_rcu);
+	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
+	status = nfserr_jukebox;
+	goto out_status;
 
 wait_for_construction:
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
@@ -1143,13 +1144,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
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

