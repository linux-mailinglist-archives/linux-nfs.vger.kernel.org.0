Return-Path: <linux-nfs+bounces-15201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DEDBD5EDB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 21:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86D84E296D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9602D94AB;
	Mon, 13 Oct 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN5kcLqm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FB2D73A8;
	Mon, 13 Oct 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383266; cv=none; b=Iq2Q3vqkRvFjQ3ALVEIUj/f0r4yOGEIOQwrgKJzIy1PDKJiIAU2X3EJPHl/VURVG45P+ibQ0Tv3LnNRCcmKj3IXrj6+OVc6pwu31u6DnxTXMhL+ynIVao9fCTC3x+QqCsxTD8hnG4MVnTbWIbmzBskBFhemPsncR2EsLeg0B9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383266; c=relaxed/simple;
	bh=Gf4tLKj2R4HlGFgv3EPwbtXfxkpOO9Wvff9KZZS9+Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+VTmYtoRdZeVNYRB1SNs9EtVn4UMvxAK9DCQjHFlY60H9usGO1SUDxxSji857bgmUXNMR8G3wMszFkpQLCzIUyHpTXUX/WNHZBVayfJ4D0MCYsRKPP3+LgHsA+bYPjGXOTN9lUxZZ7/wJbmoH18eZEUsE7nG7hvonjq8H7YNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN5kcLqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E93C4CEE7;
	Mon, 13 Oct 2025 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760383265;
	bh=Gf4tLKj2R4HlGFgv3EPwbtXfxkpOO9Wvff9KZZS9+Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gN5kcLqmaswykqD9XFLhxguz7GAQcHdPqKvUbFseWKktBBP7eTuo2XvmthQArNtxg
	 NDuRPQiB9D/VcmRrVKQQKCK26und9QMAQ8nwNjkaanEhdH7fRUDLxFna4fo9STzLn/
	 7QGPngmBZabODM6I0TL6uEQeldXhSaDD8fdQyi9FCcLp7oakr8KCj3caj1EPF5KJqM
	 Mjh6CJcrSsfwgJtR0bl70+Svic5OqN+sXgvwKi6kUrWOIO5AkfyT8d9dFIbI9tUs4E
	 z3KOyjMIOkeC+1AZLqX7epInhIy55x3uZq+FEFsJ/4P24+gJ57qe2TXVeC0KAXWWbt
	 Wq3cuAmWvvEOg==
Date: Mon, 13 Oct 2025 19:21:03 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chuck Lever <cel@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] NFSD changes for v6.18
Message-ID: <20251013192103.GA61714@google.com>
References: <20251006135010.2165-1-cel@kernel.org>
 <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>

On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven wrote:
> Hi Chuck, Eric,
> 
> On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
> > Eric Biggers (4):
> >       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
> 
> This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
> select CRYPTO instead of depending on it") in v6.18-rc1.
> As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
> defconfigs that didn't enable it before.
> 
> Gr{oetje,eeting}s,
> 

Now the config is:

    config RPCSEC_GSS_KRB5
        tristate "Secure RPC: Kerberos V mechanism"
        depends on SUNRPC
        default y
        select SUNRPC_GSS
        select CRYPTO
        select CRYPTO_SKCIPHER
        select CRYPTO_HASH

Perhaps the 'default y' should be removed?

Chuck, do you know why it's there?

- Eric

