Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4733129C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 16:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHPxB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHPwa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 10:52:30 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D232C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 07:52:30 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F115323D8; Mon,  8 Mar 2021 10:52:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F115323D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1615218749;
        bh=S7t/9AyIqSMCz/QZkxiMpvUUWEWQQwRvlN5H/lRWnqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBxjJPRusyAByLAqlnYSFjvAVILdsH66tPrj+//ebMDbFCqA2jkiI/Q6o2sCGaW/L
         DpHyhwTKAqyDZZdbupSHxkfDG03JyzsAeLJDp5464zDTycZf/8Bd/18VoeGikFnUBq
         sn8eV2gdlOztPxjf7uF5YkmT6pgF0kqg6XW3EYKg=
Date:   Mon, 8 Mar 2021 10:52:29 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] Revert "nfsd4: a client's own opens needn't prevent
 delegations"
Message-ID: <20210308155229.GD7284@fieldses.org>
References: <20210308155151.GC7284@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308155151.GC7284@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This reverts commit 94415b06eb8aed13481646026dc995f04a3a534a.

That commit claimed to allow a client to get a read delegation when it
was the only writer.  Actually it allowed a client to get a read
delegation when *any* client has a write open!

The main problem is that it's depending on nfs4_clnt_odstate structures
that are actually only maintained for pnfs exports.

This causes clients to miss writes performed by other clients, even when
there have been intervening closes and opens, violating close-to-open
cache consistency.

We can do this a different way, but first we should just revert this.

I've added pynfs 4.1 test DELEG19 to test for this, as I should have
done originally!

Cc: stable@vger.kernel.org
Reported-by: Timo Rothenpieler <timo@rothenpieler.org>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/locks.c          |  3 ---
 fs/nfsd/nfs4state.c | 54 ++++++++++++---------------------------------
 2 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 99ca97e81b7a..6125d2de39b8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1808,9 +1808,6 @@ check_conflicting_open(struct file *filp, const long arg, int flags)
 
 	if (flags & FL_LAYOUT)
 		return 0;
-	if (flags & FL_DELEG)
-		/* We leave these checks to the caller. */
-		return 0;
 
 	if (arg == F_RDLCK)
 		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 408e2c4db926..27983a50435e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4940,32 +4940,6 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	return fl;
 }
 
-static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
-						struct nfs4_file *fp)
-{
-	struct nfs4_clnt_odstate *co;
-	struct file *f = fp->fi_deleg_file->nf_file;
-	struct inode *ino = locks_inode(f);
-	int writes = atomic_read(&ino->i_writecount);
-
-	if (fp->fi_fds[O_WRONLY])
-		writes--;
-	if (fp->fi_fds[O_RDWR])
-		writes--;
-	WARN_ON_ONCE(writes < 0);
-	if (writes > 0)
-		return -EAGAIN;
-	spin_lock(&fp->fi_lock);
-	list_for_each_entry(co, &fp->fi_clnt_odstate, co_perfile) {
-		if (co->co_client != clp) {
-			spin_unlock(&fp->fi_lock);
-			return -EAGAIN;
-		}
-	}
-	spin_unlock(&fp->fi_lock);
-	return 0;
-}
-
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
@@ -4985,12 +4959,9 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 
 	nf = find_readable_file(fp);
 	if (!nf) {
-		/*
-		 * We probably could attempt another open and get a read
-		 * delegation, but for now, don't bother until the
-		 * client actually sends us one.
-		 */
-		return ERR_PTR(-EAGAIN);
+		/* We should always have a readable file here */
+		WARN_ON_ONCE(1);
+		return ERR_PTR(-EBADF);
 	}
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
@@ -5020,19 +4991,11 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = nfsd4_check_conflicting_opens(clp, fp);
-	if (status) {
-		locks_free_lock(fl);
-		goto out_clnt_odstate;
-	}
 	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
 	if (status)
 		goto out_clnt_odstate;
-	status = nfsd4_check_conflicting_opens(clp, fp);
-	if (status)
-		goto out_clnt_odstate;
 
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
@@ -5114,6 +5077,17 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 				goto out_no_deleg;
 			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
 				goto out_no_deleg;
+			/*
+			 * Also, if the file was opened for write or
+			 * create, there's a good chance the client's
+			 * about to write to it, resulting in an
+			 * immediate recall (since we don't support
+			 * write delegations):
+			 */
+			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
+				goto out_no_deleg;
+			if (open->op_create == NFS4_OPEN_CREATE)
+				goto out_no_deleg;
 			break;
 		default:
 			goto out_no_deleg;
-- 
2.29.2

