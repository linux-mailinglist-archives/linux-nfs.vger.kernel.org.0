Return-Path: <linux-nfs+bounces-4365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3B91A508
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899AD2832C3
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4C1487FF;
	Thu, 27 Jun 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY5bNTWC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43E13C9CA
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487496; cv=none; b=oWJG15w9mq4v6SeT0/PqHvbIuOhtxEChYSbZwH6F4RFQ80aof20yqOlR2+9OVctck0G7A/i5qjLxvrssXRhuBqRCxFaKpng59IT1Yck2CjKpQGvtn4kvNeX3mKDrpcpKQdkbtC57V02NvZtIh1W5v/sj65FDjpFIF3ZXcRKhIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487496; c=relaxed/simple;
	bh=PK8mPrpNdrDpdb3b+Mb6/EEsVNGOwGHqH34uywxbtgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0giVqmOro/YtiF7ywxs1AY2jYcuPeGQHVZYrUv77c/EYbweS2Y+01ijOVhOx8JOI0EugZArmA/nMBezeQ/2Kr5p2EgbAgQ2nFGUf3z4pHKTxOIu2vlGDXk+YeU9gpAHyNtgQzN0b2mFCs5ZXMcVCD4eAerIsWz5WNVkNmqK28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY5bNTWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C1C2BBFC;
	Thu, 27 Jun 2024 11:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719487496;
	bh=PK8mPrpNdrDpdb3b+Mb6/EEsVNGOwGHqH34uywxbtgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PY5bNTWCm062nd/gwW3LmKUkA6viweLxCyI6E9nxRZKrL1Il3WgZebxp4eRZB8RcT
	 2RkISI+iaOH25V0J/j4aBvsA1pZpGanWpCO8CppvM6k7nh6mFjKy5w3IWzHxnr+oyY
	 xD2Tjc3Rd/6jhBXMs0fv+7YHO+g3tL8NSCklxqdhBhYMhaVWZ3aSEJk7uDevfn1BLF
	 hIFmZ6sqiihYlQy8bgBoW6NpdsXXltd8up1IA2I2IDpX7+t9MPODBn/PkIU1LR9pgX
	 5dDNpfw8Wzjw91PxwpiY00nPq4ivGR4l3zx+hLlmZr+sKltq9+TPS1dfdfmacVA3UY
	 IZpiF4SaDlP7Q==
Message-ID: <bf414725b1ee06a03f766a2b1c976b71161570a2.camel@kernel.org>
Subject: Re: [PATCH v8 09/18] nfsd: use percpu_ref to interlock
 nfsd_destroy_serv and nfsd_open_local_fh
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Thu, 27 Jun 2024 07:24:54 -0400
In-Reply-To: <20240626182438.69539-10-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
	 <20240626182438.69539-10-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> Introduce nfsd_serv_get and nfsd_serv_put and update the nfsd code to
> prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> client initiated localio calls to nfsd (that are _not_ in the context
> of nfsd) are complete.
>=20
> nfsd_open_local_fh is updated to nfsd_serv_get before opening its file
> handle and then drop the reference using nfsd_serv_put at the end of
> nfsd_open_local_fh.
>=20
> This "interlock" working relies heavily on nfsd_open_local_fh()'s
> maybe_get_net() safely dealing with the possibility that the struct
> net (and nfsd_net by association) may have been destroyed by
> nfsd_destroy_serv() via nfsd_shutdown_net().
>=20
> Verified to fix an easy to hit crash that would occur if an nfsd
> instance running in a container, with a localio client mounted, is
> shutdown. Upon restart of the container and associated nfsd the client
> would go on to crash due to NULL pointer dereference that occuured due
> to the nfs client's localio attempting to nfsd_open_local_fh(), using
> nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfsd/localio.c |=C2=A0 2 ++
> =C2=A0fs/nfsd/netns.h=C2=A0=C2=A0 |=C2=A0 8 +++++++-
> =C2=A0fs/nfsd/nfssvc.c=C2=A0 | 39 +++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 48118db801b5..819589ae2008 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -204,6 +204,7 @@ int nfsd_open_local_fh(struct net *net,
> =C2=A0	}
> =C2=A0	nn =3D net_generic(net, nfsd_net_id);
> =C2=A0
> +	nfsd_serv_get(nn);
> =C2=A0	serv =3D READ_ONCE(nn->nfsd_serv);
> =C2=A0	if (unlikely(!serv)) {
> =C2=A0		dprintk("%s: localio denied. Server not running\n", __func__);
> @@ -244,6 +245,7 @@ int nfsd_open_local_fh(struct net *net,
> =C2=A0out_revertcred:
> =C2=A0	revert_creds(save_cred);
> =C2=A0out_net:
> +	nfsd_serv_put(nn);
> =C2=A0	put_net(net);
> =C2=A0	return status;
> =C2=A0}
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 0c5a1d97e4ac..17a73c780ca1 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/filelock.h>
> =C2=A0#include <linux/nfs4.h>
> =C2=A0#include <linux/percpu_counter.h>
> +#include <linux/percpu-refcount.h>
> =C2=A0#include <linux/siphash.h>
> =C2=A0#include <linux/sunrpc/stats.h>
> =C2=A0#include <linux/nfslocalio.h>
> @@ -140,7 +141,9 @@ struct nfsd_net {
> =C2=A0
> =C2=A0	struct svc_info nfsd_info;
> =C2=A0#define nfsd_serv nfsd_info.serv
> -
> +	struct percpu_ref nfsd_serv_ref;
> +	struct completion nfsd_serv_confirm_done;
> +	struct completion nfsd_serv_free_done;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * clientid and stateid data for construction of net unique COPY
> @@ -225,6 +228,9 @@ struct nfsd_net {
> =C2=A0extern bool nfsd_support_version(int vers);
> =C2=A0extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> =C2=A0
> +void nfsd_serv_get(struct nfsd_net *nn);
> +void nfsd_serv_put(struct nfsd_net *nn);
> +
> =C2=A0extern unsigned int nfsd_net_id;
> =C2=A0
> =C2=A0void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index a477d2c5088a..be5acb7a4057 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -258,6 +258,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minor=
version, enum vers_op change
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +void nfsd_serv_get(struct nfsd_net *nn)
> +{
> +	percpu_ref_get(&nn->nfsd_serv_ref);
> +}
> +
> +void nfsd_serv_put(struct nfsd_net *nn)
> +{
> +	percpu_ref_put(&nn->nfsd_serv_ref);
> +}
> +
> +static void nfsd_serv_done(struct percpu_ref *ref)
> +{
> +	struct nfsd_net *nn =3D container_of(ref, struct nfsd_net, nfsd_serv_re=
f);
> +
> +	complete(&nn->nfsd_serv_confirm_done);
> +}
> +
> +static void nfsd_serv_free(struct percpu_ref *ref)
> +{
> +	struct nfsd_net *nn =3D container_of(ref, struct nfsd_net, nfsd_serv_re=
f);
> +
> +	complete(&nn->nfsd_serv_free_done);
> +}
> +
> =C2=A0/*
> =C2=A0 * Maximum number of nfsd processes
> =C2=A0 */
> @@ -462,6 +486,7 @@ static void nfsd_shutdown_net(struct net *net)
> =C2=A0		lockd_down(net);
> =C2=A0		nn->lockd_up =3D false;
> =C2=A0	}
> +	percpu_ref_exit(&nn->nfsd_serv_ref);
> =C2=A0#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> =C2=A0	list_del_rcu(&nn->nfsd_uuid.list);
> =C2=A0#endif
> @@ -544,6 +569,13 @@ void nfsd_destroy_serv(struct net *net)
> =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =C2=A0	struct svc_serv *serv =3D nn->nfsd_serv;
> =C2=A0
> +	lockdep_assert_held(&nfsd_mutex);
> +
> +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
> +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> +	wait_for_completion(&nn->nfsd_serv_free_done);
> +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> +

At this point where you're waiting on these completion vars, what stops
the client from issuing new localio requests?


> =C2=A0	spin_lock(&nfsd_notifier_lock);
> =C2=A0	nn->nfsd_serv =3D NULL;
> =C2=A0	spin_unlock(&nfsd_notifier_lock);
> @@ -666,6 +698,13 @@ int nfsd_create_serv(struct net *net)
> =C2=A0	if (nn->nfsd_serv)
> =C2=A0		return 0;
> =C2=A0
> +	error =3D percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
> +				0, GFP_KERNEL);
> +	if (error)
> +		return error;
> +	init_completion(&nn->nfsd_serv_free_done);
> +	init_completion(&nn->nfsd_serv_confirm_done);
> +
> =C2=A0	if (nfsd_max_blksize =3D=3D 0)
> =C2=A0		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
> =C2=A0	nfsd_reset_versions(nn);

--=20
Jeff Layton <jlayton@kernel.org>

