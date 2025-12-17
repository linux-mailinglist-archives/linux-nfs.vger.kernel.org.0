Return-Path: <linux-nfs+bounces-17142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95742CC8059
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B56301B83E
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98BC382571;
	Wed, 17 Dec 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfQL47iO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E633FE1F
	for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979697; cv=none; b=jQbNMU2laonitFQ6tdh8EYB8FaiFaSB16Ys5Jkl1dzdXAAkdBJJJ9zppwAY1L1d6OTnJ8A2jkgVtFd95jcyHo8qnJSu/rJEmPyh+MRo1PASB1S9pzaWeErMNK1qJ+1S8GaGhdhyLYR/Tyqa2WB+AoyTbjV1aWCSTX4QquIYu1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979697; c=relaxed/simple;
	bh=7JnpqBw2FzbOcuSlP94ehTtdCg8zztBauQKdUcXh4fM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c+RTu6uJy/BPlcz/BgUnve7NbLGi2MugnAxLeHmfFXWwPyfi17R90+73+SchHsKEtVod30usju9xDDNdLKa2g2QrHGwirSwtzc6nRtigp+ok6G+BO2M0BWLnWCJx/wyPGz2uE5Ua5CNaBdzYsxkutFuBxnpBOk8hVYQM46OglU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfQL47iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF2C4CEF5
	for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765979697;
	bh=7JnpqBw2FzbOcuSlP94ehTtdCg8zztBauQKdUcXh4fM=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=IfQL47iOb2kQRJF4/8EeiKb+nIqF7TNpiE27BiE0gTXL099EyTaA2Qx5LNP+TEBEc
	 MJLPJl1H0jAieWeWCkUR9RmAL4jlAtXZ3yXPNyCGpbyA4YTLykRVIBwOxXHyN1VQSr
	 woOOII94yE4Z8+sfX73X/CPT72hmq8NfxyrN7qmp5MGu2m1LbapGqehVUXSQeX3WSP
	 Ksl8zzRQBYYzT0nrqQXlvwxFqwT7N/VmoFSBKzQsOzaBEv0VChCkoNvGYfpaadqoKt
	 I6pqXcqQN3aRFBdYXA8l1ETaZAi5eYqpCVdrrc4WehMypqsXRLy6Jkdgm2y86bl9/w
	 igUUt772Rxb0A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49463F4006F;
	Wed, 17 Dec 2025 08:54:56 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 17 Dec 2025 08:54:56 -0500
X-ME-Sender: <xms:MLZCaRRpPS-W7u4va5fqZonu-u1Htny2o99t--0kcBz7eYJ1Zl9bRQ>
    <xme:MLZCaVmJjFsvn2x_Nnaf_vh4-PmzD1sRGuX2_K7ARM901MjWXAGnlPovTDNCgQ8eR
    C1ZdxT2ULOaj59qBIDMXE05OokXUxSwIfr7g7uHT_bDgxSt_0oylMPH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehheejleegffffiefhudduvedugefhheehfefhgfeuleeuudefteejudfhudekleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MLZCaT89xJE_gDLIcwcWJq0cyjjIPrVv5aghiGGd52i5F3g4EBz_jQ>
    <xmx:MLZCadr2gp-uWZZ8PyqvT66tUrhVQBodXwtdkgcd-edkHlCIlGrKuA>
    <xmx:MLZCaYl0SRuG5Eg7u48H5kTh9JLzDQFJ5EzmMOVeqO4bg_j0arXwAw>
    <xmx:MLZCacKf3XYueaktbuI8D8DsXB6LHDBgsQMlB9a4KyrE8jE-_Woiog>
    <xmx:MLZCaVwEUhi7UMXGbEL6fXgzIPZou-LszYbyDUtb64mC0EIH6ojbxmK3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2B63778006C; Wed, 17 Dec 2025 08:54:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArbxL3zBnRlc
Date: Wed, 17 Dec 2025 08:54:36 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <cafae1f3-def3-4b64-ae1e-9d4714d91b5c@app.fastmail.com>
In-Reply-To: <aUHcjxer3GmVcBwG@kernel.org>
References: <aUHcjxer3GmVcBwG@kernel.org>
Subject: Re: xdr_stream interface oddities with pages vs stream
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 16, 2025, at 5:26 PM, Mike Snitzer wrote:
> Hi,
>
> I've been working on enhancing the NFS client and server such that
> nfs4_{set,set}acl utilities to set/get 4.0 ACLs will work when NFSD
> v4.1 is reexporting NFS v4.2.  Its soul sucking, but that aside...
>
> In my journey I'm finding that xdr_stream_decode_u32() followed by
> xdr_stream_subsegment() doesn't continue from the point where
> xdr_stream_decode_u32() advanced xdr_stream's ->p
>
> xdr_stream_subsegment() doesn't appear in any way interlocked with the
> pages offset (->p), it starts with xdr_stream_pos() but  ends with
> advancing ->p.  So xdr_stream_subsegment() does what it should, I'm
> concerned about interfaces like xdr_stream_decode_u32() not advancing
> xdr->nwords
>
> Shouldn't both the xdr->p and xdr->nwords be interlocked?  SO that
> xdr_stream_subsegment() continues from the point where
> xdr_stream_decode_u32() advanced the stream?

From the wasteland that is my memory... I think only one side
uses nwords, and I'm betting it's the encode side. These aren't
exactly symmetrical APIs, and the differences can be subtle.


> Could this possibly be a regression due to more recent scratch buffer
> changes?
>
> Anyway.. I'm stabbing/fishing here and hoping someone else knows how
> things _should_ work.
>
> Thanks,
> Mike
>
> ps. I can expound on what I'm seeing, I just don't want to bury people
> right out of the gate ;)

-- 
Chuck Lever

