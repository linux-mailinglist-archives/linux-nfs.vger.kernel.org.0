Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8303ED855
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhHPOBB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhHPOAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 10:00:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C6C0612A3
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 06:59:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6E1307C77; Mon, 16 Aug 2021 09:59:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6E1307C77
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/8] nlm: minor nlm_lookup_file argument change
Date:   Mon, 16 Aug 2021 09:59:21 -0400
Message-Id: <1629122367-18541-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629122367-18541-1-git-send-email-bfields@redhat.com>
References: <1629122367-18541-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It'll come in handy to get the whole nlm_lock.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/lockd/svc4proc.c         |  2 +-
 fs/lockd/svcproc.c          |  2 +-
 fs/lockd/svcsubs.c          | 14 +++++++-------
 include/linux/lockd/lockd.h |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4c10fb5138f1..aa8eca7c38a1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -40,7 +40,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 	/* Obtain file pointer. Not used by FREE_ALL call. */
 	if (filp != NULL) {
-		if ((error = nlm_lookup_file(rqstp, &file, &lock->fh)) != 0)
+		if ((error = nlm_lookup_file(rqstp, &file, lock)) != 0)
 			goto no_locks;
 		*filp = file;
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 4ae4b63b5392..f4e5e0eb30fd 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -69,7 +69,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 	/* Obtain file pointer. Not used by FREE_ALL call. */
 	if (filp != NULL) {
-		error = cast_status(nlm_lookup_file(rqstp, &file, &lock->fh));
+		error = cast_status(nlm_lookup_file(rqstp, &file, lock));
 		if (error != 0)
 			goto no_locks;
 		*filp = file;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 028fc152da22..bbd2bdde4bea 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -82,31 +82,31 @@ static inline unsigned int file_hash(struct nfs_fh *f)
  */
 __be32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
-					struct nfs_fh *f)
+					struct nlm_lock *lock)
 {
 	struct nlm_file	*file;
 	unsigned int	hash;
 	__be32		nfserr;
 
-	nlm_debug_print_fh("nlm_lookup_file", f);
+	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
 
-	hash = file_hash(f);
+	hash = file_hash(&lock->fh);
 
 	/* Lock file table */
 	mutex_lock(&nlm_file_mutex);
 
 	hlist_for_each_entry(file, &nlm_files[hash], f_list)
-		if (!nfs_compare_fh(&file->f_handle, f))
+		if (!nfs_compare_fh(&file->f_handle, &lock->fh))
 			goto found;
 
-	nlm_debug_print_fh("creating file for", f);
+	nlm_debug_print_fh("creating file for", &lock->fh);
 
 	nfserr = nlm_lck_denied_nolocks;
 	file = kzalloc(sizeof(*file), GFP_KERNEL);
 	if (!file)
 		goto out_unlock;
 
-	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
+	memcpy(&file->f_handle, &lock->fh, sizeof(struct nfs_fh));
 	mutex_init(&file->f_mutex);
 	INIT_HLIST_NODE(&file->f_list);
 	INIT_LIST_HEAD(&file->f_blocks);
@@ -117,7 +117,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 	 * We have to make sure we have the right credential to open
 	 * the file.
 	 */
-	if ((nfserr = nlmsvc_ops->fopen(rqstp, f, &file->f_file)) != 0) {
+	if ((nfserr = nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file)) != 0) {
 		dprintk("lockd: open failed (error %d)\n", nfserr);
 		goto out_free;
 	}
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 666f5f310a04..81b71ad2040a 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -286,7 +286,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
  * File handling for the server personality
  */
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
-					struct nfs_fh *);
+					struct nlm_lock *);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_release_lockowner(struct nlm_lock *);
 void		  nlmsvc_mark_resources(struct net *);
-- 
2.31.1

