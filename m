Return-Path: <linux-nfs+bounces-1716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FE8474C1
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B313C29086F
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8E14077C;
	Fri,  2 Feb 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhKbHfXm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54121487C1
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891482; cv=none; b=I7Uz/Ey8UPKM5MSsxWxj2GbjkqvmpPZLtijvAG7uNjnlTkCrhf14sTGOsroTRTalIK3e+rqiReKqJQDf0+pCvTs+1kqXosmqV+3tA1pPN2qhwuhCk1sNzuRZDwyRgNsaAUrUhP5Xutw25grh0WPvBVmmvMcwDdvPx8aramtUx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891482; c=relaxed/simple;
	bh=L5XX9q9Bgwmes5VChQaRo0wPdr/Y43FELw3URgsUbfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjXpmznpW7WS+mth9CDVDi9UVELyO3J5E2VODV6fA3QCMnvUv1QGhvzw9e3mvxiyKBTrck+mJY7AdHaQTwenEFWXD22UvIMoccBO1oxK1xXoqeGgd14O969Ym/oEWiW0gaINTGjDooOfaRrf3GXzhbmOWSBjDpixHru4E07+40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhKbHfXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk0HlDLODgfQxPi8eQL+hYbTQD1mb0Iz4J6bjfS5DyY=;
	b=YhKbHfXmzGj7isFQvV3S5OhJiyXyAyAfWktIK0DFKo3Uo7h3XPNjgeSII9naWZd2tQHOhQ
	OunlJV2iaav+9ynLclsRHAPdnTLkk4ixPon+BxnRz5nIsTUpeuf4SjCaGC0+rtQWPTfAMK
	bOwlLs/KOXCtekVHi/KzXyGJxjFAK68=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ORiCPjalN2eMuAuYp5MSpg-1; Fri, 02 Feb 2024 11:31:17 -0500
X-MC-Unique: ORiCPjalN2eMuAuYp5MSpg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so2295739b3a.2
        for <linux-nfs@vger.kernel.org>; Fri, 02 Feb 2024 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891476; x=1707496276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk0HlDLODgfQxPi8eQL+hYbTQD1mb0Iz4J6bjfS5DyY=;
        b=hoy60Uf9L0tfWW+Ip1o5M5pff9fI0QISATTPXbkwzLbrxFe9I1jYH02FM3gh+d8QxH
         pM6/N3m2L089OuBW9DEPHrMzc3GRwHDsS77Cwiv9ibmxj9MvOIPWCScpOLx/5ndLPxnJ
         cCbdpkPZxTVKpzY0hffcaAxdfl584BU0zgXMirZNvq8m6ZvcMGyE0BfGhDVTBYgeO6kr
         xIiOG4AQ8BU8UkdoFpbbWaPOPILI7iaz+s0A5mN1RtzosByagZmLiO2qX/DWdCo3yd/i
         ioYm3GJRlWCgp/LznaTPXqFx0QEQ7aqmkPwoypfDYChd/zcmr9xp62F6Zu6pExlCV7wV
         OIVg==
X-Gm-Message-State: AOJu0Yw3rRXoYNhGjkuD6MURA0b9yUwutq1fgHUATpjymm6w2+4/QkbB
	DIM0EjLhckpz3e+bS0u9uG/wqyeyjfkl5brp/5lpA6LwVeB2Xc6ZABwjL1Gix9/OvrdtpBQgGCH
	JeZ5NRaVnI0mqQoJ1xKYfwigbU+bj26MrtU3w2VQGgVeToE1r0GMiuM+8v9QFmop7YUpgkBSHxb
	3BPNrwbdPlWNW4s2vNhXgPVcBT5Nt7Grc6
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id eb19-20020a056a004c9300b006dfe0355549mr9341738pfb.15.1706891476157;
        Fri, 02 Feb 2024 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgHoeBG2Xdr20yw3gJ0WYTkapLgzV5sN33Vdcc74VwBIGKGFLCt2pM0mIE0OOYW6PvCilVy3VKGPphO9s59cw=
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id
 eb19-20020a056a004c9300b006dfe0355549mr9341683pfb.15.1706891475565; Fri, 02
 Feb 2024 08:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
 <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org>
In-Reply-To: <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 2 Feb 2024 17:31:04 +0100
Message-ID: <CAFqZXNv0e9JTd6EtB4F50WkZzNjY7--Rv6U1185dw0gS_UYf9A@mail.gmail.com>
Subject: Re: Calls to vfs_setlease() from NFSD code cause unnecessary
 CAP_LEASE security checks
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:08=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Fri, 2024-02-02 at 16:31 +0100, Ondrej Mosnacek wrote:
> > Hello,
> >
> > In [1] a user reports seeing SELinux denials from NFSD when it writes
> > into /proc/fs/nfsd/threads with the following kernel backtrace:
> >  =3D> trace_event_raw_event_selinux_audited
> >  =3D> avc_audit_post_callback
> >  =3D> common_lsm_audit
> >  =3D> slow_avc_audit
> >  =3D> cred_has_capability.isra.0
> >  =3D> security_capable
> >  =3D> capable
> >  =3D> generic_setlease
> >  =3D> destroy_unhashed_deleg
> >  =3D> __destroy_client
> >  =3D> nfs4_state_shutdown_net
> >  =3D> nfsd_shutdown_net
> >  =3D> nfsd_last_thread
> >  =3D> nfsd_svc
> >  =3D> write_threads
> >  =3D> nfsctl_transaction_write
> >  =3D> vfs_write
> >  =3D> ksys_write
> >  =3D> do_syscall_64
> >  =3D> entry_SYSCALL_64_after_hwframe
> >
> > It seems to me that the security checks in generic_setlease() should
> > be skipped (at least) when called through this codepath, since the
> > userspace process merely writes into /proc/fs/nfsd/threads and it's
> > just the kernel's internal code that releases the lease as a side
> > effect. For example, for vfs_write() there is kernel_write(), which
> > provides a no-security-check equivalent. Should there be something
> > similar for vfs_setlease() that could be utilized for this purpose?
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> >
>
> Thanks for the bug report!
>
> Am I correct that we only want to do this check when someone from
> userland tries to set a lease via fcntl? The rest of the callers are all
> in-kernel callers and I don't think we need to check for any of them. It
> may be simpler to just push this check into the appropriate callers of
> generic_setlease instead.
>
> Hmm now that I look too...it looks like we aren't checking CAP_LEASE on
> filesystems that have their own ->setlease operation. I'll have a look
> at that soon too.

I did briefly check this while analyzing the issue and all of the
setlease fops implementations seemed to be either simple_nosetlease()
or some wrappers around generic_setlease(), which should both be OK.
But it can't hurt to double-check :)

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


