Return-Path: <linux-nfs+bounces-1980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B628570D1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A08D1C2259C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D813B2B0;
	Thu, 15 Feb 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQtSSxTc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75C13B2BF
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037733; cv=none; b=KFgrqKWskjlP7KSysl5aghhIsDNvQHYqOz3djPZ+eYrRyIJ0zCrbEaxAUzxbI8mICQp5k/iH8KZ/J+RHyjqYsnIGMggIPPZR+kDg5DCd9W7eVUz9Fws4Hm8ftqQdlvVSXnZD50UJFQmbtU0E+hMIfh8NfXUwGO+eaqCdivLCDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037733; c=relaxed/simple;
	bh=TKgcikG6QZnonjMbV+2czCdP2IYWb0hB8ABhU5JPq08=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/GeR60cMfGy9OPE6aMjTyFjpJfwbwMLEQLBzZ3CyV0H+0cYXJmeblZoJWvp1KzMKQxGk4iVi4DC8O+jILV8+VAcrwZu0shko8dkZnFwy2GTHSU1Md9AFzFeTKlKSYUAuuMxXjuGVDmSQck79tDFwDx/fOok6BDfk10EZQ+fRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQtSSxTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7061C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037732;
	bh=TKgcikG6QZnonjMbV+2czCdP2IYWb0hB8ABhU5JPq08=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=oQtSSxTcbNXmzkbjrCAI0p6qU0z5mvfh8nRqs/fCemggih4QalW1ejH7nK0KqCfzn
	 mh7xV7hknS4Zk90MojMBbe1fzJdlB6JZFc4Ez7I5MW6+AQjMH8OqLZCZSPUrw0vIfF
	 kIZ629X2UsPnw3b4e98ir4Cmg2zXW4SepCfzfPOnBOUPvaWdK9UKyvgaHQvPfUrzrA
	 5BLQoXULqhVEwOop20k5qobKe72cm7+kK7kXjjmFh77xDW+U6pBNTzEpQvgpjbS0/r
	 M5y/dxP2hp3GHnrdRKHyY8TmxmEVzqN+2ATcDhVvIKQz1zgWb0oRLvmOUsW/RXSoWW
	 LffcsETYB00mA==
Subject: [PATCH v2 1/2] nfsd: fix RELEASE_LOCKOWNER
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 15 Feb 2024 17:55:31 -0500
Message-ID: 
 <170803773176.10525.17584355728962235543.stgit@manet.1015granger.net>
In-Reply-To: 
 <170803741752.10525.14867593238471365383.stgit@manet.1015granger.net>
References: 
 <170803741752.10525.14867593238471365383.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit edcf9725150e42beeca42d085149f4c88fa97afd ]

The test on so_count in nfsd4_release_lockowner() is nonsense and
harmful.  Revert to using check_for_locks(), changing that to not sleep.

First: harmful.
As is documented in the kdoc comment for nfsd4_release_lockowner(), the
test on so_count can transiently return a false positive resulting in a
return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
clearly a protocol violation and with the Linux NFS client it can cause
incorrect behaviour.

If RELEASE_LOCKOWNER is sent while some other thread is still
processing a LOCK request which failed because, at the time that request
was received, the given owner held a conflicting lock, then the nfsd
thread processing that LOCK request can hold a reference (conflock) to
the lock owner that causes nfsd4_release_lockowner() to return an
incorrect error.

The Linux NFS client ignores that NFS4ERR_LOCKS_HELD error because it
never sends NFS4_RELEASE_LOCKOWNER without first releasing any locks, so
it knows that the error is impossible.  It assumes the lock owner was in
fact released so it feels free to use the same lock owner identifier in
some later locking request.

When it does reuse a lock owner identifier for which a previous RELEASE
failed, it will naturally use a lock_seqid of zero.  However the server,
which didn't release the lock owner, will expect a larger lock_seqid and
so will respond with NFS4ERR_BAD_SEQID.

So clearly it is harmful to allow a false positive, which testing
so_count allows.

The test is nonsense because ... well... it doesn't mean anything.

so_count is the sum of three different counts.
1/ the set of states listed on so_stateids
2/ the set of active vfs locks owned by any of those states
3/ various transient counts such as for conflicting locks.

When it is tested against '2' it is clear that one of these is the
transient reference obtained by find_lockowner_str_locked().  It is not
clear what the other one is expected to be.

In practice, the count is often 2 because there is precisely one state
on so_stateids.  If there were more, this would fail.

In my testing I see two circumstances when RELEASE_LOCKOWNER is called.
In one case, CLOSE is called before RELEASE_LOCKOWNER.  That results in
all the lock states being removed, and so the lockowner being discarded
(it is removed when there are no more references which usually happens
when the lock state is discarded).  When nfsd4_release_lockowner() finds
that the lock owner doesn't exist, it returns success.

The other case shows an so_count of '2' and precisely one state listed
in so_stateid.  It appears that the Linux client uses a separate lock
owner for each file resulting in one lock state per lock owner, so this
test on '2' is safe.  For another client it might not be safe.

So this patch changes check_for_locks() to use the (newish)
find_any_file_locked() so that it doesn't take a reference on the
nfs4_file and so never calls nfsd_file_put(), and so never sleeps.  With
this check is it safe to restore the use of check_for_locks() rather
than testing so_count against the mysterious '2'.

Fixes: ce3c4ad7f4ce ("NFSD: Fix possible sleep during nfsd4_release_lockowner()")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index faecdbfa01a2..0443fe4e29e1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7736,14 +7736,16 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 {
 	struct file_lock *fl;
 	int status = false;
-	struct nfsd_file *nf = find_any_file(fp);
+	struct nfsd_file *nf;
 	struct inode *inode;
 	struct file_lock_context *flctx;
 
+	spin_lock(&fp->fi_lock);
+	nf = find_any_file_locked(fp);
 	if (!nf) {
 		/* Any valid lock stateid should have some sort of access */
 		WARN_ON_ONCE(1);
-		return status;
+		goto out;
 	}
 
 	inode = locks_inode(nf->nf_file);
@@ -7759,7 +7761,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
+out:
+	spin_unlock(&fp->fi_lock);
 	return status;
 }
 
@@ -7769,10 +7772,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
  * @cstate: NFSv4 COMPOUND state
  * @u: RELEASE_LOCKOWNER arguments
  *
- * The lockowner's so_count is bumped when a lock record is added
- * or when copying a conflicting lock. The latter case is brief,
- * but can lead to fleeting false positives when looking for
- * locks-in-use.
+ * Check if theree are any locks still held and if not - free the lockowner
+ * and any lock state that is owned.
  *
  * Return values:
  *   %nfs_ok: lockowner released or not found
@@ -7808,10 +7809,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		spin_unlock(&clp->cl_lock);
 		return nfs_ok;
 	}
-	if (atomic_read(&lo->lo_owner.so_count) != 2) {
-		spin_unlock(&clp->cl_lock);
-		nfs4_put_stateowner(&lo->lo_owner);
-		return nfserr_locks_held;
+
+	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
+		if (check_for_locks(stp->st_stid.sc_file, lo)) {
+			spin_unlock(&clp->cl_lock);
+			nfs4_put_stateowner(&lo->lo_owner);
+			return nfserr_locks_held;
+		}
 	}
 	unhash_lockowner_locked(lo);
 	while (!list_empty(&lo->lo_owner.so_stateids)) {



