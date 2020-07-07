Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5C216DB1
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGN2H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGGN2G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 09:28:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EB7C061755
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2020 06:28:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C53276218; Tue,  7 Jul 2020 09:28:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C53276218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594128485;
        bh=s4+u2GC1X3VdT8xcmDuh79DF8eh3Aa0J9BAIdRZDFd0=;
        h=Date:To:Cc:Subject:From:From;
        b=LfqHgSY67gAFn1+5OFzVl0+0tNIQp/Hk6ouI4uPgpPQICEuBwenyziTRbUEf/3TMt
         E88Yq8JUkIGWmj2JgrxtY+eQ5b17jITiwI6XGZ+ONNnYywsE/cZi1ec7Zhj1+iGQ7E
         2ObG67aUauqEFC0COryzQ+2tigWDHS9GSR6xMHOI=
Date:   Tue, 7 Jul 2020 09:28:05 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd4: a client's own opens needn't prevent delegations
Message-ID: <20200707132805.GA25846@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We recently fixed lease breaking so that a client's actions won't break
its own delegations.

But we still have an unnecessary self-conflict when granting
delegations: a client's own write opens will prevent us from handing out
a read delegation even when no other client has the file open for write.

Fix that by turning off the checks for conflicting opens under
vfs_setlease, and instead performing those checks in the nfsd code.

We don't depend much on locks here: instead we acquire the delegation,
then check for conflicts, and drop the delegation again if we find any.

The check beforehand is an optimization of sorts, just to avoid
acquiring the delegation unnecessarily.  There's a race where the first
check could cause us to deny the delegation when we could have granted
it.  But, that's OK, delegation grants are optional (and probably not
even a good idea in that case).

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/locks.c          |  3 +++
 fs/nfsd/nfs4state.c | 54 +++++++++++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 7df0f9fa66f4..d5de9039dbd7 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1807,6 +1807,9 @@ check_conflicting_open(struct file *filp, const long arg, int flags)
 
 	if (flags & FL_LAYOUT)
 		return 0;
+	if (flags & FL_DELEG)
+		/* We leave these checks to the caller. */
+		return 0;
 
 	if (arg == F_RDLCK)
 		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bb3d2c32664a..ab5c8857ae5a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4922,6 +4922,32 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	return fl;
 }
 
+static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
+						struct nfs4_file *fp)
+{
+	struct nfs4_clnt_odstate *co;
+	struct file *f = fp->fi_deleg_file->nf_file;
+	struct inode *ino = locks_inode(f);
+	int writes = atomic_read(&ino->i_writecount);
+
+	if (fp->fi_fds[O_WRONLY])
+		writes--;
+	if (fp->fi_fds[O_RDWR])
+		writes--;
+	WARN_ON_ONCE(writes < 0);
+	if (writes > 0)
+		return -EAGAIN;
+	spin_lock(&fp->fi_lock);
+	list_for_each_entry(co, &fp->fi_clnt_odstate, co_perfile) {
+		if (co->co_client != clp) {
+			spin_unlock(&fp->fi_lock);
+			return -EAGAIN;
+		}
+	}
+	spin_unlock(&fp->fi_lock);
+	return 0;
+}
+
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
@@ -4941,9 +4967,12 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 
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
@@ -4973,11 +5002,19 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (!fl)
 		goto out_clnt_odstate;
 
+	status = nfsd4_check_conflicting_opens(clp, fp);
+	if (status) {
+		locks_free_lock(fl);
+		goto out_clnt_odstate;
+	}
 	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
 	if (status)
 		goto out_clnt_odstate;
+	status = nfsd4_check_conflicting_opens(clp, fp);
+	if (status)
+		goto out_clnt_odstate;
 
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
@@ -5059,17 +5096,6 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
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
2.26.2

