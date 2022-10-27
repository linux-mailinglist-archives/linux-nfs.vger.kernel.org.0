Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EA6100AC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 20:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiJ0Sv4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiJ0Sv4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 14:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC4B5B077
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67644B82769
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551FC433D6;
        Thu, 27 Oct 2022 18:51:51 +0000 (UTC)
Subject: [PATCH v6 02/14] NFSD: Revert "NFSD: NFSv4 CLOSE should release an
 nfsd_file immediately"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, jlayton@redhat.com
Date:   Thu, 27 Oct 2022 14:51:50 -0400
Message-ID: <166689671095.90991.11337902983462302822.stgit@klimt.1015granger.net>
In-Reply-To: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
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

This reverts commit 5e138c4a750dc140d881dab4a8804b094bbc08d2.

That commit attempted to make files available to other users as soon
as all NFSv4 clients were done with them, rather than waiting until
the filecache LRU had garbage collected them.

It gets the reference counting wrong, for one thing.

But it also misses that DELEGRETURN should release a file in the
same fashion. In fact, any nfsd_file_put() on an file held open
by an NFSv4 client needs potentially to release the file
immediately...

Clear the way for implementing that idea.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c |   18 ------------------
 fs/nfsd/filecache.h |    1 -
 fs/nfsd/nfs4state.c |    4 ++--
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 29a62db155fb..beb41a507623 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -444,24 +444,6 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_put_noref(nf);
 }
 
-/**
- * nfsd_file_close - Close an nfsd_file
- * @nf: nfsd_file to close
- *
- * If this is the final reference for @nf, free it immediately.
- * This reflects an on-the-wire CLOSE or DELEGRETURN into the
- * VFS and exported filesystem.
- */
-void nfsd_file_close(struct nfsd_file *nf)
-{
-	nfsd_file_put(nf);
-	if (refcount_dec_if_one(&nf->nf_ref)) {
-		nfsd_file_unhash(nf);
-		nfsd_file_lru_remove(nf);
-		nfsd_file_free(nf);
-	}
-}
-
 struct nfsd_file *
 nfsd_file_get(struct nfsd_file *nf)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 357832bac736..6b012ea4bd9d 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -52,7 +52,6 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-void nfsd_file_close(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 bool nfsd_file_is_cached(struct inode *inode);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4e718500a00c..c829b828b6fd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -831,9 +831,9 @@ static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
 			swap(f2, fp->fi_fds[O_RDWR]);
 		spin_unlock(&fp->fi_lock);
 		if (f1)
-			nfsd_file_close(f1);
+			nfsd_file_put(f1);
 		if (f2)
-			nfsd_file_close(f2);
+			nfsd_file_put(f2);
 	}
 }
 


