Return-Path: <linux-nfs+bounces-9032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21633A07DB3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7041692CA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E9222572;
	Thu,  9 Jan 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0vZAMXC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F99222569;
	Thu,  9 Jan 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440566; cv=none; b=RrqXe597uKCUQ4WKzCPf8CL2zUT4JtTv5n+8rhzv+oh0YGeLaF/8SKYIusAlIHEluXUst+bRPdDOTfAqfePOJWmFzVbml09uy1QgGRX63ID+rLRbSbgQ5OcAcdKNaDolhi3qTyspsupRfKeH+UIFa8TKbfE2ej+JenmqyT1dQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440566; c=relaxed/simple;
	bh=jU3RypXovbkii7FU1sbotxWRcH9k7T1/3ojFfFsJa0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hImkMrBoL6yBIutKmiGGz6+7rLRsm77IXOPURZHbHeo3IdC7Xlgo+H/RcY1uccsJfxjl96xLQtDwy6rv/ZqEruklUF7+kOrG8DdeG920b1XnNenjNj/a+5aw/AlHpLtNM8+DQglEIbZv+d6W9CSPZJKMvy0ZdmC7Ax+rTEM3tCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0vZAMXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D73C4CED3;
	Thu,  9 Jan 2025 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440566;
	bh=jU3RypXovbkii7FU1sbotxWRcH9k7T1/3ojFfFsJa0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0vZAMXCMDfwNFpDIttwYNvzv/Evr02hJiaBlveeXLMmK5ubZovHlbn+isIVjzJxb
	 low1xU4JRif4413Tvq00TG3uVBdbfHGkYPiL0QaYpP/4UotrqisCGG4o++k/tvkagq
	 Sl0JXgXh4VtsPa3nHXkLDzDi7BzLero2AEWZ1Tx8p/TBTI9Mq5/UjmnFhgTmt9GmmQ
	 RcDQeaKjsbrFVye2QUxqfoAR/uvjNa5wt3HxNaXW0Vv2KhwRPWrkllvSGnbv4uVi9B
	 P+t3csxGUgDXpKtRh2xhy6Cw3lzQzFjL9ASxo4nDQzf8Z68oCsS7iRDbdTCFHSOHnu
	 2DwWILLpSvpUw==
Date: Thu, 9 Jan 2025 08:36:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang
 <yoyang@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: add netlink control interface
Message-ID: <20250109083604.77ffe61d@kernel.org>
In-Reply-To: <20250108-lockd-nl-v1-1-b39f89ae0f20@kernel.org>
References: <20250108-lockd-nl-v1-1-b39f89ae0f20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jan 2025 16:00:15 -0500 Jeff Layton wrote:
> The legacy rpc.nfsd tool will set the nlm_grace_period if the NFSv4
> grace period is set. nfsdctl is missing this functionality, so add a new
> netlink control interface for lockd that it can use. For now, it only
> allows setting the grace period, and the tcp and udp listener ports.
> 
> lockd currently uses module parameters and sysctls for configuration, so
> all of its settings are global. With this change, lockd now tracks these
> values on a per-net-ns basis. It will only fall back to using the global
> values if any of them are 0.
> 
> Finally, as a backward compatability measure, if updating the nlm
> settings in the init_net namespace, also update the legacy global
> values to match.

Netlinky stuff LGTM, FWIW!

To encourage more doc: properties I should point out that we
render the specs on docs.kernel.org, now ;)
https://docs.kernel.org/next/networking/netlink_spec/nfsd.html

