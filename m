Return-Path: <linux-nfs+bounces-14497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26DB7E279
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA9B4E118F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 03:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E73B2F60DD;
	Wed, 17 Sep 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d92xco4P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C026AD9
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758078885; cv=none; b=Xs6RODoW6ADqNnNrguk7gNfSqPeZvdmp720vVevwUTb40KS5kh2mE+TC6aIMrjyC9QIFrU1PfyMze48JUKU0FqfUH+J2yTb8tVhhUE1MgQJQ/ES08hf8equSH+UmEyaFlqi9teXyKihnKIpMpeF9U5tYSjuMufv6fREAV4Pu0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758078885; c=relaxed/simple;
	bh=Z/MSIFiN82eflkb7jv68WI+DTQ0JCLDeojkD3HLHZ4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV3y/Rb1Fnijo/U4zaCzObYU1Hjufrmlo5A0KdlEew2BwnqKrAW2d3s+YLLEdKkiEr6SETrYCYYlrnCy+CqBfIxyLY9jEQNwOZxtf1DCrybb5AB5KYFbJN2wK2QTud7VvxfbBxMyWMtmF8A9iDS1aOFHbqE/q8BnKBpTxu91QX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d92xco4P; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso904142a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 20:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758078881; x=1758683681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYl9wW4dk4XbYzxIkLSJ4emAt8SgHCFiMbI64aRDGy8=;
        b=d92xco4PqzBJcT5W/akKi+kMVu0J+lJA0lcepVZenhFJ15zhGProolxMpydYVoyaCx
         KdQ7lgRWyAH3MsQ4EB6qQ9hfo5B3g1NPbH+uexCxLlEYO0uANbEYKdgxDs98ZFHvdVrG
         KSHo9EXFX0NkUY6P1qNgMBU3SdIAi6icfSoAIH1gBwPFuZjcpATsIdr+1alklQjr3/y8
         zfHHYSeEMlBwetLg8/1n1p25s3Gq4KEb5kPiz8sCnTtuKpc6Wf3MsXKP8XgGVqb7SODh
         gAV28lDB0Wug44ArjSwpWHSfgZLRjAmZhGuoSBMSv0PJaoGvWXEhTxM9FJACG9lmePRE
         pE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758078881; x=1758683681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYl9wW4dk4XbYzxIkLSJ4emAt8SgHCFiMbI64aRDGy8=;
        b=JytqTZWHlkTdXe3Fn7BczE2q3wb9oczLWZ0a2dEkVrivYZ8+BWG2w/3Wvv/LbRc3LW
         zLdLdL2tHVeJcLdq7nutt8v2B1N5CBP8LxiYUE8CxZjXlIvV8xoxBNzOj32SZn5kATlS
         0AaCutwReHBreL6SA2ld+FvbwzX1B6zSYlAVtHtbV8mX09oU6489zdU2b5JLczlNUAq5
         E1qT964VrZvHgiPx06jlSThRUSy04nDEynz/Ljyk2nts6LthcCJ3iqhjxHJk4sXpaCkv
         11XfGp+pdUAnhs5haxtl6rqPpxFfM8vi/GJflmbGK4ID/iRbkSUuqJhw+o6EH4IcMvhS
         94cw==
X-Forwarded-Encrypted: i=1; AJvYcCXmUYqMOpxRr6vGVHk7Gs25HkJ5xaWmzU4H8NQkQ+3ZW/1OnYFVueKM8v3igHZ7Kt/1nMz6bJOPJz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2HMAVpLbrslJ++T1zq0ctA28rS1L2nMsdW6Q6B+8PNPWMPbw
	FhM11OJz65d/DAQkmcPt7h9926Cd3gkzMxofdtnRcP5ubrGGC01/zkAVLdoN2GjzcwFcCwhAxSf
	094BoraJdoRFrNPM2YajJnyjL2883dig=
X-Gm-Gg: ASbGncsSOhfqXHprlEiMSfoZkSe/LTaIGSWZnAWm/8gGuTEsiJIaK4qyeAP/gKObig1
	lpSer0PX+3LGlt8S6t/lNclZq9C4LFx01liQejk3WDqPjgsXLBy2SbkhbL8zSmri6Xh8eDPkhGK
	bQqjh7k1q0YGm1wWJgsXAltDuwD0XYEA5h30tKyEiFekIdSP0BydeUCs1MCearR6un3ErabmsCb
	3xyuzg5XixubD2Q9GW4mZ4Suz7NldqdElIVkQ==
X-Google-Smtp-Source: AGHT+IGVGuR+PydNlyGT48zzkbhH6Jd/ETlW5flAIwO7dAryEXYAeMrXHZg9Ogqnyr7/1kVi1ExQPAkq73fN5EIrd0Y=
X-Received: by 2002:a17:907:da8:b0:afe:159:14b1 with SMTP id
 a640c23a62f3a-b1be49d7750mr65729166b.9.1758078880465; Tue, 16 Sep 2025
 20:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-7-alistair.francis@wdc.com> <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
In-Reply-To: <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 Sep 2025 13:14:14 +1000
X-Gm-Features: AS18NWDcMpm1G2mFqhUogMiikl4B2cDYrd9t5Pbx1ZhvlPjk4QLZp7NlJuRUoZU
Message-ID: <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:04=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 9/5/25 04:46, alistair23@gmail.com wrote:
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
> > v2:
> >   - Don't change the state
> >   - Use a helper function for KeyUpdates
> >   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
> >   - Remove command message using recvmsg
> >
> >   drivers/nvme/host/tcp.c | 73 +++++++++++++++++++++++++++++++++++++++-=
-
> >   1 file changed, 70 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 776047a71436..b6449effc2ac 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            user_session_id;
> >       __le32                  exp_ddgst;
> >       __le32                  recv_ddgst;
> >       struct completion       tls_complete;
> > @@ -210,6 +211,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nct=
rl,
> >                             struct nvme_tcp_queue *queue,
> >                             key_serial_t pskid,
> >                             handshake_key_update_type keyupdate);
> > +static void update_tls_keys(struct nvme_tcp_queue *queue);
> >
> >   static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctr=
l)
> >   {
> > @@ -393,6 +395,14 @@ static inline void nvme_tcp_send_all(struct nvme_t=
cp_queue *queue)
> >       do {
> >               ret =3D nvme_tcp_try_send(queue);
> >       } while (ret > 0);
> > +
> > +     if (ret =3D=3D -EKEYEXPIRED) {
> > +             update_tls_keys(queue);
> > +
> > +             do {
> > +                     ret =3D nvme_tcp_try_send(queue);
> > +             } while (ret > 0);
> > +     }
> >   }
> >
> >   static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *=
queue)
> > @@ -1347,6 +1357,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queu=
e *queue)
> >   done:
> >       if (ret =3D=3D -EAGAIN) {
> >               ret =3D 0;
> > +     } else if (ret =3D=3D -EKEYEXPIRED) {
> > +             goto out;
> >       } else if (ret < 0) {
> >               dev_err(queue->ctrl->ctrl.device,
> >                       "failed to send request %d\n", ret);
> > @@ -1371,9 +1383,56 @@ static int nvme_tcp_try_recv(struct nvme_tcp_que=
ue *queue)
> >       queue->nr_cqe =3D 0;
> >       consumed =3D sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb=
);
> >       release_sock(sk);
> > +
> > +     /* If we received EINVAL from read_sock then it generally means t=
he
> > +      * other side sent a command message. So let's try to clear it fr=
om
> > +      * our queue with a recvmsg, otherwise we get stuck in an infinit=
e
> > +      * loop.
> > +      */
> > +     if (consumed =3D=3D -EINVAL) {
> > +             char cbuf[CMSG_LEN(sizeof(char))] =3D {};
> > +             struct msghdr msg =3D { .msg_flags =3D MSG_DONTWAIT };
> > +             struct bio_vec bvec;
> > +
> > +             bvec_set_virt(&bvec, (void *)cbuf, sizeof(cbuf));
> > +             iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, sizeof(=
cbuf));
> > +
> > +             msg.msg_control =3D cbuf;
> > +             msg.msg_controllen =3D sizeof(cbuf);
> > +
> > +             consumed =3D sock_recvmsg(sock, &msg, msg.msg_flags);
> > +     }
> > +
> >       return consumed =3D=3D -EAGAIN ? 0 : consumed;
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
> > +     cancel_work(&queue->io_work);
> > +     handshake_req_cancel(queue->sock->sk);
> > +     handshake_sk_destruct_req(queue->sock->sk);
> > +
> Careful here. The RFC fully expects to have several KeyUpdate requests
> pending (eg if both sides decide so initiate a KeyUpdate at the same
> time). And cancelling a handshake request would cause tlshd/gnutls
> to lose track of the generation counter and generate an invalid
> traffic secret.
> I would just let it rip and don't bother with other handshake
> requests.

Unfortunately that doesn't work as future calls to
`handshake_req_hash_add()` will fail.

I now think that's a bug in `handshake_complete()` and I have a better
fix in the next version.

>
> > +     nvme_stop_keep_alive(&(queue->ctrl->ctrl));
> > +     flush_work(&(queue->ctrl->ctrl).async_event_work);
> > +
> Oh bugger. Seems like gnutls is generating the KeyUpdate message
> itself, and we have to wait for that.

Yes, we have gnutls generate the message.

> So much for KeyUpdate being transparent without having to stop I/O...
>
> Can't we fix gnutls to make sending the KeyUpdate message and changing
> the IV parameters an atomic operation? That would be a far better

I'm not sure I follow.

ktls-utils will first restore the gnutls session. Then have gnutls
trigger a KeyUpdate.gnutls will send a KeyUpdate and then tell the
kernel the new keys. The kernel cannot send or encrypt any data after
the KeyUpdate has been sent until the keys are updated.

I don't see how we could make it an atomic operation. We have to stop
the traffic between sending a KeyUpdate and updating the keys.
Otherwise we will send invalid data.

> interface, as then we would not need to stop I/O and the handshake
> process could run fully asynchronous to normal I/O...
>
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
> > @@ -1389,15 +1448,21 @@ static void nvme_tcp_io_work(struct work_struct=
 *w)
> >                       mutex_unlock(&queue->send_mutex);
> >                       if (result > 0)
> >                               pending =3D true;
> > -                     else if (unlikely(result < 0))
> > +                     else if (unlikely(result < 0)) {
> > +                             if (result =3D=3D -EKEYEXPIRED)
> > +                                     update_tls_keys(queue);
>
> How exactly can we get -EKEYEXPIRED when _sending_?

Good point. You can't with this current patch set. I have patches on
top of this that will generate a KeyUpate as part of the send
operation, which I plan to submit after this series.

So this is a bit of prep work to setup the NVMe layer to handle
sending and receiving KeyUpdate requests. I can drop this change from
the series if that's prefered?

> To my understanding that would have required userspace to intercept
> here trying (or even sending) a KeyUpdate message, right?

Not necessarily. The TLS layer can trigger a KeyUpdate independent of
userspace. This would happen for example if the sequence count was
about to overflow, which is what I use in my testing. Userspace has no
idea of the current sequence number, so it can't be involved. The
kernel will need to start the KeyUpdate send if the rec_seq is about
to overflow.

> So really not something we should see during normal operation.
> As mentioned in my previous mail we should rather code the
> KeyUpdate process itself here, too.
> Namely: Trigger the KeyUpdate via userspace (eg by writing into the
> tls_key attribute for the controller), and then have the kernel side
> to call out into tlshd to initiate the KeyUpdate 'handshake'.

Yeah, I agree about exposing a way for userspace to trigger an update.
That would only be for testing though, as in normal operation
userspace has no insight into the current connection state. In a
production system the kernel TLS layer will need to initiate a
KeyUpdate.

> That way we have identical flow of control for both the sending
> and receiving side.
>
> Incidentally: the RFC has some notion about 'request_update' setting
> in the KeyUpdate message. Is that something we have to care about at
> this level?

It is something we will need to care about. At this stage it isn't
supported as it adds a little bit of complexity, but I should be able
to extend the current approach to support a request_update.

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

