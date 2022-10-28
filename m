Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3956611513
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiJ1Orz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiJ1Orf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 10:47:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9611C202712
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 07:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8334FCE2BD4
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 14:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9583EC433C1;
        Fri, 28 Oct 2022 14:46:45 +0000 (UTC)
Subject: [PATCH v7 02/14] NFSD: Revert "NFSD: NFSv4 CLOSE should release an
 nfsd_file immediately"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, jlayton@redhat.com
Date:   Fri, 28 Oct 2022 10:46:44 -0400
Message-ID: <166696840463.106044.13085937796095110317.stgit@klimt.1015granger.net>
In-Reply-To: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
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
Reviewed-by: NeilBrown <neilb@suse.de>
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
 


