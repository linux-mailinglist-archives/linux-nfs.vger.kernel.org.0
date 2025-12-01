Return-Path: <linux-nfs+bounces-16805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AED2C95B1A
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 05:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3523E3A1DBE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 04:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA211DF26E;
	Mon,  1 Dec 2025 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW7umWsD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464661DE2B4
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764562719; cv=none; b=NsbzurinSpHXNdJRnShcvtI1abGnOi+TZb1+6o5ssxIqzkTwrsH48bsNR1OnMAHF5Cy4B63ZLya13BVCGlbsEYIKYenhKSuc8/Q6mGTpKnQjlm7QLTSqxYzBrcJ9Q2Gtc2vptS514sm+PrfokoAgWBYn+0GQ2Tty3r7bOmtmzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764562719; c=relaxed/simple;
	bh=jkPMD6GHsCXWpn7rUP9jQrqa/c4UKeSxDfKF/9lJTB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkg2Pbz3/H/vVaVUq4OA/BrZxdEq0e8nk0CpP1VgFKVnxsr0UYtf8TT9MzaoEVDvIvQ1REtMiwKDRohBCFBJAvGmTLGMjEK/r+073bgzkNjGQxwUR89WLQbyiY8su8UPE4isUIMEuy5sP/8C+Ml28QPasVlx7Nht00U8DHWT4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW7umWsD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b770f4accc0so450745566b.1
        for <linux-nfs@vger.kernel.org>; Sun, 30 Nov 2025 20:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764562716; x=1765167516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMVbFQJwrtDT4Z0LvdOkvQwxkH7n3jhJLvQGPrvBilI=;
        b=HW7umWsDoQvFygQJn2ifKK+ER+KuG3/4+pLxghHhhVVEiUUpV3izkIMU4Ee4Dp3L7Y
         QBEQr3a7sFOfY28BeuI8lyj21SAXN3IM2q8KdAyO/xPViQ4I1A2md9KWXfccyXqOx03n
         Toz7D1e35ghYZZGpP4NP20E8pNZXDqoF3Y03LahoQQbzgrHXQeMQZUapV+p9fs3kboWo
         NyjB7IYjSl2/1ENe3LH05P02250DCkkFpEPEwRSwHoLdVO9kugrx8+ifPWi6Qrk48Vg8
         utZGTXzyFL+gpSpr9D4h/yt2UOMvKcnM0oTBwrkWv/EE62ioMe0cG1V779u7dz2YN/qC
         Gy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764562716; x=1765167516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMVbFQJwrtDT4Z0LvdOkvQwxkH7n3jhJLvQGPrvBilI=;
        b=byFZ+YyTALIDVFQDbRZdUTwTUF6iwYFxn8oTT8/S+FKgQy14LeWTFbI7CfDeG5qevK
         fTCb7Pyr4hHG5CZ7QiwWNHCRvlAoxbVhKJkZVewgK2kmtdxQrmtZUCDhObWtwTqqbVrJ
         GQJIhdWpIzRVZSIX9AQrqZpDKh8h7naUMXRsWzVszZliSduNVFWBofSENghedvKIiWUo
         XrZsljRKlb5fSWBkE7dqJqYFD2CBqRyar1fhYgj+BhqI/v7CfsMpQrbke0SExhGy7hCy
         62oSEZSNiLHPxuNWfdlGEJRPSsqGsl15sCPMQgWulZYm1U9cya1a2wvbgyNuIg6XZPw1
         S29Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZCb3mOYpuoCn3V6YrqPW3uSRCd4a5uLb4iZ02adhaHVydlWiISPU3d4Z2JMDfbcoxjUEm9ozxD54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8EBVihE5WfAH0GXlH5607KS4eMvZkb68+dISOcxU4HhuU4WY
	PyjPGGSe+fjoZ49vMlP75gjHhpQ1pjCvHbG0gPsBqSeZ5eG7zAWZzouW5v7NZ/UDI5e0Bjx9K8H
	bzrHprxNja9gbrOyDSf51uGYx7C55xV4=
X-Gm-Gg: ASbGnctM+2Tp8NJPUy2ABGK3H4txcnze6G3xWi1Hwy/SfU4xQz2D8e58Eywq73YWXMk
	UzKJqRPkkQKFZB4Rwv4NM6wn2ndYhBvr74iceC4aby+q0QIBmsc9RJmKwzQPFpDg2VdI1tqqdps
	n+vKSrzRVraji7YmS+obU2ajjlMPkndgnE/KjL3wb8qRwKsUsV/kfNFGy3zyhywfX3L8cczGk85
	JQZ3+YQTWn6V8pob07WqvX6RV4LBn2+6Ah6pfoof7e4H1hJp5TzuunNRUJAepXzMgP9dgp3Ai9f
	GbXh7A9DloF7JTIU4Um9OaO+5wa/84/33qse
X-Google-Smtp-Source: AGHT+IEeTiNhj2dkL9zHMBWy2MWadxfl3ORIHTFpBD3euUzlvLmeTWg5W0jv/zpi7B8w/lH1Tab+xDdjnzwufYN3YuM=
X-Received: by 2002:a17:907:3c96:b0:b73:9368:ad5e with SMTP id
 a640c23a62f3a-b76c5515082mr2667474566b.34.1764562715362; Sun, 30 Nov 2025
 20:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com> <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
In-Reply-To: <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Dec 2025 14:18:08 +1000
X-Gm-Features: AWmQ_bnRvWBaRf_AYOX9GVK2GmdKNpGnJ5WeFBVDhtY-flit1CL2pb-FbNx9lsA
Message-ID: <CAKmqyKPU2w2GrzdMtMn1rO8auOpDCTovQH04P8RxptA45Oy6XQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:31=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 11/12/25 05:27, alistair23@gmail.com wrote:
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
>
> Errm. 'hdr' is of type 'struct nvme_tcp_hdr', and that most certainly
> does not define TLS_HANDSHAKE_KEYUPDATE. I think you should evaluate the
> cmsg type here.
>
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
> This is not correct; reading the control message implies a kernel
> memory allocation as message buffer, not an interator (as it's the
> case here).

I don't follow what you mean

Alistair

