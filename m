Return-Path: <linux-nfs+bounces-20842-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jIxuN7mq3mn5HAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20842-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 22:59:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1423FE7AE
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 972A13012853
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E386373BF4;
	Tue, 14 Apr 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNn2HAas"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA7372683
	for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200374; cv=none; b=mmplbwVeMrbBk3VPOS6DGlo2asE+1nGdVRsW+P8CWqUwfB4ecJjWd/LSYyMIyd7+I3j3YtZjFsQRLY9wV/d8J4CCVvK33/xd6bEkGcd5S8dmoDdsZGlRRnI8xTHOsRRE3jkHU2N4d0uOmPvuT4ekOQGkMzVCGvDQx80tZdZtpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200374; c=relaxed/simple;
	bh=woELsCWIavG+zYwPWlcvGt1EMynkWbGpyDdbCTa3pH8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X27wq2ahUYX6lhHQ6B0/jlDb3zcoc38u21FyKQYrtiGOARw/aHnvW+N8RIiykViOEVJtvtpzg90NR03k2tFnwGsyAHZDjUkGEvfWng3hMrX8jtSLoeN3vDoIzYaki1qEvMuaOq7UczlcgNmtV4c5qmCOWDIBe5jKdhnFVkCFRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNn2HAas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BA4C4AF09;
	Tue, 14 Apr 2026 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776200374;
	bh=woELsCWIavG+zYwPWlcvGt1EMynkWbGpyDdbCTa3pH8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZNn2HAasleWluz9X45ZuX14k/BJd0/DTwmzol8+veeJlR0bcDAzYPi6Lq5MmoRtN3
	 /veEABlh23kd9FNA0EDqoRigHWxqcUgmYPPBxdi7+RuNxaZAsQ5fGKiUxuqzUQM6XK
	 FDpcb6EonBqGbwYUDAj/bYxnG3Q0Li6GcGhk+DH5hf8BhFg2wM5TSdMAXmxSc7U5yL
	 lxq2p3q8LD2/qf1Hclj2sKVOV5cMy4cy7m1+mGyAyYXYWh95MnrlFlL0ctuwPkvbQX
	 8zKMQWMDf6JkcVCtZVX7YA78URVv6nIw7uN3TXJ2nSPQlc3CBEcBj9mlYpwCdZUSw+
	 KkoYkFmENNPow==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6E01F4006A;
	Tue, 14 Apr 2026 16:59:32 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 14 Apr 2026 16:59:32 -0400
X-ME-Sender: <xms:tKreaXG2fDnu85djWPhKvdnVsL_ujV1r1jVUpnBJvtp3h70SKLvckw>
    <xme:tKreafIHvo_EIZum5zoVjMuM4wJYvbgezfZHGvsd88VkOnHBqExrMR4KKr49KMZFM
    Zq_RWLC5tmK_-4KaBUYQkskbWKz2f3BcIGw2ZM59xsyRgrsFcN22VIa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehprhgrrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    htrhhonhgurdhmhihklhgvsghushhtsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghp
    thhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:tKreabA2ACiPI5f8t_Bv6M8X7eBTIK7mQcr1DLbl_b8cNEq9ei2cGA>
    <xmx:tKreaQ-N4F7PZvwPchQ2cUZj3cxEIM1wQjCCDpU4V4a0ya_9Uy0T_w>
    <xmx:tKreaXqOVsSb4pzeuP_W3ZdLMZPPNk8emS9I8Lv45XjzLy9gkN86LA>
    <xmx:tKreaSG5_rRI8k7NfGYyFNK8bT5OtR1_irCfn7L7BYbdVSh8qK444Q>
    <xmx:tKreaT_pF5Q9MWmboGb54PVrNlqPrVVxcQrWF47KJpj4G2p57edgVQ0g>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8628B780070; Tue, 14 Apr 2026 16:59:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ae78tHgonjNg
Date: Tue, 14 Apr 2026 13:59:12 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Pranjal Shrivastava" <praan@google.com>
Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, davem@davemloft.net,
 "Jakub Kicinski" <kuba@kernel.org>, edumazet@google.com,
 "Paolo Abeni" <pabeni@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Tom Talpey" <tom@talpey.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, NeilBrown <neil@brown.name>,
 "Dai Ngo" <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org
Message-Id: <510c6806-66f6-41b6-bf94-957bc68d31b7@app.fastmail.com>
In-Reply-To: <ad6bkyA1ItA8ou9i@google.com>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-3-praan@google.com>
 <791991c2-1e8c-4041-9674-94acb4fe483c@app.fastmail.com>
 <ad6bkyA1ItA8ou9i@google.com>
Subject: Re: [RFC PATCH 2/4] nfs: add NFS_CAP_P2PDMA and detect transport support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20842-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F1423FE7AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Apr 14, 2026, at 12:54 PM, Pranjal Shrivastava wrote:
> On Thu, Apr 02, 2026 at 09:11:04AM -0400, Chuck Lever wrote:
>> 
>> On Wed, Apr 1, 2026, at 3:44 PM, Pranjal Shrivastava wrote:
>> > The NFS server capabilities bitmask (server->caps) is currently full,
>> > utilizing all 32 bits of the existing unsigned int. Expand the bitmask
>> > to 64 bits (u64) to allow for new feature flags.
>> >
>> > Introduce a new capability bit, NFS_CAP_P2PDMA, to indicate that the
>> > local mount is backed by hardware and a transport capable of PCI
>> > Peer-to-Peer DMA.
>> >
>> > Update nfs_server_set_init_caps() to query the underlying SunRPC
>> > transport for P2PDMA support during the mount process. If the transport
>> > (e.g., RDMA) signals support, set the NFS_CAP_P2PDMA bit in the mount's
>> > capabilities. This allows the high-performance Direct I/O path to
>> > efficiently determine if it should allow P2P memory buffers.
>> 
>> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>> > index be02bb227741..f177cf098d44 100644
>> > --- a/fs/nfs/client.c
>> > +++ b/fs/nfs/client.c
>> 
>> > @@ -725,6 +727,12 @@ void nfs_server_set_init_caps(struct nfs_server *server)
>> >  		nfs4_server_set_init_caps(server);
>> >  		break;
>> >  	}
>> > +
>> > +	rcu_read_lock();
>> > +	xprt = rcu_dereference(server->client->cl_xprt);
>> > +	if (xprt->ops->supports_p2pdma && xprt->ops->supports_p2pdma(xprt))
>> > +		server->caps |= NFS_CAP_P2PDMA;
>> > +	rcu_read_unlock();
>> >  }
>> >  EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
>> 
>> Is the transport even connected when the NFS client does this
>> test? If it isn't, xprtrdma and the RDMA core have not chosen
>> an underlying device yet.
>> 
>> Note that, even if this logic /is/ correct, if the transport
>> connection is lost the transport will reconnect automatically,
>> doing the RDMA CM dance again and possibly resolving to a
>> different device. The NFS client layer will be none-the-wiser
>> and the NFS_CAP_P2PDMA flag setting will be stale at that point,
>> and quite possibly incorrect if the new connection's device is
>> not P2P-enabled.
>> 
>> (Basically this is what happens when an RDMA device is removed).
>> 
>> So this detection has to be done as part of xprtrdma's connection
>> flow, and it needs to set a flag somewhere in the rpc_xprt. The
>> NFS direct I/O code path then has to look for that flag before
>> choosing the mechanism/flags it uses for each iov iter.
>> 
>
> Ack. I agree, so should we start with an inital cap and then update it 
> in the event of a transport change / disconnect? Or shall we populate 
> the cap only when a transport is connected?

IMO this flag does not belong in the NFS server CAPS, as it is a
capability associated with each RPC transport. How should
NFS_CAP_P2PDMA be set if there are two RPC transports, one with
P2PDMA enabled and with it disabled? (Perhaps it should be a flag
in the transport switch instance rather than the transport instance).

Which mechanism to use has to be re-decided every time a dreq is
scheduled because the xprt can change between an original send
and a retransmission (if, say, the COMMIT verifier changes due to
a server reboot).

Trond and Anna will have the final say about how this works.


-- 
Chuck Lever

