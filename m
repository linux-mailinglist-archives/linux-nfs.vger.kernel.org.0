Return-Path: <linux-nfs+bounces-17569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FCFCFE8DB
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B0E23089610
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3E376BE4;
	Wed,  7 Jan 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd5NVeVc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53A376BE2
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799106; cv=none; b=FGAQW2q29/Inzco/XZAq6TnL1RDy36qFE+ZuQFL2NrKED8OOdcS8dYJTleNY5Rk848JYOA4oJ5Ow48BpFWi0SPTeNlmKuLC+I5PQ76liA9qrBgJ+DfxZpZFnW2syJVpdj5wMckcBTZyZKxevkq7vuODBPaiyw30weziO1MeQdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799106; c=relaxed/simple;
	bh=NrBCNmNdGbigwTOQ3lWrohk2DdXWhhFBrA46fhHZLHc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PZvA5N2f3v+eQKsqgNlw35HDue/uW9+m46g+CGM7/LCF6HGtewRVM101/SabM2SaSRWgCO2fdJY0kxz4pKdnS8tIIlOk5hDcYsDYrhf85ENabzLTFzquvRXI89vCuHLN7WALDVDYO/vbhgQomt8ekJ8eLfDqum/nRrSNlj0/z8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd5NVeVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B1FC4CEF7;
	Wed,  7 Jan 2026 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767799105;
	bh=NrBCNmNdGbigwTOQ3lWrohk2DdXWhhFBrA46fhHZLHc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Pd5NVeVcFURjAxcn6T3DlJTIVAn5xQ2osrF5fkL763oOV8xKeVjIVOJkCsQTLIPdw
	 mWp3RJ+Trh1C8Tu493VbfCxMnaIin46U8RAk+zR5ibzY53lexwHiGYPTGTfqy1M5vc
	 4srfz9DTPMiW7zTjBl2vDgfTEMOO6tcWPig8imvl1dXBslkH1LGqwNXGtGzrpuZN6R
	 32P3ayUfBhJr/1E1Wedk/w1tKEF/48RnFBb75SwhGxJgtxXpya4HXVkWGPigy7uGWR
	 Im9w23YLGbkGsDTupW2s8NvxD35LjzaaRqWEphdHMcPR339ehOerU+7OGsejdVWMvN
	 Udej8AXjoz2xw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 978FBF4006A;
	Wed,  7 Jan 2026 10:18:24 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 07 Jan 2026 10:18:24 -0500
X-ME-Sender: <xms:QHleaRvIHtp8rfQRoM8jucO1fkuN4nn1xde1WU8y3pciTm9oKyjSNw>
    <xme:QHleaVRJVkVyQTguIEuhEdeLyIjNs646nWfHr82iuXW8d0N5Jo4Z-jEbN_FrcCX70
    Bx823uYtU86ME7D4SpFrkHsdPsjekPzkfpom_knO1dnRYYhHgmqF97A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgumhihse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthho
    pehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QHleaZWz6xlvl7aYbcCjVQjUsnu-k8qRnbBydAXxKwc9eN9-lFrIxA>
    <xmx:QHleaXZiL2nZ4khBvwWEkJTe_nMk-KkH1dn7fp6DrH-Q2ByhqkfVkQ>
    <xmx:QHleaf0lrCGHnykLzxgwGCSGHzJPx3uDdSktZWhVgbL4mQictWjQSA>
    <xmx:QHleaZjIP7r_7qPj9J3LYxLmYp5aoxJYSRe3ZmmTR1hezbgWPZovSw>
    <xmx:QHleaTYMbN9Pc88q0Slx0P6GmLlmtrOg1cRvC3r16fxGyOluPuZMsIfm>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D6AC780054; Wed,  7 Jan 2026 10:18:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASCMS0S-oO03
Date: Wed, 07 Jan 2026 10:18:04 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
In-Reply-To: <20260107072720.1744129-1-hch@lst.de>
References: <20260107072720.1744129-1-hch@lst.de>
Subject: Re: add a LRU for delegations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Jan 7, 2026, at 2:26 AM, Christoph Hellwig wrote:
> Hi all,
>
> currently the NFS client is rather inefficient at managing delegations
> not associated with an open file.  If the number of delegations is above
> the watermark, the delegation for a free file is immediately returned,
> even if delegations that were unused for much longer would be available.
> Also the periodic freeing marks delegations as not referenced for return,
> even if the file was open and thus force the return on close.
>
> This series reworks the code to introduce an LRU and return the least
> used delegations instead.

I'm curious if you tried other methodologies like LFU to decide which
delegation to return?


> For a workload simulating repeated runs of a python program importing a
> lot of modules, this leads to a 97% reduction of on-the-wire operations,
> and ~40% speedup even for a fast local NFS server.  A reproducer script
> is attached.

-- 
Chuck Lever

