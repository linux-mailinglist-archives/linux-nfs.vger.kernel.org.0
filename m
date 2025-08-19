Return-Path: <linux-nfs+bounces-13773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD64B2C83D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C26271A4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489EF207A18;
	Tue, 19 Aug 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="riqeuZnF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523CF22D9F1
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616509; cv=none; b=nm2b+eaasBCJWuFpwX45QgFf94bXln+TAnmgh5XACN4+moxIj4asH0AKc8GMcvvr251EsD1BtBoRTkYL6Rva99bfGYJaaz6ZU6MGX6i6I1sgA2ccVH4m3TOTkjq3gZHZeL/hOEL056jOtCTs6kJtyBZSOmg/4KApjHuUC50vgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616509; c=relaxed/simple;
	bh=KS4wyrWSI2v6OGsiL9rKTDi4Gvd9cIQdOdSYIFV9C6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tiyd3li2d1ny8eGC1m47S8frlb1CwD7nEhI+ZatIuffg8gOdwlg/FSCBnQE3Z8o0uTRm5KvbUtc6Y9DHtq8H9N//nidi3pDqvyO/ryTS9M/i1YcEA4m4Sk2KDMtCs46aDLiiUqQeQH+Yk7P0k60SWy+Txl9N10Je6Nh4neTW2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=riqeuZnF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f92cb94eso42192541fa.3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755616505; x=1756221305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhoIYmMlev8a0NMbshFVN/yqVYViaw5/3S3NKV+CCUY=;
        b=riqeuZnFsub+rFQZX+O4AGJbT2y3MlIg54PnhOyEGxjZWALJuIAUcj63i9ofUbAnuS
         zvaTha4KlODjs/UUoWt0g1AlbWC68Y9QLfSHPXp85AJ0YPMq6aKp7YMZCFAnGiuIzRh4
         NFe6COYh0kLtIb9wFxoh2S8ODMUF0sT5eksonOGdvtQulAz0uMMFNZo710p4XL4e0YIM
         9+wU3okLQVH0Q6CE1ZtaanF40YkFa4onpsdjrMYjkv7cvtMoLvR81NKNQKGq3g/65BCT
         68T/gHYI9OKUHG7K9djSiCWp/za2Q/Q/CKmUEA1GCtNtRMCgTF1C1GARiUvuAncljHiz
         f9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616505; x=1756221305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhoIYmMlev8a0NMbshFVN/yqVYViaw5/3S3NKV+CCUY=;
        b=d1hrXuZDC/xooMdYPY8jtcUzSzhgyyNZEcxuRRfniroSLV1Jt8Ycuxj7y6uBNgN2tq
         lE7rFR6MU7p191gY4bFsXbH+qpLcO6X8tXY2Rat2KB5YIBwphsEbBh0dVVht43ZPDSzA
         oqIR5R+OlBdCzgLAqo/cR+nzheVrBh7d3AvBjJzqeQFQ+YXQwgd3CG3QM9E2iv+33OdR
         rFdLye1He6H2xkzDfNdX7PcwevY5w1A38Vi3IZJM+sBmAAeCTGxG02ThY6iNUOr/lHdQ
         uE9j4HCJCJNZsAgdQV2yGVDPsjXTRe9zcvGYMGg2KbWrUeTMKdows+PhwIo0WHQr+zT7
         2BTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6n0CLb2O4cxMohaMlayuUOvDRjhUA0IGN3TM3YEq2b7CUt07WFmRaF99m3IefH4MbPx70IM5LEro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZW8A74AwO2dU5cUgApIp+MPgb3M001E7Vy8l3PQEUvK0PypFx
	YVmu1SUFBmMzm5igqsryGfU0wa7vDANVZikX+bFfX5G80XWFinE1IU4bFeeokZMRITuFckVu056
	U9Zgthoc7KVjzCJq1nO8zIX4LcuSiRDI=
X-Gm-Gg: ASbGnctrJI9oBSslcTG9+3TPewQYWfLurIRQsNfCDLP3yCZB8UB2Zhhc4HImH/azaQP
	uh9evrJuUReSUa+75DdAqySUjXUjAsXkDhGqPLIWBaEk/n731cctV1T2DHWpPkkU4EaMVW7RecP
	jZLiwcCyOxMQ5B0I2q5lh6cpjlcrFZN9IwbDGm87AHTe5Zxe+rhqEHWLgLADJcZ/NIkHIgZzdqq
	HkxcXGNoZud2Im0RDnikplIs5hwXvkJRoNf2+2g0AwPZA1Mql5M
X-Google-Smtp-Source: AGHT+IHcS6Zq1iVmwPzBoa0WjEnuGSbo+zgUbg4ho2o7hrSs5SvbYRq6zFGMQYEOKMNGowWDQ7frl4QfV3DutaEulcA=
X-Received: by 2002:a2e:bc24:0:b0:334:7f8:a63d with SMTP id
 38308e7fff4ca-33530725aeamr9735001fa.23.1755616505020; Tue, 19 Aug 2025
 08:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818182557.11259-1-okorniev@redhat.com> <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
 <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com> <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
In-Reply-To: <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 19 Aug 2025 11:14:53 -0400
X-Gm-Features: Ac12FXwpB0MvhTNvRuQQNMES5rzHe49or89BZQPRW6mX22Eit2UDhtfi-l4mNss
Message-ID: <CAN-5tyFhDq1Po4ekSYFVkhWTO42CAZJMYWf6GTGQVGo2ndUD4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a transport
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:36=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 8/18/25 3:04 PM, Olga Kornievskaia wrote:
> > On Mon, Aug 18, 2025 at 2:55=E2=80=AFPM Olga Kornievskaia <aglo@umich.e=
du> wrote:
> >>
> >> On Mon, Aug 18, 2025 at 2:48=E2=80=AFPM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>>
> >>> Hi Olga -
> >>>
> >>> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
> >>>> When a listener is added, a part of creation of transport also regis=
ters
> >>>> program/port with rpcbind. However, when the listener is removed,
> >>>> while transport goes away, rpcbind still has the entry for that
> >>>> port/type.
> >>>>
> >>>> When deleting the transport, unregister with rpcbind when appropriat=
e.
> >>>
> >>> The patch description needs to explain why this is needed. Did you
> >>> mention to me there was a crash or other malfunction?
> >>
> >> Malfunction is that nfsdctl removed a listener (nfsdctl listener
> >> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
> >> nfs).
> >>
> >>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> >>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>> ---
> >>>>  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
> >>>>  1 file changed, 17 insertions(+)
> >>>>
> >>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> >>>> index 8b1837228799..223737fac95d 100644
> >>>> --- a/net/sunrpc/svc_xprt.c
> >>>> +++ b/net/sunrpc/svc_xprt.c
> >>>> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *=
xprt)
> >>>>       struct svc_serv *serv =3D xprt->xpt_server;
> >>>>       struct svc_deferred_req *dr;
> >>>>
> >>>> +     /* unregister with rpcbind for when transport type is TCP or U=
DP.
> >>>> +      * Only TCP and RDMA sockets are marked as LISTENER sockets, s=
o
> >>>> +      * check for UDP separately.
> >>>> +      */
> >>>> +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
> >>>> +         xprt->xpt_class->xcl_ident !=3D XPRT_TRANSPORT_RDMA) ||
> >>>> +         xprt->xpt_class->xcl_ident =3D=3D XPRT_TRANSPORT_UDP) {
> >>>
> >>> Now I thought that UDP also had a rpcbind registration ... ?
> >>
> >> Correct.
> >>
> >>> So I don't
> >>> quite understand why gating the unregistration is necessary.
> >>
> >> We are sending unregister for when the transport xprt is of type
> >> LISTENER (which covers TCP but not UDP) so to also send unregister for
> >> UDP we need to check for it separately. RDMA listener transport is
> >> also marked as listener but we do not want to trigger unregister here
> >> because rpcbind knows nothing about rdma type.
>
> rpcbind is supposed to know about the "rdma" and "rdma6" netids. The
> convention though is not to register them. Registering those transports
> should work just fine.

Question is: should nfsd have been registering rdma with rpcbind as well?

__svc_rpcb_register4() takes in: program (i'm assuming nfs, acl, etc),
version, protocol, and port.  Protocol is supposed to be a number
(below). I don't see how "rdma" can be specified as a protocol/type.
        switch (protocol) {
        case IPPROTO_UDP:
                netid =3D RPCBIND_NETID_UDP;
                break;
        case IPPROTO_TCP:
                netid =3D RPCBIND_NETID_TCP;
                break;
        default:
                return -ENOPROTOOPT;

We can register nfs, tcp, port 20049 but nothing that would indicate
that it's rdma. I have grepped thru the rpcbind source code and didn't
find occurrences of rdma.


> >> Transports are not necessarily of listener type and thus we don't want
> >> to trigger rpcbind unregister for that.
>
> Ah. Maybe svc_delete_xprt() is not the right place for unregistration.
>
> The "listener" check here doesn't seem like the correct approach, but
> I don't know enough about how UDP set-up works to understand how that
> transport is registered.
>
> A xpo_register and a xpo_unregister method can be added to the
> svc_xprt_ops structure to partially handle the differences. The question
> is where should those methods be called?
>
>
> > I still feel that unregistering "all" with rpcbind in nfsctl after we
> > call svc_xprt_destroy_all() seems cleaner (single call vs a call per
> > registered transport). But this approach would go for when listeners
> > are allowed to be deleted while the server is running. Perhaps both
> > patches can be considered for inclusion.
>
> You and Jeff both seem to want to punt on this, but...
>
> People will see that a transport can be removed, but having to shut down
> the whole NFS service to do that seems... unexpected and rather useless.
> At the very least, it would indicate to me as a sysadmin that the
> "remove transport" feature is not finished, and is thus unusable in its
> current form.
>
> An alternative is to simply disable the "remove transport" API until it
> can be implemented correctly.
>
>
> >>>> +             struct svc_sock *svsk =3D container_of(xprt, struct sv=
c_sock,
> >>>> +                                                  sk_xprt);
> >>>> +             struct socket *sock =3D svsk->sk_sock;
> >>>> +
> >>>> +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_fam=
ily,
> >>>> +                              sock->sk->sk_protocol, 0) < 0)
> >>>> +                     pr_warn("failed to unregister %s with rpcbind\=
n",
> >>>> +                             xprt->xpt_class->xcl_name);
> >>>> +     }
> >>>> +
> >>>>       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
> >>>>               return;
> >>>>
> >>>
> >>>
> >>> --
> >>> Chuck Lever
> >>>
> >>
> >
>
>
> --
> Chuck Lever

