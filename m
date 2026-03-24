Return-Path: <linux-nfs+bounces-20357-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBP/KyipwmkyggQAu9opvQ
	(envelope-from <linux-nfs+bounces-20357-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 16:09:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3F6317B60
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 16:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 466A430A7A2C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC240244D;
	Tue, 24 Mar 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuzX6Wll"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86843402432
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364416; cv=none; b=K+DNGUuNh9IMCUkT5nZGCIw20SmMaFQoEOKbvCKGiIOwf/tqL6sjUXW9Dh2oWxgu/Fzv0lkLCBEYZRZf9AwXNgVnwBAnqP0NdF3YM91d7Glr2il8VX0fkDnCSgo8xsr449XtkCcrzE2Dc2YPrekCMR/FsFjcwdRHf7bnpLfKgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364416; c=relaxed/simple;
	bh=261DdpU44QDsAYYaBAf7FS0ZoMYcigVPbKOFrdwYZGg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RnYVuPIrKrTLsHEfyj+R+EElx7lZVx/M9jDSIVtdI7APHjxSfhtmm/08r19X516i8VQiFRCHJMWMPkQEej32W4v6YyQXkxx5a+KWIrLacdgp39e8zQH0zCs7fMluaxCAXCHQB70K60PUfBoCYzMRplbXRNB67s28lx2Gy3DrQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuzX6Wll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C255C2BCB2;
	Tue, 24 Mar 2026 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364416;
	bh=261DdpU44QDsAYYaBAf7FS0ZoMYcigVPbKOFrdwYZGg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UuzX6WllLOng9crlTMDs+sNcNli4MM+6ZaEWdoExvQuUZGmDA7olC4JqkOw2RMsnO
	 2o5Zvt52W7HscN4ijBP3X9HH7OBFyJOLN8j2+dwIQumZLa+z1WyFaNASnDlfScsTSg
	 KPZEKQs6hsw0lKf/lI1a10/YG2WljVHe2zBYLF83g4jJ6jkvCXrJ3k8CTMTEjzNVhS
	 JYb7iYYe0M5YuaXOwdUzophY0cQntAl1Ch5qZXShqDwVDt517DS7FybjHb+HG1fp27
	 6/g2fCh7gFJMI+YRXMtFsiJC5kbpKFCy2YEWDqRMl2auC0aC973+MU27ez5CWlqwSt
	 W1FMfEmAMNraA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0868F4008B;
	Tue, 24 Mar 2026 11:00:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 24 Mar 2026 11:00:14 -0400
X-ME-Sender: <xms:_qbCadBUO-0bYUoB0vGjdqezZoaLaD80117vFCwpIOud-f9BUxoN8w>
    <xme:_qbCaWXQxLslikmeOCLsV7oUEleXHGgrOtVdWyOwc0f6B3bTEXNPE--cdQT0diOUD
    FxBLBkNRawN5pFJevqwo1nvwR0VgsCmvADhjB6sIijiYOmuBJyXKb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejhfdutdetfeetvdevfeevtdelueelffdtleefledtteefteefgffhieefgeelieen
    ucffohhmrghinhepuggvsghirghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghilhessghrohifnhdrnh
    grmhgvpdhrtghpthhtohepudduvdekkeeiudessghughhsrdguvggsihgrnhdrohhrghdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvg
    hgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthhtohepthhjrdhi
    rghmrdhtjhesphhrohhtohhnrdhmvgdprhgtphhtthhopehokhhorhhnihgvvhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_qbCaR00qauWG_tYV4eJhYXlmZJLKGQu6c3x0L5AWKutfPt0sK-bTg>
    <xmx:_qbCaU8Tt9P2onLqUwOKK1y4RdT6_o4ZaHwAwtAPjaKmg8eAjrnIlQ>
    <xmx:_qbCaRrorPwlFkwj6FgMLbbFWtq-COiuWbYxKPQYnZKzYGTgHnTG9g>
    <xmx:_qbCaeRenvMokkRhRTagU16KjGyaLetVnI4AQObJu568b2YHatNmXw>
    <xmx:_qbCaUP1gEdH97f1prFrE133DHqZSqmk2v-CX8pXLqDJQutBQ4SA8NBO>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7477780077; Tue, 24 Mar 2026 11:00:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_jyC0Lb0WUR
Date: Tue, 24 Mar 2026 10:59:54 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, 1128861@bugs.debian.org,
 Tj <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, stable@vger.kernel.org
Message-Id: <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
In-Reply-To: <177434721528.7102.13514118512738778346@noble.neil.brown.name>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>
Subject: Re: [PATCH] lockd: fix TEST handling when not all permissions are available.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20357-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email,brown.name:email,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB3F6317B60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Mar 24, 2026, at 6:13 AM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>
> The F_GETLK fcntl can work with either read access or write access or
> both.  It can query F_RDLCK and F_WRLCK locks in either case.
>
> However lockd currently treats F_GETLK similar to F_SETLK in that read
> access is required to query an F_RDLCK lock and write access is required
> to query a F_WRLCK lock.
>
> This is wrong and can cause problem - e.g.  when qemu accesses a
> read-only (e.g. iso) filesystem image over NFS (though why it queries
> if it can get a write lock - I don't know.  But it does, and this works
> with local filesystems).
>
> So we need TEST requests to be handled differently.  To do this:
>
> - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
>   succeed if either a O_RDONLY or O_WRONLY file can be opened.
> - change nlm_lookup_file() to accept a mode argument from caller,
>   instead of deducing base on lock time, and pass that on to nlm_do_fopen()
> - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
>   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
>   the same mode as before for other requests.  Also set
>    lock->fl.c.flc_file to whichever file is available for TEST requests.
> - change nlmsvc_testlock() to also not calculate the mode, but to use
>   whenever was stored in lock->fl.c.flc_file.
>
> Reported-by: Tj <tj.iam.tj@proton.me>
> Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1128861
> Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> Signed-off-by: NeilBrown <neil@brown.name>

Hi Neil, which kernels should this fix apply to?


> ---
>  fs/lockd/svc4proc.c         | 13 ++++++++++---
>  fs/lockd/svclock.c          |  4 +---
>  fs/lockd/svcproc.c          | 15 ++++++++++++---
>  fs/lockd/svcsubs.c          | 26 +++++++++++++++++---------
>  include/linux/lockd/lockd.h |  2 +-
>  5 files changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 4b6f18d97734..75e020a8bfd0 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -26,6 +26,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct 
> nlm_args *argp,
>  	struct nlm_host		*host = NULL;
>  	struct nlm_file		*file = NULL;
>  	struct nlm_lock		*lock = &argp->lock;
> +	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
> +					   rqstp->rq_proc == NLMPROC_TEST_MSG);
>  	__be32			error = 0;
> 
>  	/* nfsd callbacks must have been installed for this procedure */
> @@ -46,15 +48,20 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, 
> struct nlm_args *argp,
>  	if (filp != NULL) {
>  		int mode = lock_to_openmode(&lock->fl);
> 
> +		if (is_test)
> +			mode = O_RDWR;
> +
>  		lock->fl.c.flc_flags = FL_POSIX;
> 
> -		error = nlm_lookup_file(rqstp, &file, lock);
> +		error = nlm_lookup_file(rqstp, &file, lock, mode);
>  		if (error)
>  			goto no_locks;
>  		*filp = file;
> -
>  		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.c.flc_file = file->f_file[mode];
> +		if (is_test)
> +			lock->fl.c.flc_file = nlmsvc_file_file(file);
> +		else
> +			lock->fl.c.flc_file = file->f_file[mode];
>  		lock->fl.c.flc_pid = current->tgid;
>  		lock->fl.fl_start = (loff_t)lock->lock_start;
>  		lock->fl.fl_end = lock->lock_len ?
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 255a847ca0b6..adfd8c072898 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -614,7 +614,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct 
> nlm_file *file,
>  		struct nlm_lock *conflock)
>  {
>  	int			error;
> -	int			mode;
>  	__be32			ret;
> 
>  	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
> @@ -632,14 +631,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct 
> nlm_file *file,
>  		goto out;
>  	}
> 
> -	mode = lock_to_openmode(&lock->fl);
>  	locks_init_lock(&conflock->fl);
>  	/* vfs_test_lock only uses start, end, and owner, but tests flc_file 
> */
>  	conflock->fl.c.flc_file = lock->fl.c.flc_file;
>  	conflock->fl.fl_start = lock->fl.fl_start;
>  	conflock->fl.fl_end = lock->fl.fl_end;
>  	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
> -	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
> +	error = vfs_test_lock(lock->fl.c.flc_file, &conflock->fl);
>  	if (error) {
>  		ret = nlm_lck_denied_nolocks;
>  		goto out;
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index 5817ef272332..d98e8d684376 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -55,6 +55,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct 
> nlm_args *argp,
>  	struct nlm_host		*host = NULL;
>  	struct nlm_file		*file = NULL;
>  	struct nlm_lock		*lock = &argp->lock;
> +	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
> +					   rqstp->rq_proc == NLMPROC_TEST_MSG);
>  	int			mode;
>  	__be32			error = 0;
> 
> @@ -70,15 +72,22 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct 
> nlm_args *argp,
> 
>  	/* Obtain file pointer. Not used by FREE_ALL call. */
>  	if (filp != NULL) {
> -		error = cast_status(nlm_lookup_file(rqstp, &file, lock));
> +		mode = lock_to_openmode(&lock->fl);
> +
> +		if (is_test)
> +			mode = O_RDWR;
> +
> +		error = cast_status(nlm_lookup_file(rqstp, &file, lock, mode));
>  		if (error != 0)
>  			goto no_locks;
>  		*filp = file;
> 
>  		/* Set up the missing parts of the file_lock structure */
> -		mode = lock_to_openmode(&lock->fl);
>  		lock->fl.c.flc_flags = FL_POSIX;
> -		lock->fl.c.flc_file  = file->f_file[mode];
> +		if (is_test)
> +			lock->fl.c.flc_file = nlmsvc_file_file(file);
> +		else
> +			lock->fl.c.flc_file = file->f_file[mode];
>  		lock->fl.c.flc_pid = current->tgid;
>  		lock->fl.fl_lmops = &nlmsvc_lock_operations;
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
>   */
>  static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
>  			   struct nlm_file *file, int mode)
>  {
> -	struct file **fp = &file->f_file[mode];
> +	struct file **fp;
>  	__be32	nfserr;
> +	int m;
> 
> -	if (*fp)
> -		return 0;
> -	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> -	if (nfserr)
> -		dprintk("lockd: open failed (error %d)\n", nfserr);
> +	for (m = O_RDONLY ; m <= O_WRONLY ; m++) {
> +		if (mode != O_RDWR && mode != m)
> +			continue;
> +
> +		fp = &file->f_file[m];
> +		if (*fp)
> +			return 0;
> +		nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
> +		if (!nfserr)
> +			return 0;
> +	}
> +	dprintk("lockd: open failed (error %d)\n", nfserr);
>  	return nfserr;
>  }
> 
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
> 
>  	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
> 
>  	hash = file_hash(&lock->fh);
> -	mode = lock_to_openmode(&lock->fl);
> 
>  	/* Lock file table */
>  	mutex_lock(&nlm_file_mutex);
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 330e38776bb2..fe5cdd4d66f4 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -294,7 +294,7 @@ void		  nlmsvc_locks_init_private(struct file_lock 
> *, struct nlm_host *, pid_t);
>   * File handling for the server personality
>   */
>  __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
> -					struct nlm_lock *);
> +				  struct nlm_lock *, int);
>  void		  nlm_release_file(struct nlm_file *);
>  void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
>  void		  nlmsvc_release_lockowner(struct nlm_lock *);
> -- 
> 2.50.0.107.gf914562f5916.dirty

-- 
Chuck Lever

