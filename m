Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F760BF63
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJYASB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJYARp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1D39B9E
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF91615ED
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 22:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76699C433D6;
        Mon, 24 Oct 2022 22:37:44 +0000 (UTC)
Subject: [PATCH v5 08/13] NFSD: Clean up nfsd4_init_file()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 24 Oct 2022 18:37:43 -0400
Message-ID: <166665106362.50761.10721045216633477269.stgit@klimt.1015granger.net>
In-Reply-To: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
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

Name nfs4_file-related helpers consistently. There are already
nfs4_file_yada functions, so let's go with the same convention used
by put_nfs4_file(): init_nfs4_file().

Change the @fh parameter to be const pointer for better type safety.

Finally, move the hash insertion operation to the caller. This is
typical for most other "init_object" type helpers, and it is where
most of the other nfs4_file hash table operations are located.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 90c991e500a8..644ff4310fa9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4262,11 +4262,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
 }
 
 /* OPEN Share state helper functions */
-static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
-				struct nfs4_file *fp)
+static void init_nfs4_file(const struct svc_fh *fh, struct nfs4_file *fp)
 {
-	lockdep_assert_held(&state_lock);
-
 	refcount_set(&fp->fi_ref, 1);
 	spin_lock_init(&fp->fi_lock);
 	INIT_LIST_HEAD(&fp->fi_stateids);
@@ -4284,7 +4281,6 @@ static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
 #endif
-	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
 }
 
 void
@@ -4702,7 +4698,8 @@ static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_fh *fh,
 			fp->fi_aliased = alias_found = true;
 	}
 	if (likely(ret == NULL)) {
-		nfsd4_init_file(fh, hashval, new);
+		init_nfs4_file(fh, new);
+		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
 		new->fi_aliased = alias_found;
 		ret = new;
 	}


