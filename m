Return-Path: <linux-nfs+bounces-14486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376EB596E1
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07573B31D2
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D01A9FB4;
	Tue, 16 Sep 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ABaUMkrg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EZ0J10S9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QHZ53mBL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="peEeA59n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255532D7DCD
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027859; cv=none; b=ZIfAszzzLmbdMk8HQZYfwA2EY68dfql/b53Eu4wMMhQRv7HCUL45BiQOSm3guRLfQ4CetexcraSV0E2YpcwDebuFkI3hb16llnJQM5EZa5kY4jorQryV9Qf1wX8Ma6lShHgN5d2OwBtBAv4zUeJFE118ZdgissNrjuw14I8npB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027859; c=relaxed/simple;
	bh=/eqp/iDZYlHEnsa4vuAVT4u/N0f+kUwO2etZb6Zrvfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGZogm4wU2AhqsG/ad9aTDs1Ayvzb/kSqdqcoQkYHAWbQyuRfoCOddvcsrduCDnGu5QMKzdx2n6ALx24xe/P/YIb1tgwpBgffLmTCosu3np+elQB/b6GE248gIWf0rYIBMvJ61qUU87vH8RoOsMC6joJCP0UGD9sbjRvrxquh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ABaUMkrg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EZ0J10S9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QHZ53mBL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=peEeA59n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B24F21CB5;
	Tue, 16 Sep 2025 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758027855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEaiEMMM28n+rEM/oEhzbsdplft5zfFjRRugUCJ3aLQ=;
	b=ABaUMkrgvIb8hV6oIbUbcc0WgdTpr6wDm5TzqqFEUM6VfAkqJHhNS7a/qQG0n9GKSf4OTq
	vaiRL0CAIOjbz/jd1bigQGueAviCk/JHqqHWqqSMATllQS1p+rcCqb7Al92biSOuJIahIy
	3e0I0PdeeIUG6wCS6S8RXI9m/oy9jYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758027855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEaiEMMM28n+rEM/oEhzbsdplft5zfFjRRugUCJ3aLQ=;
	b=EZ0J10S96HO8dwYjF5NSIR9icbMiB3TFlSYUEZq49imHRryQ9mBF2TUslu6u0+lFnIpjEL
	JzWahpYJ8iZ+HzAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QHZ53mBL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=peEeA59n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758027854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEaiEMMM28n+rEM/oEhzbsdplft5zfFjRRugUCJ3aLQ=;
	b=QHZ53mBLwhOpDZzdNVXcv7QuAejEj4nB4C5DJhmy281xEhKsefLCCG32IdeZazr2SCEEo5
	wSDosPnXiIZTlgcg8osh8VDWCvpkR0wv3Tt7nb+bnY9rWGStui22S1ZtAdPmiGM35KCj/Y
	+CNngRCUWq2yJ5+ne1U3J5doU+0HMko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758027854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEaiEMMM28n+rEM/oEhzbsdplft5zfFjRRugUCJ3aLQ=;
	b=peEeA59nroXgxW0jlx/AzyZYlNEoeGbm/7bHfvwxI6Sbdz7a+Eewbt/ruX1Vqh2yP8L4w6
	IpZsJ2pjHVXGxLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31DC9139CB;
	Tue, 16 Sep 2025 13:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DmmC05gyWioCQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Sep 2025 13:04:14 +0000
Message-ID: <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
Date: Tue, 16 Sep 2025 15:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-7-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905024659.811386-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6B24F21CB5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -4.51

On 9/5/25 04:46, alistair23@gmail.com wrote:
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
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
>   
>   drivers/nvme/host/tcp.c | 73 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 776047a71436..b6449effc2ac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		user_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -210,6 +211,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   			      struct nvme_tcp_queue *queue,
>   			      key_serial_t pskid,
>   			      handshake_key_update_type keyupdate);
> +static void update_tls_keys(struct nvme_tcp_queue *queue);
>   
>   static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
>   {
> @@ -393,6 +395,14 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
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
>   static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
> @@ -1347,6 +1357,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   done:
>   	if (ret == -EAGAIN) {
>   		ret = 0;
> +	} else if (ret == -EKEYEXPIRED) {
> +		goto out;
>   	} else if (ret < 0) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"failed to send request %d\n", ret);
> @@ -1371,9 +1383,56 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	queue->nr_cqe = 0;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>   	release_sock(sk);
> +
> +	/* If we received EINVAL from read_sock then it generally means the
> +	 * other side sent a command message. So let's try to clear it from
> +	 * our queue with a recvmsg, otherwise we get stuck in an infinite
> +	 * loop.
> +	 */
> +	if (consumed == -EINVAL) {
> +		char cbuf[CMSG_LEN(sizeof(char))] = {};
> +		struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
> +		struct bio_vec bvec;
> +
> +		bvec_set_virt(&bvec, (void *)cbuf, sizeof(cbuf));
> +		iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, sizeof(cbuf));
> +
> +		msg.msg_control = cbuf;
> +		msg.msg_controllen = sizeof(cbuf);
> +
> +		consumed = sock_recvmsg(sock, &msg, msg.msg_flags);
> +	}
> +
>   	return consumed == -EAGAIN ? 0 : consumed;
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
> +	cancel_work(&queue->io_work);
> +	handshake_req_cancel(queue->sock->sk);
> +	handshake_sk_destruct_req(queue->sock->sk);
> +
Careful here. The RFC fully expects to have several KeyUpdate requests
pending (eg if both sides decide so initiate a KeyUpdate at the same
time). And cancelling a handshake request would cause tlshd/gnutls
to lose track of the generation counter and generate an invalid
traffic secret.
I would just let it rip and don't bother with other handshake
requests.

> +	nvme_stop_keep_alive(&(queue->ctrl->ctrl));
> +	flush_work(&(queue->ctrl->ctrl).async_event_work);
> +
Oh bugger. Seems like gnutls is generating the KeyUpdate message
itself, and we have to wait for that.
So much for KeyUpdate being transparent without having to stop I/O...

Can't we fix gnutls to make sending the KeyUpdate message and changing
the IV parameters an atomic operation? That would be a far better 
interface, as then we would not need to stop I/O and the handshake
process could run fully asynchronous to normal I/O...

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
> @@ -1389,15 +1448,21 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   			mutex_unlock(&queue->send_mutex);
>   			if (result > 0)
>   				pending = true;
> -			else if (unlikely(result < 0))
> +			else if (unlikely(result < 0)) {
> +				if (result == -EKEYEXPIRED)
> +					update_tls_keys(queue);

How exactly can we get -EKEYEXPIRED when _sending_?
To my understanding that would have required userspace to intercept
here trying (or even sending) a KeyUpdate message, right?
So really not something we should see during normal operation.
As mentioned in my previous mail we should rather code the
KeyUpdate process itself here, too.
Namely: Trigger the KeyUpdate via userspace (eg by writing into the 
tls_key attribute for the controller), and then have the kernel side
to call out into tlshd to initiate the KeyUpdate 'handshake'.
That way we have identical flow of control for both the sending
and receiving side.

Incidentally: the RFC has some notion about 'request_update' setting
in the KeyUpdate message. Is that something we have to care about at
this level?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

