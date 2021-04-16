Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5436336275B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhDPSAu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhDPSAr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 14:00:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F5C061761
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 11:00:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 305CF724C; Fri, 16 Apr 2021 14:00:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 305CF724C
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5/5] nfsd: grant read delegations to clients holding writes
Date:   Fri, 16 Apr 2021 14:00:18 -0400
Message-Id: <1618596018-9899-5-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1618596018-9899-1-git-send-email-bfields@redhat.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It's OK to grant a read delegation to a client that holds a write, as
long as it's the only client holding the write.

We originally tried to do this in 94415b06eb8a "nfsd4: a client's own
opens needn't prevent delegations", which had to be reverted in
6ee65a773096.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/locks.c          |  3 ++
 fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6125d2de39b8..bcc71c469ede 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1808,6 +1808,9 @@ check_conflicting_open(struct file *filp, const long arg, int flags)
 
 	if (flags & FL_LAYOUT)
 		return 0;
+	if (flags & FL_DELEG)
+		/* We leave these checks to the caller */
+		return 0;
 
 	if (arg == F_RDLCK)
 		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dfe3e39c891c..5c4896773bdd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4976,6 +4976,65 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	return fl;
 }
 
+static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
+					 struct nfs4_file *fp)
+{
+	struct nfs4_ol_stateid *st;
+	struct file *f = fp->fi_deleg_file->nf_file;
+	struct inode *ino = locks_inode(f);
+	int writes;
+
+	writes = atomic_read(&ino->i_writecount);
+	if (!writes)
+		return 0;
+	/*
+	 * There could be multiple filehandles (hence multiple
+	 * nfs4_files) referencing this file, but that's not too
+	 * common; let's just give up in that case rather than
+	 * trying to go look up all the clients using that other
+	 * nfs4_file as well:
+	 */
+	if (fp->fi_aliased)
+		return -EAGAIN;
+	/*
+	 * If there's a close in progress, make sure that we see it
+	 * clear any fi_fds[] entries before we see it decrement
+	 * i_writecount:
+	 */
+	smp_mb__after_atomic();
+
+	if (fp->fi_fds[O_WRONLY])
+		writes--;
+	if (fp->fi_fds[O_RDWR])
+		writes--;
+	if (writes > 0)
+		return -EAGAIN; /* There may be non-NFSv4 writers */
+	/*
+	 * It's possible there are non-NFSv4 write opens in progress,
+	 * but if they haven't incremented i_writecount yet then they
+	 * also haven't called break lease yet; so, they'll break this
+	 * lease soon enough.  So, all that's left to check for is NFSv4
+	 * opens:
+	 */
+	spin_lock(&fp->fi_lock);
+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
+		if (st->st_openstp == NULL /* it's an open */ &&
+		    access_permit_write(st) &&
+		    st->st_stid.sc_client != clp) {
+			spin_unlock(&fp->fi_lock);
+			return -EAGAIN;
+		}
+	}
+	spin_unlock(&fp->fi_lock);
+	/*
+	 * There's a small chance that we could be racing with another
+	 * NFSv4 open.  However, any open that hasn't added itself to
+	 * the fi_stateids list also hasn't called break_lease yet; so,
+	 * they'll break this lease soon enough.
+	 */
+	return 0;
+}
+
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
@@ -4995,9 +5054,12 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 
 	nf = find_readable_file(fp);
 	if (!nf) {
-		/* We should always have a readable file here */
-		WARN_ON_ONCE(1);
-		return ERR_PTR(-EBADF);
+		/*
+		 * We probably could attempt another open and get a read
+		 * delegation, but for now, don't bother until the
+		 * client actually sends us one.
+		 */
+		return ERR_PTR(-EAGAIN);
 	}
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
@@ -5032,6 +5094,9 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		locks_free_lock(fl);
 	if (status)
 		goto out_clnt_odstate;
+	status = nfsd4_check_conflicting_opens(clp, fp);
+	if (status)
+		goto out_unlock;
 
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
@@ -5113,17 +5178,6 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 				goto out_no_deleg;
 			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
 				goto out_no_deleg;
-			/*
-			 * Also, if the file was opened for write or
-			 * create, there's a good chance the client's
-			 * about to write to it, resulting in an
-			 * immediate recall (since we don't support
-			 * write delegations):
-			 */
-			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
-				goto out_no_deleg;
-			if (open->op_create == NFS4_OPEN_CREATE)
-				goto out_no_deleg;
 			break;
 		default:
 			goto out_no_deleg;
-- 
2.30.2

