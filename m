Return-Path: <linux-nfs+bounces-13324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117C8B16852
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 23:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC117B2556
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FC1EF09B;
	Wed, 30 Jul 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbXr/TgY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF077221D94
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753911423; cv=none; b=dfaIksLvWkChSfZ+iRNUnd3UuEv/f6DROW7UahytaOrCzLAASSuzjHDSThiCrmi/9my8ZwDm5+0QssrDK1m3LNmNIMLvMLFLdHnPQcK/wCzWLiSfdtx2joIiq1WKv7Oye9uV6qC2BzsoI9GRDgubcUa2BVkhVU2Qcm9aivIP9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753911423; c=relaxed/simple;
	bh=zp9B5nGHIG+i+kh7j9Ga7LG98BNxe4q96gRJnuj4yvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CE/GiHOjlDSYfQ/17+uLBqy7BXzmfpTeVJe4lT9K9RZaQA9bviCZqC3KRWNx///qj2gi9NmDwAHw2P+5GO08ShnTBdFvpu4+cADd9GLuVH9MidnDciC93qe2rFD8CFoRFmNsW2QQirBhyxBTA2bqThObjZ8uXL/ukpv7WkUaf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbXr/TgY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753911419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUVJK/b8xtvanBoj9VS0jS/GGMLzTsUc4wyzInBkEHc=;
	b=HbXr/TgYTf189DYrEqvDhFFHfUiIWpxXsVVUX4bEEJmu+iHzhOTvMXpuArJPJz4bypVAv9
	nli9HnkAAsQk5g9qjDSG08FWub997dnDh9ocx37x0IkLrS3ftUrvaMIPOr+PvGIKrecSH7
	Ji4dzZwrRud/7aDJ2HpjgfX9D47ZVZs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-TOo20TOYNGykou_e5X7_XA-1; Wed, 30 Jul 2025 17:36:57 -0400
X-MC-Unique: TOo20TOYNGykou_e5X7_XA-1
X-Mimecast-MFC-AGG-ID: TOo20TOYNGykou_e5X7_XA_1753911416
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-af8f6fe8336so152131666b.1
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 14:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753911416; x=1754516216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUVJK/b8xtvanBoj9VS0jS/GGMLzTsUc4wyzInBkEHc=;
        b=rw9tyWwUO+2vzDU4NYpbdTSaYiKX7ho/5hjpl04rNQF7WhulWsGdFz6kv/5xjQpifO
         1vsPi+EigDJ7G7SJOJf9qqElseULpqdHH/lO/iDV/hsnL81jKfIBx/BNb1MTHzoYQWnr
         1QEa5kgo/BfhHaaZKCtNFSg64oty1kjzj75SKyTBluJH9PoN3ieWoqIu3NDMfkWlPov3
         GEQN/koEkdn06xJbeoTaOz4ZA/4bj6RSAv5AOgQm9zvSC2Zce3+/PwYtqKI/Liage5aQ
         5mVZ5CNoSOBelfB/j5xqLMVtrSdaJkEZ4dPqJipwRGrwLsOtWGdmfjbI4tYlKtfj5+cU
         AoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxMJHJihNDtYtAvnzNrtm6ashBBVL42wa8+X/u5WDDiHD1EVL8BjvCxBBm/CyRBSANx+rOeK3JsfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEp9l0P2bAxFRwrpZPwuE8ArL0u9uzGnY67YLtT9GlJ8pnFu+O
	ZfgobctZ8spwXaHzxK/pQC9LhoE3BmL1BklOCraTLXu9Pvdc3R3Fdxp+J+3B+HpiTu3Rl3MwYXs
	Wn7uHZr8X/kYdfmh7EgibIWs/yVlzF1IIobE2EA6yCZincMfcRHiig3Z+svD41pOsJVF8CgEvMh
	60neX/imgljHnop20QBsaZqsPETwSjz7KjCS5J
X-Gm-Gg: ASbGncubzy7FDkD4jv85FHZOPa+DodnD8UKVIczmCQz7F6fiNegA+vvQ146d4ky4m2W
	OFZh4EfZwf8zpkY98hy/Gziv77kj7pgQFz+AFDELDwoLEtMk3d4rNK1BZVQapnKNNAqcgdlV3I4
	xpO+7QjQLf/03GL0eRrZLQe62n3dSn6jiKvsCcrFTyW900OlpKPXRkX/E=
X-Received: by 2002:a17:907:1b08:b0:ae0:c092:ee12 with SMTP id a640c23a62f3a-af8fd335d47mr514424266b.22.1753911416219;
        Wed, 30 Jul 2025 14:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU+UNzcVLnhtqdg3k8t4IZaqUNYX6eJdTyw40q+0juwL6H+y4IHc+PTci+/T9eOlrpvi9mA3LhywAXgNGp8fI=
X-Received: by 2002:a17:907:1b08:b0:ae0:c092:ee12 with SMTP id
 a640c23a62f3a-af8fd335d47mr514411766b.22.1753911413545; Wed, 30 Jul 2025
 14:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730200835.80605-1-okorniev@redhat.com> <20250730200835.80605-2-okorniev@redhat.com>
 <8753ffaf-0146-45c6-9189-bd8ea3e74e71@oracle.com>
In-Reply-To: <8753ffaf-0146-45c6-9189-bd8ea3e74e71@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Wed, 30 Jul 2025 17:36:42 -0400
X-Gm-Features: Ac12FXzVg6SWdNfy3Rt77NF_wjgPRdWJbcLlHUN8fnoRnafWxUNAbvZ2xJMzMYU
Message-ID: <CACSpFtB2guwTKbt_kC57BKU2DKWu58Dxhn0Y-eVzXWmCnMUWkw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sunrpc: fix handling of server side tls alerts
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com, 
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de, horms@kernel.org, 
	kbusch@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:59=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 7/30/25 4:08 PM, Olga Kornievskaia wrote:
> > Scott Mayhew discovered a security exploit in NFS over TLS in
> > tls_alert_recv() due to its assumption it can read data from
> > the msg iterator's kvec..
> >
> > kTLS implementation splits TLS non-data record payload between
> > the control message buffer (which includes the type such as TLS
> > aler or TLS cipher change) and the rest of the payload (say TLS
> > alert's level/description) which goes into the msg payload buffer.
> >
> > This patch proposes to rework how control messages are setup and
> > used by sock_recvmsg().
> >
> > If no control message structure is setup, kTLS layer will read and
> > process TLS data record types. As soon as it encounters a TLS control
> > message, it would return an error. At that point, NFS can setup a
> > kvec backed msg buffer and read in the control message such as a
> > TLS alert. Scott found that msg iterator can advance the kvec
> > pointer as a part of the copy process thus we need to revert the
> > iterator before calling into the tls_alert_recv.
> >
> > Reported-by: Scott Mayhew <smayhew@redhat.com>
> > Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side=
 TCP socket code")
> > Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> > Suggested-by: Scott Mayhew <smayhew@redhat.com>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 46c156b121db..e2c5e0e626f9 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, st=
ruct msghdr *msg,
> >  }
> >
> >  static int
> > -svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
> > +svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
> >  {
> >       union {
> >               struct cmsghdr  cmsg;
> >               u8              buf[CMSG_SPACE(sizeof(u8))];
> >       } u;
> > -     struct socket *sock =3D svsk->sk_sock;
> > +     u8 alert[2];
> > +     struct kvec alert_kvec =3D {
> > +             .iov_base =3D alert,
> > +             .iov_len =3D sizeof(alert),
> > +     };
> > +     struct msghdr msg =3D {
> > +             .msg_flags =3D *msg_flags,
> > +             .msg_control =3D &u,
> > +             .msg_controllen =3D sizeof(u),
> > +     };
> > +     int ret;
> > +
> > +     iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> > +                   alert_kvec.iov_len);
> > +     ret =3D sock_recvmsg(sock, &msg, MSG_DONTWAIT);
> > +     if (ret > 0 &&
> > +         tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_RECORD_TYPE=
_ALERT) {
> > +             iov_iter_revert(&msg.msg_iter, ret);
> > +             ret =3D svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -E=
AGAIN);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int
> > +svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
> > +{
> >       int ret;
> > +     struct socket *sock =3D svsk->sk_sock;
> >
> > -     msg->msg_control =3D &u;
> > -     msg->msg_controllen =3D sizeof(u);
> >       ret =3D sock_recvmsg(sock, msg, MSG_DONTWAIT);
> > -     if (unlikely(msg->msg_controllen !=3D sizeof(u)))
> > -             ret =3D svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret=
);
> > +     if (msg->msg_flags & MSG_CTRUNC) {
> > +             msg->msg_flags &=3D ~(MSG_CTRUNC | MSG_EOR);
> > +             if (ret =3D=3D 0 || ret =3D=3D -EIO)
> > +                     ret =3D svc_tcp_sock_recv_cmsg(sock, &msg->msg_fl=
ags);
> > +     }
> >       return ret;
> >  }
> >
> > @@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rq=
stp, size_t buflen,
> >               iov_iter_advance(&msg.msg_iter, seek);
> >               buflen -=3D seek;
> >       }
> > -     len =3D svc_tcp_sock_recv_cmsg(svsk, &msg);
> > +     len =3D svc_tcp_sock_recvmsg(svsk, &msg);
> >       if (len > 0)
> >               svc_flush_bvec(bvec, len, seek);
> >
> > @@ -1018,7 +1045,7 @@ static ssize_t svc_tcp_read_marker(struct svc_soc=
k *svsk,
> >               iov.iov_base =3D ((char *)&svsk->sk_marker) + svsk->sk_tc=
plen;
> >               iov.iov_len  =3D want;
> >               iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
> > -             len =3D svc_tcp_sock_recv_cmsg(svsk, &msg);
> > +             len =3D svc_tcp_sock_recvmsg(svsk, &msg);
> >               if (len < 0)
> >                       return len;
> >               svsk->sk_tcplen +=3D len;
>
> Fwiw, I've already pulled 1/4 into nfsd-testing. But 4/4 might not apply
> until the others are in the tree. We might want these to go through a
> single tree.
>
> Or, can we delay 4/4 until 6.18 ?

Delaying 4/4 until 6.18 sounds fine to me.

>
>
> --
> Chuck Lever
>


