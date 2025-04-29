Return-Path: <linux-nfs+bounces-11358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D567AA1B2D
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 21:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D829C0691
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAD259C94;
	Tue, 29 Apr 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2ZijDYq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584C259C8D;
	Tue, 29 Apr 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953798; cv=none; b=s1/27Xo3ooFKi4FFlKeyUHGbolgf4csqchnXi4Pt97peOsYMqMCag1o9ix9OLLItHYA5v51YSVnbgYpxn5ZIXmnIkwwms60DfU0ZyRyPNp/tlai1y9Hh0d21V34YXfO+iNtpTrizuvV/c0YancZdpXbJpqzILAuJURH77SoSwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953798; c=relaxed/simple;
	bh=S0v0ykdbkSiUutx8b5JY8FsLcit630a72geOEaZ44Z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJTrOQMyCjvZbWjHs5wyxDU+OAdZq7CPsHYf6wvENRygQkcSAFfz42FxF9wK9J2/+RafCx6AZb5d0Hedt9US8lwZMZdXOFwMhHpNr0OdIavVFEDlfvwbobo3kEhhyJGnCttaM+ud7gPgS9IGq4BdJWDgS+M6D9gbORSLkSpbGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2ZijDYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE0EC4CEE3;
	Tue, 29 Apr 2025 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745953797;
	bh=S0v0ykdbkSiUutx8b5JY8FsLcit630a72geOEaZ44Z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g2ZijDYq4e1HJ6nTuqb3MdWlY5lJHDZ0mcdWGb/MKboFapcSh25dCGMAX3DGpbdQK
	 mp4q3E7oLkkNZg72KWWUPbEUQMRGylN2vj7fKpQNtwmPlk5sWmWGYQ/dUiYLCcy5Iw
	 TGMxc6P0AJGxVAAyDaRh/RpbhIqxb+HeIxHDE6NMfmnpv5kn2+hV8vfJaszysnecWP
	 AKxuKWKB6dxA/qAj068Ih3yL6sygSiU8GLnvgVI9t0pVNBTjpWc2Xv72nyD5PuoNqY
	 DzjSS+1WDIzAmP/+zyQVdGuvVDhOJbS2s3zGoDmckxwgNy8eSc1OA6wkwNcvIVdcEa
	 M+3IR3YVFr/3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE443822D4C;
	Tue, 29 Apr 2025 19:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] crypto/krb5: Fix change to use SG miter to use
 offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595383648.1770515.334423399134912073.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 19:10:36 +0000
References: <3824017.1745835726@warthog.procyon.org.uk>
In-Reply-To: <3824017.1745835726@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, herbert@gondor.apana.org.au,
 marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
 chuck.lever@oracle.com, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Apr 2025 11:22:06 +0100 you wrote:
> [Note: Nothing in linus/master uses the krb5lib, though the bug is there,
>  but it is used by AF_RXRPC's RxGK implementation in net-next, so can it go
>  through the net-next tree rather than directly to Linus or through
>  crypto?]
> 
> The recent patch to make the rfc3961 simplified code use sg_miter rather
> than manually walking the scatterlist to hash the contents of a buffer
> described by that scatterlist failed to take the starting offset into
> account.
> 
> [...]

Here is the summary with links:
  - [net-next] crypto/krb5: Fix change to use SG miter to use offset
    https://git.kernel.org/netdev/net-next/c/eed848871c96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



