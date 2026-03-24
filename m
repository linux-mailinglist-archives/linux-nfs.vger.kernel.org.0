Return-Path: <linux-nfs+bounces-20348-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLWvFuFjwmmecAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20348-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 11:13:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F31323064C5
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60A8430217DE
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C303E0258;
	Tue, 24 Mar 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RrIwDEX/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gg6gI4Zy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489634DCC8;
	Tue, 24 Mar 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347229; cv=none; b=gRRmGpgYoIHcEdcCNZE2cCkghbdOGdGWQ4tn9V1ego00YXZHP+TRre4XSVuyHDC4NZ26ws6IiaFcWh8IuaVcQe8LY0G697kWoz1Q9o0io6tana8T8lpb9PJbdTpRdrZXLk7ELWBw9FLMxvK9vXRKn/obpSJt6pzlYUVqZICrYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347229; c=relaxed/simple;
	bh=f/+LP/1Ylqhn8EutUCWVhLD7VZPDeYIZwlFtSKPJiEY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OKO8/plkhTXn91dtMtNXa56MkEPwDAD9UsuzJ7FwvRRFbE6EjyDTmbaZm5ZHldY24P57vv7Q5HXMPKUJ/DautkQD6lT6jSZkNa5pwhw3DVvn7EsejnuFa4WyrMHSrwe+cNok9YxEDPyFOdiGu7xKNWLK4Iy18U65mPptbceLQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RrIwDEX/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gg6gI4Zy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 876F3EC0104;
	Tue, 24 Mar 2026 06:13:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Mar 2026 06:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774347222; x=1774433622; bh=eAbtl4Ts8cvSUZwYOKJ+AcokZW+5W30fBqg
	rR628Wl4=; b=RrIwDEX/hcYNz8qRtX6mEndf4hU/kf/XI8sOMFIA4LKcjxYygES
	RbJeGrxOjpn6+x0g3HuOFJjjLcT3QFXvWm3dgoTBUEq5sAUoDyMx8+3Sy93Lr72n
	XvA6lVFEnx1ywV0bEsEsP9wbuKQv5CHjHAS8bgH9BJ85GAp8cVsiXQGflAV8gu2L
	FRzGG3343wO/m9xRvtyieF0Br2IusbY1wk+esrgQArDR2LxD1laVDQ706m0gqlyY
	JfWV9eu7vSQMIr8KZzVcqs1LnmzOUq+AD0UuCHGRW1Bl+l2yiELvZulaxwkyn6gn
	dXqT6KV9+vpiLp84fvo08cHI/H3Uyx+8jLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774347222; x=
	1774433622; bh=eAbtl4Ts8cvSUZwYOKJ+AcokZW+5W30fBqgrR628Wl4=; b=G
	g6gI4ZyQPGivbKROp4uS2tJYcizKMGXzFYW58hQQu/IjGLHlDIOLPs+VwH42ey6f
	wDFzNhOVV4sQpWaL6GIhpG0IgMdrfI77B2TwAYJmDZQPnu8qP051PbI/Lte1aR36
	YZrcx68/ES0GUcriX2lsjy0rO2KBVM1FXtWloSLQd3FJUUvGqAzN08Dff3Vgvdfv
	hzO175UjreVpwIlnUQbuiFXCvNscwmKzmLR+DzUPny1fZJrddnpXgW0raKhaNMvD
	f1s4Gg/CFQyR6+qR7cSYs4ChdAlWCOuvnr6IRBB97+190zZQxM5VG9yJpK0X6tc6
	Wkcq+0NnfNuzNoXflYh8g==
X-ME-Sender: <xms:1mPCaXLVNY9wfzkyu_fy6SPGy8O9GbVVDPMbT7BePSsvifKy6CtNsQ>
    <xme:1mPCaVOtFUt1iR2gykHw0gK1at0vCD1xksjx_G3nHbPtCAJP-mBW__eOHk991oZsW
    3pfd_oC8lo_ye8bk4XZZJ8zkhpoepW0LaIi7RnjLp3pPOTcQA>
X-ME-Received: <xmr:1mPCafm5Uaipi1rX0UO1TWRExb5Vkd2iS23-vKoIJGdj2BfA1wkX2Iw7beC8Upo4sXk0w16PlReI44uVp5Qe1LEBnoHkGHRHn_UsSCGpLoyj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudefueefheejhfeuhfehvdfhgeeulefgfeehffekffduvdettdelheeftdethfdvnecu
    ffhomhgrihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehtjhdrihgrmhdrthhjsehprhhothhonhdrmhgvpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhuihhsrdhinhhfohdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeduuddvkeek
    iedusegsuhhgshdruggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:1mPCaR7g1gVL1w5WNDt24CAEMu8Dky-5PxU3NCkegeGM_8MOSaSdIQ>
    <xmx:1mPCab0eDb38YMyjeDFHsOa3LjhNDWFVFKtDARpPMAy99gPYJZv3IQ>
    <xmx:1mPCaUECWfkqFnqMv1vjtS0fSddvGexUvt1t6Z6R6sC05waJakrGBg>
    <xmx:1mPCaSjqFr3y2TXRCa0fed6MWfCpqB78l9MCDgS3NoZMMuloQqlgcg>
    <xmx:1mPCaXPC-hqmaaewxrk4hVY2J_RSa56wpYvE82yDOg_aFVQNcl64Gf66>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 06:13:39 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 "Tj" <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Subject:
 [PATCH] lockd: fix TEST handling when not all permissions are available.
In-reply-to: <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>,
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>,
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>,
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
Date: Tue, 24 Mar 2026 21:13:35 +1100
Message-id: <177434721528.7102.13514118512738778346@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20348-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: F31323064C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


From: NeilBrown <neil@brown.name>

The F_GETLK fcntl can work with either read access or write access or
both.  It can query F_RDLCK and F_WRLCK locks in either case.

However lockd currently treats F_GETLK similar to F_SETLK in that read
access is required to query an F_RDLCK lock and write access is required
to query a F_WRLCK lock.

This is wrong and can cause problem - e.g.  when qemu accesses a
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
  whenever was stored in lock->fl.c.flc_file.

Reported-by: Tj <tj.iam.tj@proton.me>
Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/lockd/svc4proc.c         | 13 ++++++++++---
 fs/lockd/svclock.c          |  4 +---
 fs/lockd/svcproc.c          | 15 ++++++++++++---
 fs/lockd/svcsubs.c          | 26 +++++++++++++++++---------
 include/linux/lockd/lockd.h |  2 +-
 5 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4b6f18d97734..75e020a8bfd0 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -26,6 +26,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_ar=
gs *argp,
 	struct nlm_host		*host =3D NULL;
 	struct nlm_file		*file =3D NULL;
 	struct nlm_lock		*lock =3D &argp->lock;
+	bool			is_test =3D (rqstp->rq_proc =3D=3D NLMPROC_TEST ||
+					   rqstp->rq_proc =3D=3D NLMPROC_TEST_MSG);
 	__be32			error =3D 0;
=20
 	/* nfsd callbacks must have been installed for this procedure */
@@ -46,15 +48,20 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_=
args *argp,
 	if (filp !=3D NULL) {
 		int mode =3D lock_to_openmode(&lock->fl);
=20
+		if (is_test)
+			mode =3D O_RDWR;
+
 		lock->fl.c.flc_flags =3D FL_POSIX;
=20
-		error =3D nlm_lookup_file(rqstp, &file, lock);
+		error =3D nlm_lookup_file(rqstp, &file, lock, mode);
 		if (error)
 			goto no_locks;
 		*filp =3D file;
-
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.c.flc_file =3D file->f_file[mode];
+		if (is_test)
+			lock->fl.c.flc_file =3D nlmsvc_file_file(file);
+		else
+			lock->fl.c.flc_file =3D file->f_file[mode];
 		lock->fl.c.flc_pid =3D current->tgid;
 		lock->fl.fl_start =3D (loff_t)lock->lock_start;
 		lock->fl.fl_end =3D lock->lock_len ?
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 255a847ca0b6..adfd8c072898 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -614,7 +614,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *=
file,
 		struct nlm_lock *conflock)
 {
 	int			error;
-	int			mode;
 	__be32			ret;
=20
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=3D%d, %Ld-%Ld)\n",
@@ -632,14 +631,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
 		goto out;
 	}
=20
-	mode =3D lock_to_openmode(&lock->fl);
 	locks_init_lock(&conflock->fl);
 	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
 	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
 	conflock->fl.fl_start =3D lock->fl.fl_start;
 	conflock->fl.fl_end =3D lock->fl.fl_end;
 	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
-	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
+	error =3D vfs_test_lock(lock->fl.c.flc_file, &conflock->fl);
 	if (error) {
 		ret =3D nlm_lck_denied_nolocks;
 		goto out;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 5817ef272332..d98e8d684376 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -55,6 +55,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_arg=
s *argp,
 	struct nlm_host		*host =3D NULL;
 	struct nlm_file		*file =3D NULL;
 	struct nlm_lock		*lock =3D &argp->lock;
+	bool			is_test =3D (rqstp->rq_proc =3D=3D NLMPROC_TEST ||
+					   rqstp->rq_proc =3D=3D NLMPROC_TEST_MSG);
 	int			mode;
 	__be32			error =3D 0;
=20
@@ -70,15 +72,22 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_a=
rgs *argp,
=20
 	/* Obtain file pointer. Not used by FREE_ALL call. */
 	if (filp !=3D NULL) {
-		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock));
+		mode =3D lock_to_openmode(&lock->fl);
+
+		if (is_test)
+			mode =3D O_RDWR;
+
+		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock, mode));
 		if (error !=3D 0)
 			goto no_locks;
 		*filp =3D file;
=20
 		/* Set up the missing parts of the file_lock structure */
-		mode =3D lock_to_openmode(&lock->fl);
 		lock->fl.c.flc_flags =3D FL_POSIX;
-		lock->fl.c.flc_file  =3D file->f_file[mode];
+		if (is_test)
+			lock->fl.c.flc_file =3D nlmsvc_file_file(file);
+		else
+			lock->fl.c.flc_file =3D file->f_file[mode];
 		lock->fl.c.flc_pid =3D current->tgid;
 		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index dd0214dcb695..b92eb032849f 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -82,18 +82,28 @@ int lock_to_openmode(struct file_lock *lock)
  *
  * We have to make sure we have the right credential to open
  * the file.
+ *
+ * mode can be O_RDONLY(0), O_WRONLY(1) or O_RDWR(2) meaning either
  */
 static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
-	struct file **fp =3D &file->f_file[mode];
+	struct file **fp;
 	__be32	nfserr;
+	int m;
=20
-	if (*fp)
-		return 0;
-	nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
-	if (nfserr)
-		dprintk("lockd: open failed (error %d)\n", nfserr);
+	for (m =3D O_RDONLY ; m <=3D O_WRONLY ; m++) {
+		if (mode !=3D O_RDWR && mode !=3D m)
+			continue;
+
+		fp =3D &file->f_file[m];
+		if (*fp)
+			return 0;
+		nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
+		if (!nfserr)
+			return 0;
+	}
+	dprintk("lockd: open failed (error %d)\n", nfserr);
 	return nfserr;
 }
=20
@@ -103,17 +113,15 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
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
=20
 	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
=20
 	hash =3D file_hash(&lock->fh);
-	mode =3D lock_to_openmode(&lock->fl);
=20
 	/* Lock file table */
 	mutex_lock(&nlm_file_mutex);
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 330e38776bb2..fe5cdd4d66f4 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -294,7 +294,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *, str=
uct nlm_host *, pid_t);
  * File handling for the server personality
  */
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
-					struct nlm_lock *);
+				  struct nlm_lock *, int);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
 void		  nlmsvc_release_lockowner(struct nlm_lock *);
--=20
2.50.0.107.gf914562f5916.dirty


