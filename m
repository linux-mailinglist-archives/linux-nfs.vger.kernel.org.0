Return-Path: <linux-nfs+bounces-19421-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDFBNdG/oWnPwAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19421-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:01:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328761BA763
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271E03050D41
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D24449EDE;
	Fri, 27 Feb 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6XS8A6V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9B44A731
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207840; cv=none; b=LKJpOBy3A9AJ1GrObn0SJ7kPwbPvB49bIMfCDtP6F5kuHzsg18p3b2NnBI3tFCglhllKMNznBE9Bvccto750lNpOK4SKkXFevCuV8LY0cIDBdGyY0KNBqGEqUIz7bp5D02sCtHownfUxL6vsrmdS4go7MmIjOY9gbtvLqL54b0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207840; c=relaxed/simple;
	bh=cLlfa1nz2pq1khEhTKdpQKrPi6Nm7WmtdQHJFzyO1MQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=STgArFwwIhi4dLXwVUiYfxmevLsDbE/7KvX+0H9UIRwoSoeLvbmUyGT1G7jpCWkWy5RIaOe/9uVOO8/Etg/w2Y8MdC3X8D1NcTAQFQp2MEwoG0hiOf5oqqfYlB22fHgAhT6s/Q46s5HXNkYj09GV1zoo2vZ72Gk+fCa8z17WZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6XS8A6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27BAC4AF09;
	Fri, 27 Feb 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772207840;
	bh=cLlfa1nz2pq1khEhTKdpQKrPi6Nm7WmtdQHJFzyO1MQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=l6XS8A6V6A7Zvwacw1pWdIoG7UpX5LioDDVXoj5kaiSQiwAvkwQrLjcGsBGAIO/Xe
	 C+ANat5y/LSDvucg+q0d5sXTe/ETl0E4qwSDdwdL/Qb/ePjW7B8kXjWPHPS7v0z3aB
	 8V0fKNzpVklfhw94VJ3DEZhFy9Sksv3whJqXLXV/VpPhLf/bUsbiPpLyIl+n5hFO9o
	 NE1UmNOla71vLNbF0dMXGJ628+jChL9xbsU6kJVa2PeemHXrSHoTJVJoWfR/TYFs2z
	 ZZVP2yCvS5n8xW10i5T66veyAoDfLcJ1gxcsj7WC3E+tQLEggPrskBaeCqprpLYO6b
	 9dqIkB7+dz/Ng==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C3DE1F40068;
	Fri, 27 Feb 2026 10:57:18 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Feb 2026 10:57:18 -0500
X-ME-Sender: <xms:3r6haT4ZwrH8jPvIVLPIN3aMIgR_q_S-gdhv_rFgzB6_khJwWXuo9g>
    <xme:3r6haTtHCfczU1ua52v5VMMOKU0UKCjR_BGmrpF6svz5qb6u23U85urNwKbY54H9N
    REwleA9iyDRrq2LjJXmbItS38DqDb6JHTavnmm-6KU-Ut4xp-Z6DC0R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3r6hacNLY7h5oeEP49ENP9Br4RQwncwa89VaEXStiibCy2aAMCmrzw>
    <xmx:3r6hac-RBR9BU6oMnuwj0RN4CHS51K3KPm2O1b_vDeIxs5FinGYk-w>
    <xmx:3r6haZ6dcUtrRs8d0d-wQzUuBUvWN4A4Z8Kt9dTGwMNrEkbX_5AEpQ>
    <xmx:3r6haS4OXGV8cutVzdlRMwmIALA8oIG5XNKfjqIzsk3OwyEZ2uSyBQ>
    <xmx:3r6haSquGlantMdU4AqqvFZUGVIlgfubu_FEkeINHYih7TBlos9ECdc0>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 841CC780075; Fri, 27 Feb 2026 10:57:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArjKq1Rg27YJ
Date: Fri, 27 Feb 2026 10:56:57 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <a4bf76dc-2805-415e-be50-5501ea1ebf9a@app.fastmail.com>
In-Reply-To: <20260226193611.1038076-1-dai.ngo@oracle.com>
References: <20260226193611.1038076-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v5 1/1] NFSD: move accumulated callback ops to per-net namespace
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-19421-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email];
	RSPAMD_URIBL_FAIL(0.00)[oracle.com:query timed out];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[dai.ngo.oracle.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 328761BA763
X-Rspamd-Action: no action



On Thu, Feb 26, 2026, at 2:35 PM, Dai Ngo wrote:
> Track accumulated callback operations on a per-network-namespace basis
> instead of globally, ensuring proper isolation and behavior when runni=
ng
> nfsd in containers.

Where are the consumers of this information? "Subsequent patch"
is an OK answer, but that should be indicated here in your patch
description.


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h        |  5 +++
>  fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
>  fs/nfsd/nfsctl.c       |  5 +++
>  fs/nfsd/state.h        |  2 ++
>  4 files changed, 52 insertions(+), 35 deletions(-)
>
> v2:
>   . free memory allocated for nn->nfsd_cb_version4.counts in
>     nfsd_net_cb_stats_init() on error in nfsd_net_init().
> v3:
>   . reword commit message.
>   . fix initialization of nn->nfsd_cb_program.nrvers.
> v4:
>   . fix merge conflict in nfsd_net_exit in nfsd-testing branch.
> v5:
>   . restore commit message to the original in v1
>
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 6ad3fe5d7e12..c101bf2c24c2 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -228,6 +228,11 @@ struct nfsd_net {
>  	struct list_head	local_clients;
>  #endif
>  	siphash_key_t		*fh_key;
> +
> +	struct rpc_version	nfsd_cb_version4;
> +	const struct rpc_version *nfsd_cb_versions[2];

I know this is copy-paste of existing code, but can you find a
proper symbolic constant to use here instead of "2" ?


> +	struct rpc_program	nfsd_cb_program;
> +	struct rpc_stat		nfsd_cb_stat;
>  };
>=20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index aea8bdd2fdc4..759f24657c34 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rq=
st *rqstp,
>  	.p_decode  =3D nfs4_xdr_dec_##restype,				\
>  	.p_arglen  =3D NFS4_enc_##argtype##_sz,				\
>  	.p_replen  =3D NFS4_dec_##restype##_sz,				\
> -	.p_statidx =3D NFSPROC4_CB_##call,				\
> +	.p_statidx =3D NFSPROC4_CLNT_##proc,				\
>  	.p_name    =3D #proc,						\
>  }

Previously all compound-based callbacks mapped to statidx 1
(NFSPROC4_CB_COMPOUND); now each operation gets its own counter
slot (values 0=E2=80=937). This changes what stats are reported, IIUC.
So bundling it here means a bisect on a stats regression cannot
isolate when accounting changed, and reverting either change
forces reverting both.

IMO this should be a pre-requisite commit with its own
rationale.


> @@ -1032,40 +1032,7 @@ static const struct rpc_procinfo nfs4_cb_proced=
ures[] =3D {
>  	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
>  };
>=20
> -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> -static const struct rpc_version nfs_cb_version4 =3D {
> -/*
> - * Note on the callback rpc program version number: despite language =
in rfc
> - * 5661 section 18.36.3 requiring servers to use 4 in this field, the
> - * official xdr descriptions for both 4.0 and 4.1 specify version 1, =
and
> - * in practice that appears to be what implementations use.  The sect=
ion
> - * 18.36.3 language is expected to be fixed in an erratum.
> - */
> -	.number			=3D 1,
> -	.nrprocs		=3D ARRAY_SIZE(nfs4_cb_procedures),
> -	.procs			=3D nfs4_cb_procedures,
> -	.counts			=3D nfs4_cb_counts,
> -};
> -
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
>  #define NFS4_CALLBACK 0x40000000
> -static const struct rpc_program cb_program =3D {
> -	.name			=3D "nfs4_cb",
> -	.number			=3D NFS4_CALLBACK,
> -	.nrvers			=3D ARRAY_SIZE(nfs_cb_version),
> -	.version		=3D nfs_cb_version,
> -	.stats			=3D &cb_stats,
> -	.pipe_dir_name		=3D "nfsd4_cb",
> -};
>=20
>  static int max_cb_time(struct net *net)
>  {
> @@ -1152,14 +1119,15 @@ static int setup_callback_client(struct=20
> nfs4_client *clp, struct nfs4_cb_conn *c
>  		.addrsize	=3D conn->cb_addrlen,
>  		.saddress	=3D (struct sockaddr *) &conn->cb_saddr,
>  		.timeout	=3D &timeparms,
> -		.program	=3D &cb_program,
>  		.version	=3D 1,
>  		.flags		=3D (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
>  		.cred		=3D current_cred(),
>  	};
>  	struct rpc_clnt *client;
>  	const struct cred *cred;
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);

Nit: Reverse Christmas tree ordering -- this new declaration
belongs close to the top.


> +	args.program =3D &nn->nfsd_cb_program;
>  	if (clp->cl_minorversion =3D=3D 0) {
>  		if (!clp->cl_cred.cr_principal &&
>  		    (clp->cl_cred.cr_flavor >=3D RPC_AUTH_GSS_KRB5)) {
> @@ -1786,3 +1754,40 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>  		nfsd41_cb_inflight_end(clp);
>  	return queued;
>  }
> +
> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn)
> +{
> +	kfree(nn->nfsd_cb_version4.counts);
> +}
> +
> +int nfsd_net_cb_stats_init(struct nfsd_net *nn)
> +{
> +	nn->nfsd_cb_version4.counts =3D kzalloc_objs(unsigned int,
> +			ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
> +	if (!nn->nfsd_cb_version4.counts)
> +		return -ENOMEM;
> +	/*
> +	 * Note on the callback rpc program version number: despite language
> +	 * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
> +	 * field, the official xdr descriptions for both 4.0 and 4.1 specify
> +	 * version 1, and in practice that appears to be what implementations
> +	 * use. The section 18.36.3 language is expected to be fixed in an
> +	 * erratum.
> +	 */
> +	nn->nfsd_cb_version4.number =3D 1;
> +
> +	nn->nfsd_cb_version4.nrprocs =3D ARRAY_SIZE(nfs4_cb_procedures);
> +	nn->nfsd_cb_version4.procs =3D nfs4_cb_procedures;
> +	nn->nfsd_cb_versions[1] =3D &nn->nfsd_cb_version4;

Could you add a comment explaining that slot 0 is intentionally
NULL and slot 1 corresponds to the CB protocol version number?
The original designated-initializer syntax made this self-
evident; the replacement imperative assignment here does not.


> +
> +	memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb_stat));
> +	nn->nfsd_cb_program.name =3D "nfs4_cb";
> +	nn->nfsd_cb_program.number =3D NFS4_CALLBACK;
> +	nn->nfsd_cb_program.nrvers =3D ARRAY_SIZE(nn->nfsd_cb_versions);
> +	nn->nfsd_cb_program.version =3D &nn->nfsd_cb_versions[0];
> +	nn->nfsd_cb_program.pipe_dir_name =3D "nfsd4_cb";
> +	nn->nfsd_cb_program.stats =3D &nn->nfsd_cb_stat;
> +	nn->nfsd_cb_stat.program =3D &nn->nfsd_cb_program;
> +
> +	return 0;
> +}

New non-static functions should get kernel-doc comments.


> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 032ab44feb70..5daa647ef0fa 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net *=
net)
>  	int retval;
>  	int i;
>=20
> +	retval =3D nfsd_net_cb_stats_init(nn);
> +	if (retval)
> +		return retval;

Does this build if CONFIG_NFSD_V4 is not enabled?


>  	retval =3D nfsd_export_init(net);
>  	if (retval)
>  		goto out_export_error;
> @@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *=
net)
>  out_idmap_error:
>  	nfsd_export_shutdown(net);
>  out_export_error:
> +	nfsd_net_cb_stats_shutdown(nn);
>  	return retval;
>  }
>=20
> @@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net =
*net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
>  	kfree_sensitive(nn->fh_key);
> +	nfsd_net_cb_stats_shutdown(nn);
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9b05462da4cc..490193c1877d 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
>  struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_stat=
e *cstate,
>  						struct nfsd4_get_dir_delegation *gdd,
>  						struct nfsd_file *nf);
> +int nfsd_net_cb_stats_init(struct nfsd_net *nn);
> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
>  #endif   /* NFSD4_STATE_H */
> --=20
> 2.47.3

--=20
Chuck Lever

