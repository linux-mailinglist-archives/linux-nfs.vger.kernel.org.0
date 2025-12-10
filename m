Return-Path: <linux-nfs+bounces-17022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07601CB3153
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C0E314D24D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B5325721;
	Wed, 10 Dec 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdoqgGvw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76031B111
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765375015; cv=none; b=BNXsQEvrNaXshTd8W4OgJrY0Fr+dfde7SyBZY3zXLpahYm1LTRHNf24MTb5EOPShIgF7k5t2SK/lRtHdIbWO4MQmZia1SSHTNIdBAfEJE0MkQki65qWzT6kQ1XZlqbw9nm5guWQEmHubxJCG/Y/DSvyzILDhSZL32JEHwPmu12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765375015; c=relaxed/simple;
	bh=ou9T/NoEP9eDmLZQVCdbq0JkKzCU0vxJBsaaqvCiVss=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P8Rnxk/6JZz25asDEA/zit6Ivl1taXjN3I32J3kO+Yf6MdKEW+KiUKYwJJicumyEUSEHiuYc9vuW6pYTGxBuZV8e1pgbN58wgaMG2KlLl6JxGXqF8zHgnK2KjcazaWEnic2KVojmISB4L5bIvcFrwYXwnnxtasqWA5xqhW3fXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdoqgGvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59458C4CEF1;
	Wed, 10 Dec 2025 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765375014;
	bh=ou9T/NoEP9eDmLZQVCdbq0JkKzCU0vxJBsaaqvCiVss=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qdoqgGvwpqw4BO0frns1J3iowajzAoaH6jShe42Owcz+Qit7mGapoPUMFw4mPEpBG
	 VSEzhg58J6kep/63xqqToMCA5jlWWLSkPunNApf0mdndqpQf/hOgo0oMmz85sNyNWV
	 wJu2l93aPQM8z7Vuzx3UmA2TZK3PeBU64xidrUcbF/ikUKw6t6EeEiHvlhb1STvKYz
	 H4lRrdCesQZTXoks+EwMjeIAVoUftMo+/QcFNxqRcxA8rFCAiwdKkmUWpWs9EHDLq0
	 2Vr0Z0A4uXKJyeETjmwNizi4uu06W3MvuRF4jkPcCQ8M4UIYQldrGioPQcFzFjnsyQ
	 OQrNYuoB4ihkQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 84799F40068;
	Wed, 10 Dec 2025 08:56:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 10 Dec 2025 08:56:53 -0500
X-ME-Sender: <xms:JXw5ad-hYmqq25kD8wSa1wxE_gjenRnSVs8Vinno_rW3WZwyndgX5w>
    <xme:JXw5acgZkGDF1c-O1kJoajrA8tLTW-XRz3VWPyeXuRPQIS8dDgJ-Jj-0RCIW4t3Rg
    S7qOhPAHzBJ7HdnPaec7S0tlVZqgLZ7FXpeAvamY7vGUjFhpJIz71s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    horhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhgrohgthhgv
    nhhguhgrnhhgsehkhihlihhnohhsrdgtnh
X-ME-Proxy: <xmx:JXw5abcMc8nYlo9Iwdyh6Lu2TEq_2JlJXhcXKKTr2xKJZo7iFFkjCw>
    <xmx:JXw5adidnjsIz4BqB3LJAHwrURP1gDMdUG_dF_Ohhiho7FXbbyi0og>
    <xmx:JXw5aWLnbnHdFvoyKsKtZrbpn8QO1C7kLOUh02rxU25eolnx1-TEyw>
    <xmx:JXw5aaFPt4O3snyMy37k-5biYWjJzR9_AREDy7ig4RqwNVaue519wA>
    <xmx:JXw5ac0p5Y9jd-vxrfuXCw1oDjADJmfXF5M7jwbVA_xWCoWcKgTOM9VN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 561F7780054; Wed, 10 Dec 2025 08:56:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhUqZCzku-iw
Date: Wed, 10 Dec 2025 08:56:33 -0500
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
Message-Id: <9fd4fded-abee-45ab-8654-359f98846ba2@app.fastmail.com>
In-Reply-To: <20251208085348.467419-1-zhaochenguang@kylinos.cn>
References: <20251208085348.467419-1-zhaochenguang@kylinos.cn>
Subject: Re: [PATCH linux-next v2] SUNRPC: Change list definition method
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 8, 2025, at 3:53 AM, Chenguang Zhao wrote:
> The LIST_HEAD macro can both define a linked list and initialize
> it in one step. To simplify code, we replace the separate operations
> of linked list definition and manual initialization with the LIST_HEAD
> macro.
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v2:
>  - Modify the commit message according to Chuck's suggestion
> 
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

backchannel_rqst.c looks like a client-side file, so I defer to my
colleagues who maintain the Linux NFS client.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

