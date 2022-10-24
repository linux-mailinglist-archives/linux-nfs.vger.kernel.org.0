Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F259760BF66
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJYASF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJYARr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:17:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD01F9D5
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64759B811E3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 22:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB88AC433D7;
        Mon, 24 Oct 2022 22:37:56 +0000 (UTC)
Subject: [PATCH v5 10/13] NFSD: Clean up find_or_add_file()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 24 Oct 2022 18:37:56 -0400
Message-ID: <166665107603.50761.14739774274949415466.stgit@klimt.1015granger.net>
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

Remove the call to find_file_locked() in insert_nfs4_file(). Tracing
shows that over 99% of these calls return NULL. Thus it is not worth
the expense of the extra bucket list traversal. insert_file() already
deals correctly with the case where the item is already in the hash
bucket.

Since insert_nfs4_file() is now just a wrapper around insert_file(),
move the meat of insert_file() into insert_nfs4_file() and get rid
of it.

Name nfs4_file-related helpers consistently. There are already
nfs4_file_yada functions, so let's go with the same convention used
by put_nfs4_file(): insert_nfs4_file().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   64 ++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 373b1d52fcd7..529995a9e916 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4682,24 +4682,42 @@ find_file_locked(const struct svc_fh *fh, unsigned int hashval)
 	return NULL;
 }
 
-static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_fh *fh,
-				     unsigned int hashval)
+static struct nfs4_file * find_file(struct svc_fh *fh)
 {
 	struct nfs4_file *fp;
+	unsigned int hashval = file_hashval(fh);
+
+	rcu_read_lock();
+	fp = find_file_locked(fh, hashval);
+	rcu_read_unlock();
+	return fp;
+}
+
+/*
+ * On hash insertion, identify entries with the same inode but
+ * distinct filehandles. They will all be in the same hash bucket
+ * because nfs4_file's are hashed by the address in the fi_inode
+ * field.
+ */
+static noinline_for_stack struct nfs4_file *
+insert_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
+{
+	unsigned int hashval = file_hashval(fhp);
 	struct nfs4_file *ret = NULL;
 	bool alias_found = false;
+	struct nfs4_file *fi;
 
 	spin_lock(&state_lock);
-	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
+	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
 				 lockdep_is_held(&state_lock)) {
-		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
-			if (refcount_inc_not_zero(&fp->fi_ref))
-				ret = fp;
-		} else if (d_inode(fh->fh_dentry) == fp->fi_inode)
-			fp->fi_aliased = alias_found = true;
+		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
+			if (refcount_inc_not_zero(&fi->fi_ref))
+				ret = fi;
+		} else if (d_inode(fhp->fh_dentry) == fi->fi_inode)
+			fi->fi_aliased = alias_found = true;
 	}
 	if (likely(ret == NULL)) {
-		init_nfs4_file(fh, new);
+		init_nfs4_file(fhp, new);
 		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
 		new->fi_aliased = alias_found;
 		ret = new;
@@ -4708,32 +4726,6 @@ static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_fh *fh,
 	return ret;
 }
 
-static struct nfs4_file * find_file(struct svc_fh *fh)
-{
-	struct nfs4_file *fp;
-	unsigned int hashval = file_hashval(fh);
-
-	rcu_read_lock();
-	fp = find_file_locked(fh, hashval);
-	rcu_read_unlock();
-	return fp;
-}
-
-static struct nfs4_file *
-find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
-{
-	struct nfs4_file *fp;
-	unsigned int hashval = file_hashval(fh);
-
-	rcu_read_lock();
-	fp = find_file_locked(fh, hashval);
-	rcu_read_unlock();
-	if (fp)
-		return fp;
-
-	return insert_file(new, fh, hashval);
-}
-
 static noinline_for_stack void remove_nfs4_file_locked(struct nfs4_file *fi)
 {
 	hlist_del_rcu(&fi->fi_hash);
@@ -5624,7 +5616,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * and check for delegations in the process of being recalled.
 	 * If not found, create the nfs4_file struct
 	 */
-	fp = find_or_add_file(open->op_file, current_fh);
+	fp = insert_nfs4_file(open->op_file, current_fh);
 	if (fp != open->op_file) {
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)


