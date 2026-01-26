Return-Path: <linux-nfs+bounces-18478-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGmxAYubd2n0iwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18478-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 17:51:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C40DC8AF31
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 520A830090AA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE43491D0;
	Mon, 26 Jan 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD8lnbFB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFC348875
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446158; cv=none; b=mE9t0u01N52yLXW8RPxPszaa6I3H+4mcLfSq/33pMO2Ved9tGtaa+KflwwrK34Ucp15ujmwew5pxsFkUlp9GQzI4UD1V6wbo92gBp/kFQ5eN6VN61lK+FvavnLZIOb5nUyReW43edOO8UFjQ/W0yYUwlnSbvltug4OIJcXQM4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446158; c=relaxed/simple;
	bh=lxEueFMYkSMwYLewLmZXIIkwZXa9K0J/Gh1IkFpq6EQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gX6MSXS1jwGL6Z2RJKNe+UHiPmeFtwuYaLCDoN7eIoXFscz+AHTCnXzf/lbmeTaLrbUQ8nXVeFi1QjnWN8/YU6dWDTVN9sf9vX9E0AN41omc4Wo8qb3b+pyZZC0j4Gn4vUL4adGE/pXTU6XKMS60bHGt3XAiajyiUL++N/uFtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD8lnbFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06720C16AAE;
	Mon, 26 Jan 2026 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769446157;
	bh=lxEueFMYkSMwYLewLmZXIIkwZXa9K0J/Gh1IkFpq6EQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dD8lnbFBxtBSvPYr6flgFFiO0aN7ZzPUto+vdSBYAqsfPTLtUZq2BkbuM+O8rvatf
	 97WLFnd0NKFnhofpfsRDf10s0ke6cg05m12EJE28DcusIkI3EqWBf6FC5zoC5fweDH
	 qGvpAprygmWeWLkCSOk06yArSDgK69HbZZwqsyWQ7TLYklDkfoIl8Ru3Jl2KRzPoE4
	 tSSh8tVEs+sx67bmr7g21c07WxERF6+0/ohndvcPM0VS60zsSB3gCCUJ2+JN/kLd+E
	 5R77aFRYFjomFCGLbBZQ5YodyBQlj73kkB8+a45g2o5rtdnnYTOzxjA0asqcfcAwEn
	 fjXL73yJ7jbvQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 12B24F40068;
	Mon, 26 Jan 2026 11:49:16 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 26 Jan 2026 11:49:16 -0500
X-ME-Sender: <xms:C5t3aQcVT_LjXfzRv8JlS4JCY-EVIGj2xMt6rabiROnYVKOLFvGJTw>
    <xme:C5t3adARk4iVm1ot3R5hbXZeGKpEDhkh1AM1fX-KG3_84MU8fHJjyTJLEruGE76vD
    FIthFQCVDBbd8qcem94p7edfxcAleH4YyJQshR3MnJuqd2Yud4Elp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthht
    ohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrh
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepnhgvihhlsgesohifnhhmrghilhdrnhgvthdprhgtphhtthhope
    hokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhm
X-ME-Proxy: <xmx:DJt3acCKKI6ZIXWsq86jw_b5JIfcGLYa6fLPYHCcSacMyqN244DK7g>
    <xmx:DJt3aaZm0FMjduMWqAW74f-qfb-nddiOq_jgIbMZ6i3XVkKgKeMwAA>
    <xmx:DJt3acnzx1D0T1lWt7nod3NyCSaHQptOVI5qol7hUXVAdJOFfhle0w>
    <xmx:DJt3aXrNptLaANk1EXkWinT7duZCLQnHXWgsRlvLvqz6DNzkKB02Zg>
    <xmx:DJt3aWBSao4zRtTGPoEt4Uekhx-0KCKWo1HOS6pNrqATU5DRfAIu27Kt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6595780070; Mon, 26 Jan 2026 11:49:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ayo69OWiNnSN
Date: Mon, 26 Jan 2026 11:48:22 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <38f7282c-31a6-4edf-8d5c-0d08b401f1f5@app.fastmail.com>
In-Reply-To: <20260126061752.GC1638@lst.de>
References: <20260122220401.1143331-1-cel@kernel.org>
 <20260122220401.1143331-4-cel@kernel.org> <20260123063622.GA26025@lst.de>
 <d868e180-b6ed-4b3b-afc6-7f08083615c1@app.fastmail.com>
 <20260126061752.GC1638@lst.de>
Subject: Re: [PATCH v3 3/5] RDMA/core: add MR support for bvec-based RDMA operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18478-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C40DC8AF31
X-Rspamd-Action: no action



On Mon, Jan 26, 2026, at 1:17 AM, Christoph Hellwig wrote:
> On Fri, Jan 23, 2026 at 10:06:36AM -0500, Chuck Lever wrote:
>> >> +	nents = ctx->reg.sgt.nents;
>> >> +	for (i = 0; i < ctx->nr_ops; i++) {
>> >> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
>> >> +		u32 sge_cnt = min(nents, pages_per_mr);
>> >> +
>> >> +		ret = rdma_rw_init_one_mr(qp, port_num, reg, sg, sge_cnt, 0);
>> >
>> > I guess you looked into that, but never replied, but this still
>> > looks like it duplicates most of rdma_rw_init_mr_wrs.  Is there something
>> > that prevents reusing that directly or with minor refactoring?
>> 
>> IIRC I interpreted your earlier review comment as "let's defer that clean-up".
>> I'll look at it again.
>
> I was hoping we could just reuse the code instead of duplicating it.
> The one earlier comment was about sharing code where we actualy
> pass in the bvec and scatterlist, and that might or might not be useful.
> But for this case where we have to actually create a scatterlist first,
> not reusing the existing scatterlist code to then work on it feels
> wrong.

I added a helper that refactors out the common logic. But I did
that a few days ago and all of the context has dribbled out of
my brain. I'll post a v4 soon, and we can continue from there.


-- 
Chuck Lever

