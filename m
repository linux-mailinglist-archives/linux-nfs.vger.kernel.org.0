Return-Path: <linux-nfs+bounces-19277-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB0eFHNNoGnvhwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19277-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:41:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49DE1A6CAA
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 377A43051DE0
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A8E261B9B;
	Thu, 26 Feb 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbOLKPL+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03E23AB88
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113216; cv=none; b=XGY4cEXVlDTpWXdy2VmZdFUzMI+gO2tNISdDbQdnEnASt/Zrqsjb7nZYWirSoFNncJTkuxs4ReQzDB02dQjswd4TAkwvhqTkaFQG7fSnH4elQxDJ6BhdwGv/fjdGQyflv/b2zeItfXOHXIKcI24gHWgx6sUkezuS7OFRm7ZOsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113216; c=relaxed/simple;
	bh=KU+pLVUQEic5daDKCJmTHeE2ukp0gjkkeO7IzT+B44Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VqJ3SAKkPIOvovqTBVy/twogNMPE/2UCG73yTSq2LzT5svwOHoP77KduZuKqslXvFFmVv2lM9PJpI2UHxT8qRob4BJ/qgGdh5rCo5ZHjwKCL2hgKgGNnrakFXaqP2nz35Cyp7GF5WLD8UBnyJIqooolu+fHuaxmhLOeY0NpJmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbOLKPL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591CAC116C6;
	Thu, 26 Feb 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113215;
	bh=KU+pLVUQEic5daDKCJmTHeE2ukp0gjkkeO7IzT+B44Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EbOLKPL+fJqC7aIQK6/QmThQWt5i30dsUhzPp0oJ+OavGvXFbNLxTeh5KNc7Mhw/w
	 Kyq8CcGj9keqLzALH7lnZ22S7JWYY3YQWyrQB/3/ChT3Y1aW4neJbF00HajKk2uJFk
	 4oNFSbKOWAL5AkeRhnUu0ZuaqyiR8h9QFvel78UWnCwbcWDK48Sr61jAYO3BEGybfX
	 /SqlxhJ//di+9I7jg/qn+DhAp6Fy4CjVUg2XL4CJsa56+6mxuD3SQHnrgkZp5UloHo
	 L48b94/i32DnE82m/tihxi5tIKPm8uwkO4kLOdPy1z5C1QAtm61tDambc+bTIqRa5T
	 PCwGx2U5u+s7g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 57745F40068;
	Thu, 26 Feb 2026 08:40:14 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 26 Feb 2026 08:40:14 -0500
X-ME-Sender: <xms:Pk2gaZNEbA99bIV0oLqLRQgX6lDBVHY7A9u-q3sv1ISRgcS6rZNcgw>
    <xme:Pk2gaWwYyGOJ3ZdGI3BaRs4Ay3afeu92ViBkuDoCF2AwS0XktPqfI5hHjeiXIDObR
    O_dEU2m7HEdZHm3IwY_RaKefrQ5pLUUBnOzv75A5St0EM1LWdMbaWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiudekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Pk2gaShBkfv9K24DPvH0-Gv884hAChX7JAD6KBuHiX9fRgiW5o6Xig>
    <xmx:Pk2gadDLK9NLJ0bBm52iMcHkBQEVCRoXSFOz6MRKHTmoK_DW1-956Q>
    <xmx:Pk2gaQs2wa7mHRSJ0z4LOwTJ1Wyd7h4uZU2cnJwFGr0rXeYerZ9cnQ>
    <xmx:Pk2gaZfirTvK_NgqSaagwZaoMjIE8QBnD3sk_AuBvpemUVISuQV0fw>
    <xmx:Pk2gad90lPoWqrAB12qc2RFmLWgV92_1ZlVaOfc6WV0JKaI61qPGiy5K>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 30F84780070; Thu, 26 Feb 2026 08:40:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0dCGpBvaPrB
Date: Thu, 26 Feb 2026 08:39:54 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <655f3bd4-9428-4b38-94c6-30f28b181581@app.fastmail.com>
In-Reply-To: <20260225195024.754489-1-dai.ngo@oracle.com>
References: <20260225195024.754489-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v4 1/1] NFSD: move accumulated callback ops to per-net namespace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19277-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid,oracle.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E49DE1A6CAA
X-Rspamd-Action: no action



On Wed, Feb 25, 2026, at 2:49 PM, Dai Ngo wrote:
> Moves the callback RPC program, version, and stats structures from
> global statics into struct nfsd_net so that each network namespace
> gets its own callback counters and program definition.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

The new patch description is rather inferior to the original. Most
importantly, it doesn't explain why this change is necessary, but
instead simply repeats the content of the diff.


-- 
Chuck Lever

