Return-Path: <linux-nfs+bounces-19083-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBWyBWo4mmlDZwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19083-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:57:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51F16E2C8
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F01D301AA99
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267A013959D;
	Sat, 21 Feb 2026 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCZb9zpH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E777F39
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771714660; cv=none; b=Fs8//eNCgrC9Cq66W/zXqvmiEmDaLqfHMNgetUvr4J3Fz4wmuUxsNUSTBdCgNT6A2a/WtArV3YHfKcwObYmtN7Zq2OK3s0lAEDnf7ioBT1x7RsHf1hggeY4Vd8UKxKg8SGykx0tsZ7iWq2BYblDDLRi/ITMRqcoVS84oE82zKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771714660; c=relaxed/simple;
	bh=ZHFVUCEXcyfMaYhMtvwalfC5gW/yiPtZlV3Y8k7sNWA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ehRDZm+fXADrbLDMFQ9wyC1YuOuMcm6ITMQtqlc4W2gDHtp8oBlIf6VaeZfGwx2zWT/xspgevq9dmopJWIndq3GAaVjBHp5DUxGVXEv7yMo7QLSSs3sSXIRDn3sEHLNFq+lh01ld2Eg2l+2XZhAIBuF76ksZ/DSeQ7TRensXpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCZb9zpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5A0C19422;
	Sat, 21 Feb 2026 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771714659;
	bh=ZHFVUCEXcyfMaYhMtvwalfC5gW/yiPtZlV3Y8k7sNWA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oCZb9zpHwzel3i9so9IWX9wxx/jv3URb+lBRc/FU9wILNvqSaJtjuPp/v8dPwwrhT
	 0NeYST+V7anzvBQI6fLsPOE3C80h/0o9dGmVSR2HGNr5CaaZaQBoNNSkzJZ/yeAgoD
	 6nPnDnmtlPn7o/ou9Sm9VhFJLHg3t2gVrCk20c0kMCs8e+1RwPTTh4j+UVeLr8Ld0H
	 7dIvjIr/ANAQuV2x6ig0Si0ctOXXN3z7c5uupGEjr9+AewSm1QqqoV4Ww/iyTyJVgG
	 O8YI7XCVu3R4h+UjNKC1gy7HublfIUqiityNSu39H683DE1vzhiNM1JCvR4f9BRydn
	 KGYWlq6Oagf3A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51965F4006C;
	Sat, 21 Feb 2026 17:57:38 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 21 Feb 2026 17:57:38 -0500
X-ME-Sender: <xms:Yjiaab7X0IOSXwSvjvRjv-tyXCaPGgA5_EBA2oYGzksEKI2FBO97Pw>
    <xme:Yjiaabtjd0TzaGM42y9cnQyTnjck12oQrUz0wkWViHkIlUTLsnMbkadvaua49saOf
    e0mm0rHNU_hbl6JuKKbFbKDUqaLxMAlnogxzTQwT2vuzUS-66AsL3UU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedvieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:YjiaaUNSyxRuiCo7Ev-WY4BfYTswu4_Qr6SswnpStbDJNwpDQt0_tw>
    <xmx:YjiaaU9WJ-vybux6_N8eqs_qjClBoIlXUh5cRtCTsUbOG2yRfrEZ2Q>
    <xmx:YjiaaR5IXbIufnRAlSGXoPjjgiibUwPUXqLra2hskh6KROwC6vgVlw>
    <xmx:Yjiaaa6m4iAb7TqONsqeZYlb-QXbBtV3lETMpV-iydmhBYckWSvsdQ>
    <xmx:YjiaaaqcbLEwUE8fRs2Xl9QuuuFXpXbRmxfvAeCGysV7eQJfetTE-dR9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29A81780082; Sat, 21 Feb 2026 17:57:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdIdnSnN9OJZ
Date: Sat, 21 Feb 2026 17:57:17 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <8d11898b-9889-43b5-bb96-445870367949@app.fastmail.com>
In-Reply-To: <20260221215733.3643669-1-dai.ngo@oracle.com>
References: <20260221215733.3643669-1-dai.ngo@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: Expose callback statistics in /proc/net/rpc/nfsd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19083-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A51F16E2C8
X-Rspamd-Action: no action

Hello Dai!

On Sat, Feb 21, 2026, at 4:57 PM, Dai Ngo wrote:
> Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
>
> . Add system-wide counters for each callback operation.
> . Add per-client callback operation statistics, similar to mountstats(8)
>   raw format.

The commit message needs to justify why you are modifying a legacy
/proc interface. I assume it is because you want these metrics to
appear in an existing NFS administrative tool like nfsstat ?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 33 ++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsd.h         |  1 +
>  fs/nfsd/stats.c        |  2 ++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index e00b2aea8da2..5d6c91b2da24 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -36,6 +36,7 @@
>  #include <linux/sunrpc/xprt.h>
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/slab.h>
> +#include <linux/sunrpc/metrics.h>
>  #include "nfsd.h"
>  #include "state.h"
>  #include "netns.h"
> @@ -1016,7 +1017,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
>  	.p_decode  = nfs4_xdr_dec_##restype,				\
>  	.p_arglen  = NFS4_enc_##argtype##_sz,				\
>  	.p_replen  = NFS4_dec_##restype##_sz,				\
> -	.p_statidx = NFSPROC4_CB_##call,				\
> +	.p_statidx = NFSPROC4_CLNT_##proc,				\
>  	.p_name    = #proc,						\
>  }
> 
> @@ -1786,3 +1787,33 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>  		nfsd41_cb_inflight_end(clp);
>  	return queued;
>  }
> +
> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq)
> +{
> +	const struct rpc_procinfo *pinfo;
> +	const struct rpc_version *ver;
> +	struct nfs4_client *clp;
> +	int ix;
> +
> +	/* display system-wide status, count per op */
> +	ver = cb_program.version[1];
> +	for (ix = 0; ix < ver->nrprocs; ix++) {
> +		pinfo = &ver->procs[ix];
> +		if (pinfo->p_name)
> +			seq_printf(seq, "%s: %d\n",
> +				pinfo->p_name, ver->counts[pinfo->p_statidx]);
> +	}
> +
> +	/* display per-client status, similar to mountstats(8) in raw format */
> +	spin_lock(&nn->client_lock);
> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++) {
> +		list_for_each_entry(clp, &nn->conf_id_hashtbl[ix], cl_idhash) {
> +			if (!clp->cl_cb_client)
> +				continue;
> +			seq_printf(seq, "\nClient[%pISpc]:\n",
> +					(struct sockaddr *)&clp->cl_addr);
> +			rpc_clnt_show_stats(seq, clp->cl_cb_client);
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 7c009f07c90b..cec0c6167ddb 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -591,6 +591,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>  #endif
> 
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq);
> 
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index f7eaf95e20fc..cc601719ef26 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -66,6 +66,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>  		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
> 
>  	seq_putc(seq, '\n');
> +
> +	nfsd4_show_cb_stats(nn, seq);
>  #endif
> 
>  	return 0;
> -- 
> 2.47.3

-- 
Chuck Lever

