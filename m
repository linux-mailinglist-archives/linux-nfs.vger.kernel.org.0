Return-Path: <linux-nfs+bounces-19721-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBytJQXip2mrlAAAu9opvQ
	(envelope-from <linux-nfs+bounces-19721-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 08:40:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A31FBBB7
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 08:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C83E30160E6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC837266A;
	Wed,  4 Mar 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E6vGClwN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+nB8IvXR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="geFxisl7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42wvlBEb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F29370D54
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610007; cv=none; b=XQ8VVVLMr4p3f11fEwvzOej/CGfXFWPzk6agi3TnCvhB7qjCulAbPir0pT/24WpQmGcgZRA1CvnZVCzR/ms4+eCpyAf/IVCCyExi228JN9S/VHqLVbPP0B1yjlwPSt8ugI6/uF4ZxugV6RKYlclpeS120UE9b19/gS3MVJd6ICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610007; c=relaxed/simple;
	bh=9XDwVawTB5i0dwNPOvXRjbdJoKpYXoXFga4KM/0Z2gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+NoqfAJt7iqbbRtYXXVZhh1EdnOpXLCgcfY+q/eQUSSAoFdBYUJPJ/X47n1Ce20ZFgxs87a6Qb2lyIhHIx8v1S3jy4/8GFcgcm84zjgU3ecR5CPRijtLIDvfyEA95yGkMLbWnYchujJ/VUSi4bRx2ZnFT+IRkiPZitWRF64YwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E6vGClwN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+nB8IvXR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=geFxisl7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42wvlBEb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3AA13F778;
	Wed,  4 Mar 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=E6vGClwNDLUB3Nt39zL+Uv4g1EKF3tgURy5iNvMD+VJarmFyYTHzOFjvUMo6scb5TIqdJK
	iy599/BxOghpLpRIZ8sRdbl7kaS+jg9Mm4Lg5M9ibzncHs1KqFXu5BI5dQnk5LdP9vgSEU
	P5t7B9zcIzbSieTxh7iKt+5IhPtUvS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=+nB8IvXRH00vrXkJdtdgl4/RhZYEQdVF1yhm1Gi4gfTza1Uq+1pq/Iwdv7DkR5NxYWC6qS
	pkQeJfnDaErPEuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=geFxisl7YkRy/RMf7sQhkfF87QEmHXiE6wv3B9DQ8u8rO8C4RgLdwgNfxotkflNc0A1oiN
	sU4O9kj2lIb95pICnKkjyNYhKX9LuomKgsUbr94Ck1T//ofYkoxkZDAyPOoS1UN//mEIGB
	nGq0Tgzq3N3PHcXl1uDnZHTaCkUbhGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx6QBAZ/g48FrY3KwtZ+m4mLgleN1Z8nKszuKUbXlAA=;
	b=42wvlBEbt9zZEV1FWhsWg2TdimuiQ5+IIAlcFn92nVDxXbn0xY6zUvpMi4Vttjl5GHkeyI
	ifX1ghQc5aBpXbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2F733EA69;
	Wed,  4 Mar 2026 07:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytg2MtDhp2kWWgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:40:00 +0000
Message-ID: <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
Date: Wed, 4 Mar 2026 08:40:00 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
 <20260304053500.590630-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260304053500.590630-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 0E6A31FBBB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19721-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/4/26 06:34, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event as described in RFC8446
> https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
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
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v7:
>   - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
> v6:
>   - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
>     instead look at the cmsg fields.
>   - Don't flush async_event_work
> v5:
>   - Cleanup code flow
>   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
>     and use that to determine if it's a control message
> v4:
>   - Remove all support for initiating KeyUpdate
>   - Don't call cancel_work() when updating keys
> v3:
>   - Don't cancel existing handshake requests
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
> 
>   drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8b6172dd1c0f..ade11d2ac9ef 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		handshake_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	return ret;
>   }
>   
> +static void update_tls_keys(struct nvme_tcp_queue *queue)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +
> +	dev_dbg(queue->ctrl->ctrl.device,
> +		"updating key for queue %d\n", qid);
> +
> +	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> +				 queue, queue->ctrl->ctrl.tls_pskid,
> +				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"failed to update the keys %d\n", ret);
> +		nvme_tcp_fail_request(queue->request);
> +	}
> +}
> +
> +static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
> +			      struct sk_buff *skb,
> +			      unsigned int offset, size_t len,
> +			      u8 content_type)
> +{
> +	struct nvme_tcp_queue *queue = desc->arg.data;
> +	struct socket *sock = queue->sock;
> +	struct sock *sk = sock->sk;
> +
> +	switch (content_type) {
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		if (len == 5) {
> +			u8 header[5];
> +
> +			if (!skb_copy_bits(skb, offset, header,
> +					   sizeof(header))) {
> +				if (header[0] == TLS_HANDSHAKE_KEYUPDATE) {
> +					dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> +					release_sock(sk);
> +					update_tls_keys(queue);
> +					lock_sock(sk);
> +					return 0;
> +				}
> +			}
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}

I think a simple 'if' condition would be sufficient here, or do you have
handling of other TLS record types queued somewhere?
And we should log unhandled TLS records.

> +
> +	return -EAGAIN;
> +}
> +
>   static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   {
>   	struct socket *sock = queue->sock;
> @@ -1372,7 +1426,8 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	rd_desc.count = 1;
>   	lock_sock(sk);
>   	queue->nr_cqe = 0;
> -	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> +	consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
> +					     nvme_tcp_recv_cmsg);
>   	release_sock(sk);
>   	return consumed == -EAGAIN ? 0 : consumed;
>   }
> @@ -1708,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +		queue->handshake_session_id = handshake_session_id;
>   	}
>   
>   out_complete:
> @@ -1737,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		keyring = key_serial(nctrl->opts->keyring);
>   	args.ta_keyring = keyring;
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	args.ta_handshake_session_id = queue->handshake_session_id;
>   	queue->tls_err = -EOPNOTSUPP;
>   	init_completion(&queue->tls_complete);
>   	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

