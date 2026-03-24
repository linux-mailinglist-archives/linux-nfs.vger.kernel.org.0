Return-Path: <linux-nfs+bounces-20349-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HCPNX13wmnqdAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20349-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 12:37:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD873307654
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 12:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30875300B45F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E83DCD88;
	Tue, 24 Mar 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWswyGhp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E393DD1;
	Tue, 24 Mar 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351514; cv=none; b=evEprrBh5+NytW9vl3HSRkxRUlC/v5WuOuVw5WKLepC+ZD0SGx62dXG/0nHPkFZFuT56OTgdJdLD8wrTclfqyTTSGCPCbhuKHV2UwewiF0AH2Vz2kzLO7FrPrnKxmiLUh12viqWbhEv374U9VtKKI3iaJGZQGgliFxeehPpDiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351514; c=relaxed/simple;
	bh=rz0eY1iPVsvqIo0MrQOTY/oPfPtz/+glPCr5rk3wbZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upNaqyw2tT2PvztaPu1YYyN36zqpAdAim0ffyzivx8JJQavJW9eRutQzEKvJsb8/+R8qVGDZP2h8i+YbRTeucRFHkydQITN3IBIvnA28d71GB+dJi72S6BzenBHmGnLlQSD938HPP+3AtCtM29Chk/LWnF4GCGAUWXRlRvKZJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWswyGhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5EBC19424;
	Tue, 24 Mar 2026 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351514;
	bh=rz0eY1iPVsvqIo0MrQOTY/oPfPtz/+glPCr5rk3wbZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KWswyGhppy98+9e7zp9LfiorrNo1lWku38sRz0UQwtJZcc3cJvLMyP+B9IySUAWek
	 JnUdLHPUsHdJdbe+D6t16e1RjJRlWBvZy7VpKIZzrjLyrVwOuJebsqFK3miNTfVEBI
	 Zr4XY12LuE0rf+uV5S70ZyCMfhtAKhWdcMWJZThfvgusTuP7GgrX9/6z33nkXDed/0
	 CxwyPal28oulJk1Xkx4n4JcCriscPEa55AiV6iS5seyp7wfY729YjM5dEHCPUnPpfb
	 DmWcNrz07D1GQyljsiJfKNQSIL7uWZXyOowO1qjEWTuGzxWL+/29ImFw5/ZmXdirg9
	 KrzFMAX+iHz0A==
Message-ID: <f0cd6fb22c917f77e5b7f70bb9a8a64450ff3722.camel@kernel.org>
Subject: Re: [PATCH] lockd: fix TEST handling when not all permissions are
 available.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 Tj	 <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org, Olga Kornievskaia	
 <okorniev@redhat.com>, stable@vger.kernel.org
Date: Tue, 24 Mar 2026 07:25:11 -0400
In-Reply-To: <177434721528.7102.13514118512738778346@noble.neil.brown.name>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
	, <177266540127.7472.3460090956713656639@noble.neil.brown.name>
	, <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
	, <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
	 <177434721528.7102.13514118512738778346@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20349-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email,proton.me:email]
X-Rspamd-Queue-Id: DD873307654
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-24 at 21:13 +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> The F_GETLK fcntl can work with either read access or write access or
> both.  It can query F_RDLCK and F_WRLCK locks in either case.
>=20
> However lockd currently treats F_GETLK similar to F_SETLK in that read
> access is required to query an F_RDLCK lock and write access is required
> to query a F_WRLCK lock.
>=20
> This is wrong and can cause problem - e.g.  when qemu accesses a
> read-only (e.g. iso) filesystem image over NFS (though why it queries
> if it can get a write lock - I don't know.  But it does, and this works
> with local filesystems).
>=20
> So we need TEST requests to be handled differently.  To do this:
>=20
> - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
>   succeed if either a O_RDONLY or O_WRONLY file can be opened.
> - change nlm_lookup_file() to accept a mode argument from caller,
>   instead of deducing base on lock time, and pass that on to nlm_do_fopen=
()
> - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
>   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
>   the same mode as before for other requests.  Also set
>    lock->fl.c.flc_file to whichever file is available for TEST requests.
> - change nlmsvc_testlock() to also not calculate the mode, but to use
>   whenever was stored in lock->fl.c.flc_file.
>=20
> Reported-by: Tj <tj.iam.tj@proton.me>
> Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
> Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/lockd/svc4proc.c         | 13 ++++++++++---
>  fs/lockd/svclock.c          |  4 +---
>  fs/lockd/svcproc.c          | 15 ++++++++++++---
>  fs/lockd/svcsubs.c          | 26 +++++++++++++++++---------
>  include/linux/lockd/lockd.h |  2 +-
>  5 files changed, 41 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 4b6f18d97734..75e020a8bfd0 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -26,6 +26,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nl=
m_args *argp,
>  	struct nlm_host		*host =3D NULL;
>  	struct nlm_file		*file =3D NULL;
>  	struct nlm_lock		*lock =3D &argp->lock;
> +	bool			is_test =3D (rqstp->rq_proc =3D=3D NLMPROC_TEST ||
> +					   rqstp->rq_proc =3D=3D NLMPROC_TEST_MSG);
>  	__be32			error =3D 0;
> =20
>  	/* nfsd callbacks must have been installed for this procedure */
> @@ -46,15 +48,20 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct =
nlm_args *argp,
>  	if (filp !=3D NULL) {
>  		int mode =3D lock_to_openmode(&lock->fl);
> =20
> +		if (is_test)
> +			mode =3D O_RDWR;
> +
>  		lock->fl.c.flc_flags =3D FL_POSIX;
> =20
> -		error =3D nlm_lookup_file(rqstp, &file, lock);
> +		error =3D nlm_lookup_file(rqstp, &file, lock, mode);
>  		if (error)
>  			goto no_locks;
>  		*filp =3D file;
> -
>  		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.c.flc_file =3D file->f_file[mode];
> +		if (is_test)
> +			lock->fl.c.flc_file =3D nlmsvc_file_file(file);
> +		else
> +			lock->fl.c.flc_file =3D file->f_file[mode];
>  		lock->fl.c.flc_pid =3D current->tgid;
>  		lock->fl.fl_start =3D (loff_t)lock->lock_start;
>  		lock->fl.fl_end =3D lock->lock_len ?
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 255a847ca0b6..adfd8c072898 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -614,7 +614,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
>  		struct nlm_lock *conflock)
>  {
>  	int			error;
> -	int			mode;
>  	__be32			ret;
> =20
>  	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=3D%d, %Ld-%Ld)\n",
> @@ -632,14 +631,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_=
file *file,
>  		goto out;
>  	}
> =20
> -	mode =3D lock_to_openmode(&lock->fl);
>  	locks_init_lock(&conflock->fl);
>  	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
>  	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
>  	conflock->fl.fl_start =3D lock->fl.fl_start;
>  	conflock->fl.fl_end =3D lock->fl.fl_end;
>  	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
> -	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
> +	error =3D vfs_test_lock(lock->fl.c.flc_file, &conflock->fl);
>  	if (error) {
>  		ret =3D nlm_lck_denied_nolocks;
>  		goto out;
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index 5817ef272332..d98e8d684376 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -55,6 +55,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm=
_args *argp,
>  	struct nlm_host		*host =3D NULL;
>  	struct nlm_file		*file =3D NULL;
>  	struct nlm_lock		*lock =3D &argp->lock;
> +	bool			is_test =3D (rqstp->rq_proc =3D=3D NLMPROC_TEST ||
> +					   rqstp->rq_proc =3D=3D NLMPROC_TEST_MSG);
>  	int			mode;
>  	__be32			error =3D 0;
> =20
> @@ -70,15 +72,22 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct n=
lm_args *argp,
> =20
>  	/* Obtain file pointer. Not used by FREE_ALL call. */
>  	if (filp !=3D NULL) {
> -		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock));
> +		mode =3D lock_to_openmode(&lock->fl);
> +
> +		if (is_test)
> +			mode =3D O_RDWR;
> +
> +		error =3D cast_status(nlm_lookup_file(rqstp, &file, lock, mode));
>  		if (error !=3D 0)
>  			goto no_locks;
>  		*filp =3D file;
> =20
>  		/* Set up the missing parts of the file_lock structure */
> -		mode =3D lock_to_openmode(&lock->fl);
>  		lock->fl.c.flc_flags =3D FL_POSIX;
> -		lock->fl.c.flc_file  =3D file->f_file[mode];
> +		if (is_test)
> +			lock->fl.c.flc_file =3D nlmsvc_file_file(file);
> +		else
> +			lock->fl.c.flc_file =3D file->f_file[mode];
>  		lock->fl.c.flc_pid =3D current->tgid;
>  		lock->fl.fl_lmops =3D &nlmsvc_lock_operations;
>  		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index dd0214dcb695..b92eb032849f 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -82,18 +82,28 @@ int lock_to_openmode(struct file_lock *lock)
>   *
>   * We have to make sure we have the right credential to open
>   * the file.
> + *
> + * mode can be O_RDONLY(0), O_WRONLY(1) or O_RDWR(2) meaning either

Meaning either... ?

>   */
>  static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
>  			   struct nlm_file *file, int mode)
>  {
> -	struct file **fp =3D &file->f_file[mode];
> +	struct file **fp;
>  	__be32	nfserr;
> +	int m;
> =20
> -	if (*fp)
> -		return 0;
> -	nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> -	if (nfserr)
> -		dprintk("lockd: open failed (error %d)\n", nfserr);
> +	for (m =3D O_RDONLY ; m <=3D O_WRONLY ; m++) {
> +		if (mode !=3D O_RDWR && mode !=3D m)
> +			continue;
> +
> +		fp =3D &file->f_file[m];
> +		if (*fp)
> +			return 0;
> +		nfserr =3D nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
> +		if (!nfserr)
> +			return 0;
> +	}
> +	dprintk("lockd: open failed (error %d)\n", nfserr);
>  	return nfserr;
>  }
> =20
> @@ -103,17 +113,15 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
>   */
>  __be32
>  nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> -					struct nlm_lock *lock)
> +		struct nlm_lock *lock, int mode)
>  {
>  	struct nlm_file	*file;
>  	unsigned int	hash;
>  	__be32		nfserr;
> -	int		mode;
> =20
>  	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
> =20
>  	hash =3D file_hash(&lock->fh);
> -	mode =3D lock_to_openmode(&lock->fl);
> =20
>  	/* Lock file table */
>  	mutex_lock(&nlm_file_mutex);
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 330e38776bb2..fe5cdd4d66f4 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -294,7 +294,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *,=
 struct nlm_host *, pid_t);
>   * File handling for the server personality
>   */
>  __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
> -					struct nlm_lock *);
> +				  struct nlm_lock *, int);
>  void		  nlm_release_file(struct nlm_file *);
>  void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
>  void		  nlmsvc_release_lockowner(struct nlm_lock *);

Patch looks good though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

