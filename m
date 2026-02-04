Return-Path: <linux-nfs+bounces-18710-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALsxBOlyg2mFmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18710-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:25:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C00EA2D5
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF34430869A9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9780421A1A;
	Wed,  4 Feb 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDPQotzc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA441C2E8;
	Wed,  4 Feb 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220428; cv=none; b=C0UnZdyTQtksfCn5mKn/6Wv7Cc2mRGIOH8cRkk3wqCDbyoTqgJCh525IFbvZrWZvRdsqb4uW0c+qRiWIo2A7lNkSoTCWmD7Jiw6RxBvPIfVKqmK+ARJ2EHUxzUx4NRMRjnM5VkJbwAxFiXNBveohxQ8QEnOgTRnn5i9JC+tyk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220428; c=relaxed/simple;
	bh=jZC6O6pOSk1/r2WwwU9Psyn3i/e3i6vnjbcVbv/gHU0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pR1zZFHJoK8mAy2CilXVXMyPgoNOoopwD0ptYrWEcXURA8ICYq74nXvQjZTaLhkqQLjIIo6G7ijNc+VuCiAdhDZt03NtmigWFzKYJDEPCw9JKJZDNggKBudKtgJTtkb/j1AVM3M6TGDAKVwVve0Iu+gvTuCLiljFXiC+zZdGXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDPQotzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1917C116C6;
	Wed,  4 Feb 2026 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220428;
	bh=jZC6O6pOSk1/r2WwwU9Psyn3i/e3i6vnjbcVbv/gHU0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IDPQotzcFTEaIZWpBbRSrRkZRgo15kltyVWS8ICWypSrpDwq+mXk9NvAHpHwyFO8B
	 Z38K27cXJVDtKKIs5Wa/edtDrVXimla1pPj0fNda/XnMD6K00MYFfa+5OPK0apFxS2
	 SJAOdIEBzrtwn+4lelcMMb+xpO5CIlwCA2/Z5js2dTaonkVdoRR1/m7j2dLT6BiTni
	 qXmJxI+fy7tWJhrnXqKKq3Hni1iVHtCGvuIs/jLwmUAftB6XJViwoBJJxk8tbiAtvd
	 sHw+qGgyNPyDkfJBGhF7pu3qlwAtQ/T7C/J0KWSSoRZiG2U4pDbUyYbsNNZWal7nGa
	 uf7b7sX0DcXbw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBAC0F40070;
	Wed,  4 Feb 2026 10:53:46 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 10:53:46 -0500
X-ME-Sender: <xms:imuDaZ10sGuCclnXHdqBMSbd4M9pfWqIF9eB5zvPzDunqlFW2hCXsQ>
    <xme:imuDaa6IMeUrsrgvC3bFp8fABG-tI2qCLDBKMBWwU50puEyGrvbh3zmT3waB2lsQY
    0SgNUnQs4JevWM0b-NYZLVlekfjDJ5lnn7BlPeHPAYAEr3iSNLN4XI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnnhgr
    ucfutghhuhhmrghkvghrfdcuoegrnhhnrgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieekjeeileegtedtueekjeehgefhudfhjeejgfefteffteekgefhteev
    ieeukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhhnrgdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijeejuddvtdej
    ledqfeefvddvfeegjeduqdgrnhhnrgeppehkvghrnhgvlhdrohhrghesnhhofihhvgihtg
    hrvggrmhgvrhihrdgtohhmpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegurg
    hvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhhitghkrdguvghsrghu
    lhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhushhtihhnshhtihhtthesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepmhhorhgsohesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthho
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:imuDaVlKOAlQmXp3cYkARdJa2pQXzeeTcXIcYXXrVW3oAQZ8AZxnLw>
    <xmx:imuDabVFi-JxLhenLIXcRyTUx4U-tRsiJB2fUqOCezu0cGeOjBAkwA>
    <xmx:imuDaYnp7hTJm3bInGpmMq2MlTaLpPc5nP3ix9sceckWrUO5JUq3IQ>
    <xmx:imuDaYRMQ8OEJXIgaHuHdpODRS9PuU8-CnuVUCUt5IXzBq_EEd3SDQ>
    <xmx:imuDacFv1HCby6-IKhdS2cJ3vFJew8UrB1uIs5lCth2iQNX6Jiaz9RrG>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AAA17B6006F; Wed,  4 Feb 2026 10:53:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_RUi7nt7k_J
Date: Wed, 04 Feb 2026 10:53:26 -0500
From: "Anna Schumaker" <anna@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>
Message-Id: <5bdb5b9d-30eb-4511-b839-21b073a6ce43@app.fastmail.com>
In-Reply-To: <20260204094500.2443455-2-andriy.shevchenko@linux.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
 <20260204094500.2443455-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] nfs/blocklayout: Fix compilation error (`make W=1`) in
 bl_write_pagelist()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-18710-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oracle.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63C00EA2D5
X-Rspamd-Action: no action



On Wed, Feb 4, 2026, at 4:41 AM, Andy Shevchenko wrote:
> Clang compiler is not happy about set but unused variable
> (when dprintk() is no-op):
>
> .../blocklayout/blocklayout.c:384:9: error: variable 'count' set but 
> not used [-Werror,-Wunused-but-set-variable]
>
> Remove a leftover from the previous cleanup.
>
> Fixes: 3a6fd1f004fc ("pnfs/blocklayout: remove read-modify-write 
> handling in bl_write_pagelist")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Anna Schumaker <anna.schumkaer@oracle.com>

> ---
>  fs/nfs/blocklayout/blocklayout.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/nfs/blocklayout/blocklayout.c 
> b/fs/nfs/blocklayout/blocklayout.c
> index 0e4c67373e4f..83e4a32b3018 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -381,14 +381,13 @@ bl_write_pagelist(struct nfs_pgio_header *header, 
> int sync)
>  	sector_t isect, extent_length = 0;
>  	struct parallel_io *par = NULL;
>  	loff_t offset = header->args.offset;
> -	size_t count = header->args.count;
>  	struct page **pages = header->args.pages;
>  	int pg_index = header->args.pgbase >> PAGE_SHIFT;
>  	unsigned int pg_len;
>  	struct blk_plug plug;
>  	int i;
> 
> -	dprintk("%s enter, %zu@%lld\n", __func__, count, offset);
> +	dprintk("%s enter, %u@%lld\n", __func__, header->args.count, offset);
> 
>  	/* At this point, header->page_aray is a (sequential) list of nfs_pages.
>  	 * We want to write each, and if there is an error set pnfs_error
> @@ -429,7 +428,6 @@ bl_write_pagelist(struct nfs_pgio_header *header, int sync)
>  		}
> 
>  		offset += pg_len;
> -		count -= pg_len;
>  		isect += (pg_len >> SECTOR_SHIFT);
>  		extent_length -= (pg_len >> SECTOR_SHIFT);
>  	}
> -- 
> 2.50.1

