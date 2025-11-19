Return-Path: <linux-nfs+bounces-16501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D783FC6C1B8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D25C128AE0
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2B7A13A;
	Wed, 19 Nov 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="R/aZfhw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sdb8XzTK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BA1B6D08
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511385; cv=none; b=KDyb8sWD5G8VqyUcoFtfoocZNx+VjOtUmElmB8fp0CSRpwunDEPmxEJ+coKcSPrb7sqxMKjFoZFVdniYckUo8Yb9fEveqQ/UuPLVpdNs97557XPFLCtoSlQxo33TMSwkTCcMPD6AaWLEI+Sp94Jxk1e1n7Oh5uBi/miQyp8PGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511385; c=relaxed/simple;
	bh=uIC8kXOzop17MlPBp01xT/o6Tre7//E/G+FpZR3jEWA=;
	h=Content-Type:MIME-Version:From:To:cc:Subject:Date:Message-id; b=WdzQpFABeybMR+nBAhs7EkLY5JqQ3ZSFhQRsyE7rfch0u2PqyCDc8hVANW1xOWtGA+kjTgCKWkR8wp81bsc7eoxTyAKYREyLDjJvNAVxzFupEtcHcjSmR1Bq7EVsnmPL2FC79DX8MyqhYDodY68Xn5C3D3Biu8bqJy2p5Lys/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=R/aZfhw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sdb8XzTK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BC927A01C5;
	Tue, 18 Nov 2025 19:16:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 19:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1763511380; x=
	1763597780; bh=TXfsqv1wrqZS+gCqd8Y9WMZQM19RzkG1YlM0G6Yo5ik=; b=R
	/aZfhw4t4aUe+b/tBS2RgyH+3JML4y/F97FJct4HYz90M5CmRasnQyl3OGJo95gw
	2q5q1xcleEqHPWy5m3WRVmqjeBD53SwxyF/KiTkQR6WJuDsAQxLvgCFAzLm/PWRD
	c2yvwfiMy3reC5RZWKOgGV/n1dJ4RHXtdHXE1+ozUIZN8qaY7xu/2Qv/ROh8UmmW
	cqDOmutXKf1awsU5CFLnR7CpyjhfFzt9w4iQrelJe1v6957Dv6HtCVt2zHiVkSVj
	xSIR1gP6Y22JYIqHNwItZtfOCDim6DLUOnjoDUisJEhmhr7y4bAHhRIDPJIYJSsR
	doitoYft9SdqBU48cOsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1763511380; x=1763597780; bh=TXfsqv1wrqZS+
	gCqd8Y9WMZQM19RzkG1YlM0G6Yo5ik=; b=sdb8XzTKWeoKzuHiJ5Fa+5qrpqbI6
	CtXuOlCm8xqGIxbd2uzpoywEo2MsN0kaTpO7IjU0pRxlcgW78F5hNP6p5TktmfOT
	M+xlsILdD0i1usj3VWpg2KIW0OVkSsvhQZvpK49rFNHNhcbtvS6NpxRddw0VKs/O
	Ot7IvG3mp6RyKKc34xVLqE9sKICYzdEeQ1hU2XZzCBtk4sJbPlV1Ozxra+BZXLrW
	XckxO5jvgs0OdPxbEQ2Ue8BrLATjbp04JyGhhnFQ86PJiu1Cp8gQtPHiD1cSVnfY
	WKG+tg64wQkDxdMXRUAXwD/73RNL9oGry5CXey/w5Gs8FiHBER1QNrs8g==
X-ME-Sender: <xms:VAwdaVcoAXghBHKlqfPPXhD_OeG2v3uMbckS7Wte84PVXBzf1oFyNg>
    <xme:VAwdaW6YYbzl5ToaN1VZL1Ty3Bg-3GtD9VNpKDhLg2PP-gQBEjN9-PCpSUo2tvCqP
    MfsqKXYM9R3wTf79WICfI8O29vU1zcb-tPdqO1gDQj70Iad>
X-ME-Received: <xmr:VAwdaYUVrBavt_EiTuHALD5z83qW_YW5aMrNAlJFZje9z8XNyFqov6t2lU57CB5WUx-SQxJ7cY3KoT4iGeBWxeNrfahDfz8vkVjDnka_A432>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephe
    euhfffkeejvdeuhffggeetteekfffgteehiedvfffhteeiveeitdehgeffuefgnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhpvgih
    rdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtph
    htthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegu
    rghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VAwdaV4XJFOEC5vzcPSPUle7ZWSapLWhLRHH9w0aiaAHvckQm3JDCQ>
    <xmx:VAwdaTo2eki2jcutRDS9SxX_cLrzOxuHphLoRnygFZI6RtzteXm1FQ>
    <xmx:VAwdaYlRaYFh9s5mPu5Zh65hRLQnA4HIwSFGMtxR6ej20w_hdiAWvw>
    <xmx:VAwdafNDbb-hRljXaRJI88khyRernhHr733iNOIDZeowDYinhlVIcw>
    <xmx:VAwdaS8sl-ipCmOyno1d05aQ0Y0edIHYrCZnGcWQQBuQrvSRJ6_eF5fz>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 19:16:18 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org
cc: linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject: [PATCH] lockd: fix vfs_lock_test() calls
Date: Wed, 19 Nov 2025 11:16:14 +1100
Message-id: <176351137459.634289.99556130353777712@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

Usage of vfs_lock_test() is somewhat confused.  Documentation suggests
it is given a "lock" but this is not the case.  It is given a struct
file_lock which contains some details of the sort of lock it should be
looking for.

In particular passing a "file_lock" containing fl_lmops or fl_ops is
meaningless and possibly confusing.

This is particularly problematic in lockd.  nlmsvc_testlock() receives
an initialised "file_lock" from xdr-decode, including manager ops etc.
It them mistakenly passes this to vfs_test_lock() which might replace
the owner and the ops.  This can lead to confusion when freeing the
lock.

The primary role of the 'struct file_lock' is to report a conflicting
lock that was found, so it makes more sense for nlmsvc_testlock() to
pass "conflock", which it used for returning the conflicting lock.

With this change, freeing of the lock is not confused and code in
__nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.

Documentation for vfs_test_lock() is improved to reflect its real
purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
future.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes: https://lore.kernel.org/all/20251021130506.45065-1-okorniev@redhat.com
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/lockd/svc4proc.c |  4 +---
 fs/lockd/svclock.c  | 15 +++++++++------
 fs/lockd/svcproc.c  |  5 +----
 fs/locks.c          |  9 +++++++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 109e5caae8c7..4b6f18d97734 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res =
*resp)
 	struct nlm_args *argp =3D rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc =3D rpc_success;
=20
 	dprintk("lockd: TEST4        called\n");
@@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_re=
s *resp)
 	if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success;
=20
-	test_owner =3D argp->lock.fl.c.flc_owner;
 	/* Now check for conflicting locks */
 	resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock,
 				       &resp->lock);
@@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_re=
s *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
=20
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index a31dc9588eb8..381b837a8c18 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file =
*file,
 	}
=20
 	mode =3D lock_to_openmode(&lock->fl);
-	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
+	locks_init_lock(&conflock->fl);
+	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
+	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
+	conflock->fl.fl_start =3D lock->fl.fl_start;
+	conflock->fl.fl_end =3D lock->fl.fl_end;
+	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
+	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error =3D=3D FILE_LOCK_DEFERRED)
@@ -648,11 +654,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file =
*file,
 	conflock->caller =3D "somehost";	/* FIXME */
 	conflock->len =3D strlen(conflock->caller);
 	conflock->oh.len =3D 0;		/* don't return OH info */
-	conflock->svid =3D lock->fl.c.flc_pid;
-	conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
-	conflock->fl.fl_start =3D lock->fl.fl_start;
-	conflock->fl.fl_end =3D lock->fl.fl_end;
-	locks_release_private(&lock->fl);
+	conflock->svid =3D conflock->fl.c.flc_pid;
+	locks_release_private(&conflock->fl);
=20
 	ret =3D nlm_lck_denied;
 out:
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f53d5177f267..5817ef272332 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res=
 *resp)
 	struct nlm_args *argp =3D rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc =3D rpc_success;
=20
 	dprintk("lockd: TEST          called\n");
@@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res=
 *resp)
 	if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success;
=20
-	test_owner =3D argp->lock.fl.c.flc_owner;
-
 	/* Now check for conflicting locks */
 	resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
 						   &argp->lock, &resp->lock));
@@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res=
 *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
=20
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..14dad411ef88 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2185,13 +2185,18 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int=
, cmd)
 /**
  * vfs_test_lock - test file byte range lock
  * @filp: The file to test lock for
- * @fl: The lock to test; also used to hold result
+ * @fl: The byte-range in the file to test; also used to hold result
  *
+ * On entry, @fl does not contain a lock, but identifies a range (fl_start, =
fl_end)
+ * in the file (c.flc_file), and an owner (c.flc_owner) for whom existing lo=
cks
+ * should be ignored.  c.flc_type and c.flc_types are ignored.
+ * Both fl_lmops and fl_ops in @fl must be NULL.
  * Returns -ERRNO on failure.  Indicates presence of conflicting lock by
- * setting conf->fl_type to something other than F_UNLCK.
+ * setting fl->fl_type to something other than F_UNLCK.
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
+	WARN_ON_ONCE(fl->fl_ops || fl->fl_lmops);
 	WARN_ON_ONCE(filp !=3D fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);

base-commit: 8b690556d8fe074b4f9835075050fba3fb180e93
--=20
2.50.0.107.gf914562f5916.dirty


