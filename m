Return-Path: <linux-nfs+bounces-7383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B389AC9AC
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3701F2110D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8BD1AB6E9;
	Wed, 23 Oct 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvpeHZDV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0F14D2AC
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685298; cv=none; b=nfZDaDjqAEHMmpSv0rXgL4n+iBFFjTqEiv6INi7sMtgIPEizGj1j6lIckFnYIhjlVfWDa7+EeWzORlc1suNcScFCSDHKlLg+oUuUNN4mPJ27dqZysi2BzaTBxQFvddkDMEfslKtfjXFrtkm4fySq7j9/wGOTf8D0u13WkFcsLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685298; c=relaxed/simple;
	bh=ZrlS2LCGKHnugwrY03WUEX0/AQjA3/HnoorOOG6wDs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oh7NEyKw5rknoac8SQbotUKTGU/aRmbcagFpg+XLTzvKXK4w0VsLi/f64saK1QV8aVThiIPE5n45dpD+IzddlHmBxBs3belJLaioLBqcNKznTcvPNKlbhv0/0C35a92hK1hgNCkll/qfErSf7SxWbp5bESX4o4uhcl2x2Tr5fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvpeHZDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4FFC4CEC6;
	Wed, 23 Oct 2024 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685296;
	bh=ZrlS2LCGKHnugwrY03WUEX0/AQjA3/HnoorOOG6wDs0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HvpeHZDVB2GVVSZhghIaLBnavg7YA5lUipyr64YWkzN3Ja39XM8lg8W32JYaS44Wm
	 SsTETz2i2l0H9WJrkjwYlGlHgOvtsXHFTJx6eH75PNYOxmFl3NtB21N3+Fptvky5lS
	 L68xri5IFjZfQdMd3G2v8BzGWIkMqAKVcJKyVcDgWgNsuyDLiuyoKoC8f7tWWbOkO2
	 rJ6+VgEM/4evtZlhuIaGLAQH+n+Ep/a36/0+7ltVvOSkWI29xoVi4S/GTFCp1hZhwV
	 4Nv24F7FqGl4NOkjwVzvyfLou/KsW3UiNl0ut2Tc/Vh9wUMVry2Fswp3g7GjBDyvCj
	 1fXLcDTwmDQkg==
Message-ID: <de7e2dfbbbe3f51848e303af446afe615d14efe8.camel@kernel.org>
Subject: Re: [PATCH 4/6] nfsd: don't use sv_nrthreads in connection limiting
 calculations.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Wed, 23 Oct 2024 08:08:15 -0400
In-Reply-To: <20241023024222.691745-5-neilb@suse.de>
References: <20241023024222.691745-1-neilb@suse.de>
	 <20241023024222.691745-5-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 13:37 +1100, NeilBrown wrote:
> The heuristic for limiting the number of incoming connections to nfsd
> currently uses sv_nrthreads - allowing more connections if more threads
> were configured.
>=20
> A future patch will allow number of threads to grow dynamically so that
> there will be no need to configure sv_nrthreads.  So we need a different
> solution for limiting connections.
>=20
> It isn't clear what problem is solved by limiting connections (as
> mentioned in a code comment) but the most likely problem is a connection
> storm - many connections that are not doing productive work.  These will
> be closed after about 6 minutes already but it might help to slow down a
> storm.
>=20
> This patch adds a per-connection flag XPT_PEER_VALID which indicates
> that the peer has presented a filehandle for which it has some sort of
> access.  i.e the peer is known to be trusted in some way.  We now only
> count connections which have NOT been determined to be valid.  There
> should be relative few of these at any given time.
>=20
> If the number of non-validated peer exceed a limit - currently 64 - we
> close the oldest non-validated peer to avoid having too many of these
> useless connections.
>=20
> Note that this patch significantly changes the meaning of the various
> configuration parameters for "max connections".  The next patch will
> remove all of these.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/callback.c               |  4 ----
>  fs/nfs/callback_xdr.c           |  1 +
>  fs/nfsd/netns.h                 |  4 ++--
>  fs/nfsd/nfsfh.c                 |  2 ++
>  include/linux/sunrpc/svc.h      |  2 +-
>  include/linux/sunrpc/svc_xprt.h | 15 +++++++++++++++
>  net/sunrpc/svc_xprt.c           | 33 +++++++++++++++++----------------
>  7 files changed, 38 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 6cf92498a5ac..86bdc7d23fb9 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -211,10 +211,6 @@ static struct svc_serv *nfs_callback_create_svc(int =
minorversion)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  	cb_info->serv =3D serv;
> -	/* As there is only one thread we need to over-ride the
> -	 * default maximum of 80 connections
> -	 */
> -	serv->sv_maxconn =3D 1024;
>  	dprintk("nfs_callback_create_svc: service created\n");
>  	return serv;
>  }
> diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
> index fdeb0b34a3d3..4254ba3ee7c5 100644
> --- a/fs/nfs/callback_xdr.c
> +++ b/fs/nfs/callback_xdr.c
> @@ -984,6 +984,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
*rqstp)
>  			nfs_put_client(cps.clp);
>  			goto out_invalidcred;
>  		}
> +		svc_xprt_set_valid(rqstp->rq_xprt);
>  	}
> =20
>  	cps.minorversion =3D hdr_arg.minorversion;
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 26f7b34d1a03..a05a45bb1978 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -129,8 +129,8 @@ struct nfsd_net {
>  	unsigned char writeverf[8];
> =20
>  	/*
> -	 * Max number of connections this nfsd container will allow. Defaults
> -	 * to '0' which is means that it bases this on the number of threads.
> +	 * Max number of non-validated connections this nfsd container
> +	 * will allow.  Defaults to '0' gets mapped to 64.
>  	 */
>  	unsigned int max_connections;
> =20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 40ad58a6a036..2f44de99f709 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -383,6 +383,8 @@ __fh_verify(struct svc_rqst *rqstp,
>  		goto out;
> =20
>  skip_pseudoflavor_check:
> +	svc_xprt_set_valid(rqstp->rq_xprt);
> +

This makes a lot of sense, but I don't see where lockd sets
XPT_PEER_VALID with this patch. Does it need a call in
nlm_lookup_file() or someplace similar?

>  	/* Finally, check access permissions. */
>  	error =3D nfsd_permission(cred, exp, dentry, access);
>  out:
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e68fecf6eab5..617ebfff2f30 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -81,7 +81,7 @@ struct svc_serv {
>  	unsigned int		sv_xdrsize;	/* XDR buffer size */
>  	struct list_head	sv_permsocks;	/* all permanent sockets */
>  	struct list_head	sv_tempsocks;	/* all temporary sockets */
> -	int			sv_tmpcnt;	/* count of temporary sockets */
> +	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
>  	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
> =20
>  	char *			sv_name;	/* service name */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index 0981e35a9fed..35929a7727c7 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -99,8 +99,23 @@ enum {
>  	XPT_HANDSHAKE,		/* xprt requests a handshake */
>  	XPT_TLS_SESSION,	/* transport-layer security established */
>  	XPT_PEER_AUTH,		/* peer has been authenticated */
> +	XPT_PEER_VALID,		/* peer has presented a filehandle that
> +				 * it has access to.  It is NOT counted
> +				 * in ->sv_tmpcnt.
> +				 */
>  };
> =20
> +static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
> +{
> +	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
> +	    !test_and_set_bit(XPT_PEER_VALID, &xpt->xpt_flags)) {
> +		struct svc_serv *serv =3D xpt->xpt_server;
> +		spin_lock(&serv->sv_lock);
> +		serv->sv_tmpcnt -=3D 1;
> +		spin_unlock(&serv->sv_lock);
> +	}
> +}
> +
>  static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_=
xpt_user *u)
>  {
>  	spin_lock(&xpt->xpt_lock);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 43c57124de52..ff5b8bb8a88f 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
>  }
> =20
>  /*
> - * Make sure that we don't have too many active connections. If we have,
> + * Make sure that we don't have too many connections that have not yet
> + * demonstrated that they have access the the NFS server. If we have,
>   * something must be dropped. It's not clear what will happen if we allo=
w
>   * "too many" connections, but when dealing with network-facing software=
,
>   * we have to code defensively. Here we do that by imposing hard limits.
> @@ -625,27 +626,26 @@ int svc_port_is_privileged(struct sockaddr *sin)
>   */
>  static void svc_check_conn_limits(struct svc_serv *serv)
>  {
> -	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn :
> -				(serv->sv_nrthreads+3) * 20;
> +	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn : 64;
> =20
>  	if (serv->sv_tmpcnt > limit) {
> -		struct svc_xprt *xprt =3D NULL;
> +		struct svc_xprt *xprt =3D NULL, *xprti;
>  		spin_lock_bh(&serv->sv_lock);
>  		if (!list_empty(&serv->sv_tempsocks)) {
> -			/* Try to help the admin */
> -			net_notice_ratelimited("%s: too many open connections, consider incre=
asing the %s\n",
> -					       serv->sv_name, serv->sv_maxconn ?
> -					       "max number of connections" :
> -					       "number of threads");
>  			/*
>  			 * Always select the oldest connection. It's not fair,
> -			 * but so is life
> +			 * but nor is life.
>  			 */
> -			xprt =3D list_entry(serv->sv_tempsocks.prev,
> -					  struct svc_xprt,
> -					  xpt_list);
> -			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> -			svc_xprt_get(xprt);
> +			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
> +						    xpt_list)
> +			{
> +				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
> +					xprt =3D xprti;
> +					set_bit(XPT_CLOSE, &xprt->xpt_flags);
> +					svc_xprt_get(xprt);
> +					break;
> +				}
> +			}
>  		}
>  		spin_unlock_bh(&serv->sv_lock);
> =20
> @@ -1039,7 +1039,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
> =20
>  	spin_lock_bh(&serv->sv_lock);
>  	list_del_init(&xprt->xpt_list);
> -	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
> +	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
> +	    !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
>  		serv->sv_tmpcnt--;
>  	spin_unlock_bh(&serv->sv_lock);
> =20

Other than the comment about lockd, I like this:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

