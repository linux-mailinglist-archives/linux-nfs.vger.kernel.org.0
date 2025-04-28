Return-Path: <linux-nfs+bounces-11306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D5A9EEE7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0578A1886941
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FB25EF93;
	Mon, 28 Apr 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pDiCebDu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB00EEC8;
	Mon, 28 Apr 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839230; cv=none; b=L6lny13/zBe0YrZbr18hFmubZQQhyJAGLHKeEN3b4O8NVay0X+IHxqGw+vdbrxwgqgHC7mKGAs91YGXZW0npJtEZKnC5vM0r2iXipYHptbE2FFPPfBEuOVg09bL4JzpUQtKwIa/uYR9TU7XRyJVkQ1QEmoVBeJY8fyLBP40+SWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839230; c=relaxed/simple;
	bh=lrGpwyIeyfi1QIbcIJ/Tj+3KQ+8NpzxTnUlKvV/xJi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWVCyBnitFzoqE4IdTXMC4sJm9wPTnk1IQJSY6V+/mqY1e3docSKKRxlcqUcvPyzQwYAnWE5stPdRTP34U7AMtVP1lefoCOtWeHgR1Oy/HP1erZ5nFL/jEcGOQadRJ8+tG0DwQQqLPxuyPSLf4yKoraponCf/BL9RwV/SaCdtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pDiCebDu; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sh9fvtw3x+0OKhV0VoEJRrPasUJuLRYfxSzZzi6/cg8=; b=pDiCebDuIci7Mk4OEF0McCApuQ
	FmKEjP5+MQvESpcUKisrKxMFEveGBInusJogYaKdCXiCiCus5aTr62ELhPOBxB7A3iFx5nMfbyjca
	aF25QoTTyLb5uCnm1z1rKjXRPOHO/LOaH3RkzXLw5MzluhGQ5C317ZIWnpcMZbDwFBaLNOl+CApuM
	ShLctgazkaiCjWI+bd7hFG0SDzWMbvvrIOP1RldsVCKLBQgfrUC1Wm5ctw9Uq5/eLt5g4Y4LUhCEB
	1i7Oos4x9bzJD2VjBFQecqi8SPcsWEoqG6K7xT7u2XK1YRHdwwkWJpk+2UxDz6m/gGE45O73p8Ror
	eTWhswvQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9MWg-001aq7-24;
	Mon, 28 Apr 2025 19:19:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Apr 2025 19:19:54 +0800
Date: Mon, 28 Apr 2025 19:19:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] crypto/krb5: Fix change to use SG miter to use
 offset
Message-ID: <aA9kWu9eViN17ZBs@gondor.apana.org.au>
References: <3824017.1745835726@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3824017.1745835726@warthog.procyon.org.uk>

On Mon, Apr 28, 2025 at 11:22:06AM +0100, David Howells wrote:
> [Note: Nothing in linus/master uses the krb5lib, though the bug is there,
>  but it is used by AF_RXRPC's RxGK implementation in net-next, so can it go
>  through the net-next tree rather than directly to Linus or through
>  crypto?]

Sure I'm happy for this to go through net-next.

> The recent patch to make the rfc3961 simplified code use sg_miter rather
> than manually walking the scatterlist to hash the contents of a buffer
> described by that scatterlist failed to take the starting offset into
> account.
> 
> This is indicated by the selftests reporting:
> 
>     krb5: Running aes128-cts-hmac-sha256-128 mic
>     krb5: !!! TESTFAIL crypto/krb5/selftest.c:446
>     krb5: MIC mismatch
> 
> Fix this by calling sg_miter_skip() before doing the loop to advance by the
> offset.
> 
> This only affects packet signing modes and not full encryption in RxGK
> because, for full encryption, the message digest is handled inside the
> authenc and krb5enc drivers.
> 
> Fixes: da6f9bf40ac2 ("crypto: krb5 - Use SG miter instead of doing it by hand")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-crypto@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  crypto/krb5/rfc3961_simplified.c |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

