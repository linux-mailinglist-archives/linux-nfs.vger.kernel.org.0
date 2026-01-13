Return-Path: <linux-nfs+bounces-17816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF62D1B03A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 20:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C346B300A7B1
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B136CDE6;
	Tue, 13 Jan 2026 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7lg0SMP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597C34DCEE;
	Tue, 13 Jan 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332094; cv=none; b=IDm6FWU+zCTBndlCMB2knRt3cL7TA0+W/uSYiUy7XZijZPiF0LMJEkle/8jUMqY4ZXK9h5YemdZaT5t2kp6dZ0+AnlLgnkEkpVDeVAVB6t+kxqTei6BdO4mMFqS4IMVKAE+X4PFaB2bZtoie7aQfdNQY/BeT9i2qJVxmhDDkVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332094; c=relaxed/simple;
	bh=GvBAv1niXdQeWWtINrbgPJMNC/MppkM8q0EcYcmZ8YQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gCsKNQ/tggEExQXaG4idZ+cFiHdk+fu79y9xzqZ1RySPqmRr8BYggmA7CgcWGRFdGdNnbvc2IDS9JeUKxk11mRAnkDzDe5qPLQTkfDsGdJp2VguincdwPYA54eqlMaTSE15qeOIKNwA4TiXFBBgKcD4FKcxr8Uq+64ZVI8QWcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7lg0SMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F4C19425;
	Tue, 13 Jan 2026 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768332093;
	bh=GvBAv1niXdQeWWtINrbgPJMNC/MppkM8q0EcYcmZ8YQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r7lg0SMPZUWIT7VOBqgBqoGK45cLhwsYfMoVFmICdw1t33yvyLiysvfOS6+9WuQNt
	 izEQ5+ylFHnLsEjvy8NySAXvEFHDfqRu9tD/i+Qi4rCugwNzbHKsu5T/AuLtANZxLD
	 CFEBahLddTe/utE4XBIwsTk6iZOqVSKrppHC6YbyjKKTFN+1QDv6KOztO8GUh7dU34
	 eAEXM3cuXR+9aKGRfErO0q8sgIR9DH7kJlrBrrTHD39PA4E9KhyEdv9IPiyZcVTt5z
	 4u9HZ4xmEvMnHVgBqApbDlmmDAIrpfLxUYBM0eTXmao2xBvymftEmGG69Ya1LZsW7e
	 GRc9ypiWxizeA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7DA26F4006C;
	Tue, 13 Jan 2026 14:21:32 -0500 (EST)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-10.internal (MEProxy); Tue, 13 Jan 2026 14:21:32 -0500
X-ME-Sender: <xms:PJtmaaT0Ncbk3QT_tSAH1J8aOiPfBRC5sy-dvsZtXEPsKU2brBfBEw>
    <xme:PJtmaalVg3laAwhWq0cEbUeKpBXVKKOHB1dDATED6BP4yiZq5dRzEX243yzq1THjk
    OONhLaoafFfZxaxdeKtr3RGzSYd7H2IpNOc_g7QF4jNOHqxagG-FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepsggtohguughinh
    hgsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhn
    ghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorh
    grtghlvgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhm
X-ME-Proxy: <xmx:PJtmaf3l4093X46sysprOUZV5K-UJywUeO9TnjnYKP-8qcZRRMNT7w>
    <xmx:PJtmaZ8NyyYp2PfNO2UptvmldScon3v3tpkmTAu74ZvVy6NCVaGoYw>
    <xmx:PJtmac7BEDP4z0-aPRfZfePyDXL2bBirbIXMCIY2tAKzKP5UKHme4Q>
    <xmx:PJtmaZsDW9fkSU4Cm029pvq5yxayKGKoW7QfcTb3AAAHnP3lRWVZqw>
    <xmx:PJtmaW0EM_zG2UTMVl5V_3wF53q9cNzF4LDynlmBnfjLkGXq9cT7ydhn>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C2CC15C008C; Tue, 13 Jan 2026 14:21:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIvM9mKjbfBc
Date: Tue, 13 Jan 2026 14:21:06 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5806015a-ad18-4bc9-a320-2fdab4d86969@app.fastmail.com>
In-Reply-To: <20260113-rq_private-v1-1-88ed308364e6@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
 <20260113-rq_private-v1-1-88ed308364e6@kernel.org>
Subject: Re: [PATCH 1/2] nfsd/sunrpc: add svc_rqst->rq_private pointer and remove
 rq_lease_breaker
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 13, 2026, at 1:37 PM, Jeff Layton wrote:
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index eee8c3f4a251a3fae6e41679de0ec34c76caf198..8ce366c9e49220e8baf475c2e5f3424fedc1cec1 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -900,6 +900,7 @@ nfsd(void *vrqstp)
> struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
> struct net *net = perm_sock->xpt_net;
> struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> + struct nfsd_thread_local_info ntli = { };
> bool have_mutex = false;
>  
> /* At this point, the thread shares current->fs
> @@ -914,6 +915,8 @@ nfsd(void *vrqstp)
>  
> set_freezable();
>  
> + rqstp->rq_private = &ntli;
> +
> /*
> * The main request loop
> */

Thanks for tackling this one. Nits below...

This assumes sizeof(structure nfsd_thread_local_info) will always
be small enough that it is reasonable to keep on the stack. I
can't say that would be a good bet in the long run.

And we don't need the perfect reliability of not doing a dynamic
allocation here. If kmalloc(sizeof(struct nfsd_thread_local_info))
fails, the thread exits immediately, no harm.

Also, scatter-gather lists could not be stored directly in this
object because it is on the stack. If Ben wanted to stick a
32-byte buffer in struct nfsd_thread_local_info to be used with
the crypto API, it would have to be a pointer to it, not the
buffer itself.


Chuck Lever

