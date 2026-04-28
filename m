Return-Path: <linux-nfs+bounces-21261-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH/5IPsP8WmXcQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21261-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 21:52:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF848B5D6
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 21:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E6C3077DFD
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF537B03A;
	Tue, 28 Apr 2026 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlCe2+M6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654E282F1F
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405672; cv=none; b=OGVA9x2xIU1Ka1tAMIdXncuSuPxHcnanoakyTk34W+D6bCOtrg1+Haf8VuhoE7RmsZm6+UxSrlLL6P7XxXBxWErsznjjgAort15rrthLBPlexJOdT1OL+3gue5RgVjvajSy0kYH5V+tYpLqDQPzkcN1TzV+2AbKgjtkfisiKVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405672; c=relaxed/simple;
	bh=A78D32DaYLqnRIRCTUGK0+dVUmOYhH2XewwnPLm1KEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucwS8SLxQJ7jHaColxndzOiq5Aw7uo764dtJoEVcen0RiKLogrVJnsUn361bLaYD4zJuuTxvJjkNf0qpUDyTXjRsKSW/E6eyvi8/X0vecMWi3ZnzCHd4v+nnFYD7LV7GCBxtcMyXuXMdcGR05sIPwTZPrif4vROtQVrMywtKaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlCe2+M6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D952CC2BCAF;
	Tue, 28 Apr 2026 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777405671;
	bh=A78D32DaYLqnRIRCTUGK0+dVUmOYhH2XewwnPLm1KEY=;
	h=From:To:Cc:Subject:Date:From;
	b=DlCe2+M6PeIn1BHCva8BJU+YhLEU+PLhR2PvtWn//HTrXnKH+sKhyIfbQzW3qimI3
	 zHih67hpNKA5IDHJPaMP0gwNTHZLXXUNUKz0iHQZ9Hz6io8KCIgKEzldH8cky7m9PE
	 mKiN/A3VPLpsLTUuFne4R0u3YEXqkWrq9Q4LOey43NZdycW3ebY3zHBCL5LuR07eC7
	 EsBEPfgVSUUMbuh0jIBsPz3bdigvP8IJ+9mElQTC9KR97x67R/xTtyNlJwD44Fxgzk
	 vLiDSLnP9OQKnhOgYrz4eL0q+5xBwBuF23Yu8WyeBwk1A526kyK3rAsTKW0au0M+6u
	 8kmzfCTwgrRTg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	NeilBrown <neil@brown.name>,
	Tj <tj.iam.tj@proton.me>
Subject: [PATCH v3] lockd: fix TEST handling when not all permissions are available.
Date: Tue, 28 Apr 2026 15:47:44 -0400
Message-ID: <20260428194744.2360735-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17EF848B5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21261-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email,oracle.com:email]

From: NeilBrown <neil@brown.name>

The F_GETLK fcntl can work with either read access or write access or
both.  It can query F_RDLCK and F_WRLCK locks in either case.

However lockd currently treats F_GETLK similar to F_SETLK in that read
access is required to query an F_RDLCK lock and write access is required
to query a F_WRLCK lock.

This is wrong and can cause problems - e.g.  when qemu accesses a
read-only (e.g. iso) filesystem image over NFS (though why it queries
if it can get a write lock - I don't know.  But it does, and this works
with local filesystems).

So we need TEST requests to be handled differently.  To do this:

- change nlm_do_fopen() to accept O_RDWR as a mode and in that case
  succeed if either a O_RDONLY or O_WRONLY file can be opened.
- change nlm_lookup_file() to accept a mode argument from caller,
  instead of deducing base on lock time, and pass that on to nlm_do_fopen()
- change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
  TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
  the same mode as before for other requests.  Also set
   lock->fl.c.flc_file to whichever file is available for TEST requests.
- change nlmsvc_testlock() to also not calculate the mode, but to use
  whatever was stored in lock->fl.c.flc_file.

This behaviour of lockd - requesting O_WRONLY access to TEST for
exclusive locks - has been present at least since git history began.
However it was hidden until recently because knfsd ignored the access
requested by lockd and required only READ access for all locking
requests (unless the underlying filesystem provided an f_op->open
function which checked access permissions).

The commit mentioned in Fixes: below changed nfsd_permission() to NOT
override the access request for LOCK requests and this exposed the bug
that we are now fixing.

Note that there is another issue that this patch does not address.
The flock(.., LOCK_EX) call is permitted on a read-only file descriptor.
Linux NFS maps this to NLM locking as whole-file byte-range locks.
nfsd will see this as though it were fcntl( F_SETLK (F_WRLCK)) and will
now require write access, which it might not be able to get.
It is not clear if this is a problem in practice, or what the best
solution might be.  So no attempt is made to address it.

Reported-by: Tj <tj.iam.tj@proton.me>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1128861
Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h    |  2 +-
 fs/lockd/svc4proc.c |  9 +++++++--
 fs/lockd/svclock.c  |  4 +---
 fs/lockd/svcproc.c  | 15 ++++++++++++---
 fs/lockd/svcsubs.c  | 31 +++++++++++++++++++++----------
 5 files changed, 42 insertions(+), 19 deletions(-)

Changes since v2:
- Rebase on nfsd-testing (v7.1-rc1 ++)
- Handle "drop reply" properly

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index a7c85ab6d4b5..1db6cb352542 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -332,7 +332,7 @@ int		  nlmsvc_dispatch(struct svc_rqst *rqstp);
  * File handling for the server personality
  */
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
-					struct nlm_lock *);
+				  struct nlm_lock *, int);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
 void		  nlmsvc_release_lockowner(struct nlm_lock *);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 5de41e249534..41cab858de57 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -146,8 +146,11 @@ nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
 		    struct nlm_lock *lock, struct nlm_file **filp,
 		    struct nlm4_lock *xdr_lock, unsigned char type)
 {
+	bool is_test = (rqstp->rq_proc == NLMPROC4_TEST ||
+			rqstp->rq_proc == NLMPROC4_TEST_MSG);
 	struct file_lock *fl = &lock->fl;
 	struct nlm_file *file = NULL;
+	int mode;
 	__be32 error;
 
 	if (xdr_lock->fh.len > NFS_MAXFHSIZE)
@@ -170,7 +173,8 @@ nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
 	fl->c.flc_type = type;
 	lockd_set_file_lock_range4(fl, lock->lock_start, lock->lock_len);
 
-	error = nlm_lookup_file(rqstp, &file, lock);
+	mode = is_test ? O_RDWR : lock_to_openmode(fl);
+	error = nlm_lookup_file(rqstp, &file, lock, mode);
 	switch (error) {
 	case nlm_granted:
 		break;
@@ -184,7 +188,8 @@ nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
 	*filp = file;
 
 	fl->c.flc_flags = FL_POSIX;
-	fl->c.flc_file = file->f_file[lock_to_openmode(fl)];
+	fl->c.flc_file = is_test ? nlmsvc_file_file(file)
+				 : file->f_file[mode];
 	fl->c.flc_pid = current->tgid;
 	fl->fl_lmops = &nlmsvc_lock_operations;
 	nlmsvc_locks_init_private(fl, host, (pid_t)lock->svid);
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index b98b1d0ada35..f4520149d6d7 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -613,7 +613,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		struct nlm_lock *conflock)
 {
 	int			error;
-	int			mode;
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%llu, ty=%d, %Ld-%Ld)\n",
@@ -631,14 +630,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	mode = lock_to_openmode(&lock->fl);
 	locks_init_lock(&conflock->fl);
 	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
 	conflock->fl.c.flc_file = lock->fl.c.flc_file;
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
 	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
-	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
+	error = vfs_test_lock(lock->fl.c.flc_file, &conflock->fl);
 	if (error) {
 		ret = nlm_lck_denied_nolocks;
 		goto out;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 749abf8886ba..c0a3487719e2 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -68,6 +68,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
+	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
+					   rqstp->rq_proc == NLMPROC_TEST_MSG);
 	int			mode;
 	__be32			error = 0;
 
@@ -83,15 +85,22 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 	/* Obtain file pointer. Not used by FREE_ALL call. */
 	if (filp != NULL) {
-		error = cast_status(nlm_lookup_file(rqstp, &file, lock));
+		mode = lock_to_openmode(&lock->fl);
+
+		if (is_test)
+			mode = O_RDWR;
+
+		error = cast_status(nlm_lookup_file(rqstp, &file, lock, mode));
 		if (error != 0)
 			goto no_locks;
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
-		mode = lock_to_openmode(&lock->fl);
 		lock->fl.c.flc_flags = FL_POSIX;
-		lock->fl.c.flc_file  = file->f_file[mode];
+		if (is_test)
+			lock->fl.c.flc_file = nlmsvc_file_file(file);
+		else
+			lock->fl.c.flc_file = file->f_file[mode];
 		lock->fl.c.flc_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 344e6c187cde..9da9d6e0b42e 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -83,23 +83,36 @@ int lock_to_openmode(struct file_lock *lock)
  *
  * We have to make sure we have the right credential to open
  * the file.
+ *
+ * @mode is O_RDONLY, O_WRONLY, or O_RDWR. O_RDWR means success
+ * is achieved with EITHER O_RDONLY or O_WRONLY; it does not
+ * require both.
  */
 static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
-	struct file **fp = &file->f_file[mode];
-	__be32 nlmerr = nlm_granted;
+	__be32 nlmerr = nlm__int__failed;
+	__be32 deferred = 0;
 	int error;
+	int m;
 
-	if (*fp)
-		return nlmerr;
+	for (m = O_RDONLY; m <= O_WRONLY; m++) {
+		struct file **fp = &file->f_file[m];
+
+		if (mode != O_RDWR && mode != m)
+			continue;
+		if (*fp)
+			return nlm_granted;
+
+		error = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
+		if (!error)
+			return nlm_granted;
 
-	error = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
-	if (error) {
 		dprintk("lockd: open failed (errno %d)\n", error);
 		switch (error) {
 		case -EWOULDBLOCK:
 			nlmerr = nlm__int__drop_reply;
+			deferred = nlmerr;
 			break;
 		case -ESTALE:
 			nlmerr = nlm__int__stale_fh;
@@ -110,7 +123,7 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 		}
 	}
 
-	return nlmerr;
+	return deferred ? deferred : nlmerr;
 }
 
 /*
@@ -119,17 +132,15 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
  */
 __be32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
-					struct nlm_lock *lock)
+		struct nlm_lock *lock, int mode)
 {
 	struct nlm_file	*file;
 	unsigned int	hash;
 	__be32		nfserr;
-	int		mode;
 
 	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
 
 	hash = file_hash(&lock->fh);
-	mode = lock_to_openmode(&lock->fl);
 
 	/* Lock file table */
 	mutex_lock(&nlm_file_mutex);
-- 
2.53.0


