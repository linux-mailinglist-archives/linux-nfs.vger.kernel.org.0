Return-Path: <linux-nfs+bounces-15490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03319BF9F4C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 06:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3E35405E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 04:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F162D6E7A;
	Wed, 22 Oct 2025 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8GSd1nf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9D2D0601
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107738; cv=none; b=UUdI0oxIgxru0wbIHqruhY30xQmV4b/bjOC4Ld9ZIzLAk/L9SxRczLN+TtXPqqYNRog5m1fp9jX7G8f2IX/zwi+76jBa6yCM4SJhwNpItAbhriXiWh3EHCosLxv7IhynitSMd1HOx1xGZttGSbruPIgjvFaiCIjdnELy8/RB9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107738; c=relaxed/simple;
	bh=7tAdD3oiYu3/bK3o6xitdgp7OB0lFPYIC2IA0keXGgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPP0F9OcFFZcn99G0dDNO2Wr5Xv9MNNl4kP3z15LPLbQxDqxX4bSHNy4si0vHPZOF/3GdbzgOglu4BMepIhs2ZlwmGaOAL4BnkyX0fR1cgkPylRdwRzgEEtAOcXtPws6Q/W9DnYLA/f1hiAJPmh0cYkmBAd40SqJa7iHD7sjyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8GSd1nf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b456d2dc440so1039871966b.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761107734; x=1761712534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj64m4sFpQ+vBQ3pmykp/cp6K9VYRj1HaNi/Sdpj2VM=;
        b=Z8GSd1nfTsmSaoQgUFzMoMMZYMCL7TgGgVogMsB1qETCYlVqTixjZ6T/MElrlzpOI9
         vLpJnODkIlTM4Mn/YFeoOQkKeIsVEyRYkAE88v76IAHzgwjJFHzEs7ZGVl91m3IQ0x+9
         iJDmTur+R4mAAgtDkI7YZJAS9Q1utBqUFpq60R+tQE7rBvuBJOuc8IMvG+3y2+Jm3q8S
         hCzJL/ZE2orJ+3vS95E/RJOeXp1xpcUEAdqTuTiwl10p/MzkPqUCl9WA/yXgCSeaFu+U
         gkI40ys1JyM1rglrf7dM0sqbfRyB/t4wFVfY8yn9iY1ccxydHNVY6u7jmNexhea3F7Uj
         J6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107734; x=1761712534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj64m4sFpQ+vBQ3pmykp/cp6K9VYRj1HaNi/Sdpj2VM=;
        b=bMHuPS5lBcEREPixvP+3dkEDSD85NSFbtaK4DdBunXYZF/ifLxIVVih04UDFFWMBEv
         aSvRh3XX1qxb3Ex0dU/rXu20ScJgzAMGUjledKf4W/kX2LY6xx+2Ey7iJS6wH/gap9zV
         03c6JOwS/nxatBKAutDu1LJg1hlIWWBp2G00I39NcRn3ifTqy1wrtji15pt9y6KIlQ80
         tGfKD41ywi++Fuv7lbIq8pJpyt5vFfjSBF+FB5EfCc+mNuqI4F6sMIEVEJMMR48NA7V9
         hVn6ulOXlNMFOztAQDwY929lTHmCbv7ualM2tqFvytNWUyHXJLfh/XAfEtgJiuQaTeI1
         VjjA==
X-Forwarded-Encrypted: i=1; AJvYcCV+543we9twN8isKsPBh4AC4sS1kb4QNtkppHcHDYDE+hAiNdYqxiw+O1aFfnD1+yAndLE5VEtOU84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oUuoQfhKWWPjUF1Ww/gSk14+AHPTd+gej35zi4VUqD8/YEbH
	T3D6VF5ZFn+jJfa4ccNemvRTW/j1+qoxUWXwz/ibPevGPlIrX3SBsSOENhDLELbmnrD8WSk2bLv
	TwnytlKMU+Ct23aWiH3N8Nuz9Irf6FoI=
X-Gm-Gg: ASbGnctmYjdDGA5g41UxLuSALQk6d/IpH+/eW84mLqVabjrtE3/dIETQb/YH34BZLCk
	66O5e0Zl2/eu0IT6oYOs/hCLwt9A1842ECByIt0xtBNogCQa6Ex0wHiJNtZ9Tul3cWGXbiqk5S7
	IFfTG5RHgJltvSp93181eoiPTao8BCU8Rvm9YC7SxfQTq+eC7f9KClSGDpFJ1K2aBUXPLFIgp34
	ezMyEGTqi3gSrCJ2JfLzLoFsGZ65v8piHkIywDp+BhZfOHl0erwrnocGHxbKbCidR+7c6JZOHnP
	BqGF6VIlYJbM3RPx1pWhSRbczg==
X-Google-Smtp-Source: AGHT+IEZ3WUWSBwKFpcrNZdWHcs2uENHhK+jxYuhPktOZEvX65BdGAZNuCfRsdi3SwrTO654hvsTxTI1H3lWOnGyc2U=
X-Received: by 2002:a17:907:3f25:b0:b40:5dac:ed3f with SMTP id
 a640c23a62f3a-b6472b6047fmr2009158266b.7.1761107734076; Tue, 21 Oct 2025
 21:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com> <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
In-Reply-To: <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 14:35:07 +1000
X-Gm-Features: AS18NWBbcQHf212IwDSHi_pCF6tkVLcWMLdXbgbTquHdoKUeBkgiVMl2L0_vC_o
Message-ID: <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:22=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/17/25 06:23, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> > EKEYEXPIRED then the underlying TLS keys need to be updated. This occur=
s
> > on an KeyUpdate event.
> >
> > If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> > allow the NVMe layer to process the KeyUpdate request and forward the
> > request to userspace. Userspace must then update the key to keep the
> > connection alive.
> >
> > This patch allows us to handle the NVMe target sending a KeyUpdate
> > request without aborting the connection. At this time we don't support
> > initiating a KeyUpdate.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v4:
> >   - Remove all support for initiating KeyUpdate
> >   - Don't call cancel_work() when updating keys
> > v3:
> >   - Don't cancel existing handshake requests
> > v2:
> >   - Don't change the state
> >   - Use a helper function for KeyUpdates
> >   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
> >   - Remove command message using recvmsg
> >
> >   drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++------=
-
> >   1 file changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 2696bf97dfac..791e0cc91ad8 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            user_session_id;
> >       __le32                  exp_ddgst;
> >       __le32                  recv_ddgst;
> >       struct completion       tls_complete;
> > @@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_t=
cp_queue *queue,
> >   static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
> >   {
> >       char *pdu =3D queue->pdu;
> > +     char cbuf[CMSG_LEN(sizeof(char))] =3D {};
> >       struct msghdr msg =3D {
> > +             .msg_control =3D cbuf,
> > +             .msg_controllen =3D sizeof(cbuf),
> >               .msg_flags =3D MSG_DONTWAIT,
> >       };
> >       struct kvec iov =3D {
> > @@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_q=
ueue *queue)
> >       if (ret <=3D 0)
> >               return ret;
> >
> > +     hdr =3D queue->pdu;
> > +     if (hdr->type =3D=3D TLS_HANDSHAKE_KEYUPDATE) {
> > +             dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> > +             return 1;
> > +     }
> > +
> >       queue->pdu_remaining -=3D ret;
> >       queue->pdu_offset +=3D ret;
> >       if (queue->pdu_remaining)
> >               return 0;
> >
> > -     hdr =3D queue->pdu;
> >       if (unlikely(hdr->hlen !=3D sizeof(struct nvme_tcp_rsp_pdu))) {
> >               if (!nvme_tcp_recv_pdu_supported(hdr->type))
> >                       goto unsupported_pdu;
> > @@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_qu=
eue *queue)
> >       struct request *rq =3D
> >               nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> >       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
> > +     char cbuf[CMSG_LEN(sizeof(char))] =3D {};
> >
> >       if (nvme_tcp_recv_state(queue) !=3D NVME_TCP_RECV_DATA)
> >               return 0;
> > @@ -973,12 +983,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_=
queue *queue)
> >               memset(&msg, 0, sizeof(msg));
> >               msg.msg_iter =3D req->iter;
> >               msg.msg_flags =3D MSG_DONTWAIT;
> > +             msg.msg_control =3D cbuf,
> > +             msg.msg_controllen =3D sizeof(cbuf),
> >
> Watch out. This is the recvmsg bug Olga had been posting patches for.
> Thing is, if there is a control message the networking code will place
> the control message payload into the message buffer. But in doing so
> it expects the message buffer to be an iovec, not a bio vec.
>
> To handle this properly you'd need to _not_ set the control buffer,
> but rather check for 'MSG_CTRUNC' in msg_flags upon return.
> Then you have to setup a new message with msg_control set and
> a suitable msg_len (5 bytes, wasn't it?) and re-issue recvmsg
> with that message.

Fixed

>
> And keep fingers crossed that you don't get MSG_CTRUNC on every
> call to recvmsg() ...
>
> >               ret =3D sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> >               if (ret < 0) {
> > -                     dev_err(queue->ctrl->ctrl.device,
> > -                             "queue %d failed to receive request %#x d=
ata",
> > -                             nvme_tcp_queue_id(queue), rq->tag);
> > +                     dev_dbg(queue->ctrl->ctrl.device,
> > +                             "queue %d failed to receive request %#x d=
ata, %d",
> > +                             nvme_tcp_queue_id(queue), rq->tag, ret);
> >                       return ret;
> >               }
> >               if (queue->data_digest)
> > @@ -1381,17 +1393,42 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp=
_queue *queue)
> >               }
> >       } while (result >=3D 0);
> >
> > -     if (result < 0 && result !=3D -EAGAIN) {
> > +     if (result =3D=3D -EKEYEXPIRED) {
> > +             return -EKEYEXPIRED;
> > +     } else if (result =3D=3D -EAGAIN) {
> > +             return -EAGAIN;
> > +     } else if (result < 0) {
> >               dev_err(queue->ctrl->ctrl.device,
> >                       "receive failed:  %d\n", result);
> >               queue->rd_enabled =3D false;
> >               nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> > -     } else if (result =3D=3D -EAGAIN)
> > -             result =3D 0;
> > +     }
> >
> >       return result < 0 ? result : (queue->nr_cqe =3D nr_cqe);
> >   }
> >
> > +static void update_tls_keys(struct nvme_tcp_queue *queue)
> > +{
> > +     int qid =3D nvme_tcp_queue_id(queue);
> > +     int ret;
> > +
> > +     dev_dbg(queue->ctrl->ctrl.device,
> > +             "updating key for queue %d\n", qid);
> > +
> > +     flush_work(&(queue->ctrl->ctrl).async_event_work);
> > +
> > +     ret =3D nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> > +                              queue, queue->ctrl->ctrl.tls_pskid,
> > +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> > +
> > +     if (ret < 0) {
> > +             dev_err(queue->ctrl->ctrl.device,
> > +                     "failed to update the keys %d\n", ret);
> > +             nvme_tcp_fail_request(queue->request);
> > +             nvme_tcp_done_send_req(queue);
> > +     }
> > +}
> > +
> >   static void nvme_tcp_io_work(struct work_struct *w)
> >   {
> >       struct nvme_tcp_queue *queue =3D
> > @@ -1414,8 +1451,11 @@ static void nvme_tcp_io_work(struct work_struct =
*w)
> >               result =3D nvme_tcp_try_recvmsg(queue);
> >               if (result > 0)
> >                       pending =3D true;
> > -             else if (unlikely(result < 0))
> > -                     return;
> > +             else if (unlikely(result < 0)) {
> > +                     if (result =3D=3D -EKEYEXPIRED)
> > +                             update_tls_keys(queue);
> > +                     break;
> > +             }
> >
> >               /* did we get some space after spending time in recv? */
> >               if (nvme_tcp_queue_has_pending(queue) &&
> > @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int sta=
tus, key_serial_t pskid,
> >                       ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >               key_put(tls_key);
> >               queue->tls_err =3D 0;
> > +             queue->user_session_id =3D user_session_id;
>
> Hmm. I wonder, do we need to store the generation number somewhere?
> Currently the sysfs interface is completely oblivious that a key update
> has happened. I really would like to have _some_ indicator there telling
> us that a key update had happened, and the generation number would be
> ideal here.

I don't follow.

The TLS layer will report the number of KeyUpdates that have been
received. Userspace also knows that a KeyUpdate happened as we call to
userspace to handle updating the keys.

Alistair

>
> >       }
> >
> >   out_complete:
> > @@ -1752,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *n=
ctrl,
> >               keyring =3D key_serial(nctrl->opts->keyring);
> >       args.ta_keyring =3D keyring;
> >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> > +     args.user_session_id =3D queue->user_session_id;
> >       queue->tls_err =3D -EOPNOTSUPP;
> >       init_completion(&queue->tls_complete);
> >       if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
>
> Chers,
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

