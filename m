Return-Path: <linux-nfs+bounces-16830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7554C99971
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 00:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0444E108C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 23:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C946288C0A;
	Mon,  1 Dec 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY8qJAEJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEB28642B
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631666; cv=none; b=q2eTPq2/g8dwuWe5WMKH1/hLSOj4R/xZhVns1Xyzw34NDznLenOL9qsS/2U1Ev+a8TL2qHvrsi7u2yGviBblluKWjBBH9VqaPMZCqq4U5ms4bTiwNSooDRpkK4CJ8l/DwxGSFMsYBpMX1B3S4Hugy4njzZFq8Z7gbn+Wa1R25OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631666; c=relaxed/simple;
	bh=2v7PUt3zWp+C6C2zHvV/eYFuT92dPOAzdkMDCQL1GT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbR6DDCeRKGwdR+1vN+FMy8M8B27zZt/OJf6A6lSXZyWYQi/HaG8jcQPByEN+utgFWw3hLIGOfkXsIqSohhwBXn2hi7nAW43El7nTRykOa9vAoGh7Ks7SYl8DFecU989+/7tmuYR2bUnCQvgwQw7X+2kVOdwXwnS46rrtDvmDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY8qJAEJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b737cd03d46so687479366b.0
        for <linux-nfs@vger.kernel.org>; Mon, 01 Dec 2025 15:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764631662; x=1765236462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5v1/VXYzTJjMPpWg21e/KcaL7VxnGFLf4XvfhndU1c=;
        b=IY8qJAEJ3HCv2gYBUARWpMwqUSxLyV7DgZ8smCMhho3bFstcxjmp9A9QTrsDc8Tui0
         /aC+g4sAMcKcTGjzlgDGCyyAmi77OpTL0EI7+LnQ/Ne3N+Ep16cYyPabs6CLjQKxcWt7
         4dHbsL5NOedL2WK/cO7R/CTYnnt8qAgR7ken/pweNCwYkkHX0FAHt32ofYV9pzr6taB9
         sviKO9EpAWHPzgRJKQwMSyunSQn+Owrdl7O+gghDD2ub8a1x6W+ld8bGqC+T1sw9SWWm
         b6NXLAukeri8yx1EWFlT8jx19Pj2ovLf1FKlxsuyRvEOBdR9mbJz81meCHthTThI3CbR
         S54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764631662; x=1765236462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5v1/VXYzTJjMPpWg21e/KcaL7VxnGFLf4XvfhndU1c=;
        b=txI2j3MwOQTieU4Zze0bHx0BWFVYeja8fNEM1cenQHbsKIkSHQFwg+ayDkHISsgQe/
         bEeTdZZcATuF57SjOYT8xvCEQf34LT6Zn4YfGo/5ZkGXsAY4DoxBIwMdY7QBWizxDiuw
         RZyG8ne2+/S1oZuFj/Syf4P0AkXPjKJ/28/mXW5+7AHKuJeKSc5G+a3zVwJwNIbtL39p
         X5Af3JP5fOUtiM8Sh82nNCxi/mAU1miZlmy4C2QKvHazJ4BABKWzJLT39vU7nk5Rcoih
         JbXBZJ6co0HtprboxHIWPxDi3iCyevLYvlV6QR3ywfJoJRZyJSUlCnMAt06U87I6aeh5
         TDRg==
X-Forwarded-Encrypted: i=1; AJvYcCVJAmjC2iGn9XSjnN0uK/RI4LweLsG8xA24h2EyKd7wvFr8KMb8S4HwOjZzMuDPuzCJK5tJQ+3Aj6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpTm/7qYvy3KnDXW7j48agDQgAeoM35Zo9me8wV9Db6IVsccK
	rPvlP2rvFFv6kZXu6Y3DmwqwVrJXFR0uo1VANH+e3nAXC69avk/nIpsgeN3+5AQ+5g3jZ1aEP93
	iPPu0tzYpxLmPIeeFZKjeBX4/fMEp8VDO+g==
X-Gm-Gg: ASbGnctse2JJ8s7D8reKtTIux2ru95n7p8vsWHeASlAZNcegbVVT/KAAtNSqi2PKkf1
	DxfzIIS700Z5ZkluYtG6hZydOCpwom6IkvXuP5ArUlk7wAH9fZQtklyE+HCT4KPOaWLqq0enKRT
	5ySaqHwQzhgOqRHVKXO7LYH54tEa1jM2jSRWU+Ca/ZmLxf/cwKOQunA9bKW/ZRWLIC5k61FtZWp
	o/OExk4563veER0MzWKUwO2qy1E5ekm4aRCnUKnaPJpWe5kmv4QnYQDd7t63qIkW9+BDutrztbf
	FJAatmLUYOUNdfs+bCom3gaJvw==
X-Google-Smtp-Source: AGHT+IF9jmZyoLWFSx4hBdg0tZdsiQqccPSCxC9NjkJhrPQdxcaCTCtSHGJiP4lrMAOk35kCgFsaz5zURXiOG0ANOnM=
X-Received: by 2002:a17:907:1b28:b0:b73:6f8c:612b with SMTP id
 a640c23a62f3a-b76715653d5mr4425120366b.16.1764631662278; Mon, 01 Dec 2025
 15:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com> <1184961b-5488-4150-b647-29ed363e2276@grimberg.me>
In-Reply-To: <1184961b-5488-4150-b647-29ed363e2276@grimberg.me>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Dec 2025 09:27:15 +1000
X-Gm-Features: AWmQ_bk8CEM-2dviwMQHZxPcd6nv4bajHpJYpbv7ORWXtEq1tzS6ym3A8-DNYFg
Message-ID: <CAKmqyKPe_o8Yaa0uNd-PeGgT1GONwuLxjATRHW9a-6DV7c=4nA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Sagi Grimberg <sagi@grimberg.me>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 8:31=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wro=
te:
>
>
>
> On 12/11/2025 6:27, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> > EKEYEXPIRED then the underlying TLS keys need to be updated. This occur=
s
> > on an KeyUpdate event as described in RFC8446
> > https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
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
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
>
> I see this is on top of Hannes recvmsg patch. Worth noting in the patch
> here at least.
>
> > v5:
> >   - Cleanup code flow
> >   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
> >     and use that to determine if it's a control message
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
> >   drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 70 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 4797a4532b0d..5cec5a974bbf 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            handshake_session_id;
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
> > @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_=
queue *queue)
> >
> >               ret =3D sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> >               if (ret < 0) {
> > -                     dev_err(queue->ctrl->ctrl.device,
> > -                             "queue %d failed to receive request %#x d=
ata",
> > -                             nvme_tcp_queue_id(queue), rq->tag);
> > -                     return ret;
> > +                     /* If MSG_CTRUNC is set, it's a control message,
> > +                      * so let's read the control message.
> > +                      */
> > +                     if (msg.msg_flags & MSG_CTRUNC) {
> > +                             memset(&msg, 0, sizeof(msg));
> > +                             msg.msg_flags =3D MSG_DONTWAIT;
> > +                             msg.msg_control =3D cbuf;
> > +                             msg.msg_controllen =3D sizeof(cbuf);
> > +
> > +                             ret =3D sock_recvmsg(queue->sock, &msg, m=
sg.msg_flags);
> > +                     }
> > +
> > +                     if (ret < 0) {
> > +                             dev_dbg(queue->ctrl->ctrl.device,
> > +                                     "queue %d failed to receive reque=
st %#x data, %d",
> > +                                     nvme_tcp_queue_id(queue), rq->tag=
, ret);
> > +                             return ret;
> > +                     }
> > +
> > +                     return 0;
> >               }
> >               if (queue->data_digest)
> >                       nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
> > @@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp=
_queue *queue)
> >               }
> >       } while (result >=3D 0);
> >
> > -     if (result < 0 && result !=3D -EAGAIN) {
> > -             dev_err(queue->ctrl->ctrl.device,
> > -                     "receive failed:  %d\n", result);
> > -             queue->rd_enabled =3D false;
> > -             nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> > -     } else if (result =3D=3D -EAGAIN)
> > -             result =3D 0;
> > +     if (result < 0) {
> > +             if (result !=3D -EKEYEXPIRED && result !=3D -EAGAIN) {
> > +                     dev_err(queue->ctrl->ctrl.device,
> > +                             "receive failed:  %d\n", result);
> > +                     queue->rd_enabled =3D false;
> > +                     nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> > +             }
> > +             return result;
> > +     }
> > +
> > +     queue->nr_cqe =3D nr_cqe;
> > +     return nr_cqe;
> > +}
> > +
> > +static void update_tls_keys(struct nvme_tcp_queue *queue)
> > +{
> > +     int qid =3D nvme_tcp_queue_id(queue);
> > +     int ret;
> > +
> > +     dev_dbg(queue->ctrl->ctrl.device,
> > +             "updating key for queue %d\n", qid);
> >
> > -     return result < 0 ? result : (queue->nr_cqe =3D nr_cqe);
> > +     flush_work(&(queue->ctrl->ctrl).async_event_work);
> > +
> > +     ret =3D nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> > +                              queue, queue->ctrl->ctrl.tls_pskid,
> > +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
>
> No need to quiesce the queue or anything like that? everything continues
> as usual?

Everything just continues as usual. Besides a drop in throughput
waiting for the KeyUpdate you don't notice it. For testing I trigger
an update every 30 packets, it's slow but works

> Why are you flushing async_event_work?

I think that's just leftover from earlier, I'll remove it

Alistair

