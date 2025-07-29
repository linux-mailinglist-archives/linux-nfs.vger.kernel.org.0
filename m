Return-Path: <linux-nfs+bounces-13301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C162AB149E3
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5DA4E1C62
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D51275B11;
	Tue, 29 Jul 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJ0c3WD4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="olujNJvS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0intH50C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0gyD29RH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92426772D
	for <linux-nfs@vger.kernel.org>; Tue, 29 Jul 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776968; cv=none; b=JrHq7j/YBZ5LHQI23eAK+U2dEpxVL808ZnLmrN5vSIq23DYQZme9aKmehlpk7ZjB8Epj1rRt4NySqH88uqqa6h5rZwBPk+GI7Nvqt8+yQM0Irt6h3KC/y1wU3rdMbmFKCVE8GWvn4ae2Sa2YuV+hfWBR5uKX7xuLgu1Z3HOHvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776968; c=relaxed/simple;
	bh=5zBxt8BGt0kD4DcBU7V21ko4qu9JxivrvnZahvhx9+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA5t/SQnH6xg6o0i1Ifqa1Hon79HDaV8wu5FZ0Qn5hV7MxAz9fpSVxqVdlC3/0HJ2uRbJVmALMbbyQRwexESO8bpZGYIXyzoOG4VdfUf6avtTi84WkBEx6YjBa9HNAnPhSm5ToEsNgWoCinGdHCUf2T/eNUN9fs823uxSoX/qBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJ0c3WD4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=olujNJvS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0intH50C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0gyD29RH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C3081F80B;
	Tue, 29 Jul 2025 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=GJ0c3WD4kjLuIp2C32cnvYy6mc2r0HmUpXAFCsclXR0Nw0uHyFXZRPgP/YJ7RvII12oDHW
	g2fQ6k8TZHOxlVap6cYYgZPATK6i4Ioc2kwTPaY26uiyPoFXa0LuJg7sky/PNikyC3GZcD
	UzZO4MoPgZ8/hd8zm9xuVZkRFoZdKCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=olujNJvSHCBAEP88q7DrAIervIA4Ranlw/EzJJYWgigy7qG+ub8cBnyQIXpwxZBBIacQvD
	Vwcpd+rwbFqpdSAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753776964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=0intH50C/KDxShfyGFUJh9wpBFKFW7iTucCxAf6wja7RCXAmR9XKLIndfz8gNDx3kYabQd
	fMsos368oBLBzSDMuHkx0V7KwDSypuH69CCROo4Jn/SrTpL11PayW9jnzm6ua+HqO/Rp+R
	zH+orCiuImHHx9hMvNN0/mN4+5OPn5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753776964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKf3Ld7GMpkyIUFZbTHgf11MFWoxhHkxt7VOXonGCy4=;
	b=0gyD29RHT9Qr1JcIysSgnO/ifhMy2hcAt4uB183ZFZ6iDgR1phPROOkuPXw0o5AjgtvelO
	gP2Z1IkstBjFHXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2503A13876;
	Tue, 29 Jul 2025 08:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJhKCEODiGj7NgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 08:16:03 +0000
Message-ID: <7e18e224-ba9f-420d-ad2e-e349d25b58e0@suse.de>
Date: Tue, 29 Jul 2025 10:16:02 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] nvme/host/tcp: set max record size in the tls context
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
 <20250729024150.222513-6-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729024150.222513-6-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLh3g55kcpku8oef9ktzra4k57)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,wdc.com,kernel.org,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,talpey.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 7/29/25 04:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a tls handshake, a host may specify the tls record size limit
> using the tls "record_size_limit" extension. Currently, the NVMe TCP
> host driver does not specify this value to the tls layer.
> 
> This patch adds support for setting the tls record size limit into the
> tls context, such that outgoing records may not exceed this limit
> specified by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 65ceadb4ffed..84a55736f269 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1677,6 +1677,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			      size_t tls_record_size_limit)
>   {
>   	struct nvme_tcp_queue *queue = data;
> +	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
>   	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>   	int qid = nvme_tcp_queue_id(queue);
>   	struct key *tls_key;
> @@ -1700,6 +1701,20 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +
> +		/* Endpoint has specified a maximum tls record size limit */
> +		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
> +			dev_err(ctrl->ctrl.device,
> +				"queue %d: invalid tls max record size limit: %zd\n",
> +				nvme_tcp_queue_id(queue), tls_record_size_limit);
> +			queue->tls_err = -EINVAL;
> +			goto out_complete;
> +		} else if (tls_record_size_limit > 0) {
> +			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
> +			dev_dbg(ctrl->ctrl.device,
> +				"queue %d: target specified tls_record_size_limit %u\n",
> +				nvme_tcp_queue_id(queue), tls_ctx->tls_record_size_limit);
> +		}
>   	}
>   
>   out_complete:

Why do we need to do that?
This value is never used in that driver, so why can't the TLS layer 
handle it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

