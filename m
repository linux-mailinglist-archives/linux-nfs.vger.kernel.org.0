Return-Path: <linux-nfs+bounces-20066-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEPANzfZsmlDQAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20066-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 16:18:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C827424F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B439302098A
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0631F997;
	Thu, 12 Mar 2026 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URJ7+3ZH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359640DFD6
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328243; cv=none; b=Y1YflgkjTV5UxW+9k5pVK/7pwM8bxSWBvYscRBFkEaEbjPWYq6SNS4QvXDCxfohHQfZCQguPgzGmr3OXB0MABKDaxCuzgu3rMWXsum9HX/OlwbZnM/GWKxgy0haSye2iZMZOoeMQF3/gSFGdR8PmwIQb9XAUGetXohJrVDdllKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328243; c=relaxed/simple;
	bh=REjh/6icliPqLRMoK2Hqv57KcaiXPSmwOcDtmXUxz9g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UQMQR/n+peX/nCltARam1V1ygeVmGOvGReZFTv1U4v1yHFxN8Z39dDL54esqkQBqExVqYLblCv/K1aN5wIr3z/Iz+QFnI7to/7L1eCvmx65Rh/bXMmPJs/FYp1/8X2bAXHSugtS4t8+qpNxhs0cdfezPxErqnTkGNd4FBsth6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URJ7+3ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CF9C19424;
	Thu, 12 Mar 2026 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328242;
	bh=REjh/6icliPqLRMoK2Hqv57KcaiXPSmwOcDtmXUxz9g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=URJ7+3ZHzzYMkuQDryLe/0OdkCk5rpa/K5IXlhR+lZ8GOxV4RoRwMY9rw5J+WACQZ
	 J2XoxcPZfWi+q2zURD1e/0l40yNrj1u23FUFf6YPMfRfdQXJF/wuMz6MpANx9YMS6z
	 J9H9xyiKCTAMTWDwCJ+4pVO3SYKj2PSUa2tHu6TA4rCrsLHui2UBd46WP1vBW09Omw
	 CmDwAkKnUxs1jNkWHa1Y2QtOiXIiY37aMa2a5Gg5YpiJF46qpO+7rfItpNGwoqHuMY
	 wT7ehNpkC/R4uLYZUQkeuHgR8MTmutxVByVxEyIdxYMTP4g5KCCos8Ku8nIUFsIV9G
	 IULH4S1J+EqlA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C223F40069;
	Thu, 12 Mar 2026 11:10:41 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 11:10:41 -0400
X-ME-Sender: <xms:cdeyaXvLToFUn5yUPZ5qyYFGfbFyjZ3qCgFCM_Pux_XXzFmvl9-_kg>
    <xme:cdeyaTT5T_TusmlISrvTGzoHodFVY6lMu7v3HMr8dSPc7N1ynhEoYkQZONFBZtr09
    Wgje5xliACbn5fMBieV0u18QVfGsw0gE58vRMUkRIOwTQrdI9H0Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhgedvteeiueeghfffvedvveduudeghfdvjeefgeelhedvieeglefhtdfftdfhheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrrhhgshdrnhgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvle
    ekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghsug
    hhvghnrhihmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughi
    nhhgsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hnnhgrrdhstghhuhhmrghkvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cdeyaRHx4vRHleKWxDYNuUPpR3hA-XFj-lKo8Mltn5Npd0B6tt3qkg>
    <xmx:cdeyaXBYkbGRVaakkj7tlmc71xjtIE5SBZyMdXQrmhsgAUsBTbXFAA>
    <xmx:cdeyaRUcTB-tOcq8hvfT_I-oxt003o6bEpOhmCIO3fl-cUqzWy4NtA>
    <xmx:cdeyaboyTCDuKwueNVz133QU8TQNjDHRTXTIjFh3qMioIurIhrlLnw>
    <xmx:cdeyadQQV7nFOnpjD2uRme54lZ_Qjs0CX3GVBnYsZ6AXZ0C9_1aYan6d>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 60B3A780075; Thu, 12 Mar 2026 11:10:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AY9Gdyo4Of1o
Date: Thu, 12 Mar 2026 11:10:21 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 bsdhenrymartin@gmail.com, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, "Mike Snitzer" <snitzer@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>
Message-Id: <25094279-518a-4477-bfdb-772a48c744b5@app.fastmail.com>
In-Reply-To: 
 <a57879782d2d383e2d1af292fe2b9005a43ea06c.1773263233.git.bcodding@hammerspace.com>
References: 
 <a57879782d2d383e2d1af292fe2b9005a43ea06c.1773263233.git.bcodding@hammerspace.com>
Subject: Re: [RFC PATCH] sunrpc: refactor TLS transport to remove rpc_clnt dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20066-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[hammerspace.com,gmail.com,kernel.org,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 815C827424F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, Mar 11, 2026, at 5:23 PM, Benjamin Coddington wrote:
> The TLS connection worker (xs_tcp_tls_setup_socket) currently
> requires a reference to the upper-layer rpc_clnt to populate arguments
> for rpc_create() when setting up the lower-layer transport for the
> RPC_AUTH_TLS probe. This dependency led to lifetime issues and a
> use-after-free (UAF) of the client's credentials if the task finished
> before the worker ran addressed previously in linux-nfs upstream 
> posting:
> https://lore.kernel.org/linux-nfs/20260309112041.1336519-1-bsdhenrymartin@gmail.com/
>
> However, it is architecturally cleaner to decouple the transport
> connection logic from the RPC client entirely.

It's probably worth expanding (briefly) on the architectural
cleanliness argument a bit. Why not simply bump the reference
count on the rpc_clnt to prevent the UAF? There is definitely
a bit of abuse in the current code that is removed by your
refactor.


> The TLS probe requires
> the upper-layer's RPC program and version to facilitate the probe.
>
> Refactor the TLS transport setup to:
> - Remove the clnt member from struct sock_xprt.
> - Save the RPC program number and version from the task
>   during xs_connect() into the sock_xprt structure.
> - Update xs_tcp_tls_setup_socket to use these saved parameters for
>   lower-layer client creation in dummy program definitiions.

^definitiions^definitions


> - Update TLS-related tracepoints to remove the rpc_clnt dependency.
> - Remove the rpc_clnt refcounting and assignment in xs_connect.
>
> This simplifies state management and eliminates the risk of UAF without
> requiring the transport to pin the upper-layer client.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>

More below.


> ---
>
> I'm not sure I like what came out here.  It adds a lot of boilerplate, and
> it reduces the tracepoint data (pretty necessary due to the race, however).
>
> Most of the fix is from just not setting cl_cred - it stays NULL.  Probably
> the other values we get from the upper rpc_clnt are still hanging around.

Can the patch description provide a rationale for why using a
NULL cred is safe?


> We could reduce the dummy definition boilerplate by passing the rpc_program
> pointer, but then there's a potential null-dref if the calling module gets
> unloaded.
>
> Can RCU the upper rpc_clnt?  Any other ideas?
>
> This is lightly tested by hand..
>
> Ben
>
> ---
>
>  include/linux/sunrpc/xprtsock.h |  3 +-
>  include/trace/events/sunrpc.h   | 16 +++------
>  net/sunrpc/xprtsock.c           | 59 +++++++++++++++++++++++++++------
>  3 files changed, 55 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
> index 700a1e6c047c..7cafc3057bfa 100644
> --- a/include/linux/sunrpc/xprtsock.h
> +++ b/include/linux/sunrpc/xprtsock.h
> @@ -61,7 +61,8 @@ struct sock_xprt {
>  	struct sockaddr_storage	srcaddr;
>  	unsigned short		srcport;
>  	int			xprt_err;
> -	struct rpc_clnt		*clnt;
> +	u32			connect_prog;
> +	u32			connect_vers;
> 
>  	/*
>  	 * UDP socket buffer size parameters
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 750ecce56930..8088a8ad83d4 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1528,28 +1528,23 @@ TRACE_EVENT(rpcb_unregister,
> 
>  DECLARE_EVENT_CLASS(rpc_tls_class,
>  	TP_PROTO(
> -		const struct rpc_clnt *clnt,
>  		const struct rpc_xprt *xprt
>  	),
> 
> -	TP_ARGS(clnt, xprt),
> +	TP_ARGS(xprt),
> 
>  	TP_STRUCT__entry(
>  		__field(unsigned long, requested_policy)
> -		__field(u32, version)
>  		__string(servername, xprt->servername)
> -		__string(progname, clnt->cl_program->name)
>  	),
> 
>  	TP_fast_assign(
> -		__entry->requested_policy = clnt->cl_xprtsec.policy;
> -		__entry->version = clnt->cl_vers;
> +		__entry->requested_policy = xprt->xprtsec.policy;
>  		__assign_str(servername);
> -		__assign_str(progname);
>  	),
> 
> -	TP_printk("server=%s %sv%u requested_policy=%s",
> -		__get_str(servername), __get_str(progname), __entry->version,
> +	TP_printk("server=%s requested_policy=%s",
> +		__get_str(servername),
>  		rpc_show_xprtsec_policy(__entry->requested_policy)
>  	)
>  );
> @@ -1557,10 +1552,9 @@ DECLARE_EVENT_CLASS(rpc_tls_class,
>  #define DEFINE_RPC_TLS_EVENT(name) \
>  	DEFINE_EVENT(rpc_tls_class, rpc_tls_##name, \
>  			TP_PROTO( \
> -				const struct rpc_clnt *clnt, \
>  				const struct rpc_xprt *xprt \
>  			), \
> -			TP_ARGS(clnt, xprt))
> +			TP_ARGS(xprt))
> 
>  DEFINE_RPC_TLS_EVENT(unavailable);
>  DEFINE_RPC_TLS_EVENT(not_started);

The requested_policy field that is retained is irrelevant to
the RPC_AUTH_TLS probe (though it matters later during
xs_tls_handshake_sync). But the program number and version that
/are/ dropped are what actually go on the wire in the AUTH_TLS
NULL call, so if the probe fails, the administrator wants to
know which program/version pair was rejected, not whether the
handshake that never happened would have been tls or mtls.

Note that this information is recoverable via container_of(xprt,
struct sock_xprt, xprt)->connect_prog/connect_vers without
needing rpc_clnt.


> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 2e1fe6013361..5f3103e9a8f2 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -61,6 +61,45 @@
>  #include "socklib.h"
>  #include "sunrpc.h"
> 
> +/* Helper macro to define repetitive rpc_version structures */
> +#define RPC_VERSION_DEFINE(prog, v_num)                 \
> +static const struct rpc_version rpc_##prog##_version##v_num = { \
> +    .number     = v_num,                                \
> +    .nrprocs    = ARRAY_SIZE(rpc_##prog##_procs),       \
> +    .procs      = rpc_##prog##_procs,                   \
> +    .counts     = rpc_##prog##_counts,                  \
> +}
> +
> +static struct rpc_stat rpc_tls_dummy_stats;
> +
> +static const struct rpc_procinfo rpc_tls_dummy_procs[] = {
> +    [0] = {
> +        .p_encode   = NULL,
> +        .p_decode   = NULL,
> +    },
> +};
> +
> +static unsigned int 
> rpc_tls_dummy_counts[ARRAY_SIZE(rpc_tls_dummy_procs)];
> +
> +/* Generate the structures for versions 2, 3, and 4 */
> +RPC_VERSION_DEFINE(tls_dummy, 2);
> +RPC_VERSION_DEFINE(tls_dummy, 3);
> +RPC_VERSION_DEFINE(tls_dummy, 4);
> +
> +static const struct rpc_version *rpc_tls_dummy_versions[5] = {
> +    [2] = &rpc_tls_dummy_version2,
> +    [3] = &rpc_tls_dummy_version3,
> +    [4] = &rpc_tls_dummy_version4,
> +};

This is a layering violation.

Today's Linux NFS client stack implements TLS only for the NFS
protocol, which has support for only versions 2, 3, and 4. But
what if we want to implement TLS for NLM (or any other RPC
protocol) -- NLM has v1, v3, and v4.

A simpler design: use a single dummy version at index 0 with
args->version = 0 always, relying solely on args->prognumber
for the wire program number. The TLS probe never consults
cl_vers -- it uses a fixed proc via msg.rpc_proc.

(Ultimately that is still a hack, but you get the idea).

> +
> +static const struct rpc_program rpc_tls_dummy_program = {
> +    .name       = "tls_probe",
> +    .number     = 0,
> +    .nrvers     = ARRAY_SIZE(rpc_tls_dummy_versions),
> +    .version    = rpc_tls_dummy_versions,
> +    .stats      = &rpc_tls_dummy_stats,
> +};
> +

Nit: All of the new static structures and the macro use 4-space
indentation rather than tabs.  Other rpc_program definitions
in the tree (rpcb_program in rpcb_clnt.c, gssp_program in
gss_rpc_upcall.c) use tabs per the kernel coding style.


>  static void xs_close(struct rpc_xprt *xprt);
>  static void xs_reset_srcport(struct sock_xprt *transport);
>  static void xs_set_srcport(struct sock_xprt *transport, struct socket 
> *sock);
> @@ -2687,24 +2726,21 @@ static void xs_tcp_tls_setup_socket(struct 
> work_struct *work)
>  {
>  	struct sock_xprt *upper_transport =
>  		container_of(work, struct sock_xprt, connect_worker.work);
> -	struct rpc_clnt *upper_clnt = upper_transport->clnt;
>  	struct rpc_xprt *upper_xprt = &upper_transport->xprt;
>  	struct rpc_create_args args = {
>  		.net		= upper_xprt->xprt_net,
>  		.protocol	= upper_xprt->prot,
>  		.address	= (struct sockaddr *)&upper_xprt->addr,
>  		.addrsize	= upper_xprt->addrlen,
> -		.timeout	= upper_clnt->cl_timeout,
> +		.timeout	= upper_xprt->timeout,

The timeout source changed here from the upper-layer client's
configured timeout to the transport's default timeout.  These
can differ: upper_clnt->cl_timeout points to a copy of the
NFS-configured timeout (set via nfs_init_timeout_values()), while
upper_xprt->timeout points to xs_tcp_default_timeout.

For default NFS TCP mounts, nfs_init_timeout_values() produces
to_maxval = 180 * HZ and to_increment = 60 * HZ, whereas
xs_tcp_default_timeout has to_maxval = 60 * HZ and
to_increment = 0.

Was this change intentional?  The commit message does not mention
it, and it alters the retry behavior for the TLS probe on mounts
with custom timeout settings.


>  		.servername	= upper_xprt->servername,
> -		.program	= upper_clnt->cl_program,
> -		.prognumber	= upper_clnt->cl_prog,
> -		.version	= upper_clnt->cl_vers,
> +		.prognumber = upper_transport->connect_prog,

Whitespace damage.


> +		.version	= upper_transport->connect_vers,
> +		.program	= &rpc_tls_dummy_program,
>  		.authflavor	= RPC_AUTH_TLS,
> -		.cred		= upper_clnt->cl_cred,
>  		.xprtsec	= {
>  			.policy		= RPC_XPRTSEC_NONE,
>  		},
> -		.stats		= upper_clnt->cl_stats,
>  	};
>  	unsigned int pflags = current->flags;
>  	struct rpc_clnt *lower_clnt;
> @@ -2719,7 +2755,7 @@ static void xs_tcp_tls_setup_socket(struct 
> work_struct *work)
>  	/* This implicitly sends an RPC_AUTH_TLS probe */
>  	lower_clnt = rpc_create(&args);
>  	if (IS_ERR(lower_clnt)) {
> -		trace_rpc_tls_unavailable(upper_clnt, upper_xprt);
> +		trace_rpc_tls_unavailable(upper_xprt);
>  		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
>  		xprt_clear_connecting(upper_xprt);
>  		xprt_wake_pending_tasks(upper_xprt, PTR_ERR(lower_clnt));
> @@ -2739,7 +2775,7 @@ static void xs_tcp_tls_setup_socket(struct 
> work_struct *work)
> 
>  	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
>  	if (status) {
> -		trace_rpc_tls_not_started(upper_clnt, upper_xprt);
> +		trace_rpc_tls_not_started(upper_xprt);
>  		goto out_close;
>  	}
> 
> @@ -2757,7 +2793,6 @@ static void xs_tcp_tls_setup_socket(struct 
> work_struct *work)
> 
>  out_unlock:
>  	current_restore_flags(pflags, PF_MEMALLOC);
> -	upper_transport->clnt = NULL;
>  	xprt_unlock_connect(upper_xprt, upper_transport);
>  	return;
> 
> @@ -2805,7 +2840,9 @@ static void xs_connect(struct rpc_xprt *xprt, 
> struct rpc_task *task)
>  	} else
>  		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
> 
> -	transport->clnt = task->tk_client;
> +	transport->connect_prog = task->tk_client->cl_prog;
> +	transport->connect_vers = task->tk_client->cl_vers;
> +
>  	queue_delayed_work(xprtiod_workqueue,
>  			&transport->connect_worker,
>  			delay);
> -- 
> 2.53.0

The proposed refactoring seems like a sensible direction.

The UAF potential is eliminated structurally, and some of the
transport-to-client coupling (and layering violation) is removed.


-- 
Chuck Lever

