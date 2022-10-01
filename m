Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F325F1BA7
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJAJ71 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 05:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJAJ70 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 05:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB4FCA4D
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 02:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F0660C13
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 09:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B3AC433D6;
        Sat,  1 Oct 2022 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664618360;
        bh=Gl9+k17093OvK30zbaqOaYdUCc0AElMSni0BuMYRnxk=;
        h=From:To:Cc:Subject:Date:From;
        b=MMfHqFZbgDroEj2Sb5sHA2K0Bb4d8EOkcWzeDXsexMBjryIRJ+xyP2fPQgWG8iWfW
         6T3EgeOBAOdt4EtpxaO1F0kCFXHFeOIoCnbXlyDTafI1F76T5G3onVQmLlDm1alJDQ
         HwNxCdSXmsuOBc6y/Q2ucRhHSDnx218Fr0eWcck8y63FUDB9u8heTlCetqkK8P7DEw
         /PmiAHI3pBYBnQcQNmwVSnGrf7AUQJV3Myii2D/8Dfn9Uand5G0O9FgliTsJk+Itex
         yqiYtm23lJbDkahb4D6/XTKnZxBtGJpS0qDZnqGcivXDmbO3uu8hJ4plr/mxBvGRhc
         qCW4E4WMjBAVQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: [PATCH v2] nfsd: nfsd_do_file_acquire should hold rcu_read_lock while getting refs
Date:   Sat,  1 Oct 2022 05:59:18 -0400
Message-Id: <20221001095918.7546-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_file is RCU-freed, so it's possible that one could be found that's
in the process of being freed and the memory recycled. Ensure we hold
the rcu_read_lock while attempting to get a reference on the object.

Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d5c57360b418..f4f75ae2e4ea 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 retry:
 	/* Avoid allocation if the item is already in cache */
+	rcu_read_lock();
 	nf = rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
 				    nfsd_file_rhash_params);
 	if (nf)
 		nf = nfsd_file_get(nf);
+	rcu_read_unlock();
 	if (nf)
 		goto wait_for_construction;
 
@@ -1090,21 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out_status;
 	}
 
+	rcu_read_lock();
 	nf = rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
 					      &key, &new->nf_rhash,
 					      nfsd_file_rhash_params);
+	if (!IS_ERR_OR_NULL(nf)) {
+		nf = nfsd_file_get(nf);
+		nfsd_file_slab_free(&new->nf_rcu);
+	}
+	rcu_read_unlock();
 	if (!nf) {
 		nf = new;
 		goto open_file;
 	}
 	if (IS_ERR(nf))
 		goto insert_err;
-	nf = nfsd_file_get(nf);
-	if (nf == NULL) {
-		nf = new;
-		goto open_file;
-	}
-	nfsd_file_slab_free(&new->nf_rcu);
 
 wait_for_construction:
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
-- 
2.37.3

