Return-Path: <linux-nfs+bounces-1215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90508359E9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 04:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B5A282367
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 03:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03E1865;
	Mon, 22 Jan 2024 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LvGLRSAw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ebh8Vqoj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LvGLRSAw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ebh8Vqoj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB91849
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895910; cv=none; b=Yzl17sSE9S5GSsZq8OUG2VRljrPfYbMTfDbIclq2hU6/i5DC5IhnnmEfWU1jXBrIw5untcrD9fnM5PD0o7gb1jAI36KzB4WXbJK1MysL1RYMSWBqZ9kQeJKw0P7Dt21Au1QmdtvEsrWCXNwXLfrIenEDdu3KGrGaStvfUG7nf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895910; c=relaxed/simple;
	bh=Q1iH+/WY1WrUjBV7PWDX0CwRfzkVyhfmLAP1MgP2+xw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=V2en3SiSBRAe0HP9LuOzDLBpjnzkNqREs5Hcx3f+VefRF5Qa0XdE6Rp0vYJ5nDfd9caDCtoD7HYjZYzQkwzN3JTZTWk+m/F+9fFBJv3aYeKSwplYr16B7j62Ch14Vd3su1LRu9+Ty8lcX5aCG8gR6anqxXWTob1BdwT8AfxM3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LvGLRSAw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ebh8Vqoj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LvGLRSAw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ebh8Vqoj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D34822130;
	Mon, 22 Jan 2024 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705895901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LJjgbA7NEQUmc62GSVGQ4XFXaBItMBcdzRj4fr3mKXk=;
	b=LvGLRSAwL5FVg0kVN+YJckjORv7OG1vj4tmJ3zNrb6MPPWrlmCY+Uqov413MGdnpkx+6kj
	9tZkrdBpevOPyvnBO1AKalhWWE2ukmputxKMSw0agNoOSVFTCf1WH7FKdgZItX70fBZkN6
	ivdk4J5xpmQZhP/sFjtsOisnPOFuwiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705895901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LJjgbA7NEQUmc62GSVGQ4XFXaBItMBcdzRj4fr3mKXk=;
	b=Ebh8VqojWl6C26eBug4O//95VA9oGUHWIoKjbmtoetUcMnLmCGLKOUG+FfB5Wrzu6t2lPa
	e04ajKXx6qDynmBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705895901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LJjgbA7NEQUmc62GSVGQ4XFXaBItMBcdzRj4fr3mKXk=;
	b=LvGLRSAwL5FVg0kVN+YJckjORv7OG1vj4tmJ3zNrb6MPPWrlmCY+Uqov413MGdnpkx+6kj
	9tZkrdBpevOPyvnBO1AKalhWWE2ukmputxKMSw0agNoOSVFTCf1WH7FKdgZItX70fBZkN6
	ivdk4J5xpmQZhP/sFjtsOisnPOFuwiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705895901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LJjgbA7NEQUmc62GSVGQ4XFXaBItMBcdzRj4fr3mKXk=;
	b=Ebh8VqojWl6C26eBug4O//95VA9oGUHWIoKjbmtoetUcMnLmCGLKOUG+FfB5Wrzu6t2lPa
	e04ajKXx6qDynmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 543FB137FD;
	Mon, 22 Jan 2024 03:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BVnPAtvnrWVXGwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Jan 2024 03:58:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <Dai.Ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Date: Mon, 22 Jan 2024 14:58:16 +1100
Message-id: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10


The test on so_count in nfsd4_release_lockowner() is nonsense and
harmful.  Revert to using check_for_locks(), changing that to not sleep.

First: harmful.
As is documented in the kdoc comment for nfsd4_release_lockowner(), the
test on so_count can transiently return a false positive resulting in a
return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
clearly a protocol violation and with the Linux NFS client it can cause
incorrect behaviour.

If NFS4_RELEASE_LOCKOWNER is sent while some other thread is still
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

It my testing I see two circumstances when RELEASE_LOCKOWNER is called.
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

Fixes: ce3c4ad7f4ce ("NFSD: Fix possible sleep during nfsd4_release_lockowner=
()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2fa54cfd4882..6dc6340e2852 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7911,14 +7911,16 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_loc=
kowner *lowner)
 {
 	struct file_lock *fl;
 	int status =3D false;
-	struct nfsd_file *nf =3D find_any_file(fp);
+	struct nfsd_file *nf;
 	struct inode *inode;
 	struct file_lock_context *flctx;
=20
+	spin_lock(&fp->fi_lock);
+	nf =3D find_any_file_locked(fp);
 	if (!nf) {
 		/* Any valid lock stateid should have some sort of access */
 		WARN_ON_ONCE(1);
-		return status;
+		goto out;
 	}
=20
 	inode =3D file_inode(nf->nf_file);
@@ -7934,7 +7936,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_locko=
wner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
+out:
+	spin_unlock(&fp->fi_lock);
 	return status;
 }
=20
@@ -7944,10 +7947,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lock=
owner *lowner)
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
@@ -7983,10 +7984,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		spin_unlock(&clp->cl_lock);
 		return nfs_ok;
 	}
-	if (atomic_read(&lo->lo_owner.so_count) !=3D 2) {
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
--=20
2.43.0


