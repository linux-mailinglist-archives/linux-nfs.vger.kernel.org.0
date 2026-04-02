Return-Path: <linux-nfs+bounces-20617-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD1cDshszmmpngYAu9opvQ
	(envelope-from <linux-nfs+bounces-20617-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 15:19:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD823898B5
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51FDC31F3F54
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C134FF55;
	Thu,  2 Apr 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soZ2xrrJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07634BA49
	for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135486; cv=none; b=m/uILiUPHwEjMjAnwoYvGkXrEZ6mF8IcON9pn/JkeLgeK9G8UXRgHqLXmPTY8yCuU+zBitCzMnF4sEIZp5ggPftXCfdonnyoDLWUD14U3fLXJ75bAXbGTNSnzKT7JkVglz/cLcnuFplB2rKf/9/Pz3s+X3Z84zYPHvT5rU+KXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135486; c=relaxed/simple;
	bh=bS15XMo/9WRu57PhJD5kvXO+TdOi27oIRuDCZQ2t9YI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=asfsDJC8JPdwVlyfdDPzx5amqwzb1wm1CeIRgSMntK7So0ssZFRx5FfwfwWzJtSd5xRTQQZZ673SFSa9yfNW8l8cqBrdQDnZ0DFdUqydNKu6Esc+1EBbIuZCQHARcR8qWxxavBlabvQC9h88Vq/3r2IAdCKAyKhx1NZ9imiHdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soZ2xrrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC56C19423;
	Thu,  2 Apr 2026 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775135486;
	bh=bS15XMo/9WRu57PhJD5kvXO+TdOi27oIRuDCZQ2t9YI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=soZ2xrrJBQw0JGVX++0BF4lX1h7yORUWY/AlLlcnKraN72iIYwyWlJwH/44Cai0cA
	 1zHddRwyPY+Mc8UkTPmWLG+tcghl+d7ww//4JTA0/hFnyUtymZ1jlCodO9ehxHI1fJ
	 1ksHG9gE5cueamMicHuHIkwOqZUCR4RFVP6S0gt2Vj4Jbqj1SP+Ya82mE1iKLVgapX
	 d37zK5N41DQCPf9oq976ltW1n/NsHq5ZvAP9Pgm+3IrmkPZJk9X3mgoKZrOxnFHybO
	 0pi0XJQrRwv2KqNsc+6A0MJZ5VoFuRAiaH48ju140A/UuBiumSPun0moDU20RuKTPQ
	 t0qC3FOj3sZjQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3B1CF4007C;
	Thu,  2 Apr 2026 09:11:24 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Apr 2026 09:11:24 -0400
X-ME-Sender: <xms:_GrOaeZE5FrY1QR8VLt7qOytmcT1yQYv5ReC6wD-d_zx_E_kI_xJnA>
    <xme:_GrOacPNrpxjAYXwhRSVPtJy6CA65Daq4OGFaaU8wLhAPFbIbqq5LXD6iag5J0KMs
    sSAgfeQz6Kjxe9MKC4UfJO0bAeNw_lQlsReYqQ7R1J5nrKkVvd9GmS6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepphhrrggrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepth
    hrohhnugdrmhihkhhlvggsuhhstheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtphht
    thhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:_GrOaaWgZ-Z5pvBEcoaFVjOszvBmqvgog9Hx1JT0dfRqtpGtvL3eHA>
    <xmx:_GrOaWDI9n041gvjfuTXfHbEajQZ2FtjfTr4251Son0qir2RO1yoZw>
    <xmx:_GrOafeVxOaUz2ICQl4q8ZNrYBq-Huq8kBJAdFc5FGHlnX8So2WXug>
    <xmx:_GrOaVo3zoWPbPr2gGXf10VINm2ol20xGh-IrtUFTwEDLTFwnWDEtA>
    <xmx:_GrOaYTdY7Lg4sknk8ZuuKhh3I0tGQ_8TjKVZVuY8ab6SuXcY5ig8-Dt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88526780070; Thu,  2 Apr 2026 09:11:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ae78tHgonjNg
Date: Thu, 02 Apr 2026 09:11:04 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Pranjal Shrivastava" <praan@google.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>
Cc: davem@davemloft.net, "Jakub Kicinski" <kuba@kernel.org>,
 edumazet@google.com, "Paolo Abeni" <pabeni@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Tom Talpey" <tom@talpey.com>, "Olga Kornievskaia" <okorniev@redhat.com>,
 NeilBrown <neil@brown.name>, "Dai Ngo" <dai.ngo@oracle.com>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <791991c2-1e8c-4041-9674-94acb4fe483c@app.fastmail.com>
In-Reply-To: <20260401194501.2269200-3-praan@google.com>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-3-praan@google.com>
Subject: Re: [RFC PATCH 2/4] nfs: add NFS_CAP_P2PDMA and detect transport support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20617-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9CD823898B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 1, 2026, at 3:44 PM, Pranjal Shrivastava wrote:
> The NFS server capabilities bitmask (server->caps) is currently full,
> utilizing all 32 bits of the existing unsigned int. Expand the bitmask
> to 64 bits (u64) to allow for new feature flags.
>
> Introduce a new capability bit, NFS_CAP_P2PDMA, to indicate that the
> local mount is backed by hardware and a transport capable of PCI
> Peer-to-Peer DMA.
>
> Update nfs_server_set_init_caps() to query the underlying SunRPC
> transport for P2PDMA support during the mount process. If the transport
> (e.g., RDMA) signals support, set the NFS_CAP_P2PDMA bit in the mount's
> capabilities. This allows the high-performance Direct I/O path to
> efficiently determine if it should allow P2P memory buffers.

> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index be02bb227741..f177cf098d44 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c

> @@ -725,6 +727,12 @@ void nfs_server_set_init_caps(struct nfs_server *server)
>  		nfs4_server_set_init_caps(server);
>  		break;
>  	}
> +
> +	rcu_read_lock();
> +	xprt = rcu_dereference(server->client->cl_xprt);
> +	if (xprt->ops->supports_p2pdma && xprt->ops->supports_p2pdma(xprt))
> +		server->caps |= NFS_CAP_P2PDMA;
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);

Is the transport even connected when the NFS client does this
test? If it isn't, xprtrdma and the RDMA core have not chosen
an underlying device yet.

Note that, even if this logic /is/ correct, if the transport
connection is lost the transport will reconnect automatically,
doing the RDMA CM dance again and possibly resolving to a
different device. The NFS client layer will be none-the-wiser
and the NFS_CAP_P2PDMA flag setting will be stale at that point,
and quite possibly incorrect if the new connection's device is
not P2P-enabled.

(Basically this is what happens when an RDMA device is removed).

So this detection has to be done as part of xprtrdma's connection
flow, and it needs to set a flag somewhere in the rpc_xprt. The
NFS direct I/O code path then has to look for that flag before
choosing the mechanism/flags it uses for each iov iter.


-- 
Chuck Lever

