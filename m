Return-Path: <linux-nfs+bounces-14989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C949BBD242
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 08:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21143348F84
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 06:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC3253F20;
	Mon,  6 Oct 2025 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvAuT5t1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FKyFmYGH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvAuT5t1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FKyFmYGH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2424DCE3
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732479; cv=none; b=p8RlWTwfD/jLaMxVaL8JfYIySR2NMPd4RWCc1BP4K6QVf6kvtd/60ZnWHk0Yka0/JqR0sr+wIM6iXzpF0jt7STbvJj+R3rtuH06PerFlM80rFyFeJPRVvorsHtlXlEg87h3ic5/dygovmiPcbDBJDFmw4pY5rAkb42l3UAr5pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732479; c=relaxed/simple;
	bh=Ae5gTWLovklh+FqGRtXymU68wdsxJ5kWKtQkGl//gCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rtm5vs9NxGNPtH9Ocs0K0mChTfHHziLCK2J2Hkm0UpqcBBlPUeM65dDqawahFC6Ke+JydXMqoBtp4pH7lmFWMBdE8bpfsAlXysKmSdeDwjXd/6Ua2mjvAhSvk0CzQCwTo3m3fTd4Ls7oFbM0EiUh2ZUs52DOFUxYTBJwLoSpt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvAuT5t1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FKyFmYGH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvAuT5t1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FKyFmYGH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19A3F3373A;
	Mon,  6 Oct 2025 06:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759732475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8Vop5batSSCeAdThB/ZJXAyRy+Z8FoB67Z2pTCV+7Y=;
	b=hvAuT5t1QEv0R3TFDiDmMnuityVQPASfk9u/Ag6O8QCO52lGZYdmRTtIPSK542mk7HilFN
	JjL9hrpKPjtMiTHslC4mmeVCqjHd/JbvnfNKAVOmV8cDfjMh2jA8gy3DcUMy6KRXKk4O8x
	2k+ebdw091X9PHom19Q4DXEq0W5Zd/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759732475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8Vop5batSSCeAdThB/ZJXAyRy+Z8FoB67Z2pTCV+7Y=;
	b=FKyFmYGH+LkytDTq655Q4y7n2ZVjQzJGfKaIjCRIKS+mjooQcsrbFugJo+P75mCtAuTRcD
	P0w9NSADKFEEMsAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hvAuT5t1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FKyFmYGH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759732475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8Vop5batSSCeAdThB/ZJXAyRy+Z8FoB67Z2pTCV+7Y=;
	b=hvAuT5t1QEv0R3TFDiDmMnuityVQPASfk9u/Ag6O8QCO52lGZYdmRTtIPSK542mk7HilFN
	JjL9hrpKPjtMiTHslC4mmeVCqjHd/JbvnfNKAVOmV8cDfjMh2jA8gy3DcUMy6KRXKk4O8x
	2k+ebdw091X9PHom19Q4DXEq0W5Zd/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759732475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8Vop5batSSCeAdThB/ZJXAyRy+Z8FoB67Z2pTCV+7Y=;
	b=FKyFmYGH+LkytDTq655Q4y7n2ZVjQzJGfKaIjCRIKS+mjooQcsrbFugJo+P75mCtAuTRcD
	P0w9NSADKFEEMsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92DC213995;
	Mon,  6 Oct 2025 06:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IZlZIfpi42hPCwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:34:34 +0000
Message-ID: <00b0fca9-e9d1-4d04-9a43-5fe3d047e4d6@suse.de>
Date: Mon, 6 Oct 2025 08:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-7-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 19A3F3373A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 10/3/25 06:31, alistair23@gmail.com wrote:
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
> v3:
>   - Don't cancel existing handshake requests
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
> 
>   drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 54 insertions(+), 6 deletions(-)
> 
Weelll ... Checking the code the network stack will only return
-EKEYEXPIRED on recvmsg() (as it parses the TLS message on receive).
So really this is handling an incoming KeyUpdate request only.
And I would keep it that way, as initiating a KeyUpdate request
is quite different (conceptually) than handling an incoming one.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b07401ad68eb..4f27319f0078 100644
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
> @@ -211,6 +212,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   			      struct nvme_tcp_queue *queue,
>   			      key_serial_t pskid,
>   			      handshake_key_update_type keyupdate);
> +static void update_tls_keys(struct nvme_tcp_queue *queue);
>   
>   static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
>   {
> @@ -394,6 +396,14 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   	do {
>   		ret = nvme_tcp_try_send(queue);
>   	} while (ret > 0);
> +
> +	if (ret == -EKEYEXPIRED) {
> +		update_tls_keys(queue);
> +
> +		do {
> +			ret = nvme_tcp_try_send(queue);
> +		} while (ret > 0);
> +	}
>   }
>   
See above. I'd rather have two patches, one for handling incoming
KeyUpdate message (where we'd see an EKEYEXPIRED on receive), and
another one for initiating KeyUpdates.

>   static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
> @@ -1346,6 +1356,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   done:
>   	if (ret == -EAGAIN) {
>   		ret = 0;
> +	} else if (ret == -EKEYEXPIRED) {
> +		goto out;
>   	} else if (ret < 0) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"failed to send request %d\n", ret);

See above.

> @@ -1381,17 +1393,45 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>   		}
>   	} while (result >= 0);
>   
> -	if (result < 0 && result != -EAGAIN) {
> +	if (result == -EKEYEXPIRED) {
> +		return -EKEYEXPIRED;
> +	} else if (result == -EAGAIN) {
> +		result = 0;
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
Remind me again to resend my tcp_recvmsg patch. The blanking out
of -EAGAIN is actually wrong.

> +static void update_tls_keys(struct nvme_tcp_queue *queue)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +
> +	dev_dbg(queue->ctrl->ctrl.device,
> +		"updating key for queue %d\n", qid);
> +
> +	cancel_work(&queue->io_work);
> +
Hmm.
You issue a 'cancel_work()', but later on you call this
function from within the workqueue context. Not a great
idea.
I'd rather calling 'update_tls_keys()' from io_work() only,
and drop the 'cancel_work()' invocation as that would be
pointless now.

> +	nvme_stop_keep_alive(&(queue->ctrl->ctrl));
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
> @@ -1407,15 +1447,21 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   			mutex_unlock(&queue->send_mutex);
>   			if (result > 0)
>   				pending = true;
> -			else if (unlikely(result < 0))
> +			else if (unlikely(result < 0)) {
> +				if (result == -EKEYEXPIRED)
> +					update_tls_keys(queue);
>   				break;
> +			}
>   		}
>   
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
> @@ -1723,6 +1769,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   			ctrl->ctrl.tls_pskid = key_serial(tls_key);
>   		key_put(tls_key);
>   		queue->tls_err = 0;
> +		queue->user_session_id = user_session_id;
>   	}
>   
>   out_complete:
> @@ -1752,6 +1799,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		keyring = key_serial(nctrl->opts->keyring);
>   	args.ta_keyring = keyring;
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	args.user_session_id = queue->user_session_id;
>   	queue->tls_err = -EOPNOTSUPP;
>   	init_completion(&queue->tls_complete);
>   	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);

Cheers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

