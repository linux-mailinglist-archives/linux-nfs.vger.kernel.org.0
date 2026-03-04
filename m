Return-Path: <linux-nfs+bounces-19726-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPjGC8kZqGmgnwAAu9opvQ
	(envelope-from <linux-nfs+bounces-19726-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 12:38:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66D1FF1D2
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99D3302B52B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72F36607C;
	Wed,  4 Mar 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVGaupro"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111423537FB
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624272; cv=pass; b=Te2R/AShFgtsen/Z5CPP8lpB4yvYj7o3+RrtSInm9l2JbwbGIASVbJNve+pXwYE39aq8PE2+vsGFy387zFvThXSkMxMPHOJp8tMRI2pxhtdgGuwZSDuIif+awpuSH1N7SytARqgLPh1vhO71lPEYC13Vzel763I8WL1A2O4+Y/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624272; c=relaxed/simple;
	bh=ZaTX/5xZCLp8jX/BNqqW109CaVTKhBe9/NvQKJFvKx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2IvrLA5k4ejQbGeGpwROd71pgibCUcVQ7iTid+XVtqab+Q1iDBl52CjLy5z7TFctBm5VFRUCHWJ8MFnWUcCyJfaVAW+ud2QaWNULXwbBIpmQAnLWOaCKDzQxQ5F0LG0ZWUhiC3HMSb9ZLr8bBVxVNl8of8VQrBXBV8pJl19fpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVGaupro; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-660d2e48383so1840118a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Mar 2026 03:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772624269; cv=none;
        d=google.com; s=arc-20240605;
        b=SeARERZDBA3LmgN0X5MUxpSxuKwYFizdEgelJagMw5WaXC+bVHfP1ceEg9CSkusjA7
         W0NJFJvJ14zcV4P4rGpN92JhRAXv8T+PaGu4H+FIiGwhpzrdTWAMw/7yOJRRNuWnNAip
         zBYtIm0MqQ2d/BygcrD3MYVhwUIpkuFprL0a9dbnzc9ONODSLw2Hbx6f12TdzjzJK/vz
         vdhKTGxf8hV+lAnMwAYOwsJEbpZpx9sfk0U+K939k8mxGjdDZKKL71/DTVBvYjNvf+8A
         jFoiPSovdY38lucq3QlXKgIIRT2JOJRJfm9gNp9oNOQ0U8SbwUyD8bAUX7Mj+Z34PX+t
         LhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=;
        fh=XbeZTmfnrzC3YGsWpbOyP5u5HVZyOrMP7zUbaUW9nX0=;
        b=T6YwAN9XVrNZO3cWPiD5CaW2bb8SwiVSSTkaXxpH7ozXl+HAN5tPF46dKJAitPs/xq
         aGPjwDHV2+oqaIEOTBXtToVUdH3lTwsE0VJk/1d04vovibOYiJLQQG0zOVZWZSoAB3CV
         /leGibCucBoS5yc5DgiimMjXbZYes2i0pymxSq40rxQovK/tTOCpNhWgXgAvqgTpxiP5
         zXsZPtcPQZLY7Rb9eV4KH49NaniFFNMFz7kTXRjVQ+1Y9rVyXjjIySyJeuwup/Imy5km
         QiaayRIN4VNFXmXIzACXtPrNeoP6xW0atPNAIK5Y6vtIa/rgFWRzTSJC8+nPNdmAmM0G
         hkUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624269; x=1773229069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=;
        b=OVGauproHypGOuNaPR4sbb7gMQz4b1SFekKespaRJM3CRKzZ5wDpjl9VcSmTNijB17
         HYzRwCwrxM02w6PpJY0avjq9T5RUK/SaITtesRZ/OXsXSWefzqGpKn5/rTOL/mNJtGtK
         w1rOaUqpTSF87SBq/f4VoI5dMBgulFqI/wOs8YIffJke3fXGHpJsA8vgidX02iEPVSfZ
         qSG6vuwGt7kkvEAD9cuEUUrakiyhqUC+hOj8cNCQ+OkcoxnlaSD/9Pzzv5P57v37I4P3
         mJ+56HSwbL0ECPFYU5L5uTZh7XogrIZZSRxziYmKAbC1IQsMkT5ZI2TMytFNiGavcNUo
         Cv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624269; x=1773229069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=;
        b=TeEUoPyCkedSMJ7pA8DmpXzVWOs2S3oJy3ynmJvM90kTXhrwU1HsnaxnXr1e5JqZTa
         ahFWlIO1iOgNYal9WIPeYlT1+9u4oknHTGQbJsJCf06fDRHjfMnk1NzdPsRRaL0U50/s
         7cG9FKpU85npjRYBbT2UjGrYLjlveAuZcHRrwg9AuBaRKM5ynd99LOYUoLI+T1rgXXlN
         wCu9djerO/ElCiBUqLH/drUkvF7Z1l+kLfUC4KM7FfaHhdxTgzrf9EgE8yA8QNDmv1zK
         r/5uV63EJdi+Ms4b3ArXVd0IgYIyUFHH3HdXl28TA48tyBQlC/CR65RJy0O9a7riBTVf
         fm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgAmPk1G/89vnpLiFSXNOD7L+0rkH2b/IxKQOjPTruB4fbFh4TPhJXqrhEOWtEctVaYN8D+ojCJY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOHsVPK9PWWpc8GXvPRszawTFCxQNEWaEOS90/+ftI4gxPbft
	UX75rGzht9sgaxz3sE7d8Np25g1d3OOaQwfBDHcP7/n6ecfyHPV+sUvTR/wjdqi+NBWHtZuX+cK
	qGZhvJQpWF0ejrgCl0st0Vl6ucTFKhmo=
X-Gm-Gg: ATEYQzyNRLl5QurZguNWOu09BY0818yFcrqnmJ+hVin32h60PDqoGWQD2AGGKDKCQec
	H7zRjP+p/e5xb68elVioJ7Hg5Jdy1kHygGyVgmbE+SCMYRJoiHzh4C6NMS6F/MC+TEHvHxhZNAY
	C/ZXyWrljD3Oo/ArlmI7ke7Trr/z8i7EHk4LEk6BayL8Sw0YT8nIqWpwIWmnGv/qm7G42qrwIde
	kYIr2Rye7KcAkilL0XTgd4Dc+dUORvJH9aYUf7a3LXghm5yoqeW4fAhs09uK6qkSeiLQUs2Uwew
	ZhVGi13Ao+SsfFCoDa0j3OkHh9Xzi0aVtdAl6w==
X-Received: by 2002:a05:6402:34c9:b0:65f:80cc:a47a with SMTP id
 4fb4d7f45d1cf-660ef7797f6mr858539a12.1.1772624269071; Wed, 04 Mar 2026
 03:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304053500.590630-1-alistair.francis@wdc.com>
 <20260304053500.590630-5-alistair.francis@wdc.com> <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
In-Reply-To: <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Mar 2026 21:37:22 +1000
X-Gm-Features: AaiRm53Rc8hKqaLsyJSSxrm4evktnm3D1AOZXCuqV_7q51qatQHTgMljJH9bALQ
Message-ID: <CAKmqyKPdJ2bgT2JaXi_38obyFTjRQ_rR5EdGmP81so8MEJNRVw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9D66D1FF1D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19726-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,wdc.com:email,ietf.org:url,suse.de:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 5:40=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 3/4/26 06:34, alistair23@gmail.com wrote:
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
> > v7:
> >   - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
> > v6:
> >   - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDAT=
E,
> >     instead look at the cmsg fields.
> >   - Don't flush async_event_work
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
> >   drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 8b6172dd1c0f..ade11d2ac9ef 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            handshake_session_id;
> >       __le32                  exp_ddgst;
> >       __le32                  recv_ddgst;
> >       struct completion       tls_complete;
> > @@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_que=
ue *queue)
> >       return ret;
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
> > +     ret =3D nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> > +                              queue, queue->ctrl->ctrl.tls_pskid,
> > +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> > +
> > +     if (ret < 0) {
> > +             dev_err(queue->ctrl->ctrl.device,
> > +                     "failed to update the keys %d\n", ret);
> > +             nvme_tcp_fail_request(queue->request);
> > +     }
> > +}
> > +
> > +static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
> > +                           struct sk_buff *skb,
> > +                           unsigned int offset, size_t len,
> > +                           u8 content_type)
> > +{
> > +     struct nvme_tcp_queue *queue =3D desc->arg.data;
> > +     struct socket *sock =3D queue->sock;
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     switch (content_type) {
> > +     case TLS_RECORD_TYPE_HANDSHAKE:
> > +             if (len =3D=3D 5) {
> > +                     u8 header[5];
> > +
> > +                     if (!skb_copy_bits(skb, offset, header,
> > +                                        sizeof(header))) {
> > +                             if (header[0] =3D=3D TLS_HANDSHAKE_KEYUPD=
ATE) {
> > +                                     dev_err(queue->ctrl->ctrl.device,=
 "KeyUpdate message\n");
> > +                                     release_sock(sk);
> > +                                     update_tls_keys(queue);
> > +                                     lock_sock(sk);
> > +                                     return 0;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             break;
> > +     default:
> > +             break;
> > +     }
>
> I think a simple 'if' condition would be sufficient here, or do you have
> handling of other TLS record types queued somewhere?
> And we should log unhandled TLS records.

I like this approach as it makes it really easy to handle more types
in the future. I don't have any more record types queued anywhere so I
can change it to an if statement.

Good point about logging unhandled records

Alistair

>
> > +
> > +     return -EAGAIN;
> > +}
> > +
> >   static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
> >   {
> >       struct socket *sock =3D queue->sock;
> > @@ -1372,7 +1426,8 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queu=
e *queue)
> >       rd_desc.count =3D 1;
> >       lock_sock(sk);
> >       queue->nr_cqe =3D 0;
> > -     consumed =3D sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb=
);
> > +     consumed =3D sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_rec=
v_skb,
> > +                                          nvme_tcp_recv_cmsg);
> >       release_sock(sk);
> >       return consumed =3D=3D -EAGAIN ? 0 : consumed;
> >   }
> > @@ -1708,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int sta=
tus, key_serial_t pskid,
> >                       ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >               key_put(tls_key);
> >               queue->tls_err =3D 0;
> > +             queue->handshake_session_id =3D handshake_session_id;
> >       }
> >
> >   out_complete:
> > @@ -1737,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *n=
ctrl,
> >               keyring =3D key_serial(nctrl->opts->keyring);
> >       args.ta_keyring =3D keyring;
> >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> > +     args.ta_handshake_session_id =3D queue->handshake_session_id;
> >       queue->tls_err =3D -EOPNOTSUPP;
> >       init_completion(&queue->tls_complete);
> >       if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
>
> Otherwise looks good.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

