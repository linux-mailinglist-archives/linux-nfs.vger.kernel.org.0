Return-Path: <linux-nfs+bounces-13302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA50B149EB
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A163A5999
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57127BF85;
	Tue, 29 Jul 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ENbrR8y0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r8qxkebH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iTaV1cmq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4+Bzf8c4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542127A123
	for <linux-nfs@vger.kernel.org>; Tue, 29 Jul 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777019; cv=none; b=lkfDV0JLPyZc6tdJqVp4ogAcpjmztbvCY5WDnXmd0AInZVw5GZSVrqV8589dz471vl2+8rjrhEqMrwlPOldJM75iGlsLCnY+0JKMiav4gjHddz5SIi1DEutSXogyK/JyJ6QUt2zoQ8cvWaCYv5EzBXqsnZQHoMfyc36YRY5kS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777019; c=relaxed/simple;
	bh=xEMJxaJq2XYIcXrL4NNIaY5wH7OkEvW+t3Rn+DQhA4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii5rxuGx+B+Oy0koHAl1uun95pCjZ7eCPgA+TKRTEVBB4Nk1TEr83wamuyT19NJVEcOUx3VMXja9HF+z49pSrwv8B2QvsWdoX0sfy8yhFbZiEE38+GS9EiVKbW5uLLXVpt426qm0MI0uO5QO9LldmKZZo5znWe9VSqaMuq3OvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ENbrR8y0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r8qxkebH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iTaV1cmq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4+Bzf8c4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3F17219EE;
	Tue, 29 Jul 2025 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753777010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=ENbrR8y0h9sYQ9VqCDBKwiY+mwKM4c9w5COpbioJtplUI+4cGemJvvVj/9muB4CulQiF3i
	BGJnajQxSRvlfjO2kd0LfezZN7Vn3iiyd395694j9lP6Ifh5UawBWhqZ6OZYw2UqvxoLNH
	zmvUUQKnZkkFUT7zK8e7oDF1JfRJBMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753777010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=r8qxkebHUBSbmI/LyFKMwOeB7QlHIAM8pA+/l55u5AeTFIExFe9Wnz/vd62cpB9vgjHW+e
	o4KA/rY5jOvrQsBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iTaV1cmq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4+Bzf8c4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753777009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=iTaV1cmqqBGDrMYnlAI1K3KQa47nelnskJQ2pHt0cGSPGd8bjuLUEMan7BTBuJWopIlEQM
	ocyneezXYvP1lFDYKzHtspkcxYKqU4UtKt2LovCEWIZ4rp4FweeRCsBwIG+jQvHOpuV5Dq
	ExdcozV81Blcnh/LBidfzKzwjhPdXfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753777009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwdTTHdeOVI0z++8NUCczywVnQjEIDhs65XxyQb9Kfc=;
	b=4+Bzf8c4476+e9thuIX+OaX5NFXgGffWpsXoU+yjkXaK5qYtkoexCTbDp3LWN1vIW+3bxH
	tz6dgX9UkwnqYYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51F9113876;
	Tue, 29 Jul 2025 08:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AmvkEnCDiGhKNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 08:16:48 +0000
Message-ID: <3339e2d0-02ac-470a-9511-0e60ed1d0598@suse.de>
Date: Tue, 29 Jul 2025 10:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] nvme/target/tcp: set max record size in the tls context
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
 <20250729024150.222513-7-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729024150.222513-7-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: F3F17219EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 7/29/25 04:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a tls handshake, a host may specify the tls record size limit
> using the tls "record_size_limit" extension. Currently, the NVMe target
> driver does not specify this value to the tls layer.
> 
> This patch adds support for setting the tls record size limit into the
> tls context, such that outgoing records may not exceed this limit
> specified by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   drivers/nvme/target/tcp.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 60e308401a54..f2ab473ea5de 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1784,6 +1784,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   					size_t tls_record_size_limit)
>   {
>   	struct nvmet_tcp_queue *queue = data;
> +	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
>   
>   	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>   		 queue->idx, peerid, status);
> @@ -1795,6 +1796,17 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	if (!status) {
>   		queue->tls_pskid = peerid;
>   		queue->state = NVMET_TCP_Q_CONNECTING;
> +
> +		/* Endpoint has specified a maximum tls record size limit */
> +		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
> +			pr_err("queue %d: invalid tls max record size limit: %zu\n",
> +			       queue->idx, tls_record_size_limit);
> +			queue->state = NVMET_TCP_Q_FAILED;
> +		} else if (tls_record_size_limit > 0) {
> +			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
> +			pr_debug("queue %d: host specified tls max record size %u\n",
> +				 queue->idx, tls_ctx->tls_record_size_limit);
> +		}
>   	} else
>   		queue->state = NVMET_TCP_Q_FAILED;
>   	spin_unlock_bh(&queue->state_lock);
> @@ -1808,6 +1820,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   		nvmet_tcp_schedule_release_queue(queue);
>   	else
>   		nvmet_tcp_set_queue_sock(queue);
> +
>   	kref_put(&queue->kref, nvmet_tcp_release_queue);
>   }
>   
Again, why?

I'd rather have the TLS layer handling that internally.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

