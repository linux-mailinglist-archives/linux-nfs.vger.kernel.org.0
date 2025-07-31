Return-Path: <linux-nfs+bounces-13331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E47B173FB
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000C1626A41
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B39BE6C;
	Thu, 31 Jul 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmh0XvdY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF319ABAC
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975823; cv=none; b=O/TK+9oTo94FpDJsyiFX2pfOrOM4K3e6Ex+7H7qN6R1Z62AfWLeQbRQtNyhgW2+hjYsH1D5IFaDxL0551QeZ2t8Az6mp+LeGXTnuhnfgAyMzPTQYtAJ4cKtp7Eirpgk+UiAsI/yJae8qpqs5QEU5qXkft9mwnOiiClZLfivh028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975823; c=relaxed/simple;
	bh=8jmN7HSIprpvchOA3h5PYxRrb3kV7jr1wO++TShAHRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ymm+S0wYACj04i2QvOTPyAJaKx4GPrikqKp3n5M9RehVhHOrDj0SSzdfIkDluEWaS7bRhEmWpzZ3PdDv/lVkpBeplz+hPZAx1mcPCCsx2JC8NZvJGQhADXiXqdwZYgYNva//HyJ2+NGWK5yElU/TvnuKvDkhL+UjrC6aPJ0FDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmh0XvdY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753975820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=;
	b=dmh0XvdYx+zdVoLaJvfbUJsFWD3x6c9yxKzDr1HT9X7FONAwf92+niTv5zwpnMFQAbte31
	JdyyMqdpDZS5HCkOfZN24hwJP/el4xk3F7t6YPDNZfHc1tsC5BtGO4z/gZHW4Dwcv6YJXV
	bDLe6GlDq+6nutghqYRbpk3OdInCv1s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-nST0b3hhN9-pDp_p70FOvQ-1; Thu, 31 Jul 2025 11:30:15 -0400
X-MC-Unique: nST0b3hhN9-pDp_p70FOvQ-1
X-Mimecast-MFC-AGG-ID: nST0b3hhN9-pDp_p70FOvQ_1753975814
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae9bf1c5947so263496766b.0
        for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 08:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975811; x=1754580611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=;
        b=Qq7HwgznUi5BpKScZmHhyJc25MIsgjoYyeHfeS6qDt1gjrtDhlv51cn1TvtM3h5+0Z
         miabq4H8BUrhfUGWG/fKsYY7alkfltdK1reEg52n5kDuFGSxHxG72lnXkQrHDXjUiHiK
         cPf9339Pk7oFzi27gRggtMTlhho76y2HyUB03MWwpbPGNL11bRuHBTqyjXze/lDPzR/Y
         PT0IuSDexWtL6LKwz/VBxvDgiNTudAahGU2K/zYMNneSGsRjwZpDawKLfah/84AF4J9W
         i1cfmPUIw8C7YK0yqci+eOrae4WIj0w7PDXg2w7Ja2ymsbbQtHwhWDaVIzCc160f+ShR
         CIGA==
X-Forwarded-Encrypted: i=1; AJvYcCWfSq34Bcmqgp/FKyXcI34c9WFQE3S2q3TgBUqCtFbAa9CTyC07/oaFEy74zyx9WRvAaxpkf7EfARw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aGS0mg/ozZjQ8R80r8JDILiPN18GW7bSZqavkAPznnaTxgrp
	P0Ls44bH8hcazNm4aYMraB14qVAIix1+uDyC60zPi/y/zzRQw9COGNqt+h7+d/CNODGWtCd/hpV
	lU7mcppT2q4u89YF8wUj5T/QCD/H4khZnTZ1i2+z7Hrkk/MPbYWI/bgmQiKA0t17w2ULVBm7/CW
	HBwCcpsDDAP2Hk9K7QIIMo0xLNcE8amt2u7fRP
X-Gm-Gg: ASbGncuqUx0LCCfuc/mQwdpJtGpZMdOy6qVJfuQMvvHg527vOvoCmbSVlDokBGmI0ZQ
	KvarpWo8ukjqFQCP1uD7VpdvcoCFnSav+q8T3/c8yZTxWrOSek9mu9EokQTovjPD4/Kh41Tbfvi
	GcFHL0GQcNIufDgynxcxbpf0tqw9d6iKQ7ayBh0eyM+wNbZqD4jmeClQ==
X-Received: by 2002:a17:906:fe02:b0:ae6:c334:af3a with SMTP id a640c23a62f3a-af91bbff55emr339555766b.6.1753975811044;
        Thu, 31 Jul 2025 08:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5c9yIisVqfaFsfCitspiLklBi+v8OwNwd+81HnIxrh0XVGF7Bd2GCjIVQsJ7OLqh9uU8xi9NdthF8zdbYdEE=
X-Received: by 2002:a17:906:fe02:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-af91bbff55emr339550366b.6.1753975810480; Thu, 31 Jul 2025
 08:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730200835.80605-1-okorniev@redhat.com> <20250730200835.80605-4-okorniev@redhat.com>
 <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
In-Reply-To: <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 31 Jul 2025 11:29:58 -0400
X-Gm-Features: Ac12FXyu4ke7AXpdJWvJjWBL1u_s87jJMDfrMGmbaMXP6xuZW7P6B3nrHVs7sWU
Message-ID: <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com, 
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org, kbusch@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:10=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 7/30/25 22:08, Olga Kornievskaia wrote:
> > Revert kvec msg iterator before trying to process a TLS alert
> > when possible.
> >
> > In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> > message buffer is set prior to sock_recvmsg(). Hannes suggested
> > that upon detecting that TLS control message is received log a
> > message and error out. Left comments in the code for the future
> > improvements.
> >
> > Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> > Suggested-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Hannes Reinecky <hare@susu.de>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >   drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
> >   1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 688033b88d38..055e420d3f2e 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tc=
p_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nv=
met_tcp_cmd *cmd)
> >   static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
> >   {
> >       struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
> > -     int len, ret;
> > +     int len;
> >
> >       while (msg_data_left(&cmd->recv_msg)) {
> > +             /* to detect that we received a TlS alert, we assumed tha=
t
> > +              * cmg->recv_msg's control buffer is not setup. kTLS will
> > +              * return an error when no control buffer is set and
> > +              * non-tls-data payload is received.
> > +              */
> >               len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
> >                       cmd->recv_msg.msg_flags);
> > +             if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
> > +                     if (len =3D=3D 0 || len =3D=3D -EIO) {
> > +                             pr_err("queue %d: unhandled control messa=
ge\n",
> > +                                    queue->idx);
> > +                             /* note that unconsumed TLS control messa=
ge such
> > +                              * as TLS alert is still on the socket.
> > +                              */
>
> Hmm. Will it get cleared when we close the socket?

If the socket is closed then any data on that socket would be freed.

> Or shouldn't we rather introduce proper cmsg handling?

That would be what I have originally proposed (I know that was on the
private list). But yes, we can setup a dedicated kvec to receive the
TLS control message once its been detected and then call
nvme_tcp_tls_record_ok().

Let me know if proper cmsg handling is what's desired for this patch.

> (If we do, we'll need it to do on the host side, too)

I can see that the host doesn't have any TLS alert handling now. If
the only place where (TLS) traffic is read from is in host/tcp.c
nvme_tcp_init_connection(), then that's seems like an easy case
because it uses a kvec to back the kernel_recvmsg() msg structure. If
the ctype is tls alert, you can call tls_alert_recv() and pass in the
"iov".  -- assuming patch#4 already went in by that time)

>
> > +                             return -EAGAIN;
> > +                     }
> > +             }
> >               if (len <=3D 0)
> >                       return len;
> > -             if (queue->tls_pskid) {
> > -                     ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> > -                                     &cmd->recv_msg, cmd->recv_cbuf);
> > -                     if (ret < 0)
> > -                             return ret;
> > -             }
> >
> >               cmd->pdu_recv +=3D len;
> >               cmd->rbytes_done +=3D len;
> > @@ -1267,6 +1277,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_=
tcp_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1453,10 +1464,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_=
queue *queue,
> >       if (!c->r2t_pdu)
> >               goto out_free_data;
> >
> > -     if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> > -             c->recv_msg.msg_control =3D c->recv_cbuf;
> > -             c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
> > -     }
>
> As you delete this you can also remove the definition of 'recv_msg'
> from nvmet_tcp_cmd structure.

You mean 'recv_cbuf', right? recv_msg would still be needed by the code.

I can send v2 with that change. Whether or not cmsg handling is needed
in v2 I'd need a confirmation on. Given I'm working on compile only
mode, I'd rather keep changes to minimal.

> >       c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
> >
> >       list_add_tail(&c->entry, &queue->free_list);
> > @@ -1736,6 +1743,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tc=
p_queue *queue)
> >               return len;
> >       }
> >
> > +     iov_iter_revert(&msg.msg_iter, len);
> >       ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >       if (ret < 0)
> >               return ret;
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


