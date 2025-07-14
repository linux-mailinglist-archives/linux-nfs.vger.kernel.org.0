Return-Path: <linux-nfs+bounces-13033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519BB03C06
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 12:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610BC3A203B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60728244668;
	Mon, 14 Jul 2025 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CANIMQiV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A07225779
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489539; cv=none; b=drNL3RJ+Y6KR2tE5XkvP4JoSgTx0nd7cDHGqV3WCdY8Qx6Ioj6Fs80PgvsgJ/cVkvTAZ6nQNt+Tkmpll6Tmv6NURzoFNGDrvikk+K0Phuo05hKiIxGhkIQa5c3iJCziP6cavbxknzAX9f3BVMxZ97lUoL1KwgPxpVEBp6jWDq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489539; c=relaxed/simple;
	bh=G7jBaAI8ZbIAVKSZs5XWng4N2D+BkpsCAr83mlfz4h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=unncqj/6kinMp4rbXX1p6zOdXzODQl7GZsZEZrA9bTvXTAu4hJwC9DwJr3uURzuxwFZcCM1FRDp3IOu8bqE5y4GZypSC7gU86MIJW8Iauess3hlcp19vjRvV1TGNjfv/hniOn+VemuHdJOxsrtbxD5en81N20FXFwBAtfa+lbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CANIMQiV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ef461b9daeso2682473fac.2
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752489536; x=1753094336; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI0mMz1aR91GZu7fy4qcz+Ek8WB9ICX0mhFjVFDPPzY=;
        b=CANIMQiVg2riRr4vT42tu/Jvdh+yveugL6RwNJBM4FAvvp1qAIoqW/NPmHdRUamPfU
         vAKQYyurARkytk893LKUKHNpm6TgEi470BR1qWJVMJ20CyOE0Onc1Tc3qh8TKeo8LXYm
         fYcFEYT3kPQdI3frbKZGGMA17m3edCD1WiFRxjYBoOdFXmrat3a5hRl67/WuYxxj8IKE
         71pVEdORTLg2t5S5Po4mHhsXgKeKbXyT5/rEXZaDkeflIqdDbC/mt1PIgGH5rzmpt2Ge
         By3Hziwc1glDfE0TkFR9juywHGlLWTVOtYlb20N4JoRwYVrhxkzXOWjqx01WsQ4954LB
         Wx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489536; x=1753094336;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI0mMz1aR91GZu7fy4qcz+Ek8WB9ICX0mhFjVFDPPzY=;
        b=m+furHaloLFS738SxG2aqJBdtjW/jYXnCSkmfgRjdiKKp82v4nhs+NgyVTzMVB5oec
         tVEPoiaVVv4YKDWLRIeiDeQlEjDRjz33wgqxM2bAO8c7sl3NlHMk+uo31in74CSP32fS
         AeFaEjLlPpwuioRYeP7JKIftb/gZph183+K1R7UFPLLwXpIq5t0TjBYbApipJGm18bjL
         LPKT0hSmpG/Dz0UHGcOcTifwBWwP26evVft4jhYOqxWE0VhHVhr4eOY+I7fBdkC+v+24
         b/H6kuyPwo9MB2IPpT35cHRuD2PaxJgGfWOa2z6qhyqhki4g80PMiak1E4tb63e3FfgG
         q0tw==
X-Gm-Message-State: AOJu0YyWydMuSPNraKZq6zHleVJ+8k+O6cQCSTlyBXCp3JKILOFQ3CY0
	71RCCPTrRKkxsU1AZWxFGyBG62jL9066jXlZT8EHprw2UCmAR+C0qOefHgA4Qf3pSmtYplt1gqv
	DJmrYwl/xyu9cUxn3NL92A0lAtgKlzCJeHhQf
X-Gm-Gg: ASbGncvL6qf0I0JMppyFcHxtKUdBlbb66BnUQDDIQq5r3pc5+WdPOnRjTrk4h3Tk2v9
	904icsnWL04emVydil6cxinM9At5ND3fXCtsIpW+v2Ly1hoPiLEY82hvYOB6O7PQBqZ9NPXihg7
	JaLUz4NG7vCb4+qTj4gRYDzna3WsGtORDJpH79OxQAGzJoiX6aMihCDc5XqTs66icanj6sNaQLC
	zRzJDTumsqbex/u
X-Google-Smtp-Source: AGHT+IFu0bXtDwOjxk7Qq7wn0XLgwYLNGIBi0Ei7ec4K3qeH3gMhgaz5onJfnafZ3atJFI7Wwc03hROe1TnEQYTVCDQ=
X-Received: by 2002:a05:6870:f68a:b0:2e9:95cc:b855 with SMTP id
 586e51a60fabf-2ff2b6c264emr7997222fac.34.1752489536517; Mon, 14 Jul 2025
 03:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618125803.1131150-1-cel@kernel.org> <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
 <CA+1jF5pP3MJQ6L8TBzfuBNRr-YZxefBpBrQSxRR2kJWSqjgYxQ@mail.gmail.com>
 <f6f3c22f-8c49-4f9a-937f-2103cd780f6e@kernel.org> <CA+1jF5qu31AjMpRxmZPVmWVvd_beXS=0egeCxbdthY13GDRiQg@mail.gmail.com>
In-Reply-To: <CA+1jF5qu31AjMpRxmZPVmWVvd_beXS=0egeCxbdthY13GDRiQg@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 14 Jul 2025 12:38:19 +0200
X-Gm-Features: Ac12FXwA8P5V2M4kua4ODII_-8MIz9dqqzsndHFgRgQDeQk3hhvDaDC6Zs6Ih5g
Message-ID: <CA+1jF5rLOpw-p4m4kZNwVqJYwxLHhB8QkFfA3RaQ7jpE+hKd4g@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be synchronous"
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:36=E2=80=AFPM Aur=C3=A9lien Couderc
<aurelien.couderc2002@gmail.com> wrote:
>
> On Sun, Jul 13, 2025 at 7:50=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> > On 7/12/25 9:06 AM, Aur=C3=A9lien Couderc wrote:
> > > ?
> > >
> > > On Wed, Jun 18, 2025 at 9:22=E2=80=AFPM Aur=C3=A9lien Couderc
> > > <aurelien.couderc2002@gmail.com> wrote:
> > >>
> > >> On Wed, Jun 18, 2025 at 2:58=E2=80=AFPM Chuck Lever <cel@kernel.org>=
 wrote:
> > >>>
> > >>> From: Chuck Lever <chuck.lever@oracle.com>
> > >>>
> > >>> In the past several kernel releases, we've made NFSv4.2 async copy
> > >>> reliable:
> > >>>  - The Linux NFS client and server now both implement and use the
> > >>>    NFSv4.2 OFFLOAD_STATUS operation
> > >>>  - The Linux NFS server keeps copy stateids around longer
> > >>>  - The Linux NFS client and server now both implement referring cal=
l
> > >>>    lists
> > >>>
> > >>> And resilient against DoS:
> > >>>  - The Linux NFS server limits the number of concurrent async copy
> > >>>    operations
> > >>
> > >> And how does an amin change that limit? There is zero documentation
> > >> for admins, and zero training or reference material for COPY, CLONE,
> > >> ALLOCATE, ...
> > >>
> > >> Aur=C3=A9lien
> > >> --
> > >> Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> > >> Big Data/Data mining expert, chess enthusiast
> > >
> > >
> > >
> >
> > The tone of your original email suggested to me that it was a whine
> > rather than a genuine request for more information.
>
> Well, put it that way: I am not a native english speaker.
>
> Imagine a world in the multiverse where the French retained their
> colonies instead of the British empire. French would be the dominant
> language of that blue marble. Programming languages would use french
> words. Someone from the tiny leftover remnants of the British empire
> would post in the linnaeus-sdfr@ (syst=C3=A8me de fichiers r=C3=A9seau, A=
KA NFS)
> mailing list, and that post would be called "a whine", because his
> French is not perfect...
>
> >
> > Also the request for "training material" for individual NFSv4.2
> > operations does not make sense. We do not have training material for
> > the NFSv3 READDIRPLUS procedure, for example.
> >
> > Therefore I ignored the email.
>
> OK, but as an analog: SMB is infamous for "too many" features, all
> which can cause trouble. Over time SAMBA added controls to turn
> features on/off or use different ways of emulation. So far NFSv4.2

Apologies, that should have been "the LINUX NFSv4.2 server implementation"

> has
> no controls to turn specific features on/off, or even get statistics,
> or put limits on certain features.
>
> That IS a problem, which SAMBA and even Windows Server SMB have
> solved. Otherwise you're at the mercy of whatever combination of NFS
> client and NFS server you have, and that is NOT good.
>
> Aur=C3=A9lien
> --
> Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> Big Data/Data mining expert, chess enthusiast


Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

