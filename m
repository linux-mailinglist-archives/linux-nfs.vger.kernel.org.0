Return-Path: <linux-nfs+bounces-14062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CEEB44DDF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 08:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DBB5A0575
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E00238C10;
	Fri,  5 Sep 2025 06:19:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4052AD2F;
	Fri,  5 Sep 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053173; cv=none; b=FHRJiEng2ZI4ncvHsZwYz2Wo/iHDxWAXRTt7kBTkTehlr1YXphG+TFo1QILGV85vWpDl0gXmjSu7kgKbKxISUef8mq4/jIfTKPEoy7kJlTP9AyZYashgl3/q6yepTho/5YTy+GOlJp6EVcVc0v44XXsE8TV9rub68tEIxCx2Whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053173; c=relaxed/simple;
	bh=NhlN6InMMn588qcAitktClqWH4WsbE2cjvjyyXVGWpU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lq/TVbymN3ZSHQXPvt/+v1kjREH8VTdFIlZDqs+ufiTPrKgOsesti15Atj8XGdHDJ+g3WPBT/nWmc0RFIjT7/0UTEN0NBhjyatyS8o2XBiBnHddQvkWi6qSl2z9h6CkAEP1Z680VXXjvi3GWgQ2GW5D8inO+lsqpr8XHnAbKREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id cf8a8994 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Sep 2025 07:52:41 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 07:52:41 +0200
Message-Id: <DCKMSNY3N59V.3KQCDWA1VJQNQ@bsdbackstore.eu>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
 <sagi@grimberg.me>, <kch@nvidia.com>, "Alistair Francis"
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: <alistair23@gmail.com>, <chuck.lever@oracle.com>, <hare@kernel.org>,
 <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-nfs@vger.kernel.org>
X-Mailer: aerc
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-8-alistair.francis@wdc.com>
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>

On Fri Sep 5, 2025 at 4:46 AM CEST, alistair23 wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
> a KeyUpdate handshake type then the underlying TLS keys need to be
> updated.
>
> If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
>
> This patch allows us to handle the NVMe host sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
>
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>  - Use a helper function for KeyUpdates
>  - Ensure keep alive timer is stopped
>  - Wait for TLS KeyUpdate to complete
>
>  drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index bee0355195f5..dd09940e9635 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
> =20
>  	/* TLS state */
>  	key_serial_t		tls_pskid;
> +	key_serial_t		user_session_id;
>  	struct delayed_work	tls_handshake_tmo_work;
> =20
>  	unsigned long           poll_end;
> @@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
>  	struct sockaddr_storage	sockaddr_peer;
>  	struct work_struct	release_work;
> =20
> +	struct completion       tls_complete;
> +
>  	int			idx;
>  	struct list_head	queue_list;
> =20
> @@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_q=
ueue *queue,
>  	return 1;
>  }
> =20
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> +#endif
> +
>  static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
>  		int budget, int *sends)
>  {
> @@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue=
 *queue,
>  	for (i =3D 0; i < budget; i++) {
>  		ret =3D nvmet_tcp_try_send_one(queue, i =3D=3D budget - 1);
>  		if (unlikely(ret < 0)) {
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret =3D=3D -EKEYEXPIRED &&
> +				queue->state !=3D NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state !=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}
> +#endif
>  			nvmet_tcp_socket_error(queue, ret);
>  			goto done;
>  		} else if (ret =3D=3D 0) {
> @@ -1110,11 +1125,52 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>  	return false;
>  }
> =20
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int update_tls_keys(struct nvmet_tcp_queue *queue)
> +{
> +	int ret;
> +
> +	cancel_work(&queue->io_work);
> +	handshake_req_cancel(queue->sock->sk);
> +	handshake_sk_destruct_req(queue->sock->sk);
> +	queue->state =3D NVMET_TCP_Q_TLS_HANDSHAKE;
> +
> +	/* Restore the default callbacks before starting upcall */
> +	read_lock_bh(&queue->sock->sk->sk_callback_lock);
> +	queue->sock->sk->sk_data_ready =3D  queue->data_ready;
> +	queue->sock->sk->sk_state_change =3D queue->state_change;
> +	queue->sock->sk->sk_write_space =3D queue->write_space;
> +	queue->sock->sk->sk_user_data =3D NULL;

Shouldn't "sk_user_data =3D NULL" be protected by a write lock?

Maurizio

