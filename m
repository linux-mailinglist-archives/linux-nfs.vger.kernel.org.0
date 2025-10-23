Return-Path: <linux-nfs+bounces-15571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05955C0180A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 122C54FC2BB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBEF31280B;
	Thu, 23 Oct 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE8PlGse"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A93148CB
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226852; cv=none; b=JFWR8tidiqTALRDMmL/JRb0yMmM+w6ALEV4XYehWl/wr94E3vYkz/GH3uYk8C4Iv4cBwu/4jPO6UdWLRWkVDhOXTYovBgXTKu/qpL+q5++cX8g8pmtp4cIoImyLEL75cL8Gtj5yrmly1ZyhhtxCeKKZkAFhcJt/TuxVDxZp5+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226852; c=relaxed/simple;
	bh=tXHhffhMXF+bHLRAiYRCAFZ436/FYLKJlslKVYWcEvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXBJvO07xGAnA3oitrsTRURiAqU5nzL2cYNGQsIkXk/7pWqJgsg9mJMjGfi2Gty0UxYmjxgyQIA7xC1ZR420vPd0RVmfdIJv/4NU5WkA4OOUzC9XXyfsTT8SEWuSSGMf//QrbE+btF55nXWIbWn6+QrKmRoyIV8/1cfqv24frW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE8PlGse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92705C4CEFB;
	Thu, 23 Oct 2025 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761226852;
	bh=tXHhffhMXF+bHLRAiYRCAFZ436/FYLKJlslKVYWcEvM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TE8PlGseF2l2T5mi+jiz3TTEEx2kUyUw59JLyYxlhPCUu8UmfAYT3cBJxgONLMw02
	 vJwmymGgevqTucnsNZi5vLzfZpao8w+lzWEZvg2XkZmpiTyJxsjkA2jp51Lby8zmT1
	 aSCaR5JxJLURfYdGUiiyLiLhgVpXO+KUM3uJ9HUQ9KHnEECbp+nZDXs7X2vZS6IU3b
	 SJxRUO8NHj6Yw9Ih3jipxibn+sAaU4JJWEYtsZMzKNSUq7ZVLaCdQF7OoLndIEIDqH
	 7L89HeQoeBLAY5w/CpKGDFfxrmkSpHNVspd2TWiMqMwtpaSw7QnK3loBKSgRTXCAnq
	 mLyiZyEs0+q0w==
Message-ID: <866d16d748b3ee91ab91be4c5488032556045260.camel@kernel.org>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <aglo@umich.edu>, Olga Kornievskaia
 <okorniev@redhat.com>, 	chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
 neilb@brown.name, 	Dai.Ngo@oracle.com, tom@talpey.com
Date: Thu, 23 Oct 2025 09:40:50 -0400
In-Reply-To: <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
References: <20251021130506.45065-1-okorniev@redhat.com>
	, <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
	, <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
	, <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
	, <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
	, <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>
	, <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>
	, <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
	, <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>
	, <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
	 <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 08:44 +1100, NeilBrown wrote:
> On Thu, 23 Oct 2025, Jeff Layton wrote:
> >=20
> > Longer term, I think Neil is right and we probably need to fix
> > vfs_test_lock and the lock inode_operation to take a separate conflock
> > for testlock purposes. That's a bigger change though (particularly the
> > ->lock operations).
>=20
> Thanks.  But in the shorter term I'd like to suggest this.
> I haven't tested, but I think it should fix the lockd issue and make the
> code cleaner too.
> Sorry - I haven't written a commit description yet :-(
> As nlmsvc_testlock() is being passed a conflock, use that directly to
> hold the found lock, and initialise it from 'lock' before, rather than
> copying results the from lock after.
>=20
> NeilBrown
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 109e5caae8c7..4b6f18d97734 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_=
res *resp)
>  	struct nlm_args *argp =3D rqstp->rq_argp;
>  	struct nlm_host	*host;
>  	struct nlm_file	*file;
> -	struct nlm_lockowner *test_owner;
>  	__be32 rc =3D rpc_success;
> =20
>  	dprintk("lockd: TEST4        called\n");
> @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>  	if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file))=
)
>  		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_succes=
s;
> =20
> -	test_owner =3D argp->lock.fl.c.flc_owner;
>  	/* Now check for conflicting locks */
>  	resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock,
>  				       &resp->lock);
> @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>  	else
>  		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
> =20
> -	nlmsvc_put_lockowner(test_owner);
> +	nlmsvc_release_lockowner(&argp->lock);
>  	nlmsvc_release_host(host);
>  	nlm_release_file(file);
>  	return rc;
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index a31dc9588eb8..381b837a8c18 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
>  	}
> =20
>  	mode =3D lock_to_openmode(&lock->fl);
> -	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> +	locks_init_lock(&conflock->fl);
> +	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
> +	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
> +	conflock->fl.fl_start =3D lock->fl.fl_start;
> +	conflock->fl.fl_end =3D lock->fl.fl_end;
> +	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;

This is basically the same approach that Olga took. This leaves the
fl_lmops field unset, and so we will just not do the refcounting in
this case.

I'm starting to be convinced of that approach -- the exported
filesystem's ->lock operation should just treat flc_owner as opaque.
We'll need a comment around this though, since setting fl_lmops to NULL
for this reason isn't intuitive.

> +	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
>  	if (error) {
>  		/* We can't currently deal with deferred test requests */
>  		if (error =3D=3D FILE_LOCK_DEFERRED)
> @@ -648,11 +654,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
>  	conflock->caller =3D "somehost";	/* FIXME */
>  	conflock->len =3D strlen(conflock->caller);
>  	conflock->oh.len =3D 0;		/* don't return OH info */
> -	conflock->svid =3D lock->fl.c.flc_pid;
> -	conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> -	conflock->fl.fl_start =3D lock->fl.fl_start;
> -	conflock->fl.fl_end =3D lock->fl.fl_end;
> -	locks_release_private(&lock->fl);
> +	conflock->svid =3D conflock->fl.c.flc_pid;
> +	locks_release_private(&conflock->fl);
> =20
>  	ret =3D nlm_lck_denied;
>  out:
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index f53d5177f267..5817ef272332 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>  	struct nlm_args *argp =3D rqstp->rq_argp;
>  	struct nlm_host	*host;
>  	struct nlm_file	*file;
> -	struct nlm_lockowner *test_owner;
>  	__be32 rc =3D rpc_success;
> =20
>  	dprintk("lockd: TEST          called\n");
> @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>  	if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
>  		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_succes=
s;
> =20
> -	test_owner =3D argp->lock.fl.c.flc_owner;
> -
>  	/* Now check for conflicting locks */
>  	resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
>  						   &argp->lock, &resp->lock));
> @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>  		dprintk("lockd: TEST          status %d vers %d\n",
>  			ntohl(resp->status), rqstp->rq_vers);
> =20
> -	nlmsvc_put_lockowner(test_owner);
> +	nlmsvc_release_lockowner(&argp->lock);
>  	nlmsvc_release_host(host);
>  	nlm_release_file(file);
>  	return rc;

--=20
Jeff Layton <jlayton@kernel.org>

