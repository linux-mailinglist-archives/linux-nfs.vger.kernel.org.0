Return-Path: <linux-nfs+bounces-15394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C47BEF760
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 08:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1793AEFCE
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673929A1;
	Mon, 20 Oct 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lJdM9UjT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z931M2vc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15FKwpUC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lUtwmzhq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80CE2D6E71
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941348; cv=none; b=HP6y/FeW283UJ/qj/9Gyw8rqHXscZ87Ts5GD5EV3rD5zNq+HcjOdkrpVmfezhe2QkEZN+uWEXwjjr5im2cCAaxzAp/l3bfuiMDi/4dOkvEUjXHg7joxwjaHEjqw3EdPZRVAc+r79NwLRuF4NT61qI8Oseon1TZPcousgaRGTZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941348; c=relaxed/simple;
	bh=R3hR8SX/CGpcZ1lUAXiJem3B9VtfgYmqzBVpUxFmE0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSPOK8v84HeMN1QxozIwEkocsLNVcKIVS36HFzUggSWUqJBDi8hM/1b1b1kS4Im7f7GVWKEcU0KDPTS+SB6AYrVDRX+COIXmcIzvN0Otlo1VNedJ6m/Ym//gs59K4WWbyIOfWXV3eqvm4ePh0LxbB2r1PCPIWwkv/2aojnnkNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lJdM9UjT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z931M2vc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15FKwpUC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lUtwmzhq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65FDC2118D;
	Mon, 20 Oct 2025 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLOFUBn1T2+9I+mMFgCTxQAiQFct96bRIkxGDB6nyXc=;
	b=lJdM9UjT2ee8jEy1avvD36asU6kosjyGRPChgnZy0k8vZ+tRYz1RxvuQPL4DTT78z0TFEa
	a2sW9R10S7XC4XujVRvS5faLY0eEtMNie9jK7G846yEnMzdnphHogkNK+YDI09TIVPD8Jk
	GPOqcmsVapnXRCVM92p1MOZU81FgjHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLOFUBn1T2+9I+mMFgCTxQAiQFct96bRIkxGDB6nyXc=;
	b=z931M2vcsaIAil9YBjlU7s2tm7kr/z7y1irMQ290+kd1Vdp9jQURl/eoGKR/QIgV5GycNX
	truG9G7YWHx8uQBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=15FKwpUC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lUtwmzhq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLOFUBn1T2+9I+mMFgCTxQAiQFct96bRIkxGDB6nyXc=;
	b=15FKwpUCxOfh7gJ1/Utp+yyd5yX7QNGzZAX29NnB7IDWb1rUorDdCn6b81rB6QBj9zxBOF
	Oi034UibfQUkR20ykFFpAGQ1c2M/vRJF/zg/iy8c4eqIqoIZ7KI6AmX0JnewzFJ/VOagti
	FUnd+Uskvtco6URBkfo82hjKdjomFr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLOFUBn1T2+9I+mMFgCTxQAiQFct96bRIkxGDB6nyXc=;
	b=lUtwmzhqm0oUk0NCX9vJYtwvZDq+R+k/RsYQWmw1iAYwkNfYA3cXNspXLbsAeoIkYE5gYZ
	eJc3wcaHVG0si+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B2B13A8E;
	Mon, 20 Oct 2025 06:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dTCjNRHV9WipVAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Oct 2025 06:22:09 +0000
Message-ID: <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
Date: Mon, 20 Oct 2025 08:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251017042312.1271322-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65FDC2118D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/17/25 06:23, alistair23@gmail.com wrote:
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
>   drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 2696bf97dfac..791e0cc91ad8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		user_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
>   static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   {
>   	char *pdu = queue->pdu;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
>   		.msg_flags = MSG_DONTWAIT,
>   	};
>   	struct kvec iov = {
> @@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   	if (ret <= 0)
>   		return ret;
>   
> +	hdr = queue->pdu;
> +	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
> +		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> +		return 1;
> +	}
> +
>   	queue->pdu_remaining -= ret;
>   	queue->pdu_offset += ret;
>   	if (queue->pdu_remaining)
>   		return 0;
>   
> -	hdr = queue->pdu;
>   	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
>   		if (!nvme_tcp_recv_pdu_supported(hdr->type))
>   			goto unsupported_pdu;
> @@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   
>   	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>   		return 0;
> @@ -973,12 +983,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   		memset(&msg, 0, sizeof(msg));
>   		msg.msg_iter = req->iter;
>   		msg.msg_flags = MSG_DONTWAIT;
> +		msg.msg_control = cbuf,
> +		msg.msg_controllen = sizeof(cbuf),
>   
Watch out. This is the recvmsg bug Olga had been posting patches for.
Thing is, if there is a control message the networking code will place
the control message payload into the message buffer. But in doing so
it expects the message buffer to be an iovec, not a bio vec.

To handle this properly you'd need to _not_ set the control buffer,
but rather check for 'MSG_CTRUNC' in msg_flags upon return.
Then you have to setup a new message with msg_control set and
a suitable msg_len (5 bytes, wasn't it?) and re-issue recvmsg
with that message.

And keep fingers crossed that you don't get MSG_CTRUNC on every
call to recvmsg() ...

>   		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>   		if (ret < 0) {
> -			dev_err(queue->ctrl->ctrl.device,
> -				"queue %d failed to receive request %#x data",
> -				nvme_tcp_queue_id(queue), rq->tag);
> +			dev_dbg(queue->ctrl->ctrl.device,
> +				"queue %d failed to receive request %#x data, %d",
> +				nvme_tcp_queue_id(queue), rq->tag, ret);
>   			return ret;
>   		}
>   		if (queue->data_digest)
> @@ -1381,17 +1393,42 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>   		}
>   	} while (result >= 0);
>   
> -	if (result < 0 && result != -EAGAIN) {
> +	if (result == -EKEYEXPIRED) {
> +		return -EKEYEXPIRED;
> +	} else if (result == -EAGAIN) {
> +		return -EAGAIN;
> +	} else if (result < 0) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"receive failed:  %d\n", result);
>   		queue->rd_enabled = false;
>   		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> -	} else if (result == -EAGAIN)
> -		result = 0;
> +	}
>   
>   	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
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
> +	flush_work(&(queue->ctrl->ctrl).async_event_work);
> +
> +	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> +				 queue, queue->ctrl->ctrl.tls_pskid,
> +				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"failed to update the keys %d\n", ret);
> +		nvme_tcp_fail_request(queue->request);
> +		nvme_tcp_done_send_req(queue);
> +	}
> +}
> +
>   static void nvme_tcp_io_work(struct work_struct *w)
>   {
>   	struct nvme_tcp_queue *queue =
> @@ -1414,8 +1451,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		result = nvme_tcp_try_recvmsg(queue);
>   		if (result > 0)
>   			pending = true;
> -		else if (unlikely(result < 0))
> -			return;
> +		else if (unlikely(result < 0)) {
> +			if (result == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			break;
> +		}
>   
>   		/* did we get some space after spending time in recv? */
>   		if (nvme_tcp_queue_has_pending(queue) &&
> @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +		queue->user_session_id = user_session_id;

Hmm. I wonder, do we need to store the generation number somewhere?
Currently the sysfs interface is completely oblivious that a key update
has happened. I really would like to have _some_ indicator there telling
us that a key update had happened, and the generation number would be
ideal here.

>   	}
>   
>   out_complete:
> @@ -1752,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		keyring = key_serial(nctrl->opts->keyring);
>   	args.ta_keyring = keyring;
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	args.user_session_id = queue->user_session_id;
>   	queue->tls_err = -EOPNOTSUPP;
>   	init_completion(&queue->tls_complete);
>   	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)

Chers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

