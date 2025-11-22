Return-Path: <linux-nfs+bounces-16665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1FC7C116
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 02:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BD8F4E11AB
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98C26AC3;
	Sat, 22 Nov 2025 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Bcyor0/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQqCo3gn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA82BAF4
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773395; cv=none; b=Hu65MpDvY7CzYvKZKr3yV+YXrd9Rf8hRvr5Byq6ViPV9nOM+NqY31XdTg/FCR0ytOzU0AsUjwl78uWk4jRL13MDhVT7nkTJHKrrzujrORAwkCwnY6ENaXUc2dIhPYl/PgW4OsVZ7G+P4mDmNEAT+FeUD6pPiymwzX95/fOliGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773395; c=relaxed/simple;
	bh=h0R474SkDB9S/doWFMAt8Ed6Db3hl1OV+uEfMnSxfWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHYS+3Vm0Q3x+yDQdCB7NhIPIrQ7TCc72v5SLI1Pt1FuqGF/Gu2NM7ynQUUMhjo2KQfZRXojPfCNxCWlWMVZQ0kcODVmRW7Rf+D3+RwtPi4aSiZGW/jPLUW5ZjWssAiUcFH9mUY6uDvAQkGKxqtrdsnP6jqXZror7jCQbAPvzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Bcyor0/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQqCo3gn; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BB40EC0101;
	Fri, 21 Nov 2025 20:03:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 20:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763773392;
	 x=1763859792; bh=VdEa2lL+BdysjCKht8b8WdYbVsSCQdnxUv/UqOfqiWA=; b=
	Bcyor0/hxfL9L1U2fpnUpCnr/PPWXbF4/8yTq2GglA8mckWkaLUtpe0rMnuoweIn
	k++L5tvipcQK0NT5Cv6yJ3qtuf0G78bX7LHzmd4oxAIVKUnL+eH2AJXvyD21H/aq
	9u8hxk28gEXAjpcNXvR5k5Uhxp7AHuiGtYQN+ZRB8hLvJaRqNknEMVj4ziT0LsOQ
	3l4C+UKXVfajyhGOC1krstxXgA0Y3xYPFJoUVBVubYdIoWk8zCxYq8F4q5O4oanp
	GFowuPwY3xKTgKFnH1aa59wwE05Ew2nWABRB7ArJxZ+MEmUIxnbTUxgdCA2KngI9
	9i/2Q/op0CQ/M6YFJj8/bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763773392; x=1763859792; bh=V
	dEa2lL+BdysjCKht8b8WdYbVsSCQdnxUv/UqOfqiWA=; b=LQqCo3gnQC7vMAj63
	0dM7QLV/x2a5Pn2Q6dLGdUdFNWwpHAFGS2ZKVpi4XoBn0cgHL1LRRo5jw+t6tm4h
	zVu+MKCBiiN4pezieZTKgx2vINaKsXuv2mK+EgAXkYPEH8X19zpn8l4d71IxW0iH
	+faZOAGXphRCV2LH74Fd35yBLnWrZ9L/mBFZSqus4dppjLwEtn9yPnvZt0TGcF2T
	6E6TCmEvK8Y1TO1NMwn1T6HsEv9IDpHYEiqmAbpmtlpocS5WghtWn2LuG+nf1vz3
	a/ljVTKDKgMd2oFjXYWy60m7/sFqMakMU9EUzzIKo3rA6mPwcXA7aO1qN9dyJkmQ
	BIACw==
X-ME-Sender: <xms:0AshackQATMzLMLZ_5Cot8FTBvCiRQZNNNrhWbb9uMgqDfTywy-KTg>
    <xme:0Ashafj8RWv8h5pWWycSAp7YktndaGEUViKmB_gbeNshx_zm8Y9RTa6RdmigwN65F
    wZOY0_HCBUxkRVycgpAt_8v4W--vgZu1PZxz9sip1mQNoPwYg>
X-ME-Received: <xmr:0AshaUfgdhslDA8vOwc87Wur0MsHyqPSxAoRVWMPtJoTAVFm1w5Y_j0fKCq27iYHiOWhFtVpCBGwGeFO-GX7K3nxHDYnnGJXx4SC7t4HAgX9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfevjeduvdeufeeileefteegudetheetffdtjeegvdfgtdetjeeihfeigeffffehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0Ashafi3frY9Arb3iBd_nYTXWOf9zYr86-zqJmXr0yfBjSNEE649Hg>
    <xmx:0AshaczzUpyBqwwlCp21gC95FBXSIbBbh7Oo11fOwX0Ke5_kZzFCaw>
    <xmx:0AshabM0m03ytxWQJBpq-YIxrwyk6Bz7GTszRBeyjkOk7FQZtOFj-w>
    <xmx:0AshadW4ellX5yCtYWknirEcP1nMlq0uRF2l5V6VXRmCYPQvlvi-Tw>
    <xmx:0AshaSFXsZfd8BS_A5MhMFTluKTnyaLOUBmWLBqBEokvin3XqK7EwIEw>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 20:03:10 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] lockd: fix vfs_test_lock() calls
Date: Sat, 22 Nov 2025 12:00:36 +1100
Message-ID: <20251122010253.3445570-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122010253.3445570-1-neilb@ownmail.net>
References: <20251122010253.3445570-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Usage of vfs_test_lock() is somewhat confused.  Documentation suggests
it is given a "lock" but this is not the case.  It is given a struct
file_lock which contains some details of the sort of lock it should be
looking for.

In particular passing a "file_lock" containing fl_lmops or fl_ops is
meaningless and possibly confusing.

This is particularly problematic in lockd.  nlmsvc_testlock() receives
an initialised "file_lock" from xdr-decode, including manager ops and an
owner.  It then mistakenly passes this to vfs_test_lock() which might
replace the owner and the ops.  This can lead to confusion when freeing
the lock.

The primary role of the 'struct file_lock' passed to vfs_test_lock() is
to report a conflicting lock that was found, so it makes more sense for
nlmsvc_testlock() to pass "conflock", which it uses for returning the
conflicting lock.

With this change, freeing of the lock is not confused and code in
__nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.

Documentation for vfs_test_lock() is improved to reflect its real
purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
future.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes: https://lore.kernel.org/all/20251021130506.45065-1-okorniev@redhat.com
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v1:
- use conflock more consistently in nlmsvc_testlock()
---
 fs/lockd/svc4proc.c |  4 +---
 fs/lockd/svclock.c  | 21 ++++++++++++---------
 fs/lockd/svcproc.c  |  5 +----
 fs/locks.c          | 12 ++++++++++--
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 109e5caae8c7..4b6f18d97734 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST4        called\n");
@@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.c.flc_owner;
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
 				       &resp->lock);
@@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
 
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index a31dc9588eb8..d66e82851599 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	}
 
 	mode = lock_to_openmode(&lock->fl);
-	error = vfs_test_lock(file->f_file[mode], &lock->fl);
+	locks_init_lock(&conflock->fl);
+	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
+	conflock->fl.c.flc_file = lock->fl.c.flc_file;
+	conflock->fl.fl_start = lock->fl.fl_start;
+	conflock->fl.fl_end = lock->fl.fl_end;
+	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
+	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error == FILE_LOCK_DEFERRED)
@@ -637,22 +643,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	if (lock->fl.c.flc_type == F_UNLCK) {
+	if (conflock->fl.c.flc_type == F_UNLCK) {
 		ret = nlm_granted;
 		goto out;
 	}
 
 	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
-		lock->fl.c.flc_type, (long long)lock->fl.fl_start,
-		(long long)lock->fl.fl_end);
+		conflock->fl.c.flc_type, (long long)conflock->fl.fl_start,
+		(long long)conflock->fl.fl_end);
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = lock->fl.c.flc_pid;
-	conflock->fl.c.flc_type = lock->fl.c.flc_type;
-	conflock->fl.fl_start = lock->fl.fl_start;
-	conflock->fl.fl_end = lock->fl.fl_end;
-	locks_release_private(&lock->fl);
+	conflock->svid = conflock->fl.c.flc_pid;
+	locks_release_private(&conflock->fl);
 
 	ret = nlm_lck_denied;
 out:
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f53d5177f267..5817ef272332 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST          called\n");
@@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.c.flc_owner;
-
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
 						   &argp->lock, &resp->lock));
@@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
 
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..bf5e0d05a026 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2185,13 +2185,21 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 /**
  * vfs_test_lock - test file byte range lock
  * @filp: The file to test lock for
- * @fl: The lock to test; also used to hold result
+ * @fl: The byte-range in the file to test; also used to hold result
  *
+ * On entry, @fl does not contain a lock, but identifies a range (fl_start, fl_end)
+ * in the file (c.flc_file), and an owner (c.flc_owner) for whom existing locks
+ * should be ignored.  c.flc_type and c.flc_flags are ignored.
+ * Both fl_lmops and fl_ops in @fl must be NULL.
  * Returns -ERRNO on failure.  Indicates presence of conflicting lock by
- * setting conf->fl_type to something other than F_UNLCK.
+ * setting fl->fl_type to something other than F_UNLCK.
+ *
+ * If vfs_test_lock() does find a lock and return it, the caller must
+ * use locks_free_lock() or locks_release_private() on the returned lock.
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
+	WARN_ON_ONCE(fl->fl_ops || fl->fl_lmops);
 	WARN_ON_ONCE(filp != fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
-- 
2.50.0.107.gf914562f5916.dirty


