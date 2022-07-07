Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842B956A754
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiGGP6h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiGGP6f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 11:58:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02651261E
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 08:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55361B8228C
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 15:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95DDC3411E;
        Thu,  7 Jul 2022 15:58:31 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Bump the ref count on nf_inode
From:   Chuck Lever <chuck.lever@oracle.com>
To:     jlayton@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 07 Jul 2022 11:58:30 -0400
Message-ID: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The documenting comment for struct nf_file states:

/*
 * A representation of a file that has been opened by knfsd. These are hashed
 * in the hashtable by inode pointer value. Note that this object doesn't
 * hold a reference to the inode by itself, so the nf_inode pointer should
 * never be dereferenced, only used for comparison.
 */

However, nfsd_file_mark_find_or_create() does dereference the pointer stored
in this field.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    3 +++
 fs/nfsd/filecache.h |    4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

Hi Jeff-

I'm still testing this one, but I'm wondering what you think of it.
I did hit a KASAN splat that might be related, but it's not 100%
reproducible.


diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9cb2d590c036..7b43bb427a53 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval,
 		nf->nf_cred = get_current_cred();
 		nf->nf_net = net;
 		nf->nf_flags = 0;
+		ihold(inode);
 		nf->nf_inode = inode;
 		nf->nf_hashval = hashval;
 		refcount_set(&nf->nf_ref, 1);
@@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
 		fput(nf->nf_file);
 		flush = true;
 	}
+	iput(nf->nf_inode);
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
 	return flush;
 }
@@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (nf == NULL)
 		goto open_file;
 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
+	iput(new->nf_inode);
 	nfsd_file_slab_free(&new->nf_rcu);
 
 wait_for_construction:
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 1da0c79a5580..01fbf6e88cce 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -24,9 +24,7 @@ struct nfsd_file_mark {
 
 /*
  * A representation of a file that has been opened by knfsd. These are hashed
- * in the hashtable by inode pointer value. Note that this object doesn't
- * hold a reference to the inode by itself, so the nf_inode pointer should
- * never be dereferenced, only used for comparison.
+ * in the hashtable by inode pointer value.
  */
 struct nfsd_file {
 	struct hlist_node	nf_node;


