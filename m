Return-Path: <linux-nfs+bounces-11732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C43AB7B6D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 04:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE3C1BA13F7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC642820A0;
	Thu, 15 May 2025 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr5So+JB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C827933E
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274996; cv=none; b=jvCXHYcqFkJvWiwqEr3Glt8Apt7XSMSiyLaY2FPPOfgZKOUUFjmHIdo1bTkDB6LwlbRkoAcWCReW6p4kQR8qAEWx7OJ4a+MYu73rdd7wKLJtScVCKNB/ueIyuqe+7QL4yOdziZC+Y6izOxBd3mWytiuede7xmvd3N1OSSiQ6Stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274996; c=relaxed/simple;
	bh=lJSwrzAXRIYJRqQ+/H0vvCSRZipBTYUmY5l/21jCcLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbvNFGDbfBlojVnoQXvvHeIikP35w590uwL4p2O0fVwxdn+AXKNY+4W9LH/T/AYACluUVoOlUg8lCItUsEL3WmMYY3N8pb7u/esPSCE3yl2FV8WhKtyMvBoFHX16F99z8wpogduWfZa8AVNQ4cakvGfn39pK6I841BFstzxsIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr5So+JB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso873789a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 19:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747274993; x=1747879793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJSwrzAXRIYJRqQ+/H0vvCSRZipBTYUmY5l/21jCcLI=;
        b=lr5So+JB/HjWkR7gKNnq78vVkEE4vDamE7OdYmoNZAmPWCrU6P2/iSbnV/M3YXbhgA
         gcmRmXSjDVMR1PLJxMeQBIi8i6z+UXYFONExSAQd0HGE1cXqkk+cqj2XDUtqxmlMO0qi
         6FAqQKjOK9BBRQGAUyjNkTGZ/FJ1k2AZgbIkewqCz1zcU6VO9Ae7BncNmU6K/iXA8DND
         k8q1Ixd9+dGLd94vu3N95ghqwrxjnSIpCGTPqv5J/vdl89dVy775mrpRE/69XpC5FJCL
         IzsA4+8LHeI2yNFD/BXQMi/F0tZA98ClQ8V+vupu/goBkmQCpyKPyEUm8ACikFv4ztjk
         SO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747274993; x=1747879793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJSwrzAXRIYJRqQ+/H0vvCSRZipBTYUmY5l/21jCcLI=;
        b=vOdHZAJbld3IlyEAu+PTHiz6HFW14EURWIcqGODtQsJbQC0DS8FYw+mejTzpEeR55W
         jJzy7gFldqX585Q1bhjKrruxVTLx8IofGK5NusHfEW2SlqPS9IRWTz7vNM+Us4/YqPC6
         ueLxHiUKgs9KmNzxJY4UMwMnvAJ/Tl9t+CK6+5h60kpbFMPbYJNDhAwt4G6EZpGVu3tf
         2xPFU1kCHdah2mhHEy0AY/FXtwUgFBNpfLjwGow0L1k80bCSE+f6OnN/OsnQeHfVYK7A
         YsSRWjCcZYpxc5ZGji4Xs5l7WxwVfVp59paWdwsUzVmeMgCDrNSoLaQGJc1+rwVQhnVh
         9xzA==
X-Gm-Message-State: AOJu0YwtUES1IrPcVBgMomwnopCA+viJdxiz6VyLy44KSPMBIyzrZtFI
	+0+PkRGj5yprnnDXdMpyjI3sK8Rpt6cSQlp2PkiINEai+1PWSolVUF9VAd5Tenhk5UwHExwXjns
	YuyBXLOY4eLlZ/iFWPInsFNhgpPUr5eM=
X-Gm-Gg: ASbGncsL1zUC51EBbtyEkBtaxSlXo3i+suT/R/l+lzYNj7jyW1sTs+uakdWV3fPsvLc
	k9JfNsQ0iffxy77TP0WNbooqYZ1KtUKhjY+NMYCgO7vNljPCycqSXbLlV8f4ef0gNfOOyjpPNj8
	3rBOra7og6FoX6hAOL9JelDnu5jhCXJecGXVlYByr9sW2da/Y7QCi0A4FRoyAECdE=
X-Google-Smtp-Source: AGHT+IEF5SXVnKy4/qW61hxS2gmsODtgLw2n4DiGU6k9aZPpFxM3c2qHzQ/69OMOr50NZynpMgQes8TL+pKfyNadQvk=
X-Received: by 2002:a05:6402:3514:b0:5e5:bb58:d6bd with SMTP id
 4fb4d7f45d1cf-5ff988aaeedmr5038118a12.10.1747274992407; Wed, 14 May 2025
 19:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
In-Reply-To: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 14 May 2025 19:09:40 -0700
X-Gm-Features: AX0GCFtvqPLnZTGL_aQHXvtUTf7v_bmN9ZvwKQeWOx_W_6CG_YVHVs_A0imd3Gg
Message-ID: <CAM5tNy7MCKPgg7+fNJk3SkTp9Au6G=2XBK+8DfxKQQ8-GvaA=Q@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 2:51=E2=80=AFPM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Wed, May 14, 2025 at 1:55=E2=80=AFPM NeilBrown <neil@brown.name> wrote=
:
> >
> > On Wed, 14 May 2025, Jeff Layton wrote:
> > Ignoring source ports makes no sense at all unless you enforce some oth=
er
> > authentication, like krb5 or TLS, or unless you *know* that there are n=
o
> > unprivileged processes running on any client machines.
>
> I don't like to ruin that party, but this is NOT realistic.
>
> 1. Kerberos5 support is HARD to set up, and fragile because not all
> distributions test it on a regular basis. Config is hard, not all
> distributions support all kinds of encryption methods, and Redhat's
> crusade&maintainer mobbing to promote sssd at the expense of other
> solutions left users with a half broken, overcomplicated Windows
> Active Directory clone called sssd, which is an insane overkill for
> most scenarios.
> gssproxy is also a constant source of pain - just Google for the
> Debian bug reports.
>
> Short: Lack of test coverage in distros, not working from time to
> time, sssd and gssproxy are more of a problem than a solution.
>
> It really only makes sense for very big sites and a support contract
> which covers support and bug fixes for Kerberos5 in NFS+gssproxy.
I will note that it is possible to configure a client to use SP4_NONE and
do Kerberos mounts without needing a Kerberos ticket. This avoids the
hassle of creating keytab entries for clients.

Once you do that, all you really need is a KDC (either MIT or Heimdal
can be set up easily) and the creation of a service principal for the
server and putting it in a keytab on the server.
(This really is not hard to do. I won't comment on what Linux distros
provide, since I have no expertise.)

>
>
> 2. TLS: Wanna make NFS even slower? Then use NFS with TLS.
>
> NFS filesystem over TLS support then feels like working with molasses.
This is not my limited experience. I have two old Dell laptops and they
easily do NFS over TLS at wire speed for their 1Gbps net ports.
(They do use about 30% of a CPU for each active mount's TCP connection.)
For faster (10Gbps-->) net connections, I wouldn't be surprised that you wi=
ll
see a performance hit without offload hardware, but I'm not sure I would
call it "molasses".

There is offload hardware out there, but I have no access to such.

I will agree that NFS over TLS does not make sense for a well controlled
LAN, but the university example may not be a well controlled LAN,
except maybe within a server machine room.

>
> Exacerbated by Linux's crazy desire to only support hyper-secure
> post-quantum encryption method (so no fast arcfour, because that is
> "insecure", and everyone is expected to only work with AMD
> Threadripper 3995WX), lack of good threading through the TLS eye of
> the needle, and LACK of support in NFS clients.
>
> Interoperability is also a big problem (nay, it's ZERO
> interoperability), as this is basically a Linux kernel client/kernel serv=
er only
> solution.
Actually, I could have said it was a FreeBSD only solution at one point in
time. Now, both Linux and FreeBSD clients do it.
And, although I'd like to say otherwise, there are not a lot of other
current clients out there. (Yes, I know you are involved in the resurrected
CITI Windows client, which is good to see.)
I'd like to see the Windows client learn how to do NFS over TLS, since
a Windows laptop would be an ideal example of a client that could
use NFS over TLS. (With it, it can access a NFSv4 server from pretty
well anywhere. It is also possible to put a username in an X.509 cert.
on the client so that it performs all RPCs as that user and avoids any
need for Kerberos or messing with passwd/group entries. When this
is done it can stick any old uid/gid in the RPC header, because they
are ignored anyhow.)

Would I like to see Apple do this? Yes.
Do I expect MacOS to get this any time soon. Nope, since they have
never even upgraded their client to 4.1.

As for the VMware client, I doubt there is much use for NFS over TLS
in it.

What other clients are there out there? (Hummingbird's, now called
OpenText's NFSv4.0 client. I was surprised to see it was still possible
to buy it. And it probably can be put in the same category as the MacOS one=
.)

As for the merits of reserved port #s.. I'm staying out of that one. I made=
 the
mistake of going down that rabbit hole some years ago. (I'll admit there ar=
e
certain situations where a reserved port# restriction is useful. A system w=
here
root is trusted, but the users are not, could be one.)

rick

> libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
> this is an issue, and not a solution.
>
> Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna f=
ly.
>
> Thanks,
> Martin
>

