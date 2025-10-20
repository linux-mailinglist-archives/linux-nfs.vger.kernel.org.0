Return-Path: <linux-nfs+bounces-15393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61107BEF69C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 08:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFFD18858DA
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 06:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E02D192B;
	Mon, 20 Oct 2025 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YaCdthG+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AMuzVmAu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YaCdthG+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AMuzVmAu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D42D0C64
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940568; cv=none; b=dT+KsOEacAqas5NpeSqBBvmMhFaQztSn2R/iN5QvKW5eKnsYjJLtnnlTeK9FhTYhOd5aZtcyicJC6dFhatum4sznfb715v88LXjbrDmDs79xSfhay30DUCFXAAZnhSLUBJqn3lJCXVjIclmHgeqdOtxuyN6vb5QblSDwiWOfjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940568; c=relaxed/simple;
	bh=UgDlIjc1FVqdUpBpnYDNh2xGTjNSXEiCJix2pOTRyuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9tKRu7n84PgE9pecLnxxBTi+EWIt6QxnXqzaVVM/gOgzSWKDbemLa3UE69WREfITZcvvcPTCDCbd7Mw3lfs6lSb1HPQQFfCxvibn8dAZPTWBizH0RyoS9mhpKawJtzAF7lHWF+E8ukw4sgobWCePCjHFYm14MKYj/DFDsE2u9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YaCdthG+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AMuzVmAu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YaCdthG+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AMuzVmAu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4170E1F385;
	Mon, 20 Oct 2025 06:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760940560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ql5wHkB2WFVANuAhz1FG4f6RCGImO354vLJtgVa5xY=;
	b=YaCdthG+ed4xOjNm4T1zqAgVRBG2uFiLtI2UXmOxg6oRLsmiBbYz6xiyK6yFIUuVc8c6UC
	3nlEYU7dRg6OxK4AVVheSNnC74PZDZI1JUDDmLbLN0WDzjhVLh7vAJpd3DlFMNQpWgLz6+
	A1Cw6D9T0SPEL1B8A+Tb11T6UQ8jLwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760940560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ql5wHkB2WFVANuAhz1FG4f6RCGImO354vLJtgVa5xY=;
	b=AMuzVmAuerkOQ+qBTBsJYoOMs3681Bp3mVjYR36U+ofwKqb4adJUtidRWQoL1CqPZtNsmA
	LfMwNfcvkYk0q1BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760940560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ql5wHkB2WFVANuAhz1FG4f6RCGImO354vLJtgVa5xY=;
	b=YaCdthG+ed4xOjNm4T1zqAgVRBG2uFiLtI2UXmOxg6oRLsmiBbYz6xiyK6yFIUuVc8c6UC
	3nlEYU7dRg6OxK4AVVheSNnC74PZDZI1JUDDmLbLN0WDzjhVLh7vAJpd3DlFMNQpWgLz6+
	A1Cw6D9T0SPEL1B8A+Tb11T6UQ8jLwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760940560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ql5wHkB2WFVANuAhz1FG4f6RCGImO354vLJtgVa5xY=;
	b=AMuzVmAuerkOQ+qBTBsJYoOMs3681Bp3mVjYR36U+ofwKqb4adJUtidRWQoL1CqPZtNsmA
	LfMwNfcvkYk0q1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A75EC13AAC;
	Mon, 20 Oct 2025 06:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 25z0Jg/S9WjsSAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Oct 2025 06:09:19 +0000
Message-ID: <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
Date: Mon, 20 Oct 2025 08:09:19 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251017042312.1271322-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/17/25 06:23, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>   - Don't overload existing functions, instead create new ones
> v3:
>   - Fixup yamllint and kernel-doc failures
> 
>   Documentation/netlink/specs/handshake.yaml | 16 ++++-
>   drivers/nvme/host/tcp.c                    | 15 +++-
>   drivers/nvme/target/tcp.c                  | 10 ++-
>   include/net/handshake.h                    |  8 +++
>   include/uapi/linux/handshake.h             | 13 ++++
>   net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
>   6 files changed, 137 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index a273bc74d26f..c72ec8fa7d7a 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -21,12 +21,18 @@ definitions:
>       type: enum
>       name: msg-type
>       value-start: 0
> -    entries: [unspec, clienthello, serverhello]
> +    entries: [unspec, clienthello, serverhello, clientkeyupdate,
> +              clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
>     -

Why do we need the 'keyupdate' and 'keyupdaterequest' types?
Isn't the 'keyupdate' type enough, and can we specify anything
else via the update type?

>       type: enum
>       name: auth
>       value-start: 0
>       entries: [unspec, unauth, psk, x509]
> +  -
> +    type: enum
> +    name: key-update-type
> +    value-start: 0
> +    entries: [unspec, send, received, received_request_update]

See above.

>   
>   attribute-sets:
>     -
> @@ -74,6 +80,13 @@ attribute-sets:
>         -
>           name: keyring
>           type: u32
> +      -
> +        name: key-update-request
> +        type: u32
> +        enum: key-update-type
> +      -
> +        name: key-serial
> +        type: u32

Not sure if I like key-serial. Yes, it is a key serial number,
but it's not the serial number of the updated key (rather the serial
number of the key holding the session information).
Maybe 'key-update-serial' ?

>     -
>       name: done
>       attributes:
> @@ -116,6 +129,7 @@ operations:
>               - certificate
>               - peername
>               - keyring
> +            - key-serial
>       -
>         name: done
>         doc: Handler reports handshake completion
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 611be56f8013..2696bf97dfac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -20,6 +20,7 @@
>   #include <linux/iov_iter.h>
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
> +#include <uapi/linux/handshake.h>
>   
>   #include "nvme.h"
>   #include "fabrics.h"
> @@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
>   static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> +			      struct nvme_tcp_queue *queue,
> +			      key_serial_t pskid,
> +			      handshake_key_update_type keyupdate);
>   
>   static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
>   {
> @@ -1726,7 +1731,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>   
>   static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   			      struct nvme_tcp_queue *queue,
> -			      key_serial_t pskid)
> +			      key_serial_t pskid,
> +			      handshake_key_update_type keyupdate)
>   {
>   	int qid = nvme_tcp_queue_id(queue);
>   	int ret;
> @@ -1748,7 +1754,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
>   	queue->tls_err = -EOPNOTSUPP;
>   	init_completion(&queue->tls_complete);
> -	ret = tls_client_hello_psk(&args, GFP_KERNEL);
> +	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> +		ret = tls_client_hello_psk(&args, GFP_KERNEL);
> +	else
> +		ret = tls_client_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
>   	if (ret) {
>   		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
>   			qid, ret);
> @@ -1898,7 +1907,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   
>   	/* If PSKs are configured try to start TLS */
>   	if (nvme_tcp_tls_configured(nctrl) && pskid) {
> -		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
> +		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
>   		if (ret)
>   			goto err_init_connect;
>   	}
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4ef4dd140ada..8aeec4a7f136 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
>   	kref_put(&queue->kref, nvmet_tcp_release_queue);
>   }
>   
> -static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> +	handshake_key_update_type keyupdate)
>   {
>   	int ret = -EOPNOTSUPP;
>   	struct tls_handshake_args args;
> @@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
>   	args.ta_keyring = key_serial(queue->port->nport->keyring);
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
>   
> -	ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> +		ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	else
> +		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
>   	if (ret) {
>   		kref_put(&queue->kref, nvmet_tcp_release_queue);
>   		pr_err("failed to start TLS, err=%d\n", ret);
> @@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   		sk->sk_data_ready = port->data_ready;
>   		write_unlock_bh(&sk->sk_callback_lock);
>   		if (!nvmet_tcp_try_peek_pdu(queue)) {
> -			if (!nvmet_tcp_tls_handshake(queue))
> +			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
>   				return;
>   			/* TLS handshake failed, terminate the connection */
>   			goto out_destroy_sq;
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index dc2222fd6d99..084c92a20b68 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -10,6 +10,10 @@
>   #ifndef _NET_HANDSHAKE_H
>   #define _NET_HANDSHAKE_H
>   
> +#include <uapi/linux/handshake.h>
> +
> +#define handshake_key_update_type u32
> +
Huh?
You define it as 'u32' here

>   enum {
>   	TLS_NO_KEYRING = 0,
>   	TLS_NO_PEERID = 0,
> @@ -38,8 +42,12 @@ struct tls_handshake_args {
>   int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
>   int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
>   int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     handshake_key_update_type keyupdate);
>   int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
>   int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
> +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     handshake_key_update_type keyupdate);
>   
>   bool tls_handshake_cancel(struct sock *sk);
>   void tls_handshake_close(struct socket *sock);
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index b68ffbaa5f31..b691530073c6 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -19,6 +19,10 @@ enum handshake_msg_type {
>   	HANDSHAKE_MSG_TYPE_UNSPEC,
>   	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
>   	HANDSHAKE_MSG_TYPE_SERVERHELLO,
> +	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
> +	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATEREQUEST,
> +	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
> +	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATEREQUEST,
>   };
>   
>   enum handshake_auth {
> @@ -28,6 +32,13 @@ enum handshake_auth {
>   	HANDSHAKE_AUTH_X509,
>   };
>   
> +enum handshake_key_update_type {
> +	HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
> +	HANDSHAKE_KEY_UPDATE_TYPE_SEND,
> +	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
> +	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
> +};
> +

and here it's an enum. Please kill the first declaration.

>   enum {
>   	HANDSHAKE_A_X509_CERT = 1,
>   	HANDSHAKE_A_X509_PRIVKEY,
> @@ -46,6 +57,8 @@ enum {
>   	HANDSHAKE_A_ACCEPT_CERTIFICATE,
>   	HANDSHAKE_A_ACCEPT_PEERNAME,
>   	HANDSHAKE_A_ACCEPT_KEYRING,
> +	HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> +	HANDSHAKE_A_ACCEPT_KEY_SERIAL,
>   
>   	__HANDSHAKE_A_ACCEPT_MAX,
>   	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 2549c5dbccd8..c40839977ab9 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -41,6 +41,7 @@ struct tls_handshake_req {
>   	unsigned int		th_num_peerids;
>   	key_serial_t		th_peerid[5];
>   
> +	int			th_key_update_request;
>   	key_serial_t		user_session_id;
>   };
>   
Why 'int' ? Can it be negative?
If not please make it an 'unsigned int'

> @@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
>   	treq->th_num_peerids = 0;
>   	treq->th_certificate = TLS_NO_CERT;
>   	treq->th_privkey = TLS_NO_PRIVKEY;
> -	treq->user_session_id = TLS_NO_PRIVKEY;
> +	treq->user_session_id = args->user_session_id;
> +
>   	return treq;
>   }
>   
> @@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake_req *req,
>   		break;
>   	}
>   
> +	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_SERIAL,
> +			  treq->user_session_id);
> +	if (ret < 0)
> +		goto out_cancel;
> +
> +	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> +			  treq->th_key_update_request);
> +	if (ret < 0)
> +		goto out_cancel;
> +
>   	genlmsg_end(msg, hdr);
>   	return genlmsg_reply(msg, info);
>   
> @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
>   }
>   EXPORT_SYMBOL(tls_client_hello_psk);
>   
> +/**
> + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a socket
> + * @args: socket and handshake parameters for this request
> + * @flags: memory allocation control flags
> + * @keyupdate: specifies the type of KeyUpdate operation
> + *
> + * Return values:
> + *   %0: Handshake request enqueue; ->done will be called when complete
> + *   %-EINVAL: Wrong number of local peer IDs
> + *   %-ESRCH: No user agent is available
> + *   %-ENOMEM: Memory allocation failed
> + */
> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     handshake_key_update_type keyupdate)
> +{
> +	struct tls_handshake_req *treq;
> +	struct handshake_req *req;
> +	unsigned int i;
> +
> +	if (!args->ta_num_peerids ||
> +	    args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
> +		return -EINVAL;
> +
> +	req = handshake_req_alloc(&tls_handshake_proto, flags);
> +	if (!req)
> +		return -ENOMEM;
> +	treq = tls_handshake_req_init(req, args);
> +	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
> +	treq->th_key_update_request = keyupdate;
> +	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
> +	treq->th_num_peerids = args->ta_num_peerids;
> +	for (i = 0; i < args->ta_num_peerids; i++)
> +		treq->th_peerid[i] = args->ta_my_peerids[i];
Hmm?
Do we use the 'peerids'?
I thought that the information was encoded in the session, ie
the 'user_session_id' ?

> +
> +	return handshake_req_submit(args->ta_sock, req, flags);
> +}
> +EXPORT_SYMBOL(tls_client_keyupdate_psk);
> +
>   /**
>    * tls_server_hello_x509 - request a server TLS handshake on a socket
>    * @args: socket and handshake parameters for this request
> @@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
>   }
>   EXPORT_SYMBOL(tls_server_hello_psk);
>   
> +/**
> + * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a socket
> + * @args: socket and handshake parameters for this request
> + * @flags: memory allocation control flags
> + * @keyupdate: specifies the type of KeyUpdate operation
> + *
> + * Return values:
> + *   %0: Handshake request enqueue; ->done will be called when complete
> + *   %-ESRCH: No user agent is available
> + *   %-ENOMEM: Memory allocation failed
> + */
> +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     handshake_key_update_type keyupdate)
> +{
> +	struct tls_handshake_req *treq;
> +	struct handshake_req *req;
> +
> +	req = handshake_req_alloc(&tls_handshake_proto, flags);
> +	if (!req)
> +		return -ENOMEM;
> +	treq = tls_handshake_req_init(req, args);
> +	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
> +	treq->th_key_update_request = keyupdate;
> +	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
> +	treq->th_num_peerids = 1;
> +	treq->th_peerid[0] = args->ta_my_peerids[0];

Same here. Why do we need to set 'peerid'?

> +
> +	return handshake_req_submit(args->ta_sock, req, flags);
> +}
> +EXPORT_SYMBOL(tls_server_keyupdate_psk);
> +
>   /**
>    * tls_handshake_cancel - cancel a pending handshake
>    * @sk: socket on which there is an ongoing handshake
Nit: we _could_ overload 'peerid' with the user_session_id,then we 
wouldn't need to specify a new field in the handshake
request.
But that's arguably quite hackish.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

