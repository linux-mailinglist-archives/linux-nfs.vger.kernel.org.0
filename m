Return-Path: <linux-nfs+bounces-13299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5CB149D0
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437D818A2FE3
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9286275AF5;
	Tue, 29 Jul 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TP0CXxJA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FWyyTVVL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e+2sTR3N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YHcTOh35"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FE27587C
	for <linux-nfs@vger.kernel.org>; Tue, 29 Jul 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776774; cv=none; b=kqdgRwEoPc6bKUVNopSK3oBpt0BBVTv0FAu+t3h8SSXLtNNdnVcBS5X8Bj6RImZlqZiIyvLRbhMKOe67SmKOm8uNHwcYqWP2pQ95VV+cxwoCH8GGUNbjLVYbzLtOYVmSg+5/bsqFzq5L2b/DFNktI9Sol9yzw6OxYM4iMHyfKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776774; c=relaxed/simple;
	bh=rdWdQxRPPebLIFAE61U25B9ANEFUl1JAwqQwG/fL4Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jA7T+utTASV8I2+1PIyEq8duVCB6Isq7wSz9Vh9VeQjQu7wWtqZ2JYqhRn6huq04HKziWxeB53hxnrOGXRqTIVDMsIOTIxowQGc5n0kbbbxUXfBCgvWKIqz/kRc4L5i6OhK//WXeAZP0iXkleB96WSJMjCag8zJs6vypRKli254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TP0CXxJA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FWyyTVVL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e+2sTR3N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YHcTOh35; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4CFB21A26;
	Tue, 29 Jul 2025 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=TP0CXxJALp4/Y4BfEbYLZnhuBPV1q0vfL6cnfMVT5gFDJp5sBHHZPXmB+CPJc18adZhuTu
	ZotniTUatLxSurWVvQnNVq37yFkWIQ797P02DZY3WVaubIevjUabbfBqeHTiZFBTm5aWcN
	8mKkW+xnSGWRz/qfXkyisLsI55Et3uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=FWyyTVVLpIXFQgr/VV2sXnRR0pxWybQ9Np52/d4tpc7JSsggtTic5PqIEvd9+c37xTrqZq
	qEmmN78CYqrjn2CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e+2sTR3N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YHcTOh35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=e+2sTR3NLIPhsudzRRZXAuiZWxvVOSxs3ho549QjdLN756QMDiRVDqPMmyGG7rHzBo/NWb
	bnp0a68ZsKTKV0pz54tE0xn4W55gxRHcCPvaOKY5/7sFX6pQYRXva56heR0wjBh64OWEd3
	ACSZav5bNNqrSiBgFEUslS9jvGmgkxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdtdL83ySdzVcOjcM/If1HVX/MdEz/8nkOEt4H8mAMA=;
	b=YHcTOh35iZh/BRTK8lD+n7XiCATU9tLk6XmoENjWc7QDZZVyHPXC4MflA4WTJ7Gh0R48XY
	vKtZwuDZX8t+nvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FEA713876;
	Tue, 29 Jul 2025 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEp1A4KCiGhZNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 08:12:50 +0000
Message-ID: <2a9c71e0-f29d-46b6-823d-a957b10b4858@suse.de>
Date: Tue, 29 Jul 2025 10:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] net/handshake: get negotiated tls record size limit
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 dlemoal@kernel.org, chuck.lever@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B4CFB21A26
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,wdc.com,kernel.org,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,talpey.com,lists.linux.dev,vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLhu34id7c3duw89qhx7eswje4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 7/29/25 04:41, Wilfred Mallawa wrote:
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
>   Documentation/netlink/specs/handshake.yaml |  3 +++
>   Documentation/networking/tls-handshake.rst |  8 +++++++-
>   drivers/nvme/host/tcp.c                    |  3 ++-
>   drivers/nvme/target/tcp.c                  |  3 ++-
>   include/net/handshake.h                    |  4 +++-
>   include/uapi/linux/handshake.h             |  1 +
>   net/handshake/genl.c                       |  5 +++--
>   net/handshake/tlshd.c                      | 15 +++++++++++++--
>   net/sunrpc/svcsock.c                       |  4 +++-
>   net/sunrpc/xprtsock.c                      |  4 +++-
>   10 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index b934cc513e3d..35d5eb91a3f9 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -84,6 +84,9 @@ attribute-sets:
>           name: remote-auth
>           type: u32
>           multi-attr: true
> +      -
> +        name: record-size-limit
> +        type: u32
>   
>   operations:
>     list:
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index 6f5ea1646a47..cd984a137779 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -169,7 +169,8 @@ The synopsis of this function is:
>   .. code-block:: c
>   
>     typedef void	(*tls_done_func_t)(void *data, int status,
> -                                   key_serial_t peerid);
> +                                   key_serial_t peerid,
> +                                   size_t tls_record_size_limit);
>   
>   The consumer provides a cookie in the @ta_data field of the
>   tls_handshake_args structure that is returned in the @data parameter of

Why is this exposed to the TLS handshake consumer?
The TLS record size is surely required for handling and processing TLS
streams in net/tls, but the consumer of that (eg NVMe-TCP, NFS)
are blissfully unaware that there _are_ such things like TLS records.
And they really should keep it that way.

So I'd really _not_ expose that to any ULP and keep it internal to
the TLS layer.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

