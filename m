Return-Path: <linux-nfs+bounces-13712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B62B2A2C2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559EB560483
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8B31E103;
	Mon, 18 Aug 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AvhKbEy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c7DKhGrX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AvhKbEy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c7DKhGrX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5E31E0FA
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521540; cv=none; b=Itccc19ByCNDQs00+XEtkalE5P70cCPfWfuJ4kqZqTAWTUQff5F4+zgHLqljF633P/JJt0SRmfr06/MaFH0H282Bi3qm7d1WD6nZJy5ah+ZA5A6e9t0opGCSQN5EGTtydItRA8MYl12tDOJFTB4eCuZ0dXKiYw679tuXT6XzWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521540; c=relaxed/simple;
	bh=zfyzDSAVxnMaaSs01hyHjmHTlAAMSq3eN1p2RnLSdz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru4dnAe6Mq6oBla1tFFt5JjdK/OdYpMg05qsGc0oJcn/GBX5JGdsaVf7DVeBJ+E8g8wcmU8Yn/iKltQqLSPQn/KR2oCuNfByE8Fl5ZwSvARtDuvNzyCIueaWS5e0VpkwzFmpyRIpl5vng2KlDz54UDZ/3DYiwmt6ok8haU7nmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AvhKbEy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c7DKhGrX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AvhKbEy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c7DKhGrX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A37E51F44E;
	Mon, 18 Aug 2025 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755521535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=AvhKbEy19hKEV2FFEiHgKDM8P8hVYDU59C7pdywm8+FgDQ6VNld014PFPF2qu77nm40k0j
	lmwGJ5rbhFW6V5LnOTOvG9SaayZGPNcSqstuc/4Csq6U9Utx3HdUQJhOwJJFU1kcNFxxnU
	7+sJ7fwbqe/cfEuQTzVq3bd26gZqN7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755521535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=c7DKhGrXdg8go5WZN1alZFwPx+wb0ZMA03t7v79QmYiQB705wP187YVYmqgVrBDYcQ7fIs
	mUMxMzl4zH+kpAAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AvhKbEy1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c7DKhGrX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755521535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=AvhKbEy19hKEV2FFEiHgKDM8P8hVYDU59C7pdywm8+FgDQ6VNld014PFPF2qu77nm40k0j
	lmwGJ5rbhFW6V5LnOTOvG9SaayZGPNcSqstuc/4Csq6U9Utx3HdUQJhOwJJFU1kcNFxxnU
	7+sJ7fwbqe/cfEuQTzVq3bd26gZqN7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755521535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYgRIvxhgQ9HCB25wkduiasp17FHQMerfEPYfWkM8W4=;
	b=c7DKhGrXdg8go5WZN1alZFwPx+wb0ZMA03t7v79QmYiQB705wP187YVYmqgVrBDYcQ7fIs
	mUMxMzl4zH+kpAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BEC13686;
	Mon, 18 Aug 2025 12:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kwDmIv4ho2ilewAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 12:52:14 +0000
Message-ID: <107506e2-7870-45df-b595-583b57137a29@suse.de>
Date: Mon, 18 Aug 2025 14:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
 <20250815050210.1518439-7-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250815050210.1518439-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ietf.org:url,wdc.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A37E51F44E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/15/25 07:02, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event.
> 
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 63 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index cc3332529355..0c14d3ad58af 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		user_key_serial;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -1313,6 +1314,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	struct nvme_tcp_request *req;
>   	unsigned int noreclaim_flag;
>   	int ret = 1;
> +	enum nvme_ctrl_state state = nvme_ctrl_state(&(queue->ctrl->ctrl));
>   
>   	if (!queue->request) {
>   		queue->request = nvme_tcp_fetch_request(queue);
> @@ -1347,6 +1349,29 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   done:
>   	if (ret == -EAGAIN) {
>   		ret = 0;
> +	} else if (ret == -EKEYEXPIRED &&
> +		state != NVME_CTRL_CONNECTING &&
> +		state != NVME_CTRL_RESETTING) {
> +		int qid = nvme_tcp_queue_id(queue);
> +
> +		dev_dbg(queue->ctrl->ctrl.device,
> +			"updating key for queue %d\n", qid);
> +
> +		nvme_change_ctrl_state(&(queue->ctrl->ctrl), NVME_CTRL_RESETTING);

Rah. Don't do that.
The 'resetting' state is tied to the resetting mechanism
(LIVE->RESETTING->CONNECTING->LIVE) and is being relied on
for the timeout handler. Setting it manually will confuse error
handling.

And really, having the key update in two places is a bit ... odd.
I'd rather stop the I/O queue in nvme_tcp_io_work() once a
EKEYEXPIRED error has been hit, and start the key update via
nvme_tcp_start_tls() function directly from there.
No need to change the controller state.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

