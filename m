Return-Path: <linux-nfs+bounces-8938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52DCA03531
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 03:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73A7164A9D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847113B58C;
	Tue,  7 Jan 2025 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROEL5mqI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEF7DA7F;
	Tue,  7 Jan 2025 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217395; cv=none; b=t57vfs2IAIXpIpieqMIJRlFvQoxjDfp29I7AP0BcgubqnQFO4aCoq51NR5pbiHIQABOyVDJ/wZQ8fC/MNZgpCMQseKmsvOZt88QZZBP54xi2wFtSwy7vjcPtOIyr+a07/j2NtST3OZLbJYczyGFfGn0Uk/FRM+l8YcZwYSRq06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217395; c=relaxed/simple;
	bh=moqNFwJoVpoEyM0pXq6iiTO5wZQNaHE39lpiW9moPng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UH4cmYKLZtLqCK+Y9j+GuNxG6SHe0wOLWrq8drqBviBGG5zUPHJszry4g+gOUxw041Nt0kQqEc7yHLqPRR4ibWcwjsQbhOFTYgDahxzDGMAbmIgiS6hl+ikAmEZtwyIJkKIVeOgmYj3VJHqNDGLK7Yixd5lVbMYfwScuDZiP8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROEL5mqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7269AC4CED2;
	Tue,  7 Jan 2025 02:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736217394;
	bh=moqNFwJoVpoEyM0pXq6iiTO5wZQNaHE39lpiW9moPng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROEL5mqID/hJH7z7KWNtvY3TAcfQGDFhj9/iQhnWZqpGPBBdIVuDmuyMr1C5KQItF
	 RpDIWQvVV61KP9zX8g6BZofwwTBReUL7JwHt0KgnEPXZK2oPNZ4+OPrK28+VxoWdKX
	 YISzFIEynOqVE5PWUqx4KLMIke30uh15B6DIg4k8vWsxpCyCHdfoFo0BArI4YEhnPR
	 5rIxJIEAJMv3CSY0l/Vd3KS5vFm8PSv7ntOEUdgFiW8pQTya3CmhBeImicdWgKtWch
	 tAOyLabzDUhifN/hX3MVAodR7cAXV2SBRLYRQjDLj3oTeJviWqrhpvgvhwLloI+T1L
	 3PCzwriUW8Xjw==
Date: Mon, 6 Jan 2025 18:36:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] tls: Fix tls_sw_sendmsg error handling
Message-ID: <20250106183633.0ddb7cb0@kernel.org>
In-Reply-To: <9594185559881679d81f071b181a10eb07cd079f.1736004079.git.bcodding@redhat.com>
References: <9594185559881679d81f071b181a10eb07cd079f.1736004079.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jan 2025 10:29:45 -0500 Benjamin Coddington wrote:
> We've noticed that NFS can hang when using RPC over TLS on an unstable
> connection, and investigation shows that the RPC layer is stuck in a tight
> loop attempting to transmit, but forever getting -EBADMSG back from the
> underlying network.  The loop begins when tcp_sendmsg_locked() returns
> -EPIPE to tls_tx_records(), but that error is converted to -EBADMSG when
> calling the socket's error reporting handler.
> 
> Instead of converting errors from tcp_sendmsg_locked(), let's pass them
> along in this path.  The RPC layer handles -EPIPE by reconnecting the
> transport, which prevents the endless attempts to transmit on a broken
> connection.

LGTM, only question in my mind is whether we should send this to stable.
Any preference?

