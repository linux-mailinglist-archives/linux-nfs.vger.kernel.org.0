Return-Path: <linux-nfs+bounces-11843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBABABE816
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 01:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B958C189B63E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3C2528E0;
	Tue, 20 May 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5yQRu5L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C07218EA2;
	Tue, 20 May 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784088; cv=none; b=FLY1na3URfmI9DgwMRXLJk8A/k3myW9JniFYxFinZUyX19WTroicN1aEFFtYLjMqUteONkrk/80hhodh+pM6//a5h8kLkptnCtPwtLFvNeVwAuoS6+98eXaDu6KpiGDlKDL5BCP4cxMXKv8JaBUbgPOmLw6zH03J09/qmAeRGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784088; c=relaxed/simple;
	bh=nk5kiEmG5q6Z6ly3rI2SSY3NQLP58Venst00SAF/F60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQSQWaEXNJtCwCmnjx7/+ErlYXG4iIHELhG788Jr4BwetBC7T6/ctVePbyyGYmBPcnwWHpeTjdd/WtMBOkCcdWwcfvuPZzf5i7viPcCMsznO0ReS0gETCI/IhQcvnB73z2URerOE67V218EtmZ7jh0Qy/9pU4WxQrIL2bvC+UUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5yQRu5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED200C4CEE9;
	Tue, 20 May 2025 23:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747784088;
	bh=nk5kiEmG5q6Z6ly3rI2SSY3NQLP58Venst00SAF/F60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5yQRu5LByw0qmZ43NOxThhQtuMUYw/+ZdxT7XSL2GD0uPrryMrYvF7hrXlwb+LxR
	 ZAfYA8jueqxHLuIGfSEGpdB03PxUdHOD91p18u+8CGqSnWfc9/soxQeMhxcRYBBBP+
	 o41IY6fqHnI7Oi9ai33uTiKQyuy/T7f/w8Q49UeG//f1O73giDmS8Ze/DVf8TBo2Aa
	 6TPSC1h85fHcC96Hk2lzl8/29drA/WjeXSfevV9r9NApvmOgTavSSP+ow+/oLOE4my
	 oiGZgeNaci6l6nx2iuJRl+1kBOLp9aHH5LMm4NLiMyC8W4Rd7mV5+Jzq+T7yfudl0m
	 ihhDCVTGozBlw==
Date: Tue, 20 May 2025 19:34:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: cel@kernel.org
Cc: Thomas Haynes <loghyr@hammerspace.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve Sears <sjs@hammerspace.com>, Jakub Kacinski <kuba@kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls
Message-ID: <aC0RlqfuilOj51kT@kernel.org>
References: <20250520195916.676511-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520195916.676511-1-cel@kernel.org>

On Tue, May 20, 2025 at 03:59:16PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Engineers at Hammerspace noticed that sometimes mounting with
> "xprtsec=tls" hangs for a minute or so, and then times out, even
> when the NFS server is reachable and responsive.
> 
> kTLS shuts off data_ready callbacks if strp->msg_ready is set to
> mitigate data_ready callbacks when a full TLS record is not yet
> ready to be read from the socket.
> 
> Normally msg_ready is clear when the first TLS record arrives on
> a socket. However, I observed that sometimes tls_setsockopt() sets
> strp->msg_ready, and that prevents forward progress because
> tls_data_ready() becomes a no-op.
> 
> Moreover, Jakub says: "If there's a full record queued at the time
> when [tlshd] passes the socket back to the kernel, it's up to the
> reader to read the already queued data out." So SunRPC cannot
> expect a data_ready call when ingress data is already waiting.
> 
> Add an explicit poll after SunRPC's upper transport is set up to
> pick up any data that arrived after the TLS handshake but before
> transport set-up is complete.
> 
> Reported-by: Steve Sears <sjs@hammerspace.com>
> Suggested-by: Jakub Kacinski <kuba@kernel.org>
> Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtsock.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> Mike, can you try this out?

Works well, thanks to you and Jakub for seeing this through!

Tested-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>

> 
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 83cc095846d3..4b10ecf4c265 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2740,6 +2740,11 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
>  	}
>  	rpc_shutdown_client(lower_clnt);
>  
> +	/* Check for ingress data that arrived before the socket's
> +	 * ->data_ready callback was set up.
> +	 */
> +	xs_poll_check_readable(upper_transport);
> +
>  out_unlock:
>  	current_restore_flags(pflags, PF_MEMALLOC);
>  	upper_transport->clnt = NULL;
> -- 
> 2.49.0
> 

