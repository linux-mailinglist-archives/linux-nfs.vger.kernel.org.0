Return-Path: <linux-nfs+bounces-16670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5CC7D3A5
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 17:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8296342880
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B332989B5;
	Sat, 22 Nov 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jv99IRja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdxsHzgm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5460238C03
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763827857; cv=none; b=qonKHsm0Pzg7V0fXAnrleiNjRnE6PFIyd+wZFaV60QT7qLuteALsJvtvAwOvHHdxUEduBGmTNulE/1xhyMS30Je1dOaXUge/bgv7b3wuZtTlTA/GcVPPPxCfHc8Lp0tcjbAgIEcDT6Id3Tug11OeRoZV++K2KBrGLdaGEBVJe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763827857; c=relaxed/simple;
	bh=S9gRcI8k4o7EsiMJSUBrTHn4XqUYM3OsnzCNXZoQkPQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XXXAe6LT3zf9yeVwZpxpmC4g4bg5gZ2WDpTW2hYKitrkX1+Aga8qysqTT0kQOAj7915//ytTOQjlO0Gn1+M/aplbXB+Vds0hsoHGjLJjnyeTiZT3HJWwaOGfD4bHMyko5sUbooEDAdGahv5tuhnwXvHTMaqwIdvRPe5bnvQH26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jv99IRja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdxsHzgm; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id F0FB61300283;
	Sat, 22 Nov 2025 11:10:51 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 22 Nov 2025 11:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763827851;
	 x=1763831451; bh=q5uPLUjj8TzTtd8yNigyoo9L5SKJ4EiuGD2bb/FCaiI=; b=
	jv99IRjacMr9FZbpZ5QrkturghwMWquNxP0Tl/0Sx1IMdCdWqUSNnftWfbtbo81h
	6UeP5aaO73Rw6EcODz43qNvlkcF73A+OwCBuCmzNWGNhe9sEz86G60zNaIDKKLh5
	Yr/6uxHtrrda3pLdaNNUHDlSqg8pogh9l5oCsMK4jbQVJAg4k2iJ8c34A4T3OiNN
	cqN4HW0TFZhZJffEENlTkV4zV/UoHIspeO+FIXxaDNeFs7YCfDsPDjXFP+8DHP35
	m4udJjrjRMTbfS9QIavwIeDY29a8Ts/hXjj2MO3uL6l/shujMDFzNAzcwQWZ7Pt1
	utfvnnbrxqdKsnES+1vFbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763827851; x=
	1763831451; bh=q5uPLUjj8TzTtd8yNigyoo9L5SKJ4EiuGD2bb/FCaiI=; b=Z
	dxsHzgmKE3lMze9KzE1LOWb7rAlQ2ER7H/qkjFUdkNolNa/SW6xewDObGM39pZgs
	mgfM1NM+pLG1WtBO9sF5UGY83od4QXf+fMRkc4+z9VolbfG6IXw83X739iUSytrv
	gB9rArYZtyVMEPjYf7sKNLkfvcy4NSqWznGrWXJUiyS3MSozm4FP7a1ZpOGP5cmV
	erwfgfeYvGYqxHEUdzJRuUgWhe8jg+q6NYT+55D/6iIfWI0UscfStWvmPw3ZnKiT
	6Z3JjzWQZVHRSfuI0S8zip+4bzghs1KU6OPr+FTDbmczoINTVhVUoCJb0c/e+SkE
	rr3WiZR45kwZ+rhS30xag==
X-ME-Sender: <xms:i-AhaT_BN8kTPEyMurOk897RU-7crzZnJ54ywpHYc64_itcabtckMg>
    <xme:i-Ahaai1_mcZ1SX-YwliAJtmWsqAWyySC7tCknuftRwW06KiLhN2y5p_fOfzGvlqo
    8DiFsGcTYS3tsBOGsMq4zqMrLZ9my1IHZyoiTN6OnFBWuWOt6x4B64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotghhuhgtkhhlvghvvghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepfeejgfegheefiefgieehhfdvgedufefhkeehudffjeejkedt
    hffhheevgfduueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhl
    rgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i-AhaTWLk-UzfzjApwdxJFfAT1K8cidvEgHxQ1zHUBvomQkP5xmfFg>
    <xmx:i-AhacRRbyhENRQoO7i-bPOLRNw5hdB-K-Q2ef-PA6yXfcGLoAA81w>
    <xmx:i-Ahadm8QNuUb9CNpTHyKcewE7ttrw-doJbmsBeIfM6QUXgSnPC3Ew>
    <xmx:i-AhaS6-lBxCPtiotyG4GUg4nZAlRW45y7pKVqMIWSS3LPqHywj8Tg>
    <xmx:i-AhaR6mzbRqsbKVQVcl6Uz5_NAoj7isTRPOG_jANV04GNiflhqQHhve>
Feedback-ID: ifa964810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 11DA1780054; Sat, 22 Nov 2025 11:10:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADrCbGGn5uSZ
Date: Sat, 22 Nov 2025 11:10:30 -0500
From: "Chuck Lever" <chucklever@fastmail.com>
To: NeilBrown <neil@brown.name>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Message-Id: <6149cfe6-3546-4f71-9da4-7cac12e09116@app.fastmail.com>
In-Reply-To: <20251122010253.3445570-2-neilb@ownmail.net>
References: <20251122010253.3445570-1-neilb@ownmail.net>
 <20251122010253.3445570-2-neilb@ownmail.net>
Subject: Re: [PATCH v2 1/2] lockd: fix vfs_test_lock() calls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 21, 2025, at 8:00 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>
> Usage of vfs_test_lock() is somewhat confused.  Documentation suggests
> it is given a "lock" but this is not the case.  It is given a struct
> file_lock which contains some details of the sort of lock it should be
> looking for.
>
> In particular passing a "file_lock" containing fl_lmops or fl_ops is
> meaningless and possibly confusing.
>
> This is particularly problematic in lockd.  nlmsvc_testlock() receives
> an initialised "file_lock" from xdr-decode, including manager ops and an
> owner.  It then mistakenly passes this to vfs_test_lock() which might
> replace the owner and the ops.  This can lead to confusion when freeing
> the lock.
>
> The primary role of the 'struct file_lock' passed to vfs_test_lock() is
> to report a conflicting lock that was found, so it makes more sense for
> nlmsvc_testlock() to pass "conflock", which it uses for returning the
> conflicting lock.
>
> With this change, freeing of the lock is not confused and code in
> __nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.
>
> Documentation for vfs_test_lock() is improved to reflect its real
> purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
> future.
>
> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> Closes: https://lore.kernel.org/all/20251021130506.45065-1-okorniev@redhat.com
> Signed-off-by: NeilBrown <neil@brown.name>

At a guess:

Fixes: 5ea0d75037b9 ("lockd: handle test_lock deferrals")  ??

I suspect this also needs a Cc: stable.


> ---
> changes since v1:
> - use conflock more consistently in nlmsvc_testlock()
> ---
>  fs/lockd/svc4proc.c |  4 +---
>  fs/lockd/svclock.c  | 21 ++++++++++++---------
>  fs/lockd/svcproc.c  |  5 +----
>  fs/locks.c          | 12 ++++++++++--
>  4 files changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 109e5caae8c7..4b6f18d97734 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct 
> nlm_res *resp)
>  	struct nlm_args *argp = rqstp->rq_argp;
>  	struct nlm_host	*host;
>  	struct nlm_file	*file;
> -	struct nlm_lockowner *test_owner;
>  	__be32 rc = rpc_success;
> 
>  	dprintk("lockd: TEST4        called\n");
> @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct 
> nlm_res *resp)
>  	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
>  		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
> 
> -	test_owner = argp->lock.fl.c.flc_owner;
>  	/* Now check for conflicting locks */
>  	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
>  				       &resp->lock);
> @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct 
> nlm_res *resp)
>  	else
>  		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
> 
> -	nlmsvc_put_lockowner(test_owner);
> +	nlmsvc_release_lockowner(&argp->lock);
>  	nlmsvc_release_host(host);
>  	nlm_release_file(file);
>  	return rc;
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index a31dc9588eb8..d66e82851599 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct 
> nlm_file *file,
>  	}
> 
>  	mode = lock_to_openmode(&lock->fl);
> -	error = vfs_test_lock(file->f_file[mode], &lock->fl);
> +	locks_init_lock(&conflock->fl);
> +	/* vfs_test_lock only uses start, end, and owner, but tests flc_file 
> */
> +	conflock->fl.c.flc_file = lock->fl.c.flc_file;
> +	conflock->fl.fl_start = lock->fl.fl_start;
> +	conflock->fl.fl_end = lock->fl.fl_end;
> +	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
> +	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
>  	if (error) {
>  		/* We can't currently deal with deferred test requests */
>  		if (error == FILE_LOCK_DEFERRED)
> @@ -637,22 +643,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct 
> nlm_file *file,
>  		goto out;
>  	}
> 
> -	if (lock->fl.c.flc_type == F_UNLCK) {
> +	if (conflock->fl.c.flc_type == F_UNLCK) {
>  		ret = nlm_granted;
>  		goto out;
>  	}
> 
>  	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
> -		lock->fl.c.flc_type, (long long)lock->fl.fl_start,
> -		(long long)lock->fl.fl_end);
> +		conflock->fl.c.flc_type, (long long)conflock->fl.fl_start,
> +		(long long)conflock->fl.fl_end);
>  	conflock->caller = "somehost";	/* FIXME */
>  	conflock->len = strlen(conflock->caller);
>  	conflock->oh.len = 0;		/* don't return OH info */
> -	conflock->svid = lock->fl.c.flc_pid;
> -	conflock->fl.c.flc_type = lock->fl.c.flc_type;
> -	conflock->fl.fl_start = lock->fl.fl_start;
> -	conflock->fl.fl_end = lock->fl.fl_end;
> -	locks_release_private(&lock->fl);
> +	conflock->svid = conflock->fl.c.flc_pid;
> +	locks_release_private(&conflock->fl);
> 
>  	ret = nlm_lck_denied;
>  out:
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index f53d5177f267..5817ef272332 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct 
> nlm_res *resp)
>  	struct nlm_args *argp = rqstp->rq_argp;
>  	struct nlm_host	*host;
>  	struct nlm_file	*file;
> -	struct nlm_lockowner *test_owner;
>  	__be32 rc = rpc_success;
> 
>  	dprintk("lockd: TEST          called\n");
> @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct 
> nlm_res *resp)
>  	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
>  		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
> 
> -	test_owner = argp->lock.fl.c.flc_owner;
> -
>  	/* Now check for conflicting locks */
>  	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
>  						   &argp->lock, &resp->lock));
> @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct 
> nlm_res *resp)
>  		dprintk("lockd: TEST          status %d vers %d\n",
>  			ntohl(resp->status), rqstp->rq_vers);
> 
> -	nlmsvc_put_lockowner(test_owner);
> +	nlmsvc_release_lockowner(&argp->lock);
>  	nlmsvc_release_host(host);
>  	nlm_release_file(file);
>  	return rc;
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..bf5e0d05a026 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2185,13 +2185,21 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, 
> unsigned int, cmd)
>  /**
>   * vfs_test_lock - test file byte range lock
>   * @filp: The file to test lock for
> - * @fl: The lock to test; also used to hold result
> + * @fl: The byte-range in the file to test; also used to hold result
>   *
> + * On entry, @fl does not contain a lock, but identifies a range 
> (fl_start, fl_end)
> + * in the file (c.flc_file), and an owner (c.flc_owner) for whom 
> existing locks
> + * should be ignored.  c.flc_type and c.flc_flags are ignored.
> + * Both fl_lmops and fl_ops in @fl must be NULL.
>   * Returns -ERRNO on failure.  Indicates presence of conflicting lock 
> by
> - * setting conf->fl_type to something other than F_UNLCK.
> + * setting fl->fl_type to something other than F_UNLCK.
> + *
> + * If vfs_test_lock() does find a lock and return it, the caller must
> + * use locks_free_lock() or locks_release_private() on the returned 
> lock.
>   */
>  int vfs_test_lock(struct file *filp, struct file_lock *fl)
>  {
> +	WARN_ON_ONCE(fl->fl_ops || fl->fl_lmops);
>  	WARN_ON_ONCE(filp != fl->c.flc_file);
>  	if (filp->f_op->lock)
>  		return filp->f_op->lock(filp, F_GETLK, fl);
> -- 
> 2.50.0.107.gf914562f5916.dirty

