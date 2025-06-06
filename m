Return-Path: <linux-nfs+bounces-12149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB09AD03FC
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A597174611
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA97263B;
	Fri,  6 Jun 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw6DXaq1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9F76026
	for <linux-nfs@vger.kernel.org>; Fri,  6 Jun 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220024; cv=none; b=U5G5F1jG6lg97m042lIRNzSi0SFHvbnWZk8j1nivIkWGhemTrTS4CU+dCZMo3lhIDI7Z95bjCRKCJD9clAvBNXjt+f1CaBpE82WBpM6vc/SkUJG4U6B/h4hemrvHglcdQNztYxQ7fPU4CVmSGvsLdwvLDUjhbkwt3TIzMK0PhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220024; c=relaxed/simple;
	bh=uu8I1tikktTdNiU895wjGaGjRqYVAP2A1AR9lRVYGXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNW6JecOk3ua+Ux0wz3tnES4wPQUXGzvEgOv5RkrBBZtoARzyu4C6/CnmXaOZhznPN90zvbZwvQU6Xaq9jmvdI/3VJ+XBAfX44ybxy4ZSvKSlB37wJNVlMrGkaFtdUeYLB9DJ6e3qHuI5DtBfOe4MMkPtAUHupwttFST24AefKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw6DXaq1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso464437a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Jun 2025 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749220021; x=1749824821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GOJAIGVjVPo/aDAa7fRLPbYuDHAS0+7cuQy/O5L/uA=;
        b=fw6DXaq1eDItxeJdAwoEXSlIdCGaptdOnjyudlCJRSi6YZa8spL4y2valgi5TVz9SH
         /YenlRxgXJLno6ecPLiRQVAqg0iV3lxp8dUWd0w/W6v9N93SjkDglnJToDR6mWmkkdy6
         leQ7PhZ4Fcm4qK4b534ZUNTIPkqqBuhK8fv/VnzpRVGFQHm8xRisr/ByZNYuE7Dip6sv
         +KyANMiXDPy04Yu/Kj90Kk5/RDEuCOy7zFaRTkTh3GaLRo7Qe+zi4FZWTZDiICzDsW+x
         kUn++lXAIcOj8Ne6BLinrQHD3Mue1E/ZL2oClYdf0zPOmpDMHzi86Plhk6l6U+8ilHMq
         7NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749220021; x=1749824821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GOJAIGVjVPo/aDAa7fRLPbYuDHAS0+7cuQy/O5L/uA=;
        b=Tc+o6FAZQbGGZTUDt7KFommAlQqtACYw5ysIwNjyy5SXOuCG8c3CGlUrnMVDWjEOHI
         nJWKiocq+fnQ8cS40CHbj2YvagiT9f6vycJ0b0GRphxvsKYbcQfUhMbpGis73cpZW0zV
         z7RKtSGzP0cyLEFaYlk8v4x/DZspLxydk/IrmTqtusvBDFHZyfOIT+mK9lFwH2Zl2wV9
         jl8GzQWnuOYFCB+rid20fOmQ/kljdY0cFX39leQwPgDYqGFLqLYBtE0SnklPV9LnCB+X
         5NIOoDVS8xh/qQLa9NWjBQx6VI4cfyAZw8W7fYfAx1Lu0zu1+nx0Gv0OL3jWf46sobma
         yF8w==
X-Forwarded-Encrypted: i=1; AJvYcCVz4X0lgCviRCefIAimYHgDfJrJLsSi5SNRRUytHxxuRI/7U932hPiJI4mRyoRwnp5D8L3/BhH2mH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQsYFvHR/Y5WP0Gen4lWEnB77ElMGoJbDxgJVpvIJvYUG/8ed
	6+3iGBeuS5S/XHmFm9VbwKj69x/KCBFd6blRJvUXxKrPlt3ldF7hegEnoJCoO1UO21tH6kJXVQV
	NqedUxxzEiXpKhzF+AkmbXBGQcD6U4Q==
X-Gm-Gg: ASbGncvoZiiLGMV/JjLb5Q9m25CXnNX9Frje4Ew9ltQ3IbZAQuUcX9ElXMbZV/HR+Sf
	i3q+IYd++vC3WM2GtcqxieENpT8MVUAo7bH5XL0tbqDG2Ng8c9etDgjnWzlNFRJzFQSK3gn7dDo
	hLLVxxjVXbz75uVV7WdcVwNffygzRivXrj/KwOri6S0wK5UUNNRLGmXgnr5cWJTDQAfgSdTsdmY
	rI=
X-Google-Smtp-Source: AGHT+IEhB0wkwVH6MgAtf7cMporAgTlvXhDgOfwAz1ZZmQ7bpPDOgpIFO09CQwQ8gKzDdn8QdAixby+hBz0S38zf+8o=
X-Received: by 2002:a05:6402:2744:b0:607:2a09:38de with SMTP id
 4fb4d7f45d1cf-6077350deebmr3243908a12.7.1749220020859; Fri, 06 Jun 2025
 07:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4csWq+Zu2hfdz0GcLk9pc0-JeP0EKZs=yOScJSx+v9ow@mail.gmail.com>
 <CAPJSo4XP132ParCDO6uNFZHyq+c_e1j0o2qxO9tQe4hqbWQw7w@mail.gmail.com>
 <CAM5tNy4EVhgmj1XHocMqbeKqJSWcUio7kppy+EKfp5ECnQ2R7g@mail.gmail.com>
 <CAM5tNy5ke7H+pMfsvQC-+kuRUokd0vsbPw_WOY-N6v=0t-pS5Q@mail.gmail.com>
 <CALXu0UdjF5s3Af72uo0A6503fZfGQ0kfxUs9yGoBh+v0oPz7pA@mail.gmail.com>
 <CAM5tNy5+X9f=xfr8T2Z+2OcOg6P7VGbSHbH0AeE1h5Xffugh6g@mail.gmail.com> <CALXu0UdeQhppELxzG7NrW7D4wJ6SM-QQm=PROkV8Z6v+c6+E_Q@mail.gmail.com>
In-Reply-To: <CALXu0UdeQhppELxzG7NrW7D4wJ6SM-QQm=PROkV8Z6v+c6+E_Q@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 6 Jun 2025 07:26:48 -0700
X-Gm-Features: AX0GCFv_XNnyOCn5kXZRmI1k9bJL1ftUCnb9UTY3bloe4xiDRJEtGAS-Mem7Gx4
Message-ID: <CAM5tNy6tCMGfckOif0NMOKT1dsWtfM6Gakjq=y7FYtw_h_108Q@mail.gmail.com>
Subject: Re: NFSv4/TLS support for newgrp(1) Re: [Ms-nfs41-client-devel]
 Implementing NFS over TLS
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: ms-nfs41-client-devel@lists.sourceforge.net, 
	libtirpc-devel@lists.sourceforge.net, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 11:11=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Wed, 4 Jun 2025 at 22:21, Rick Macklem <rick.macklem@gmail.com> wrote:
> >
> > On Wed, Jun 4, 2025 at 10:36=E2=80=AFAM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> > >
> > > On Mon, 2 Jun 2025 at 02:45, Rick Macklem <rick.macklem@gmail.com> wr=
ote:
> > > >
> > > > On Sun, Jun 1, 2025 at 3:53=E2=80=AFPM Rick Macklem <rick.macklem@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, May 21, 2025 at 12:20=E2=80=AFAM Lionel Cons <lionelcons1=
972@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, 21 May 2025 at 01:53, Rick Macklem <rick.macklem@gmail.=
com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > If the Google AI is correct, MS does not provide a full
> > > > > > > TLS implementation in the kernel and their kTLS only
> > > > > > > handles record level encryption/decryption, similar to
> > > > > > > FreeBSD.
> > > > > >
> > > > > > Could you first look into adding TLS support to steved-libtirpc=
 in a
> > > > > > generic fashion via openssl, please?
> > > > > Ok, I finally got around to doing this. The tarball is attached a=
nd it can
> > > > > also be found at...
> > > > > https://people.freebsd.org/~rmacklem/tirpc-tls.tar
> > >
> > > How are uid and - more important gid - information passed to the NFS/=
RPC server?
> > Normally, no differently than it is now. Either krb5 or auth_sys.
> > RPC-over-TLS encrypts
> > the RPC header, but does not change it.
> >
> > There is a "special case" where a <user@domain> string is set in the ot=
herName
> > component of subjectAltName. For that specific case, the NFS server gen=
erates
> > credentials based on that user (uid+gid list for POSIX servers) and use=
s those,
> > ignoring whatever is in the RPC header (presumably auth_sys with any ol=
d uid
> > and gid list).
> > --> This is entirely an option for an NFS server and really has
> > nothing to do with
> >      NFS-over-TLS except that it is embedded in the client's X.509
> > cert. by whoever
> >      created it. It is meant for laptops and similar that are only
> > used by one user.
>
> I see a problem here, because <user@domain> is not sufficient. Users
> can have multiple primary groups, e.g. in case of /bin/newgrp, Windows
> winsg and so on.
>
> TLS must have a way to specify a primary group for POSIX newgrp(1) suppor=
t.
TLS does not handle user authentication, only machine authentication.
The above special case is what Chuck calls "identity squashing" and will on=
ly
identify a single user at the time of TLS handshake (normally when mounting
is done. It does not allow changes to the user after that time and I do not=
 see
how it could? (NFS-over-TLS is not meant to replace krb5[ip] or auth_sys, w=
hich
are still in the RPC message header.)

Btw, I'm not sure that things like newgrp are handled by krb5[ip] either.
Normally, for "sec=3Dkrb5[ip]" a Kerberos credential representing a Kerbero=
s
principal is sent to the NFS server. The NFS server translates that Kerbero=
s
user principal to a <uid, gid list> at that time and that <uid, gid
list> is used for
all subsequent RPCs for that principal.
--> The only way newgrp would work for Kerberos is if there was a separate
     user principal in the KDC for each variant of groups list (not
practical) or
     the "group list on the server" is changed every time "newgrp" is done =
and
     the client creates a new RPCSEC_GSS shorthand for the user principal v=
ia
     the TGT etc (gss_init_sec_context() etc).
     I know the FreeBSD NFS client does not do this but I am not sure w.r.t=
.
     other ones.

Note that, when NFS-over-TLS is used with auth_sys, the server is "trusting=
"
the client's <uid, gid-list> based on the authentication of the client mach=
ine's
identity. Only for the "special case" where the <user@domain> is in the
otherName field of SAN in the client's X.509 cert does it do anything else.
Note that I believe this machine authentication is stronger than using clie=
nt
IP host address, which is what traditional exports files do.

If it was not clear, X.509 certs do not travel from client->server with eve=
ry
RPC. A cert. is only passed to the server during TLS handshake and even
that is optional.

--> Put another way, if this does not work for you, you choose not to do it=
.
(Trond has talked about using X.509 certs to authenticate users, but has
never described what he thinks could work in any detail.)

rick
>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

