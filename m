Return-Path: <linux-nfs+bounces-4309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC639174A4
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E087B20C67
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60917D88C;
	Tue, 25 Jun 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AwOaT/7v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FDqKHPX6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AwOaT/7v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FDqKHPX6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2F146A64
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357678; cv=none; b=MXCgOEADLHrsc1rxphcElXGPyDuAeRlXMO0KiIR97Qk47EFpP+Q6wCKFezmAR+fxuryOVkwZsnxwIF6fV5tm2DmjsHh+dEg32dYiJJ+irhbbYTFemZEQLX9EXwswi9FKs4v2E4iF+tPlGJAl4un8lf/ZJrFxn10J+G4D2q4KLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357678; c=relaxed/simple;
	bh=tr8VbgvBO9CGyVA7JgsewDZaEYuZRFwwQKWed82yI94=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Up2octVhT0ffr/stjTd6ClW/A56DCRQd//NWoRT+t6QyaX2P7HFgleg1iTQ0HT/WFW14ry3iDDcjQTQVHWi38VzZbPDnL3d+TcWL70M2xS7Y8yqdAiKAVhohJ95ZvpD//0v//QLjU2fkm03vl2OULwchxWcEUTBSUtJJqxOUxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwOaT/7v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FDqKHPX6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwOaT/7v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FDqKHPX6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0262621A5E;
	Tue, 25 Jun 2024 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKMcY658qig9ncJexNLaUNbiUZK6uCir1F4ltU80Q50=;
	b=AwOaT/7vJNZk2pIIbKYBBexk5mHki2NmARfFau0lKISDVFjIrCuMGxjpDODPgJLoSedQoc
	cbpSpnsZ+9NoFg+JX26nKtoK5cFahIaoVKfb3roekmJS+8nQTPgm47JT3MXRSWmd0FfK0i
	sl0snVvmZMlhR9D9owQzPkOheQ/C3k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKMcY658qig9ncJexNLaUNbiUZK6uCir1F4ltU80Q50=;
	b=FDqKHPX6tb/DJ95aJp4mjEqj9rS/CxvdNNhFEsQ3OoOvf1VByAlJIOtHAUQjhwSoLYJIGn
	yMI3bgqwR0MyJ7Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKMcY658qig9ncJexNLaUNbiUZK6uCir1F4ltU80Q50=;
	b=AwOaT/7vJNZk2pIIbKYBBexk5mHki2NmARfFau0lKISDVFjIrCuMGxjpDODPgJLoSedQoc
	cbpSpnsZ+9NoFg+JX26nKtoK5cFahIaoVKfb3roekmJS+8nQTPgm47JT3MXRSWmd0FfK0i
	sl0snVvmZMlhR9D9owQzPkOheQ/C3k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKMcY658qig9ncJexNLaUNbiUZK6uCir1F4ltU80Q50=;
	b=FDqKHPX6tb/DJ95aJp4mjEqj9rS/CxvdNNhFEsQ3OoOvf1VByAlJIOtHAUQjhwSoLYJIGn
	yMI3bgqwR0MyJ7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 659451384C;
	Tue, 25 Jun 2024 23:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YB//AuhQe2bZRwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Jun 2024 23:21:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject:
 Re: [PATCH v7 13/20] nfs: implement client support for NFS_LOCALIO_PROGRAM
In-reply-to: <20240624162741.68216-14-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>,
 <20240624162741.68216-14-snitzer@kernel.org>
Date: Wed, 26 Jun 2024 09:21:00 +1000
Message-id: <171935766072.14261.2299610894569720025@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Tue, 25 Jun 2024, Mike Snitzer wrote:
> LOCALIOPROC_GETUUID allows a client to discover the server's uuid.
>=20
> nfs_local_probe() will retrieve server's uuid via LOCALIO protocol and
> verify the server with that uuid it is known to be local. This ensures
> client and server 1: support localio 2: are local to each other.
>=20
> All the knowledge of the LOCALIO RPC protocol is in fs/nfs/localio.c
> which implements just a single version (1) that is used independently
> of what NFS version is used.
>=20
> Get nfsd_open_local_fh and store it in rpc_client during client
> creation, put the symbol during nfs_local_disable -- which is also
> called during client destruction.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> [neilb: factored out and simplified single localio protocol]
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/client.c     |   6 +-
>  fs/nfs/localio.c    | 159 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/nfs.h |   7 ++
>  3 files changed, 161 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 1300c388f971..6faa9fdc444d 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -434,8 +434,10 @@ struct nfs_client *nfs_get_client(const struct nfs_cli=
ent_initdata *cl_init)
>  			list_add_tail(&new->cl_share_link,
>  					&nn->nfs_client_list);
>  			spin_unlock(&nn->nfs_client_lock);
> -			nfs_local_probe(new);
> -			return rpc_ops->init_client(new, cl_init);
> +			new =3D rpc_ops->init_client(new, cl_init);
> +			if (!IS_ERR(new))
> +				 nfs_local_probe(new);
> +			return new;

I would fold this back into the earlier patch that introduced
nfs_local_probe().  It makes this patch ugly.
But I won't insist.

NeilBrown



>  		}
> =20
>  		spin_unlock(&nn->nfs_client_lock);
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 418b8d76692b..e4f860a51170 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -15,6 +15,7 @@
>  #include <linux/sunrpc/addr.h>
>  #include <linux/inetdevice.h>
>  #include <net/addrconf.h>
> +#include <linux/nfslocalio.h>
>  #include <linux/module.h>
>  #include <linux/bvec.h>
> =20
> @@ -123,13 +124,72 @@ nfs4errno(int errno)
>  static bool localio_enabled __read_mostly =3D true;
>  module_param(localio_enabled, bool, 0644);
> =20
> +static inline bool nfs_client_is_local(const struct nfs_client *clp)
> +{
> +	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +}
> +
>  bool nfs_server_is_local(const struct nfs_client *clp)
>  {
> -	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) !=3D 0 &&
> -		localio_enabled;
> +	return nfs_client_is_local(clp) && localio_enabled;
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_is_local);
> =20
> +/*
> + * GETUUID XDR functions
> + */
> +
> +static void localio_xdr_enc_getuuidargs(struct rpc_rqst *req,
> +					struct xdr_stream *xdr,
> +					const void *data)
> +{
> +	/* void function */
> +}
> +
> +static int localio_xdr_dec_getuuidres(struct rpc_rqst *req,
> +				      struct xdr_stream *xdr,
> +				      void *result)
> +{
> +	u8 *uuid =3D result;
> +
> +	return decode_opaque_fixed(xdr, uuid, UUID_SIZE);
> +}
> +
> +static const struct rpc_procinfo nfs_localio_procedures[] =3D {
> +	[LOCALIOPROC_GETUUID] =3D {
> +		.p_proc =3D LOCALIOPROC_GETUUID,
> +		.p_encode =3D localio_xdr_enc_getuuidargs,
> +		.p_decode =3D localio_xdr_dec_getuuidres,
> +		.p_arglen =3D 0,
> +		.p_replen =3D XDR_QUADLEN(UUID_SIZE),
> +		.p_statidx =3D LOCALIOPROC_GETUUID,
> +		.p_name =3D "GETUUID",
> +	},
> +};
> +
> +static unsigned int nfs_localio_counts[ARRAY_SIZE(nfs_localio_procedures)];
> +const struct rpc_version nfslocalio_version1 =3D {
> +	.number			=3D 1,
> +	.nrprocs		=3D ARRAY_SIZE(nfs_localio_procedures),
> +	.procs			=3D nfs_localio_procedures,
> +	.counts			=3D nfs_localio_counts,
> +};
> +
> +static const struct rpc_version *nfslocalio_version[] =3D {
> +       [1]			=3D &nfslocalio_version1,
> +};
> +
> +extern const struct rpc_program nfslocalio_program;
> +static struct rpc_stat		nfslocalio_rpcstat =3D { &nfslocalio_program };
> +
> +const struct rpc_program nfslocalio_program =3D {
> +	.name			=3D "nfslocalio",
> +	.number			=3D NFS_LOCALIO_PROGRAM,
> +	.nrvers			=3D ARRAY_SIZE(nfslocalio_version),
> +	.version		=3D nfslocalio_version,
> +	.stats			=3D &nfslocalio_rpcstat,
> +};
> +
>  /*
>   * nfs_local_enable - attempt to enable local i/o for an nfs_client
>   */
> @@ -149,20 +209,100 @@ void nfs_local_disable(struct nfs_client *clp)
>  {
>  	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
>  		trace_nfs_local_disable(clp);
> +		put_nfsd_open_local_fh();
> +		clp->nfsd_open_local_fh =3D NULL;
> +		if (!IS_ERR(clp->cl_rpcclient_localio)) {
> +			rpc_shutdown_client(clp->cl_rpcclient_localio);
> +			clp->cl_rpcclient_localio =3D ERR_PTR(-EINVAL);
> +		}
>  		clp->cl_nfssvc_net =3D NULL;
>  	}
>  }
> =20
>  /*
> - * nfs_local_probe - probe local i/o support for an nfs_client
> + * nfs_init_localioclient - Initialise an NFS localio client connection
>   */
> -void
> -nfs_local_probe(struct nfs_client *clp)
> +static void nfs_init_localioclient(struct nfs_client *clp)
>  {
> -	bool enable =3D false;
> +	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio)))
> +		goto out;
> +	clp->cl_rpcclient_localio =3D rpc_bind_new_program(clp->cl_rpcclient,
> +							 &nfslocalio_program, 1);
> +	if (IS_ERR(clp->cl_rpcclient_localio))
> +		goto out;
> +	/* No errors! Assume that localio is supported */
> +	clp->nfsd_open_local_fh =3D get_nfsd_open_local_fh();
> +	if (!clp->nfsd_open_local_fh) {
> +		rpc_shutdown_client(clp->cl_rpcclient_localio);
> +		clp->cl_rpcclient_localio =3D ERR_PTR(-EINVAL);
> +	}
> +out:
> +	dprintk_rcu("%s: server (%s) %s NFS LOCALIO, nfsd_open_local_fh is %s.\n",
> +		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
> +		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"),
> +		(clp->nfsd_open_local_fh ? "set" : "not set"));
> +}
> =20
> -	if (enable)
> -		nfs_local_enable(clp);
> +static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_=
uuid)
> +{
> +	u8 uuid[UUID_SIZE];
> +	struct rpc_message msg =3D {
> +		.rpc_resp =3D &uuid,
> +	};
> +	int status;
> +
> +	nfs_init_localioclient(clp);
> +	if (IS_ERR(clp->cl_rpcclient_localio))
> +		return false;
> +
> +	dprintk("%s: NFS issuing getuuid\n", __func__);
> +	msg.rpc_proc =3D &nfs_localio_procedures[LOCALIOPROC_GETUUID];
> +	status =3D rpc_call_sync(clp->cl_rpcclient_localio, &msg, 0);
> +	dprintk("%s: NFS reply getuuid: status=3D%d uuid=3D%pU\n",
> +		__func__, status, uuid);
> +	if (status)
> +		return false;
> +
> +	import_uuid(nfsd_uuid, uuid);
> +
> +	return true;
> +}
> +
> +/*
> + * nfs_local_probe - probe local i/o support for an nfs_server and nfs_cli=
ent
> + * - called after alloc_client and init_client (so cl_rpcclient exists)
> + * - this function is idempotent, it can be called for old or new clients
> + */
> +void nfs_local_probe(struct nfs_client *clp)
> +{
> +	uuid_t uuid;
> +	struct net *net =3D NULL;
> +
> +	if (!localio_enabled || clp->cl_rpcclient->cl_vers =3D=3D 2)
> +		goto unsupported;
> +
> +	if (nfs_client_is_local(clp)) {
> +		/* If already enabled, disable and re-enable */
> +		nfs_local_disable(clp);
> +	}
> +
> +	/*
> +	 * Retrieve server's uuid via LOCALIO protocol and verify the
> +	 * server with that uuid is known to be local. This ensures
> +	 * client and server 1: support localio 2: are local to each other
> +	 * by verifying client's nfsd, with specified uuid, is local.
> +	 */
> +	if (!nfs_local_server_getuuid(clp, &uuid) ||
> +	    !nfsd_uuid_is_local(&uuid, &net))
> +		goto unsupported;
> +
> +	dprintk("%s: detected local server.\n", __func__);
> +	nfs_local_enable(clp, net);
> +	return;
> +
> +unsupported:
> +	/* localio not supported */
> +	nfs_local_disable(clp);
>  }
>  EXPORT_SYMBOL_GPL(nfs_local_probe);
> =20
> @@ -189,7 +329,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct =
cred *cred,
>  		trace_nfs_local_open_fh(fh, mode, status);
>  		switch (status) {
>  		case -ENXIO:
> -			nfs_local_disable(clp);
> +			/* Revalidate localio, will disable if unsupported */
> +			nfs_local_probe(clp);
>  			fallthrough;
>  		case -ETIMEDOUT:
>  			status =3D -EAGAIN;
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index 64ed672a0b34..036f6b0ed94d 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -15,6 +15,13 @@
>  #include <linux/crc32.h>
>  #include <uapi/linux/nfs.h>
> =20
> +/* The localio program is entirely private to Linux and is
> + * NOT part of the uapi.
> + */
> +#define NFS_LOCALIO_PROGRAM	400122
> +#define LOCALIOPROC_NULL	0
> +#define LOCALIOPROC_GETUUID	1
> +
>  /*
>   * This is the kernel NFS client file handle representation
>   */
> --=20
> 2.44.0
>=20
>=20


