Return-Path: <linux-nfs+bounces-20605-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF8eGTaCzWmaeQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20605-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 22:38:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C09380450
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 22:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467B53098FA3
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED481A0B15;
	Wed,  1 Apr 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoykezTB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E34086A;
	Wed,  1 Apr 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075492; cv=none; b=pcFbY/2f4n3gmDEgapRqW+2t3Ec37+Ul5qphh25kravNLAVr3gzLIIW4iB8pZjbgplQOuxaFsb1mL1GcQn4OlHBPb9wWumb/vrb5k5pEf2klFdzsaO41xSDB4dDomCo/Jg5UX2K3S+ihlrqkfX2RDmG5OIhRl9L9x4g9aTFZ8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075492; c=relaxed/simple;
	bh=1gyzumXUdHHUSBY2A1GlVnSPNB8k3coGKrGX5+Ep8EY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JoS/xKwhgNLeClxnMzyasXOWx1+nL0oLiOMyYE2OWS1UTwuOz4Tl9KkdWyv5tTzmDFunTl6WAuw8sY2Tnz6Vvxp/V0E/AFT+kXKgNcoXUlnb1NQUpqJDTGSXI10DModc2mJsRi8MgHLEBVg720bhyjET2WxBRQW4E84JXNDWMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoykezTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C9CC4AF09;
	Wed,  1 Apr 2026 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775075492;
	bh=1gyzumXUdHHUSBY2A1GlVnSPNB8k3coGKrGX5+Ep8EY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JoykezTBKx9PxJEaFidQ8xplDJxV8zvbuzpCX3H8wdLpQE16qdv+xvnH4bhusCDGS
	 s3qdD0zrbxBKCS0iQ24MdXIC24Sv41RldbCubNnhAwoxm6+IqALe34IRPS7tPJzcY4
	 87FekSNiM7GTYja2nd/6NDB6LES/nGdjrR0LodQ99KxbPUggpjhbTG49qsKcW76HD4
	 m0W4LeTy8CEp4lSe9418GE6WsQBmvITbcOSRy4xAN+OMpMLdC4GqlPzzIDgT69yfZV
	 ut3nlpY3Ry2WIpobqLmdpYGa62JVqdfRiIdiuUzz4RhHO9+YURusUwhT8gc+9kOdCC
	 JEKSTr2+0I5sg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A7060F4006E;
	Wed,  1 Apr 2026 16:31:30 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 01 Apr 2026 16:31:30 -0400
X-ME-Sender: <xms:ooDNadKaTbLiW6GvDd5GSD8ia_vcBmEEZs5Ooa__EtMNCdoyPLJayA>
    <xme:ooDNaT9rSlU0ExFUbTVjea0userordYH5FrqwV1n8U-1oifO8mWzhjnW7Mw9Pua6S
    bvYsZZqr59ZvW08b7TrQx8D2HPQOOOv41d_qkrOfRswfh1WgsaBW8jk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghmihhrjeefihhlse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    gthheslhhsthdruggvpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomh
X-ME-Proxy: <xmx:ooDNaeuBF7lZetNQArlmeO1sHh-AQidmal5WE9fOncXgbD7rebrwMg>
    <xmx:ooDNafVFRHNB4TESQsumlHL3edfNwQZpcw-eSCYhXMV3wk3qO4ngKg>
    <xmx:ooDNaWwCky6tSf92zJPm3TxY1ABM03oNrPtYDfM4JE1-XBZl8N_zyA>
    <xmx:ooDNaeF6honZlkS8Yqzaft3_6YOUAMmSK829IGBHljX-0quwzNNCzA>
    <xmx:ooDNaTuxZY6p9zsNonxJ7vSaHgOi4zl_Ll4iNWMOkxvrRGHsMZoIGQw->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 62FCD780076; Wed,  1 Apr 2026 16:31:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwBntrSeBB7R
Date: Wed, 01 Apr 2026 16:31:10 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Christoph Hellwig" <hch@lst.de>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>
Message-Id: <8bef4d4e-1c0d-451d-8854-ed0cba27ee1f@app.fastmail.com>
In-Reply-To: <20260401144059.160746-1-hch@lst.de>
References: <20260401144059.160746-1-hch@lst.de>
Subject: Re: cleanup block-style layouts exports v2
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
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,lst.de,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20605-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C1C09380450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, Apr 1, 2026, at 10:40 AM, Christoph Hellwig wrote:
> Hi all,
>
> this series cleanups the exportfs support for block-style layouts that
> provide direct block device access.  This is preparation for supporting
> exportfs of more than a single device per file system.
>
> Changes since v1:
>  - consity struct exportfs_block_ops
>  - fix spelling
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

Christian, are you OK if I take this series through the NFSD tree?


-- 
Chuck Lever

