Return-Path: <linux-nfs+bounces-22865-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vY8UAfqNPmpkHwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22865-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 16:34:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0736CDF57
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 16:34:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CTfpoRa1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22865-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22865-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 842743054681
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159237C113;
	Fri, 26 Jun 2026 14:31:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CA2D0C62;
	Fri, 26 Jun 2026 14:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484286; cv=none; b=GUyXHz2w2VJJISHjmH24ruhemoUL/R5945P0whURnCgkk2/nHibPF3yRVqNVbJdsaxbhMnSMVosA7OR036+63tdfcES+1WwPUh8XE3IjD+6XXryB5WStdwYjZdpHWVjXyDcBr1HNBorKHcvJ8nwWm5nQHcWt0X81l7Shi545Fto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484286; c=relaxed/simple;
	bh=V1/pvCquSAfD61E3dDguYuTZU5JM7KIVSwqkWlCD7D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ih1GI04kd7a1fHrT6gHPxqIeR2TvysmWBXQrBZp3MEPuxFtMnDTr0I5rfK3zOMKG4aMqvfrD4J0NAjOp0xOfEKariN2DAx8dWlCl7Yw2i8fZl8Ukzc9nYKKFeqfORL0BKgay+pU9MiTUjSN4EHRCztu7R23e1fEnPSFvc7n6y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTfpoRa1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4115B1F000E9;
	Fri, 26 Jun 2026 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782484284;
	bh=pLi5c0mP9yP58ZuekrXgp8QlUCb1Y0XlpMIazqJNvcs=;
	h=From:To:Cc:Subject:Date;
	b=CTfpoRa1mAs/sgXzB6rZmimCMHpfdvDX4Vi+8XHSTG4J16lf+WJ/js38jECMsfxNJ
	 L5Jsr+xKY3gOHo8VmdVxix/DrMVwtfX/ORW4wpiyFUnTYSIJyRn8ZTRffezoOfbupY
	 kD3aiD/gagaVVN9EoAWw8EXC4PLan9GLwolskH0hVhdB6VopQCkw90uZsaMST9KmZ8
	 podhSE390+QTF1EhWwfUtm3GWx7cHPvMdZkvKqTz0gPrLA8ROHBCzGdaNyVrUDQuwE
	 0mAKgzxQAG89hCyUZkIazYftmAb6VQG5gXKmU2eql2N5yST0lP6OEoNreEN1+wwzXx
	 r0QzRsfQfTuTw==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	NeilBrown <neil@brown.name>,
	Tj <tj.iam.tj@proton.me>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.18.y] lockd: fix TEST handling when not all permissions are available.
Date: Fri, 26 Jun 2026 10:31:22 -0400
Message-ID: <20260626143122.71386-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22865-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:neil@brown.name,m:tj.iam.tj@proton.me,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E0736CDF57

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
 fs/lockd/svc4proc.c         | 13 ++++++++++---
 fs/lockd/svclock.c          |  4 +---
 fs/lockd/svcproc.c          | 15 ++++++++++++---
 fs/lockd/svcsubs.c          | 35 +++++++++++++++++++++++++----------
 include/linux/lockd/lockd.h |  2 +-
 5 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4b6f18d97734..75e020a8bfd0 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -26,6 +26,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
+	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
+					   rqstp->rq_proc == NLMPROC_TEST_MSG);
 	__be32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
@@ -46,15 +48,20 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	if (filp != NULL) {
 		int mode = lock_to_openmode(&lock->fl);
 
+		if (is_test)
+			mode = O_RDWR;
+
 		lock->fl.c.flc_flags = FL_POSIX;
 
-		error = nlm_lookup_file(rqstp, &file, lock);
+		error = nlm_lookup_file(rqstp, &file, lock, mode);
 		if (error)
 			goto no_locks;
 		*filp = file;
-
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.c.flc_file = file->f_file[mode];
+		if (is_test)
+			lock->fl.c.flc_file = nlmsvc_file_file(file);
+		else
+			lock->fl.c.flc_file = file->f_file[mode];
 		lock->fl.c.flc_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
 		lock->fl.fl_end = lock->lock_len ?
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index d66e82851599..c35ffa1b4b89 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -611,7 +611,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		struct nlm_lock *conflock)
 {
 	int			error;
-	int			mode;
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
@@ -626,14 +625,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
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
 		/* We can't currently deal with deferred test requests */
 		if (error == FILE_LOCK_DEFERRED)
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 5817ef272332..d98e8d684376 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -55,6 +55,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
+	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
+					   rqstp->rq_proc == NLMPROC_TEST_MSG);
 	int			mode;
 	__be32			error = 0;
 
@@ -70,15 +72,22 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
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
index 9103896164f6..7ea204eadfca 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -82,18 +82,35 @@ int lock_to_openmode(struct file_lock *lock)
  *
  * We have to make sure we have the right credential to open
  * the file.
+ *
+ * mode can be O_RDONLY(0), O_WRONLY(1) or O_RDWR(2). The latter
+ * means success can be achieved with EITHER O_RDONLY or O_WRONLY.
+ * It does NOT mean both read and write are required.
  */
 static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
-	struct file **fp = &file->f_file[mode];
-	__be32	nfserr;
+	__be32 nfserr = nlm_lck_denied_nolocks;
+	__be32 deferred = 0;
+	struct file **fp;
+	int m;
 
-	if (*fp)
-		return 0;
-	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
-	if (nfserr)
-		dprintk("lockd: open failed (error %d)\n", nfserr);
+	for (m = O_RDONLY ; m <= O_WRONLY ; m++) {
+		if (mode != O_RDWR && mode != m)
+			continue;
+
+		fp = &file->f_file[m];
+		if (*fp)
+			return 0;
+		nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
+		if (!nfserr)
+			return 0;
+		if (nfserr == nlm_drop_reply)
+			deferred = nfserr;
+	}
+	if (deferred)
+		return deferred;
+	dprintk("lockd: open failed (error %d)\n", ntohl(nfserr));
 	return nfserr;
 }
 
@@ -103,17 +120,15 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
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
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index c8f0f9458f2c..d9930fc43ca5 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -293,7 +293,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
  * File handling for the server personality
  */
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
-					struct nlm_lock *);
+				  struct nlm_lock *, int);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
 void		  nlmsvc_release_lockowner(struct nlm_lock *);
-- 
2.54.0


