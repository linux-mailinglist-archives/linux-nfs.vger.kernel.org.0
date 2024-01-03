Return-Path: <linux-nfs+bounces-889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E003882306A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B922B2385D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E11B26C;
	Wed,  3 Jan 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmBfzwEL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BC1B267;
	Wed,  3 Jan 2024 15:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E7C433C8;
	Wed,  3 Jan 2024 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295247;
	bh=jkkxBytXYuNC6qUWoA7VY8YyBeMCa0cK7N5xO1FZS68=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JmBfzwELpLY/WZYice3ebTwiimG1UEB39YOh5dkgqYSiNuJ3FsbBSUuHkh6n+pvLY
	 Or8igqN6b3HxF9mZX21qmiB83i0tPHZGKwbtHJiYNKNaac0aehQ4cvzNRoMzpjA2A9
	 TmtfcVWlywMZh+eAZAS1AQ1bS6K9WjWudyzT0jyCsQf3pHRrjVTZZn4NV8K+YIC/Tx
	 L223Uo0T8bS4yyRxqINczjVW7UUNSlVN2jFKW0/twGV9wXfhVlN7gJZ9THL5ENlEPO
	 nZaONOUG8EfAJwNrIQbibu4iypqcFJpREGc82K4uv8hLvsK9L2m4Ljgs7s3Qnz28tB
	 4UFViH3VtKVQw==
Message-ID: <f6e3444ca2b798d1f8d6b481ed6b848ec15d44c9.camel@kernel.org>
Subject: Re: [PATCH] nfsd: drop the nfsd_put helper
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org, Zhi Li
 <yieli@redhat.com>
Date: Wed, 03 Jan 2024 10:20:45 -0500
In-Reply-To: <ZZVz1wd/oTvBk3dU@tissot.1015granger.net>
References: <20240103-nfsd-fixes-v1-1-4f4f9d7edd0d@kernel.org>
	 <ZZVz1wd/oTvBk3dU@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 09:48 -0500, Chuck Lever wrote:
> On Wed, Jan 03, 2024 at 08:36:52AM -0500, Jeff Layton wrote:
> > It's not safe to call nfsd_put once nfsd_last_thread has been called, a=
s
> > that function will zero out the nn->nfsd_serv pointer.
> >=20
> > Drop the nfsd_put helper altogether and open-code the svc_put in its
> > callers instead. That allows us to not be reliant on the value of that
> > pointer when handling an error.
> >=20
> > Fixes: 2a501f55cd64 ("nfsd: call nfsd_last_thread() before final nfsd_p=
ut()")
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Cc: NeilBrown <neilb@suse.de>
> > Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
> > ---
> > I know it's late, but it would be good to get this into v6.7 if
> > possible. I think it's fairly straightforward.
>=20
> How is Zhi finding these? Are there administrative API tests that
> can be shared with the community (say, by adding them to kdevops)?
>=20
>=20

I wish I knew. In most of these, we see these messages ahead of the
KASAN pops that he's reporting:

[  643.617739] NFSD: Using UMH upcall client tracking operations.=20
[  643.617755] NFSD: starting 90-second grace period (net f0000000)=20
[  643.780487] svc: failed to register nfsdv3 RPC service (errno 512).=20
[  643.780928] svc: failed to register nfsaclv3 RPC service (errno 512).=
=20
[  643.794625] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
[  643.794635] BUG: KASAN: null-ptr-deref in __write_ports_addfd+0x3b9/0x6c=
0 [nfsd]=20
[  643.794779] Write of size 4 at addr 0000000000000058 by task rpc.nfsd/16=
702=20
[  643.794783] =20

...

The errno 512 makes me suspect that the rpcbind registration attempt is
catching a signal, and that failure then bubbles up when we're trying to
start the server. I've not been able to reproduce this myself though.


> > ---
> >  fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
> >  fs/nfsd/nfsd.h   |  7 -------
> >  2 files changed, 17 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 7cd513e59305..87fed75808ff 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -693,6 +693,7 @@ static ssize_t __write_ports_addfd(char *buf, struc=
t net *net, const struct cred
> >  	char *mesg =3D buf;
> >  	int fd, err;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct svc_serv *serv;
> > =20
> >  	err =3D get_int(&mesg, &fd);
> >  	if (err !=3D 0 || fd < 0)
> > @@ -703,15 +704,15 @@ static ssize_t __write_ports_addfd(char *buf, str=
uct net *net, const struct cred
> >  	if (err !=3D 0)
> >  		return err;
> > =20
> > -	err =3D svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_L=
IMIT, cred);
> > +	serv =3D nn->nfsd_serv;
> > +	err =3D svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cre=
d);
> > =20
> > -	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > +	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
> >  		nfsd_last_thread(net);
> > -	else if (err >=3D 0 &&
> > -		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > -		svc_get(nn->nfsd_serv);
> > +	else if (err >=3D 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active,=
 1))
> > +		svc_get(serv);
> > =20
> > -	nfsd_put(net);
> > +	svc_put(serv);
> >  	return err;
> >  }
> > =20
> > @@ -725,6 +726,7 @@ static ssize_t __write_ports_addxprt(char *buf, str=
uct net *net, const struct cr
> >  	struct svc_xprt *xprt;
> >  	int port, err;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct svc_serv *serv;
> > =20
> >  	if (sscanf(buf, "%15s %5u", transport, &port) !=3D 2)
> >  		return -EINVAL;
> > @@ -737,32 +739,33 @@ static ssize_t __write_ports_addxprt(char *buf, s=
truct net *net, const struct cr
> >  	if (err !=3D 0)
> >  		return err;
> > =20
> > -	err =3D svc_xprt_create(nn->nfsd_serv, transport, net,
> > +	serv =3D nn->nfsd_serv;
> > +	err =3D svc_xprt_create(serv, transport, net,
> >  			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
> >  	if (err < 0)
> >  		goto out_err;
> > =20
> > -	err =3D svc_xprt_create(nn->nfsd_serv, transport, net,
> > +	err =3D svc_xprt_create(serv, transport, net,
> >  			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
> >  	if (err < 0 && err !=3D -EAFNOSUPPORT)
> >  		goto out_close;
> > =20
> > -	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > -		svc_get(nn->nfsd_serv);
> > +	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > +		svc_get(serv);
> > =20
> > -	nfsd_put(net);
> > +	svc_put(serv);
> >  	return 0;
> >  out_close:
> > -	xprt =3D svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
> > +	xprt =3D svc_find_xprt(serv, transport, net, PF_INET, port);
> >  	if (xprt !=3D NULL) {
> >  		svc_xprt_close(xprt);
> >  		svc_xprt_put(xprt);
> >  	}
> >  out_err:
> > -	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > +	if (!serv->sv_nrthreads && !nn->keep_active)
> >  		nfsd_last_thread(net);
> > =20
> > -	nfsd_put(net);
> > +	svc_put(serv);
> >  	return err;
> >  }
> > =20
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 3286ffacbc56..9ed0e08d16c2 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct f=
ile *);
> >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> >  void		nfsd_shutdown_threads(struct net *net);
> > =20
> > -static inline void nfsd_put(struct net *net)
> > -{
> > -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -
> > -	svc_put(nn->nfsd_serv);
> > -}
> > -
> >  bool		i_am_nfsd(void);
> > =20
> >  struct nfsdfs_client {
> >=20
> > ---
> > base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> > change-id: 20240103-nfsd-fixes-1f1196134a11
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

