Return-Path: <linux-nfs+bounces-14065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E72B458A7
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6625D189FE9C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D130CD93;
	Fri,  5 Sep 2025 13:19:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556827AC5A;
	Fri,  5 Sep 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078392; cv=none; b=IhozXLX61Y+ZH0a2p21vXiYp1HYYDH3uEj/xKJINCMG4XR42EH4iY0pLOeA7KaGpJY2nKfp8PY90S08Lfep0mfCOKxls+mlkAzrBBelCtuhFvWlu773B6Xhow8zKE1eRkgEBstlVQlCNzRLv/yMW5URMjnpSbLfWL0kGvZ1RTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078392; c=relaxed/simple;
	bh=RlHQsh/p+t/Q06a1D1Rl/GvU0YvFEgJg4blF00i2yZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=B9GZAdzncKdBXzpmEAsWGKmV/3qIKQszFlLs+l0WIAG5YodPjwg+BzAdj7uW7asIB+QtcaSdk4F3F62UVt7bH2YecIAkz6SQsE2MHhfRqENr32g4KzldIa2hn7k+Pe/UiR+Al38P3DCVwELwpa4kPSeoymoYigtgdO+1DtTv2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 13115ccc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Sep 2025 15:19:46 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 15:19:46 +0200
Message-Id: <DCKWAZAH7QNO.3739YP7O69XKZ@bsdbackstore.eu>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: <alistair23@gmail.com>, <chuck.lever@oracle.com>, <hare@kernel.org>,
 <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-nfs@vger.kernel.org>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
 <sagi@grimberg.me>, <kch@nvidia.com>, "Alistair Francis"
 <alistair.francis@wdc.com>
X-Mailer: aerc
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-8-alistair.francis@wdc.com>
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>

On Fri Sep 5, 2025 at 4:46 AM CEST, alistair23 wrote:
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
> +	read_unlock_bh(&queue->sock->sk->sk_callback_lock);
> +
> +	nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
> +
> +	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
> +			  nvmet_tcp_tls_handshake_timeout);
> +
> +	ret =3D nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIV=
ED);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D wait_for_completion_interruptible_timeout(&queue->tls_complete,=
 10 * HZ);
> +
> +	if (ret <=3D 0) {
> +		tls_handshake_cancel(queue->sock->sk);
> +		return ret;
> +	}
> +
> +	queue->state =3D NVMET_TCP_Q_LIVE;
> +
> +	return ret;
> +}
> +#endif



> @@ -1408,14 +1474,22 @@ static void nvmet_tcp_io_work(struct work_struct =
*w)
>  		ret =3D nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
>  		if (ret > 0)
>  			pending =3D true;
> -		else if (ret < 0)
> -			return;
> +		else if (ret < 0) {
> +			if (ret =3D=3D -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +				return;
> +		}
> =20

What happens if CONFIG_NVME_TARGET_TCP_TLS is disabled?
I suspect the kernel build will fail with an update_tls_keys
implicit declaration error.

Maurizio

