Return-Path: <linux-nfs+bounces-17824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3CD1BD4C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 01:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35521301A72B
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 00:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D01F03DE;
	Wed, 14 Jan 2026 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTfctO4y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FE1E1DEC
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351328; cv=none; b=uHL8XwCfb0BLDE/UG8ZUG1twjShA6lEq3eQP+5YXI88DRQcAjxJN5/9CdqMBYXNBNzvl7Iw3sESE5/UaTYjA94hiOThbN9AFaU7xK7M8a3wnBR/Bmapk0DOMVsKOU8Tzm0b9yij+oq2qYZiv7BSJPHDS5J+TEXeR/FIWEutjRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351328; c=relaxed/simple;
	bh=6PBGzWcjHfB59rDry7UMAz06odaS0vgJsxOZEe99WdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulHb20+KvUHXpeadTarWmTwWNkl39Wh8feE5t9EmkWcQO0w5Km+n7nP9KQcLmhf/dF9y8En3+Hx2PhK4tcVKWd6mMsRPxcy26tU8nnxBPhnGMR+Ahz7kmMFo+xEgEwqir6PzOCIL3z8QHS/7rZ4VtybfjVZqZlSZ+liOXw4M6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTfctO4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8225AC116C6;
	Wed, 14 Jan 2026 00:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768351328;
	bh=6PBGzWcjHfB59rDry7UMAz06odaS0vgJsxOZEe99WdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTfctO4yrNFTx6A8qL60vE2Aye7VUvVy3iWE6mxsbppgLseDhDpdAT7N9K5SgvLjE
	 AVRbtXzaLgaH+6DhhqL9BIY4ozcfqFICH99kPAlsDgeM5up3nlne9JPLiH9OrFOSlu
	 Oo/UxQXnIcGG21e3vzpVnfNAnELo3v2RMf1KWJwfMLV78R4a/pWMIGjfNc9GcNgL06
	 kVcBbW5FpLIfEG7Suo9n/yxafa2ngS9ntQsLFgBPZBE015yPEyMIcKw6C64zATMCSZ
	 61DUD3kuU96Gdoh1OG2C49Q7zV7rgxUPj3gnucAzcGvhUXg4HLp1tfKQDIvPbXBpX5
	 mXAYmSj8CIpUQ==
Date: Tue, 13 Jan 2026 16:42:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Message-ID: <20260114004205.GC2178@quark>
References: <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
 <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
 <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
 <C79886E5-3064-4202-9813-0D79091F78DF@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C79886E5-3064-4202-9813-0D79091F78DF@hammerspace.com>

On Tue, Jan 13, 2026 at 05:33:37PM -0500, Benjamin Coddington wrote:
> > - Individual filehandles are small, on the order of 32- or 64-bytes
> >
> > - But there are a lot of filehandles, perhaps billions, that would
> >   be encrypted or signed by the same key
> >
> > - The filehandle plaintext is predictable
> 
> Mostly, yes.  I think a strength of the AES-CBC implementation is that each
> 16-byte block is hashed with the results of the previous block.  So, by
> starting with the fileid (unique per-file) and then proceeding to the less
> unique block (fsid + fileid again), the total entropy for each encrypted
> filehandle is increased.

This sort of comment shows that the choice of AES-CBC still isn't well
motivated.  AES-CBC is an unauthenticated encryption algorithm that
protects a message's confidentiality.  It isn't a hash function, it
isn't a MAC, and it doesn't protect a message's authenticity.  AES-CBC
will successfully decrypt any ciphertext, even one tampered with by an
attacker, into some plaintext.  You may be confusing AES-CBC with
AES-CBC-MAC.

> > There are plenty of other kmalloc / alloc_page call sites in the
> > request path, and the server is designed around permitting synchronous
> > waits for memory allocated with GFP_KERNEL. If you don't want to wait
> > for memory reclaim, use GFP_NOFS or even GFP_ATOMIC but for such small
> > allocations, it's highly unlikely that an allocation request will fail.
> 
> I'm ok doing the allocation dance for every filehandle, but I think its an
> easy optimization to keep the buffers around if you know you're going to be
> using them - same way we do for RPC buffers.

In the kernel, several MACs (such as HMAC-SHA256, HMAC-SHA512, BLAKE2s,
and SipHash-2-4) have clean APIs that don't require dynamic memory
allocation, scatterlists, or CONFIG_CRYPTO.  If you do need a MAC, you
probably should use one of those algorithms and APIs.

I see that FIPS 140-3 got mentioned.  In the case where the kernel is
certified as a FIPS 140-3 module, I don't know whether this feature
would actually be considered a security function for FIPS purposes or
not.  That would determine whether it would actually be required to use
a FIPS-approved algorithm.  If you're choosing a MAC and want to use a
FIPS-approved one to be safe, you could choose HMAC-SHA256.

However, as I said before, the first thing to do is actually to evaluate
what security guarantees you need.  To me it seems like you want to
ensure that for a given client, only file handles that it was sent by
the server will be accepted by the server (provided that it can't snoop
on handles sent to other clients).  An unauthenticated encryption mode
like AES-CBC doesn't solve that problem.  I think a MAC is sufficient to
solve that problem.  An AEAD would too and would add confidentiality
protection, but that seems overkill / unnecessary here.

- Eric

