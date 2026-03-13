Return-Path: <linux-nfs+bounces-20147-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ8BEXsrtGkEigAAu9opvQ
	(envelope-from <linux-nfs+bounces-20147-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 16:21:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B4285D55
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 448AF306BDA9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3D3A8742;
	Fri, 13 Mar 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4IO1wJd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CA3A8740
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414119; cv=none; b=l3pkT0IW6552QD25uqcX1a+v7fWP6tFshB2M9ivI6XMtMD4UzSWg1m0t+1ZhPo7+q1ppLB6HcQeB90CvdPW1sEsPNF8dW+H8tDihf+iPJE6gThByCK8ONqKglvKqlSLvVZfESKtGdRois1BREbp02y0ExscIZI2feNgEQW0Tloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414119; c=relaxed/simple;
	bh=c0mySo/z+77zq8T6qGtP9A7vMAWZJ73r+ZNzBso+IR0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CJvwVa9665aCO7s7bgfVICWPLk86S8xeo6IL2aDb6hoItFRIJ17piFPaXQou85R2t3cyavpo+y4zzTnrFwuvMnT+1f0kV6+UjBJkSrXy9PoUU2Zj/GlbBp5QFVSdTdOiWNWxSvqlEJS2w6xnrPKCmsojTNiXpLDhclzV2vo2fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4IO1wJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77357C2BC87;
	Fri, 13 Mar 2026 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414118;
	bh=c0mySo/z+77zq8T6qGtP9A7vMAWZJ73r+ZNzBso+IR0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=K4IO1wJdYWs09Vqfz9lhXyszNfM9Z3Y+nYstcyCaDzi3YTUs2d8CX2OV/UaTDc9VL
	 lSgvAFRSq4XE6ysHNqErJGAuwkvzSQqTuDmpHivP4FU9/hbCN2/s9LTPDmM2TAdqQh
	 NZ82RGAvdOYTgfrfIhbfk0/Egi1xypQ9Vvajc3DhlVFjeOk6KCv15ptqOu5w9LEd1+
	 6eLDiSJJFaMBGwuXNqXudWiBWm7Pg9/lLL6xD4692vkv1a7vbolpTJjn7uKZZoqGOT
	 dbcgWYNPk2VQ5PP19io1mKzNU/JpTOEiN/aCiYHlr6Y4L6cuTaoNroSppyx96ghcSZ
	 mNeDP0W4t0Cxg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5536DF40068;
	Fri, 13 Mar 2026 11:01:57 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 13 Mar 2026 11:01:57 -0400
X-ME-Sender: <xms:5Sa0aZj2NkYWHwccaCJdHh5Ly32mJEsRynzAC2YGnRjE3xg8uMCc6w>
    <xme:5Sa0aY1iokZH0FONyndmyizGJCMUkef3ZUz2ed9AMeqzIfYblE_pI9YTNcm50nDR6
    aFsZkZHU_WPNhExR3x98FclijymAltyGrEE7VD3j3ke0d3Tx1P1vG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
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
X-ME-Proxy: <xmx:5Sa0aT3cf2ADm7hQYHxcds8rTFF1C-SVIOK-V5Iw54hUVhNWoqq0qw>
    <xmx:5Sa0acGxdFmqtGxiuxOJwUpEjZZR80TZFE1RH6VLLsEUTpLYVVFlig>
    <xmx:5Sa0aaijjVJNX5XZGtWj0ldel_qBy39zKelMGGIacdaWz680Bem2oQ>
    <xmx:5Sa0aXCc79a_MTl7l4MwDrUSLD8JMpO9IN6QViFf7ndjNNfNgniedg>
    <xmx:5Sa0aUSMlaQGBPqUCoHpG55XcZ-x1ysvY0bQI5Iupjk8qq6uMLQHEQ2A>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2575E780070; Fri, 13 Mar 2026 11:01:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMUnDyOFIn2o
Date: Fri, 13 Mar 2026 11:01:36 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <856fb692-7dfe-4bb6-a72b-98bb79a184ff@app.fastmail.com>
In-Reply-To: <20260313001428.2599438-1-dai.ngo@oracle.com>
References: <20260313001428.2599438-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v6 1/1] NFSD: move accumulated callback ops to per-net namespace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20147-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 488B4285D55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, Mar 12, 2026, at 8:14 PM, Dai Ngo wrote:
> The RPC statistics for the NFSD fore channel are tracked per network
> namespace, but the backchannel (callback) RPC statistics are currently
> maintained globally. This causes statistics to be shared across network
> namespaces and can produce misleading results when nfsd is run in
> containers.
>
> Move the accumulated backchannel/callback RPC statistics into
> per-network-namespace storage so each netns maintains independent
> counters.
>
> This change only relocates the accounting. User-facing retrieval and
> display of these per-netns callback statistics will be added in a
> follow-up patch.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h        |  5 +++
>  fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
>  fs/nfsd/nfsctl.c       | 11 +++++++
>  fs/nfsd/state.h        |  2 ++
>  4 files changed, 58 insertions(+), 35 deletions(-)
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
> v6:
>   . put the call nfsd_net_cb_stats_init and nfsd_net_cb_stats_shutdown
>     under CONFIG_NFSD_V4.
>
>   . reword commit message to clarify the intention of the patch.
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
> +	struct rpc_program	nfsd_cb_program;
> +	struct rpc_stat		nfsd_cb_stat;
>  };
> 
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index aea8bdd2fdc4..759f24657c34 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
>  	.p_decode  = nfs4_xdr_dec_##restype,				\
>  	.p_arglen  = NFS4_enc_##argtype##_sz,				\
>  	.p_replen  = NFS4_dec_##restype##_sz,				\
> -	.p_statidx = NFSPROC4_CB_##call,				\
> +	.p_statidx = NFSPROC4_CLNT_##proc,				\
>  	.p_name    = #proc,						\
>  }
> 
> @@ -1032,40 +1032,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>  	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
>  };
> 
> -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> -static const struct rpc_version nfs_cb_version4 = {
> -/*
> - * Note on the callback rpc program version number: despite language in rfc
> - * 5661 section 18.36.3 requiring servers to use 4 in this field, the
> - * official xdr descriptions for both 4.0 and 4.1 specify version 1, and
> - * in practice that appears to be what implementations use.  The section
> - * 18.36.3 language is expected to be fixed in an erratum.
> - */
> -	.number			= 1,
> -	.nrprocs		= ARRAY_SIZE(nfs4_cb_procedures),
> -	.procs			= nfs4_cb_procedures,
> -	.counts			= nfs4_cb_counts,
> -};
> -
> -static const struct rpc_version *nfs_cb_version[2] = {
> -	[1] = &nfs_cb_version4,
> -};
> -
> -static const struct rpc_program cb_program;
> -
> -static struct rpc_stat cb_stats = {
> -	.program		= &cb_program
> -};
> -
>  #define NFS4_CALLBACK 0x40000000
> -static const struct rpc_program cb_program = {
> -	.name			= "nfs4_cb",
> -	.number			= NFS4_CALLBACK,
> -	.nrvers			= ARRAY_SIZE(nfs_cb_version),
> -	.version		= nfs_cb_version,
> -	.stats			= &cb_stats,
> -	.pipe_dir_name		= "nfsd4_cb",
> -};
> 
>  static int max_cb_time(struct net *net)
>  {
> @@ -1152,14 +1119,15 @@ static int setup_callback_client(struct 
> nfs4_client *clp, struct nfs4_cb_conn *c
>  		.addrsize	= conn->cb_addrlen,
>  		.saddress	= (struct sockaddr *) &conn->cb_saddr,
>  		.timeout	= &timeparms,
> -		.program	= &cb_program,
>  		.version	= 1,
>  		.flags		= (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
>  		.cred		= current_cred(),
>  	};
>  	struct rpc_clnt *client;
>  	const struct cred *cred;
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> 
> +	args.program = &nn->nfsd_cb_program;
>  	if (clp->cl_minorversion == 0) {
>  		if (!clp->cl_cred.cr_principal &&
>  		    (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
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
> +	nn->nfsd_cb_version4.counts = kzalloc_objs(unsigned int,
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
> +	nn->nfsd_cb_version4.number = 1;
> +
> +	nn->nfsd_cb_version4.nrprocs = ARRAY_SIZE(nfs4_cb_procedures);
> +	nn->nfsd_cb_version4.procs = nfs4_cb_procedures;
> +	nn->nfsd_cb_versions[1] = &nn->nfsd_cb_version4;
> +
> +	memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb_stat));
> +	nn->nfsd_cb_program.name = "nfs4_cb";
> +	nn->nfsd_cb_program.number = NFS4_CALLBACK;
> +	nn->nfsd_cb_program.nrvers = ARRAY_SIZE(nn->nfsd_cb_versions);
> +	nn->nfsd_cb_program.version = &nn->nfsd_cb_versions[0];
> +	nn->nfsd_cb_program.pipe_dir_name = "nfsd4_cb";
> +	nn->nfsd_cb_program.stats = &nn->nfsd_cb_stat;
> +	nn->nfsd_cb_stat.program = &nn->nfsd_cb_program;
> +
> +	return 0;
> +}
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 14d9458aeff0..ce69bdccbb48 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2216,6 +2216,11 @@ static __net_init int nfsd_net_init(struct net *net)
>  	int retval;
>  	int i;
> 
> +#ifdef CONFIG_NFSD_V4
> +	retval = nfsd_net_cb_stats_init(nn);
> +	if (retval)
> +		return retval;
> +#endif
>  	retval = nfsd_export_init(net);
>  	if (retval)
>  		goto out_export_error;
> @@ -2256,6 +2261,9 @@ static __net_init int nfsd_net_init(struct net *net)
>  out_idmap_error:
>  	nfsd_export_shutdown(net);
>  out_export_error:
> +#ifdef CONFIG_NFSD_V4
> +	nfsd_net_cb_stats_shutdown(nn);
> +#endif
>  	return retval;
>  }
> 
> @@ -2286,6 +2294,9 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> 
>  	kfree_sensitive(nn->fh_key);
> +#ifdef CONFIG_NFSD_V4
> +	nfsd_net_cb_stats_shutdown(nn);
> +#endif
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9b05462da4cc..490193c1877d 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
>  struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
>  						struct nfsd4_get_dir_delegation *gdd,
>  						struct nfsd_file *nf);
> +int nfsd_net_cb_stats_init(struct nfsd_net *nn);
> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.47.3

There are at least five unaddressed previous review comments
here in v6. Since this is a simple clean-up that seems to have
stalled out, I'll fix those up and apply it.


-- 
Chuck Lever

