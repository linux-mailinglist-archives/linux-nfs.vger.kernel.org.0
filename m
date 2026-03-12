Return-Path: <linux-nfs+bounces-20062-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ci3J5G9smmvPAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20062-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:20:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBA2726CA
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B37B3011F33
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE553C6617;
	Thu, 12 Mar 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8JmDsT5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6A3C554B
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321613; cv=none; b=FNaH35PADyaVCSXnZ51m4qhqPkt98nHzNB96+dlIzV9Y+43VBEhYCn+X4cp1LUoFLZ5o9X/XMfflXwm0NLk2TGO/xO1ChbGQWrfEBeJ4azIZpZidlAyF+1yFHxn6WPtaCyGxS2/k/9mvr6EUlYU+XzguNe791LpL2jRs9Bcl+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321613; c=relaxed/simple;
	bh=u4iqMoQGwOqxKnOrGqci8L3jVaTwfHQlcaKI9FiMdwU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RBsy82xgPnIEMavWUfqnKZAwqogJzPy9yq/a3LH+CKrB3l3kO3J9XMmIjYPtypzjQaihSq6/IwLVeRkKNTubxikL3+tgVlqqWS7uRDmR4kWNn0PSK9S/f58oXJlljXR1tZsXdqPHG4ASOckedM9ilFeWWiDq646c4Vvpz7PInsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8JmDsT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C476C4AF09;
	Thu, 12 Mar 2026 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773321612;
	bh=u4iqMoQGwOqxKnOrGqci8L3jVaTwfHQlcaKI9FiMdwU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=A8JmDsT5i+VOlvvKYgkrsW6UEnWoZUgq4lqGr/DJy9m72XnxRP6uGUShmcajY2Esr
	 JsC6Vl78TPgBR+HhecXGJRAxCdWug7umOtUvqQg1SzVjdQodthCXyGxm2BQRJEnxDN
	 1r0Qi4c7R6k4VXctHQdHSXe7gQt2ymXgAskTb9ifisLbsF2U4+N9JZq/gBSCaaBR6i
	 evacDfhjoc8c48n+Wz+oCznz9gFUG814eVmkoN3I6mWo6W2TVjy0GgEQE/bYfzh7Hb
	 WsgZw3n9q3NgnLusIrqoQJjO2s+Oqf1b8aq5tHU9qzobxApYJjbsKVzv+hEV8B9Rbe
	 V4tDjvtCfIs+w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6498AF4006A;
	Thu, 12 Mar 2026 09:20:11 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 12 Mar 2026 09:20:11 -0400
X-ME-Sender: <xms:i72yaQIWt3nNh7ii4Q-HsoSJhthcB3hS_ycBRzAsfPzWUAtrD-gRPA>
    <xme:i72yaa_-IDLCM-cbjl6FmMyO-XTOIPQ_6dVg-V43yfItedFRFLSqRePwS5S2nWtur
    DMN3Inmz10WZxfO9WnvSvkH1rbv3e2BLz3DZQexH0pOXs9oRJdlB58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgvrghnfigrshgtohguihhnghesghhmrghilhdrtghomhdprhgtphhtthho
    pegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoh
    eprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhn
    rdgthhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i72yaSrLdf8yjsQ4BPDIn4752fJEm_1T5o_JMESdbTVuDQ74Umlxmg>
    <xmx:i72yadMjM8gW09vE4Bwi-blaND2KNHSfNscTmBQIFoUIBPR3B-jzxQ>
    <xmx:i72yaboLIKQt7bs1iYOhQrX7PW1XN1Hieq8i_hU-WM6Pa5G80baPAQ>
    <xmx:i72yaYsbG_h1I2lTOBHugLuvNcn_vWjOQqdP0RClwgdvYkAwceXxZQ>
    <xmx:i72yaS10i0gtmCuVPAUKqwjHaRD3oyFgbL0F9n-ioD_1Ry_nwSBFkzz5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E44C780070; Thu, 12 Mar 2026 09:20:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhbZdgiYvuX7
Date: Thu, 12 Mar 2026 09:19:51 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sean Chang" <seanwascoding@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "David Laight" <david.laight.linux@gmail.com>,
 "Anna Schumaker" <anna@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
In-Reply-To: <20260303140725.86260-1-seanwascoding@gmail.com>
References: <20260303140725.86260-1-seanwascoding@gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup redundant debug
 guards
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20062-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,lunn.ch:email];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,oracle.com,kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E4BBA2726CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Mar 3, 2026, at 9:07 AM, Sean Chang wrote:
> Following David Laight's suggestion, simplify the macro definitions by
> removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
> directly.
>
> Verification with .lst files under -O2 confirms that the compiler
> successfully performs "dead code elimination". Even when variables
> (like char buf[] in nfsfh.c) or static helper functions (like
> nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
> completely optimized out (no stack allocation, no symbol references in
> the final executable) as they are only referenced within no_printk().
>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
> v2:
>  - Follow reversed xmas tree order for variables in svc_rdma_transport.c
>    as requested by Andy Shevchenko.
>  - Polish commit message: use dprintk() and remove redundant file list.
>  - Correct the technical claim about dprintk() type checking.
>
>  fs/lockd/svclock.c                       |  7 -------
>  fs/nfsd/nfsfh.c                          |  8 +++-----
>  include/linux/sunrpc/debug.h             |  8 ++------
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 +++++++++++-------------
>  4 files changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index ee23f5802af1..9b978a087b3c 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -47,7 +47,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
>  static LIST_HEAD(nlm_blocked);
>  static DEFINE_SPINLOCK(nlm_blocked_lock);
> 
> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
>  {
>  	/*
> @@ -74,12 +73,6 @@ static const char *nlmdbg_cookie2a(const struct 
> nlm_cookie *cookie)
> 
>  	return buf;
>  }
> -#else
> -static inline const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
> -{
> -	return "???";
> -}
> -#endif
> 
>  /*
>   * Insert a blocked lock into the global list
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 68b629fbaaeb..91514326d1b4 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -105,12 +105,10 @@ static __be32 nfsd_setuser_and_check_port(struct 
> svc_rqst *rqstp,
>  {
>  	/* Check if the request originated from a secure port. */
>  	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
> -		if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
> -			char buf[RPC_MAX_ADDRBUFLEN];
> +		char buf[RPC_MAX_ADDRBUFLEN];
> 
> -			dprintk("nfsd: request from insecure port %s!\n",
> -			        svc_print_addr(rqstp, buf, sizeof(buf)));
> -		}
> +		dprintk("nfsd: request from insecure port %s!\n",
> +			svc_print_addr(rqstp, buf, sizeof(buf)));
>  		return nfserr_perm;
>  	}
> 
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index ab61bed2f7af..f6f2a106eeaf 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -38,8 +38,6 @@ extern unsigned int		nlm_debug;
>  do {									\
>  	ifdebug(fac)							\
>  		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
> -	else								\
> -		no_printk(fmt, ##__VA_ARGS__);				\
>  } while (0)
> 
>  # define dfprintk_rcu(fac, fmt, ...)					\
> @@ -48,15 +46,13 @@ do {									\
>  		rcu_read_lock();					\
>  		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>  		rcu_read_unlock();					\
> -	} else {							\
> -		no_printk(fmt, ##__VA_ARGS__);				\
>  	}								\
>  } while (0)
> 
>  #else
>  # define ifdebug(fac)		if (0)
> -# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> -# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk(fac, ...)		no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...)	no_printk(__VA_ARGS__)
>  #endif
> 
>  /*
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c 
> b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index f2d72181a6fe..0759444bda50 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -413,6 +413,7 @@ static struct svc_xprt *svc_rdma_accept(struct 
> svc_xprt *xprt)
>  	struct rpcrdma_connect_private pmsg;
>  	struct ib_qp_init_attr qp_attr;
>  	struct ib_device *dev;
> +	struct sockaddr *sap;
>  	int ret = 0;
> 
>  	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
> @@ -559,20 +560,16 @@ static struct svc_xprt *svc_rdma_accept(struct 
> svc_xprt *xprt)
>  		goto errout;
>  	}
> 
> -	if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
> -		struct sockaddr *sap;
> -
> -		dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
> -		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> -		dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
> -		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> -		dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
> -		dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
> -		dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
> -		dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
> -		dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
> -		dprintk("    ord             : %d\n", conn_param.initiator_depth);
> -	}
> +	dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
> +	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> +	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
> +	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> +	dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
> +	dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
> +	dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
> +	dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
> +	dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
> +	dprintk("    ord             : %d\n", conn_param.initiator_depth);
> 
>  	return &newxprt->sc_xprt;
> 
> -- 
> 2.34.1

Has a subsystem tree been chosen through which to merge these two patches?


-- 
Chuck Lever

