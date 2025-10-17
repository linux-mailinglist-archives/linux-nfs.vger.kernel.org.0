Return-Path: <linux-nfs+bounces-15310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45DBE6109
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 03:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC4420AD6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68E23536B;
	Fri, 17 Oct 2025 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es4da3nw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508420C00C
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666014; cv=none; b=cAmveCbGWzqYg108RVf8itsPETMDY4DYmLKl+GYcAVpTbgoZ3+FDITgRfCttbaB4Nof08vg13PRgrQuUWKqBmV3jfPSiWCkcVM1H+PrOVCJOHBPvrS89QEHaKqxbDtlW9L4/g2bP0dSZUW5T1fDz25TmgQWpdir4e15D/npfO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666014; c=relaxed/simple;
	bh=hM1tl4y/lVKyn+dDmiZdlUKnhKkFxFNeGV/L79BL390=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj0yYCEKP3rSY9rKae8meClzKQFAH1lsoKqIlXSId4vO1cmGNpiCGlsXqbj+e2iVBhTEIi5ys8n4go351tBXMPhqEAkOxiFg9YTEWr8PsccyY6IobI3yYGTDQdqULAOXdAClSHrOP534vd5Y/vQnkTD5MuAbxuWcJXC7ZBahhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es4da3nw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so2589363a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666011; x=1761270811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg3YC8a6su9LqTbpQvqj8XsjlAAqUYFX939NA7tC+rk=;
        b=Es4da3nwPiQimfM82tzr0+1jza+wbFxFDsge5b5Wcciqt22VgPBlRHsKcAo/AwcYhz
         V4EcpOdoyDA0/LBvcSVbNw9m4GWsZbKdzlYBLQIFWt7fr/aSBjbI5WFOkBoMs/1hrst8
         vndlA22+j5yy7aL+uCgQ9ASHhBhUOJbJR4SnUViE1EMAX8XxZJo78F2hM57IJSgoVEy6
         DmHSry4xSWQbpz5/kKnMaZ+9xC8poocxeNTHTJ9wCJ4I5I+kZKZzuUejPr8AtL2elVXb
         aS1Eeg0SCt5A/WJ3qPbmkX2JmoUnfjpaLl9WOEdpmm5toQPqoTvdLDdQj/9XVj1SADV0
         +4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666011; x=1761270811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg3YC8a6su9LqTbpQvqj8XsjlAAqUYFX939NA7tC+rk=;
        b=a915zLj5io6vTZFrvGQmdItFY7ClpUT9HDy6CKUJjmt9Qa6uNxPpytgXTaxk+u7W/I
         KVZ5meQVk4O/YS1tUo1+mKYHBsChpcevUv5wwTp77ibkyZFbIbXh3AetlXtsgAcPUdrZ
         4LXQYt8wwVW8uGN3QVw+D21ld7KnOXTJa3jf1Zw4xp2dRWCEB8bXCWaQhzVdlavSMLss
         i4COJdZfyLlaK0ys21TKAJjH2JBF1uoCxjGJ1MaUmdhu90PWpK5Nw1jNstgHTh/SkNPa
         3w8OiJ7xXsRf5URyPRYUSU1n67K4gceHAef938h4z4I/gWh97fkM2TLd0CW+/9ZAOSEE
         VPOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQAYzU89zesfPrFf+6BiKiSGK/ouSUJCL8ytupWljL/hQ50RULl2VrTHQjo/vEwGUWCm/2LJTe38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkmWE3wnASjAm+/NAP0BUp4HjEKWrHRmUWzNQ6ksGzA/sc7ej
	xMP/itcEZ3POTBc9Hem3FR2UFa8YaQ0QCnfeIqaY5eJf6o7CDsIYijtmfmzGToF5/kNzJqgZtEz
	MJncYzLxaSTa38NRlSc8q5mPjFIjN2WY=
X-Gm-Gg: ASbGncvLDnTUAFNMlTFq+JhWtBdhrSfFBHsKZeTrEwoGfi3LmyHNgmmHw5SB6CahmzD
	dpsp09n93BuDfoIkf4N8q3pCjEMoPtweRmtpL+xzkXaKi3lEXm3bJASun67bvsLwWFTLBdW2a+7
	1MVVf33mhm7G6gW8y0rMXiCRv2wMzZhZ//k+PzWqxoZt0KVhpEjghRCHan0QCN9Qdaj8u/UAEGz
	jjIbmvjdOspf1LmVWRCRuJcPO8CY+vKdHuHNJ0+5wX2O2Yhjyd1lfzHvaTHGXoYEgFE9Ca08StM
	wkm6yjyVkuHclkE=
X-Google-Smtp-Source: AGHT+IEwGE2DyBw79hahqoYYl+Io8sAm9x+p/Mvm4N2Yz5vRAjrfFya1X4ses6e0GFt/zr8ZT03UC+13/oAZmSfJwPQ=
X-Received: by 2002:a05:6402:3506:b0:63c:11cd:be57 with SMTP id
 4fb4d7f45d1cf-63c1f626e7cmr1509380a12.5.1760666011447; Thu, 16 Oct 2025
 18:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-8-alistair.francis@wdc.com> <591a7eb8-563c-4368-b868-880ed081a432@suse.de>
In-Reply-To: <591a7eb8-563c-4368-b868-880ed081a432@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 11:53:04 +1000
X-Gm-Features: AS18NWAQRox_cHhQyvz94xO43zDLu8kahziESzW1tlno9LjS2bcAJiNBl10LBPE
Message-ID: <CAKmqyKNupEy8dj4B9a8NWymVJTQs_mpeQynLSdCPrO3rBYnByA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] nvmet-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:48=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 10/3/25 06:31, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receiv=
e
> > a KeyUpdate handshake type then the underlying TLS keys need to be
> > updated.
> >
> > If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> > allow the NVMe layer to process the KeyUpdate request and forward the
> > request to userspace. Userspace must then update the key to keep the
> > connection alive.
> >
> > This patch allows us to handle the NVMe host sending a KeyUpdate
> > request without aborting the connection. At this time we don't support
> > initiating a KeyUpdate.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - Use a write lock for sk_user_data
> >   - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
> >   - Remove unused variable
> > v2:
> >   - Use a helper function for KeyUpdates
> >   - Ensure keep alive timer is stopped
> >   - Wait for TLS KeyUpdate to complete
> >
> >   drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 85 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index bee0355195f5..fd59dd3ca632 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
> >
> >       /* TLS state */
> >       key_serial_t            tls_pskid;
> > +     key_serial_t            user_session_id;
> >       struct delayed_work     tls_handshake_tmo_work;
> >
> >       unsigned long           poll_end;
> > @@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
> >       struct sockaddr_storage sockaddr_peer;
> >       struct work_struct      release_work;
> >
> > +     struct completion       tls_complete;
> > +
> >       int                     idx;
> >       struct list_head        queue_list;
> >
> > @@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp=
_queue *queue,
> >       return 1;
> >   }
> >
> > +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> > +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> > +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> > +#endif
> > +
> >   static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
> >               int budget, int *sends)
> >   {
>
> And we need this why?
>
> > @@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_que=
ue *queue,
> >       for (i =3D 0; i < budget; i++) {
> >               ret =3D nvmet_tcp_try_send_one(queue, i =3D=3D budget - 1=
);
> >               if (unlikely(ret < 0)) {
> > +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> > +                     if (ret =3D=3D -EKEYEXPIRED &&
> > +                             queue->state !=3D NVMET_TCP_Q_DISCONNECTI=
NG &&
> > +                             queue->state !=3D NVMET_TCP_Q_TLS_HANDSHA=
KE) {
> > +                                     goto done;
> > +                     }
> > +#endif
> >                       nvmet_tcp_socket_error(queue, ret);
> >                       goto done;
> >               } else if (ret =3D=3D 0) {
>
> See my comment to the host patches. Handling an incoming KeyUpdate is
> vastly different than initiating a KeyUpdate. _and_ the network stack
> will only ever return -EKEYEXPIRED on receive.
> So please split the patches in handling an incoming KeyUpdate and
> initiating a KeyUpdate.

Ok, removed from both.

>
> > @@ -1110,6 +1125,45 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
> >       return false;
> >   }
> >
> > +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> > +static int update_tls_keys(struct nvmet_tcp_queue *queue)
> > +{
> > +     int ret;
> > +
> > +     cancel_work(&queue->io_work);
> > +     queue->state =3D NVMET_TCP_Q_TLS_HANDSHAKE;
> > +
> > +     /* Restore the default callbacks before starting upcall */
> > +     write_lock_bh(&queue->sock->sk->sk_callback_lock);
> > +     queue->sock->sk->sk_data_ready =3D  queue->data_ready;
> > +     queue->sock->sk->sk_state_change =3D queue->state_change;
> > +     queue->sock->sk->sk_write_space =3D queue->write_space;
> > +     queue->sock->sk->sk_user_data =3D NULL;
> > +     write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> > +
> We do have a function for this ...
>
> > +     nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
> > +
> > +     INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
> > +                       nvmet_tcp_tls_handshake_timeout);
> > +
> > +     ret =3D nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_=
RECEIVED);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D wait_for_completion_interruptible_timeout(&queue->tls_com=
plete, 10 * HZ);
> > +
> > +     if (ret <=3D 0) {
> > +             tls_handshake_cancel(queue->sock->sk);
> > +             return ret;
> > +     }
> > +
> > +     queue->state =3D NVMET_TCP_Q_LIVE;
> > +
> > +     return ret;
> > +}
> > +#endif
> > +
> >   static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
> >               struct msghdr *msg, char *cbuf)
> >   {
> > @@ -1135,6 +1189,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_t=
cp_queue *queue,
> >                       ret =3D -EAGAIN;
> >               }
> >               break;
> > +     case TLS_RECORD_TYPE_HANDSHAKE:
> > +             ret =3D -EAGAIN;
> > +             break;
>
> Shouldn't this be rather -EKEYEXPIRED?

It shouldn't be. The TLS layer returns -EKEYEXPIRED and we update the
keys. TLS_RECORD_TYPE_HANDSHAKE occurs after the KeyUpdate when the
NVMe layer reads the KeyUpdate message, but we have already acted on
the KeyUpdate from the -EKEYEXPIRED returned by the TLS layer.
Basically the TLS layer handles decoding the KeyUpdate (already in
mainline) and returning -EKEYEXPIRED which kicks off the KeyUpdate.
This is just us clearing the message from the TLS buffer.

Alistair

