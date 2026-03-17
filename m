Return-Path: <linux-nfs+bounces-20240-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIDpGHBzuWm8EgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20240-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 16:29:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C11572AD0F2
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2DE930427DC
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321427FB0E;
	Tue, 17 Mar 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWPgrlBI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391F2D879E
	for <linux-nfs@vger.kernel.org>; Tue, 17 Mar 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761188; cv=none; b=kFSUZqV4+0yu26wCoSA7APNC5+L0X6h4lELVZfDAB+4w7E5i+hVF7dlhFgPRpjr198rdaAAtsqrjXJCwecvOiq5oiqLMgrvRIh5OfJGpuLKxlx3Lto1dWXzM0/C5FhClbtmQWt160YtTVPAdbmqrf2qnO1xbruDnv5q6fs1mhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761188; c=relaxed/simple;
	bh=4AMERsTXdrPKHLtcoeTcSSizD6aR3Nfyj9rtRZkUCLY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=utUHLa4ci+MWmBhnedRxnwsj1S5Jb/4ZPy6LD48yKKZNZUzyEZsjHlE+pdXJG+n412QM9BOjdhxhcdxusV/sLNwPNFpVgb5qSYI+LFG/bz3BjS2NPV24Z+nKcTdd+8Yrc+kbredOeyvY1usAhlZWNnjksyHSwoNauilvpw4guK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWPgrlBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7ABC4CEF7;
	Tue, 17 Mar 2026 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773761187;
	bh=4AMERsTXdrPKHLtcoeTcSSizD6aR3Nfyj9rtRZkUCLY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MWPgrlBIXR/xBLawjI6aqKc0iU1AEFYbLOASVqVVQFiA0UZSe+KV80gH9NTlokCfJ
	 Nup3JSRxksOHgKkgWDh7K0/VzfvGJvTfaKJNbmg3KxQvUd3CwghIPrDQCCYF0ss0Y7
	 JfZ/2XfYAiNgLb1NtyaFftVdCupWx+tgZ1ByUmwdoSlj8ChfBEtxhT8g9WL9MPUkR1
	 gvbpFxFoarwfFP9k7sOkP8Gk1Tw26Jeu/ngd0jT+rk1BKTg6dApisf0xHshmJ1yXc2
	 VEQztqpnqNDsJDIBsedosk6LzmK9BIV3Rc8efafqs7u+8PDZuWZ8TSc/yUlfAQAJJ5
	 p43KD2npHO2aQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6DC72F40083;
	Tue, 17 Mar 2026 11:26:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 17 Mar 2026 11:26:26 -0400
X-ME-Sender: <xms:onK5aaqhusnrdcnTEj41akiAhtRJkMckUID3SS83MbCplcyaVy2aPA>
    <xme:onK5aTdl_OEsHSMutslWux7dha9L5Kkgl_xsH8CF4aFYry33csdIgdDQlGkfw_LId
    3xAR4DpYt0AGjgB47Jd7qEUsPC5ogAYFSUWV917JtUJQmeZrntOIko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehnvghilhgssehofihnmhgrihhlrdhnvghtpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomh
X-ME-Proxy: <xmx:onK5acMj94za36VvpGSM20rOttclYjsnUfxhsZJLR0y7UqfJefvH_w>
    <xmx:onK5ae0-BBjHswNhLg6J3kX9YbobbBGzyzmDYjJcqXQvoAQ2Y30VVg>
    <xmx:onK5aQTUnmJWFzoTdyhJBFnXBP1tDJbtOSa5o3SoTlL6YaCtqvhwzw>
    <xmx:onK5aZlI_Vg9buybQnUdhHpy5NH-LL6oubWiILkve-fc-DyJPJjidw>
    <xmx:onK5aZOYbtYZFxuekj3A-qf28QBLbGLcr7f69IltcdyGlzb6PpYG_IQw>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3F779780077; Tue, 17 Mar 2026 11:26:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYNV0DTDvx0R
Date: Tue, 17 Mar 2026 11:26:05 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Leon Romanovsky" <leon@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Christoph Hellwig" <hch@infradead.org>
Message-Id: <c5e41476-2086-4e76-8153-82788e1b9203@app.fastmail.com>
In-Reply-To: <20260317142855.GD4367@lst.de>
References: <20260313194201.5818-1-cel@kernel.org>
 <20260313194201.5818-5-cel@kernel.org> <20260317142855.GD4367@lst.de>
Subject: Re: [PATCH v3 4/4] svcrdma: Use contiguous pages for RDMA Read sink buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org,infradead.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20240-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C11572AD0F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Mar 17, 2026, at 10:28 AM, Christoph Hellwig wrote:
> On Fri, Mar 13, 2026 at 03:42:01PM -0400, Chuck Lever wrote:
>> +#if PAGE_SIZE < SZ_64K
>> +
>> +/*
>> + * Limit contiguous RDMA Read sink allocations to 64KB
>> + * (order-4 on 4KB-page systems). Higher orders risk
>> + * allocation failure under __GFP_NORETRY, which would
>> + * negate the benefit of the contiguous fast path.
>> + */
>> +#define SVC_RDMA_CONTIG_MAX_ORDER	get_order(SZ_64K)
>
> Isn't the limit really an order and thus grows with the page size,
> instead of based on a fixed size?

So on a platform with 16KB pages, an order-4 allocation request
(256KB) is still desirable for our purpose here?


-- 
Chuck Lever

