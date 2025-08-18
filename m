Return-Path: <linux-nfs+bounces-13745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836EB2B129
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 21:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E0D189017E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12C272E53;
	Mon, 18 Aug 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpubwqWt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596D3451A6
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543860; cv=none; b=i7lQhBUnZ4QxAsjWWjopvYtSLD0POT/p132LoVC/CbVjtLqBk4ZlNKvBEqE1Eem+yitUFBwKYuM1PSrXPeIct0XVsEZ+bPIX0xcaFUV9+kcv/rldaOomRUT7andP4eBpJjdGT4RXPi+XxKQl75K0uJMaxIQdzppBQpPyuek+C/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543860; c=relaxed/simple;
	bh=b+YHco7nPM5jl0qSSDPUPtgutA/XPSC/KIRaDCYXLA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKMsi9EyrQuj0FbjFn4p1saLjaXuHQ5eVlrXwtK0Y3r1dGKL7vcU9Ckg5AA3Xj9X59MuIZs6JSGN+Q5WNsQMYcensnp+pLqbNbbLIqVUiT0N8oRWHuMI+ftTJfXv16pEpU7AloK6Ur3HvfrHGT8twg1RvdjMv6zoSI5X9VTvPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpubwqWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755543858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9u3kvjuCNEbd9r3n57Y1Qg+DL3l1APwB8aZ/Q/x4Hk=;
	b=FpubwqWtTUOOGfqUh3fPa+bYZJ49SIlHGgPwQn2q83rjE3vnIW0ts/4HQtsRPNq5KLlbfP
	6me867y+zF+uW4NkYAgHyADYud95Xsi6yHDNsv9DK/VaeV+HbO5UyG/daPshP70Wi+ZTSz
	gmJtgDcJu6Uyg8Az2f8c+ALo1ekrWe8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-6zWQqnDCOU6qH2blxI8Mww-1; Mon, 18 Aug 2025 15:04:16 -0400
X-MC-Unique: 6zWQqnDCOU6qH2blxI8Mww-1
X-Mimecast-MFC-AGG-ID: 6zWQqnDCOU6qH2blxI8Mww_1755543855
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afcb7af3e41so295151166b.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 12:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543855; x=1756148655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9u3kvjuCNEbd9r3n57Y1Qg+DL3l1APwB8aZ/Q/x4Hk=;
        b=OQxAB30wgC9bkcgDw2uWsmGZm64QelunfkJNe7LX77u7p6W3qAKcfmqZ+i9q8Qjjtw
         r8pbkrWuiT4eAp45Dk5YTqOi2OAz5toG7juUCGF5LOHzJVHsmpvdCEERp7VWQAj8fvie
         aXIDtA9hXx8B7O5/AuhyTfTfI54JqiqjRRvZdbbvMkxD/dctbds3aQy3x+rQVapKr2bz
         /vaUfl6RZurQlxW13V+225sD0YIEx8/+mPjo5KqOtpZiWvHmm37L2fE4RGqi4bnbAWlO
         vMvljmZosvemhs+KFUMy3K54TRRpVFpjpFGIgQE3Bf/7wKy9VjS97EFZA0MVvx7QZpxM
         WJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmV0kTNZantbJ6WTgU+ErI1M74ogWSnSuwWD0gEatoiqpwSSHMlkTaelFg1qpzYG2KL6K/yAwOvC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+/RqL/5mtSr84uGjF+PuBcYJluqF+2ndBWwron0ZtQ/7z6wa
	6RTeeZH2qGn5I61uNYdFOK8i6ln6M0v862SypfZ6IURvSjs7hdvAwr+LwxI2nNvb2qnZMtYyzn5
	JPeSzPWAl7/49PgZcgpk62tOf5GI3IVQC+PG2Kpzlxj7qARyjrBNRSXgnaakXHFFKJ8FhcDwjms
	XwJjR+YNW9EbyBwVbX4xohK0ZSBkp5CjUIQ7rY
X-Gm-Gg: ASbGnctVXI7wTyb6xztnrd99Rga4CTo/56AFXDSGYIKOP23BbRDySi0m9qYg+RUiudV
	X+OOVv4s1XGcqA0dsQIF8oiGvzkbpL6bANC2gT4TtL1WVsFqa2C/eovaBX+jdsqWJp2pGcTMqTz
	H14X2k10TSINCDXFoBeJUfXLLvg2AwjcjYikfB0pPVVjC7mwndZoJ2
X-Received: by 2002:a17:907:847:b0:ae3:53b3:b67d with SMTP id a640c23a62f3a-afceacad5a1mr988424866b.1.1755543855344;
        Mon, 18 Aug 2025 12:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZaoeopW/vXFhe59Aa1tpe1Uxsj3Zoji3RQs1HnteXilncs7X2Z9yEHqxP0iA+KpB6PVfLGYSZ3mKWAXrDeLU=
X-Received: by 2002:a17:907:847:b0:ae3:53b3:b67d with SMTP id
 a640c23a62f3a-afceacad5a1mr988422466b.1.1755543854890; Mon, 18 Aug 2025
 12:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818182557.11259-1-okorniev@redhat.com> <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
In-Reply-To: <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 18 Aug 2025 15:04:03 -0400
X-Gm-Features: Ac12FXxRY5k_sTacy00DOrGE6srxk-PpdjfA5c3BIwhSQ6ZjCsLNVon0-Yf4qr4
Message-ID: <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a transport
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 2:55=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Mon, Aug 18, 2025 at 2:48=E2=80=AFPM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
> >
> > Hi Olga -
> >
> > On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
> > > When a listener is added, a part of creation of transport also regist=
ers
> > > program/port with rpcbind. However, when the listener is removed,
> > > while transport goes away, rpcbind still has the entry for that
> > > port/type.
> > >
> > > When deleting the transport, unregister with rpcbind when appropriate=
.
> >
> > The patch description needs to explain why this is needed. Did you
> > mention to me there was a crash or other malfunction?
>
> Malfunction is that nfsdctl removed a listener (nfsdctl listener
> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
> nfs).
>
> > > Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > index 8b1837228799..223737fac95d 100644
> > > --- a/net/sunrpc/svc_xprt.c
> > > +++ b/net/sunrpc/svc_xprt.c
> > > @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *x=
prt)
> > >       struct svc_serv *serv =3D xprt->xpt_server;
> > >       struct svc_deferred_req *dr;
> > >
> > > +     /* unregister with rpcbind for when transport type is TCP or UD=
P.
> > > +      * Only TCP and RDMA sockets are marked as LISTENER sockets, so
> > > +      * check for UDP separately.
> > > +      */
> > > +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
> > > +         xprt->xpt_class->xcl_ident !=3D XPRT_TRANSPORT_RDMA) ||
> > > +         xprt->xpt_class->xcl_ident =3D=3D XPRT_TRANSPORT_UDP) {
> >
> > Now I thought that UDP also had a rpcbind registration ... ?
>
> Correct.
>
> > So I don't
> > quite understand why gating the unregistration is necessary.
>
> We are sending unregister for when the transport xprt is of type
> LISTENER (which covers TCP but not UDP) so to also send unregister for
> UDP we need to check for it separately. RDMA listener transport is
> also marked as listener but we do not want to trigger unregister here
> because rpcbind knows nothing about rdma type.
>
> Transports are not necessarily of listener type and thus we don't want
> to trigger rpcbind unregister for that.

I still feel that unregistering "all" with rpcbind in nfsctl after we
call svc_xprt_destroy_all() seems cleaner (single call vs a call per
registered transport). But this approach would go for when listeners
are allowed to be deleted while the server is running. Perhaps both
patches can be considered for inclusion.

>
> > > +             struct svc_sock *svsk =3D container_of(xprt, struct svc=
_sock,
> > > +                                                  sk_xprt);
> > > +             struct socket *sock =3D svsk->sk_sock;
> > > +
> > > +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_fami=
ly,
> > > +                              sock->sk->sk_protocol, 0) < 0)
> > > +                     pr_warn("failed to unregister %s with rpcbind\n=
",
> > > +                             xprt->xpt_class->xcl_name);
> > > +     }
> > > +
> > >       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
> > >               return;
> > >
> >
> >
> > --
> > Chuck Lever
> >
>


