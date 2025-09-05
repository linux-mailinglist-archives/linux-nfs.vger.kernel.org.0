Return-Path: <linux-nfs+bounces-14064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C27B45897
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E67B4FEB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970F283FE1;
	Fri,  5 Sep 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfalbbc0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E501D5CC9;
	Fri,  5 Sep 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078309; cv=none; b=Rdi0ie+AO9nB+XQiiy+Wu80dLMuf4mrZkR9ZYU0bnr7rvEcnOG3wdz4iSSLVgmfcfTAzjClH57Dv4T0S+3Jo/8M57rmn3gpKr3T0lDRauyO+sWwzfsUN3I4+Ua9KbzNc6KJuUvLGSGGE6RLeGV4uYBCvcyqMq6gcf9enhREmMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078309; c=relaxed/simple;
	bh=RAA4rrJfeN8TQeFhBzYY5lBVITfb6FXS1EgUHDAhgbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEdf3NXVlK4c2k+dSnG32oVIeJ4EGmbvR0p2ocHjU9UEoCbeoHGtqHnbWyVo14yFRwMAhf86E7HyGMojFpTQh3dJDgdqMRTY3euG3HLmen1QRdiq2BsJuzRFYituiKKkrUQSugIRUvQwNWj8GxGN2sCJ6BevJIXo+jajA72fWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfalbbc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A15DC4CEF1;
	Fri,  5 Sep 2025 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078309;
	bh=RAA4rrJfeN8TQeFhBzYY5lBVITfb6FXS1EgUHDAhgbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfalbbc0wK3mEOrEVsTZbNdHh1qtaNoFYkoXswu86BJXqgZtkB2p7ll0PmNFm+UF+
	 gROQHu45kiB2fB6zc9OocpeaCAl/VSUHMQTcK5dzzrBgfqKjEqoouiaYe0mVXn3hhP
	 2kpcsQKNAXGCMaKeCuDHKvZBNbFWuLrnetV5rnBM+Lul+hxu1a3YiWmsb1sWrI+HmF
	 8pxiMX2HVdqmxtozF5RFbwrNM7Av4MtV5kA9VGPoVeyr66E1EOBfErHIwl+nZDi9gV
	 BRPm5dt9TEUB/FB/dwkJLJ+Ks+3zD13gCA3XbAUMRYXVgNRQ6rjKqP7qlrGvZJFGPw
	 1nGF+gV/jf+bw==
Date: Fri, 5 Sep 2025 14:18:23 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/7] net/handshake: Store the key serial number on
 completion
Message-ID: <20250905131823.GE553991@horms.kernel.org>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-2-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-2-alistair.francis@wdc.com>

On Fri, Sep 05, 2025 at 12:46:53PM +1000, alistair23@gmail.com wrote:

...

> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c

...

> @@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
>  		if (i >= treq->th_num_peerids)
>  			break;
>  	}
> +
> +	nla_for_each_attr(nla, head, len, rem) {
> +		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
> +			treq->user_session_id = nla_get_u32(nla);

Hi Alistair,

This appears to be addressed by patch 5/7 of this series.
But struct tls_handshake_req does not have a user_session_id member
with (only) this patch applied on top of net-next.

This breaks bisection and should be addressed: when each patch is applied
in turn the resulting source tree should compile.

...

> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e2c5e0e626f9..1d5829aecf45 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -450,7 +450,8 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */

Please also add user_session_id to the kernel doc for this function (above).

Flagged by W=1 builds and ./scripts/kernel-doc -none 

> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   key_serial_t user_session_id)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index c5f7bbf5775f..3489c4693ff4 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2591,7 +2591,8 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @peerid: serial number of key containing the remote's identity
>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  key_serial_t user_session_id)

Ditto.

>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =
> -- 
> 2.50.1
> 
> 

