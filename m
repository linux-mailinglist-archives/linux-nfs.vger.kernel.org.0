Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96E5F1241
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiI3TP6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiI3TP5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:15:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C5153133
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60882CE2664
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 19:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5690EC433C1;
        Fri, 30 Sep 2022 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664565352;
        bh=sVL8/mHcxst89Ak9xV8H6IlaBJfZIWW4Jyd0gQCnPVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJSYprMjTf4HlST0naPQa46VuR7cWPsk6bjEO7cdzjegMxvM3Diz21KyDrkKUAu1W
         ZdBra1juTit00nu1341oBfavQuW3vC+6+K6QS3LT87XDqpNX2TnVUT7fUaj4WnfRfz
         CWzSpcKgEdjX1jfn8x0O+Ef3mIyIHQDoFes267rZmIUMjIMWO86NWUVtFYCUvHADMS
         nWR6r2y2LoFpQqgidbSuuAhsXo/IckouJcSOn/dCoGEAfU/aKROmJgACcPku5bbzaQ
         mZEcglrrosWT8CQwmsyhhqhdCpnMVP3i7/Rp+HjOy3m9teeY6DumdXLnUFgGvsFaaC
         /l/n14+Y13QDA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfsd: nfsd_do_file_acquire should hold rcu_read_lock while getting refs
Date:   Fri, 30 Sep 2022 15:15:48 -0400
Message-Id: <20220930191550.172087-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191550.172087-1-jlayton@kernel.org>
References: <20220930191550.172087-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d5c57360b418..6237715bd23e 100644
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
 
@@ -1090,16 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out_status;
 	}
 
+	rcu_read_lock();
 	nf = rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
 					      &key, &new->nf_rhash,
 					      nfsd_file_rhash_params);
 	if (!nf) {
+		rcu_read_unlock();
 		nf = new;
 		goto open_file;
 	}
-	if (IS_ERR(nf))
+	if (IS_ERR(nf)) {
+		rcu_read_unlock();
 		goto insert_err;
+	}
 	nf = nfsd_file_get(nf);
+	rcu_read_unlock();
 	if (nf == NULL) {
 		nf = new;
 		goto open_file;
-- 
2.37.3

