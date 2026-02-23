Return-Path: <linux-nfs+bounces-19135-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNWUJShonGmsFwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19135-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:46:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73A17836D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D53305B08C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB134D391;
	Mon, 23 Feb 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtHtCQpU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D21346AF0
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857854; cv=none; b=QL8GACcMoxl1a6dk4k1JN9DQTT1r8nb57t6BBncFSX97pQv+Ncvav7AeBWpYmKZdNBeKYGyL2PJdSDvH251lbHHde7p4DXo7uGZVjq9DyqG8TbZDQnO1GOIRk9x1feKCO8zWBmkIWsUoCsAtASnqB6qAERYwZDNjXum/AUlVL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857854; c=relaxed/simple;
	bh=DyZkrXqO+K00P93aTzYQYoBgQTBB7ntcRbBm1uhvF78=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NfpfZEikLu2KPwFmKXEoElr8Y9khF2Ihk7+zLowXLXpC+yo6UjCxFcZ0aezH4sGwJmgtxRx4Mz23efKuksBNPzhACSVRgi8jJTg0UiIB3awy/f8vFFnmJZk/6wnx2QlpRRE80IS2cLIEkb4cPeWpCqYByPyvdzldMGhCPHrzjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtHtCQpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34226C116C6;
	Mon, 23 Feb 2026 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771857854;
	bh=DyZkrXqO+K00P93aTzYQYoBgQTBB7ntcRbBm1uhvF78=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QtHtCQpURk4MQ3HL4TyRzmmMauYZCEyeyVOomZkX7Zb2OMvJPQ3BkiqBPLNmHjG7L
	 MwUWKHptqs3oL1TAwty/FpJyO8Nn1nt3VwxWkLJKJoAgyX7wxcKSPGffCqVGt0mRO0
	 jT0e8aQkm6AbNlQL3LzdVpaohJE5MDMbugBz8uVuKEgVU69c40ERbrRjoPTKG8a4bm
	 UlHwNQHbQrUwi/No3UUJCkBPlQuj4uyyB12ZJVYuhwRd47yEylXY3aWha1XT2DQbR+
	 dJMnNsSB2249YSRpsGMNNHKiGyvwlvDIXgfpdb/QP/yNQ+Xel7/fGBF3VfmqAjMgSF
	 fB4x9plnwfIrQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 24731F40068;
	Mon, 23 Feb 2026 09:44:13 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Feb 2026 09:44:13 -0500
X-ME-Sender: <xms:vWecaVZ65H3P8FRI18i4TLg6tmmCxuLvb_tXMRd4D0RyGas8FFAHqA>
    <xme:vWecaXMuCBdSj3RaRIBdRGhpkL9eVIFMTUImkXYNybV91Z3LZvZWrajgfI73E3tzp
    wb39bJt_6EfZlqvuqZ_SvunGKLglImX7lgER-24a4n8pURk3k9tjGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vWecafQrdsCjY0cWsKVSy_Dvl12wz4ZEJQ_T3nATC7U-WKUwphwl6A>
    <xmx:vWecaRddbcmivP7PYqKrwbdSuaR-QoDuQSqvRA61sCfdtkQes06TKA>
    <xmx:vWecaTAhHBB_VEmcOGmxmgRmQn8roYveDKkffp8fvYCwxcJFGWapsg>
    <xmx:vWecaTmhWKywjy615LkYvLwTEkn0yGz5ONisWypv0L7wMqTHQ9yZ-Q>
    <xmx:vWecaec2_IR-Rmou11TdsaeXEsKNiNnjHuMlXGYNV8VgIhiv1tZn2AML>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED5A9780078; Mon, 23 Feb 2026 09:44:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgEhKVKDMhLN
Date: Mon, 23 Feb 2026 09:43:34 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <c707ce06-3771-4339-b107-c22f1f9d04ea@app.fastmail.com>
In-Reply-To: <177180571733.8396.6283139237611600966@noble.neil.brown.name>
References: <20260222162002.10613-1-cel@kernel.org>
 <20260222162002.10613-3-cel@kernel.org>
 <177180571733.8396.6283139237611600966@noble.neil.brown.name>
Subject: Re: [RFC PATCH 2/6] sunrpc: Allocate a separate Reply page array
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19135-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE73A17836D
X-Rspamd-Action: no action



On Sun, Feb 22, 2026, at 7:15 PM, NeilBrown wrote:
> On Mon, 23 Feb 2026, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> struct svc_rqst uses a single dynamically-allocated page array
>> (rq_pages) for both the incoming RPC Call message and the
>> outgoing RPC Reply message. rq_respages is a sliding pointer
>> into rq_pages that each transport receive path must compute
>> based on how many pages the Call consumed. This boundary
>> tracking is a source of confusion and bugs, and prevents an
>> RPC transaction from having both a large Call and a large
>> Reply simultaneously.
>> 
>> Allocate rq_respages as its own page array, eliminating the
>> boundary arithmetic. This decouples Call and Reply buffer
>> lifetimes, following the precedent set by rq_bvec (a separate
>> dynamically-allocated array for I/O vectors).
>> 
>> rq_next_page is initialized in svc_alloc_arg() and
>> svc_process() during Reply construction, and in
>> svc_rdma_recvfrom() as a precaution on error paths.
>> Transport receive paths no longer compute it from the
>> Call size.
>
> I do like that you have split the one array in two - it is certainly
> conceptually cleaner.
>
> I don't like that you now allocate twice as many pages.  This could have
> a significant impact on a smaller server, and should at least be
> highlighted in the commit description.

The number of pages nailed down by NFSD is directly controlled by the
number of nfsd threads. So on small-memory servers, run fewer threads.
We have a dynamic thread count facility now, which keeps the number
of threads minimal on an idle server.

For 16 threads and 1MB maximum payload size, that's an extra 16MB of
nailed memory. That might have been a lot of memory to nail down on
typical systems 25 years ago, but these days, I don't think it's that
significant and it's entirely under the control of the NFSD
administrator.


> For NFSv3, this is complete waste.

Perhaps, but I don't see a way around that. nfsd threads are
fungible: they are called upon to handle all NFS versions, and
thus have to be prepared to deal with either NFSv3 or NFSv4
requests.


> For NFSv4 we do have the option is returning NFS4ERR_RESOURCE for ops
> that we cannot reply to.

NFS4ERR_RESOURCE is NFSv4.0-only. NFSv4.1 and above advertise their
maximum message sizes via CREATE_SESSION, and currently those numbers
are a lie.


> So could we allocate reply pages on demand, either stealing them from
> the end of the request buffer, to using kmalloc when request buffer has
> no spare?

The most pernicious cost of the second array is the CPU time spent
repopulating it, and subsequent patches in this series deal with that.

If NFSD starts stealing pages out of rq_pages for building the reply,
then alloc_bulk_pages() will have to walk the entire array to ensure
all pages are filled, and that's something I'd like to avoid.

As far as allocating pages on demand, there is a cost to that as
well (in terms of contention with other memory allocators) that I
want to keep out of the I/O paths.


-- 
Chuck Lever

