Return-Path: <linux-nfs+bounces-13911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5EB384E4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E622D7B5CB0
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFF35AAA0;
	Wed, 27 Aug 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+0JCzlG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5135A2BD;
	Wed, 27 Aug 2025 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304657; cv=none; b=S8EuabAABzyFfslHtjGs8IFepsLW7kt57xy3sy/wnhJwmNK6WQZFbv2iEWZri7iaRA8nCx+03AskpDaykZBa8SPPjljsm/lIkxt91/NufgpW5LwpOJPXGWDijY8MWC4QMwO+5drtY+JauKAufSXq/zvC6Ix15DSmZOHgZT3y5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304657; c=relaxed/simple;
	bh=mq9eSuFgiPBFkbu6qC8Z66lM09Kcv4mvMXmdIBs42NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWd2Z6e0q728mBDHt9OV1cc9IpmHoTx4+rBAXd6BkpPPoqC89aH1PPZPxX+n+EaS0VXoAbIqVDnshCgMrzbE72Phk8wXhB4IPgyiWjGKuNTlF558bJt0dqPhSuuvOU1tpJXpeuvJ0pO01fZrD3EnGJqEfvITRnPx0Ppemqyp/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+0JCzlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B36C4CEF9;
	Wed, 27 Aug 2025 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756304656;
	bh=mq9eSuFgiPBFkbu6qC8Z66lM09Kcv4mvMXmdIBs42NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+0JCzlG6B+n6qBFikQl3S57CnpOcdupphg1A6UY5gA449o44tY+LGxZfTq4XZXXb
	 SMKW8L/G29ftL1VZ38NPUGfJBp1L/q8Vv3mJl2nChLpR1srL1sUHEkJ0UPjpoFFI94
	 Y3i510ecQLUQlUx4G4nuvyiX5AAlzkP27Ec4PPprSseg6LaH2ufCfir2/y5+VPR+tM
	 4MXmItP0XBFafte5sOul6z6qQ9JZwabbmj7DCBST5NywTfo9iwzR6pDHl/LWO5CHNW
	 DUVQmvw5doaIrxenIIIYUge7Q/ExAaZY1hnMehupnEwtdnSf6ZO53KQBbqcTrXR712
	 sopcfqSzdIXwg==
Date: Wed, 27 Aug 2025 15:24:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sunrpc: add a Kconfig option to redirect
 dfprintk() output to trace buffer
Message-ID: <20250827142411.GF5652@horms.kernel.org>
References: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
 <20250822-nfs-testing-v2-2-5f6034b16e46@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-nfs-testing-v2-2-5f6034b16e46@kernel.org>

On Fri, Aug 22, 2025 at 09:19:23AM -0400, Jeff Layton wrote:
> We have a lot of old dprintk() call sites that aren't going anywhere
> anytime soon. At the same time, turning them up is a serious burden on
> the host due to the console locking overhead.
> 
> Add a new Kconfig option that redirects dfprintk() output to the trace
> buffer. This is more efficient than logging to the console and allows
> for proper interleaving of dprintk and static tracepoint events.
> 
> Since using trace_printk() causes scary warnings to pop at boot time,
> this new option defaults to "n".
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


