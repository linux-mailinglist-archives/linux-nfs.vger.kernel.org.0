Return-Path: <linux-nfs+bounces-22241-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PpWLO0JnIGpK2wAAu9opvQ
	(envelope-from <linux-nfs+bounces-22241-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:41:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2A63A39D
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f4Pa+947;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22241-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22241-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B28313040F4C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4163E1696;
	Wed,  3 Jun 2026 17:34:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420A3D1CCA
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 17:34:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508063; cv=none; b=RfMgPtb5NOSl6Fw015gilxEGa5v/HgAI/Xi/3ZfupQI/AgvKZpKTEGtHVEksoBkRzNLubaiQDFuijD6ke4QH6GPTzZH6sMag/YuqpqW9vIZyPWA6thqrGEiYf5wr71mxP/qV48c18L99ZHyfodOGPTZt/Fa4x1U9gG+rNaPdC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508063; c=relaxed/simple;
	bh=rieoedKXbJtwRotYIOkycmqRynUOg0NqnWYmiFsin14=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Lddr2Dn2chXcIUwQ7vE3I+mUU3Fx/GP9rIM3vUUxfgtoknFvzJRUwLNZ973Kvk/Z4cgkOCMhMQdltQFCWMKay56+KJILbg3eyIQGutGPlMYu8bwqDg3Iobd4KIuC8MoY3qBXcLST3jqtyLSBwx+7jqynBdWNj2c0SCmkQ0mtVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4Pa+947; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CBC1F00898;
	Wed,  3 Jun 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780508060;
	bh=GWtIh2slYfAF2sjsoP6rqmh41wXrJffMbv6rcewaRRE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=f4Pa+947yG7a8LDgyB06hgyqaIUPJ6ZFc89S8Xk7MTgBQKtsPqdw4XNXdWujy5oFz
	 RL1Z6nxdWLO/NprWKXtk/EOGNILrLD1BbgyDyxBCng/50zFs32ykUPotiitOHPbBEv
	 gL0Ssqd8iL1kJsPodNeR3D78QOGOMyVg2JNwuPdXPf1h2wPTZiFmu+N0kgcSCXo07l
	 omajM2dyOCiG2F6TRl7A9vU26LJOLylgtpY4E8WnCIHMB/4WXxMa4BEL8kmmcc7fFP
	 Rlv+ydmHmXSNUOMT8OlvwXXsxORDCAp4+N2VU1+tW3VPWgj5+gdlBCgi196lupzHla
	 5yGJ2v9ntB7Lg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B191F40073;
	Wed,  3 Jun 2026 13:34:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 13:34:19 -0400
X-ME-Sender: <xms:mmUgatQGPYC3lrJBJpyrH7m3Ioqmp8Ji8_Nvw8DAbdpPuWerGf5XZA>
    <xme:mmUgahk0HW0EVv5PPHEE7MHOEVuwlG6cflnYINsTFlko2jZRequ9dmXj5pv-CddAx
    OOJye52BDt_4DdufL-AkRQjvwvFwkX9r_Jn4J0TOMHMR6hgckhyIVs>
X-ME-Proxy-Cause: dmFkZTEuRxtnLhknrILQhX/P8UCfVI6r1YouQ89ZsKnaUdi33AjkWRP9tVGcTf1f/HLHtG
    LLhAB0/SwwnyoJ8MOgfLt91uKU8sfxu9bGsiMIPhtrsxrF47B09/N6PasPvr66AS+msOHI
    HhBMJ2LppRMtp5GusBj42f4TBG4myPvNQ3urJMoxd9SApp5019whPeON9/857ko9T211qO
    vVbpwMPGwukAr1LDvC6yOqGNh0nhkB5TlfcHbcXiXk5CBMkyU0OUgFZvNTP9uEEpm3lsfe
    LrSKBgLkwzCV6GTml21yd8mttL6tbUBVEDRu/YNYtcbFtQbAC1IfnJzcDfB9APAkL8d0cv
    XE4jLcMwbbrIsZPO5t+ZG5e64XUnHUJWZR0GlN691lTB3HtFp9F2D/SZjszACRJTsDQ77K
    iiIGarCOc9NUwzyqhixzJH6XWL2Rb64Bc15p2QWV7pWW0D87WtwZtPPnbYMS/b/u9lt6vw
    W4nvQvoufocLIR/wQVnMOD9Jv+IhZZw2OeVebYxsjXzyh2TpcOYFhrgbqTAaL+rRwZAEF1
    3nQDxGAkiVFZkSvha73t5qG63xbxqwaDamIGgiq6IsylZWA3h6/N2c2YPoIOg6/chLSZpm
    WCv44mwTImQJr+GMsgMxqwDi7RYAlNAHy5qSqtn67GDPcPDdw3kKm4PQk09w
X-ME-Proxy: <xmx:m2Ugau3cgZZTFpe54LKiy7VGakZXCFjj5B-gh6Pk1hdkxIwZ7G5w4A>
    <xmx:m2UgaqdKqsOt9o4J9gdnPeMyhL0LIoFRP6Mu2ObtEPaEf5q5wtOJqg>
    <xmx:m2UgavYQh8LPqWwK99Q59Q2_bpdssfDbD5PRtNEbDBEY1jwJPPwW5w>
    <xmx:m2UgavW6v1-LSVc_Qyvg7bJMoP2jSJYtNJrh546L68j7ztg1fZlZWA>
    <xmx:m2UgaiS-I7UgTkLMZTZlfBFfB-ySyegTF_Z3l3HpepolVAzm37eVH4s0>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 875C0780070; Wed,  3 Jun 2026 13:34:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1VAgNH1MNFs
Date: Wed, 03 Jun 2026 10:33:58 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Chris Mason" <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>
Message-Id: <efb19b50-6535-480d-9630-37f53a8de3cd@app.fastmail.com>
In-Reply-To: <20260602-nfsd-testing-v2-8-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
 <20260602-nfsd-testing-v2-8-e4ea62e3cd5c@kernel.org>
Subject: Re: [PATCH v2 8/9] nfsd: hold net namespace reference for delayed-dispose
 nfsd_files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22241-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECB2A63A39D



On Tue, Jun 2, 2026, at 9:23 AM, Jeff Layton wrote:
> Take a net-namespace reference in nfsd_file_dispose_list_delayed()
> (get_net) and release it in nfsd_file_free() (put_net), so that
> nf_net is always valid for files that the GC or shrinker has isolated
> from the hash table and LRU -- which __nfsd_file_cache_purge() cannot
> see.
>
> Without this, nf_net can dangle for in-flight files whose net namespace
> is torn down concurrently, causing a use-after-free when
> nfsd_file_dispose_list_delayed() calls net_generic(nf->nf_net, ...).
>
> Only files entering the delayed-dispose path need the net reference;
> files freed synchronously (non-GC stateful opens, purge, direct put)
> are always freed while the net namespace is still alive, so they skip
> get_net()/put_net() entirely.  A new NFSD_FILE_NET_HELD flag tracks
> whether a given nfsd_file holds a net reference.
>
> Because nfsd_file_free() may now call put_net(nf->nf_net), the old
> nfsd_file_put_local() pattern of returning nf->nf_net after
> nfsd_file_put() is unsafe -- put_net() could theoretically drop the
> last net namespace reference, leaving the returned pointer stale.
> Fix this by moving the nfsd_net_put() call into nfsd_file_put_local()
> itself, before the nfsd_file_put() that may trigger nfsd_file_free().
> The function now returns void and the caller no longer needs to handle
> the net reference.
>
> Fixes: 43fd953fa7e2 ("nfsd: simplify the delayed disposal list code")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c        | 34 ++++++++++++++++++++++++++--------
>  fs/nfsd/filecache.h        |  3 ++-
>  fs/nfsd/localio.c          |  4 ++--
>  include/linux/nfslocalio.h |  9 ++-------
>  4 files changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 03f01a0beced..957fe57be063 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -295,6 +295,9 @@ nfsd_file_free(struct nfsd_file *nf)
>  	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>  		return;
> 
> +	if (test_bit(NFSD_FILE_NET_HELD, &nf->nf_flags))
> +		put_net(nf->nf_net);
> +
>  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>  }
> 
> @@ -375,24 +378,28 @@ nfsd_file_put(struct nfsd_file *nf)
>  }
> 
>  /**
> - * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
> + * nfsd_file_put_local - put nfsd_file reference and release nfsd_net ref
>   * @pnf: nfsd_file of which to put the reference
>   *
> - * First save the associated net to return to caller, then put
> - * the reference of the nfsd_file.
> + * Drops both the nfsd_file reference and the associated nfsd_net
> + * reference.  The nfsd_net ref is released before the file ref so
> + * that put_net() inside nfsd_file_free() cannot drop the last net
> + * namespace reference while the caller still needs it.
>   */
> -struct net *
> +void
>  nfsd_file_put_local(struct nfsd_file __rcu **pnf)
>  {
>  	struct nfsd_file *nf;
> -	struct net *net = NULL;
> 
>  	nf = unrcu_pointer(xchg(pnf, NULL));
>  	if (nf) {
> -		net = nf->nf_net;
> +		struct net *net = nf->nf_net;
> +
> +		rcu_read_lock();
> +		nfsd_net_put(net);
> +		rcu_read_unlock();
>  		nfsd_file_put(nf);
>  	}
> -	return net;
>  }
> 
>  /**
> @@ -433,9 +440,20 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
>  	while (!list_empty(dispose)) {
>  		struct nfsd_file *nf = list_first_entry(dispose,
>  						struct nfsd_file, nf_gc);
> -		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
> +		struct nfsd_net *nn;
>  		struct svc_serv *serv;
> 
> +		/*
> +		 * Pin the net namespace so nf_net stays valid while the
> +		 * file sits on the per-net dispose list.  Callers (the GC
> +		 * worker, shrinker, and fsnotify callbacks) always run
> +		 * before nfsd_net_exit(), so nf_net is still live here.
> +		 * The matching put_net() is in nfsd_file_free().
> +		 */
> +		get_net(nf->nf_net);
> +		set_bit(NFSD_FILE_NET_HELD, &nf->nf_flags);
> +
> +		nn = net_generic(nf->nf_net, nfsd_net_id);
>  		spin_lock(&nn->fcache_dispose_lock);
>  		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
>  		spin_unlock(&nn->fcache_dispose_lock);
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 683b6437cacc..7ae3c0ea0a2a 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -45,6 +45,7 @@ struct nfsd_file {
>  #define NFSD_FILE_REFERENCED	(2)
>  #define NFSD_FILE_GC		(3)
>  #define NFSD_FILE_RECENT	(4)
> +#define NFSD_FILE_NET_HELD	(5)
>  	unsigned long		nf_flags;
>  	refcount_t		nf_ref;
>  	unsigned char		nf_may;
> @@ -66,7 +67,7 @@ void nfsd_file_cache_shutdown(void);
>  int nfsd_file_cache_start_net(struct net *net);
>  void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
> -struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
> +void nfsd_file_put_local(struct nfsd_file __rcu **nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index c3eb0557b3e1..e3295bae75a4 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -40,8 +40,8 @@
>   * avoid all the NFS overhead with reads, writes and commits.
>   *
>   * On successful return, returned nfsd_file will have its nf_net member
> - * set. Caller (NFS client) is responsible for calling nfsd_net_put and
> - * nfsd_file_put (via nfs_to_nfsd_file_put_local).
> + * set. Caller (NFS client) is responsible for calling nfsd_file_put
> + * (via nfs_to_nfsd_file_put_local), which also releases the nfsd_net 
> ref.
>   */
>  static struct nfsd_file *
>  nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 3d91043254e6..7267a69092d1 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -62,7 +62,7 @@ struct nfsd_localio_operations {
>  						const struct nfs_fh *,
>  						struct nfsd_file __rcu **pnf,
>  						const fmode_t);
> -	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
> +	void (*nfsd_file_put_local)(struct nfsd_file __rcu **);
>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
>  	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
>  					u32 *, u32 *, u32 *);
> @@ -96,12 +96,7 @@ static inline void nfs_to_nfsd_file_put_local(struct 
> nfsd_file __rcu **localio)
>  	 * must prevent nfsd shutdown from completing as nfs_close_local_fh()
>  	 * does by blocking the nfs_uuid from being finally put.
>  	 */
> -	struct net *net;
> -
> -	net = nfs_to->nfsd_file_put_local(localio);
> -
> -	if (net)
> -		nfs_to_nfsd_net_put(net);
> +	nfs_to->nfsd_file_put_local(localio);
>  }
> 
>  #else   /* CONFIG_NFS_LOCALIO */
>
> -- 
> 2.54.0

It seems that all of the LLM reviewers have difficulty with this patch.
This is a consolidated review of the issue from Claude and Codex:

> The reordering in nfsd_file_put_local() -- nfsd_net_put() before
> nfsd_file_put() -- introduces a shutdown race.
>
> The nfsd_net_ref percpu refcount is taken only by LOCALIO
> (nfsd_open_local_fh() and nfs_open_local_fh()). The drain wait in
> nfsd_shutdown_net() (wait_for_completion(&nn->nfsd_net_free_done))
> is what holds off percpu_ref_exit() and nfsd_shutdown_generic() --
> and through the latter, nfsd_file_cache_shutdown(), which runs
> rcu_barrier() and then destroys nfsd_file_slab, nfsd_file_mark_slab,
> the fsnotify groups, and the rhltable.
>
> Per-I/O references are not covered by the nfs_uuid handshake. Each
> pgio call takes its own nfsd_file ref plus a paired nfsd_net ref
> (fs/nfs/pagelist.c, nfs_local_open_fh), stores it in iocb->localio,
> and releases it at completion through nfsd_file_put_local(). An
> iocb is not on nfs_uuid->files, so nfs_localio_invalidate_clients()
> does not wait for it; only the drain wait does. Meanwhile
> __nfsd_file_cache_purge() has already unhashed the nfsd_file but
> cannot free it (the iocb ref keeps refcount elevated in
> nfsd_file_cond_queue()).
>
> So with one I/O in flight when the server is stopped: the shutdown
> thread parks at the drain wait; the I/O completion thread enters
> nfsd_file_put_local() and drops the last nfsd_net ref, which runs
> complete() before nfsd_file_put() has executed. The shutdown thread
> then proceeds through nfsd_file_cache_shutdown() concurrently with
> the final nfsd_file_free(): the call_rcu() is queued after the
> rcu_barrier(), so nfsd_file_slab_free() does kmem_cache_free() into
> a destroyed cache, and nfsd_file_mark_put() runs against a destroyed
> fsnotify group. kmem_cache_destroy() also fires "objects remaining"
> because the nfsd_file is still allocated.
>
> The old ordering was the mechanism that prevented this: the caller
> held its paired nfsd_net ref across nfsd_file_put(), and percpu_ref
> guarantees the release callback runs only after every ref is
> dropped, so global teardown strictly followed the file free and the
> rcu_barrier() flushed its call_rcu().
>
> The hazard the commit message cites for the reorder cannot occur on
> this path: NFSD_FILE_NET_HELD is set only in
> nfsd_file_dispose_list_delayed(), reachable only through
> refcount_dec_if_one() in nfsd_file_lru_cb(), i.e. at refcount == 1.
> A file with an outstanding LOCALIO reference has refcount >= 2, so
> a file whose final put arrives via nfsd_file_put_local() never has
> NET_HELD set and its nfsd_file_free() never calls put_net().
>
> Suggest keeping the void API but restoring the put order:
>
>       nf = unrcu_pointer(xchg(pnf, NULL));
>       if (nf) {
>               struct net *net = nf->nf_net;
> 
>               nfsd_file_put(nf);
>               rcu_read_lock();
>               nfsd_net_put(net);
>               rcu_read_unlock();
>       }
>
> with the kdoc comment and the commit message paragraph about the
> old ordering being unsafe adjusted to match.


-- 
Chuck Lever

