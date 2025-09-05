Return-Path: <linux-nfs+bounces-14066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C57B458B1
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 15:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081583A846C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F94134A32C;
	Fri,  5 Sep 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyrvac0H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D989191F98;
	Fri,  5 Sep 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078612; cv=none; b=KArqwOGV3w74plygLCEJTPQFyblV8aPop2BFpY5T/X+aZ9LZwlGJgCbVCWIPRb/yVMdt0/mF/t20WS48+dLRPkCzA3pOaEFVeb4Jt9FrneJWBGdxMJAeSYWJuWyNfDdBzBGadCpQTBSI9VtMsu1Ph74OgdH2+6bJaHAS0b469rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078612; c=relaxed/simple;
	bh=oUjxRpw2jn9nJg4SkZzc7uIiTF1l3VGO8gkEdXpUbwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM7tup0zrkkF3FctZAt/+fnlRD3SyRLMLYCc5Fz6Grl+irBfO/xxHymyfk88r43Az/AJ7tMYKev5bEeP2DUb4bE/CzRl1LaLJHyP95nED+hsP9dH2BfRH1xIHc6aAZzxk/SC48RMfDzcsP22KCoBJ0QWdF3FJjU6v8IlHZS/Rw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyrvac0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AB0C4CEF1;
	Fri,  5 Sep 2025 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078610;
	bh=oUjxRpw2jn9nJg4SkZzc7uIiTF1l3VGO8gkEdXpUbwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyrvac0H+l/lHSAlPh6QaASvjPJZFk5ehuYmjHV81YNgiOdZRzqaHBtXEMZ7bpkxn
	 8gAikwOkfU1qGvBUgbfnvg0T5EjGKYgkNv2Vdi8huubZ6MCLzjlmpCcageKcwPc3a8
	 QoSV/Ko9nVw/VbjlWVNz2waYMofB/byZgumufIz7SETHDJoM/NcScPstvoBSxGvWXf
	 +gp/fImF6E1/lRREo0EWyJ54+sxPAlJEiCMb/YuimLzA6w1OnpXc5tVFpD6gXwv55q
	 RdajGLUwKCtvsqudezvh9U6UxZgL57D5KD9zj+mbfwI5DtH/m1zqNXA/nw+NzBjHAI
	 0Lcd8j6DtIvxg==
Date: Fri, 5 Sep 2025 14:23:25 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 5/7] net/handshake: Support KeyUpdate message types
Message-ID: <20250905132325.GF553991@horms.kernel.org>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-6-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-6-alistair.francis@wdc.com>

On Fri, Sep 05, 2025 at 12:46:57PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

...

> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index a273bc74d26f..1a3312fad410 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -21,12 +21,17 @@ definitions:
>      type: enum
>      name: msg-type
>      value-start: 0
> -    entries: [unspec, clienthello, serverhello]
> +    entries: [unspec, clienthello, serverhello, clientkeyupdate, clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
>    -

This line seems excessively long.
The preference is for lines no longer than 80 characters wide.

Flagged by yamllint.

...

> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c

...

> @@ -348,7 +361,8 @@ EXPORT_SYMBOL(tls_client_hello_x509);
>   *   %-ESRCH: No user agent is available
>   *   %-ENOMEM: Memory allocation failed
>   */

Please also add keyupdate to the Kernel doc for this function.

Flagged by ./scripts/kernel-doc --none

> -int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
> +int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			 handshake_key_update_type keyupdate)
>  {
>  	struct tls_handshake_req *treq;
>  	struct handshake_req *req;

...

> @@ -410,7 +428,8 @@ EXPORT_SYMBOL(tls_server_hello_x509);
>   *   %-ESRCH: No user agent is available
>   *   %-ENOMEM: Memory allocation failed
>   */

Ditto.

> -int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
> +int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			 handshake_key_update_type keyupdate)
>  {
>  	struct tls_handshake_req *treq;
>  	struct handshake_req *req;

...

