Return-Path: <linux-nfs+bounces-16962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA0CA8AF8
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Dec 2025 18:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C935930BC50F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Dec 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437734C9A9;
	Fri,  5 Dec 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oviwmDWC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019934C9A1
	for <linux-nfs@vger.kernel.org>; Fri,  5 Dec 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956505; cv=none; b=AUUaFp+FknIgNxQW1BP+9V/7G0KcIR00q2A9XgUR++W0doTxgvk+3s/kDs/0yLqQmQ+vWlu9Lwdv7fhdPqUrP3yIOhEY/fCd31YJNr0vSIvYHw2Ey9FwXeV/w343lOrHtN8emy/IhirS/C9g268wDvEOMpwsamkYRnM3pmyUayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956505; c=relaxed/simple;
	bh=9P+oUCNrHqQr6TTse4VstKkT/97+r6l55NAKHEhSJ9s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tbl4rB6BjgDFuhGSp5e+V/GKaycAEmCjgMCu1DEMwO7DE0prLTLBm/IYc8Ul1CRaXeGWyeX1PyVxmJC+hH9JPlCjWLe7bq2TzVpdItmkMqyeDM8pron4jIeGi+i7AIV0GlTBYLZ4w4pqxymjdSTacVzTAZ+x1Sz8TIjBC5U6bYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oviwmDWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53E6C4CEF1;
	Fri,  5 Dec 2025 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764956505;
	bh=9P+oUCNrHqQr6TTse4VstKkT/97+r6l55NAKHEhSJ9s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oviwmDWCzYHpDX4wfzofBRm9GQZKAOShMHLidMh2k622DxLjwkFlIM7xaUH3scOSl
	 HGKqbb8km99rlq3YhJdBITxZUVpuzRWNcJUPi/8CDuqg2tewxk1AVtiuy3FrtKuasz
	 F2dWGAQIB8nyBhVm2LOsz2w+qav4DPSd602h59UgGLrrC7Suxfz4ne01rVRBuaRtId
	 X64UkjS1FTgRyNUPlBvaRhf3mfmBaXYE6B+jzs/GigOClyx0phyG58qSRUoLhMQY34
	 Ft4qC7vTIOwmqFGb/nREezZfPgBulqCFU0du0pZj1j9/b6iMKFf6sX+vI3REBLMCvU
	 BCFVnYOc2uAyQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0FEEF4006C;
	Fri,  5 Dec 2025 12:41:43 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 05 Dec 2025 12:41:43 -0500
X-ME-Sender: <xms:VxkzaVllaefO6Cr-V0OcyG5qCs6STHAyg-nt-DpYBYUNeqOeinx6YA>
    <xme:VxkzabrwiLD7QKwWSn2KA1g48uuUUoYYWy9P2IxCo0gqCaX8f01TV8ED19vLsrE_V
    8yJCg0TRNGBaqPC9v7k7ZBSxt5sj0ENsX82BOtzIcefWh34s_XHfrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeltddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhoh
    hrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhrghotghhvghn
    ghhurghngheskhihlhhinhhoshdrtghn
X-ME-Proxy: <xmx:VxkzaaEGclyb4xuLsHEaPlshe4WnaPIsTSjuADqvbaSRSRrIfZavWw>
    <xmx:VxkzaXpCbzZAMmHvlwWEp_G0rVc6pClaXFCCWt0pt_PhZ9S30VT_GA>
    <xmx:VxkzaVyMhvEEKux-F80P-ZzcEpWbBuFWPB3Qswr802E4FVRbtNU_ZQ>
    <xmx:VxkzaRMqeS6rnLxCPla-GgyvjCy9rpvnPGao3f5FpsNx7A3nSUWM9w>
    <xmx:VxkzaVeYyat1uHtS1X1SBryztmo_OSLSaCGhdljt_2U7Q5cS2sx_hCTF>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9429780054; Fri,  5 Dec 2025 12:41:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyOyYelYpCes
Date: Fri, 05 Dec 2025 12:41:21 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Chenguang Zhao" <zhaochenguang@kylinos.cn>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <dd196d82-6c38-4aa3-bdb5-228fe66f4e5b@app.fastmail.com>
In-Reply-To: <20251204011232.41487-1-zhaochenguang@kylinos.cn>
References: <20251204011232.41487-1-zhaochenguang@kylinos.cn>
Subject: Re: [PATCH RESEND linux-next] SUNRPC: Optimize list definition method
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, Dec 3, 2025, at 8:12 PM, Chenguang Zhao wrote:
> Integrate list definition and initialization into LIST_HEAD macro
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/sunrpc/backchannel_rqst.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index caa94cf57123..949022c5574c 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(xprt_setup_backchannel);
>  int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
>  {
>  	struct rpc_rqst *req;
> -	struct list_head tmp_list;
> +	LIST_HEAD(tmp_list);
>  	int i;
> 
>  	dprintk("RPC:       setup backchannel transport\n");
> @@ -147,7 +147,6 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned 
> int min_reqs)
>  	 * lock is held on the rpc_xprt struct.  It also makes cleanup
>  	 * easier in case of memory allocation errors.
>  	 */
> -	INIT_LIST_HEAD(&tmp_list);
>  	for (i = 0; i < min_reqs; i++) {
>  		/* Pre-allocate one backchannel rpc_rqst */
>  		req = xprt_alloc_bc_req(xprt);
> -- 
> 2.25.1

The commit message:

> SUNRPC: Optimize list definition method
> 
> Integrate list definition and initialization into LIST_HEAD macro

Only describes what the change does, not why it's needed. The body
just restates the diff in English.

A commit message should justify the change. For this patch, there's
no justification. Moreover the word "Optimize" in the subject is
misleading - it implies a benefit that doesn't exist.

If this change were genuinely needed, the commit message should
explain something like:

- "...to match the pattern used elsewhere in this file" (if applicable)
- "...as a prerequisite for X"
- "...to fix Y"

For example, is this patch part of a kernel-wide audit driven by a
code safety concern?


-- 
Chuck Lever

