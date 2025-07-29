Return-Path: <linux-nfs+bounces-13300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B395B149D7
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DFD4E5A58
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498E276054;
	Tue, 29 Jul 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCUlRsbw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546F27603C;
	Tue, 29 Jul 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776793; cv=none; b=J3yZ2TAxX8MtyP8v2SQ7dyb8+hv4xYoQ6xNaynr/hyW/cBwXJCsLsEAL6DX+ysYi94A6XKNmaeSjjYNBXhyxNqxBSNILQtWvEt8twt2KqxvBcbvnm/M+4eN7tvy+lS3GYK8SXiFOr/ZiEBtb9AaCuGoWUWrs/K+9U4EQaFxXwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776793; c=relaxed/simple;
	bh=iau6CFRPvo+1rErnYbUShzPk5E8wZpMfdzXyHGYM0go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dira94SeUxvbfxW7bfGv2WxDyyX80W+dTbWvwPMWvm4y/9dE8XsfvaKeH0ccCUWMr0ecG2Q5yqy0Z49QF6av+y6E+XCAsG+ARKpOmhNU7sbHPrEakFF7L00bTeDMILipLc4iDoKxH0EKCbUHF6QWqvDuTM8bHp0kiw7CGP+cZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCUlRsbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4287C4CEEF;
	Tue, 29 Jul 2025 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753776793;
	bh=iau6CFRPvo+1rErnYbUShzPk5E8wZpMfdzXyHGYM0go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TCUlRsbw4eKHsMvwqqMw0QZp5VHfQ1kjTeMRX270ZFQs7lZR0DACV5S2YM21RYIw6
	 D5ZAYt74Qv7QNAHQjNoe8zrC+B1dpE8tzyAbn6hTCnx0TFaJK7FYvrUNhpBrs8RRvU
	 nsc0c3zSvuS3MANsYjJX2X/QxQwNa5zuqLLs6lIEbFjFHGi6k1h6Cb/W1hH815Fqx4
	 ZYKfp2VbzN0toadJ7p3gvmOnUpA8orp5eVtqUc3CHyTpX5W/IBimOkLaBSUswjlIER
	 yPJRM7FY5MxuiKYcdpcwAAG3Bs0UtRij6a4BCXV+6Q+dfS9wmoj63b+JF84L/8Yshk
	 q7lYQ9pkvbx8g==
Message-ID: <8ce2c9ce-9636-4888-8d63-2169441addcb@kernel.org>
Date: Tue, 29 Jul 2025 17:13:07 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] net/tls/tls_sw: use the record size limit specified
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
 <20250729024150.222513-5-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250729024150.222513-5-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 11:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Currently, for tls_sw, the kernel uses the default 16K
> TLS_MAX_PAYLOAD_SIZE for records. However, if an endpoint has specified
> a record size much lower than that, it is currently not respected.

Remove "much". Lower is lower and we have to respect it, even if it is 1B.

> This patch adds support to using the record size limit specified by an
> endpoint if it has been set.

s/to using/for using

> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

> @@ -1045,6 +1046,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  		}
>  	}
>  
> +	if (tls_ctx->tls_record_size_limit > 0) {
> +		tls_record_size_limit = min(tls_ctx->tls_record_size_limit,
> +					    TLS_MAX_PAYLOAD_SIZE);
> +	} else {
> +		tls_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
> +	}

You can simplify this with:

	tls_record_size_limit =
		min_not_zero(tls_ctx->tls_record_size_limit,
			     TLS_MAX_PAYLOAD_SIZE);

> +
>  	while (msg_data_left(msg)) {
>  		if (sk->sk_err) {
>  			ret = -sk->sk_err;
> @@ -1066,7 +1074,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  		orig_size = msg_pl->sg.size;
>  		full_record = false;
>  		try_to_copy = msg_data_left(msg);
> -		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
> +		record_room = tls_record_size_limit - msg_pl->sg.size;
>  		if (try_to_copy >= record_room) {
>  			try_to_copy = record_room;
>  			full_record = true;


-- 
Damien Le Moal
Western Digital Research

