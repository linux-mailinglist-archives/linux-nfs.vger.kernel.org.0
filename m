Return-Path: <linux-nfs+bounces-20551-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGhcEicHzGn+NQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20551-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:40:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B741536F1E8
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5D330120D4
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442A426D20;
	Tue, 31 Mar 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npOwmaPz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F33E51DF
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978493; cv=none; b=UzoOQDEO7H/+sPl/z55ErR0X74MIolAj3b8hOC3xvlrqyuqzINHAZy5gmqLBZbgQDw4UDwS7XYOfTSp5R2acgFGaHI6uAU8RmanJwjCHeGF+Z1Bp4c0q1mQdAFGnflpCpelLQ2zKShGNu+09eTL84/FxRtwQdl9xOkPNzZTWmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978493; c=relaxed/simple;
	bh=tPN9EEmFF/RJsDgPySUY9wOXPGZf+BF1CpAnuz8jQ+U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PgW5/T7VNeBVNLqncBYOatPtV4uOG4TSNLsI/wp/HU82jexNp3knp1o2cZ9AhAaSaT6ep/RzSqS3SHgvj9Bk2+dan+qSS92TeIHqQkrHZR6mGZ/9RaDQWrAibmkfrgcaDze1Gkx5rQ33+avBbcvfEqPk+uf8EQKrJieVyju6JIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npOwmaPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D8BC19423;
	Tue, 31 Mar 2026 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978492;
	bh=tPN9EEmFF/RJsDgPySUY9wOXPGZf+BF1CpAnuz8jQ+U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=npOwmaPzrqqBZ784mgmnIZxdb4uOCzONVy4FzunvvOdd0ABPff77H6Q0HxIlXXTgj
	 /Z2m43rDgX668dVgCRPj1HVtGAu94n2bYerGiZe9ygRL+Yt1TcGw66pL6Ycn6qhcyH
	 V3FAbJKEsxm0DV0Gr9qsdhgKxbf7VggDlyaEaGp6KMLWHa7aCg4qihbr5uRTLT53+b
	 dNxaB0992zWvYnghbvdNX71dnBeOq2hPEPmkIh/+6y8HdDzT94jBxkSHe2zudCbRCP
	 7qraBaXafeS95PX44bi1boagv853KZWJNUa5BXrtNknOWIty4c4adOgVfBGvxzMCcg
	 0xxlXwD48iuMg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 75F97F40074;
	Tue, 31 Mar 2026 13:34:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 31 Mar 2026 13:34:51 -0400
X-ME-Sender: <xms:uwXMaVjJHM1EraKm390D0nnX0bt0pngUZ8MBUu5fR5aq79RDugmFZA>
    <xme:uwXMaU2e1fq8lVAIMuS9B6piyeItcBiF64F0HCENjzLUeEDefY80s5BI_0KVRdrd_
    CmC62EVG8bg598K-GLvQ5XXGziHxRNLk7ejLxlywSdhUAM5zaBdEXAa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegurghirdhnghhosehorh
    grtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uwXMaXMUDnQ86qqtSuUM5ZZJpB44m9dhp7ezgEZx4lWAxad4kEDC_Q>
    <xmx:uwXMaX9-ZH3u2sm7D3nCmu-xarcnSxIt5lzO0fvVGgcWPrTxu2HZuQ>
    <xmx:uwXMaRFfRADObcusYF-L1xZDzvBSHpYnaUuIJLCahM7as6pTIC__Kg>
    <xmx:uwXMaejQo64bvnu-gPomFaIRqSgoHeQrLVx4XmErc53gk1gNeiWPEQ>
    <xmx:uwXMaesky9hw4IgFmZ1M4qcANmWUKcqPI_z2hPU8JB03LoICrA6hZn3K>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52F85780070; Tue, 31 Mar 2026 13:34:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoFadv7LPD5F
Date: Tue, 31 Mar 2026 13:33:11 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>
Message-Id: <df21ae49-c763-43d6-bdb2-c492f349a6cb@app.fastmail.com>
In-Reply-To: <20260331153406.4049290-1-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
Subject: Re: cleanup block-style layouts exports
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20551-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B741536F1E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Mar 31, 2026, at 11:33 AM, Christoph Hellwig wrote:
> Hi all,
>
> this series cleanups the exportfs support for block-style layouts that
> provide direct block device access.  This is preparation for supporting
> exportfs of more than a single device per file system.
>
> Changes since the multi-device export series:
>  - check for NULL bops in nfsd4_setup_layout_type
>  - clearly document why we are ignoring loca_time_modify
>
> Diffstat:
>  MAINTAINERS                    |    2 
>  fs/nfsd/blocklayout.c          |   37 +++++++----------
>  fs/nfsd/export.c               |    3 -
>  fs/nfsd/nfs4layouts.c          |   29 +++----------
>  fs/xfs/xfs_export.c            |    4 -
>  fs/xfs/xfs_pnfs.c              |   44 ++++++++++++++------
>  fs/xfs/xfs_pnfs.h              |   11 ++---
>  include/linux/exportfs.h       |   25 +++--------
>  include/linux/exportfs_block.h |   88 +++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 162 insertions(+), 81 deletions(-)

How do you see this getting merged? Do you want all of these
patches to go through the NFS tree? Or do you want this to
go through VFS?


-- 
Chuck Lever

