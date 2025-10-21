Return-Path: <linux-nfs+bounces-15427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C37BF47EA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 05:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3D814EA25D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 03:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1C223707;
	Tue, 21 Oct 2025 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLAZkkV8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E56136351
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016824; cv=none; b=tCZHkNrlhrMK6pTAJBtiEm9SHN5wBv02I9Zffy3KsMhXE9uiUfmsyvn/6oyacFPSNseQPZaDQObccec1LVnLgT58f6K9Um+WLnb3QF/VvvwYU0VtxPR6cZ24E5OJPSuD2z6s7zFxW1UI87LlLg0k1B9EojwaqypoDd2sU9aXAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016824; c=relaxed/simple;
	bh=DxUQv/9ds5xNkXtmgS/LZl6/6F3j7jAb05ovJhOTnLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0e9X/fYVZn08NHm45bV2Ok2lsQZVro9iypBmV0fcqgXJe3yYgXMi6Nw7gJIXp4RtccAWRd+ZgAkd8T51MUpeNECSVYxdFynWcgkw1YYfAdFdJ48ohCU42KWMGy1MRqrpA4mXpwDa4wcQDUyyHaIiOHrSmwsLYByjWsCno7TxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLAZkkV8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so5628365a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 20:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016820; x=1761621620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCNvyw8m2QX1VIGFb99RS6GnyHPuBwl16dP0YQiFQRk=;
        b=ZLAZkkV8V0F9GNY4jxS6Npn80vMvGNe3mUTl6uXiDIeHJggoGmb1zb8c1/ZI8BD/VP
         7q5ykB5GPnjcmvja9SRcGdffgZFTBBqZAueOr18vY8PcKngi6qmwcG2ThiPFcpw3uyl1
         0xjg/CBn5UQfjVQE9L6S2/pJtLAL76BWCzFxf989gQgAkmba/3iZMpy81fO5iT5UAigM
         UCXIjFstQ15eADwGj7fFxBWxJ8GQn4ERDKjn8WGiKFGh6MG4MGB8NmC2dw4C4wYz2Yc4
         CW4+X1uyNEBYdT/33S4HJUd1tDzlGQrF5XtcjzaD2bfJkDWg4e4H2U2ooOil0QAv7UjJ
         KUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016820; x=1761621620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCNvyw8m2QX1VIGFb99RS6GnyHPuBwl16dP0YQiFQRk=;
        b=E8APAryPqznkWRVdpZaicYevlS50i93xbc07w73uXmHhtoTcur+ZuP5//7aJlG1sas
         7+nxY4Scko78w6r/V1mGuq7JVj+fABIagg49cE6Ow+I/zu2YemQ2yCenyhdtgnDaP0fm
         tGqnVXMSG/1uWsdheDLKN7HM19ZVR8Pz+lDA9C0STc0vCvttEllQYHlG8Y5Zyfp+Bx8v
         jqBnsquJAh7Jy/ltjXp7DvSJFZyfg5iiQsuqhe4HfurWVd75cuHas+ZseGYgAhEBb1gt
         fTycGZlcjoozixbmA6YWa2CwYW5N7LP+yW3G9YmNUlhKc6679bwNk26hfLtC0YPD+5My
         rhkA==
X-Forwarded-Encrypted: i=1; AJvYcCXx3UlMbSyw3561n4PIIKYKgD0gyQAGLehJaOCQQPGm39PlH7vVUcR4gGskraK1gGkJmOewUZ5IQ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTp2eScdS4cF/bNpEVGm1cEe1h8ZczoYMhIZ+CYdlpV+Ygh3gm
	PONwrhCPShSNMBapgdXBR8hTaDc56DdSk/89uwXSeV/5H3dGstRg3ieg3BHKPGDzhFMUEsz+N3K
	7MC45+1wyQABKTq7bypW03GSEODlelHc=
X-Gm-Gg: ASbGnctJa+xd0Z0vPK0S9tnvs5ZopPDp02qCerEGPZYWc+KhPN/nMgrGO0vbbGQEeeT
	ffW9u71VX09mVwZxnsk47uWuseQLbQ4Y2oUXDabPQ7pGH+l6EBho1tYK4S5VMjsiU0Vew1GLvfX
	GXwLLDI/EP3fewUdEMx6QLCvmb5SMGYRdQt1e078zP1utgiqVFAYjmTOLFzfaTefNUQ61YYHz8G
	XY8sWwhServv5b2a3eZfLmLSATCRgIKC+m2az2t1KRPOK2jG8bAwIEpx3ZUpO4gjt2iwfcP5kWa
	AfERjEjD2UJ3tQ8fp0poKY2pcQ==
X-Google-Smtp-Source: AGHT+IEsnmHK88912XQyF+ULc5HjsHFjFCxHsTm5vWc53Obeo6iDSP0Fs5p3c4KR3eNywOjh1EZStCqv8ly1yB9KL/k=
X-Received: by 2002:a05:6402:354f:b0:63c:6537:43d2 with SMTP id
 4fb4d7f45d1cf-63c65374608mr7802783a12.38.1761016819680; Mon, 20 Oct 2025
 20:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-5-alistair.francis@wdc.com> <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
In-Reply-To: <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Oct 2025 13:19:53 +1000
X-Gm-Features: AS18NWAyhNaTenQO2sZ2HNxBD0TNSlf23hB-sIzI2xuCGrNnY_zE8OZIe2AJIGI
Message-ID: <CAKmqyKMsYUPLz9hVmM_rjXKSo52cMEtn8qVwbSs=UknxRWaQUw@mail.gmail.com>
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

On Mon, Oct 20, 2025 at 4:09=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/17/25 06:23, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > When reporting the msg-type to userspace let's also support reporting
> > KeyUpdate events. This supports reporting a client/server event and if
> > the other side requested a KeyUpdateRequest.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v4:
> >   - Don't overload existing functions, instead create new ones
> > v3:
> >   - Fixup yamllint and kernel-doc failures
> >
> >   Documentation/netlink/specs/handshake.yaml | 16 ++++-
> >   drivers/nvme/host/tcp.c                    | 15 +++-
> >   drivers/nvme/target/tcp.c                  | 10 ++-
> >   include/net/handshake.h                    |  8 +++
> >   include/uapi/linux/handshake.h             | 13 ++++
> >   net/handshake/tlshd.c                      | 83 +++++++++++++++++++++=
-
> >   6 files changed, 137 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation=
/netlink/specs/handshake.yaml
> > index a273bc74d26f..c72ec8fa7d7a 100644
> > --- a/Documentation/netlink/specs/handshake.yaml
> > +++ b/Documentation/netlink/specs/handshake.yaml
> > @@ -21,12 +21,18 @@ definitions:
> >       type: enum
> >       name: msg-type
> >       value-start: 0
> > -    entries: [unspec, clienthello, serverhello]
> > +    entries: [unspec, clienthello, serverhello, clientkeyupdate,
> > +              clientkeyupdaterequest, serverkeyupdate, serverkeyupdate=
request]
> >     -
>
> Why do we need the 'keyupdate' and 'keyupdaterequest' types?

msg-type indicates if it's a client or server and hello or keyupdate,
the idea being

client:
 - Hello
 - KeyUpdate

server:
 - Hello
 - KeyUpdate

I'll drop clientkeyupdaterequest and serverkeyupdaterequest

> Isn't the 'keyupdate' type enough, and can we specify anything
> else via the update type?

Once we know if it's a client or server KeyUpdate we need to know if
we are receiving one, sending one or receiving one with the
request_update flag set, hence key-update-type

>
> >       type: enum
> >       name: auth
> >       value-start: 0
> >       entries: [unspec, unauth, psk, x509]
> > +  -
> > +    type: enum
> > +    name: key-update-type
> > +    value-start: 0
> > +    entries: [unspec, send, received, received_request_update]
>
> See above.
>
> >
> >   attribute-sets:
> >     -
> > @@ -74,6 +80,13 @@ attribute-sets:
> >         -
> >           name: keyring
> >           type: u32
> > +      -
> > +        name: key-update-request
> > +        type: u32
> > +        enum: key-update-type
> > +      -
> > +        name: key-serial
> > +        type: u32
>
> Not sure if I like key-serial. Yes, it is a key serial number,
> but it's not the serial number of the updated key (rather the serial
> number of the key holding the session information).
> Maybe 'key-update-serial' ?
>
> >     -
> >       name: done
> >       attributes:
> > @@ -116,6 +129,7 @@ operations:
> >               - certificate
> >               - peername
> >               - keyring
> > +            - key-serial
> >       -
> >         name: done
> >         doc: Handler reports handshake completion
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 611be56f8013..2696bf97dfac 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/iov_iter.h>
> >   #include <net/busy_poll.h>
> >   #include <trace/events/sock.h>
> > +#include <uapi/linux/handshake.h>
> >
> >   #include "nvme.h"
> >   #include "fabrics.h"
> > @@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
> >   static const struct blk_mq_ops nvme_tcp_mq_ops;
> >   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> >   static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
> > +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> > +                           struct nvme_tcp_queue *queue,
> > +                           key_serial_t pskid,
> > +                           handshake_key_update_type keyupdate);
> >
> >   static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctr=
l)
> >   {
> > @@ -1726,7 +1731,8 @@ static void nvme_tcp_tls_done(void *data, int sta=
tus, key_serial_t pskid,
> >
> >   static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> >                             struct nvme_tcp_queue *queue,
> > -                           key_serial_t pskid)
> > +                           key_serial_t pskid,
> > +                           handshake_key_update_type keyupdate)
> >   {
> >       int qid =3D nvme_tcp_queue_id(queue);
> >       int ret;
> > @@ -1748,7 +1754,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *=
nctrl,
> >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> >       queue->tls_err =3D -EOPNOTSUPP;
> >       init_completion(&queue->tls_complete);
> > -     ret =3D tls_client_hello_psk(&args, GFP_KERNEL);
> > +     if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> > +             ret =3D tls_client_hello_psk(&args, GFP_KERNEL);
> > +     else
> > +             ret =3D tls_client_keyupdate_psk(&args, GFP_KERNEL, keyup=
date);
> >       if (ret) {
> >               dev_err(nctrl->device, "queue %d: failed to start TLS: %d=
\n",
> >                       qid, ret);
> > @@ -1898,7 +1907,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl =
*nctrl, int qid,
> >
> >       /* If PSKs are configured try to start TLS */
> >       if (nvme_tcp_tls_configured(nctrl) && pskid) {
> > -             ret =3D nvme_tcp_start_tls(nctrl, queue, pskid);
> > +             ret =3D nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE=
_KEY_UPDATE_TYPE_UNSPEC);
> >               if (ret)
> >                       goto err_init_connect;
> >       }
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 4ef4dd140ada..8aeec4a7f136 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(struc=
t work_struct *w)
> >       kref_put(&queue->kref, nvmet_tcp_release_queue);
> >   }
> >
> > -static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
> > +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> > +     handshake_key_update_type keyupdate)
> >   {
> >       int ret =3D -EOPNOTSUPP;
> >       struct tls_handshake_args args;
> > @@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_=
tcp_queue *queue)
> >       args.ta_keyring =3D key_serial(queue->port->nport->keyring);
> >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> >
> > -     ret =3D tls_server_hello_psk(&args, GFP_KERNEL);
> > +     if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> > +             ret =3D tls_server_hello_psk(&args, GFP_KERNEL);
> > +     else
> > +             ret =3D tls_server_keyupdate_psk(&args, GFP_KERNEL, keyup=
date);
> >       if (ret) {
> >               kref_put(&queue->kref, nvmet_tcp_release_queue);
> >               pr_err("failed to start TLS, err=3D%d\n", ret);
> > @@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tc=
p_port *port,
> >               sk->sk_data_ready =3D port->data_ready;
> >               write_unlock_bh(&sk->sk_callback_lock);
> >               if (!nvmet_tcp_try_peek_pdu(queue)) {
> > -                     if (!nvmet_tcp_tls_handshake(queue))
> > +                     if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY=
_UPDATE_TYPE_UNSPEC))
> >                               return;
> >                       /* TLS handshake failed, terminate the connection=
 */
> >                       goto out_destroy_sq;
> > diff --git a/include/net/handshake.h b/include/net/handshake.h
> > index dc2222fd6d99..084c92a20b68 100644
> > --- a/include/net/handshake.h
> > +++ b/include/net/handshake.h
> > @@ -10,6 +10,10 @@
> >   #ifndef _NET_HANDSHAKE_H
> >   #define _NET_HANDSHAKE_H
> >
> > +#include <uapi/linux/handshake.h>
> > +
> > +#define handshake_key_update_type u32
> > +
> Huh?
> You define it as 'u32' here
>
> >   enum {
> >       TLS_NO_KEYRING =3D 0,
> >       TLS_NO_PEERID =3D 0,
> > @@ -38,8 +42,12 @@ struct tls_handshake_args {
> >   int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_=
t flags);
> >   int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_=
t flags);
> >   int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t=
 flags);
> > +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gf=
p_t flags,
> > +                          handshake_key_update_type keyupdate);
> >   int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_=
t flags);
> >   int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t=
 flags);
> > +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gf=
p_t flags,
> > +                          handshake_key_update_type keyupdate);
> >
> >   bool tls_handshake_cancel(struct sock *sk);
> >   void tls_handshake_close(struct socket *sock);
> > diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handsh=
ake.h
> > index b68ffbaa5f31..b691530073c6 100644
> > --- a/include/uapi/linux/handshake.h
> > +++ b/include/uapi/linux/handshake.h
> > @@ -19,6 +19,10 @@ enum handshake_msg_type {
> >       HANDSHAKE_MSG_TYPE_UNSPEC,
> >       HANDSHAKE_MSG_TYPE_CLIENTHELLO,
> >       HANDSHAKE_MSG_TYPE_SERVERHELLO,
> > +     HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
> > +     HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATEREQUEST,
> > +     HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
> > +     HANDSHAKE_MSG_TYPE_SERVERKEYUPDATEREQUEST,
> >   };
> >
> >   enum handshake_auth {
> > @@ -28,6 +32,13 @@ enum handshake_auth {
> >       HANDSHAKE_AUTH_X509,
> >   };
> >
> > +enum handshake_key_update_type {
> > +     HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
> > +     HANDSHAKE_KEY_UPDATE_TYPE_SEND,
> > +     HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
> > +     HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
> > +};
> > +
>
> and here it's an enum. Please kill the first declaration.
>
> >   enum {
> >       HANDSHAKE_A_X509_CERT =3D 1,
> >       HANDSHAKE_A_X509_PRIVKEY,
> > @@ -46,6 +57,8 @@ enum {
> >       HANDSHAKE_A_ACCEPT_CERTIFICATE,
> >       HANDSHAKE_A_ACCEPT_PEERNAME,
> >       HANDSHAKE_A_ACCEPT_KEYRING,
> > +     HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> > +     HANDSHAKE_A_ACCEPT_KEY_SERIAL,
> >
> >       __HANDSHAKE_A_ACCEPT_MAX,
> >       HANDSHAKE_A_ACCEPT_MAX =3D (__HANDSHAKE_A_ACCEPT_MAX - 1)
> > diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> > index 2549c5dbccd8..c40839977ab9 100644
> > --- a/net/handshake/tlshd.c
> > +++ b/net/handshake/tlshd.c
> > @@ -41,6 +41,7 @@ struct tls_handshake_req {
> >       unsigned int            th_num_peerids;
> >       key_serial_t            th_peerid[5];
> >
> > +     int                     th_key_update_request;
> >       key_serial_t            user_session_id;
> >   };
> >
> Why 'int' ? Can it be negative?
> If not please make it an 'unsigned int'
>
> > @@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
> >       treq->th_num_peerids =3D 0;
> >       treq->th_certificate =3D TLS_NO_CERT;
> >       treq->th_privkey =3D TLS_NO_PRIVKEY;
> > -     treq->user_session_id =3D TLS_NO_PRIVKEY;
> > +     treq->user_session_id =3D args->user_session_id;
> > +
> >       return treq;
> >   }
> >
> > @@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake_r=
eq *req,
> >               break;
> >       }
> >
> > +     ret =3D nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_SERIAL,
> > +                       treq->user_session_id);
> > +     if (ret < 0)
> > +             goto out_cancel;
> > +
> > +     ret =3D nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> > +                       treq->th_key_update_request);
> > +     if (ret < 0)
> > +             goto out_cancel;
> > +
> >       genlmsg_end(msg, hdr);
> >       return genlmsg_reply(msg, info);
> >
> > @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handshak=
e_args *args, gfp_t flags)
> >   }
> >   EXPORT_SYMBOL(tls_client_hello_psk);
> >
> > +/**
> > + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a s=
ocket
> > + * @args: socket and handshake parameters for this request
> > + * @flags: memory allocation control flags
> > + * @keyupdate: specifies the type of KeyUpdate operation
> > + *
> > + * Return values:
> > + *   %0: Handshake request enqueue; ->done will be called when complet=
e
> > + *   %-EINVAL: Wrong number of local peer IDs
> > + *   %-ESRCH: No user agent is available
> > + *   %-ENOMEM: Memory allocation failed
> > + */
> > +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gf=
p_t flags,
> > +                          handshake_key_update_type keyupdate)
> > +{
> > +     struct tls_handshake_req *treq;
> > +     struct handshake_req *req;
> > +     unsigned int i;
> > +
> > +     if (!args->ta_num_peerids ||
> > +         args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
> > +             return -EINVAL;
> > +
> > +     req =3D handshake_req_alloc(&tls_handshake_proto, flags);
> > +     if (!req)
> > +             return -ENOMEM;
> > +     treq =3D tls_handshake_req_init(req, args);
> > +     treq->th_type =3D HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
> > +     treq->th_key_update_request =3D keyupdate;
> > +     treq->th_auth_mode =3D HANDSHAKE_AUTH_PSK;
> > +     treq->th_num_peerids =3D args->ta_num_peerids;
> > +     for (i =3D 0; i < args->ta_num_peerids; i++)
> > +             treq->th_peerid[i] =3D args->ta_my_peerids[i];
> Hmm?
> Do we use the 'peerids'?

We don't, this is just copied from the
tls_client_hello_psk()/tls_server_hello_psk() to provide the same
information to keep things more consistent.

I can remove setting these

> I thought that the information was encoded in the session, ie
> the 'user_session_id' ?
>
> > +
> > +     return handshake_req_submit(args->ta_sock, req, flags);
> > +}
> > +EXPORT_SYMBOL(tls_client_keyupdate_psk);
> > +
> >   /**
> >    * tls_server_hello_x509 - request a server TLS handshake on a socket
> >    * @args: socket and handshake parameters for this request
> > @@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handshak=
e_args *args, gfp_t flags)
> >   }
> >   EXPORT_SYMBOL(tls_server_hello_psk);
> >
> > +/**
> > + * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a sock=
et
> > + * @args: socket and handshake parameters for this request
> > + * @flags: memory allocation control flags
> > + * @keyupdate: specifies the type of KeyUpdate operation
> > + *
> > + * Return values:
> > + *   %0: Handshake request enqueue; ->done will be called when complet=
e
> > + *   %-ESRCH: No user agent is available
> > + *   %-ENOMEM: Memory allocation failed
> > + */
> > +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gf=
p_t flags,
> > +                          handshake_key_update_type keyupdate)
> > +{
> > +     struct tls_handshake_req *treq;
> > +     struct handshake_req *req;
> > +
> > +     req =3D handshake_req_alloc(&tls_handshake_proto, flags);
> > +     if (!req)
> > +             return -ENOMEM;
> > +     treq =3D tls_handshake_req_init(req, args);
> > +     treq->th_type =3D HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
> > +     treq->th_key_update_request =3D keyupdate;
> > +     treq->th_auth_mode =3D HANDSHAKE_AUTH_PSK;
> > +     treq->th_num_peerids =3D 1;
> > +     treq->th_peerid[0] =3D args->ta_my_peerids[0];
>
> Same here. Why do we need to set 'peerid'?
>
> > +
> > +     return handshake_req_submit(args->ta_sock, req, flags);
> > +}
> > +EXPORT_SYMBOL(tls_server_keyupdate_psk);
> > +
> >   /**
> >    * tls_handshake_cancel - cancel a pending handshake
> >    * @sk: socket on which there is an ongoing handshake
> Nit: we _could_ overload 'peerid' with the user_session_id,then we
> wouldn't need to specify a new field in the handshake
> request.
> But that's arguably quite hackish.

Oh no! Let's not do that. That just seems prone to confusion

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

