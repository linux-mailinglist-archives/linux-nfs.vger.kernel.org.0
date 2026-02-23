Return-Path: <linux-nfs+bounces-19133-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE87JbdhnGkoFgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19133-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:18:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10602177EA3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1C23009542
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F62701CB;
	Mon, 23 Feb 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdVDyHZB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305926E718
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856307; cv=none; b=qUyRkMEVfLttoeO/8Ekcc7lrC+/UezXQvNTjqPy5jRcGKbR/vVPJ/IWzL6v0ZftCrFDBtnrWs9WTM6/2cLrFi7zm5MLMrkeff2nHsf7IkANd4YJdpGdu2KRQGJVLIhvA9LWf3mwSymZAz969bjXmUNDFdTu6GziM/deEDkVQfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856307; c=relaxed/simple;
	bh=Iq7YisufBOOZrA7aOjV6a1hDbPORQFSutFSx96UaZFk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b4digUJCQdI1Tvaofrjvx/fPenZsDeu6W8kn2zR/e/a72Ny5E9nb4DMYGRY2e1m1iDhKpwxU0wD3gX7luMBk/wB9pL8uoUBZlk/xmpXhnrIL0VECAGZQGa0um9bLNoww4vpdwBcUrEhBmQhNz7GDrrBDAaOIraLAPDiVFZ59itA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdVDyHZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B849DC4AF09;
	Mon, 23 Feb 2026 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771856307;
	bh=Iq7YisufBOOZrA7aOjV6a1hDbPORQFSutFSx96UaZFk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UdVDyHZBCeB9yzgSLmw8ZSsIYc8zzAdW/WaPgDliBJuB89ONtJCRkO8kjA7t43u4O
	 CnPe407SetfNUxbrMeZz5VTYuRrvknkhyYgICoYYiZFR3I9AKEv8q2wYCcJMywysEC
	 1Tr3AXGAs9R0dxwtw5KKNvScRrk99UmKboBibJfK65RINB4jR7D0HegAr0UTjyp0aQ
	 gPgctIX5Hy6GAdIzBwiVsdi8c13ANsm99ddGs4npxWsdHPJcZjfvp1imzNUq2eVYt9
	 secwoCjakmBTzqWgceQ/yqCifobNB7E8pGYj0N1WWbCUPAiLRgSV+VBpCdQHouWcox
	 8uuy+EqfjEMtA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B2866F40068;
	Mon, 23 Feb 2026 09:18:25 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Feb 2026 09:18:25 -0500
X-ME-Sender: <xms:sWGcaUT3bHK5qBJ10v3en4oY2XliUamWRr3drX9elZXpFzIXu4oLnA>
    <xme:sWGcackzy2StCDsn7OvM9mQ1mHpEik2qQ0ql0h9EnBVsA-wQnLkXEEe500H8Tr3v6
    U7IxN3LighFroG3gzPIasCfPIPTSnEU2gghy_NpVV4Po7bKpMla_RE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sWGcaakUwlXzIsh9EXbhrI8CzbWyA5tTA2eA4n8z9JAfQ6Jnl2wNzw>
    <xmx:sWGcab2_5_DOKvaDtnzubJflH-j5url-AUXIdwRi8lcfJCD_oMrBKA>
    <xmx:sWGcafT_apkNU9-y0VQxryu1WnMzkgAPG2Yb_eA-QmNzCcQ3hZttVg>
    <xmx:sWGcacwwLOIqcTYt5l0r4iaEjjJr7igfm01yIYUFxFz7gI9OX60Hyg>
    <xmx:sWGcaXBfe2fTpXIC0_1kd5TTI_FqUeXYdiM5EyL7MdUp7E7T64DtsqpJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9171D780077; Mon, 23 Feb 2026 09:18:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdIdnSnN9OJZ
Date: Mon, 23 Feb 2026 09:18:05 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org
Message-Id: <a38f4c64-f930-4143-9d62-8baa417acd50@app.fastmail.com>
In-Reply-To: <177180401604.8396.3300860214801483447@noble.neil.brown.name>
References: <20260221215733.3643669-1-dai.ngo@oracle.com>
 <177173152164.8396.12929618094338409157@noble.neil.brown.name>
 <687f1398-698b-4646-b9d4-24fbe77d7241@oracle.com>
 <177180401604.8396.3300860214801483447@noble.neil.brown.name>
Subject: Re: [PATCH 1/1] NFSD: Expose callback statistics in /proc/net/rpc/nfsd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19133-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 10602177EA3
X-Rspamd-Action: no action



On Sun, Feb 22, 2026, at 6:46 PM, NeilBrown wrote:
> On Mon, 23 Feb 2026, Dai Ngo wrote:
>> On 2/21/26 7:38 PM, NeilBrown wrote:
>> > On Sun, 22 Feb 2026, Dai Ngo wrote:
>> >> Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
>> >>
>> >> . Add system-wide counters for each callback operation.
>> > Why system-wide rather than per-net-namespace?
>> 
>> These counters are currently embedded in cb_program which is defined
>> globally and not in nfsd_net. Am i using the wrong terminology?
>
> Sorry - I hadn't properly processed that these are existing statistics
> and you are only exporting them.
>
> So I change my comment to: please don't do that.  I don't think it is
> appropriate to export global statistics.  We should only export
> per-net-namespace statistics.
>
> So place convert the statistics collect to per-net-namespace, then
> export them.

+1


-- 
Chuck Lever

