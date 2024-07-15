Return-Path: <linux-nfs+bounces-4929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C579317E5
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C0B218EB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106EDDA0;
	Mon, 15 Jul 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqUhgv/S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC379D53C
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058777; cv=none; b=mNZud1BF1sMc5JzPAytH+uk4InuyYsrMvXGt9UnncQ6V5al4uAiZBOL8OYEzkDjEl3bVyvnaGE3Nb6nUKk9vRlwzG/6yi6VPsTvv7anUtTR78MW9Bk3tFxRmfhe82jKReTvrngkxSornQZQfBVEuz1AhIUwQLOFlT3C67E18pRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058777; c=relaxed/simple;
	bh=GrbComSw1Qc2+dMHjPecr8uRFuQ7iGpM35X0rwSCKI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppbhCFbdDNl8pabyU+vtsltYM0e8JgziorqArpFJ8bPkcgvqL7u8fTxtcbmBzGEBDl6D43tHXXEkqQ+2/Li+E6bJ7N3fecbqjbV77T3tZVhWRu3+B/iA6ubp7Dt5JAf5M5TTDNY1lA9niuh4ceHhDmQ/8+lcjvtU//YAMn6OfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqUhgv/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FDCC32782;
	Mon, 15 Jul 2024 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721058777;
	bh=GrbComSw1Qc2+dMHjPecr8uRFuQ7iGpM35X0rwSCKI0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pqUhgv/SDXtCZUZlAkyMHoE4E0pIDFWNxXi1QmTMy15VXwmuVp9kmDg9qSDfXSfjj
	 NDHE6Xqn/PbkJ0Y+SSFN0IuhvJQXSDwLhvj8/mYiCEWy3k1T2hWMJvtW9GLLvfN73A
	 zOSIkEdzJ4dxC3ibpYSmo0PugJAsZfi0NC8wsiEiUZG8OAPqATbvQV09zla97osNPG
	 yggbgPxBqxNFWssjDd2hfr1PTmCp6el4zXnWGK1r4N469MPXHE9ce73cyjz2EdTcN9
	 UAVt4Lb84i268kryatnocD1uRwWTJjCNxiybq4HiMWW3kNnX5LK1Kp2i/fhR6XPiv6
	 /tPCwKsK2dMJQ==
Message-ID: <2d74fdf5f3c1f2b0e5264ff3c807b1b38657c9ef.camel@kernel.org>
Subject: Re: [PATCH 11/14] nfsd: don't use sv_nrthreads in connection
 limiting calculations.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 11:52:55 -0400
In-Reply-To: <20240715074657.18174-12-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
	 <20240715074657.18174-12-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> The heuristic for limiting the number of incoming connections to nfsd
> currently uses sv_nrthreads - allowing more connections if more threads
> were configured.
>=20
> A future patch will allow number of threads to grow dynamically so that
> there is no need to configure sv_nrthreads.=C2=A0 So we need a different
> solution for limiting connections.
>=20
> It isn't clear what problem is solved by limiting connections (as
> mentioned in a code comment) but the most likely problem is a connection
> storm - many connections that are not doing productive work.=C2=A0 These =
will
> be closed after about 6 minutes already but it might help to slow down a
> storm.
>=20
> This patch add a per-connection flag XPT_PEER_VALID which indicates
> that the peer has presented a filehandle for which it has some sort of
> access.=C2=A0 i.e the peer is known to be trusted in some way.=C2=A0 We n=
ow only
> count connections which have NOT be determined to be valid.=C2=A0 There
> should be relative few of these at any given time.
>=20
> If the number of non-validated peer exceed as limit - currently 64 - we
> close the oldest non-validated peer to avoid having too many of these
> useless connections.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/netns.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/nfsd/nfsfh.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> =C2=A0include/linux/sunrpc/svc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
> =C2=A0include/linux/sunrpc/svc_xprt.h |=C2=A0 4 ++++
> =C2=A0net/sunrpc/svc_xprt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 33 +++++++++++++++++----------------
> =C2=A05 files changed, 32 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 238fc4e56e53..0d2ac15a5003 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -128,8 +128,8 @@ struct nfsd_net {
> =C2=A0	unsigned char writeverf[8];
> =C2=A0
> =C2=A0	/*
> -	 * Max number of connections this nfsd container will allow. Defaults
> -	 * to '0' which is means that it bases this on the number of threads.
> +	 * Max number of non-validated connections this nfsd container
> +	 * will allow.=C2=A0 Defaults to '0' gets mapped to 64.
> =C2=A0	 */
> =C2=A0	unsigned int max_connections;
> =C2=A0
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 0b75305fb5f5..08742bf8de02 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -391,6 +391,14 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp=
, umode_t type, int access)
> =C2=A0		goto out;
> =C2=A0
> =C2=A0skip_pseudoflavor_check:
> +	if (test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags) &&
> +	=C2=A0=C2=A0=C2=A0 !test_and_set_bit(XPT_PEER_VALID, &rqstp->rq_xprt->x=
pt_flags)) {
> +		struct svc_serv *serv =3D rqstp->rq_server;
> +		spin_lock(&serv->sv_lock);
> +		serv->sv_tmpcnt -=3D 1;
> +		spin_unlock(&serv->sv_lock);
> +	}
> +

This is the only place you set XPT_PEER_VALID, but this change affects
more services than just nfsd. What about lockd? Do we need a similar
change there?

> =C2=A0	/* Finally, check access permissions. */
> =C2=A0	error =3D nfsd_permission(rqstp, exp, dentry, access);
> =C2=A0out:
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 99e9345d829e..0b414af448e0 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -79,7 +79,7 @@ struct svc_serv {
> =C2=A0	unsigned int		sv_xdrsize;	/* XDR buffer size */
> =C2=A0	struct list_head	sv_permsocks;	/* all permanent sockets */
> =C2=A0	struct list_head	sv_tempsocks;	/* all temporary sockets */
> -	int			sv_tmpcnt;	/* count of temporary sockets */
> +	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
> =C2=A0	struct timer_list	sv_temptimer;	/* timer for aging temporary socke=
ts */
> =C2=A0
> =C2=A0	char *			sv_name;	/* service name */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index 0981e35a9fed..92565133b3b6 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -99,6 +99,10 @@ enum {
> =C2=A0	XPT_HANDSHAKE,		/* xprt requests a handshake */
> =C2=A0	XPT_TLS_SESSION,	/* transport-layer security established */
> =C2=A0	XPT_PEER_AUTH,		/* peer has been authenticated */
> +	XPT_PEER_VALID,		/* peer has presented a filehandle that
> +				 * it has access to.=C2=A0 It is NOT counted
> +				 * in ->sv_tmpcnt.
> +				 */
> =C2=A0};
> =C2=A0
> =C2=A0static inline void unregister_xpt_user(struct svc_xprt *xpt, struct=
 svc_xpt_user *u)
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 53ebc719ff5a..a9215e1a2f38 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
> =C2=A0}
> =C2=A0
> =C2=A0/*
> - * Make sure that we don't have too many active connections. If we have,
> + * Make sure that we don't have too many connections that have not yet
> + * demonstrated that they have access the the NFS server. If we have,
> =C2=A0 * something must be dropped. It's not clear what will happen if we=
 allow
> =C2=A0 * "too many" connections, but when dealing with network-facing sof=
tware,
> =C2=A0 * we have to code defensively. Here we do that by imposing hard li=
mits.
> @@ -625,27 +626,26 @@ int svc_port_is_privileged(struct sockaddr *sin)
> =C2=A0 */
> =C2=A0static void svc_check_conn_limits(struct svc_serv *serv)
> =C2=A0{
> -	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn :
> -				(serv->sv_nrthreads+3) * 20;
> +	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn : 64;
> =C2=A0
> =C2=A0	if (serv->sv_tmpcnt > limit) {
> -		struct svc_xprt *xprt =3D NULL;
> +		struct svc_xprt *xprt =3D NULL, *xprti;
> =C2=A0		spin_lock_bh(&serv->sv_lock);
> =C2=A0		if (!list_empty(&serv->sv_tempsocks)) {
> -			/* Try to help the admin */
> -			net_notice_ratelimited("%s: too many open connections, consider incre=
asing the %s\n",
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serv->sv_name, serv->sv_maxcon=
n ?
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "max number of connections" :
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "number of threads");
> =C2=A0			/*
> =C2=A0			 * Always select the oldest connection. It's not fair,
> -			 * but so is life
> +			 * but nor is life.
> =C2=A0			 */
> -			xprt =3D list_entry(serv->sv_tempsocks.prev,
> -					=C2=A0 struct svc_xprt,
> -					=C2=A0 xpt_list);
> -			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> -			svc_xprt_get(xprt);
> +			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
> +						=C2=A0=C2=A0=C2=A0 xpt_list)
> +			{
> +				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
> +					xprt =3D xprti;
> +					set_bit(XPT_CLOSE, &xprt->xpt_flags);
> +					svc_xprt_get(xprt);
> +					break;
> +				}
> +			}
> =C2=A0		}
> =C2=A0		spin_unlock_bh(&serv->sv_lock);
> =C2=A0
> @@ -1039,7 +1039,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
> =C2=A0
> =C2=A0	spin_lock_bh(&serv->sv_lock);
> =C2=A0	list_del_init(&xprt->xpt_list);
> -	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
> +	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
> +	=C2=A0=C2=A0=C2=A0 !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
> =C2=A0		serv->sv_tmpcnt--;
> =C2=A0	spin_unlock_bh(&serv->sv_lock);
> =C2=A0

--=20
Jeff Layton <jlayton@kernel.org>

