Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4F5F123E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiI3TP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiI3TPz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D72153133
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C19246242D
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 19:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD05C433B5;
        Fri, 30 Sep 2022 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664565353;
        bh=olAXaLNvcVyHbeX5iwRpk3Tf0FgMvTKXQEEez5T0iH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHGkT3e4MSL4tkFF7eJdpaVwP89B10ToVRWMCNS+0TXyLWGQ3Nit/VZ/y2bp/qhPR
         zT7Kl9UQs+YOHD00DDGpRp5nPJZtWYug3Cc3+rkhtjzUuiiEahFCNC0gvVu9dfLXGG
         AZb+d9PPxuZ0dyC6fTM0LcXxKiKn6Q/UZkYCsmLcUEEB6nqa8cgywjevnBuA78cPsY
         hnIgNjsFg3nnXiD4e45jzLpUQm4pM0r71uIBPvSwbMP/0DRQETxoPivd3wne267CGE
         x565GBRXvD+DQ834Yb7J2YyQ6OJdcWzhIFCBIZFtF8Nu/S0MQE4CUsssX+q2S08kgn
         qs/usv7k7FAEA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfsd: fix potential race in nfsd_file_close
Date:   Fri, 30 Sep 2022 15:15:49 -0400
Message-Id: <20220930191550.172087-3-jlayton@kernel.org>
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

Once we call nfsd_file_put, there is no guarantee that "nf" can still be
safely accessed. That may have been the last reference.

Change the code to instead check for whether nf_ref is 2 and then unhash
it and put the reference if we're successful.

We might occasionally race with another lookup and end up unhashing it
when it probably shouldn't have been, but that should hopefully be rare
and will just result in the competing lookup having to create a new
nfsd_file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 6237715bd23e..58f4d9267f4a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -461,12 +461,14 @@ nfsd_file_put(struct nfsd_file *nf)
  */
 void nfsd_file_close(struct nfsd_file *nf)
 {
-	nfsd_file_put(nf);
-	if (refcount_dec_if_one(&nf->nf_ref)) {
-		nfsd_file_unhash(nf);
-		nfsd_file_lru_remove(nf);
-		nfsd_file_free(nf);
+	/* One for the reference being put, and one for the hash */
+	if (refcount_read(&nf->nf_ref) == 2) {
+		if (nfsd_file_unhash(nf))
+			nfsd_file_put_noref(nf);
 	}
+	/* put the ref for the stateid */
+	nfsd_file_put(nf);
+
 }
 
 struct nfsd_file *
-- 
2.37.3

