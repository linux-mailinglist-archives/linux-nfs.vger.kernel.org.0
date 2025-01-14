Return-Path: <linux-nfs+bounces-9198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDFEA10A5B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FB7A02C7
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848E156257;
	Tue, 14 Jan 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="BZTaF8sC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93298156644
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867376; cv=none; b=kxFwsahZ2ssdEH+g+QQYRAGlr1Y/95BAl3ZfpgVIw+l0lK1BLaZZ3YeK7hyKOGbibAhvaXaiMZ3uozohjE5GDVFXgf+HdE9zJNc23EkQvHjGKrxZPKXifAaVWD1YJ6ezAn6Vrs/CoWi3UepltyU2lFjPZdJlOxVjg7HqtslgWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867376; c=relaxed/simple;
	bh=rc02AALFEspTuThZmTGtedZ4D2/bmQW6+eG3p6PncTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLhegyzF/MIVXi0B7DQdhmXjlfwQrLaZmlS1rs8Q9PwR206n2SmRVVrT/PdOcrsr7vn08uk/imQwg17tZC6U8HX7C9y6m4qU0raqmd7FD5UrsijjnyR2CZFPX5aD0kmnHrpyVD/UgP5YEoJ+ldZ1gcwHSUd2V6EXKtw6EZ246Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=BZTaF8sC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003c82c95cso41176401fa.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 07:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1736867373; x=1737472173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpI3yKKAzjs+5quxef+oLP6vXtkIHrfYkvco4de/Nms=;
        b=BZTaF8sCMp6DdIvwMXdf+L8bv1Ko7qd2ZllXXZS6Vv9JvQUejWcApbJeAv1votuFAj
         kuLjUDd0PUg3Yz7fcU5QySvYBbbDbuuBehG7L8+xcLiQLTfV80rFOqZ9i8W7el7U3SqB
         4ZawrwTi1jEZkFlHL+vnNDhtJHXpIxfZelSFJ/K3lEqP9v0wQoVn7pm1+JCAdkHasCzh
         RWLwHE+k6EsRt9triO/h15mrJethpy6f6gGV95TTLr9MlZb0JrAa/aWU2QxmjUOHpty8
         SD6FPnC99i94YuwsKDNHM3DWTQJtgoN3wA85XPEl2tjYWXXqes7Veh9RJEcNfXfux3Tz
         uLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736867373; x=1737472173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpI3yKKAzjs+5quxef+oLP6vXtkIHrfYkvco4de/Nms=;
        b=htDby+ki+IGA/oxq/TsRatW2h1/pGBk4JBya9VF27MMmtulhTtBs8wBqytbgHbuH8J
         OSXC20ax7MAvKrEghom77hqNfHVk11ZcQRCFmaxcyZKSnu/ygzQyhvDP3CAoQh9Rc0iL
         bv1XhIaoxJCTl2cT3/v2RH403hvN+DlgouxZQZ5CZJvA+Q1vExASAlEbkVNgZhoNiXBN
         Vh9Tbl/KrAmCMNAflqopPUxzFxOo/+YnV9J8+cPiHfbi0sYGd/8A4+gBpqGYQ1tlJjhJ
         aOAgHYzy69VLzvdMEnncngNEXgxjfl9qXME5/d9ayvMQU33tWu+z3pz5LcgfGmt+nQ1S
         RbMw==
X-Forwarded-Encrypted: i=1; AJvYcCVwRBH0r+ipxNrluO7vBAfhahL6xmATlp8SnfmL06HnK8GrVUOmh9xoVYySSuEoxhAnSBMODy02EKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LAVj96ew9k3ZEdnQIBEudnt8i+bDb97javVv/I6nqqoJCjZf
	mfnuyXAucC+RWKbl/849yH+HZUcV5Vy9bIFOxWCLgbAwolz5l1leu3YDjNGA7nDXFBkUIY4+hwQ
	Emz8zo6OyD4h3BDU3YSQaFs57E7k=
X-Gm-Gg: ASbGnctM5B/HL/bOyVfcJ4Pw0ohVRixHRn0dEtOyeb+DJgs4mb+QzU9ROpSGRvWpe7Z
	6uegSRQ2P52pEuyGYjfjqY2RtwQfbjMwEbR71/oTP1hpZwBY4Mc2OueBfZfc1o/AT41FKUgrX
X-Google-Smtp-Source: AGHT+IE2Ds/DJYdG0/dzUdgzeONyWpZyekNp5wOdQ686452MTa8LQiSaKmOWjeADG8d4Nq71kafMhd58XyqH0cOekHk=
X-Received: by 2002:a2e:bea3:0:b0:300:de99:fcc7 with SMTP id
 38308e7fff4ca-305f46042c4mr77697121fa.36.1736867372229; Tue, 14 Jan 2025
 07:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108213632.260498-1-anna@kernel.org> <20250108213632.260498-4-anna@kernel.org>
 <CAN-5tyGk_Nh4u_m=gEEGH8DbdzoU7XU-2PhOWC3xbBdvEi-SDQ@mail.gmail.com> <15a6d57c-569c-46c9-ade9-59e274226d88@oracle.com>
In-Reply-To: <15a6d57c-569c-46c9-ade9-59e274226d88@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 14 Jan 2025 10:09:20 -0500
X-Gm-Features: AbW1kvb1NZi0XvjLQCCEP9kBMgtF7E5MnJla8QrzOyH8Uh3Af4_YOiAlQF5eAM8
Message-ID: <CAN-5tyGrzO_A4PQZr4MuOOZwHH17EywnJiZUf1ms-6MSnsQqgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] sunrpc: Add a sysfs file for adding a new xprt
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:52=E2=80=AFPM Anna Schumaker
<anna.schumaker@oracle.com> wrote:
>
> Hi Olga,
>
> On 1/13/25 9:10 AM, Olga Kornievskaia wrote:
> > On Wed, Jan 8, 2025 at 4:36=E2=80=AFPM Anna Schumaker <anna@kernel.org>=
 wrote:
> >>
> >> From: Anna Schumaker <anna.schumaker@oracle.com>
> >>
> >> Writing to this file will clone the 'main' xprt of an xprt_switch and
> >> add it to be used as an additional connection.
> >>
> >> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> >> ---
> >>  include/linux/sunrpc/xprtmultipath.h |  1 +
> >>  net/sunrpc/sysfs.c                   | 54 +++++++++++++++++++++++++++=
+
> >>  net/sunrpc/xprtmultipath.c           | 21 +++++++++++
> >>  3 files changed, 76 insertions(+)
> >>
> >> diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunr=
pc/xprtmultipath.h
> >> index c0514c684b2c..c827c6ef0bc5 100644
> >> --- a/include/linux/sunrpc/xprtmultipath.h
> >> +++ b/include/linux/sunrpc/xprtmultipath.h
> >> @@ -56,6 +56,7 @@ extern void rpc_xprt_switch_add_xprt(struct rpc_xprt=
_switch *xps,
> >>                 struct rpc_xprt *xprt);
> >>  extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
> >>                 struct rpc_xprt *xprt, bool offline);
> >> +extern struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt=
_switch *xps);
> >>
> >>  extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
> >>                 struct rpc_xprt_switch *xps);
> >> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> >> index dc3b7cd70000..ce7dae140770 100644
> >> --- a/net/sunrpc/sysfs.c
> >> +++ b/net/sunrpc/sysfs.c
> >> @@ -250,6 +250,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(st=
ruct kobject *kobj,
> >>         return ret;
> >>  }
> >>
> >> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_show(struct kobject *ko=
bj,
> >> +                                                  struct kobj_attribu=
te *attr,
> >> +                                                  char *buf)
> >> +{
> >> +       return sprintf(buf, "# add one xprt to this xprt_switch\n");
> >> +}
> >> +
> >> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *k=
obj,
> >> +                                                   struct kobj_attrib=
ute *attr,
> >> +                                                   const char *buf, s=
ize_t count)
> >> +{
> >> +       struct rpc_xprt_switch *xprt_switch =3D
> >> +               rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
> >> +       struct xprt_create xprt_create_args;
> >> +       struct rpc_xprt *xprt, *new;
> >> +
> >> +       if (!xprt_switch)
> >> +               return 0;
> >> +
> >> +       xprt =3D rpc_xprt_switch_get_main_xprt(xprt_switch);
> >> +       if (!xprt)
> >> +               goto out;
> >> +
> >> +       xprt_create_args.ident =3D xprt->xprt_class->ident;
> >> +       xprt_create_args.net =3D xprt->xprt_net;
> >> +       xprt_create_args.dstaddr =3D (struct sockaddr *)&xprt->addr;
> >> +       xprt_create_args.addrlen =3D xprt->addrlen;
> >> +       xprt_create_args.servername =3D xprt->servername;
> >> +       xprt_create_args.bc_xprt =3D xprt->bc_xprt;
> >> +       xprt_create_args.xprtsec =3D xprt->xprtsec;
> >> +       xprt_create_args.connect_timeout =3D xprt->connect_timeout;
> >> +       xprt_create_args.reconnect_timeout =3D xprt->max_reconnect_tim=
eout;
> >> +
> >> +       new =3D xprt_create_transport(&xprt_create_args);
> >> +       if (IS_ERR_OR_NULL(new)) {
> >> +               count =3D PTR_ERR(new);
> >> +               goto out_put_xprt;
> >> +       }
> >> +
> >> +       rpc_xprt_switch_add_xprt(xprt_switch, new);
> >
> > Before adding a new transport don't we need to check that we are not
> > at or over the limit of how many connections we currently have (not
> > over nconnect limit and/or over the session trunking limit)?
>
> That's a good thought, but I'm not really seeing how to do that from insi=
de the sunrpc code. Those are configuration values for the NFS client, and =
don't get passed down to sunrpc, so sunrpc has no knownledge of them. If yo=
u think that'll be a problem, I can look into adding those checks for the n=
ext posting.

Seems incorrect to allow going over a limit we enforce at the nfs
layer? So I think it is a problem.

The other thing that sticks out. Given that this is version agnostic
what happens for v3/v4 and the bc_xprt?

>
> Anna
>
> >
> >> +       xprt_put(new);
> >> +
> >> +out_put_xprt:
> >> +       xprt_put(xprt);
> >> +out:
> >> +       xprt_switch_put(xprt_switch);
> >> +       return count;
> >> +}
> >> +
> >>  static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
> >>                                             struct kobj_attribute *att=
r,
> >>                                             const char *buf, size_t co=
unt)
> >> @@ -451,8 +500,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
> >>  static struct kobj_attribute rpc_sysfs_xprt_switch_info =3D
> >>         __ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show=
, NULL);
> >>
> >> +static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =3D
> >> +       __ATTR(xprt_switch_add_xprt, 0644, rpc_sysfs_xprt_switch_add_x=
prt_show,
> >> +               rpc_sysfs_xprt_switch_add_xprt_store);
> >> +
> >>  static struct attribute *rpc_sysfs_xprt_switch_attrs[] =3D {
> >>         &rpc_sysfs_xprt_switch_info.attr,
> >> +       &rpc_sysfs_xprt_switch_add_xprt.attr,
> >>         NULL,
> >>  };
> >>  ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
> >> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> >> index 720d3ba742ec..a07b81ce93c3 100644
> >> --- a/net/sunrpc/xprtmultipath.c
> >> +++ b/net/sunrpc/xprtmultipath.c
> >> @@ -92,6 +92,27 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_sw=
itch *xps,
> >>         xprt_put(xprt);
> >>  }
> >>
> >> +/**
> >> + * rpc_xprt_switch_get_main_xprt - Get the 'main' xprt for an xprt sw=
itch.
> >> + * @xps: pointer to struct rpc_xprt_switch.
> >> + */
> >> +struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch=
 *xps)
> >> +{
> >> +       struct rpc_xprt_iter xpi;
> >> +       struct rpc_xprt *xprt;
> >> +
> >> +       xprt_iter_init_listall(&xpi, xps);
> >> +
> >> +       xprt =3D xprt_iter_get_xprt(&xpi);
> >> +       while (xprt && !xprt->main) {
> >> +               xprt_put(xprt);
> >> +               xprt =3D xprt_iter_get_next(&xpi);
> >> +       }
> >> +
> >> +       xprt_iter_destroy(&xpi);
> >> +       return xprt;
> >> +}
> >> +
> >>  static DEFINE_IDA(rpc_xprtswitch_ids);
> >>
> >>  void xprt_multipath_cleanup_ids(void)
> >> --
> >> 2.47.1
> >>
> >>
>

