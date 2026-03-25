Return-Path: <linux-nfs+bounces-20368-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG92OaSEw2kPrQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20368-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 07:45:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B603204DC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 07:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1C963034A3B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A835C193;
	Wed, 25 Mar 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="V6clP2D0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9nPMG/2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3635BDA4;
	Wed, 25 Mar 2026 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421075; cv=none; b=R5biDzo7WyCjHsqrXj3+Ms/CQpjMp+GY2ou4QOClb7SBU9MDSev/OvfGPY3tTGE8KKvNUTQwuCv3pqMNv6qgyGQ/LB0uVY2r/3/3Te4l/G5kMl15eGhuDms6d2o9Hc2rrKCEGP4SVsmFw001fj4t4alF9+OfXZjwQ8q4y+UxBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421075; c=relaxed/simple;
	bh=DRDbpBunxIzj0/SVBdjeKWGBlpnvw/F0PktwEiZofNM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OONtmJ23/rud8tmq98bo/7u7lrpjksGiQoOLHa2CDltm+mzmAOtCs8fpW/e/bw+I3A/SuWlPlLYdmDzyhbWpG0puvJNtFTrkPudxqqcSqwf+03RZetZt7132DQBkUgM5GyrxkYnAiolEjDUIhm+GRwiaZ80Ze+2s0pd2TnJQxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V6clP2D0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9nPMG/2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B9AA1D00099;
	Wed, 25 Mar 2026 02:44:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 02:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774421072; x=1774507472; bh=UPj4cT/Zn+undZLMX9BvD2gvoHJu2zbhF8J
	IJ3npyOA=; b=V6clP2D0rfLHCCczqVM0g/ysLfxBKwfIMdwhXKBQx0Xi8d9P9f5
	E+H1GFIbX4SVMacUvaGjYh9xvDM8h7vXt2LAEC9bOClxL32rlZ1RN+jKGRunrAeT
	/VD7GKyXW5GVZdnlwFGgeoUlipfDMiXSt8XKdnP1VxKl0xhJ4SNezStAGUFgaE4k
	k/d82X98QIpk8JNvx4WsLbrZ+yfHJA9CJswRAziU0eBNzSuPZdPXAZ97QlKzwVyC
	p83HILU/j6vw6niClpYVsQDxcMzOJ6ST8b5cmPhT226SvaHB7kVrOeh6Io0sO+Y/
	IHmzc8KmVg4XaOnSLT//BZMuNyzm3qOfx8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774421072; x=
	1774507472; bh=UPj4cT/Zn+undZLMX9BvD2gvoHJu2zbhF8JIJ3npyOA=; b=M
	9nPMG/2I0/GMJLLEpUAX+JLAV3tT7uoQqLUdl43QbWHg+xCmuzEUTvaqT2q5iTmT
	8zVkMmQL2XIv/GfIavTpYmapUJek3kM92+Wa5EPzdQBhshWWnn2Hvdvv1JuVBKQA
	tMrQoeJ6/x1a0qoeaszox6gEpIrdP4ajrklWwaJEzaEEPGqmo+PhfrCZZkUgVQUv
	N6wESLQq6Vxbv4q19nn1qHSJpGhHSiOBhQ0r+TiVAXDmjrzB7nhUEl53FjOLfFM3
	170x8B/0kX7gr8obU88A35ICxlHhYUlsQl9DHlKRdBitNud2WNiFO/auPaTk8etD
	hrsYh8ZQYijG0Ck0ihfdw==
X-ME-Sender: <xms:T4TDaYWTY6T-6E4In4dv1qdqA5QLedEj6YDlDzbYG3Zbrx_0j5enlg>
    <xme:T4TDaWqt2BvaNR4OzqckUBiQleXpKwyEcHSeRz8TC6rcFqZby0UTn2oEgfefElZ7D
    _wEVf8L5cGC2txM3fJ9aBk1WmCVPhuc2yvE5xHVOrpVSn_sfA>
X-ME-Received: <xmr:T4TDacRtocTK37XyGqvF9BXJZZKrlb9zJBRKBCtgkZtffYbOmMhHM1kctcu2SOo6VM2JEU2og56fCmdL8civeTHC-PUkZrVo2D63lygxqhQT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:T4TDaY3PcngfG71uXairwAKiJHIv-xb_ufluCVeN64uwvC6TmCdLAA>
    <xmx:T4TDaQDL457t_iJi_DdGN8HrzvXLUzsVv5Xa1l1roAE7b_K-BkTMxA>
    <xmx:T4TDaciMSOgshm4mrzB0Ne42n0hoKMxCiMXC2j1yzJgXH1eBkDmo-Q>
    <xmx:T4TDaaMv_nWtv8N0qm_5puwIunEn_8ZFVsXQmj5XLLmPqApogH99Wg>
    <xmx:UITDabob528WJ4az50pAAzN3K7N4R6gniGEudqvZfZKxPmDpNTH1wbZz>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:44:29 -0400 (EDT)
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
 Re: [PATCH] lockd: fix TEST handling when not all permissions are available.
In-reply-to: <f0cd6fb22c917f77e5b7f70bb9a8a64450ff3722.camel@kernel.org>
References: <>, <f0cd6fb22c917f77e5b7f70bb9a8a64450ff3722.camel@kernel.org>
Date: Wed, 25 Mar 2026 17:44:24 +1100
Message-id: <177442106465.7102.4787487567766699153@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20368-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:dkim,proton.me:email,messagingengine.com:dkim,brown.name:email,brown.name:replyto]
X-Rspamd-Queue-Id: 79B603204DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026, Jeff Layton wrote:
> On Tue, 2026-03-24 at 21:13 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > The F_GETLK fcntl can work with either read access or write access or
> > both.  It can query F_RDLCK and F_WRLCK locks in either case.
> >=20
> > However lockd currently treats F_GETLK similar to F_SETLK in that read
> > access is required to query an F_RDLCK lock and write access is required
> > to query a F_WRLCK lock.
> >=20
> > This is wrong and can cause problem - e.g.  when qemu accesses a
> > read-only (e.g. iso) filesystem image over NFS (though why it queries
> > if it can get a write lock - I don't know.  But it does, and this works
> > with local filesystems).
> >=20
> > So we need TEST requests to be handled differently.  To do this:
> >=20
> > - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
> >   succeed if either a O_RDONLY or O_WRONLY file can be opened.
> > - change nlm_lookup_file() to accept a mode argument from caller,
> >   instead of deducing base on lock time, and pass that on to nlm_do_fopen=
()
> > - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
> >   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
> >   the same mode as before for other requests.  Also set
> >    lock->fl.c.flc_file to whichever file is available for TEST requests.
> > - change nlmsvc_testlock() to also not calculate the mode, but to use
> >   whenever was stored in lock->fl.c.flc_file.
> >=20
> > Reported-by: Tj <tj.iam.tj@proton.me>
> > Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
> > Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/lockd/svc4proc.c         | 13 ++++++++++---
> >  fs/lockd/svclock.c          |  4 +---
> >  fs/lockd/svcproc.c          | 15 ++++++++++++---
> >  fs/lockd/svcsubs.c          | 26 +++++++++++++++++---------
> >  include/linux/lockd/lockd.h |  2 +-
> >  5 files changed, 41 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index 4b6f18d97734..75e020a8bfd0 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -26,6 +26,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nl=
m_args *argp,
> >  	struct nlm_host		*host =3D NULL;
> >  	struct nlm_file		*file =3D NULL;
> >  	struct nlm_lock		*lock =3D &argp->lock;
> > +	bool			is_test =3D (rqstp->rq_proc =3D=3D NLMPROC_TEST ||
> > +					   rqstp->rq_proc =3D=3D NLMPROC_TEST_MSG);
> >  	__be32			error =3D 0;
> > =20
> >  	/* nfsd callbacks must have been installed for this procedure */
> > @@ -46,15 +48,20 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct =
nlm_args *argp,
> >  	if (filp !=3D NULL) {
> >  		int mode =3D lock_to_openmode(&lock->fl);
> > =20
> > +		if (is_test)
> > +			mode =3D O_RDWR;
> > +
> >  		lock->fl.c.flc_flags =3D FL_POSIX;
> > =20
> > -		error =3D nlm_lookup_file(rqstp, &file, lock);
> > +		error =3D nlm_lookup_file(rqstp, &file, lock, mode);
> >  		if (error)
> >  			goto no_locks;
> >  		*filp =3D file;
> > -
> >  		/* Set up the missing parts of the file_lock structure */
> > -		lock->fl.c.flc_file =3D file->f_file[mode];
> > +		if (is_test)
> > +			lock->fl.c.flc_file =3D nlmsvc_file_file(file);
> > +		else
> > +			lock->fl.c.flc_file =3D file->f_file[mode];
> >  		lock->fl.c.flc_pid =3D current->tgid;
> >  		lock->fl.fl_start =3D (loff_t)lock->lock_start;
> >  		lock->fl.fl_end =3D lock->lock_len ?
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index 255a847ca0b6..adfd8c072898 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -614,7 +614,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >  		struct nlm_lock *conflock)
> >  {
> >  	int			error;
> > -	int			mode;
> >  	__be32			ret;
> > =20
> >  	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=3D%d, %Ld-%Ld)\n",
> > @@ -632,14 +631,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_=
file *file,
> >  		goto out;
> >  	}
> > =20
> > -	mode =3D lock_to_openmode(&lock->fl);
> >  	locks_init_lock(&conflock->fl);
> >  	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
> >  	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
> >  	conflock->fl.fl_start =3D lock->fl.fl_start;
> >  	conflock->fl.fl_end =3D lock->fl.fl_end;
> >  	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
> > -	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
> > +	error =3D vfs_test_lock(lock->fl.c.flc_file, &conflock->fl);
> >  	if (error) {
> >  		ret =3D nlm_lck_denied_nolocks;
> >  		goto out;
> > diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> > index 5817ef272332..d98e8d684376 100644
> > --- a/fs/lockd/svcproc.c
> > +++ b/fs/lockd/svcproc.c
> > @@ -55,6 +55,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
> >  	struct nlm_host		*host =3D NULL;
> >  	struct nlm_file		*file =3D NULL;
> >  	struct nlm_lock		*lock =3D &argp->lock;
> > +	bool			is_test =3D (rqstp->rq_proc =3D=3D NLMPROC_TEST ||
> > +					   rqstp->rq_proc =3D=3D NLMPROC_TEST_MSG);
> >  	int			mode;
> >  	__be32			error =3D 0;
> > =20
> > @@ -70,15 +72,22 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct n=
lm_args *argp,
> > =20
> >  	/* Obtain file pointer. Not used by FREE_ALL call. */
> >  	if (filp !=3D NULL) {
> > -		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock));
> > +		mode =3D lock_to_openmode(&lock->fl);
> > +
> > +		if (is_test)
> > +			mode =3D O_RDWR;
> > +
> > +		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock, mode));
> >  		if (error !=3D 0)
> >  			goto no_locks;
> >  		*filp =3D file;
> > =20
> >  		/* Set up the missing parts of the file_lock structure */
> > -		mode =3D lock_to_openmode(&lock->fl);
> >  		lock->fl.c.flc_flags =3D FL_POSIX;
> > -		lock->fl.c.flc_file  =3D file->f_file[mode];
> > +		if (is_test)
> > +			lock->fl.c.flc_file =3D nlmsvc_file_file(file);
> > +		else
> > +			lock->fl.c.flc_file =3D file->f_file[mode];
> >  		lock->fl.c.flc_pid =3D current->tgid;
> >  		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
> >  		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> > diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> > index dd0214dcb695..b92eb032849f 100644
> > --- a/fs/lockd/svcsubs.c
> > +++ b/fs/lockd/svcsubs.c
> > @@ -82,18 +82,28 @@ int lock_to_openmode(struct file_lock *lock)
> >   *
> >   * We have to make sure we have the right credential to open
> >   * the file.
> > + *
> > + * mode can be O_RDONLY(0), O_WRONLY(1) or O_RDWR(2) meaning either
>=20
> Meaning either... ?

If O_RDWR is given then either a O_RDONLY file or a O_WRONLY file is provided.

I see now that isn't obvious from the text...



>=20
> >   */
> >  static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
> >  			   struct nlm_file *file, int mode)
> >  {
> > -	struct file **fp =3D &file->f_file[mode];
> > +	struct file **fp;
> >  	__be32	nfserr;
> > +	int m;
> > =20
> > -	if (*fp)
> > -		return 0;
> > -	nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> > -	if (nfserr)
> > -		dprintk("lockd: open failed (error %d)\n", nfserr);
> > +	for (m =3D O_RDONLY ; m <=3D O_WRONLY ; m++) {
> > +		if (mode !=3D O_RDWR && mode !=3D m)
> > +			continue;
> > +
> > +		fp =3D &file->f_file[m];
> > +		if (*fp)
> > +			return 0;
> > +		nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
> > +		if (!nfserr)
> > +			return 0;
> > +	}
> > +	dprintk("lockd: open failed (error %d)\n", nfserr);
> >  	return nfserr;
> >  }
> > =20
> > @@ -103,17 +113,15 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
> >   */
> >  __be32
> >  nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> > -					struct nlm_lock *lock)
> > +		struct nlm_lock *lock, int mode)
> >  {
> >  	struct nlm_file	*file;
> >  	unsigned int	hash;
> >  	__be32		nfserr;
> > -	int		mode;
> > =20
> >  	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
> > =20
> >  	hash =3D file_hash(&lock->fh);
> > -	mode =3D lock_to_openmode(&lock->fl);
> > =20
> >  	/* Lock file table */
> >  	mutex_lock(&nlm_file_mutex);
> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index 330e38776bb2..fe5cdd4d66f4 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -294,7 +294,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *,=
 struct nlm_host *, pid_t);
> >   * File handling for the server personality
> >   */
> >  __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
> > -					struct nlm_lock *);
> > +				  struct nlm_lock *, int);
> >  void		  nlm_release_file(struct nlm_file *);
> >  void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
> >  void		  nlmsvc_release_lockowner(struct nlm_lock *);
>=20
> Patch looks good though.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks,
NeilBrown



