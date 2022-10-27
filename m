Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8F6104CA
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiJ0VwX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiJ0VwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:52:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597347C753
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 14:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7F77CE28BB
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 21:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8125DC433D7;
        Thu, 27 Oct 2022 21:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907536;
        bh=dpBtA9eKZ51T3/O+ZUICErSKhL4AZE2SEtv6C4KCcd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG+hPysIwLfEwihl2xdVcmaTxzdMUE4N6CA3unfC7iab6xRyiz2ExvxJTngBr112h
         bCFnaRGfSwe90+K94CyKydq0lljj4pq0gLhJBSOEm63weXSdfdADBCIBd2a9arGJ+G
         XDF2h5JKXThn2pyKz3c5iV7il9AYbufYXH5tNsMPISsKEGdrbJYTf7hABDj3T8j6t1
         Yjd5clrfi/o7UR9MPvR+yK8oWpwVDAncfwl/mTBMZ9yUrZhrRuOGoOra3EkV2XIH/C
         h5ljiFC3tUV4LtyKn+JWH5PZ2EfgXuQa6GATzSfAkJoro1IRkqEcEO/nkHC5cZJT6x
         d6PBI1wzaLbkg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v2 2/3] nfsd: only keep unused entries on the LRU
Date:   Thu, 27 Oct 2022 17:52:12 -0400
Message-Id: <20221027215213.138304-3-jlayton@kernel.org>
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

Currently, nfsd_files live on the LRU once they are added until they are
unhashed. There's no need to keep ones that are actively in use there.

Before incrementing the refcount, do a lockless check for nf_lru being
empty. If it's not then attempt to remove the entry from the LRU. If
that's successful, claim the LRU reference and return it. If the removal
fails (or if the list_head was empty), then just increment the counter
as we normally would.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e63534f4b9f8..d2bbded805d4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -420,14 +420,31 @@ nfsd_file_unhash(struct nfsd_file *nf)
 	return false;
 }
 
-struct nfsd_file *
-nfsd_file_get(struct nfsd_file *nf)
+static struct nfsd_file *
+__nfsd_file_get(struct nfsd_file *nf)
 {
 	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
 		return nf;
 	return NULL;
 }
 
+struct nfsd_file *
+nfsd_file_get(struct nfsd_file *nf)
+{
+	/*
+	 * Do a lockless list_empty check first, before attempting to
+	 * remove it, so we can avoid the spinlock when it's not on the
+	 * list.
+	 *
+	 * If we successfully remove it from the LRU, then we can just
+	 * claim the LRU reference and return it. Otherwise, we need to
+	 * bump the counter the old-fashioned way.
+	 */
+	if (!list_empty(&nf->nf_lru) && nfsd_file_lru_remove(nf))
+		return nf;
+	return __nfsd_file_get(nf);
+}
+
 /**
  * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispose list
  * @nf: nfsd_file to be unhashed and queued
@@ -449,7 +466,7 @@ nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
 		 * to take a reference. If that fails, just ignore
 		 * the file altogether.
 		 */
-		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
+		if (!nfsd_file_lru_remove(nf) && !__nfsd_file_get(nf))
 			return false;
 		list_add(&nf->nf_lru, dispose);
 		return true;
-- 
2.37.3

