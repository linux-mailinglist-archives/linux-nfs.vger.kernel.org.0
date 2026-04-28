Return-Path: <linux-nfs+bounces-21254-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGMfEqLC8GmmYQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21254-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:22:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E362C486D71
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9EE93070AF0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B3429823;
	Tue, 28 Apr 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYsRQCha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D16428847
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384626; cv=none; b=kIBgUTa6ob5H4hh7IY/m4uTZOWeiV4sQdao4OWOBzdNqEwDfq58gXtkgJw3maih9mf73ZpXXH0NszXGRtmsccFJdc19XgE71jDqVPwLGwLHBttMoquzw0SyuGBaEmiSzI9aiVk4M6CsHwZSkVfSvnsTL0PW3/J84yGOWfwFBKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384626; c=relaxed/simple;
	bh=SGXglodLyOYc6bmxluvfe7QcqLdPyV5krEqTGnf0ius=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ObbenmExWmfcvqHh5y+XfpGrXdI+fue4Y66enXBa6XgWLPagbVKFdynCdQ0t3VC47iTsh4UeONCuallF3fN++DkemNxMbt/7GdpgcVvlmXuKKii/auKgQkm6oCmk6GBFTfQb78jD5OuQQSaPnX0RBAf4RBo4D6bdDJzrIt2W9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYsRQCha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52254C2BCAF;
	Tue, 28 Apr 2026 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777384625;
	bh=SGXglodLyOYc6bmxluvfe7QcqLdPyV5krEqTGnf0ius=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DYsRQChat1g99sVTgQDrrUtgZ5fJqkED/Ea83TXVJuflK0OdlvHnh7+qdXgFcVwv7
	 jTrex26rIyYbytLA3Qwuey9QSpptoWNqRBwadV93/FlMeTdhJUj3fwu9qKYG8X/3+b
	 /k0vIt0eelyDIrGZhb3MD+1I3dRLsDBVM9+NpToho+HlPjYwtKtlIHiDCLxUQKTtoI
	 VqS3cl8sfxdk5bDPgn71vPtRNOdVJb1YFrUjpJk0L1XVtWLBiKc2sW1kxsgpDvqXCp
	 NiMKdwfP8nEBAyPoNiOGlKo7KqRQbd4QNO74ikpJX8WEkDC5OhWzq/uwLJDvC+5omN
	 Qn1aGXG5SMrGQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 47788F4006A;
	Tue, 28 Apr 2026 09:57:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 28 Apr 2026 09:57:04 -0400
X-ME-Sender: <xms:sLzwaZskqAVpsA80npEJQmsxJ7AoxafWjrpw7mOhFWijMrTRueppaQ>
    <xme:sLzwadSr7X0bVEDw5RWGMn5qexpNhiwQ_z2olz-Wv8Q4TkyyyZsnVYqs9PSjvtdiA
    vAWaKopyAHm9GOqUck3OH-MTXGx5Q-k_zOhHMEOACEo3o6GUIB4t9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epiedtheekvdejkeekfeetgedtfedvudfggeejudehgfffudfffeefkeejvdelfeefnecu
    ffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqud
    eifeegleelleehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrlhgvshhsrghnughroh
    driigrnhhnihekjeesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhiht
    ohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sLzwaXg5Kt4QsTM9PFgTvzVHX1yhCfPrNpRobVEC0lF8HnbDmdz50Q>
    <xmx:sLzwaVbfVvTjgJP5nOTJUVjELawDMJkX492Uk-SM1O4_CXEl4pkuOQ>
    <xmx:sLzwaQUboyiQ_1mUZXeAgKHmFe3Sz_M8bdL8O0dMXDuynuViQigvtQ>
    <xmx:sLzwaci1SxosdhNBM7inngdXElKmgcMPJQzibYIuVT_SlNmwypnnBg>
    <xmx:sLzwabkflFEbeep_6wtO8PHZIFxA25ho_Lw86oKojzL4JnXsxdDtiaBz>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 205E2780070; Tue, 28 Apr 2026 09:57:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARdQguB5z6r-
Date: Tue, 28 Apr 2026 09:56:42 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Alessandro Zanni" <alessandro.zanni87@gmail.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 davem@davemloft.net, edumazet@google.com, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Message-Id: <f13ad5ba-1b1e-4bf9-8acb-07b5530e1da5@app.fastmail.com>
In-Reply-To: <20260428134230.136533-1-alessandro.zanni87@gmail.com>
References: <20260428134230.136533-1-alessandro.zanni87@gmail.com>
Subject: Re: [PATCH] net: sunrpc: fix slab-out-of-bounds read in cache_seq_start_rcu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E362C486D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21254-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,60cfa08822470bbebe44];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]



On Tue, Apr 28, 2026, at 9:42 AM, Alessandro Zanni wrote:
> Syzbot reported slab-out-of-bounds read in cache_seq_start_rcu().
>
> The issue happens in function __cache_seq_start() when is invoked
> hlist_for_each_entry_rcu() and the hash value is greater than the
> hash_size.
>
> This fix verifies that the hash index is within the hash_size value
> before dereferencing the hash table: if the hash index is out of
> bounds return NULL, otherwise access the value.
>
> Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection 
> rather than the r/w spinlock")
> Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  net/sunrpc/cache.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 7081c1214e6c..aac5f03112f5 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1348,6 +1348,9 @@ static void *__cache_seq_start(struct seq_file 
> *m, loff_t *pos)
>  	hash = n >> 32;
>  	entry = n & ((1LL<<32) - 1);
> 
> +	if (hash >= cd->hash_size)
> +		return NULL;
> +
>  	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
>  		if (!entry--)
>  			return ch;
> -- 
> 2.47.3

Thank you for the patch! We have this fixed in the nfsd-testing
tree already:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=72fe9e528c68aa7b9ed5afab98c44f8b83bbe287


-- 
Chuck Lever

