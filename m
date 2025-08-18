Return-Path: <linux-nfs+bounces-13744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F4B2B0E6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9721117DDC8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3D27056D;
	Mon, 18 Aug 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="LE8QnPSr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B67147C9B
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543321; cv=none; b=NjDGRHalIy4epaMufIrdLvsXdXXgFR/3tSEYRdGbGqfabu1IOBSmPVcCCmRpOgtqmg3KmF5rgML0o4FrM0RQjJzeuCOkmxO5Qs3QmYUNYThcURmxje2A0qD2E9FMS4jEVyHwP5G64wPb5w3n482IFR04QZM9fxRwpO645fJPEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543321; c=relaxed/simple;
	bh=ADWmB+7KQG6ynDxwPvg3DG5GrNFDhXGk//SZIzwLDYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4fUHqKhkaPyvT+o/9A66hmZwHWpSKeILsIIvjuDs1Se+s6SacQVOP5LKRnYtTkTb6uCwPekqoqc7KRuV0OQmBbmqgvWnBbvTvcEeyApA/Uq/vIYC5v63hQCQaw7WB6lKlAOyEElw5u11Cy2sVlUceAsr2q5yU7mCqgbZnLC8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=LE8QnPSr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f92cb94eso35088481fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755543317; x=1756148117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYtVK2mGt2g03B9C6e/CU6n4rSaLuI0tnaYgjxqSKjs=;
        b=LE8QnPSrz0Ypd6lItgmWYzGTSOzZvHlJ1bGdwsIZt4sQskP1nP1E4J3Lst7LHgm1z5
         8UjYYyIhpp65sVptfBYnP43/SOKQGCdq62735WWmaEV3xr4ghgoRQlW58idcbyxfKgEU
         0B5pSjAzT9SiCFVJ9qin3iyfUZe1x0DlzSltax3VxkhGMPQ3ihOFMtL4RfJOIGQqGvCG
         C2sB+6P+j5Tdp5+LZx/p4b/QOIVy0hs1zsvKPI5hdtWdl7Inie8iNVOYlE72ZsfE1Q88
         RQ+vm8exiFZRfSkyn8+0YB8PHsGmmMXeRj+tqriPILo07Plzc0ZksOFT8OIGYSQaJEki
         l1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543317; x=1756148117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYtVK2mGt2g03B9C6e/CU6n4rSaLuI0tnaYgjxqSKjs=;
        b=pPYuR3BLulzGZBLad12MGdeHfsLW8oH1PFZ6ZYz5zxfCfH/6oBcwA6qVwAQLrb65uy
         Nb9zJ+HxgFR4vK1MbR7yAyCdVlVLdvBd1qxWum4HlSM/pP6Oafw63dd41J7Vhw7xSeaT
         kqwAeLsc5LkdMtioBz9Rp0lDrGUipo5ThTAE6A+IfLPSjY7CyOooxtgGF5Oigtq3w89P
         X7RAvvEFpMoSm38LfanLmEJzHyQMhsPANN4Czn140GL4C/kdhGhxfe3LzLRnMOYVrYdi
         WpPi5CtIwepxPwuIKtwkB0GN7lgWiaWL2ROjYf4aBZ5lnd0sWW7EgKxRmVbVZM51xRPR
         9mag==
X-Forwarded-Encrypted: i=1; AJvYcCV2bM0cI556PggxJvNwJVGFAZexuFlm6iSITnOtop1Eou0YzA1o0J5O4l4Y0X2v5I51mXlQSAzvjgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vsXXEC+Wa+BM1ErTwoP1+NWDgXDJWCYMDMiHUK0eAD5PEdnx
	DH+aUONtw4R1mjK/4Ugp/CjTcLzzfOgw06S4JKi5yIDG3btm3fQwda5b0zVfFj0OlC5UDA/XCRH
	vT4/O3IB4l9g8Kk4gkKB9degVIq6dWAg=
X-Gm-Gg: ASbGncsWy6UxpqhC/d90vRlAnaFBHnb6kWJj7xFm/r3q2ukHwJ3yD7AWHL/ciiLnzW1
	wN0AdE+1bkaT6oN5LRK3xH0Erh12J547uhuf/HgILciJ3VASJBdngFetuyz9DvVbhdo1pxj2VFn
	QEl5RBlTiJUxF6q1CxGzdngYL+A59YSTtdqCJeoyNbrlrcYpNXLOlJTEUiGxpeOs+0hi9HyfTP5
	5Ohn5pr8U+5DrHYQPcuec5FXQwHH6QBqqXM9o4=
X-Google-Smtp-Source: AGHT+IFkS96Gg/mKy+wSLLC3u1mXWCPZg3jHA6C6EVwwa7PebMraKmYmEkzip5lzDNQFTT0gO95TOsvL6ADWtByh86M=
X-Received: by 2002:a05:651c:2222:b0:333:f086:3092 with SMTP id
 38308e7fff4ca-33412bd417dmr28775161fa.11.1755543317253; Mon, 18 Aug 2025
 11:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818182557.11259-1-okorniev@redhat.com> <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
In-Reply-To: <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 18 Aug 2025 14:55:04 -0400
X-Gm-Features: Ac12FXw6g9tNGwXRfcvOGema7qG4OrvYL2CoK6rWwywNJYIDn_dzETVwJswZvW8
Message-ID: <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a transport
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 2:48=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> Hi Olga -
>
> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
> > When a listener is added, a part of creation of transport also register=
s
> > program/port with rpcbind. However, when the listener is removed,
> > while transport goes away, rpcbind still has the entry for that
> > port/type.
> >
> > When deleting the transport, unregister with rpcbind when appropriate.
>
> The patch description needs to explain why this is needed. Did you
> mention to me there was a crash or other malfunction?

Malfunction is that nfsdctl removed a listener (nfsdctl listener
-udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
nfs).

> > Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 8b1837228799..223737fac95d 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xpr=
t)
> >       struct svc_serv *serv =3D xprt->xpt_server;
> >       struct svc_deferred_req *dr;
> >
> > +     /* unregister with rpcbind for when transport type is TCP or UDP.
> > +      * Only TCP and RDMA sockets are marked as LISTENER sockets, so
> > +      * check for UDP separately.
> > +      */
> > +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
> > +         xprt->xpt_class->xcl_ident !=3D XPRT_TRANSPORT_RDMA) ||
> > +         xprt->xpt_class->xcl_ident =3D=3D XPRT_TRANSPORT_UDP) {
>
> Now I thought that UDP also had a rpcbind registration ... ?

Correct.

> So I don't
> quite understand why gating the unregistration is necessary.

We are sending unregister for when the transport xprt is of type
LISTENER (which covers TCP but not UDP) so to also send unregister for
UDP we need to check for it separately. RDMA listener transport is
also marked as listener but we do not want to trigger unregister here
because rpcbind knows nothing about rdma type.

Transports are not necessarily of listener type and thus we don't want
to trigger rpcbind unregister for that.

> > +             struct svc_sock *svsk =3D container_of(xprt, struct svc_s=
ock,
> > +                                                  sk_xprt);
> > +             struct socket *sock =3D svsk->sk_sock;
> > +
> > +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family=
,
> > +                              sock->sk->sk_protocol, 0) < 0)
> > +                     pr_warn("failed to unregister %s with rpcbind\n",
> > +                             xprt->xpt_class->xcl_name);
> > +     }
> > +
> >       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
> >               return;
> >
>
>
> --
> Chuck Lever
>

