Return-Path: <linux-nfs+bounces-20167-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC7oH+BOtWm8zAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20167-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 13:04:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D733328CFA9
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 13:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6C5300F120
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F5A25A640;
	Sat, 14 Mar 2026 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa+9ZINj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0D218845
	for <linux-nfs@vger.kernel.org>; Sat, 14 Mar 2026 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489885; cv=none; b=l6QWqAZodJGqo0OaJBUcVmS64UQviOYlDXKpS+t9tmcc/iR0KUsBcrvXnVdZdboJyjbKdGwV/Jtfjyh6Tbqv8MeHy79ldNjCbU8o2Lbvgwq7CsPSgkkAacxbN+j9/VAx1nRrzV800nkKqAdm9FmxFid1FvV/DobMxudA7Z9GF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489885; c=relaxed/simple;
	bh=Y7ckMZgEl00LznNwTECA3T/nE5iwTMV5CweFHfTxmaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqZbiIvgWGjLgjj1EOu1p3t9ptrOQH1aMB+7QbqSkRlAZ0DMPDaIf6T67Dikvvc/CfcfF8uP+kPK0TZXTvD7r/Srt2/3upvCeh5DILfuX4hjAV6/SSghzcPm4NDW+CghseP6ueUO1P26vUDOFLStWNKVvOTO34/3X84quuDlb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa+9ZINj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EBC116C6;
	Sat, 14 Mar 2026 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773489884;
	bh=Y7ckMZgEl00LznNwTECA3T/nE5iwTMV5CweFHfTxmaw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Fa+9ZINjUuVHhvaUPx798s03bMiMc46lUwzFsEk447RMHbSMaS+re416n73ELfodt
	 c5I2uO+eA9ZGlO8jeUDqp779e+96NFsyZFmOvabf1ESTQdp53xhjzlAwhGJy3p9cXf
	 ZeiZelgigb7l48Ylm8xUViBCtHB9WnUabCNcnfQqDTUvdjXag0BoVzl3+Jgp9QlsvS
	 6/zpLXfday7kvMJ03cI8QC0dRDk6jnnyNuYGS7mjMXpqM8s1V3U6ocC7ghwk4tvC7r
	 zJRVjLPWh1c+axDqpFe3gkvzj3Xj92yrFwEuiinm9s4VqHd6m1EtXOiezniNhFGXki
	 SzFvDHt9j+nrg==
Message-ID: <5df3076a22438f5be6b070e62c0d3fc567341b20.camel@kernel.org>
Subject: Re: [PATCH v7 2/2] NFSD: convert callback RPC program to per-net
 namespace
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Sat, 14 Mar 2026 08:04:42 -0400
In-Reply-To: <20260313163148.281676-3-cel@kernel.org>
References: <20260313163148.281676-1-cel@kernel.org>
	 <20260313163148.281676-3-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20167-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D733328CFA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-13 at 12:31 -0400, Chuck Lever wrote:
> From: Dai Ngo <dai.ngo@oracle.com>
>=20
> The callback channel's rpc_program, rpc_version, rpc_stat,
> and per-procedure counts are declared as file-scope statics in
> nfs4callback.c, shared across all network namespaces.
> Forechannel RPC statistics are already maintained per-netns
> (via nfsd_svcstats in struct nfsd_net); the backchannel
> has no such separation. When backchannel statistics are
> eventually surfaced to userspace, the global counters would
> expose cross-namespace data.
>=20
> Allocate per-netns copies of these structures through a new
> opaque struct nfsd_net_cb, managed by nfsd_net_cb_init()
> and nfsd_net_cb_shutdown(). The struct definition is private
> to nfs4callback.c; struct nfsd_net holds only a pointer.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/netns.h        |   3 ++
>  fs/nfsd/nfs4callback.c | 111 ++++++++++++++++++++++++++++-------------
>  fs/nfsd/nfsctl.c       |   5 ++
>  fs/nfsd/state.h        |   9 ++++
>  4 files changed, 94 insertions(+), 34 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 6ad3fe5d7e12..27da1a3edacb 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -25,6 +25,7 @@
>  #define SESSION_HASH_SIZE	512
> =20
>  struct cld_net;
> +struct nfsd_net_cb;
>  struct nfsd4_client_tracking_ops;
> =20
>  enum {
> @@ -228,6 +229,8 @@ struct nfsd_net {
>  	struct list_head	local_clients;
>  #endif
>  	siphash_key_t		*fh_key;
> +
> +	struct nfsd_net_cb	*nfsd_cb;

Given that there will only ever be one nfsd_cb per net, why not just
embed this struct inside the nfsd_net instead of doing a separate
allocation?

>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 74effafdd0dc..50827405468d 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1032,39 +1032,14 @@ static const struct rpc_procinfo nfs4_cb_procedur=
es[] =3D {
>  	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
>  };
> =20
> -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> -static const struct rpc_version nfs_cb_version4 =3D {
> -/*
> - * Note on the callback rpc program version number: despite language in =
rfc
> - * 5661 section 18.36.3 requiring servers to use 4 in this field, the
> - * official xdr descriptions for both 4.0 and 4.1 specify version 1, and
> - * in practice that appears to be what implementations use.  The section
> - * 18.36.3 language is expected to be fixed in an erratum.
> - */
> -	.number			=3D 1,
> -	.nrprocs		=3D ARRAY_SIZE(nfs4_cb_procedures),
> -	.procs			=3D nfs4_cb_procedures,
> -	.counts			=3D nfs4_cb_counts,
> -};
> +#define NFS4_CB_PROGRAM	0x40000000
> +#define NFS4_CB_VERSION	1
> =20
> -static const struct rpc_version *nfs_cb_version[2] =3D {
> -	[1] =3D &nfs_cb_version4,
> -};
> -
> -static const struct rpc_program cb_program;
> -
> -static struct rpc_stat cb_stats =3D {
> -	.program		=3D &cb_program
> -};
> -
> -#define NFS4_CALLBACK 0x40000000
> -static const struct rpc_program cb_program =3D {
> -	.name			=3D "nfs4_cb",
> -	.number			=3D NFS4_CALLBACK,
> -	.nrvers			=3D ARRAY_SIZE(nfs_cb_version),
> -	.version		=3D nfs_cb_version,
> -	.stats			=3D &cb_stats,
> -	.pipe_dir_name		=3D "nfsd4_cb",
> +struct nfsd_net_cb {
> +	struct rpc_version	version4;
> +	const struct rpc_version *versions[NFS4_CB_VERSION + 1];
> +	struct rpc_program	program;
> +	struct rpc_stat		stat;
>  };
> =20
>  static int max_cb_time(struct net *net)
> @@ -1140,6 +1115,7 @@ static const struct cred *get_backchannel_cred(stru=
ct nfs4_client *clp, struct r
> =20
>  static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb=
_conn *conn, struct nfsd4_session *ses)
>  {
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>  	int maxtime =3D max_cb_time(clp->net);
>  	struct rpc_timeout	timeparms =3D {
>  		.to_initval	=3D maxtime,
> @@ -1152,14 +1128,14 @@ static int setup_callback_client(struct nfs4_clie=
nt *clp, struct nfs4_cb_conn *c
>  		.addrsize	=3D conn->cb_addrlen,
>  		.saddress	=3D (struct sockaddr *) &conn->cb_saddr,
>  		.timeout	=3D &timeparms,
> -		.program	=3D &cb_program,
> -		.version	=3D 1,
> +		.version	=3D NFS4_CB_VERSION,
>  		.flags		=3D (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
>  		.cred		=3D current_cred(),
>  	};
>  	struct rpc_clnt *client;
>  	const struct cred *cred;
> =20
> +	args.program =3D &nn->nfsd_cb->program;
>  	if (clp->cl_minorversion =3D=3D 0) {
>  		if (!clp->cl_cred.cr_principal &&
>  		    (clp->cl_cred.cr_flavor >=3D RPC_AUTH_GSS_KRB5)) {
> @@ -1786,3 +1762,70 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>  		nfsd41_cb_inflight_end(clp);
>  	return queued;
>  }
> +
> +/**
> + * nfsd_net_cb_shutdown - release per-netns callback RPC program resourc=
es
> + * @nn: NFS server network namespace
> + *
> + * Frees resources allocated by nfsd_net_cb_init().
> + */
> +void nfsd_net_cb_shutdown(struct nfsd_net *nn)
> +{
> +	struct nfsd_net_cb *cb =3D nn->nfsd_cb;
> +
> +	if (cb) {
> +		kfree(cb->version4.counts);
> +		kfree(cb);
> +		nn->nfsd_cb =3D NULL;
> +	}
> +}
> +
> +/**
> + * nfsd_net_cb_init - initialize per-netns callback RPC program
> + * @nn: NFS server network namespace
> + *
> + * Sets up the callback RPC program, version table, procedure
> + * counts, and statistics structure for @nn. Caller must release
> + * these resources using nfsd_net_cb_shutdown().
> + *
> + * Return: 0 on success, or -ENOMEM if allocation fails.
> + */
> +int nfsd_net_cb_init(struct nfsd_net *nn)
> +{
> +	struct nfsd_net_cb *cb;
> +
> +	cb =3D kzalloc(sizeof(*cb), GFP_KERNEL);
> +	if (!cb)
> +		return -ENOMEM;
> +
> +	cb->version4.counts =3D kzalloc_objs(unsigned int,
> +			ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
> +	if (!cb->version4.counts) {
> +		kfree(cb);
> +		return -ENOMEM;
> +	}
> +	/*
> +	 * Note on the callback rpc program version number: despite language
> +	 * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
> +	 * field, the official xdr descriptions for both 4.0 and 4.1 specify
> +	 * version 1, and in practice that appears to be what implementations
> +	 * use. The section 18.36.3 language is expected to be fixed in an
> +	 * erratum.
> +	 */
> +	cb->version4.number =3D NFS4_CB_VERSION;
> +	cb->version4.nrprocs =3D ARRAY_SIZE(nfs4_cb_procedures);
> +	cb->version4.procs =3D nfs4_cb_procedures;
> +	cb->versions[NFS4_CB_VERSION] =3D &cb->version4;
> +
> +	cb->program.name =3D "nfs4_cb";
> +	cb->program.number =3D NFS4_CB_PROGRAM;
> +	cb->program.nrvers =3D ARRAY_SIZE(cb->versions);
> +	cb->program.version =3D &cb->versions[0];
> +	cb->program.pipe_dir_name =3D "nfsd4_cb";
> +	cb->program.stats =3D &cb->stat;
> +	cb->stat.program =3D &cb->program;
> +
> +	nn->nfsd_cb =3D cb;
> +
> +	return 0;
> +}
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 14d9458aeff0..988a79ec4a79 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  	int retval;
>  	int i;
> =20
> +	retval =3D nfsd_net_cb_init(nn);
> +	if (retval)
> +		return retval;
>  	retval =3D nfsd_export_init(net);
>  	if (retval)
>  		goto out_export_error;
> @@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  out_idmap_error:
>  	nfsd_export_shutdown(net);
>  out_export_error:
> +	nfsd_net_cb_shutdown(nn);
>  	return retval;
>  }
> =20
> @@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net *ne=
t)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
>  	kfree_sensitive(nn->fh_key);
> +	nfsd_net_cb_shutdown(nn);
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9b05462da4cc..953675eba5c3 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -862,6 +862,8 @@ struct nfsd_file *find_any_file(struct nfs4_file *f);
>  #ifdef CONFIG_NFSD_V4
>  void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
>  void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
> +int nfsd_net_cb_init(struct nfsd_net *nn);
> +void nfsd_net_cb_shutdown(struct nfsd_net *nn);
>  #else
>  static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super=
_block *sb)
>  {
> @@ -869,6 +871,13 @@ static inline void nfsd4_revoke_states(struct nfsd_n=
et *nn, struct super_block *
>  static inline void nfsd4_cancel_copy_by_sb(struct net *net, struct super=
_block *sb)
>  {
>  }
> +static inline int nfsd_net_cb_init(struct nfsd_net *nn)
> +{
> +	return 0;
> +}
> +static inline void nfsd_net_cb_shutdown(struct nfsd_net *nn)
> +{
> +}
>  #endif
> =20
>  /* grace period management */

--=20
Jeff Layton <jlayton@kernel.org>

