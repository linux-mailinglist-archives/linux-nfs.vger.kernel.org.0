Return-Path: <linux-nfs+bounces-19807-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEnBH3iaqWm7AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19807-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 16:00:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5C2140E0
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2934E3073D84
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0437F8B6;
	Thu,  5 Mar 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIKcN9lq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D343AE1B6
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722399; cv=none; b=h6TXjR5SaKmTtrXFHLQglmaOqQkmrm3+35V5gEmTsRKJBpGx4gLBSkGhVGntmvTfnfR/EUxvgXH15yTZR1U/9TvG9ppALfeG+ZdM3XqDL4IHllK9F6aFlzLMb3fEP9VS4Ad2nQL1ZWrN+2znQxT/DvowxzTBK7SVy4fWZtLBZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722399; c=relaxed/simple;
	bh=cIbMRYeO8Ucx3MaQx8lRYPcGEjiejjuBPKecgn1mots=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J+HvaesH8CpNG1AU3eWl5m6Fp/gpy8cOU+kV6G3J4r22pGNu1K4/A4H6m4w8A3BEOsj0Tg/q/aSmUYAhd3ZbD0v52219tF6c8/vgY1tB4SYu1VjthBgMm5RW4LUGpRskkuQtGQpzo69HKoitnOz0tM50iJ3iueRd+NdgvAPSKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIKcN9lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7731EC19423
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722398;
	bh=cIbMRYeO8Ucx3MaQx8lRYPcGEjiejjuBPKecgn1mots=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FIKcN9lqdC4dcFb967xvUA7xW8cDFFj0FS1EC6DwVxN3PCwXnUA/dvhstjnZjn8bC
	 3Jtk+vj/J8aOG9Z+JeKBwSKIDuTH+kJPS5uii1a6cvUapVryDUKM/wO5iLrqKt9345
	 ObBerYVa5N7CyggXGALNfO8ZDJjshx2gfP6pF1ljhyPe25L++0WKD3ts6RdeCrmLby
	 vbnIcoKD5dsNmG6uW7RMHMX2nwpaUBe89NrGIG8fqMZiBs/92mILiqMd1m1iQBngor
	 f6wfkLAQykO7TNyYHAGYlR7knqAnR+uCDLPngWxPYXB/V6QNjfobX9wxjh2b1OhFAx
	 ueGb2yzlA6HdQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81E9EF40068;
	Thu,  5 Mar 2026 09:53:17 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 05 Mar 2026 09:53:17 -0500
X-ME-Sender: <xms:3ZipaSh3hlaJ5w677GfaMUMM7y81eH2Wt9r2FsrBEr9TBol3tOVCGg>
    <xme:3Zipad1_vQos2FEeNM5KcgbsSf5PdBSBXTNWLi_lFfcPcS9W4ZMR8_PWhEGLKEvgd
    Eoq_gbUGLV3TicYqZcInY83MADmMVuoJ32_og3jZkcThOsNkK-U9ni6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthhrohhnugdrmhihkhhlvggsuhhstheshhgrmhhmvghrshhprggtvgdrtghomh
    dprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsrggu
    ghgvrhesphhurhgvshhtohhrrghgvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgr
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3ZipaRsXCD3PHGiVa4tTzCRkTGNM0oBRRktw_E4CKCNs40qna3oTKw>
    <xmx:3ZipaTZyFPwCx7MmCbK8cZtZhFo2jLjoragGZ7D45HlHHM7W2OggwQ>
    <xmx:3ZipaQVtUicZ072WGMs91ypGVx_HOcF2rKgy3WYBdLEEc0hXcIWBDg>
    <xmx:3ZipaYQqGJq4gKgDjptFLsjyAvpN1Q6e68SnbzCQdJ5hNWYWXOvP4A>
    <xmx:3ZipaeMM8ETETTKOkMhIFbj9N22VlziOl32Z5ozMZJiKkXWMyngrKVsZ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5952E780070; Thu,  5 Mar 2026 09:53:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyLyfDHKzLyg
Date: Thu, 05 Mar 2026 09:52:57 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Anna Schumaker" <anna@kernel.org>
Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Eric Badger" <ebadger@purestorage.com>
Message-Id: <0e60efac-e810-405a-94c4-d9c2809517f9@app.fastmail.com>
In-Reply-To: <20260305145054.7096-11-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
 <20260305145054.7096-11-cel@kernel.org>
Subject: Re: [PATCH v2 1/8] xprtrdma: Decrement re_receiving on the early exit paths
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 16C5C2140E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19807-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On Thu, Mar 5, 2026, at 9:50 AM, Chuck Lever wrote:
> From: Eric Badger <ebadger@purestorage.com>
>
> In the event that rpcrdma_post_recvs() fails to create a work request
> (due to memory allocation failure, say) or otherwise exits early, we
> should decrement ep->re_receiving before returning. Otherwise we will
> hang in rpcrdma_xprt_drain() as re_receiving will never reach zero and
> the completion will never be triggered.
>
> On a system with high memory pressure, this can appear as the following
> hung task:
>
>     INFO: task kworker/u385:17:8393 blocked for more than 122 seconds.
>           Tainted: G S          E       6.19.0 #3
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
> message.
>     task:kworker/u385:17 state:D stack:0     pid:8393  tgid:8393  
> ppid:2      task_flags:0x4248060 flags:0x00080000
>     Workqueue: xprtiod xprt_autoclose [sunrpc]
>     Call Trace:
>      <TASK>
>      __schedule+0x48b/0x18b0
>      ? ib_post_send_mad+0x247/0xae0 [ib_core]
>      schedule+0x27/0xf0
>      schedule_timeout+0x104/0x110
>      __wait_for_common+0x98/0x180
>      ? __pfx_schedule_timeout+0x10/0x10
>      wait_for_completion+0x24/0x40
>      rpcrdma_xprt_disconnect+0x444/0x460 [rpcrdma]
>      xprt_rdma_close+0x12/0x40 [rpcrdma]
>      xprt_autoclose+0x5f/0x120 [sunrpc]
>      process_one_work+0x191/0x3e0
>      worker_thread+0x2e3/0x420
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x10d/0x230
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x273/0x2b0
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>
> Fixes: 15788d1d1077 ("xprtrdma: Do not refresh Receive Queue while it 
> is draining")
> Signed-off-by: Eric Badger <ebadger@purestorage.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/verbs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 15bbf953dfad..b51a162885bb 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -1362,7 +1362,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt 
> *r_xprt, int needed)
>  	needed += RPCRDMA_MAX_RECV_BATCH;
> 
>  	if (atomic_inc_return(&ep->re_receiving) > 1)
> -		goto out;
> +		goto out_dec;
> 
>  	/* fast path: all needed reps can be found on the free list */
>  	wr = NULL;
> @@ -1385,7 +1385,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt 
> *r_xprt, int needed)
>  		++count;
>  	}
>  	if (!wr)
> -		goto out;
> +		goto out_dec;
> 
>  	rc = ib_post_recv(ep->re_id->qp, wr,
>  			  (const struct ib_recv_wr **)&bad_wr);
> @@ -1400,9 +1400,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt 
> *r_xprt, int needed)
>  			--count;
>  		}
>  	}
> +
> +out_dec:
>  	if (atomic_dec_return(&ep->re_receiving) > 0)
>  		complete(&ep->re_done);
> -
>  out:
>  	trace_xprtrdma_post_recvs(r_xprt, count);
>  	ep->re_receive_count += count;
> -- 
> 2.53.0

Whoops, didn't mean to include this one because you should already
have it. But, it shows that I am testing it.


-- 
Chuck Lever

