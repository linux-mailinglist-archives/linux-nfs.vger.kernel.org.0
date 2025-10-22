Return-Path: <linux-nfs+bounces-15494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E1DBF9F7F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 06:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3984319A0837
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 04:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8690199E9D;
	Wed, 22 Oct 2025 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXVkOYrl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9F2D739C
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108087; cv=none; b=ICcpm76FY49fSwuj4ZQBBvPXeOeD6D8EKlWSrs7LxqRQBUH7OGvqcqJbIJ+cMy6sh4viB6NVTDzB4rXYA9EYMqYvMeyoWRBcYRvLum/O2cVO58lgR/4aXHFMtV+ZBZgeNGlLr//mDXqbxbEJjv1qRea/Hd6eE9ZFKJK/DoolN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108087; c=relaxed/simple;
	bh=YI9XdeSqNw1PtqUxfjdv8/RUjGXVOhxD/W87lZ+RgMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzQy2LhAHOGnh9K8H0TmKVCBX2S1QFtrf9DnT3m3RyIiXpMc4y1oaaCg9fvR/asb1hWmkfA1GziupvvyOVESGavmmz4Y9RTfoDuMhQvp+Z6bVpAZ7D4QhdEMryCh8jVKIJ3KiM+SQdRWyXujzeVOmT50nrwHSm56xoTxp4cQTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXVkOYrl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so8390490a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 21:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761108082; x=1761712882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzIhtTke8e+w0UvoNy02RNiPIBjkvjFYUBf5hqrPq1k=;
        b=UXVkOYrlCq1rHdL4z0Th2jMr5ktpJOub+YOAtq5AE57l87uTuKmY3rtLqxGsSwGOt1
         fEoRxeQbyFZwJlmq62btkWfmffx1z+QT1uUywtH7buBcmYFHzOwSViNIeGlLfyPQSQ93
         TVwoQmdhpjEDJA9jfCaryrgxjFsp3yHq/6sLzlA3L70O8+ERrAl7ScQMojFQBFcN4Z0O
         dcJPc92DvCyhCEczGf/PqPeGfqsFqw0kKq9bIPZS+sMGLgtP5fKYvq5hCwdTneeWiLdm
         U09FVH8/RyaMnzCD6bRMYylfF5sR9v4vLaeXCR/ab3WVK3ppTv/6vCClvcFWvkNkN2Wy
         ri1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108082; x=1761712882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzIhtTke8e+w0UvoNy02RNiPIBjkvjFYUBf5hqrPq1k=;
        b=vp0wxHlHznaWS9+v68uZltN7FE97HtuaQicoqmVMZe8PTww2qpIfxLiCt2Yc1zFQ2z
         W9RGsfyaZTU0nvDoClXmRP7NnVPvuoGf7zlOinxG1+D4coSsRjRMIGPdfgIplaNg0/44
         G4FopI9vZOZBVZ7GBIFVt8vUPYv6w3Nx5pNaNvtxVKY1W1wi4DnzLwN+8RyORJBOJhl7
         3mocT1ECViDlUu5LmnjuPUjCcEsv7hhTobSaMTFb3nT2TcjBlOFonB1ve+uZGgHsvSrU
         ELC9p9Po/IQGZpxs6OJZcGkJ7bUOfEkyU715YeT5lU/dYqe688Lvho3dozWyEut5CeoV
         ehVA==
X-Forwarded-Encrypted: i=1; AJvYcCVq/JZBYMNyEjbEq72zrHDYO35dCG9k4L2TZCUbqW1tfL7iaUht3IINhErxbY/cBSa+Mlyo98HzLeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjltou+JOklvUJn9W944MFSeMhLNBiXV9T/WDOKAkIrVnysuLg
	vHUqSBLIT0yUzBdsx1UrmaNrZTZ29YhjjEWoXzfHBWfTkgbKacEKUu33p6+Ef3Bth2mBUmE6Qh2
	PsWPrIk2lHjCrAnohRYDRhyasVZg+xnM=
X-Gm-Gg: ASbGnctUR+TuvxSf2+IAGVNB5EvRewc61u89HOgytXmOlpZLT/PZZDSS3mbb7al4BDJ
	WoSjitzZV595AzmdJ3y00cxQ40m44sYodsCnMqE4vum13/cghuGYVbfKd63E+gZGX7ejjOY8plc
	L2Uf8TZLGCsGhxvTuzwITh+zDIgBWNo94rTRC84JHoD7bkW/JrX04H2D2Q1FqGHQMZ4GnXDyi/J
	zHYA4nxyryamlaODKsSznDMBMaVd1RwfiE9As7KqAap/8S+kELZ+N2LfhkDbX6VmyKPYZERcjPO
	8jkK6zSO+UsftXA=
X-Google-Smtp-Source: AGHT+IFM79I+L2aLcKhyvnpbYsGDy6QnZNFX/8jnRvok9XdbcEQbMrJ8J6bVZm0CtpL1WBrjXN82qfUU0k6ZqC9LrEg=
X-Received: by 2002:a05:6402:5191:b0:63c:4f1e:6d82 with SMTP id
 4fb4d7f45d1cf-63c4f1e73acmr14921626a12.24.1761108082359; Tue, 21 Oct 2025
 21:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-5-alistair.francis@wdc.com> <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
 <CAKmqyKMsYUPLz9hVmM_rjXKSo52cMEtn8qVwbSs=UknxRWaQUw@mail.gmail.com>
In-Reply-To: <CAKmqyKMsYUPLz9hVmM_rjXKSo52cMEtn8qVwbSs=UknxRWaQUw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 14:40:55 +1000
X-Gm-Features: AS18NWDxX_HGaPlhwMFef4VjzTwZPMCk6IUmYygfFRuAXSRtLQyX_g3NHGGD5kk
Message-ID: <CAKmqyKNSV1GdipOrOs3csyoTMKX1+mxTgxnOq9xnb3vmRN0RgA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net/handshake: Support KeyUpdate message types
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:19=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Mon, Oct 20, 2025 at 4:09=E2=80=AFPM Hannes Reinecke <hare@suse.de> wr=
ote:
> >
> > On 10/17/25 06:23, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > When reporting the msg-type to userspace let's also support reporting
> > > KeyUpdate events. This supports reporting a client/server event and i=
f
> > > the other side requested a KeyUpdateRequest.
> > >
> > > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > > v4:
> > >   - Don't overload existing functions, instead create new ones
> > > v3:
> > >   - Fixup yamllint and kernel-doc failures
> > >
> > >   Documentation/netlink/specs/handshake.yaml | 16 ++++-
> > >   drivers/nvme/host/tcp.c                    | 15 +++-
> > >   drivers/nvme/target/tcp.c                  | 10 ++-
> > >   include/net/handshake.h                    |  8 +++
> > >   include/uapi/linux/handshake.h             | 13 ++++
> > >   net/handshake/tlshd.c                      | 83 +++++++++++++++++++=
++-
> > >   6 files changed, 137 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentati=
on/netlink/specs/handshake.yaml
> > > index a273bc74d26f..c72ec8fa7d7a 100644
> > > --- a/Documentation/netlink/specs/handshake.yaml
> > > +++ b/Documentation/netlink/specs/handshake.yaml
> > > @@ -21,12 +21,18 @@ definitions:
> > >       type: enum
> > >       name: msg-type
> > >       value-start: 0
> > > -    entries: [unspec, clienthello, serverhello]
> > > +    entries: [unspec, clienthello, serverhello, clientkeyupdate,
> > > +              clientkeyupdaterequest, serverkeyupdate, serverkeyupda=
terequest]
> > >     -
> >
> > Why do we need the 'keyupdate' and 'keyupdaterequest' types?
>
> msg-type indicates if it's a client or server and hello or keyupdate,
> the idea being
>
> client:
>  - Hello
>  - KeyUpdate
>
> server:
>  - Hello
>  - KeyUpdate
>
> I'll drop clientkeyupdaterequest and serverkeyupdaterequest
>
> > Isn't the 'keyupdate' type enough, and can we specify anything
> > else via the update type?
>
> Once we know if it's a client or server KeyUpdate we need to know if
> we are receiving one, sending one or receiving one with the
> request_update flag set, hence key-update-type
>
> >
> > >       type: enum
> > >       name: auth
> > >       value-start: 0
> > >       entries: [unspec, unauth, psk, x509]
> > > +  -
> > > +    type: enum
> > > +    name: key-update-type
> > > +    value-start: 0
> > > +    entries: [unspec, send, received, received_request_update]
> >
> > See above.
> >
> > >
> > >   attribute-sets:
> > >     -
> > > @@ -74,6 +80,13 @@ attribute-sets:
> > >         -
> > >           name: keyring
> > >           type: u32
> > > +      -
> > > +        name: key-update-request
> > > +        type: u32
> > > +        enum: key-update-type
> > > +      -
> > > +        name: key-serial
> > > +        type: u32
> >
> > Not sure if I like key-serial. Yes, it is a key serial number,
> > but it's not the serial number of the updated key (rather the serial
> > number of the key holding the session information).
> > Maybe 'key-update-serial' ?
> >
> > >     -
> > >       name: done
> > >       attributes:
> > > @@ -116,6 +129,7 @@ operations:
> > >               - certificate
> > >               - peername
> > >               - keyring
> > > +            - key-serial
> > >       -
> > >         name: done
> > >         doc: Handler reports handshake completion
> > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > index 611be56f8013..2696bf97dfac 100644
> > > --- a/drivers/nvme/host/tcp.c
> > > +++ b/drivers/nvme/host/tcp.c
> > > @@ -20,6 +20,7 @@
> > >   #include <linux/iov_iter.h>
> > >   #include <net/busy_poll.h>
> > >   #include <trace/events/sock.h>
> > > +#include <uapi/linux/handshake.h>
> > >
> > >   #include "nvme.h"
> > >   #include "fabrics.h"
> > > @@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
> > >   static const struct blk_mq_ops nvme_tcp_mq_ops;
> > >   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> > >   static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
> > > +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> > > +                           struct nvme_tcp_queue *queue,
> > > +                           key_serial_t pskid,
> > > +                           handshake_key_update_type keyupdate);
> > >
> > >   static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *c=
trl)
> > >   {
> > > @@ -1726,7 +1731,8 @@ static void nvme_tcp_tls_done(void *data, int s=
tatus, key_serial_t pskid,
> > >
> > >   static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> > >                             struct nvme_tcp_queue *queue,
> > > -                           key_serial_t pskid)
> > > +                           key_serial_t pskid,
> > > +                           handshake_key_update_type keyupdate)
> > >   {
> > >       int qid =3D nvme_tcp_queue_id(queue);
> > >       int ret;
> > > @@ -1748,7 +1754,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl=
 *nctrl,
> > >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> > >       queue->tls_err =3D -EOPNOTSUPP;
> > >       init_completion(&queue->tls_complete);
> > > -     ret =3D tls_client_hello_psk(&args, GFP_KERNEL);
> > > +     if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> > > +             ret =3D tls_client_hello_psk(&args, GFP_KERNEL);
> > > +     else
> > > +             ret =3D tls_client_keyupdate_psk(&args, GFP_KERNEL, key=
update);
> > >       if (ret) {
> > >               dev_err(nctrl->device, "queue %d: failed to start TLS: =
%d\n",
> > >                       qid, ret);
> > > @@ -1898,7 +1907,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctr=
l *nctrl, int qid,
> > >
> > >       /* If PSKs are configured try to start TLS */
> > >       if (nvme_tcp_tls_configured(nctrl) && pskid) {
> > > -             ret =3D nvme_tcp_start_tls(nctrl, queue, pskid);
> > > +             ret =3D nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHA=
KE_KEY_UPDATE_TYPE_UNSPEC);
> > >               if (ret)
> > >                       goto err_init_connect;
> > >       }
> > > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > > index 4ef4dd140ada..8aeec4a7f136 100644
> > > --- a/drivers/nvme/target/tcp.c
> > > +++ b/drivers/nvme/target/tcp.c
> > > @@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(str=
uct work_struct *w)
> > >       kref_put(&queue->kref, nvmet_tcp_release_queue);
> > >   }
> > >
> > > -static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
> > > +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> > > +     handshake_key_update_type keyupdate)
> > >   {
> > >       int ret =3D -EOPNOTSUPP;
> > >       struct tls_handshake_args args;
> > > @@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvme=
t_tcp_queue *queue)
> > >       args.ta_keyring =3D key_serial(queue->port->nport->keyring);
> > >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> > >
> > > -     ret =3D tls_server_hello_psk(&args, GFP_KERNEL);
> > > +     if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> > > +             ret =3D tls_server_hello_psk(&args, GFP_KERNEL);
> > > +     else
> > > +             ret =3D tls_server_keyupdate_psk(&args, GFP_KERNEL, key=
update);
> > >       if (ret) {
> > >               kref_put(&queue->kref, nvmet_tcp_release_queue);
> > >               pr_err("failed to start TLS, err=3D%d\n", ret);
> > > @@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_=
tcp_port *port,
> > >               sk->sk_data_ready =3D port->data_ready;
> > >               write_unlock_bh(&sk->sk_callback_lock);
> > >               if (!nvmet_tcp_try_peek_pdu(queue)) {
> > > -                     if (!nvmet_tcp_tls_handshake(queue))
> > > +                     if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_K=
EY_UPDATE_TYPE_UNSPEC))
> > >                               return;
> > >                       /* TLS handshake failed, terminate the connecti=
on */
> > >                       goto out_destroy_sq;
> > > diff --git a/include/net/handshake.h b/include/net/handshake.h
> > > index dc2222fd6d99..084c92a20b68 100644
> > > --- a/include/net/handshake.h
> > > +++ b/include/net/handshake.h
> > > @@ -10,6 +10,10 @@
> > >   #ifndef _NET_HANDSHAKE_H
> > >   #define _NET_HANDSHAKE_H
> > >
> > > +#include <uapi/linux/handshake.h>
> > > +
> > > +#define handshake_key_update_type u32
> > > +
> > Huh?
> > You define it as 'u32' here
> >
> > >   enum {
> > >       TLS_NO_KEYRING =3D 0,
> > >       TLS_NO_PEERID =3D 0,
> > > @@ -38,8 +42,12 @@ struct tls_handshake_args {
> > >   int tls_client_hello_anon(const struct tls_handshake_args *args, gf=
p_t flags);
> > >   int tls_client_hello_x509(const struct tls_handshake_args *args, gf=
p_t flags);
> > >   int tls_client_hello_psk(const struct tls_handshake_args *args, gfp=
_t flags);
> > > +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, =
gfp_t flags,
> > > +                          handshake_key_update_type keyupdate);
> > >   int tls_server_hello_x509(const struct tls_handshake_args *args, gf=
p_t flags);
> > >   int tls_server_hello_psk(const struct tls_handshake_args *args, gfp=
_t flags);
> > > +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, =
gfp_t flags,
> > > +                          handshake_key_update_type keyupdate);
> > >
> > >   bool tls_handshake_cancel(struct sock *sk);
> > >   void tls_handshake_close(struct socket *sock);
> > > diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/hand=
shake.h
> > > index b68ffbaa5f31..b691530073c6 100644
> > > --- a/include/uapi/linux/handshake.h
> > > +++ b/include/uapi/linux/handshake.h
> > > @@ -19,6 +19,10 @@ enum handshake_msg_type {
> > >       HANDSHAKE_MSG_TYPE_UNSPEC,
> > >       HANDSHAKE_MSG_TYPE_CLIENTHELLO,
> > >       HANDSHAKE_MSG_TYPE_SERVERHELLO,
> > > +     HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
> > > +     HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATEREQUEST,
> > > +     HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
> > > +     HANDSHAKE_MSG_TYPE_SERVERKEYUPDATEREQUEST,
> > >   };
> > >
> > >   enum handshake_auth {
> > > @@ -28,6 +32,13 @@ enum handshake_auth {
> > >       HANDSHAKE_AUTH_X509,
> > >   };
> > >
> > > +enum handshake_key_update_type {
> > > +     HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
> > > +     HANDSHAKE_KEY_UPDATE_TYPE_SEND,
> > > +     HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
> > > +     HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
> > > +};
> > > +
> >
> > and here it's an enum. Please kill the first declaration.
> >
> > >   enum {
> > >       HANDSHAKE_A_X509_CERT =3D 1,
> > >       HANDSHAKE_A_X509_PRIVKEY,
> > > @@ -46,6 +57,8 @@ enum {
> > >       HANDSHAKE_A_ACCEPT_CERTIFICATE,
> > >       HANDSHAKE_A_ACCEPT_PEERNAME,
> > >       HANDSHAKE_A_ACCEPT_KEYRING,
> > > +     HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> > > +     HANDSHAKE_A_ACCEPT_KEY_SERIAL,
> > >
> > >       __HANDSHAKE_A_ACCEPT_MAX,
> > >       HANDSHAKE_A_ACCEPT_MAX =3D (__HANDSHAKE_A_ACCEPT_MAX - 1)
> > > diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> > > index 2549c5dbccd8..c40839977ab9 100644
> > > --- a/net/handshake/tlshd.c
> > > +++ b/net/handshake/tlshd.c
> > > @@ -41,6 +41,7 @@ struct tls_handshake_req {
> > >       unsigned int            th_num_peerids;
> > >       key_serial_t            th_peerid[5];
> > >
> > > +     int                     th_key_update_request;
> > >       key_serial_t            user_session_id;
> > >   };
> > >
> > Why 'int' ? Can it be negative?
> > If not please make it an 'unsigned int'
> >
> > > @@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
> > >       treq->th_num_peerids =3D 0;
> > >       treq->th_certificate =3D TLS_NO_CERT;
> > >       treq->th_privkey =3D TLS_NO_PRIVKEY;
> > > -     treq->user_session_id =3D TLS_NO_PRIVKEY;
> > > +     treq->user_session_id =3D args->user_session_id;
> > > +
> > >       return treq;
> > >   }
> > >
> > > @@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake=
_req *req,
> > >               break;
> > >       }
> > >
> > > +     ret =3D nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_SERIAL,
> > > +                       treq->user_session_id);
> > > +     if (ret < 0)
> > > +             goto out_cancel;
> > > +
> > > +     ret =3D nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> > > +                       treq->th_key_update_request);
> > > +     if (ret < 0)
> > > +             goto out_cancel;
> > > +
> > >       genlmsg_end(msg, hdr);
> > >       return genlmsg_reply(msg, info);
> > >
> > > @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handsh=
ake_args *args, gfp_t flags)
> > >   }
> > >   EXPORT_SYMBOL(tls_client_hello_psk);
> > >
> > > +/**
> > > + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a=
 socket
> > > + * @args: socket and handshake parameters for this request
> > > + * @flags: memory allocation control flags
> > > + * @keyupdate: specifies the type of KeyUpdate operation
> > > + *
> > > + * Return values:
> > > + *   %0: Handshake request enqueue; ->done will be called when compl=
ete
> > > + *   %-EINVAL: Wrong number of local peer IDs
> > > + *   %-ESRCH: No user agent is available
> > > + *   %-ENOMEM: Memory allocation failed
> > > + */
> > > +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, =
gfp_t flags,
> > > +                          handshake_key_update_type keyupdate)
> > > +{
> > > +     struct tls_handshake_req *treq;
> > > +     struct handshake_req *req;
> > > +     unsigned int i;
> > > +
> > > +     if (!args->ta_num_peerids ||
> > > +         args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
> > > +             return -EINVAL;
> > > +
> > > +     req =3D handshake_req_alloc(&tls_handshake_proto, flags);
> > > +     if (!req)
> > > +             return -ENOMEM;
> > > +     treq =3D tls_handshake_req_init(req, args);
> > > +     treq->th_type =3D HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
> > > +     treq->th_key_update_request =3D keyupdate;
> > > +     treq->th_auth_mode =3D HANDSHAKE_AUTH_PSK;
> > > +     treq->th_num_peerids =3D args->ta_num_peerids;
> > > +     for (i =3D 0; i < args->ta_num_peerids; i++)
> > > +             treq->th_peerid[i] =3D args->ta_my_peerids[i];
> > Hmm?
> > Do we use the 'peerids'?
>
> We don't, this is just copied from the
> tls_client_hello_psk()/tls_server_hello_psk() to provide the same
> information to keep things more consistent.
>
> I can remove setting these

Actually, ktls-utils (tlshd) expects these to be set, so I think we
should leave them as is

Alistair

>
> > I thought that the information was encoded in the session, ie
> > the 'user_session_id' ?
> >
> > > +
> > > +     return handshake_req_submit(args->ta_sock, req, flags);
> > > +}
> > > +EXPORT_SYMBOL(tls_client_keyupdate_psk);
> > > +
> > >   /**
> > >    * tls_server_hello_x509 - request a server TLS handshake on a sock=
et
> > >    * @args: socket and handshake parameters for this request
> > > @@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handsh=
ake_args *args, gfp_t flags)
> > >   }
> > >   EXPORT_SYMBOL(tls_server_hello_psk);
> > >
> > > +/**
> > > + * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a so=
cket
> > > + * @args: socket and handshake parameters for this request
> > > + * @flags: memory allocation control flags
> > > + * @keyupdate: specifies the type of KeyUpdate operation
> > > + *
> > > + * Return values:
> > > + *   %0: Handshake request enqueue; ->done will be called when compl=
ete
> > > + *   %-ESRCH: No user agent is available
> > > + *   %-ENOMEM: Memory allocation failed
> > > + */
> > > +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, =
gfp_t flags,
> > > +                          handshake_key_update_type keyupdate)
> > > +{
> > > +     struct tls_handshake_req *treq;
> > > +     struct handshake_req *req;
> > > +
> > > +     req =3D handshake_req_alloc(&tls_handshake_proto, flags);
> > > +     if (!req)
> > > +             return -ENOMEM;
> > > +     treq =3D tls_handshake_req_init(req, args);
> > > +     treq->th_type =3D HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
> > > +     treq->th_key_update_request =3D keyupdate;
> > > +     treq->th_auth_mode =3D HANDSHAKE_AUTH_PSK;
> > > +     treq->th_num_peerids =3D 1;
> > > +     treq->th_peerid[0] =3D args->ta_my_peerids[0];
> >
> > Same here. Why do we need to set 'peerid'?
> >
> > > +
> > > +     return handshake_req_submit(args->ta_sock, req, flags);
> > > +}
> > > +EXPORT_SYMBOL(tls_server_keyupdate_psk);
> > > +
> > >   /**
> > >    * tls_handshake_cancel - cancel a pending handshake
> > >    * @sk: socket on which there is an ongoing handshake
> > Nit: we _could_ overload 'peerid' with the user_session_id,then we
> > wouldn't need to specify a new field in the handshake
> > request.
> > But that's arguably quite hackish.
>
> Oh no! Let's not do that. That just seems prone to confusion
>
> Alistair
>
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                  Kernel Storage Architect
> > hare@suse.de                                +49 911 74053 688
> > SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> > HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

