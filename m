Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5075AEF3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGTM7h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGTM7g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 08:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586B10D2
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689857924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cs+3mPINUu7CIziTneRZX33fBd+VO6ZuLx7iYDNN/64=;
        b=HqX+FKdGvBYW5J2U9k7IREgwgT9pJIwr5Ks00X7OxZkmp2TxV1WvrFwnsaYYJIZ2kzgn/+
        +bejwhe+zlgAKlgop0MJZiz+dGx7gD0W+0T4MOySVuIl1PQFtT8vMNdSDRc+agdS0amLzL
        COPdUiRUmR2JpugR0msYTefszyouC78=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-ifrruSzjNQSZHZhEKdGyDw-1; Thu, 20 Jul 2023 08:58:22 -0400
X-MC-Unique: ifrruSzjNQSZHZhEKdGyDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F19D1044596;
        Thu, 20 Jul 2023 12:58:15 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3832166B25;
        Thu, 20 Jul 2023 12:58:15 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     chuck.lever@oracle.com
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, aahringo@redhat.com, agruenba@redhat.com
Subject: [RFC v6.5-rc2 3/3] fs: lockd: introduce safe async lock op
Date:   Thu, 20 Jul 2023 08:58:06 -0400
Message-Id: <20230720125806.1385279-3-aahringo@redhat.com>
In-Reply-To: <20230720125806.1385279-1-aahringo@redhat.com>
References: <20230720125806.1385279-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
export flag to signal that the "own ->lock" implementation supports
async lock requests. The only main user is DLM that is used by GFS2 and
OCFS2 filesystem. Those implement their own lock() implementation and
return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
("nfs: block notification on fs with its own ->lock") the DLM
implementation were never updated. This patch should prepare for DLM
to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
plock implementation regarding to it.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c       |  5 ++---
 fs/nfsd/nfs4state.c      | 11 ++++++++---
 include/linux/exportfs.h |  1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 62ef27a69a9e..54a67bd33843 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -483,9 +483,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	    struct nlm_host *host, struct nlm_lock *lock, int wait,
 	    struct nlm_cookie *cookie, int reclaim)
 {
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct inode		*inode = nlmsvc_file_inode(file);
-#endif
 	struct nlm_block	*block = NULL;
 	int			error;
 	int			mode;
@@ -499,7 +497,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
-	if (nlmsvc_file_file(file)->f_op->lock) {
+	if (!(inode->i_sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK) &&
+	    nlmsvc_file_file(file)->f_op->lock) {
 		async_block = wait;
 		wait = 0;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e61fa3acaf1..efcea229d640 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7432,6 +7432,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
+	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -7453,6 +7454,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
+	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -7504,7 +7506,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate))
+			if (sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK &&
+			    nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
@@ -7516,7 +7519,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate))
+			if (sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK &&
+			    nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
@@ -7544,7 +7548,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * for file locks), so don't attempt blocking lock notifications
 	 * on those filesystems:
 	 */
-	if (nf->nf_file->f_op->lock)
+	if (!(sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK) &&
+	    nf->nf_file->f_op->lock)
 		fl_flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 11fbd0ee1370..da742abbaf3e 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -224,6 +224,7 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
+#define EXPORT_OP_SAFE_ASYNC_LOCK	(0x40) /* fs can do async lock request */
 	unsigned long	flags;
 };
 
-- 
2.31.1

