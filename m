Return-Path: <linux-nfs+bounces-17818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AED1B15D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 20:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BCC6303022E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB835EDD0;
	Tue, 13 Jan 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqxfv4Sz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1C2DF156
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333317; cv=none; b=d5kkq9gDsZoLPIf9O7zoanmc1SGwqfgM7Rm51WOEuqLtq5UfFMZIzLoeKJfI2Pd3xP99Ri+FCdQKqFClvG9virbSUtlHsd4J7XygPtBa52Bu6wSzwfNRi82A3cFHfzJTOjMh2PY8/sKEEcURx57NIlemaaz2+LWPetl7J7zID0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333317; c=relaxed/simple;
	bh=ajwNiSdbv/DqCRB3UF9WRBbdE5OqGMnlBdXXHexYJkc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Is2U0E4HMUKz5xxWjPOB31hIAUxgfpNQKeWGQMenXesLUQU1XUK6SZ4ztIhkUO98fHfUIkCk8UyrDs9Vic06GC3a4sLWnw5UAk3TzN93jL+LNaKjrKcemWWQbzRQsngw+DlsU9HeDkUVTo5mlxyRRzvao0NQ1p+VhQDiNXtGyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqxfv4Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67820C19424;
	Tue, 13 Jan 2026 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768333316;
	bh=ajwNiSdbv/DqCRB3UF9WRBbdE5OqGMnlBdXXHexYJkc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Jqxfv4Sz1DYNw5yBrS206OXLI7F3SfcoWK2hMF81nKbZ5rVBVkNNl2fSNElbGbHtQ
	 YyodddWaUl6+v512gwrnyxCpWqVkhgL9TZcNbBYZysjve+rAr4F8KrL2wMieVBiHEm
	 my64vsDGD1GExaQ+sKi+x/KqHBEQXVikhJvNiUaP0QxHJ0MzuLKypFoKxqEYDELiKQ
	 wi0dS4tBMlKiK5WrmL5O+dWQp0WS/6C73XjlXkcnDyy2fFYTstKLuWKTxvUjwQI2Mc
	 RD2veJXgrmMmaB1vb421NXmBmpTcukRmothGjK+rkmfkyfil8iNs9zMfOQuIyMOwkY
	 FjMVk+qLE9CmQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 917DCF40068;
	Tue, 13 Jan 2026 14:41:55 -0500 (EST)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-10.internal (MEProxy); Tue, 13 Jan 2026 14:41:55 -0500
X-ME-Sender: <xms:A6BmaSk-NxqYTMB0IYZvjGrxKU2ArRzcyYAXBHaASAPsJmTMSjE4QA>
    <xme:A6BmaUohuYLnhYvgu61zFwFgf878Ufmaw9j2AMmi4kbtejfhtxmCPf9YA20krkWhu
    FdcB_pLos-ntjfZVvq5TZXBX4Fwz0mWQNbodJd39jlMySoGPzy7DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduudekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:A6BmaSIo0y2k96LOjGsiZOyAZWdVxizdl9SUp8DbxHqX2OwcjGXJkQ>
    <xmx:A6BmaWB1M6vIDTHOGcgSKekZ0RO-wk2XFr9UhzU1e93_an0LzOvA4w>
    <xmx:A6BmaftUqGRiQRAqBF3CN2zRlSG0iL_iTaV0Bq0NtAJuzVuFYzotew>
    <xmx:A6BmacQbm9b2pSBDbhvn_phI5Z1t2wT1WTVto1fcccnMhL819k-K8Q>
    <xmx:A6BmaeIj_hN7GjTYdvnw9bK-1dCZ9-ev31-fbIm9ONvEtJCj4SXubM2s>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6EF8315C008C; Tue, 13 Jan 2026 14:41:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIvM9mKjbfBc
Date: Tue, 13 Jan 2026 14:41:25 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6f112559-43e0-41ad-864c-03b1841920d2@app.fastmail.com>
In-Reply-To: <71ddafd443a0e13f79cea09ba2b3ac4f106163ce.camel@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
 <20260113-rq_private-v1-1-88ed308364e6@kernel.org>
 <5806015a-ad18-4bc9-a320-2fdab4d86969@app.fastmail.com>
 <71ddafd443a0e13f79cea09ba2b3ac4f106163ce.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd/sunrpc: add svc_rqst->rq_private pointer and remove
 rq_lease_breaker
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 13, 2026, at 2:31 PM, Jeff Layton wrote:
> On Tue, 2026-01-13 at 14:21 -0500, Chuck Lever wrote:
>> 
>> On Tue, Jan 13, 2026, at 1:37 PM, Jeff Layton wrote:
>> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> > index eee8c3f4a251a3fae6e41679de0ec34c76caf198..8ce366c9e49220e8baf475c2e5f3424fedc1cec1 100644
>> > --- a/fs/nfsd/nfssvc.c
>> > +++ b/fs/nfsd/nfssvc.c
>> > @@ -900,6 +900,7 @@ nfsd(void *vrqstp)
>> > struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
>> > struct net *net = perm_sock->xpt_net;
>> > struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> > + struct nfsd_thread_local_info ntli = { };
>> > bool have_mutex = false;
>> >  
>> > /* At this point, the thread shares current->fs
>> > @@ -914,6 +915,8 @@ nfsd(void *vrqstp)
>> >  
>> > set_freezable();
>> >  
>> > + rqstp->rq_private = &ntli;
>> > +
>> > /*
>> > * The main request loop
>> > */
>> 
>> Thanks for tackling this one. Nits below...
>> 
>> This assumes sizeof(structure nfsd_thread_local_info) will always
>> be small enough that it is reasonable to keep on the stack. I
>> can't say that would be a good bet in the long run.
>> 
>> And we don't need the perfect reliability of not doing a dynamic
>> allocation here. If kmalloc(sizeof(struct nfsd_thread_local_info))
>> fails, the thread exits immediately, no harm.
>> 
>
> Not sure how much space Ben will need (if any).
>
> We certainly could have nfsd allocate this separately. I didn't see the
> point for something that is only a few bytes though.

If we are designing for today, another approach would be to set up
a BUILD_WARN_ON or other type of static build failure if this
structure grows larger than, say 256 bytes -- then add dynamic
allocation at that point.


>> Also, scatter-gather lists could not be stored directly in this
>> object because it is on the stack. If Ben wanted to stick a
>> 32-byte buffer in struct nfsd_thread_local_info to be used with
>> the crypto API, it would have to be a pointer to it, not the
>> buffer itself.
>> 
>
> *nod*
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

