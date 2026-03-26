Return-Path: <linux-nfs+bounces-20441-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J7NAsy4xWnxAwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20441-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 23:53:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9933CD0F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 23:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BB9304BCCB
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5DB34216C;
	Thu, 26 Mar 2026 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dh4FcvCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNv0HS2z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BB24728F;
	Thu, 26 Mar 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565231; cv=none; b=Jud77Pwj9/ppqFUQWPQGOxZl++NUjeBn1ZeFz/raNStCRBHdCP9yUx/X97YxdXMvoStMsma1BfLJDqBZpHXOoiblOGghD9WnV4rsbDPso90MT0dZySGFlq9UR/rXi/3U8/Mhz4fJyfUTMx6fjnuQ53yRKV4gFbEnllCmlB/OgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565231; c=relaxed/simple;
	bh=zHxkboLZiChYaj27c8SiNTKVSPcwdH6QHK10X0h/FLY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HBgoU5aKhpntRzjFqyI276rGPzHnqAyks2ebhYpqUXjhpiH4hCNfeJ/1aFDddwJmdIiRwu877Wg+i9fiiQJC1RmBDym+FafPnI2CFLhcVy1v73GRH9adb1cIlENDhPqAI8cF3u/JkPkTK8ZJLHX7Bo11PFgtfrl4+AoeWp+GiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dh4FcvCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNv0HS2z; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AB621400164;
	Thu, 26 Mar 2026 18:47:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 18:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774565228; x=1774651628; bh=+6bZtrmHOnNYAwmGPUzXtlAGI528Z95rKAO
	w3o1eseo=; b=dh4FcvCQyQ2zXlxwnRy/bxO3jpPjXATgcnmu2d3cpZyMIrJzY9R
	jeaXhxsNTahEvVFe3NBHiTFdE8BkCPBX/6BppxkAH9tChRQTVkPeS0g1jTdIHRR6
	P2+Bkopt9reAS6w1DEXy5kiNUajVDMZxSP1Cq+YwIEwXrFJ0u67kp5pEhaDbyj9H
	D4ph7vphZMzDMaHJaA7h3emKC4R0jna1mV9cDCWkw2LxG4zaGMmlgT7dJelPpu5U
	CC4Jg3jY20+ujqZgFISe/pq7XN4UP9D7FVVPx7kPsQuVVnVvtQ6XgCBPpXMAgo30
	bQEXCtrPpm739HY4O++LakrwrjAqZI+qmtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774565228; x=
	1774651628; bh=+6bZtrmHOnNYAwmGPUzXtlAGI528Z95rKAOw3o1eseo=; b=G
	Nv0HS2zN3lD75JdtbeTg55uSKZv9pybIxdrexEGqQ2ibrOGlrEqJt55CMBE6HwGs
	xUiT8M+JQL99ZtMtT9mT5J+q5shFBy/so1HCjVpW6IEskpSezaZNsT/yx1EAXigA
	mSFzLN+QkH9/fHS9mIshJdz9IihCJh0sg6oo/vxHhtbaBHlKm4/AN/Sz5ya1+xoB
	2YXvy2GO7L6XFFN0SIXkANoohOMnBwLkAoLhl7TLSM9UQoeHx18eBjlPnbXZ9klt
	iHOO+Wy3380cjI56ibc8bUJndB6vx+9rWTQAKmKYNqJeAtKcZsLlD5Z+vWSt0ogA
	+45fNGB+VTrvcrhK2cKMg==
X-ME-Sender: <xms:bLfFaRaqRGfV2OlMgXo8IUeNpFAf4T4Vx__0bJuFQ4hiac1rZMuX7w>
    <xme:bLfFaUYtDGq6wuHmffA21ML9g_TpH0Uzl_0lcEbY3xOWzBLeJ673SBV2GxWgoDZIt
    XLKshJhdTCG3_yWReHCcZSHnLgg_jxTl851COfKtzdwDSaexw>
X-ME-Received: <xmr:bLfFaWJ7JwtjfiW7faJWZvOZZkXB-0zqaPdBC7MCzx1wTEk9IJbmc_8kqz84zT6u8bKyZKJNZc1dhdfB_eZZVmoX8ELwZ4uT1Izcr2SiUjQW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudefueefheejhfeuhfehvdfhgeeulefgfeehffekffduvdettdelheeftdethfdvnecu
    ffhomhgrihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehtjhdrihgrmhdrthhjsehprhhothhonhdrmhgvpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhuihhsrdhinhhfohdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeduuddvkeekiedusegsuhhgshdruggvsghirg
    hnrdhorhhg
X-ME-Proxy: <xmx:bLfFaQt1tSXZ7XudhSKasBLJ1ItKvOVKJ5RQZPzxaByeRsbfOKxhuw>
    <xmx:bLfFaaWMrAyz_S5E3ur2RUQ0sLX4b1TO9rvniAIkw-PMuYgr748IzQ>
    <xmx:bLfFabjVfDfCx5Z8xnDqetQQNRA1Wbgey9Fk1Esp0VdOtB4F0bJThQ>
    <xmx:bLfFaSp_St_8A27RiYY9ZOrjs5PpQ3_UsDPaRZFcFgl-6GQ6MrlCrQ>
    <xmx:bLfFaRItVeZ4OngNg6kY-8Jbmnt_9IjSt67erHkZiqPwgN9TKMeB_7NT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 18:47:05 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Leemhuis" <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 "Tj" <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Subject:
 [PATCH v2] lockd: fix TEST handling when not all permissions are available.
In-reply-to: <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>,
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>,
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>,
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>,
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>,
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>,
 <177442248735.2237155.773724155681455344@noble.neil.brown.name>,
 <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
Date: Fri, 27 Mar 2026 09:47:03 +1100
Message-id: <177456522377.1851489.16395975485525163031@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20441-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,ownmail.net:dkim,proton.me:email]
X-Rspamd-Queue-Id: 5BF9933CD0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


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
  whenever was stored in lock->fl.c.flc_file.

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
Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/lockd/svc4proc.c         | 13 ++++++++++---
 fs/lockd/svclock.c          |  4 +---
 fs/lockd/svcproc.c          | 15 ++++++++++++---
 fs/lockd/svcsubs.c          | 28 +++++++++++++++++++---------
 include/linux/lockd/lockd.h |  2 +-
 5 files changed, 43 insertions(+), 19 deletions(-)

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
index dd0214dcb695..865ff6844743 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -82,18 +82,30 @@ int lock_to_openmode(struct file_lock *lock)
  *
  * We have to make sure we have the right credential to open
  * the file.
+ *
+ * mode can be O_RDONLY(0), O_WRONLY(1) or O_RDWR(2).
+ * The latter means succecss can be achieved with EITHER O_RDONLY or
+ * O_WRONLY.  It does NOT mean both read and write are required.
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
@@ -103,17 +115,15 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
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


