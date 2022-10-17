Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB69060126C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJQPIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJQPI3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 11:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6C6CD07
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 08:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 724FD6119A
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 15:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA2BC433D6;
        Mon, 17 Oct 2022 15:02:29 +0000 (UTC)
Subject: [PATCH v3 2/7] NFSD: Revert "NFSD: NFSv4 CLOSE should release an
 nfsd_file immediately"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 17 Oct 2022 11:02:28 -0400
Message-ID: <166601894879.1714.15718074867123795605.stgit@manet.1015granger.net>
In-Reply-To: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
References: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
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
---
 fs/nfsd/filecache.c |   18 ------------------
 fs/nfsd/filecache.h |    1 -
 fs/nfsd/nfs4state.c |    4 ++--
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a2adfc247648..b7aa523c2010 100644
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
index 8e8c0c47d67d..f81c198f4ed6 100644
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
index c5d199d7e6b4..2b850de288cf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -820,9 +820,9 @@ static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
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
 


