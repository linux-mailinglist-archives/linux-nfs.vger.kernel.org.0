Return-Path: <linux-nfs+bounces-13298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCEB149BC
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D650545927
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3D2750EA;
	Tue, 29 Jul 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LooOaRcD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6811990B7;
	Tue, 29 Jul 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776480; cv=none; b=FuixOy2sry35RcT+C5mdyJQJa1Fv1o/08GVlV9MXQ2tOnrnx8ezgUJcWxcI7Aj7Xx4a0y33j//cuN5jfZ8GBBNX2EHIxiGvW6DxeXPzp76IyEqQRweEnIZIN/DE8SED1l4LF/9N5Rk9i7/XhRYaO+GUJV1Ec+TIHUT0FE43roQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776480; c=relaxed/simple;
	bh=LVJKkN36qjkh4TnMJiHplxyR9I2VwOGyfMGru+KsKTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8EMFickttn6o7fM24D/HM/eTk8Ep2CeD6/65mD0AdNp5RiuwhQto7FiF1jVwiXuo4MS2B0gNz14ibanrvKaSVJGHtZst9uBKGuSi6io1DlsmdWxtkvGDHPpYt/a6F7uFAP0isnNaEN5BJFpSJK6nqTc0lMjPt+DtmRfaz9VO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LooOaRcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61926C4CEEF;
	Tue, 29 Jul 2025 08:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753776479;
	bh=LVJKkN36qjkh4TnMJiHplxyR9I2VwOGyfMGru+KsKTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LooOaRcDqVFj6TYPVM4bElH0sal8d+yU3vpj7mh7Po0EyZu3w+oLX5+/zt7nQCzdz
	 +vAFMS5zL9RlCAWEhdqbuoOM+E5IA5rfCGvgDbvUNJOwIMrsT3cEZGBlnK2qbS4y+7
	 pA3IYoFMvrwEorSeqRqxmIIDGWzwRDlpEF2aWQGrAe9BDg9PdI3mXGGdTAFlXaWii9
	 sUzxzVgnR9vETwweQNlTaJk28YK8dGPUWCzcY47eJL3yxe7h5pVNMqHXwH3bhyLSBT
	 l2JvI4VShASNpPFfvNiAgOg3lfZ8/2jhFBWlA2kuS+yKa4xwC2ZBqGpo3XfIjZPjU3
	 XXuGk0mW/8JxQ==
Message-ID: <624296dc-69d6-4bdd-bed1-ffcb747fb96d@kernel.org>
Date: Tue, 29 Jul 2025 17:07:54 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] net/handshake: get negotiated tls record size limit
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
 <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 11:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, this limit is not visble to the kernel particularly in the case
> where userspace handles the handshake (tlshd/gnutls). This patch adds
> support for retrieving the record size limit.
> 
> This is the first step in ensuring that the kernel can respect the record
> size limit imposed by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  Documentation/netlink/specs/handshake.yaml |  3 +++
>  Documentation/networking/tls-handshake.rst |  8 +++++++-
>  drivers/nvme/host/tcp.c                    |  3 ++-
>  drivers/nvme/target/tcp.c                  |  3 ++-
>  include/net/handshake.h                    |  4 +++-
>  include/uapi/linux/handshake.h             |  1 +
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--
>  net/sunrpc/svcsock.c                       |  4 +++-
>  net/sunrpc/xprtsock.c                      |  4 +++-
>  10 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index b934cc513e3d..35d5eb91a3f9 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -84,6 +84,9 @@ attribute-sets:
>          name: remote-auth
>          type: u32
>          multi-attr: true
> +      -
> +        name: record-size-limit
> +        type: u32
>  
>  operations:
>    list:
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index 6f5ea1646a47..cd984a137779 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -169,7 +169,8 @@ The synopsis of this function is:
>  .. code-block:: c
>  
>    typedef void	(*tls_done_func_t)(void *data, int status,
> -                                   key_serial_t peerid);
> +                                   key_serial_t peerid,
> +                                   size_t tls_record_size_limit);
>  
>  The consumer provides a cookie in the @ta_data field of the
>  tls_handshake_args structure that is returned in the @data parameter of
> @@ -200,6 +201,11 @@ The @peerid parameter contains the serial number of a key containing the
>  remote peer's identity or the value TLS_NO_PEERID if the session is not
>  authenticated.
>  
> +The @tls_record_size_limit parameter, if non-zero, exposes the tls max
> +record size advertised by the endpoint. Record size must not exceed this amount.
> +A negative value shall indicate that the endpoint did not advertise the
> +maximum record size limit.

size_t cannot be negative... Did you mean:
"A value of 0 (TLS_NO_RECORD_SIZE_LIMIT)..."

Also note that even if the endpoint does not advertize a record sie limit, we
still have one (16K was it ?). So I think that the name TLS_NO_RECORD_SIZE_LIMIT
is a little misleading.

> +
>  A best practice is to close and destroy the socket immediately if the
>  handshake failed.

[...]

> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e1c85123b445..2014d906ff06 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -417,13 +417,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote peer's identity
> + * @tls_record_size_limit: Max tls_record_size_limit of the endpoint

Please make a proper sentence to describe tls_record_size_limit instead of
repeating that argument name.

>   *
>   * If a security policy is specified as an export option, we don't
>   * have a specific export here to check. So we set a "TLS session
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */
> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   size_t tls_record_size_limit)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 04ff66758fc3..509aa6269b0a 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2569,9 +2569,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote's identity
> + * @tls_record_size_limit: Max tls_record_size_limit of the endpoint

Same here.

>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  size_t tls_record_size_limit)
>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =


-- 
Damien Le Moal
Western Digital Research

