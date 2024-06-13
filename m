Return-Path: <linux-nfs+bounces-3777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94D9078EE
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBCF1F21CBC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AE1494B5;
	Thu, 13 Jun 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvS9Yfke"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55A1339A4;
	Thu, 13 Jun 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297898; cv=none; b=G0HtBQojZcv6VWtEjx6EA9m/88kJ31ArUvLeJtxA+6s7HApkCAhIED7W4jfm6YoqPdfuWoFOH/fedegD+0BCYFWmu3qloD7tKPAxXH1HHhiKHdfF/Jn2tQupXv6v7ax+b8pJfFELJKmDcRIKr4bkzFO2NLPJqgu32dnW6uoDfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297898; c=relaxed/simple;
	bh=KRSGQcAao4mcEtpnNWb8+qcRBkyi8QYsN67UJSpzfec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=puChHYtbTiPJCNupomzz+xB20x7IJGfmZ0fXb2754H8xVmKAp5ek6s4uCst2WPU8TQJpomkT6kQUcpDhufJmAnBF4UK3fblSrVHNgA+JrnQ82qvveKYCPW8uSdx9/EuWhXNeK5fs0/kCm1Otd99sbbaQnsDK3OBOu1v2+HvpWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvS9Yfke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A734C3277B;
	Thu, 13 Jun 2024 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297897;
	bh=KRSGQcAao4mcEtpnNWb8+qcRBkyi8QYsN67UJSpzfec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WvS9YfkepHgZ68WrLBfHDj/K4OtPy1FYqduNBtl8WbCps/qNwkBFBQt63b8hyCxeL
	 7RFh7RVrbaGUarhLjfL2msY/kwvRjJzEplzQ0JaTXvP3tj4obwct+v56OLmitux17e
	 nllm2Bgo1FWr18LnyASJC7wowS5Ibmo5TU50TFMefCdQiCo5YhdQaJRSVaWQby9oAW
	 WAyVQaHol+HGjqUYrHva0gEybowri06Obh9uQuPPKJqslWoytn9hUnCkkL26yVRHV3
	 YgLuoRb24pjzo+hqqngx+s3YOmsykbEY3pYtxhZ+ynurhlSp1h8xZK/b1LiQibOya7
	 5fTFs5FQ+B0HQ==
Message-ID: <5064ae6b3156a1601eb7a7f4f890fb125933aefb.camel@kernel.org>
Subject: Re: [PATCH v2 2/5] nfsd: make nfsd_svc call nfsd_set_nrthreads
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Date: Thu, 13 Jun 2024 12:58:15 -0400
In-Reply-To: <ZmsW+kmUdtebrUcd@tissot.1015granger.net>
References: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
	 <20240613-nfsd-next-v2-2-20bf690d65fb@kernel.org>
	 <ZmsW+kmUdtebrUcd@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 11:57 -0400, Chuck Lever wrote:
> On Thu, Jun 13, 2024 at 08:16:39AM -0400, Jeff Layton wrote:
> > Now that the refcounting is fixed, rework nfsd_svc to use the same
> > thread setup as the pool_threads interface. Since the new netlink
> > interface doesn't have the same restriction as pool_threads, move
> > the
> > guard against shutting down all threads to write_pool_threads.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/nfsd/nfsctl.c | 14 ++++++++++++--
> > =C2=A0fs/nfsd/nfsd.h=C2=A0=C2=A0 |=C2=A0 3 ++-
> > =C2=A0fs/nfsd/nfssvc.c | 18 ++----------------
> > =C2=A03 files changed, 16 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 202140df8f82..121b866125d4 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -406,7 +406,7 @@ static ssize_t write_threads(struct file *file,
> > char *buf, size_t size)
> > =C2=A0			return -EINVAL;
> > =C2=A0		trace_nfsd_ctl_threads(net, newthreads);
> > =C2=A0		mutex_lock(&nfsd_mutex);
> > -		rv =3D nfsd_svc(newthreads, net, file->f_cred,
> > NULL);
> > +		rv =3D nfsd_svc(1, &newthreads, net, file->f_cred,
> > NULL);
> > =C2=A0		mutex_unlock(&nfsd_mutex);
> > =C2=A0		if (rv < 0)
> > =C2=A0			return rv;
> > @@ -481,6 +481,16 @@ static ssize_t write_pool_threads(struct file
> > *file, char *buf, size_t size)
> > =C2=A0				goto out_free;
> > =C2=A0			trace_nfsd_ctl_pool_threads(net, i,
> > nthreads[i]);
> > =C2=A0		}
> > +
> > +		/*
> > +		 * There must always be a thread in pool 0; the
> > admin
> > +		 * can't shut down NFS completely using
> > pool_threads.
> > +		 *
> > +		 * FIXME: do we really need this?
>=20
> Hi, how do you plan to decide this question?
>=20

Probably by ignoring it and letting the restriction (eventually) die
with the old pool_threads interface. I'm amenable to dropping this
restriction altogether though.

>=20
> > +		 */
> > +		if (nthreads[0] =3D=3D 0)
> > +			nthreads[0] =3D 1;
> > +
> > =C2=A0		rv =3D nfsd_set_nrthreads(i, nthreads, net);
> > =C2=A0		if (rv)
> > =C2=A0			goto out_free;
> > @@ -1722,7 +1732,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff
> > *skb, struct genl_info *info)
> > =C2=A0			scope =3D nla_data(attr);
> > =C2=A0	}
> > =C2=A0
> > -	ret =3D nfsd_svc(nthreads, net, get_current_cred(), scope);
> > +	ret =3D nfsd_svc(1, &nthreads, net, get_current_cred(),
> > scope);
> > =C2=A0
> > =C2=A0out_unlock:
> > =C2=A0	mutex_unlock(&nfsd_mutex);
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 8f4f239d9f8a..cec8697b1cd6 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -103,7 +103,8 @@
> > bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
> > =C2=A0/*
> > =C2=A0 * Function prototypes.
> > =C2=A0 */
> > -int		nfsd_svc(int nrservs, struct net *net, const
> > struct cred *cred, const char *scope);
> > +int		nfsd_svc(int n, int *nservers, struct net *net,
> > +			 const struct cred *cred, const char
> > *scope);
> > =C2=A0int		nfsd_dispatch(struct svc_rqst *rqstp);
> > =C2=A0
> > =C2=A0int		nfsd_nrthreads(struct net *);
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index cd9a6a1a9fc8..076f35dc17e4 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -744,13 +744,6 @@ int nfsd_set_nrthreads(int n, int *nthreads,
> > struct net *net)
>=20
> Since you are slightly changing the API contract for this publicly
> visible function, now would be a good time to add a kdoc comment.
>=20

Ok.

>=20
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	/*
> > -	 * There must always be a thread in pool 0; the admin
> > -	 * can't shut down NFS completely using pool_threads.
> > -	 */
> > -	if (nthreads[0] =3D=3D 0)
> > -		nthreads[0] =3D 1;
> > -
> > =C2=A0	/* apply the new numbers */
> > =C2=A0	for (i =3D 0; i < n; i++) {
> > =C2=A0		err =3D svc_set_num_threads(nn->nfsd_serv,
> > @@ -768,7 +761,7 @@ int nfsd_set_nrthreads(int n, int *nthreads,
> > struct net *net)
> > =C2=A0 * this is the first time nrservs is nonzero.
> > =C2=A0 */
> > =C2=A0int
> > -nfsd_svc(int nrservs, struct net *net, const struct cred *cred,
> > const char *scope)
> > +nfsd_svc(int n, int *nthreads, struct net *net, const struct cred
> > *cred, const char *scope)
>=20
> Ditto: the patch changes the synopsis of nfsd_svc(), so I'd like a
> kdoc comment to go with it.
>=20
> And, this particular change is the reason for this patch, so the
> description should state that (especially since subsequent
> patch descriptions refer to "now that nfsd_svc takes an array
> of threads..." : I had to come back to this patch and blink twice
> to see why it said that).
>=20
> A kdoc comment from sunrpc_get_pool_mode() should also be added
> in 4/5.
>=20

I'll do that and resend soon.

>=20
> > =C2=A0{
> > =C2=A0	int	error;
> > =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > @@ -778,13 +771,6 @@ nfsd_svc(int nrservs, struct net *net, const
> > struct cred *cred, const char *scop
> > =C2=A0
> > =C2=A0	dprintk("nfsd: creating service\n");
> > =C2=A0
> > -	nrservs =3D max(nrservs, 0);
> > -	nrservs =3D min(nrservs, NFSD_MAXSERVS);
> > -	error =3D 0;
> > -
> > -	if (nrservs =3D=3D 0 && nn->nfsd_serv =3D=3D NULL)
> > -		goto out;
> > -
> > =C2=A0	strscpy(nn->nfsd_name, scope ? scope : utsname()-
> > >nodename,
> > =C2=A0		sizeof(nn->nfsd_name));
> > =C2=A0
> > @@ -796,7 +782,7 @@ nfsd_svc(int nrservs, struct net *net, const
> > struct cred *cred, const char *scop
> > =C2=A0	error =3D nfsd_startup_net(net, cred);
> > =C2=A0	if (error)
> > =C2=A0		goto out_put;
> > -	error =3D svc_set_num_threads(serv, NULL, nrservs);
> > +	error =3D nfsd_set_nrthreads(n, nthreads, net);
> > =C2=A0	if (error)
> > =C2=A0		goto out_put;
> > =C2=A0	error =3D serv->sv_nrthreads;
> >=20
> > --=20
> > 2.45.2
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

